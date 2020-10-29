Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAFC29E491
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 08:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbgJ2HkA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 03:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbgJ2HYs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 03:24:48 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C0EC0613A9
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Oct 2020 21:34:26 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id i1so1329350wro.1
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Oct 2020 21:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iIafFTKTCpoQpjE3obAjnh3fVBd0XVCAififu+byI4M=;
        b=GwBiD7G+FUYhP+AMKNM5iIBgQ1b6MjU8DR4jVZdnkqIxyXqjU87uXSLE36Bws6Z4OA
         8g3A300ySzdbq6u+UyD4gaLQVEa5P5mXgoh+2ZLNrcxrq0r95r7LKoj2pngxawO37wdw
         IZ3OGO0nNIFmKhzBqST4KXPhO6W24c+bqYMpKkkJ+t6SOHL3NlVqksEmfY6+WRGAzL3Q
         NmUstuKFJF6E2YvdKZbM12W4vE7VNiV53/tPOM2Q1lQ5efI7Bi8xpQMDPDNvinoejwuu
         EKQiWRF9y2g9ceTMSZ8x8AgkfM15bkPnUq2K2U5euf+6CW4z88f8ae0LDdtpKymyezK9
         Ic0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iIafFTKTCpoQpjE3obAjnh3fVBd0XVCAififu+byI4M=;
        b=EtIxUMXJ6O8qI4GIA77G02lZHrDj1RJGvn1udgH4AsxA72A8fPlfTZaOrLWTIBnVbv
         kOu3F1RfVc8paqkgknR9xS6j4cOSpe0aAk8nNDlkhVUfX2dpXEtiwshnflBVK4aZ2mF2
         oB8cdd6Q+FAX5+VH0AzoWCCGF0q3YkDrQfFy94mXXldI5P8XDfpBe0FURmo4QTJrVWqL
         b5am+tpK3vtLZu5qkgDM7ql3sWBBPE3vtw0rKTkCb83pxH3+yQRE2RY9J/AKV0DV0g1U
         kAUSohBGh3bRCGxPXQvty15g8XrqLpwEZOuVcjdG1mqx51MJrvi/T777HfRqqPNhkasY
         7goQ==
X-Gm-Message-State: AOAM532WEupZtMrhizVzFCDYqa8Kww2kxNDIX8RYkuhM1ghuf1glZwp4
        cPv2u9ar1lKGI2vNJBGBA6Tu6U8GVN0r5h/Z4CWolw==
X-Google-Smtp-Source: ABdhPJx/gO08tec6Z9f5oRtghhVasw98weg7RxLfRxURX6wJAiNYQo8R+FqZiaL+TWcRSxSKfEnhs7pb8NXU9Aa0XOs=
X-Received: by 2002:a5d:6ac6:: with SMTP id u6mr2979475wrw.65.1603946065554;
 Wed, 28 Oct 2020 21:34:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAA85sZtGM1Gia7FjunVN4+r4uikQeAPTYAU53QCcT=QQTyt1bg@mail.gmail.com>
In-Reply-To: <CAA85sZtGM1Gia7FjunVN4+r4uikQeAPTYAU53QCcT=QQTyt1bg@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 28 Oct 2020 22:34:09 -0600
Message-ID: <CAJCQCtQtVvOZx9Q-YsrEN1VW_zn_1ipWCahjMAR8hx_pr6b00g@mail.gmail.com>
Subject: Re: questions about qemu io_uring/dio
To:     Ian Kumlien <ian.kumlien@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 28, 2020 at 4:17 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:
>
> Hi,
>
> From what i understand, DIO is supposed to be supported...
>
> But when i switched qemu to use io_uring it seems like the filesystems
> on the VM:s get silently corrupted... (they also run btrfs, and it's
> thus detected)
>
> The system is mounted as nodatacow, I can't set +C with chattr so I
> assume that the images are actually noncow
>
> Any ideas?

Could be related.
https://bugzilla.kernel.org/show_bug.cgi?id=208875

I'm not sure if the fix made it into 5.9 but pretty sure it's in 5.10
but just haven't yet had a chance to test it.

-- 
Chris Murphy
