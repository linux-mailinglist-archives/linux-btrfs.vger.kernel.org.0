Return-Path: <linux-btrfs+bounces-22112-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gP1YLppco2nW/AQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22112-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 22:22:34 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2122F1C8F48
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 22:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6DF633588A1
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 19:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598EF4A33FF;
	Sat, 28 Feb 2026 17:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRNia+k8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92AC4A33F2
	for <linux-btrfs@vger.kernel.org>; Sat, 28 Feb 2026 17:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300994; cv=none; b=ndtMsTi4D1os/aeZgGl9lvhKBrNsgo91nhjbE91iPTjNZyiA/kfxoVm5vqA9u10gMOOgjKr8vzGT37x+jYs3U6CWcWJlJ6YwKkv8cDfN6BZkfWtg0uOrnvhqXn1lkhrj+jsHl9mNUARZvc4i1PLm8QgMaaDlmPBEr9uPR1aMX+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300994; c=relaxed/simple;
	bh=5HVy6vAq2bRGgbHntyGok6fQD7+RUDVoE005swKOmwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BwsLXcMzM+GVv+m00yfzewCMTR757HJ+r9yKh2hNx3sw6Py/02YYbuRJ0zEUDZT7ha760DFmzJBK0noFs7UoN1HuleeURX2Fm6fGCH0f84YdVtV6339268mtOPcbE8k+BFCGEuLWgM5HqAci1IVUQesDnmzD15SE84xL/uVSs5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRNia+k8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682EDC19423
	for <linux-btrfs@vger.kernel.org>; Sat, 28 Feb 2026 17:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300994;
	bh=5HVy6vAq2bRGgbHntyGok6fQD7+RUDVoE005swKOmwg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MRNia+k8/YKFh61g/emrzWShQwPOsXH6LIqwpZNLalYEf0VlOmD8a5LyP4ubpk5ti
	 THngnvmuVMcA34KhPSjXGTzNlS87xNsLcmbtJpLbrpIcR/SSm7wm4eT1tRCysRW9OC
	 /w+SuiivHTbCuFRQrJAwU5/zuuFTdVzdN0Z4RKMFZwyjT3c/Y9uuW8TPecNetnLf+B
	 +HtC15e1wgGYK/k/CkL8j2psmC6uLkWi2B8LTpM8ZvuSC+T9WXqYAfedyVQtZhqKy9
	 /bYpCdik43tUa4VeuJ2ySAHf7Tb8f9BsTe2zMrUVQPq9g/JMVSO9xpt2eWDSVky44I
	 vt+gWsLHwzyvQ==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-65a2fea1a1eso6503070a12.0
        for <linux-btrfs@vger.kernel.org>; Sat, 28 Feb 2026 09:49:54 -0800 (PST)
X-Gm-Message-State: AOJu0Yy0V0daheJzIMrTUtS3IJcEISwSOMLttk0RjuF56W884ZVrw/Tv
	rkQ0orWPu9O/owXOUL7xJdEPB2D3P4upRVbvMabIJwtJX75ruoKSz+You9LY/U69BwCrg5nkye0
	Us/9u2BTq3QFrwJHz9jM0w5leqfOnLMU=
X-Received: by 2002:a17:907:60d0:b0:b8f:7200:63ca with SMTP id
 a640c23a62f3a-b9375847a7amr528313966b.11.1772300992920; Sat, 28 Feb 2026
 09:49:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1772150849.git.fdmanana@suse.com> <6bcde21c-d297-4063-97dd-836b037c92d8@gmail.com>
In-Reply-To: <6bcde21c-d297-4063-97dd-836b037c92d8@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Sat, 28 Feb 2026 17:49:16 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6g_M3bpaHy+Sbim2KODhYw2LMtjLo6HJy0e1WOtwkf8A@mail.gmail.com>
X-Gm-Features: AaiRm52Li2ATX6j2NAnMNBA7yG4TqQB1XbHdllACNBfptbtevF8fgVHgtDJWqkk
Message-ID: <CAL3q7H6g_M3bpaHy+Sbim2KODhYw2LMtjLo6HJy0e1WOtwkf8A@mail.gmail.com>
Subject: Re: [PATCH 0/3] btrfs: fixes for the received subvol ioctl
To: Anand Jain <anajain.sg@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22112-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 2122F1C8F48
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 11:27=E2=80=AFPM Anand Jain <anajain.sg@gmail.com> =
wrote:
>
>
>
> > Filipe Manana (3):
> >   btrfs: fix transaction abort on set received ioctl due to item overfl=
ow
> >   btrfs: abort transaction on failure to update root in the received su=
bvol ioctl
> >   btrfs: remove unnecessary transaction abort in the received subvol io=
ctl
>
>
>
> Can this also be considered for LTS kernels?

I forgot to add a Fixes tag, which is:

Fixes: dd5f9615fc5c ("Btrfs: maintain subvolume items in the UUID tree")

This is both for the first and second patches. I'll add it before
pushing to for-next, thanks.

>
> Otherwise, this looks good to me.
>
> Reviewed-by: Anand Jain [asj@kernel.org](mailto:asj@kernel.org)
>
> Anand

