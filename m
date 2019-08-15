Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8F88EEF6
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2019 17:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731756AbfHOPBL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Aug 2019 11:01:11 -0400
Received: from resqmta-po-10v.sys.comcast.net ([96.114.154.169]:54734 "EHLO
        resqmta-po-10v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727160AbfHOPBK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Aug 2019 11:01:10 -0400
Received: from resomta-po-05v.sys.comcast.net ([96.114.154.229])
        by resqmta-po-10v.sys.comcast.net with ESMTP
        id yGMuhZ6fKELdDyHFVhNC4F; Thu, 15 Aug 2019 15:01:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1565881269;
        bh=IGn3kVXkXzUmhTf7k9WGoninqQmzClI6hfx3h8NEp1Y=;
        h=Received:Received:Received:Received:Date:From:To:Subject:
         Message-ID:Reply-To:MIME-Version:Content-Type;
        b=kZ3ExbyTFjND1hvkYCd9O6pCiwGoiqZuYpKHpeeT6X1G5kHxCq2O8nPyBnwD2z38o
         ZPunBe+JueBs4snYCU5X/IwN0gXAccBD9ftqY2EujpFsbZJ5wen0lTkP8bYyygkmJ8
         5AJCPWlLA20QyIM6UYvNFjWlL/Ynslrtmyb5bA2E+0v4OZWCdC0S6FBy9+QAEvdHqG
         VYJQyGKYpxISvHPoENRPKZcuCdRKOLa+aQG9e/QV77ioPy5nJo6/+Oj/E9zUM21xFf
         iTD2U2FdtEWGvrs6lwTBTgPe5dC6xIUWryS0o9DbWX7y/Xvku9mrErpr3Nqneg5CzK
         XF4vXcFwy+lFg==
Received: from beta.localdomain ([73.209.109.78])
        by resomta-po-05v.sys.comcast.net with ESMTPA
        id yHFUhO0XmCDVRyHFVhSrwZ; Thu, 15 Aug 2019 15:01:09 +0000
X-Xfinity-VAAS: gggruggvucftvghtrhhoucdtuddrgeduvddrudefuddgkedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuvehomhgtrghsthdqtfgvshhipdfqfgfvpdfpqffurfetoffkrfenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkrhhfgggtuggjvggfsehttdertddtredvnecuhfhrohhmpefvihhmucghrghlsggvrhhguceothifrghlsggvrhhgsegtohhmtggrshhtrdhnvghtqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeejfedrvddtledruddtledrjeeknecurfgrrhgrmhephhgvlhhopegsvghtrgdrlhhotggrlhguohhmrghinhdpihhnvghtpeejfedrvddtledruddtledrjeekpdhmrghilhhfrhhomhepthifrghlsggvrhhgsegtohhmtggrshhtrdhnvghtpdhrtghpthhtohepqhhufigvnhhruhhordgsthhrfhhssehgmhigrdgtohhmpdhrtghpthhtohepthifrghlsggvrhhgsegtohhmtggrshhtrdhnvghtpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-Xfinity-VMeta: sc=0;st=legit
Received: from calvin.localdomain ([10.0.0.8])
        by beta.localdomain with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <twalberg@comcast.net>)
        id 1hyHFU-0007pw-9x; Thu, 15 Aug 2019 10:01:08 -0500
Received: from tew by calvin.localdomain with local (Exim 4.84_2)
        (envelope-from <tew@calvin.localdomain>)
        id 1hyHFU-0005Gn-5B; Thu, 15 Aug 2019 10:01:08 -0500
Date:   Thu, 15 Aug 2019 10:01:08 -0500
From:   Tim Walberg <twalberg@comcast.net>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Tim Walberg <twalberg@comcast.net>, linux-btrfs@vger.kernel.org
Subject: Re: recovering from "parent transid verify failed"
Message-ID: <20190815150108.GF2731@comcast.net>
Reply-To: Tim Walberg <twalberg@comcast.net>
References: <20190814183213.GA2731@comcast.net>
 <4be5086f-61e7-a108-8036-da7d7a5d5c11@gmx.com>
 <20190815135251.GC2731@comcast.net>
 <b871da91-1330-f8c9-add8-858025a91fc9@gmx.com>
 <20190815142105.GE2731@comcast.net>
 <1ce8ace9-b86a-19fb-0b4c-f6315c8e73b2@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ce8ace9-b86a-19fb-0b4c-f6315c8e73b2@gmx.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks for all the help!

