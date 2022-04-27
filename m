Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92339512751
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Apr 2022 01:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240225AbiD0XIT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Apr 2022 19:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240404AbiD0XII (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Apr 2022 19:08:08 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D7BAF1CD
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 16:02:42 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id z26so4793141iot.8
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 16:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xsYHv/9C5WlVKtkn8IKe7MSsnxAEvS0GtMa9X05z1bU=;
        b=aW4WhBeAFRX4eTsE/462dh2GmqDz0MPin4T2QX/BgbJ0fZEJko0jzF37532KnzFYtN
         rzBywr2smbek7QPNITXIfcCRunyvNl357/3nTOn/bBNduFhBU1vcrA5kCGENMPwmAZu3
         TQU9nQHYdHtboTAeqzQlJckaRcY4KnGY1IFbxURcvHcH+f63Eq/KchLA4ybc11q9bWYk
         82lw7+7DZ+vARGsus+vjFyWpaosLuC8IO0UxzhwbkSNaJEOOMy03fmUrwwvM6+/SkDk/
         Ma4hJuma3aXOcE7MmAB+qR482/CazherKQmBB+zJXY6GYOz8l47XU+tfpInw4Kgn5RaO
         xRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xsYHv/9C5WlVKtkn8IKe7MSsnxAEvS0GtMa9X05z1bU=;
        b=vTvnnYYIgFcqnQ3ZLnJIyQjluOvdrhFyVSRvDH18J2t+avF53qClcdYK9HeEvnAIHn
         RV9NAI0hcMONigekv0uHvqw4bc8J3rnZfX04dm/uhNQAl0SB0GaGuBi3OLaas0IbUAa0
         QlUrCZvwDPQgkqESGtgzFUya2PpMUaQgeHGVNH1pLf8vGSloesSVOn82TSaBYCj8u5ND
         vs7dq8JIT33Z5x8ZUG+GjXfjs1RYytF260K931PblAnK5AxJaKq04ZwIBr5QeezXgGI+
         9ASR6O6L+9Asr9MScOOMOcTX0FEf4e2KTHzBEAsoRTkwVxAA+TT010v5YkicU/sxKWcQ
         1rGg==
X-Gm-Message-State: AOAM533EOhy9FuPco+RRSO7vW+rL5d5AxTy6qTwC7/5CIlMNpsJu9EiX
        40IiFEryXWVqk3nQdx8LezqvWwvhI2V+6X43h1mYqtWZZsI=
X-Google-Smtp-Source: ABdhPJxMFBTc8oftBKZTd1Jzb+hH8FU6UMxjCe8oKhabu4quHmdyoXiI47PZemLrcvemVcGKURSY4OymeK3rAXqP9v0=
X-Received: by 2002:a05:6602:14ce:b0:657:2bbc:ade8 with SMTP id
 b14-20020a05660214ce00b006572bbcade8mr12636065iow.83.1651100561461; Wed, 27
 Apr 2022 16:02:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220427035451.GM29107@merlins.org> <CAEzrpqdN7FaMMpemFbr6fO9Vi8t6upGPbAjonTtP-dpWMzdJwQ@mail.gmail.com>
 <20220427163423.GN29107@merlins.org> <CAEzrpqdaEFMi1ahnTkd+WHqN-pDWOnf4iK2AiOiOxb3Natv0Kw@mail.gmail.com>
 <20220427182440.GO12542@merlins.org> <CAEzrpqc7D5A6xZ7ztbWg4mztu+t9XUPSPt_gEgAbCCzVzhnHbA@mail.gmail.com>
 <20220427210246.GV12542@merlins.org> <CAEzrpqezdFDLGjLvzznWrxCg11DptboeWCc7p_Wwz-=q5H+00w@mail.gmail.com>
 <20220427212023.GW12542@merlins.org> <CAEzrpqcvrA+qJspsusyk2fOOp5WovjWQEGX5sZA=Pr8pQRb9wA@mail.gmail.com>
 <20220427225942.GX12542@merlins.org>
In-Reply-To: <20220427225942.GX12542@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Wed, 27 Apr 2022 19:02:30 -0400
Message-ID: <CAEzrpqfN9QQqyRAoy=YOpcaCWnKCzpDcTxAtYNUGE=7A2vRTTQ@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 27, 2022 at 6:59 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Wed, Apr 27, 2022 at 05:27:44PM -0400, Josef Bacik wrote:
> > Sigh, added another print_leaf.  Thanks,
>
> doing an insert that overlaps our bytenr 7750833627136 262144
> processed 1146880 of 0 possible bytes
> processed 1163264 of 0 possible bytes
> processed 1179648 of 0 possible bytes
> processed 1196032 of 0 possible bytes
> processed 1212416 of 0 possible bytes
> processed 1228800 of 0 possible bytesWTF???? we think we already inserted this bytenr?? [5507, 108, 0] dumping paths
> inode ref info failed???
> leaf 15645023322112 items 123 free space 55 generation 1546750 owner ROOT_TREE

Ooooh that explains it, it's the free space cache, that's perfect!
I'll get something wired up and let you know when it's ready.  Thanks,

Josef
