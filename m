Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F1D523712
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 May 2022 17:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343544AbiEKPWD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 May 2022 11:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343562AbiEKPV5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 May 2022 11:21:57 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5505054BC2
        for <linux-btrfs@vger.kernel.org>; Wed, 11 May 2022 08:21:50 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id kq17so4778711ejb.4
        for <linux-btrfs@vger.kernel.org>; Wed, 11 May 2022 08:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ge1qQVDV/8Fkv+LxuuCtySdO1rxwz6ZKSlx11gKWZg=;
        b=eqjvp1hoX8+4aRv8tqvGvfV6nWxbh73OYG5kSv9H/kNRC2DBVEXcq9W12JSVOWZy9m
         oA/IETkJQ2KjU5jiJFjyzlEXA3Fo6KqapTtu9GWeyM1KCCSapGgEmax+9nWtQcgsSbwo
         fGqY3lVRCmQNDT7QNckDA0I3HYd3IQr5QKSpujD7UHdqzKnAOFI1BO/3d1CyoBHcRrBB
         h7YpOGb90vkNquZpkvpTmWHTqNK0YsMLKp4nrX8Gv6l1dITbukWmQBJ9W1WNO9JaSAv4
         4K8rc4LJnVdgwJwcCVNcGhZILVYNb1fitWa7Q6IBTmprgfwfcVOiDMiQoYWZn0kP6OW0
         oumg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ge1qQVDV/8Fkv+LxuuCtySdO1rxwz6ZKSlx11gKWZg=;
        b=lc6o7aLDEBPm44QJ+HOjdM7ZlmBbadBNkryq2n/4iLmmUFq0tayTSUalK9mrp+X1eZ
         tkxP8SK+ZCkOYY2Nva2dsUEbiCCcoE6aMT1z+JZg4UrxbJLBw1mJ1Il7l5tm5KbJnl1N
         QTiKRJgj7yiLG+Rt9kQfBf1VhS+7S5nnK2FWbKIY/q5Dq+VWtEhX9a//E7ARUDpH0SOI
         7HjL4U/O0QoRaXaUqrk75f8Q7ylzzMqT5qJiIwpUY9NKzNCsYe13k6Nyiu5p/NJuLmx9
         aGydgdP9Et5nTz2PRz8YqJeG0Ibjhn+6zz7nJcTcR6DhOU2LjGGQRvlaCAumI3fsS9kI
         TSdg==
X-Gm-Message-State: AOAM533I98mOrpuJI2/MlYfavtEcaAd5DVoGldauluLeWGu9UrQtnsXQ
        h6FGLHHn6rWKRLHGXvM6/N8RnFAz9+lPWa1LtdL1j4bMFZw=
X-Google-Smtp-Source: ABdhPJw1tCocJZGbRak4IXJlt7F7/5sLufTdHUk96WvsMXNXRl3hXNSxa8ud1kheyiRMxoqyC+8U/sO+s0j0UmL5bDU=
X-Received: by 2002:a17:906:6a10:b0:6f5:5e4:9d5 with SMTP id
 qw16-20020a1709066a1000b006f505e409d5mr24796240ejc.122.1652282508687; Wed, 11
 May 2022 08:21:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqf7As9tL28+Rb1kVqeO4G=MqBPQw0fKF6Mwa=_4fzsjSQ@mail.gmail.com>
 <20220510160600.GG12542@merlins.org> <CAEzrpqfYJDPdxxrw9TMFdF9GacYKMwc8=yFB6wt3=TMDt6Bung@mail.gmail.com>
 <20220510164448.GI12542@merlins.org> <20220510211507.GJ12542@merlins.org>
 <CAEzrpqe41JYFKE2tZFjgZ4V_YqO+K8m4nzF=R3Sti6hgv5snuQ@mail.gmail.com>
 <20220511000815.GK12542@merlins.org> <CAEzrpqcPdf8kNjywtGY-OKDAm-87o+1QDh0qX+0mOSV3D4WEqQ@mail.gmail.com>
 <20220511014827.GL12542@merlins.org> <CAEzrpqfzXn0sZNVDud4UfysxvF4mgbq_a_ToJioDFz2wE-d3Rw@mail.gmail.com>
 <20220511150319.GM29107@merlins.org>
