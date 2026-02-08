Return-Path: <linux-btrfs+bounces-21495-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id J/YnBcDbiGnYxQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21495-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 19:53:52 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D39B109F18
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 19:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 530B83002B68
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Feb 2026 18:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1182FF16F;
	Sun,  8 Feb 2026 18:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="mIoy8bTI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB661D7E5C
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Feb 2026 18:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770576823; cv=none; b=gGRqjAkwXG8GZDXD6ZdIY+lvq6B6PtfeVeEMcs4hBGIa9/peLun7dnoheu7TlYC1R4EhembS4eCCu4abzK/cbB4JmcIXR4SZ0Jl8uhj8hMJInAqjY8dZmnuWOb//1WgA+aOInau9dMEe6T4Xk04I+q7Z/Wf6rXOEUz/NKFv2WF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770576823; c=relaxed/simple;
	bh=17Q8nhcqjKyxDmfg+8fBvPDS4uxPpjV28hRzYu+ns9o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KHsZMSLDlzxXabdk2tqc9VTkSu30rDSH7UrwmGEVd1Sx2zOmKH/h+n0A7JDG+D1K8j/DK0rs2LXjhqEM3sigkY5f8TZ2ExoINATI14J3kaHNWgUWSHWSOlAK+jNGllA/Ed13ecXn4F4rqecikkjmoxD9cg7RpQCgP+y93r4U/Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=mIoy8bTI; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 618IVw7Z116525;
	Sun, 8 Feb 2026 10:53:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=hB0r10CAckrr/UB6Ft7NSJf2nuQOiRmsyWLV5YbogtI=; b=mIoy8bTIuQEH
	z28tpFlbgI4LHYH3IgYCVBbW7RLhk4seS5yBUUjnTS2mJuxhj1uSoqdQZANGPYU5
	2yQslC8ZYspV5mjz03vqNEszPVp0X63cxPwtew4SoWteNQc9sKoP22kL0QGRHazN
	aH5G84UV5iGAmLF8BtD7vSntBwQL8yIYJB1eL9ZhRzqYsGKCJGdd3AP6aaLaMrGy
	7Kq4nv/saIVSmakVlOTGyNYyEUDTJr7baboW4WqPuSeuR8JvjLQOS1GY4cEES3ya
	MMR5JGxJghTU7EDiOqreoKP8WbIlifASwzXRUHLYrgxAcntt3e6Q3a6Aft+FeYS0
	PEAG11oQNQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4c6yuq03wt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 08 Feb 2026 10:53:36 -0800 (PST)
Received: from devbig003.atn7.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Sun, 8 Feb 2026 18:53:35 +0000
From: Chris Mason <clm@meta.com>
To: <fdmanana@kernel.org>
CC: <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/4] btrfs: use single return variable in btrfs_find_orphan_roots()
Date: Sun, 8 Feb 2026 10:52:30 -0800
Message-ID: <20260208185321.1128472-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <d95588f0ae2023c3b12817f868b26929eceb63b5.1765899509.git.fdmanana@suse.com>
References: <cover.1765899509.git.fdmanana@suse.com> <d95588f0ae2023c3b12817f868b26929eceb63b5.1765899509.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=WZUBqkhX c=1 sm=1 tr=0 ts=6988dbb0 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8
 a=zao4ZBXs9oaaGhchSo0A:9 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-ORIG-GUID: B-aMYQP6SmLQfuTcT5Wfv5pBr0AefexJ
X-Proofpoint-GUID: B-aMYQP6SmLQfuTcT5Wfv5pBr0AefexJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA4MDE2MyBTYWx0ZWRfX2eql+v4Ee0m3
 uV5QwUpc4NovCSQxBy+QpmXrwkxb7OSnIKsK21LAvVNjR8W9f0mb6eQPClXoAS5Q06JVF/5jMcM
 eeewNzyHxz0vu9fD3hMv2Jl/qkCEyNwdyKVxlGoRCxBg18lqRRqL0246dcEE0Ra6on/KA2Qb3S+
 +02yjJBu71F4cTcoIFttYYdAKbzXTW+mkmZWnZcwSOrr9kIWHqe+YzmBh6JJ85/k/YsvJmoZxKc
 PyZk1b7ZWvgEIv2lbCZqW5IQSHqY3agdNEoM1h7Ed2iMUQBt6n1j8MgSegh/HrK8+Yoe+19i7uA
 DJmC82vYKQ1tI6RQaEq/7cwrO7q/2ft6lkCHrYzEUD5HmND1qkRw06OcuXO2dNg5qsqHrTpVnQh
 WQvHC8aXl5h+G0TytdBz1TmEqQo4udhMES38RzbHk0Q1cGjn4wFG6bwL3lPdctQusz0zt69c/WO
 T3a+YC+xXXHrwb9AL6A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-05_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21495-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clm@meta.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,meta.com:mid,meta.com:dkim]
X-Rspamd-Queue-Id: 1D39B109F18
X-Rspamd-Action: no action

fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We use both 'ret' and 'err' which is a pattern that generates confusion
> and resulted in subtle bugs in the past. Remove 'err' and use only 'ret'.
> Also move simplify the error flow by directy returning from the function
> instead of breaking of the loop, since there are no resources to cleanup
> after the loop.

Hi everyone,

I'm running the btrfs for-next branch, along with the encryption patch set
through my AI review prompts:

https://github.com/masoncl/review-prompts

I'm working on some btrfs specific instructions, but hopefully these reviews
are already useful.  I've kept the headers to make it easier to double check
that I'm actually replying to the right email, but please let me know if any
parts of this are incorrect:

commit 8670a25ecb2fbc35d4e58f8f522e7d5b735d6778
Author: Filipe Manana <fdmanana@suse.com>

btrfs: use single return variable in btrfs_find_orphan_roots()

This commit refactors btrfs_find_orphan_roots() to use a single return
variable 'ret' instead of both 'ret' and 'err', and simplifies the error
flow by directly returning from the function instead of breaking out of
the loop.

> diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
> index 6a7e297ab0a7a..a7171112d638f 100644
> --- a/fs/btrfs/root-tree.c
> +++ b/fs/btrfs/root-tree.c

[ ... ]

> @@ -217,8 +217,6 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
>  	BTRFS_PATH_AUTO_FREE(path);
>  	struct btrfs_key key;
>  	struct btrfs_root *root;
> -	int err = 0;
> -	int ret;
>
>  	path = btrfs_alloc_path();
>  	if (!path)
> @@ -230,20 +228,19 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
>
>  	while (1) {
>  		u64 root_objectid;
> +		int ret;
>
>  		ret = btrfs_search_slot(NULL, tree_root, &key, path, 0, 0);
> -		if (ret < 0) {
> -			err = ret;
> -			break;
> -		}
> +		if (ret < 0)
> +			return ret;
>
>  		leaf = path->nodes[0];
>  		if (path->slots[0] >= btrfs_header_nritems(leaf)) {
>  			ret = btrfs_next_leaf(tree_root, path);
>  			if (ret < 0)
> -				err = ret;
> -			if (ret != 0)
> -				break;
> +				return ret;
> +			else if (ret > 0)
> +				return 0;
>  			leaf = path->nodes[0];
>  		}
>
> @@ -252,34 +249,33 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
>
>  		if (key.objectid != BTRFS_ORPHAN_OBJECTID ||
>  		    key.type != BTRFS_ORPHAN_ITEM_KEY)
> -			break;
> +			return 0;
>
>  		root_objectid = key.offset;
>  		key.offset++;
>
>  		root = btrfs_get_fs_root(fs_info, root_objectid, false);
> -		err = PTR_ERR_OR_ZERO(root);
> -		if (err && err != -ENOENT) {
> +		ret = PTR_ERR_OR_ZERO(root);
> +		if (ret && ret != -ENOENT) {
>  			break;
                        ^^^^

Does this code lose the error code from btrfs_get_fs_root()?

The refactoring moved 'int ret' from function scope (line 217 in the old
code) to loop scope (inside the 'while (1)' loop). When btrfs_get_fs_root()
fails with an error like -ENOMEM or -EIO, the code breaks out of the loop.
However, the 'ret' variable containing the error is scoped to the loop body
and goes out of scope after the break.

The function then returns 0 at line 303, losing the error code. This
violates the commit message's stated intent to "directly return from the
function instead of breaking of the loop."

Looking at btrfs_get_fs_root() in fs/btrfs/disk-io.c, it can return:
- -ENOMEM if path allocation fails (line 1316)
- -EIO or other errors from btrfs_read_tree_root() (line 1301)
- errors from btrfs_init_fs_root() (line 1310)
- -EIO from btrfs_search_slot() (line 1323)

If btrfs_get_fs_root() fails during mount due to memory pressure or I/O
errors, the mount will succeed instead of failing. This can lead to
filesystem corruption because the orphan root handling is incomplete but the
mount proceeds anyway.

Shouldn't this 'break;' be 'return ret;' to match all the other error paths
in the refactored function?

> -		} else if (err == -ENOENT) {
> +		} else if (ret == -ENOENT) {
>  			struct btrfs_trans_handle *trans;
>
>  			btrfs_release_path(path);
>
>  			trans = btrfs_join_transaction(tree_root);
>  			if (IS_ERR(trans)) {
> -				err = PTR_ERR(trans);
> -				btrfs_handle_fs_error(fs_info, err,
> +				ret = PTR_ERR(trans);
> +				btrfs_handle_fs_error(fs_info, ret,
>  					    "Failed to start trans to delete orphan item");
> -				break;
> +				return ret;
>  			}
> -			err = btrfs_del_orphan_item(trans, tree_root,
> -						    root_objectid);
> +			ret = btrfs_del_orphan_item(trans, tree_root, root_objectid);
>  			btrfs_end_transaction(trans);
> -			if (err) {
> -				btrfs_handle_fs_error(fs_info, err,
> +			if (ret) {
> +				btrfs_handle_fs_error(fs_info, ret,
>  					    "Failed to delete root orphan item");
> -				break;
> +				return ret;
>  			}
>  			continue;
>  		}


