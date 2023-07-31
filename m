Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A2F769594
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Jul 2023 14:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbjGaMGt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Jul 2023 08:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjGaMGp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Jul 2023 08:06:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3643410E9
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 05:06:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C02526105A
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 12:06:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B29C433C8
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 12:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690805202;
        bh=baMcraqtHYJkIFTPVKbs7LYpuHS+p4/4OSfcOlIU83I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=D0Bs5osQ3KFjkW5ZrT5GjY00qJjWEm2bI7vaVsSjuhlG0SKIwhXRZTWS2cyFjpzNT
         1nYWDP/xRq5or0ifjZ5wryRB4h/DztX5MLwxRzSpMfaDhcg8BM8I9AF2/24AyVqe2m
         y/7l5O9Zv7qS7LwkNdMgG2V8/WO7dk0tV9jjex3T+eK6XtgOVOkHxwMkNvaNJgnmgA
         0xMaxmH8nOX0GwvS5vrck7k+FNPY2nxmoQD9SuizGG7lJIBZPFnPx53ZtfdiI7w90M
         Y3s/yZPk1rITFcspe1YCHzklGmhU/UBgFtvmUdQPNDy3x1G8lufrzGXTwp0rN0P7Pv
         9ZNKbsDay3mWw==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1bb7d1f7aeaso3415900fac.1
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 05:06:42 -0700 (PDT)
X-Gm-Message-State: ABy/qLZRKraa59KPsAwF5MCy8ivatGLcyj0ENUzxEwswkZlDlasYR1Eq
        8h/7PJKmavr9p9R67eJ8+OwF840kEvqPC6jnUzY=
X-Google-Smtp-Source: APBJJlHucWSbXqNTbx1Qn3jDnQ2MBG6Cixq64Pd4m8F1pEV4ycey4U9x48e04EAlC3skNNJIg0y9ildZL+1Z+wKMc0o=
X-Received: by 2002:a05:6870:b152:b0:1bc:d479:ed70 with SMTP id
 a18-20020a056870b15200b001bcd479ed70mr5844835oal.25.1690805201307; Mon, 31
 Jul 2023 05:06:41 -0700 (PDT)
MIME-Version: 1.0
References: <5e4c3eaf235f8a73054f06d8fa68673566a5b323.1690783136.git.wqu@suse.com>
In-Reply-To: <5e4c3eaf235f8a73054f06d8fa68673566a5b323.1690783136.git.wqu@suse.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 31 Jul 2023 13:06:05 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5UHX9SD8vzsWAKERAp=f8JJJWKXa9zPg6g84O9ATA_UA@mail.gmail.com>
Message-ID: <CAL3q7H5UHX9SD8vzsWAKERAp=f8JJJWKXa9zPg6g84O9ATA_UA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: output extra debug info if we failed to find an
 inline backref
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 31, 2023 at 7:16=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> Syzbot reported several warning triggered inside
> lookup_inline_extent_backref().
>
> [CAUSE]
> As usual, the reproducer doesn't reliably trigger locally here, but at
> least we know the WARN_ON() is triggered when an inline backref can not
> be found, and it can only be triggered when @insert is true. (aka,
> inserting a new inline backref, which means the backref should already
> exist)
>
> [ENHANCEMENT]
> Instead of a plain WARN_ON(), dump all the parameter and the extent tree
> leaf to help debug.
>
> Link: https://syzkaller.appspot.com/bug?extid=3Dd6f9ff86c1d804ba2bc6
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent-tree.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 3cae798499e2..51a721b7156e 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -847,7 +847,13 @@ int lookup_inline_extent_backref(struct btrfs_trans_=
handle *trans,
>         if (ret && !insert) {
>                 err =3D -ENOENT;
>                 goto out;
> -       } else if (WARN_ON(ret)) {
> +       } else if (unlikely(ret)) {
> +               btrfs_err(fs_info,
> +"inline backref not found, bytenr %llu num_bytes %llu parent %llu root_o=
bjectid %llu owner %llu offset %llu",
> +                         bytenr, num_bytes, parent, root_objectid, owner=
,
> +                         offset);
> +               btrfs_print_leaf(path->nodes[0]);
> +               WARN_ON(1);

The error messages should be printed after dumping the leaf.
This is what we generally do to make sure the message is seen on logs
from screenshots sometimes sent by users.

For the same reason, the WARN_ON() should also happen before the error mess=
age.
Also why did you remove it from the else-if statement? WARN_ON()
already uses 'unlikely'.

Thanks.

>                 err =3D -EIO;
>                 goto out;
>         }
> --
> 2.41.0
>
