Return-Path: <linux-btrfs+bounces-20060-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 780E9CECDF1
	for <lists+linux-btrfs@lfdr.de>; Thu, 01 Jan 2026 09:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71AAA3008FB9
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jan 2026 08:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54B71F4611;
	Thu,  1 Jan 2026 08:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Peqm9fXH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="B6LPi4uM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1BF1DF26B
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Jan 2026 08:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767256963; cv=none; b=BO+CNaJSUi8xXTmUhQ4Gq4kxNETWR4AgFDOJoSAozVaoxCN576Y2zOZpCpOkij3bODLuj8nKxASXDLAfbL3MfrLZZu1rEs2whQC5ChJwgBNU3If5g61lx9gKxwYp0gn/JonykDphlqrYW7KGevGaRpIlzXl7YUlSfDB6spNOXds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767256963; c=relaxed/simple;
	bh=a+FFONRBEpB+OqSr2QaoDw1SqU6I8+ARXvupLSVJzCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lEBcWAgBZp4FssYKpB4yWwgEzgogkeebvMQN09+9GgrSm6oaOadnFpWIwMDX6jc9if7e2VCPHwXjckGrxbq0EW5yCFr6Zzf3tGaizDI8gCSgiDmWYhX/NclKi1ovceUPDJGulxl/YC6N16Eo4lTf6bJDdYugRdV6Aalf5Ktw+kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Peqm9fXH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=B6LPi4uM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767256959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uynV/TGnMJE2w/2wWJyQ3tWEooZCQjZwZ/DoujUYQqA=;
	b=Peqm9fXH1bAa4/uOoydd6wZSF6Dwo8rctgoQecH0NsUG8VZycX41NEnB8PZX+j+bw7+nyV
	SwBiWF4UHZFuHYMjuAEaqQR46DHrHz6N3F+/Ml1b4AhzujpFEGiQYR2+UYePCiGRTxypvA
	KqeHGyL2nI5d4kPaqqraoFtPeu9/gUI=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-V0sRu6EsPe-8bRDa0VpIog-1; Thu, 01 Jan 2026 03:42:37 -0500
X-MC-Unique: V0sRu6EsPe-8bRDa0VpIog-1
X-Mimecast-MFC-AGG-ID: V0sRu6EsPe-8bRDa0VpIog_1767256956
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a0e9e0fd49so123675485ad.0
        for <linux-btrfs@vger.kernel.org>; Thu, 01 Jan 2026 00:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767256956; x=1767861756; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uynV/TGnMJE2w/2wWJyQ3tWEooZCQjZwZ/DoujUYQqA=;
        b=B6LPi4uMEVP7SZPm7Ag6GPxl+nslbKVJ72eLqLZTepdWUBntkzRdUqf2T2PBir8Ahk
         fonZFLpAfM7hjFbgTEO9ft7apqpbbXOldmJ5SV6jZWJBVcRxI2DqFhmXeYJaxMdaSSU8
         WVSZ1nrMoCvU/SmZI/C2lBmw9vpo994b8qZix3Ui5d2j0oTQfkSQWv6JL8Dgnxaf5peX
         78DBdGq39JqoVHewTPjPJVpUFocMIbudRlGydGjSfpnwSjphyHDRrHZYPkVURu5NIZi1
         wu1JxLU/Ak53ExmFKbTqcqThp/r51gQ2DPSF00+T4Xqm5FuIJljrMYjFuCMP2uBqH+1D
         +mRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767256956; x=1767861756;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uynV/TGnMJE2w/2wWJyQ3tWEooZCQjZwZ/DoujUYQqA=;
        b=IJ9sL2nj1CkwxOmIua5tiT0bk5COy3OwZjfAnLvnWZsLsSOJAp8OShE2iHLFqX7V3k
         7F6tdbi/KRuhAc64w3tN15JkSgI95O72mmN7jT1of/t9vMYWtBtsR+iBVcl4IIuVWJ1P
         wYMMb1dGBzYNu4vLSW4AKpfIcyd1+c3qHhPfoFo4gdj/1dArkhEG6pZQxo+wElyK96em
         jTNEDzYIsGaeY/02FfyCtpFN6guXCiMqyiRQOlP9Fe5rjQP1OncU1hdTImOApNE4SOiK
         jri6Hu1EpyorIrXjT6o55azv+coc9BqkFkDBP614LtHwI5hL2Nnk5fyagizBJgY5qdYb
         mnlg==
