Return-Path: <linux-btrfs+bounces-12907-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FE2A82151
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 11:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68ACF3B532F
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 09:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5C725D52F;
	Wed,  9 Apr 2025 09:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNzdfvrq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267F225A2DC;
	Wed,  9 Apr 2025 09:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744192251; cv=none; b=neCUkGrK0cBtpkcZk2Oenn705enEw8r0L9T9x8UzX3CjASvlPoZxO/wzVIFUr5qWRT2g5WMbFdrqUQBEnRWiUCy+ogue0r6ZHvjCT3YaVPlz8xhxH7ImuugEeUcfNXV6P762OqASGBvQLUsuytQQ6DRBEuK9B3cqoZRhRYo8mnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744192251; c=relaxed/simple;
	bh=3Xy1d0ZKCKOQ3MBUYJIkxShddwZ/IF8I+/NfadY8KBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fsSS8ZmuJehMvIZ9Rok18IU8N9YztPOS6v8k8wHOU6pDTN9BSq1sTQFRU6piKAnaKXFReEMvH+Eh+y/4l+3CKXelTlwpNf6AOodYku/Moj/rW5MlMcgL+2AGHMe7mvu6GytACIWMiWIFUsQytbna+10TwyQNwbPQxWojJ/D6u2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNzdfvrq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99EEFC4CEEC;
	Wed,  9 Apr 2025 09:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744192250;
	bh=3Xy1d0ZKCKOQ3MBUYJIkxShddwZ/IF8I+/NfadY8KBs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MNzdfvrqD3KPqxzYt3+xIIy8bnPL/qmzlLmAsmcF6ceCFXY55RNc9HhomphjQuHy7
	 cLm6wCVpt4WpmbrqeLfqn72WTJ6sZTQ9ZpStlhUDBV1dG7V1Cw77mPkURm128PozmX
	 d5X7G0zMsBwJ3CJJRFurEtwUFkN2COUjfmHRf/JadXY2fZr/rqoKZ16sIKcp9yB2/Z
	 ugOPr0ZjA9i0gGp8zYbl2JsSUeoOx4FN8cxODE1/UUY+cwDPeCjaRwa5JmXofVIeVz
	 rcB60nZt4Qn7jhCEcn4r9R1Tmtt+RV0zIyfpLrJCk3pOG0qcn50fNglIrF3oCw1utx
	 pEGV0E716PwIw==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e5c9662131so10209942a12.3;
        Wed, 09 Apr 2025 02:50:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU69t5H0LGpyRbxntKauCfNQ/aiYNJKinVjChHRO2GoWDsPz3Ybf4IvUd8mcK6za5Kf6TL9JUUunbRrvIgb@vger.kernel.org, AJvYcCWyB8t5FkEeF9AsSV7UJiqBBU9lcYuTy14BqabE0v2KCHm4dHgXoIhrVxUBDNz7QL9CL/9idJjzsT0wdA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQMrJGVNhAjBdNy8D28hC1iE3luiF3j73cAOWYD0DNre54DIBi
	4qVMINL0CFAL/jA58QUEurrLOwe0eQmnx0q29wxEE3iDf2Nbvf6NLdwrc/B5lilUALEiBMCvXVd
	WhSisbp/OxEwA0mWTipjkAB6iyB4=
X-Google-Smtp-Source: AGHT+IEQPRgz05B5cbUBeFx6ljVX3NfUNAODD2oo5w8cUjx/V6yY1vctEbX9Jt45SZyIT2g8yRkjj4ew0h7AXUvZMYY=
X-Received: by 2002:a17:907:6094:b0:abf:4bde:51b1 with SMTP id
 a640c23a62f3a-aca9b65e5d9mr250602966b.21.1744192249141; Wed, 09 Apr 2025
 02:50:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408122933.121056-1-frank.li@vivo.com> <20250408122933.121056-4-frank.li@vivo.com>
 <CAL3q7H7BS6juCS0eRdo6sqM4jzeMMi1o=huG38wgKYumD7qmmw@mail.gmail.com> <20250408230413.GE13292@twin.jikos.cz>
