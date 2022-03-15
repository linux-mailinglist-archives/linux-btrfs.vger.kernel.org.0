Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5B24DA346
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 20:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350166AbiCOT36 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Mar 2022 15:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbiCOT3z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Mar 2022 15:29:55 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF9D4553B
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 12:28:42 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id n5-20020a4a9545000000b0031d45a442feso194122ooi.3
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 12:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BtRRgJnqcR82FsxZVkJDMMpxTK0vKElTlDTBNy9oMz8=;
        b=HDw4x2hkzJMo7gNN2H3rFVKgdR0rHt7Q1TJCfKQCh5pR30x9IJsB2yWXR9R9Y7Atc4
         MHTP7CinXf5BIdOydN7dBCoYl3yvZZMqlb+gr/w4lGIMs6WHEbxAhwfBrT1GCMRHP9px
         dszjyZ1i7gX3AbFYSwcDJLmRTkBwEuIDSJqJsgxUQ+hfcBJ9Xtg6cSMjmu9qy09TQbDd
         DxV6whfIrIebKvEwrQgN/J/XUv86E4v65ASbpdkqbbkt9YwRgNZTir6g4ZS2sYcbkcn3
         9RT3N6zDruBc7jz9+GVGaJPJIjc1ym6lN/FBDWV7iX3BzMshYk3pxvBgiK4/1SvInxV0
         C2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BtRRgJnqcR82FsxZVkJDMMpxTK0vKElTlDTBNy9oMz8=;
        b=uhVjWFNSc+lGWK9jvd0EV7RUTIGYO4pVPL28jh4rrzHh8tyh9tgYI+1k2yiJSdxrZN
         69X+RhHbAALq1kMOh6ls8+iH//6S+s70Nb4iDyfAiQRTzdENqS5w2lKmDBDgQKw5C1yH
         J4o6UU+T+tzpCMsF3W2i0WrxBamwoEy1rB1NKB4bwC13EqSPJP11m27+0/aj3wdukoq4
         EPJ5iUQxlnJRY98EA7Si2BnQ+15+qEVy66LcArvHfRHhUM66e4Lmd+K7BYGzNf+gs2E4
         MCCJKVmP+4nOPKzWa/eZOdJV7ufDhtCfK5X0XVsnbG5tYXyo0kAOxeTw/hRhkwUAKy8P
         k/VQ==
X-Gm-Message-State: AOAM531gjmRqKv5fcFz6t+z5Tn+sx2UBZklhC/u4ghslgH4hAysyP7zN
        wetbIMbpmDB+Q3un4/OCAYn4lstEL09ygCUIOLQ=
X-Google-Smtp-Source: ABdhPJyRF3gOYPKj5xAdaeTun52Xf6JsV2vKM+0qd2acFKDawce/tW8TjE8m1pRt0RrjEKwXoVebVJmM09ZCLknUWCg=
X-Received: by 2002:a05:6870:1613:b0:da:b3f:2b3c with SMTP id
 b19-20020a056870161300b000da0b3f2b3cmr2227570oae.219.1647372521976; Tue, 15
 Mar 2022 12:28:41 -0700 (PDT)
MIME-Version: 1.0
References: <3c668ffe-edb0-bbbb-cfe0-e307bad79b1a@gmx.com> <CAODFU0pcT73bXwkXOpjQMvG0tYO73mLdeG2i4foxr6kHorh1jQ@mail.gmail.com>
 <70bc749c-4b85-f7e6-b5fd-23eb573aab70@gmx.com> <CAODFU0q7TxxHP6yndndnVtE+62asnbOQmfD_1KjRrG0uJqiqgg@mail.gmail.com>
 <a3d8c748-0ac7-4437-57b7-99735f1ffd2b@gmx.com> <CAODFU0rK7886qv4JBFuCYqaNh9yh_H-8Y+=_gPRbLSCLUfbE1Q@mail.gmail.com>
 <7fc9f5b4-ddb6-bd3b-bb02-2bd4af703e3b@gmx.com> <CAODFU0oj3y3MiGH0t-QbDKBk5+LfrVoHDkomYjWLWv509uA8Hg@mail.gmail.com>
 <078f9f05-3f8f-eef1-8b0b-7d2a26bf1f97@gmx.com> <87a6dscn20.fsf@vps.thesusis.net>
 <Yi/I54pemZzSrNGg@hungrycats.org> <87fsnjnjxr.fsf@vps.thesusis.net>
In-Reply-To: <87fsnjnjxr.fsf@vps.thesusis.net>
From:   Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Date:   Tue, 15 Mar 2022 20:28:05 +0100
Message-ID: <CAODFU0r4Q5_+5hS51uOfLh2tPQqxB9Dv8LQxnNb0aDHXXDp5MQ@mail.gmail.com>
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
To:     Phillip Susi <phill@thesusis.net>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 15, 2022 at 7:34 PM Phillip Susi <phill@thesusis.net> wrote:
> Zygo Blaxell <ce3g8jdj@umail.furryterror.org> writes:
>
> > btrfs extents are immutable, so the filesystem can't extend an existing
> > extent with new data.  Instead, a new extent must be created that contains
> > both the old and new data to replace the old extent.  At least one new
>
> Wait, what?  How is an extent immutable?  Why isn't a new tree written
> out with a larger extent and once the transaction commits, bam... you've
> enlarged your extent?  Just like modifying any other data.
>
> And do you mean to say that before the new data can be written, the old
> data must first be read in and moved to the new extent?  That seems
> horridly inefficient.

I think, one way of how to make sense of this is that, in btrfs, not
just past file-data is immutable due to the fact that it is a CoW
filesystem, but also certain parts of the filesystem's meta-data (such
as: extents) are immutable as well. Modifying meta-data belonging to a
previous (thus, by design, unmodifiable) generation in the btrfs
filesystem is somewhat complicated.

-Jan
