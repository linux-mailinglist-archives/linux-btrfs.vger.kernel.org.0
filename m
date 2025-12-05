Return-Path: <linux-btrfs+bounces-19545-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8209CCA8B76
	for <lists+linux-btrfs@lfdr.de>; Fri, 05 Dec 2025 18:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B90D30D1B2E
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Dec 2025 17:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7ABF33D6F1;
	Fri,  5 Dec 2025 17:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZFZSnq0s";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HgEgy/Kb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D956E336EFE
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Dec 2025 17:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764957198; cv=none; b=O7wkLuNLFB5Ue+j3irmEvsADsXxTh85V9rDlmkb2ToUU8lgxLV2fsU+xXvcyQtVrkB+S9xufIZDe1Oy1gX2yVIYpRUsPOEUqhAgUWsecb7t1Ya4UVHdLuohP6JBw2/lTjnLmCQgCRx/JKStkIl8pZK3Corls07jNKgQL+hQJNek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764957198; c=relaxed/simple;
	bh=16wVmq80sm+uOB4rv22nh0ipceeANttQcN7Uf1bfiXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rfEWXHK0qUAJXdboa5osU6RQOR+2aNFiYOIR1TOyusg/id81dKo34rH3RZ+TZ2DSJAAUZfGXc3Yauct3rWKjTz+BjkRetgk+aNPyE6ZiDnx7c78BarNpDQ8wkIbm0dJiEUYd485knvFWfneOG0+jnM6rAkNp40hcaiN7mugxlmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZFZSnq0s; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HgEgy/Kb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764957194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0DNHTxDnJffWpuIVHPgygHfO5prZLtxIdOONqujHiEI=;
	b=ZFZSnq0siM8vN04K6tU+3V3S4Uw12HK6STeajIwiovhKZMiD6jvc8B9HM8Ua4BXHPmV6Nz
	DOPplx2CUH+NPFBGCr+9TcqE3JXK8bCHLCXVnvHLkhSk6WpiBTkHGOF73H6y3vyo1a1uTg
	W8SkmPkEF7sRRReoN3VGiDEVOyvaDc0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-3zEDe9DrPAiBAkR_Q6btIg-1; Fri, 05 Dec 2025 12:53:12 -0500
X-MC-Unique: 3zEDe9DrPAiBAkR_Q6btIg-1
X-Mimecast-MFC-AGG-ID: 3zEDe9DrPAiBAkR_Q6btIg_1764957192
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2956a694b47so29931415ad.1
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Dec 2025 09:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764957191; x=1765561991; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0DNHTxDnJffWpuIVHPgygHfO5prZLtxIdOONqujHiEI=;
        b=HgEgy/KbJXbHTb1KFZX8+08zzNyg3Q/zT0M/TkVFGB7hv4RJj3+z/l1Dgrl3r4iC9k
         tLxOjFK039M/RY31qcy38AKQR83kECLAYD8FoV6LJMSEi9P7BvOo1qObMmEZNFNOA+Jd
         YkPqvO+qd2Bk4pJBt+fI4HTk4Emlff7ZT5JHA+JBP+D/S2Ropi+b3n3Si2qUwsw1+81G
         3Vo/IU39CAGoneIpu/B7GprkqrF3rUpQWCeUgzQCjbFp8SC5dqNTa5YKYweRSWtDyEZt
         YlJFex6j+Y2hWFclv66uTcdNwJZHfBrpt/eQEBTbJJO69C3L3q+8hIgpyA05wyce8Ran
         9Q8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764957191; x=1765561991;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0DNHTxDnJffWpuIVHPgygHfO5prZLtxIdOONqujHiEI=;
        b=jJ+lJIk8/icS01SGo46aIFYpKyEa8YPDkNyg5uYzpB0WsFWX5I/CJZlH/MyRDrvVof
         VMwhwxG5Ge7p5ETIAkHD7cwttNLyrntK92cI6Dh/X/08absOkl9sdVxYKbgdqB6Y4ayO
         9wl8AlL+4N0HWtiZw5qI099mh//3OaRDyJFG6b6dKeLSKOv2xzwuC9w3MAdYiGm1pN1r
         R4r27hLAKZjNBVGMRxBK4APGOfuR2BAZe9i+DB4JCLd05Zg8ofYIS0Av1d1qgGqYlqpU
         LEkFU8sMoE6LexeAgh+1iC+V7CovyJBr4NpIgSTDLyw84BJQcelZGCSUnhgCUL3tkKx4
         8qtg==
