Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B509422F912
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jul 2020 21:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgG0Ta2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jul 2020 15:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgG0Ta1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jul 2020 15:30:27 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497C4C061794
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Jul 2020 12:30:27 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id a5so6028693wrm.6
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Jul 2020 12:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mu1rr05/8jM8/H8z0uzXdyaJbIhmkF6xYHWKzS/CA0Y=;
        b=YfUOEggqJwf3rCMvfCADIqQTrC2VZSu69ecLONlujj7Az8v0UbZ4vPxLYRFrUgyIsc
         D9Rnvj19mBBx/TDHe9y1MNNDMjU6hIo/drwibdwtwv8GLUCxk353gu7Gz4EK9qxCl+ph
         7cYnCWHz58WePgWLd9ahwYbK3WHq5VXl6LLKA/iwoNksBNaVpckCzOlqoS1mame+YN7t
         SuUFdKnO4kxS3z0zDYmmWu/J7hgsw6K7FHH5HSN1viDIO4gRe5jBmc1cM7WYo9weuwFt
         LW+Ec7MJPpHlKd2PHuMr1BKL6zh5lODwHTULEjZxqDh3cQ+XpcK4nBDuilVC5gmZRx5J
         L3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mu1rr05/8jM8/H8z0uzXdyaJbIhmkF6xYHWKzS/CA0Y=;
        b=e4qxXCyTNUMcMkKCD+BYzNXtnAAzujgXQRQtsKUrhFG3rV1B1VL1g8fZFDUDBFJSN9
         PSw3L7FzMTKDoQU9WLjJ3nLNoSIzlA3i+XEB+eLU0+GDrEql/fBQmDceWTN4x7K7URXf
         NLSZkzqo6lJE5pYEGH9vd0PJg4NfXQW8G8M/rcOOCP09jq33YhvMx9u9fqCg8+4qDNVX
         hThv4xBJKUhBftxu/9/6h9V5Y6Jz9m4OBom2THTJ79Njrc749ilsRA/jwu4U8fkL8AnF
         dedWCQZVO25ZR/P3C35FqKsYBeCNDSezE+tb0vVgwiHUMbK9PLxEUY4kcTluE6S71MZD
         KoSg==
X-Gm-Message-State: AOAM531mfFkJrkbSm6L30U/eZ5OSKx2bwYciihVaLhexcxbnEtBhHVJv
        Y1kO0ZL9h95JT00XlpxCYMx8XU8D04/8ZAr4PAps3A==
X-Google-Smtp-Source: ABdhPJybcSiM2+7PhGC260pOlB9heyb+Hm52m+OlzNBb0Z9R0o6fIRk2jksaWaKqUMPmpGsQw2QlkbVvV3a3yLGNvhI=
X-Received: by 2002:adf:aace:: with SMTP id i14mr21137633wrc.236.1595878226052;
 Mon, 27 Jul 2020 12:30:26 -0700 (PDT)
MIME-Version: 1.0
References: <3225288.0drLW0cIUP@merkaba> <20200723045106.GL10769@hungrycats.org>
 <1622535.kDMmNaIAU4@merkaba> <558ef4c5-ee61-8a0d-5ca5-43a07d6e64ac@gmail.com>
In-Reply-To: <558ef4c5-ee61-8a0d-5ca5-43a07d6e64ac@gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 27 Jul 2020 13:30:10 -0600
Message-ID: <CAJCQCtRgug3uTLBuraWmCiCoAY9VV94nQ0TBXz9jkUyuRhLnzQ@mail.gmail.com>
Subject: Re: Understanding "Used" in df
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     Martin Steigerwald <martin@lichtvoll.de>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 27, 2020 at 10:43 AM Andrei Borzenkov <arvidjaar@gmail.com> wrote:
>
> Unfortunately, "df" does not display "free" (I was wrong in other post).
> But using stat ...
>
>
> $ LANGUAGE=en stat -f .
> ...
> Block size: 4096       Fundamental block size: 4096
> Blocks: Total: 115164174  Free: 49153062   Available: 43297293
>
> $ LANGUAGE=en df -B 4K .
> Filesystem     4K-blocks     Used Available Use% Mounted on
> /dev/sda4      115164174 66011112  43297293  61% /
>
> 115164174 - 49153062 == 66011112
>
> But there is no way you can compute Available from other values - it is
> whatever filesystem returns.
>

It's definitely goofy in the odd device raid1 case. If I fallocate a
file equal to Avail, Avail is not zero. The fallocated file + new
Avail != old Avail, which is just not at all correct behavior. So I
keep fallocating files to get to 0 Avail, and instead I'm only chasing
zero Avail condition. Once I'm close enough, and delete all six
fallocated files, I end up for a short period of time, an Avail that
seems reasonable but is way bigger than it was at the start. And then
a minute later, without any additional action on my part, returns to
reporting nonsense.

It's pretty confusing.


-- 
Chris Murphy
