Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3215E3FA594
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Aug 2021 14:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbhH1L7y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 28 Aug 2021 07:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234099AbhH1L7y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 28 Aug 2021 07:59:54 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECAFC061756
        for <linux-btrfs@vger.kernel.org>; Sat, 28 Aug 2021 04:59:03 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id m11-20020a056820034b00b0028bb60b551fso2880380ooe.5
        for <linux-btrfs@vger.kernel.org>; Sat, 28 Aug 2021 04:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=6fREeKHcHd9OZsAV4C714TvG7QZswkEZc2NIPBmdJME=;
        b=gfrPl1gK3ehbBAyqXSZ4Nm+nZUOFJBFcsRTIdud0o4ufH6BJU8gPyh05uepnAAP5Dt
         crHUBIlvlBW+AeEHtSFfdYUyeQeDYCPjVzkKEJjqsJBDGIPgUSvT5GdAzxL5un9GvrEO
         twqyYshv1MK2lmO6q/Vl7wfHM5sv4DYQukwjiww7f+hh89jQ/QMRMlLHk+msRbeIYFJc
         iXE0E9huHu9eztvKC/14+9Cj4KmPaguFtP02dWqT0rzA6X+JBHF0l/5eUJQNLskARuUu
         Yqk20IR9SwZQBNrDmgyvsDkxwwIUcHqxr+QRgB+7XWb4Nln9g1kZ1MfApBQq4vt6QNZj
         eV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=6fREeKHcHd9OZsAV4C714TvG7QZswkEZc2NIPBmdJME=;
        b=k47J0moUdPDeA7r6fxRvyO4YsZQczMT4b3ixg06VjBdo+zl/XJVxeo4QkIJXASjRqe
         h0MVIeogFss/RcH14nag1Qg30AKjxoU0gnYlQAqBaBmrJd70lnE8fu02wjG+/+Zgsd1a
         VtqfYJfrmmYjFCp4UG+mqfxxRMD/LBhNt8rdeKClmKn7WnrJT90DLYOo+2qBQrw4Rjxa
         NPniJJB6QWT9SXJkVZHC0yParA5kKQGnwftGMMnqDSbT06tNXt4+qjeIm8vxFE4xxX/8
         qVk7qETqQhAfbs0kEn9sJBTts1R144WVG7y9tp6kiY7RfmxR+fpWjWTvKYapHrpWFx+o
         UXQA==
X-Gm-Message-State: AOAM533JdA80YUFGxXGdUBwsqyRbJEckJ+EBKgAXjRbOHor+RRfUh8BC
        8h+Ngu1D7wnjniNQ5S7ygDPG6wdbEULcqc0sroR5pfiJt2U=
X-Google-Smtp-Source: ABdhPJzYwBUj/KdS98ahKqtrDr98tEsFJZk60qC9kIxMYvblh2nMAA8uTLLBzhjDPKwUbnG9YaXr64DelFeQAt+iT8A=
X-Received: by 2002:a4a:1704:: with SMTP id 4mr2946126ooe.50.1630151942792;
 Sat, 28 Aug 2021 04:59:02 -0700 (PDT)
MIME-Version: 1.0
From:   Jingyun He <jingyun.ho@gmail.com>
Date:   Sat, 28 Aug 2021 19:58:52 +0800
Message-ID: <CAHQ7scVGPAwEGQOq3Kmn75GJzyzSQ9qrBBZrHFu+4YWQhGE0Lw@mail.gmail.com>
Subject: btrfs mount takes too long time
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello, all
I'm new to btrfs, I have a HM-SMR 14TB disk, I have formatted it to
btrfs to store the files.

When the device is almost full, it needs about 5 mins to mount the device.

Is it normal? is there any mount option that I can use to reduce the mount time?

Thank you.
