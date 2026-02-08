Return-Path: <linux-btrfs+bounces-21490-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGFzOk3ViGnnwwQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21490-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 19:26:21 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63236109E03
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 19:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69802300DF5E
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Feb 2026 18:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C763A2F83AE;
	Sun,  8 Feb 2026 18:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="f6A+M2Zy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE77243969
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Feb 2026 18:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770575174; cv=none; b=tiOdYEaactqP5Ijyqs8RElPkV+Zd/aa56tutSzkDunjuJ1hxeTlR//nZ1ne/IFRKdedd34RFlPSYpMz85HUPoCDBU0h465ZbooijSKf27ir50AG3nQ1mnN0YcjU7KoBq3y+Mncj47149gBL5UBqTuZxfSEdJ1Z8+0Xsvz+k3Xr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770575174; c=relaxed/simple;
	bh=NVQESX5nS1uVHtKmiPDG4TMumPOVYTFyjecEQEr2OPo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lmmWrC/VsGVnPmPvnUmxeBuPBI5eK19DWHs07J/cdD/RrHB5ToDSdJS9oB2VvbwZ3mpF7isleM4m8HOsGVjhtB078w6t3q0DCGNCdiAUeoyR+0PmcxpzUnVAu+xNXUDIIjpEmzoCbzXOmFyV92vAhGDmdH9Xk9PUrAipnU+GQYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=f6A+M2Zy; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 618Eoknk2507952;
	Sun, 8 Feb 2026 10:26:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=C9mWF+Qgt/GjT3bZN0NahxiKndxyEaq2h49WAD31nVQ=; b=f6A+M2ZygRgx
	/g8R7TM5USwDt4RGOY5vAFHNso8+4cLfDjOEhct6z102BOaXhg492zgeb3ymlhNC
	f8e/yof34X2noUZKZojNnodmb2CAaTkjW2NMRZBqGEfgtB5Tx7w4sqbcAg/TAbsA
	8Ay5S7/dgDnBOt3XamPKGVEodqvditq2LkpB6v4JYVRkKRvsrjA6Bxn72e9kCv7g
	RTlIvVvDXdEbzSj1RSzP+BW5dcyTf2CdRI8fwJ37tUsu4jKcfq58h5Y8qHE12CLQ
	57CfAMntLiwZo6m6bPGZ6GdUIISDOIetoZ77V5hpWO9J6N1d2akVELZ/ZqmQBBXX
	fwaXubuvpw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c6vm1150g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 08 Feb 2026 10:26:10 -0800 (PST)
Received: from devbig003.atn7.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Sun, 8 Feb 2026 18:26:09 +0000
From: Chris Mason <clm@meta.com>
To: Sun YangKai <sunk67188@gmail.com>
CC: <linux-btrfs@vger.kernel.org>, Boris Burkov <boris@bur.io>
Subject: Re: [PATCH v4 1/2] btrfs: fix periodic reclaim condition
Date: Sun, 8 Feb 2026 10:24:17 -0800
Message-ID: <20260208182556.891815-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260114035126.20095-2-sunk67188@gmail.com>
References: <20260114035126.20095-1-sunk67188@gmail.com> <20260114035126.20095-2-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=ILUPywvG c=1 sm=1 tr=0 ts=6988d542 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=NEAV23lmAAAA:8 a=pGLkceISAAAA:8
 a=J69yAAYYy6rkEN2CjnUA:9
X-Proofpoint-ORIG-GUID: 8yLwpJZ6LpYHChckOZ8BIhv8Wp0uqccz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA4MDE1NyBTYWx0ZWRfX1bP/RlnPbuEG
 gupVdOzm+dR3O2b12+m3Y4xqHMSt2Oni8tH0Qah+Hq6xZwKgp9FU9MwgFnnr/Ezq07XENpMmwIp
 x8PWUDUruGc4apufjFBbLH4JcxtYF6ok2rMGH0JmeDLFIyHPkMKKliNAa66t511KO5lbEgOK9dn
 9ZSlIDOo3Ziedhg2Y+pD7S4saV5KmeI5QCz6tFcUfaqzIRX7/66vmo9fnC7QdeooneR1uBNlqjE
 gqNvBhSZHofQIPLLZMk1Zy7q3MXXsMF9XxHzbj6rPZV6SlqO2ZktE/k2vdvPhjeY0p2fMjcIvQe
 mP4lPp/8ko0G9HumyJRyw/Szt2PNxCaq4Ru1LWmzKxRbbScYuGMHzUXi5a+TiNZtJsMpy72+qfh
 X9UZpvn0Z+y3T1n3Y2JZvGBNw9KCA/+qdL/yMz2NcX1gIM5YEGbpM15RfkfHuvLINGysP6qtoPb
 1rlCJuBnHxJ+xosH0KA==
