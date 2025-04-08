Return-Path: <linux-btrfs+bounces-12888-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90807A813F3
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 19:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BF904682F7
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 17:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D2F23E325;
	Tue,  8 Apr 2025 17:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Y/qee6O+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42F622DFB0
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Apr 2025 17:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744134456; cv=none; b=ZMG3XnRKMK/UZ6rBP5HBOu/OFe9eL6/AEMcAvr8c/pvXXGmwjx8mdS0WPyD8l8I2dn7V4osw3vFtjbfhvSP7R0Ka8e+Fp1xHNwd9o32i0ovaVtdOxp4P8mgJrcp/TWJtG6EnB8n8OR2kXFw+mTimKHfmcOiHGE18Q8bZswY/Uy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744134456; c=relaxed/simple;
	bh=6xnX5NUK57zOuUDC2r2Qt1QdSl2C7YJiwPptSlINKtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YjgEEnafsN2ktYKhL0AQaFeFyr/fdaxpp8Wjc1BIlXUF8BLtVc56ZFCRIIjp1vbqoT5blXXeS34IS2I4TWvUhWN0q1vstdKkMMZnctpmZ0TF1uFNmjAgruTNT03gDloH8CWSTxxU5R5RT2CT7PWTzaCkeD8+LTW3ycEf/GhRwdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Y/qee6O+; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac7bd86f637so1057254166b.1
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Apr 2025 10:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744134452; x=1744739252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCbKSs5ZbNLa65xSwrJ8gawGsTAvmrtEZ4B0b2dQDs4=;
        b=Y/qee6O+0p+O7bfTDQXHhFg25/RfJKHPaG9zLU3NNVZ2F0Hr6pcW6CeCKCPirNWdmv
         yJm5+grV3IfoGkaRTP/S81sgix7UvHdOU1jtGBeQYCMkpobVXQo++qlpi/cAjUA+q5hz
         xAx7RdokCYFtK8pZb1uECTl5OWviPGOXdqphJ0k7+zShgwrF6PtN5+EKPbQG1nTcDbpd
         s53XDIMIJAW1jI+9iqPTju6ma5Cdnrxxx5EqgrjppVa/+NdTHcrv+UDqcy+Gj4Z3j142
         IbecdZ7BNFHZ6qQaqiyW7XhgJ73udP7SEZdVqwfPHcBsmR4gf3EfegCjnZGoW2pgEbsf
         MbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744134452; x=1744739252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RCbKSs5ZbNLa65xSwrJ8gawGsTAvmrtEZ4B0b2dQDs4=;
        b=M44GG+5mwVs5BZ7VeGU2ej95psQgeysTNIdyilce0Up5Yj+k6p76NhnTvYaeXEb6+E
         3ZIt7QQ0vAcB+gp51179U8lwBjeVXDtmYWylZ8WYR1v53yDK0VMjR7qyi1vy3611yfLL
         4X9LLlKmczo/iwpeqZF7+9ZCsj69eCnylNlYy7d/N+viYXRD2C66+FvxVp/O89AkqYa+
         dMxe2nAsmY5+o1rv42ujEqBbLG0TK0vDLkOxTrXDXjn9hVtCnBdbX1F30DYeBsyTNWtQ
         EhqYSb+2T7c3s/++pZenmhhvtfuEL4z6nMJUnLA7rXbSscengTMe9F3lfTv4I68DALD4
         syZg==
X-Forwarded-Encrypted: i=1; AJvYcCVhtCpCyT1zC2kn7KuRQFKtZ9oh3PEB8N+3XUZud+inBCqHguxs7dkVKjyXHdD1+d5663v7h7h5Qb0mLg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGW8NUvkMWvDgQfpUUwds26M4YU/jjUBqIpblOpb+/nL32cRbl
	xT/GYJpf9ycJpPkK7nkQ0c+ifSECIky6wfqR1qG80cqj8A9BGb8VrgXRLsv3EnVVd3+7R9r8fxK
	zkVs7zVfa8fyDryaWCBb5T321FeKZeEBClVjgJAqV8ZXp2wvg
X-Gm-Gg: ASbGncuAx8CVnKLJsOPp2u71jFeeN4hJvmORHtrSgoVH8oBb3Vq8nbfyBQD5Gms4uia
	1xGRUQbf0VMnhVPxKCMvZ/q6fNMrMrXAH6ynbRzouE+8fSBEL64VN+zEXbH38i9mqNq7F6qkywD
	sbf4KC/b+LkOcWZqzvQGnruzXc
X-Google-Smtp-Source: AGHT+IHMMiRAydzAbwJa+Ye4XOnz9bIdvcLG9qlWjCjAcE2n1Ae1dSMKIpzsYeJBUticNHo0yFDd8FYuI/NOlq0Fa24=
X-Received: by 2002:a17:906:7cc5:b0:ac8:1bbe:1a5b with SMTP id
 a640c23a62f3a-ac81bbe1a82mr305167366b.9.1744134451946; Tue, 08 Apr 2025
 10:47:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408122933.121056-1-frank.li@vivo.com> <CAL3q7H6ysGxpXs8P9iPY-Y1KNKPggGSFHR_tMv-34Q+Qf6PZTQ@mail.gmail.com>
 <CAPjX3Fem5E26+Fj537zcOXk9YZum2pDdcY9SAwCOr12wrGrroA@mail.gmail.com> <CAL3q7H40yF8q78vZgd2c92LZMzBxqvU3XTrWMu86th1mGsGYDg@mail.gmail.com>
