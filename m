Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D74BBE55A
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2019 21:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732787AbfIYTIr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Sep 2019 15:08:47 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34063 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfIYTIr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Sep 2019 15:08:47 -0400
Received: by mail-wr1-f67.google.com with SMTP id a11so8228279wrx.1
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2019 12:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5XXkvFGYweUUgVgyg8r/i/7pRUuzoMQFXCTNqn8EWDI=;
        b=HbsG0mEoXYvi6ionCByQHFuCunM0vw9+li7nz7slObGParTqb9AU0uQGCOCJ4XzHi4
         WHBfNrnYf22+QRcIkUvhnb3FHz3qA3P78g41GBhDxCm5crn3XRwYINBBV9HF9aOXA96/
         MdBTGwv/7/CxpvAXY/e/m4zm5dzIljMdpIajzj3Rvn3H7a+2rY7i4WgWfPIHkhc4EYZQ
         ibjJ3RDJTg7zIJa6IOj4bz491mjUd6SFdml/S68ALDMieOR7wPHgddFqRVQTbh4W3/KU
         fonKD5bbose2kfhLbdq2t3Mw3nZjP58KlZOqMOmsMeoo83mqutV0Qskm9W6vkqk8+aTQ
         yV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5XXkvFGYweUUgVgyg8r/i/7pRUuzoMQFXCTNqn8EWDI=;
        b=iTKN8upjenV1YEhuSL3j05r/jTi+CW/SQjjSK3T7PicRj/plw7OTSUSsdQMDE05a4W
         eyOjGy4O5LuhaywJWkIz7e/SevsPIbDV8LNrg0/4sLmdLSa3eLCSwpHwvs7/qDgpxRZ6
         E4OGY/lMREBy2YMfAgvgJvC+pcute32nNyk8MUpmcLElmgcuA7Cf3vWZ/iBnJQ9/KVN2
         paTfWJZaqI71lwkysQbpSDn6v+kcGl9eFhFaX0G3EAXSKskXf5o2D5f9DpOlICOLeY6V
         mJWJKy6XjazKolrBrdUwrm7L0Epb08xdFwilhW7lcNjAJ0uF38PTJxRXa1wKhtKrh/YY
         m8lA==
X-Gm-Message-State: APjAAAWNXoz6S1l/mpMvPH/sbpH3OdAh5ptdpksZfOPkSfkrOn7ojjDj
        VFgc3Cn6vPXEXBZ4emf7Ey+Ce9KarlifSX6FhxNIZin7juoY5g==
X-Google-Smtp-Source: APXvYqw9AaGfcMkqzVVqPXkdzA0VVb/aMWRrfIWANwf38ygqGXm3o2oZEiwURS8JfmSexELcefLK2w6Yyi61WZLu+4I=
X-Received: by 2002:adf:f092:: with SMTP id n18mr5652558wro.262.1569438525216;
 Wed, 25 Sep 2019 12:08:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190925144959.p4xyyhn2d2sajxjj@matt-laptop-p01>
In-Reply-To: <20190925144959.p4xyyhn2d2sajxjj@matt-laptop-p01>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 25 Sep 2019 13:08:34 -0600
Message-ID: <CAJCQCtQwHRVs+XwnnUcktGcaRabZGG-UxS4o=g9y_MCiD4yG9Q@mail.gmail.com>
Subject: Re: errors found in extent allocation tree or chunk allocation after
 power failure
To:     "Pallissard, Matthew" <matt@pallissard.net>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 25, 2019 at 8:50 AM Pallissard, Matthew <matt@pallissard.net> wrote:
>
> Version:
> Kernel: 5.2.2-arch1-1-ARCH #1 SMP PREEMPT Sun Jul 21 19:18:34 UTC 2019 x86_64 GNU/Linux

You need to upgrade to arch kernel 5.2.14 or newer (they backported
the fix first appearing in stable 5.2.15). Or you need to downgrade to
5.1 series.
https://lore.kernel.org/linux-btrfs/20190911145542.1125-1-fdmanana@kernel.org/T/#u

That's a nasty bug. I don't offhand see evidence that you've hit this
bug. But I'm not certain. So first thing should be to use a different
kernel.

Next, anytime there is a crash or powerfailur with Btrfs raid56, you
need to do a complete scrub of the volume. Obviously will take time
but that's what needs to be done first.

OK actually, before the scrub you need to confirm that each drive's
SCT ERC time is *less* than the kernel's SCSI command timer. e.g.

# smartclt -l scterc /dev/sda
# cat /sys/block/sda/device/timeout

The SCT ERC value is in deciseconds so convert to seconds. The second
value is in seconds. The first value must be shorter. By default the
kernel's command timer per device is 30 seconds, typical consumer
drives are much longer. So depending on the reply from your drive for
that smart command, you might either change the drive timer or the
SCSI command timer - or it might actually be perfect. NAS specific
drives and nearline and SAS all tend to have short SCT ERC by default,
around 7 second. That's fine.

Note that the smart command is transient, when the drive powers off it
goes back to a default. And on reboot, the kernel's command timer also
resets.


-- 
Chris Murphy
