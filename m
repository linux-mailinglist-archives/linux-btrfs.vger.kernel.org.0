Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA427AD8F5
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Sep 2023 15:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjIYNWf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Sep 2023 09:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjIYNWd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Sep 2023 09:22:33 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A37107
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Sep 2023 06:22:27 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3231df68584so2599938f8f.1
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Sep 2023 06:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695648145; x=1696252945; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Qkk3xQ3JnuN3bdbe8yXcpoP9Gcopd+aQpLFddZBWRVQ=;
        b=FxzDcfOUwMh7XQDo2LellOYq8o1HYsIa4Oyf8zknnIsj5UZrq5AyIDYexndctCnX88
         e/BsE1X4KuJnGvANw56iHRiOg/umHQbqBQ4XJfarA9INNBIJ2fQkYuEqJ2SKExtSvhu+
         lPuhkAroQjRT3dVAvGX8lUhMZ0A5XEPV69AahT5Pr8V3JGGp1CYi7RDl+VYKftYmwUbH
         hmzXC2ZsTwVH/jOfu+Ai+WN/AaDBAhg8CYuM+zhycD4AGSVzftRshqKS2DCg7sBZPoLj
         95QbqbbSDThkBGAiodfJEMBIjgj1W2zImY3x1vCsCSh+KnFMnI2rfdj4awmBp4zTN5EI
         8qjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695648145; x=1696252945;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qkk3xQ3JnuN3bdbe8yXcpoP9Gcopd+aQpLFddZBWRVQ=;
        b=oW42/EZG9wYs2eVLDZ1JEkpyggQMAKfLoeBr0HzadqI0Vd4LBmizT1J6f9+lqiE1cF
         m929RZvZL/pmIsnhV+KRGFcsFIapHupUk1QgIBKVSVJ1TxqC99//goIgw7ZipKltwR1s
         /qXN1LO/FwQQSOE84R8RRnLg65CUG5NYrSZIJ3/ytjNARG8gckyUY0Xq1UIX5t7Yip0g
         RhBFWeOxQO65qTmIH4RnbYVG+ity2BdBgaEXyaG/y/UXln7jokp0kqK1STUpMvaEpJ4o
         dYg0n8rxnwlL/Vr3x7tfoIX8kKpayeHkowZez2W06ty0cwx6jKtMBOFAoyD1CPgMDf0O
         1aCw==
X-Gm-Message-State: AOJu0Ywwt+rgGgq3hnVvOP6jxyjfg5LLcFkNgWA5nwwIqCbBqSBSCV97
        O7sNGmIH6KCoXvL+0xU8/7cT6HINyjwpXahdXxJ0ag2Ssi4=
X-Google-Smtp-Source: AGHT+IFEFwggHRugicYdO/pBFdGmFqWJNLVKC6O9razLJEWD2OksTvJ2WJLOk/+adYpFS63E2B3PXO1JqNMEMSIflR8=
X-Received: by 2002:a5d:46d0:0:b0:321:6e68:ec3b with SMTP id
 g16-20020a5d46d0000000b003216e68ec3bmr5993597wrs.49.1695648144943; Mon, 25
 Sep 2023 06:22:24 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Richards <paul.richards@gmail.com>
Date:   Mon, 25 Sep 2023 14:22:13 +0100
Message-ID: <CAMosweitbAN5EPOgJCtrbkRAj1QSbsYt4uDGVMZ378YY7wjnRw@mail.gmail.com>
Subject: Supporting fallocate collapse and insert range
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,
I would like for btrfs to support fallocate's FALLOC_FL_COLLAPSE_RANGE
and FALLOC_FL_INSERT_RANGE flags.  Currently btrfs supports neither.
I have searched the btrfs mailing list archives, and there was a patch
from 2014 to support FALLOC_FL_COLLAPSE_RANGE but from what I can see
this didn't get as far as being merged:

https://lore.kernel.org/linux-btrfs/1403519147-19520-1-git-send-email-fdmanana@gmail.com/

I would like to ask:
1. Is there an issue tracker where feature requests like this should be posted?
2. I am a software engineer with knowledge of C, but not the linux
kernel specifically.  Is there anyone willing to offer guidance if I
were to try and implement this myself?

Thanks,

-- 
Paul Richards
