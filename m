Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267103F9C37
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Aug 2021 18:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245548AbhH0QOQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Aug 2021 12:14:16 -0400
Received: from mail-qk1-f182.google.com ([209.85.222.182]:42777 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234108AbhH0QOO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Aug 2021 12:14:14 -0400
Received: by mail-qk1-f182.google.com with SMTP id t4so7695923qkb.9
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Aug 2021 09:13:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=h0yS26bXm088SOJvWrtl/gwCe0N9LalHAkl6xNyRPxY=;
        b=ZU8oyVQycKVEIQoMAtljd0qzLSKcGkAIvHzWEMNKsj4fhewhLC7Osbzn7WUUCvEQ+C
         4Op+oe9Kf8tS4v+3Ie1UOmMnbvn9IppDUiBa+5nOCRYwIZ0a8n/Jz+phWNvr1dJf9S5y
         puL4X3vkpNKta9b9+UIUfudY2Bd8xoIQ4znysbfTrxVhHTp4IDmDAuDrXn72oEJncwTd
         cHFllg5xf38isZ8xHWpx2SPU1v6t8QHNGA2EOBggiZclj9qmaeElZVl2HH161ZER4xvs
         Wp76guszuqy8W8Jot++9AOrxbth/p9yZ6V4qnetz8RQX1JIBepUBtkrlYRdtafOSHpxe
         O62g==
X-Gm-Message-State: AOAM530BhuqonJ9IixKl+70uw822HQidc6Ieo3PyRxPBLrOkyyiGR8D3
        evpgFTfkYacfr4BEdrruMCiZOPmQj4Akvw==
X-Google-Smtp-Source: ABdhPJz2dMUCclR/rHuAo6c4fAZWe9EhlE9OXhDN41kOKDejWHNfobrrz0JTghqkvsqk8yJrQhTi8g==
X-Received: by 2002:a05:620a:430f:: with SMTP id u15mr10152096qko.32.1630080804733;
        Fri, 27 Aug 2021 09:13:24 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id v24sm3767892qtq.17.2021.08.27.09.13.24
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 09:13:24 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id x140so13617976ybe.0
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Aug 2021 09:13:24 -0700 (PDT)
X-Received: by 2002:a25:d991:: with SMTP id q139mr6826445ybg.148.1630080804269;
 Fri, 27 Aug 2021 09:13:24 -0700 (PDT)
MIME-Version: 1.0
From:   Vladimir Panteleev <git@vladimir.panteleev.md>
Date:   Fri, 27 Aug 2021 16:13:08 +0000
X-Gmail-Original-Message-ID: <CAHhfkvxH8NMR5wrKtDU-9SSgHjtk+0kuHixV0Q-t47FCW7Ra2g@mail.gmail.com>
Message-ID: <CAHhfkvxH8NMR5wrKtDU-9SSgHjtk+0kuHixV0Q-t47FCW7Ra2g@mail.gmail.com>
Subject: Deadlock on 5.13.8 when running bees?
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi there,

Esteemed Zygo suggested that I report this here. I was running bees on
a btrfs volume that was a few days old after having transferred a
snapshot to it, and bees hung in a not seemingly healthy way. The
system load was 15 while not doing much else, and a bees process
seemed to be stuck consuming 100% CPU in a syscall that it would not
return from. Here are some relevant logs and dmesg excerpts:

"task blocked for more than ...":
https://dump.cy.md/464b43eec01aad04e762e6329323a309/15%3A42%3A20-upload.txt

echo w > /proc/sysrq-trigger:
https://dump.cy.md/6efc6a7116aebe9bbd4a6fb0b9e3d91e/15%3A43%3A02-upload.txt

Hope this helps!