In-Reply-To: <20250408230413.GE13292@twin.jikos.cz>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 9 Apr 2025 10:50:12 +0100
X-Gmail-Original-Message-ID: <CAL3q7H49CYEJWv6-zDY2VxTL5MgJtrFL+KEwKrJJFii-exmyyA@mail.gmail.com>
X-Gm-Features: ATxdqUGWs7SG0Cm4MKLLdiioCwAgCiDq-AAk_INdDxbCxU24Q__DQFEKYn-nw64
Message-ID: <CAL3q7H49CYEJWv6-zDY2VxTL5MgJtrFL+KEwKrJJFii-exmyyA@mail.gmail.com>
Subject: Re: [PATCH 4/4] btrfs: Fix transaction abort during failure in del_balance_item()
To: dsterba@suse.cz
Cc: Yangtao Li <frank.li@vivo.com>, clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 12:04=E2=80=AFAM David Sterba <dsterba@suse.cz> wrot=
e:
>
> On Tue, Apr 08, 2025 at 03:53:04PM +0100, Filipe Manana wrote:
> > On Tue, Apr 8, 2025 at 1:19=E2=80=AFPM Yangtao Li <frank.li@vivo.com> w=
rote:
> > >
> > > Handle errors by adding explicit btrfs_abort_transaction
> > > and btrfs_end_transaction calls.
> >
> > Again, like in the previous patch, why?
> > This provides no reason at all why we should abort.
> > And the same comment below.
> >
> > >
> > > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> > > ---
> > >  fs/btrfs/volumes.c | 11 +++++++----
> > >  1 file changed, 7 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > > index 347c475028e0..23739d18d833 100644
> > > --- a/fs/btrfs/volumes.c
> > > +++ b/fs/btrfs/volumes.c
> > > @@ -3777,7 +3777,7 @@ static int del_balance_item(struct btrfs_fs_inf=
o *fs_info)
> > >         struct btrfs_trans_handle *trans;
> > >         BTRFS_PATH_AUTO_FREE(path);
> > >         struct btrfs_key key;
> > > -       int ret, err;
> > > +       int ret;
> > >
> > >         path =3D btrfs_alloc_path();
> > >         if (!path)
> > > @@ -3800,10 +3800,13 @@ static int del_balance_item(struct btrfs_fs_i=
nfo *fs_info)
> > >         }
> > >
> > >         ret =3D btrfs_del_item(trans, root, path);
> > > +       if (ret)
> > > +               goto out;
> > > +
> > > +       return btrfs_commit_transaction(trans);
> > >  out:
> > > -       err =3D btrfs_commit_transaction(trans);
> > > -       if (err && !ret)
> > > -               ret =3D err;
> > > +       btrfs_abort_transaction(trans, ret);
> > > +       btrfs_end_transaction(trans);
> >
> > A transaction abort will turn the fs into RO mode, and it's meant to
> > be used when we can't proceed with changes to the fs after we did
> > partial changes, to avoid leaving things in an inconsistent state.
> > Here we don't abort because we haven't done any changes before using
> > the transaction handle, so an abort is pointless and will turn the fs
> > into RO mode unnecessarily.
>
> The del_balance_item() case seems to be unique, there's only one caller
> reset_balance_state() that calls btrfs_handle_fs_error() in case of an
> error. This is almost the same as a transaction abort, but
> del_balance_item() may be called from various contexts.
>
> The error handling may be improved here, e.g. some callers may care
> about the actual error of del_balance_item/reset_balance_state, but
> rather a hard transaction abort it could be better to handle it more
> gracefully for operations that are restartable, like return an EAGAIN.

That's just not possible in 2 cases out of 3 (btrfs_cancel_balance()
being the exception where it's possible), since we already have an
error return value to return to user space.
The btrfs_handle_fs_error() call is exaggerated and doesn't accomplish
anything as the balance item was already persisted in a transaction
committed previously.

