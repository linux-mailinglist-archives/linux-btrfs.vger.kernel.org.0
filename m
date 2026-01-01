Return-Path: <linux-btrfs+bounces-20061-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13016CECE18
	for <lists+linux-btrfs@lfdr.de>; Thu, 01 Jan 2026 09:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EA5B3009409
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jan 2026 08:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BFA24BBEB;
	Thu,  1 Jan 2026 08:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZEf+Ul4N"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBC41FAC42
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Jan 2026 08:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767257390; cv=none; b=ZJpqUm1kEAiteVTvnE2JZV0PxleD/H9LCzq/lII9EU0Zd7Y7nUl38Tkl4SnIF+syFu1aeyc2qWlyi4ZVJj44PJa0JV/wuKISElykwrjCKT/Hu0bKRMbi5L2C3XDg/KFekVRjAmkr/yFByobUXI2bjKlGIEVTrci+XYTavXDhutw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767257390; c=relaxed/simple;
	bh=bupeeYL/RsPVRlIuU1BabxxJQyjewEYWvQM0dy76ZqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k+ac+MutL8ALGwFMm1rITD0ZB3UEbI+jUQak7BIPfgoDtj2CIbI1rEvW5jUYlernbiUMEPigjAy1XNpMzNpGEL0letyduv/pL9Me2oM9PnTWnrC+lq3EWeI+t43agF4Yo6gu3QF5oceCV4e/P4vdmwxYxyT3jXA67XtBvK+C0Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZEf+Ul4N; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so73818095e9.2
        for <linux-btrfs@vger.kernel.org>; Thu, 01 Jan 2026 00:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767257386; x=1767862186; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2C+4BhTNuI2FjSZ69nXv8lTcqvA4PuwBdpNkCC8k89Y=;
        b=ZEf+Ul4N3rVWX9oi8tcgnWqp2aM3L+RlyH65iOHfCcHztfSkh2IbeD4mEyfL4yrEW3
         Z3255aSnAmgsRROm2crCuHQkQBTWc4D4V4ToobyYBji9ur29LsvII996v+yeht+MQkpV
         BcsFIMC1vri9crEJxyf6iSRgq8oTUV10pgCQkTpDJ97QXKbHSby7vJB7uXuEANk/7u+W
         0qU+BmocbppbPa1f2FycurFbETgv3dBnnHDGtSxJSHv4wnOGaqhueuRhCN9+53LZ96Yh
         NDj99tuOsN1Ryh3AHpbXT46tMM4s/VDAXm18KgLZ4ByGnMbYaipCqgnFiawb5ZjprPel
         1ciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767257386; x=1767862186;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2C+4BhTNuI2FjSZ69nXv8lTcqvA4PuwBdpNkCC8k89Y=;
        b=XETynRTvSPvK0xnMYcbD8g4P0oBZlAdgr1it9h6hzpf1+2JY6M+vy/pSO5k7GimQON
         xvgD2vkEPngOXflqrlwIIrYQ4lit/e9ef39m4EVeOgvAltFmP64eDAzTKbax4QUaVAHn
         mS/1lfjfCNDxU34l0e9bA6ldvxOx04SJIMAARLVJpOPQgg3YKNWkRk07Z75pviVe2fxY
         /NpRDKnFjfogKmnSQSNHRHJmDDm3KJDbWlilw78l6Yoioe0mBokv11qbG17oRNtVlxTO
         96dEeagO0nL/sUtW5SIcPOFRksktHnEoVTd1vJogRtW25cN9GXCm/dZkE5NYm9SnTx4V
         18wg==
X-Gm-Message-State: AOJu0YwxpR7VaYzQIhtn5diyJz/tyb6rpjZsUeWAL+M19LZR8iNTUYoi
	3toz4L/Zk8NXGnhcPf5KmyGRJcJlVE72Q9leyR6UND8qo6kzSEeRTeCapvwI1G5kCUD/+CNy4t2
	plm5Nk0k=
