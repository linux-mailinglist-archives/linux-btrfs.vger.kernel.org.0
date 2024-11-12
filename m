Return-Path: <linux-btrfs+bounces-9521-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8DE9C5B2E
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 16:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0BD81F22F87
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 15:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764AF201261;
	Tue, 12 Nov 2024 14:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVJVPIf1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04B41FF5F4
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 14:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423508; cv=none; b=qPD7Xnh5iQslaqzHeeKPkQm9wgba+nZb48m2ZlNCURhIVyK8174TBINN02ygkRCdosAwdN2aZDa9pp916ooR5WxJ2JXOgY1+kRm5VsIpXovhuVWvrgjpmyoaUBA3n8KYzhVEMFr2Rxb6ymxdfN+jKyI9BOYalVed2KPZjrwHaRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423508; c=relaxed/simple;
	bh=ACsvNW8DPotsBYPQmC8WG6Zz+LnN9sjqBGvgw5IBlE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XN22ywdQvmqaEgL25yH4R1YlaplwXkSiFkzRLmVVuqAEPnjfxy3jzWRqwytRqbAiXxleAE3aH9mpKzsqGsyTD7Sklqt+1LAVSvKQmdWHdAzSfQ2wdKlvbofej8FzeQ0yHyET4ZNmy221/ZNp8K97eRjTkoLAIShq2jMKxOEFcLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVJVPIf1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C0CC4CED6
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 14:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731423508;
	bh=ACsvNW8DPotsBYPQmC8WG6Zz+LnN9sjqBGvgw5IBlE0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HVJVPIf1W7aPjYKjeOpWIzQQ/ROrFWlHztAG3aecuDIoNjJp6jlZUmPu2wBCHLXB7
	 4xc0sLRPMa8Xmn8jwhmKntawfPziSUu7eeoa0UXh5NFxniVN2kMXno1canuSax/kDD
	 2EpZDPhQHabHfLPBSpHgjOOFdWSgFVzcH2P0r5EFxqUUY9imZ1bbt/CQfl+FEgHimH
	 wzsSHp5FnLkuTBrG1/ZOOPfQRvT2t1mE6mWJeXCtOzG3fOxVmCIstFMjvQf+3jsmtS
	 sB3T8I0kOaySMN8BXuVASFnjqJu6h6jFnNl5OvSHN7XGSbWlTGIM0WkDwi5CR7GMiC
	 jX7n31KRXi8ag==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a99f646ff1bso869607466b.2
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 06:58:28 -0800 (PST)
X-Gm-Message-State: AOJu0Yzt1IQ2oe0fMzXSAzkXikxFAQ4HFwvIM2H4dXj++Pi9VU1NLrQY
	RtrAf9s4vdGDdwv+F7FvU3r/IdQeu7w6Axo8o3j4NyO9TOnLEwOOvMn0khcuvY55qPTY0EUPNY/
	9cTANHJUB9VDGL7+/w1kfNueGPIo=
X-Google-Smtp-Source: AGHT+IEFZK3QCm/CJtlXNQ8E/Z/wh9rlCdjiMZ5t6ZlBSsz76rm15LtHHJkvg32wAJwPAiDaMraIUsTgWce9UbBs44I=
X-Received: by 2002:a17:906:dac9:b0:a9e:c266:2e15 with SMTP id
 a640c23a62f3a-aa1b10a20bemr325937066b.27.1731423506981; Tue, 12 Nov 2024
 06:58:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731407982.git.jth@kernel.org> <efda9415bfe4a33b764d82fe9f7a522a23b4586f.1731419476.git.jth@kernel.org>
In-Reply-To: <efda9415bfe4a33b764d82fe9f7a522a23b4586f.1731419476.git.jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 12 Nov 2024 14:57:50 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7rLgUBk6CrhpTuyFU3L4ww4qmsZqdpERO3A34nmY1fOw@mail.gmail.com>
Message-ID: <CAL3q7H7rLgUBk6CrhpTuyFU3L4ww4qmsZqdpERO3A34nmY1fOw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] btrfs: simplify waiting for encoded read endios
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
	Damien Le Moal <Damien.LeMoal@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 1:54=E2=80=AFPM Johannes Thumshirn <jth@kernel.org>=
 wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Simplify the I/O completion path for encoded reads by using a
