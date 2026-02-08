Return-Path: <linux-btrfs+bounces-21487-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uG2iBXy2iGkrvAQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21487-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 17:14:52 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B356B109603
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 17:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0094E305E9DC
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Feb 2026 16:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B290934F47C;
	Sun,  8 Feb 2026 16:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ZhPEDhhO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9C734CFDD
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Feb 2026 16:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770567108; cv=none; b=WNqt04eDnUKUvtuFkKwmnbQafGDBdm9Oam1NiLrQc40SvdcFB9UOkxdKa3ByfUMUYxPWYt5dGuCDCoVA/9fR0CzhQL2ocDktKNjySqRf+sjhQ54D0zXCekkGHy20Vaza3/Un3OpBMS64ai58UWhy6xC7vr+wfQVDFsM0n2Gp2qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770567108; c=relaxed/simple;
	bh=3ZynPs/sLnQDZHEWrPcFsRyNU2kuQE5J9Y+SstnxLhU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aZRw54fd3BCsXAAzeVF7BjCE3XGe3at7BLVWYKWt9oUO3Ryd90JZG/54nPSq7xa3X6GZYcgaNR7AMQzcKmIa2QTC8C568l01/0fcj91lD6hTVulQjf/F9NssaPz0Z5pfz0/Y+iqZMis1+q3sJYz0NgilSlMmSPEEoyH5yU8ysK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ZhPEDhhO; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6184k1sl1718377;
	Sun, 8 Feb 2026 08:11:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=we9ZngqAOP9+FOpc6/ZZkeSy4dFEDN+tWpRIRxDoDyw=; b=ZhPEDhhOlJ+F
	SfyyQRU9lm0Drn090waHKiAZEszWLA2BUzWlkER55WcHC6P73N4Gn1avQ8yb9Grr
	SeixW9NAgOvOs02shFhqENRFIKc/6uwuS+Wq06A2neROh3LXc7Mj9wP673iwE6vx
	2+OATpDq1xqs/86TO6sVd6l9fYrkJZRYSmwYYku3e4scg6gMBbPzwi1H4ZgoSAZT
	8IUJltUFTxvOwXQTmiDzZ/SB3phGhGK6TF5aAwH5ZPgKnmbeBtnJ7OSQnFRXPs+t
	J/i8wcp/sTiWi4zzl4FuBvVBFMzWuo1PAt/5hsjosKVRUIbkP3f06rios8LrDqOw
	j7cDS2Eppg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c63c9gve3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 08 Feb 2026 08:11:45 -0800 (PST)
Received: from devbig003.atn7.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Sun, 8 Feb 2026 16:11:44 +0000
From: Chris Mason <clm@meta.com>
To: <fdmanana@kernel.org>
CC: <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 16/19] btrfs: remove out label in finish_verity()
Date: Sun, 8 Feb 2026 08:10:44 -0800
Message-ID: <20260208161129.3888234-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <1974159cc321acb84acea5ccef0427592a576cad.1768993725.git.fdmanana@suse.com>
References: <cover.1768993725.git.fdmanana@suse.com> <1974159cc321acb84acea5ccef0427592a576cad.1768993725.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: FAzTo5xYBSt7Jo-CX_m3I9eT-Dyg9Zja
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA4MDEzOSBTYWx0ZWRfX7DtVKazKCx/a
 oghywWTENDuYNUfIVdB4WlWBJmXAzfrsDfjBlafRMkhEWPniX3D/0XjvS228CnZv8n2uIH0Q0Nw
 uP0Cm+J0FJN7GN8w6BBRQcxVN9CpMnmssocrk54uSId0PKmZJ6irnKza+J43DCcsRBNkWv+RjPB
 8+F9zPQVsolITVloTOY7aju/Z6rp2fWpNOStnarM4361PalOp3P6mG4I07SHXVKObUssl5gnAej
 9XtJTl4aVXFLOWXEPvizh3hnqznCEnYLnf9wP+2UybG/Zi6MF16PgCbzyZ+ZEseSqeGGxFndqSZ
 Ax37TEB8+9eu9QV6W2X8poE3bwc5WaCv8bxA0VqBTIr2tIOcjLpfJK6zukAepm4xTIonlichn4z
 5X0y3uPw75JpDY8yg/jT1EFz0aaWod1S5gx1nHDw058t8+OuABFHDV2CcEW9kxPxKvjHRhTejmN
 OkxI3Zf1Z48141TTFeA==
X-Proofpoint-GUID: FAzTo5xYBSt7Jo-CX_m3I9eT-Dyg9Zja
X-Authority-Analysis: v=2.4 cv=H5fWAuYi c=1 sm=1 tr=0 ts=6988b5c1 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8
 a=OOPYNT28nISv832xqnIA:9 a=WzC6qhA0u3u7Ye7llzcV:22
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21487-lists,linux-btrfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B356B109603
X-Rspamd-Action: no action

fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> There is no point in having the label since all it does is return the
> value in the 'ret' variable. Instead make every goto return directly
> and remove the label.

Hi everyone,

I'm running the btrfs for-next branch, along with the encryption patch set
through my AI review prompts:

https://github.com/masoncl/review-prompts

I'm working on some btrfs specific instructions, but hopefully these reviews
are already useful.  I've kept the headers to make it easier to double check
that I'm actually replying to the right email, but please let me know if any
parts of this are incorrect:

commit 61fb7f04ee06e6c7e113a490af1a057f958f1d05
Author: Filipe Manana <fdmanana@suse.com>

btrfs: remove out label in finish_verity()

This commit refactors the finish_verity() function by removing the 'out'
label and making error paths return directly. The goal is to simplify the
control flow.

> diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
> index a2ac3fb68bc85..06cbd6f00a78c 100644
> --- a/fs/btrfs/verity.c
> +++ b/fs/btrfs/verity.c

[ ... ]

> @@ -554,8 +552,7 @@ static int finish_verity(struct btrfs_inode *inode, const void *desc,
>  	btrfs_set_fs_compat_ro(root->fs_info, VERITY);
>  end_trans:
>  	btrfs_end_transaction(trans);
> -out:
> -	return ret;
> +	return 0;
>

Does this change introduce an error handling regression? When
btrfs_update_inode() or del_orphan() fail (lines 546, 549), execution
jumps to the end_trans label which now returns 0 instead of returning the
error code in 'ret'.

Looking at btrfs_end_enable_verity() at line 632:

    ret = finish_verity(inode, desc, desc_size);
    if (ret)
        goto rollback;

If finish_verity incorrectly returns 0 on these failures, the caller will
not trigger its rollback mechanism, leaving the inode in an inconsistent
state. The verity flag changes (BTRFS_INODE_RO_VERITY set at line 543)
would not be persisted to disk and the orphan item would not be properly
removed.

The original code correctly returned 'ret' via the 'out' label. Should the
end_trans label also return 'ret' instead of 0?

>  }


