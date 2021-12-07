Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F4246BEED
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Dec 2021 16:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238854AbhLGPOY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Dec 2021 10:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238899AbhLGPNx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Dec 2021 10:13:53 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A153C0698C4
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Dec 2021 07:10:19 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id n104-20020a9d2071000000b005799790cf0bso18465703ota.5
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Dec 2021 07:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jZud5oR4s/NSr0IMDIM8/bDatvyPuIAqWLHw7ozuliE=;
        b=jy7wbqw8E1Vb+p1EKEG8EwzsFEnM5wnNtAuZ1Dtjdq2LPNFiQO3ye3gxP1t0Cr0RUd
         hvJMvIQpjRZg8FMzPITAx14Z9Z21CUzjhqoK8XkgedzTiQuL47mlE3sJmJduyviYAavF
         JZeY9bJMrFhfsqWI7M5vGIzNksY2ekKlm2HqLjk/920p16ZpK4AzdFLx3L3dRW659oB4
         EdIOTC5J0sEpCzdLsVaF3aqh73OBQGK9nJb0QW2kz9rmH+IOam+Cfuj7U6+RawDgtfeP
         zmbOyqK3hjrfloJonxBQqQfKTYOrhYcOfOHwJB8Wu+neINPHJDfzw4ZeHDUMTDiIKIyR
         s57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jZud5oR4s/NSr0IMDIM8/bDatvyPuIAqWLHw7ozuliE=;
        b=Dqqos6VE8gPVFY7p2EPvhLnqQpXLyw60LXJHQ7eSs7gqu6DOEX8DzrKYi9wHaJuFYx
         H1NhC1Wb2F/fq7pJ9GxrfabwoJFSsohZ1WJ2BKWrXKkxdzZcz48vqUgAY2576cFbR8Vf
         YncfwjXh8j9kW41hiMwvdmV+QQ38Wl2CpBml+5ZFi3ih+6VMyYa717kwRtfT0SA1yIvw
         ZVcHBKT3mIbGFEkCUsbAfyF05E02khRBePuN6orbaYm0O3vudpNV0wqKPhJ/zbjrz7c+
         xBWiQJvjkBxpD2sENnvYLka6623g2f3CVdfv3HO32T8yZkwPDmJhn72SjkPVv7f0qhPb
         mKyA==
X-Gm-Message-State: AOAM5317IcgzzvMO02Shgdu6F2FnGDJI2S0XC9d2YSF2fDriJLNffqMv
        b86Kma4etFAZ7p7PDhUa1EA66Rj+xsYyKMI4SDJ3TdnC
X-Google-Smtp-Source: ABdhPJwytRwxiyDUTgU685EaqOiFPxRqyN1i851hwTkhLBHUsEKPNzfZOs5oWhDwh3hQp8GPNFHKNg38zA0LSTy3YDE=
X-Received: by 2002:a05:6830:2692:: with SMTP id l18mr35979400otu.353.1638889818544;
 Tue, 07 Dec 2021 07:10:18 -0800 (PST)
MIME-Version: 1.0
References: <f001f3e81d413ea290722c38b14d95f3f1f52249.camel@scientia.org>
 <25d305e5-c75f-3d71-fc5a-c2019e49bed9@gmx.com> <c64be50bdc99b993b910a7ab019af8d552eeb0d4.camel@scientia.org>
 <b7b6a6a7-700e-f83d-dae6-581ed6befbef@gmx.com> <3239b2307fae4c7f9e8be9f194d5f3ef470ddb8c.camel@scientia.org>
 <20211207072128.GL17148@hungrycats.org>
In-Reply-To: <20211207072128.GL17148@hungrycats.org>
From:   Jorge Bastos <jorge.mrbastos@gmail.com>
Date:   Tue, 7 Dec 2021 15:10:07 +0000
Message-ID: <CAHzMYBRf63mcgVHiO-8o2UFffjB7Y+7FiOdnWRRb7RzfOBhi5Q@mail.gmail.com>
Subject: Re: ENOSPC while df shows 826.93GiB free
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Christoph Anton Mitterer <calestyo@scientia.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

Disregard my last email, it is the same issue of metadata exhaustion,
just didn't understand why two identical file systems used in the same
way in the same server behaved so differently, if I convert metadata
from raid1 to single it will leave some extra metadata chunks and I
was then able to fill up the data chunks, of course now I can't
balance metadata to raid1 again, I wish there was an easy way to
allocate an extra metadata chunk when there's available space.

Regards,
Jorge Bastos
