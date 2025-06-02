Return-Path: <linux-btrfs+bounces-14391-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48102ACBA57
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 19:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26B7317717C
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 17:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A74223707;
	Mon,  2 Jun 2025 17:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inwind.it header.i=@inwind.it header.b="ZGhsEZfm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-16.italiaonline.it [213.209.10.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164F1226D1D
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 17:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.209.10.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748885462; cv=none; b=Zp68pDvnuGQk/SOA0tcsFW0jp9hVnGb7bo7Qup9NqrMqWyD37D3X23jD7e1ZW7K3d/KYK13v4VUgHa8pBC3ZX54yAZAObaarofa8c13qoaXhe1uuqjwqWt6YkInfOaQh1GwpBk1tvMB3fnPHN/6tMEAOuI8lkkQ9Jf4n+fLDK5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748885462; c=relaxed/simple;
	bh=7ggU5dRcnapo8j/GCsHtC+nvcGfKMptMWrP/mwmLka8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kvFc3ZxnkNu9RRPZjfEXyxIAyQ7Y1egs5Kmy6qfvrY5HGkvFZP+fA2BH3BrS6/43YILRxEbJVa0bdgaR5JV4OoEtqc4awVkUX3DKDpbLJp8ZJvmYDsXgXX/hzxkVbgD/m4uKQtgQnh6PD0c9KHABCAfdJe3OTgp+ErJmD4aDBlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=inwind.it; spf=pass smtp.mailfrom=inwind.it; dkim=pass (2048-bit key) header.d=inwind.it header.i=@inwind.it header.b=ZGhsEZfm; arc=none smtp.client-ip=213.209.10.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=inwind.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inwind.it
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-16.iol.local with ESMTPSA
	id M8xQuqEGaL8lyM8xQufFFg; Mon, 02 Jun 2025 19:28:20 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
	t=1748885300; bh=73gY52CxXyJFkCBJ3pgQx1FnC4hx0Yuih8QRX5FZn30=;
	h=From;
	b=ZGhsEZfmpqG9tcb0Et/M1Gw6I+fIhk3CU2nF8TT7CM60JvEIZrLXAwfjdYmMljmyJ
	 pStML02X3Vimr2BXcXVc/RL1GtCfpUPU2gO2aJRWh5s35B0NmcEjAsy8ue6SQ8TWP3
	 clk13oXivWSIBeBgoPPsLhd9grijQrYtrpomNCbFHRbf4OrEo3zftnSqZ60Hl+r1Ux
	 8bCsqIlrQUY02eu0u8ZN08VMHhwLGT1dRc9hQk9ftCuQei8kt1DunL+I+kN72XQKbh
	 gOgfXsdV9JQxVdCmm0hBkZpDfkNcP53riJP0DmUXokFWHN2dyqgmHkgvPOo6k24Zgd
	 J3BLl+cPgf4JA==
X-CNFS-Analysis: v=2.4 cv=Hu52G1TS c=1 sm=1 tr=0 ts=683ddf34 cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=se02cz2NG2M5r8EZTucA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
Message-ID: <b2eee8fc-ef11-431f-81b2-46f48e087a0d@inwind.it>
Date: Mon, 2 Jun 2025 19:28:20 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH v2 0/6] btrfs-progs: introduce "btrfs rescue
 fix-data-checksum"
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org
References: <cover.1747295965.git.wqu@suse.com>
 <828702dd-33e8-48c0-85f8-455763e34ed2@libero.it>
 <e156fb78-928b-4fea-b29d-c06f70744fdf@gmx.com>
Content-Language: en-US
From: Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <e156fb78-928b-4fea-b29d-c06f70744fdf@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfD6/yiPsr8uE5DtvF6v/pK7v9UeGoSrYYpGvre7bISuoTxjEYROsDDInWWkid+oDASULcX09okmYFa8E0K+a5KApBKlJDSMkFJXKhPlPv5VBHxO0R3Q9
 +9OxKvC1afjI049ox6DLMlFGIyjV4fX5iTkEXes9fPBFC3fv5s4/2M2VsKuaHP1N5ugpm7zC+U+Pa59tPnsB3FHpiioQJMHCUlMFOjQM5g4LkS3fKIie6/cV
 BLyspG2/bga+LnlQd7Ovnw==