> completion instead of a wait_queue.
>
> Furthermore skip taking an extra reference that is instantly
> dropped anyways and convert btrfs_encoded_read_private::pending into a
> refcount_t filed instead of atomic_t.
>
> Freeing of the private data is now handled at a common place in
> btrfs_encoded_read_regular_fill_pages() and if btrfs_encoded_read_endio()
> is freeing the data in case it has an io_uring context associated, the
> btrfs_bio's private filed is NULLed to avoid a double free of the private
> data.
>
> Suggested-by: Damien Le Moal <Damien.LeMoal@wdc.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/inode.c | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index cb8b23a3e56b..3093905364e5 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -9068,9 +9068,9 @@ static ssize_t btrfs_encoded_read_inline(
>  }
>
>  struct btrfs_encoded_read_private {
> -       wait_queue_head_t wait;
> +       struct completion done;
>         void *uring_ctx;
> -       atomic_t pending;
> +       refcount_t refs;
>         blk_status_t status;
>  };
>
> @@ -9090,14 +9090,15 @@ static void btrfs_encoded_read_endio(struct btrfs=
_bio *bbio)
>                 WRITE_ONCE(priv->status, bbio->bio.bi_status);
>         }
>         bio_put(&bbio->bio);
> -       if (atomic_dec_and_test(&priv->pending)) {
> +       if (refcount_dec_and_test(&priv->refs)) {
>                 int err =3D blk_status_to_errno(READ_ONCE(priv->status));
>
>                 if (priv->uring_ctx) {
>                         btrfs_uring_read_extent_endio(priv->uring_ctx, er=
r);
> +                       bbio->private =3D NULL;

Isn't this racy?

We decremented priv->refs to 0, the task at
btrfs_encoded_read_regular_fill_pages() sees it as 0 and sees
bbio->private still as non-NULL, does a kfree() on it and then we do
it here again.

I.e. we should set bbio->private to NULL before decrementing, and
possibly some barriers.

Thanks.


>                         kfree(priv);
>                 } else {
> -                       wake_up(&priv->wait);
> +                       complete(&priv->done);
>                 }
>         }
>  }
> @@ -9116,8 +9117,8 @@ int btrfs_encoded_read_regular_fill_pages(struct bt=
rfs_inode *inode,
>         if (!priv)
>                 return -ENOMEM;
>
> -       init_waitqueue_head(&priv->wait);
> -       atomic_set(&priv->pending, 1);
> +       init_completion(&priv->done);
> +       refcount_set(&priv->refs, 1);
>         priv->status =3D 0;
>         priv->uring_ctx =3D uring_ctx;
>
> @@ -9130,7 +9131,7 @@ int btrfs_encoded_read_regular_fill_pages(struct bt=
rfs_inode *inode,
>                 size_t bytes =3D min_t(u64, disk_io_size, PAGE_SIZE);
>
>                 if (bio_add_page(&bbio->bio, pages[i], bytes, 0) < bytes)=
 {
> -                       atomic_inc(&priv->pending);
> +                       refcount_inc(&priv->refs);
>                         btrfs_submit_bbio(bbio, 0);
>
>                         bbio =3D btrfs_bio_alloc(BIO_MAX_VECS, REQ_OP_REA=
D, fs_info,
> @@ -9145,26 +9146,26 @@ int btrfs_encoded_read_regular_fill_pages(struct =
btrfs_inode *inode,
>                 disk_io_size -=3D bytes;
>         } while (disk_io_size);
>
> -       atomic_inc(&priv->pending);
>         btrfs_submit_bbio(bbio, 0);
>
>         if (uring_ctx) {
> -               if (atomic_dec_return(&priv->pending) =3D=3D 0) {
> +               if (bbio->private && refcount_read(&priv->refs) =3D=3D 0)=
 {
>                         ret =3D blk_status_to_errno(READ_ONCE(priv->statu=
s));
>                         btrfs_uring_read_extent_endio(uring_ctx, ret);
> -                       kfree(priv);
> -                       return ret;
> +                       goto out;
>                 }
>
>                 return -EIOCBQUEUED;
>         } else {
> -               if (atomic_dec_return(&priv->pending) !=3D 0)
> -                       io_wait_event(priv->wait, !atomic_read(&priv->pen=
ding));
> +               wait_for_completion_io(&priv->done);
>                 /* See btrfs_encoded_read_endio() for ordering. */
>                 ret =3D blk_status_to_errno(READ_ONCE(priv->status));
> -               kfree(priv);
> -               return ret;
>         }
> +
> +out:
> +       kfree(priv);
> +       return ret;
> +
>  }
>
>  ssize_t btrfs_encoded_read_regular(struct kiocb *iocb, struct iov_iter *=
iter,
> --
> 2.43.0
>
>