In-Reply-To: <CAL3q7H40yF8q78vZgd2c92LZMzBxqvU3XTrWMu86th1mGsGYDg@mail.gmail.com>
From: Daniel Vacek <neelx@suse.com>
Date: Tue, 8 Apr 2025 19:47:20 +0200
X-Gm-Features: ATxdqUGZ91u223X10tzq9NgOGLqvLsNRF_lv_kEhVEqSVkZaOP4gLp8OkuuPRv0
Message-ID: <CAPjX3Fd275aj0g5CWVKyX2wu0Sjn3a3UdZBaOR5MqUV55e4ZXw@mail.gmail.com>
Subject: Re: [PATCH 1/4] btrfs: use BTRFS_PATH_AUTO_FREE in insert_balance_item()
To: Filipe Manana <fdmanana@kernel.org>
Cc: Yangtao Li <frank.li@vivo.com>, clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 8 Apr 2025 at 19:41, Filipe Manana <fdmanana@kernel.org> wrote:
>
> On Tue, Apr 8, 2025 at 6:36=E2=80=AFPM Daniel Vacek <neelx@suse.com> wrot=
e:
> >
> > On Tue, 8 Apr 2025 at 16:47, Filipe Manana <fdmanana@kernel.org> wrote:
> > >
> > > On Tue, Apr 8, 2025 at 1:18=E2=80=AFPM Yangtao Li <frank.li@vivo.com>=
 wrote:
> > > >
> > > > All cleanup paths lead to btrfs_path_free so we can define path wit=
h the
> > > > automatic free callback.
> > > >
> > > > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> > > > ---
> > > >  fs/btrfs/volumes.c | 7 ++-----
> > > >  1 file changed, 2 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > > > index c8c21c55be53..a962efaec4ea 100644
> > > > --- a/fs/btrfs/volumes.c
> > > > +++ b/fs/btrfs/volumes.c
> > > > @@ -3730,7 +3730,7 @@ static int insert_balance_item(struct btrfs_f=
s_info *fs_info,
> > > >         struct btrfs_trans_handle *trans;
> > > >         struct btrfs_balance_item *item;
> > > >         struct btrfs_disk_balance_args disk_bargs;
> > > > -       struct btrfs_path *path;
> > > > +       BTRFS_PATH_AUTO_FREE(path);
> > > >         struct extent_buffer *leaf;
> > > >         struct btrfs_key key;
> > > >         int ret, err;
> > > > @@ -3740,10 +3740,8 @@ static int insert_balance_item(struct btrfs_=
fs_info *fs_info,
> > > >                 return -ENOMEM;
> > > >
> > > >         trans =3D btrfs_start_transaction(root, 0);
> > > > -       if (IS_ERR(trans)) {
> > > > -               btrfs_free_path(path);
> > > > +       if (IS_ERR(trans))
> > > >                 return PTR_ERR(trans);
> > > > -       }
> > > >
> > > >         key.objectid =3D BTRFS_BALANCE_OBJECTID;
> > > >         key.type =3D BTRFS_TEMPORARY_ITEM_KEY;
> > > > @@ -3767,7 +3765,6 @@ static int insert_balance_item(struct btrfs_f=
s_info *fs_info,
> > > >         btrfs_set_balance_sys(leaf, item, &disk_bargs);
> > > >         btrfs_set_balance_flags(leaf, item, bctl->flags);
> > > >  out:
> > > > -       btrfs_free_path(path);
> > > >         err =3D btrfs_commit_transaction(trans);
> > >
> > > This isn't a good idea at all.
> > > We're now committing a transaction while holding a write lock on some
> > > leaf of the tree root - this can result in a deadlock as the
> > > transaction commit needs to update the tree root (see
> > > update_cowonly_root()).
> >
> > I do not follow. This actually looks good to me.
>
> path->nodes[0] has a write locked leaf, returned by btrfs_insert_empty_it=
em().

Well, the first return is before calling this function and the final
return is only after committing.

Again, the function keeps it's former structure as it was before this
patch. I still don't see any logical or functional change.

I'm lost. This still looks to me just as a straightforward cleanup.

> > Is there really any functional change? What am I missing?
>
> Yes there is, a huge one. Even if a transaction commit didn't need to
> update the root tree, it would be performance wise to commit a
> transaction while holding a lock on a leaf unnecessarily.
>
> >
> > --nX
> >
> > > Thanks.
> > >
> > >
> > > >         if (err && !ret)
> > > >                 ret =3D err;
> > > > --
> > > > 2.39.0
> > > >
> > > >
> > >

