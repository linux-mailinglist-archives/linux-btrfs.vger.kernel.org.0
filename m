Return-Path: <linux-btrfs+bounces-21486-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDgFLn6ziGkkuwQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21486-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 17:02:06 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E0F10955E
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 17:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D99713026AA1
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Feb 2026 16:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1A334F46E;
	Sun,  8 Feb 2026 16:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="DUxEsxDc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A151324B2B
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Feb 2026 16:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770566484; cv=none; b=DcdfKeIWZN7FRG4amJkhBZ8K43GCdgB2bOL6WXOYJgtYidPQo81EOobIFbKHk8TJYUrGW+pR9/uf2roONkBzkkIsvp2cMjOqXvNMTVVPh2LFXAvJgp/d7FY1655gLlF3aXnuaRLtCdAAsIuPWXzfivX0FxKjF5n77I2fOdegnyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770566484; c=relaxed/simple;
	bh=FgwnAZ2OYWhaPFfEzw55geigXIp6aOHdt4k+4w6ck2k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gk7Y1jWqUnJ0jss2huJYPPqCgxzPKQ/YjuRswc/s6u3B8LEnfA7IlOlVQiBJHjkgfeq6zBf3oEMIeY2S2KJrtUpM8DIEA/QTrMJSUoEu+LrBM+N5VRPZCh1U6CXC4AKixPyzMbFsNs7scvJMn/8dPeEZS9ElKPsXAUqtsPnQ61E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=DUxEsxDc; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6184tWsF2585066;
	Sun, 8 Feb 2026 08:01:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=xsfaZNj1IVPNyPm4dbgquXx0Wl08LIt46aURdYIAEZo=; b=DUxEsxDcg9YD
	40kPooLSz+CKpiOnpxc34p2A0MxLs/erqHh3RoCsiW2OIRYzhnd45S5599D9vpMj
	8mGeyK7390/zbU4mYU+21B2EcjNsWIx/X2ol7Nt2sR98DFP3wmqVSWriB3AD1yKZ
	byPBiXHWKPX7ZR8xZ1JEewd8sQENy30frcMxMImMzOQsaeWxydPNGtmaWDmqjK+r
	ShBGplzkysQuZGDRzYmZmWV1/fZtEPjyKJUOTTOw4PLZiHQKdsGrpsSQtAkknTAi
	l2tg2e9deb3+S23Vag47xe18390BBv4GdteI3JthQ8GiUOvr2zc403c/2d/i2ysV
	qlnf53neHQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c65jk05tw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 08 Feb 2026 08:01:19 -0800 (PST)
Received: from devbig003.atn7.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Sun, 8 Feb 2026 16:01:06 +0000
From: Chris Mason <clm@meta.com>
To: Qu Wenruo <wqu@suse.com>
CC: <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] btrfs: introduce the device layout aware per-profile available space
Date: Sun, 8 Feb 2026 07:59:33 -0800
Message-ID: <20260208160052.3757174-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <ef73e5bf75b19e839f68c018596f10437a8ba23b.1770173615.git.wqu@suse.com>
References: <cover.1770173615.git.wqu@suse.com> <ef73e5bf75b19e839f68c018596f10437a8ba23b.1770173615.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: TUqYItqiZwonYOXD38hFnZu1s3eD1OmH
X-Proofpoint-GUID: TUqYItqiZwonYOXD38hFnZu1s3eD1OmH
X-Authority-Analysis: v=2.4 cv=HM/O14tv c=1 sm=1 tr=0 ts=6988b34f cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=NEAV23lmAAAA:8 a=iox4zFpeAAAA:8
 a=ap6K4-xflikQ_QRAGKQA:9 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA4MDEzOCBTYWx0ZWRfXxOb+5HFW83Z5
 z8dEzvtNX/2mpwlaEuVTIpoTsdYyQdpiVSY8TSKgzZKvoZPgTGF3TXMD42h9zjA4FWsrqw3inFR
 07i195dVvwPhf1uqGtjfMyyqewonjQfsBKg/puAumHQUXdfwmNTYX81VfG9OBKPs+/gSAbokrwm
 eglppnGPc4cVjf1pLAvlypD/Y65wsoGJTR9Gz2ymUP7etV6WSptfgrSY2FJubaG3BvlsWP0WdQx
 IheLMPBsW4iCweyPaQB9ZZ+DyzwLSg9TEaQmjAG8fSwsAoMnTQGFPYC+iCAcGQW/6UWlhIUBx/J
 IcpkosIzdWLHUN+7E2lrSGxcgehUfKYHuAv91ubzW1ec4S1+SUJZ1Ed82tFMDtSqMD1xbI0hlDu
 7Mem0elV8p+0uH3U+M4xluelV+8Gv6yaz/SPoM0jOguGcKiH3deddYN3GccIJEuyODc1JfIBPU9
 8tIZBYHl3JrYEnxL1zg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_04,2026-02-05_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21486-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[meta.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clm@meta.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:mid,meta.com:dkim,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 60E0F10955E
X-Rspamd-Action: no action

Qu Wenruo <wqu@suse.com> wrote:
> [BUG]
> There is a long known bug that if metadata is using RAID1 on two disks
> with unbalanced sizes, there is a very high chance to hit ENOSPC related
> transaction abort.
> 
> [CAUSE]
> The root cause is in the available space estimation code:
> 
> - Factor based calculation
>   Just use all unallocated space, divide by the profile factor
>   One obvious user is can_overcommit().
> 
> This can not handle the following example:
> 
>   devid 1 unallocated:	1GiB
>   devid 2 unallocated:	50GiB
>   metadata type:	RAID1
 
Hi everyone,

I'm running the btrfs for-next branch, along with the encryption patch set
through my AI review prompts:

https://github.com/masoncl/review-prompts

I'm working on some btrfs specific instructions, but hopefully these reviews
are already useful.  I've kept the headers to make it easier to double check
that I'm actually replying to the right email, but please let me know if any
parts of this are incorrect:

commit 6f42a3863d937025e9670539658409ed668a7d48
Author: Qu Wenruo <wqu@suse.com>

btrfs: introduce the device layout aware per-profile available space

This commit introduces per-profile available space estimation to fix a
long-standing ENOSPC bug with RAID1 on unbalanced device sizes. It adds
infrastructure for chunk-allocator-like calculations to provide accurate
(conservative) estimations.

> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 8288d79372a56..0082c166af91f 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h

[ ... ]

> @@ -458,6 +465,15 @@ struct btrfs_fs_devices {
>  	/* Device to be used for reading in case of RAID1. */
>  	u64 read_devid;
>  #endif
> +
> +	/*
> +	 * Each value indicates the available space for that profile.
> +	 * U64_MAX means the estimation is unavailable.
> +	 *
> +	 * Protected by per_profile_lock;
> +	 */
> +	u64 per_profile_avail[BTRFS_NR_RAID_TYPES];
> +	spinlock_t per_profile_lock;
>  };

Where is this spinlock initialized? Looking at alloc_fs_devices() in
fs/btrfs/volumes.c:381, it uses kzalloc() which zeroes the memory, but
spinlocks require explicit initialization.

The follow-up commit 185737deaf9dc adds calls to
btrfs_update_per_profile_avail() which uses spin_lock() at line 5532, and
btrfs_get_per_profile_avail() also uses this spinlock. Using an uninitialized
spinlock is undefined behavior and will trigger warnings/BUGs with
CONFIG_DEBUG_SPINLOCK.

Other locks in the same struct (device_list_mutex) are properly initialized
with mutex_init() at line 389. Is there a missing spin_lock_init() call for
per_profile_lock?

