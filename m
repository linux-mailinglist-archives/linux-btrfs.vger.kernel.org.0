Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0548012CDDA
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Dec 2019 10:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfL3JCE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 30 Dec 2019 04:02:04 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34609 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbfL3JCE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Dec 2019 04:02:04 -0500
Received: by mail-ot1-f66.google.com with SMTP id a15so45486707otf.1
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Dec 2019 01:02:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8iTOMyEnXIwWJJb+987xW0a91yr7enufGHVXHNtlpHs=;
        b=o0EBODtPPnNvfO3aWS2iZaA5/8V9S52ZypvM8a0MH0bVa+JYfapMttEIvSBe0qeDaa
         r+O72ZZMwJ5fwoRCLBT0Si/ho1+Hms9xHTmXNg5WdE8OZplA/LfEbgssbbbiqzBklau6
         EfRhCMV+ipJYxf5y6/g9puwoI40Z2hN8rOv+2fkvft83jwfw3ipP/Qb0xV+x6MX6Qeic
         VcmlmsBI/YIuL/v+9/quTKuZhus7g81h3KGcX1vcDPqitvy/5Og0lsEF7ffxy6jjRBsq
         riuRgJnfbGZeGHNEcRgIzXGSkPyaal6Jo6qVq3YLDqFX6RCnl9vmzXP0YoipVzaHIBEG
         cGqw==
X-Gm-Message-State: APjAAAVIjzHv0bTE3kuv7EVrL0VouewecCd5fGKA7rwoTGrFHPhF26eD
        nY1ZwDH7qMLb0SEDqUce/MlDpvk2n/rclExL/ki9TQ==
X-Google-Smtp-Source: APXvYqyOpF6pZVbTqy1DYDyZDSf7oZpWvuXTM66lJYwTjeSptJjy9Jx/3WmPOKR+aoP0LyapWxWrihGnhTlMNU0thZA=
X-Received: by 2002:a9d:7410:: with SMTP id n16mr60725659otk.23.1577696522601;
 Mon, 30 Dec 2019 01:02:02 -0800 (PST)
MIME-Version: 1.0
References: <CAOB=O_jxu5JOe=JiYVW_VZ1rgs9+mdHpAHkscXkc4MVRLrBKDw@mail.gmail.com>
 <4bf17941-2ab0-15ca-b4c9-f6ba037624ee@gmx.com> <CAOB=O_jfwBVihtbNTF1xLNWNtf2_Mi=Bs_BCZ8VnXOKWosw7uQ@mail.gmail.com>
 <66d35620-160e-105a-6970-03c3de3f7c78@gmx.com> <CAOB=O_jpg0K4eDARfG+XDDRMHhm+yKp8XfhjqHsFxAswSPUfdQ@mail.gmail.com>
 <CAOB=O_hdjpNtNtMMi93CFh3wO048SDVxMgBQd_pC0wx0C_49Ug@mail.gmail.com>
 <a2f28c83-01c0-fce7-5332-2e9331f3c3df@gmx.com> <CAOB=O_gBBjT9EVduHWHbF8iOsA8ua-ZGGh4s1x6Lia24LAZEMg@mail.gmail.com>
 <4c06d3a9-7f09-c97c-a6f3-c7f7419d16a7@gmx.com> <CAOB=O_i=ZDZw92ty9HUeobV1J4FA8LNRCkPKkJ1CVrzHxAieuw@mail.gmail.com>
 <27a9570c-70cc-19b6-3f5f-cd261040a67c@gmx.com>
In-Reply-To: <27a9570c-70cc-19b6-3f5f-cd261040a67c@gmx.com>
From:   Patrick Erley <pat-lkml@erley.org>
Date:   Mon, 30 Dec 2019 09:01:51 +0000
Message-ID: <CAOB=O_hMPVfmFqumfcdS8LxG0tZXR2AiccDwgN1f6Lomntg9uQ@mail.gmail.com>
Subject: Re: read time tree block corruption detected
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 30, 2019 at 8:54 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> On 2019/12/30 下午4:14, Patrick Erley wrote:
> > On Mon, Dec 30, 2019 at 6:09 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >
> > Should I also paste in the repair log?
> >
> Yes please.
>
> This sounds very strange, especially for the transid mismatch part.
>
> Thanks,
> Qu
>



