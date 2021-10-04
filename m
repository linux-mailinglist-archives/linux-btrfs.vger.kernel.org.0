Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4A4420593
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Oct 2021 07:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbhJDF2R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Oct 2021 01:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbhJDF2R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Oct 2021 01:28:17 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8E2C0613EC
        for <linux-btrfs@vger.kernel.org>; Sun,  3 Oct 2021 22:26:29 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id r4-20020a7bc084000000b0030d6fc48bd2so522563wmh.1
        for <linux-btrfs@vger.kernel.org>; Sun, 03 Oct 2021 22:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=u8vnT7p2zsHvRHeAP9O3GKO+vw5c9aIZgn8vASh4YAM=;
        b=Hq/E3wiwrj97mrXOSTvcWS4+T5oNx3S6xx2wi2gh17nBUCc4og0HbYpyqcFbw80cdZ
         MtqXqrxamH5V+DfAcomkbQnb6IbXlxDs7yzuSIjf9RE8Cf58wSpozAZgF2I2DqU+qSui
         k/K/rUHHgIH+iLFNvBnqq761tZGnDu9XzQ+iDFcehShbCF8dY1Tpy+5+xHkXXKrpqnHX
         Fw7Ttc5u9ywNY2HzkxUFs0qeHPxKXhl7RWqMhgA1M1YYHvgLHg4fzPl62bBKWvz9gHSk
         wr0n/Lex7nhDEr7D7vdqXns26Cm6w6m06Z8pfzw+v2xaZZ23+uR6y5jLZiCFoHr7FaX9
         6LrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=u8vnT7p2zsHvRHeAP9O3GKO+vw5c9aIZgn8vASh4YAM=;
        b=bdxAY4+CgCQjqikKY03j2Jd3kZP5WxJ1AUovbmN1sZPpWBDFNz3mZiRgvPpCZD4w7M
         sHEEMcSRs3VcB0Qjl07hrIQSMOQRvEgk6UcRdJqKYagD5hGsL1GS1nsb75xQ/fTE7PLt
         21cqQTpDvovhHuREjBv1xFq0MBiusK7sOmAjjmqgVgRT46i3bSR7P/7Hdc5zRxh0d9kT
         NS2hdxjAgaOuroDhu2usoAU8YDqq0kp9NYwx5a1Pc+bDj8EKrXlAQUCGIgMAQhqHoGpU
         hzQ89kfoXVrblIylX1o2q/y0UCx0qStwIaZkKxI1seeV4GWRff127DY94g9Ud434JeN7
         4qCg==
X-Gm-Message-State: AOAM532yUq92NaAxIEuvjBa1uu9bPuxQJIPh3Wg+HOpDeoCw9oiDdA1B
        dd5svxBXgJybEmAmZxJQvstyCeojT+TOVdGPQ9c26mRv
X-Google-Smtp-Source: ABdhPJyQL+0zqt0O7iKcG0FySv6bEymQ9BlJrEseI9Gq51Xuh60Le0ByHwwApfsRhCx5CDrZD14NzTz64DfmSc/HeB4=
X-Received: by 2002:a1c:7f81:: with SMTP id a123mr15379530wmd.34.1633325187068;
 Sun, 03 Oct 2021 22:26:27 -0700 (PDT)
MIME-Version: 1.0
From:   Matthew Warren <matthewwarren101010@gmail.com>
Date:   Mon, 4 Oct 2021 00:26:16 -0500
Message-ID: <CA+H1V9wsz2y21qxaYAkNa2PuBUCnM4yFVpoSC5rGav-1LHdwHA@mail.gmail.com>
Subject: Changing the checksum algorithm on an existing BTRFS filesystem
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Is there currently any way to change the checksum used by btrfs
without recreating the filesystem and copying data to the new fs?

Matthew Warren
