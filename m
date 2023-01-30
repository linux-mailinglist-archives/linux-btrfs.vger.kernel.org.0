Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A862680349
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jan 2023 01:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjA3AXP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Jan 2023 19:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjA3AXO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Jan 2023 19:23:14 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C093B1DBBD
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Jan 2023 16:23:13 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id w11so3025672qtc.3
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Jan 2023 16:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vR/aSgrJHdEUHH393ovuG+gdb9mEVG9SSuRJGcP6Heo=;
        b=f7z1VEWfscIz93hQw2ARicELTJgcMMU7+Kwe141HJmBKOEMFF1/dpn9Ew1Fn6TVToK
         0gGABaHC+rywJW6jSoOCtgwWA30ngg7SwFwX7xMvHMfROb4E7cceG4xZRaMwoHmjd9tU
         ij3FcVj1pUM1O8d5gehPiGT/f8vFpjpe6TcJa/brU+m64do2Hq9k/tZ/s89EU8VZMsA/
         RUWeDX+fqBnoRovp+mj143WPRds2YGfVlt3ECVasxUUY7IyLfTaAkOd/V5SRDKB55lKx
         7BBbSRiaOxgc29LyW8dPjNJS4uVm4y/Y9OC+s18uDbsuuKgk3KbLRhPRFzlkgyE75r5y
         29Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vR/aSgrJHdEUHH393ovuG+gdb9mEVG9SSuRJGcP6Heo=;
        b=xTej2JQAVTYdNfFG7nnffRJE4a+YTSB5LdNGF55iKdvAq6ggACu+AEthTi9LE9fAPQ
         T8W3ceVZjKo8SvWrovVH06KHkyhlKYTwXl1L+BP2cWPSnTx3q/DSicAtPOz2ROrfLgt0
         6nUYSQPHcGto41+oIAupQkZ+WZ8iXFkIPdd6ydVIcqCLMOJoT4soOjnqssaSkx1LRqkg
         QkCtE2EFnRmt7qw8jPdzqIakg5NAfaX9gB1ZR4cUrevnwLADPHxGODGtPy+DY2EZt6oy
         fCyty1S5IXhf9wLiAE/bnCCo/BpUjTPfR2Tz5YFzkW3ntHJBbPPtUWdkK8nRy48/IWHv
         JAbA==
X-Gm-Message-State: AO0yUKWFkJaFMurUnizKdq1i5dxaNRCI5ey0ZeraZNWjGgIK5iPfy1uW
        4tT/4mSRyuwxTcR/TTO+xnXDTLFKAkXYTDEU6PE=
X-Google-Smtp-Source: AK7set/3Qa8861bs2lHMbL2P+yElUmGrAXowynwecrmPd5NUz90nAPeEQLUSo7R0OUxBTjX8fgTZfD0PmmhhIYYRR0o=
X-Received: by 2002:ac8:5f90:0:b0:3b7:fd8a:fe28 with SMTP id
 j16-20020ac85f90000000b003b7fd8afe28mr1054219qta.344.1675038192779; Sun, 29
 Jan 2023 16:23:12 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a0c:e941:0:b0:537:79dd:f11d with HTTP; Sun, 29 Jan 2023
 16:23:12 -0800 (PST)
Reply-To: te463602@gmail.com
From:   "Dr. Rooney Harry" <osane706@gmail.com>
Date:   Sun, 29 Jan 2023 16:23:12 -0800
Message-ID: <CAC7OyrpA_mGgoMY2aMKcFCE9X2ZhaUBYAKTo2ajYSVn7SuMVDQ@mail.gmail.com>
Subject: Very Urgent,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

-- 
Hello,
I tried e-mailing you more than twice but my email bounced back
failure, Note this, soonest you receive this email revert to me before
I deliver the message it's importunate, pressing, crucial. Await your
response.

Best regards
Dr. Rooney Harry
