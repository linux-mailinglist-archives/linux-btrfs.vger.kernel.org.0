Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8932B7196F0
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jun 2023 11:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbjFAJ3l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jun 2023 05:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbjFAJ3h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Jun 2023 05:29:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEBD97
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Jun 2023 02:29:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15E4763717
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Jun 2023 09:29:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B76DC433EF
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Jun 2023 09:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685611775;
        bh=3SL79sjDikrgrrN7Z6KD3TYaLNGttIzgc0XBA8JhqIM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jiT9mg6MW+TC2oPC9Qv6eBFpIRH0CqDxUGNbTSxplEzldyyCiPlwQ3wbguaEKw+Bi
         IEAIS/PqU+1VwEJP8EHr34XkjN5SoedQ/Z4Y4j+PuTxxvZKIIfNQ1zU1C2YCD6zwnc
         q58c6REXqnV34STJ8dkTDTwtyq2ca5urMZ9/+C16lsBwmbweWEnzornAGsbac0P6Gz
         sFOkWTIRRCVkbYWvUFVZUYs6VcjVi2fB9c8VED/DIFbgDYH/nkqSmS7KSmCSrWcQ+f
         Vs991+fnDdCH6gUMdw2SuzWGbq+d6PMphFQTER4BhoJiZ4Nhg2P8Jak4kpTpVuHQqh
         To/vrtnBuKmcA==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-557f3159a34so165619eaf.2
        for <linux-btrfs@vger.kernel.org>; Thu, 01 Jun 2023 02:29:35 -0700 (PDT)
X-Gm-Message-State: AC+VfDyrN3EmZoSQWxQ7KAkq5Z+xOyqDTnL52E8nUZU+dIa5uuPvlADk
        oO3iafAprWy/bujNJ0dh0RSZWmsmk3BkGV90Qqo=
X-Google-Smtp-Source: ACHHUZ7GiiaqmLT9rYYAQt6ybMNSztLy0KNHTAtdukWcP/26JUkEBc6s7ayUXAteCTIP4qepHKS0Wstb7TDs8PFPaEA=
X-Received: by 2002:a4a:57c7:0:b0:555:4ebc:9a8 with SMTP id
 u190-20020a4a57c7000000b005554ebc09a8mr3240373ooa.7.1685611774612; Thu, 01
 Jun 2023 02:29:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685546114.git.boris@bur.io> <bc3d9ec0aac7a1514165170c5fb73ed8f5d3a68b.1685546114.git.boris@bur.io>
In-Reply-To: <bc3d9ec0aac7a1514165170c5fb73ed8f5d3a68b.1685546114.git.boris@bur.io>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 1 Jun 2023 10:28:58 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7paNTeHhF35o-1MVAfNzXFH6NW-vOVayk0V6u_u8o11Q@mail.gmail.com>
Message-ID: <CAL3q7H7paNTeHhF35o-1MVAfNzXFH6NW-vOVayk0V6u_u8o11Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] btrfs: warn on invalid slot in tree mod log rewind
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

On Wed, May 31, 2023 at 5:22=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
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
>  fs/btrfs/tree-mod-log.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/fs/btrfs/tree-mod-log.c b/fs/btrfs/tree-mod-log.c
> index a555baa0143a..43f2ffa6f44d 100644
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

It would be better to document the intention of the special value
(u32)-1, and perhaps also let the type be
a signed integer and just check for -1 as meaning "no valid slot".

> +                               max_slot =3D tm->slot;
>                         break;
>                 case BTRFS_MOD_LOG_KEY_REPLACE:
>                         BUG_ON(tm->slot >=3D n);
> @@ -693,12 +697,30 @@ static void tree_mod_log_rewind(struct btrfs_fs_inf=
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
>                         o_dst =3D btrfs_node_key_ptr_offset(eb, tm->slot)=
;
>                         o_src =3D btrfs_node_key_ptr_offset(eb, tm->move.=
dst_slot);
> +                       if (WARN_ON((tm->move.dst_slot + tm->move.nr_item=
s - 1 > max_slot) ||
> +                                   (max_slot =3D=3D (u32)-1 && tm->move.=
nr_items > 0))) {

Like v1, I'm still a bit at odds with the check for  tm->move.nr_items > 0

Such a case should never be possible, we should assert that
separately, plus when I read this it makes me think:
why do we check it only when max_slot is (u32)-1 but not for the
previous condition?
It makes me think what would happen to the first condition if it's 0
and dst_slot happens to be 0, we have an underflow, etc

Maybe add an ASSERT(tm->move.nr_items > 0) before.

Thanks.


> +                               btrfs_warn(fs_info,
> +                                          "Move from invalid tree mod lo=
g slot eb %llu slot %d dst_slot %d nr_items %d seq %llu n %u max_slot %u\n"=
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
>                         break;
> --
> 2.40.1
>
