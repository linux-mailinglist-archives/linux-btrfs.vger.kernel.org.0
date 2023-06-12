Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D75872CB62
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jun 2023 18:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235724AbjFLQWW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Jun 2023 12:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbjFLQWV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Jun 2023 12:22:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730F519A
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jun 2023 09:22:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DC4661555
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jun 2023 16:22:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C055C433EF
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jun 2023 16:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686586939;
        bh=XUZ5u0eFvEjL5zrRh5Mxq9z682NrjQNbgp88/6W7ni0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gX+OQ1+gp6JulA5PtN0zBlXim/iwMmr2zxHo44AF71N/IPsDLtlpcMUZGpmpOp8UZ
         DlSsNPR9HwtjZWoVcnFGe9/ochsLr5nWzlY9Bwju+qdeq1GnS2BoZBbvS7Wd6i/2GA
         h8o/itS/k/GL9q+NQDuNH8pnM+bhzwD5bxTLrL+wC+lSt3bYwuncM6wXyPvtegS5Tm
         f4CE2IwfKhcPHD6UqkwmIRXz1h4Kvvg3NzvXWYMmscD1TNdxM3Jaz7pfEecy7VBDby
         8BvgUNUhK/gtzz89VlI7x9w1e7TI55jZDf07PuGZxx7KZNmD7RbmgwEKj8s+Bvs8dj
         VmyMYha8wy8YA==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-558a7faa989so3040361eaf.1
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jun 2023 09:22:19 -0700 (PDT)
X-Gm-Message-State: AC+VfDzNc5CBf3SzwEFhxe7fNgIEubb5DAFFXWnqOnbxo8odKUyaGBQi
        6v+WWl0q/G7gEU81EX+u8eBGXnsMkvniUFcQ2Gs=
X-Google-Smtp-Source: ACHHUZ5mIoJrjI7ZGj3hfVkxSKdZTy7Hg1z5tYdNysWCzQbaR58MA39a48zDlqXvzq4+0mdOoGwKSTcDRfMtQoh8bFM=
X-Received: by 2002:a4a:bd92:0:b0:556:c580:eba6 with SMTP id
 k18-20020a4abd92000000b00556c580eba6mr5446905oop.4.1686586938488; Mon, 12 Jun
 2023 09:22:18 -0700 (PDT)
MIME-Version: 1.0
References: <05225b2c8b1848cfb68125b858998111e18dd5cb.1686566185.git.fdmanana@suse.com>
 <30de1598-f1ab-fbc1-1992-106c4bf6e03b@wdc.com>
In-Reply-To: <30de1598-f1ab-fbc1-1992-106c4bf6e03b@wdc.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 12 Jun 2023 17:21:42 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7NyU+Y7FK4vjQjQDMsKO6ivhm7aEYM5uFjsy5X=hAgPw@mail.gmail.com>
Message-ID: <CAL3q7H7NyU+Y7FK4vjQjQDMsKO6ivhm7aEYM5uFjsy5X=hAgPw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: do not BUG_ON() when dropping inode items from log root
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
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

On Mon, Jun 12, 2023 at 12:50=E2=80=AFPM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 12.06.23 12:55, fdmanana@kernel.org wrote:
>
> > -
> > -             if (path->slots[0] =3D=3D 0)
> > +             if (ret < 0) {
> >                       break;
>
> Style nit, the else after a break isn't needed.

It isn't, but I usually prefer it like that, to have a single if-else
testing the same variable, rather than 2 (or more) separate if
statements testing the same variable. I find it more clear this way.

Thanks.

>
> > +             } else if (ret > 0) {
>
> Anyways,
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