On 01/06/2025 00.07, Qu Wenruo wrote:
> 
> 
> 在 2025/6/1 02:28, Goffredo Baroncelli 写道:
>> On 15/05/2025 10.00, Qu Wenruo wrote:
[...]
>>> We have a long history of data csum mismatch, caused by direct IO and
>>> buffered being modified during writeback.
>>>
>> What about having an ioctl (on a mounted fs) which allow us to read data from a file even
>> if the csum doesn't match ?
> 
> The problem is again with mirrors.
> 
> Unless you ask the end user to provide a mirror number, for a with multiple mirrors, and the mirrors doesn't match each other, the behavior will be a mess.
> 
> That's why I'm planning to add something like a mirror priority, with a new mirror "best" to try use the mirror with the most matches.
> 
> 
> Despite the mirror number problem (we need to ask the end user for mirror number), I think it's possible to implement the feature (mostly) in user space.
> 
> E.g. combine fiemap result with btrfs-map-logical, then read from the disk directly.
> 
This would expose to the user space the complexity of the filesystem; this means having two code path doing the same thing in two subtle different ways. Pay attention to consider also a raid5/6 case with a missing disks.

I don't know how important is select a valid mirror. Or at least, I don't see a realistic case where a mirror may be better than another one.

After your consideration, I would like to suggest the following:
1) read the data from a mirror, the csum matches, return data
2) read the data from a mirror, the csum DOES NOT match:
    2.1) read the data from another mirror(s), the csum matches,
	- rebuild the csum
	- return the data
    2.2) read the data from another mirror(s), the csum still doesn't match, return error
    2.3) (NEW, alternatively to 2.2) read the data from another mirror(s), the csum still doesn't match:
	- take the latest read attempt as valid
         - rebuild the csum
         - return the last read attempt

2.3) mode should be a enabled by an IOCTL on a specific fd. The assumption here is that if the csum doesn't match any mirror may be equally bad/good. But in the IOCTL we could add a parameter to specify the order of the mirrors (still we need a way to specify the order of the mirror in the raid5 case).

>> I asked that because the problem usually happen on a specific file
>> and not to an entire filesystem. In this case I think that it would be more practical to read the block
>> using the IOCTL, and then rewrite the block, at the specific offset (to update the checksum).
> 
> I'm fine with the idea of reading from raw data idea (although prefer to implement it in user space), but not a huge fan to simply re-write with COW.
> 
> E.g. the bad csum is still there, can still be exposed by scrub, even it's not referred by any file anymore.
> 

If I understood correctly, you are saying that due to the fact that even if an extent is partially referred, all data in the extent is tracked and has his checksum. A rewriting in the middle would generate a new extent with a new checksum, but the old data still exists in the extent with his dedicated (and un-matching ) csum. (I repeated this because it seems to me a technical detail not so obvious but very important)

>>
>> Of course there are several tradeoff: the "unmounted" version, doesn't duplicate a shared block,
>> where my approach (read the data using an ioctl to avoid the CSUM mismatch and rewrite it) make
>> a fork if the block is shared. However, as told before, the problem is related to specifics file and it seems
>> a waste of resource reading an entire filesystem to correct few files. No to mention that the IOCTL
>> can be done on a "live" filesystem.
> 
> I do not think we should treat the csum error so easily, it's still a big problem.
> 
> Even it's known that direct IO with buffer modified halfway can lead to corruption, the csum mismatch is still a huge problem.
> The end user should check if their problem is properly written, or use the latest kernel with proper backport.
> 
> If it's really caused by hardware (memory or disk or whatever), it's a huge deal and definitely needs proper inspection and verification.
> 
> So overall, if one hits a csum mismatch, especially after the direct IO fix, then it should not be treated as "something that can be easily fixed online", it should be something huge, at least needs some tool to handle it offline.
> 

Even tough I agree about the severity (e.g. the corruption happened due to an hw error), I less agree about the fact that this is a justification to not have a simpler interface (form an user interface POV) that don't requires an un-mount/mount of the filesystem.

Un-mounting a root filesystem is a not so easy operation, so we should provide a different way to access the data.

However I agree that we should allow the user to select a different "mirror", considering that a "mirror" may be any valid combination of disk to rebuild the data (e.g. when we will define the interface, we should consider raid 6).

> Thanks,
> Qu
> 
>>

BR
Goffredo

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

