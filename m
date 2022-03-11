Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449224D665C
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Mar 2022 17:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245547AbiCKQdK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Mar 2022 11:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350376AbiCKQdA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Mar 2022 11:33:00 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA661AD976
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 08:31:55 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id s35-20020a0568302aa300b005b2463a41faso6604996otu.10
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 08:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q57rkvikBqx4CLoYj4whrcCtAWG2JhY8lVms0ERFhDU=;
        b=ilhhJ4/NNY0qy3gmIno7uApoW6AhBFuoRWCWOKhWHFnPUkhXtrJorLwSAALFY/dM9K
         /XSdxNTFmrdTOrNW8PJYw1Ry4Zp8ZHOEdfLfadN5FCY3hpIsLpDnV0DyZCVW/KFRNB1j
         5M4A4Fnmkzf6l7wPJW2RUvKlLZTZ/OYT5Nlbj4rwYyY5FxpdjZyPGIJzcRlqzwYy8Uwb
         I6OpBlsKs2Puzlb7Wx0I87TTmx1CDYP3S2dOX731xloK6c6unDWbYa5ZMFpdopuxPcJP
         CFn3+WG+qQBhnnO0nUG0We7v3EVodfDnyveH4lcFqQAQlgrJso3OAehNCxdY/V7G9FXq
         EsqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q57rkvikBqx4CLoYj4whrcCtAWG2JhY8lVms0ERFhDU=;
        b=TgbUTw2vGp9qxfQt0R6UCNbGNPDb9q0TUCR09Ek8yBR2NNXfUXJ46S6iPsyKKqPf88
         InBC9SvV1xLB6lEUEYmOa5fXHA4bABP/vzMH6BJx7AYqWXk1GqkjeP8HzBAfwFHCL3TJ
         kKOZvb5fuachT4XH8iMHO7tm6w7Gd/vR0jfgfhB2sGzfxk4asNejj16Nuf5Wtw4/IzGd
         AFKoFFiua2899aNcLSSBYeBsVSY61urf/6tpyffBZDSibmQ/7BG6QbfY2oQAHZxGeL/9
         unXdgX5gwHXJLHe9iC6sZkGcEwIJMLUfR4EEDQxOJwiFGu9zTumFLXUlhDyIWHqxrX6+
         hTwA==
X-Gm-Message-State: AOAM5303vOJv4soAFbFAhjjcutcaHp5MaQxDSJbIonAMsKwuAAmN5MKh
        c5TKmh5gPZmvxLI8+SeYpf+ilnNImwZ5MSyjhSIyEbNNxjo=
X-Google-Smtp-Source: ABdhPJyFBBwK48a3PnJSF3Q8DVMM5gySEJ4cUfl3qROcreMttPy/HvBtXcW3PEvRrnJYDj9ZviCjQ6uCVXSzBDKEmLY=
X-Received: by 2002:a05:6830:11d6:b0:5b2:5a37:3cc7 with SMTP id
 v22-20020a05683011d600b005b25a373cc7mr5124282otq.381.1647016315052; Fri, 11
 Mar 2022 08:31:55 -0800 (PST)
MIME-Version: 1.0
References: <CAODFU0rZEy064KkSK1juHA6=r2zC4=Go8Me2V2DqHWb-AirL-Q@mail.gmail.com>
 <455d2012-aeaf-42c5-fadb-a5dc67beff35@gmx.com> <CAODFU0q56n3UxNyZJYsw2zK0CQ543Fm7fxD6_4ZSfgqPynFU7g@mail.gmail.com>
 <e5bb2e23-2101-dcc3-695e-f3a0f5a4aba7@gmx.com> <3c668ffe-edb0-bbbb-cfe0-e307bad79b1a@gmx.com>
 <CAODFU0pcT73bXwkXOpjQMvG0tYO73mLdeG2i4foxr6kHorh1jQ@mail.gmail.com>
 <70bc749c-4b85-f7e6-b5fd-23eb573aab70@gmx.com> <CAODFU0q7TxxHP6yndndnVtE+62asnbOQmfD_1KjRrG0uJqiqgg@mail.gmail.com>
 <a3d8c748-0ac7-4437-57b7-99735f1ffd2b@gmx.com> <CAODFU0rK7886qv4JBFuCYqaNh9yh_H-8Y+=_gPRbLSCLUfbE1Q@mail.gmail.com>
 <7fc9f5b4-ddb6-bd3b-bb02-2bd4af703e3b@gmx.com> <CAODFU0oj3y3MiGH0t-QbDKBk5+LfrVoHDkomYjWLWv509uA8Hg@mail.gmail.com>
 <078f9f05-3f8f-eef1-8b0b-7d2a26bf1f97@gmx.com> <CAODFU0q+F2Za=pUVsi1uz9CLi4gs-k1hAAndYmVopgmF9673gw@mail.gmail.com>
In-Reply-To: <CAODFU0q+F2Za=pUVsi1uz9CLi4gs-k1hAAndYmVopgmF9673gw@mail.gmail.com>
From:   Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Date:   Fri, 11 Mar 2022 17:31:19 +0100
Message-ID: <CAODFU0pxmTShj7OrgGH+-_YuObhwoLBrgwVvx-v+WbFerHM01A@mail.gmail.com>
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

On Fri, Mar 11, 2022 at 6:04 AM Jan Ziak <0xe2.0x9a.0x9b@gmail.com> wrote:
>
> On Fri, Mar 11, 2022 at 3:59 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> > A few outliners can also be fixed by a upcoming patch:
> > https://patchwork.kernel.org/project/linux-btrfs/patch/d1ce90f37777987732b8ccf0edbfc961cd5c8873.1646912061.git.wqu@suse.com/
> >
> > But please note that, the extra patch won't bring a bigger impact as the
> > previous one, it's mostly a small optimization.
>
> I will apply and test the patch and report results.

$ uptime
10h54m

CPU time of pid 297: 1h48m

$ cat /proc/297/io  (pid 297 is btrfs-cleaner)
read_bytes: 4_433_081_716_736
write_bytes: 788_509_859_840

file.sqlite, before 10h54m: 1827586 extents

file.sqlite, after 10h54m: 1876144 extents

Summary: File fragmentation increased by 48558 extents despite the
fact that btrfs-cleaner read 4.4 TB, wrote 788 GB and consumed 1h48m
of CPU time.

If it helps, I can send you the complete list of all the 1.8 million
extents. I am not sure how long it might take to obtain such a list.

-Jan
