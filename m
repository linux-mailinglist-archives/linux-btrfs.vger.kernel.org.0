Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF79712AF12
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Dec 2019 23:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfLZWPe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Dec 2019 17:15:34 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45825 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfLZWPe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Dec 2019 17:15:34 -0500
Received: by mail-wr1-f66.google.com with SMTP id j42so24607515wrj.12
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Dec 2019 14:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IE8Rj9/jOE3TpIrXrtE6X6kzXdgmHozlAWpEYPbLKXk=;
        b=2P7F37FlJsjRKtivdbiwyyHjh1Gp+bVesvQ16/X0J2lzc5vRhgKUjDOdY7h82AiRzk
         Ntt+dyGaz0Sn5FUjxc8rSgzSlZgkFNzXwfOXb8KYj0mSvV2MyEEzUdWDlyOuMbzgOoHg
         AV6H6sFLz3+z9IKrx0YyePQZzhKu/vialDTJb9ox4oVg2lQAkAUYmdL/EnqXlsuqX+Mu
         hPL2qAAgLUrUnK+k0qixd5MW8EHw1LcOyy33oz9B7V7GqTzBn2bwRf2NbrvSbhsYJMuw
         DQeRPFIyVS2zSsGwLa0zkvKv8dJ9PEy0cbU5Of3NiImqSs9PtNpnD4MaTxDsWV0fxla8
         vYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IE8Rj9/jOE3TpIrXrtE6X6kzXdgmHozlAWpEYPbLKXk=;
        b=Pj9r0ZZss9dtFlFVk84L3gIS6FYqWfUQSLuAseAMJBpxiRS7JI/Z28YT4pfrWsnijR
         y0A1LelwVQceht0BnfEyszfGagQlpIJKpjJrrUgaFYVEVWNNPJTx+cWaTsuTdaioFFMz
         e0dQo6EKFCUDBtRwYFMW1oGp8j5e66uQCGFFpDBTToLxrVQAjZoM3Qszhd5iyr4hiOi1
         OMnXGn9XdnWD48qVw8fgnxnIV4eD4lLmxZkhiN1KkhkowaSMW21UG5UKSIr57PsZ6HUc
         wZVVmgDr1/SEqREgjRw7vetU5PzGpKyjrzpzu3X6GiNYDFPuUZK5j1sEXn3cL2tFQt/0
         v4Ww==
X-Gm-Message-State: APjAAAVonGRKXjvpNJ28o3CrJtKyQg8KnjBcccS2tcCfJ6HI9DUPJj1u
        AaulddCvesa7fs7QkrGA6q+RyfwejgkY9wwmoB+3uZ6XP1u1zw==
X-Google-Smtp-Source: APXvYqxcSVnrLe6O/5/T8zQaw7rMfdY9SnNOnyFYLwhuTNhQlg35VlFPP3JjyDG68lBE+sJPTA1XaIU2S9CvsJ7ngsU=
X-Received: by 2002:adf:ea4e:: with SMTP id j14mr48585503wrn.101.1577398531918;
 Thu, 26 Dec 2019 14:15:31 -0800 (PST)
MIME-Version: 1.0
References: <879f2f45-f738-da74-9e9c-b5a7061674b6@dubiel.pl>
In-Reply-To: <879f2f45-f738-da74-9e9c-b5a7061674b6@dubiel.pl>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 26 Dec 2019 15:15:15 -0700
Message-ID: <CAJCQCtQR+rFoS7kaLm0eh35x5iYw0UO9Ybi3gxANTxJLU-YEFg@mail.gmail.com>
Subject: Re: very slow "btrfs dev delete" 3x6Tb, 7Tb of data
To:     Leszek Dubiel <leszek@dubiel.pl>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 25, 2019 at 3:42 PM Leszek Dubiel <leszek@dubiel.pl> wrote:
>
>
> Hello!
>
> I have a server: 3 disks, 6TB each, total 17TB space, occupied with data
> 6TB.
>
>
> One of the disks got smart errors:
>
>      197 Current_Pending_Sector  0x0022   100   100   000 Old_age
> Always       -       16
>      198 Offline_Uncorrectable   0x0008   100   100   000 Old_age
> Offline      -       2
>
> And didn't pass tests:
>
>      Num  Test_Description    Status                  Remaining
> LifeTime(hours)  LBA_of_first_error
>      # 1  Extended offline    Completed: read failure 90%
> 3575         -
>      # 2  Short offline       Completed without error 00%
> 3574         -
>      # 3  Extended offline    Completed: read failure 90%
> 3574         -
>      # 4  Extended offline    Completed: read failure 90%
> 3560         -
>      # 5  Extended offline    Completed: read failure 50%
> 3559         -
>
> I decided to remove that drive from BTRFS system:


What is the SCT ERC for each drive? This applies to mdadm, lvm, and
btrfs RAID. While you are not using raid for data, you are using it
for metadata. And also mismatching SCT ERC with kernel's command timer
is not good for any configuration, the SCT ERC must be shorter than
the kernel command timer or inevitably bad sector errors are masked by
the kernel resetting the link to the device.

https://raid.wiki.kernel.org/index.php/Timeout_Mismatch

And when was the last time a scrub was done on the volume? Were there
any errors reported by either user space tools or kernel? And what
were they?

I do agree, however, that this configuration should have higher
performing reads from the device being deleted, unless part of the
reason why it's so slow is that one or more drives is trying to do
deep recoveries.

My suggestion for single profile multiple device is to leave the per
drive SCT ERC disabled (or a high value, e.g. 1200 deciseconds) and
also change the per block device command timer (this is a kernel timer
set per device) to be at least 120 seconds. This will allow the drive
to do deep recovery, which will make it dog slow, but if necessary
it'll improve the chances of getting data off the drives. If you don't
care about getting data off the drives, i.e. you have a backup, then
you can set the SCT ERC value to 70 deciseconds. Any bad sector errors
will quickly result in a read error, Btrfs will report the affected
file. IF it's metadata that's affected, it'll get a good copy from the
mirror, and fix up the bad copy, automatically.



-- 
Chris Murphy
