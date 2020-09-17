Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFDA226D2D0
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Sep 2020 06:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgIQEwb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Sep 2020 00:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgIQEwa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Sep 2020 00:52:30 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFA9C06174A
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Sep 2020 21:52:30 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id w1so1079825edr.3
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Sep 2020 21:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=V/wf0qzz/fTpcBYBPkV3SLW/jepFr6mmJIboq0EqBK4=;
        b=t/zc4li/6mIh2OPXnzO1okNDXXaddfpL+apUzX69C2y9idNnLhj+uLOOxHMpi/9Y1L
         7xdYM843aKHRXQl9/cIm1xvGHXbHtusDsjQIJ/X0ogdEBPEZm6UmbHBkQB1sceBRPhzD
         Xd23NgevWoNYqTYijcNGPo8fTrM1joYURcCtvgH6I7fammph+63XoNEIxUfn33gonWAG
         EUkkl0nhZZWSEQnVNDp5mXXcAl5QWUDY741B3lj9DqgmGiO2E7C2HOn5tney8sOJeGn/
         jRPMWUoQAEE6FOr+qpz2y6lUzVvkX5am2qTz1aGhXYxjzrF31zm7nVtWNZYejdRkUQ9W
         nLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=V/wf0qzz/fTpcBYBPkV3SLW/jepFr6mmJIboq0EqBK4=;
        b=l9Lyrpbj+9GIUespv8UnhnwGTZ5b1Xzc2CRqXlFBBLvOJFjAFL+tklncgwxNYbjI/q
         hdepHtyUGrQSDUUrtrO7GhkpWF/QXfWw8yFmLLggcnlZACGpFL+WB+Z2UCKa1h4bbLsq
         KMHHqoKiVYFKot4xKrUNDrs2pf0LYKt0U364d0XO1X+06b/1Lx65CY8pmWA2+Har6jpD
         zvGeeJAH9Uq1/6yY938f1TrpkvhBTf1x14pIqWp/MaZ60kA2Fl6ainXYszIklLobWvXN
         U7yOlxMAAf+JfCnU0k+A+d3kZ/IrfFafhL2KvMg1gEPtRzzO+ys0GvfTXTMWFkdZQVdE
         gxyg==
X-Gm-Message-State: AOAM5335JRRnUQsTh87WBIzy/Nd/cyU356k6cScTHTFdT3qGpyFSNjRc
        LwhNffphffPfRoFNIQFMG8AqZyx6VW4/MxuaH0SUsA09570=
X-Google-Smtp-Source: ABdhPJyEBFcNtQeQ/6BGpBk/bYya98nSrEfDHzoi8+C7+lXwTRC1OcEIGsY051+9rcWCZQSNjj3AviviblNzrbXWMEw=
X-Received: by 2002:a50:9d0a:: with SMTP id v10mr30609209ede.144.1600318347542;
 Wed, 16 Sep 2020 21:52:27 -0700 (PDT)
MIME-Version: 1.0
From:   Thommandra Gowtham <trgowtham123@gmail.com>
Date:   Thu, 17 Sep 2020 10:22:16 +0530
Message-ID: <CA+XNQ=ijYZbtTejEcdfgOAgmUu68d7c2YL-3BLQfokq3YYuZNQ@mail.gmail.com>
Subject: Need solution: BTRFS read-only
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

We are using BTRFS as a root filesystem and after a power outage, the
file-system is mounted read-only.  The system is stuck in that
state(even after multiple reboots) with below errors on console

[   35.099841] BTRFS error (device sda4): bdev /dev/sda4 errs: wr 0,
rd 0, flush 0, corrupt 1, gen 0
[   35.109822] BTRFS error (device sda4): unable to fixup (regular)
error at logical 166334464 on dev /dev/sda4
[   37.500975] BTRFS error (device sda4): bdev /dev/sda4 errs: wr 0,
rd 0, flush 0, corrupt 2, gen 0
[   37.510993] BTRFS error (device sda4): unable to fixup (regular)
error at logical 440860672 on dev /dev/sda4
[   37.522128] BTRFS error (device sda4): bdev /dev/sda4 errs: wr 0,
rd 0, flush 0, corrupt 3, gen 0

Is there a way to make BTRFS delay moving the filesystem to read-only
after a reboot so that we can scrub the FS? Or is there a code-change
we can use to modify the btrfs module to affect this change?

Regards,
Gowtham


mount options used:
rw,noatime,compress=lzo,ssd,space_cache,commit=60,subvolid=263

#   btrfs --version
btrfs-progs v4.4

Ubuntu 16.04: 4.15.0-36-generic #1 SMP Mon Oct 22 21:20:30 PDT 2018
x86_64 x86_64 x86_64 GNU/Linux
