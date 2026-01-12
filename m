Return-Path: <linux-btrfs+bounces-20401-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFCED12EE5
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 14:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C6DF30BC951
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 13:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5957635B14C;
	Mon, 12 Jan 2026 13:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGcAKr7b"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80509330339
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Jan 2026 13:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768225786; cv=none; b=AiGkYbexr/RHjBp0IoYJjEUcjuH10Hrd60Jk/DWWxvxTp5NlkzrNkV1rELCbkEFUchJ1duoAagk4lX7KKJcVKPo7mw69bPtsUZ9sgo6dF0KPnNyd2ykgZOsJFVRmePCKw5c9+8ECmc6/9UCB0pXR70URqDEfvs/4lRqdz3ldyro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768225786; c=relaxed/simple;
	bh=lDHPOlQO6NK45Ee0lf8PttXfMechH2rgOyt0vVV4zbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hdo79n7F740NlYsphTUyMTOIHElfMWePmOmIxCqv+d5DXtX+2eXh72C0uqR5shwSmxlZd/lYzjRdhvX5XuPwJoe5vCays0DYSnRl4LJVim+b2w6LJS5wS88jSmO4fhAPpzkdaBbNZ1/5kP9NdeF64ZuJEUIs0I4LdC/qsXl2X4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGcAKr7b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31BE8C4AF09
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Jan 2026 13:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768225786;
	bh=lDHPOlQO6NK45Ee0lf8PttXfMechH2rgOyt0vVV4zbU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PGcAKr7bUaAW69zX0HzqEsfLzRoF1/EFA4cY67B+6KjZo7oqheydt/HnHoEuhHD+b
	 E7ArYmtFrhDcC358WlAUnFs837GPNAvfE5Vz0Inah1AkAd2qVFSO2+yHk8Y8UFkhct
	 4H+A33NtB/4hRQWJ0a8cqyXEj/6t2K+7QQq9lwxUctU2mR8xPxdNYhbh6MdIPbHx/B
	 /zn4Diq4Nl69GlBZ2gw6lPIFdVEbLxsKxPsslVYGHhD41mv3lMmoH7Jv5ONkg++02g
	 ygxaxFXAWMlP0vDIrMa7oUmHj0ktD4DonHJQZezMmQZ2p3Ct9EgiayTDHeOipLULXT
	 CO6+pcJ26cbcw==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b86ef1e864cso219528666b.1
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jan 2026 05:49:46 -0800 (PST)
X-Gm-Message-State: AOJu0Yw1/+fRhlh/bVpjOe7n4rYfyQE9Qi3dWAk2VS/MFEfI+ur4Z3O4
	Iubm9FWGv+/JP3tLxfi1y8ve1TbQyXoKjXnXNFy9tcqMHzL4knMMnXN6jPlMxDc7Ew1LBZ/Kk6m
	8Bh5KmtyiL9G3pTt3JMuC4fQaiX/3oIQ=
X-Google-Smtp-Source: AGHT+IGaMNy10FNxRfABjsJCSSCxfLMr2wQAoUM+pIe87fiO9u6JlSWS8I/6FNM93S0/YONZeRXKF/nhbyZ5XvCg+MA=
X-Received: by 2002:a17:907:268b:b0:b77:1b05:a081 with SMTP id
 a640c23a62f3a-b8445283562mr1936797966b.27.1768225784776; Mon, 12 Jan 2026
 05:49:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1767801889.git.fdmanana@suse.com> <20260112-wonach-mochten-cd6c14b298ae@brauner>
In-Reply-To: <20260112-wonach-mochten-cd6c14b298ae@brauner>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 12 Jan 2026 13:49:07 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5xB1RFQK6fn1KL73AiGr-A+SoKCFH1pfwBTxHCkHPXCg@mail.gmail.com>
X-Gm-Features: AZwV_QhEcZYFGmLny8HuzAivfUMi3fmVl1kBcKczPMNBNhNSLfRTgWENGlb5yHQ
Message-ID: <CAL3q7H5xB1RFQK6fn1KL73AiGr-A+SoKCFH1pfwBTxHCkHPXCg@mail.gmail.com>
Subject: Re: [PATCH 0/4] btrfs: stop duplicating VFS code for
 subvolume/snapshot dentry
To: Christian Brauner <brauner@kernel.org>
Cc: linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 12:48=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Thu, Jan 08, 2026 at 01:35:30PM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Currently btrfs has copies of two unexported functions from fs/namei.c
> > used in the snapshot/subvolume creation and deletion. This patchset
> > exports those functions and makes btrfs use them, to avoid duplication
> > and the burden of keeping the copies up to date.
>
> Seems like a good idea to me.
> Let me know once it's ready and I'll give you a stable branch with the
> VFS bits applied where you can apply the btrfs specific changes on top.

Right now what's missing is just an update to the changelog of patch
4/4 to mention that the btrfs copy is missing the audit_inode_child()
call.

If there are no other comments, I can prepare a v2 with that update,
and then you can pick the patches into a branch.
For the btrfs patches, you can probably pick them too as they are
trivial, though I'll defer to David in case he has a different
preference.

Thanks.

> Thanks!

