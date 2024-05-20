Return-Path: <linux-btrfs+bounces-5119-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD0E8CA0F4
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 18:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 033771F21D5E
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 16:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA29137C21;
	Mon, 20 May 2024 16:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYqF4qgz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EFE79EF
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 16:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716224356; cv=none; b=bguSjC2iu3gzKcLg1iebQnnX7R8nmFszcL9LhfaFIJLFo99K+w31pGdyQu7a4YdNwZHX5t8vxXW5LpjWGRMeORYazUDzBGhUcR6KVyX4JGWABe+cTiNY+KdVBJScE22qLWwmjEpPC8v+0D0L2PCpT9C9PY4tE99VWy7Vw4SuC0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716224356; c=relaxed/simple;
	bh=nB6UJ7AYhPbXrHql0oRfqaRGAhsGH2AlMWPaljHd6JU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LrrH+lMLUZnSRXr+OHVG1KM7Mb3ismu37n3Fqc0mFHHKh/NNeLqKrMr0reF+CQn4b5ZW+yb2E4lkh+WDhIn4VPh3Tisf8ms/wkg2Pw7tAk6rfhCaJTQOE1zhYuTMfEBZ86zwJnWlEZ/K3Abg69o+rxwiMJnsZ86WBn6my3Dx59I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYqF4qgz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 939B2C2BD10
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 16:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716224355;
	bh=nB6UJ7AYhPbXrHql0oRfqaRGAhsGH2AlMWPaljHd6JU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dYqF4qgzLf4zMAr/YcrhOAmXVDI5dL/G9kUtxf24VRSswfulhSWkKl/MVBHO3KWcl
	 9i2XRBagW94acYIOsdu5pYTpV09YkyAbBLipsRm5WdKE4V/kPIBya0yY/dxIXrWEEP
	 fcx04zFHvPI3dMMzbazX9udFSJII6DeWGCMoaolhJ1EfUHMyNJNiV8GiZskGIAZqCc
	 oUAk9CcfjvifLHEiGskA925rFgDKo4Dgkd3HGrh3IGBdpxk9wyLALkM9pfVa0nPZMl
	 /t7FqJo3EYJ6d3itMvJZbQnSOo1gD0Ezgval36lTECejtTlhUCf5PxGtrlNPsbJCCZ
	 GwWvKf8+ozj7Q==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-572baf393ddso10578446a12.1
        for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 09:59:15 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy4CNFibVAC9E7PcQ9yBKBFcpb0xN9g45zE/IIqtHg0iJusUxY2
	8f59lpZLH2xBvP2euZNQHRhemK+pknvL/0dVOER8l5lI2EMInICc7Su+aft9EOZcwtMEA99L9+Y
	z9INsciMYbv3hJXvedVEfBIvfZ08=
X-Google-Smtp-Source: AGHT+IHfAC2o8QwmyNfmu8tYaDJfMPQ8UF/wv0aHvo0aYV6DslguaDefUnKdfZ2gRWtD4Szo9WE1dkEn33iFv7ejiaw=
X-Received: by 2002:a17:906:ac5:b0:a5c:dd2c:d95b with SMTP id
 a640c23a62f3a-a5d5ecdc3e0mr578112866b.25.1716224354122; Mon, 20 May 2024
 09:59:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1715951291.git.fdmanana@suse.com> <20240520154844.GF17126@twin.jikos.cz>
In-Reply-To: <20240520154844.GF17126@twin.jikos.cz>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 20 May 2024 17:58:37 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5LhdkQq7aeU+yD_6RS9mYeBa5=5doB7OQ4xj0M4xuhFg@mail.gmail.com>
Message-ID: <CAL3q7H5LhdkQq7aeU+yD_6RS9mYeBa5=5doB7OQ4xj0M4xuhFg@mail.gmail.com>
Subject: Re: [PATCH 0/3] btrfs: avoid data races when accessing an inode's delayed_node
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 4:48=E2=80=AFPM David Sterba <dsterba@suse.cz> wrot=
e:
>
> On Fri, May 17, 2024 at 02:13:23PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > We do have some data races when accessing an inode's delayed_node, name=
ly
> > we use READ_ONCE() in a couple places while there's no pairing WRITE_ON=
CE()
> > anywhere, and in one place (btrfs_dirty_inode()) we neither user READ_O=
NCE()
> > nor take the lock that protects the delayed_node. So fix these and add
> > helpers to access and update an inode's delayed_node.
> >
> > Filipe Manana (3):
> >   btrfs: always set an inode's delayed_inode with WRITE_ONCE()
> >   btrfs: use READ_ONCE() when accessing delayed_node at btrfs_dirty_nod=
e()
> >   btrfs: add and use helpers to get and set an inode's delayed_node
>
> The READ_ONCE for delayed nodes has been there historically but I don't
> think it's needed everywhere. The legitimate case is in
> btrfs_get_delayed_node() where first use is without lock and then again
> recheck under the lock so we do want to read fresh value. This is to
> prevent compiler optimization to coalesce the reads.
>
> Writing to delayed node under lock also does not need WRITE_ONCE.
>
> IOW, I would rather remove use of the _ONCE helpers and not add more as
> it is not the pattern where it's supposed to be used. You say it's to
> prevent load tearing but for a pointer type this does not happen and is
> an assumption of the hardware.

If you are sure that pointers aren't subject to load/store tearing
issues, then I'm fine with dropping the patchset.

