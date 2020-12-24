Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842E02E22F1
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Dec 2020 01:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgLXAUx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Dec 2020 19:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbgLXAUx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Dec 2020 19:20:53 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC54C061794
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Dec 2020 16:20:12 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 190so319023wmz.0
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Dec 2020 16:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+DcqMo5wSEcJ1Q5P4TAuK4nPlYy9DqI9Q87lGrhsQdw=;
        b=uxLJA4zrJeFUMxGCVhQXiW0HciQj2JZkVf5ucISG9DoXJ2sRmdX3Dk2ZIzboX2Y29K
         dkph1Q5hAPmzzOweDM0Fj+XQejXzegQHOKSwpHxo1Ccis3SdMCq8lp+sXVbFHm0iD43J
         YI2QDHOLrpaHIfN5QKMXRNdM2sI1IPmQ8CDQIFJY17XowX7s76xHaVfS4j+FPcqzCcV9
         MBT2J0Bizm1ZUTXLtNLErfzeTEBZp2BRlapRwv2DghoUZ/ZMaGNY/A7NqFs5PgaNdogb
         8r2IKkgmgBc7aZLMaAdPkrKfU+te/I1g/ZNj5qS24OUf4UhEAh/oseAUheO9OwPUkQsU
         fWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+DcqMo5wSEcJ1Q5P4TAuK4nPlYy9DqI9Q87lGrhsQdw=;
        b=PnUJh1BQ+MgWxAkaIbpcH8v3E/MIneVOR0HenYOiNwuzsjjS77XidNgiWfJS0TN+GR
         1IzgVyE/aoa6iW85+lCWgslzFfatH5o0g/cehWjzzJgqWOj7ATcdl3mRUSutrg9u03CC
         o3amyllp7cx905XLMjPAI8oZ8B3bUjxZMRH+xcK/BWUsXjahuFv/TW14lqeD/WHQAe7c
         zMHV9bY4F+2uKejAl+k55YRNaTcpmOhZtEAgrOpzZvPMY2AbOe3GfjOcyDdFD2dUU+Sr
         MLWzwL3RxplOjD3VbXpQi4QmYKqgq87xSWJZzn8PWfTCFYjE6cE/xv1m6gDeTZDi85mK
         bTHQ==
X-Gm-Message-State: AOAM533QiPCoAR6JzGPVw1ArQlfzf91m3W486Wkf5aPVeIfw1KNgAVT7
        eenokWpdsVGi2faxp0VnMhp4THKekuMw0DEYeNtvMcTUto0R6aOo
X-Google-Smtp-Source: ABdhPJyUeiKSBO85VMlHlTIdG9Qve4q7ZsPmESjUhuyu5XkXdV607sIoZPgMWrlGi/Vi7jRHdRXYxDnGuChz7pE0HJ4=
X-Received: by 2002:a7b:cf0d:: with SMTP id l13mr1883563wmg.168.1608769211422;
 Wed, 23 Dec 2020 16:20:11 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtQZJ8Jo8rX0BL51k5DmC1GEs21CyvmEOhoYDoY=g6XwCw@mail.gmail.com>
 <e7a7ddd7-1de7-3453-6398-3a5acc7f5e18@gmail.com>
In-Reply-To: <e7a7ddd7-1de7-3453-6398-3a5acc7f5e18@gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 23 Dec 2020 17:19:55 -0700
Message-ID: <CAJCQCtS803Z+B9YHGq-bxhyjne3cncbmq+LiEchq8F3rxVAGKA@mail.gmail.com>
Subject: Re: cp --reflink of inline extent results in two DATA_EXTENT entries
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 22, 2020 at 11:05 PM Andrei Borzenkov <arvidjaar@gmail.com> wro=
te:
>
> 23.12.2020 06:48, Chris Murphy =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > Hi,
> >
> > kernel is 5.10.2
> >
> > cp --reflink hi hi2
> >
> > This results in two EXTENT_DATA items with different offsets,
> > therefore I think the data is duplicated in the leaf? Correct? Is it
> > expected?
> >
>
> I'd say yes. Inline data is contained in EXTEND_DATA item and
> EXTENT_DATA item cannot be shared by two different inodes (it is keyed
> by inode number).
>
> Even when cloning regular extent you will have two independent
> EXTENT_DATA items pointing to the same physical extent.


Thanks.

I saw this commit a long time ago and sorta just figured it meant
maybe inline extents would be cloned within a given leaf.

05a5a7621ce6
Btrfs: implement full reflink support for inline extents

But I only just now read the commit message, and it reads like cloning
now will be handled without error. It's not saying that it results in
shared inline data extents.

--=20
Chris Murphy
