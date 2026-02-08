Return-Path: <linux-btrfs+bounces-21485-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id LsaZCDyxiGlrugQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21485-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 16:52:28 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F23109536
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 16:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9E84301CCEB
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Feb 2026 15:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A91F36C5A5;
	Sun,  8 Feb 2026 15:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="rsVnXbH9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F4336C0AC
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Feb 2026 15:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770565937; cv=none; b=kgZJjcwv87UHN0Bh+Nv8AVRBJ5X8UdxsracNafZOX57s7OirdNEBa+gPBs+rpwLRurQoynWQNe3Vj/ufUOOL8e3EwBe6HzpTt5BfHdLKcFQI7+lgQyEL3HXRtpx9keAOG5VFoO0JKQ8mAtxyCJJAlYzksA4D14rIbZmUQ9/yFHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770565937; c=relaxed/simple;
	bh=ZBMZfwnqvkNlZdBBcl9EO3RiiucasyViZUJ5Z/mP5Qw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PnLIvQAL+Y7Z1SE/6K1nPnfH4RZbAcYsaZHN6of4Wbuvj84Ge5sJFM/elzqo3uEP00+QW2eDhH/Pm4zVVgEWYN+dHqvZ9t3v8uQcOs9uUcmBWO/TLbTyeMAq936QVsv9sgu2Reo8agidpjqudhCu8D1rJEAivfGoN7rfDhOqid4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=rsVnXbH9; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 618Flmw33487389;
	Sun, 8 Feb 2026 07:52:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=WYPRlUDZSuXdeqtWA+wUixaRVe6SQLge36XM8ul9mWc=; b=rsVnXbH9/dWr
	2RFvPr2QGhjO3MsQt2WXSvauuG19Y2WLb1w4HCZ8Dn1haQwQUVbWIvxr98RUOnF6
	m3rGr3D/ii9uEiDNracUQlFvcDNZpXvVA/A9uw37uTaH4agmUZnsw2vBPxx4d1Sc
	qcDC7VXzzQfsK1LqozGv9eOMRyUTyBpuPymhoBKTayyOJxjiatbyiShsQaJnpxP5
	CiR0YkbW/jN3hkLQ8UAvVidSIkeWflKt1nJUizJaH7hsQpbcT2oEyR0GnCSJe1E9
	ljU3XMdVqQOb4LXUehyKXFozVtjmQpKXgVDBbRo6sD/ecA2fJcJPZUqgs2jIDkie
	PZLbOK6L/Q==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c63se0jys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 08 Feb 2026 07:52:10 -0800 (PST)
Received: from devbig003.atn7.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Sun, 8 Feb 2026 15:52:10 +0000
From: Chris Mason <clm@meta.com>
To: <fdmanana@kernel.org>
CC: <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 6/7] btrfs: remove max_mirrors argument from write_all_supers()
Date: Sun, 8 Feb 2026 07:49:51 -0800
Message-ID: <20260208155148.3637328-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <a7a8b95c9c2f5d5c6a481aea277194fa615b8390.1770212626.git.fdmanana@suse.com>
References: <cover.1770212626.git.fdmanana@suse.com> <a7a8b95c9c2f5d5c6a481aea277194fa615b8390.1770212626.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Q3p3G6Xwya-CHUAoxyNTb1TWIw-Qczak
X-Proofpoint-GUID: Q3p3G6Xwya-CHUAoxyNTb1TWIw-Qczak
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA4MDEzNiBTYWx0ZWRfXxDimCAK90y/9
 QXcN7zuoKMBgohTqcCCbFCpsd9xauJI5WAaiwWouBmwW3O8cO2OcKhLt+IjfnZbfy6vnaPjxtea
 nr5K1x5dV+YcBtdKc4En2By48jt32LD+pXE17nGFFEyRcWi5Ekoacqpl1ricXl6gwn9qDxCio64
 gB7HrrWod9rbIO+V+C0ljMz2ONcdsNyRHTfofNs2v5T1yx1hDf30c9dmHfkMmn/LWZeMUtEheNU
 g+/YBtiih6SrwPbxpJyBIh+JyLvcIF0nnjWnDAGLlNUUlsgxJLTNRyRFYmcN+IQo6mQ987GNIPE
 dsaGK8OGLVLul0ws9L8//R7xZMeVIHo9buG021ufJRfAJly2Btuuz1f8r4HQzfyEOycBWP9U/2/
 wpQR5HPB3H9Tz7ZDBirangeIb8yxdrKtGDibbZdYYdZZsnzFFVataQSyNo7/kaeyCJTgYhNqWyS
 0SmGrc2K/MNmtRiOJkg==
