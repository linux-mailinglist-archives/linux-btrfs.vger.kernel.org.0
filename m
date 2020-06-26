Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F1720B11F
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jun 2020 14:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgFZMIx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jun 2020 08:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727977AbgFZMIx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jun 2020 08:08:53 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14ADDC08C5DB
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jun 2020 05:08:53 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id z2so7245378qts.5
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jun 2020 05:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=28tjY+8EndFVMAlQrFKFaVmtvJlOmgqG5RWA2TYa7PI=;
        b=AJDoyrDxGelcZ9S5sgyY9wjxeUCV7NNck0v3758kz8uFmq0T191B3Phgb6JK19vA5W
         iDzR4K9cNfkyEnWqt3a+3nlK/NC+/LJF2rw8BTIwoyHMcFNI1xpfzV1ANh1+r6tcQxb2
         Bq2Aoo0YaAt3Rl6laW0EPORe1/wn53wOZArYcaEeatssKCziYMZJO+X846M8nASedHf9
         gc6rMDcAhREspHoOZUn94WxzcKair5rcK4Ldd+zmWB8aKAgZ0fBkBhvi1/vgFEvdCE7l
         dqHdostNDW/jCpQWZWSrfQDWS2r81j1hNelSwVAvUDEM0mk++SUr5dEwENqtp6eqWyqq
         dAng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=28tjY+8EndFVMAlQrFKFaVmtvJlOmgqG5RWA2TYa7PI=;
        b=rxGtAm5Yx18PsWOinViEDNEahlkci4Fa1QBAl/YYO/qBEwOo1FinxOIUhqkFJx5lIH
         FUJJ4BnJu0plgal79FIwR2JtkjsdWyUcneO5pGP8tfdtrSYWsEhGNHf8/EvHnHeXLirz
         bXbk3xuFVjzQeQ4Si1KJAB8Wjh1moUkhA8dMfaUrQfDYRPyrrBtnZtr2DmfHjghnu0wQ
         zeSuCHNuqz0bK3C78fQh+5P8JeZmISNU5lfPPUyO5ZreRgGIzwiR0ni3Pu52Oh7n1m7l
         1jekgBZyczgsQNZ32/JjWjixg2ehSISz/SP2hw7ilfmAXnwEAb5cNC/NGjE4R437YEHo
         sTzg==
X-Gm-Message-State: AOAM533AR5K7ww8Gj5Vx5yC4R3qLuIFgwTSmH+lwn/UCK+jKSXb+n5E6
        AbsLF136SQKyA3gU+PElOYSMb7hb6HdDowHPMWoPkw==
X-Google-Smtp-Source: ABdhPJzMcGOP6QwO5jEknggSJxq77QHLd2GowmaHJOB4cBpeJJW/KGXu1/MTfkYAFgc/xOz32VBAxPkxq5ndS5FXT2A=
X-Received: by 2002:ac8:5188:: with SMTP id c8mr2430813qtn.1.1593173331957;
 Fri, 26 Jun 2020 05:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200621054240.GA25387@tik.uni-stuttgart.de> <CAJCQCtSbCid6OzvjK9fxXZosS_PAk2Lr7=VTpNijuuZXmRVVEg@mail.gmail.com>
 <20200621235202.GA16871@tik.uni-stuttgart.de> <CAJCQCtQmrc5m=H6d6xZiGvuzRrxBhf=wgf8bAMXZ_4p8F3AJFw@mail.gmail.com>
 <20200622000611.GB16871@tik.uni-stuttgart.de> <CAJCQCtQ8GFAdg2HJY_HqDgW8WAp5L1GoLbKqUN2mZ7s_kS-8XA@mail.gmail.com>
 <20200622140234.GA4512@tik.uni-stuttgart.de> <20200622142319.GG27795@twin.jikos.cz>
 <2E6403C5-072D-4E71-8501-6D90FB539C15@fb.com>
In-Reply-To: <2E6403C5-072D-4E71-8501-6D90FB539C15@fb.com>
From:   Tim Cuthbertson <ratcheer@gmail.com>
Date:   Fri, 26 Jun 2020 07:08:40 -0500
Message-ID: <CAAKzf7=gQCMCECtnFwry8+LzuVCkkfeYX6VsAUcrnONtyaF18A@mail.gmail.com>
Subject: Fwd: weekly fstrim (still) necessary?
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

---------- Forwarded message ---------
From: Chris Mason <clm@fb.com>
Date: Mon, Jun 22, 2020 at 10:57 AM
Subject: Re: weekly fstrim (still) necessary?
To: David Sterba <dsterba@suse.cz>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>


On 22 Jun 2020, at 10:23, David Sterba wrote:

> On Mon, Jun 22, 2020 at 04:02:34PM +0200, Ulli Horlacher wrote:
>> On Sun 2020-06-21 (18:57), Chris Murphy wrote:
>>
>>>>> You need to check fstrim.timer, which in turn triggers
>>>>> fstrim.service.
>>>>
>>>> root@fex:~# cat /lib/systemd/system/fstrim.timer
>>>>
>>>> root@fex:~# cat /lib/systemd/system/fstrim.service
>>
>>> I'm familiar with the contents of the files. Do you have a question?
>>
>>
>> You have deleted my question, it have asked:
>>
>> This means: an extra fstrim (via btrfsmaintenance script, etc) is
>> unnecessary?
>
> You need only one service, either from the fstrim or from
> btrfsmaintenance.

Dennis=E2=80=99s async discard features are working much better here than
either periodic trims or the traditional mount -o discard.  I=E2=80=99d
suggest moving to mount -o discard=3Dasync instead.

-chris

Apparently, discard=3Dasync is still unsafe on Samsung SSDs, at least
older models. I enabled it on my 850 Pro, and within two days I was
getting uncorrectable errors (for csums). Scrub showed 12,936
uncorrectable errors.

While I was trying to recover, a long SMART analysis showed the actual
drive to have no errors.

Then, the first recovery attempt failed. I had deleted and recreated
the partition. When I was copying the backup snapshots back to the
SSD, uncorrectable errors showed up, again (4,119 of them after
copying one snapshot). I then overwrote the partition with all zeros,
and when I copied the snapshots back to it, there were no errors.
After recovering my filesystem, scrub still showed no errors. So, alls
well that ends well, I guess.

Tim
