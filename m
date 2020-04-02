Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A60819BFE6
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Apr 2020 13:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388072AbgDBLJJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Apr 2020 07:09:09 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:33161 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388066AbgDBLJJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Apr 2020 07:09:09 -0400
Received: by mail-vk1-f193.google.com with SMTP id f63so767451vkh.0
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Apr 2020 04:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=fcL+C6U3jQJR4SKdNTO8d7c52F0gg+5N9xTe7FkPAuw=;
        b=G15LRKgrkNlSZRO17yxK+VdFk57/YeO5L8WHcb7IafZYiuoUY+ELpayXE7+gybYqFo
         NKXzTM1dDVhIy4WjipuzTtvRTFviNT1/xn6pTEYaLCSyqrg9tLMzA5FOsnJKYoMXN2bh
         lHJEQPn/g//d4ceGyQ2ZsaeWOj5zy2sgvi4qsze68tZP1A0y4P9VLClX3opSumHvbA9z
         Cf+bBNqfNwandjEse/yiI/ts1i8tYgfNgUkznqA/m2cUUORuHRyYOl4ky9QJrBBhThi6
         zCv4eUvMx9IIXKI3oxDLRYRDDpapU+Crmn5VPze9EMGESonWBkLf+abKDYgIdndE4drD
         LPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=fcL+C6U3jQJR4SKdNTO8d7c52F0gg+5N9xTe7FkPAuw=;
        b=bNJNy6QhoOUiBa7IeA9mSNnHyQ5zp9bc08IMQQ3OJ/N8qsgMdVsMDEafRFQw3GSZbf
         l+2FDXe1al5xfflN0+B7S9A9vJ46tJY5c997oBMgTZSXA2EGD8AwWZe8IPv4FHMluZV7
         DbTe3jiXDnL+Mid5Mgzb8zTTKnQAN1DA2BoqhsarzLDPne2OD+4l1QokOQdCR/zu33uj
         GFipV/tRX1rmkTm944MEfqnIxOfWCNUVkwgXDgsT4GmLcZdd57QKKnKMOn7i4ScKEyXe
         yY8uSqenf/DE2wk7LttVah73FyR77pd8rlOCF2P9/Y8ncbaxpFAJ1mWysShj988LWLLu
         FyUg==
X-Gm-Message-State: AGi0PubtutSTvjJbYsh1XPUABFy+a161E4spPsUWRVHMKelz9xu5AIzU
        +y5L+nzfDkTCMMUMEuUVzUoXGfSF4nC9D29FCgWxfdmZ
X-Google-Smtp-Source: APiQypJ3HtyN3ouJ0COPtORJ6PIj7qsrlZJPKeh1vhogBZfiGxTmTeB9iN8c9e+FhX0FE6LhcQdLP6vQbGddoQJ//FI=
X-Received: by 2002:ac5:ccb9:: with SMTP id p25mr1683627vkm.69.1585825746434;
 Thu, 02 Apr 2020 04:09:06 -0700 (PDT)
MIME-Version: 1.0
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 2 Apr 2020 11:08:55 +0000
Message-ID: <CAL3q7H4oa70DUhOFE7kot62KjxcbvvZKxu62VfLpAcmgsinBFw@mail.gmail.com>
Subject: RAID5/6 permanent corruption of metadata and data extents
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

Recently I was looking at why the test case btrfs/125 from fstests often fa=
ils.
Typically when it fails we have something like the following in dmesg/syslo=
g:

 (...)
 BTRFS error (device sdc): space cache generation (7) does not match inode =
(9)
 BTRFS warning (device sdc): failed to load free space cache for block
group 38797312, rebuilding it now
 BTRFS info (device sdc): balance: start -d -m -s
 BTRFS info (device sdc): relocating block group 754581504 flags data|raid5
 BTRFS error (device sdc): bad tree block start, want 39059456 have 0
 BTRFS info (device sdc): read error corrected: ino 0 off 39059456
(dev /dev/sde sector 18688)
 BTRFS info (device sdc): read error corrected: ino 0 off 39063552
(dev /dev/sde sector 18696)
 BTRFS info (device sdc): read error corrected: ino 0 off 39067648
(dev /dev/sde sector 18704)
 BTRFS info (device sdc): read error corrected: ino 0 off 39071744
