Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAACD729B96
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jun 2023 15:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239822AbjFIN2u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Jun 2023 09:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbjFIN2t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Jun 2023 09:28:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531F2270B
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jun 2023 06:28:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3E9D60A07
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jun 2023 13:28:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59DD4C433EF
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jun 2023 13:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686317327;
        bh=R8Da1zvGh2YaseE5Qd2jDZ96a2j8NkawCAUPG6cbM4I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=D4yfTb/zseVsp4SOq4Tf1gr7RIcz50v3DTQZByH9C13K1zuOeWLOUIpp6Rd6YX2OK
         I1O+pKqxB9KDaaShs2yl/pCYWsrcoyIbT4Sa97Cy5YBr2H4eJtgMzHuwEO+T5L4SqD
         4JOMgrX5T3xkeGy+3m3nbtU9T/TFrF3RE/5b56oMytluBQiZkdkgE8UZ+XdPCGfhue
         qCfIsJwwKOYST3TqCy8VxJc7TepSJ4PFeMzK7ZLHQYljpWQdf1bL5GNzQzt24rinQA
         9t6Xda/wkbbE950GbNv5BZwsRxhWq7K5CO8m4gJ8gZ70JR5Djvg91l/D9+LxzH3YHf
         Y+8PhyqO/UOmA==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1a2c9f087f0so687607fac.3
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Jun 2023 06:28:47 -0700 (PDT)
X-Gm-Message-State: AC+VfDwX4i5UPlt8XPxpOzS/voQGBIhQ/FIEshauGz0C2ejgy7xE2Xti
        O9Q+xzky/qX32xx2+pxOyVD7NZWRF2RP7/vWntM=
X-Google-Smtp-Source: ACHHUZ6vjC1HruYwB/PecZpgmVwqgJi6yMUaCnJgAAazVFtFIXNsaYLx2ioZafQFeeHUks0XAp1UKXEJe91r/P+ttb0=
X-Received: by 2002:a05:6871:6baa:b0:184:3981:add4 with SMTP id
 zh42-20020a0568716baa00b001843981add4mr1147664oab.25.1686317326561; Fri, 09
 Jun 2023 06:28:46 -0700 (PDT)
MIME-Version: 1.0
References: <r3pglf6fh5hqqfd6iwt5eklmalm4idnumjxo5v23buu7zfjdfm@ixnvwldw5yjg> <CAL3q7H4E6gqLvi-Ar1Um8c3teHWntHt25_uvD19x-9QTkaSRFQ@mail.gmail.com>
In-Reply-To: <CAL3q7H4E6gqLvi-Ar1Um8c3teHWntHt25_uvD19x-9QTkaSRFQ@mail.gmail.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 9 Jun 2023 14:28:10 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6hP=V2zLHGcvnqVG4_7B-d7+aM3k0z1TRXq6u7rzz0KA@mail.gmail.com>
Message-ID: <CAL3q7H6hP=V2zLHGcvnqVG4_7B-d7+aM3k0z1TRXq6u7rzz0KA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: do not clear EXTENT_LOCKED in try_release_extent_state()
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 9, 2023 at 2:25=E2=80=AFPM Filipe Manana <fdmanana@kernel.org> =
wrote:
>
> On Fri, Jun 9, 2023 at 2:20=E2=80=AFPM Goldwyn Rodrigues <rgoldwyn@suse.d=
e> wrote:
> >
> > clear_bits unsets EXTENT_LOCKED in the else branch of checking
> > EXTENT_LOCKED.
>
> It doesn't. Because of the negation operator:
>
> u32 clear_bits =3D ~(EXTENT_LOCKED | EXTENT_NODATASUM | ...
>
> > At this point, it is not possible that EXTENT_LOCKED bits
> > are set, so do not clear EXTENT_LOCKED.
>
> And it doesn't clear them because of ~
>
> >
> > Besides, The comment above try_release_extent_state():__clear_extent_bi=
t()
> > also says that locked bit should not be cleared.
> >
> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > ---
> >  fs/btrfs/extent_io.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index a91d5ad27984..e5bec73b5991 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -2357,7 +2357,7 @@ static int try_release_extent_state(struct extent=
_io_tree *tree,
> >         if (test_range_bit(tree, start, end, EXTENT_LOCKED, 0, NULL)) {
> >                 ret =3D 0;
> >         } else {
> > -               u32 clear_bits =3D ~(EXTENT_LOCKED | EXTENT_NODATASUM |
> > +               u32 clear_bits =3D ~(EXTENT_NODATASUM |
> >                                    EXTENT_DELALLOC_NEW | EXTENT_CTLBITS=
);
>
> So because of the  ~, this is actually introducing a bug:
>
> 1) test_range_bit() returns false because the range is locked

not locked, of course

> 2) some other task locks the range just after the test_range_bit() call
> 3) we get to the else branch, clear_bits has EXTENT_LOCKED, because of
> the ~, and we unlock the range when we shouldn't....
>
> Thanks.
>
> >
> >                 /*
> > --
> > 2.40.1
