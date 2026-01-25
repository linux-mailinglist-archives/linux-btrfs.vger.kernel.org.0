Return-Path: <linux-btrfs+bounces-20996-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cxbGF5sTdmm9LQEAu9opvQ
	(envelope-from <linux-btrfs+bounces-20996-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Jan 2026 13:59:07 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8728090C
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Jan 2026 13:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C398300B10C
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Jan 2026 12:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE294319609;
	Sun, 25 Jan 2026 12:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="WxuV/hAX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E0F191F91
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Jan 2026 12:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769345939; cv=none; b=sq0t4/4c+0s9aBIZvP5EzIVqsSYH61I19EhYwTTNyNGvXsGLDCHG3sBsX26WPXgSXDF3JTvrZTTRw9eBKWrPIU23ITwkzSNAuAHHSB4uQd+FUkoYpsqJHjlWv7ivzeIfKTdoP7H0xd9I7LA6kD2ylDkzkjSX9TDODByrO9FXbWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769345939; c=relaxed/simple;
	bh=YkwuxO2/nwbBW+CyReQ6KE/BaBlwoV7KE4xo83r809Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UTvEcsnkH1DhkJQOyYR5OYoSPOKxo/VTMKA7zvrrULAl5/RNyqARZshcOyCaycVuFDqAIf0bnWgIg4z7oyK7Z4Bne/a4s8n6jHZD1FugyjRSdpwwK8voZ8u8gO4SzV16SdMrVkOkjRysDcZPyWqcDayA6Aot0aJFU81P28VcSIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=WxuV/hAX; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60PCapHb2296954;
	Sun, 25 Jan 2026 04:58:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=a1NosjiqzKKaVmtrTlz5vs9Zqq1/7oaukzO5M+qIFKc=; b=WxuV/hAX6Xzk
	myw3d65NUFQ41J9ckT1ZuCJdAyyoI3y5Y3xUv90z86/11uk6GLOkHVWyhLuxG5cH
	xbi2ZmAkaXx9FPUSoE0Q6TI5oW3hMeuFFPB+xDaFevG8wHpdXtKVxgl4XH4or6Zy
	+eMPGwmcyamLYgQ9zZ9RalN1yQHn7ojiF3qb/FmvGhRQWBmrdM3sFMr+C+D08QQh
	LdCU8udpPFVD39Qi2fqDxNpZDtQ4gsvDOPlzRPZFsxgl1AIIIGOL1laBtMRyUwm4
	5SUJmjtuP6S362rknPT0MlmuBg3TwaUP6b8Ii037g/hFFh5X7fydNHYX6ikTBT4z
	lO+mvNMTCA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bvu01x8rs-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 25 Jan 2026 04:58:53 -0800 (PST)
Received: from devbig003.atn7.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Sun, 25 Jan 2026 12:58:51 +0000
From: Chris Mason <clm@meta.com>
To: Mark Harmstone <mark@harmstone.com>
CC: <linux-btrfs@vger.kernel.org>, Boris Burkov <boris@bur.io>
Subject: Re: [PATCH v8 09/17] btrfs: redirect I/O for remapped block groups
Date: Sun, 25 Jan 2026 04:57:39 -0800
Message-ID: <20260125125830.2352988-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260107141015.25819-10-mark@harmstone.com>
References: <20260107141015.25819-1-mark@harmstone.com> <20260107141015.25819-10-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=UaVciaSN c=1 sm=1 tr=0 ts=6976138d cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=LWDUg-46AAAA:8
 a=wdPVtlASxeAafhje3qoA:9 a=0m5oFGktkVSl59jdpf0v:22
X-Proofpoint-GUID: MnowsdF02p2R5CQqbW3T1tDVZUTUjncm
X-Proofpoint-ORIG-GUID: MnowsdF02p2R5CQqbW3T1tDVZUTUjncm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI1MDEwOCBTYWx0ZWRfX1apwmP38zSky
 9Y2qB/Dq/K5CqvNBnMZ9YkgzyMz+1eZa+TqUNJ6c8GrJkHoLJb1i1yhNJVxqiB7htPnmqDRefIc
 9OlbqBpnmfUHV84AvNzIfF/X88UyBey61kJiGLl9Z6QDGZz6PGDHIcjkDQ40hCqEvQe2uzNgt+d
 0WRV+4+xubWjLXd0LdJQjswe449HmgnGEflw4SJirJZyC2EOcOkIskSAG6yhBr6B0rvAoZpoeE7
 pKvBovz8liVdHR8rXmoUxNw8uzPiRvkZsAd7Ukb0DzDLiT6Goe5ZZthgF32ZOUFBV1ZoGtaYON0
 ZtDgJOQj/3c/22lEjKTyPV5gvVP8w1GUyeSAA44qGnwKXBi7z9bWMqMty2y2bzIqIlq831EyTj3
 C4aoxnQUaYDBW1hmef+blCWl1SZG0QuuIHio0Ihh8X3MrHg7hWn5u6dfrpO8qfiYijYQkvWoyEZ
 L0QZQxWHBBr8kozgHVA==
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
	TAGGED_FROM(0.00)[bounces-20996-lists,linux-btrfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[harmstone.com:email,meta.com:mid,meta.com:dkim]
X-Rspamd-Queue-Id: 8B8728090C
X-Rspamd-Action: no action

Mark Harmstone <mark@harmstone.com> wrote:
> Change btrfs_map_block() so that if the block group has the REMAPPED
> flag set, we call btrfs_translate_remap() to obtain a new address.
> 
> btrfs_translate_remap() searches the remap tree for a range
> corresponding to the logical address passed to btrfs_map_block(). If it
> is within an identity remap, this part of the block group hasn't yet
> been relocated, and so we use the existing address.
> 
> If it is within an actual remap, we subtract the start of the remap
> range and add the address of its destination, contained in the item's
> payload.
> 

Hi everyone,

Another AI review from linux-next runs:

> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6586,6 +6586,24 @@ struct btrfs_io_geometry io_geom = { 0 };
> 	if (IS_ERR(map))
> 		return PTR_ERR(map);
>
> +	if (map->type & BTRFS_BLOCK_GROUP_REMAPPED) {
> +		u64 new_logical = logical;
> +
> +		ret = btrfs_translate_remap(fs_info, &new_logical, length);
> +		if (ret)
> +			return ret;
                        ^^^^^^^^^^

When btrfs_translate_remap() returns an error, does this leak the chunk
map? The map was obtained via btrfs_get_chunk_map() which increments a
refcount, and btrfs_get_chunk_map() documents that callers are
responsible for dropping the reference. The other error paths in this
function use goto out, which calls btrfs_free_chunk_map(map).

> +
> +		if (new_logical != logical) {
> +			btrfs_free_chunk_map(map);
> +
> +			map = btrfs_get_chunk_map(fs_info, new_logical, *length);
> +			if (IS_ERR(map))
> +				return PTR_ERR(map);
> +
> +			logical = new_logical;
> +		}
> +	}

[ ... ]

