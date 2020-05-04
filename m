Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7521C4A35
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 May 2020 01:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgEDXYa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 May 2020 19:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbgEDXYa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 May 2020 19:24:30 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D37C061A0E
        for <linux-btrfs@vger.kernel.org>; Mon,  4 May 2020 16:24:29 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id u16so138049wmc.5
        for <linux-btrfs@vger.kernel.org>; Mon, 04 May 2020 16:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pRmq2U+PRdYwsuUK6B4UzjjC4F2EEw1gLmv140AFmgI=;
        b=1Ow3asd8xsbJGkFTmDmtf3wgY5Y5u26AVARQ76XaNr9u2TXKjSsQuFPRsWieXJdd00
         4nnQAq0eAxVhhf/Pz08v9/BUU8pA27QwG8K7GPxdtep5Tl/Kf/cLyjRp53kT7PAYR8S5
         Y6yj48AnyBSRKMZZmBAN/at1ja9yt9+Do7IisFlWUF1WtoG7ZY2BBboXlwgvw1ZngYhP
         h1z+p+pQqu2g+0XwQ5eIyXNCX8ZybuB1Tb9WQevmuq//FKiQmgOc8IFPXUxoJ2sfq8nX
         ODELnQv0JT9AWvKiYIIRELpsQMLRmzyE1YADzb6kgORitrWGQBZVZIjJs1yJFplYpNWU
         5rrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pRmq2U+PRdYwsuUK6B4UzjjC4F2EEw1gLmv140AFmgI=;
        b=j9e31yrWj15ZpNwXDCcIHTgq4/z2JtwUpq9hdQfQDrBVXW9uHmfyVaQQGnP+uZHCpj
         7lGQtzg5O9cTcjDTsJxSdCQJa6gD6w81l7C+JTO9L7/VK+VXNafihGn453Md4X5qLTbl
         YWV0THQAyilxd0q6dQh9uI3nrYlo6Ecs1jcOKs0KNZmiTHyjIdNe6g+eu5pqGNatCln1
         l+9j3BOetQHzR8Jj53DW+7ieNaW50q+Qx7zJ7D2UQSfjGduDFuAm4v7T4XZlRLYCV83S
         4KlFJXNRMCZzsm344mqqUE5cF3dltSAH0lr7y1hzXxBA9ZCgy/CuCFmkp+PLB4BYEkWS
         vVng==
X-Gm-Message-State: AGi0PuaK8eGz39q8wupaqJ3A2wTVx+pq4kdcAf8tlDJRXL6jBF1zS4nB
        qabVdsmiuTiYj0NXh8EgGKtPFub1Lot40Rfqc8+ZN1NGJLk=
X-Google-Smtp-Source: APiQypK5tNeh8Huhd3i6KChsdOk/j56fpoZg2RYOAsy9s7pHcAU+E+cQUsq4Nn1qTVTR1Jj3x6Jo+8DT4seY0W4yE/s=
X-Received: by 2002:a05:600c:2645:: with SMTP id 5mr119740wmy.168.1588634667791;
 Mon, 04 May 2020 16:24:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAG+QAKXuaah3tkhQLd7mD3bx+pc3JZdXkUg6yr0R8=Zv2vXnhw@mail.gmail.com>
 <20200504230857.GQ10769@hungrycats.org>
In-Reply-To: <20200504230857.GQ10769@hungrycats.org>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 4 May 2020 17:24:11 -0600
Message-ID: <CAJCQCtQt0S6b66yKRFT6bV=z4r+CEvjss3o66EoT=oiz7UKuxQ@mail.gmail.com>
Subject: Re: Western Digital Red's SMR and btrfs?
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Rich Rauenzahn <rrauenza@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 4, 2020 at 5:09 PM Zygo Blaxell
<ce3g8jdj@umail.furryterror.org> wrote:

> Some kinds of RAID rebuild don't provide sufficient idle time to complete
> the CMR-to-SMR writeback, so the host gets throttled.  If the drive slows
> down too much, the kernel times out on IO, and reports that the drive
> has failed.  The RAID system running on top thinks the drive is faulty
> (a false positive failure) and the fun begins (hope you don't have two
> of these drives in the same array!).

This came up on linux-raid@ list today also, and someone posted this
smartmontools bug.
https://www.smartmontools.org/ticket/1313

It notes in part this error, which is not a time out.

[20809.396284] blk_update_request: I/O error, dev sdd, sector
3484334688 op 0x1:(WRITE) flags 0x700 phys_seg 2 prio class 0

An explicit write error is a defective drive. But even slow downs
resulting in link resets is defective. The marketing of DM-SMR says
it's suitable without having to apply local customizations accounting
for the drive being SMR.


> Desktop CMR drives (which are not good in RAID arrays but people use
> them anyway) have firmware hardcoded to retry reads for about 120
> seconds before giving up.  To use desktop CMR drives in RAID arrays,
> you must increase the Linux kernel IO timeout to 180 seconds or risk
> false positive rejections (i.e. multi-disk failures) from RAID arrays.

I think we're way past the time when all desktop oriented Linux
installations should have overridden the kernel default, using 180
second timeouts instead. Even in the single disk case. The system is
better off failing safe to slow response, rather than link resets and
subsequent face plant. But these days most every laptop and desktop's
sysroot is on an SSD of some kind.


> Now here is the problem:  DM-SMR drives have write latencies of up to 300
> seconds in *non-error* cases.  They are up to 10,000 times slower than
> CMR in the worst case.  Assume that there's an additional 120 seconds
> for error recovery on top of the non-error write latency, and add the
> extra 50% for safety, and the SMR drive should be configured with a
> 630 second timeout (10.5 minutes) in the Linux kernel to avoid false
> positive failures.

Incredible.


-- 
Chris Murphy