(dev /dev/sde sector 18712)
 BTRFS warning (device sdc): csum failed root -9 ino 257 off 1376256
csum 0x8941f998 expected csum 0x93413794 mirror 1
 BTRFS warning (device sdc): csum failed root -9 ino 257 off 1380352
csum 0x8941f998 expected csum 0x93413794 mirror 1
 BTRFS warning (device sdc): csum failed root -9 ino 257 off 1445888
csum 0x8941f998 expected csum 0x93413794 mirror 1
 BTRFS warning (device sdc): csum failed root -9 ino 257 off 1384448
csum 0x8941f998 expected csum 0x93413794 mirror 1
 BTRFS warning (device sdc): csum failed root -9 ino 257 off 1388544
csum 0x8941f998 expected csum 0x93413794 mirror 1
 BTRFS warning (device sdc): csum failed root -9 ino 257 off 1392640
csum 0x8941f998 expected csum 0x93413794 mirror 1
 BTRFS warning (device sdc): csum failed root -9 ino 257 off 1396736
csum 0x8941f998 expected csum 0x93413794 mirror 1
 BTRFS warning (device sdc): csum failed root -9 ino 257 off 1400832
csum 0x8941f998 expected csum 0x93413794 mirror 1
 BTRFS warning (device sdc): csum failed root -9 ino 257 off 1404928
csum 0x8941f998 expected csum 0x93413794 mirror 1
 BTRFS warning (device sdc): csum failed root -9 ino 257 off 1409024
csum 0x8941f998 expected csum 0x93413794 mirror 1
 BTRFS info (device sdc): read error corrected: ino 257 off 1380352
(dev /dev/sde sector 718728)
 BTRFS info (device sdc): read error corrected: ino 257 off 1376256
(dev /dev/sde sector 718720)
 BTRFS error (device sdc): bad tree block start, want 39043072 have 0
 BTRFS error (device sdc): bad tree block start, want 39043072 have 0
 BTRFS error (device sdc): bad tree block start, want 39043072 have 0
 BTRFS error (device sdc): bad tree block start, want 39043072 have 0
 BTRFS error (device sdc): bad tree block start, want 39043072 have 0
 BTRFS error (device sdc): bad tree block start, want 39043072 have 0
 BTRFS error (device sdc): bad tree block start, want 39043072 have 0
 BTRFS error (device sdc): bad tree block start, want 39043072 have 0
 BTRFS info (device sdc): balance: ended with status: -5
 (...)

So I finally looked into it to figure out why that happens.

Consider the following scenario and steps that explain how we end up
with a metadata extent
permanently corrupt and unrecoverable (when it shouldn't be possible).

* We have a RAID5 filesystem consisting of three devices, with device
IDs of 1, 2 and 3;

* The filesystem's nodesize is 16Kb (the default of mkfs.btrfs);

* We have a single metadata block group that starts at logical offset
38797312 and has a
  length of 715784192 bytes.

The following steps lead to a permanent corruption of a metadata extent:

1) We make device 3 unavailable and mount the filesystem in degraded
mode, so only
   devices 1 and 2 are online;

2) We allocate a new extent buffer with logical address of 39043072, this f=
alls
   within the full stripe that starts at logical address 38928384, which is
   composed of 3 stripes, each with a size of 64Kb:

   [ stripe 1, offset 38928384 ] [ stripe 2, offset 38993920 ] [
stripe 3, offset 39059456 ]
   (the offsets are logical addresses)

   stripe 1 is in device 2
   stripe 2 is in device 3
   stripe 3 is in device 1  (this is the parity stripe)

   Our extent buffer 39043072 falls into stripe 2, starting at page
with index 12
   of that stripe and ending at page with index 15;

3) When writing the new extent buffer at address 39043072 we obviously
don't write
   the second stripe since device 3 is missing and we are in degraded
mode. We write
   only the stripes for devices 1 and 2, which are enough to recover
stripe 2 content
   when it's needed to read it (by XORing stripes 1 and 3, we produce
the correct
   content of stripe 2);

4) We unmount the filesystem;

5) We make device 3 available and then mount the filesystem in
non-degraded mode;

6) Due to some write operation (such as relocation like btrfs/125
does), we allocate
   a new extent buffer at logical address 38993920. This belongs to
