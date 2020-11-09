Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98FFB2AB4AC
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Nov 2020 11:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgKIKVL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Nov 2020 05:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgKIKVL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Nov 2020 05:21:11 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334D2C0613CF
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Nov 2020 02:21:11 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id v143so2849558qkb.2
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Nov 2020 02:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=RM+pxGYctrKLXtJlUzHXK5cF6Vg8MqMPQwkQlMxggu4=;
        b=DN+TWjHkVE+5uqopAtwyjoGUloXwvo9gi0Tgq0UuretYv8OFhZ314O7iXTRQWSBk7r
         OCnhX5z9fGqOW8QI2/rScHAhzlagzSpoXxTNHjVNOndyS8pkDuqsjTCZeKVikkslDhg4
         BUZv2/ptqubf8tfz99vWwoywYikQ0jWi50AP31QIScYUt7atR+Ts2U1XuxwIBKHImUIi
         hjPcBn+ucEDZITvypyTpeA8oHnSLg4GOC3jam9/PywtEranh3p01KIBzH+AwX9fHho3C
         VzXwg9cYSBr4HVlVUh9jSfchaKck6sxW2sOxLMzWOafRz1QpeUJUGqVqbeRSM7akLdJ5
         J9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=RM+pxGYctrKLXtJlUzHXK5cF6Vg8MqMPQwkQlMxggu4=;
        b=Zzk0k8qwcK+/T/pluNWF5oXqmMniWPxGW02S1GfH9QuN+tRgc3uETk0oVaPFPJx8Y6
         SgkPJGr2nfE+xH73VL4bm9VvDHkoia+BT2shiCN0J41N1KtGYaYrvt+cTQzPRinqS8Dk
         4QrvVNF4x6ps57HQcv1tWje0+dOECfvulMvpJ+TL0UUTCxCkcUwahXBo2ClbcF6hHkbj
         idABwcZE6WmUYr35aLnUsxm3zqV+sVMccR0V+bIca02NU9HUo4++ii1AtiHcgZHKdsUN
         RY74nklorYnSs0Q9lHBCpl1utxzXwZzqf+3UyGhS0KelRMI8aJ80lrusYXSPBTR+Ro6z
         2DEg==
X-Gm-Message-State: AOAM533DrRG88LICt+5vAB/UK6C+G4kVbxW/KMIjZElFZThlhpXJ9yoo
        zWQAxH6Ioc8J2Li7OthEjkPc4lJmiZ6r6qzAKyc=
X-Google-Smtp-Source: ABdhPJy1GBjmo/JkAysPVAY7IwJBa4IE5eObd1Lv4J8iV0APpFqzYsIDo7Z5HF0C7DMCnBOszOqMHBZ8e7SozDuPayA=
X-Received: by 2002:a37:7c81:: with SMTP id x123mr12331678qkc.383.1604917270475;
 Mon, 09 Nov 2020 02:21:10 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604697895.git.josef@toxicpanda.com> <295a64e139b18fdbedd872f2be8c4688d9f18364.1604697895.git.josef@toxicpanda.com>
In-Reply-To: <295a64e139b18fdbedd872f2be8c4688d9f18364.1604697895.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 9 Nov 2020 10:20:59 +0000
Message-ID: <CAL3q7H4PqK1Uf_duNZJNzxzqgsVatvTmu0V3qnKRGVkRnYzijg@mail.gmail.com>
Subject: Re: [PATCH 5/8] btrfs: remove __btrfs_read_lock_root_node
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 6, 2020 at 9:30 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> We no longer have recursive locking, so remove this variant.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/ctree.c   | 2 +-
>  fs/btrfs/locking.c | 5 ++---
>  fs/btrfs/locking.h | 8 +-------
>  3 files changed, 4 insertions(+), 11 deletions(-)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index cdd86ced917a..ef7389e6be3d 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -2588,7 +2588,7 @@ static struct extent_buffer *btrfs_search_slot_get_=
root(struct btrfs_root *root,
>                  * We don't know the level of the root node until we actu=
ally
>                  * have it read locked
>                  */
> -               b =3D __btrfs_read_lock_root_node(root, 0);
> +               b =3D btrfs_read_lock_root_node(root);
>                 level =3D btrfs_header_level(b);
>                 if (level > write_lock_level)
>                         goto out;
> diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
> index 9b66154803a7..c8b239376fb4 100644
> --- a/fs/btrfs/locking.c
> +++ b/fs/btrfs/locking.c
> @@ -185,14 +185,13 @@ struct extent_buffer *btrfs_lock_root_node(struct b=
trfs_root *root)
>   *
>   * Return: root extent buffer with read lock held
>   */
> -struct extent_buffer *__btrfs_read_lock_root_node(struct btrfs_root *roo=
t,
> -                                                 bool recurse)
> +struct extent_buffer *btrfs_read_lock_root_node(struct btrfs_root *root)
>  {
>         struct extent_buffer *eb;
>
>         while (1) {
>                 eb =3D btrfs_root_node(root);
> -               __btrfs_tree_read_lock(eb, BTRFS_NESTING_NORMAL, recurse)=
;
> +               btrfs_tree_read_lock(eb);
>                 if (eb =3D=3D root->node)
>                         break;
>                 btrfs_tree_read_unlock(eb);
> diff --git a/fs/btrfs/locking.h b/fs/btrfs/locking.h
> index f8f2fd835582..91441e31db18 100644
> --- a/fs/btrfs/locking.h
> +++ b/fs/btrfs/locking.h
> @@ -94,13 +94,7 @@ void btrfs_tree_read_unlock(struct extent_buffer *eb);
>  int btrfs_try_tree_read_lock(struct extent_buffer *eb);
>  int btrfs_try_tree_write_lock(struct extent_buffer *eb);
>  struct extent_buffer *btrfs_lock_root_node(struct btrfs_root *root);
> -struct extent_buffer *__btrfs_read_lock_root_node(struct btrfs_root *roo=
t,
> -                                                 bool recurse);
> -
> -static inline struct extent_buffer *btrfs_read_lock_root_node(struct btr=
fs_root *root)
> -{
> -       return __btrfs_read_lock_root_node(root, false);
> -}
> +struct extent_buffer *btrfs_read_lock_root_node(struct btrfs_root *root)=
;
>
>  #ifdef CONFIG_BTRFS_DEBUG
>  static inline void btrfs_assert_tree_locked(struct extent_buffer *eb) {
> --
> 2.26.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
