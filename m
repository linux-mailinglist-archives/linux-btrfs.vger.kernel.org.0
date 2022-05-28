Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934BB536E4C
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 May 2022 22:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiE1UIj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 28 May 2022 16:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiE1UIh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 28 May 2022 16:08:37 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0515010BC
        for <linux-btrfs@vger.kernel.org>; Sat, 28 May 2022 13:08:37 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id g15so2476143ilr.3
        for <linux-btrfs@vger.kernel.org>; Sat, 28 May 2022 13:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CBuWXEru4xnofJbJmNU8FgQoJMAHV9XS8a+rmE/UP9I=;
        b=tv1XQvkgTqqqHsoGoC/gb+v+vvatU9+chiyyF1MQxJrYJAgkUh2XcqrQoonEQ/0DJ/
         1PTd2MXZnTeuXOgFg3rqxlGalCpyIZ6BWr+y5aALLqx5W0n6hlEmwVpMngfCfeKSSoIf
         WRILy3wBOZOuJcH2YDbnXEv1b6+1fRa9FVPvmDzLmwOR/2hNyiddjr96Ua6+s0aFbP9u
         fUMKj/K7ZI080ZGbwxrJHXu6TXnH9cADqoWQJejLRYNZtYwmqZU2t/egM+wfvFlZhhP/
         vZPN4X6pIC+7xSUN23CS9ReAwS1oBKcQXtYB7KZtnGKBDORol+6FKtKIQjCRWA+LLZga
         nQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CBuWXEru4xnofJbJmNU8FgQoJMAHV9XS8a+rmE/UP9I=;
        b=4xle42FBtkowF30z27dMC0s5zqjqXJQkd3kJmhckbAO9Dt0Xk0zB5T5gIY4LEm2AcN
         niA8NxkHhDSWF083vVTlZvWP5xg/73PXlBn+H2bIZdQ4ruFJ4n9kMy1DvPsKfRPxWwT6
         zc2/FSpYYL46gMnQyoho7fhjquZic+CGC9t+DjpMmWT8tXsshlJR1YCG9prwQ+9fwVEA
         zLd4IBw/EG7Zy84X4RLoHLZNQ7jJS99Hph4Y4E2tAfxH1rSd4I/NqO+wK3tnpbWsVd+j
         KmOUsfC9d8RO49MnlFEhw8orBfBXBs65yEckyjuGAQdkkkh7/toKx4pflY5zBbLsnX8w
         P40Q==
X-Gm-Message-State: AOAM532DDWh5XeGTJNknUhq91KTWD8GM0mrsM27c9Av+3lc0k1XtGPNN
        8I7VOlOsAeV8Jy+KY6jH7OyfiSel7phjb8myXj8h5JAdhMI=
X-Google-Smtp-Source: ABdhPJx1xVt/2Viqc9TAO2AA5gCE3D81qeax4MI7KzfnD4ER4MJBSyJbw0MeSkJ5rYtBbil9jXopTeW1rDxzcGoIjVU=
X-Received: by 2002:a92:d1c6:0:b0:2d3:96da:426e with SMTP id
 u6-20020a92d1c6000000b002d396da426emr1450677ilg.152.1653768516212; Sat, 28
 May 2022 13:08:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqd_B13rDPCZLm9h0ji8f1oS7mCw=2d1-iiW=M26FfEcCw@mail.gmail.com>
 <20220526173119.GC1751747@merlins.org> <CAEzrpqemPU_=VTxGEQS2WtGiaGbHy+ssnj5MKyh=8JC36uyZ6Q@mail.gmail.com>
 <20220526181246.GA28329@merlins.org> <CAEzrpqfEmm0qGZkkdTgFYNjVvSn6SZwbdDUYLO2E3jV4DYELFQ@mail.gmail.com>
 <20220526191512.GE28329@merlins.org> <CAEzrpqetTskf-UtyfXHBajpJBci4vxdSaBXwDTm5cRs2QtNRkw@mail.gmail.com>
 <20220526213924.GB2414966@merlins.org> <20220527011622.GA24951@merlins.org>
 <CAEzrpqdbuQGwwuCfYyVdiDtGDsPb=3FWmKrTEA5Xukk1ex514g@mail.gmail.com>
 <20220527232604.GA22722@merlins.org> <CAEzrpqeJyupr02nUJkBBVCah46FN+znVczm-RtfBFauvJW9O6w@mail.gmail.com>
In-Reply-To: <CAEzrpqeJyupr02nUJkBBVCah46FN+znVczm-RtfBFauvJW9O6w@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Sat, 28 May 2022 16:08:25 -0400
Message-ID: <CAEzrpqfAYRUYttOAMmdth4mfi4e7MTM++s5WOQ+KAzg2Kv0Nsw@mail.gmail.com>
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

On Fri, May 27, 2022 at 8:13 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On Fri, May 27, 2022 at 7:26 PM Marc MERLIN <marc@merlins.org> wrote:
> >
> > On Fri, May 27, 2022 at 02:35:05PM -0400, Josef Bacik wrote:
> > > I'm augmenting my tree-recover tool to go and find any missing chunks
> > > and add them in, which is what the chunk recover thing was supposed to
> > > do.  This is going to take a bit, but should be the last piece.
> >
> > And by that you mean you're working on it and will tell me when it's
> > ready to pull, or did you forget git push?
> >
>
> Still typing, just didn't want you to think I'd disappeared.  I'll let
> you know when you can pull.  Thanks,
>

Sorry my ability to think isn't doing so great right now.  I've wired
up the detection stuff, but it won't actually fix anything yet.  I
want to make sure I've got detection part right before I go messing
with the file system.  If you can pull and build and then run

btrfs rescue recover-chunks <device>

and capture the output that would be great.  Hopefully this shows the
missing block groups and I can just copy them into place.  Thanks,

Josef
