Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14B93BBC11
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2019 21:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733118AbfIWTLv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Sep 2019 15:11:51 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:32932 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfIWTLv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Sep 2019 15:11:51 -0400
Received: by mail-wr1-f53.google.com with SMTP id b9so15267368wrs.0
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Sep 2019 12:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MIVXt08T2+KUoN34R6EGryYxo7sA6EiIQGG8WzoKDR4=;
        b=vaciwl81f5ddaztNl9t8TI3X2KytIp47hgtQfXL7QaE5wpRodpgZLdtwJxWGurJLYP
         2y71EW0rwmkXCYvO0sam34zjcwuIGEQCT8vktGm5pM3SexX6nFoJ45GXnACeeJplLRm/
         55L/8bBwayx3aRpE7ULnpdRwk2O3kVCo0mnxogXgaaI+T9nXxtfvHfzuWrIan+iR8hrN
         nb2eaAAoTE4jMNhnmGrrDVLKBjpTsqe0a4NH0v9a20OXEzOfhXXEflWeUKc3J1OE+zA3
         /UFcaoS/YFvudTdcyw4vyaQm3iYFm2Y7p9jsuHC0O6scTSiSaJx1T/CMpCOsmSA6TVqB
         Zimg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MIVXt08T2+KUoN34R6EGryYxo7sA6EiIQGG8WzoKDR4=;
        b=WqBx6+JkuR4bhacG+kTqUVwI/4flNb81foN6k5mNRMNOeO2BSwSzj2iCVVbLAHKwI9
         0H24wLxZMxTQL1DpoPMEXX1emVgaVfn6pyIDrRwIKhwH5ef6eYf84qyWhWAqoUoXP/bv
         nI5qZXUA8iGvehQda6S/JHAWALLvYVbf9AwDuy7Y23iqKEDswHimIsYEUpoYPPNLyLxg
         hewoz2tnBUONi2HnozvIsp8u0p7ktauY27AR3XyzBSUAY0lmX3cKKx1O2y/4pgKIFmOQ
         /Ae14uURxgDNqHdViupbD1CHYaeJVSiCJ2+RJgXwVulRvtNPGHcYkjdNeT0J6W4MFhe5
         /8qA==
X-Gm-Message-State: APjAAAVsvWjSmdXNfN4RCaCInYKDSrFfSQbqacCzaENwTG3MEdHadaff
        xDUfunwPsfqDhUCRUFtBoxO50AQp7p8Pho1g+huMyg==
X-Google-Smtp-Source: APXvYqxdZu1xRV/de1xqBDkYE4e1aiKroa2nChdiVlx6uhSaOW6f9V0vGfBXgODjHhB9FydrnGcGVSrBiRCyO1iMvEM=
X-Received: by 2002:adf:efcb:: with SMTP id i11mr689501wrp.69.1569265909427;
 Mon, 23 Sep 2019 12:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <000f01d5723b$6e3d0f70$4ab72e50$@gmail.com>
In-Reply-To: <000f01d5723b$6e3d0f70$4ab72e50$@gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 23 Sep 2019 13:11:38 -0600
Message-ID: <CAJCQCtSCJTsk1oFrWObUBpw-MXArQJHoJV3BeBk0Nfv_-AoS8g@mail.gmail.com>
Subject: Re: BTRFS checksum mismatch - false positives
To:     hoegge@gmail.com
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 23, 2019 at 12:19 PM <hoegge@gmail.com> wrote:
>
> Dear BTRFS mailing list,
>
> I'm running BTRFS on my Synology Diskstation and they have referred me to
> the BTRFS developers.

If it's a generic question that's fine, but all the development
happening on this list is very recent kernels and btrfs-progs, which
is not typically the case with distribution specific products.

>
> For a while I have had quite a few (tens - not hundreds) checksum mismatch
> errors on my device (around 6 TB data). It runs BTRFS on SHR (Synology
> Hybrid Raid). Most of these checksum mismatches, though, do not seem "real".
> Most of the files are identical to the original files (checked by binary
> comparison and by recalculated MD5 hashes).
>
> What can explain that problem? I thought BTRFS only reported checksum
> mismatch errors, when it cannot self-heal the files?

It'll report them in any case, and also report if they're fixed. There
are different checksum errors depending on whether metadata or data
are affected (both are checksummed). Btrfs can only self-heal with
redundant copies available. By default metadata is duplicated and
should be able to self-heal, but data is not redundant by default. So
it'd depend on how the storage stack layout is created.

We need logs though. It's better to have more than less, if you can go
back ~5 minutes from the first report of checksum mismatch error,
that's better than too aggressive log trimming. Also possibly useful:

# uname -a
# btrfs --version


-- 
Chris Murphy
