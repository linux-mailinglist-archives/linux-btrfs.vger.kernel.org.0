Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE4B77A63B
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Aug 2023 13:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjHMLhg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Aug 2023 07:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjHMLhf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Aug 2023 07:37:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2620D10C1
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Aug 2023 04:37:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B11A461D32
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Aug 2023 11:37:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1898AC433C7
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Aug 2023 11:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691926657;
        bh=OcN0mdpNj5yxPZBvcUgaLKDxGH1p1ofB8uZgKb9GD4Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=solMUu33CcbtPoS5paWvqRjZCtCHYdc98RNqYNprQ9KdRC9wcdIA/FzcYQ115WyGY
         i1rA40jnWYUL+9g0RMVRVt5HXIO4Z9XisvHVxK/jjuABwsPsouiz1L8Rl1rJJSuii3
         coJRsdSZIOapcPifLwxqsNWKUfcxNPGzaYOCCf1DY0rqjsnhOVkNaT6F52bo/QakDW
         ZNHSw5wW1BDgscsnk5Ocv9lHnmgW4Uqju/TTnoCqt8cHn0YEO2/1Ps1NJ4us4ahoYV
         d7gIXZsoz71xvvf/fO5ANzJRI20IqYxot/r5T2TNya6E56aiTMP9ZP+XJOs6a3tNrW
         1AwhEAjuVRAEw==
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3a5ad6087a1so2025771b6e.2
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Aug 2023 04:37:37 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx2sSPCxTvwrcjpBKiiTzFdRox+y56v2i/yp9tZhiymL0Lu4PTV
        AbKQG9Dbex2Ys9rCJPzhoIECbuhz0BbBILBKtuQ=
X-Google-Smtp-Source: AGHT+IFVHgKHG9bhBDfe928JeatVslEdsTSqRp6PJ/F/p84ApuZ69L9RAq3E4QF1liLa5rxDiXuMsdQV6EhVm+h6mOs=
X-Received: by 2002:a05:6808:13ce:b0:3a7:4802:c3f with SMTP id
 d14-20020a05680813ce00b003a748020c3fmr6381516oiw.52.1691926656207; Sun, 13
 Aug 2023 04:37:36 -0700 (PDT)
MIME-Version: 1.0
References: <2c8c55ec-04c6-e0dc-9c5c-8c7924778c35@landley.net>
In-Reply-To: <2c8c55ec-04c6-e0dc-9c5c-8c7924778c35@landley.net>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Sun, 13 Aug 2023 12:37:00 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6ehkiLBZpfFf3dy7whnE1fWK5HhW6XdNbYAu2FtqNHxA@mail.gmail.com>
Message-ID: <CAL3q7H6ehkiLBZpfFf3dy7whnE1fWK5HhW6XdNbYAu2FtqNHxA@mail.gmail.com>
Subject: Re: Endless readdir() loop on btrfs.
To:     Rob Landley <rob@landley.net>
Cc:     linux-btrfs@vger.kernel.org, enh <enh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Aug 13, 2023 at 12:04=E2=80=AFAM Rob Landley <rob@landley.net> wrot=
e:
>
> Would anyone like to comment on:
>
>   https://bugzilla.kernel.org/show_bug.cgi?id=3D217681
>
> which resulted from:
>
>   https://github.com/landley/toybox/issues/306
>
> and just got re-reported as:
>
>   https://github.com/landley/toybox/issues/448
>
> The issue is that modifications to the directory during a getdents()
> deterministically append the modified entry to the getdents(), which mean=
s
> directory traversal is never guaranteed to end, which seems like a denial=
 of
> service attack waiting to happen.
>
> This is not a problem on ext4 or tmpfs or vfat or the various flash files=
ystems,
> where readdir() reliably completes. This is a btrfs-specific problem.
>
> I can try to add a CONFIG_BTRFS_BUG optional workaround comparing the dev=
:inode
> pair of returned entries to filter out ones I've already seen, but can I
> reliably stop at the first duplicate or do I have to continue to see if t=
here's
> more I haven't seen yet? (I dunno what your return order is.) If some OTH=
ER
> process is doing a "while true; do mv a b; mv b a; done" loop in a direct=
ory,
> that could presumably pin any OTHER process doing a naieve readdir() loop=
 over
> that directory, hence denial of service...

I've just sent a fix for this, it's at:

https://lore.kernel.org/linux-btrfs/c9ceb0e15d92d0634600603b38965d9b6d986b6=
d.1691923900.git.fdmanana@suse.com/

Thanks for the report.

>
> Rob
