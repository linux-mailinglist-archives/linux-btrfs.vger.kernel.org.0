Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF664D3E96
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Mar 2022 02:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239089AbiCJBMf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 20:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiCJBMe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 20:12:34 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB20D1216A7
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 17:11:34 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id w127so4443765oig.10
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Mar 2022 17:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KREBG59omfMbxXzfo37uU2qOsjLw8zEgZF9qPbqUQXo=;
        b=QulTXX57pID/aTRfGd0xSVcaew4SaMqHmy2F7m/Pc1yuuMFfeSpwNg/KXTRTV3m+n0
         qNSBXDKUgx4VtkS1fIlmKv0ZQkVnfJ6tv4YQHd5CsaApbjiTdEw/EURsVgrcMmCtOemz
         vJLsd4nZ0u/pNVKeFzO0qltI7sEeYC5jJBulObG/7+K67wb5kS0mygWp+9uYDjcn/DPN
         HGu/BpI6E43Xa+ZD4f0iq0znE2GJsETGQ3A6idhAUt1uFqBBZQEJTDiEl40LAdzj15HB
         z7YRZ9fivRkeNJfpb3T9D+B7Y3CTYiew2Oyrq5IOY1RscJGSJ0CuhLDi42IAJ1tfJ4y/
         udAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KREBG59omfMbxXzfo37uU2qOsjLw8zEgZF9qPbqUQXo=;
        b=qDHiUE0lPSVmehks0VKc9PDHOeiV2Aoj3lLnRD2LHTZVIpzuGsUZ02ywAelPxs0TmV
         GKavN293/tiJZdbQasHfb1IC4aG+Yu9CbLYBRZS4YAZ6v3MCpbrHOojW0ot7XMbUFSRg
         Y1aSPuIk6NnSimnIRGezRyLV2wSk234yb4ZSwCM1gNQ6VieqlbOFVUhM8FlFb2gyQRAk
         0L88oEt8ZGbmImFRz9kWaax1VbwO7N4xxYTpD1gjyNdiS7kEEkAFtXG3bKdJ3/yciflL
         KobGknUd8k5RpASa59Bex2XhRK6WTYwmtyYAUWtZMOVEtKEW+RBatq/iO0g3m9HIPyNq
         kSow==
X-Gm-Message-State: AOAM531HMPSsHECVq4SuLlSxnhRg92eGbZ1A0Inw9awP+EQt3xmPrNlY
        8LH37BT4C/t0jyQc4qvGLvBQUQ06g9PXQWE+JaJH5UmjYJw=
X-Google-Smtp-Source: ABdhPJxTfFumOJZMydXpKOQBZGI64zUYxGmr9ss724VXCRihlXu1s/EfSAmTz63k+OTnu2Qdrg5yKr03SF31MIWHpoo=
X-Received: by 2002:a05:6808:14cf:b0:2d9:dcc6:8792 with SMTP id
 f15-20020a05680814cf00b002d9dcc68792mr8031797oiw.219.1646874694236; Wed, 09
 Mar 2022 17:11:34 -0800 (PST)
MIME-Version: 1.0
References: <CAODFU0rZEy064KkSK1juHA6=r2zC4=Go8Me2V2DqHWb-AirL-Q@mail.gmail.com>
 <455d2012-aeaf-42c5-fadb-a5dc67beff35@gmx.com> <CAODFU0q56n3UxNyZJYsw2zK0CQ543Fm7fxD6_4ZSfgqPynFU7g@mail.gmail.com>
 <e5bb2e23-2101-dcc3-695e-f3a0f5a4aba7@gmx.com> <3c668ffe-edb0-bbbb-cfe0-e307bad79b1a@gmx.com>
In-Reply-To: <3c668ffe-edb0-bbbb-cfe0-e307bad79b1a@gmx.com>
From:   Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Date:   Thu, 10 Mar 2022 02:10:58 +0100
Message-ID: <CAODFU0pcT73bXwkXOpjQMvG0tYO73mLdeG2i4foxr6kHorh1jQ@mail.gmail.com>
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
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

> Or use the attached diff which I manually backported for v5.16.12.

I applied the patch to 5.16.12. It takes about 35 minutes after "mount
/ -o remount,autodefrag" for btrfs autodefrag to start writing about
200 MB/s to the NVMe drive.

$ trace-cmd record -e btrfs:defrag_*

The size of the resulting trace.dat file is 4 GB.

Please send me some instructions describing how to extract data
relevant to the btrfs-autodefrag issue from the trace.dat file. I
suppose you don't want the whole trace.dat file. Compressed
trace.dat.zstd has size 324 MB.

-Jan
