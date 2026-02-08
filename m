Return-Path: <linux-btrfs+bounces-21497-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKkjJULdiGkQxgQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21497-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 20:00:18 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9839109F46
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 20:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC83B300CE67
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Feb 2026 19:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9522F305E19;
	Sun,  8 Feb 2026 19:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="JqU+PbSl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC397305057
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Feb 2026 19:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770577210; cv=none; b=iTvRv3HlmKvrg7qoCOfmmav8zebb+02V9WxgHf39t4Ptmu1UEipmWglg+UusyduXm6IjA3nri44xNTHDkR97DyQptHWgwbqtcNH4UvtvmCbHyAKeHAN3NLa36un7VVwfvBj4K+PmLELALuKYfvlc+xlAIWQ9RwUgj2l+E2Obnjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770577210; c=relaxed/simple;
	bh=jifUBomsuLDA9YnqWoENO2WOSbIf6YTI/+rljWRzVt4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gE12ZHOFbCmFU9Ljy/0R3MEGu3HCV4SzuPqgaCEx8HunHza5jFYyyMbwZWV5h3DdZMlJEnpw/6W0oWgB27hD83ZM1SJ9Y4r0fSm7x1GNR+//Vmwf+Dvg/+JfQdJiyWnoSiWXvzFSv4tkPC1Ve/j3U/TC0UmA6QzPCbIbS7g873s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=JqU+PbSl; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 618GVjsV1284089;
	Sun, 8 Feb 2026 11:00:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=X8u0WERQWq4NYKXD1HcmTIyXnsGD1bsdle8ld6Yn2cA=; b=JqU+PbSljthr
	neQn/7exa/tGCpX9Hm91bIA4H9fSQacc9BbI6dCxvVzZ2PwvWY8JRyWDB/nOGkXM
	PpCym60/HF8KQ2eKy9xw/pT1OKGn7IAsnhcXktwUBMiTE2BNBdkU6eB0VG3QTvZo
	p1AE18pRBWfWWjDMMbkj45Hq6KxbLwBO1JSOUcTFYz7PpHj+IhBL/9VFa5pApULm
	wg+8A/6oXZIXqrlI3F67KBH0X6yCcxmjL7CnUUfVhUCslECseKg/u9kQx/Hj2xuW
	1tRo29a8I7SZKXUvw7DqoWR/bQxI0wdu42qWewJsgFJtKZ4PpPFwr/mtqq2N+/wG
	EudA6299Tw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 4c6x33rsau-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 08 Feb 2026 11:00:06 -0800 (PST)
