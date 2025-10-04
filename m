Return-Path: <linux-btrfs+bounces-17426-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C491BB87E7
	for <lists+linux-btrfs@lfdr.de>; Sat, 04 Oct 2025 03:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F4F24E64B3
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Oct 2025 01:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448FB19E7E2;
	Sat,  4 Oct 2025 01:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="RsmUFCfR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F097A78F29
	for <linux-btrfs@vger.kernel.org>; Sat,  4 Oct 2025 01:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759542223; cv=none; b=IVGgHq/l2incMqITxlE+cfJDb6hsDByYnTytM8m9KGlCbnUWy/tbDYiFSEimpQuA9Z5Ey0v+WA6I4BGNpx7c2dDEUZVeytn+VoftoETrBPwCBFDN3/SiZrp4cNJ2w8XAqjJcsEzGFNxK2sSlXmItRP1M2hhVWNfgd2WGdTfDBO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759542223; c=relaxed/simple;
	bh=b0QyOm8mWrJdfsW5mkBTqHvTNwdebgoVW0RkO+QiqjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ddn7QYUO11049QhRDJjHOTCV7bHiTlO5cRDyRuWoyq4ltx40wHyEv+RbnD9YHmWUp8Mlv4dh7p8oM8xy8w9asrKtu7NwBuULorDGv1KW/tVmu9rU77b/rEzJrAdiohaS8IFKJyxTY2e/04RT+zzFuWt7PmaYcyvkQGZbv/kxlfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=RsmUFCfR; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id A5810240101
	for <linux-btrfs@vger.kernel.org>; Sat,  4 Oct 2025 03:43:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1759542212; bh=8ELYt6Yn+xqX5A9bqJzrQxlANr8PBjCf0439rpsLkIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:Autocrypt:
	 Content-Type:Content-Transfer-Encoding:From;
	b=RsmUFCfR41xgReSsfKZRN/8oDECIY75Qn7a0xNgc+EVbHRhirkzKRWKhf5rjJKA0r
	 71UqdarNjeX2gBsGfff7vzSKipCyD6JiKXQ28sKHGJXvm0Xbz08urfmu9HGrnAw64q
	 4n0bxxSe5KMUcSTAZ3MW/DwmyPdJKZMOCJZXJta48A9TEf+nTkYC7+nkLXe0ZrIRcG
	 iHp6QGMj9FCZtRXK0ZYxHYcrycNNZiEamtzHLPjtUyyZGo/trrvgf5Tgjv4ZcUPd7c
	 fRY5sOFtIz/ItbKa6pfAX7w0UMRvPG/LifDKwHehsSakZI2dPNa0+qzZaiYDQUYGO4
	 C+VWU+MmR7Stw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4cdpGC4ffMz9rxB;
	Sat,  4 Oct 2025 03:43:31 +0200 (CEST)
Message-ID: <c309381f-c39e-4362-a2b2-8d677346f4a6@posteo.net>
Date: Sat, 04 Oct 2025 01:43:32 +0000
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Can the output of FIEMAP on BTRFS be used to check if a file and
 its reflink copy might have diverged?
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-btrfs@vger.kernel.org
References: <a697548b-cc40-4275-9da1-3b29351654f0@gmail.com>
 <aNF9xH30pAEq5y4r@infradead.org>
 <38f350b0-9a71-4627-9d36-57bf2f85e67a@gmail.com>
 <aNGFdxq6Xqduoj6w@infradead.org>
 <d14d26ce-3176-4cd4-989e-cdbda30be98e@posteo.net>
 <aNpIKB7cc7lCUy7j@infradead.org>
Content-Language: en-US
From: Chris Laprise <tasket@posteo.net>
Autocrypt: addr=tasket@posteo.net; keydata=
 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
In-Reply-To: <aNpIKB7cc7lCUy7j@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/29/25 04:49, Christoph Hellwig wrote:
> On Mon, Sep 22, 2025 at 11:25:48PM +0000, Chris Laprise wrote:
>> The overall procedure is:
>>
>> 1. Get subvolume's Generation ID
>>
>> 2. Read FIEMAP data
>>
>> 3. Get subvolume's Generation ID again
>>
>> 4. Check that the Generation ID hasn't changed: No match skips the file or
>> raises an error
> 
> I'll let the btrfs developers answer this as it's clearly not about
> XFS.
> 
>> I should clarify that in this application we are not interested in physical
>> mappings, but the logical representation of data.
> 
> And that's not what FIEMAP provides.