X-Authority-Analysis: v=2.4 cv=G7wR0tk5 c=1 sm=1 tr=0 ts=6988b12b cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8
 a=VXcNfpkTLv-XE4N0sXUA:9 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_04,2026-02-05_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21485-lists,linux-btrfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,meta.com:mid,meta.com:dkim]
X-Rspamd-Queue-Id: A9F23109536
X-Rspamd-Action: no action

fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> There's no need to pass max_mirrors to write_all_supers() since from the
> given transaction handle we can infer if we are in a transaction commit
> or fsync context, so we can determine how many mirrors we need to use.
> 
> So remove the max_mirror argument from write_all_supers() and stop
> adjusting it in the callees write_dev_supers() and wait_dev_supers(),
> simplifying them besides the parameter list for write_all_supers().

Hi everyone,

I'm running the btrfs for-next branch, along with the encryption patch set
through my AI review prompts:

https://github.com/masoncl/review-prompts

I'm working on some btrfs specific instructions, but hopefully these reviews
are already useful.  I've kept the headers to make it easier to double check
that I'm actually replying to the right email, but please let me know if any
parts of this are incorrect:

commit a30345d606f40c870c69fb77195b3516a6dd6504
Author: Filipe Manana <fdmanana@suse.com>

btrfs: remove max_mirrors argument from write_all_supers()

This commit removes the max_mirrors parameter from write_all_supers()
and determines the mirror count from the transaction handle's in_fsync
flag, claiming this simplifies the code while maintaining correctness.

> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 19f7927a000d9..cf4ab067be72c 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c

[ ... ]

> @@ -4018,13 +4011,14 @@ int btrfs_get_num_tolerated_disk_barrier_failures(u64 flags)
>  	return min_tolerated;
>  }
>
> -int write_all_supers(struct btrfs_trans_handle *trans, int max_mirrors)
> +int write_all_supers(struct btrfs_trans_handle *trans)
>  {
>  	struct btrfs_fs_info *fs_info = trans->fs_info;
>  	struct list_head *head;
>  	struct btrfs_device *dev;
>  	struct btrfs_super_block *sb;
>  	struct btrfs_dev_item *dev_item;
> +	int max_mirrors;
>  	int ret;
>  	int do_barriers;
>  	int max_errors;
> @@ -4033,13 +4027,13 @@ int write_all_supers(struct btrfs_trans_handle *trans, int max_mirrors)
>
>  	do_barriers = !btrfs_test_opt(fs_info, NOBARRIER);
>
> -	/*
> -	 * max_mirrors == 0 indicates we're from commit_transaction,
> -	 * not from fsync where the tree roots in fs_info have not
> -	 * been consistent on disk.
> -	 */
> -	if (max_mirrors == 0)
> +	if (trans->in_fsync) {
> +		max_mirrors = 1;
> +	} else {
> +		/* We are called from transaction commit. */
> +		max_mirrors = BTRFS_SUPER_MIRROR_MAX;
>  		backup_super_roots(fs_info);
> +	}

Can this logic handle the case where btrfs_sync_file() falls through to
btrfs_commit_transaction()? Looking at fs/btrfs/file.c, when a full_sync
encounters a log sync failure or BTRFS_LOG_FORCE_COMMIT, the code flow is:

btrfs_sync_file()
   trans->in_fsync = true;  /* Set at file.c:1728 */
   ...
   btrfs_sync_log()  /* May fail or return BTRFS_LOG_FORCE_COMMIT */
   ...
   btrfs_commit_transaction(trans)  /* Fallthrough at file.c:1787-1816 */
      write_all_supers(trans)
         if (trans->in_fsync)  /* Still true here */
            max_mirrors = 1;  /* But we're in transaction commit */

The OLD code always passed max_mirrors=0 from btrfs_commit_transaction()
(transaction.c:2560), ensuring full superblock redundancy with
BTRFS_SUPER_MIRROR_MAX=3 and calling backup_super_roots() regardless of
how the transaction commit was triggered.

The NEW code uses trans->in_fsync which remains true during the
fsync-to-commit fallthrough path. This causes write_all_supers() to set
max_mirrors=1 and skip backup_super_roots(), reducing superblock
redundancy from 3 copies to 1 and skipping tree root backups during these
commits.

Is the commit message claim that "from the given transaction handle we can
infer if we are in a transaction commit or fsync context" accurate for
this case?


