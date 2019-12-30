Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF45512CD8B
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Dec 2019 09:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbfL3IPF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 30 Dec 2019 03:15:05 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46397 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbfL3IPF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Dec 2019 03:15:05 -0500
Received: by mail-ot1-f66.google.com with SMTP id k8so28176406otl.13
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Dec 2019 00:15:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UnGpZQ0NCLLxd3RwdiHPJ8Iyh2DaLwVlACRXsVnodBQ=;
        b=nsTRUmPrEBm8uEcDM7RoDoeLeunXGTtowCvDNjXLYObFFP9mk6gvKMMD2cnQGq9WuF
         Yhoy9f07w9Uli11axl1n1IWCVhBCZE43mVQHxl8ZFgZv256hK61ll0+XaCGfiinHK6dJ
         cbHVynh7c2wLmCW0Nh74fpMWaRTUkYw399xHmL5qvjevoGmyVdWUBNoJOYLOenyxDwMd
         WvKmVgPBJ/lL2n5ex4w/5mwEvOiTC0eWsP0IGZv4/WcI88CGkoEiiDdOMojZG4pu7HQc
         Pzh5N6+TWRIvhbJP3dRSLYCqPG9ggP9EBUS9oly9eb0YGmaDIsrlvynkslvEirtrjoJR
         KhQQ==
X-Gm-Message-State: APjAAAXGXZEjOHebPT5SPnrvqG6Al1GrRNta2ciEeyYEQQ1mKqs4mhLH
        3IcvIwVkTwSRqO/XJVh2xbiIcrZP9PWD+T4wfwjDTQ==
X-Google-Smtp-Source: APXvYqwnJAEKxWK24hfWdMN2RE/U0DBPS9Ig8qj9QOCyEaDSTmoE7/5cLhOI7Ob1khZoOxYykEmzYdLazRp41soPbCU=
X-Received: by 2002:a05:6830:139a:: with SMTP id d26mr74900296otq.75.1577693703468;
 Mon, 30 Dec 2019 00:15:03 -0800 (PST)
MIME-Version: 1.0
References: <CAOB=O_jxu5JOe=JiYVW_VZ1rgs9+mdHpAHkscXkc4MVRLrBKDw@mail.gmail.com>
 <4bf17941-2ab0-15ca-b4c9-f6ba037624ee@gmx.com> <CAOB=O_jfwBVihtbNTF1xLNWNtf2_Mi=Bs_BCZ8VnXOKWosw7uQ@mail.gmail.com>
 <66d35620-160e-105a-6970-03c3de3f7c78@gmx.com> <CAOB=O_jpg0K4eDARfG+XDDRMHhm+yKp8XfhjqHsFxAswSPUfdQ@mail.gmail.com>
 <CAOB=O_hdjpNtNtMMi93CFh3wO048SDVxMgBQd_pC0wx0C_49Ug@mail.gmail.com>
 <a2f28c83-01c0-fce7-5332-2e9331f3c3df@gmx.com> <CAOB=O_gBBjT9EVduHWHbF8iOsA8ua-ZGGh4s1x6Lia24LAZEMg@mail.gmail.com>
 <4c06d3a9-7f09-c97c-a6f3-c7f7419d16a7@gmx.com>