X-Proofpoint-GUID: 8yLwpJZ6LpYHChckOZ8BIhv8Wp0uqccz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_04,2026-02-05_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21490-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[meta.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clm@meta.com,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 63236109E03
X-Rspamd-Action: no action

Sun YangKai <sunk67188@gmail.com> wrote:
> Problems with current implementation:
> 1. reclaimable_bytes is signed while chunk_sz is unsigned, causing
>    negative reclaimable_bytes to trigger reclaim unexpectedly
> 2. The "space must be freed between scans" assumption breaks the
>    two-scan requirement: first scan marks block groups, second scan
>    reclaims them. Without the second scan, no reclamation occurs.
> 
> Instead, track actual reclaim progress: pause reclaim when block groups
> will be reclaimed, and resume only when progress is made. This ensures
> reclaim continues until no further progress can be made. And resume
> perioidc reclaim when there's enough free space.
> 
Hi everyone,

I'm running the btrfs for-next branch, along with the encryption patch set
through my AI review prompts:

https://github.com/masoncl/review-prompts

I'm working on some btrfs specific instructions, but hopefully these reviews
are already useful.  I've kept the headers to make it easier to double check
that I'm actually replying to the right email, but please let me know if any
parts of this are incorrect:

commit 19eff93dc738e8afaa59cb374b44bb5a162e6c2d
Author: Sun YangKai <sunk67188@gmail.com>

btrfs: fix periodic reclaim condition

This commit fixes issues with periodic reclaim by tracking actual reclaim
progress rather than relying on the assumption that space must be freed
between scans. The patch addresses problems with signed/unsigned comparison
and ensures reclaim continues until no further progress can be made.

> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index ebe97d6d67d3a..bc493243f777d 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c

[ ... ]

> @@ -2098,11 +2098,11 @@ static bool is_reclaim_urgent(struct btrfs_space_info *space_info)
>  	return unalloc < data_chunk_size;
>  }
>
> -static void do_reclaim_sweep(struct btrfs_space_info *space_info, int raid)
> +static bool do_reclaim_sweep(struct btrfs_space_info *space_info, int raid)
>  {
>  	struct btrfs_block_group *bg;
>  	int thresh_pct;
> -	bool try_again = true;
> +	bool will_reclaim = false;
>  	bool urgent;
>
>  	spin_lock(&space_info->lock);

[ ... ]

> @@ -2137,12 +2137,13 @@ static void do_reclaim_sweep(struct btrfs_space_info *space_info, int raid)
>  	 * If we have any staler groups, we don't touch the fresher ones, but if we
>  	 * really need a block group, do take a fresh one.
>  	 */
> -	if (try_again && urgent) {
> -		try_again = false;
> +	if (!will_reclaim && urgent) {
> +		urgent = false;
>  		goto again;
>  	}
>
>  	up_read(&space_info->groups_sem);
> +	return will_reclaim;
>  }

[ ... ]

> @@ -2179,7 +2181,6 @@ static bool btrfs_should_periodic_reclaim(struct btrfs_space_info *space_info)
>
>  	spin_lock(&space_info->lock);
>  	ret = space_info->periodic_reclaim_ready;
> -	btrfs_set_periodic_reclaim_ready(space_info, false);
>  	spin_unlock(&space_info->lock);
>
>  	return ret;
> @@ -2193,8 +2194,10 @@ void btrfs_reclaim_sweep(const struct btrfs_fs_info *fs_info)
>  	list_for_each_entry(space_info, &fs_info->space_info, list) {
>  		if (!btrfs_should_periodic_reclaim(space_info))
>  			continue;
> -		for (raid = 0; raid < BTRFS_NR_RAID_TYPES; raid++)
> -			do_reclaim_sweep(space_info, raid);
> +		for (raid = 0; raid < BTRFS_NR_RAID_TYPES; raid++) {
> +			if (do_reclaim_sweep(space_info, raid))
> +				btrfs_set_periodic_reclaim_ready(space_info, false);
> +		}
>  	}
>  }

Does btrfs_reclaim_sweep()->btrfs_set_periodic_reclaim_ready() violate
locking requirements? The function btrfs_set_periodic_reclaim_ready() has
lockdep_assert_held(&space_info->lock) at line 2163, but at the call site
above (line 2199), no lock is held.

Looking at do_reclaim_sweep(), it releases space_info->lock via
up_read(&space_info->groups_sem) at line 2145 before returning. Similarly,
the old code had btrfs_should_periodic_reclaim() release the lock with
spin_unlock(&space_info->lock) at line 2184 before returning.

In the original code, btrfs_set_periodic_reclaim_ready() was called from
btrfs_should_periodic_reclaim() while holding space_info->lock (acquired
at line 2182, call to btrfs_set_periodic_reclaim_ready, then release at
line 2184). This patch moves the call to btrfs_reclaim_sweep() but doesn't
acquire the lock at the new call site.

Should space_info->lock be acquired before calling
btrfs_set_periodic_reclaim_ready() at line 2199?


