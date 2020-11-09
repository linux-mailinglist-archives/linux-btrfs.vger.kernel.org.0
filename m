Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC642AB4A8
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Nov 2020 11:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbgKIKUZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Nov 2020 05:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgKIKUY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Nov 2020 05:20:24 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222C2C0613CF
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Nov 2020 02:20:23 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id z17so67211qvy.11
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Nov 2020 02:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=OT3OtEAZhSua7z+clGYvFpRqldS5LP1jn4WL8elJsZA=;
        b=osKIh9krz2tDl/H9KrJAyeRxf1aa0S+8fJOcxJEiR68ciGvaDzqwr2qyLPbidhVpNT
         fUrU4EGLbPIqmFRKOF5HlS7lerI1ChWoe29809bui9VtTyS9qCDKghMhmOsmOM8E0sUU
         tF0Rj7GFZcu/lRoFmdAd1yFNBii7KQi0uyUx04pOIa9WYAAqx90cHF1eIQ9K1M/odP57
         avC214/o2AZzxJYRxt54vmRsjZ25YrTOZdKuCHwtHeQlfGkhz02x0tRuIGUn+EUGHOZO
         KdjiM796OmuoEy5s9LEE8scCGcoQ+44D84TLUc0VKoP0taX+KjsySQqNTWX9DbyH28mw
         CZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=OT3OtEAZhSua7z+clGYvFpRqldS5LP1jn4WL8elJsZA=;
        b=UjQkj5ocvxieL+VWJ1VDisEUH62VWW+EXDcTJMfA78IqLgADyfq1NhMXI3yQPnRK98
         xF70Gif9nTyVr+rbW43FH+hVdcQDN4/S+CFZ0/R1C7NgPxHsKVhy/o+C+Z4YTt10I0ML
         pI+Gm95CEPi4RzXN9LFcRSbRRf4zaWrJkuaYLhIevyq0bBXm/noBIy97uEi54yZk4bKM
         AxnwzzGIqI91Du2cTyBhAXG7vptNijT+EiXAkIcZJBP3WN3YZicL7oLHspdVzPfXa4nT
         DAbhSSK0vCISC+gsXyyu+vqYQf6fvn9fLitZvFQ1caTSwNgEvhvPj2oua+sKg4X0BfWY
         Lo+A==
X-Gm-Message-State: AOAM532U1UCCA3wL0DF7McbdaGRQgKDQLXmJqDiSAqnAYz57iKclnwcg
        5eCmA5CIhCptz1P+fdbhC0c7MpJ07J5iT4QzaRKijgLjsavcMg==
X-Google-Smtp-Source: ABdhPJzE2ct8EseFgsJPmG6ex5Ng8S8GIX7Jtxi6qhXz5pMkAxKzWomL7jJVn1y8//AXvQKR2JmY70T72gNBQukw1Ys=
X-Received: by 2002:a0c:99e1:: with SMTP id y33mr13201159qve.62.1604917222360;
 Mon, 09 Nov 2020 02:20:22 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604697895.git.josef@toxicpanda.com> <c04e7bd2e5294b23eadbcafedca7214f7894c9e9.1604697895.git.josef@toxicpanda.com>
