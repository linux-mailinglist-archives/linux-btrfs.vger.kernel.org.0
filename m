Return-Path: <linux-btrfs+bounces-2699-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8295E8621E4
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Feb 2024 02:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13C681F28EF4
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Feb 2024 01:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FCA4688;
	Sat, 24 Feb 2024 01:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=edcint.co.nz header.i=@edcint.co.nz header.b="aa1YHBde"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from h1.out4.mxs.au (h1.out4.mxs.au [110.232.143.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A038017C9
	for <linux-btrfs@vger.kernel.org>; Sat, 24 Feb 2024 01:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=110.232.143.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708737860; cv=none; b=qaZLHq9tAUP+xLGz62K5jYSPSvH8jQlFsjfAC9j29MjrR3ym7w56ZKQUlMywELb+I01g80j6gK5ZsZvlofPr/FtB4kHTrSQQ95UfKrv1hlZsG/Cf9p27rih/3G20ltxRgDkPWcFPEuVNcaS+QVNA5MHjC2H9tgbk5BzNl9OXH6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708737860; c=relaxed/simple;
	bh=mHyiIdzDz8ei8iupUiUx8uofwZ4qhNtvysFL3pJh2sU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=u2yYegN0sgYv1mb1mVZTAT6LpMuw+g7Wx5sMd66BmKiamWYsTU+GrbxTDbmQuvluMceeHk9Um+7UAgi2/cWBqbpMlSxX+O3Kbc0Zm8kTdfN9bcFdDsGzxhawMSJ9GsJS59lmYRZYURM4649xIfBO2s0byPhbkGwNKOI6arCumK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edcint.co.nz; spf=fail smtp.mailfrom=edcint.co.nz; dkim=pass (2048-bit key) header.d=edcint.co.nz header.i=@edcint.co.nz header.b=aa1YHBde; arc=none smtp.client-ip=110.232.143.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edcint.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=edcint.co.nz
Received: from s02bd.syd2.hostingplatform.net.au (s02bd.syd2.hostingplatform.net.au [103.27.32.42])
	by out4.mxs.au (Halon) with ESMTPS (TLSv1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	id 3f8fc457-d2b3-11ee-8d83-00163c87da3f
	for <linux-btrfs@vger.kernel.org>;
	Sat, 24 Feb 2024 12:23:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=edcint.co.nz; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7HpLWsjCTEe/dM62k6VtAsURvTRoxsuc+Xz2/NKiGYc=; b=aa1YHBdePjd3AMSgjVj7Jw6TVY
	gmiLn7ZMWrfL3RwLYkHXXIrmU3RLIM50YSeRT1H/2H7+SNOgkbcE7KAbz/l/7B6Dn4xDQHDtKNV/W
	vpi2bUGaRAJDthvU4WR5vQ+vGwEBibcWnDzdahUQXDzKF70lSRNcHh2wnXVNMokQML+Wi84g/pZ5O
	DGzOIcqZYhNH0ArsfMcZoQs7Wpwq0ctgwobfix+XWVGT9MJgkWQOuN+20NuMkQD/s5XdnaC1/3uaR
	mKcGmCZMoWFOwGSA26mNRXQT/n1GB9hh0Or259H4cKkPIMxXRHA11VLZLTafCQQ1KRfPBhdef+N9+
	c4zTEDZA==;
Received: from [159.196.20.165] (port=23159 helo=[192.168.2.80])
	by s02bd.syd2.hostingplatform.net.au with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <default@edcint.co.nz>)
	id 1rdgkm-002JFs-0N;
	Sat, 24 Feb 2024 12:23:00 +1100
Message-ID: <0dd56988-e191-45c7-a3d7-60f43fc4b7fd@edcint.co.nz>
Date: Sat, 24 Feb 2024 12:22:59 +1100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to repair BTRFS
To: Qu Wenruo <wqu@suse.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
 linux-btrfs@vger.kernel.org
References: <cb434383-5dfb-4748-8039-1496e09a2a80@edcint.co.nz>
 <e18d4a17-12ed-438a-bceb-b1a2e10d15d4@gmx.com>
 <be5917ba-4940-4800-9fbf-c1a24f4d82be@edcint.co.nz>
 <7382a5c8-726f-41b3-9cbf-b2c67f0a5419@suse.com>
Content-Language: en-US
From: Matthew Jurgens <default@edcint.co.nz>
In-Reply-To: <7382a5c8-726f-41b3-9cbf-b2c67f0a5419@suse.com>
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

As I understand rescue=all, I don't need it for allowing me to mount 
(since I can already mount the file system) but it will allow me to copy 
damaged files out of the file system. However, I don't know what is 
damaged. I do have backups.

Commands like  btrfs inspect-internal logical-resolve 20647087898624  
/export/shared

just return
ERROR: logical ino ioctl: No such file or directory

On 24/02/2024 9:12 am, Qu Wenruo wrote:
>
>
> 在 2024/2/24 08:11, Matthew Jurgens 写道:
>>
>> On 24/02/2024 6:55 am, Qu Wenruo wrote:
>>>
>>>
>>> 在 2024/2/23 21:39, Matthew Jurgens 写道:
>>>> If I can't run --repair, then how do I repair my file system?
>>>>
>>>> I ran a scrub which reported 8 errors that could not be fixed.
>>>
>>> The scrub report and corresponding dmesg please.
>>>
>> The latest scrub report is
>>
>> UUID:             021756e1-c9b4-41e7-bfd3-bc4e930eae46
>> Scrub started:    Fri Feb 23 21:42:13 2024
>> Status:           finished
>> Duration:         5:52:50
>> Total to scrub:   9.00TiB
>> Rate:             447.36MiB/s
>> Error summary:    verify=8
>>    Corrected:      0
>>    Uncorrectable:  8
>>    Unverified:     0
>>
>>
>> Probably the most relevant dmesg lines:
> [...]
>> [10226.535987] BTRFS warning (device sdg): tree block 20647087931392 
>> mirror 2 has bad csum, has 0x97fa472a want 0xccdf090b
>> [10226.615321] BTRFS warning (device sdg): tree block 20647087931392 
>> mirror 2 has bad csum, has 0x97fa472a want 0xccdf090b
>> [10226.615524] BTRFS warning (device sdg): tree block 20647087931392 
>> mirror 2 has bad csum, has 0x97fa472a want 0xccdf090b
>> [10226.615731] BTRFS warning (device sdg): tree block 20647087931392 
>> mirror 2 has bad csum, has 0x97fa472a want 0xccdf090b
>
> This is not good, this means both tree block copies are having csum 
> mismatch.
>
> Since both metadata copies are corrupted, it's not some on-disk data 
> corruption, but more likely some runtime corruption leads to bad csum 
> (like runtime memory corruption).
>
> Since the unmounted fsck still gave tons of error on fs tree, I'd say 
> at least some of the corrupted tree blocks are in subvolume trees.
> (aka, affecting data salvage)
>
> The first thing I'd recommend is to do a full memory tests (if it's 
> not ECC memory), to make sure the hardware is not the cause. Or it 
> would just show up again no matter whatever filesystem you're using in 
> the next try.
>
> Anyway, since the fs is really corrupted, data salvage is recommended 
> before doing any writes into the fs.
> You can salvage the data by "-o ro,rescue=all" mount option.
>
> I won't recommend any further rescue/writes until you have verified 
> the hardware memory and rescued whatever you need.
>
> Thanks,
> Qu
>
>> [10226.615733] BTRFS error (device sdg): unable to fixup (regular) 
>> error at logical 20647087898624 on dev /dev/sdb physical 1597612949504
>> [10226.615741] BTRFS error (device sdg): unable to fixup (regular) 
>> error at logical 20647087898624 on dev /dev/sdb physical 1597612949504
>> [10226.615742] BTRFS error (device sdg): unable to fixup (regular) 
>> error at logical 20647087898624 on dev /dev/sdb physical 1597612949504
>> [10226.615744] BTRFS error (device sdg): unable to fixup (regular) 
>> error at logical 20647087898624 on dev /dev/sdb physical 1597612949504
>> [10871.525097] BTRFS warning (device sdg): tree block 20647087931392 
>> mirror 1 has bad csum, has 0x97fa472a want 0xccdf090b
>> [10871.538286] BTRFS warning (device sdg): tree block 20647087931392 
>> mirror 1 has bad csum, has 0x97fa472a want 0xccdf090b
>> [10871.546525] BTRFS warning (device sdg): tree block 20647087931392 
>> mirror 1 has bad csum, has 0x97fa472a want 0xccdf090b
>> [10871.551011] BTRFS warning (device sdg): tree block 20647087931392 
>> mirror 1 has bad csum, has 0x97fa472a want 0xccdf090b
>> [10871.551033] BTRFS error (device sdg): unable to fixup (regular) 
>> error at logical 20647087898624 on dev /dev/sdg physical 1600879263744
>> [10871.551055] BTRFS error (device sdg): unable to fixup (regular) 
>> error at logical 20647087898624 on dev /dev/sdg physical 1600879263744
>> [10871.551063] BTRFS error (device sdg): unable to fixup (regular) 
>> error at logical 20647087898624 on dev /dev/sdg physical 1600879263744
>> [10871.551069] BTRFS error (device sdg): unable to fixup (regular) 
>> error at logical 20647087898624 on dev /dev/sdg physical 1600879263744
>> [12097.231261] btrfs_validate_extent_buffer: 12 callbacks suppressed
>> [12097.231264] BTRFS warning (device sdg): checksum verify failed on 
>> logical 20647087931392 mirror 2 wanted 0x97fa472a found 0xccdf090b 
>> level 0
>> [12097.257496] BTRFS warning (device sdg): checksum verify failed on 
>> logical 20647087931392 mirror 1 wanted 0x97fa472a found 0xccdf090b 
>> level 0
>> [12097.399518] BTRFS warning (device sdg): checksum verify failed on 
>> logical 20647087931392 mirror 2 wanted 0x97fa472a found 0xccdf090b 
>> level 0
>> [12097.437847] BTRFS warning (device sdg): checksum verify failed on 
>> logical 20647087931392 mirror 1 wanted 0x97fa472a found 0xccdf090b 
>> level 0
>> [12097.456673] BTRFS warning (device sdg): checksum verify failed on 
>> logical 20647087931392 mirror 2 wanted 0x97fa472a found 0xccdf090b 
>> level 0
>> [12097.507496] BTRFS warning (device sdg): checksum verify failed on 
>> logical 20647087931392 mirror 1 wanted 0x97fa472a found 0xccdf090b 
>> level 0
>> [12097.539579] BTRFS warning (device sdg): checksum verify failed on 
>> logical 20647087931392 mirror 2 wanted 0x97fa472a found 0xccdf090b 
>> level 0
>> [12097.562906] BTRFS warning (device sdg): checksum verify failed on 
>> logical 20647087931392 mirror 1 wanted 0x97fa472a found 0xccdf090b 
>> level 0
>> [12097.610849] BTRFS warning (device sdg): checksum verify failed on 
>> logical 20647087931392 mirror 2 wanted 0x97fa472a found 0xccdf090b 
>> level 0
>> [12097.616316] BTRFS warning (device sdg): checksum verify failed on 
>> logical 20647087931392 mirror 1 wanted 0x97fa472a found 0xccdf090b 
>> level 0
>> [12817.886430] btrfs_validate_extent_buffer: 12 callbacks suppressed
>> [12817.886437] BTRFS warning (device sdg): checksum verify failed on 
>> logical 20647087931392 mirror 2 wanted 0x97fa472a found 0xccdf090b 
>> level 0
>> [12817.911375] BTRFS warning (device sdg): checksum verify failed on 
>> logical 20647087931392 mirror 1 wanted 0x97fa472a found 0xccdf090b 
>> level 0
>> [12818.002768] BTRFS warning (device sdg): checksum verify failed on 
>> logical 20647087931392 mirror 2 wanted 0x97fa472a found 0xccdf090b 
>> level 0
>> [12818.031952] BTRFS warning (device sdg): checksum verify failed on 
>> logical 20647087931392 mirror 1 wanted 0x97fa472a found 0xccdf090b 
>> level 0
>> [12818.066655] BTRFS warning (device sdg): checksum verify failed on 
>> logical 20647087931392 mirror 2 wanted 0x97fa472a found 0xccdf090b 
>> level 0
>> [12818.108668] BTRFS warning (device sdg): checksum verify failed on 
>> logical 20647087931392 mirror 1 wanted 0x97fa472a found 0xccdf090b 
>> level 0
>> [12818.136420] BTRFS warning (device sdg): checksum verify failed on 
>> logical 20647087931392 mirror 2 wanted 0x97fa472a found 0xccdf090b 
>> level 0
>> [12818.169702] BTRFS warning (device sdg): checksum verify failed on 
>> logical 20647087931392 mirror 1 wanted 0x97fa472a found 0xccdf090b 
>> level 0
>> [12818.207071] BTRFS warning (device sdg): checksum verify failed on 
>> logical 20647087931392 mirror 2 wanted 0x97fa472a found 0xccdf090b 
>> level 0
>> [12818.235735] BTRFS warning (device sdg): checksum verify failed on 
>> logical 20647087931392 mirror 1 wanted 0x97fa472a found 0xccdf090b 
>> level 0
>> [20654.902312] BTRFS info (device sdg): scrub: finished on devid 3 
>> with status: 0
>> [20790.498498] BTRFS info (device sdg): scrub: finished on devid 4 
>> with status: 0
>> [21228.046956] BTRFS info (device sdg): scrub: finished on devid 1 
>> with status: 0
>> [21333.526634] BTRFS info (device sdg): scrub: finished on devid 2 
>> with status: 0
>>
>> The complete dmesg is at https://www.edcint.co.nz/tmp/dmesg_1.txt
>>
>>>>
>>>> ------------------------------------------------------------------------------------------------------------------------------ 
>>>>
>>>>
>>>> Then I ran a btrfs check while mounted which looks like:
>>>>
>>>> WARNING: filesystem mounted, continuing because of --force
>>>
>>> Do not run btrfs check --force on RW mounted fs.
>>>
>>> It's pretty common to hit false transid mismatch (which normally should
>>> be a death sentence to your fs) due to the IO.
>> Ok, thanks for the info
>>>
>>> Thanks,
>>> Qu
>>>> Opening filesystem to check...
>>>> Checking filesystem on /dev/sdg
>>>> UUID: 021756e1-c9b4-41e7-bfd3-bc4e930eae46
>>>> parent transid verify failed on 18344238039040 wanted 4416296 found
>>>> 4416299s checked)
>>>> parent transid verify failed on 18344238039040 wanted 4416296 found 
>>>> 4416299
>>>> parent transid verify failed on 18344238039040 wanted 4416296 found 
>>>> 4416299
>>>> Ignoring transid failure
>>>> ERROR: child eb corrupted: parent bytenr=18344237924352 item=1 parent
>>>> level=2 child bytenr=18344238039040 child level=0
>>>> [1/7] checking root items                      (0:00:06 elapsed, 69349
>>>> items checked)
>>>> ERROR: failed to repair root items: Input/output error
>>>> parent transid verify failed on 18344253374464 wanted 4416296 found 
>>>> 4416300
>>>> parent transid verify failed on 18344253374464 wanted 4416296 found 
>>>> 4416300
>>>> parent transid verify failed on 18344253374464 wanted 4416296 found 
>>>> 4416300
>>>> Ignoring transid failure
>>>> parent transid verify failed on 18344264335360 wanted 4416296 found 
>>>> 4416301
>>>> parent transid verify failed on 18344264335360 wanted 4416296 found 
>>>> 4416301
>>>> parent transid verify failed on 18344264335360 wanted 4416296 found 
>>>> 4416301
>>>> Ignoring transid failure
>>>> parent transid verify failed on 18344243511296 wanted 4416296 found 
>>>> 4416301
>>>> parent transid verify failed on 18344243511296 wanted 4416296 found 
>>>> 4416301
>>>> parent transid verify failed on 18344243511296 wanted 4416296 found 
>>>> 4416301
>>>> Ignoring transid failure
>>>> parent transid verify failed on 18344246345728 wanted 4416296 found 
>>>> 4416301
>>>> parent transid verify failed on 18344246345728 wanted 4416296 found 
>>>> 4416301
>>>> parent transid verify failed on 18344246345728 wanted 4416296 found 
>>>> 4416301
>>>> Ignoring transid failure
>>>> ERROR: child eb corrupted: parent bytenr=18344243445760 item=4 parent
>>>> level=1 child bytenr=18344246345728 child level=2
>>>> [2/7] checking extents                         (0:00:00 elapsed)
>>>> ERROR: errors found in extent allocation tree or chunk allocation
>>>> parent transid verify failed on 18344238039040 wanted 4416296 found 
>>>> 4416299
>>>> Ignoring transid failure
>>>> ERROR: child eb corrupted: parent bytenr=18344237924352 item=1 parent
>>>> level=2 child bytenr=18344238039040 child level=0
>>>> [3/7] checking free space cache                (0:00:00 elapsed)
>>>> parent transid verify failed on 18344241594368 wanted 4416296 found
>>>> 4416300ecked)
>>>> parent transid verify failed on 18344241594368 wanted 4416296 found 
>>>> 4416300
>>>> parent transid verify failed on 18344241594368 wanted 4416296 found 
>>>> 4416300
>>>> Ignoring transid failure
>>>> root 5 root dir 256 not found
>>>> parent transid verify failed on 18344253374464 wanted 4416296 found 
>>>> 4416300
>>>> Ignoring transid failure
>>>> ERROR: free space cache inode 958233742 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958233743 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958233744 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958233745 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958233746 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958233747 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958233748 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958233749 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958233750 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958233751 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958233752 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958233753 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958233754 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958233755 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958233756 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958233757 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958233758 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958233759 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958233760 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958233761 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958233762 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958233763 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958233764 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958233765 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958233766 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958233767 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958233768 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958233769 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958233770 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958233771 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958233772 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958233773 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958233774 has invalid mode: has 0100644
>>>> expect 0100600
>>>> parent transid verify failed on 18344264335360 wanted 4416296 found 
>>>> 4416301
>>>> Ignoring transid failure
>>>> ERROR: free space cache inode 958232811 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958232812 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958232813 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958232814 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958232815 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958232816 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958232817 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958232818 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958232819 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958232820 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958232821 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958232822 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958232823 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958232824 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958232825 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958232826 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958232827 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958232828 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958232829 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958232830 has invalid mode: has 0100644
>>>> expect 0100600
>>>> parent transid verify failed on 18344243511296 wanted 4416296 found 
>>>> 4416301
>>>> Ignoring transid failure
>>>> ERROR: free space cache inode 958231543 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958231544 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958231545 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958231546 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958231547 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958231548 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958231549 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958231550 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958231551 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958231552 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958231553 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958231554 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958231555 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958231556 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958231557 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958231558 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958231559 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958231560 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958231561 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958231562 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958231563 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958231564 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958231565 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958231566 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958231567 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958231568 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958231569 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958231570 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958231571 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958231572 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958231573 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958231574 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958231575 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958231576 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958231577 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958231578 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958231579 has invalid mode: has 0100644
>>>> expect 0100600
>>>> ERROR: free space cache inode 958231580 has invalid mode: has 0100644
>>>> expect 0100600
>>>> parent transid verify failed on 18344246345728 wanted 4416296 found 
>>>> 4416301
>>>> Ignoring transid failure
>>>> ERROR: child eb corrupted: parent bytenr=18344243445760 item=4 parent
>>>> level=1 child bytenr=18344246345728 child level=2
>>>> [4/7] checking fs roots                        (0:00:00 elapsed, 1 
>>>> items
>>>> checked)
>>>> ERROR: errors found in fs roots
>>>> found 0 bytes used, error(s) found
>>>> total csum bytes: 0
>>>> total tree bytes: 0
>>>> total fs tree bytes: 0
>>>> total extent tree bytes: 0
>>>> btree space waste bytes: 0
>>>> file data blocks allocated: 0
>>>>   referenced 0
>>>>
>>>> ------------------------------------------------------------------------------------------------------------------------------ 
>>>>
>>>>
>>>> I then ran a btrfs check again whilst not mounted and I won't put the
>>>> output here since the file is 1.5GB and full of things like:
>>>> root 5 inode 437187144 errors 2000, link count wrong
>>>>          unresolved ref dir 942513356 index 9 namelen 14 name
>>>> _tokenizer.pyc filetype 1 errors 0
>>>>          unresolved ref dir 945696631 index 9 namelen 14 name
>>>> _tokenizer.pyc filetype 1 errors 0
>>>>          unresolved ref dir 948998753 index 9 namelen 14 name
>>>> _tokenizer.pyc filetype 0 errors 3, no dir item, no dir index
>>>>          unresolved ref dir 952510365 index 9 namelen 14 name
>>>> _tokenizer.pyc filetype 0 errors 3, no dir item, no dir index
>>>>          unresolved ref dir 954421030 index 9 namelen 14 name
>>>> _tokenizer.pyc filetype 0 errors 3, no dir item, no dir index
>>>>
>>>> and
>>>>
>>>> root 5 inode 957948416 errors 2001, no inode item, link count wrong
>>>>          unresolved ref dir 690084 index 17960 namelen 19 name
>>>> 20240222_084117.jpg filetype 1 errors 4, no inode ref
>>>> root 5 inode 957957996 errors 2001, no inode item, link count wrong
>>>>          unresolved ref dir 890819470 index 4463 namelen 8 name 
>>>> hourly.3
>>>> filetype 2 errors 4, no inode ref
>>>>
>>>> and ends like:
>>>>
>>>> [4/7] checking fs roots                        (0:00:58 elapsed, 
>>>> 415857
>>>> items checked)
>>>> ERROR: errors found in fs roots
>>>> found 4967823106048 bytes used, error(s) found
>>>> total csum bytes: 4834452504
>>>> total tree bytes: 17343725568
>>>> total fs tree bytes: 10449027072
>>>> total extent tree bytes: 1109393408
>>>> btree space waste bytes: 3064698357
>>>> file data blocks allocated: 5472482066432
>>>>   referenced 5313641955328
>>>>
>>>>
>>>> ------------------------------------------------------------------------------------------------------------------------------ 
>>>>
>>>>
>>>> I have tried to see if I can find out which files are impacted by 
>>>> doing eg
>>>>
>>>> btrfs inspect-internal logical-resolve 18344253374464 /export/shared
>>>>
>>>> using a what I think is a logical block number from the scrub or btrfs
>>>> check, but these always give an error like:
>>>>
>>>> ERROR: logical ino ioctl: No such file or directory
>>>>
>>>> ------------------------------------------------------------------------------------------------------------------------------ 
>>>>
>>>>
>>>> after mounting it again, subsequent checks while mounted look like the
>>>> first one
>>>>
>>>> I have also run
>>>>
>>>> btrfs rescue clear-uuid-tree /dev/sdg
>>>> btrfs rescue clear-space-cache v1 /dev/sdg
>>>> btrfs rescue clear-space-cache v2 /dev/sdg
>>>>
>>>>
>>>> I am currently running another scrub so I will see what that looks 
>>>> like
>>>> in a few hours
>>>>
>>>>
>>>> ------------------------------------------------------------------------------------------------------------------------------ 
>>>>
>>>>
>>>> Other Generic Info:
>>>>
>>>> uname -a
>>>> Linux gw.home.arpa 6.5.7-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Wed 
>>>> Oct
>>>> 11 04:07:58 UTC 2023 x86_64 GNU/Linux
>>>>
>>>> btrfs --version
>>>> btrfs-progs v6.6.2
>>>>
>>>> btrfs fi show
>>>> Label: 'SHARED'  uuid: 021756e1-c9b4-41e7-bfd3-bc4e930eae46
>>>>          Total devices 4 FS bytes used 4.52TiB
>>>>          devid    1 size 2.73TiB used 2.55TiB path /dev/sdg
>>>>          devid    2 size 2.73TiB used 2.56TiB path /dev/sdf
>>>>          devid    3 size 2.73TiB used 2.55TiB path /dev/sdb
>>>>          devid    4 size 2.73TiB used 2.56TiB path /dev/sdc
>>>>
>>>> btrfs fi df /export/shared
>>>> Data, RAID1: total=5.09TiB, used=4.50TiB
>>>> System, RAID1: total=64.00MiB, used=768.00KiB
>>>> Metadata, RAID1: total=24.00GiB, used=16.14GiB
>>>> GlobalReserve, single: total=512.00MiB, used=0.00B
>>>>
>>>>
>>>
>>
>