enabling repair mode
WARNING:

    Do not use --repair unless you are advised to do so by a developer
    or an experienced user, and then only after having accepted that no
    fsck can successfully repair all types of filesystem corruption. Eg.
    some software or hardware bugs can fatally damage a volume.
    The operation will start in 10 seconds.
    Use Ctrl-C to stop it.
10 9 8 7 6 5 4 3 2 1parent transid verify failed on 499774464000
wanted 3323349 found 3323340
parent transid verify failed on 499774521344 wanted 3323349 found 3323340
parent transid verify failed on 499774529536 wanted 3323349 found 3323340
[1/7] checking root items
parent transid verify failed on 499774373888 wanted 3323349 found 3323340
parent transid verify failed on 499774480384 wanted 3323349 found 3323340
parent transid verify failed on 499774386176 wanted 3323349 found 3323340
parent transid verify failed on 499774390272 wanted 3323349 found 3323340
parent transid verify failed on 499774394368 wanted 3323349 found 3323340
parent transid verify failed on 499774398464 wanted 3323349 found 3323340
parent transid verify failed on 499774402560 wanted 3323349 found 3323340
parent transid verify failed on 499774406656 wanted 3323349 found 3323340
parent transid verify failed on 499774423040 wanted 3323349 found 3323340
parent transid verify failed on 499774427136 wanted 3323349 found 3323340
parent transid verify failed on 499774435328 wanted 3323349 found 3323340
parent transid verify failed on 499774439424 wanted 3323349 found 3323340
parent transid verify failed on 499774320640 wanted 3323349 found 3323340
parent transid verify failed on 499774324736 wanted 3323349 found 3323340
parent transid verify failed on 499774443520 wanted 3323349 found 3323340
parent transid verify failed on 499774447616 wanted 3323349 found 3323340
parent transid verify failed on 499774504960 wanted 3323349 found 3323340
parent transid verify failed on 499774513152 wanted 3323349 found 3323340
parent transid verify failed on 499774468096 wanted 3323349 found 3323340
parent transid verify failed on 499774337024 wanted 3323349 found 3323340
parent transid verify failed on 499774341120 wanted 3323349 found 3323340
parent transid verify failed on 499774517248 wanted 3323349 found 3323340
parent transid verify failed on 499774558208 wanted 3323349 found 3323340
Fixed 0 roots.
[2/7] checking extents
extent back ref already exists for 499952799744 parent 0 root 2
extent back ref already exists for 499952803840 parent 0 root 2
extent back ref already exists for 499952807936 parent 0 root 2
extent back ref already exists for 499952812032 parent 0 root 2
extent back ref already exists for 499952816128 parent 0 root 2
extent back ref already exists for 499952824320 parent 0 root 5
extent back ref already exists for 499952832512 parent 0 root 2
extent back ref already exists for 499952852992 parent 0 root 2
extent back ref already exists for 499952857088 parent 0 root 2
extent back ref already exists for 499952861184 parent 0 root 2
extent back ref already exists for 499952877568 parent 0 root 2
extent back ref already exists for 499952885760 parent 0 root 2
extent back ref already exists for 499952889856 parent 0 root 2
extent back ref already exists for 499952898048 parent 0 root 2
leaf parent key incorrect 499774554112
leaf parent key incorrect 499774554112
leaf parent key incorrect 499774554112
leaf parent key incorrect 499774554112
leaf parent key incorrect 499774554112
leaf parent key incorrect 499774554112
leaf parent key incorrect 499774554112
leaf parent key incorrect 499774554112
leaf parent key incorrect 499774554112
leaf parent key incorrect 499774554112
leaf parent key incorrect 499774554112
leaf parent key incorrect 499774554112
leaf parent key incorrect 499774554112
leaf parent key incorrect 499774554112
leaf parent key incorrect 499774554112
leaf parent key incorrect 499774554112
leaf parent key incorrect 499774554112
leaf parent key incorrect 499774554112
leaf parent key incorrect 499774554112
leaf parent key incorrect 499774554112
leaf parent key incorrect 499774554112
leaf parent key incorrect 499774554112
leaf parent key incorrect 499774554112
leaf parent key incorrect 499774554112
leaf parent key incorrect 499774554112
leaf parent key incorrect 499773358080
bad block 499773358080
ERROR: errors found in extent allocation tree or chunk allocation
[3/7] checking free space cache
[4/7] checking fs roots
parent transid verify failed on 499774283776 wanted 3323349 found 3323340
Wrong key of child node/leaf, wanted: (1442047, 1, 0), have:
(523365974016, 168, 16384)
ERROR: child eb corrupted: parent bytenr=499750891520 item=2 parent
level=2 child level=0
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
ERROR: child eb corrupted: parent bytenr=499762622464 item=37 parent
level=2 child level=0
root 5 inode 6553855 errors 2001, no inode item, link count wrong
    unresolved ref dir 256 index 0 namelen 3 name var filetype 2