In-Reply-To: <c04e7bd2e5294b23eadbcafedca7214f7894c9e9.1604697895.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 9 Nov 2020 10:20:11 +0000
Message-ID: <CAL3q7H79FhNTbndm+R63H0EzvuuRpjfkaFWs59HdLT6+U0TNYA@mail.gmail.com>
Subject: Re: [PATCH 4/8] btrfs: remove the recursion handling code in locking.c
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 6, 2020 at 9:31 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> Now that we're no longer using recursion, rip out all of the supporting
> code.  Follow up patches will clean up the callers of these functions.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/locking.c | 63 ++--------------------------------------------
>  1 file changed, 2 insertions(+), 61 deletions(-)
>
> diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
> index d477df1c67db..9b66154803a7 100644
> --- a/fs/btrfs/locking.c
> +++ b/fs/btrfs/locking.c
> @@ -28,40 +28,16 @@
>   * Additionally we need one level nesting recursion, see below. The rwse=
m
>   * implementation does opportunistic spinning which reduces number of ti=
mes the
>   * locking task needs to sleep.
> - *
> - *
> - * Lock recursion
> - * --------------
> - *
> - * A write operation on a tree might indirectly start a look up on the s=
ame
> - * tree.  This can happen when btrfs_cow_block locks the tree and needs =
to
> - * lookup free extents.
> - *
> - * btrfs_cow_block
> - *   ..
> - *   alloc_tree_block_no_bg_flush
> - *     btrfs_alloc_tree_block
> - *       btrfs_reserve_extent
> - *         ..
> - *         load_free_space_cache
> - *           ..
> - *           btrfs_lookup_file_extent
> - *             btrfs_search_slot
> - *
>   */
>
>  /*
>   * __btrfs_tree_read_lock: Lock the extent buffer for read.
>   * @eb:  the eb to be locked
>   * @nest: the nesting level to be used for lockdep
> - * @recurse: if this lock is able to be recursed
> + * @recurse: unused.
>   *
>   * This takes the read lock on the extent buffer, using the specified ne=
sting
>   * level for lockdep purposes.
> - *
> - * If you specify recurse =3D true, then we will allow this to be taken =
if we
> - * currently own the lock already.  This should only be used in specific
> - * usecases, and the subsequent unlock will not change the state of the =
lock.
>   */
>  void __btrfs_tree_read_lock(struct extent_buffer *eb, enum btrfs_lock_ne=
sting nest,
>                             bool recurse)
> @@ -71,31 +47,7 @@ void __btrfs_tree_read_lock(struct extent_buffer *eb, =
enum btrfs_lock_nesting ne
>         if (trace_btrfs_tree_read_lock_enabled())
>                 start_ns =3D ktime_get_ns();
>
> -       if (unlikely(recurse)) {
> -               /* First see if we can grab the lock outright */
> -               if (down_read_trylock(&eb->lock))
> -                       goto out;
> -
> -               /*
> -                * Ok still doesn't necessarily mean we are already holdi=
ng the
> -                * lock, check the owner.
> -                */
> -               if (eb->lock_owner !=3D current->pid) {
> -                       down_read_nested(&eb->lock, nest);
> -                       goto out;
> -               }
> -
> -               /*
> -                * Ok we have actually recursed, but we should only be re=
cursing
> -                * once, so blow up if we're already recursed, otherwise =
set
> -                * ->lock_recursed and carry on.
> -                */
> -               BUG_ON(eb->lock_recursed);
> -               eb->lock_recursed =3D true;
> -               goto out;
> -       }
>         down_read_nested(&eb->lock, nest);
> -out:
>         eb->lock_owner =3D current->pid;
>         trace_btrfs_tree_read_lock(eb, start_ns);
>  }
> @@ -136,22 +88,11 @@ int btrfs_try_tree_write_lock(struct extent_buffer *=
eb)
>  }
>
>  /*
> - * Release read lock.  If the read lock was recursed then the lock stays=
 in the
> - * original state that it was before it was recursively locked.
> + * Release read lock.
>   */
>  void btrfs_tree_read_unlock(struct extent_buffer *eb)
>  {
>         trace_btrfs_tree_read_unlock(eb);
> -       /*
> -        * if we're nested, we have the write lock.  No new locking
> -        * is needed as long as we are the lock owner.
> -        * The write unlock will do a barrier for us, and the lock_recurs=
ed
> -        * field only matters to the lock owner.
> -        */
> -       if (eb->lock_recursed && current->pid =3D=3D eb->lock_owner) {
> -               eb->lock_recursed =3D false;
> -               return;
> -       }
>         eb->lock_owner =3D 0;
>         up_read(&eb->lock);
>  }
> --
> 2.26.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
