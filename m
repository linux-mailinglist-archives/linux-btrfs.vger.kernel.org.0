Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE0E21CAC5
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Jul 2020 19:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbgGLRh1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 Jul 2020 13:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729289AbgGLRh1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 Jul 2020 13:37:27 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABA6C061794
        for <linux-btrfs@vger.kernel.org>; Sun, 12 Jul 2020 10:37:27 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id f18so10720439wml.3
        for <linux-btrfs@vger.kernel.org>; Sun, 12 Jul 2020 10:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=et4iKepAj1EBgGoN1CYHKEBamnyMXhIcADIRK9umXzY=;
        b=lK75fM3Lk6KS9OKCqLBJqtyIlUB145vuliy5kHtQIcac8eky+5a5BLUgbvGatXREgt
         yE9NfphYeGGkPgHJOH4zfiMWiJkWJvtPRsA15AJnlEj0B/A8AEAMxy71LeQ/3vCQCd3w
         lyd7XrMww+tYT7abmog1vJD/p18+3U8cNgANIR3xNlnylAISB/rGogsEAAE4H8sq5UA/
         B1SfgqWQzO2nY1aTQpCJ2/p/eWZZ59/TzukbtLs+bF/3FMEC+iJK0kiea5bgRzqiMh/o
         BwKHTk3UtlKMdUHrjMxh79a/pwl6VKxkjZrJGxWg+oSrn5gfweuIXwZa+tG4YsbMOyW8
         G9tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=et4iKepAj1EBgGoN1CYHKEBamnyMXhIcADIRK9umXzY=;
        b=VrtOymsyeaijnAmZpmtQAjNNuJ9yxYLDaJjac7aiwXooIceKnEaW1t1MWVClZeqrY/
         7bHzv7jyyAZf+z7BpEG//jb9X7+H5eGC12rERNZWMZSjCfT9+GMQndQDhvmGc2CM6/0F
         egg78Ndo589jSh6reWJ3AhIMy75+lRlnW59/TtqijRsb8hd5SCIwhOODeylswXAgisZm
         sMvdxdtHqEf66kou/TGKqakJrM7Ibsw/mf2YSCbzgpcCrh/XfDc+JOySodiDe/YBZF+D
         QrxOqeaL6zANG4AdpavOreMoCCxWrv0m0AzX+yCsse4qknP2T0qaUNr0dt1lxefw5KMo
         ID7g==
X-Gm-Message-State: AOAM530xaMb9LVt/vj9+YkYv7ktty/ibcDIcQBGGq1PaoHf7yx+wCfce
        zBEUK0oIJwO00ThMguyx92ezvMxox8LDLkqygLNT5ab/NFM=
X-Google-Smtp-Source: ABdhPJz2Nu5E5WlUeI74mD5x/df0GFjCKC66pxgBULMq/G1dEdTy5OmnKshkNu5UgFxzlS7DrZ07jK/LGznUCEOV6JI=
X-Received: by 2002:a05:600c:2241:: with SMTP id a1mr14861815wmm.168.1594575445719;
 Sun, 12 Jul 2020 10:37:25 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 12 Jul 2020 11:37:09 -0600
Message-ID: <CAJCQCtTFX7uECSMcACYTfVxouSKud1Qri2bu6MOBLsGjT2BL+g@mail.gmail.com>
Subject: bogus min size estimates by 'btrfs inspect min'
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

https://github.com/kdave/btrfs-progs/issues/271

The summary is that 'btrfs inspect-internal min-dev-size' doesn't
work. There are two values, one where it's obviously wrong: e.g. fs
can be shrunk to 1MiB. And the more common case where it
underestimates the amount of shrink - by a lot. So two extremes.

Details in the bug.

-- 
Chris Murphy
