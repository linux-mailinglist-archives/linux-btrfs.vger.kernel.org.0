Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A9B71FEA1
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jun 2023 12:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbjFBKKJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Jun 2023 06:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235318AbjFBKKE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Jun 2023 06:10:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8259D1A7
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Jun 2023 03:09:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00F26616EB
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Jun 2023 10:09:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA2BC4339B
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Jun 2023 10:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685700591;
        bh=V+/0UnQMnCTcXKylWGoNHh/z/PfwEpveITloB93Ved0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Mn2R8LEpZ5Ib3ZWNuo9zHIRzJsQcRayJ2XhRW5johOFHUPNa1vMr0zsW4Va3FSsbG
         lOLrR1X3syG3JWMXo3sQxmb2OcqCLJd3WniTqARSuoWWzAPXcIXIYsidCPm5b3iL0x
         9CbHvbdfSeYyi3tjQEjuC/7n0BdodD2xM/KvORbu3LQLDk7QEGAAjtOZSI9HGugpHg
         +ZUssmSYA2JAaRSYz/57HE7W73/NCZVhZsqBQfdbNzyOL0QFicYheuv/+G0pkTOWEM
         7Jqk1PZGftcFQVTiPAAN+NnJvDhkfhQ2UtM1RYf1+rXOjcuu24x8EN1u+TbopsAQLy
         q1lknoG2+7Tmw==
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6af549a7fb4so2101035a34.1
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Jun 2023 03:09:51 -0700 (PDT)
X-Gm-Message-State: AC+VfDzYUzeZJSHkIy+ZWPJuCBSQoH6EQDnCYBxpCVGFIWAuPnQAYrN/
        umoJcTUolKKCYEH0AhUvAhuUqP2IqkLfPf2wo2Q=
X-Google-Smtp-Source: ACHHUZ4+w2aiH2OQgn42EhzGTJEx+BMvPkS/JUixKIM7lxsAoLpgONIy/MseVKEuKkitGd7AFXTT3Mc7Wtan2gd1DBo=
X-Received: by 2002:a05:6870:1706:b0:199:fa90:a62 with SMTP id
 h6-20020a056870170600b00199fa900a62mr1090031oae.8.1685700590330; Fri, 02 Jun
 2023 03:09:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685645613.git.boris@bur.io> <742a0f5e01de22aae0ada9504834b0e5e3177349.1685645613.git.boris@bur.io>
