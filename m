Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3EFE2AB4C0
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Nov 2020 11:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbgKIKWx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Nov 2020 05:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgKIKWx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Nov 2020 05:22:53 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2297DC0613CF
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Nov 2020 02:22:53 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id u4so4654390qkk.10
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Nov 2020 02:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=ZjxR38LVFPAQ7zaWIYUhSH1idqnC3qCZIXOTpsrzWxI=;
        b=ipHIopaSnTxt33xUnVIIqqn+0JermZKBFuDhXgstYrCOPbyXRb8Ncc8QNwr7uITOcE
         BDW2o7KN7m71ovj7YB59ihy/lKoinraAiPaxBtDoNvAezHaN5pfA2FU5Rm6HUP3vNXt1
         MNln6gmIHs5dLghvE2gNpmJ3fKRMgVZTGDoiaz6a+VoKy5c5BC2IBZh+/JAKUXVcaCnL
         fYK2fwI/AwCm8jRwBFLdKHEs/JATkeMPHoGmkladbd+mQxrsrFeS6tjhqSFW/Wlod73I
         T9QkVCKBADFrNzVVYCBSve8TESh4XXHdd4TatzOlAIA9PAQbloOPLHx/c0AarD9gtpnR
         QgoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=ZjxR38LVFPAQ7zaWIYUhSH1idqnC3qCZIXOTpsrzWxI=;
        b=ay34EB7kpDG9pJlebxzYKFIaWAQaAfEUnRQ8i+WdvBzOTYVmPuSjt69K7wp/POaL2k
         7QuewE3Y0gyUypro3p4KYSrskQU26gDcDplqzRcKGHmXJDKbtWGQ1gxJnW6dTzTZRTTc
         QUeIhSEFhs19Wv0hbEfBpAMuTh5rkk2h09eVueS3qh/TE0C59XSq3LZ/5VTjvzuwfO2b
         9dPTJNUAsbJF/7G8+eRV8vCLfsCDBsdHEOVbjAesIWYCGbA5U/8cGGT2aCyWULG6imcU
         JviIW7KEVvyKaNhy2JkL8JbqHShU7CZStUWvrdEt1lRmmkUxIX8xG5cw5HTx4kFmaHib
         Et6A==
X-Gm-Message-State: AOAM530geqBV74p4nynmH3hhONbHdrag9sf4rCHBmHlrjt3g2WZuAaxs
        42QFca95PiSxViPDYtWTALHCDXK5A9pmQ2C6I68Q0J172aTPbA==
X-Google-Smtp-Source: ABdhPJwOuU8UG9h/X5YCk2Fu7KSmA3QjYKJ1nFJRFLRShRVTCs/Dn615XbEHzQaQQvbAs7MXUvg8ih1dRyxMHC5RiU4=
X-Received: by 2002:a37:7c81:: with SMTP id x123mr12336415qkc.383.1604917372449;
 Mon, 09 Nov 2020 02:22:52 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604697895.git.josef@toxicpanda.com> <64f17b720411228ac68fae00852ea391103aedc5.1604697895.git.josef@toxicpanda.com>
In-Reply-To: <64f17b720411228ac68fae00852ea391103aedc5.1604697895.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 9 Nov 2020 10:22:41 +0000
Message-ID: <CAL3q7H7uRaOqBHVMFd8rEdOUAc3D13YoEPyfz5GwiG5hw03kmA@mail.gmail.com>
Subject: Re: [PATCH 7/8] btrfs: remove the recurse parameter from __btrfs_tree_read_lock
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 6, 2020 at 9:29 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> It is completely unused now, remove it.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/locking.c | 6 ++----
>  fs/btrfs/locking.h | 3 +--
>  2 files changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
> index c8b239376fb4..e6fa53dddbb6 100644
> --- a/fs/btrfs/locking.c
> +++ b/fs/btrfs/locking.c
> @@ -34,13 +34,11 @@
>   * __btrfs_tree_read_lock: Lock the extent buffer for read.
>   * @eb:  the eb to be locked
>   * @nest: the nesting level to be used for lockdep
> - * @recurse: unused.
>   *
>   * This takes the read lock on the extent buffer, using the specified ne=
sting
>   * level for lockdep purposes.
>   */
> -void __btrfs_tree_read_lock(struct extent_buffer *eb, enum btrfs_lock_ne=
sting nest,
> -                           bool recurse)
> +void __btrfs_tree_read_lock(struct extent_buffer *eb, enum btrfs_lock_ne=
sting nest)
>  {
>         u64 start_ns =3D 0;
>
> @@ -54,7 +52,7 @@ void __btrfs_tree_read_lock(struct extent_buffer *eb, e=
num btrfs_lock_nesting ne
>
>  void btrfs_tree_read_lock(struct extent_buffer *eb)
>  {
> -       __btrfs_tree_read_lock(eb, BTRFS_NESTING_NORMAL, false);
> +       __btrfs_tree_read_lock(eb, BTRFS_NESTING_NORMAL);
>  }
>
>  /*
> diff --git a/fs/btrfs/locking.h b/fs/btrfs/locking.h
> index 91441e31db18..a2e1f1f5c6e3 100644
> --- a/fs/btrfs/locking.h
> +++ b/fs/btrfs/locking.h
> @@ -87,8 +87,7 @@ void __btrfs_tree_lock(struct extent_buffer *eb, enum b=
trfs_lock_nesting nest);
>  void btrfs_tree_lock(struct extent_buffer *eb);
>  void btrfs_tree_unlock(struct extent_buffer *eb);
>
> -void __btrfs_tree_read_lock(struct extent_buffer *eb, enum btrfs_lock_ne=
sting nest,
> -                           bool recurse);
> +void __btrfs_tree_read_lock(struct extent_buffer *eb, enum btrfs_lock_ne=
sting nest);
>  void btrfs_tree_read_lock(struct extent_buffer *eb);
>  void btrfs_tree_read_unlock(struct extent_buffer *eb);
>  int btrfs_try_tree_read_lock(struct extent_buffer *eb);
> --
> 2.26.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
