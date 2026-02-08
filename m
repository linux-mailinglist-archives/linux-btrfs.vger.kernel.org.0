Return-Path: <linux-btrfs+bounces-21496-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPxEKRDciGnYxQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21496-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 19:55:12 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C18F109F28
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 19:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D2EF5300767D
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Feb 2026 18:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AA53016EE;
	Sun,  8 Feb 2026 18:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="sM+au5Al"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729BF17A2E8
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Feb 2026 18:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770576909; cv=none; b=uaiwkZM5+Rvmc5MplhM44bvYiVCeAY92j/gS1qgeHVH0s8EP/tcXAqCSVvccNU3/OAMzJB06vRIUhYS4gaYxt4XJhR5fhbuYyA+natWO0hefyAiMVWCmdyFtgt3r8tzpdyiLFg209m4D+Z47Gw8FwMA/HP9YusCXpfre6BS4A1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770576909; c=relaxed/simple;
	bh=ThRE7bE8SYOT+iXzyWgvFjUYLfdoIdSHnSVCzsSDH0I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fc8Ned8BR/vunWBfF0TVVbmWGobQ5FN4bJhedajvZyhKvMJWn5nOpklnV6o/rWgZCzAJcyo1pXN2kWD7+EHj9PviibhteZbfUa3wdXdAFIGWdiggeNtJ1J+ZLA4sWE0aVFTs0HG9g0FqyCwFuxEEL5YVXn8lmXf5xql01zT7Khk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=sM+au5Al; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 618BwtID2532019;
	Sun, 8 Feb 2026 10:55:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=rTjbBm881RybeR32DWa97QkLteaZ7WIF6U5il5Z1YEQ=; b=sM+au5AlCGA+
	RSB1Ffv6bx6FKCMOEzA9BcQFi38RPecfFvgNA1CqjB/0RcxcT8OQT00mmv8nLVgZ
	v3yvT1GFy2t91aPU+Q8WUnSVYLhsdi3TD7KdjX3CHxlYp3AsNPn4W8MXNYXp/7O6
	+4a53FQa7ImhbTN4Ys30NHO3dXgPcfc7ED0boNukbbgZ3udgdkmPqn3gwTvO7K9R
	W+3b7rhx3CYbC1nAfQHdkl9/J0aMOfqRNEbrMrI751rQ9ECGvC+33NFdbxsoClpk
	z2SlF4mYDPNn75Yyk0eEIp4yPuLNbHNT7wHrfmCu15AfELIclXX5MuNKnwv2PnUP
	3ev4drxKZw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c63c9hqk4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 08 Feb 2026 10:55:04 -0800 (PST)
Received: from devbig003.atn7.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Sun, 8 Feb 2026 18:55:03 +0000
From: Chris Mason <clm@meta.com>
To: David Sterba <dsterba@suse.com>
CC: <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/3] btrfs: pass level to _btrfs_printk() to avoid parsing level from string
Date: Sun, 8 Feb 2026 10:54:17 -0800
Message-ID: <20260208185450.1145092-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <f884e72071839aeb0f8b77e79a6ae2d0bc8adf78.1765299883.git.dsterba@suse.com>
References: <cover.1765299883.git.dsterba@suse.com> <f884e72071839aeb0f8b77e79a6ae2d0bc8adf78.1765299883.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: bMZmxd8SNPNJakQlrHkf-JTk7pKE1ea_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA4MDE2MyBTYWx0ZWRfX637YLqzATXhn
 +nDkq3sMZiJKJfSVFdVbJWn2gngjZ4P0lDjIA41uEOeTKMwUY/+WB20+cPPLJ5v/OD0xuk+grjT
 PPlVF16fsLEWvBlqwvPGH6p3iRsOO5CUqcA4E80GiKvhBLq2Czsx/pm+et3mpvgmZyuufq2l6oW
 43NbNX9KZxu/hxcR6cwLXmOM6ea9dCJtWtVje2QKiKeaVnF5ZDDLgXCyGIQEbEhm2vZYO/AD4yZ
 +Hc7rhnPkGdCOxvIBdF+8A0LB8Ww/dJjX3Nx+sjAC4LTEojL9g9sq22ZDPYf8UFQpr2XDoAuJ8k
 fklkwK1RewKhQOImn4CGtkHwmYyJyWRc9/ZORAo8csP1ZKDPxO2he+z3rgb5BSK7A3r6ggmIR6D
 mRG4oGjGAzOeqeWFQxyIakWfUz59+f/ScC37z1jXAgGyvRxbpOGt089ee+x2YeE1lYlIV2Fo6t2
 C7D035LsLjdxDjqI0YA==
X-Proofpoint-GUID: bMZmxd8SNPNJakQlrHkf-JTk7pKE1ea_
X-Authority-Analysis: v=2.4 cv=H5fWAuYi c=1 sm=1 tr=0 ts=6988dc08 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=NEAV23lmAAAA:8 a=iox4zFpeAAAA:8
 a=_dfjxIViyR5an1TfihMA:9 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-05_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21496-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[meta.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clm@meta.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,meta.com:mid,meta.com:dkim]
