Return-Path: <linux-btrfs+bounces-21488-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIAeL8i3iGkrvAQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21488-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 17:20:24 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 661E4109675
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 17:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F2CF3046BB3
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Feb 2026 16:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F67372B45;
	Sun,  8 Feb 2026 16:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="pEnieuZZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FB134A789
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Feb 2026 16:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770567437; cv=none; b=iKq5vOdL3FnGvAFePDJv64yL2jvDGEPy0HKLk1HZWdhKZ2WFfNwu7aTOwyQVOC7RvLUdUMmPkwhTmc+DPFjJaJvqmn5QHy0S1M51didZjusNbxMa/k1qWKRcingp7GbRjZHbzufCQ6da0Ae+wH+V568KCjw6CnWf5gcPFPlxDN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770567437; c=relaxed/simple;
	bh=qLm8Oi4bPgYeSPaUetgZopS89RdH2WUEsoVWzL1uJhc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nuE076jMab57PosyVkpWQyfxz91Ro0Sh3QH9W/+HyyNbhmbHbLMGPnR6L58yfftyyLuTYQmCoFZVIge1ZrDczu2+3QJPxhYA/9ndQmItacS47WnnYwgelnWH6k9gZg8bphm9iYV9kHfvX3tFT5MEOeATy7cMKczTPXRp3uGN5kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=pEnieuZZ; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6182E2ud1888399;
	Sun, 8 Feb 2026 08:17:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=abHJ9zKDsvRxMLkC+/4pvjTawCHbRvVF/3KCQ0WdUos=; b=pEnieuZZjtWq
	CRkcMxACg0a/E6kyLRyBSHAUGNDeWLHAuOrSfGlK8xav3CrWCE8z3xxzBrV0Fj+t
	+W2GhbeTVddQDfxSVUUX9gf9kLZUOyx13p85K2u091Gfzt8kg2Eytf1NK3VWyTvI
	Ofbvpnch8CPn8iAPa5DhEPd4ExuRIFGVjMslWbdUFAqvHIH9qpdsuPdU+TqzjLsm
	F8dVkAasVeeod8JvnqJ0wYNbQp1X3sZqMsvFzYFoP7DN1Cse4BcybVVf3ufo/dpJ
	stSZfe7IxP5SXx34bnts5iqC1lMaYNZ49Wcok2wk51hWYp0o0HMtiHbYcr1kAfVe
	xPnwl5WQbA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c67ycf8pc-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 08 Feb 2026 08:17:13 -0800 (PST)
Received: from devbig003.atn7.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Sun, 8 Feb 2026 16:17:12 +0000
From: Chris Mason <clm@meta.com>
To: <fdmanana@kernel.org>
CC: <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/2] btrfs: deal with missing root in sample_block_group_extent_item()
Date: Sun, 8 Feb 2026 08:16:33 -0800
Message-ID: <20260208161657.3972997-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <30034e48a39502638fbac40662914132895cca4b.1769028677.git.fdmanana@suse.com>
References: <cover.1769028677.git.fdmanana@suse.com> <30034e48a39502638fbac40662914132895cca4b.1769028677.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA4MDE0MCBTYWx0ZWRfXwNRc+9/okv2e
 UABAJ6Zrx0gY47xR1rUuuvjOtjp0+SeOAXBrzta6hPd+e8832nBf9IidsQRvX7E4i5o9S5RPBvr
 Hr+HTWpMe24I/t/YZnh1wsgN21HLATVZ7cv/GdYP4MqHiYhJCtn2vUuXbbccpgDTPJq4R/wIKyB
 mhwtuHQ7RSx54TmS7VoCuR3rgH2HdxaqG8iJ8aNvVc2WHsbqGizsakRrC0bfLbazcQvapE70dWB
 11v8YetIzqf6mwSoCPpmuYDsd0KKxuUSuf2QV4UfxcgXGMVuEo8eQDDhxCnugrvVsdMJlJ1+l0D
 /8QL+mfMYzqGC1JFym4pkI9BeYccnsahz8umjgwuHL8tWdj0VP8ocvxRBaZ5VaX66mIM4uAI9Ve
 ltRRmxkdR3TNwrDSgfP336QHVMsHS5utsVCOxjdF982AfvgcQWj2sJBgTazabe0E3PfwZDnEUiW
 FHtvl60s0BP4xn6Xnhw==
X-Proofpoint-ORIG-GUID: f0DNI3Hf5Pnq8FI4iQwNGeRC9ePb3ZbK
X-Authority-Analysis: v=2.4 cv=PomergM3 c=1 sm=1 tr=0 ts=6988b709 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8
 a=PdGY9H71u8uL4sseGzYA:9 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-GUID: f0DNI3Hf5Pnq8FI4iQwNGeRC9ePb3ZbK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_04,2026-02-05_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21488-lists,linux-btrfs=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clm@meta.com,linux-btrfs@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[meta.com:+];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 661E4109675
X-Rspamd-Action: no action

fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> In case the does not exists, which is unexpected, btrfs_extent_root()
> returns NULL, but we ignore that and so if it happens we can trigger
> a NULL pointer dereference later. So verify if we found the root and
> log an error message in case it's missing.

Hi everyone,

I'm running the btrfs for-next branch, along with the encryption patch set
through my AI review prompts:

https://github.com/masoncl/review-prompts

I'm working on some btrfs specific instructions, but hopefully these reviews
are already useful.  I've kept the headers to make it easier to double check
that I'm actually replying to the right email, but please let me know if any
parts of this are incorrect:

commit a8bec25e014eab671ec8a25b03d391cad3e55230
Author: Filipe Manana <fdmanana@suse.com>

btrfs: deal with missing root in sample_block_group_extent_item()

This commit adds a NULL check for extent_root after calling
btrfs_extent_root() in sample_block_group_extent_item(), addressing
a potential NULL pointer dereference.

> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 66c512bc022c5..28aa87872f0d9 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -607,6 +607,12 @@ static int sample_block_group_extent_item(struct btrfs_caching_control *caching_
>  	lockdep_assert_held_read(&fs_info->commit_root_sem);
>
>  	extent_root = btrfs_extent_root(fs_info, block_group->start);
> +	if (unlikely(!extent_root)) {
> +		btrfs_err(fs_info,
> +			  "missing extent root for block group at offset %llu",
> +			  block_group->start);
> +		return -EUCLEAN;
> +	}
>
>  	search_offset = index * div_u64(block_group->length, max_index);
>  	search_key.objectid = block_group->start + search_offset;

Does load_extent_tree_free() in the same file have the same issue?

Looking at load_extent_tree_free() around line 741:

	last = max_t(u64, block_group->start, BTRFS_SUPER_INFO_OFFSET);
	extent_root = btrfs_extent_root(fs_info, last);

and then at line 767:

	ret = btrfs_search_slot(NULL, extent_root, &key, path, 0, 0);

There's no NULL check between the btrfs_extent_root() call and the
btrfs_search_slot() call. If btrfs_extent_root() returns NULL (via
btrfs_global_root() when rb_find() fails), extent_root would be
dereferenced in btrfs_search_slot(), causing a NULL pointer
dereference.

Both sample_block_group_extent_item() and load_extent_tree_free() are
called from caching_thread() during block group caching operations, so
they have the same risk profile. Should load_extent_tree_free() have
the same NULL check added?