In-Reply-To: <742a0f5e01de22aae0ada9504834b0e5e3177349.1685645613.git.boris@bur.io>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 2 Jun 2023 11:09:14 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6W69Ybd5-+2NdqBeaX3oi4nCkQK_YTQJr0yNgt9BveDQ@mail.gmail.com>
Message-ID: <CAL3q7H6W69Ybd5-+2NdqBeaX3oi4nCkQK_YTQJr0yNgt9BveDQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] btrfs: warn on invalid slot in tree mod log rewind
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 1, 2023 at 7:55=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> The way that tree mod log tracks the ultimate length of the eb, the
> variable 'n', eventually turns up the correct value, but at intermediate
> steps during the rewind, n can be inaccurate as a representation of the
> end of the eb. For example, it doesn't get updated on move rewinds, and
> it does get updated for add/remove in the middle of the eb.
>
> To detect cases with invalid moves, introduce a separate variable called
> max_slot which tries to track the maximum valid slot in the rewind eb.
> We can then warn if we do a move whose src range goes beyond the max
> valid slot.
>
> There is a commented caveat that it is possible to have this value be an
> overestimate due to the challenge of properly handling 'add' operations
> in the middle of the eb, but in practice it doesn't cause enough of a
> problem to throw out the max idea in favor of tracking every valid slot.
>
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/tree-mod-log.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/fs/btrfs/tree-mod-log.c b/fs/btrfs/tree-mod-log.c
> index a555baa0143a..157e1a0efab8 100644
> --- a/fs/btrfs/tree-mod-log.c
> +++ b/fs/btrfs/tree-mod-log.c
> @@ -664,10 +664,27 @@ static void tree_mod_log_rewind(struct btrfs_fs_inf=
o *fs_info,
>         unsigned long o_dst;
>         unsigned long o_src;
>         unsigned long p_size =3D sizeof(struct btrfs_key_ptr);
> +       /*
> +        * max_slot tracks the maximum valid slot of the rewind eb at eve=
ry
> +        * step of the rewind. This is in contrast with 'n' which eventua=
lly
> +        * matches the number of items, but can be wrong during moves or =
if
> +        * removes overlap on already valid slots (which is probably sepa=
rately
> +        * a bug). We do this to validate the offsets of memmoves for rew=
inding
> +        * moves and detect invalid memmoves.
> +        *
> +        * Since a rewind eb can start empty, max_slot is a signed intege=
r with
> +        * a special meaning for -1, which is that no slot is valid to mo=
ve out
> +        * of. Any other negative value is invalid.
> +        */
> +       int max_slot;
> +       int move_src_end_slot;
> +       int move_dst_end_slot;
>
>         n =3D btrfs_header_nritems(eb);
> +       max_slot =3D n - 1;
>         read_lock(&fs_info->tree_mod_log_lock);
>         while (tm && tm->seq >=3D time_seq) {
> +               ASSERT(max_slot >=3D -1);
>                 /*
>                  * All the operations are recorded with the operator used=
 for
>                  * the modification. As we're going backwards, we do the
> @@ -684,6 +701,8 @@ static void tree_mod_log_rewind(struct btrfs_fs_info =
*fs_info,
>                         btrfs_set_node_ptr_generation(eb, tm->slot,
>                                                       tm->generation);
>                         n++;
> +                       if (tm->slot > max_slot)
> +                               max_slot =3D tm->slot;
>                         break;
>                 case BTRFS_MOD_LOG_KEY_REPLACE:
>                         BUG_ON(tm->slot >=3D n);
> @@ -693,14 +712,36 @@ static void tree_mod_log_rewind(struct btrfs_fs_inf=
o *fs_info,
>                                                       tm->generation);
>                         break;
>                 case BTRFS_MOD_LOG_KEY_ADD:
> +                       /*
> +                        * It is possible we could have already removed k=
eys behind the known
> +                        * max slot, so this will be an overestimate. In =
practice, the copy
> +                        * operation inserts them in increasing order, an=
d overestimating just
> +                        * means we miss some warnings, so it's OK. It is=
n't worth carefully
> +                        * tracking the full array of valid slots to chec=
k against when moving.
> +                        */
> +                       if (tm->slot =3D=3D max_slot)
> +                               max_slot--;
>                         /* if a move operation is needed it's in the log =
*/
>                         n--;
>                         break;
>                 case BTRFS_MOD_LOG_MOVE_KEYS:
> +                       ASSERT(tm->move.nr_items > 0);
> +                       move_src_end_slot =3D tm->move.dst_slot + tm->mov=
e.nr_items - 1;
> +                       move_dst_end_slot =3D tm->slot + tm->move.nr_item=
s - 1;
>                         o_dst =3D btrfs_node_key_ptr_offset(eb, tm->slot)=
;
>                         o_src =3D btrfs_node_key_ptr_offset(eb, tm->move.=
dst_slot);
> +                       if (WARN_ON(move_src_end_slot > max_slot ||
> +                                   tm->move.nr_items <=3D 0)) {
> +                               btrfs_warn(fs_info,
> +                                          "Move from invalid tree mod lo=
g slot eb %llu slot %d dst_slot %d nr_items %d seq %llu n %u max_slot %d\n"=
,
> +                                          eb->start, tm->slot,
> +                                          tm->move.dst_slot, tm->move.nr=
_items,
> +                                          tm->seq, n, max_slot);
> +
> +                       }
>                         memmove_extent_buffer(eb, o_dst, o_src,
>                                               tm->move.nr_items * p_size)=
;
> +                       max_slot =3D move_dst_end_slot;
>                         break;
>                 case BTRFS_MOD_LOG_ROOT_REPLACE:
>                         /*
> --
> 2.40.1
>
