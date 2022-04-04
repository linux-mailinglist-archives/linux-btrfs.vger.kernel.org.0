Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01ADB4F1C2C
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Apr 2022 23:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358870AbiDDVZm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Apr 2022 17:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380704AbiDDVHB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Apr 2022 17:07:01 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8722E08B
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Apr 2022 14:05:04 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e1so3076695ile.2
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Apr 2022 14:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l1UwlPYCuqMGgxPt+1Q3TTmpIr86Qx3a2xY4ZlhU7bk=;
        b=YZ9RrzSU2HPGxajcjNfSMlEsfOJ6JwShwYPE6BFNRG3ZYejQZPf9dToJJGrIh+Ro2b
         b5wU6ZR8FuN7Cuo2X4LkQXYqZdifGPtdcaBDd2K9SEmhcw6MBe3A0d8+Dv9xyQR+/KUI
         nCc6i5G1th7C2RjjLuT07RWm9dT0BUIpdeEWJS6z+pxbgiejGMaw3Bwe2/clK337/NyW
         9ueS5LZbUH2FaKRtN7uQNKszkzyZSZFJmQFsPqh0qfh9tDSNg2oFX5wjmQLPkwY0e39Q
         nmAUei/4rXzekvQ9bKCuGLAuvCm6TDLd2KxO0b72TnhS44IHxqrexAcRq2edlyXVlAL7
         67Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l1UwlPYCuqMGgxPt+1Q3TTmpIr86Qx3a2xY4ZlhU7bk=;
        b=LfLuLTDHXAx6BX3KPM+rATKaoA5/O9ypRabHcsfceT0abwrSQTw8iYIv44VRX7L9XA
         Xuk4C1dxMZJ3e0S8uLdC4I3y1PU3+qYftdlYh1Ej5K+DE7P05JQzYGbkp+3LaSTQdNkz
         Zv421ITKgGBB8AhPyDkGc7YMSv/mom7KnsuST7OO/qUsAMI46Sj2gBikgwIJuv9SYwd7
         qZKByl0GVWdnLwtHKzEZwaV02TRmAVfX6olKVKK3kjo9RvD99UhDqPOVf8Ed65WKFV6t
         2Yh60XuTKhM9UlOOmnKRq3KX7v/rojOfJGhOEOSa2v7gBR2/HRDG+Ul69WYlFaH3ldQl
         qkbg==
X-Gm-Message-State: AOAM533MF8zkq/tJeCi14yO4TwCHLMofWMXzmK6HxMPYKkxx9k2BZTVC
        MgupqvjgxPUVV+ODqB8Djwl9B09A/cUABg8+wIP6Xg==
X-Google-Smtp-Source: ABdhPJyjIqKR4gQ0lyB8aZrzh6+jEBbBsMO3HnXOaqzq0FwNAz+2ruowFk2BMwqZ3kS13sB9OrAbKuAUEg5E9HlIKBc=
X-Received: by 2002:a05:6e02:1889:b0:2ca:2105:78 with SMTP id
 o9-20020a056e02188900b002ca21050078mr95259ilu.6.1649106303439; Mon, 04 Apr
 2022 14:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <Ykoux6Oczf6+hmGg@localhost.localdomain> <20220404010101.GQ1314726@merlins.org>
 <20220404150858.GS1314726@merlins.org> <CAEzrpqc1yvK+v5MSiCxPRxX2c27xPsO5POMPJ8OuQaN4u1y2wA@mail.gmail.com>
 <20220404174357.GT1314726@merlins.org> <CAEzrpqc7P7pxkdSw8eS-nCkn1h5ztQC7C=MewJdmT6Mr5OJX-A@mail.gmail.com>
 <20220404181055.GW1314726@merlins.org> <CAEzrpqfA94nYjV=o_4+XRitopVT-3j7iQMaXAr3FE3Rfm32gkA@mail.gmail.com>
 <20220404190403.GY1314726@merlins.org> <CAEzrpqeMPQvtoov=7Lv5Kx8-cgOmRFFYLbuh0QxZ6psQN3RDeA@mail.gmail.com>
 <20220404203333.GZ1314726@merlins.org>
In-Reply-To: <20220404203333.GZ1314726@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Mon, 4 Apr 2022 17:04:52 -0400
Message-ID: <CAEzrpqdmKwdZxzu7EBhp-PgZW+vqNaUm51SRrKAe64N3pN2rnw@mail.gmail.com>
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

On Mon, Apr 4, 2022 at 4:33 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Mon, Apr 04, 2022 at 03:52:15PM -0400, Josef Bacik wrote:
> > Can you build a recent btrfs-progs from git?  We chucked that error
> > apparently and I can't figure out where it's complaining.  Thanks,
>
> Sure, here's git master
>

Alright we've entered the "Josef throws code at the problem" portion
of the event.

git clone https://github.com/josefbacik/btrfs-progs.git
git checkout for-marc
<build>
re-run fsck

I wonder if the tree root is fucked and that's why it's not finding
the device tree.  Thanks,

Josef