X-Gm-Message-State: AOJu0Yx0pNJdmuF5GhoG+MGamOlgStt1CaIexcAt2LmIOvtA3B7QDhlC
	c2KLVZdi1vyVE5LoQRLG+nH3gTVJeUnoqX1Ro3Fba2tttaJSWshPo32rnLFOnZ3cSJjWO6LUYMK
	O0CVFcEER6hYuECOM7kU5/GpAEZyeBhO11gOStDzX6cGDznJHpTFZWj5Xqb7W4LkZ
X-Gm-Gg: ASbGncsoN/5u7gr09FQcD4kXWZq1VCdzLMoMRG452ggWBDVVuKTmaNaF3FjR7joh22d
	uLUtrZrEGgD+4R9G8Krv9C/tJN1TBAR1zn0uhQKarDnOvJAPVZZH9HPU0A20E6/DBUTImvyzoGe
	v6jKNWOdQTkP926vqfYFyrSUeMRZITTYwZ4nhT+JW9s+sin20ALwBPwjwBH6Hsu7jt8qaMqErh7
	lKInh7KzXZZqJaSwSfuUuU6Jmn/wpSo46EEUh6wbkT3KTRHXf95rlUqU+cQYKmzQJemlOjHCRLq
	4WAN5wbqdnxiNvbX6B5FMQpM6jVZUVcIHPuCaG+j03GPD3u8jf3NzMptZDEfMRxATjxu8UxsxgX
	SoQHCvYyDPJ8SutCnL/r+dbsvfGwLDk5zGREftsgc+ccn9jku0Q==
X-Received: by 2002:a17:903:3c48:b0:298:4f73:d872 with SMTP id d9443c01a7336-29d9fb6ff4amr72197825ad.21.1764957191447;
        Fri, 05 Dec 2025 09:53:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGmlX+Y0J3+4VmwNLjoBosw/+ZBAncECNSWIuJl2e7qiFAbL19U0O1llQC3GKKFP9k8nVuzA==
X-Received: by 2002:a17:903:3c48:b0:298:4f73:d872 with SMTP id d9443c01a7336-29d9fb6ff4amr72197545ad.21.1764957190709;
        Fri, 05 Dec 2025 09:53:10 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae99f1cfsm55120995ad.55.2025.12.05.09.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 09:53:09 -0800 (PST)
Date: Sat, 6 Dec 2025 01:53:06 +0800
From: Zorro Lang <zlang@redhat.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v2] fstests: generic/746: update the parser to handle
 block group tree
Message-ID: <20251205175306.vhy2puit42jdvwi4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251205071726.159577-1-wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251205071726.159577-1-wqu@suse.com>

