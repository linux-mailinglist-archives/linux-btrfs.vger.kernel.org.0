Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1382F0A0A
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Jan 2021 23:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbhAJWq1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 10 Jan 2021 17:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbhAJWq0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 Jan 2021 17:46:26 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5A1C061786
        for <linux-btrfs@vger.kernel.org>; Sun, 10 Jan 2021 14:45:46 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 3so13373676wmg.4
        for <linux-btrfs@vger.kernel.org>; Sun, 10 Jan 2021 14:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oZJ/HURHostNBsAGSSvKBPkFbSQfDPFbv+ETaYZqdNQ=;
        b=kA01pUZ7m3McI1aEBNVqYFpyndnTwYaOhTH7l0zwaBELm6ZKAE8huEH/TgMGseDOFX
         xW3TWTvpqDrcySOGaHrB/0J3UktthA0ntNFP2DYoPdj7nx8+7lzMtD1VV8cgna4RY/fi
         2arWU0xCc+fs2Sv54F6/Z7yP3ZNCu3oJLOhHJif8wplL/aCzwh5SXfZI+pt1le8TnNFc
         JatrNcOq9KfSrphwZelZTHJdkuTQR5iRYwdCGK7fWHcQ1HDR10kyt3cmt+Z8AipjHWaY
         vzeAL/KlE7Smt2qDV10VbPLOvU0KYh2qCkpMOw23PIRWlRiT3OevpDITs8dJB3z/x8N+
         xExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oZJ/HURHostNBsAGSSvKBPkFbSQfDPFbv+ETaYZqdNQ=;
        b=eKVT3L1EHs4m+BRXAGQeefWv5NNAa7mN/672sIyaNAd+WUptTu5oHlVV7o9QIfcLZt
         9I8i70gPnM8N9kTn1uBTvZ8ktNAAxFEv50swQeEILgTZLdHMHcfK0HHOSnZR+6U2v8f4
         9wdVozA8XoniMAFMttiCTNajzCLr+77GhxzqrKaBbWrK4BUmSFa45eU181M2VKDokXwS
         hKIAU0X0LGtLHVkoeMSFfrfeDn4EL9RS4hNUbjOcEIw9O7tN7skBV7vMuV98SKNqnllH
         TUWOm+okJtOfn6h0Q8Q7P017MAS/yfQ1m81IK8ez9rpHN+Fbn3V7xX1fVeqNZHjZ4xcH
         5Uiw==
X-Gm-Message-State: AOAM533f4G9AL3upXIvdk8s5JXG8GTP8C5pt3+UMYuQ2G7VInIl5X48N
        FU2xlZNhf+JByx9wO7n2YfYd1f0pVxW4vv1fuP/5uLwik9OZLw==
X-Google-Smtp-Source: ABdhPJw92PpdsnjMsFH3WGwBY/whaToZTc1H57pFDGAXYTuaVVY3U69tMP3WLFp4VsCXA5AKm5+4lU7nycUmfI/YgfU=
X-Received: by 2002:a7b:cf0d:: with SMTP id l13mr12439581wmg.168.1610318744935;
 Sun, 10 Jan 2021 14:45:44 -0800 (PST)
MIME-Version: 1.0
References: <1ad3962943592e9a60f88aecdb493f368c70bbe1.camel@infradead.org>
In-Reply-To: <1ad3962943592e9a60f88aecdb493f368c70bbe1.camel@infradead.org>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 10 Jan 2021 15:45:28 -0700
Message-ID: <CAJCQCtQ2o=K2+ZNifF44mohYNmpYMgn8twz_7gsV45RRfg2YzA@mail.gmail.com>
Subject: Re: Reading files with bad data checksum
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jan 10, 2021 at 4:54 AM David Woodhouse <dwmw2@infradead.org> wrote:
>
> I filed https://bugzilla.redhat.com/show_bug.cgi?id=1914433
>
> What I see is that *both* disks of the RAID-1 have data which is
> consistent, and does not match the checksum that btrfs expects:

Yeah either use nodatacow (chattr +C) or don't use O_DIRECT until
there's a proper fix.

> What's the best way to recover the data?

I'd say, kernel 5.11's new "mount -o ro,rescue=ignoredatacsums"
feature. You can copy it out normally, no special tools.

The alternative is 'btrfs restore'.


-- 
Chris Murphy
