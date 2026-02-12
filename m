Return-Path: <linux-btrfs+bounces-21643-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CH01MRWjjWlh5gAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21643-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Feb 2026 10:53:25 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A99512C0DF
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Feb 2026 10:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89275300D141
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Feb 2026 09:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05AF2D97BF;
	Thu, 12 Feb 2026 09:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDApcjfl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBF23EBF1B
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Feb 2026 09:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770889945; cv=none; b=g5feXB2JlClaKSVAS3Vw3LnXl9Q7IJITEE74XlF4Tr31GuiFG0bqdF2RjchwSq5KJ41DbxEte/rnei7JuAMkmOk899Y6sL9L79nw/IqybdKfrmdUsP4CiUahejiABJFe/N3fd6uD8aOisVGGve7ilhB//MwH+mKkl0jPtqc6ea0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770889945; c=relaxed/simple;
	bh=K4it8qXhDnMwCu63l6G8nYf9XbeQh0tm4f/yNjCsJEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OzaALZxeTJ/OkJ64hP5fgScb6rG1Ws0CsladG0xck7Wcc4CZIbCAFROWf9h5ch3wwT9QfWd0ADwWGh0gUKjHZCDHUK0zeyNhagGHZEc8gQ5xX21G1QOcI4hm9kjDPIQQS+mymVzAA1t/8y7ISlkp7kdsp1FCqsuYtAqaVE/goNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDApcjfl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68EFC4CEF7
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Feb 2026 09:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770889944;
	bh=K4it8qXhDnMwCu63l6G8nYf9XbeQh0tm4f/yNjCsJEk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LDApcjflmlwSBiI88V17GJi+92VGqUL3dh/AkZOEvxkwF9HTIiQZy6rQxO/tDd++u
	 FhfqFNrBEnU1Dr71TICY/bqBatLdXU9/P9nWAGeRbfBJN8I2Qv1TlfEbId/lNUr1H2
	 cMffWW64g1tYCILBpKu4V8jZTIf3NMLwkVyu52GoHhpgRW16LvSYkle8z2nEgzSjOT
	 M/g7oh7lDH/wSmNXmDo90evUzI0VPj593oxMXHIx1MaU4KvDPPRjDRTNMSGC1if86A
	 fQiLLNEbk2qzz4uDBkUtcmjbdmVo0g5tZiexQUW2TArS1NZvSzrMI5QOt49L7VVSHe
	 s4t7cogo03+dg==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b8d7f22d405so408556666b.0
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Feb 2026 01:52:24 -0800 (PST)
X-Gm-Message-State: AOJu0Yxp76oskSd9Dohn9fIBO47JrF98wwKv84r17PgQiLHOgs/OyclT
	LSKUfkA+LD7sjoRc4ODo4tzhaYDw7tIvptzLnHCtNs7Jcr7+p0DA5lFYLOSi5HxO/fA/CrmrluK
	rDxlcYd57TcoEXiVxilDG+nPupcpTPio=
X-Received: by 2002:a17:907:d18:b0:b8e:36ec:88db with SMTP id
 a640c23a62f3a-b8f92a31894mr107375466b.22.1770889943282; Thu, 12 Feb 2026
 01:52:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b47c68886c6e5174a2281e45c93f486a2aa73752.1770845275.git.boris@bur.io>
In-Reply-To: <b47c68886c6e5174a2281e45c93f486a2aa73752.1770845275.git.boris@bur.io>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 12 Feb 2026 09:51:46 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5YsBb4-OwcG0+tPAE=PRqLZ=2Nr-ai9QoappjBmxC=pw@mail.gmail.com>
X-Gm-Features: AZwV_QiVtygDPVieK-uYobqRjhY-sZRKW2je0KD0P-_y542OqDD8rvQC5w9Fa4M
Message-ID: <CAL3q7H5YsBb4-OwcG0+tPAE=PRqLZ=2Nr-ai9QoappjBmxC=pw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix rfer_cmpr check in squota_check_parent_usage()
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21643-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 2A99512C0DF
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 9:29=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> We compared rfer_cmpr against excl_cmpr_sum instead of rfer_cmpr_sum
> which is confusing.
>
> I expect that
> rfer_cmpr =3D=3D excl_cmpr in squota, but it is much better to be consist=
ent
> in case of any surprises or bugs.
>
> Reported-by: Chris Mason <clm@meta.com>
> Link: https://lore.kernel.org/linux-btrfs/cover.1764796022.git.boris@bur.=
io/T/#mccb231643ffd290b44a010d4419474d280be5537
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/qgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 38adadb936dc..19edd25ff5d1 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -370,7 +370,7 @@ static bool squota_check_parent_usage(struct btrfs_fs=
_info *fs_info, struct btrf
>                 nr_members++;
>         }
>         mismatch =3D (parent->excl !=3D excl_sum || parent->rfer !=3D rfe=
r_sum ||
> -                   parent->excl_cmpr !=3D excl_cmpr_sum || parent->rfer_=
cmpr !=3D excl_cmpr_sum);
> +                   parent->excl_cmpr !=3D excl_cmpr_sum || parent->rfer_=
cmpr !=3D rfer_cmpr_sum);
>
>         WARN(mismatch,
>              "parent squota qgroup %hu/%llu has mismatched usage from its=
 %d members. "
> --
> 2.52.0
>
>

