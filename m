Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 142DF2C5E5C
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Nov 2020 00:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392046AbgKZXzl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Nov 2020 18:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388084AbgKZXzl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Nov 2020 18:55:41 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C84C0613D4
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Nov 2020 15:55:40 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id t4so3815320wrr.12
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Nov 2020 15:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NGiv+NlOo3+7zVxMJ9b1SktLR8q64hUIY0m7ExgtDwA=;
        b=ZoOCoD5OmIyf/kC+sfD7SNJt6kTKGo9KC3vSXjMI6dvJ9U5lgY26C+NE46hPMRclvC
         TJYM4Rs7QR5SSJfoxy2vklyB7QLqZwtVr6E2itv5CJG6OKtmy/c9tkwPqs0rUtMp3/aO
         5Oeapx4o/cIYsZq8ngZsW1gWZc7YwM17WeQgrw3l0EulMGC2aj5hsuRVhC1e63lY5739
         wF9tIApAk50olWJncLd/Y0AMM4i2fJ5Hm7qTVmAK4WTXPGY6LBIhECYP7iovTu7wODJi
         9TlBN3CSRbxvXYMSUI1SQshUe/+zChspVG5KjxqeVxIGhpy5DnOLJpxT9Gf8mBxz+vEC
         5ucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NGiv+NlOo3+7zVxMJ9b1SktLR8q64hUIY0m7ExgtDwA=;
        b=FY8TImKGqKBxK6Hz3sX7NNlyT+SbwrIWGpPpi38cRWcGagDNZbDQwSka305XAQZDDq
         +O/v3nLLwMhOL89Gub4p1Nd+bqdHKreZVXMwbeQVMlVr8qakLawtaVhG2Ux+BVO3T9JC
         sJJe+yPuTpf5VL5tXMQ91xPQbiIyfp+OlAlHuCwtSe3v3BfEDAkliqwIfM2jKnPxLBG2
         8FbNe9D6r8j8aUuFUK8u0swHQ1fVQoA0LNsVvaSoBHMiw745S94jXLSpMWeKzPP5DhYD
         jKsj2uHvhLZ/0ApQWinJfIue3fYZpOq48TLjHSkyw14qeWk8UWBp8BLu6OAgT0MCneqL
         c9gA==
X-Gm-Message-State: AOAM533GrbP6+h5MKpuIauXLGbAGV27vuS/ZrHE8GRdWw5kYfpU6XXtU
        cTX6mmemixgBzIxsaaETbltxk4O9g+pEx101Zh3PgKXNISNeig25
X-Google-Smtp-Source: ABdhPJyGJBgjq4sLRp8ledN41uHG374CzRaGoAxeYRk2CK8RNXUrCOmMAVL5Eh9T8CImYCOnHxApurkFOLhiCFaOIyY=
X-Received: by 2002:a5d:620a:: with SMTP id y10mr6665709wru.236.1606434939398;
 Thu, 26 Nov 2020 15:55:39 -0800 (PST)
MIME-Version: 1.0
References: <CAD7Y51gpvZ79nVnkg+i3AuvT-1OiXj0eaq2-aig38pGmBtm-Xw@mail.gmail.com>
In-Reply-To: <CAD7Y51gpvZ79nVnkg+i3AuvT-1OiXj0eaq2-aig38pGmBtm-Xw@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 26 Nov 2020 16:55:21 -0700
Message-ID: <CAJCQCtS0HVBQZ1-=oAhvYnywUVuhjS__8qf553YMoRWriabADg@mail.gmail.com>
Subject: Re: corrupted root, doesnt check, repair or mount
To:     Daniel Brunner <daniel@brunner.ninja>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 25, 2020 at 2:16 PM Daniel Brunner <daniel@brunner.ninja> wrote:
>
> Hi all,
>
> I used btrfs resize to shrink the filesystem and then used mdadm to
> shrink the backing device.
>
> Sadly I did not use btrfs for the software raid itself.
>
> After shrinking the mdadm device, my btrfs filesystem doesnt want to
> mount or repair anymore.

First, make no writes to any of the drives until you understand
exactly what went wrong. Any attempt to repair it without
understanding the problem comes with risk of making the problem worse
and not reversible.

What were the exact commands, in order? Best to use the history
command so we know for sure what every relevant command is.

> # btrfs check --repair --force /dev/mapper/bcache0-open

Yeah first mistake is to try and repair. Fortunately it looks like it
couldn't get far enough along to even attempt writes.

I don't know anything about bcache so I looked at this:
https://wiki.archlinux.org/index.php/bcache#Resize_backing_device

So the question is, what was the bcache device cache mode? Writeback
or writethrough? And did you confirm that bcache reports a clean state
before doing the mdadm resize?

> # blockdev --getsize64 /dev/mapper/bcache0-open
> 40002767544320

What do you get for

# btrfs insp dump-s /dev/mapper/bcache0-open
# btrfs rescue super -v /dev/mapper/bcache0-open

Importantly these are read only commands and make no changes.


-- 
Chris Murphy
