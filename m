Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90DAF12C994
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Dec 2019 19:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731531AbfL2SKz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Dec 2019 13:10:55 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39683 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730575AbfL2SKv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Dec 2019 13:10:51 -0500
Received: by mail-wr1-f65.google.com with SMTP id y11so30880465wrt.6
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Dec 2019 10:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rpr1/9B/H39KrgHrCruKIT/pYdFoZ30zgYc/bll3umE=;
        b=OAspP8uikRJ3neb4NZ/j3whDw0mCmRF+ovqVfnJSeLR/3HhHW2CtcpKyoX+B0WPPRr
         rVOwWCbIGLQDzmEfBcIzOauGYuVoyOxFOd+ukLcmSrr4Kb5Bozd3oDz3hOheTFxurtJ2
         2HZ+zqmhcDKNoraffKFmiLG6rcU/FXVeYYREZBqCVYf5jWIVlHLKB78pXSGqjYTzh7/D
         wpOKLtJEZINYxwiBgbKeUk9U/jAMjBJDeMdgRLqAVHnejeo6b0nf2by27zBhq7zBVh4M
         jf+eU0rC4RkUG2vprnkheEx2BHqr04vkqMfpvHBF/caYrGNwdsvPYgcvJDeWTdu1LSkQ
         NSyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rpr1/9B/H39KrgHrCruKIT/pYdFoZ30zgYc/bll3umE=;
        b=io6aelJsjGfYuF3oDwVaYeud+hx4kRhvW1YJuSBF+2SkwIWLR8mP8zDLVQ+yycfRbj
         QXUOJ+rt1zFlJTegg9XByr+F2lZ7BmsPTF5cDkmxoWSsUNFaPhM8fST3QJywtZ67137y
         s99LI/J2gw9G+aknaRpllWb8EQCEiVR/9UzS2Madbl9dXmk2Dlx/iUu+A6z48Bbnm0oE
         zUWUpQ+dbyWjA84jvzHf48TF4BtnbCHxDIU4eq6jBvMQF2OaH9bZvqgPyFDBm4IwxA6h
         4lMjhDiQPximdW1X44ge+U2OoLUPXcIMMqNHrjmCbLghVAd4OC7Awui5OFbAOXGDXxTM
         e39Q==
X-Gm-Message-State: APjAAAVB/9v6AmvLmnR7zxZPTGNl/3Z0TsV7b10GeGktjtZYH4vr1sdC
        j1OXpTn9rb1uU+CKf402FARsaCCRgw1RjdKj7oF/Sw==
X-Google-Smtp-Source: APXvYqzMHF8Y52AFKT88SlJ41og1dqiUg6G5HDxYp6OpcuykdLa1TyYLTMn4H0x4j3Z5tevow1Wozu3icUTVAeRmBnc=
X-Received: by 2002:adf:9c8f:: with SMTP id d15mr62978296wre.390.1577643049815;
 Sun, 29 Dec 2019 10:10:49 -0800 (PST)
MIME-Version: 1.0
References: <19acbd39-475f-bd72-e280-5f6c6496035c@web.de>
In-Reply-To: <19acbd39-475f-bd72-e280-5f6c6496035c@web.de>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 29 Dec 2019 11:10:33 -0700
Message-ID: <CAJCQCtQ-ApthkeKtSgsFN+JuTpPoX0OFubOGQdbz=OnNkphB_w@mail.gmail.com>
Subject: Re: invalid root item size
To:     Matthias Neuer <mneuer@web.de>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Dec 29, 2019 at 6:40 AM Matthias Neuer <mneuer@web.de> wrote:
>
> Hi,
>
> since I updated my system I noticed a lot of messages like the following
> in dmesg (sda8 is /home).
>
> BTRFS critical (device sda8): corrupt leaf: root=1 block=78397440
> slot=32, invalid root item size, have 239 expect 439
>
> I did a 'btrfs scrub' but it didn't find any errors. Then I started the
> system in single user mode and tried 'btrfs check' but again, no error
> could be found.

Scrub compares block contents with its checksum, if there's a match,
no error is reported. But the contents of the leaf might not be valid,
with the leaf's checksum based on that corruption. In recent kernels
there's a tree checker that does a validation check.

The tree checker code is what you've hit, and it's saying there's a
problem with the leaf contents. Depending on the update you did, it's
possible that this is corrupt leaf has been there for a while, and is
only just now showing up with the newish tree checker code, in 5.2 and
5.3 kernels.

> I read that the issue could come from bad RAM and so I ran memtest86+
> for 12h but it seems my RAM is ok.

Could be the result of a Btrfs bug in an older kernel, and it's only
now being caught because of the tree checker.

>
> Is this a real problem and how can I fix it?
>

Good question. The kernel message is very convincing, in that it
suggests it knows exactly what the problem is and what the expected
value should be. I'd like to believe 'btrfs check' could fix it.

What do you get for:

btrfs insp dump-t -b 78397440 /dev/

If there are filenames in the output you can remove/sanitize them.

btrfs check /dev/

This should give a good idea whether --repair can fix it, but we'll
need to hear from a developer about it first. In the meantime you can
make sure the backup is current.


-- 
Chris Murphy