X-Gm-Message-State: AOJu0Yy3dEWhk/SMKJyIUhKibAjBCx1G1Z+TryuOm3uFPqXr+A87mN0I
	wa3zv8RNAwix2D/+RTVSR/aOewziycC+YjL/LIPJGSynAeSI5HW0CrMoeW7+TEPqFzgwIBFuh1W
	0SucxRSkKa42QXXg39qkD64ribyZfxCYASs3JAKD3/0CZAgjM+J7c2AOjjkyxxvRp4z6fppUF
X-Gm-Gg: AY/fxX4fJOZW9x7Xg7/nsipaXheilsHXGAg1T59NOMKYXxFf3xDl0CsJ+MBWtZVG6EV
	Xs14Pap1jdvvNYytnkEnll0vVGrzh43lPV02JnVnpqZ/Se59GU99V1kUBMYdBfeie/pCrJGsJbo
	6cUSeG8ItvH4Y+FS465MsP0MBTOarFZuY6KeMTHQEK5oGtyY354JY/uvss2kHv6JazSgcnXRNx7
	Rc11v4OZE13MuCV/ylGjS2ZWE0Sfwp7OIhls5p0FWhJMHfvChimQjaMPPXYzM581gEsk0Z92+H2
	HIBf5UU+Rg6KPiPpyicLeiyEpBzrsqSqQytQ6xxEnEHB5CtWJl+D4BekAvPydblTtAbsfeha4bs
	wVxDdQtCog4fuwHJ/zr2JOLxLeQj+IfhQxYT+ydC0uXl1Zf32fg==
X-Received: by 2002:a17:902:dace:b0:2a0:eaf5:5cd8 with SMTP id d9443c01a7336-2a2caab6e40mr385049365ad.9.1767256955667;
        Thu, 01 Jan 2026 00:42:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE68JJNBRDY4BiYJPa4gV0aKhuCUQOx8XO+Hz93m7mlY4+7+i5CSB0Xzo1RwtSmwmoq6RBagg==
X-Received: by 2002:a17:902:dace:b0:2a0:eaf5:5cd8 with SMTP id d9443c01a7336-2a2caab6e40mr385049265ad.9.1767256955075;
        Thu, 01 Jan 2026 00:42:35 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d4cb90sm350758525ad.51.2026.01.01.00.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 00:42:34 -0800 (PST)
Date: Thu, 1 Jan 2026 16:42:30 +0800
From: Zorro Lang <zlang@redhat.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v2] fstests: generic/746: update the parser to handle
 block group tree
Message-ID: <20260101084230.tciqvaxa5pxhi3xq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
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
> ---
>  src/parse-extent-tree.awk | 144 --------------------------------------

As you've removed the parse-extent-tree.awk, it should be removed from
src/Makefile too, or `make install` always fails as

  /bin/sh ../libtool --quiet --mode=install ../install-sh -o root -g root -m 755 dmerror fill2attr fill2fs fill2fs_check scaleread.sh btrfs_crc32c_forged_name.py popdir.pl popattr.py soak_duration.awk parse-dev-tree.awk parse-extent-tree.awk /var/lib/xfstests/src
  cp: cannot stat 'parse-extent-tree.awk': No such file or directory
  gmake[1]: *** [Makefile:137: install] Error 1
  make: *** [Makefile:103: src-install] Error 2

So I'll do below change when I merge this patch, to avoid this installation
regressoin:

  diff --git a/src/Makefile b/src/Makefile
  index 711dbb91..ad2ffd85 100644
  --- a/src/Makefile
  +++ b/src/Makefile
  @@ -40,7 +40,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 
   EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
                btrfs_crc32c_forged_name.py popdir.pl popattr.py \
  -             soak_duration.awk parse-dev-tree.awk parse-extent-tree.awk
  +             soak_duration.awk parse-dev-tree.awk

Thanks,
Zorro

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


