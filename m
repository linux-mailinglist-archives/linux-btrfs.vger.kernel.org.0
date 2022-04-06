Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5994F545A
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 06:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347633AbiDFEsx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Apr 2022 00:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346485AbiDFEeM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Apr 2022 00:34:12 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D02A994F
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 17:39:28 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id r2so1184861iod.9
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Apr 2022 17:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rQ+lntHGRbfJLpoWFqPiuypFR/dttgitLYVXGMMixL4=;
        b=HYlkf054NS5F7RlGtyPhgEvBCJUXIKHOkOg2XMcrhnBJkWnQPy/zG1DmAey9Too+9s
         l318Hl9+Hob7VZ8JD8H981dnzlBH3d6PISBLmKqdxoxJN6DswM0sD5ib8Qmrqylsj6tF
         nkBaWUI7Ess7RMRgtsqHqyjb/YOE2QGUf75lxj0BxlS4ZbACPYufWutC6JhvffzvWSDv
         jfinM3BQmvzmEbfajiDxCL30W6ja9I2PYPtYVjsmsaPv9cTm0J3l1T+URnw3rNrsi+tS
         wt6cRkWGHmmJYEQ692lZwgLbSE/Op82zqTodFM6lTXE5SKfki1O+UgM3IMM2S1PHEknW
         bx0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rQ+lntHGRbfJLpoWFqPiuypFR/dttgitLYVXGMMixL4=;
        b=s35sonxgboPNVY6ABZ6RdEQm2fEfNenQR0xVau0Hs2MTQd16N19luHdSqT1STkecTk
         Jc2Yr1s5Lkms5rcg0mmxFxbEBzFcSXBvDFNZaY9WrkDDra0xwXWzBcNVQ4v6q5oXqGOk
         xIwD/emYbbPnVyacGlG2LWBamlGiD86LRHOJzxl2gorMykgfjXKNB7Wt1AsEFoFjPScq
         F0jW/okKmUKYx6ReHaHjfk+FaL9USVzqfVb4L1LksBB40nBdQ5zPpmB/R3RzefFyvTgm
         oK9kHYK5icxR16IHA7WBIjK6qhqG2Eod/xOUoOr20kStkHHLaQEvLzZCJxymcbCRv1wa
         5nqQ==
X-Gm-Message-State: AOAM532b3pMZv+nN/aHO4B5XND9K/qTPkC4xl0mynLJPd6xSOYXpuVqE
        T0hut8B2IABLSibC/BMfpiJDfA74OLO3TVkmtYeT/akvNzs=
X-Google-Smtp-Source: ABdhPJyWxeJt22eS1Oi1kO/P3RvcmLQaQe8PGTDaOM0xE3M2Rf22Q2rP7tWyHEOaS/NWpNwJ5Mclo6erkaFzvzGeatw=
X-Received: by 2002:a02:b10f:0:b0:323:9bba:a956 with SMTP id
 r15-20020a02b10f000000b003239bbaa956mr3327658jah.313.1649205567413; Tue, 05
 Apr 2022 17:39:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220405203737.GE28707@merlins.org> <CAEzrpqemQ2Uzi+ZJHtQtbF62=hZMTmuPT3HxwkYedUvAsXhdvQ@mail.gmail.com>
 <20220405211412.GF28707@merlins.org> <CAEzrpqeZoUF3+Pgyaup1DGFENs6zDKtRqHiJQ6sx_CoXE2HOOA@mail.gmail.com>
 <20220405212655.GH28707@merlins.org> <CAEzrpqc0Ss+J6oTqNPfTgWOwyhPAF2uHnRELmc6AO6je6Ht88w@mail.gmail.com>
 <20220405214309.GI28707@merlins.org> <CAEzrpqeDZxjbis5kPWH3khiOALyFqUoTuh5eojFtWHPcwj-Ygw@mail.gmail.com>
 <20220405225808.GJ28707@merlins.org> <CAEzrpqdtvY7vu50-xSFpdJoySutMWF3JYsqORjMBHNzmTZ52UQ@mail.gmail.com>
 <20220406003521.GM28707@merlins.org>
In-Reply-To: <20220406003521.GM28707@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Tue, 5 Apr 2022 20:39:16 -0400
Message-ID: <CAEzrpqesUdkDXhdJXHewPZuFGPVu_qyGfH07i5Lxw=NDs=LASQ@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 5, 2022 at 8:35 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Tue, Apr 05, 2022 at 08:23:42PM -0400, Josef Bacik wrote:
> > Alright it's time for the crazy.  Go ahead and pull and start running.
> > This is going to take a while to run, we're basically going to walk
> > and check all the node pointers in the tree root, if it doesn't look
> > right we're going to search the metadata for the best copy to use, and
> > then update the block to point at the new block.  It has to do the
> > full search every time, because we don't have time for me to properly
> > implement a cache, so don't be worried if it takes a while.
> >
> > It may print out stuff, if it looks like it's looping stop it and let
> > me know, but I don't think I fucked it up.  You're going to see a lot
> > "fixed root <id>", "fixed slot <whatever>", if you see it repeating
> > the same slot or root then we know we have a problem.
>
> I assume this is not good?
> ERROR: failed to write bytenr 13577814573056 length 16384 devid 1 dev_bytenr 13439981355008: Operation not permitted
>
> I am running as root of course.
>

Yeah I'm just a dumbass, try again please. Thanks,

Josef
