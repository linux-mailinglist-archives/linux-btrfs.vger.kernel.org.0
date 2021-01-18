Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE872F9687
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jan 2021 01:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbhARANV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 17 Jan 2021 19:13:21 -0500
Received: from mout.gmx.net ([212.227.15.18]:58185 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbhARANO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 17 Jan 2021 19:13:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610928699;
        bh=UJUQs8EM2IucW3jkTw9F2hYp/vI+uSWA8W1AxtqMYTU=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=MVxJ4FyxzSN/LMzOtICCm4riaXIEQ6GTFh0FwXiirMLWaqv+hc+6YZ1IHOYHjVfo9
         hpadn9JqvCo3/emehi8+3kXB57t3TGdMcgYWMhTug/DmnQaCNoA+cyqJVijCp8Ooos
         QJC9RinJ+HUVfSR6H1ezgTRVKoBW5vTyA7ESGjAs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MYNNo-1lWaOP0gS2-00VOVL; Mon, 18
 Jan 2021 01:11:39 +0100
To:     chainofflowers <chainofflowers@neuromante.net>,
        linux-btrfs@vger.kernel.org
References: <5975832.dRgAyDc8OP@luna>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Access Beyond End of Device & Input/Output Errors
Message-ID: <09596ccd-56b4-d55e-ad06-26d5c84b9ab6@gmx.com>
Date:   Mon, 18 Jan 2021 08:11:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <5975832.dRgAyDc8OP@luna>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tq3bQ80agCk8IW61uxVC+zASTD/z9DYiaKKJgi1kole9vBz67Az
 hhpGuhb05DxX/2cOYoeGsQGt6WfxXqDfWDDXAz15ipNu932QYVfOajcq84KSet2hR0Vg7Je
 oHjRrVpRf90HvPb9fJFcH8KQYfWROY5prXQ8oXB+th59LjJHxbAfu7BlBcQtKknVHthw1JM
 bOwGJEfKgKehDQbt7mH4A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UGlJX/H5qa4=:PbqNbgPCyE0MSuHaGXg7qk
 idFfRM6VCkerwypvz1Z3ivZaUEvJ5E6mTrjoDB6grEPBDcKUSWwkt10c5CaEq034qUTrjTlOf
 4Ze4lD8XSNQlpJXmFbXCit7ofza4H0wSNgrju1CNeTs6ad5PBELyljwgVTUQJftdZ0QXWaggD
 kN8nJRARKNxlyjMpOqI3/noAri26MfMchGm636chmSHa4GYi5Qzb6IyODWt9y92KwLKapZKqi
 ZlfzB4OzP9CB38Ty/i6d2jldJaoqMX3fGhCGQlr8YgiMvMO/3zuaYrL29bIgNkE+l5s2cf3ss
 puckdoKItq1cDNVm72aFVxXG1taPQXabPDVcDavXaHhzzZ8WJtLq63ynok/d/OjASx8jMe8CY
 L+IMZXALiadN9cCdbdUGurpWWSCn3IhcmC+Qo7FERqxMqBqDMfwLr/crX0V7kgouR/+1BDC0u
 MJar3+1LAqf+ZXbuEGib2BqONZhfAFZ3PAU4/6Uz1doceNYQa/2eUGLgYulX4miXutK1GQoHa
 nyxgaS+apLtUMSfoBRGjhyeKU/oK03/9CRYhEDF97E0eOslzRXmmYybv0kUFY3vvcsDBqhKkY
 lYN8ILOibuQw47cLX215yPNLkfGsbzljUYoZ0gxMnshy6f1FyuBg00QbvyYkEC//yEjH4N5yJ
 5Ug4DgLDlPadx2sIDcikayWK9tKOaq/Hn355VLBsyU8gvAp9DmwiqykTLsV65FcIiYQL5zjRn
 50v3/Cnn6gE9xXTR2EvaSBDJXOA/QScuTXNQ3nxK3uOX4leEmBLKtE4ae6pX5m2O+JPg6K34A
 TM+JINBNzjrFERuFxZtYW8Lhrm922nCitnad+KmJoSTRdINKMItKJ+79dC3SuIMfDt70dvS0G
 LBKlndZHFR1mpOfXo6oA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/1/18 =E4=B8=8A=E5=8D=887:38, chainofflowers wrote:
> Hi all,
> Hi Qu,
>
> I am also getting this very same error on my system.
> Actually, I am experiencing this since the following old bug was introdu=
ced AND also even after it has been fixed:
> https://lore.kernel.org/linux-btrfs/20190521190023.GA68070@glet/T/
>
> That (dm-related) bug was claimed to have been fixed and users confirmed=
 that their btrfs partitions were working correctly again, but I am still =
experiencing some issues from time to time - and obviously only on SSD dev=
ices.
>
> Just to clarify: I am using btrfs volumes on encrypted LUKS partitions, =
where every partition is encrypted individually.
> I am *NOT* using LVM at all: just btrfs directly on top of LUKS (which i=
s different from the users' setup in the above-mentioned bug reports).
> And I am trimming the partitions only via fstrim, have configured the mo=
unt points with the "nodiscard" option and the LUKS volumes in /etc/cryptt=
ab with "discard", so to have the pass-through when I use fstrim.
>
> Opposite to Justin, my partitions are all aligned.
>
> When this happens on my root partition, I cannot launch any command anym=
ore because the file system is not responding (e.g.: I get "ls: command no=
t found"). I cannot actually do anything in reality, because the system co=
nsole is flooded with messages like:
>
>   "sd <....> [sdX] tag#29 access beyond end of device"

The best way to debug such problem is to recompile the kernel adding
some debug outputs.
(Maybe it can be done with bpftrace, but not yet familiar with that)

If you're able to recompile the kenerl (using abs + makepkg for Arch
based kernel), please try the following diff.

This will add extra debugging to show where the offending length
happens, either extent discard or unallocated space discard.
And from that output we can continue our investigation.

Thanks,
Qu

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 30b1a630dc2f..7451fa0b14b9 100644
=2D-- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5776,6 +5776,7 @@ static int btrfs_trim_free_extents(struct
btrfs_device *device, u64 *trimmed)

         ret =3D 0;

+       pr_info("%s: enter devid=3D%llu\n", __func__, device->devid);
         while (1) {
                 struct btrfs_fs_info *fs_info =3D device->fs_info;
                 u64 bytes;
@@ -5820,6 +5821,8 @@ static int btrfs_trim_free_extents(struct
btrfs_device *device, u64 *trimmed)
                         break;
                 }

+               pr_info("%s: devid=3D%llu start=3D%llu len=3D%llu\n",
+                       __func__, device->devid, start, len);
                 ret =3D btrfs_issue_discard(device->bdev, start, len,
                                           &bytes);
                 if (!ret)
@@ -5842,6 +5845,7 @@ static int btrfs_trim_free_extents(struct
btrfs_device *device, u64 *trimmed)
                 cond_resched();
         }

+       pr_info("%s: done devid=3D%llu ret=3D%d\n", __func__, device->devi=
d,
ret);
         return ret;
  }

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 379bef967e1d..03046fca53a2 100644
=2D-- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -3772,6 +3772,8 @@ int btrfs_trim_block_group(struct
btrfs_block_group *block_group,
                 spin_unlock(&block_group->lock);
                 return 0;
         }