In-Reply-To: <4c06d3a9-7f09-c97c-a6f3-c7f7419d16a7@gmx.com>
From:   Patrick Erley <pat-lkml@erley.org>
Date:   Mon, 30 Dec 2019 08:14:52 +0000
Message-ID: <CAOB=O_i=ZDZw92ty9HUeobV1J4FA8LNRCkPKkJ1CVrzHxAieuw@mail.gmail.com>
Subject: Re: read time tree block corruption detected
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 30, 2019 at 6:09 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2019/12/30 下午2:07, Patrick Erley wrote:
> > On Sun, Dec 29, 2019 at 9:58 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >>
> >>
> >>
> >> On 2019/12/30 下午1:50, Patrick Erley wrote:
> >>> On Sun, Dec 29, 2019 at 9:47 PM Patrick Erley <pat-lkml@erley.org> wrote:
> >>>>
> >>>> On Sun, Dec 29, 2019 at 9:43 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 2019/12/30 下午1:36, Patrick Erley wrote:
> >>>>>> (ugh, just realized gmail does top replies.  Sorry... will try to
> >>>>>> figure out how to make gsuite behave like a sane mail client before my
> >>>>>> next reply):
> >>>>>>
> >>>>>> here's btrfs check /dev/nvme0n1p2 (sda3, which is a mirror of it, has
> >>>>>> exactly the same output)
> >>>>>>
> >>>>>> [1/7] checking root items
> >>>>>> [2/7] checking extents
> >>>>>> [3/7] checking free space cache
> >>>>>> [4/7] checking fs roots
> >>>>>> [5/7] checking only csums items (without verifying data)
> >>>>>> [6/7] checking root refs
> >>>>>> [7/7] checking quota groups skipped (not enabled on this FS)
> >>>>>> Opening filesystem to check...
> >>>>>> Checking filesystem on /dev/nvme0n1p2
> >>>>>> UUID: 815266d6-a8b9-4f63-a593-02fde178263f
> >>>>>> found 89383137280 bytes used, no error found
> >>>>>> total csum bytes: 85617340
> >>>>>> total tree bytes: 1670774784
> >>>>>> total fs tree bytes: 1451180032
> >>>>>> total extent tree bytes: 107905024
> >>>>>> btree space waste bytes: 413362851
> >>>>>> file data blocks allocated: 90769887232
> >>>>>>  referenced 88836960256
> >>>>>
> >>>>> It looks too good to be true, is the btrfs-progs v5.4? IIRC in v5.4 we
> >>>>> should report inodes generation problems.
> >>>>
> >>>> Hurray Bottom Reply?
> >>>>
> >>>> /usr/src/initramfs/bin $ ./btrfs.static --version
> >>>> btrfs-progs v5.4
> >>
> >> This is strange.
> >>
> >>
> >> 6084adam|thinkpad|~$ btrfs check --mode=lowmem test.img
> >> Opening filesystem to check...
> >> Checking filesystem on test.img
> >> UUID: c6c6ddd2-01c1-47fc-b699-cacfae9d4bfd
> >> [1/7] checking root items
> >> [2/7] checking extents
> >> [3/7] checking free space cache
> >> cache and super generation don't match, space cache will be invalidated
> >> [4/7] checking fs roots
> >> ERROR: invalid inode generation for ino 257, have 8858344568388091671
> >> expect [0, 9)
> >> ERROR: errors found in fs roots
> >> found 131072 bytes used, error(s) found
> >> total csum bytes: 0
> >> total tree bytes: 131072
> >> total fs tree bytes: 32768
> >> total extent tree bytes: 16384
> >> btree space waste bytes: 123409
> >> file data blocks allocated: 0
> >>  referenced 0
> >> 6085adam|thinkpad|~$ btrfs --version
> >> btrfs-progs v5.4
> >>
> >> As expected, v5.4 should detect such problem without problem.
> >>
> >> Would you please provide extra tree dump to help us to determine what
> >> makes btrfs check unable to detect such problems?
> >>
> >> # btrfs ins dump-tree -b 303629811712 /dev/dm-1
> > anvil ~ # btrfs ins dump-tree -b 303629811712 /dev/nvme0n1p2
> > btrfs-progs v5.4
> > Invalid mapping for 303629811712-303629815808, got 476092633088-477166374912
> > Couldn't map the block 303629811712
> > Couldn't map the block 303629811712
> > bad tree block 303629811712, bytenr mismatch, want=303629811712, have=0
> > ERROR: failed to read tree block 303629811712
> >
> The bytenr is different from your initial report.
>
> Anyway, you can try mount with v5.4, and use the bytenr from the dmesg.
>
> Then please provide both dmeg (including the "corrupted leaf" line), and
> the `btrfs ins dump-tree -b` output.
>
> Thanks,
> Qu
>

Good news and bad news.  Running btrfs check --repair fixed the errors
listed in $subject, but seems to have fully hosed te filesystem.  I'm
now getting:

./btrfs.static check /dev/nvme0n1p2
Opening filesystem to check...
Checking filesystem on /dev/nvme0n1p2
UUID: 815266d6-a8b9-4f63-a593-02fde178263f
[1/7] checking root items
parent transid verify failed on 499774480384 wanted 3323349 found 3323340
parent transid verify failed on 499774386176 wanted 3323349 found 3323340
parent transid verify failed on 499774394368 wanted 3323349 found 3323340
parent transid verify failed on 499774398464 wanted 3323349 found 3323340
parent transid verify failed on 499774406656 wanted 3323349 found 3323340
parent transid verify failed on 499774423040 wanted 3323349 found 3323340
parent transid verify failed on 499774427136 wanted 3323349 found 3323340
parent transid verify failed on 499774439424 wanted 3323349 found 3323340
parent transid verify failed on 499774324736 wanted 3323349 found 3323340
parent transid verify failed on 499774513152 wanted 3323349 found 3323340
parent transid verify failed on 499774341120 wanted 3323349 found 3323340
[2/7] checking extents
leaf parent key incorrect 499774554112
bad block 499774554112
ERROR: errors found in extent allocation tree or chunk allocation
[3/7] checking free space cache
there is no free space entry for 499922907136-499952799744
there is no free space entry for 499922907136-500822249472
cache appears valid but isn't 499748507648
[4/7] checking fs roots
Wrong key of child node/leaf, wanted: (1442047, 1, 0), have:
(523365974016, 168, 16384)
root 5 inode 1442047 errors 2001, no inode item, link count wrong
    unresolved ref dir 256 index 0 namelen 3 name etc filetype 2
errors 6, no dir index, no inode ref
root 5 inode 1835263 errors 2001, no inode item, link count wrong
    unresolved ref dir 256 index 0 namelen 3 name bin filetype 2
errors 6, no dir index, no inode ref
root 5 inode 1966335 errors 2001, no inode item, link count wrong
    unresolved ref dir 256 index 0 namelen 4 name proc filetype 2
errors 6, no dir index, no inode ref
root 5 inode 2097407 errors 2001, no inode item, link count wrong
    unresolved ref dir 256 index 0 namelen 5 name lib32 filetype 2
errors 6, no dir index, no inode ref
root 5 inode 2228479 errors 2001, no inode item, link count wrong
    unresolved ref dir 256 index 0 namelen 3 name sys filetype 2
errors 6, no dir index, no inode ref
root 5 inode 2359551 errors 2001, no inode item, link count wrong
    unresolved ref dir 256 index 0 namelen 5 name lib64 filetype 2
errors 6, no dir index, no inode ref
root 5 inode 3145983 errors 2001, no inode item, link count wrong
    unresolved ref dir 256 index 0 namelen 3 name dev filetype 2
errors 6, no dir index, no inode ref
root 5 inode 3277055 errors 2001, no inode item, link count wrong
    unresolved ref dir 256 index 0 namelen 3 name opt filetype 2
errors 6, no dir index, no inode ref
root 5 inode 3408127 errors 2001, no inode item, link count wrong
    unresolved ref dir 256 index 0 namelen 3 name mnt filetype 2
errors 6, no dir index, no inode ref
root 5 inode 3539199 errors 2001, no inode item, link count wrong
    unresolved ref dir 256 index 0 namelen 3 name usr filetype 2
errors 6, no dir index, no inode ref
root 5 inode 3670271 errors 2001, no inode item, link count wrong
    unresolved ref dir 256 index 0 namelen 5 name media filetype 2
errors 6, no dir index, no inode ref
root 5 inode 4587775 errors 2001, no inode item, link count wrong
    unresolved ref dir 256 index 0 namelen 4 name sbin filetype 2
errors 6, no dir index, no inode ref
root 5 inode 4980991 errors 2001, no inode item, link count wrong
    unresolved ref dir 256 index 0 namelen 4 name etc2 filetype 2
errors 6, no dir index, no inode ref
root 5 inode 4984678 errors 2001, no inode item, link count wrong
    unresolved ref dir 256 index 0 namelen 3 name run filetype 2
errors 6, no dir index, no inode ref
root 5 inode 5505279 errors 2001, no inode item, link count wrong
    unresolved ref dir 256 index 0 namelen 7 name exports filetype 2
errors 6, no dir index, no inode ref
root 5 inode 5767423 errors 2001, no inode item, link count wrong
    unresolved ref dir 256 index 0 namelen 5 name debug filetype 2
errors 6, no dir index, no inode ref
root 5 inode 5898495 errors 2001, no inode item, link count wrong
    unresolved ref dir 256 index 0 namelen 4 name etc3 filetype 2
errors 6, no dir index, no inode ref
root 5 inode 6029567 errors 2001, no inode item, link count wrong
    unresolved ref dir 256 index 0 namelen 4 name root filetype 2
errors 6, no dir index, no inode ref
root 5 inode 6431345 errors 2001, no inode item, link count wrong
    unresolved ref dir 256 index 0 namelen 4 name boot filetype 2
