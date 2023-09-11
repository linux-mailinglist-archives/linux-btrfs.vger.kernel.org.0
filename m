Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F34979B2E2
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 01:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356116AbjIKWC7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Sep 2023 18:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243763AbjIKRk4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Sep 2023 13:40:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E95CCC3
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Sep 2023 10:40:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D244C433CB
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Sep 2023 17:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694454050;
        bh=eaULS60IkQFRYcLabt7sbSvGkuyFXLSvKws0GNQelAM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nUTXqi0Ue5Uocdc7jIKy60K1bWmYXkCsV9nPD6l05GZ1KJ3nj2T2F3vre61h5+Rb1
         os/Y7JaZkjSDVXpPgIEL02rqY2MvgYHD/IWmk5cLZLy166KSDHYrYB3ofV+M5b+7yw
         lWy4VH0V285qWCoYk0f7rnm5D6/75rBqlo8TtVItU4IQdQUd3A5cV6n/S95BML//5I
         RDet3UGOBHKKTwxRYgvBwRZEl91anIyWjBn56k3kQMXNNhTzDNHEl5mSSyiuSrsncm
         6qEPHZyojYbcSV/1pwDfafc+C6nFbheJmVOkUl+c7fiwnX8OPpE3mxalPvsuqW+XgC
         /1qp/IlsjiSBg==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-573921661a6so2941807eaf.1
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Sep 2023 10:40:50 -0700 (PDT)
X-Gm-Message-State: AOJu0YzYa8pvyQzzU42O1595IDETZYYQoADTwZOHBsP40+NgKzZXhcZg
        Y5mqt485qpS3uuwZ0px0V25NELAnTacUAJoVs+8=
X-Google-Smtp-Source: AGHT+IESBB5TIAF1Yu0uxDACfu71zlVVb4U3y1W6rfvtAxjJ+uSbXg5cRDn0Z7BogP667DUDn62uL1V6ZvBu5AGj/gc=
X-Received: by 2002:a05:6870:828d:b0:1d5:2b28:5354 with SMTP id
 q13-20020a056870828d00b001d52b285354mr11548494oae.4.1694454049830; Mon, 11
 Sep 2023 10:40:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694260751.git.fdmanana@suse.com> <20230911173530.GB2352074@perftesting>
In-Reply-To: <20230911173530.GB2352074@perftesting>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 11 Sep 2023 18:40:13 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5jNoWTgVy6aAnm13p3Q0LSWi0r=oQVfsvHrGJEOrRkrw@mail.gmail.com>
Message-ID: <CAL3q7H5jNoWTgVy6aAnm13p3Q0LSWi0r=oQVfsvHrGJEOrRkrw@mail.gmail.com>
Subject: Re: [PATCH 0/2] btrfs: updates for directory reading
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, ian@ianjohnson.dev,
        Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 11, 2023 at 6:35=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> On Sat, Sep 09, 2023 at 01:08:30PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Tweak and fix a bug when reading directory entries after a rewinddir(3)
> > call. Reported by Ian Johnson.
> >
> > Link: https://lore.kernel.org/linux-btrfs/YR1P0S.NGASEG570GJ8@ianjohnso=
n.dev/T/#u
> >
> > Filipe Manana (2):
> >   btrfs: set last dir index to the current last index when opening dir
> >   btrfs: refresh dir last index during a rewinddir(3) call
> >
> >  fs/btrfs/inode.c | 18 ++++++++++++++++--
> >  1 file changed, 16 insertions(+), 2 deletions(-)
> >
>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
>
> I didn't see an fstest for this, is it forthcoming?  Thanks,

Give me a break... I did this on a Saturday morning.
Be patient...

>
> Josef
