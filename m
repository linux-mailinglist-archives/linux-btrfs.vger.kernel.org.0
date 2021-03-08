Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB8933058E
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Mar 2021 02:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbhCHBG4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 7 Mar 2021 20:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbhCHBGX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 7 Mar 2021 20:06:23 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C19C06174A
        for <linux-btrfs@vger.kernel.org>; Sun,  7 Mar 2021 17:06:22 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id v15so9662810wrx.4
        for <linux-btrfs@vger.kernel.org>; Sun, 07 Mar 2021 17:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hf8oBtTng6zsiMWef4BqVoKgITFNGxaG8j0tUSA+5og=;
        b=i6o8Oh1dOpycXgLBYlD88uthYYodvUmGvBgWWHXQcNbqC71X+65Ic8/ZeKgH8ngjR6
         hEswoRa42410+2+MGfGqzrIzd1yEIFMsT23y/BB9Sr3oM56t9LREqZAFftXhAXTO/P5x
         MaL+VjlGh3oM1xEU73rNt6p7lwW7qFHPVSFudcxHt0z9gAb0UtxNbZ+1XJo+7PrHtGoV
         hPBhfrRVWNtwyN34BDaEbZ+KmXhU0ECNyrcI+bJj6JVBOIR2KrGMFZdkotRqi+pbZyk5
         GW99hZLEWdQm6Of95tQEqjLIoSjDVKel5L5K02IF0qmsOGGH93+hZyEOhwMESmtEpDTt
         eVxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hf8oBtTng6zsiMWef4BqVoKgITFNGxaG8j0tUSA+5og=;
        b=XC0plPIIK8KEdvSp9JgoinRRJC+o3j4Bu7AERoZhVb+3nqb453p9WoeG+6ml83+OVj
         GtDkYZRddOzpAD8/txqH+Ja1oCzviEMw8E0ZcH59O0o/G/lShLIPrbSm0Or3q+yEul4u
         zWXjT7QyUcP2lffkQtifY4Ughb1P5wTvG9ihzPOzkTlp/BPeyzYVCbC4Z8kgADwmyII7
         mJRIbk8Q54WDdE1lmHMDwgATxvTHBgeY3TgR0HIjXEBJVd2s4p4CqJcf0nzdANRxJ70V
         5JsIRl/rMNybeRnIBwEEXItYZ7RWhXfAOiMSnic1GOG2Vtg43DePz2v5m+4W9SFJgYdi
         l+/g==
X-Gm-Message-State: AOAM530tGzRXgkcKpRLERFcgdgHT96bl6Iq5hSNfuFbsgGP9/ELWw/Xt
        gI2f6ezKRqPyddrYp6vtNHuPmgT2Kl0m5xr7NxKaBNFmWAnM0g==
X-Google-Smtp-Source: ABdhPJyRa2qal5iSRSgqYgS3mHomrGVYqRSdpoDlpXrI0kp3+TOpg0M0H5ypOhgLrvarsW03I2peodIgbhjMuh5b9cU=
X-Received: by 2002:a5d:42ca:: with SMTP id t10mr20097105wrr.274.1615165581646;
 Sun, 07 Mar 2021 17:06:21 -0800 (PST)
MIME-Version: 1.0
References: <YEVYbMdXdPzklSVc@bulldog.preining.info> <20210308081640.3774.409509F4@e16-tech.com>
 <YEVu36vR0QVWMcN6@burischnitzel.preining.info>
In-Reply-To: <YEVu36vR0QVWMcN6@burischnitzel.preining.info>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 7 Mar 2021 18:06:05 -0700
Message-ID: <CAJCQCtTn_O8grH5OBHoDfN7OfEOq5WM2Ryxffb-Z=qhVn_PLTg@mail.gmail.com>
Subject: Re: btrfs fails to mount on kernel 5.11.4 but works on 5.10.19
To:     Norbert Preining <norbert@preining.info>
Cc:     Wang Yugui <wangyugui@e16-tech.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Mar 7, 2021 at 5:25 PM Norbert Preining <norbert@preining.info> wrote:
>
> Hi
>
> (please cc)
>
> thanks for your email. First some additional information. Since this
> happened I searched and realized that there seem to have been a problem
> with 5.12-rc1, which I tried for short time (checking whether AMD-GPU
> hangs are fixed). Now I read that -rc1 is a btrfs-killer. I have swap
> partition, not swap file, and 64G or RAM, so normally swap is not used,
> though.

That bug should not have affected the dedication swap partition case.



-- 
Chris Murphy
