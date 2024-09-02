Return-Path: <linux-btrfs+bounces-7719-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5670A967F60
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 08:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCD681F22812
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 06:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D44183CC2;
	Mon,  2 Sep 2024 06:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=wiesinger.com header.i=@wiesinger.com header.b="yWqGyXqE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from vps01.wiesinger.com (vps01.wiesinger.com [46.36.37.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1746617ADFA
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Sep 2024 06:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.36.37.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725258268; cv=none; b=cYgBCTPbDaEnskga5eR3cXMRtpaigOlxRAbwjxNA0pqAl3uJTdBEatkAUr+H3aLWlz7XtlhVz4MJclHN2CdkmsiQo3wVH0lNU7YTlpyjcjbTd2jyZbIpLyIT/D6pPmp/3/oo4xZ6sy1GxTKUEFAQXNFFkFLMqlbexXL5qAcRB14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725258268; c=relaxed/simple;
	bh=/zo7malMMtZWp+tKfIsiH/r0rgN6h6rLIx4pd4SOsRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FUEL6lSeQrXUwnL3T1HzAIHIg1U/lpp4g9rtVuoCS4dcLO27O2pjDfFAtyo2Ic1zhxfoULGlU1r4zphQ1UxJlGB1jY/cT2due8JGncvoHTWC/d+ZasPpF2835+idyDGm6ZzBrDEIGceisGjnM0tiCckJTi9ZUy0M+y6q4ZmCf6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wiesinger.com; spf=pass smtp.mailfrom=wiesinger.com; dkim=pass (4096-bit key) header.d=wiesinger.com header.i=@wiesinger.com header.b=yWqGyXqE; arc=none smtp.client-ip=46.36.37.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wiesinger.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiesinger.com
Received: from wiesinger.com (wiesinger.com [84.112.177.114])
	by vps01.wiesinger.com (Postfix) with ESMTPS id 84C039F25E;
	Mon,  2 Sep 2024 08:24:23 +0200 (CEST)
Received: from [192.168.0.63] ([192.168.0.63])
	(authenticated bits=0)
	by wiesinger.com (8.18.1/8.18.1) with ESMTPSA id 4826OKTs1187116
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 2 Sep 2024 08:24:22 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 wiesinger.com 4826OKTs1187116
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiesinger.com;
	s=default; t=1725258262;
	bh=tX1FSWmUowOLG2d+lMVE2/aMri/v5mQFpgvKitCV95o=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=yWqGyXqEuZDRB7QFSl8bIMc36ZVJvSDHxI1wpwKd2MrpiYnruGY9UGYUZxiIjizcn
	 2unHhIHnPPrFAkkRuVEDYFTCWvZ83ktY8x2zLi3sNqm9PM4ReB9bFvNGu5/dWCEpnD
	 RxksfUhd061bRgZSrchCxo3NWrsW5NQ0Y+CF0xX7IxQWtkzfEDc4m/ktNen/N/0uCs
	 RSH+X1ZqUvUIdUGq6BMKU4vwjXmxO/6IUy17z3nRBy8YhYq5m201XfNCVBaCKisxmJ
	 cqUh7kSSzAlMB1QnvzoUY3OK66DjFG6myxJVteOulB2X1XHmfw/zWYN5t3VnS3wPB6
	 EPLcrUHcCEAvJ6urM9A5r2bp9gCneKa59QDSEJyJ0ABichGiHR9JCOXXl+ILLEV3T4
	 NpKe3OdQllsGs02qlYDg75Fow+IndWIM+UYbmepwU/16IXjx/OXb3QH1iRorT2zEaM
	 dfstY0X23ZS70HbJh2JypSDeGth3+4kbSDx7j/Cj7K7kAf5z4yVzs27K00WFdAgEUQ
	 /UTAQeBejiCFBcOyI5D4mXMWt8jXgxVycF2AO5hdcQa0SVbrrMHGPV9n/N1fD0Hpo9
	 7+47CkyE67pmmh4eu+10W5CDcenb3lyoaDOCjd7XBJMb/ddYDs4tTNQZ6vsOc2S+61
	 0ZVyct5gwUcNO9eYyJeX6RXc=
