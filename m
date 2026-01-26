Return-Path: <linux-btrfs+bounces-21071-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJeNEeCmd2lrjwEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21071-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 18:39:44 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCBD8B951
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 18:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 771013031330
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 17:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6AE34D4C4;
	Mon, 26 Jan 2026 17:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SAzVLnsZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C6B33BBD3
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Jan 2026 17:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769449146; cv=pass; b=bKXPCGcMh9VMMNqjr/JIX8tG4NGhf/xoTwy9Je7g0SN6HHEdlP1VLM/4ZaKqZ8Wj1BbchCwY6gfgoA36ZjfWsxMltJZrY+l1Swd5zlIX4E0GMl1vPZ37xROrXiMOMUUYr82RlfQ5i8rdKimAcX4YIl95x+Lq31WcwPoP+9H4ALE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769449146; c=relaxed/simple;
	bh=FfOLKXz6+XWJbYdwCD7fWpqi58SMWKXRwBiI+d0Bm+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V0jyHl/N23dw+SBU7yV3eRPapNgLDjw/eP0mUfnhRTPwJ/ZqD7bhyBje8yWugNK2USBX16/ub6r+hyFsPlei/Ra2yaLmt8+Nsc2SXDPMrqzz/PJdooSg2JZInzCsl8c7NcIyUVpkYT0FX+ObUqUJMc+Vy48lvUM7ll1HttJ7PNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SAzVLnsZ; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-432d2c7dd52so4906680f8f.2
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Jan 2026 09:39:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769449142; cv=none;
        d=google.com; s=arc-20240605;
        b=ae7KGhFdI2dnYD1sXbxidBq6yK9i9QS6NIvIYYdnHbDIp3NsVmttEvAnCiAtDl+rE7
         BFFjIXh+jamiMV46AscFGTbLiXzU6jyS/d3MouYQ8RiJ9wLC45T6KR2CNHQit0Kd5JT4
         Xd/EPvVVH0VnaIFoBTbKFA05jZqS0sfwUd4Hnlp/TQxRYlKlj2p9Ncojwq/WCmRw4hce
         3eQmrm14nXVmaUcOTU7EAEGitlr8Z3fHMvyvt3bvgdxBCqCblciIKkKxqRJ95yQ2+5ba
         ALH/3T8GNzZd8n2ewxVFLiWykl09Gh1fYKMSfDlZ75t8H9ZNCi9AKuJL1MaJB0ukN6B0
         D/3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CwtEoxZKFxtKB3AZJ62GCCjjQiVFYrAwy1e1hxV+t9w=;
        fh=DNhRoUogv4njemsTPAOB4Tb4wfg3Mu7IYlLDA9H4+4Y=;
        b=NNmpyabY4g0CLOpNMbqIbi5b0TQCD49Vm8OZpY7yt4krSEsrdxuoijfkwGeKXacT0I
         0D4QIno3HnbRXQSQ2zwjzcXJ9hrkGkrqa36AFCYkNGHlxPx7/mBWcRz1qMcBi0KbsCxC
         wbMUnV9nnHPqNn94lJj2eb5NSsJzwJvj0CESsoj0HUg9X2vVSj6Yn/2yegSGppL2LMnV
         5wKIvg1IER3kU6hLPLEfpXqpd1AspganDyljM1pYL6/2z9gJY2BNtgjoE6qTJx5E4ltS
         E9ajbSQ6pqffJkqZjWhzmNKpQukRBLjVIfgBBr6z1CkUHaNt8qpW4SSay5TOWjR5fKFt
         t8Qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769449142; x=1770053942; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CwtEoxZKFxtKB3AZJ62GCCjjQiVFYrAwy1e1hxV+t9w=;
        b=SAzVLnsZq1ddWWt4LyOJm+hqgJX/3z0KR9CALicNxVhYydAVN2z/1jkEbVYYds1dWk
         URD2jiF1lzWMX+2yT6axyo0kwtzw02phAkw4ZYdMbg+RioR/8VX20x3KLUWu5L5px0GI
         kGKvmlLXN9OORKIG3KaDM3iNlpiNROldyfannzKgPYsKH/iHQjnLfrA7wgf6+Psj9UH1
         OWOmHqkBRxVzn8aqpefilBE5mI2usCw3JtbYxjLkLc1f34MrL3XRuBoNn8tHw9Bs0cWy
         CGKGtrZMdlVOxJdPLCuMaZzD1TrgwsSs7XXm4sibjbbEEnf4qNaIWbWMZT+G3G5YpNRs
         uh6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769449142; x=1770053942;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CwtEoxZKFxtKB3AZJ62GCCjjQiVFYrAwy1e1hxV+t9w=;
        b=V2eS9Nz6+xrfdL0g2yL31GYWi6Fe6ikRCypw1IT9zI7/lNj8uQQWwGeWuJ0IPwzp6h
         Fn5q/DDUbmEEHdSh2oV7G1UN4uEsi1fm9SyaG5cjtZGfO4zh3thp9OTjXM4t0b4UbiZ/
         8zTXHyOIGU1YjeLDOnGV5SkIegxW30HMmN+fqduNcvFnqpjHDp8/NyDOHlsT3NeyR8PB
         8L3+9PrujAkVWD04kkJhs1f/lGQ9BM73rTVtsvEZ/O4LmmpiBX7f7pbNtMoPPahi6Pvo
         k85wbnYHKAjfP2jVIzvrhV+ljDuOBSeeJMm0Z4R++xz7GbnYaJoLNDbntq2dDSBNwjTn
         /MZA==
