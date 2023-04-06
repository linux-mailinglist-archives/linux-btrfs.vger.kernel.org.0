Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83BB16DA5EF
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Apr 2023 00:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238744AbjDFWk5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Apr 2023 18:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjDFWk4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Apr 2023 18:40:56 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9CA5FC7
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Apr 2023 15:40:55 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5027d3f4cd7so1647078a12.0
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Apr 2023 15:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680820854; x=1683412854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFfBcibv+zKn0+T3VThsPYfN0XsCHJSgTIVTEgQwORM=;
        b=RQ5CvbQfeWPRZuRgMYa8TRlKB56nXVAm9C472p7dc2DKm2SY7IUoQXj8ZKlpYMaumI
         OVnPNiaUvRKLc8DKYyjInU3my3tcaptMC/vintswr0rjLQ/2oUlOugAaa9wnypnIM8Ox
         5qpj30bNcUOBqbQNbLpAor+nIlovOFAspbmcuyyO0VqYD6YSYqN8BEAgNYVBnLrH8tkX
         lhDepAJ/pVVlxt1A3hT6MlDB1JNn0FaR1EU736aku8kJtMY5JUfaGl40KRzAs8CXybIt
         fGm75PCNLzUWWRhhi/+g0Pk97x6FpTsM9L0QWOJKgEcBFeKfYf6D6SmNOcbXOHNn9w0U
         azbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680820854; x=1683412854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pFfBcibv+zKn0+T3VThsPYfN0XsCHJSgTIVTEgQwORM=;
        b=5PIFSDO7seKjFxmdVSNwAnQUBfjOsdXbqj/q4HD00SBFj9+XG183WyguqNVJ+Dn6er
         xzeVbg8JQLp1WE0jatHWiRB7FRIAY+qWu9bfGagXNFH3DqWsuJ5rnXY3T5KhSJTScugW
         jXpdUngfgsKTxVWZrSNjbgRvCkrP9rz4FQdagqesVda/xel2jv6yGy/k2fFqWHOHqXJf
         aTALtq+h0el4y3jkaiHpd5D623lW5PyfPuFlZMEL8skGEyS4spxsw9SGmnGFo02V/EYJ
         9rdlDotvbN05J0h8hl64H2vSqK+xvL83CCJUSxQYjSZ966VrG7tqwHPlCI/Ra6syNMFc
         WTvA==
X-Gm-Message-State: AAQBX9dAaVzsCI7gPlNAfsJenH0JPLAo77bCpat2b3B0LF8AsJ6H0Zlr
        9MStP23swRkriYi+6OmmJEj5lVVuCXc1iFkw2B8HV9aOstgMlA==
X-Google-Smtp-Source: AKy350ZU46g2BLFOK3mgQp2BpBZJ4ogsOm/M46stCnXrjvKTxV/wju5Uz1LZ+X1UkUK9cSVtF5+j7Jr5fNaDlCQQrAA=
X-Received: by 2002:a50:bb23:0:b0:4fc:8749:cd77 with SMTP id
 y32-20020a50bb23000000b004fc8749cd77mr569174ede.3.1680820853617; Thu, 06 Apr
 2023 15:40:53 -0700 (PDT)
MIME-Version: 1.0
References: <aa1fb69e-b613-47aa-a99e-a0a2c9ed273f@app.fastmail.com>
 <1334e2af-b55f-3bb2-6e1a-6ab0b0ef93f0@leemhuis.info> <20230406154732.GV19619@twin.jikos.cz>
In-Reply-To: <20230406154732.GV19619@twin.jikos.cz>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Thu, 6 Apr 2023 18:40:17 -0400
Message-ID: <CAEg-Je9EczN14CyTqb22Wtz8nUMty0OvwCBbq2RdXwBf3=pCAA@mail.gmail.com>
Subject: Re: LMDB mdb_copy produces a corrupt database on btrfs, but not on ext4
To:     dsterba@suse.cz
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>, boris@bur.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 6, 2023 at 11:52=E2=80=AFAM David Sterba <dsterba@suse.cz> wrot=
e:
>
> On Wed, Apr 05, 2023 at 03:07:52PM +0200, Linux regression tracking #addi=
ng (Thorsten Leemhuis) wrote:
> > [TLDR: I'm adding this report to the list of tracked Linux kernel
> > regressions; the text you find below is based on a few templates
> > paragraphs you might have encountered already in similar form.
> > See link in footer if these mails annoy you.]
> >
> > On 15.02.23 21:04, Chris Murphy wrote:
> > > Downstream bug report, reproducer test file, and gdb session transcri=
pt
> > > https://bugzilla.redhat.com/show_bug.cgi?id=3D2169947
> > >
> > > I speculated that maybe it's similar to the issue we have with VM's w=
hen O_DIRECT is used, but it seems that's not the case here.
> >
> > To properly track this, let me add this report as well to the tracking
> > (I already track another report not mentioned in the commit log of the
> > proposed fix: https://bugzilla.kernel.org/show_bug.cgi?id=3D217042 )
>
> There were several iterations of the fix and the final version is
> actually 11 patches (below), and it does not apply cleanly to current
> master because of other cleanups.
>
> Given that it's fixing a corruption it should be merged and backported
> (at least to 6.1), but we may need to rework it again and minimize/drop
> the cleanups.
>
> a8e793f97686 btrfs: add function to create and return an ordered extent
> b85d0977f5be btrfs: pass flags as unsigned long to btrfs_add_ordered_exte=
nt
> c5e9a883e7c8 btrfs: stash ordered extent in dio_data during iomap dio
> d90af6fe39e6 btrfs: move ordered_extent internal sanity checks into btrfs=
_split_ordered_extent
> 8d4f5839fe88 btrfs: simplify splitting logic in btrfs_extract_ordered_ext=
ent
> 880c3efad384 btrfs: sink parameter len to btrfs_split_ordered_extent
> 812f614a7ad7 btrfs: fold btrfs_clone_ordered_extent into btrfs_split_orde=
red_extent
> 1334edcf5fa2 btrfs: simplify extent map splitting and rename split_zoned_=
em
> 3e99488588fa btrfs: pass an ordered_extent to btrfs_extract_ordered_exten=
t
> df701737e7a6 btrfs: don't split NOCOW extent_maps in btrfs_extract_ordere=
d_extent
> 87606cb305ca btrfs: split partial dio bios before submit

At least from Fedora's perspective, we've shifted to the 6.2 kernel
series now. If it's reasonable to get backported to there ASAP,
that'll help for Fedora (where this was discovered).




--
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
