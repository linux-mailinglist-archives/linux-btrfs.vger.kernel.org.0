Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F16729B8C
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jun 2023 15:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjFIN0Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Jun 2023 09:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjFIN0X (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Jun 2023 09:26:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926581FEC
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jun 2023 06:26:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1913A6581C
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jun 2023 13:26:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726F5C4339C
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jun 2023 13:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686317181;
        bh=zEiN7FO4E3ti31tWXoXlomgITRcpq6PcZDu5tZqWiZM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nQ9BL63xwK13nNRPtxUbLntrvBaxA5cTTofi+GeA49Y7U9lAxLzih8OzEQx0ollto
         KxFk95+015M7jWYpMzkbvU9y2ZGoBtmieT1wJTnQqdoeDqWRu8AhjpTh8mV1Xw+cxy
         JKHKtDwBJq6zuxF6AVG6lQxva6O4O9l/fbDY8UTOBsUzEEeDTDIxe1HOlPWTU0NjHp
         tLKE1WH8fX6qSTeQiIDBWsc5wdW309uPK3BsGROcqykztLy9exs0vQZubapCEiffU7
         jTya94AIqN+401Q1lHCZWdDvwIj1ThZH1aBdy6F9r/862vEcXN3GGjami4eD0/Vcxb
         9gIbAv+Qr2y9w==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-19f22575d89so553859fac.0
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Jun 2023 06:26:21 -0700 (PDT)
X-Gm-Message-State: AC+VfDzvfuSGyysBB4lAYtLY2gF81WGATDsi4AgtoE5pvmwtL3UA2Q5s
        DbOeCTAtiu4+af3CVK+yP4+XisobJLFAW68Enpo=
X-Google-Smtp-Source: ACHHUZ7V4H+kVLvC16d3aRZPl1DCc6SiLJPJvmgeAWLq2QrcSABRzou8B8AosWdz/Ga++wB6IW9o/eKn5J+wgvk6Iuo=
X-Received: by 2002:a05:6870:d345:b0:196:45b7:9385 with SMTP id
 h5-20020a056870d34500b0019645b79385mr1285595oag.27.1686317180556; Fri, 09 Jun
 2023 06:26:20 -0700 (PDT)
MIME-Version: 1.0
References: <r3pglf6fh5hqqfd6iwt5eklmalm4idnumjxo5v23buu7zfjdfm@ixnvwldw5yjg>
In-Reply-To: <r3pglf6fh5hqqfd6iwt5eklmalm4idnumjxo5v23buu7zfjdfm@ixnvwldw5yjg>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 9 Jun 2023 14:25:44 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4E6gqLvi-Ar1Um8c3teHWntHt25_uvD19x-9QTkaSRFQ@mail.gmail.com>
Message-ID: <CAL3q7H4E6gqLvi-Ar1Um8c3teHWntHt25_uvD19x-9QTkaSRFQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: do not clear EXTENT_LOCKED in try_release_extent_state()
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
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

On Fri, Jun 9, 2023 at 2:20=E2=80=AFPM Goldwyn Rodrigues <rgoldwyn@suse.de>=
 wrote:
>
> clear_bits unsets EXTENT_LOCKED in the else branch of checking
> EXTENT_LOCKED.

It doesn't. Because of the negation operator:

u32 clear_bits =3D ~(EXTENT_LOCKED | EXTENT_NODATASUM | ...

> At this point, it is not possible that EXTENT_LOCKED bits
> are set, so do not clear EXTENT_LOCKED.

And it doesn't clear them because of ~

>
> Besides, The comment above try_release_extent_state():__clear_extent_bit(=
)
> also says that locked bit should not be cleared.
>
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/btrfs/extent_io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index a91d5ad27984..e5bec73b5991 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2357,7 +2357,7 @@ static int try_release_extent_state(struct extent_i=
o_tree *tree,
>         if (test_range_bit(tree, start, end, EXTENT_LOCKED, 0, NULL)) {
>                 ret =3D 0;
>         } else {
> -               u32 clear_bits =3D ~(EXTENT_LOCKED | EXTENT_NODATASUM |
> +               u32 clear_bits =3D ~(EXTENT_NODATASUM |
>                                    EXTENT_DELALLOC_NEW | EXTENT_CTLBITS);

So because of the  ~, this is actually introducing a bug:

1) test_range_bit() returns false because the range is locked
2) some other task locks the range just after the test_range_bit() call
3) we get to the else branch, clear_bits has EXTENT_LOCKED, because of
the ~, and we unlock the range when we shouldn't....

Thanks.

>
>                 /*
> --
> 2.40.1