errors 6, no dir index, no inode ref
root 5 inode 6553855 errors 2001, no inode item, link count wrong
    unresolved ref dir 256 index 0 namelen 3 name var filetype 2
errors 6, no dir index, no inode ref
root 5 inode 7602431 errors 2001, no inode item, link count wrong
    unresolved ref dir 256 index 0 namelen 3 name tmp filetype 2
errors 6, no dir index, no inode ref
root 5 inode 9133291 errors 2001, no inode item, link count wrong
    unresolved ref dir 256 index 0 namelen 13 name .pulse-cookie
filetype 1 errors 6, no dir index, no inode ref
root 5 inode 9133292 errors 2001, no inode item, link count wrong
    unresolved ref dir 256 index 0 namelen 6 name .pulse filetype 2
errors 6, no dir index, no inode ref
root 5 inode 9980485 errors 2001, no inode item, link count wrong
    unresolved ref dir 256 index 0 namelen 9 name bootchart filetype 2
errors 6, no dir index, no inode ref
root 5 inode 10254180 errors 2001, no inode item, link count wrong
    unresolved ref dir 256 index 0 namelen 4 name temp filetype 2
errors 6, no dir index, no inode ref
root 5 inode 11827458 errors 2001, no inode item, link count wrong
    unresolved ref dir 256 index 0 namelen 8 name tftpboot filetype 2
errors 6, no dir index, no inode ref
root 5 inode 14435353 errors 2001, no inode item, link count wrong
    unresolved ref dir 131327 index 0 namelen 4 name s0be filetype 2
errors 6, no dir index, no inode ref
root 5 inode 14646004 errors 2001, no inode item, link count wrong
    unresolved ref dir 256 index 0 namelen 4 name s0be filetype 2
errors 6, no dir index, no inode ref
root 5 inode 14910590 errors 2001, no inode item, link count wrong
    unresolved ref dir 256 index 0 namelen 13 name .bash_history
filetype 1 errors 6, no dir index, no inode ref
root 5 inode 23438027 errors 2001, no inode item, link count wrong
    unresolved ref dir 256 index 0 namelen 8 name mknod.sh filetype 1
errors 6, no dir index, no inode ref
root 5 inode 25548332 errors 2001, no inode item, link count wrong
    unresolved ref dir 256 index 0 namelen 8 name ctrl_dir filetype 1
errors 6, no dir index, no inode ref
root 5 inode 25548333 errors 2001, no inode item, link count wrong
    unresolved ref dir 256 index 0 namelen 5 name state filetype 1
errors 6, no dir index, no inode ref
root 5 inode 26407893 errors 2001, no inode item, link count wrong
    unresolved ref dir 256 index 0 namelen 6 name e2fsck filetype 1
errors 6, no dir index, no inode ref
root 5 inode 36767707 errors 2001, no inode item, link count wrong
    unresolved ref dir 924630 index 0 namelen 31 name
lib_mysqludf_log-warnings.patch filetype 1 errors 6, no dir index, no
inode ref
root 5 inode 36767712 errors 2001, no inode item, link count wrong
    unresolved ref dir 924632 index 0 namelen 32 name
lib_mysqludf_stem-mysql_m4.patch filetype 1 errors 6, no dir index, no
inode ref
root 5 inode 36767838 errors 2001, no inode item, link count wrong
    unresolved ref dir 924633 index 0 namelen 33 name
mysql-udf-base64-signedness.patch filetype 1 errors 6, no dir index,
no inode ref
root 5 inode 36767839 errors 2001, no inode item, link count wrong
    unresolved ref dir 924633 index 0 namelen 20 name
mysql-udf-base64.sql filetype 1 errors 6, no dir index, no inode ref
root 5 inode 36767840 errors 2001, no inode item, link count wrong
    unresolved ref dir 924634 index 0 namelen 27 name
mysql-udf-http-stdlib.patch filetype 1 errors 6, no dir index, no
inode ref
root 5 inode 36767843 errors 2001, no inode item, link count wrong
    unresolved ref dir 924635 index 0 namelen 29 name
mysql-udf-ipv6-warnings.patch filetype 1 errors 6, no dir index, no
inode ref
root 5 inode 37030378 errors 2001, no inode item, link count wrong
    unresolved ref dir 924616 index 0 namelen 12 name metadata.xml
filetype 1 errors 6, no dir index, no inode ref
root 5 inode 37030384 errors 2001, no inode item, link count wrong
    unresolved ref dir 924619 index 0 namelen 12 name metadata.xml