On Fri, Dec 05, 2025 at 05:47:26PM +1030, Qu Wenruo wrote:
> [FALSE ALERT]
> The test case will fail on btrfs if the new block-group-tree feature is
> enabled:
> 
> FSTYP         -- btrfs
> PLATFORM      -- Linux/x86_64 btrfs-vm 6.18.0-rc6-custom+ #321 SMP PREEMPT_DYNAMIC Sun Nov 23 16:34:33 ACDT 2025
> MKFS_OPTIONS  -- -O block-group-tree /dev/mapper/test-scratch1
> MOUNT_OPTIONS -- /dev/mapper/test-scratch1 /mnt/scratch
> 
> generic/746 44s ... [failed, exit status 1]- output mismatch (see xfstests-dev/results//generic/746.out.bad)
>     --- tests/generic/746.out	2024-06-27 13:55:51.286338519 +0930
>     +++ xfstests-dev/results//generic/746.out.bad	2025-11-28 07:47:17.039827837 +1030
>     @@ -2,4 +2,4 @@
>      Generating garbage on loop...done.
>      Running fstrim...done.
>      Detecting interesting holes in image...done.
>     -Comparing holes to the reported space from FS...done.
>     +Comparing holes to the reported space from FS...Sectors 256-2111 are not marked as free!
>     ...
>     (Run 'diff -u xfstests-dev/tests/generic/746.out xfstests-dev/results//generic/746.out.bad'  to see the entire diff)
> 
> [CAUSE]
> Sectors [256, 2048) are the from the reserved first 1M free space.
> Sectors [2048, 2112) are the leading free space in the chunk tree.
> Sectors [2112, 2144) is the first tree block in the chunk tree.
> 
> However the reported free sectors from get_free_sectors() looks like this:
> 
>   2144 10566
>   10688 11711
>   ...
> 
> Note that there should be a free sector range in [2048, 2112) but it's
> not reported in get_free_sectors().
> 
> The get_free_sectors() call is fs dependent, and for btrfs it's using
> parse-extent-tree.awk script to handle the extent tree dump.
> 
> The script uses BLOCK_GROUP_ITEM items to detect the beginning of a
> block group so that it can calculate the hole between the beginning of a
> block group and the first data/metadata item.
> 
> However block-group-tree feature moves BLOCK_GROUP_ITEM items to a
> dedicated tree, making the existing script unable to parse the free
> space at the beginning of a block group.
> 
> [FIX]
> Introduce a new script, parse-free-space.py, that accepts two tree
> dumps:
> 
> - block group tree dump
>   If the fs has block-group-tree feature, it's the block group tree
>   dump.
>   Otherwise the regular extent tree dump is enough.
> 
> - extent tree dump
>   The usual extent tree dump.
> 
> With a dedicated block group tree dump, the script can correctly handle
> the beginning part of free space, no matter if block-group-tree feature
> is enabled or not.
> 
> And with this parser, the old parse-extent-tree.awk can be retired.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Add extra requirement for python3 if the fs is btrfs
> - Utilize $PYTHON3_PROG other than calling the script directly
> - Add the comment on we need single DATA/METADATA profiles

This version looks good to me. I'd like to wait for some review points
from btrfs list, as this change affects the btrfs test only. For me:

Reviewed-by: Zorro Lang <zlang@redhat.com>

> ---
>  src/parse-extent-tree.awk | 144 --------------------------------------
>  src/parse-free-space.py   | 122 ++++++++++++++++++++++++++++++++
>  tests/generic/746         |  24 +++++--
>  3 files changed, 142 insertions(+), 148 deletions(-)
>  delete mode 100755 src/parse-extent-tree.awk
>  create mode 100755 src/parse-free-space.py
> 
> diff --git a/src/parse-extent-tree.awk b/src/parse-extent-tree.awk
> deleted file mode 100755
> index 1e69693c..00000000
> --- a/src/parse-extent-tree.awk
> +++ /dev/null
> @@ -1,144 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0
> -# Copyright (c) 2019 Nikolay Borisov, SUSE LLC.  All Rights Reserved.
> -#
> -# Parses btrfs' extent tree for holes. Holes are the ranges between 2 adjacent
> -# extent blocks. For example if we have the following 2 metadata items in the
> -# extent tree:
> -#	item 6 key (30425088 METADATA_ITEM 0) itemoff 16019 itemsize 33
> -#	item 7 key (30490624 METADATA_ITEM 0) itemoff 15986 itemsize 33
> -#
> -# There is a whole of 64k between then - 30490624−30425088 = 65536
> -# Same logic applies for adjacent EXTENT_ITEMS.
> -#
> -# The script requires the following parameters passed on command line:
> -#     * sectorsize - how many bytes per sector, used to convert the output of
> -#     the script to sectors.
> -#     * nodesize - size of metadata extents, used for internal calculations
> -
> -# Given an extent line "item 2 key (13672448 EXTENT_ITEM 65536) itemoff 16153 itemsize 53"
> -# or "item 6 key (30425088 METADATA_ITEM 0) itemoff 16019 itemsize 33" returns
> -# either 65536 (for data extents) or the fixes nodesize value for metadata
> -# extents.
> -function get_extent_size(line, tmp) {
> -	if (line ~ data_match || line ~ bg_match) {
> -		split(line, tmp)
> -		gsub(/\)/,"", tmp[6])
> -		return tmp[6]
> -	} else if (line ~ metadata_match) {
> -		return nodesize
> -	}
> -}
> -
> -# given a 'item 2 key (13672448 EXTENT_ITEM 65536) itemoff 16153 itemsize 53'
> -# and returns 13672448.
> -function get_extent_offset(line, tmp) {
> -	split(line, tmp)
> -	gsub(/\(/,"",tmp[4])
> -	return tmp[4]
> -}
> -
> -# This function parses all the extents belonging to a particular block group
> -# which are accumulated in lines[] and calculates the offsets of the holes
> -# part of this block group.
> -#
> -# base_offset and bg_line are local variables
> -function print_array(base_offset, bg_line)
> -{
> -	if (match(lines[0], bg_match)) {
> -		# we don't have an extent at the beginning of of blockgroup, so we
> -		# have a hole between blockgroup offset and first extent offset
> -		bg_line = lines[0]
> -		prev_size=0
> -		prev_offset=get_extent_offset(bg_line)
> -		delete lines[0]
> -	} else {
> -		# we have an extent at the beginning of block group, so initialize
> -		# the prev_* vars correctly
> -		bg_line = lines[1]
> -		prev_size = get_extent_size(lines[0])
> -		prev_offset = get_extent_offset(lines[0])
> -		delete lines[1]
> -		delete lines[0]
> -	}
> -
> -	bg_offset=get_extent_offset(bg_line)
> -	bgend=bg_offset + get_extent_size(bg_line)
> -
> -	for (i in lines) {
> -			cur_size = get_extent_size(lines[i])
> -			cur_offset = get_extent_offset(lines[i])
> -			if (cur_offset  != prev_offset + prev_size)
> -				print int((prev_size + prev_offset) / sectorsize), int((cur_offset-1) / sectorsize)
> -			prev_size = cur_size
> -			prev_offset = cur_offset
> -	}
> -
> -	print int((prev_size + prev_offset) / sectorsize), int((bgend-1) / sectorsize)
> -	total_printed++
> -	delete lines
> -}
> -
> -BEGIN {
> -	loi_match="^.item [0-9]* key \\([0-9]* (BLOCK_GROUP_ITEM|METADATA_ITEM|EXTENT_ITEM) [0-9]*\\).*"
> -	metadata_match="^.item [0-9]* key \\([0-9]* METADATA_ITEM [0-9]*\\).*"
> -	data_match="^.item [0-9]* key \\([0-9]* EXTENT_ITEM [0-9]*\\).*"
> -	bg_match="^.item [0-9]* key \\([0-9]* BLOCK_GROUP_ITEM [0-9]*\\).*"
> -	node_match="^node.*$"
> -	leaf_match="^leaf [0-9]* flags"
> -	line_count=0
> -	total_printed=0
> -	skip_lines=0
> -}
> -
> -{
> -	# skip lines not belonging to a leaf
> -	if (match($0, node_match)) {
> -		skip_lines=1
> -	} else if (match($0, leaf_match)) {
> -		skip_lines=0
> -	}
> -
> -	if (!match($0, loi_match) || skip_lines == 1) next;
> -
> -	# we have a line of interest, we need to parse it. First check if there is
> -	# anything in the array
> -	if (line_count==0) {
> -		lines[line_count++]=$0;
> -	} else {
> -		prev_line=lines[line_count-1]
> -		split(prev_line, prev_line_fields)
> -		prev_objectid=prev_line_fields[4]
> -		objectid=$4
> -
> -		if (objectid == prev_objectid && match($0, bg_match)) {
> -			if (total_printed>0) {
> -				# We are adding a BG after we have added its first extent
> -				# previously, consider this a record ending event and just print
> -				# the array
> -
> -				delete lines[line_count-1]
> -				print_array()
> -				# we now start a new array with current and previous lines
> -				line_count=0
> -				lines[line_count++]=prev_line
> -				lines[line_count++]=$0
> -			} else {
> -				# first 2 added lines are EXTENT and BG that match, in this case
> -				# just add them
> -				lines[line_count++]=$0
> -
> -			}
> -		} else if (match($0, bg_match)) {
> -			# ordinary end of record
> -			print_array()
> -			line_count=0
> -			lines[line_count++]=$0
> -		} else {
> -			lines[line_count++]=$0
> -		}
> -	}
> -}
> -
> -END {
> -	print_array()
> -}
> diff --git a/src/parse-free-space.py b/src/parse-free-space.py
> new file mode 100755
> index 00000000..3c761715
> --- /dev/null
> +++ b/src/parse-free-space.py
> @@ -0,0 +1,122 @@
> +#!/usr/bin/python3
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Parse block group and extent tree output to create a free sector list.
> +#
> +# Usage:
> +#  ./parse-free-space -n <nodesize> -b <bg_dump> -e <extent_dump>
> +#
> +# nodesize:     The nodesize of the btrfs
> +# bg_dump:      The tree dump file that contains block group items
> +#               If block-group-tree feature is enabled, it's block group tree dump.
> +#               Otherwise it's extent tree dump
> +# extent_dump:  The tree dump file that contains extent items
> +#               Just the extent tree dump, requires all tree block and data have
> +#               corresponding extent/metadata item.
> +#
> +# The output is "%d %d", the first one is the sector number (in 512 byte) of the
> +# free space, the second one is the last sector number of the free range.
> +
> +import getopt
> +import sys
> +import re
> +
> +bg_match = "^.item [0-9]* key \\([0-9]* BLOCK_GROUP_ITEM [0-9]*\\).*"
> +metadata_match="^.item [0-9]* key \\([0-9]* METADATA_ITEM [0-9]*\\).*"
> +data_match="^.item [0-9]* key \\([0-9]* EXTENT_ITEM [0-9]*\\).*"
> +
> +def parse_block_groups(file_path):
> +    bg_list = []
> +    with open(file_path, 'r') as bg_file:
> +        for line in bg_file:
> +            match = re.search(bg_match, line)
> +            if match == None:
> +                continue
> +            start = match.group(0).split()[3][1:]
> +            length = match.group(0).split()[5][:-1]
> +            bg_list.append({'start': int(start), 'length': int(length)})
> +    return sorted(bg_list, key=lambda d: d['start'])
> +
> +def parse_extents(file_path):
> +    extent_list = []
> +    with open(file_path, 'r') as bg_file:
> +        for line in bg_file:
> +            match = re.search(data_match, line)
> +            if match:
> +                start = match.group(0).split()[3][1:]
> +                length = match.group(0).split()[5][:-1]
> +                extent_list.append({'start': int(start), 'length': int(length)})
> +                continue
> +            match = re.search(metadata_match, line)
> +            if match:
> +                start = match.group(0).split()[3][1:]
> +                length = nodesize
> +                extent_list.append({'start': int(start), 'length': int(length)})
> +                continue
> +    return sorted(extent_list, key=lambda d: d['start'])
> +
> +def range_end(range):
> +    return range['start'] + range['length']
> +
> +def calc_free_spaces(bg_list, extent_list):
> +    free_list = []
> +    bg_iter = iter(bg_list)
> +    cur_bg = next(bg_iter)
> +    prev_end = cur_bg['start']
> +
> +    for cur_extent in extent_list:
> +        # Finished one bg, add the remaining free space.
> +        while range_end(cur_bg) <= cur_extent['start']:
> +            if range_end(cur_bg) > prev_end:
> +                free_list.append({'start': prev_end,
> +                                  'length': range_end(cur_bg) - prev_end})
> +            cur_bg = next(bg_iter)
> +            prev_end = cur_bg['start']
> +
> +        if prev_end < cur_extent['start']:
> +            free_list.append({'start': prev_end,
> +                              'length': cur_extent['start'] - prev_end})
> +        prev_end = range_end(cur_extent)
> +
> +    # Handle the remaining part in the bg
> +    if range_end(cur_bg) > prev_end:
> +        free_list.append({'start': prev_end,
> +                          'length': range_end(cur_bg) - prev_end})
> +
> +    # Handle the remaining empty bgs (if any)
> +    for cur_bg in bg_iter:
> +        free_list.append({'start': cur_bg['start'],
> +                          'length': cur_bg['length']})
> +
> +
> +    return free_list
> +
> +nodesize = 0
> +sectorsize = 512
> +bg_file_path = ''
> +extent_file_path = ''
> +
> +opts, args = getopt.getopt(sys.argv[1:], 's:n:b:e:')
> +for o, a in opts:
> +    if o == '-n':
> +        nodesize = int(a)
> +    elif o == '-b':
> +        bg_file_path = a
> +    elif o == '-e':
> +        extent_file_path = a
> +    elif o == '-s':
> +        sectorsize = int(a)
> +
> +if nodesize == 0 or sectorsize == 0:
> +    print("require -n <nodesize> and -s <sectorsize>")
> +    sys.exit(1)
> +if not bg_file_path or not extent_file_path:
> +    print("require -b <bg_file> and -e <extent_file>")
> +    sys.exit(1)
> +
> +bg_list = parse_block_groups(bg_file_path)
> +extent_list = parse_extents(extent_file_path)
> +free_space_list = calc_free_spaces(bg_list, extent_list)
> +for free_space in free_space_list:
> +    print(free_space['start'] >> 9,
> +          (range_end(free_space) >> 9) - 1)
> diff --git a/tests/generic/746 b/tests/generic/746
> index 6f02b1cc..4eb4252b 100755
> --- a/tests/generic/746
> +++ b/tests/generic/746
> @@ -93,13 +93,23 @@ get_free_sectors()
>  			| sed -n 's/nodesize\s*\(.*\)/\1/p')
>  
>  		# Get holes within block groups
> -		$BTRFS_UTIL_PROG inspect-internal dump-tree -t extent $loop_dev \
> -			| $AWK_PROG -v sectorsize=512 -v nodesize=$nodesize -f $here/src/parse-extent-tree.awk
> +		$BTRFS_UTIL_PROG inspect-internal dump-tree -t extent $loop_dev >> $tmp/extent_dump
> +		if $BTRFS_UTIL_PROG inspect-internal dump-super $loop_dev |\
> +				grep -q "BLOCK_GROUP_TREE"; then
> +			$BTRFS_UTIL_PROG inspect-internal dump-tree -t block-group $loop_dev \
> +				>> $tmp/bg_dump
> +		else
> +			cp $tmp/extent_dump $tmp/bg_dump
> +		fi
> +		$PYTHON3_PROG $here/src/parse-free-space.py -n $nodesize -b $tmp/bg_dump \
> +			-e $tmp/extent_dump >> $tmp/bg_free_space
>  
>  		# Get holes within unallocated space on disk
>  		$BTRFS_UTIL_PROG inspect-internal dump-tree -t dev $loop_dev \
> -			| $AWK_PROG -v sectorsize=512 -v devsize=$device_size -f $here/src/parse-dev-tree.awk
> +			| $AWK_PROG -v sectorsize=512 -v devsize=$device_size \
> +			  -f $here/src/parse-dev-tree.awk >> $tmp/unallocated
>  
> +		cat $tmp/bg_free_space $tmp/unallocated | sort
>  	;;
>  	esac
>  }
> @@ -157,7 +167,13 @@ merged_sectors="$tmp/merged_free_sectors"
>  mkdir $loop_mnt
>  
>  [ "$FSTYP" = "xfs" ] && MKFS_OPTIONS="-f $MKFS_OPTIONS"
> -[ "$FSTYP" = "btrfs" ] && MKFS_OPTIONS="$MKFS_OPTIONS -f -dsingle -msingle"
> +if [ "$FSTYP" = "btrfs" ]; then
> +	# Only SINGLE chunks have their logical address 1:1 mapped
> +	# to physical addresses.
> +	MKFS_OPTIONS="$MKFS_OPTIONS -f -dsingle -msingle"
> +	_require_command $PYTHON3_PROG python3
> +fi
> +
>  
>  _mkfs_dev $loop_dev
>  _mount $loop_dev $loop_mnt
> -- 
> 2.51.2
> 
> 


