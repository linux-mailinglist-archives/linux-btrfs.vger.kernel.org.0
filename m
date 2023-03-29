Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A5D6CD001
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Mar 2023 04:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjC2CfL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Mar 2023 22:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjC2CfJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Mar 2023 22:35:09 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431A42D7F
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Mar 2023 19:35:08 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id h8so57519658ede.8
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Mar 2023 19:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680057306; x=1682649306;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=64ihsXE0YL0rC1mVkqNPGDFs/Mq9i5zw8tEyypS7Asg=;
        b=i3Hw18UEf3vkX3gVrKKKF0geFSXdOxdtMs8SdICHd/UiWi9xpuOWyNvt0182XOd5mW
         n7aPKhGjLSut4TzziHOhwMYNgZU6BMS6xqNxteylvM4UhiHDJvq3C4JytDpKuZ1E4yvY
         pmEyKgDrXb+YkkV01k1qCYrUurTYY7lPV7vuXcetl4mlPSSDknW0SGfPQNNxwVMThvCt
         RFs3pG6K2X/LXM2nIx+cjewVGFK3jeVq+bI6wmy6IkWvdkA0Vxp1/9IhHHA20g8jx1T9
         IaoDIvaf1iGTdXFt/vSaRLpZC2Ul6PvUly4Rnkoa4USVJP00TU94OYl4+7XnnQtYzVd4
         wQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680057306; x=1682649306;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=64ihsXE0YL0rC1mVkqNPGDFs/Mq9i5zw8tEyypS7Asg=;
        b=Cuj4WBSuTULPLzwmJOvMe0Fj1/Q9LYW/bZEQCdg+TLzj1IoEN+ti3vBbiEuZYYwehw
         7ZwRuscuejaMMFAVDMmQ4VEy5awFBB2m+uNxZxmzC2AzqCDJhkgBwSXjSsuS8KV3YNoj
         kz+XRhvOp3UiwiIQwJuBTGM4z4sl2pM4eHhf73gHDJ1FeGIQmLyuqyyRnf0tqo4OUbhA
         KjqrDMCIYxSH8zgQEcsaY5te8T+POabj6gS+n+cLxSVs4jkZiYPyggqa0VMncrOwQ4Xp
         YdpTFa1hd3kU/YhbUFZiAMbcinnDfJkMQO3jalrQgXEOYTYFEwPO+Q7slxBLw7qeZg9y
         XnBw==
X-Gm-Message-State: AAQBX9f5UdReoPlAmJuVT4bVMcETDvklrWJ/lH0zsEQkrvLwuoZCdsIw
        8zbmtsYhKKxAsvCycZ5xqRNBriD8PYE4k7RQuYz1Q6HJyl8=
X-Google-Smtp-Source: AKy350ZZs8mDQtqecrJgwd2K6BLj0nce4WMmdr3KC1B8IiV025lOBxYIbSaPfQJx5I+QGYro9nNmbKrWmpYs6LPdc5Y=
X-Received: by 2002:a17:907:3f1b:b0:90a:33e4:5a69 with SMTP id
 hq27-20020a1709073f1b00b0090a33e45a69mr8957191ejc.3.1680057306397; Tue, 28
 Mar 2023 19:35:06 -0700 (PDT)
MIME-Version: 1.0
From:   Gio <gioflux@gmail.com>
Date:   Tue, 28 Mar 2023 22:34:54 -0400
Message-ID: <CADhidkpm=AG7YVR23H1SFjKNbYQHjy25EQQhYamsJGfQLGjPhg@mail.gmail.com>
Subject: Storage tiering (btrfs balance?) possible
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I came across a post on stackexchange discussing btrfs implemented by
netgear here: https://unix.stackexchange.com/questions/623460/tiered-storage-with-btrfs-how-is-it-done

It claims that it is possible to do a hybrid tiered storage filesystem
with btrfs and it claims that  `
btrfs balance start -dsweep lt:/dev/md127:7 /data' is being run on a
cronjob to achieve moving data from NVME disk to slower disks.

I did not find any information about "sweep" filter command - so I
wanted to ask here if there was a way to build a tiered storage
solution with btrfs or not?

I am looking to achieve something close to this commercial solution
but using open source: https://www.qnap.com/solution/qtier/en-us/ - it
is not a simple SSD cache - it integrates NVME disk space to the
overall pool of available storage which is great.
