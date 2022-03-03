Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8CC4CBCC2
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Mar 2022 12:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiCCLfi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Mar 2022 06:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbiCCLfV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Mar 2022 06:35:21 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564258D69B
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Mar 2022 03:33:04 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id gm1so3836830qvb.7
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Mar 2022 03:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=k6NYZQl2rxZhVB/aKDQvMsV5vW2gUENZyGD3qWaMtBI=;
        b=nhz2/wus2Sza9akBJWP66OUL/N6BHq+rLY7aHQ1cBP5KjyECnDO7jeU6/cBka01qqh
         z3GIx8RQN2NVpDos4I9uK34WNRxu2exygHz4fMMxTfppfRbmmyDNC/zBeDolhSJI+IRO
         uViwT/YMQAmE1QfiVvqzRibtiFzHSGdF5IOctJaNhBwg6mH1y3ceY5I3ysRwKhG3VN2q
         hRZYgOJxPJBl7Bz5lwVFTeIVApx/ZHt482Eg2kUQVPllboz9K+p+41GozO7O7DbUERwR
         5WpgzoXSai6p+HP1hdUanIIovpTMH7vKsjzRY7IiaWYkM0gPDmfpCwkbOGackgDYz39M
         dWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=k6NYZQl2rxZhVB/aKDQvMsV5vW2gUENZyGD3qWaMtBI=;
        b=mt/ebNHqvI1nWB0dOLm20eTCd2kJ/wf/zZH0MtHLXwg6Aya0Qvs7flk/piQK9xBmtf
         CoP6u5fexmqz95+XMYCApqPPqciU5u5MzviyPLuc8UUHLWBLxgsiuZ5YLb4bkEu2KRXF
         b7c6rtN+hJk/+a6lxCu4yz4RGpJ1O1pmLmdQckqy9HTCH/ztEahBE+Bmx9TdNt2dIl7n
         +qk0pGXRH3CP5cHIimnwCMYbUaM1bYMkEqpAJ/RYPIc/FTeIB6mXgS/6VU3lJ/dhaUgI
         jX0wNg98Sd6/hU7Q62nQNs85rwaQwxT9pQkmZ2HeSfDblQS6uH4UXaOpZSatL8Kpo5Y3
         mQMA==
X-Gm-Message-State: AOAM533ZhqrPV+0Jh+5bCAIyDyHfS+g1PhWsgQ13ULjShCzhSLYYTdSZ
        E2ZDbvrsZFMiFj80Yw7FurjJhwz5yLMEZIZfJLI=
X-Google-Smtp-Source: ABdhPJz4mO96kpQRwuvRgHWMcfiLEFywiDmtCx/gvsD0X3AOTUNhXp3Da8YScgT58kfqqF7SxcmMW9dt9RLWLFiZaew=
X-Received: by 2002:a0c:f285:0:b0:435:1021:b6a1 with SMTP id
 k5-20020a0cf285000000b004351021b6a1mr7881827qvl.70.1646307183538; Thu, 03 Mar
 2022 03:33:03 -0800 (PST)
MIME-Version: 1.0
Sender: edithbrown3342@gmail.com
Received: by 2002:ac8:7d85:0:0:0:0:0 with HTTP; Thu, 3 Mar 2022 03:33:03 -0800 (PST)
From:   Rose Funk Williams <rosefunkwilliams02577@gmail.com>
Date:   Thu, 3 Mar 2022 12:33:03 +0100
X-Google-Sender-Auth: ZFMUE9aWSC3JyP5kUo5uRnxvw9Q
Message-ID: <CADagySKf=VH_xF68aUiQ-Mo4EOGDDwQ-8LKQ-wZPC1apyK6v7Q@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

-- 
Hello,

My name is Rose Funk Williams, I will be honored if we talk and know
something about ourselves, share pictures and life experiences, I look
forward to your reply, thank you.
