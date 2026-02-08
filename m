Return-Path: <linux-btrfs+bounces-21494-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JcCGdbaiGnFxQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21494-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 19:49:58 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0E2109F05
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 19:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C5C830094F1
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Feb 2026 18:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBB130100E;
	Sun,  8 Feb 2026 18:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="WF8bmblS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5412B1D7E5C
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Feb 2026 18:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770576589; cv=none; b=ZMCrv8nf9rY092dYPqhTX/zYEctHCjUVTGRp59xJc2dHvW/DEzVTCnDDEljN6P8vdy5UoOuoRMsf4HThBs3yyx94VTHgIydaEu4WsdG2M1S8RG0ip/wixn5a6MpRywunyAE0tatB8w1tSXb58KOI09WhR71CmjFlh1R9xmsIjWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770576589; c=relaxed/simple;
	bh=W+t8SotURr0Ds7cC13lgXzmmd9h8Tq7p7K+Nc63wodU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bNAmMBJj1vUmxZ2QrKEwwzSn3Eu35tIPJqNgupLGwsOtGexFAfAmXMNcUNai/eFDSF1NBUfwE59EWV8ZiMVwLaSNvjwHErUWabXNKURQCPoHBqojPqrS1mKxg3/bhU417LJJF2AbovwOYwjuIGrYLcbanwDx8otJXLB9mG7svLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=WF8bmblS; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6188QODX3972544;
	Sun, 8 Feb 2026 10:49:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=Sq1jaqiL13Gys+CF0XIffhD4JBuIe2WI8N5erVQ5BrE=; b=WF8bmblSwpGd
	ZsnKY0rySKzO9adUbUpdNr//EeAd27RGGKfM301AG2edD6Bio9qSdMp0plajOMvp
	f5DJTiH62TVU7FQDoiwkHKIdm/9PVFBznsiZUTqoPtVs0+kKQadfw74fQ11spskl
	csOL/pZYIJGZwSDbuSezfvOWOvpU9JYLKLqtwrsU18rUbZ5YKM9QBzxew5+Y0I+t
	cJYA9L+ifCmXFmiladlXxiWtJMnJCYI4SNipaZZ1v12By89tvEwLLJJqQe5RCFiB
	BpESV1iCHVDxXzXPMEO65yxSpRb59P5t6eHKIcgkrQzjxXLLPkBhQpcele6b8GDT
	xc6DHvgiRA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c67ycg1w5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 08 Feb 2026 10:49:47 -0800 (PST)
Received: from devbig003.atn7.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Sun, 8 Feb 2026 18:49:33 +0000
From: Chris Mason <clm@meta.com>
To: Qu Wenruo <wqu@suse.com>
CC: <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: refactor the main loop of cow_file_range()
Date: Sun, 8 Feb 2026 10:48:20 -0800
Message-ID: <20260208184920.1102719-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <5ff61d63a33409de2b821562613ebb3ac0da9bae.1765788497.git.wqu@suse.com>
References: <5ff61d63a33409de2b821562613ebb3ac0da9bae.1765788497.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA4MDE2MiBTYWx0ZWRfXwYt5gF1akH/A
 zNf3auc93+ACPslAJv30Osyx124eTx5vfyH3mVkq/uYxsRG8hdfo8XeFl4pT/HqD7HIxRtp886P
 XgusZOEQiN4t7tsF2SKiQozF4/4AeUZwRAQ30SxPvIHcKZ1YpPa9xxv/+fpFrVulfMKAn2gfYVi
 2iNFiKdbGzLj2+FPXrGk2aWUfRlgI4z/D5USZIXEzxhouB5xtULkXns9sVYU0CkbgZYUcOLYDMm
 zhrH8GRDjSRRRHIx6CFdkT7t3mYqrWS87ccmYvQYL+RIseiU0EIZzbjIfityxqbw9ZS89C7SCVb
 IS9tItLpWr/dC+opzqJjmG40jyjsts4TxMEXcoYvcY91Hyc1mCzPhu5keSAi9g4UIxKMc3fbYl+
 hoXv2929PwFchBYme2PjK3H3d4Dw73LfQ8DxNK821L+CIgb5EsZJcBxrxvQLk1dEWPnLlwXOl2B
 v1INdBrpwidCYibpZvg==
