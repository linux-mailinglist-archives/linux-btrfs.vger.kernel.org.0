Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9F66D705F
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Apr 2023 01:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235997AbjDDXDl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Apr 2023 19:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236620AbjDDXDj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Apr 2023 19:03:39 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6175D4699
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Apr 2023 16:03:32 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id j11so44276928lfg.13
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Apr 2023 16:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680649410;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RTKQ/iSroGJji6OTLa0a4XkLB3hdCJ1Pu3ohkR8aR/0=;
        b=cNLKIA0X3BMo0hH6i3sLmyFxTpT2vnZ/6U0DSqttyroWdOpsv486G3szqYbXvboASe
         5zfYCVXH1DstVBdUFwCaD/W7aL7Z0pQ+Y3gfgo0ARa6SD6c2iL/Ppm5Vc0ahhPspIhHH
         9/EhuKlU/gN1bjZ2Jf2iTUeSqjBoeHlyVQ8Ki9AHVPpumIdXpie1v/ZUHLOgLVM9chCe
         Ucm2stuXnvY0+QfL45xwpkuzEX2ArwV6HeVNM3b78J5k156IlXig6xVMxGDfGf26h3+4
         V+KWslKDEgs9V++gRir4q4PukBzSk3zwdjPvxzR2c2Lm9Bg3Ys5VLoTSu7D4+bR5uyg+
         C/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680649410;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RTKQ/iSroGJji6OTLa0a4XkLB3hdCJ1Pu3ohkR8aR/0=;
        b=Pa/0mdv+R+29IwLIogmNRe8AN9dA82W8EbDo32ytbo/Lww3FX/b1HXsuoGm7gecnAo
         uKk+AXu8DD7tEAVmqxtd5bF+BfwtvxY7YQZpjj2NeJ+qMqIWiWQG/g8sw6Xcn52VQR/N
         zmyZ7sLk9V+sZ7WTpQcgoW3NOGwJMC8L7PDw31HvQl8j2fH5DR6FGIYcTtaDfMl54HlL
         QRYuUqoM64Kbr9XPAVBfN74E2/OP45k2jP8a9150IalCxCkhW3esIIHS0BRQ1xA+60RA
         6DUpXFRyU3ThTzmxk35p4295jdTyASFBD1NsLK1Hj/b4ZFRIeLe0sQQgh+ADxV8CJN49
         9DwA==
X-Gm-Message-State: AAQBX9fjNaG1DwNLiOAQhVgcTnjTI6qi2D1OyD1q2x1G3zQ028q8CKJE
        ml7pQLY9Rs5Or6gzvfz+nmFpLimWzKgVB+0LcSM=
X-Google-Smtp-Source: AKy350aX5xXfOMSdmd10qOURNcjcW4qheS5WEYGXyfqCySt8BVndWlguLPIOBdpc0IZZ8g1WCwi4CtxQEW49N/+yEaE=
X-Received: by 2002:ac2:5688:0:b0:4e9:a3b7:2369 with SMTP id
 8-20020ac25688000000b004e9a3b72369mr1244702lfr.7.1680649410135; Tue, 04 Apr
 2023 16:03:30 -0700 (PDT)
MIME-Version: 1.0
Sender: mrsalicejohnson4@gmail.com
Received: by 2002:a05:6520:11e8:b0:23f:100a:9f37 with HTTP; Tue, 4 Apr 2023
 16:03:29 -0700 (PDT)
From:   Dr Lisa Williams <lw4666555@gmail.com>
Date:   Tue, 4 Apr 2023 16:03:29 -0700
X-Google-Sender-Auth: QiXwv7w0JmI-FUjj0O0APu6byPk
Message-ID: <CAK50m7hVpcCW7qakg3We5Q3ESiJipCdby10YHQYa2aVYB0zB4Q@mail.gmail.com>
Subject: Hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi

My name is Dr. Lisa Williams, from the United States, currently living
in the United Kingdom.

I hope you consider my friend request. I will share some of my photos
and more details about me when I get your reply.

With love
Lisa