errors 6, no dir index, no inode ref
root 5 inode 7602431 errors 2001, no inode item, link count wrong
    unresolved ref dir 256 index 0 namelen 3 name tmp filetype 2
errors 6, no dir index, no inode ref
ERROR: child eb corrupted: parent bytenr=499752206336 item=14 parent
level=3 child level=0
root 5 inode 9133291 errors 2001, no inode item, link count wrong
    unresolved ref dir 256 index 0 namelen 13 name .pulse-cookie
filetype 1 errors 6, no dir index, no inode ref
ERROR: child eb corrupted: parent bytenr=499748732928 item=14 parent
level=3 child level=0
root 5 inode 9133292 errors 2001, no inode item, link count wrong
    unresolved ref dir 256 index 0 namelen 6 name .pulse filetype 2
errors 6, no dir index, no inode ref
ERROR: child eb corrupted: parent bytenr=499752206336 item=14 parent
level=3 child level=0
root 5 inode 9980485 errors 2001, no inode item, link count wrong
    unresolved ref dir 256 index 0 namelen 9 name bootchart filetype 2
errors 6, no dir index, no inode ref
root 5 inode 10254180 errors 2001, no inode item, link count wrong
    unresolved ref dir 256 index 0 namelen 4 name temp filetype 2
errors 6, no dir index, no inode ref
root 5 inode 11827458 errors 2001, no inode item, link count wrong
    unresolved ref dir 256 index 0 namelen 8 name tftpboot filetype 2
errors 6, no dir index, no inode ref
ERROR: child eb corrupted: parent bytenr=499748732928 item=17 parent
level=3 child level=0
root 5 inode 14435353 errors 2001, no inode item, link count wrong
    unresolved ref dir 131327 index 0 namelen 4 name s0be filetype 2
errors 6, no dir index, no inode ref
ERROR: child eb corrupted: parent bytenr=499752206336 item=17 parent
level=3 child level=0
root 5 inode 14646004 errors 2001, no inode item, link count wrong
    unresolved ref dir 256 index 0 namelen 4 name s0be filetype 2
errors 6, no dir index, no inode ref
ERROR: child eb corrupted: parent bytenr=499748732928 item=17 parent
level=3 child level=0
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
ERROR: child eb corrupted: parent bytenr=499748732928 item=65 parent
level=3 child level=1
root 5 inode 75334150 errors 2001, no inode item, link count wrong
    unresolved ref dir 256 index 0 namelen 7 name lib.new filetype 2
errors 6, no dir index, no inode ref
parent transid verify failed on 499774287872 wanted 3323349 found 3323340
parent transid verify failed on 499774291968 wanted 3323349 found 3323340
parent transid verify failed on 499774296064 wanted 3323349 found 3323340
root 5 inode 77351088 errors 2001, no inode item, link count wrong
    unresolved ref dir 256 index 0 namelen 3 name lib filetype 7