Message-ID: <2a4a6f58-da36-456e-89b1-dde0a7b4f5ea@wiesinger.com>
Date: Mon, 2 Sep 2024 08:24:19 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: Corrupt BTRFS can't be get into a consistent state
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <63f8866f-ceda-4228-b595-e37b016e7b1f@wiesinger.com>
 <c06d4a06-589a-428d-a50f-93e29254976e@gmx.com>
 <ce3a4dbc-4e81-4b05-b9e5-c92eec9b5d80@wiesinger.com>
 <c70ac7be-c670-4b89-ae8c-bd34fb505997@gmx.com>
Content-Language: en-US
From: Gerhard Wiesinger <lists@wiesinger.com>
In-Reply-To: <c70ac7be-c670-4b89-ae8c-bd34fb505997@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02.09.2024 07:43, Qu Wenruo wrote:
>
>
> 在 2024/9/2 14:58, Gerhard Wiesinger 写道:
>> On 02.09.2024 00:13, Qu Wenruo wrote:
> [...]
>>> So it means 60 metadata csum mismatch is fixed, only 145 bad data
>>> sectors.
>>
>> How to get rid of the 145 uncorrectables?
>
> Those are all data, at least for my case.
>
> It will not be repairable, just as you mentioned, data loss is expected.

Yes, but I'm expecting a repaired state and not still an inconsistent 
state with known errors (as command repair states). Other filesystems 
move broken files to e.g. lost+found (expecting at least with a switch).


