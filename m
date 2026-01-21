Return-Path: <linux-btrfs+bounces-20871-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJmoJERFcWn2fgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20871-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 22:29:40 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BE55E107
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 22:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E85E14F0833
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 21:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC633EF0BB;
	Wed, 21 Jan 2026 21:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/2da62P"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90271423A88
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 21:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769030959; cv=none; b=bOX2tPEEhU3En0lIZ34Z8ZoHuvjznpZBRxpxPVLw++lNu4UFGXAz0kpE5dHH4tbSomIu1WlqMBxVNbNkwSLZrxD1KNwrHUJi7byfHWYgiU5DGi8+9JFz+uotYVd9O2l39nNvROu9FEXYI9rUzRL6ctGSAvikPC/44SDf2dQf9sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769030959; c=relaxed/simple;
	bh=b9SbsC+vvDr4+Uy639LTKXjVTyJaqhAok/E4hMgVc8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=p5uqdG8+Kth8QM9IR5w21y+nUCGSrC8qgQEq6cH13apSCmnZ5tqe7lkqR/p6MF3IGqf6qsnQ+5g2IjSEX6+GQ3UmPQniwTifAHFuojmNisvSRjgJmwQ9Xk1KsQFKpTccQ/48LCVJkpTS1VrU+JL9hz+toLtrnBAksihLphkEWIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/2da62P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08BDC4CEF1
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 21:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769030959;
	bh=b9SbsC+vvDr4+Uy639LTKXjVTyJaqhAok/E4hMgVc8g=;
	h=References:In-Reply-To:From:Date:Subject:To:From;
	b=Y/2da62PPQbfzj+gy0c6yHuUS5iJ3rer3uA+LbO2bil9ETCE3igBVDZejzUhuejry
	 KPFkzHyCOlqSHiULmqr8HzdDvoEr/pcyrJz0FsurratHF07r9Fmt98ARM1BEanJ4hr
	 j4cR7mKy7Jl/4X5weWioQsVCflo0+rryH5uCH0c9JmO6k8z0sU9BK7i4a7o3aMyeX5
	 +BsZ974DR/+dEz6V0EtfctNDHmwGocC5OM87gYul78T9mEZ4tQDRxV+RsWiFoBiSRt
	 DLPBDig+0R9N1vXj99a2xkWz89U9s2woJ1tt0dRsmgvSiYxXI0tBXqhLQd5yNQrT2H
	 1yNzFDY73lg3g==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-65812261842so2362800a12.1
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 13:29:18 -0800 (PST)
X-Gm-Message-State: AOJu0YwlooLFZF100zUl9BRYvZY1kT6JMUna9ui6J11C4MiieG6dMqEP
	acJgGQRkJdOpkXA1zFT3oaaBfwnG3QGRl/xvC044P69w4XMW1knN1R7rxhLHiINg4KFZwLIK35m
	8NvXxKno1WWECXIGLSWN11Bu07sVECrI=
X-Received: by 2002:a17:907:9443:b0:b87:672c:4108 with SMTP id
 a640c23a62f3a-b8831b17cd3mr65191266b.4.1769030957537; Wed, 21 Jan 2026
 13:29:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1769028677.git.fdmanana@suse.com> <30034e48a39502638fbac40662914132895cca4b.1769028677.git.fdmanana@suse.com>
In-Reply-To: <30034e48a39502638fbac40662914132895cca4b.1769028677.git.fdmanana@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 21 Jan 2026 21:28:39 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5AgujW=S9zybrBny-4ab2ip-_qav7RMAEr7PD0pQkEGQ@mail.gmail.com>
X-Gm-Features: AZwV_Qhbqh-0JTJhdskGZU-oTzjj0p0_u1ggNr7hl_DXo4qBJk8qjQ2YQEAHLe8
Message-ID: <CAL3q7H5AgujW=S9zybrBny-4ab2ip-_qav7RMAEr7PD0pQkEGQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs: deal with missing root in sample_block_group_extent_item()
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20871-lists,linux-btrfs=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,suse.com:email]
X-Rspamd-Queue-Id: 10BE55E107
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 9:08=E2=80=AFPM <fdmanana@kernel.org> wrote:
>
> From: Filipe Manana <fdmanana@suse.com>
>
> In case the does not exists, which is unexpected, btrfs_extent_root()
> returns NULL, but we ignore that and so if it happens we can trigger
> a NULL pointer dereference later. So verify if we found the root and
> log an error message in case it's missing.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/block-group.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 6387e11f8f8e..b3345792f3a1 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -607,6 +607,12 @@ static int sample_block_group_extent_item(struct btr=
fs_caching_control *caching_
>         lockdep_assert_held_read(&fs_info->commit_root_sem);
>
>         extent_root =3D btrfs_extent_root(fs_info, block_group->start);
> +       if (unlikely(!extent_root)) {
> +               btrfs_err(fs_info,
> +                         "Could not find extent root for block group at =
offset %llu\n",

Unnecessary newline, will remove before commit or on v2 if needed.

> +                         block_group->start);
> +               return -EUCLEAN;
> +       }
>
>         search_offset =3D index * div_u64(block_group->length, max_index)=
;
>         search_key.objectid =3D block_group->start + search_offset;
> --
> 2.47.2
>
>

