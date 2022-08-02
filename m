Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4475881B4
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Aug 2022 20:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237490AbiHBSJf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Aug 2022 14:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237498AbiHBSJV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Aug 2022 14:09:21 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC21A25EB0
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Aug 2022 11:09:19 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id w6so1248505qkf.3
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Aug 2022 11:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc;
        bh=Hrwa3tPiXPQVwtzpp+EsczzzZ5tfCC2WA0tUJGLJH7U=;
        b=c5Evj5gk3+c50575533mMc4rjz5/y39GkmSq2RW7DK2klGwrTGwt9q3khQ/1Z8Ysg+
         ICxNZqbycjNbTB8R9CGbFWmFRJ0kJzJmUUHuSNKImZNUZEXfkNMdcU3sc524+F+1pU1H
         Q1XbrVPl2SAxHBHbAqmRrqzqQTgdoWQ2QFYkxca4fk1GCq+ox1X1mkZ9Ybk3TQl/CiD7
         EXxm22REhw/eYDqFdL15ip4bHGYg1h/oTw+KHCV9/Dg3uxFa5/56s056+ObyTs+8VudC
         5Y8O2z9kD1pUQpfq5fR9j0TS5uwNa7YzFLleHi0UD6yK8s72uEzN5tbE7EG7GEex0p6L
         NdrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc;
        bh=Hrwa3tPiXPQVwtzpp+EsczzzZ5tfCC2WA0tUJGLJH7U=;
        b=xxYalCPUIzeWErMdaFC7nHPuXr44qROTygYTnv0FGIVyL0zmqK8VPmCN6R/IqGeKx4
         uHlkAofNNveSyVXdj8kfyvO8Uiq40WpgJ8REhkwOnPK9SubnNPoC9o0cw5XbzIAnPD5x
         sfMncUR1VgOaqZioNHWw5uHKUpUHWvsmdymcVHrfgokLZnJ7wEgoRBSHdu/AoWOG9jC3
         k02zQLZSplHObZPwN20loq+ZruIoieowW/lci1Cpi8gj97BaosoOV8Wi3ZpgeoCdfDBJ
         gvEa2xdwI4FekX9BiOc0LSlojsack8gedr8fNmznc52T+rinfbKU6eCAA0rfENlZpb7s
         lyvw==
X-Gm-Message-State: AJIora8FMT8c5QxEUTsoc9Ay9LJEYQm/S2OoLHq3VWgvwFIuYkCNiuVN
        aUYonKCXP6cAhQXdgxGXoPrirvrdaQ0/V5weU3w=
X-Google-Smtp-Source: AGRyM1vevCiiNxx2ZQ4vEW79eps5twnD8IKAC9L+PqJDnZNYlG72FccYRV2JAHI+0k66ZHUE1D8LiqzOOjbzIxxOI0w=
X-Received: by 2002:a05:620a:4905:b0:6b5:c742:6161 with SMTP id
 ed5-20020a05620a490500b006b5c7426161mr16452524qkb.107.1659463758827; Tue, 02
 Aug 2022 11:09:18 -0700 (PDT)
MIME-Version: 1.0
References: <27a36e2b4cf30de8f7a04e718ba47bb9e98ddb85.1658419807.git.josef@toxicpanda.com>
In-Reply-To: <27a36e2b4cf30de8f7a04e718ba47bb9e98ddb85.1658419807.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 2 Aug 2022 19:08:42 +0100
Message-ID: <CAL3q7H7=jb5j=p14khCNN2uev23bVg8+ttAFisKU7nmQsFCv_Q@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix infinite loop with dio faulting
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 21, 2022 at 5:12 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> Filipe removed the check for the case where we are constantly trying to
> fault in the buffer from user space for DIO reads.  He left it for
> writes, but for reads you can end up in this infinite loop trying to
> fault in a page that won't fault in.

Yes, and the removal was intentional (not by accident).

Adding the check back makes the same check at dio_fault_in_size()
useless and redundant.

> This is the patch I applied ontop
> of his patch, without this I was able to get generic/475 to get stuck
> infinite looping.

This doesn't answer why the infinite loop happens.
Why can't we faultin at least one page? Have you checked why this happens?

So I'd rather not fold this into the original patch, and instead
revert it until we know exactly why we end in the infinite loop.

Thanks.

> This patch is currently staged so we can probably just fold this into
> his actual patch.
>
> Fixes: 5ad7531dbe67 ("btrfs: fault in pages for direct io reads/writes in=
 a more controlled way")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/file.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 1876072dee9d..79f866e36368 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -3806,20 +3806,21 @@ static ssize_t btrfs_direct_read(struct kiocb *io=
cb, struct iov_iter *to)
>                 read =3D ret;
>
>         if (iov_iter_count(to) > 0 && (ret =3D=3D -EFAULT || ret > 0)) {
> -               if (iter_is_iovec(to)) {
> -                       const size_t left =3D iov_iter_count(to);
> -                       const size_t size =3D dio_fault_in_size(iocb, to,=
 prev_left);
> +               const size_t left =3D iov_iter_count(to);
>
> -                       fault_in_iov_iter_writeable(to, size);
> -                       prev_left =3D left;
> -                       goto again;
> -               } else {
> +               if (left =3D=3D prev_left) {
>                         /*
>                          * fault_in_iov_iter_writeable() only works for i=
ovecs,
>                          * return with a partial read and fallback to buf=
fered
>                          * IO for the rest of the range.
>                          */
>                         ret =3D read;
> +               } else {
> +                       const size_t size =3D dio_fault_in_size(iocb, to,=
 prev_left);
> +
> +                       fault_in_iov_iter_writeable(to, size);
> +                       prev_left =3D left;
> +                       goto again;
>                 }
>         }
>         btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
> --
> 2.26.3
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
