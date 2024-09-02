Return-Path: <linux-btrfs+bounces-7717-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B687967EC7
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 07:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC2421F21E5C
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 05:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B836814F100;
	Mon,  2 Sep 2024 05:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=wiesinger.com header.i=@wiesinger.com header.b="vzuVUn2j"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from vps01.wiesinger.com (vps01.wiesinger.com [46.36.37.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EDB179AA
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Sep 2024 05:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.36.37.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725254924; cv=none; b=nwtuJwfqL7f37+Tg9qJ5toSO4j+n3+CjfheDHW51GxPnlo2wJPheHb693AUmbrZHLHySMaf0o0Lv9tDjv7f5iG62G2swJ25JRlPExxnrbs3hgSz2cRkvilyar9eHPxuN71UZ6GklSlQvCmZFl8zxJ7gT9xQ2mlFNEEqPmgK86RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725254924; c=relaxed/simple;
	bh=YRBDg4/3l7TMEB4jMb6nk+GeLPJt51unNElldmA019Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QdwpMnJYvpyUET8q8UHllD8RKvDM3TBLi4IT/iZ53ipf5h9KrDw+pXZhokMOGZC6wQQmqiIpQJ+o7YTiQAfBrt4Utm9zqXrwBNJo3fQgTLgB+9HXmNpS40mQUBt/79ySWVVIe3dZ99ry6KQOMWMMDbgKDrf3AA1DBM8aeUhJPjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wiesinger.com; spf=pass smtp.mailfrom=wiesinger.com; dkim=pass (4096-bit key) header.d=wiesinger.com header.i=@wiesinger.com header.b=vzuVUn2j; arc=none smtp.client-ip=46.36.37.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wiesinger.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiesinger.com
Received: from wiesinger.com (wiesinger.com [84.112.177.114])
	by vps01.wiesinger.com (Postfix) with ESMTPS id EDE9D9F262;
	Mon,  2 Sep 2024 07:28:39 +0200 (CEST)
Received: from [192.168.0.63] ([192.168.0.63])
	(authenticated bits=0)
	by wiesinger.com (8.18.1/8.18.1) with ESMTPSA id 4825Sd0P1181841
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 2 Sep 2024 07:28:39 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 wiesinger.com 4825Sd0P1181841
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiesinger.com;
	s=default; t=1725254919;
	bh=FuAlY07O80VbbHu4dxe2wcRGowLQAE5kPHHjzF/GVKs=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=vzuVUn2jwmC+ELuKVKhfFEJpoFvds8RVbQ/LZxN0JU5gUmK5T4j67oOptCwfVtA2O
	 cYQY9fqmI48IqyT7PZfFrMgE74e3qILqhiu5JrMUqxBqhnncgaAxQ4wdCOp5gziOGy
	 N1ehpKGOSfBkwn0OqA64y/qC3g4VxjD95XSF4EWiORye/L2Q87xZczBV05epPDuvI9
	 D0Xm7fy0T1lLDLacuPpd43Ez++mtK04Ztohckh4gpmr/gYBVV3g/5fAvuGB/NJ7et0
	 4MInyq2iwgC5gmzhsZ1aDuTfk1Rvlzb792xb/dvYNZGpUgHd6BCvJiBAaroPdLnkbY
	 ZRM3IRctPtCmhNXQcrbRB92zD1qX3lTidS9QYBT4A0DIBUKDxoanWXkp2Sm0dqsB4v
	 eLZKDe1uFdhqf1Tueqc1vApiDD6gytdxX2T/OQCfPDv/0Yu+IEpN+EFhRDK0IexjMh
	 ASyCsE7FA74t+RUNaK4WeBd1FTlX2JGyIddb8QpunLqUyyCg7JDS+AMFtxApqlSfii
	 B4t6ssojiSw/oKWs8+78YjTrENtMZCdr44XRMTUCe5/hCoajZWfFUaSDZ9Drzoe8ey
	 EUA1xBOiWXWOO0EEO3wAoh7+G0RVoWJkPUVaSwnyPzEKRHPlpydZxnb4kh2MzxmNKi
	 5WCeouSfg6YYd/J0UKHexv1Q=
Message-ID: <ce3a4dbc-4e81-4b05-b9e5-c92eec9b5d80@wiesinger.com>
Date: Mon, 2 Sep 2024 07:28:38 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: Corrupt BTRFS can't be get into a consistent state
Content-Language: en-US
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <63f8866f-ceda-4228-b595-e37b016e7b1f@wiesinger.com>
 <c06d4a06-589a-428d-a50f-93e29254976e@gmx.com>
From: Gerhard Wiesinger <lists@wiesinger.com>
In-Reply-To: <c06d4a06-589a-428d-a50f-93e29254976e@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02.09.2024 00:13, Qu Wenruo wrote:
>
>
> 在 2024/9/1 21:13, Gerhard Wiesinger 写道:
>> Hello,
>>
>> I'm having some Fedora Linux VMs (actual versions, latest updates) in a
>> virtual test infrastructure on Virtualbox. There I run different VMs
>> with different filesystems (ext4, xfs, zfs, bcachefs and btrfs).
>>
>> I had a hardware problem on the underlying hardware where around 1000 4k
>> blocks could not be read anymore. I migrated with ddrescure the whole
>> disk which worked well.
>>
>> Of course I was expecting some data loss in the VMs but wanted to get
>> them in a consistent state.
>>
>> The following file systems got very easy in a consistent state with the
>> corresponding repair/scrub tools of the filesystems:
>> - ext4
>> - xfs
>> - zfs
>>
>> Unfortunately 2 filesystem can't get into a state, where the filesystem
>> repair tools report "everything fine" (of course with some loss data,
>> but that's fine):
>> - btrfs
>> - bcachefs
>>
>> btrfs --version
>> btrfs-progs v6.10.1
>> -EXPERIMENTAL -INJECT -STATIC +LZO +ZSTD +UDEV +FSVERITY +ZONED
>> CRYPTO=libgcrypt
>>
>> commands run with btrfs:
>> btrfs check device
>
> This is readonly operation, just to tell you what's going wrong.
>
>> btrfs check --init-csum-tree device
>> btrfs check --init-extent-tree device
>
> These two are dangerous operations.
>
> And why you didn't try "btrfs scrub"?

Forgot to mention, started with this one.

>
>>
>> But btrfs never got into a consistent state, also with newer versions
>> (have copies of original virtual disk, around 6 month ago). Also btrfs
>> check runs for hours for around 4GB of data.
>>
>> To reproduce the problem I created a new filesystem and copied some
>> files there:
>> # Copy around 4GB
>> time cp -Rap /usr /mnt
>>
>> Afterwards I created a (quick&dirty) script "corrupt_device.sh" to
>> corrupt the device in the same manner as the original failure (1000 4k
>> blocks will be randomly overwritten).
>> Script: see below
>>
>> Result: It can be reproduced, that btrfs can't be brought into a
>> consistent state even after several runs of the repair.
>> If the filesystem is modified in between (e.g. some further files are
>> written) it gets even worser.
>>
>> You can also try to reproduce it and create a testcase out of it.
>
> I created a 10GiB fs, filled with around 3.7G data using fsstress, run
> your script.
>
> And the result is the opposite as yours:
>
> Opening filesystem to check...
> Checking filesystem on /dev/test/scratch1
> UUID: c2be653b-6b00-4ed9-925f-258cc7ca5391
> [1/7] checking root items
> checksum verify failed on 37896192 wanted 0x1e3b3b76 found 0xf6ba3f0c
> [2/7] checking extents
> checksum verify failed on 276135936 wanted 0x142c0f06 found 0xdcc4a8df
> checksum verify failed on 66502656 wanted 0x6fff8502 found 0x333397eb
> checksum verify failed on 107397120 wanted 0x52894737 found 0x56e3558b
> checksum verify failed on 235864064 wanted 0x3a0b6ded found 0xe11cbb02
> checksum verify failed on 72384512 wanted 0x9306ee79 found 0x62a123d8
> checksum verify failed on 264683520 wanted 0x2cebc20f found 0x293c9426
> checksum verify failed on 196001792 wanted 0xe3ec9b3f found 0x29d32fce
> [3/7] checking free space tree
> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 3776757760 bytes used, no error found <<<
> total csum bytes: 1692008
> total tree bytes: 82444288
> total fs tree bytes: 71237632
> total extent tree bytes: 6455296
> btree space waste bytes: 43820357
> file data blocks allocated: 29158084608
>  referenced 4905811968
>
> Btrfs properly detects the corruption in metadata, but since the default
> profile is DUP, it's totally fine and can go with the other mirror.
>
> And sure since your data is still SINGLE thus you will lose some data,
> but your metadata is totally fine.
>
> With proper btrfs scrub run:
>
> scrub done for c2be653b-6b00-4ed9-925f-258cc7ca5391
> Scrub started:    Mon Sep  2 06:08:23 2024
> Status:           finished
> Duration:         0:00:03
> Total to scrub:   3.61GiB
> Rate:             1.20GiB/s
> Error summary:    verify=36 csum=169
>   Corrected:      60
>   Uncorrectable:  145
>   Unverified:     0
>
> So it means 60 metadata csum mismatch is fixed, only 145 bad data 
> sectors.

How to get rid of the 145 uncorrectables?

>
> And after the above scrub, btrfs check reports no more error (at least
> for metadata):
>
> Opening filesystem to check...
> Checking filesystem on /dev/test/scratch1
> UUID: c2be653b-6b00-4ed9-925f-258cc7ca5391
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space tree
> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 3776757760 bytes used, no error found
> total csum bytes: 1692008
> total tree bytes: 82444288
> total fs tree bytes: 71237632
> total extent tree bytes: 6455296
> btree space waste bytes: 43819992
> file data blocks allocated: 29158084608
>  referenced 4905811968
>
>>
>> Any ideas how to repair and what can be done to get it into a consistent
>> state?
>
> Please give the original "btrfs check" output.
>
> I think your original fs is either using SINGLE metadata profile (then
> very hard to do repair), AND you're using incorrect way to repair (scrub
> first, then btrfs check to verify, never --init-extent-tree nor
> --init-csum-tree unless you know what you're really doing).

I originally did scrub first (forget to mention, but there were still 
uncorrectable errors as with my test script)

Original ones: DUP Metadata, so repair should work fine regarding 
metadata (I have also an original copy of the virtual disk image so I 
can play around).

btrfs inspect-internal list-chunks /mnt
Devid PNumber      Type/profile   PStart    Length     PEnd LNumber   
LStart Usage%
----- ------- ----------------- -------- --------- -------- ------- 
-------- ------
     1       1       Data/single 12.00MiB   8.00MiB 20.00MiB 1 12.00MiB  
99.76
     1       2   Metadata/DUP    36.00MiB   1.00GiB  1.04GiB 2 28.00MiB  
14.74
     1       3   Metadata/DUP     1.04GiB   1.00GiB  2.04GiB 3 28.00MiB  
14.74
     1       4       Data/single  2.04GiB   1.00GiB  3.04GiB 4  1.03GiB  
93.51
     1       5       Data/single  3.04GiB   1.00GiB  4.04GiB 5  2.03GiB  
49.37
     1       6     System/DUP     4.10GiB  32.00MiB  4.13GiB 15 
15.18GiB   0.05
     1       7     System/DUP     4.13GiB  32.00MiB  4.16GiB 16 
15.18GiB   0.05
     1       8       Data/single  4.60GiB   1.00GiB  5.60GiB 6  6.56GiB  
37.75
     1       9   Metadata/DUP     5.60GiB 128.00MiB  5.72GiB 7  
7.71GiB   9.55
     1      10   Metadata/DUP     5.72GiB 128.00MiB  5.85GiB 8  
7.71GiB   9.55
     1      11       Data/single  5.85GiB   1.00GiB  6.85GiB 9  8.12GiB  
11.79
     1      12       Data/single  6.85GiB   1.00GiB  7.85GiB 10  
9.12GiB  16.43
     1      13       Data/single  7.85GiB   1.00GiB  8.85GiB 11 
10.12GiB  69.76
     1      14       Data/single  8.85GiB   1.00GiB  9.85GiB 12 
11.15GiB  80.00
     1      15       Data/single  9.85GiB   1.00GiB 10.85GiB 13 
12.15GiB  45.58
     1      16       Data/single 11.85GiB   1.00GiB 12.85GiB 14 
14.18GiB  67.44
     1      17       Data/single 12.85GiB   1.00GiB 13.85GiB 17 
15.21GiB  35.54

(BTW: Any other way to find this out?)


>
> And your random corruption script is the best case scenario for btrfs,
> it's pretty easy for btrfs just to use the good mirror to repair
> metadata, without any need to extra repair inside metadata. 

# Syntethic test case:

# Destroyed with script after btrfs scrub start /mnt
[root@localhost ~]# btrfs scrub status /mnt
UUID:             717cee50-d376-4c5a-941d-3dac986256fd
Scrub started:    Mon Sep  2 07:11:30 2024
Status:           finished
Duration:         0:00:25
Total to scrub:   3.73GiB
Rate:             152.74MiB/s
Error summary:    verify=8 csum=182
   Corrected:      12
   Uncorrectable:  178
   Unverified:     0

# After finishing
btrfs scrub status /mnt
UUID:             717cee50-d376-4c5a-941d-3dac986256fd
Scrub started:    Mon Sep  2 07:12:39 2024
Status:           finished
Duration:         0:00:26
Total to scrub:   3.73GiB
Rate:             146.87MiB/s
Error summary:    csum=178
   Corrected:      0
   Uncorrectable:  178
   Unverified:     0

=> so there are still uncorrectables, why can't they be fixed with 
scrub? (Expectation: "Clean filesystem afterwards, maybe some data lost 
due to overwritten parts")

# Original disk (after running a lot of scrub/repair commands):

btrfs check /dev/mapper/fedora--defect-root--defect

[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
Missing extent item in extent tree for disk_bytenr 1402974208, num_bytes 
1847296
Missing extent item in extent tree for disk_bytenr 1423011840, num_bytes 
598016
Missing extent item in extent tree for disk_bytenr 1457127424, num_bytes 
6164480
Missing extent item in extent tree for disk_bytenr 1484931072, num_bytes 
7127040
Missing extent item in extent tree for disk_bytenr 2022019072, num_bytes 
1773568
Missing extent item in extent tree for disk_bytenr 2635603968, num_bytes 
5255168
Missing extent item in extent tree for disk_bytenr 2817658880, num_bytes 
8073216
Missing extent item in extent tree for disk_bytenr 2935803904, num_bytes 
3244032
Missing extent item in extent tree for disk_bytenr 2605039616, num_bytes 
8355840
Missing extent item in extent tree for disk_bytenr 2745331712, num_bytes 
3706880
Missing extent item in extent tree for disk_bytenr 3018563584, num_bytes 
3121152
Missing extent item in extent tree for disk_bytenr 2947518464, num_bytes 
8302592
Missing extent item in extent tree for disk_bytenr 3068272640, num_bytes 
2781184
Missing extent item in extent tree for disk_bytenr 2791301120, num_bytes 
3547136
Missing extent item in extent tree for disk_bytenr 7574302720, num_bytes 
3350528
Missing extent item in extent tree for disk_bytenr 3031347200, num_bytes 
1216512
root 5 inode 72933 errors 840, bad file extent, odd csum item
root 5 inode 90368 errors 840, bad file extent, odd csum item
root 5 inode 166783 errors 840, bad file extent, odd csum item
root 5 inode 219687 errors 840, bad file extent, odd csum item
root 5 inode 248131 errors 840, bad file extent, odd csum item
root 5 inode 346844 errors 840, bad file extent, odd csum item
root 5 inode 379257 errors 840, bad file extent, odd csum item
root 5 inode 464039 errors 840, bad file extent, odd csum item
root 5 inode 464044 errors 840, bad file extent, odd csum item
root 5 inode 471393 errors 840, bad file extent, odd csum item
root 5 inode 681858 errors 840, bad file extent, odd csum item
root 5 inode 833692 errors 840, bad file extent, odd csum item
root 5 inode 909657 errors 840, bad file extent, odd csum item
root 5 inode 910009 errors 840, bad file extent, odd csum item
root 5 inode 1032866 errors 840, bad file extent, odd csum item

root 5 inode 1153395 errors 2001, no inode item, link count wrong
         unresolved ref dir 53460 index 0 namelen 75 name 
7ae2e1b7acb59ea0b30163c03de1cf3884abdc3f-kernel-core-4.19.6-200.fc28-x86_64 
filetype 2 errors 6, no dir index, no inode ref
root 5 inode 1153401 errors 2001, no inode item, link count wrong
         unresolved ref dir 53460 index 0 namelen 70 name 
2ed0519ee6bab67f5e5d5d6ce4650e541fbb359f-kernel-4.19.6-200.fc28-x86_64 
filetype 2 errors 6, no dir index, no inode ref
root 5 inode 1153403 errors 2001, no inode item, link count wrong
         unresolved ref dir 53460 index 0 namelen 76 name 
f2caebbe5620078065d21c37e4a88e8f5957215b-kernel-devel-4.19.6-200.fc28-x86_64 
filetype 2 errors 6, no dir index, no inode ref
root 5 inode 1153405 errors 2001, no inode item, link count wrong
         unresolved ref dir 53460 index 0 namelen 78 name 
2ad09f77ebb3882396b40dfa44f2840cccf4cf9d-kernel-modules-4.19.6-200.fc28-x86_64 
filetype 2 errors 6, no dir index, no inode ref
root 5 inode 1159931 errors 2001, no inode item, link count wrong
         unresolved ref dir 271 index 0 namelen 15 name fc29-update.log 
filetype 1 errors 6, no dir index, no inode ref
root 5 inode 1159933 errors 2001, no inode item, link count wrong
         unresolved ref dir 53026 index 0 namelen 31 name 
fedora-modular-ce4dd907f26812da filetype 2 errors 6, no dir index, no 
inode ref

<skipped a lot here>

ERROR: errors found in fs roots
Opening filesystem to check...
Checking filesystem on /dev/mapper/fedora--defect-root--defect
UUID: 7bb1e7be-c83c-4cbb-a396-14c38393977c
found 5625135104 bytes used, error(s) found
total csum bytes: 4979288
total tree bytes: 171147264
total fs tree bytes: 154255360
total extent tree bytes: 10895360
btree space waste bytes: 36824455
file data blocks allocated: 11575373824
  referenced 5772767232

Can test on the original disk in the evening.

Thnx.

Ciao,

Gerhard


