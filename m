Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696921C7FB5
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 May 2020 03:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbgEGBHC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 May 2020 21:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgEGBHC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 May 2020 21:07:02 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA518C061A0F
        for <linux-btrfs@vger.kernel.org>; Wed,  6 May 2020 18:07:00 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id r26so4804438wmh.0
        for <linux-btrfs@vger.kernel.org>; Wed, 06 May 2020 18:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rOFdgBNlKh2knVOwd6z7/l4insiuzknIgmPN+WNVSaI=;
        b=TTO0zTs7bu4PxgcX5OQ+j9+X5Wgd6SrxyNxlKvQ7rvFgYrRtnZAS/9IEbPfarC1QSR
         qRDT6GQXou/KEAc0Q9slBW/5esgHmAYqHHe8xg0MKViFu6T37AYEvJ4FoxqFNSlzhrKD
         jSrLylClU7WGpQ3SEiFAgf0crvNUOGlBKuSkjwpf9Zjf+Tti1hPdA4n/d5P6D7QmR1Wt
         mH4vMsZRhQ3M/j83z5XhBplVbyfvF/pXenoeOwXpD7SW9pnyI62+EWo21Ng1M9SQJqIi
         iB+762sQlWS+jecVQ2IJIiIl84ys+tKlekimsTs7ojk8pza8VbqZ4IuXX+xUBO+nsbOn
         uyvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rOFdgBNlKh2knVOwd6z7/l4insiuzknIgmPN+WNVSaI=;
        b=oiNvYDVxrNIk3GJ9qvNWnc6EQz0KKtOYwi3eZE+xwA3RDP3O5mMVb4wp0CmVdd8q91
         b6xHmJp22+wQtsqUfXGD2uoY6kqt1lgrHrbjLcADKvHhik2gJBCj1cEmrGTG3EGsJ2Ta
         bwd02TJPc5eYNrfMeBnk3A8uAQGnb8LYUA/kQ/KnuRvXcv63zmFaAE+4nSl+3zWZnlCi
         wRQ/LnjZPdYNW0h2drbzfY7ALx5cW72t79rvJdlJeqMmkCx5PW4hS/UHYMh6eNEJseYW
         6IHI5eygO0QTzYHUeYt+ONEyzGUmC2ItmyhpcRYPFeGoYj1KRUT47FML9b2e2nn2iLbH
         RXjQ==
X-Gm-Message-State: AGi0PuZhzL/zADzFXM9OJZsGOG9FPBnf4y2Tx76kORFtczxHLzDLFpSx
        yTflnyV1sRDfaM74i0LM8WQuG8l17r1lpZSXg8Anbm/Kz2M=
X-Google-Smtp-Source: APiQypIVH0Oy7s2AZnmOdmWHbGBy3BB8Qubu8HN+LCRtl0C6rP4GumcVqcSc2kWx+8ujIMuBZi+Tr3DsQfnyMArNdVY=
X-Received: by 2002:a1c:7c13:: with SMTP id x19mr7292266wmc.124.1588813618872;
 Wed, 06 May 2020 18:06:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAJheHN0FUe-ijMco1ZOc6iKF2zbPocOw+iiVNeTT1r-JuXOJww@mail.gmail.com>
 <CAJheHN3J85eLmZZYs0-ACoUQFuv3FVHmAnoJTxB+Xu8CGnCy5A@mail.gmail.com>
 <CAJCQCtTqxWymZK5Bb5V8FJfur2dJUgrwZs9b1D4CNWGYjvEv_A@mail.gmail.com> <CAJheHN1rKTrUUF=jGdDwEDYtLYZZ1F2eME+at4kuvNQr1RfF1g@mail.gmail.com>
In-Reply-To: <CAJheHN1rKTrUUF=jGdDwEDYtLYZZ1F2eME+at4kuvNQr1RfF1g@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 6 May 2020 19:06:42 -0600
Message-ID: <CAJCQCtTXDifBP7kF90y9wq5=a8J+o69j47t17+GTjckjKkoGNg@mail.gmail.com>
Subject: Re: Read time tree block corruption detected
To:     Tyler Richmond <t.d.richmond@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 6, 2020 at 6:51 PM Tyler Richmond <t.d.richmond@gmail.com> wrote:
>
> Kernel version is 5.4.0-28. Just upgraded to Ubuntu 20.04.
> btrfs-progs is version 5.6
>
> That inode search returned an error:
> ERROR: ino paths ioctl: Input/output error
>
> I don't use any subvolumes.
>
> The next command also resulted in an error. Replaced the actual
> mountpoint in the error with /mountpoint.
>
> ERROR: not a block device or regular file: /mountpoint/
> ERROR: device scan /mountpoint/: Input/output error
>
> Something definitely doesn't seem right.

You need to substitute the /mountpoint with the actual mountpoint of
the file system, be it / or /home or /mnt

-- 
Chris Murphy