X-Rspamd-Queue-Id: 1C18F109F28
X-Rspamd-Action: no action

David Sterba <dsterba@suse.com> wrote:
> There's code in _btrfs_printk() to parse the message level from the
> input string so we can augment the message with the level description
> for better visibility in the logs.

Hi everyone,

I'm running the btrfs for-next branch, along with the encryption patch set
through my AI review prompts:

https://github.com/masoncl/review-prompts

I'm working on some btrfs specific instructions, but hopefully these reviews
are already useful.  I've kept the headers to make it easier to double check
that I'm actually replying to the right email, but please let me know if any
parts of this are incorrect:

commit 01c8634c695d199de4a4669c5d684bbec148e71b
Author: David Sterba <dsterba@suse.com>

btrfs: pass level to _btrfs_printk() to avoid parsing level from string

This commit refactors the btrfs printk helpers to pass the message level
directly instead of parsing it from the format string, simplifying the
implementation by removing the parsing code from _btrfs_printk().

> diff --git a/fs/btrfs/messages.c b/fs/btrfs/messages.c
> index 2f853de444739..6190777924bff 100644
> --- a/fs/btrfs/messages.c
> +++ b/fs/btrfs/messages.c

[ ... ]

> diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
> index 7049976342a57..d4e4cad060925 100644
> --- a/fs/btrfs/messages.h
> +++ b/fs/btrfs/messages.h
> @@ -23,19 +23,18 @@ void btrfs_no_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...)
>
>  #ifdef CONFIG_PRINTK
>
> -__printf(2, 3)
> -__cold
> -void _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...);
> +__printf(3, 4) __cold
> +void _btrfs_printk(const struct btrfs_fs_info *fs_info, unsigned int level, const char *fmt, ...);
>
>  #else
>
> -#define btrfs_printk(fs_info, fmt, args...) \
> +#define btrfs_printk_in_rcu(fs_info, level, fmt, args...)		\
>  	btrfs_no_printk(fs_info, fmt, ##args)
>
> -#define btrfs_printk_in_rcu(fs_info, fmt, args...)			\
> +#define btrfs_printk_in_rcu(fs_info, level, fmt, args...)		\
>  	btrfs_no_printk(fs_info, fmt, ##args)

Does this define btrfs_printk_in_rcu twice? Looking at the original code, it
had btrfs_printk and btrfs_printk_in_rcu as separate macros, but both were
renamed to btrfs_printk_in_rcu in the refactoring.

>
> -#define btrfs_printk_rl_in_rcu(fs_info, fmt, args...)			\
> +#define btrfs_printk_rl_in_rcu(fs_info, level, fmt, args...)		\
>  	btrfs_no_printk(fs_info, fmt, ##args)

[ ... ]

> @@ -44,38 +43,38 @@ void _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...);

[ ... ]

>  #if defined(CONFIG_DYNAMIC_DEBUG)
>  #define btrfs_debug(fs_info, fmt, args...)				\
>  	_dynamic_func_call_no_desc(fmt, btrfs_printk_in_rcu,		\
> -				   fs_info, KERN_DEBUG fmt, ##args)
> +				   fs_info, LOGLEVEL_DEBUG, fmt, ##args)
>  #define btrfs_debug_rl(fs_info, fmt, args...)				\
>  	_dynamic_func_call_no_desc(fmt, btrfs_printk_rl_in_rcu,		\
> -				   fs_info, KERN_DEBUG fmt, ##args)
> +				   fs_info, LOGLEVEL_DEBUG, fmt, ##args)
>  #elif defined(DEBUG)
>  #define btrfs_debug(fs_info, fmt, args...) \
> -	btrfs_printk_in_rcu(fs_info, KERN_DEBUG fmt, ##args)
> +	btrfs_printk_in_rcu(fs_info, LOGLEVEL_DEBUG, fmt, ##args)
>  #define btrfs_debug_rl(fs_info, fmt, args...) \
> -	btrfs_printk_rl_in_rcu(fs_info, KERN_DEBUG fmt, ##args)
> +	btrfs_printk_rl_in_rcu(fs_info, LOGLEVEl_DEBUG, fmt, ##args)
                                                ^^^^^^^^^^^^^^

Is the spelling correct here? It looks like "LOGLEVEl_DEBUG" has a lowercase
'l' before "_DEBUG" instead of "LOGLEVEL_DEBUG". This would break compilation
when DEBUG is defined but CONFIG_DYNAMIC_DEBUG is not.

>  #else
>  /* When printk() is no_printk(), expand to no-op. */
>  #define btrfs_debug(fs_info, fmt, args...)	do { (void)(fs_info); } while(0)

[ ... ]


