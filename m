Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9574F1C4A
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Apr 2022 23:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380633AbiDDV0S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Apr 2022 17:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379515AbiDDRU6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Apr 2022 13:20:58 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D06CDEFB
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Apr 2022 10:19:00 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id e22so12086219ioe.11
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Apr 2022 10:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ybOCW8P6F/Yqf3OcdlmcI2ZZHw0MxYTzS9UF7EPTtBM=;
        b=zp3sdaOgUNlvGn6XGHbiCWXrSLBLxFytJshP7sNRHI7YNlr0J9MZmjx5VxvlxqoGv4
         diqO0klkolSu6J20w/TYDswiAc33ddMskBM5ElJH8flgu+2J1nQMVQFr1zqI+MDg87pk
         IRzBTnNb8MWcPTFmJs57iT9Rl/N8gglqr4Z9VGZbC2RHCWFFO3moGCNrxqeTqUaUO4BX
         r2wYzDy4lhffOHi1kE63ojn/KUr+quvPqSllxJwvSRgXbQu/axh5103k+uSKT8dgADQC
         VHtn13i6ITM1Ea2IX7gP82Z+WJGNLMGrnePZKB5UbKJJiRmn7fOFEUB6j1sKaWJyHHU4
         zyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ybOCW8P6F/Yqf3OcdlmcI2ZZHw0MxYTzS9UF7EPTtBM=;
        b=xd0I4G5LZoGbPppvxhh7N+pp1uFj5fJdWG/TwGEmdcke8azGEgvII1z/R8HHglO4A8
         kt2LugdaofCftV6mn59uIiZh/vOfLQeJr2Q93J2RzVYzq5XNG3QLJ9cu6oJonbmcUYUf
         hnghGFRcG9FVwtxrcQGK1j4jL/nYrbLK+IOGwxRxyM4ehtuoDOqmBXxIjdJBNAE3Aupr
         2zp+lRMYr0jC+NsmwgU5dq4lxMuzZSWKZ98zq4jcWmI4DwG71Efcx/cV07GfHCYgkEWA
         cY8i5DxIWtHOhgB5PeECX99D2bWzw51AOP7g1+azX15FLUXPpX/LlYfPl/bEZf7hlOPy
         +edA==
X-Gm-Message-State: AOAM532rZ55qZDwbWqvL09Ic/TVXCzDHuU1Jov+71hVvQTPypsc4/qoh
        NGy71UbFbe5qc5iG2RbHoJlD1bI2oYUy+pCBOFe0pg==
X-Google-Smtp-Source: ABdhPJxkvNjRuoL+Lj/lnccTuQ2bqggqJgGo4JwvgmG4ulBfpJ+ratu0xQvq87xq+NQGG92+Whix1JYY50BF8PoeT1U=
X-Received: by 2002:a02:c89a:0:b0:321:25b2:4b52 with SMTP id
 m26-20020a02c89a000000b0032125b24b52mr355244jao.218.1649092739881; Mon, 04
 Apr 2022 10:18:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220329171818.GD1314726@merlins.org> <dffec23f-bef1-30e2-83fc-b3fb9bb5f21e@gmail.com>
 <20220330143944.GE14158@merlins.org> <20220331171927.GL1314726@merlins.org>
 <Ykoux6Oczf6+hmGg@localhost.localdomain> <20220404010101.GQ1314726@merlins.org>
 <20220404150858.GS1314726@merlins.org>
In-Reply-To: <20220404150858.GS1314726@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Mon, 4 Apr 2022 13:18:48 -0400
Message-ID: <CAEzrpqc1yvK+v5MSiCxPRxX2c27xPsO5POMPJ8OuQaN4u1y2wA@mail.gmail.com>
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

On Mon, Apr 4, 2022 at 11:09 AM Marc MERLIN <marc@merlins.org> wrote:
>
> On Sun, Apr 03, 2022 at 06:01:01PM -0700, Marc MERLIN wrote:
> > gargamel:~# btrfs rescue chunk-recover /dev/mapper/dshelf1a
> > Scanning: 1509736448 in dev0
> >
> > I'll let this run, looks like it might take a while.
>
> 14h later, still going on. I'll update when it's done, it may take a few
> days.
> gargamel:~# btrfs rescue chunk-recover /dev/mapper/dshelf1a
> Scanning: 7049296592896 in dev0
>
> Please let me know about the backup chunk roots that all seemed to be
> the same and were apparently all pointing to the same corrupted version?

Ok cool apparently we have code that does this already, can you do

btrfs-find-root -o 3 /dev/whatever

and then use the bytenr's it finds like you did with the backup roots

btrfs check --chunk-bytenr <bytenr> /dev/whatever

and see if one of them works.  You can do this without stopping the
chunk recovery if you want to let that keep going.  Thanks,

Josef
