Return-Path: <linux-btrfs+bounces-2667-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC79E861028
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 12:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A335B23FC5
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 11:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E7A5DF25;
	Fri, 23 Feb 2024 11:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=edcint.co.nz header.i=@edcint.co.nz header.b="5bdhulFx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from m3.out3.mxs.au (m3.out3.mxs.au [110.232.143.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C427241F9
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Feb 2024 11:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=110.232.143.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708686625; cv=none; b=k1qkOPCaSqX6BO8xf18PLjcnLDTNo1KCF1KY1RjJlPvDRLSsAFb9G7CXYatJWivf+2H/wf1M4sstC0ujGxnRKsJ9Bilh+aNKw8NHA5tcHZRhs5NEzR982IbMMqDeJGTfRFpHgmFS+k47lFdYnMiAQluClu5ihrBembx1ZZubaJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708686625; c=relaxed/simple;
	bh=T2FUyP6JaA6oR6R8rbCXNDu7quS9KXoiJdgpafpMr28=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=pM7AXLIVFIxNmKWLF/rOkiKnd4dJhwImqHNX+MO6Sstrj9c1Tfqpyt28+46weXxu5V/FDr2AmAYu2O3bn4lM/tQpcGctF+fNMu6WOYMATY0rwAxjvsz2QuxW+JEkG8DlzXCm8o5Y1n/4DckxNa3HAp0HuHVLyP/R13skBR8yp5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edcint.co.nz; spf=fail smtp.mailfrom=edcint.co.nz; dkim=pass (2048-bit key) header.d=edcint.co.nz header.i=@edcint.co.nz header.b=5bdhulFx; arc=none smtp.client-ip=110.232.143.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edcint.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=edcint.co.nz
Received: from s02bd.syd2.hostingplatform.net.au (s02bd.syd2.hostingplatform.net.au [103.27.32.42])
	by out3.mxs.au (Halon) with ESMTPS (TLSv1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	id f352a410-d23b-11ee-990e-00163c573069
	for <linux-btrfs@vger.kernel.org>;
	Fri, 23 Feb 2024 22:09:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=edcint.co.nz; s=default; h=Content-Transfer-Encoding:Content-Type:Subject:
	From:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=s6LYkfuQl9rd2OrOurZpsUHotA8msF6ry8gt0h2RwK4=; b=5bdhulFxc96w0wDO+3W+9Ho7HX
	O0mIvqw0cm9zutTzVmXaLizQLonPxUZ9OWoKd/5T/rMbiHAoF+lJT550kVNU4riplIqONCbRSpG2R
	XpqYv8idfnOFEBfApSVaXJj7KT8H7JZzGUBaLiSxsnaCUofKHkgNb6810Zw4r3Et68bL+gMvk6eCr
	U8Y+BxlOsfGjGZO0mNhE0NXGJZEwXw0UZiLJCWXuWlLfO6Y5KAZUdisadG8fWcOsWk54Q5mNJ6ozp
	fRleJR/1n+nqa8NHLI3aEVY4ySaIxga2wRLyik5iumeJDSmmCsDxL8pMonDFIdpo1W5ckp5Pabzxt
	J7eJe6WQ==;
Received: from [159.196.20.165] (port=43882 helo=[192.168.2.2])
	by s02bd.syd2.hostingplatform.net.au with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <default@edcint.co.nz>)
	id 1rdTQM-000vsg-0M
	for linux-btrfs@vger.kernel.org;
	Fri, 23 Feb 2024 22:09:02 +1100
Message-ID: <cb434383-5dfb-4748-8039-1496e09a2a80@edcint.co.nz>
Date: Fri, 23 Feb 2024 22:09:01 +1100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-btrfs@vger.kernel.org
Content-Language: en-US
From: Matthew Jurgens <default@edcint.co.nz>
Subject: How to repair BTRFS
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s02bd.syd2.hostingplatform.net.au
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - edcint.co.nz
X-Get-Message-Sender-Via: s02bd.syd2.hostingplatform.net.au: authenticated_id: default@edcint.co.nz
X-Authenticated-Sender: s02bd.syd2.hostingplatform.net.au: default@edcint.co.nz
X-Source: 
X-Source-Args: 
X-Source-Dir: 

If I can't run --repair, then how do I repair my file system?

I ran a scrub which reported 8 errors that could not be fixed.

