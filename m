Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94CF4DA539
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 23:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352186AbiCOWV7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Mar 2022 18:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352182AbiCOWV6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Mar 2022 18:21:58 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FDB5C656
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 15:20:46 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id o64so779299oib.7
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 15:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yHKDGwnW7aQ4fQisVAIqIgw/LYPpRC+fcY+ruNNGvYs=;
        b=A7LA+Q6ZP2kQpWs43YEJYOf/awdwEL7AYM/VPU+1ef2zJqKDS7yrCb2QRJIPadm6Pl
         ledhZLzt2mndnynziCYyDql2WaJe+x+waKxzpvbH6GKLwsrbexxhKj+RDW4WGNGkER6d
         CClZMRUNy+6z9EmHOBc3m7cLR+m0SzZ2EUgiigkZYo1YixvN3YaRGASzAMj308z7TWjt
         loB9uc973CMyWnkJ07YJSCLEERtOHCn5ZIA+hXZ3gRK8jNe3gSR2OGKJIbBLnMMoeam+
         BKhGhgbnF+NGytdwFajlWOHIUpHyzJ+eO86Po9Z9xmXxnRKEfqsSk0HN6cPoKv4jlRZ4
         Q4ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yHKDGwnW7aQ4fQisVAIqIgw/LYPpRC+fcY+ruNNGvYs=;
        b=O+M+qcjjhi+NSFxGl+Oxdp+I16GrJZMHWdNmdHfKLAUdDltVBD+yJ1Nz7dciWmTne8
         x496qR92CpaLV6DVOE6Onys9Pg1RFmCrTtuXIkuzg1R2s3duV/k1h8Bq8saD4qdo52HL
         ec+cubR0dWgpqSdjqrZlxCUDgJMTBKISDFbbMOYLj5tppopFhymG+6IGCPKnofoy+j4w
         5mVbx+X0fPdQXdQjMbZo+VEFf4R/6KgO1qdpiIMreBZ9rbRThCiMPvrfoQe7d1iMe8zS
         k4GNf5v7YHPnCLoUF2tjym9dxJVTNhmF3W/AZ+V2uR4F3fvdNsQ79hH7howBzbIrEbBW
         Butw==
X-Gm-Message-State: AOAM532aj7Qfp0QWxlawPF//N6vX0dSf+Sx6yPmLUk4SCchYgqnru8SX
        /nK18eIoi8JrGBcPjdgenGJPAwKnE4BtVhTfcw6BenU0AwV1aA==
X-Google-Smtp-Source: ABdhPJzVTabxxp8ma6fZQcPYbKe8yN8KRixjSF+5dHr1/8EeKovPPqA5Hwtf3gKHErhhW94qhJ63fl22dibJPDWlmZA=
X-Received: by 2002:a05:6808:14cf:b0:2d9:dcc6:8792 with SMTP id
 f15-20020a05680814cf00b002d9dcc68792mr2715997oiw.219.1647382845692; Tue, 15
 Mar 2022 15:20:45 -0700 (PDT)
MIME-Version: 1.0
References: <70bc749c-4b85-f7e6-b5fd-23eb573aab70@gmx.com> <CAODFU0q7TxxHP6yndndnVtE+62asnbOQmfD_1KjRrG0uJqiqgg@mail.gmail.com>
 <a3d8c748-0ac7-4437-57b7-99735f1ffd2b@gmx.com> <CAODFU0rK7886qv4JBFuCYqaNh9yh_H-8Y+=_gPRbLSCLUfbE1Q@mail.gmail.com>
 <7fc9f5b4-ddb6-bd3b-bb02-2bd4af703e3b@gmx.com> <CAODFU0oj3y3MiGH0t-QbDKBk5+LfrVoHDkomYjWLWv509uA8Hg@mail.gmail.com>
 <078f9f05-3f8f-eef1-8b0b-7d2a26bf1f97@gmx.com> <87a6dscn20.fsf@vps.thesusis.net>
 <Yi/I54pemZzSrNGg@hungrycats.org> <87fsnjnjxr.fsf@vps.thesusis.net> <YjD/7zhERFjcY5ZP@hungrycats.org>
In-Reply-To: <YjD/7zhERFjcY5ZP@hungrycats.org>
From:   Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Date:   Tue, 15 Mar 2022 23:20:09 +0100
Message-ID: <CAODFU0pwch49XB4oGX0GKvuRyrp+JEYBbrHvHcXTnWapPBQ8Aw@mail.gmail.com>
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Phillip Susi <phill@thesusis.net>,
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

On Tue, Mar 15, 2022 at 10:06 PM Zygo Blaxell
<ce3g8jdj@umail.furryterror.org> wrote:
> This is what makes
> nodatacow and prealloc slow--on every write, they have to check whether
> the blocks being written are shared or not, and that check is expensive
> because it's a linear search of every reference for overlapping block
> ranges, and it can't exit the search early until it has proven there
> are no shared references.  Contrast with datacow, which allocates a new
> unshared extent that it knows it can write to, and only has to check
> overwritten extents when they are completely overwritten (and only has
> to check for the existence of one reference, not enumerate them all).

Some questions:

- Linear nodatacow search: Do you mean that write(fd1, buf1, 4096) to
a larger nodatacow file is slower compared to write(fd2, buf2, 4096)
to a smaller nodatacow file?

- Linear nodatacow search: Does the search happen only with uncached
metadata, or also with metadata cached in RAM?

- Extent tree v2 + nodatacow: V2 also features the linear search (like
v1) or has the search been redesigned to be logarithmic?

-Jan
