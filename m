Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB652567597
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Jul 2022 19:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbiGER1H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jul 2022 13:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiGER1G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Jul 2022 13:27:06 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887CF20181
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 10:27:05 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id l11so23012227ybu.13
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Jul 2022 10:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=wbcDWuQS0HJSI1jG4VNQL//RrS/H+/hSyRrJhFHvYCA=;
        b=Z8MiCbeu2X22eP1FHWVDFACm628BBcCSU8Zm6u0zGIfOwqCdBmJGC+bV7sxiVRF0wI
         Wn6uShqRle5G569mwJ36FEFCG1OAgLgE9a1/Oxse0q6VbyV+BQ3h3F5OVJaNiKqBG8ZQ
         C24g+R9yRNdYzjjgXotZJuf0z5Hor/JWOAsLBRSY/baR/2//fB4a29+MYSCnJzp5Wu3H
         kgLKyLTe2pqHDWMtBHkFcqFAkcnnJh3J0Woz2lPcigLCTeA8TOIjPNGv4/xur1Qi6UKO
         arRiWAkmJF+OpNwS4wUn47axlUPjnQCp+Y7BvkYI+xh4wIVZ7XZcLL+7JimvY7/aSu72
         I0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=wbcDWuQS0HJSI1jG4VNQL//RrS/H+/hSyRrJhFHvYCA=;
        b=YHNBD2Ru6FDrfc54c93hkQ4fGPQ4CFbtJmU5JmsxhxeNt+diSmq+3y5/hdueqyfLEO
         A8v6xGjjPg0MT004bhyiCAhl32IPTwU/3Cvzhr/y0cib0Rr1yuSBSDx8bp848ANjqSf4
         Py6yWczBo/M9hyxvRt84JNRMTdo3lChk2PihIzykW3CCvkKQB1naq5MwHl516Twz2KwK
         c1OkR7++sFG7/mFJVWBxpcX7Zt8rVc+fOeSztEFv/qG4/2i41mqRoMddYUgde4EYVFD/
         EtpjiSvnAnMA31htUMIPJuXNtrdqOtt+kwwKahAyIOfcpgLeLZLfjFecA8YAX/BMVN3d
         BBhQ==
X-Gm-Message-State: AJIora9zegoi0p3V1YW0XKdHXahNF0ta7e0v/GU7T/wBctK6P7vcL7ch
        ZfXmav1KYkMVIMIr+fhhLjmKcunEzumAkkEQ2fA=
X-Google-Smtp-Source: AGRyM1ui+4S0YGZYQrU5MTyTAK95TspenHrT0sOfoy3Uu3T8ZEFKnBBH/4lSYRsi+RqCiIzx6/q208/1K4R5KXRLFhg=
X-Received: by 2002:a25:b6cc:0:b0:66e:68a9:a006 with SMTP id
 f12-20020a25b6cc000000b0066e68a9a006mr7759612ybm.249.1657042024741; Tue, 05
 Jul 2022 10:27:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7108:78d5:0:0:0:0 with HTTP; Tue, 5 Jul 2022 10:27:04
 -0700 (PDT)
Reply-To: kl145177@gmail.com
From:   Ken Lawson <jameslukan18@gmail.com>
Date:   Tue, 5 Jul 2022 17:27:04 +0000
Message-ID: <CAGaH9f+h7cPQ4NBe6JaiwakcMn9JHQArt1c6hkr5yVJYL7ENiA@mail.gmail.com>
Subject: Did you receive the email I sent for you yesterday morning
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Best regards,
L. Ken
