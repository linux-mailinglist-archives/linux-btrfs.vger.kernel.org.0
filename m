Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D96071800C
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 14:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbjEaMiM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 08:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjEaMiL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 08:38:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AECA11D
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 05:38:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA0116339C
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 12:38:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346F8C433D2
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 12:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685536689;
        bh=ZClN4heNDuzSd8YeR+0yMg7LYJAwQCkS9UnjBzqKckA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=F9Tgm+uikdErw2nczrcljwKX26fmh3xCGKJQ2pV+8Kuiid/LjSZDAgqZn/LcTUoMC
         ItX6EBc+4KAtI5GYip0kqTFJ5O5PWPKr3XZo0nYVyqDews61Bs4iht6cT2ndK4rijP
         WRDwYvYCM5ScjQNdtajmP4wsIR+YsQ5cMHNAYtYiu4KgR2CazFr9P3QMUItZ7xVUZX
         3Z3E1F6jGA3fQW3drigdXjL71sdueMrHU6OK3BSAUyZXNjNMMuim/S0CUa6e13iu16
         UclQmRChwqC8X/Sdh2mmZsFjfm6hyOvX6AyTL2hkYS2zu4Bfybb3gncVEug5sIc9++
         Isg9oG7HoK89Q==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-19a13476ffeso4666429fac.0
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 05:38:09 -0700 (PDT)
X-Gm-Message-State: AC+VfDwDHL7Ffi3lfNDuJJLk5SI1x+VAbtxH1cZVGJMUVb9Dzc1xd7oa
        AoeQ8UswXLELI828W9jReBF1Vjdsmo9CTBMnJDk=
X-Google-Smtp-Source: ACHHUZ40Rh7CtOTJTRq7aOTfAMoE9i2HzaMudT+95+mrmUjDJkmXlZK1cMxxPRupA9JvDBL9p4Fx4lqgqo7jbW6ylIk=
X-Received: by 2002:a05:6870:44c2:b0:19a:6209:e164 with SMTP id
 t2-20020a05687044c200b0019a6209e164mr3917434oai.26.1685536688332; Wed, 31 May
 2023 05:38:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685474139.git.boris@bur.io> <ab57e130bc466300efe32f36e623e546e4cfa85d.1685474140.git.boris@bur.io>
In-Reply-To: <ab57e130bc466300efe32f36e623e546e4cfa85d.1685474140.git.boris@bur.io>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 31 May 2023 13:37:32 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6Fage2sJLY6JEdzPVJGogOqHWWNnbpRL2gU3o24x9F6w@mail.gmail.com>
Message-ID: <CAL3q7H6Fage2sJLY6JEdzPVJGogOqHWWNnbpRL2gU3o24x9F6w@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs: warn on invalid slot in tree mod log rewind
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 30, 2023 at 8:52=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
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
> ---
>  fs/btrfs/tree-mod-log.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/fs/btrfs/tree-mod-log.c b/fs/btrfs/tree-mod-log.c
> index a555baa0143a..1b1ae9ce9d1e 100644
> --- a/fs/btrfs/tree-mod-log.c
> +++ b/fs/btrfs/tree-mod-log.c
> @@ -664,8 +664,10 @@ static void tree_mod_log_rewind(struct btrfs_fs_info=
 *fs_info,
>         unsigned long o_dst;
>         unsigned long o_src;
>         unsigned long p_size =3D sizeof(struct btrfs_key_ptr);
> +       u32 max_slot;
>
>         n =3D btrfs_header_nritems(eb);
> +       max_slot =3D n - 1;
>         read_lock(&fs_info->tree_mod_log_lock);
>         while (tm && tm->seq >=3D time_seq) {
>                 /*
> @@ -684,6 +686,8 @@ static void tree_mod_log_rewind(struct btrfs_fs_info =
*fs_info,
>                         btrfs_set_node_ptr_generation(eb, tm->slot,
>                                                       tm->generation);
>                         n++;
> +                       if (max_slot =3D=3D (u32)-1 || tm->slot > max_slo=
t)
> +                               max_slot =3D tm->slot;
>                         break;
>                 case BTRFS_MOD_LOG_KEY_REPLACE:
>                         BUG_ON(tm->slot >=3D n);
> @@ -693,6 +697,15 @@ static void tree_mod_log_rewind(struct btrfs_fs_info=
 *fs_info,
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
> @@ -701,6 +714,12 @@ static void tree_mod_log_rewind(struct btrfs_fs_info=
 *fs_info,
>                         o_src =3D btrfs_node_key_ptr_offset(eb, tm->move.=
dst_slot);
>                         memmove_extent_buffer(eb, o_dst, o_src,
>                                               tm->move.nr_items * p_size)=
;
> +                       WARN((tm->move.dst_slot + tm->move.nr_items - 1 >=
 max_slot) ||
> +                            (max_slot =3D=3D (u32)-1 && tm->move.nr_item=
s > 0),

Why the: "tm->move.nr_items > 0" ?
It's actually a bug, or in the best case a pointless operation that
should not have been logged, to have a move operation for 0 items.

> +                            "Move from invalid tree mod log slot eb %llu=
 slot %d dst_slot %d nr_items %d seq %llu n %u max_slot %u\n",
> +                            eb->start, tm->slot, tm->move.dst_slot, tm->=
move.nr_items,
> +                            tm->seq, n, max_slot);

Why trigger the warning after doing the memmove, and not before?
I would say it's preferable, because in case the bad memmove triggers
a crash/panic, we get the warning logged with some useful information.

It's also possibly better to log using the btrfs_warn() helper, as it
prints information about the affected filesystem, etc.
So like a: if (WARN_ON(conditions)) btrfs_warn()

Thanks.


> +                       max_slot =3D tm->slot + tm->move.nr_items - 1;
>                         break;
>                 case BTRFS_MOD_LOG_ROOT_REPLACE:
>                         /*
> --
> 2.40.1
>
