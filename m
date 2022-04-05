Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9CC14F219A
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Apr 2022 06:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbiDEC75 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Apr 2022 22:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiDEC7u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Apr 2022 22:59:50 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9AA89084
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Apr 2022 19:11:14 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id q142so8068801pgq.9
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Apr 2022 19:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TL391wwsu9r3FpU5uXWNIAo+U3x2rQXObFxvQiYUGx8=;
        b=5jniA1knIy9UAafTGpBXVYjwoqQZCokX8vYdwEEt73gBujm0HiW6n2W3SEJlBWQOw6
         Xqw2fnT7TO/N/V2jLGfrboM5t0xolJEtMBABU8x5TgoMlvAF1exQfL3RIs2GRTJQFSYw
         50MT3QcXxelhw8cwTYK0pr48z+9fBu1tF7EzRLWmvGCZ9chvz4UeT0nO5r7Y0glS5XJN
         1SfFfz3/kg5l73YMdvsWz7fqKqgHbT3kPzHbiWhaqebrBQ4SsWyGZSQbjA6LzW2+HL6L
         XZ0W/gjrnsPWKoUMn7WEHKU9Mh9vE5R0w4MfM56S0t5R/r2yJPtvNrTj208T0WDY4JWs
         S0vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TL391wwsu9r3FpU5uXWNIAo+U3x2rQXObFxvQiYUGx8=;
        b=DEDRG43+Okd/cXY8yMzTtOIR3tacFDko2ZgwNIqFWztPFQ31JZcQJIeMZCRy51Jeh8
         JY9fHixFEFzbbgN3wI1blQ3GuO5U4rKhXKeiNA3xYpGtBsCyq/WVwsCIRa4eoLFqICCe
         r5WdUkbms6kbOlRBCh89JqrP3H+/p4BGLJ46t00fi98XbvVVjvvPmJ9+PvVUdlwMdtM1
         cMOQldEsovi+4A6yZWkHO8orDwcT1z5W9hV06znElA6FRckASwFDgjD6r0XIDeLCaAtG
         IYOdqyalDHZtTlwKIJZMix1lWQE95Ac/+346KIqRlwFkvSgumk+uzYnFkLx1jDwRCMdE
         +oOQ==
X-Gm-Message-State: AOAM530KvAiqpNd00Q6TDTFvgPld9I5eEBrS51jlZLE0RCDrjR0Em2Fy
        qCpltlepLQ7Rj7+3XVENduUxvd61q/Yn7a/x2EvwD6dk6BM=
X-Google-Smtp-Source: ABdhPJyBdF6q1kqXe0ajJc3Zjg+FNnUT85lSRVPHpSZLM36e/3+6Ntp5XqjjmhemPjbre2n4ogXn8NfKOeue/Qxc8J8=
X-Received: by 2002:a6b:ea07:0:b0:649:f07e:9c73 with SMTP id
 m7-20020a6bea07000000b00649f07e9c73mr463343ioc.10.1649117756192; Mon, 04 Apr
 2022 17:15:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220404212951.GG14158@merlins.org> <CAEzrpqemPHLN4gp5TdLQDGkUZSOkRFHHFiHEraZDNSTDjCh4=Q@mail.gmail.com>
 <20220404220935.GH14158@merlins.org> <CAEzrpqefSVVYOf7oj4gqdvBou7vo58x7u4+G=vwCrnky9t3BZQ@mail.gmail.com>
 <20220404224503.GA11442@merlins.org> <CAEzrpqfJ7-GQHZicxpn2x3D=aOY=tnKkt9XiPJ8O+_VZAgK7wg@mail.gmail.com>
 <20220404231838.GA1314726@merlins.org> <CAEzrpqd2kVY=mpttaP3+YJJ_1t1Z3crfXAdF-69pMU10aVe5OA@mail.gmail.com>
 <20220404234213.GA5566@merlins.org> <CAEzrpqft7WzRB+6+=_tTXYU4geBB_38navF1opr6cd9PXiWUGg@mail.gmail.com>
 <20220405001325.GB5566@merlins.org>
In-Reply-To: <20220405001325.GB5566@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Mon, 4 Apr 2022 20:15:45 -0400
Message-ID: <CAEzrpqcb2jHehpnrjxtNJ4KWW3M5pvJThUNGFZw78=MBNdTG5g@mail.gmail.com>
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

On Mon, Apr 4, 2022 at 8:13 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Mon, Apr 04, 2022 at 08:08:53PM -0400, Josef Bacik wrote:
> > Fuck it, I'll just comment it out.  Try it again please.  Thanks,
>
> same output :-/
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs inspect-internal dump-tree -t ROOT /dev/mapper/dshelf1a
> btrfs-progs v5.16.2
> parent transid verify failed on 22216704 wanted 1600938 found 1602177
> parent transid verify failed on 22216704 wanted 1600938 found 1602177
> parent transid verify failed on 22216704 wanted 1600938 found 1602177
> Ignoring transid failure
> parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
> parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
> parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
> Ignoring transid failure
> parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
> Ignoring transid failure
> parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
> Ignoring transid failure
> parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
> Ignoring transid failure
> Couldn't find the last root for 4
> Couldn't setup device tree
> ERROR: unable to open /dev/mapper/dshelf1a
> gargamel:/var/local/src/btrfs-progs-josefbacik# git log | head -12
> commit 25024ece18db0a9ef554892098125f2ac5e27f97
> Author: Josef Bacik <josef@toxicpanda.com>
> Date:   Mon Apr 4 20:08:05 2022 -0400
> mel:/var/local/src/btrfs-progs-josefbacik# l btrfs
> -rwxr-xr-x 1 root staff 6216888 Apr  4 17:11 btrfs
>

Hmm I wonder if the dependencies aren't done right, can you

make clean
make

then rerun?  Thanks,

Josef
