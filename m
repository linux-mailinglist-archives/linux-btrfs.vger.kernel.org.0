Return-Path: <linux-btrfs+bounces-8970-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC259A0FEC
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 18:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F3CE1C20E9F
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 16:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475A2212F05;
	Wed, 16 Oct 2024 16:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lg5/N1BJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE4420FAA1
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Oct 2024 16:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729096919; cv=none; b=TwhDxyMuWkcw3ze2l2jScKZTHk4cY+a+hA4IDvpbW9M8SnIl7Ye5NZY8Ijo+4PPWwFe1FMexU9M3o+9rUpzCp7DsFCzo7fMWU91aggFDoMid68JrrSOreJKCie/RNqVbTLkNUZ5T06soIo58653hyxXrcZzqmddkEXvnYCirBr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729096919; c=relaxed/simple;
	bh=31TtaAkmtkQCd5WsDW4pTydGhhuewNq8vL0RBikOqnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fv5z+8Zb1ESVmogO/jDuzwsUUh/tAQy4sNuGcqp4F/woCF0OLahZ91OAE031UaIfJqjzk0R6a0eGqO2gAJQtNZWg2oLURqAoRNDdvESy9gabZqXtE1bzdcCT8kdXB5oeDJE8tzelV3ZD2dUMQAAb/x1JlLG9T49qwDvUlR14TQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lg5/N1BJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06783C4CECE
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Oct 2024 16:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729096919;
	bh=31TtaAkmtkQCd5WsDW4pTydGhhuewNq8vL0RBikOqnU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Lg5/N1BJRfBkL/KhGX7IL247WnXSfeKNwfjStzi2jRDbbauNQT+IzWiO49nilCV4z
	 a2MDbgfT2EaIEWXAjxlO3FB9eg3flIKBAZVD6EKdepNmSt/L2EUX4StByoCqwl0JrS
	 Xr+F/88ZI+FMJKXVdtcdpud35HZPldtx8UGz+REyFVtusFNzXO1dVzvfkiZVOlQsEd
	 fHubsDK/KhFWsg9K4FkYI5m+q3hdWn/8TVBSujJNGfJGrU4n1lHpOpPXP3z56Be20P
	 jiIfHMPbjtP3A6CznRZwE1j9s9cKOfT+Zo6cnurxdgppgAZ2BLNiyiwEOFWgu441hW
	 Wi7+wHxlT/IrQ==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c935d99dc5so98663a12.1
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Oct 2024 09:41:58 -0700 (PDT)
X-Gm-Message-State: AOJu0YwJ96E1brsOAnLh4w6VE94pldcBCHhTQxuOIGLB+vdgOZjZTCSO
	kHqw8Ffgn+2aZtse05VWxS0HklV3LBvIfdTWBZYDf0Zdlz3q9eiV2EwFXFLQIMKEn6BkUzV5sj6
	Nk5nIJOUE6szN/M2Lh94GPkrl6xk=
X-Google-Smtp-Source: AGHT+IELv6tG3zBr/xeySR+kD8xsksVpP0rDGbnQ1kMa7/3e3GjVFegzM1Z8quVl19Xkkosug+Pdm7ypkQM4kCfNyEg=
X-Received: by 2002:a17:906:d269:b0:a99:f230:8d7c with SMTP id
 a640c23a62f3a-a9a34e4a923mr357845766b.54.1729096917617; Wed, 16 Oct 2024
 09:41:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1729075703.git.fdmanana@suse.com> <22e345124a6e35e4dbc07e9564475b5c97b37a41.1729075703.git.fdmanana@suse.com>
 <20241016154951.GR1609@twin.jikos.cz>
In-Reply-To: <20241016154951.GR1609@twin.jikos.cz>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 16 Oct 2024 17:41:20 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5D4c3OOFQFq5WNW65muhXa-fQLFsdhu73wSdG8Zz6LxQ@mail.gmail.com>
Message-ID: <CAL3q7H5D4c3OOFQFq5WNW65muhXa-fQLFsdhu73wSdG8Zz6LxQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] btrfs: remove redundant initialization from btrfs_readahead_tree_block()
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 4:49=E2=80=AFPM David Sterba <dsterba@suse.cz> wrot=
e:
>
> On Wed, Oct 16, 2024 at 03:20:22PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > It's pointless to initialize the has_first_key field of the stack local
> > btrfs_tree_parent_check structure since it all fields not explicitly
> > initialized are zeroed out, plus it's a bit odd because the field is
> > of type bool and we are assigning 0 instead of false to it (however it'=
s
> > not incorrect since 0 is converted to false). Just remove the explicit
> > initialization due to its redundancy.
>
> Makes sense, I've noticed there's one more to remove from
> btrfs_qgroup_trace_subtree() you can squash it to this patch too.

Ah yes, done and added to for-next. Thanks.

