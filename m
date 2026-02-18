Return-Path: <linux-btrfs+bounces-21750-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFA5DfCvlWkvTwIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21750-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 13:26:24 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A93156554
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 13:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83F653012C4E
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 12:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FF331282E;
	Wed, 18 Feb 2026 12:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKHTEf7w"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10548286D57
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Feb 2026 12:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771417576; cv=none; b=TU8wCsAApso1+GM5m7BQAeWwGO/pKO0SfpUSZNBTSY3hdtS4XMWV8Oc5usosU7uJxnFJMdL57rI6McCR1+N3h0pL7bfnTWqH5LyxP8R5fnb0Wti4OGa3lkc+rkbBQfYmX4hQt4H1vgdk/COiIQveIvh+OahUqJ8H1e3vECXjDvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771417576; c=relaxed/simple;
	bh=+JC4Gk+u+6FXfT7VeKYw7PfjoHqg9tyR3tIRbJxqONg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qPNozX69J9v9I7ufPd3MEzBvWzU4kt7p7YQBFu8Pv1zkqj234RGRV56Q5A2/iAMesgBhuTyfgizmJnpBuRpBUnhtqpipyaSCVjP/okWrl7+SdzXwU4Frfs4PKLhwGKvyIIHvqMmasuNAn2xCcZoCoxlcwNySya9aemFoB7HYx7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKHTEf7w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B04EDC19421
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Feb 2026 12:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771417575;
	bh=+JC4Gk+u+6FXfT7VeKYw7PfjoHqg9tyR3tIRbJxqONg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YKHTEf7w1UJPy+fwmssEhl6y6MA7njq+1/ij5dtob3s0AVPTiAdpnhq8vY7r2jYDY
	 94Ot0B5zs4Yuci3ASaONX9EDWrqBozXrwoPOWu9wLUd3kuZ5ldmVFXI0H6eYRyJAlv
	 1bvTSBXumNjFGU6QpXvlNa+M+RAHokOwYpr5OZ3MZnydh9AcDnZ4q0kUiTGNsVVXmh
	 HuuNKPQZCpFYsRcB3LR/6gd39EK8N/OZ5r4x3dtJOo43TXFjUzJ8OOuO6YKGw0MKrd
	 d4MTVOGlZY5oI7ZE8sKtl4DPMscjpBBvsSIstN5WKwpI59NbD+weMD2xmvm3m+N2cT
	 Yv68Qst0wapTg==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-65c20dc9577so3258739a12.2
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Feb 2026 04:26:15 -0800 (PST)
X-Gm-Message-State: AOJu0YxtKzclBWXSqGoebbZ86Vo1I2GUdMtQojFwGb4l4Eps+Gaqtud+
	El8xJKbujtT1zVA4HvQqFRuqbtGo/h4iD63jUyhpn+yg7F/k6Vs1K67qAqM+hJRw2TGhSSE42zx
	ON2Tcy85zcp35OVNfhH1gmuDwFiFax14=
X-Received: by 2002:a17:907:e0d8:b0:b8f:be44:1afd with SMTP id
 a640c23a62f3a-b8fbe443a78mr575865066b.65.1771417574243; Wed, 18 Feb 2026
 04:26:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218120322.327-1-mark@harmstone.com>
In-Reply-To: <20260218120322.327-1-mark@harmstone.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 18 Feb 2026 12:25:37 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4LkbG7uN=MejDKNcDzA2h5rdp2GaLK1S+Q60Hy=AYVHA@mail.gmail.com>
X-Gm-Features: AaiRm53CX47JUKVwHaPoKQYv-F_o_f8BRqgWP8Z5TcW7ha-zhiLN94tc9b7Vn5Y
Message-ID: <CAL3q7H4LkbG7uN=MejDKNcDzA2h5rdp2GaLK1S+Q60Hy=AYVHA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: print correct subvol num if can't delete because
 of active swapfile
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org, kevinhu@synology.com
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
	TAGGED_FROM(0.00)[bounces-21750-lists,linux-btrfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,mail.gmail.com:mid,harmstone.com:email]
X-Rspamd-Queue-Id: 88A93156554
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 12:03=E2=80=AFPM Mark Harmstone <mark@harmstone.com=
> wrote:
>
> Fix the error message in btrfs_delete_subvolume() if we can't delete a
> subvolume because it has an active swapfile: we were printing the number
> of the parent rather than the target.
>
> Fixes: 60021bd754c6 ("btrfs: prevent subvol with swapfile from being dele=
ted")
> Signed-off-by: Mark Harmstone <mark@harmstone.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 4523b689711d..233d91556fe4 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -4804,7 +4804,7 @@ int btrfs_delete_subvolume(struct btrfs_inode *dir,=
 struct dentry *dentry)
>                 spin_unlock(&dest->root_item_lock);
>                 btrfs_warn(fs_info,
>                            "attempt to delete subvolume %llu with active =
swapfile",
> -                          btrfs_root_id(root));
> +                          btrfs_root_id(dest));
>                 ret =3D -EPERM;
>                 goto out_up_write;
>         }
> --
> 2.52.0
>
>

