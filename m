Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B7853BF47
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jun 2022 22:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbiFBUGT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jun 2022 16:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239235AbiFBUGO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jun 2022 16:06:14 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B932A31526
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jun 2022 13:06:12 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id d3so4101891ilr.10
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jun 2022 13:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C3bGSfqNYbqJip/YkfHsRjYFsAzCIiwSyYs780cgvrc=;
        b=uFs9Juz6pN9uM7kPD3Cnb4A+TOA0uZZtnL1zu34bSHsvCIdBtfKDGYlRVicOLJQkX9
         3eYtmT8t3DqjC80S2nucKU6VQ2P5u9qK3ywHryttG09UEXlYNJIzZ1a2ivQGYh2Fvo8w
         HPqVcfRGUPysD6jqmbEbgwFqH2n1XSiJx2pgoeBLDzgOzzYAqfGLWCtB1X82G11or+Km
         JvmKF9ckAil6kqVJCFFagRdQBUi7JKXudrGizqBzClvw9InajmmmCXHizV36pIqwC24P
         FXU7Dd9Ex2COk5JolTnztpvysU6T2qGk/weRDIGk9OH+D0VjAM5G72j3r0QzLMSOwh8o
         OfyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C3bGSfqNYbqJip/YkfHsRjYFsAzCIiwSyYs780cgvrc=;
        b=TVjB3yGe1BuDXimnKQWqOR2b4ORI7cGNwofV8HgoiQvQdy9ZQqr284s/B0m+gOtZT5
         XKYCI0Z9XUybrZZNXElkHbsu+o9HUQidv9pnsohUDH6KSSz5HHxCNELT+Bl6C8yvWmBb
         4PXSD1fVdU2edMY6bJxb1RPXrn2SB7xeAco2yELuLWuHAvqKNS42N/eqBY4AS15mc/iB
         4zRru4FxycOWrHHyvHSVDKIfqxVjJt2M/xHiABNi98N314FlkQNEgFmS6FURP5m+pRqi
         Z7UK7m3zTHX+Ywg08il5ICd04kT0wT0umLoAIi+AXdMXYMdJAF2VPj35UoIuoj29Zioc
         +/yw==
X-Gm-Message-State: AOAM533Yk0yiwCZ/eU/LEXGY1tjqTu69R52BF13kI8zK1DfEemKvsM4Y
        D8a2I5DwzpUzZG8nWL/I3fuhMlhOtiRjjQggHh8EPTMbYjs=
X-Google-Smtp-Source: ABdhPJxJxWdj2QRF0AAbnctmt2oKE5GuEAeEp8cFyB8UJbddeyO7vEqe8g298PQ3OPRZuNjg+XHT2NzZaHDH0vdP6KU=
X-Received: by 2002:a05:6e02:158a:b0:2d3:f198:9f39 with SMTP id
 m10-20020a056e02158a00b002d3f1989f39mr1675987ilu.206.1654200371669; Thu, 02
 Jun 2022 13:06:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220602021617.GP22722@merlins.org> <CAEzrpqfKbEvZh1td=UW6HGJ1x3htSVL1jo49KzcJPu+OSYt4jQ@mail.gmail.com>
 <20220602142112.GQ22722@merlins.org> <CAEzrpqdJHDte6jc7-ykD-wnuFe8_xB-Y4e97C-o5B-G-1Nnksw@mail.gmail.com>
 <20220602143606.GR22722@merlins.org> <CAEzrpqdADZbOcz0iSoiYvOX=UVsbWybiRdcdtc4GJ-tmpJqdRg@mail.gmail.com>
 <20220602190848.GS22722@merlins.org> <CAEzrpqdKjjPW5Bvqkt2=U1_jmiBMGui775BC=Mdx6Ei5FWL1AQ@mail.gmail.com>
 <20220602195134.GT22722@merlins.org> <CAEzrpqciXfV0NZMTJoMjX_E_TzQ-j5sEpsACnEhnJdAXzbVOEg@mail.gmail.com>
 <20220602195623.GU22722@merlins.org>
In-Reply-To: <20220602195623.GU22722@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Thu, 2 Jun 2022 16:06:00 -0400
Message-ID: <CAEzrpqd6CHi2s5B7WPtRo+N0b++F95Qr-nrjYbx2NrD4xxMN=A@mail.gmail.com>
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

On Thu, Jun 2, 2022 at 3:56 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Thu, Jun 02, 2022 at 03:53:00PM -0400, Josef Bacik wrote:
> > Ok it seems like we're still missing some chunks, hopefully re-running
> > btrfs rescue recover-chunks <device> will find the remaining, there
> > must have been system chunks that got discovered.  Thanks,
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue recover-chunks /dev/mapper/dshelf1
> FS_INFO IS 0x55f3efdd3bc0
> Couldn't find the last root for 8
> FS_INFO AFTER IS 0x55f3efdd3bc0
> Walking all our trees and pinning down the currently accessible blocks
> Invalid mapping for 11822437826560-11822437842944, got 14271702368256-14272776110080
> Couldn't map the block 11822437826560
> Couldn't map the block 11822437826560
> Error reading root block
> ERROR: Couldn't pin down excluded extents, if there were errors run btrfs rescue tree-recover
> doing close???
> Recover chunks tree failed

Pushed, try again please.  Thanks,

Josef
