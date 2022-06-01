Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C0653B0B0
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jun 2022 02:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbiFAWyp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jun 2022 18:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbiFAWyo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jun 2022 18:54:44 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5D1403E7
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 15:54:43 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id s23so3220879iog.13
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Jun 2022 15:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uW63rcfRh/z+DZtV9ZmXSgcdeBE70Y1TdHgB9v0P8G4=;
        b=cp1UzLUgOB6lewJawWnlD9LL+2m6S+AOgVvLaua8bTnf/p3bLn/uOvp+GD4uL9hCos
         WzlwpKgZJg0w3cI8cyuSCQlhm5r7Be4Z9pWOpfw/BQoTivlyjZ8xLEA2D2Qeqhn1Tw4n
         Eq75fekK9Kp9A/F8hak7emXCAubYDe6PYMDD4VvGrOUbfgooMm5Zy7KeT9cTNVfgfJpH
         +Kdj9qMOT9VyRaGM/iBYo36SVJxujpTqwAE96WMokbL+0HUxpX2e6ssTboc/sCr4oqRX
         okFJ1k1+z5YMejbrBTjN/KHGYhqMDn0fB6jgg4+Dr2CI4+kVEGibD6qe6Xe068KfAAVa
         UM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uW63rcfRh/z+DZtV9ZmXSgcdeBE70Y1TdHgB9v0P8G4=;
        b=zIMdTjOcSwZQcGYAKClO7jH3CHNrF00lhlKjwmcLGfNqG4K1HX5xpaJj4WeBzg4F/w
         veplt5x6mGKm1V8vCZ3xCVjaol8za0qAyaeBLPdcNHFYCg76J6Hsa98CcJmIirb0mGTo
         jCaRUK8CFLD28Fuzpw2r2eSvcPbbZN9NrA82Pn5m9o76FHZBEt0lS0ivypTj0Ww8RH7J
         TqX+rPh5ptLMSZEdK0hN04gLcdwDu3nvx5vlxTEOOmqMSTem+T2ncHGF9xL+82bsYWXk
         V/AJA+4Mdh5n4T/LfjqxXURP1IiJAhJA2vg9ap3pxyWKtgYIxVZHPATBXbN7l9fb4dbD
         omZA==
X-Gm-Message-State: AOAM530ZFuQkkhJelhqmF+SJJyNcb4CLcCgubV5qQKdV7n0Kf4ZyasB5
        XPMUhIxfYs5JmEn0915W3Sf+KIOycN5jjpWY/AC3i525GAU=
X-Google-Smtp-Source: ABdhPJwwyHochiMQXMEM8CXvGA/E2XkOlz/FldPy14V8AMIWvtiDfGysrqiQCvW/3vRUHMoeo8QBhFX4/FbfWL+CVGc=
X-Received: by 2002:a05:6602:1695:b0:665:8390:fcf with SMTP id
 s21-20020a056602169500b0066583900fcfmr1158288iow.83.1654124082444; Wed, 01
 Jun 2022 15:54:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqfw85GnLUq8=vywej1Gb6vjcgKUYucLw9DgoSaWEbyZbg@mail.gmail.com>
 <20220601163924.GE1745079@merlins.org> <CAEzrpqd7=9JxgjC0pqikEo5o7RTsP9M-qLLcCps0Vx1RxRak-g@mail.gmail.com>
 <20220601180824.GF22722@merlins.org> <CAEzrpqc1cFHwb8fczUatznbwzDFi87j-kuXMMcUf2rmKWzu5Lw@mail.gmail.com>
 <20220601185027.GG22722@merlins.org> <CAEzrpqcY-F4WOiaJcDfHykok0LB=JEX1DnZj53+KvM7a6j+daQ@mail.gmail.com>
 <CAEzrpqeTEuRzP_Nj1qoSerCObJLA4fJYDfR1u3XMatuG=RZf-g@mail.gmail.com>
 <20220601214054.GH22722@merlins.org> <CAEzrpqduFy+7LkgWyyEnvYLgdJU6zDEWv25JM-niOg9tjmZ3Nw@mail.gmail.com>
 <20220601223639.GI22722@merlins.org>
In-Reply-To: <20220601223639.GI22722@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Wed, 1 Jun 2022 18:54:31 -0400
Message-ID: <CAEzrpqdfz5FMFDiBbb1mrUTXqxNvJ2RkuqJCdE2VQ6op01k61g@mail.gmail.com>
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

On Wed, Jun 1, 2022 at 6:36 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Wed, Jun 01, 2022 at 06:34:51PM -0400, Josef Bacik wrote:
> > On Wed, Jun 1, 2022 at 5:40 PM Marc MERLIN <marc@merlins.org> wrote:
> > >
> > > On Wed, Jun 01, 2022 at 04:57:34PM -0400, Josef Bacik wrote:
> > > > Ok I've committed the code, but I forsee all sorts of wonky problems
> > > > since we don't have a tree root yet, there may be a variety of
> > > > segfaults I have to run down before it actually works.  So go ahead
> > > > and do
> > > >
> > > > btrfs rescue recover-chunks <device>
> > > >
> > > > if by some miracle it completes, you'll then want to run
> > >
> > > Found missing chunk 15483956887552-15485030629376 type 0
> > > Found missing chunk 15485030629376-15486104371200 type 0
> > > Found missing chunk 15486104371200-15487178113024 type 0
> > > Found missing chunk 15487178113024-15488251854848 type 0
> > > Found missing chunk 15488251854848-15489325596672 type 0
> > > Found missing chunk 15671861706752-15672935448576 type 0
> > > Found missing chunk 15672935448576-15674009190400 type 0
> > > Found missing chunk 15772793438208-15773867180032 type 0
> > > Found missing chunk 15773867180032-15774940921856 type 0
> > > Found missing chunk 15774940921856-15776014663680 type 0
> > > Found missing chunk 15776014663680-15777088405504 type 0
> > > Found missing chunk 15777088405504-15778162147328 type 0
> > > ERROR: Corrupted fs, no valid METADATA block group found
> > > Inserting chunk 14823605665792wtf transid 2582704
> >
> > Fixed, lets try that again please.  Thanks,
>
> Found missing chunk 15672935448576-15674009190400 type 0
> Found missing chunk 15772793438208-15773867180032 type 0
> Found missing chunk 15773867180032-15774940921856 type 0
> Found missing chunk 15774940921856-15776014663680 type 0
> Found missing chunk 15776014663680-15777088405504 type 0
> Found missing chunk 15777088405504-15778162147328 type 0
>  Unable to find block group for 0
> Unable to find block group for 0
> Unable to find block group for 0
> Inserting chunk 14823605665792wtf transid 2582704
>

Ah right, I have to mock up free space since we can't read our normal
stuff.  Fixed, lets go again.  Thanks,

Josef