In-Reply-To: <20220511150319.GM29107@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Wed, 11 May 2022 11:21:37 -0400
Message-ID: <CAEzrpqcT0fObDa8XFWtvzeqCKom42t5o+xE9atmFjWyHCHmb=g@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 11, 2022 at 11:03 AM Marc MERLIN <marc@merlins.org> wrote:
>
> On Wed, May 11, 2022 at 07:43:29AM -0400, Josef Bacik wrote:
> > OMG we're almost done, that's awesome.  So no extent errors, just the
> > csum things and the fs things I expected.  Now we do
>
> Yeah!
>
> > btrfs check --init-csum-tree <dev>
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs check --init-csum-tree /dev/mapper/dshelf1
> Creating a new CRC tree
> WARNING:
>
>         Do not use --repair unless you are advised to do so by a developer
>         or an experienced user, and then only after having accepted that no
>         fsck can successfully repair all types of filesystem corruption. Eg.
>         some software or hardware bugs can fatally damage a volume.
>         The operation will start in 10 seconds.
>         Use Ctrl-C to stop it.
> 10 9 8 7 6 5 4 3 2 1
> Starting repair.
> Opening filesystem to check...
> FS_INFO IS 0x55a89d2dbfd0
> JOSEF: root 9
> Couldn't find the last root for 8
> FS_INFO AFTER IS 0x55a89d2dbfd0
> Checking filesystem on /dev/mapper/dshelf1
> UUID: 96539b8c-ccc9-47bf-9e6c-29305890941e
> Reinitialize checksum tree
> checksum verify failed on 42565632 wanted 0x53c18aa1 found 0xcd4368c2
> checksum verify failed on 42582016 wanted 0xc42fc10c found 0xd63d1182
> checksum verify failed on 42647552 wanted 0x10aefde4 found 0x5c5bedba
> checksum verify failed on 42680320 wanted 0x9cfe6b48 found 0xed48fcc5
> checksum verify failed on 42696704 wanted 0x005c4793 found 0x0d9de33c
> checksum verify failed on 42811392 wanted 0x2b08fbc0 found 0xf25092bb
> checksum verify failed on 42827776 wanted 0x6277c597 found 0x70d260d3
> checksum verify failed on 42844160 wanted 0xceecf694 found 0x15ab7b7c
> checksum verify failed on 42860544 wanted 0xbc48b372 found 0x99719113
> checksum verify failed on 60915712 wanted 0xb9ea7152 found 0x75dbb3c0
> checksum verify failed on 63438848 wanted 0x4cfafe67 found 0xf97194d0
> checksum verify failed on 63422464 wanted 0xcae61e1f found 0xafc5d21c
> checksum verify failed on 63946752 wanted 0xe545e347 found 0x5c2ca453
> checksum verify failed on 63881216 wanted 0x4dbaba12 found 0x843eeecc
> checksum verify failed on 63930368 wanted 0x03a5dd54 found 0x049161ac
> checksum verify failed on 76709888 wanted 0x52911556 found 0x1fbf8f99
> checksum verify failed on 76660736 wanted 0xcf5d93fa found 0x08ef5ce9
> checksum verify failed on 76677120 wanted 0xf56b664d found 0x9d0df1da
> checksum verify failed on 76726272 wanted 0x759a69db found 0xc4d2e554
> checksum verify failed on 76742656 wanted 0xe5a5401d found 0xd40609cc
> checksum verify failed on 100302848 wanted 0xb1829326 found 0xbd08c95e
> checksum verify failed on 105742336 wanted 0x26ef0666 found 0x2fa5587b
> checksum verify failed on 129449984 wanted 0x915d087e found 0x26b36e0f
> ERROR: checksum tree refilling failed: -2
>

Hmm of course IDK where it's falling over, I pushed some debugging but
there's another method we can try if I can't figure this out.  Thanks,

Josef
