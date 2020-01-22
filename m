Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6418114490F
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2020 01:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgAVAoB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jan 2020 19:44:01 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38261 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbgAVAoB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jan 2020 19:44:01 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so5470918wrh.5
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jan 2020 16:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5+W+VxFOA78+a5m4gtLC843G+e/8Ji+WI9o9/bkBjI8=;
        b=BXquigFZvDYaQOhMqEsSsn2cKSnWHuPapOA8SpZMNLul9fYFtk4oKLnQzfKbUQr/1V
         KgJ/cwDWgc02bPeVqRNB4bhAwRGhrcir0px1PvV0r/MrO9swRDms57+bIhU8npfe8pcW
         dh3oRHqHz9vctjf3Me+lX/uGqDrAn7OCuh4xqRKoy0cMXhSXD1ZwEhSDSMT+5V1wieVy
         eLQLgpbxj53ZDPWzLPaeAF3bkoKjN6aF17Jbv6crR7FoRb2wswMQyLux7vCZjy+unAwV
         4j3XlS7UJqpLou2KcX2XXzA38ln8zgCiHs6EnS/hLPG1p7HkUE66IWpEWW0zO9OxL6oX
         qWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5+W+VxFOA78+a5m4gtLC843G+e/8Ji+WI9o9/bkBjI8=;
        b=Qu86xD9aLxlpjsMwhEHvZTBQb47E3Jp8qfguNHzm8j+2D0IgJ5KRjQzEbs0BnDrBI0
         M38PLKQvVOto9u0FGTZTNg4a6bPvRBW1xKjffYi+V1FiPsXqO2fcDNfWDBDB3c0zSVdL
         yXmbEBN4RM4uroxLMLGgHcx8mgzye2EvnCUtzyOQkVCQMGYlg/5wNk9KtvBhkayosQYh
         rKbdTVxmeohiAh2UCx19XriMYfHXphojKwLqGDmKlm+FevyN+kmp0A/bOpnk7B8qlHQg
         Q5ZbWZ5BBOe4qHbMFkO78/ZgsrSdU/Yr16Ue5bcc46CGSpoVoWSStNtdEaNn+tNJ0MVM
         fMew==
X-Gm-Message-State: APjAAAUvaP+GloKSpzh8r93MMaxv778Inmq6i6CT3ST3g19wuc73RFUA
        GaSZOgz+KSIrZbzUPJI3HqQH+yt3pXbQx1/VrHPw9qk439c=
X-Google-Smtp-Source: APXvYqxix7T/0R5y1lNdIAGky2GdqXdppG6B6Xknfcq68Ju7pmiMvAB+i7ZZg6IVc5XKRDpFMLnKKThdEXxwmS8FaZ4=
X-Received: by 2002:adf:f308:: with SMTP id i8mr7710812wro.42.1579653839781;
 Tue, 21 Jan 2020 16:43:59 -0800 (PST)
MIME-Version: 1.0
References: <CACurcBus8d2RYTtVOheAvJcohY5jmP=akKUw1hen5seccfGihA@mail.gmail.com>
 <91be9396-4142-94ba-ea79-0baf8dc4800a@gmx.com> <CACurcBtC3ynvVcgS0yo2aNkxELxevc9Y=LO9eQ+hZSoB+3cMDQ@mail.gmail.com>
 <3af6a8b4-4102-4f4e-67f7-deda839e0cf5@gmx.com> <CACurcBsoOye4bZ9JxSV2zaEiMRGnhgUs5EZdhcxf5=EXQ0_6yA@mail.gmail.com>
 <0949e592-6564-8617-4e8f-fda1e9bdcfb1@gmx.com> <CACurcBsdPYCba8SjvTRxToPkwKvy3Y_85+GhqV91uS51Tv4b4w@mail.gmail.com>
 <226182ca-e389-2506-1751-79b7d0b4ec24@gmx.com> <CACurcBs_q=Zvt4_f4iJ5fupUR0b5OnsFzx6mZ7GeAw8kSgtp8w@mail.gmail.com>
 <CACurcBueqFjkX43timLY_OCQ97KOdwwj742XEFJJY+d290SnYw@mail.gmail.com>
In-Reply-To: <CACurcBueqFjkX43timLY_OCQ97KOdwwj742XEFJJY+d290SnYw@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 21 Jan 2020 17:43:43 -0700
Message-ID: <CAJCQCtRbDCciOEbLWf+SuH4TsrFesVOUiRRj=_SSM9KnWW+8=g@mail.gmail.com>
Subject: Re: BTRFS failure after resume from hibernate
To:     Robbie Smith <zoqaeski@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 21, 2020 at 4:00 AM Robbie Smith <zoqaeski@gmail.com> wrote:
>
> I think I have a hunch as to why this issue has occurred. I've had two
> btrfs partition failures, and both times it was upon resuming from
> hibernation. The key file for the encrypted swap was stored in
> /root/key-file, and the openswap hook unlocks the encrypted root,
> mounts it, reads the keyfile for the swap partition, and then unmounts
> it again.

For sure if it's a rw mount it's a problem. I'm pretty sure even ro
mount isn't guaranteed to be ro, it's only ro for user space but
kernel space could still write. I think the only sure way is use
blockdev --setro before mounting the volume.


> The very first line of swsusp[1] has a big fat warning about touching
> data on the disk between suspend and resume, and in hindsight I
> imagine this action may count.

Totally counts. The hibernation image has its own view of the file
system which is restored when resuming from that image. I don't know
enough about the work implied by not merely syncing the file system at
hibernation time, but forcing an unmount after the hibernation image
is written; and therefore requiring it be (freshly) mounted upon
resuming from hibernation. That would prevent this problem, but then
also makes hibernation entry and resume more complicated.


-- 
Chris Murphy
