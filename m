Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4814F214A
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Apr 2022 06:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiDECPk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Apr 2022 22:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiDECPi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Apr 2022 22:15:38 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05B23DC445
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Apr 2022 18:10:42 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id q11so13449430iod.6
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Apr 2022 18:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T0XBkYugezAJpQwSxS1lb/92dAwZBuqBr3dZPzOYBE8=;
        b=OwpySwxneJBssI/kcxXlVU7rFJOBXFbKD88iJRsps5dQSgRQBwu1+eie7y4NCBeBfk
         bxMcRjUI6mL0knX7fLezZlUCGcDpdKTpada9e4Dhf5ULV9wIxFghB4BkfS82Qvr36Rn7
         J+eKWBlm3RRij4PJuXvOLnwnl+mR+hI/2RxZB5pnrXxShsZKHB/dPwt8x0EchZCkAG2t
         5cheUh848zdjeGTTsVNkwR7dbnhb+49vVHknnEHOkch2zYp89BadI85cFUB3LmXffc1w
         q3SjRWxyHe3TaZyKwuXOPbBd3OXTSIqCbBwoV0yDM5b3c++ppgvTo6x8GwD7/GSr727b
         W3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T0XBkYugezAJpQwSxS1lb/92dAwZBuqBr3dZPzOYBE8=;
        b=r57LdtuGVufKxOmBZ4iuKZ19Yqqgknj7oARVt9UDSxQOvu0X1Y6ZGMXcAAqAvClr4n
         DLNFnCbTB1iQjSIXHKFX4GTglJnB24Y2WbaCtLEDOMm7GgjS+LJCCm7ZKdpmn09mCN/m
         +6F/CbqcRb26IMBdrdTagj8ImKWeth8ysD4VJpWrVwo0Ip62eVlcFrtODu3PdKjpai6h
         VSsavsg3BQZBDdSXhJf/Nel1V/qhE7qyB9VTkLNxi+po4Ixb6ZFRKdH5vhhqTD83zX50
         1oZ/OAax5Q1OtydNoQflHgPPDVEARrlYoYtrIOYhkmUPb2w91Y1RfLE2A+RrgM8k9sMo
         yC4g==
X-Gm-Message-State: AOAM530XRh2OKwDTf3vsjA13EsZLAfZucoJx0UA1DP59zsJN02M0u+AX
        C9pXw51JPwL0j1uHoCaw5nO8+Oj7W185O0k0N78N+Mta16n0nw==
X-Google-Smtp-Source: ABdhPJzzpdZ0WiFzsr0I8VY+zKWyL8Gtms0TWtr4R7kbarZFJ6hBvDyDubHDKTyQN8JvJzoGZHmOzYzmnLuZ5j+tNUU=
X-Received: by 2002:a05:6602:14c7:b0:646:3bfb:7555 with SMTP id
 b7-20020a05660214c700b006463bfb7555mr508718iow.83.1649120772509; Mon, 04 Apr
 2022 18:06:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220404231838.GA1314726@merlins.org> <CAEzrpqd2kVY=mpttaP3+YJJ_1t1Z3crfXAdF-69pMU10aVe5OA@mail.gmail.com>
 <20220404234213.GA5566@merlins.org> <CAEzrpqft7WzRB+6+=_tTXYU4geBB_38navF1opr6cd9PXiWUGg@mail.gmail.com>
 <20220405001325.GB5566@merlins.org> <CAEzrpqcb2jHehpnrjxtNJ4KWW3M5pvJThUNGFZw78=MBNdTG5g@mail.gmail.com>
 <20220405001808.GC5566@merlins.org> <CAEzrpqfKaXjk7J_oAY0pSL4YPy_vw5Z0tKmjMPQgQSd_OhYwXA@mail.gmail.com>
 <20220405002826.GD5566@merlins.org> <CAEzrpqeHa7tG+S_9Owu5XYa0hwBKJPVN2ttr_E_1Q4UV8u0Nmg@mail.gmail.com>
 <20220405005809.GE5566@merlins.org>
In-Reply-To: <20220405005809.GE5566@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Mon, 4 Apr 2022 21:06:01 -0400
Message-ID: <CAEzrpqfjTUoK9fi43tLZaJ9mkBewAqcUH77di7QipH9Vj6AB0g@mail.gmail.com>
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

On Mon, Apr 4, 2022 at 8:58 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Mon, Apr 04, 2022 at 08:39:14PM -0400, Josef Bacik wrote:
> > On Mon, Apr 4, 2022 at 8:28 PM Marc MERLIN <marc@merlins.org> wrote:
> > >
> > > On Mon, Apr 04, 2022 at 08:24:55PM -0400, Josef Bacik wrote:
> > > > > Binary identical after rebuild.
> > > >
> > > > Sigh time for printf sanity checks, thanks,
> > >
> >
> > I'm dumb, try again please, thanks,
>
> progress :)

Ok, lets try

btrfs inspect-internal dump-tree -b 13577779511296

and see what that gives us, the root we think is ok is missing the
part with the actual root items.  Thanks,

Josef
