Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15EE153DDE1
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Jun 2022 21:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343917AbiFEThi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Jun 2022 15:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234938AbiFEThg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Jun 2022 15:37:36 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9966F65F2
        for <linux-btrfs@vger.kernel.org>; Sun,  5 Jun 2022 12:37:34 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id r3so10735999ilt.8
        for <linux-btrfs@vger.kernel.org>; Sun, 05 Jun 2022 12:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b0KoERCOlgFZ5VnwYQ9UqmG4yqAXDnWWJDbQbr7fpK4=;
        b=O9xqHP12uDYQjd4jiFW2bE2dmQ2/xkidyLFpAnCmcjDKklf1p/pJYhleBB2c4YR5A1
         oWIUu4qWQBUjStzRs1hRpSTrOVAbnEhOORFDgNIxlRNs1GARJgaVUQ01UMqZyXl0PUH8
         NTbeZ+X8tlC4MB1d5gsthPwiPVbDbuPwWZVxHbOuxafEefdYyNMqtpwmEpKu859eVN2/
         wHw+HAR1lNt7sFPd0xi1nyg1VttSrFn4r9FaeqktOeAGhpWtTHTODYRlpYASTXDigHwt
         b7G/dTM2+m6ISzdYVYSAFwAh4c/H+yVtmivnkJTppE2deJojUMeuQqI986k2jNk2gH00
         dajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b0KoERCOlgFZ5VnwYQ9UqmG4yqAXDnWWJDbQbr7fpK4=;
        b=h+S8ITbyumTLKGYNBySBcOAobDseuPltVbYZlqYSjfy+jd5iex+YzLfw7zPP1PPZ11
         wPV2+pH4NFCH6nPFSZTwEm8IxQyxkGI7wIIBBfva1q3oNdWGgG6N0mu51/qlzhuZMtuA
         b7KpyfCuoP601klq9GbCcCML5sIIT5GrPxTGRmHbKTmLwPfORW3u5KXz0xqeGyy6E8dC
         JNl+3hrxizDxkP+b9Y6Cv8mn4/PvuGNgnEErkiw4jHaL9X3DW00xlRN30YQFkD7nIOrk
         scoZ1fgnpBKp6XCpQK+dESzyqtvjZ8vBjK2m04LrOP9FQbwhPZsCFYq3pkuhggoE5sJ8
         oEFg==
X-Gm-Message-State: AOAM530PRwbuv3KTN2bgnen1kQ+CK0GWCSl/VaYbGJMDC24RAiqyah6d
        becYDTE6g43L09Ci13QWNfxn0/xfbEnZEUA5RyDT8dCVgXI=
X-Google-Smtp-Source: ABdhPJy/Ee4Wyil7IQICjTZiwo+KYbDnIIoDnqbBNIcV+UyXv0XIt09LbxercGi4K4GoooRXk6HUL8X+5Zy+9XFQUGw=
X-Received: by 2002:a92:d1c6:0:b0:2d3:96da:426e with SMTP id
 u6-20020a92d1c6000000b002d396da426emr12137576ilg.152.1654457853862; Sun, 05
 Jun 2022 12:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqdBHuJr85+TfSyRbXEOVY6jqKqZNJo42d8afATr=b9Gow@mail.gmail.com>
 <20220603144732.GG1745079@merlins.org> <CAEzrpqez1Ct8xrtCOaFtPxWQZ-0R6BUSYm2k=PN9pqChoKNMSw@mail.gmail.com>
 <20220603164252.GH1745079@merlins.org> <20220603170700.GX22722@merlins.org>
 <CAEzrpqf122toMdEAx2audiusW3kKM6d36df13ARJ+SjbVf7TFw@mail.gmail.com>
 <20220603183927.GZ22722@merlins.org> <CAEzrpqdzU7nugcLoTzKy-=tsikX=dUx5xMb2iKe+wR=69=H4yA@mail.gmail.com>
 <20220604134823.GB22722@merlins.org> <CAEzrpqetLawF0wdYkz02nGQct63Yae_-ALF=ZUw3hVe=AH4wKg@mail.gmail.com>
 <20220605001349.GJ1745079@merlins.org>
In-Reply-To: <20220605001349.GJ1745079@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Sun, 5 Jun 2022 15:37:23 -0400
Message-ID: <CAEzrpqfjDL=GtAn9cHQ2cOPMVZeNnuaQBLq6K-X-tGaipaAouA@mail.gmail.com>
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

On Sat, Jun 4, 2022 at 8:13 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Sat, Jun 04, 2022 at 07:10:16PM -0400, Josef Bacik wrote:
>
> > Ok this looks like it worked?  Can you re-run tree-recover to see if
> > it uses the right bytenr?  Thanks,
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue tree-recover /dev/mapper/dshelf1

Sorry I've been in the mountains with terrible internet.  I'm home
with a computer and real internet now.  I've pushed more debugging,
just run the init-extent-tree again, it'll spit out the root info so I
can see wtf is going on here.  Thanks,

Josef
