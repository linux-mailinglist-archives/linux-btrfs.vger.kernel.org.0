Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D89F4F1C28
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Apr 2022 23:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235064AbiDDVZc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Apr 2022 17:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380383AbiDDTyY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Apr 2022 15:54:24 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75100559A
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Apr 2022 12:52:27 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id z7so12688089iom.1
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Apr 2022 12:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=29NziYajTOtSfbQPiGDJUqJnW1sZ0ywfZxf9w4t6tt4=;
        b=kZzrY4ClLr9e6dIf7r955FgOUr73EqXieOiab4NgGIfyjz+FC2ZQjcA4V3N5gBFhri
         iyJZfK4vofx32Vnr5VdeMyd7EPwxd1/2TmwAUBL4dztsEM/HqPnjE9f0D5eCWkbgFVuQ
         xysmZBxP/bXZHDdT7kNALngjlHwTd3f47D4fxsdwVlIjjClJMve1XRaivKuwPaXxwf+P
         FWOz1WZfq349BkL1Jxfuo42fx/Rc901XCXnnbl7WsJU+2pDhwIzALY6+2kyq5qnDEBxe
         1d01kprg4uisS90WnwDiasiAbI25L75LF6TqEmxePyR3i9S82lfcJQ64eklYuZEgrZe6
         JROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=29NziYajTOtSfbQPiGDJUqJnW1sZ0ywfZxf9w4t6tt4=;
        b=KFVB/874/91eeenXdHTwmQ92tknpKfE2K8GZqL+nhEn+pmRNAsAYSwvedq3mIhWxqK
         XL//MjrzRY5iKViIOcORmvn7rngSM2/WxrAwhO5CXxgvYmVQamWMsy2boeuQwLcaE42K
         5qrUHNS3EFW7zz9RZyvgN8b6c579+cvEFQ8Zy14SmYpHprzI5wpce6JWDFcM0TxQ6FhM
         ZleJ748Dx9j81rhbWh+ylEQyyadjTahdLI+h2GysD1lzDyQSTVccE9buuRKgEWB5tpkT
         RGYByuL62Duxv5Zs+llbxIkCUNkIuVWwrZ5qzT3Mh62WJgd1pwKv0NsgJE52rjbmOjLH
         xOwg==
X-Gm-Message-State: AOAM531gZiY1Av+l7/BEw/LerZ2x/NdlDp3JFnEPrucyrgiWNuHZFa0q
        ZoS5EE5US4mgwq44IOe2/07W/GZB41XY5Raila26dA==
X-Google-Smtp-Source: ABdhPJyRmRRLBhIX8QyJ0ek8MI5POn2E4Q4p1X8d4D8NNs4tEf8E5cRWPRKXWiMIq3uaVb8VkQlDyQwToxhA4vbyfQY=
X-Received: by 2002:a05:6602:168b:b0:646:3bbb:7db4 with SMTP id
 s11-20020a056602168b00b006463bbb7db4mr868982iow.134.1649101946845; Mon, 04
 Apr 2022 12:52:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220330143944.GE14158@merlins.org> <20220331171927.GL1314726@merlins.org>
 <Ykoux6Oczf6+hmGg@localhost.localdomain> <20220404010101.GQ1314726@merlins.org>
 <20220404150858.GS1314726@merlins.org> <CAEzrpqc1yvK+v5MSiCxPRxX2c27xPsO5POMPJ8OuQaN4u1y2wA@mail.gmail.com>
 <20220404174357.GT1314726@merlins.org> <CAEzrpqc7P7pxkdSw8eS-nCkn1h5ztQC7C=MewJdmT6Mr5OJX-A@mail.gmail.com>
 <20220404181055.GW1314726@merlins.org> <CAEzrpqfA94nYjV=o_4+XRitopVT-3j7iQMaXAr3FE3Rfm32gkA@mail.gmail.com>
 <20220404190403.GY1314726@merlins.org>
In-Reply-To: <20220404190403.GY1314726@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Mon, 4 Apr 2022 15:52:15 -0400
Message-ID: <CAEzrpqeMPQvtoov=7Lv5Kx8-cgOmRFFYLbuh0QxZ6psQN3RDeA@mail.gmail.com>
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

On Mon, Apr 4, 2022 at 3:04 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Mon, Apr 04, 2022 at 02:46:57PM -0400, Josef Bacik wrote:
> > Ok now that I've learned how to read, the real problem is the extent
> > tree is fucked.  The chunk tree isn't happy, but it appears to be sane
> > enough to proceed, which is good because that could be unfun to
> > restore.
> >
> > Good news is the extent tree is easily re-buildable, lets use
> >
> > btrfs check --init-extent-tree /dev/whatever
> >
> > and let that baby do its thing.  Hopefully that rebuilds everything
> > and you'll be good to go.  Thanks,
>
> Thanks for the suggestion, sadly it's not that simple:
>
> gargamel:~# btrfs check --init-extent-tree  /dev/mapper/dshelf1a
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
> parent transid verify failed on 22216704 wanted 1600938 found 1602177
> parent transid verify failed on 22216704 wanted 1600938 found 1602177
> parent transid verify failed on 22216704 wanted 1600938 found 1602177
> Ignoring transid failure
> parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
> parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
> parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
> Ignoring transid failure
> leaf parent key incorrect 13577821667328
> WARNING: could not setup extent tree, skipping it
> parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
> Ignoring transid failure
> leaf parent key incorrect 13577821667328
> Couldn't setup device tree
> ERROR: cannot open file system
>
> gargamel:~# btrfs --version
> btrfs-progs v5.10.1
>

Can you build a recent btrfs-progs from git?  We chucked that error
apparently and I can't figure out where it's complaining.  Thanks,

Josef
