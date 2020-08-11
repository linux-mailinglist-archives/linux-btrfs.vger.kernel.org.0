Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02187241A61
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Aug 2020 13:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgHKL2f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Aug 2020 07:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbgHKL2f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Aug 2020 07:28:35 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F7EC06174A
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Aug 2020 04:28:34 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id i20so2547759vkk.2
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Aug 2020 04:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=fFzIACV6z97VQUuvoEwe6Xi3FP92mIYFYOJ9k0IhdJs=;
        b=qZxW5T/80Gmd1Cb3777xp9ILHAD/M3XfHUKTtz9u3jCt8rHOHqwKDWYumiV8HmsF15
         Oju8EH9p4EcwrHE/fpffYSo7Hez6fvEmSvD13USCYA7YtmUStUeHZWbt9KpUBOp/oDWr
         bFJstHOBhHcPVgEdNeayE3EoLEa4BP4YjMNC1j9cxbbzVZH/jqKpQY9T5rm0W+yP3t0g
         L3Fud3hZtZv7JHPAcEzi/zn9Yaz2EcuKauDCjf3QkhgXtdJc5z42GH/gq+UdQRnj9n5C
         cN8jMVjp4v71mMGtTVuf+xsoeBFNEosHPeoI/xICUjbYYOQokEXqoFIgFxmaik9jNpUC
         8akQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=fFzIACV6z97VQUuvoEwe6Xi3FP92mIYFYOJ9k0IhdJs=;
        b=fZLlsGBoUbi//ptLnoTty6gJo9q5c0dYYCgCqoHPod1x9QfvDa7Z/lI7e1uRdGmnHv
         wE+WEHnk74JVCff9CrBGPtxcqfE2tPuQc2MS4gNMUHoXVw6Y4aonoBU0C3WEMYIqAcn8
         isd+Ye+JIdTnJDyj+TN3byp5UzmsG4Y/+hu2j9gFJ8HnbV/m6+AeZ37fok3i0gLlnMPz
         CxnOC5y8WT6gWUvTMD3tE8mQM1ht3yHWxCjNSYsmw643iD7MZg0whP3Bwi5y/UUNsk0o
         Y4S6bEuJEqyyPRjg+tvW8+rxRt9DoAmXh7x+k0XLMnmRncvsArL3vFAJaec10XpDFu9Q
         EJQA==
X-Gm-Message-State: AOAM531KtRjAbW5ZzoEUznQH/4d2lnb1TyYz+f86KT4M5lL8o2qOM/9H
        LeRj/7uNltwi4tn2xJmjCNLx7nw+0mHjLhYV8WM=
X-Google-Smtp-Source: ABdhPJykBlCpsSTFM9yZDG7X8n0ogZ53o007ZP1dIKvBHk70ObOgXigW3KpYk9QE4I2Rvpo7BmxtOjX6ApU9MKuFHZU=
X-Received: by 2002:a1f:2a48:: with SMTP id q69mr23822504vkq.69.1597145313580;
 Tue, 11 Aug 2020 04:28:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200810154242.782802-1-josef@toxicpanda.com> <20200810154242.782802-7-josef@toxicpanda.com>
In-Reply-To: <20200810154242.782802-7-josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 11 Aug 2020 12:28:22 +0100
Message-ID: <CAL3q7H6MsM7sUTaBGAftz9VfEmmgpLd-oQdg8756oRK-PPjvUg@mail.gmail.com>
Subject: Re: [PATCH 06/17] btrfs: set the lockdep class for log tree extent buffers
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 10, 2020 at 4:44 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> These are special extent buffers that get rewound in order to lookup
> the state of the tree at a specific point in time.  As such they do not
> go through the normal initialization paths that set their lockdep class,
> so handle them appropriately when they are created and before they are
> locked.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/ctree.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 70e49d8d4f6c..cbacf700b68b 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -1297,6 +1297,8 @@ tree_mod_log_rewind(struct btrfs_fs_info *fs_info, =
struct btrfs_path *path,
>         btrfs_tree_read_unlock_blocking(eb);
>         free_extent_buffer(eb);
>
> +       btrfs_set_buffer_lockdep_class(btrfs_header_owner(eb_rewin),
> +                                      eb_rewin, btrfs_header_level(eb_re=
win));
>         btrfs_tree_read_lock(eb_rewin);
>         __tree_mod_log_rewind(fs_info, eb_rewin, time_seq, tm);
>         WARN_ON(btrfs_header_nritems(eb_rewin) >
> @@ -1370,7 +1372,6 @@ get_old_root(struct btrfs_root *root, u64 time_seq)
>
>         if (!eb)
>                 return NULL;
> -       btrfs_tree_read_lock(eb);
>         if (old_root) {
>                 btrfs_set_header_bytenr(eb, eb->start);
>                 btrfs_set_header_backref_rev(eb, BTRFS_MIXED_BACKREF_REV)=
;
> @@ -1378,6 +1379,9 @@ get_old_root(struct btrfs_root *root, u64 time_seq)
>                 btrfs_set_header_level(eb, old_root->level);
>                 btrfs_set_header_generation(eb, old_generation);
>         }
> +       btrfs_set_buffer_lockdep_class(btrfs_header_owner(eb), eb,
> +                                      btrfs_header_level(eb));
> +       btrfs_tree_read_lock(eb);
>         if (tm)
>                 __tree_mod_log_rewind(fs_info, eb, time_seq, tm);
>         else
> --
> 2.24.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
