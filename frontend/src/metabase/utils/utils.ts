export function calculateTimeDifference(pastDate: string): string {
  if (!pastDate) {
    return "";
  }
  // Parse the input past date string into a Date object
  const pastDateTime = new Date(pastDate);

  // Get the current date and time
  const currentDate = new Date();

  // Calculate the time difference in milliseconds
  const timeDifference = currentDate.getTime() - pastDateTime.getTime();

  // Calculate days and hours
  const daysDifference = Math.floor(timeDifference / (1000 * 60 * 60 * 24));
  const hoursDifference = Math.floor(
    (timeDifference % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60),
  );

  if (daysDifference > 0 && hoursDifference > 0) {
    return daysDifference + "d " + hoursDifference + "h";
  } else if (hoursDifference >= 0) {
    return hoursDifference + "h";
  } else {
    return "";
  }
}
