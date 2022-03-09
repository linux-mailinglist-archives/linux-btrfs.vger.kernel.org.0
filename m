Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11564D3D55
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 23:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234816AbiCIW5V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 17:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbiCIW5U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 17:57:20 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57EFB10A4
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 14:56:20 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id j83so4204266oih.6
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Mar 2022 14:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LuKzglXRj86gIhDoFW32VdixIBUzyfO4xuq5z3ecYjI=;
        b=PgG8TYEK5+ctQAQKalqomUbB2Vk8wwbcQEiBISepFWVpokcnEJpXymhuVPOHWPH84i
         PLaDi2AZHx3iGwPB1mSZpV2v6M8uxlElpFcU+vcnzBRdwFO9iWsUOXN4W2nv4j47meNG
         cZSOeLiN+7n1UNUBC1eeTotB5A8+5K1GPr+CgSeRfMaq0H93brRNSZSmGqjR2OyEEyem
         qSRzNS8P0rCwaYkONY+d8qR/oC18kxdeS65vVeW+4+m0Jf+1Imsy26Z4uhw1/0skdjDN
         Bb26N+1riT52+uPBzXh2Np0IYSLsYTmIEcsetX/nHQC/7D+qztXewuyAFnWmF04Yv+/M
         2eUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LuKzglXRj86gIhDoFW32VdixIBUzyfO4xuq5z3ecYjI=;
        b=UYOC17ZAvlVL8L/+r4t0PPLJM9K4L4Mdg9NUPupsa8tVMRQJiU59BM8HRCZopnKYlj
         ZpZOOQF15muOsm3hWEWWgYe2QAYa8jFHYOpKgd/T3P18aEbJhgs6IIpsDtDET+PF8zvS
         72JY2JJRREX3tsVLR1kqE57BXiNsSCdaxIS6jWrho+2mynwuM5GpLdPfCjNY/mbANZQn
         FifrNQ2J/0qgw6GAzh2M4zrxm9iN6pdcDjs8OV6XXQbYqydFva7aEl6jfC2+29F6eEjq
         mbFnA4140T2gf2Ri26M1s1f+lNEJYqDwPmWqK0yaNlrlmQVeJDgASmPYLFcvbYPOqhRk
         YOzQ==
X-Gm-Message-State: AOAM532Lq3sPoIhWM3R9hPQvz8beA7V9stSza4jkXzL7nRwKSpCCtvx5
        NstuvkxJhgY45Spq4edqmefLSgUxiPocuX1vxu68G4sfbHs=
X-Google-Smtp-Source: ABdhPJxhgkfwolerl4kbhYJp8cMffefKSE3+5ww/iFFknhG5amzr294zDKvpibI2a+BvQcJjtJO2RTHYCB03hpmKmgY=
X-Received: by 2002:a05:6808:2117:b0:2da:5906:22c3 with SMTP id
 r23-20020a056808211700b002da590622c3mr723168oiw.80.1646866580295; Wed, 09 Mar
 2022 14:56:20 -0800 (PST)
MIME-Version: 1.0
References: <CAODFU0rZEy064KkSK1juHA6=r2zC4=Go8Me2V2DqHWb-AirL-Q@mail.gmail.com>
 <455d2012-aeaf-42c5-fadb-a5dc67beff35@gmx.com> <CAODFU0q56n3UxNyZJYsw2zK0CQ543Fm7fxD6_4ZSfgqPynFU7g@mail.gmail.com>
 <e5bb2e23-2101-dcc3-695e-f3a0f5a4aba7@gmx.com> <CAODFU0pEd+QTJqio6ff5nsA_c--iCLGm52t0z6YBgzJcWPxy9g@mail.gmail.com>
 <3f286144-d4c4-13f6-67d9-5928a94611af@gmx.com> <CAODFU0r8QqbuHdH_vG21bPacuMM+dmzMbdSq23TPHxL=R1DbgQ@mail.gmail.com>
 <cc8d21c6-6bda-f296-3f3a-09b10582fde3@gmx.com>
In-Reply-To: <cc8d21c6-6bda-f296-3f3a-09b10582fde3@gmx.com>
From:   Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Date:   Wed, 9 Mar 2022 23:55:44 +0100
Message-ID: <CAODFU0p3=xn9viSQsnhqt=c3AuD_tEzXpxJAuV-sDWN=udrOow@mail.gmail.com>
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

On Wed, Mar 9, 2022 at 11:44 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> > xfs_io -c "fiemap -v 0 40g"
>
> Well, I literally mean 4k, which is ensured to be one extent.

The usefulness of such information would be 4k/40g = 1e-6 = 0.0001%.

-Jan