Its actually what FIEMAP provides: the reported 'logical offsets' are 
intra-file offsets mapped to extent addresses which are labeled 
'physical' (in FIEMAP only) as a historical holdover in Btrfs.  From the 
"BTRFS: The Linux B-Tree Filesystem" paper [1] and developer reference [2]:

 > A chunk tree maintains a mapping from logical chunks to physical
 > chunks. A device tree maintains the reverse mapping. The rest of the
 > filesystem sees logical chunks, and all extent references address
 > logical chunks

[1] 
https://web.archive.org/web/20140423000340/http://domino.watson.ibm.com/library/CyberDig.nsf/papers/6E1C5B6A1B6EDD9885257A38006B6130/$File/rj10501.pdf

[2] 
https://btrfs.readthedocs.io/en/latest/dev/On-disk-format.html#extent-data-6c

FIEMAP is a readout from an inode's extent references.  Btrfs extent 
references are pointers to logical addresses.

The distinction between physical and logical (deemed "opaque") is 
important mainly in cases not grounded in VFS access, such as when the 
Btrfs docs warn not to use FIEMAP addresses "reported as physical" for 
system hibernation storage. (This is the only warning on FIEMAP use I 
could find in the documentation, BTW.)  Knowing that the value is 
unusable for hibernation on Btrfs but usable on XFS only means the 
developer has to know the difference and check the filesystem type.

For Wyng's purposes, each record coming from FIEMAP is logical because 
its a mapping of something (logical for Btrfs or physical for other fs) 
to a logical range in a file, and the list of those ranges (w/extent 
references) under an inode record in the subvolume tree define a file's 
contents.  The two files being compared in a read-only subvol must 
contain the same data before, during and after maint transactions.  So 
it only matters that FIEMAPs for both files were read under the same 
version of the subvol tree (filesystem layer), which contains the 
logical extent reference mapping, so checking the subvol generation ID 
works here. (Noting also, it likely won't work much longer on XFS since 
online maint was recently added apparently without a way to online check 
transaction IDs; Wyng has an open issue for this.)

Notes on general usage –

The FIEMAP ioctl is used by Btrfs userspace utils, samba, libarchive, 
bees, duperemove, blockdiff and probably more. Coreutils 'cp' used it 
for a time before deciding they preferred the portability of lseek(). 
'duperemove' and 'blockdiff' use FIEMAP to find shared extents similar 
to Wyng's usage.  'libarchive' notes [3] that extent references map to 
"logical file blocks".

[3] 
https://github.com/libarchive/libarchive/blob/372e709c1a143c08281fef76edaf84db42327559/libarchive/archive_read_disk_entry_from_file.c#L841

Given that, the oddly disparate warnings to limit FIEMAP use to only 
debugging (one person) or only fragmentation detection (another person) 
look disingenuous.  Neither the FIEMAP documentation for the kernel nor 
for Btrfs put such restrictions on its use.  So in the spirit of 
purported "hacker ethos" and not aesthetics or appeals to proximate 
expertise, I'll need to see an actually demonstrated or fully explained 
code path for data corruption for _this_ specific application in order 
to view the OP claims as serious.  Even a moderately fleshed-out thought 
experiment would be a big improvement.

Additionally, I welcome sincere requests to explore the ramifications of 
using Wyng under specific scenarios in the Wyng issues system, although 
not catastrophizing based on loosely offered opinion.

> I think what you want/need is a way to look at the delta between two
> reflinked files. [...]
Yes, but only the deltas that matter for read()-able content. We are not 
trying to make a comprehensive picture of storage internals as 
btrfs-send/receive do; we only want to know where to seek() during an 
otherwise normal incremental file backup.

-- 
Chris Laprise, tasket@posteo.net
https://codeberg.org/tasket
PGP: BEE2 20C5 356E 764A 73EB  4AB3 1DC4 D106 F07F 1886

