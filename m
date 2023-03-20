Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F906C24D1
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Mar 2023 23:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjCTWlG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Mar 2023 18:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjCTWlF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Mar 2023 18:41:05 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9F434F6F
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Mar 2023 15:41:02 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id bc12so13500140plb.0
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Mar 2023 15:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679352061;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ewcHUOsRMqDzv2kXLhMhSBwIIrce8cI7RuKCFd/Xr+8=;
        b=PeDypUk3NoXF1Kd+G1TqgsaqhYWFaLHsdnCd2WZ5e2SCgDB6b/otkvrtnWlo72f6JQ
         oqDnZIwzDmUOcjfx+rDd5XqrQ4d7kofjXaZKIFI7kzsVZwdcacDj0bbjMA7A2Q1IjQt6
         UKptea8I2jewBU95nBSdnPs61Ki7kqmdfVDHcf13b/j0KvOlRgtCCg+8NLuAlQufz9N2
         ZL1qd0CZUFPxjgYbbgZyIQO4kPU6syLvmfRk05kXsU/Pe/P7HhaapWmIvQWuPh1vJlgt
         8ogydsoOEdtGICCHF5INu0Ba6gGENMTe8348GH79LwYs8cpUmmmhybbOdVZc1SuuyOYO
         aooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679352061;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ewcHUOsRMqDzv2kXLhMhSBwIIrce8cI7RuKCFd/Xr+8=;
        b=GcPOQp5P5O48wy0z+dbhwbK148nnL4BYmdhTHlkQvQ+TYnKm2NIVOxAe8iqU4ZkBYQ
         x8gedVMZ/IfR7X6NCzk57XIEnOZHh02Yi1WQwQL66q7wSbPMzw7fBDPyKZ2oWezkpq9c
         yWOohkzsFNJ9geNQ2pmLt4J1fMU03zyNmF8pTggdm7WcRPUSILykH0eY3iNjFUlswNrY
         zOCOZGzqJHmNxCp/s7koPZcnnzG1tQ4S2G3SSwSh5WnmtUMZvX8jxgOPnhQebFF5KQKh
         1PKm37U6B4BMjKWaJxfHETknmmkyAGcQDkxl5zFiPZdG68HNf2WxU/7lGIyP1G/GkG9l
         QmWQ==
X-Gm-Message-State: AO0yUKUefe9GP0VGEOqVr9nakNOJG9DuAEBcO2zn3f3gSJMeArc2kwYH
        QNkKVnSimWHp4icjOtJFuWCqoScclPNLmxJmZ6I=
X-Google-Smtp-Source: AK7set+cm7w23+5mhEcI6tCtH9XabL8/Le/HX33mBISDAlSmTrsIGGZCSRE0Xz4UkRvzSEk+imcIi4/NpMvohYFP1T4=
X-Received: by 2002:a17:902:c944:b0:1a0:52f1:8ea7 with SMTP id
 i4-20020a170902c94400b001a052f18ea7mr1045pla.12.1679352061307; Mon, 20 Mar
 2023 15:41:01 -0700 (PDT)
MIME-Version: 1.0
From:   Christopher Price <pricechrispy@gmail.com>
Date:   Mon, 20 Mar 2023 15:40:49 -0700
Message-ID: <CAHmG9huwQcQXvy3HS0OP9bKFxwUa3aQj9MXZCr74emn0U+efqQ@mail.gmail.com>
Subject: Re: [6.2 regression][bisected]discard storm on idle since
 v6.1-rc8-59-g63a7cb130718 discard=async
To:     slyich@gmail.com
Cc:     anand.jain@oracle.com, boris@bur.io, clm@fb.com, dsterba@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        regressions@leemhuis.info, regressions@lists.linux.dev
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

I can also confirm the issue occurred on and after kernel 6.2, and
confirm the workaround setting btrfs discard iops_limit works for my
device:

08:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd
NVMe SSD Controller PM9A1/PM9A3/9
80PRO

I had to use ~6000 for my device, instead of 1000.
I'm currently on kernel 6.2.1.

I am also interested to know what if this is expected.
