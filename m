Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC3748F951
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Jan 2022 21:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbiAOUic (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 Jan 2022 15:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbiAOUib (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 Jan 2022 15:38:31 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7BEC061574
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Jan 2022 12:38:31 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id m196so5467993ybf.4
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Jan 2022 12:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iaSo6o6njk4HjFGPkLUdstlNBIcxUKeaBwLYld6LHXw=;
        b=fVe5bfCgaAGIzMzSre9bnDKzgG8qZJjf1Q26rHZGXnFHQURF6K4mYSS8GeCJ8z6V5A
         mhcqztEVrUgvvS3i2opWiCdMrKdbyC99qUAiGRbd5zjuY0TlJTeTwbQdKaSPgqjdQfaU
         RLf0Kunj2K+jpVl3iinx9tKDTVvRySQNX4T7Fh5YdfgdXCbg5UyOEPNIJzCY8oGAkcze
         3gW8J6O2TT6bVF1+hzhEiGYRhQJuM6lLyYS1ZDSodg5DnOoeGMm+87FkLrcOmNY7bwlW
         JXPHaOFb4bGlh3GzALyCUuKRIsRxssLjNnnWpK0W6uJbTdztg7S5lah410Z3hAVLHiMV
         aWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iaSo6o6njk4HjFGPkLUdstlNBIcxUKeaBwLYld6LHXw=;
        b=DFwuuOZep69n9UyjMHZTzfzKncjpjOMPVW6cdrCYUHkS3lh/dLZN8nxYyR7G04mBtr
         lDWWd6mRxLf8zGT+fzLUttgSJLQiEXzT6Tr5kMXS9K80OtHQdjGDoqCk14awtRw4PmXS
         7FfFyx2zGpe3zk1jfLKUF/BuYnO8GRI0EbZLRpGmLnmq50YYsS+R1kXJbIwqwA4HRqz7
         PUhV4r1ADT0lAuyHrARrJjxcIlvouUBiYEaePB5Ruv+f1loN/71nkfVYtsA3jOyhjz7p
         tfoSYmW1owKoOE2Fxwmo4t6V2sza7jHcD9WnmQwg6QtFFGUfhrbz7pfC5w2DM8jRY5Ns
         cfUg==
X-Gm-Message-State: AOAM531uhF46qh5d/fbFg+UoHSAVvT0oprWphagmvlDNnWYnGo7enPJg
        KBHUUs8z1PDWloQPrsxX1tv9Y0sOnDIVwLdRQSWdKmCu0G0pZw==
X-Google-Smtp-Source: ABdhPJyLgB0CfVmA93p/dfXgYP9lwKMudm5XwKryjDnhEH1Iv+DvbIawxbnlQpn8csrrwamQSqaUDg7jlHkxCFLiVqQ=
X-Received: by 2002:a25:70c3:: with SMTP id l186mr19067401ybc.642.1642279110495;
 Sat, 15 Jan 2022 12:38:30 -0800 (PST)
MIME-Version: 1.0
References: <b717a01c-c152-97e9-5485-2f0a95a5d4f5@petezilla.co.uk>
 <CAJCQCtTexbZf0TTPsW1Rd-nmooNvsT+MbT1AYZX66WeDeB-5SA@mail.gmail.com> <ed95c0e2-3029-45d0-c039-a275037d8bf4@petezilla.co.uk>
In-Reply-To: <ed95c0e2-3029-45d0-c039-a275037d8bf4@petezilla.co.uk>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 15 Jan 2022 13:38:14 -0700
Message-ID: <CAJCQCtS8DDGXOjZdzvkaMSbVyuG-x1Z5o_fO_u8rOGtE2zKSfA@mail.gmail.com>
Subject: Re: ENOSPC on file system with nearly empty 12TB drive
To:     Pete <pete@petezilla.co.uk>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 14, 2022 at 4:09 PM Pete <pete@petezilla.co.uk> wrote:

> Any suggestions?  Just be patient, and hope the balance finishes without
> ENOSPC?  Go for the remove again.  I'd like to remove a 4TB drive if I
> can without adding a 6th HD to the system.  Still don't understand why I
> might need more than one practically empty drive for raid1?

When bg profile is raid1, any time the file system wants to add
another block group, it must create a chunk on 2 devices at the same
time for it to succeed or else you get ENOSPC. The question is why two
chunks can't be created given all the unallocated space you have even
without the empty drive.

Ordinarily you want to avoid doing metadata balance. Balancing data is
ok, it amounts to defragmenting free space, and returning excess into
unallocated space which can then be used to create any type of block
group.


>
> Or, given that I've got another 12TB drive on the way, just abandon this
> file system (apart from reading any relevant data) and create a new file
> system as single, and migrate the current 12TB disk over later on to go
> back to raid1?
>
> I'm wondering if part of the problem is a 3.6TB disk image that is
> sitting on the file system (fixing someone else's external drive).
> Deleting that might speed things up, but since I don't think that drive
> is fully backed up I'd rather keep the disk image until I am sure that
> all is well.  (I don't need the backup lecture...)

I don't think the large image file is the problem.

In my opinion, you've hit a bug. There's plenty of unallocated space
on multiple drives. I think what's going on is an old bug that might
not be fixed yet where metadata overcommit is allowed to overestimate
due to the single large empty drive with a ton of space on it. But
since the overcommit can't be fulfilled on at least two drives, you
get ENOSPC even though it's not actually trying to create that many
block groups at once.

So what I suggest doing is removing the mostly empty device, and only
add devices in pairs when using raid1.



-- 
Chris Murphy
