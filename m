Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A402730EACC
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Feb 2021 04:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbhBDDRP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Feb 2021 22:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbhBDDRM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Feb 2021 22:17:12 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4162C061573
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Feb 2021 19:16:31 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id m13so1693890wro.12
        for <linux-btrfs@vger.kernel.org>; Wed, 03 Feb 2021 19:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Yq9Fnw5KAtmb36TWsdyp0QSrOG2/CChM5v8osxuGnk=;
        b=Vyddu0V/lf9Bk23p6nM7k0UDIWt13fW0CikS0GOXP5hrK9AmJnzbNU6uMYsBmMRB+f
         WKzVHf0z+to6HLsMPDrKVuFHvtzcAfXYqaNfQu/qDBqs28fe9q6xYB6xCZ0aNFMA1tGT
         /2ckk38dkZ9F5iLgWBcDHSFFuPZcrJcG/HOjFHqi3ww6ExXu5A7VZINvRgAmD5xogrBW
         WM0I4G4k3iYgbbpljIymp5YuoSi+gsg01WbnVRcdtUJ8NNl39onythUHM32HfhEtLgLp
         FV2yLRuo6XimB532sC64+8eHzqZC77v8+hAgUqcnSNvLfOPes/Y3ZRtZuzpcprQTNmAa
         BoDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Yq9Fnw5KAtmb36TWsdyp0QSrOG2/CChM5v8osxuGnk=;
        b=aEjB7M21mRiTwfAHgv4+C1w2BRL96eR00ZR+BsRSjDznHGYG+QFSpADfn8Kj1qM/E3
         RO/wo0Yv2sOjQaFC07h7bg49usd78+BjTumb7s9vj0dyUzu4Hw9l4CF+6Sn7cXppitNj
         K49UXdeOE35Ecq6oJb/v6SnYj0zc6bn2R68rzl9KxBgNYog3UEXk1k3KZBViUh2pLHYY
         1/hCJ4F2XmrdmfpK4qFmiwrHgcaWv+Z2yitzx+rubjbSlseAxSkJaQp7Nlyu+seZC5JN
         ezhMJ9PrZlQKyoqyARaoURjKWkVk9IkEijANWjjGBYTsTfHC8niNuE9h8lPchLwbdoWL
         o2Lg==
X-Gm-Message-State: AOAM533LSw4ytRNSso3wGHY65Ah3pCN9qXrQ/mPjCDnIRorALavjvHcG
        71KtovIuzhadqRbJB1Bk1iEvTrhjz1k2fJLBI1sfdH0fZjtocvmn
X-Google-Smtp-Source: ABdhPJz+X6O7+buOEUn8r8dD59ayD9rSlByCzSO0rLQxvJHEAnUIzuMlR+ocsmjg3zMsd6N4sys0hN1GAsFSA/30XGs=
X-Received: by 2002:a5d:414f:: with SMTP id c15mr6768245wrq.42.1612408590661;
 Wed, 03 Feb 2021 19:16:30 -0800 (PST)
MIME-Version: 1.0
References: <D97BD745-505D-4F88-B92D-A59DB92AA7BF@gmx.net>
In-Reply-To: <D97BD745-505D-4F88-B92D-A59DB92AA7BF@gmx.net>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 3 Feb 2021 20:16:14 -0700
Message-ID: <CAJCQCtRKR=4hfPG7iY=PKeKxDH0ZE-mzZ1Ppt3SrzqkcyeAU-Q@mail.gmail.com>
Subject: Re: Need help for my Unraid cache drive
To:     Patrick Bihlmayer <p.bihlmayer@gmx.net>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jan 30, 2021 at 1:59 AM Patrick Bihlmayer <p.bihlmayer@gmx.net> wrote:
>
> Hello together,
>
> today i had an issue with my cache drive on my Unraid Server.
> I used a 500GB SSD as cache drive.
>
> Unfortunately i added another cache drive (wanted a separate drive for my VMs and accidentally added into the cache device pool)
> After starting the array and all the setup for the cache device pool was done i stopped the array again.
> I removed the second drive from my cache device pool again.
>
> I started the array again - formatted the removed drive mounted it with unassigned devices.#
> And then i realized the following error in my Unraid Cache Devices
>
>
>
> Unfortunately i cannot mount it again.
> Can you please help me?

I don't know anything about unraid. The attached dmesg contains:
[ 3660.395013] BTRFS info (device sdb1): allowing degraded mounts
[ 3660.395014] BTRFS info (device sdb1): disk space caching is enabled
[ 3660.395014] BTRFS info (device sdb1): has skinny extents
[ 3660.395733] BTRFS error (device sdb1): failed to read chunk root
[ 3660.404212] BTRFS error (device sdb1): open_ctree failed

Is that sdb1 device part of the unraid? Is there a device missing? The
'allowing degraded mounts' message along with 'open_ctree failed'
suggests that there's still too many devices missing. I suggest a
relatively recent btrfs-progs, 5.7 or higher, and provide the output
from:

btrfs insp dump-s /dev/sdb1


-- 
Chris Murphy
