Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A946665FB5D
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jan 2023 07:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjAFGTU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Jan 2023 01:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbjAFGSv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Jan 2023 01:18:51 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E93B6EC89
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Jan 2023 22:18:07 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-4c1073f545bso10834937b3.2
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Jan 2023 22:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=leblancnet-us.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R0hofCZz7EVuFcNZg72qvyXCe55pUUhWVaTTGatHYp8=;
        b=QESBizyK7iPbnuqAKh0jt1VSz+MUgrYRTNJzlqD7SaTL2iyxrySPXfiuoeunJ1x/Bd
         MdaGor2GM3/IbZ20UQPNc6gJ7NZobzb7JJWNA3oYzDHwSKN1s8kjOQmhU3j3OcUtoo/L
         wAWQuzF8pm9gej8+b75UsnkeOwnVB39pWSznz37r9jEXZhXe1krbrQrHBLumDWLq5YmR
         f0RZmTS8etoy1oF5Ht26p4tmGPfdbkEXgRYYE3uP42yu6zL1dOAeSEjif4z2Y8R833D2
         qwDAZYILjw8+huOKgqiD8C2h3gbcIsV3WfROXaDPbmt618zGU1MgD5ZtHaZBOdBh5422
         bTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R0hofCZz7EVuFcNZg72qvyXCe55pUUhWVaTTGatHYp8=;
        b=6NRe+2WIDhOC3kDdYCp/Bf/vBssArScxRywLiVfE22mWE0Nmd5eex+TYf6jZtS8aVk
         kUuIAtzZKqUmdeOiKofeo294p6DMYiz5elBTsnYUJgfXaIC5z0Vw1e+fHTv4SbeAx/k+
         jyagH6ChZYHg3tq+VCjnvM6gRnxOV8DS2R9HxDduv8NznPlaRF8Dj9rN4NdZ+f0tDED3
         uOEa5zmU2wjoBgRKStVw1MQlB7wxuHAniIV3APVJ5NEPC9airxXug/a7FEZEKSY1TN4Q
         2PREQLzgHKnrjpJYRYXvTUacyLsMqfaBFI/VXooRREgneCRkIlgyR9Qai1k03NRZLcQ9
         08xA==
X-Gm-Message-State: AFqh2kpQoAQ1HDgorHvZV1W67ZnWPcVQuCAA5nF1dO2KVNJz0cq/+Hdv
        L2ER0lpsdgt/mT9U40NOwQwiRuBC4vqZEROOcA/TpMSpwLAaBZNVFmPo9Q==
X-Google-Smtp-Source: AMrXdXuLng+ozd2Pxkz+tYidnq40Om6NzbcD4rK+OSqcf9XlZSOQyc+5GLhynMNXqfrZn5oYG0O8BV6H+IhYi3SFSDY=
X-Received: by 2002:a81:48ce:0:b0:47b:5415:c95a with SMTP id
 v197-20020a8148ce000000b0047b5415c95amr4023167ywa.19.1672985875465; Thu, 05
 Jan 2023 22:17:55 -0800 (PST)
MIME-Version: 1.0
References: <CAANLjFobOKhui5j1VsRkNSTF9SjRADtBennjoZE1jEPnU=iVaw@mail.gmail.com>
 <CAANLjFraYrdzZLv0ZcW=1sfnKSnbbb08qEpVHiAQHZQ181epjg@mail.gmail.com>
 <4f134378-4298-bc28-c17a-8415ffdc19e9@gmx.com> <50ecc4dc-fbf1-8fca-5484-27de33a2ed85@gmx.com>
 <0de3f1eb-4131-774b-74bc-ab2cfdd022de@inwind.it> <b09e0dfc-a911-5eea-8a35-f829ab618b2d@gmx.com>
In-Reply-To: <b09e0dfc-a911-5eea-8a35-f829ab618b2d@gmx.com>
From:   Robert LeBlanc <robert@leblancnet.us>
Date:   Thu, 5 Jan 2023 23:17:44 -0700
Message-ID: <CAANLjFroTEUcOLjfRs-4FWdSf_rgnSHpP8TkU8fo--SYrfjKCg@mail.gmail.com>
Subject: Re: File system can't mount
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Antonio Muci <a.mux@inwind.it>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 5, 2023 at 5:20 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> There are several hidden assumptions.
>
> - For recently created/balanced btrfs, there should be no tree blocks
>    crossing stripe/64K page boundary
>    Thus a single backref crossing the boundary is not some common thing.
>
>    We should either get tons of such metadata, or none.
>
> - Dmesg itself only contains the obviously bad info
>    In your case, it's "btrfs check" result showing the details.
>    As kernel rejects the mount directly, without giving any chance
>    to look into the situation.
>
> - One backref is missing, one backref should not exist
>    This is already a hint to let us link those two backrefs.
>
>    And if we compare the hex of the two backrefs, we got one
>    bitflipped.
>
>    Furthermore this does not only matches the symptom, but also possible
>    to happen.
>    The metadata itself is fine, but when adding the backref, bitflip
>    happened in the key of the backref, resulting a missing backref for
>    the correct metadata, while a backref doesn't has any metadata for it.
>
> Thus I believe it's a memory bitflip.
>
> Thanks,
> Qu

Qu,

Your assumptions are spot on. One of the two memory dims is either bit
flipping or stuck on 0/1. After running memtest86+, I can verify that
some memory addresses create spoiled data. I'm currently running off
the good DIMM as I get some new RAM ordered and recovering from
backups (apparently my backups stopped in September of last year) and
then trying to pull off the newer data that I need from the bad file
systems. It's really odd that I never saw csum errors in dmesg and it
only appears that metadata got corrupted. It looks like some of my
more critical subvolumes I could either do a `btrfs send/receive` or
do an `rsync` of them from my NVMe btrfs. I hope the HDD will have
similar luck and since there weren't a lot of writes to my large
volume, I'm hoping that it escaped corruption.

Thinking out loud here, with BTRFS being so good at detecting bit rot
on disk, could that be expanded to in-memory data structures kind of
like RAID with checksums? But I guess the argument could be made to
use server grade hardware with ECC if you want that level of
protection.

Thank you,
Robert LeBlanc

----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
