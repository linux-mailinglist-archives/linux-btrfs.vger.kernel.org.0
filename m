Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3362A1751AA
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2020 02:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgCBB50 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Mar 2020 20:57:26 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52987 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbgCBB5Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 Mar 2020 20:57:25 -0500
Received: by mail-wm1-f65.google.com with SMTP id p9so9390557wmc.2
        for <linux-btrfs@vger.kernel.org>; Sun, 01 Mar 2020 17:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DyIo7WFbm4tot3cZZRjY7OEzqzpW9npkV1D6H0bIAvE=;
        b=Hbd2f2hnJqznZr8KV6qw0yEA21mbCd9HHOj3qSPqKfiTuRLi0iBctzecyGzLxzVJCr
         U7KTj/XU0XVFcFT0gXhP54cq+AXPI3kHj/nQrgJZQibQ1fEMIpF4yGXBlifdgZJLfyxy
         ZfkHmLIzjL6A1DEB22vMXNGRHzUTDsmq3sIN02oSgUOXA5zZbvfuOWoImMIyaLL9BXsE
         Sr+L3RPD9YLxPzdHRt5Ck3DwwpOz6McJzFfQpgiD6plSlLiOmmMRWbK3wQSOuMyXWvGK
         eDQG7X9UHrnYZnPan/4SDhKX3us9PFoyyQJnEQlv/5wqKUR4PZFx/cR6DNu2xll+C0Bp
         d4Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DyIo7WFbm4tot3cZZRjY7OEzqzpW9npkV1D6H0bIAvE=;
        b=Rm7eOUAoImri2oIhu3x47TSX3greTlKD3SF9WBqeSseXgi/9J+imdWVEzNk7gJ0AGs
         j7pbwm/ZurE37aMqrjkutAmiE1vNSKSmzHS/dHY/e5fMM6jRekSfFE5S6Ce3rVBGDhRn
         d3LMD5kMB8CVQIUC1fUU4RLq/SztvG2t3FWtma8DCyt2yuKVgaC77TR6T58Rbpj8afel
         4W7tG8mGpl+T4UxNzwDUkOS82khAfpyqucdr95Re/gtgtBdBk74lzfy0FHoUtHxP85MM
         CImxaT5lltOskdVUZnEal1moCm3Qfi1i6JOtZQ6H2nvmjcoqiDfVRE6JZfEzKEz3ozLR
         JK5g==
X-Gm-Message-State: APjAAAUYhrhfypVUCN2Ob9pOgQ6/ekD09qt25d+V9RTE22iuXnD/Sdzq
        vVWVKATjCxm9ERM5MrTrO7Fd1uUO2MVK+eDRsP373A==
X-Google-Smtp-Source: APXvYqxF9qheEZYvs3ZAEg/ArZXXK3WzGFwk4drRQEdEWmf3diZcmTn3VYyck5bjdfsK4LRIra8o0LiPIrAIImnbaq8=
X-Received: by 2002:a05:600c:214a:: with SMTP id v10mr17272054wml.182.1583114241631;
 Sun, 01 Mar 2020 17:57:21 -0800 (PST)
MIME-Version: 1.0
References: <CAG+QAKWwvevCz5zYDtkOO5V0AA7bJuoZWHJ2CZjc1ofsO-c7xQ@mail.gmail.com>
 <CAJCQCtQF8f0UsVuFU_TXxWJ2DZQcFZABTSwPu18ob7RcSUKW_A@mail.gmail.com> <CAG+QAKUzqdVf88G9ZdLKLa3YUQRcvJMS47qQkhLsgiQ46R19Bw@mail.gmail.com>
In-Reply-To: <CAG+QAKUzqdVf88G9ZdLKLa3YUQRcvJMS47qQkhLsgiQ46R19Bw@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 1 Mar 2020 18:57:05 -0700
Message-ID: <CAJCQCtQvEOX--M5pXN=2fSmfPDM2ADK3JhStTWiTdXTCV_XBXQ@mail.gmail.com>
Subject: Re: btrfs balance to add new drive taking ~60 hours, no progress?
To:     Rich Rauenzahn <rrauenza@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Mar 1, 2020 at 6:26 PM Rich Rauenzahn <rrauenza@gmail.com> wrote:
>
>
>
> On Sun, Mar 1, 2020 at 5:10 PM Chris Murphy <lists@colorremedies.com> wrote:
>>
>> Free is 1.82 exactly half of  unallocated on one drive and no
>> unallocate on the other drives, so yeah this file system is 100% full.
>> Adding one drive was not enough, it's raid1. You needed to add two
>> drives.
>
>
> I'm not following the btrfs logic here - I had three drives, 2 x 1 TB and a 1 x 4 TB and added a 4TB.

The original three drives:

        devid    2 size 1.82TiB used 1.82TiB path /dev/sda1
        devid    3 size 1.82TiB used 1.82TiB path /dev/sdc1
        devid    4 size 3.64TiB used 3.64TiB path /dev/sdb1

Simplistically, devid 2 mirrors with 50% of devid 4, and devid 3
mirrors with the other 50% of devid 4. You have 4TB of data on an 8TB
volume in a raid1 configuration. That's completely full and using up
all space.

Then you added one drive. Doesn't matter what its size is. There's no
where for more data to go.

https://carfax.org.uk/btrfs-usage/

>
> That was a total of 4TB in RAID0.

The volume is 8TB in a RAID 1 before adding the 4th drive. You can put
4TB of data on that volume, and it will be full and balanced.

> Wouldn't adding a fourth drive give me 6TB and some of the blocks just moved from the three drives onto the fourth?

Adding one 4TB drive gives you one empty 4TB, and three full drives.
The first copy of a chunk can go to the new drive, but there's nowhere
for the 2nd copy to go because the other three drives are full.


> Is there a particular 2nd copy policy I'm not aware of?

Btrfs raid1 is not block based like either mdadm or LVM raid. It's
based on the block group. A data block group is typically 1GiB. When a
data block group has raid1 profile, it has two stripes. In this case a
stripe is a copy.  Using your devid 2, 3, 4 where 2 and 3 are the same
size and devid 4 is 2x you have three possible kinds of blockgroup
stripe combinations:

2+3
2+4
3+4

How many you have of each just depends on the life history of the
volume; but if it were never balance and all three drives were
together from the start,  you might in theory have only 2+4 and 3+4
block groups.


> Or is it that it is trying to create new allocations on the new drive as part of the balance but can't because they wouldn't be mirrored?

Correct. The balance must move "the block group" and there are
effectively two copies. You have room for one to be moved. Not two.

If there was even 10GiB unallocated on one of the drives, this would
be going a LOT faster. But it looks like the three drives were full
before you got started (?) so it's wedged itself in.


 >But I still don't get why it wouldn't move blocks from the full drives...

To where? There's only one drive with unallocated space.



-- 
Chris Murphy