Received: from devbig003.atn7.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Sun, 8 Feb 2026 19:00:05 +0000
From: Chris Mason <clm@meta.com>
To: Boris Burkov <boris@bur.io>
CC: <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
Subject: Re: [PATCH 2/3] btrfs: check squota parent usage on membership change
Date: Sun, 8 Feb 2026 10:59:01 -0800
Message-ID: <20260208185947.1191113-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <5d170d19ba8d0494c77a638293cc66ecb8a66967.1764796022.git.boris@bur.io>
References: <cover.1764796022.git.boris@bur.io> <5d170d19ba8d0494c77a638293cc66ecb8a66967.1764796022.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: b1ijALiPLWqjgYdY-Y5lTOKff2M7gA4I
X-Proofpoint-GUID: b1ijALiPLWqjgYdY-Y5lTOKff2M7gA4I
X-Authority-Analysis: v=2.4 cv=KbnfcAYD c=1 sm=1 tr=0 ts=6988dd36 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=NEAV23lmAAAA:8 a=YuBLRphVnL6iPjch19kA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA4MDE2NCBTYWx0ZWRfX5T+g3Flr7Xg3
 uDzt32LF3E8BDDbuYI4jXDuH/zvz5m9G6qeL3M8siVUSkrgpmVUHaDuwnccud8VTnQgdhiH+KhF
 m30tbScuX1IPXemKktggXDEPVnEZizetCVmYfO3bajliA1byeUgWzTT11v82inqui0FetrCw6+h
 cHOcZFzXJfWZ627Wk0zm573gJLFxs7FOii5kUdUNE02nny/JPq7/0P3g4cHp6fEuo/YUcL2E8Cw
 HUd5RR3CKyiz9/b3SroObSrCFDpYAuQdrawDfluGiyMOqUP1z+7dEh1u82oWV8Rz2oA5Q+YMIVV
 V+1Yt5uZ6UlAofW9TJVXt3seeZE2povbEpxw0MQnh0fNSaCZ7jJoO/7Mk9ouyymjm0SBamh/5Hv
 7U7YGj/lMEZVKpsK3GHdHXfxkQ5rbmVxjyAdoCZ4UndfzUMb9757wGHcSaxLjOnGImBLj5iFhh3
 zj5J0JlXr0IR/sjsPLg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-05_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[meta.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21497-lists,linux-btrfs=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clm@meta.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:mid,meta.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D9839109F46
X-Rspamd-Action: no action

Boris Burkov <boris@bur.io> wrote:
> We could have detected the quick inherit bug more directly if we had
> an extra warning about squota hierarchy consistency while modifying the
> hierarchy. In squotas, the parent usage always simply adds up to the sum of
> its children, so we can just check for that when changing membership and
> detect more accounting bugs.

Hi everyone,

I'm running the btrfs for-next branch, along with the encryption patch set
through my AI review prompts:

https://github.com/masoncl/review-prompts

I'm working on some btrfs specific instructions, but hopefully these reviews
are already useful.  I've kept the headers to make it easier to double check
that I'm actually replying to the right email, but please let me know if any
parts of this are incorrect:

commit 9c46bcda5f347febdbb4d117fb21a37ffcec5fa4
Author: Boris Burkov <boris@bur.io>

btrfs: check squota parent usage on membership change

This commit adds a diagnostic check to detect squota hierarchy
consistency issues when modifying qgroup membership. The check verifies
that parent usage equals the sum of its children's usage.

> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 206587820fec0..3a74759b59ee4 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -346,6 +346,42 @@ int btrfs_verify_qgroup_counts(const struct btrfs_fs_info *fs_info, u64 qgroupid
>  }
>  #endif
>
> +static bool squota_check_parent_usage(struct btrfs_fs_info *fs_info, struct btrfs_qgroup *parent)
> +{
> +	u64 excl_sum = 0;
> +	u64 rfer_sum = 0;
> +	u64 excl_cmpr_sum = 0;
> +	u64 rfer_cmpr_sum = 0;
> +	struct btrfs_qgroup_list *glist;
> +	int nr_members = 0;
> +	bool mismatch;
> +
> +	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_SIMPLE)
> +		return false;
> +	if (btrfs_qgroup_level(parent->qgroupid) == 0)
> +		return false;
> +
> +	/* Eligible parent qgroup. Squota; level > 0; empty members list. */
> +	list_for_each_entry(glist, &parent->members, next_member) {
> +		excl_sum += glist->member->excl;
> +		rfer_sum += glist->member->rfer;
> +		excl_cmpr_sum += glist->member->excl_cmpr;
> +		rfer_cmpr_sum += glist->member->rfer_cmpr;
> +		nr_members++;
> +	}
> +	mismatch = (parent->excl != excl_sum || parent->rfer != rfer_sum ||
> +		    parent->excl_cmpr != excl_cmpr_sum || parent->rfer_cmpr != excl_cmpr_sum);
                                                                            ^^^^^^^^^^^^^^^^

Is parent->rfer_cmpr being compared to the wrong variable? The code
compares parent->rfer_cmpr to excl_cmpr_sum, but rfer_cmpr_sum was
calculated above and never used. Should this be comparing
parent->rfer_cmpr != rfer_cmpr_sum instead?

> +
> +	WARN(mismatch,
> +	     "parent squota qgroup %hu/%llu has mismatched usage from its %d members. "
> +	     "%llu %llu %llu %llu vs %llu %llu %llu %llu\n",
> +	     btrfs_qgroup_level(parent->qgroupid),
> +	     btrfs_qgroup_subvolid(parent->qgroupid), nr_members, parent->excl,
> +	     parent->rfer, parent->excl_cmpr, parent->rfer_cmpr, excl_sum,
> +	     rfer_sum, excl_cmpr_sum, rfer_cmpr_sum);
> +	return mismatch;
> +}

[ ... ]



