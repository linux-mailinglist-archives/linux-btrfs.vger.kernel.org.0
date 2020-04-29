Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C98E1BD18C
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Apr 2020 03:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgD2BLk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Apr 2020 21:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726353AbgD2BLk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Apr 2020 21:11:40 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CB6C03C1AC
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Apr 2020 18:11:39 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id x25so149810wmc.0
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Apr 2020 18:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M74NbVSyeulsYwaHQ21W6TbvbuHihMwGBmY/TZgth5c=;
        b=WCAKzs5WYR2d5MgXFHdj8IPuPmBQqNtkGpG5eSCCzK4rQiDUjvyv11YVXpNONhCnQV
         JO3F7nMpQu31nJWBRpt0YtqWlFzWqhm7BVtQipqrsiLH2QUYau5wP0G7MwhmHLEJ6X9E
         r31rulfiVjwTFXGBWySGi8gz/eUIHuUiyv5WGvkOpayHqwQn53hmXKdOMizOxfSwDv3C
         NiYpBrCoKVq/VCvefUayCv+7jfSRKV0QB1pUWarcg387pLCSwpxGd3j0KAxVVg3PPgd7
         Q0WAC36k0CHlpbEjxL1aVVN39UMpX/9VCAfnIkGq2aJZPkueMiBXF3G+p+78Ap+utAdP
         0zaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M74NbVSyeulsYwaHQ21W6TbvbuHihMwGBmY/TZgth5c=;
        b=VnXKOe57jHKclA/25XkqUN91w+Cd4u+gK9CA28dELfWNmqI1vZzQ3uYKW3YkxVdRFM
         pmNDsCDfZrcSGLiKYdOmlCzNGJdHuhOZUN0hN5ey5EocGz5dpEnseJThvQ3lIAO4cNjP
         wO4qkfO2Q3pJvxlKIu7QENANuKbEyq+8+Uh6L6rbynrdp30NkS28i/2ER+T0h4o8Gs4i
         JsyZmithKC5/bjxq8E0oFz1HUuwP2htBRTkS/muRMME6ZRj3l4rz1O7VQRD0ZDkELSAW
         RNwEsNUnfYAusa6zEURj5Ee7HZ6Bykyr6vgMI0jOk6vAnt1mnOW6CyfUcFArBLAxIZl4
         9BgA==
X-Gm-Message-State: AGi0PubHDomfsRxrvVbYkgTgx9Njgi7mOzuHmPIYlnvEbBXuza0kxH59
        89kMbE082kld9u5SkzIPoCBdQEV50q6FCgFPfcx8GzVs
X-Google-Smtp-Source: APiQypKoTdY3XvulLGcDlAQJXMExdDsS4vDoVRCMqgZAudBYrGR32QeZN7wZx5EZaVIQDI9/H9y6tU5+9s6vuYsES0A=
X-Received: by 2002:a1c:1b0b:: with SMTP id b11mr216073wmb.182.1588122698496;
 Tue, 28 Apr 2020 18:11:38 -0700 (PDT)
MIME-Version: 1.0
References: <d54b6655-db2d-ff35-8c73-92f282dc252e@netc.fr> <20200429002525.GC10769@hungrycats.org>
In-Reply-To: <20200429002525.GC10769@hungrycats.org>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 28 Apr 2020 19:11:22 -0600
Message-ID: <CAJCQCtQjEgYmEs28usUe-sh_KpX9jsFgDUT=xkGNf1FkH-tKBQ@mail.gmail.com>
Subject: Re: RAID1C3 across 3 devices but with only 2 online simultaneously
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     =?UTF-8?Q?Timoth=C3=A9e_Jourde?= <timjrd@netc.fr>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 28, 2020 at 6:25 PM Zygo Blaxell
<ce3g8jdj@umail.furryterror.org> wrote:

> Doing this with scrub is not reliable with the crc32c csum method--every
> ~16TB of updates, you'll get a crc32c collision, so you'll have the
> wrong data on disk and no csum failure to detect it with.  Any of the
> other csum options will solve this.  Use SHA256 if (and only if) you
> are worried about crypto collision attacks in your data; otherwise,
> xxhash64 is fine.

What about blake2b? Hash benchmark on x86_64 shows it's quite a lot
faster than SHA256 (and yet still way slower than xxhash64 or crc32c).
But I have no idea if this actually affects overall file system
read/write performance when under load.

I've started to migrate to xxhash64. It'd be nice to have a convert
option. Rewriting 100% of the metadata is still a fraction of having
to rewrite out TBs of data. But this is not a complaint. Btrfs is
still badass.

-- 
Chris Murphy
