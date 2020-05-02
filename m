Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86CC61C231A
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 May 2020 06:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgEBEsg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 2 May 2020 00:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726463AbgEBEsf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 2 May 2020 00:48:35 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895C4C061A0C
        for <linux-btrfs@vger.kernel.org>; Fri,  1 May 2020 21:48:35 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id u15so4455221ljd.3
        for <linux-btrfs@vger.kernel.org>; Fri, 01 May 2020 21:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ka9q-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=opLaQVYQs6wk/ck/hRA+etLgvzw1B+XX9xQGjMXUpHA=;
        b=dzkI3YjlULiqcS3xTwMKF4Q0uc6AqL6TluCXc2ZPg4eW1BMQX7PvV5q6Y+yZo0y2co
         TjIzr/0Qk+CW3zVpm7k0kCm6AL50PknlQf5co6Z4kBzxhf+qL2aQq8jBLEJtOLR++liE
         vgsDkkJGE8CyL4hluakOBtuxAaOqJJnOhXFsxbUVZzGMFL3X8Pl/5bAGwB/LofCepBBt
         7u8jTJ3phoSTGtg5l6bqN0L0dASIbyz2NmrCLJSuIHRKISwHSneTIeLKW4nLCOoJUNwH
         Q6F4mwGaVaA5e9b5wBs8a/seQlE1a8ddRktHKPfEd6F/c4VPxisDGpRB1/zl+OTg7uh6
         /01A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=opLaQVYQs6wk/ck/hRA+etLgvzw1B+XX9xQGjMXUpHA=;
        b=AHJ3Vu29S65ZQFZl8M9UWKz7eCbL3tRGFcvhwRHTEXuutziNFT7xoPHg4VzqlbMMXN
         qgOwxEjr4EViMOU10xFm0oXPfMuym2FSI+pDX5fo05sJjy+i5xiNclrwDRH6ytV1uVwJ
         /r2s9CUq9WRBVs8GAdtYYjZawRRLVhUGxW2hROBV/AErjr+mIJ8ZtE6SOMAvwtWWhPe2
         hONZijX/utfxyEWDw/xYvoJdSxCzmfEVvfeiQkakHqEZQMb3n2upp8BgRAhb/AR0hicG
         tMq2Htg5FVqIGfJc1HAk5TCh04ol5z6OTO5/Y1d/rKuUjrTryJt4YvycRa4R5j65ACNI
         plcg==
X-Gm-Message-State: AGi0PuZQoazAw39HpFc9KbLW9VPq1NWG655jUuZbMewFd6cSn0gruKzI
        qma7LnvNPOoUXK+Nbtc6lwatRN6E11qGhQ0AF2NvQw==
X-Google-Smtp-Source: APiQypLjAiV4abia0Dnf3bo5bT/gHLq6xTg5I9BLkRDylpCrsUtmjiGyajHs/PnbgoW+xlys9HhRNmwb4RI80fmY1tE=
X-Received: by 2002:a2e:2245:: with SMTP id i66mr4232627lji.191.1588394913955;
 Fri, 01 May 2020 21:48:33 -0700 (PDT)
MIME-Version: 1.0
References: <8b647a7f-1223-fa9f-57c0-9a81a9bbeb27@ka9q.net>
 <14a8e382-0541-0f18-b969-ccf4b3254461@ka9q.net> <CAJCQCtQqdk3FAyc27PoyTXZkhcmvgDwt=oCR7Yw3yuqeOkr2oA@mail.gmail.com>
 <bfa161e9-7389-6a83-edee-2c3adbcc7bda@ka9q.net> <20200501024753.GE10769@hungrycats.org>
 <b2cd0c70-b955-197c-d68b-cf77e102690c@ka9q.net> <6F06C333-0C27-482A-9AE4-3C0123CC550A@dordea.net>
 <bc37ccb3-119e-24da-4852-56962c93fd2d@ka9q.net> <20200502041826.GH10769@hungrycats.org>
In-Reply-To: <20200502041826.GH10769@hungrycats.org>
From:   Phil Karn <karn@ka9q.net>
Date:   Fri, 1 May 2020 21:48:22 -0700
Message-ID: <CAMwB8mifO8kbLUHarY-nZRPwmK6YUEFTCY5AE_JVcuH38P8oZg@mail.gmail.com>
Subject: Re: Extremely slow device removals
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Alexandru Dordea <alex@dordea.net>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks for the additional information. I know it's inherently hard to
recover from some errors when caching is enabled, like an acknowledged
write that can't later be flushed to stable storage. But I had no idea
that some drives do gratuitous stuff like dropping the whole write
cache on a read error. That does seem pretty indefensible. Has anybody
gotten a response from the vendors? Does anybody keep a list of the
drives and firmware versions that do this?

(Resending because the list requires plain text)

--Phil