errors 6, no dir index, no inode ref
ERROR: errors found in fs roots

Starting repair.
Opening filesystem to check...
Checking filesystem on /dev/sda3
UUID: 815266d6-a8b9-4f63-a593-02fde178263f
cache and super generation don't match, space cache will be invalidated
reset isize for dir 256 root 5
reset isize for dir 131327 root 5
reset isize for dir 924616 root 5
Moving file 'lib_mysqludf_log' to 'lost+found' dir since it has no valid backref
Fixed the nlink of inode 924616
reset isize for dir 924619 root 5
Moving file 'lib_mysqludf_stem' to 'lost+found' dir since it has no
valid backref
Fixed the nlink of inode 924619
reset isize for dir 924625 root 5
Moving file 'mysql-udf-base64' to 'lost+found' dir since it has no valid backref
Fixed the nlink of inode 924625
reset isize for dir 924626 root 5
Moving file 'mysql-udf-http' to 'lost+found' dir since it has no valid backref
Fixed the nlink of inode 924626
reset isize for dir 924628 root 5
Moving file 'mysql-udf-ipv6' to 'lost+found' dir since it has no valid backref
Fixed the nlink of inode 924628
reset isize for dir 924630 root 5
reset isize for dir 924632 root 5
reset isize for dir 924633 root 5
reset isize for dir 924634 root 5
reset isize for dir 924635 root 5
Trying to rebuild inode:1442047
Trying to rebuild inode:1835263
Trying to rebuild inode:1966335
Trying to rebuild inode:2097407
Trying to rebuild inode:2228479
Trying to rebuild inode:2359551
Trying to rebuild inode:3145983
Trying to rebuild inode:3277055
Trying to rebuild inode:3408127
Trying to rebuild inode:3539199
Trying to rebuild inode:3670271
Trying to rebuild inode:4587775
Trying to rebuild inode:4980991
Trying to rebuild inode:4984678
Trying to rebuild inode:5505279
Trying to rebuild inode:5767423
Trying to rebuild inode:5898495
Trying to rebuild inode:6029567
Trying to rebuild inode:6431345
Trying to rebuild inode:6553855
Trying to rebuild inode:7602431
Trying to rebuild inode:9133291
Trying to rebuild inode:9133292
Trying to rebuild inode:9980485
Trying to rebuild inode:10254180
Trying to rebuild inode:11827458
Trying to rebuild inode:14435353
Trying to rebuild inode:14646004
Trying to rebuild inode:14910590
Trying to rebuild inode:23438027
Trying to rebuild inode:25548332
Trying to rebuild inode:25548333
Trying to rebuild inode:26407893
Trying to rebuild inode:36767707
Trying to rebuild inode:36767712
Trying to rebuild inode:36767838
Trying to rebuild inode:36767839
Trying to rebuild inode:36767840
Trying to rebuild inode:36767843
Trying to rebuild inode:37030378
Trying to rebuild inode:37030384
Trying to rebuild inode:37030490
Trying to rebuild inode:37030492
Trying to rebuild inode:37030497
Trying to rebuild inode:39198776
Trying to rebuild inode:51520157
Trying to rebuild inode:51520163
Trying to rebuild inode:51520278
Trying to rebuild inode:51520280
Trying to rebuild inode:51520284
Trying to rebuild inode:58792107
Trying to rebuild inode:63681251
Trying to rebuild inode:66715793
Trying to rebuild inode:71469207
Trying to rebuild inode:71469208
Trying to rebuild inode:71469238
Trying to rebuild inode:71469239
Trying to rebuild inode:71469240
Trying to rebuild inode:75334150
Trying to rebuild inode:77351088
found 89594781696 bytes used, error(s) found
total csum bytes: 0
total tree bytes: 108093440
total fs tree bytes: 53248
total extent tree bytes: 107958272
btree space waste bytes: 36265970
file data blocks allocated: 27983872
 referenced 27983872
