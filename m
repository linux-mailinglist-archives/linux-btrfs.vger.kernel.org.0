Return-Path: <linux-btrfs+bounces-20994-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Nlg3KyQPdmmBLAEAu9opvQ
	(envelope-from <linux-btrfs+bounces-20994-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Jan 2026 13:40:04 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF427808C4
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Jan 2026 13:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95EC0300BDB8
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Jan 2026 12:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69515318EFF;
	Sun, 25 Jan 2026 12:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="N63nRCgA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1371DDF3
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Jan 2026 12:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769344795; cv=none; b=YKrrw4AHebpWrA0/xZsS+XoKLUVF8gzeTjHmOGSC35xOJOCrHkm+72XFakX1+Qglgle//f67SX2KH9isPmFFSU+btKKjACbLpZ+WRTCv761/wOW5WiZdKwgTyeymVxHci/xu2R06xJ9mbmInM69rke6OuMBZS9TSFxVfUv0/X0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769344795; c=relaxed/simple;
	bh=YGGtJ+X6IqBH6b9KvMIUTQDXoVR3zgB4weQLsodUss0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V0G/z/K2AE9MzkJX36sN3++6XufRVS3t0gyX8LNapQsGBF9+/mARHGq0s5tW0si6iH8/RoHdlDWR7t5Ib4nw0XreTopdckfFdq9bNi2UMzJruQdS87kD5JnOaROjXZ71H11KzIL0LKV//xjN98U48Ky0b99YXNZ+UVOOq1WtQWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=N63nRCgA; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60P6YWnF1628392;
	Sun, 25 Jan 2026 04:39:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=8TuSuEeYCXTXuMxl62vOaTMfWCWLPl5eU+ykEnxgN58=; b=N63nRCgArdYJ
	07zWXD4sfP/C4d05q21OBgQIC9REtv/lUeQMHV26kF2ogl15WuQ8tSb3bcqNDkDN
	k/i6ZwK3mgAggwK97sNjntw1G/aY88wxWYOJkeD+SVubUW7BszvMvioU3aMAn+HE
	CTlBEkh7j4WKcRSdjxFPxMPiE084wZXskSTXxGWMHeJ+P4RiEV4DZY73N1zkubtQ
	P1ZhrocAcr5Wjl9/RS1yfixqUGSmdVEN7LuwoEmUU0B2ypnq+nbzkM4qO7OlQwHK
	4KWDFF6LB5ooP6clHcDcDlMZKJddWXktY+sGgHtJGCPHX7lksBnBkZVk8Z4F8opT
	DDApABlV7g==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bvu01x6te-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 25 Jan 2026 04:39:48 -0800 (PST)
Received: from devbig003.atn7.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Sun, 25 Jan 2026 12:39:35 +0000
From: Chris Mason <clm@meta.com>
To: Mark Harmstone <mark@harmstone.com>
CC: <linux-btrfs@vger.kernel.org>, Boris Burkov <boris@bur.io>
Subject: Re: [PATCH v8 12/17] btrfs: move existing remaps before relocating block group
Date: Sun, 25 Jan 2026 04:38:06 -0800
Message-ID: <20260125123908.2096548-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260107141015.25819-13-mark@harmstone.com>
References: <20260107141015.25819-1-mark@harmstone.com> <20260107141015.25819-13-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=UaVciaSN c=1 sm=1 tr=0 ts=69760f14 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=LWDUg-46AAAA:8
 a=tbFFEX0_jrYaF2LSth4A:9 a=0m5oFGktkVSl59jdpf0v:22
X-Proofpoint-GUID: 29DdiQYgvWL0mLlb1ZZvFgkPmsXBlcF-
X-Proofpoint-ORIG-GUID: 29DdiQYgvWL0mLlb1ZZvFgkPmsXBlcF-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI1MDEwNCBTYWx0ZWRfX8tL5lWLiT9n6
 VUd6F+X+Vhxy0Bq2qHZJ3jcFraszU8DGggTzwbvTi4yy0AuQQyp6COQ/nlmRuHcz2GbczI8URex
 mhoLXuraCoESlXA4qLe9sf6Olbu65N3z7kenV3RHuFLk4Urr4/5yIrmdDuz0PG7eUekIooliA+0
 LzgrtPxNCG5QOpPfehWBGgxvqrAYldWzNSa/fOodZi4UdQGmDy3KufgicAskSQ8N23ka1znwu8R
 WVYU0ELQmYdyz8M5mxLIsZTtQIER3gFf+KNxCA4BFx0iIVwYU/8uDOz7ivhIVhlobeb3q241GtC
 1nUKNO6OA84Ferf+bdgPgQ9vsZzixi4KCQl0JaWhzzuTYjytq0uzBLdIhlaVJNVrEw0w98XYf9h
 BKNUmJIGqnZ3Acx5gNFBLB6zdm4sqgWqnj0HO/XU9LJSyva0LmMMHXkGuVZtL1kRKFCI2jr3CSi
 DWV0uqEtfgs/tuimd4Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-25_02,2026-01-22_02,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[meta.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20994-lists,linux-btrfs=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clm@meta.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EF427808C4
X-Rspamd-Action: no action

Mark Harmstone <mark@harmstone.com> wrote:
> If when relocating a block group we find that `remap_bytes` > 0 in its
> block group item, that means that it has been the destination block
> group for another that has been remapped.
> 
> We need to seach the remap tree for any remap backrefs within this
> range, and move the data to a third block group. This is because
> otherwise btrfs_translate_remap() could end up following an unbounded
> chain of remaps, which would only get worse over time.
> 
> We only relocate one block group at a time, so `remap_bytes` will only
> ever go down while we are doing this. Once we're finished we set the
> REMAPPED flag on the block group, which will permanently prevent any
> other data from being moved to within it.

Hi everyone,

One more AI review from linux-next, this looks valid to me:

> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c

[ ... ]

> +static int move_existing_remap(struct btrfs_fs_info *fs_info,
> +			       struct btrfs_path *path,
> +			       struct btrfs_block_group *bg, u64 new_addr,
> +			       u64 length, u64 old_addr)
> +{

[ ... ]

> +	dest_bg = btrfs_lookup_block_group(fs_info, dest_addr);
> +
> +	adjust_block_group_remap_bytes(trans, dest_bg, dest_length);
> +
> +	mutex_lock(&dest_bg->free_space_lock);
> +	bg_needs_free_space = test_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE,
> +				       &dest_bg->runtime_flags);
> +	mutex_unlock(&dest_bg->free_space_lock);
> +	btrfs_put_block_group(dest_bg);
> +
> +	if (bg_needs_free_space) {
> +		ret = btrfs_add_block_group_free_space(trans, dest_bg);
                                                         ^^^^^^^

Is there a use-after-free here? btrfs_put_block_group() is called above,
which can free the block group if the refcount drops to zero. Then
btrfs_add_block_group_free_space() dereferences dest_bg by calling
mutex_lock(&block_group->free_space_lock).

Perhaps the btrfs_put_block_group() call should be moved after the
conditional block that uses dest_bg?

> +		if (unlikely(ret))
> +			goto end;
> +	}

[ ... ]

> +static int move_existing_remaps(struct btrfs_fs_info *fs_info,
> +				struct btrfs_block_group *bg,
> +				struct btrfs_path *path)
> +{
> +	int ret;
> +	struct btrfs_key key;
> +	struct extent_buffer *leaf;
> +	struct btrfs_remap_item *remap;
> +	u64 old_addr;
> +
> +	/* Look for backrefs in remap tree. */
> +	while (bg->remap_bytes > 0) {
> +		key.objectid = bg->start;
> +		key.type = BTRFS_REMAP_BACKREF_KEY;
> +		key.offset = 0;
> +
> +		ret = btrfs_search_slot(NULL, fs_info->remap_root, &key, path, 0, 0);
> +		if (ret < 0)
> +			return ret;
> +
> +		leaf = path->nodes[0];
> +
> +		if (path->slots[0] >= btrfs_header_nritems(leaf)) {
> +			ret = btrfs_next_leaf(fs_info->remap_root, path);

[ ... ]

> +			leaf = path->nodes[0];
> +		}
> +
> +		btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
> +
> +		if (key.type != BTRFS_REMAP_BACKREF_KEY) {
> +			path->slots[0]++;

When the slot is incremented here because the key type does not match,
should the key be re-read from the new slot? The code below reads
the remap item from path->slots[0] (the incremented slot), but then
passes key.objectid and key.offset (from the old slot) to
move_existing_remap().

If the key at the new slot has different objectid/offset values than
the previous slot, this would pass mismatched address and length values
to move_existing_remap().

> +
> +			if (path->slots[0] >= btrfs_header_nritems(leaf)) {
> +				ret = btrfs_next_leaf(fs_info->remap_root, path);

[ ... ]

> +				leaf = path->nodes[0];
> +			}
> +		}
> +
> +		remap = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_remap_item);
> +		old_addr = btrfs_remap_address(leaf, remap);
> +
> +		btrfs_release_path(path);
> +
> +		ret = move_existing_remap(fs_info, path, bg, key.objectid,
> +					  key.offset, old_addr);

[ ... ]