------------------------------------------------------------------------------------------------------------------------------

Then I ran a btrfs check while mounted which looks like:

WARNING: filesystem mounted, continuing because of --force
Opening filesystem to check...
Checking filesystem on /dev/sdg
UUID: 021756e1-c9b4-41e7-bfd3-bc4e930eae46
parent transid verify failed on 18344238039040 wanted 4416296 found 
4416299s checked)
parent transid verify failed on 18344238039040 wanted 4416296 found 4416299
parent transid verify failed on 18344238039040 wanted 4416296 found 4416299
Ignoring transid failure
ERROR: child eb corrupted: parent bytenr=18344237924352 item=1 parent 
level=2 child bytenr=18344238039040 child level=0
[1/7] checking root items                      (0:00:06 elapsed, 69349 
items checked)
ERROR: failed to repair root items: Input/output error
parent transid verify failed on 18344253374464 wanted 4416296 found 4416300
parent transid verify failed on 18344253374464 wanted 4416296 found 4416300
parent transid verify failed on 18344253374464 wanted 4416296 found 4416300
Ignoring transid failure
parent transid verify failed on 18344264335360 wanted 4416296 found 4416301
parent transid verify failed on 18344264335360 wanted 4416296 found 4416301
parent transid verify failed on 18344264335360 wanted 4416296 found 4416301
Ignoring transid failure
parent transid verify failed on 18344243511296 wanted 4416296 found 4416301
parent transid verify failed on 18344243511296 wanted 4416296 found 4416301
parent transid verify failed on 18344243511296 wanted 4416296 found 4416301
Ignoring transid failure
parent transid verify failed on 18344246345728 wanted 4416296 found 4416301
parent transid verify failed on 18344246345728 wanted 4416296 found 4416301
parent transid verify failed on 18344246345728 wanted 4416296 found 4416301
Ignoring transid failure
ERROR: child eb corrupted: parent bytenr=18344243445760 item=4 parent 
level=1 child bytenr=18344246345728 child level=2
[2/7] checking extents                         (0:00:00 elapsed)
ERROR: errors found in extent allocation tree or chunk allocation
parent transid verify failed on 18344238039040 wanted 4416296 found 4416299
Ignoring transid failure
ERROR: child eb corrupted: parent bytenr=18344237924352 item=1 parent 
level=2 child bytenr=18344238039040 child level=0
[3/7] checking free space cache                (0:00:00 elapsed)
parent transid verify failed on 18344241594368 wanted 4416296 found 
4416300ecked)
parent transid verify failed on 18344241594368 wanted 4416296 found 4416300
parent transid verify failed on 18344241594368 wanted 4416296 found 4416300
Ignoring transid failure
root 5 root dir 256 not found
parent transid verify failed on 18344253374464 wanted 4416296 found 4416300
Ignoring transid failure
ERROR: free space cache inode 958233742 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958233743 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958233744 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958233745 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958233746 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958233747 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958233748 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958233749 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958233750 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958233751 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958233752 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958233753 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958233754 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958233755 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958233756 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958233757 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958233758 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958233759 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958233760 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958233761 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958233762 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958233763 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958233764 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958233765 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958233766 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958233767 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958233768 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958233769 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958233770 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958233771 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958233772 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958233773 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958233774 has invalid mode: has 0100644 
expect 0100600
parent transid verify failed on 18344264335360 wanted 4416296 found 4416301
Ignoring transid failure
ERROR: free space cache inode 958232811 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958232812 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958232813 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958232814 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958232815 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958232816 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958232817 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958232818 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958232819 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958232820 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958232821 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958232822 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958232823 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958232824 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958232825 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958232826 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958232827 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958232828 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958232829 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958232830 has invalid mode: has 0100644 
expect 0100600
parent transid verify failed on 18344243511296 wanted 4416296 found 4416301
Ignoring transid failure
ERROR: free space cache inode 958231543 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958231544 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958231545 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958231546 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958231547 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958231548 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958231549 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958231550 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958231551 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958231552 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958231553 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958231554 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958231555 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958231556 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958231557 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958231558 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958231559 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958231560 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958231561 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958231562 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958231563 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958231564 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958231565 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958231566 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958231567 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958231568 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958231569 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958231570 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958231571 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958231572 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958231573 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958231574 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958231575 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958231576 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958231577 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958231578 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958231579 has invalid mode: has 0100644 
expect 0100600
ERROR: free space cache inode 958231580 has invalid mode: has 0100644 
expect 0100600
parent transid verify failed on 18344246345728 wanted 4416296 found 4416301
Ignoring transid failure
ERROR: child eb corrupted: parent bytenr=18344243445760 item=4 parent 
level=1 child bytenr=18344246345728 child level=2
[4/7] checking fs roots                        (0:00:00 elapsed, 1 items 
checked)
ERROR: errors found in fs roots
found 0 bytes used, error(s) found
total csum bytes: 0
total tree bytes: 0
total fs tree bytes: 0
total extent tree bytes: 0
btree space waste bytes: 0
file data blocks allocated: 0
  referenced 0

