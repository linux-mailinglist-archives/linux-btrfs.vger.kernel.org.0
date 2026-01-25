Return-Path: <linux-btrfs+bounces-20993-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EAqBLoHdml3KwEAu9opvQ
	(envelope-from <linux-btrfs+bounces-20993-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Jan 2026 13:08:26 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 721018074B
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Jan 2026 13:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 087F930087B3
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Jan 2026 12:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70273161BC;
	Sun, 25 Jan 2026 12:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="QcuvJdmT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F87FAD24
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Jan 2026 12:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769342897; cv=none; b=Y7LyuNlE7IGmdCcxgqad6FZ6+SntyHx2ffPTMF/bJex6CU0QB192iNHXYlhh88i9tzM//WudMKpDICC5PJsAW1aAU4kgpIUV/FaSCPYFhp9ZqOauNdDlQ566yqZzy1Y/Hz0ZdPH30SB/Y7bJi+hrpxNp4WqbxLuPQKK6/2rwQak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769342897; c=relaxed/simple;
	bh=BAGbURafydo8ORGB6UUTjXEGQEfRIAca5XOUXBia+RU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o+uje26X1jAceZ5fwzFKaoWa0oS7midqxk2cZDha2nuRpaFjpoujiV+J2QZJTsEgqk6Po8+WDn54Z+vODL2SHdAaLIkVXYuQMUDJMzpbfe4Y9RIiXqmp5gQAZjIqmd1jub/uhCzvWwrVU5Dn2RAYjq1mxf8gv7Ys5j/auAL+ago=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=QcuvJdmT; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60PAPJti2108799;
	Sun, 25 Jan 2026 04:08:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=mPTo9QrvXpW6G61PQqSGfhj/wnmaHOzsWZMFNxnCCmY=; b=QcuvJdmTcCKw
	fUWYFgv3ZHRKPcKWDV2uujmnNwybrMkyvl4jff2Bq3TkABm8Efxoq79aSGF4AUKI
	6IpDWLnsY3/c5xIQohXL9ZOy/kT8s9ol7+Y6MZeJdk9fd9K0cuZPKykhEfYfOa2P
	4iAVMwFyS/kQn00M01hf10UOlPegC/R9AVW4vt0+k0yBfYyyqfxn/v5P9nNGf5Cl
	UFhTGSDsPp3FeCo51PHqXOqIwezDLWQgbWfzr/B/lJlzee4dJeSjuSMMEpCQfxET
	Ro8bXCFzylGgOlW1HgNOzhOJtcHspvEJaOk1MG+SFOCMlCnAH5LecZ9Y//Z9erGm
	KdiXaQ3Qjw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bvvsanqrs-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 25 Jan 2026 04:08:09 -0800 (PST)
Received: from devbig003.atn7.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Sun, 25 Jan 2026 12:08:08 +0000
From: Chris Mason <clm@meta.com>
To: Mark Harmstone <mark@harmstone.com>
CC: <linux-btrfs@vger.kernel.org>, Boris Burkov <boris@bur.io>
Subject: Re: [PATCH v8 15/17] btrfs: allow balancing remap tree
Date: Sun, 25 Jan 2026 04:00:40 -0800
Message-ID: <20260125120717.1578828-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260107141015.25819-16-mark@harmstone.com>
References: <20260107141015.25819-1-mark@harmstone.com> <20260107141015.25819-16-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 4pTi3BzimJ0zQYBa1QoSBLSkL5MTg6M7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI1MDEwMSBTYWx0ZWRfX0tgnJmPw60w+
 OpqZ/OiclK0FRlVezgGnFZZBAadTaVfej5nd78MWTxdR2eV7rE4vZyKwYPiq0amqbgYg9yIh+2b
 lHkZsRa2S1ppCyqSdHXBM0lRSasESXzN9NpDHh51vYaHBENWcp1fPsqEAjpTTJ/2JI7KrTkdl0S
 DpuOy8tFYEtdrd1wiqrYwI5v4VF1Uaxnbc0sxGfbCdNOEPNff64FXwAcLcOy4ipXqoPTnwWF3P5
 ntOS5YXWY/sO4V6uyscBD1thgjcrJsJLCcgT8NuiYKJgDHLBKKEx8wAHwNUcpmkauayJpJb3IHy
 akAsMkvU3h30G+VJN6pyQO2KGYrk1R2voOATxaLJNp0JTuS9hAYwP0/SF6+vOlhpIDHtDWRbJph
 aVYrcGxVIY5KIyRhNHV73+2KS1gfm24FK6JKz5SbdG4lpR3g7DRm0UtA30WZ2JWzjPSRGXczfaL
 i22HIvRCPMJRqp30Syg==
X-Proofpoint-ORIG-GUID: 4pTi3BzimJ0zQYBa1QoSBLSkL5MTg6M7
X-Authority-Analysis: v=2.4 cv=IpcTsb/g c=1 sm=1 tr=0 ts=697607a9 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=LWDUg-46AAAA:8
 a=eddPgyF4dVD45t8RQc4A:9 a=0m5oFGktkVSl59jdpf0v:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-25_02,2026-01-22_02,2025-10-01_01
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
	TAGGED_FROM(0.00)[bounces-20993-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[clm@meta.com,linux-btrfs@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:mid,meta.com:dkim]
X-Rspamd-Queue-Id: 721018074B
X-Rspamd-Action: no action

Mark Harmstone <mark@harmstone.com> wrote:
> Balancing the METADATA_REMAP chunk, i.e. the chunk in which the remap tree
> lives, is a special case.
> 
> We can't use the remap tree itself for this, as then we'd have no way to
> boostrap it on mount. And we can't use the pre-remap tree code for this
> as it relies on walking the extent tree, and we're not creating backrefs
> for METADATA_REMAP chunks.
> 
> So instead, if a balance would relocate any METADATA_REMAP block groups, mark
> those block groups as readonly and COW every leaf of the remap tree.

Hi everyone,

I ran my AI patch review prompts on linux-next, and this one was flagged.   As
we add more btrfs specifics we'll probably find some other fun, but this one
seems right to me:

>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c

[ ... ]

> +static int balance_remap_chunks(struct btrfs_fs_info *fs_info, struct btrfs_path *path,
> +				struct list_head *chunks)
> +{
> +	struct remap_chunk_info *rci, *tmp;
> +	struct btrfs_trans_handle *trans;
> +	int ret;
> +
> +	list_for_each_entry_safe(rci, tmp, chunks, list) {
> +		rci->bg = btrfs_lookup_block_group(fs_info, rci->offset);
> +		if (!rci->bg) {
> +			list_del(&rci->list);
> +			kfree(rci);
> +			continue;
> +		}
> +
> +		ret = btrfs_inc_block_group_ro(rci->bg, false);
> +		if (ret)
> +			goto end;

If btrfs_inc_block_group_ro() fails here, the remaining entries in the
list still have rci->bg set to NULL (from the initialization in
__btrfs_balance()). The goto jumps to the cleanup loop below.

> +
> +		rci->made_ro = true;
> +	}

[ ... ]

> +end:
> +	while (!list_empty(chunks)) {
> +		bool is_unused;
> +
> +		rci = list_first_entry(chunks, struct remap_chunk_info, list);
> +
> +		spin_lock(&rci->bg->lock);
                         ^^^^^^^^

Can this dereference a NULL pointer? When the loop above exits early
via goto end, the remaining rci entries in the list have rci->bg == NULL.
The cleanup loop then calls spin_lock(&rci->bg->lock) on these entries,
which would crash the kernel.

> +		is_unused = !btrfs_is_block_group_used(rci->bg);
> +		spin_unlock(&rci->bg->lock);
> +
> +		if (is_unused)
> +			btrfs_mark_bg_unused(rci->bg);
> +
> +		if (rci->made_ro)
> +			btrfs_dec_block_group_ro(rci->bg);
> +
> +		btrfs_put_block_group(rci->bg);
> +
> +		list_del(&rci->list);
> +		kfree(rci);
> +	}
> +
> +	return ret;
> +}

[ ... ]

> +			rci->offset = found_key.offset;
> +			rci->bg = NULL;
                                  ^^^^

This is where rci->bg is initialized to NULL. If balance_remap_chunks()
fails partway through processing the list, these unprocessed entries
still have bg == NULL when the cleanup loop runs.

[ ... ]