X-Gm-Gg: AY/fxX78wVjDGQCeErh5x/uyq/1mg38bLil8HVgGejWYVaGLcWEGLd9XT9K+E4mRY7z
	qBwdWqN+8Znd1se5XBiUYRrxwuPghbNR2hQSSDkfSghzMFBMT3XePQivRY7TGtjqFY1PcgN6F5n
	HNxsuK5YzZpq9WBCnvEKO0dD1YfMq60wTBdEN4AyzRIjEgenL6/fC+TIOrvKkZ+oCy8UPlQR8VN
	jJ2PPVHjOZ6/IAfj1NIDYSU54F+QwyBcnozewQc4jzDfoC3Ef09rVqeli+KgnTIEN55mTDKremV
	sAjIBY9caCgExB3GMD98y2+y9A/z7+K/tIe87sFzqOUIGWC/T3kHo6tLqaXHQxnJYt215AspzS5
	5SXLE9gll18u6akUMsLje9LD9/DgDOZqhbHhp7Y+NcD45OszPzeAZrvVIDfvp3/DgvFQK2kFHWD
	gYYRREFi1yIFJjfPhVg1OWLw0Ba93xlXROEmvprxI=
X-Google-Smtp-Source: AGHT+IEOgKf9dB/b2kcoN20hrYZBCu8femhju1wBkbIp8Kmil0K7p+5vg2rrkrpKovGZcf1UtoUpLw==
X-Received: by 2002:a05:600c:8b06:b0:47b:e2a9:2bd7 with SMTP id 5b1f17b1804b1-47d3b011b03mr303147125e9.19.1767257385986;
        Thu, 01 Jan 2026 00:49:45 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e797787sm37139955b3a.60.2026.01.01.00.49.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jan 2026 00:49:45 -0800 (PST)
Message-ID: <6de0d565-e6f9-4084-a0f6-187a2b1dd8d3@suse.com>
Date: Thu, 1 Jan 2026 19:19:41 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fstests: generic/746: update the parser to handle
 block group tree
To: Zorro Lang <zlang@redhat.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20251205071726.159577-1-wqu@suse.com>
 <20260101084230.tciqvaxa5pxhi3xq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <20260101084230.tciqvaxa5pxhi3xq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/1/1 19:12, Zorro Lang 写道:
> On Fri, Dec 05, 2025 at 05:47:26PM +1030, Qu Wenruo wrote:
>> [FALSE ALERT]
>> The test case will fail on btrfs if the new block-group-tree feature is
>> enabled:
>>
>> FSTYP         -- btrfs
>> PLATFORM      -- Linux/x86_64 btrfs-vm 6.18.0-rc6-custom+ #321 SMP PREEMPT_DYNAMIC Sun Nov 23 16:34:33 ACDT 2025
>> MKFS_OPTIONS  -- -O block-group-tree /dev/mapper/test-scratch1
>> MOUNT_OPTIONS -- /dev/mapper/test-scratch1 /mnt/scratch
>>
>> generic/746 44s ... [failed, exit status 1]- output mismatch (see xfstests-dev/results//generic/746.out.bad)
>>      --- tests/generic/746.out	2024-06-27 13:55:51.286338519 +0930
>>      +++ xfstests-dev/results//generic/746.out.bad	2025-11-28 07:47:17.039827837 +1030
>>      @@ -2,4 +2,4 @@
>>       Generating garbage on loop...done.
>>       Running fstrim...done.
>>       Detecting interesting holes in image...done.
>>      -Comparing holes to the reported space from FS...done.
>>      +Comparing holes to the reported space from FS...Sectors 256-2111 are not marked as free!
>>      ...
>>      (Run 'diff -u xfstests-dev/tests/generic/746.out xfstests-dev/results//generic/746.out.bad'  to see the entire diff)
>>
>> [CAUSE]
>> Sectors [256, 2048) are the from the reserved first 1M free space.
>> Sectors [2048, 2112) are the leading free space in the chunk tree.
>> Sectors [2112, 2144) is the first tree block in the chunk tree.
>>
>> However the reported free sectors from get_free_sectors() looks like this:
>>
>>    2144 10566
>>    10688 11711
>>    ...
>>
>> Note that there should be a free sector range in [2048, 2112) but it's
>> not reported in get_free_sectors().
>>
>> The get_free_sectors() call is fs dependent, and for btrfs it's using
>> parse-extent-tree.awk script to handle the extent tree dump.
>>
>> The script uses BLOCK_GROUP_ITEM items to detect the beginning of a
>> block group so that it can calculate the hole between the beginning of a
>> block group and the first data/metadata item.
>>
>> However block-group-tree feature moves BLOCK_GROUP_ITEM items to a
>> dedicated tree, making the existing script unable to parse the free
>> space at the beginning of a block group.
>>
>> [FIX]
>> Introduce a new script, parse-free-space.py, that accepts two tree
>> dumps:
>>
>> - block group tree dump
>>    If the fs has block-group-tree feature, it's the block group tree
>>    dump.
>>    Otherwise the regular extent tree dump is enough.
>>
>> - extent tree dump
>>    The usual extent tree dump.
>>
>> With a dedicated block group tree dump, the script can correctly handle
>> the beginning part of free space, no matter if block-group-tree feature
>> is enabled or not.
>>
>> And with this parser, the old parse-extent-tree.awk can be retired.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Changelog:
>> v2:
>> - Add extra requirement for python3 if the fs is btrfs
>> - Utilize $PYTHON3_PROG other than calling the script directly
>> - Add the comment on we need single DATA/METADATA profiles
>> ---
>>   src/parse-extent-tree.awk | 144 --------------------------------------
> 
> As you've removed the parse-extent-tree.awk, it should be removed from
> src/Makefile too, or `make install` always fails as
> 
>    /bin/sh ../libtool --quiet --mode=install ../install-sh -o root -g root -m 755 dmerror fill2attr fill2fs fill2fs_check scaleread.sh btrfs_crc32c_forged_name.py popdir.pl popattr.py soak_duration.awk parse-dev-tree.awk parse-extent-tree.awk /var/lib/xfstests/src
>    cp: cannot stat 'parse-extent-tree.awk': No such file or directory
>    gmake[1]: *** [Makefile:137: install] Error 1
>    make: *** [Makefile:103: src-install] Error 2

My bad, thanks a lot for pointing this out.

Not aware xfstest can be installed until now.

> 
> So I'll do below change when I merge this patch, to avoid this installation
> regressoin:
> 
>    diff --git a/src/Makefile b/src/Makefile
>    index 711dbb91..ad2ffd85 100644
>    --- a/src/Makefile
>    +++ b/src/Makefile
>    @@ -40,7 +40,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>   
>     EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
>                  btrfs_crc32c_forged_name.py popdir.pl popattr.py \
>    -             soak_duration.awk parse-dev-tree.awk parse-extent-tree.awk
>    +             soak_duration.awk parse-dev-tree.awk

And you may also want to add parse-free-space.py to EXTRA_EXECS?

Thanks,
Qu

> 
> Thanks,
> Zorro
> 
>>   src/parse-free-space.py   | 122 ++++++++++++++++++++++++++++++++
>>   tests/generic/746         |  24 +++++--
>>   3 files changed, 142 insertions(+), 148 deletions(-)
>>   delete mode 100755 src/parse-extent-tree.awk
>>   create mode 100755 src/parse-free-space.py
>>
>> diff --git a/src/parse-extent-tree.awk b/src/parse-extent-tree.awk
>> deleted file mode 100755
>> index 1e69693c..00000000
>> --- a/src/parse-extent-tree.awk
>> +++ /dev/null
>> @@ -1,144 +0,0 @@
>> -# SPDX-License-Identifier: GPL-2.0
>> -# Copyright (c) 2019 Nikolay Borisov, SUSE LLC.  All Rights Reserved.
>> -#
>> -# Parses btrfs' extent tree for holes. Holes are the ranges between 2 adjacent
>> -# extent blocks. For example if we have the following 2 metadata items in the
>> -# extent tree:
>> -#	item 6 key (30425088 METADATA_ITEM 0) itemoff 16019 itemsize 33
>> -#	item 7 key (30490624 METADATA_ITEM 0) itemoff 15986 itemsize 33
>> -#
>> -# There is a whole of 64k between then - 30490624−30425088 = 65536
>> -# Same logic applies for adjacent EXTENT_ITEMS.
>> -#
>> -# The script requires the following parameters passed on command line:
>> -#     * sectorsize - how many bytes per sector, used to convert the output of
>> -#     the script to sectors.
>> -#     * nodesize - size of metadata extents, used for internal calculations
>> -
>> -# Given an extent line "item 2 key (13672448 EXTENT_ITEM 65536) itemoff 16153 itemsize 53"
>> -# or "item 6 key (30425088 METADATA_ITEM 0) itemoff 16019 itemsize 33" returns
>> -# either 65536 (for data extents) or the fixes nodesize value for metadata
>> -# extents.
>> -function get_extent_size(line, tmp) {
>> -	if (line ~ data_match || line ~ bg_match) {
>> -		split(line, tmp)
>> -		gsub(/\)/,"", tmp[6])
>> -		return tmp[6]
>> -	} else if (line ~ metadata_match) {
>> -		return nodesize
>> -	}
>> -}
>> -
>> -# given a 'item 2 key (13672448 EXTENT_ITEM 65536) itemoff 16153 itemsize 53'
>> -# and returns 13672448.
>> -function get_extent_offset(line, tmp) {
>> -	split(line, tmp)
>> -	gsub(/\(/,"",tmp[4])
>> -	return tmp[4]
>> -}
>> -
>> -# This function parses all the extents belonging to a particular block group
>> -# which are accumulated in lines[] and calculates the offsets of the holes
>> -# part of this block group.
>> -#
>> -# base_offset and bg_line are local variables
>> -function print_array(base_offset, bg_line)
>> -{
>> -	if (match(lines[0], bg_match)) {
>> -		# we don't have an extent at the beginning of of blockgroup, so we
>> -		# have a hole between blockgroup offset and first extent offset
>> -		bg_line = lines[0]
>> -		prev_size=0
>> -		prev_offset=get_extent_offset(bg_line)
>> -		delete lines[0]
>> -	} else {
>> -		# we have an extent at the beginning of block group, so initialize
>> -		# the prev_* vars correctly
>> -		bg_line = lines[1]
>> -		prev_size = get_extent_size(lines[0])
>> -		prev_offset = get_extent_offset(lines[0])
>> -		delete lines[1]
>> -		delete lines[0]
>> -	}
>> -
>> -	bg_offset=get_extent_offset(bg_line)
>> -	bgend=bg_offset + get_extent_size(bg_line)
>> -
>> -	for (i in lines) {
>> -			cur_size = get_extent_size(lines[i])
>> -			cur_offset = get_extent_offset(lines[i])
>> -			if (cur_offset  != prev_offset + prev_size)
>> -				print int((prev_size + prev_offset) / sectorsize), int((cur_offset-1) / sectorsize)
>> -			prev_size = cur_size
>> -			prev_offset = cur_offset
>> -	}
>> -
>> -	print int((prev_size + prev_offset) / sectorsize), int((bgend-1) / sectorsize)
>> -	total_printed++
>> -	delete lines
>> -}
>> -
>> -BEGIN {
>> -	loi_match="^.item [0-9]* key \\([0-9]* (BLOCK_GROUP_ITEM|METADATA_ITEM|EXTENT_ITEM) [0-9]*\\).*"
>> -	metadata_match="^.item [0-9]* key \\([0-9]* METADATA_ITEM [0-9]*\\).*"
>> -	data_match="^.item [0-9]* key \\([0-9]* EXTENT_ITEM [0-9]*\\).*"
>> -	bg_match="^.item [0-9]* key \\([0-9]* BLOCK_GROUP_ITEM [0-9]*\\).*"
>> -	node_match="^node.*$"
>> -	leaf_match="^leaf [0-9]* flags"
>> -	line_count=0
>> -	total_printed=0
>> -	skip_lines=0
>> -}
>> -
>> -{
>> -	# skip lines not belonging to a leaf
>> -	if (match($0, node_match)) {
>> -		skip_lines=1
>> -	} else if (match($0, leaf_match)) {
>> -		skip_lines=0
>> -	}
>> -
>> -	if (!match($0, loi_match) || skip_lines == 1) next;
>> -
>> -	# we have a line of interest, we need to parse it. First check if there is
>> -	# anything in the array
>> -	if (line_count==0) {
>> -		lines[line_count++]=$0;
>> -	} else {
>> -		prev_line=lines[line_count-1]
>> -		split(prev_line, prev_line_fields)
>> -		prev_objectid=prev_line_fields[4]
>> -		objectid=$4
>> -
>> -		if (objectid == prev_objectid && match($0, bg_match)) {
>> -			if (total_printed>0) {
>> -				# We are adding a BG after we have added its first extent
>> -				# previously, consider this a record ending event and just print
>> -				# the array
>> -
>> -				delete lines[line_count-1]
>> -				print_array()
>> -				# we now start a new array with current and previous lines
>> -				line_count=0
>> -				lines[line_count++]=prev_line
>> -				lines[line_count++]=$0
>> -			} else {
>> -				# first 2 added lines are EXTENT and BG that match, in this case
>> -				# just add them
>> -				lines[line_count++]=$0
>> -
>> -			}
>> -		} else if (match($0, bg_match)) {
>> -			# ordinary end of record
>> -			print_array()
>> -			line_count=0
>> -			lines[line_count++]=$0
>> -		} else {
>> -			lines[line_count++]=$0
>> -		}
>> -	}
>> -}
>> -
>> -END {
>> -	print_array()
>> -}
>> diff --git a/src/parse-free-space.py b/src/parse-free-space.py
>> new file mode 100755
>> index 00000000..3c761715
>> --- /dev/null
>> +++ b/src/parse-free-space.py
>> @@ -0,0 +1,122 @@
>> +#!/usr/bin/python3
>> +# SPDX-License-Identifier: GPL-2.0
>> +#
>> +# Parse block group and extent tree output to create a free sector list.
>> +#
>> +# Usage:
>> +#  ./parse-free-space -n <nodesize> -b <bg_dump> -e <extent_dump>
>> +#
>> +# nodesize:     The nodesize of the btrfs
>> +# bg_dump:      The tree dump file that contains block group items
>> +#               If block-group-tree feature is enabled, it's block group tree dump.
>> +#               Otherwise it's extent tree dump
>> +# extent_dump:  The tree dump file that contains extent items
>> +#               Just the extent tree dump, requires all tree block and data have
>> +#               corresponding extent/metadata item.
>> +#
>> +# The output is "%d %d", the first one is the sector number (in 512 byte) of the
>> +# free space, the second one is the last sector number of the free range.
>> +
>> +import getopt
>> +import sys
>> +import re
>> +
>> +bg_match = "^.item [0-9]* key \\([0-9]* BLOCK_GROUP_ITEM [0-9]*\\).*"
>> +metadata_match="^.item [0-9]* key \\([0-9]* METADATA_ITEM [0-9]*\\).*"
>> +data_match="^.item [0-9]* key \\([0-9]* EXTENT_ITEM [0-9]*\\).*"
>> +
>> +def parse_block_groups(file_path):
>> +    bg_list = []
>> +    with open(file_path, 'r') as bg_file:
>> +        for line in bg_file:
>> +            match = re.search(bg_match, line)
>> +            if match == None:
>> +                continue
>> +            start = match.group(0).split()[3][1:]
>> +            length = match.group(0).split()[5][:-1]
>> +            bg_list.append({'start': int(start), 'length': int(length)})
>> +    return sorted(bg_list, key=lambda d: d['start'])
>> +
>> +def parse_extents(file_path):
>> +    extent_list = []
>> +    with open(file_path, 'r') as bg_file:
>> +        for line in bg_file:
>> +            match = re.search(data_match, line)
>> +            if match:
>> +                start = match.group(0).split()[3][1:]
>> +                length = match.group(0).split()[5][:-1]
>> +                extent_list.append({'start': int(start), 'length': int(length)})
>> +                continue
>> +            match = re.search(metadata_match, line)
>> +            if match:
>> +                start = match.group(0).split()[3][1:]
>> +                length = nodesize
>> +                extent_list.append({'start': int(start), 'length': int(length)})
>> +                continue
>> +    return sorted(extent_list, key=lambda d: d['start'])
>> +
>> +def range_end(range):
>> +    return range['start'] + range['length']
>> +
>> +def calc_free_spaces(bg_list, extent_list):
>> +    free_list = []
>> +    bg_iter = iter(bg_list)
>> +    cur_bg = next(bg_iter)
>> +    prev_end = cur_bg['start']
>> +
>> +    for cur_extent in extent_list:
>> +        # Finished one bg, add the remaining free space.
>> +        while range_end(cur_bg) <= cur_extent['start']:
>> +            if range_end(cur_bg) > prev_end:
>> +                free_list.append({'start': prev_end,
>> +                                  'length': range_end(cur_bg) - prev_end})
>> +            cur_bg = next(bg_iter)
>> +            prev_end = cur_bg['start']
>> +
>> +        if prev_end < cur_extent['start']:
>> +            free_list.append({'start': prev_end,
>> +                              'length': cur_extent['start'] - prev_end})
>> +        prev_end = range_end(cur_extent)
>> +
>> +    # Handle the remaining part in the bg
>> +    if range_end(cur_bg) > prev_end:
>> +        free_list.append({'start': prev_end,
>> +                          'length': range_end(cur_bg) - prev_end})
>> +
>> +    # Handle the remaining empty bgs (if any)
>> +    for cur_bg in bg_iter:
>> +        free_list.append({'start': cur_bg['start'],
>> +                          'length': cur_bg['length']})
>> +
>> +
>> +    return free_list
>> +
>> +nodesize = 0
>> +sectorsize = 512
>> +bg_file_path = ''
>> +extent_file_path = ''
>> +
>> +opts, args = getopt.getopt(sys.argv[1:], 's:n:b:e:')
>> +for o, a in opts:
>> +    if o == '-n':
>> +        nodesize = int(a)
>> +    elif o == '-b':
>> +        bg_file_path = a
>> +    elif o == '-e':
>> +        extent_file_path = a
>> +    elif o == '-s':
>> +        sectorsize = int(a)
>> +
>> +if nodesize == 0 or sectorsize == 0:
>> +    print("require -n <nodesize> and -s <sectorsize>")
>> +    sys.exit(1)
>> +if not bg_file_path or not extent_file_path:
>> +    print("require -b <bg_file> and -e <extent_file>")
>> +    sys.exit(1)
>> +
>> +bg_list = parse_block_groups(bg_file_path)
>> +extent_list = parse_extents(extent_file_path)
>> +free_space_list = calc_free_spaces(bg_list, extent_list)
>> +for free_space in free_space_list:
>> +    print(free_space['start'] >> 9,
>> +          (range_end(free_space) >> 9) - 1)
>> diff --git a/tests/generic/746 b/tests/generic/746
>> index 6f02b1cc..4eb4252b 100755
>> --- a/tests/generic/746
>> +++ b/tests/generic/746
>> @@ -93,13 +93,23 @@ get_free_sectors()
>>   			| sed -n 's/nodesize\s*\(.*\)/\1/p')
>>   
>>   		# Get holes within block groups
>> -		$BTRFS_UTIL_PROG inspect-internal dump-tree -t extent $loop_dev \
>> -			| $AWK_PROG -v sectorsize=512 -v nodesize=$nodesize -f $here/src/parse-extent-tree.awk
>> +		$BTRFS_UTIL_PROG inspect-internal dump-tree -t extent $loop_dev >> $tmp/extent_dump
>> +		if $BTRFS_UTIL_PROG inspect-internal dump-super $loop_dev |\
>> +				grep -q "BLOCK_GROUP_TREE"; then
>> +			$BTRFS_UTIL_PROG inspect-internal dump-tree -t block-group $loop_dev \
>> +				>> $tmp/bg_dump
>> +		else
>> +			cp $tmp/extent_dump $tmp/bg_dump
>> +		fi
>> +		$PYTHON3_PROG $here/src/parse-free-space.py -n $nodesize -b $tmp/bg_dump \
>> +			-e $tmp/extent_dump >> $tmp/bg_free_space
>>   
>>   		# Get holes within unallocated space on disk
>>   		$BTRFS_UTIL_PROG inspect-internal dump-tree -t dev $loop_dev \
>> -			| $AWK_PROG -v sectorsize=512 -v devsize=$device_size -f $here/src/parse-dev-tree.awk
>> +			| $AWK_PROG -v sectorsize=512 -v devsize=$device_size \
>> +			  -f $here/src/parse-dev-tree.awk >> $tmp/unallocated
>>   
>> +		cat $tmp/bg_free_space $tmp/unallocated | sort
>>   	;;
>>   	esac
>>   }
>> @@ -157,7 +167,13 @@ merged_sectors="$tmp/merged_free_sectors"
>>   mkdir $loop_mnt
>>   
>>   [ "$FSTYP" = "xfs" ] && MKFS_OPTIONS="-f $MKFS_OPTIONS"
>> -[ "$FSTYP" = "btrfs" ] && MKFS_OPTIONS="$MKFS_OPTIONS -f -dsingle -msingle"
>> +if [ "$FSTYP" = "btrfs" ]; then
>> +	# Only SINGLE chunks have their logical address 1:1 mapped
>> +	# to physical addresses.
>> +	MKFS_OPTIONS="$MKFS_OPTIONS -f -dsingle -msingle"
>> +	_require_command $PYTHON3_PROG python3
>> +fi
>> +
>>   
>>   _mkfs_dev $loop_dev
>>   _mount $loop_dev $loop_mnt
>> -- 
>> 2.51.2
>>
>>
> 


