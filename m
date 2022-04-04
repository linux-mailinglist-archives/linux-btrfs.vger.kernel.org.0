Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20314F1C60
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Apr 2022 23:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382318AbiDDV0o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Apr 2022 17:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380052AbiDDStG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Apr 2022 14:49:06 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA93030F7A
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Apr 2022 11:47:08 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id p21so12461027ioj.4
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Apr 2022 11:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iLJgIFzUSlXF1BpSlqxVdZ2UTA3C4qraalMybLlFYiY=;
        b=KBQuZAbdplJE5+C/fWi4SAetRe8ETxYDm8i7L29gcXt8UzysJLCGze1MwQcppGPkom
         8mO+d3lv0+L4JXDaRKf9CzCQNCfN6d3pfQuArI12UgFd/Put0J7YJBxzYqtR3HSo72xK
         ou9KythiTpul8cSTZbfyNRbHy0fxhcxU16p6PbH08ZnY78o4MKIM+NFXkMaVQJrIvH+T
         ibdu45fyGdO5swG5AQunTn3BG8xUI+FkB8wiU4thjzDv6TCDdvBkawe3oTYUG3RFd7q3
         TdbUGjjvf0E78q2HjFnC5THDK8ydNoq9wJNaKPzDqMEkaQa9ZTfvkUbI+JWu1mrKET0r
         ODcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iLJgIFzUSlXF1BpSlqxVdZ2UTA3C4qraalMybLlFYiY=;
        b=GqysbdG6YM6fD1/Wpr05LfAemnCNfCW0B5URgYCzrJdsB9XmF9Dt3sWRfve06uBsNU
         nJZ/PuGt3r+RwD5YW4X6CJjGcONwi2uc+br0oxxs+ntkbg8AGqBumuFYdFTfAKh1+IGN
         HkgWkMNWfD4oZ6ID6TsXg8a8YoIWpQx9bjZsNBYNesWJei6hlJjLlB8Gt8qs8U3As+G6
         akqYdVk9+0DjZkeS0bAgGPwYwRUxyZTlAHBljo5EWg01D9eIP7ISu/vNTWvweQyfdJdb
         Rgpk5ZQbZ1VAwVFYxf7EtDXWYM3QaZFhxT5TE8tTD6e2GnzpjP01xxhfidEQnTDid6Wl
         /9Pw==
X-Gm-Message-State: AOAM5327AwxL/tQV2wr5loo4nrdv49ETPy9uE+kveVPnTOv9w739zRIj
        3NeiVIxKH3LCcw0yGFuTiRAr88OsqvY0atrE3vW3fg==
X-Google-Smtp-Source: ABdhPJwaRVQ32zZgn2WbJ5TG81gmc54Kk7sfnKEcLZ2Eg4z1BP23kVC0jSeTtMNgkZlj62WYmOqDwuhJpxu7zuQOCCs=
X-Received: by 2002:a02:6010:0:b0:31a:6d4f:d9ca with SMTP id
 i16-20020a026010000000b0031a6d4fd9camr555442jac.46.1649098028206; Mon, 04 Apr
 2022 11:47:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220329171818.GD1314726@merlins.org> <dffec23f-bef1-30e2-83fc-b3fb9bb5f21e@gmail.com>
 <20220330143944.GE14158@merlins.org> <20220331171927.GL1314726@merlins.org>
 <Ykoux6Oczf6+hmGg@localhost.localdomain> <20220404010101.GQ1314726@merlins.org>
 <20220404150858.GS1314726@merlins.org> <CAEzrpqc1yvK+v5MSiCxPRxX2c27xPsO5POMPJ8OuQaN4u1y2wA@mail.gmail.com>
 <20220404174357.GT1314726@merlins.org> <CAEzrpqc7P7pxkdSw8eS-nCkn1h5ztQC7C=MewJdmT6Mr5OJX-A@mail.gmail.com>
 <20220404181055.GW1314726@merlins.org>
In-Reply-To: <20220404181055.GW1314726@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Mon, 4 Apr 2022 14:46:57 -0400
Message-ID: <CAEzrpqfA94nYjV=o_4+XRitopVT-3j7iQMaXAr3FE3Rfm32gkA@mail.gmail.com>
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

On Mon, Apr 4, 2022 at 2:10 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Mon, Apr 04, 2022 at 01:53:56PM -0400, Josef Bacik wrote:
> > Can you do
> >
> > btrfs check --chunk-bytenr 21053440 /dev/whatever
>
> I assume you meant chunk-root
>

I did, my bad.

>
> gargamel:~# btrfs check /dev/mapper/dshelf1a
> Opening filesystem to check...
> parent transid verify failed on 22216704 wanted 1600938 found 1602177
> parent transid verify failed on 22216704 wanted 1600938 found 1602177
> parent transid verify failed on 22216704 wanted 1600938 found 1602177
> Ignoring transid failure
> parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
> parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
> parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
> Ignoring transid failure
> leaf parent key incorrect 13577821667328
> ERROR: could not setup extent tree
> ERROR: cannot open file system
>

Ok now that I've learned how to read, the real problem is the extent
tree is fucked.  The chunk tree isn't happy, but it appears to be sane
enough to proceed, which is good because that could be unfun to
restore.

Good news is the extent tree is easily re-buildable, lets use

btrfs check --init-extent-tree /dev/whatever

and let that baby do its thing.  Hopefully that rebuilds everything
and you'll be good to go.  Thanks,

Josef
