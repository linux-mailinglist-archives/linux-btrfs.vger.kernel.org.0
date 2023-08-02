Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2627676CC64
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Aug 2023 14:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234320AbjHBMMd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Aug 2023 08:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234507AbjHBMMS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Aug 2023 08:12:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F3F3592
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Aug 2023 05:11:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3824161957
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Aug 2023 12:11:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9720AC433C9
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Aug 2023 12:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690978312;
        bh=bdYp4bMg/isb0WkFQEew9Pir2Inw4lUO/Go8gXAXHgE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AX+N4ociGCj+sXEPO0iOXErtRRvDOJkr08mslS0X1pj+TtnkGIELNS9xDINPx2U2n
         n9MzO+8PZq4Ke671hCLzFu6entav2s5Fju21j6PoNe7Zm7fQzuobLlc6Z1HqGFCKl8
         U8QAiRxN6m3bzzoQZnb2jUUX6Y/fheHV+0PuCzWsX+Cni5g1LdaGXjKH4aBLODx5wP
         D7oPrAPn5UcLSNN7TXy5PPNRw+MLMa0/lCotQiwKg9QBQo2vgTlkYMfMRGmlPYEkLG
         ecNkSZNmCooW2554bQ1ji9d0oG6PGL0lCkt2tzcbnTwEA7ylsVisJ3KTs19m0AZkmN
         h94vE0HdflpuA==
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3a74d759be4so1313912b6e.2
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Aug 2023 05:11:52 -0700 (PDT)
X-Gm-Message-State: ABy/qLbX/5qqCOreFx1mD3K2beLju14KU1pareJV9UJtWdm9mWeKgxlV
        C4NiSO1Ns9xGSLQm9AqGLUryvq4U07QMb5DlErY=
X-Google-Smtp-Source: APBJJlFepttuCifMkRFPlaPYQ4DK2QwDA2AA88jXQPjRwoHJQDjo2RkOP5V6c0n0JS3xZB2Lzv5MhMw41LnFqlNBLac=
X-Received: by 2002:a05:6808:148a:b0:3a7:3792:5b96 with SMTP id
 e10-20020a056808148a00b003a737925b96mr11313509oiw.14.1690978311779; Wed, 02
 Aug 2023 05:11:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1690970028.git.wqu@suse.com> <a15ff1e397312309c554482e55d929488e22dcca.1690970028.git.wqu@suse.com>
In-Reply-To: <a15ff1e397312309c554482e55d929488e22dcca.1690970028.git.wqu@suse.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 2 Aug 2023 13:11:15 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6Q__RBAJBhWJBhOPtTLg7nhXei81wKmy=W6iO5RX=yAg@mail.gmail.com>
Message-ID: <CAL3q7H6Q__RBAJBhWJBhOPtTLg7nhXei81wKmy=W6iO5RX=yAg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] btrfs: reject invalid reloc tree root keys with
 stack dump
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 2, 2023 at 12:24=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> Syzbot reported a crash that an ASSERT() got triggered inside
> prepare_to_merge().
>
> That ASSERT() makes sure the reloc tree is properly pointed back by its
> subvolume tree.
>
> [CAUSE]
> After more debugging output, it turns out we had an invalid reloc tree:
>
>  BTRFS error (device loop1): reloc tree mismatch, root 8 has no reloc roo=
t, expect reloc root key (-8, 132, 8) gen 17
>
> Note the above root key is (TREE_RELOC_OBJECTID, ROOT_ITEM,
> QUOTA_TREE_OBJECTID), meaning it's a reloc tree for quota tree.
>
> But reloc trees can only exist for subvolumes, as for non-subvolume
> trees, we just COW the involved tree block, no need to create a reloc
> tree since those tree blocks won't be shared with other trees.
>
> Only subvolumes tree can share tree blocks with other trees (thus they
> have BTRFS_ROOT_SHAREABLE flag).
>
> Thus this new debug output proves my previous assumption that corrupted
> on-disk data can trigger that ASSERT().
>
> [FIX]
> Besides the dedicated fix and the graceful exit, also let tree-checker to
> check such root keys, to make sure reloc trees can only exist for
> subvolumes.
>
> Reported-by: syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/disk-io.c      |  3 ++-
>  fs/btrfs/tree-checker.c | 15 +++++++++++++++
>  2 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 5fd336c597e9..a01eac963075 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1103,7 +1103,8 @@ static int btrfs_init_fs_root(struct btrfs_root *ro=
ot, dev_t anon_dev)
>         btrfs_drew_lock_init(&root->snapshot_lock);
>
>         if (root->root_key.objectid !=3D BTRFS_TREE_LOG_OBJECTID &&
> -           !btrfs_is_data_reloc_root(root)) {
> +           !btrfs_is_data_reloc_root(root) &&
> +           is_fstree(root->root_key.objectid)) {
>                 set_bit(BTRFS_ROOT_SHAREABLE, &root->state);
>                 btrfs_check_and_init_root_item(&root->root_item);
>         }
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index 038dfa8f1788..dabb86314a4c 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -446,6 +446,21 @@ static int check_root_key(struct extent_buffer *leaf=
, struct btrfs_key *key,
>         btrfs_item_key_to_cpu(leaf, &item_key, slot);
>         is_root_item =3D (item_key.type =3D=3D BTRFS_ROOT_ITEM_KEY);
>
> +       /*
> +        * Bad rootid for reloc trees.
> +        *
> +        * Reloc trees are only for subvolume trees, other trees only nee=
ds
> +        * a COW to be relocated.

... other trees only need to be COWed to be relocated.

> +        */
> +       if (unlikely(is_root_item && key->objectid =3D=3D BTRFS_TREE_RELO=
C_OBJECTID &&
> +                    !is_fstree(key->offset))) {
> +               generic_err(leaf, slot,
> +       "invalid reloc tree for root %lld, root id is not a subvolume tre=
e",
> +                           key->offset);
> +               dump_stack();

Same logic as for places that do WARN_ON() or dump leaves: the
dump_stack() should come before the error message.

Other than that, it looks good to me:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> +               return -EUCLEAN;
> +       }
> +
>         /* No such tree id */
>         if (unlikely(key->objectid =3D=3D 0)) {
>                 if (is_root_item)
> --
> 2.41.0
>
