Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9D74F1FD3
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Apr 2022 01:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241497AbiDDXHs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Apr 2022 19:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240688AbiDDXHa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Apr 2022 19:07:30 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2C453E10
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Apr 2022 15:34:50 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id 125so13106803iov.10
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Apr 2022 15:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pheDtFXtLfyM9HAE7r9C7zr4fP4EZ524KlsyTcYLNwU=;
        b=EzNjJcTOWVCfdj9skG4aPTlb0UAaChRhUopxklHNcbgGD/LX/xA8htpeuyv8vUKoIO
         WtXJAiyiJz9bNZGJ2Wn0u3uXP5DY0vKu+UUwGsZ6AF9wGBcSFkfKEdRUsvNFCkc0Ss8v
         VT6FHjsBjT8q0Ad/zWDjUJJmPTkb8b71jldB68cVLwOnPrNrOH9ovy5svbqy51pbOqGf
         a3dmBraRwyZng6X+gkoCwZCNs8qYe5dDHkbbsjh/OW6jnaDsegtNEmOEgM0bhZvlKWra
         Kg3agxvaAAN2iBGf7SRADYQh4HB46zsHThm7cPpRFEJFPAXyHJwhwjBSacjHy17iDOxt
         T2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pheDtFXtLfyM9HAE7r9C7zr4fP4EZ524KlsyTcYLNwU=;
        b=bsJ914qRS9Qz4W9KeBv+5E08yIBPjDOJZuW7ZUMuLjDRKGVVsc+embF1jXET1fku9y
         O0mspH9sjHPEFMOlDCv1hwZu4qty46wG7kl1WX1disRafkogmaJKTV+S1OvaB3ruOK6R
         nmnKDEMs/qpiwyMHPWYWeIilwcdgJCWZiYY7IprjHC2VDrwkZLzsvBp2D3WkEuOpX841
         s45YiKsJ5f/GbYBSjvEN5vdcCrXeeBQm2iCVf5Ht9KKn8A+c9AOp3/jpotuptp4lv91v
         DH2pRBk32v8WyZp+4TpV3Sf0KbIQVwj9M8QvGsVlteDHQVNNRmuosUwPrHs1k7Wm6FXx
         EOsA==
X-Gm-Message-State: AOAM532FlsMjhAYFDi1cnZgiThVD8JxZtZWwVZJf8uC24alTwLNAGBsJ
        fvmJjjiR/2Qo/OiMBzluN8YvvblWKRbGwwey8gD7kg==
X-Google-Smtp-Source: ABdhPJwgbKZ9HPRLJ1SAshw3e0Ecf7FRo0BD6vGGZd37lz2M+DW2vR6QnWkE45R39aQIS5jo+6Z47GzKzwv7U9oMJBA=
X-Received: by 2002:a6b:ea07:0:b0:649:f07e:9c73 with SMTP id
 m7-20020a6bea07000000b00649f07e9c73mr287850ioc.10.1649111689898; Mon, 04 Apr
 2022 15:34:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220404174357.GT1314726@merlins.org> <CAEzrpqc7P7pxkdSw8eS-nCkn1h5ztQC7C=MewJdmT6Mr5OJX-A@mail.gmail.com>
 <20220404181055.GW1314726@merlins.org> <CAEzrpqfA94nYjV=o_4+XRitopVT-3j7iQMaXAr3FE3Rfm32gkA@mail.gmail.com>
 <20220404190403.GY1314726@merlins.org> <CAEzrpqeMPQvtoov=7Lv5Kx8-cgOmRFFYLbuh0QxZ6psQN3RDeA@mail.gmail.com>
 <20220404203333.GZ1314726@merlins.org> <CAEzrpqdmKwdZxzu7EBhp-PgZW+vqNaUm51SRrKAe64N3pN2rnw@mail.gmail.com>
 <20220404212951.GG14158@merlins.org> <CAEzrpqemPHLN4gp5TdLQDGkUZSOkRFHHFiHEraZDNSTDjCh4=Q@mail.gmail.com>
 <20220404220935.GH14158@merlins.org>
In-Reply-To: <20220404220935.GH14158@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Mon, 4 Apr 2022 18:34:39 -0400
Message-ID: <CAEzrpqefSVVYOf7oj4gqdvBou7vo58x7u4+G=vwCrnky9t3BZQ@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     Andrei Borzenkov <arvidjaar@gmail.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 4, 2022 at 6:09 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Mon, Apr 04, 2022 at 05:40:14PM -0400, Josef Bacik wrote:
> > Ok cool, lets do
> >
> > ./btrfs check -r 13577779511296 /dev/mapper/dshelf1a
> > ./btrfs check -r 13577821667328 /dev/mapper/dshelf1a
> > ./btrfs check -r 13577775284224 /dev/mapper/dshelf1a
> >
> > and see what those say, it looks like the tree root is stale and can't
> > find the root pointers for anything.  Thanks,
>
> Sure thing, the last one is slightly different (found 1602088)
>

Alright, lets see how fucked this thing is

./btrfs inspect-internal dump-tree -t ROOT /dev/mapper/dshelf1a

Thanks,

Josef