------------------------------------------------------------------------------------------------------------------------------

I then ran a btrfs check again whilst not mounted and I won't put the 
output here since the file is 1.5GB and full of things like:
root 5 inode 437187144 errors 2000, link count wrong
         unresolved ref dir 942513356 index 9 namelen 14 name 
_tokenizer.pyc filetype 1 errors 0
         unresolved ref dir 945696631 index 9 namelen 14 name 
_tokenizer.pyc filetype 1 errors 0
         unresolved ref dir 948998753 index 9 namelen 14 name 
_tokenizer.pyc filetype 0 errors 3, no dir item, no dir index
         unresolved ref dir 952510365 index 9 namelen 14 name 
_tokenizer.pyc filetype 0 errors 3, no dir item, no dir index
         unresolved ref dir 954421030 index 9 namelen 14 name 
_tokenizer.pyc filetype 0 errors 3, no dir item, no dir index

and

root 5 inode 957948416 errors 2001, no inode item, link count wrong
         unresolved ref dir 690084 index 17960 namelen 19 name 
20240222_084117.jpg filetype 1 errors 4, no inode ref
root 5 inode 957957996 errors 2001, no inode item, link count wrong
         unresolved ref dir 890819470 index 4463 namelen 8 name hourly.3 
filetype 2 errors 4, no inode ref

and ends like:

[4/7] checking fs roots                        (0:00:58 elapsed, 415857 
items checked)
ERROR: errors found in fs roots
found 4967823106048 bytes used, error(s) found
total csum bytes: 4834452504
total tree bytes: 17343725568
total fs tree bytes: 10449027072
total extent tree bytes: 1109393408
btree space waste bytes: 3064698357
file data blocks allocated: 5472482066432
  referenced 5313641955328


------------------------------------------------------------------------------------------------------------------------------

I have tried to see if I can find out which files are impacted by doing eg

btrfs inspect-internal logical-resolve 18344253374464 /export/shared

using a what I think is a logical block number from the scrub or btrfs 
check, but these always give an error like:

ERROR: logical ino ioctl: No such file or directory

------------------------------------------------------------------------------------------------------------------------------

after mounting it again, subsequent checks while mounted look like the 
first one

I have also run

btrfs rescue clear-uuid-tree /dev/sdg
btrfs rescue clear-space-cache v1 /dev/sdg
btrfs rescue clear-space-cache v2 /dev/sdg


I am currently running another scrub so I will see what that looks like 
in a few hours


------------------------------------------------------------------------------------------------------------------------------

Other Generic Info:

uname -a
Linux gw.home.arpa 6.5.7-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Oct 
11 04:07:58 UTC 2023 x86_64 GNU/Linux

btrfs --version
btrfs-progs v6.6.2

btrfs fi show
Label: 'SHARED'  uuid: 021756e1-c9b4-41e7-bfd3-bc4e930eae46
         Total devices 4 FS bytes used 4.52TiB
         devid    1 size 2.73TiB used 2.55TiB path /dev/sdg
         devid    2 size 2.73TiB used 2.56TiB path /dev/sdf
         devid    3 size 2.73TiB used 2.55TiB path /dev/sdb
         devid    4 size 2.73TiB used 2.56TiB path /dev/sdc

btrfs fi df /export/shared
Data, RAID1: total=5.09TiB, used=4.50TiB
System, RAID1: total=64.00MiB, used=768.00KiB
Metadata, RAID1: total=24.00GiB, used=16.14GiB
GlobalReserve, single: total=512.00MiB, used=0.00B