X-Gm-Message-State: AOJu0YxrOdoO0Y4ryOkKnmlXshFnAQyByGae45A2KsUEjhe75D0ebK4+
	yfWcmMFH8pE9wbELuuIhUsThD3qVOrSX/QydsGnUvq6kv/cdinoT9Bk5LfkZG1m7+yf1hbUYEkg
	iYQ1XprsYky9cR7mHsdSMqBioiG5CEfVCjbQpzak4mQ==
X-Gm-Gg: AZuq6aK1axxm1YJ7CX+HU25KJec07ZDn8ntshWJKDRMRG35qvPnMZfNqXesC1hraLOD
	Bs1hSlHnqDc9iYLwMr24KX6eFEQSIC3RtkyY7hbpwLJW+ArrYDRSct5UDE3T8jMWawuT/AlRX6A
	2tw7s/FoE3PFgs5Z5Lt7GPQG6a93RSmSA2XYb6bbkNNCoSq/IPLnLqN0JCcICvHeGCO57oExacP
	Kz9cLVyi2fLSEszDhUFZIGh4GEn7vBfN9El/buaoEQ5/lXddSiKNYVR+8BTOYIBrrQRLIyq2yLi
	wkkNpsuUAF735jirHeKPinAeMxolfWY1WQfS6DVjFpR4Yk4SrhsvRG9wEDGiOaaWiFHg
X-Received: by 2002:a5d:5f83:0:b0:432:c0e8:4a33 with SMTP id
 ffacd0b85a97d-435ca12207emr7948124f8f.22.1769449142533; Mon, 26 Jan 2026
 09:39:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123081444.474025-1-johannes.thumshirn@wdc.com>
In-Reply-To: <20260123081444.474025-1-johannes.thumshirn@wdc.com>
From: Daniel Vacek <neelx@suse.com>
Date: Mon, 26 Jan 2026 18:38:50 +0100
X-Gm-Features: AZwV_QgLb59zBBrSfJh7u2G7zhvdF-AO2gqculC66ynf0AwqjbSyMtw_Vab4G4c
Message-ID: <CAPjX3Fc1o=YqmhU1V6ZxW7h06g93Znn2RynG=Mz-rtKC4C_9SA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: zoned: use local fs_info variable in btrfs_load_block_group_dup
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21071-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neelx@suse.com,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,suse.com:dkim,wdc.com:email]
X-Rspamd-Queue-Id: DCCBD8B951
X-Rspamd-Action: no action

On Fri, 23 Jan 2026 at 09:19, Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
>
> btrfs_load_block_group_dup() has a local pointer to fs_info, yet the
> error prints dereference fs_info from the block_group.
>
> Use local fs_info variable to make the code more uniform.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Daniel Vacek <neelx@suse.com>

> ---
>  fs/btrfs/zoned.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 1ad4147d8bae..f74bd9099d8a 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -1438,13 +1438,13 @@ static int btrfs_load_block_group_dup(struct btrfs_block_group *bg,
>         bg->zone_capacity = min_not_zero(zone_info[0].capacity, zone_info[1].capacity);
>
>         if (unlikely(zone_info[0].alloc_offset == WP_MISSING_DEV)) {
> -               btrfs_err(bg->fs_info,
> +               btrfs_err(fs_info,
>                           "zoned: cannot recover write pointer for zone %llu",
>                           zone_info[0].physical);
>                 return -EIO;
>         }
>         if (unlikely(zone_info[1].alloc_offset == WP_MISSING_DEV)) {
> -               btrfs_err(bg->fs_info,
> +               btrfs_err(fs_info,
>                           "zoned: cannot recover write pointer for zone %llu",
>                           zone_info[1].physical);
>                 return -EIO;
> @@ -1465,7 +1465,7 @@ static int btrfs_load_block_group_dup(struct btrfs_block_group *bg,
>         }
>
>         if (unlikely(zone_info[0].alloc_offset != zone_info[1].alloc_offset)) {
> -               btrfs_err(bg->fs_info,
> +               btrfs_err(fs_info,
>                           "zoned: write pointer offset mismatch of zones in DUP profile");
>                 return -EIO;
>         }
> --
> 2.52.0
>
>