>
>>
>>>
>>> And after the above scrub, btrfs check reports no more error (at least
>>> for metadata):
>>>
>>> Opening filesystem to check...
>>> Checking filesystem on /dev/test/scratch1
>>> UUID: c2be653b-6b00-4ed9-925f-258cc7ca5391
>>> [1/7] checking root items
>>> [2/7] checking extents
>>> [3/7] checking free space tree
>>> [4/7] checking fs roots
>>> [5/7] checking only csums items (without verifying data)
>>> [6/7] checking root refs
>>> [7/7] checking quota groups skipped (not enabled on this FS)
>>> found 3776757760 bytes used, no error found
>>> total csum bytes: 1692008
>>> total tree bytes: 82444288
>>> total fs tree bytes: 71237632
>>> total extent tree bytes: 6455296
>>> btree space waste bytes: 43819992
>>> file data blocks allocated: 29158084608
>>>  referenced 4905811968
>>>
>>>>
>>>> Any ideas how to repair and what can be done to get it into a 
>>>> consistent
>>>> state?
>>>
>>> Please give the original "btrfs check" output.
>>>
>>> I think your original fs is either using SINGLE metadata profile (then
>>> very hard to do repair), AND you're using incorrect way to repair 
>>> (scrub
>>> first, then btrfs check to verify, never --init-extent-tree nor
>>> --init-csum-tree unless you know what you're really doing).
>>
>> I originally did scrub first (forget to mention, but there were still
>> uncorrectable errors as with my test script)
>
> Aren't you expect data corruption?

Yes, but I'm expecting a repaired state and not still an inconsistent 
state with known errors (as command repair states). Other filesystems 
move broken files to e.g. lost+found (expecting at least with a switch)


>
> The uncorrectable errors just means, btrfs knows there is some data with
> checksum, but the on-disk data mismatch with the checksum.
>
> Since it's SINGLE, there is not way to recover, exactly your "data loss"
> case.
> The only difference from other fses is, btrfs can detect the corruption
> and report them as error.
>
>>
>> Original ones: DUP Metadata, so repair should work fine regarding
>> metadata (I have also an original copy of the virtual disk image so I
>> can play around).
>>
>> btrfs inspect-internal list-chunks /mnt
>> Devid PNumber      Type/profile   PStart    Length     PEnd LNumber
>> LStart Usage%
>> ----- ------- ----------------- -------- --------- -------- -------
>> -------- ------
>>      1       1       Data/single 12.00MiB   8.00MiB 20.00MiB 1 12.00MiB
>> 99.76
>>      1       2   Metadata/DUP    36.00MiB   1.00GiB  1.04GiB 2 28.00MiB
>> 14.74
>>      1       3   Metadata/DUP     1.04GiB   1.00GiB  2.04GiB 3 28.00MiB
>> 14.74
>>      1       4       Data/single  2.04GiB   1.00GiB  3.04GiB 4 1.03GiB
>> 93.51
>>      1       5       Data/single  3.04GiB   1.00GiB  4.04GiB 5 2.03GiB
>> 49.37
>>      1       6     System/DUP     4.10GiB  32.00MiB  4.13GiB 15
>> 15.18GiB   0.05
>>      1       7     System/DUP     4.13GiB  32.00MiB  4.16GiB 16
>> 15.18GiB   0.05
>>      1       8       Data/single  4.60GiB   1.00GiB  5.60GiB 6 6.56GiB
>> 37.75
>>      1       9   Metadata/DUP     5.60GiB 128.00MiB  5.72GiB 7 7.71GiB
>> 9.55
>>      1      10   Metadata/DUP     5.72GiB 128.00MiB  5.85GiB 8 7.71GiB
>> 9.55
>>      1      11       Data/single  5.85GiB   1.00GiB  6.85GiB 9 8.12GiB
>> 11.79
>>      1      12       Data/single  6.85GiB   1.00GiB  7.85GiB 10 9.12GiB
>> 16.43
>>      1      13       Data/single  7.85GiB   1.00GiB  8.85GiB 11
>> 10.12GiB  69.76
>>      1      14       Data/single  8.85GiB   1.00GiB  9.85GiB 12
>> 11.15GiB  80.00
>>      1      15       Data/single  9.85GiB   1.00GiB 10.85GiB 13
>> 12.15GiB  45.58
>>      1      16       Data/single 11.85GiB   1.00GiB 12.85GiB 14
>> 14.18GiB  67.44
>>      1      17       Data/single 12.85GiB   1.00GiB 13.85GiB 17
>> 15.21GiB  35.54
>>
>> (BTW: Any other way to find this out?)
>
> `btrfs fi suage` is more than enough to find out the profiles.


Will try it.

>
>>
>>
>>>
>>> And your random corruption script is the best case scenario for btrfs,
>>> it's pretty easy for btrfs just to use the good mirror to repair
>>> metadata, without any need to extra repair inside metadata.
>>
>> # Syntethic test case:
>>
>> # Destroyed with script after btrfs scrub start /mnt
>> [root@localhost ~]# btrfs scrub status /mnt
>> UUID:             717cee50-d376-4c5a-941d-3dac986256fd
>> Scrub started:    Mon Sep  2 07:11:30 2024
>> Status:           finished
>> Duration:         0:00:25
>> Total to scrub:   3.73GiB
>> Rate:             152.74MiB/s
>> Error summary:    verify=8 csum=182
>>    Corrected:      12
>>    Uncorrectable:  178
>>    Unverified:     0
>>
>> # After finishing
>> btrfs scrub status /mnt
>> UUID:             717cee50-d376-4c5a-941d-3dac986256fd
>> Scrub started:    Mon Sep  2 07:12:39 2024
>> Status:           finished
>> Duration:         0:00:26
>> Total to scrub:   3.73GiB
>> Rate:             146.87MiB/s
>> Error summary:    csum=178
>>    Corrected:      0
>>    Uncorrectable:  178
>>    Unverified:     0
>>
>> => so there are still uncorrectables, why can't they be fixed with
>> scrub? (Expectation: "Clean filesystem afterwards, maybe some data lost
>> due to overwritten parts")
>
> That's your "data lost", btrfs just detects those data loss and report 
> them.
> Unlike other fses with data checksum, they can only accept whatever data
> is on the disk, not knowing if it's good or bad.

Yes, but I'm expecting a repaired state and not still an inconsistent 
state with known errors (as command repair states). Other filesystems 
move broken files to e.g. lost+found (expecting at least with a switch)


>
>>
>> # Original disk (after running a lot of scrub/repair commands):
>>
>> btrfs check /dev/mapper/fedora--defect-root--defect
>>
>> [1/7] checking root items
>> [2/7] checking extents
>> [3/7] checking free space cache
>> [4/7] checking fs roots
>> Missing extent item in extent tree for disk_bytenr 1402974208, num_bytes
>> 1847296
>> Missing extent item in extent tree for disk_bytenr 1423011840, num_bytes
>> 598016
>> Missing extent item in extent tree for disk_bytenr 1457127424, num_bytes
>> 6164480
>> Missing extent item in extent tree for disk_bytenr 1484931072, num_bytes
>> 7127040
>> Missing extent item in extent tree for disk_bytenr 2022019072, num_bytes
>> 1773568
>> Missing extent item in extent tree for disk_bytenr 2635603968, num_bytes
>> 5255168
>> Missing extent item in extent tree for disk_bytenr 2817658880, num_bytes
>> 8073216
>> Missing extent item in extent tree for disk_bytenr 2935803904, num_bytes
>> 3244032
>> Missing extent item in extent tree for disk_bytenr 2605039616, num_bytes
>> 8355840
>> Missing extent item in extent tree for disk_bytenr 2745331712, num_bytes
>> 3706880
>> Missing extent item in extent tree for disk_bytenr 3018563584, num_bytes
>> 3121152
>> Missing extent item in extent tree for disk_bytenr 2947518464, num_bytes
>> 8302592
>> Missing extent item in extent tree for disk_bytenr 3068272640, num_bytes
>> 2781184
>> Missing extent item in extent tree for disk_bytenr 2791301120, num_bytes
>> 3547136
>> Missing extent item in extent tree for disk_bytenr 7574302720, num_bytes
>> 3350528
>> Missing extent item in extent tree for disk_bytenr 3031347200, num_bytes
>> 1216512
>> root 5 inode 72933 errors 840, bad file extent, odd csum item
>> root 5 inode 90368 errors 840, bad file extent, odd csum item
>> root 5 inode 166783 errors 840, bad file extent, odd csum item
>> root 5 inode 219687 errors 840, bad file extent, odd csum item
>> root 5 inode 248131 errors 840, bad file extent, odd csum item
>> root 5 inode 346844 errors 840, bad file extent, odd csum item
>> root 5 inode 379257 errors 840, bad file extent, odd csum item
>> root 5 inode 464039 errors 840, bad file extent, odd csum item
>> root 5 inode 464044 errors 840, bad file extent, odd csum item
>> root 5 inode 471393 errors 840, bad file extent, odd csum item
>> root 5 inode 681858 errors 840, bad file extent, odd csum item
>> root 5 inode 833692 errors 840, bad file extent, odd csum item
>> root 5 inode 909657 errors 840, bad file extent, odd csum item
>> root 5 inode 910009 errors 840, bad file extent, odd csum item
>> root 5 inode 1032866 errors 840, bad file extent, odd csum item
>>
>> root 5 inode 1153395 errors 2001, no inode item, link count wrong
>>          unresolved ref dir 53460 index 0 namelen 75 name
>> 7ae2e1b7acb59ea0b30163c03de1cf3884abdc3f-kernel-core-4.19.6-200.fc28-x86_64 
>> filetype 2 errors 6, no dir index, no inode ref
>> root 5 inode 1153401 errors 2001, no inode item, link count wrong
>>          unresolved ref dir 53460 index 0 namelen 70 name
>> 2ed0519ee6bab67f5e5d5d6ce4650e541fbb359f-kernel-4.19.6-200.fc28-x86_64
>> filetype 2 errors 6, no dir index, no inode ref
>> root 5 inode 1153403 errors 2001, no inode item, link count wrong
>>          unresolved ref dir 53460 index 0 namelen 76 name
>> f2caebbe5620078065d21c37e4a88e8f5957215b-kernel-devel-4.19.6-200.fc28-x86_64 
>> filetype 2 errors 6, no dir index, no inode ref
>> root 5 inode 1153405 errors 2001, no inode item, link count wrong
>>          unresolved ref dir 53460 index 0 namelen 78 name
>> 2ad09f77ebb3882396b40dfa44f2840cccf4cf9d-kernel-modules-4.19.6-200.fc28-x86_64 
>> filetype 2 errors 6, no dir index, no inode ref
>> root 5 inode 1159931 errors 2001, no inode item, link count wrong
>>          unresolved ref dir 271 index 0 namelen 15 name fc29-update.log
>> filetype 1 errors 6, no dir index, no inode ref
>> root 5 inode 1159933 errors 2001, no inode item, link count wrong
>>          unresolved ref dir 53026 index 0 namelen 31 name
>> fedora-modular-ce4dd907f26812da filetype 2 errors 6, no dir index, no
>> inode ref
>>
>> <skipped a lot here>
>>
>> ERROR: errors found in fs roots
>> Opening filesystem to check...
>> Checking filesystem on /dev/mapper/fedora--defect-root--defect
>> UUID: 7bb1e7be-c83c-4cbb-a396-14c38393977c
>> found 5625135104 bytes used, error(s) found
>
> Please provide the full output with both stderr and stdout combined.

Was stripped log file with command btrfs check 
/dev/mapper/fedora--defect-root--defect > 
btrfs-root-defect-after-repairs.log 2>&1


Send you full log file in a private E-mail.

Yes, but I'm expecting a repaired state and not still an inconsistent 
state with known errors (as command repair states). Other filesystems 
move broken files to e.g. lost+found (expecting at least with a switch)

Ciao,

Gerhard