+       pr_info("%s: enter bg start=3D%llu start=3D%llu end=3D%llu minlen=
=3D%llu\n",
+               __func__, block_group->start, start, end, minlen);
         btrfs_freeze_block_group(block_group);
         spin_unlock(&block_group->lock);

@@ -3786,6 +3788,8 @@ int btrfs_trim_block_group(struct
btrfs_block_group *block_group,
                 reset_trimming_bitmap(ctl, offset_to_bitmap(ctl, end));
  out:
         btrfs_unfreeze_block_group(block_group);
+       pr_info("%s: enter bg start=3D%llu ret=3D%d\n",
+               __func__, block_group->start, ret);
         return ret;
  }


>
> and that "clogs" the system. Since the root fs is unusable, the system l=
og cannot store those messages, so I can't find them at the next reboot.
> I can only soft-reset (CTRL-ALT-DEL), it's the "cleanest" (and only) way=
 I can get back to a working system.
>
> When the system restarts, it takes 2 seconds longer than usual to mount =
the file systems, and then I can use the PC again.
> Immediately after login, if I run btrfs scrub, I get no errors (I scrub =
ALL of my partitions: they're all fine). So, it seems that at least the au=
to-recovery capability of btrfs works fine, thanks to you devs :-)
>
> Then, if I boot from an external device and run btrfs check on the unmou=
nted file systems, it also reports NO errors - opposite to what was happen=
ing when the dm bug was still open: to me, this really means that btrfs to=
day is able to heal itself from this issue (it was not always the case in =
2019, when the dm bug was opened).
> I have not tried to boot from external device directly after this issue =
occurs - I mean, performing btrfs check without going first through the bt=
rfs scrub step. I will do that next time and see what output I get.
>
> All my partitions are snapshotted, and surely this could help with auto-=
recovery.
>
> What I have noticed is that when this bug happens, it ALWAYS happens aft=
er I have purged the old snapshots: that is, when the root partition only =
has one "fresh" (read-only) snapshot. This is never happening when I have =
more than one snapshot - maybe it means nothing, but it seems to me to be =
systematic.
>
> I have attached a file with my setup.
> Could you maybe spot anything weird there? It looks fine to me. The USER=
 and SCRATCH volumes are in RAID-0.
>
> I am unable to provide any dmesg output or system log because, as said, =
when it happens it does not write anything to the SYS partition (where /va=
r/log is). I will move at least /var/log/journal to another device, so hop=
efully next time I will be able to provide some useful info.
>
> Another info: of course, I have tried (twice!) to reconstruct the system=
 SSD from scratch, because I wanted to be sure that it was not depending o=
n some exotic issue. And each time I used a brand new device.
> So, this issue has been happening with a SanDisk Ultra II and with two d=
ifferent Samsung EVO 860.
>
> Is it possible that what we are experiencing is still an effect of that =
dm bug, that it was not completely fixed?
>
>
> Thanks for your help, and for reading till here :)
>
> (c)
>