X-Proofpoint-ORIG-GUID: uJgvQ58OdnXg2HFK78IVRovuToO6LHIf
X-Authority-Analysis: v=2.4 cv=PomergM3 c=1 sm=1 tr=0 ts=6988dacb cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=NEAV23lmAAAA:8 a=iox4zFpeAAAA:8
 a=OwSd4tB7qwwLmjfTHYcA:9 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-GUID: uJgvQ58OdnXg2HFK78IVRovuToO6LHIf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-05_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21494-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[meta.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clm@meta.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,meta.com:mid,meta.com:dkim,suse.com:email]
X-Rspamd-Queue-Id: DB0E2109F05
X-Rspamd-Action: no action

Qu Wenruo <wqu@suse.com> wrote:
> Currently inside the main loop of cow_file_range(), we do the following
> sequence:
> 
> - Reserve an extent
> - Lock the IO tree range
> - Create an IO extent map
> - Create an ordered extent

Hi everyone,

I'm running the btrfs for-next branch, along with the encryption patch set
through my AI review prompts:

https://github.com/masoncl/review-prompts

I'm working on some btrfs specific instructions, but hopefully these reviews
are already useful.  I've kept the headers to make it easier to double check
that I'm actually replying to the right email, but please let me know if any
parts of this are incorrect:

commit c28214bde6da6e05554a0e5b6375b7b65f98cdbf
Author: Qu Wenruo <wqu@suse.com>

btrfs: refactor the main loop of cow_file_range()

This commit refactors error handling in cow_file_range() by introducing
a dedicated cow_one_range() helper that consolidates the
reserve/lock/allocation sequence and moves error handling into the
helper itself.

> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index e83a881fe202e..b95dab8ac8a11 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c

[ ... ]