If I get a chance later today, I may try the patch set, but in
the interest of getting things back online quicker, I may just
have to recreate and restore the recovered data. The snapshots
are no great loss - they're just one level of daily backups.

			tw



On 08/15/2019 22:45 +0800, Qu Wenruo wrote:
>>	
>>	
>>	On 2019/8/15 ??????10:21, Tim Walberg wrote:
>>	> 'dump-super -Ffa' from all three devices attached.
>>	> 
>>	> 'btrfs restore' did appear to recover most of the main data, minus
>>	> snapshots, which would have greatly increased the required time and
>>	> capacity, since I was recovering to XFS.
>>	
>>	That's why I recommend that experimental patchset, it will make the fs
>>	mountable (RO though), with all btrfs snapshots available.
>>	
>>	> 
>>	> 'btrfs rescue chunk-recover' ran, but failed to fix anything.
>>	> 'btrfs rescue super-recover' says all supers are fine.
>>	
>>	Those are useless for your case.
>>	
>>	> 
>>	> Initial corruption was due to a hard hang, which didn't leave enough
>>	> crumbs to determine the source - might have been btrfs, might have
>>	> been nvidia, might have been something completely different.
>>	
>>	Anyway, the corruption is a little strange.
>>	
>>	First of all, even hard hang/power loss shouldn't cause btrfs to
>>	overwrite its tree block, thus even hard hang/power loss happens, btrfs
>>	should be corrupted.
>>	
>>	But that's definitely not the case. (We have quite some such report, but
>>	haven't pinned down the cause yet)
>>	
>>	Secondly, the generation of your fs is strange.
>>	The latest geneartion of your tree root is 49750, matches with your
>>	corrupted tree block, but your extent tree is definitely older.
>>	
>>	So it looks like, your super blocks (all nine!) reach disk before some
>>	tree blocks reach the disk.
>>	
>>	Finally, the superblock doesn't record previous transaction correctly.
>>	It doesn't has transaction of 49749 in its backup roots.
>>	
>>	Not 100% sure, but looks somewhat like the problem fixed by this patch:
>>	Btrfs: fix race leading to fs corruption after transaction abortion
>>	
>>	It should get backported to all stable release recently.
>>	
>>	Thanks,
>>	Qu
>>	
>>	> 
>>	> 
>>	> On 08/15/2019 22:07 +0800, Qu Wenruo wrote:
>>	>>> 	
>>	>>> 	
>>	>>> 	On 2019/8/15 ??????9:52, Tim Walberg wrote:
>>	>>> 	> Had to wait for 'btrfs recover' to finish before I proceed farther.
>>	>>> 	> 
>>	>>> 	> Kernel is 4.19.45, tools are 4.19.1
>>	>>> 	> 
>>	>>> 	> File system is a 3-disk RAID10 with WD3003FZEX (WD Black 3TB)
>>	>>> 	> 
>>	>>> 	> Output from attempting to mount:
>>	>>> 	> 
>>	>>> 	> # mount -o ro,usebackuproot /dev/sdc1 /mnt
>>	>>> 	> mount: wrong fs type, bad option, bad superblock on /dev/sdc1,
>>	>>> 	>        missing codepage or helper program, or other error
>>	>>> 	> 
>>	>>> 	>        In some cases useful info is found in syslog - try
>>	>>> 	>        dmesg | tail or so.
>>	>>> 	> 
>>	>>> 	> Kernel messages from the mount attempt:
>>	>>> 	> 
>>	>>> 	> [Thu Aug 15 08:47:42 2019] BTRFS info (device sdc1): trying to use backup root at mount time
>>	>>> 	> [Thu Aug 15 08:47:42 2019] BTRFS info (device sdc1): disk space caching is enabled
>>	>>> 	> [Thu Aug 15 08:47:42 2019] BTRFS info (device sdc1): has skinny extents
>>	>>> 	> [Thu Aug 15 08:47:42 2019] BTRFS error (device sdc1): parent transid verify failed on 229846466560 wanted 49749 found 49750
>>	>>> 	> [Thu Aug 15 08:47:42 2019] BTRFS error (device sdc1): parent transid verify failed on 229846466560 wanted 49749 found 49750
>>	>>> 	> [Thu Aug 15 08:47:42 2019] BTRFS error (device sdc1): failed to read block groups: -5
>>	>>> 	
>>	>>> 	Extent tree corruption.
>>	>>> 	
>>	>>> 	So if that's the only corruption, you have a very high chance to recover
>>	>>> 	most of your data.
>>	>>> 	
>>	>>> 	Btrfs rescue can work, or you can try the experimental patches which
>>	>>> 	provides rescue=skip_bg mount option to allow you mount the fs RO and
>>	>>> 	receive your data (later is way faster than user space rescue)
>>	>>> 	https://patchwork.kernel.org/project/linux-btrfs/list/?series=130637
>>	>>> 	
>>	>>> 	Also, for your dump super output, it doesn't provide too much info.
>>	>>> 	
>>	>>> 	You would like to use -Ffa option for more info.
>>	>>> 	Also, you could also try that on all 3 devices, to find out which one
>>	>>> 	has lower generation.
>>	>>> 	
>>	>>> 	Also, please provide the history of the corruption.
>>	>>> 	One generation corruptions is a little rare. Is sudden power loss
>>	>>> 	involved in this case?
>>	>>> 	
>>	>>> 	Thanks,
>>	>>> 	Qu
>>	>>> 	
>>	>>> 	> [Thu Aug 15 08:47:42 2019] BTRFS error (device sdc1): open_ctree failed
>>	>>> 	> 
>>	>>> 	> Output from 'btrfs check -p /dev/sdc1':
>>	>>> 	> 
>>	>>> 	> # btrfs check -p /dev/sdc1
>>	>>> 	> Opening filesystem to check...
>>	>>> 	> parent transid verify failed on 229846466560 wanted 49749 found 49750
>>	>>> 	> Ignoring transid failure
>>	>>> 	> ERROR: child eb corrupted: parent bytenr=229845336064 item=0 parent level=1 child level=2
>>	>>> 	> ERROR: cannot open file system
>>	>>> 	> 
>>	>>> 	> 
>>	>>> 	> 
>>	>>> 	> On 08/15/2019 10:35 +0800, Qu Wenruo wrote:
>>	>>> 	>>> 	
>>	>>> 	>>> 	
>>	>>> 	>>> 	On 2019/8/15 ??????2:32, Tim Walberg wrote:
>>	>>> 	>>> 	> Most of the recommendations I've found online deal with when "wanted" is
>>	>>> 	>>> 	> greater than "found", which, if I understand correctly means that one or
>>	>>> 	>>> 	> more transactions were interrupted/lost before fully committed.
>>	>>> 	>>> 	
>>	>>> 	>>> 	No matter what the case is, a proper transaction shouldn't have any tree
>>	>>> 	>>> 	block overwritten.
>>	>>> 	>>> 	
>>	>>> 	>>> 	That means, either the FLUSH/FUA of the hardware/lower block layer is
>>	>>> 	>>> 	screwed up, or the COW of tree block is already screwed up.
>>	>>> 	>>> 	
>>	>>> 	>>> 	> 
>>	>>> 	>>> 	> Are the recommendations for recovery the same if the system is reporting a
>>	>>> 	>>> 	> "wanted" that is less than "found"?
>>	>>> 	>>> 	> 
>>	>>> 	>>> 	The salvage is no difference than any transid mismatch, no matter if
>>	>>> 	>>> 	it's larger or smaller.
>>	>>> 	>>> 	
>>	>>> 	>>> 	It depends on the tree block.
>>	>>> 	>>> 	
>>	>>> 	>>> 	Please provide full dmesg output and btrfs check for further advice.
>>	>>> 	>>> 	
>>	>>> 	>>> 	Thanks,
>>	>>> 	>>> 	Qu
>>	>>> 	>>> 	
>>	>>> 	> 
>>	>>> 	> 
>>	>>> 	> 
>>	>>> 	> 
>>	>>> 	
>>	> 
>>	> 
>>	> 
>>	> End of included message
>>	> 
>>	> 
>>	> 
>>	



End of included message



-- 
+----------------------+
| Tim Walberg          |
| 830 Carriage Dr.     |
| Algonquin, IL 60102  |
| twalberg@comcast.net |
+----------------------+
