Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C921C795A
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 May 2020 20:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729995AbgEFSZH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 May 2020 14:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729701AbgEFSZH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 May 2020 14:25:07 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F7EC061A0F
        for <linux-btrfs@vger.kernel.org>; Wed,  6 May 2020 11:25:05 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id l18so2451214qtp.0
        for <linux-btrfs@vger.kernel.org>; Wed, 06 May 2020 11:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P/gFMrD9YWYRY9NtIsBa7oseVLVqas8L8yU2HHG6ZhY=;
        b=s3DvDctWaEpa+3bXUKfFreh5r6fi92zT35O3kR2y5BzLMTJC83HAjlp+e7ln2U+FiR
         pj2ngU26HHKHQyg7/DIA2cRHb6kj039YQcbgbHhZT6egykgFHqgab0h8EkxC76c31T0m
         luq92+s/8eJYRFl+iavABFwh5zj/CTLuPwiMFIaL9iKqXtM/uBbJjZ6jDt2GmNmfgAhi
         Vkvuq+AYw3rMmUBqWcHUudhyWA0riT/Dg1Tr8l772cdInq8XKStuf/LmoQV/1DNcYqHT
         4glf2BP/nXR1slSvQ39Yqy/muZpSijjD8d709VkL65kX3DGSz+BQ8drdIWDLiYFpLSsh
         6OKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P/gFMrD9YWYRY9NtIsBa7oseVLVqas8L8yU2HHG6ZhY=;
        b=lMphpTUc+Q75LfcX6wR90a5Zj6Gu+kTAT5n4mmDRtIkHsgx3VkNrbsARi8dAm02xqj
         8Axlcrh3sn80JNoXRGvE1gUDvURTCckdC9sZ5jGgL1sY426M6av8brDIOJfytCJ3x+6Y
         fCkxd4hRsfiB5eGiJrjKx1tCquePKrDTYPorefIJoiKBtj2HrQvFH7jr86olCzRVT0+X
         U+fxeTFGO3QAECPxF6iDPVfhQNxW/gHYMXAexxd2XksGhi2+YK0Ni2i3Up/lJZczIUgY
         8ORO1OegHRkxvRVoN49BMZuTZ4bFYHXiXJk65E461DgiP0etUM2EAeGToFsv7Aw2rFp1
         eX3A==
X-Gm-Message-State: AGi0PuYRTvq7b41ayowFonIjEWjCgSAjAL3ZW5zeWcPA+RysomdHK8mf
        uYR35jcGWr27L2SFZseOaTlq+gyne3d0uu6VbjBL4AQrJow=
X-Google-Smtp-Source: APiQypKPhrkmYp8sLRSOUEMQ5GgjtsrV3b88HRZ/TpsD6s406VDqsEdC/TVBZ+dn/3QnArasz6XFLsBksDPAhDtGIa4=
X-Received: by 2002:aed:3223:: with SMTP id y32mr10368509qtd.133.1588789504539;
 Wed, 06 May 2020 11:25:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200411211414.GP13306@hungrycats.org> <b3e80e75-5d27-ec58-19af-11ba5a20e08c@gmx.com>
 <20200428045500.GA10769@hungrycats.org> <ea42b9cb-3754-3f47-8d3c-208760e1c2ac@gmx.com>
 <CAK-xaQYvgXuUtX6DKpOZ2NrvkYBfW9qgGOvMUCovAjVBO2Ay7g@mail.gmail.com>
 <a7d16528-b5c2-0dcb-27fa-8eee455fee55@gmx.com> <CAK-xaQajcwVdwBZ6DhZ5EYax2FL28a6_+ZfsPjV7sqXeQ3RVKQ@mail.gmail.com>
 <628479cc-9cc2-ac05-9a0f-20f3987284f3@gmx.com>
In-Reply-To: <628479cc-9cc2-ac05-9a0f-20f3987284f3@gmx.com>
From:   Andrea Gelmini <andrea.gelmini@gmail.com>
Date:   Wed, 6 May 2020 20:24:52 +0200
Message-ID: <CAK-xaQYTNCv8tA=_cR1H4u-ZCy80UFFNjP+CLM1=zuNhoU_x_Q@mail.gmail.com>
Subject: Re: Balance loops: what we know so far
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Linux BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Il giorno mer 6 mag 2020 alle ore 07:58 Qu Wenruo
<quwenruo.btrfs@gmx.com> ha scritto:
> Thanks for your dump.
>
> Do you still have the initial looping dmesg?

Yeap, you can find the complete syslog here:
http://mail.gelma.net/btrfs-vm/syslog.txt


>   If we're looping on block group 12210667520, then it's possible that

Oh, well, from the syslog above:
May  3 17:14:25 ubuntu kernel: [  586.735870] BTRFS info (device
sda1): balance: start -musage=2 -susage=2
May  3 17:14:25 ubuntu kernel: [  586.735974] BTRFS info (device
sda1): relocating block group 12479102976 flags system|dup
May  3 17:14:25 ubuntu kernel: [  586.833331] BTRFS info (device
sda1): relocating block group 12210667520 flags metadata|dup
May  3 17:14:25 ubuntu kernel: [  586.939172] BTRFS info (device
sda1): found 26 extents
May  3 17:14:25 ubuntu kernel: [  587.021568] BTRFS info (device
sda1): found 1 extents
(and then repeating lines like this)

>   (Sorry, not sure if I could convert the vbox format to qcow2 nor how
>    to resume it to KVM/qemu, thus I still have to bother you to dump the
>    dmesg)

I guess no way to migrate the saved state of VB to QEMU.
Anyway, I have prepared a minimal Lubuntu 20.04. It starts up, run
VirtualBox and let you to replicate what I see.
It's ~40GB. If you cat it on /dev/usb-stick you can boot up  (no way
to run it inside KVM because of VB need to access VT-x).

I'm uploading it. It takes lot of hours. I tell you know when done.

> If that's the case, it would be very interesting in how we're handling
> the data reloc tree.
> It would be very worthy digging then.

Good!

Ciao,
Gelma
