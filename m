Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7813509B3
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Mar 2021 23:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbhCaVoq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 Mar 2021 17:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbhCaVom (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 Mar 2021 17:44:42 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F016DC061574
        for <linux-btrfs@vger.kernel.org>; Wed, 31 Mar 2021 14:44:41 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id g25so64725wmh.0
        for <linux-btrfs@vger.kernel.org>; Wed, 31 Mar 2021 14:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z5wcsJ9yilkN+iHwRG+1ymtqNUa3QRy+MgTGIClWb7I=;
        b=oR089d0xCscp61BjcZo2VTC7ILwokbP89Q4HOI2YsPju+bJJKPIy3KiLLejqi4KTE0
         l/V+2KDJ/WzVBelPreLanIq1ParodVSxtWtt4OSZw7gDdfzOCiO1dBgnQMrFsWwc9WYH
         hmitB9dU9ashue+bgvFokwSRU7obNFGWOIcA5SRFmReEH5wxpYrh+9d+tJgokxGpPAeJ
         OcZPDgoC6+7vqPs1DSeJzdpKIASWHZAD6yTpmfDtlEazo6mi3+P6Owo6X/wyiAB8L2QD
         HkAIbyKcNszEYv/kdxL9yqjPxbZansNlR2EroTSAIBb6FKNI+u7kCrzwWywV/3uaxMV5
         UZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z5wcsJ9yilkN+iHwRG+1ymtqNUa3QRy+MgTGIClWb7I=;
        b=f3nXkdlDiSAcvQbKgt9yv5El50i79OoviCfJfFsPO1YwlD2eDiuzJHpJJ+10vKB7Ef
         yLERrDIFIjfbmMHrvGXnVYIWaKX9VyYOo9OgaV8aowQvNzZGDZkeDPFITb9tTJ/dBKQj
         3dMeYrR4zBLnzC2Mby2JEl98zOp4j8hEPhWnkfOxrIFfiFknO7vTzmZOBhyVqfHNV/HO
         6yM4o1aIxHu+npuKL/+W2Pl2wRS9jgydB06anw2/EMlXbznGJVQKHFDSUEdxjw7a/GV7
         5yzHEvkHzwG0lE/3FTHcaGY8NWl3WMZAOrV8QDDvOhYprdtPIXYqUXoG0Bno8ndjTvKw
         LVzA==
X-Gm-Message-State: AOAM531KwRpTDXyFRnZ3apEt2+t+RBVgCe/c230NtmGnvQkdtvQG4pE6
        XgCOdM+PVyKqGZBIiFghgQTglfW8qY2KhRiLGnaNsEO82VbkTw==
X-Google-Smtp-Source: ABdhPJxXq+UFjTUr9VyIPXdl03kOI/veuXWULpYnzP32if8Hw7TDshWYdQAr+RhaDk3uWHl9Z3X//Z+1gluhoe73rjQ=
X-Received: by 2002:a1c:b006:: with SMTP id z6mr4732861wme.19.1617227080655;
 Wed, 31 Mar 2021 14:44:40 -0700 (PDT)
MIME-Version: 1.0
References: <CABDFzMi0AXwBaiL-aFW1G5-UMwgTffza5hbr-9MNHWyGfmyDAQ@mail.gmail.com>
 <CABDFzMg1J_CDkNJ8JSvu2CkQT_ARHPw4_72C5BozbmYRxLKO6w@mail.gmail.com> <20210331142327.09af250d@gecko.fritz.box>
In-Reply-To: <20210331142327.09af250d@gecko.fritz.box>
From:   Thierry Testeur <thierry.testeur@gmail.com>
Date:   Wed, 31 Mar 2021 23:44:28 +0200
Message-ID: <CABDFzMiR=b6N+1mp_F4W1awig+kC2Qb3w18C6ev_S3jcQSKchQ@mail.gmail.com>
Subject: Re: Support demand on Btrfs crashed fs.
To:     Lukas Straub <lukasstraub2@web.de>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Yep, compression enabled (original fstab before having tried restore option=
s):
compress=3Dlzo

Best regards,
Thierry

Le mer. 31 mars 2021 =C3=A0 14:23, Lukas Straub <lukasstraub2@web.de> a =C3=
=A9crit :
>
> On Wed, 31 Mar 2021 02:17:48 +0200
> Thierry Testeur <thierry.testeur@gmail.com> wrote:
>
> > Hello,
> >
> > if anyone can help me with the problem above?
> > Have tried a Photorec (even if i know the chance are really poor), and
> > have got some non-sens files, lkie pdf of 2Gb, .... most of them are
> > unusable, except smal size file, like jpg pic...
> >
> > thanks for any help.
> > Thierry
>
> Weird, I would have expected photorec to recover more. Did you have compr=
ession enabled?
>
> Regards,
> Lukas Straub
>
> --
>
