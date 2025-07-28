Return-Path: <linux-btrfs+bounces-15718-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8BBB1408C
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jul 2025 18:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 630F3171011
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jul 2025 16:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1FD27467F;
	Mon, 28 Jul 2025 16:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXePbetB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D3E24BD03
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Jul 2025 16:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753721075; cv=none; b=icg7U2VZRak5P6umzzX50PYyNsB2OkjdMyBn0FPQjQ89A3lsnCKkztg3ZnUpWQg6IGy3lO5sMSEJcoebCa5fwkIpKtksyoyeI8tJVfUWwOI+Mu2ulcUAbL2jf3kFWMImwFG0sd6F5BcPCq7K73CuPvRgecixOq4V9nGSbWMJvh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753721075; c=relaxed/simple;
	bh=eacamN/TDBDKNSXli6xNBjkqUmAnjUsidnQmjNb7b/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bJxf3KWh6aFp64k1fgM8kzOa4bNzxX4kCc99zTp+2UPA0qVDpHQIes3PZJw3i6CBKHyTrDdvoQKD1Vwv/d4vHOY8AKMisUI7EvWh9LYFdNFanZK+w+y4gEHRC+Re5taFtrGr11y/OwAmZChdDB/gMiGHXhpLZAWUUVhVwJ4eR20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXePbetB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEEF9C4CEEF
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Jul 2025 16:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753721074;
	bh=eacamN/TDBDKNSXli6xNBjkqUmAnjUsidnQmjNb7b/o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CXePbetBrzEIAS5btufwmHSuk9PBDghJjijQ6bMGJ/U+bVmoWFbye89VTClLQCW6s
	 1/KL3icAyGtZE1AiDJN9Ut4KKYJo9VsfbvBi7u2x1DKmsRn/GzYKt8sel60B0Q5uXd
	 4JM3QHIPtaI8yb9owh8uQhinW3TplQWn9DmxvPkvXC4LLG+3i1sHj4JeyTz7xdQfMH
	 gjQyKV0aKihkxBwQrd7vt/DDGdXtzBSVZoIhpcO35uE//oVR3D2/CgDelLKm79uqei
	 eCLojEgfrelU3vrjwfJVgSgWhXngkJ98Qi01L8thqJgSdyONPeWmKO1EHIMrgzcFbr
	 D1uYdrS+2DHqQ==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae0dffaa8b2so940015266b.0
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Jul 2025 09:44:34 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx2v2Qt1o4OgncRgaMbpvnHiqEj5ppGi+rTjOhAQdSy4aFjyFt+
	KU8zAq2k9aLQCyZ2evRutTO2SEpStGeR98DyDV9VTTiCk7sUBxq2GqWK2DPCUGd2XxIINciY5cl
	4IDyGScRUIpHBq5N4AxPSbJlQoSApv4M=
X-Google-Smtp-Source: AGHT+IEM1tEW9IyON6N7qbAYhzazExWEQUkBhr714wNtcg0yhrqWP7X2GKBetkN6b3kElgp3la1AdWeqJJQ6GUmlkNg=
X-Received: by 2002:a17:906:fe05:b0:ae3:65a7:5621 with SMTP id
 a640c23a62f3a-af618f04bf4mr1197870466b.37.1753721073205; Mon, 28 Jul 2025
 09:44:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1753469762.git.fdmanana@suse.com> <fcedbeb4d8f0c9afbd99d0c768ad181842b41dad.1753469763.git.fdmanana@suse.com>
 <847191e9-e4f3-4359-bdf6-22b1bd95a0ec@wdc.com>
In-Reply-To: <847191e9-e4f3-4359-bdf6-22b1bd95a0ec@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 28 Jul 2025 17:43:56 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7FcnsL7XSJzKhhyw5QbcK0iTv5f7bB22q_rTq8g54v=Q@mail.gmail.com>
X-Gm-Features: Ac12FXy-HDhkap3x-RvQUkL4awRVhAyymyGsSRFBJ9Bs2fun-lIDccV8CqGW0WY
Message-ID: <CAL3q7H7FcnsL7XSJzKhhyw5QbcK0iTv5f7bB22q_rTq8g54v=Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] btrfs: simplify error handling logic for btrfs_link()
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 3:42=E2=80=AFPM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 7/28/25 11:40 AM, fdmanana@kernel.org wrote:
> > +     /* Link added now we update the inode item with the new link coun=
t. */
> > +     inc_nlink(inode);
> > +     ret =3D btrfs_update_inode(trans, BTRFS_I(inode));
> >       if (ret) {
> > -             drop_inode =3D 1;
> > -     } else {
> > -             struct dentry *parent =3D dentry->d_parent;
> > +             btrfs_abort_transaction(trans, ret);
> > +             goto fail;
> > +     }
>
>
> Don't we need to call "inode_dec_link_count(inode);" here? It used to be
> in the old "drop_inode" case but it's gone now. And in the commit
> message you state:
>
> [...]This makes the error handling logic simpler by avoiding the need for=
 the 'drop_inode'
> variable to signal if we need to undo the link count increment and the in=
ode refcount
> increase under the 'fail' label.[...]
>
> So the "undo inode refcount increase" part is gone now.

Yes it is gone, because if we fail to update the inode, it means we
have added the new link so it's more correct to leave the incremented
link count, since the inode has a new link.

In the end it doesn't matter much because we abort the transaction, so
the new link is never persisted (and neither the incremented link
count).

Thanks.

>