the same full
   stripe as the extent buffer we allocated before in degraded mode (390430=
72),
   and it's mapped to stripe 2 of that full stripe as well,
corresponding to page
   indexes from 0 to 3 of that stripe;

7) When we do the actual write of this stripe, because it's a partial
stripe write
   (we aren't writing to all the pages of all the stripes of the full
stripe), we
   need to read the remaining pages of stripe 2 (page indexes from 4 to 15)=
 and
   all the pages of stripe 1 from disk in order to compute the content for =
the
   parity stripe. So we submit bios to read those pages from the correspond=
ing
   devices (we do this at raid56.c:raid56_rmw_stripe()). The problem is tha=
t we
   assume whatever we read from the devices is valid - in this case what we=
 read
   from device 3, to which stripe 2 is mapped, is invalid since in the degr=
aded
   mount we haven't written extent buffer 39043072 to it - so we get
garbage from
   that device (either a stale extent, a bunch of zeroes due to trim/discar=
d or
   anything completely random). Then we compute the content for the
parity stripe
   based on that invalid content we read from device 3 and write the
parity stripe
   (and the other two stripes) to disk;

8) We later try to read extent buffer 39043072 (the one we allocated while =
in
   degraded mode), but what we get from device 3 is invalid (this extent bu=
ffer
   belongs to a stripe of device 3, remember step 2), so
btree_read_extent_buffer_pages()
   triggers a recovery attempt - this happens through:

   btree_read_extent_buffer_pages() -> read_extent_buffer_pages() ->
     -> submit_one_bio() -> btree_submit_bio_hook() -> btrfs_map_bio() ->
       -> raid56_parity_recover()

   This attempts to rebuild stripe 2 based on stripe 1 and stripe 3 (the pa=
rity
   stripe) by XORing the content of these last two. However the parity
stripe was
   recomputed at step 7 using invalid content from device 3 for stripe 2, s=
o the
   rebuilt stripe 2 still has invalid content for the extent buffer 3904307=
2.

This results in the impossibility to recover an extent buffer and
getting permanent
metadata corruption. If the read of the extent buffer 39043072
happened before the
write of extent buffer 38993920, we would have been able to recover it sinc=
e the
parity stripe reflected correct content, it matched what was written in deg=
raded
mode at steps 2 and 3.

The same type of issue happens for data extents as well.

Since the stripe size is currently fixed at 64Kb, the issue doesn't happen =
only
if the node size and sector size are 64Kb (systems with a 64Kb page size).

And we don't need to do writes in degraded mode and then mount in non-degra=
ded
mode with the previously missing device for this to happen (I gave the exam=
ple
of degraded mode because that's what btrfs/125 exercises).

Any scenario where the on disk content for an extent changed (some bit flip=
s for
example) can result in a permanently unrecoverable metadata or data extent =
if we
have the bad luck of having a partial stripe write happen before an attempt=
 to
read and recover a corrupt extent in the same stripe.

Zygo had a report some months ago where he experienced this as well:

https://lore.kernel.org/linux-btrfs/20191119040827.GC22121@hungrycats.org/

Haven't tried his script to reproduce, but it's very likely it's due to thi=
s
issue caused by partial stripe writes before reads and recovery attempts.

This is a problem that has been around since raid5/6 support was added, and=
 it
seems to me it's something that was not thought about in the initial design=
.

The validation/check of an extent (both metadata and data) happens at a hig=
her
layer than the raid5/6 layer, and it's the higher layer that orders the low=
er
layer (raid56.{c,h}) to attempt recover/repair after it reads an extent tha=
t
fails validation.

I'm not seeing a reasonable way to fix this at the moment, initial thoughts=
 all
imply:

1) Attempts to validate all extents of a stripe before doing a partial writ=
e,
which not only would be a performance killer and terribly complex, ut would
also be very messy to organize this in respect to proper layering of
responsabilities;

2) Maybe changing the allocator to work in a special way for raid5/6 such t=
hat
it never allocates an extent from a stripe that already has extents that we=
re
allocated by past transactions. However data extent allocation is currently
done without holding a transaction open (and forgood reasons) during
writeback. Would need more thought to see how viable it is, but not trivial
either.

Any thoughts? Perhaps someone else was already aware of this problem and
had thought about this before. Josef?

Thanks.


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