> @@ -1274,6 +1274,133 @@ u64 btrfs_get_extent_allocation_hint(struct btrfs_inode *inode, u64 start,
>  	return alloc_hint;
>  }
>
> +/*
> + * Handle COW for one range.
> + *
> + * @ins:		The key representing the allocated range.
> + * @file_offset:	The file offset of the COW range
> + * @num_bytes:		The expected length of the COW range
> + *			The actually allocated length can be smaller than it.
> + * @min_alloc_size:	The minimal extent size.
> + * @alloc_hint:		The hint for the extent allocator.
> + * @ret_alloc_size:	The COW range handles by this function.
> + *
> + * Return 0 if everything is fine and update @ret_alloc_size updated.  The
> + * range is still locked, and caller should unlock the range after everything
> + * is done or for error handling.
> + *
> + * Return <0 for error and @is updated for where the extra cleanup should
> + * happen. The range [file_offset, file_offset + ret_alloc_size) will be
> + * cleaned up by this function.
> + */
> +static int cow_one_range(struct btrfs_inode *inode, struct folio *locked_folio,
> +			 struct btrfs_key *ins, struct extent_state **cached,
> +			 u64 file_offset, u32 num_bytes, u32 min_alloc_size,
> +			 u64 alloc_hint, u32 *ret_alloc_size)
> +{
> +	struct btrfs_root *root = inode->root;
> +	struct btrfs_fs_info *fs_info = root->fs_info;
> +	struct btrfs_ordered_extent *ordered;
> +	struct btrfs_file_extent file_extent;
> +	struct extent_map *em;
> +	u32 cur_len = 0;
> +	u64 cur_end;
> +	int ret;
> +
> +	ret = btrfs_reserve_extent(root, num_bytes, num_bytes, min_alloc_size,
> +				   0, alloc_hint, ins, true, true);
> +	if (ret < 0) {
> +		*ret_alloc_size = cur_len;
> +		return ret;
> +	}
> +
> +	cur_len = ins->offset;
> +	cur_end = file_offset + cur_len - 1;
> +
> +	file_extent.disk_bytenr = ins->objectid;
> +	file_extent.disk_num_bytes = ins->offset;
> +	file_extent.num_bytes = ins->offset;
> +	file_extent.ram_bytes = ins->offset;
> +	file_extent.offset = 0;
> +	file_extent.compression = BTRFS_COMPRESS_NONE;
> +
> +	/*
> +	 * Locked range will be released either during error clean up (inside
> +	 * this function or by the caller for previously successful ranges) or
> +	 * after the whole range is finished.
> +	 */
> +	btrfs_lock_extent(&inode->io_tree, file_offset, cur_end, cached);
> +	em = btrfs_create_io_em(inode, file_offset, &file_extent, BTRFS_ORDERED_REGULAR);
> +	if (IS_ERR(em)) {
> +		ret = PTR_ERR(em);
> +		goto free_reserved;
> +	}
> +	btrfs_free_extent_map(em);
> +
> +	ordered = btrfs_alloc_ordered_extent(inode, file_offset, &file_extent,
> +					     1U << BTRFS_ORDERED_REGULAR);
> +	if (IS_ERR(ordered)) {
> +		btrfs_drop_extent_map_range(inode, file_offset, cur_end, false);
> +		ret = PTR_ERR(ordered);
> +		goto free_reserved;
> +	}

[ ... ]

> +free_reserved:
> +	extent_clear_unlock_delalloc(inode, file_offset, cur_end, locked_folio, cached,
> +				     EXTENT_LOCKED | EXTENT_DELALLOC |
> +				     EXTENT_DELALLOC_NEW |
> +				     EXTENT_DEFRAG | EXTENT_DO_ACCOUNTING,
> +				     PAGE_UNLOCK | PAGE_START_WRITEBACK |
> +				     PAGE_END_WRITEBACK);

Can this cause a double decrement of the bytes_may_use space accounting
counter?

Looking at the error paths in cow_one_range(), when
btrfs_reserve_extent() succeeds, it calls btrfs_add_reserved_bytes() at
line 3829 in block-group.c, which already decrements bytes_may_use.
Then if we hit the free_reserved error path, EXTENT_DO_ACCOUNTING
includes EXTENT_CLEAR_DATA_RESV, which causes
btrfs_free_reserved_data_space_noquota() to be called via
btrfs_clear_delalloc_extent(), decrementing bytes_may_use a second time.

The old code at the out_unlock label explicitly avoided this with the
comment:

    /*
     * For the range (2). If we reserved an extent for our delalloc range
     * (or a subrange) and failed to create the respective ordered extent,
     * then it means that when we reserved the extent we decremented the
     * extent's size from the data space_info's bytes_may_use counter and
     * incremented the space_info's bytes_reserved counter by the same
     * amount. We must make sure extent_clear_unlock_delalloc() does not try
     * to decrement again the data space_info's bytes_may_use counter,
     * therefore we do not pass it the flag EXTENT_CLEAR_DATA_RESV.
     */

The old code used only EXTENT_CLEAR_META_RESV (not
EXTENT_CLEAR_DATA_RESV) for this error path. Should the free_reserved
path use EXTENT_CLEAR_META_RESV instead of EXTENT_DO_ACCOUNTING to avoid
this double-decrement?

> +	btrfs_qgroup_free_data(inode, NULL, file_offset, cur_len, NULL);
> +	btrfs_dec_block_group_reservations(fs_info, ins->objectid);
> +	btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset, true);
> +	mapping_set_error(inode->vfs_inode.i_mapping, -EIO);
> +	*ret_alloc_size = cur_len;
> +	/*
> +	 * We should not return -EAGAIN where it's a special return code for
> +	 * zoned to catch btrfs_reserved_extent().
> +	 */
> +	ASSERT(ret != -EAGAIN);
> +	return ret;
> +}

[ ... ]


