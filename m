Return-Path: <linux-btrfs+bounces-20995-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCwqGfYRdmldLQEAu9opvQ
	(envelope-from <linux-btrfs+bounces-20995-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Jan 2026 13:52:06 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D524C808FE
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Jan 2026 13:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 017CB300B9E4
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Jan 2026 12:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C906F318EFF;
	Sun, 25 Jan 2026 12:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="mSN+SxCj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7C415746E
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Jan 2026 12:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769345515; cv=none; b=jcFXKSME76zni4URZratSJ7yh8JFQXJt9MK8SZzmCFtKda81wpVcRin+ZH7Ihl8U24OOJjpUU90Z+GsucpCv3nG8XsRjFpCdESmtYtm535sOHonDD+4RsoTD6akwAAuy3W5PxhItYstIGT9kYdCdREmRvyOBNIKZ8kEvdEGk8R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769345515; c=relaxed/simple;
	bh=HlOCgTH1fOfGbVm5LDi32/GANFYOiWyAfa5bkEAXV84=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pmPftKEZO8M5GW6r2UO4mI2NrTqyEsLCab9d1rWT/vXerwgdliWRtFiZlQG/JTqXUSXCPM2+D2UvK1Rgv2nDjzhtCw0vzHAU1XZqD82AlMD97zju1zggNhhgF6y+EPtNZo+fvDNloT2lcvkYanozzxR/0c7OFUQvTLFr3ZVJtBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=mSN+SxCj; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60P7hcbr2190778;
	Sun, 25 Jan 2026 04:51:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=USk3PrSZpAy7Y5NKVv8r3qTbtMqzTP1loFlBYMBxOfI=; b=mSN+SxCjU2t4
	kYbf9wVyHNGYK5t3gSN+4za1t0XSwSQBlOxO9uEPkCrN+G6XPMpIJSEPfDT6QhW3
	6E5IdQ519JoY0YR8KlHC5YMrmHca8DajQs4MsqvzFiwZv7LImz2ZQ11GruBT7tVT
	kTIlQeM43Qq510+qAzTryfiSH9ZI3KBcV8wrjodUrcunax3PEw/ZZXp4O8RcRoxU
	OliyKZgHpXoE7SgQh3cuPBYxyQiTSwyHSfxbeLiOFwNMCZa/N8lnMpiHiGAq0oMz
	UXna6ziYKUR+9l+KENYoh7HBH+bAU8cVHr2UoGKjFvDE50shd217P7PN9LgQ6IcL
	HCLFk6eMkA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bvvn1nu56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 25 Jan 2026 04:51:49 -0800 (PST)
Received: from devbig003.atn7.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Sun, 25 Jan 2026 12:51:47 +0000
From: Chris Mason <clm@meta.com>
To: Mark Harmstone <mark@harmstone.com>
CC: <linux-btrfs@vger.kernel.org>, Boris Burkov <boris@bur.io>
Subject: Re: [PATCH v8 10/17] btrfs: handle deletions from remapped block group
Date: Sun, 25 Jan 2026 04:49:36 -0800
Message-ID: <20260125125129.2245240-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260107141015.25819-11-mark@harmstone.com>
References: <20260107141015.25819-1-mark@harmstone.com> <20260107141015.25819-11-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=X8df6WTe c=1 sm=1 tr=0 ts=697611e5 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=LWDUg-46AAAA:8
 a=ZEBlm8uLOMWBT5bI-sYA:9 a=0m5oFGktkVSl59jdpf0v:22
X-Proofpoint-ORIG-GUID: 70AuqlZM3EB6C5zh8PDwsfAmJrtGzhlb
X-Proofpoint-GUID: 70AuqlZM3EB6C5zh8PDwsfAmJrtGzhlb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI1MDEwNyBTYWx0ZWRfX4ElcBJFunBOm
 9lo3dsfCPrHaaB7ni/mXLC9RuEp/c8WRund71OGvMLH6tSs+OB7kY0imhwdyYs3Olztxz99pvj3
 YjiLAgAwc8Cm7sYAMNI0kPencoiT4A3i4PQRffRyRLPWxGUnnGH074Lg84kiAWvmbCyjfWJuIGP
 JzlnPq65gAEsBlhYX+nNMD2Ufip0gXhp+xx0C+xAfG50QO1jvhpqbxu596qXGdoRCKnGxgofBqO
 WhGoXgZynQ2pKVvptuImFylXpvT9mSR5Qko0fBKXQL+5DYXtnDKGg9RZ1BrCDFIjIIpZw9ziB3b
 60UFyNkg2VuMeJQAUxwJ8qKEJx8TaHF4c6KL5JRMkESETqNxUwTo7uWSbMNSL9IIX75GZTprNGF
 FllzkGQ61A6WUb9hZ7aajDvnarIG7g1m0hyX0o//Ltln/0VmG99We3oSQWux9/6HQknUKD3SrCD
 0LdQcMF1CQa+VQaar9g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-25_03,2026-01-22_02,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20995-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clm@meta.com,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[meta.com:+];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[harmstone.com:email,meta.com:mid,meta.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D524C808FE
X-Rspamd-Action: no action

Mark Harmstone <mark@harmstone.com> wrote:
> Handle the case where we free an extent from a block group that has the
> REMAPPED flag set. Because the remap tree is orthogonal to the extent
> tree, for data this may be within any number of identity remaps or
> actual remaps. If we're freeing a metadata node, this will be wholly
> inside one or the other.
> 
> btrfs_remove_extent_from_remap_tree() searches the remap tree for the
> remaps that cover the range in question, then calls
> remove_range_from_remap_tree() for each one, to punch a hole in the
> remap and adjust the free-space tree.
> 
> For an identity remap, remove_range_from_remap_tree() will adjust the
> block group's `identity_remap_count` if this changes. If it reaches
> zero we mark the block group as fully remapped.
> 
> For an identity remap, remove_range_from_remap_tree() will adjust the
> block group's `identity_remap_count` if this changes. If it reaches
> zero we mark the block group as fully remapped.
> 
> Fully remapped block groups have their chunk stripes removed and their
> device extents freed, which makes the disk space available again to the
> chunk allocator. This happens asynchronously: in the cleaner thread for
> sync discard and nodiscard, and (in a later patch) in the discard worker
> for async discard.

Hi everyone,

Another AI review from my recent linux-next run:

> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c

[ ... ]

> +int btrfs_last_identity_remap_gone(struct btrfs_chunk_map *chunk_map,
> +				   struct btrfs_block_group *bg)
> +{
> +	struct btrfs_fs_info *fs_info = bg->fs_info;
> +	struct btrfs_trans_handle *trans;
> +	int ret;
> +	unsigned int num_items;
> +	BTRFS_PATH_AUTO_FREE(path);
> +
> +	path = btrfs_alloc_path();
> +	if (!path)
> +		return -ENOMEM;
> +
> +	/*
> +	 * One item for each entry we're removing in the dev extents tree, and
> +	 * another for each device. DUP chunks are all on one device,
> +	 * everything else has one device per stripe.
> +	 */
> +	if (bg->flags & BTRFS_BLOCK_GROUP_DUP)
> +		num_items = chunk_map->num_stripes + 1;
> +	else
> +		num_items = 2 * chunk_map->num_stripes;
> +
> +	trans = btrfs_start_transaction_fallback_global_rsv(fs_info->tree_root, num_items);
> +	if (IS_ERR(trans))
> +		return PTR_ERR(trans);
> +
> +	ret = btrfs_remove_dev_extents(trans, chunk_map);
> +	if (unlikely(ret)) {
> +		btrfs_abort_transaction(trans, ret);
> +		return ret;
> +	}

Can this leak the transaction handle? btrfs_abort_transaction() marks
the transaction as aborted but does not end it. __btrfs_abort_transaction()
has a comment explaining cleanup happens in btrfs_end_transaction().

> +
> +	mutex_lock(&trans->fs_info->chunk_mutex);
> +	for (unsigned int i = 0; i < chunk_map->num_stripes; i++) {
> +		ret = btrfs_update_device(trans, chunk_map->stripes[i].dev);
> +		if (unlikely(ret)) {
> +			mutex_unlock(&trans->fs_info->chunk_mutex);
> +			btrfs_abort_transaction(trans, ret);
> +			return ret;
> +		}

Same question here about leaking the transaction handle.

> +	}
> +	mutex_unlock(&trans->fs_info->chunk_mutex);
> +
> +	write_lock(&trans->fs_info->mapping_tree_lock);
> +	btrfs_chunk_map_device_clear_bits(chunk_map, CHUNK_ALLOCATED);
> +	write_unlock(&trans->fs_info->mapping_tree_lock);
> +
> +	btrfs_remove_bg_from_sinfo(bg);
> +
> +	ret = remove_chunk_stripes(trans, chunk_map, path);
> +	if (unlikely(ret)) {
> +		btrfs_abort_transaction(trans, ret);
> +		return ret;
> +	}

And here as well - does this return path need btrfs_end_transaction()?

> +
> +	ret = btrfs_commit_transaction(trans);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}

[ ... ]

> +static int remove_range_from_remap_tree(struct btrfs_trans_handle *trans,
> +					struct btrfs_path *path,
> +					struct btrfs_block_group *bg,
> +					u64 hole_start, u64 hole_length)
> +{

[ ... ]

> +	if (!is_identity_remap) {
> +		struct btrfs_block_group *dest_bg;
> +
> +		dest_bg = btrfs_lookup_block_group(fs_info, new_addr);
> +		adjust_block_group_remap_bytes(trans, dest_bg, -overlap_length);
> +		btrfs_put_block_group(dest_bg);

btrfs_lookup_block_group() can return NULL if no block group is found
for the address. Every other caller checks for NULL before using the
result. Is a NULL check needed here before passing dest_bg to
adjust_block_group_remap_bytes()? That function does spin_lock(&bg->lock)
which would crash on a NULL pointer.

> +		ret = btrfs_add_to_free_space_tree(trans,
> +						   hole_start - remap_start + new_addr,
> +						   overlap_length);
> +		if (ret)
> +			return ret;
> +	}

[ ... ]

This is not a bug, but the commit message appears to have a duplicated
paragraph about identity remaps:

    For an identity remap, remove_range_from_remap_tree() will adjust the
    block group's `identity_remap_count` if this changes. If it reaches
    zero we mark the block group as fully remapped.

    For an identity remap, remove_range_from_remap_tree() will adjust the
    block group's `identity_remap_count` if this changes. If it reaches
    zero we mark the block group as fully remapped.


