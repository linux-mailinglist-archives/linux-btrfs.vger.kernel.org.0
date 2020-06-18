Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343651FE5D7
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jun 2020 04:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731323AbgFRC25 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Jun 2020 22:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729704AbgFRC2p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jun 2020 22:28:45 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72889C06174E
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Jun 2020 19:28:45 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ne5so1841299pjb.5
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Jun 2020 19:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=xjAKeaybTuFLOgNqS07QUJRxMzQrG4AfDFgEIWSGnwc=;
        b=LTVLGBieKQIboS1ZK+hVa4Fyl/zL+AwQZWauBHccH7FsYgYokzLV5NYyiyEtOCl2Eu
         KqUIoIXupBTm/Ws3piHi1/Noyxmvg6Ej+qZ/WGWEdtj8HPtsl1ve11ZWa7YVPVvD0KEh
         EfpCgAFP7vkAAw07KoedC+zw6kRroMAZXeMY1ZB6o72HbtacFcC3U4xvcDdZd31gh0TQ
         JjduJVeN+a31hhoAwirgkc6/MC3xpECoS3IGQgeY/yygP0xE5yK/ZYqshGX6ENfe2iwb
         kXEegVrBVH3RK+aKCNcy+ylh0jVAg+/jPLumCLqX7WKgTzxvGfKdoFV8qtMRP677nNPU
         Tt2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=xjAKeaybTuFLOgNqS07QUJRxMzQrG4AfDFgEIWSGnwc=;
        b=q32CuxWghp+JJcuFysfa9m0XesO5To8Tsyo10SjdYZLojrfqllrG+QYoGnkBgJwMpU
         LLY1AxWpXdlFPZhcn3qMxcnOjWHwwJ+eOEqoxt+ZGVDOdjEbpcVqYBHxM2vEnkObRZ/Y
         /XetP9icZiJ9N5jsORJGz2AWhQ7Yv5k3ueBmGZu5QFJIFqLrK5Q2xgUcwWJnSn36eC5T
         XFP9LUttQpTUBpa4b7ZwP2cKZldkKsu5RC2qlLn9lxhG+CgX5Ny8nAiAH7OnCkh++rE7
         oPDl0XSaFC96ZgQ5Vs9MTe6mVX4UbNrcgZRzAliQL9zSHjNnolWIoTLiN8mHw2hr/OXM
         Y/gQ==
X-Gm-Message-State: AOAM531IYXwEim9fI9jZHBRcFVqdTBngHnJHiK9EQBeB0OveIxhnzYjL
        /nk/ju2Z5uzGerhoQZCUGCaJVJ9V
X-Google-Smtp-Source: ABdhPJy/9CF5/BJKhw8FkvIpvbULQdPMFasq82m6NXRhgeQszB3wS/04//g8WIKh8T1K4ZCQ33lcrQ==
X-Received: by 2002:a17:90a:cf17:: with SMTP id h23mr1970047pju.139.1592447324794;
        Wed, 17 Jun 2020 19:28:44 -0700 (PDT)
Received: from [192.168.178.53] ([61.68.239.179])
        by smtp.gmail.com with ESMTPSA id r9sm1105743pfq.31.2020.06.17.19.28.43
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 19:28:44 -0700 (PDT)
To:     linux-btrfs@vger.kernel.org
From:   DanglingPointer <danglingpointerexception@gmail.com>
Subject: btrfs-dedupe broken and unsupported but in official wiki
Message-ID: <16bc2efa-8e88-319f-e90e-cf8536460860@gmail.com>
Date:   Thu, 18 Jun 2020 12:28:41 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-AU
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs-dedupe is currently broken and no longer actively supported.

It no longer builds with current rustc v1.44.0 with cargo

It is in the official btrfs Deduplication wiki:

     https://btrfs.wiki.kernel.org/index.php/Deduplication

There's no real active community and proper QA, reviewing and vetting.

A poster in the issues area of the projects Github location stated that 
even if fixed, it may not function correctly due to BTRFS having evolved 
since the tool was designed created.

There's just too many unknowns with this BTRFS specific dedupe tool.

People using your official wiki and trying to use that deduplication 
program could inadvertently destroy their data through nativity or 
accident.  Especially if they start trying to fix the code.

I recommend you remove it from your website or at least put large 
warnings there that it is broken (which looks ugly, I would rather only 
stuff that works were there since it isn't your project anyway but some 
3rd party).

