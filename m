Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 733543C2962
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jul 2021 21:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhGITEe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Jul 2021 15:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhGITEe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Jul 2021 15:04:34 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5810C0613DD
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jul 2021 12:01:50 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id x21-20020a17090aa395b029016e25313bfcso6595677pjp.2
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Jul 2021 12:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zjPYFNP/4bWKiS4Tt52QOU/BI4y3bdEiErjfd5IVs2c=;
        b=uBWIWPPYjSttNfmPCuemXtVlpX4iVC/cS83hzvgsEx6opc6oP/yFcj2aLHBI0pOxO1
         c0MgAhUMwKZcUK43aozGDWPUwSSckiRbn1Mo99t/7v0W5DBVLYy1mWLDwHOuuk7VBRrv
         O7pA1RJ60z4vD83qRFd3RHIHk2nFqGxdSV0z1i1+COiGmr8wkrcc43sIO0GnHFVT0Vff
         u+oo1NSU4NsRtjamF69bOXV72jK8s/82RmSigddcieA4W4DOGCHS/JO8qeEW0wj7+QSb
         T883Tusk5i8owiUHZ0OZ1bj0iXw/C3XzXWnDbn1dfMm4eCcRltr3dExSzeN7UsDk5vfN
         GUAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zjPYFNP/4bWKiS4Tt52QOU/BI4y3bdEiErjfd5IVs2c=;
        b=hE2bABGRAU/Ixi8Y37olfM2LuCEClx7L4nfKeXk+DX33WmR98cF2UVL79JwIfCdoi2
         /gSNrIMO+b6KTpREyBV03IeYM7Ah4kZdmoYKYHmn4l3pBtMin2ky/KHK8uuSWwctd1Qi
         6QNPmXwF1HOCAb5NI9bPk9DMo+T4EaOejzsGuxCCgNGFt6y7sjxlyXuK5I5huSXGo6zp
         7QWh6emTKtbK/HKeDwD126NR7pJVqmLi/is24I7sVqxvALnzwClMpXTGEgvMZhbbYh1R
         +o5D4VJz+W3Wggn3bh+dMrF6mB1URblU+IsjVAttif+xxpzWH09kiuZpembqNhytb9IT
         k1Dw==
X-Gm-Message-State: AOAM531MUpMYWtBa8FRRlwBtvxdEFtDM3t5YNN5Nz8pfQRcSQErme9CS
        y0G/5EfeLG7Id1QSvu+oxsTjRaKplLiuWLML04CH5MSdRPwafg==
X-Google-Smtp-Source: ABdhPJwjFqf9rtBsmxAPuHaUFvFSqBTJpUBYcjiwWVIaX8KPBw0r3R0kedMylE8ACGDUOoCc8jnhQGJ64ku/XuZvzGk=
X-Received: by 2002:a17:90b:3647:: with SMTP id nh7mr5419457pjb.228.1625857310313;
 Fri, 09 Jul 2021 12:01:50 -0700 (PDT)
MIME-Version: 1.0
References: <CALc-jWwheBvcKKM79AD7BA5ZZQs7D407acgwOiwyo9R=U98Nwg@mail.gmail.com>
 <20210706161908.BE32.409509F4@e16-tech.com>
In-Reply-To: <20210706161908.BE32.409509F4@e16-tech.com>
From:   Yan Li <elliot.li.tech@gmail.com>
Date:   Fri, 9 Jul 2021 12:01:39 -0700
Message-ID: <CALc-jWwAW9yaoHgXvWykUiovYKCPzv3SuZVjBpsmp8i3CdgUEw@mail.gmail.com>
Subject: Re: autodefrag causing freezes under heavy writes?
To:     wangyugui@e16-tech.com
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 6, 2021 at 1:19 AM Wang Yugui <wangyugui@e16-tech.com> wrote:
> The message 'blocked for more than 120 seconds.' show which job is
> blocked.
>
> Is there some message like 'watchdog: BUG: soft lockup - CPU#XX stuck for XXs!'?
> that show which job blocked others.

Nope. There was no such a message.

> so a full dmesg is useful.

Here you go
https://pastebin.com/TwChmFmC

> If there is no good info in the full dmesg, the call trace of 'freeze'
> status is useful too.
>
> echo "t" >/proc/sysrq-trigger  will output all jobs call stace.

I'll try next time. I can't reboot this system very often, since it's
a production system.

Thanks!

--
Yan
