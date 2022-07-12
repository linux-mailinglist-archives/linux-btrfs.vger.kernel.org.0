Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1198C5719E8
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Jul 2022 14:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbiGLMZc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Jul 2022 08:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233200AbiGLMZM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Jul 2022 08:25:12 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0BCAA824
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jul 2022 05:24:57 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id n7so7632516ioo.7
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jul 2022 05:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=VlsEmllhnRayw2tgxIpHosIpeVc1uFRI3UUMGWk8xSs=;
        b=nEqOdfYLImVg/MPnnhW2ukicZdqEWzIZY76KyQZsxGTC3Mp6axlt21z+gbmButnCAT
         f57laC8oq60/8G1xnnProbDQWAaU9E/61W8p5ASmKyLyHswv/3EoT/YhL1lS7SS90fT4
         ipbjwP/78S3oGFpz6ypbBB9D/6IXelwoHB/Ef5BXOlpiGfopIPD6f0BeCAkZwMNg244h
         JjXwqRs0pR6M+4Ma+yQznuCV8g1ClzD3FBlOdz4XQNFuWMKGSnEp63G8IQP1sEV5SqBd
         g7DR6MoTE1ECv1Jzwr/iHBalMh21IbTRaWANt787LskcCILNb8SFpf89LYeWxwmiv4Kg
         PTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=VlsEmllhnRayw2tgxIpHosIpeVc1uFRI3UUMGWk8xSs=;
        b=iZI3DyRMuQmcE2xbGgvvYMyiJJ9MD0rGj9sq5cRrvx3YaRGyUBmZGeyjz52d6ViZGZ
         HEXe5AcO8pEV/2IZ/FD7RcAKO2o3QUevjBhRC7XfnOrIeNLO6SW9XkS0M8Hc+WW4/AAD
         pqYsT2+yodOHCDi00/JRa0Q1A52Tsg1OVn3xkxJ2HNkGhJVk6jVeJ4gaouqKgLrWbIy3
         owz75ZlwOMT8eoCCerDi8fVvnZm/QI/9nVWR6PE6jRGEIj1uex05OS658L3VAW+naGY6
         bj07SWNVVcMIqwzyTakffFyPtuFCv5tKw+7Rba3EW5HyyWxNYtTV9LWPCnqVWo2hPG1F
         exFg==
X-Gm-Message-State: AJIora8u5ILzTJGYAhCaASiFEWa/QhcLSnvLrWZA9Qv5d5WmZHXUaV3r
        gxwpxG5LCPlgtfGvcdwYhS8o2bnOTfS0I8GTJ3CwIFcWoew=
X-Google-Smtp-Source: AGRyM1tcM0SV2hXKalpl0pFKeSdIa95c6CJtZsRh+hs9Y1IvNRW+qDt5OYq4uIkewsFBZiggQqrSrBSR6RV2v7hYFQo=
X-Received: by 2002:a05:6638:2404:b0:33f:7105:ed23 with SMTP id
 z4-20020a056638240400b0033f7105ed23mr1587776jat.50.1657628696779; Tue, 12 Jul
 2022 05:24:56 -0700 (PDT)
MIME-Version: 1.0
From:   Peter Allebone <allebone@gmail.com>
Date:   Tue, 12 Jul 2022 08:24:41 -0400
Message-ID: <CAGSM=J8K7_GfaqL3-7obOSytNhtoqmJ1GQrOKAUgE2dF7OehTg@mail.gmail.com>
Subject: BIG_METADATA - dont understand fix or implications
To:     linux-btrfs@vger.kernel.org
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

Hi there,

Apologies in advance, I dont understand how I am affected by this issue here:

https://lore.kernel.org/linux-btrfs/20220623142641.GQ20633@twin.jikos.cz/

I have a problem where if I run "sudo btrfs inspect-internal
dump-super /dev/sdbx" on some disks it  shows the BIG_METADATA flag
and some disks it does not. I posted about it here on reddit:

https://www.reddit.com/r/btrfs/comments/vo8run/why_does_the_inspectinternal_command_not_show_big/

My concern is what effect does this have and how do I fix it, once the
patch makes its way down to me. Is there any concern with data on that
disk changing in an unexpected way?

Many thanks for any insight you can shed. I did read the thread but
was not able to easily follow or understand what was implied or what
would happen to someone affected by the issue.

Thank you again in advance. Sorry for emailing in. Hope that is ok. I
was just concerned.

Kind regards
Peter
