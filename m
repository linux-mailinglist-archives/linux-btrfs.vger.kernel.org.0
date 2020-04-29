Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189561BE73F
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Apr 2020 21:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgD2TVv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Apr 2020 15:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726456AbgD2TVv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Apr 2020 15:21:51 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC62C03C1AE
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Apr 2020 12:21:50 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id u127so3312161wmg.1
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Apr 2020 12:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hz05wIgjvzUoxDrjJYL27Pnl9qBDlVEwVtf8Pa7ptf0=;
        b=XCEj2ImyMB8+TzzwGQBiMTDi9WWDAcuGPDdWTnhD07zB9T3bMTcRppfehUeP+3sACi
         p2fZIDerMqniZx24Z4t2z+r31L8nkZ4rxYxFINfcQ0CwiUzD9C0EVAfEmfsCx1HdlNok
         N5f28yncqoephIqyUTrrj05fPKk8xVgqxKL47lMJ7JP0p6xLOCl/51mdodaS7JqSKoAE
         EWp/VeYQVJW+Tvynzz5G5PyaOUoe1RfEjf49VIyoq8FRAYqui+tBX7Bn1hm4+EJBEGmw
         69ZEjI2HW0Luxx8AdqK6vhlTCrBZ4xrMtbQ7HSQ2/wNbZYxkwh56WfRQLkc5XXn6sgM3
         h5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hz05wIgjvzUoxDrjJYL27Pnl9qBDlVEwVtf8Pa7ptf0=;
        b=IjYvm0fMW3W8/fNhoslUj0DSicvFWeH+jEB0bKCVUuAM2PNaP1Fh6vukpVFZNiP141
         rpxxqIB1bOuRmYZV7TPt3HmieljbPOEYpPXcun4Z9Bame33wacZPW985YBFuiKt/YSx2
         //VrLvjrCi/qkeIBENO3brqKB3rjf+8D4+hs3D1GP/bU2i9DSZ5o9bdFrsqhuamyd5TJ
         8t9i3dWlrL0zsYlu61m6UqXDVAafxxoLSZznJvj0wU7pHuZWaW/oBWlVuRhlY+Ii1M2J
         hRCUd0TJlDlS3RiOC4mwk9cY15NZ9MbKwXLIlaYrmZo3+Fd/EaCcQZywJ6Vww0bL3dCc
         T0Cw==
X-Gm-Message-State: AGi0PuYuXp/TIf3oa1YrZv2GAF6+o9931N2D8967oV3UkY4z/0o6+NBY
        8WUFStHM01yC3y8zRTp0QNSiYednT6Vp0KX0VZ3IgbxL
X-Google-Smtp-Source: APiQypIFDu4GrlAupEUm9eubyQqyxgDReG0a2omJzcZhOoMP2I478J3X/KOurmKoYdYKAy5C32LO3tZzyHAkEPZmbh8=
X-Received: by 2002:a1c:6455:: with SMTP id y82mr4802578wmb.128.1588188109443;
 Wed, 29 Apr 2020 12:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <0ee3844d-830f-9f29-2cd5-61e3c9744979@yandex.pl> <76ec883b-3e44-fcda-d981-93a9e120f56d@yandex.pl>
In-Reply-To: <76ec883b-3e44-fcda-d981-93a9e120f56d@yandex.pl>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 29 Apr 2020 13:21:33 -0600
Message-ID: <CAJCQCtTxGRqA4SZFnC+G+=b0bK2ahpym+9eG31pRTv9FH1_-3w@mail.gmail.com>
Subject: Re: many csum warning/errors on qemu guests using btrfs
To:     Michal Soltys <msoltyspl@yandex.pl>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 29, 2020 at 9:45 AM Michal Soltys <msoltyspl@yandex.pl> wrote:
>
> Short update:
>
> 1) turned out to not be btrfs fault in any way or form, as we recreated
> the same issue with ext4 while manually checksumming the files; so if
> anything, btrfs told us we have actual issues somewhere =)
>
> 2) qemu/vm scenario is also not to be blamed, as we recreated the issue
> directly on the host as well
>
> So as far as I can see, both of the above narrows the potential culprits
> to either faulty/buggy hardware/firmware somewhere - or - some subtle
> lvm/md/kernel issues. Though so far pinpointing the issue is proving
> rather frustrating.
>
>
> Anyway, sorry for the noise.

It's not noise. I think it's useful to see how Btrfs can help isolate
such cases.

-- 
Chris Murphy
