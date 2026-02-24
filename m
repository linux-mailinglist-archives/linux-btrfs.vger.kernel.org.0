Return-Path: <linux-btrfs+bounces-21886-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEdyDKXZnWk0SQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21886-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 18:02:29 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 786C718A3F8
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 18:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 119F430059AC
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 17:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366973A900B;
	Tue, 24 Feb 2026 17:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8WLpjdI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E733A1CFF
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Feb 2026 17:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771952542; cv=none; b=DHMFZKeIopRbsvcx+nF0lJ5o3yYInRuR78LevypFTCaI54Dq7afMDIf8uJyScm8S9sKHbqbuzaZqx9EqkVTC6BUjjLwFLS5o4pVRfvCcqN/Cpy8FZWJ/TidJTI6LxOSzsCOpdAshrVGYISfRO6qt6lD6h9mlg9tU31B5V/fUa9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771952542; c=relaxed/simple;
	bh=IKh54VM/xUWkKjWY0tjuuqkNOAS9Hg6fk7z6Z6htYW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u4PWAkWaBts+/svHV42e8wwgq7krjGV5cqVV6qDPUyAGS4uzy1zTp2YwJT0LRMtkhacEdpZ1HZhZRMTsqMTMlJYaIp0WJqTytUDWnfe0QYY9K+WuMFFdGyF6XCOj6F+rEo5mNJ0u5Hx8wdOm0DbTkNsmGM775d/lxabijubYLIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8WLpjdI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C209C19425
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Feb 2026 17:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771952542;
	bh=IKh54VM/xUWkKjWY0tjuuqkNOAS9Hg6fk7z6Z6htYW4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=D8WLpjdIVi6GI1YdD0+xAjXLWWOXA6QpuCeFEjhyb5Ie/XIqFS3bkLR36iEixEezT
	 xK+UjDzzZ1pR0zGNnaY1xNRjCEXkZw6nlUuZlMAP8axjw0vCwAHptl6fmYzwkzjHpq
	 /+/bKJeGuveZx/IcysIiC2XQAjvH1ySEjKwBq3aX9TwEREkNFsa9Q0SCQ/Esi+kabv
	 V6FjVIg7K3VVOT/J+KgTVTxXCAIjeY7aln0a8NMYfWzeWVq+Ix3cm0YZ14CBZxLLt8
	 T5lVBsGn3SLouEJOj1UAXdgpkWbkiieAEe9uk0ULVa7GJxba2/XWFuDPcalJChfsa3
	 lXLp4Ydn4Me1g==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-65a43a512b0so6534315a12.3
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Feb 2026 09:02:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWA8W/rM0pfnX/66jga7ZDeSKhimYfFlfb/bhOtlLjeSlxj6F9weeOx6lUprOuD3iXX3CGPvOP8cgZcvw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0oenjFlK5B7CwYXCS2MQassx7a3PayoVLzjkktcITomASfjgk
	7IT+wknQ3YEQoGJfIulZixptIgxg+YGZf4psKH7AvvlAX3uR5Ux5QORsprWIuIFWdSg2atTJDcE
	qb20Y0dRuYZgIuroceIElvCLadasabkQ=
X-Received: by 2002:a17:907:d08:b0:b87:322d:a8bd with SMTP id
 a640c23a62f3a-b90819d97c7mr725666066b.24.1771952540483; Tue, 24 Feb 2026
 09:02:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <djynzzkwdfzqq6rks5njvhjexmje2zoofffkx2qtectxlyv53f@r54cgbf5l2b3> <20260224165704.GY26902@twin.jikos.cz>
In-Reply-To: <20260224165704.GY26902@twin.jikos.cz>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 24 Feb 2026 17:01:43 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4HZ1wJ_YHpPXcZOJ=UVSoKqncbkS+3e1D6PhMpzTpTJw@mail.gmail.com>
X-Gm-Features: AaiRm50U7_dg-TyUro42cko4H1DBDDr4eL3kCdijUuS9xg_wcD-CnER5NrsWhiU
Message-ID: <CAL3q7H4HZ1wJ_YHpPXcZOJ=UVSoKqncbkS+3e1D6PhMpzTpTJw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: use inode->i_sb to calculate fs_info
To: dsterba@suse.cz
Cc: Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-21886-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.cz:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 786C718A3F8
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 4:57=E2=80=AFPM David Sterba <dsterba@suse.cz> wrot=
e:
>
> On Mon, Feb 09, 2026 at 02:11:37PM -0500, Goldwyn Rodrigues wrote:
> > If overlay is used on top of btrfs, dentry->d_sb translates to overlay'=
s
> > super block and fsid assignment will lead to a crash.
> >
> > Use inode->i_sb to calculate btrfs_sb.
> >
> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
>
> Added to for-next, thanks.

There are review comments in v2:

https://lore.kernel.org/linux-btrfs/apsgauiwdj2exslcb7wmy2womtf6suyzfwatnxk=
75tzseivm4q@e7wktzgzxmsd/


>