filetype 1 errors 6, no dir index, no inode ref
root 5 inode 37030490 errors 2001, no inode item, link count wrong
    unresolved ref dir 924625 index 0 namelen 12 name metadata.xml
filetype 1 errors 6, no dir index, no inode ref
root 5 inode 37030492 errors 2001, no inode item, link count wrong
    unresolved ref dir 924626 index 0 namelen 12 name metadata.xml
filetype 1 errors 6, no dir index, no inode ref
root 5 inode 37030497 errors 2001, no inode item, link count wrong
    unresolved ref dir 924628 index 0 namelen 12 name metadata.xml
filetype 1 errors 6, no dir index, no inode ref
root 5 inode 39198776 errors 2001, no inode item, link count wrong
    unresolved ref dir 256 index 0 namelen 8 name bootback filetype 2
errors 6, no dir index, no inode ref
root 5 inode 51520157 errors 2001, no inode item, link count wrong
    unresolved ref dir 924616 index 0 namelen 29 name
lib_mysqludf_log-0.0.2.ebuild filetype 1 errors 6, no dir index, no
inode ref
root 5 inode 51520163 errors 2001, no inode item, link count wrong
    unresolved ref dir 924619 index 0 namelen 30 name
lib_mysqludf_stem-0.9.1.ebuild filetype 1 errors 6, no dir index, no
inode ref
root 5 inode 51520278 errors 2001, no inode item, link count wrong
    unresolved ref dir 924625 index 0 namelen 32 name
mysql-udf-base64-20010618.ebuild filetype 1 errors 6, no dir index, no
inode ref
root 5 inode 51520280 errors 2001, no inode item, link count wrong
    unresolved ref dir 924626 index 0 namelen 25 name
mysql-udf-http-1.0.ebuild filetype 1 errors 6, no dir index, no inode
ref
root 5 inode 51520284 errors 2001, no inode item, link count wrong
    unresolved ref dir 924628 index 0 namelen 25 name
mysql-udf-ipv6-0.4.ebuild filetype 1 errors 6, no dir index, no inode
ref
root 5 inode 58792107 errors 2001, no inode item, link count wrong
    unresolved ref dir 256 index 0 namelen 3 name foo filetype 1
errors 6, no dir index, no inode ref
root 5 inode 63681251 errors 2001, no inode item, link count wrong
    unresolved ref dir 256 index 0 namelen 4 name xpra filetype 2
errors 6, no dir index, no inode ref
root 5 inode 66715793 errors 2001, no inode item, link count wrong
    unresolved ref dir 256 index 0 namelen 8 name .viminfo filetype 1
errors 6, no dir index, no inode ref
root 5 inode 71469207 errors 2001, no inode item, link count wrong
    unresolved ref dir 924616 index 0 namelen 8 name Manifest filetype
1 errors 6, no dir index, no inode ref
root 5 inode 71469208 errors 2001, no inode item, link count wrong
    unresolved ref dir 924619 index 0 namelen 8 name Manifest filetype
1 errors 6, no dir index, no inode ref
root 5 inode 71469238 errors 2001, no inode item, link count wrong
    unresolved ref dir 924625 index 0 namelen 8 name Manifest filetype
1 errors 6, no dir index, no inode ref
root 5 inode 71469239 errors 2001, no inode item, link count wrong
    unresolved ref dir 924626 index 0 namelen 8 name Manifest filetype
1 errors 6, no dir index, no inode ref
root 5 inode 71469240 errors 2001, no inode item, link count wrong
    unresolved ref dir 924628 index 0 namelen 8 name Manifest filetype
1 errors 6, no dir index, no inode ref
root 5 inode 75334150 errors 2001, no inode item, link count wrong
    unresolved ref dir 256 index 0 namelen 7 name lib.new filetype 2
errors 6, no dir index, no inode ref
root 5 inode 77351088 errors 2001, no inode item, link count wrong
    unresolved ref dir 256 index 0 namelen 3 name lib filetype 7
errors 6, no dir index, no inode ref
ERROR: errors found in fs roots
found 951992320 bytes used, error(s) found
total csum bytes: 0
total tree bytes: 3895296
total fs tree bytes: 0
total extent tree bytes: 3813376
btree space waste bytes: 1560917
file data blocks allocated: 27983872
 referenced 27983872

Should I also paste in the repair log?
