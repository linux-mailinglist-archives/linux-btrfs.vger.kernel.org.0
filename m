Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA8A4D2388
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Mar 2022 22:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346294AbiCHVrH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Mar 2022 16:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241531AbiCHVrG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Mar 2022 16:47:06 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335AE5522B
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Mar 2022 13:46:08 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id w7so373424lfd.6
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Mar 2022 13:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KiVXm2JHZg4d7hys7fzdokyAQCcalPymJU3zf9SxzD4=;
        b=tDr45eY/dC5V+w6QGTatiP7B5BgbvHRu9ulaNwdpW53nfeEbCiK8NyW3Q1N3cqiVrN
         zv3r/CYkJ6fMk0f0o+4PfLxhsOTrlxvXBbpBMhVmDMwrGoQa79qcn+/6X/0YRUzH4m2Z
         pSRUL/I2ap16xhDB5Z9aCF40ou3bv3w6dqJn1kwuNqyvcII79XCMfleCzVqL2LYQuKgi
         fhAbt4aGlm/dkwPU/TeAPyMNKUX258AwO5LCx6G9bkOFm4Yoy3qudOcfxYvHW9EOaBmm
         ueNrgOZi/QhLWZAwDrZFhhuBDwIaVhKODUDF/iRjq3q6IxTn5NyoGQ/OdOHdPN8CV0nA
         JAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KiVXm2JHZg4d7hys7fzdokyAQCcalPymJU3zf9SxzD4=;
        b=jTXAzorjLAbDIs0QOw7U4+nKxhARMQOWuIDltbFpIMekLsNJpKryY3uXjGZhl38nkT
         OFOJLcPCqDOrymnn3hlaJeAqK2m95zkTR0IdHeT7okz/LYrDdVIhdgnDYTpxAHaE23Bk
         tr3NPhZIwgbr6EH7Uj18aDrCPYd1rtaIoDwWFajWpSeGjqp21QwwIkNcc00YsvIDQDsF
         krLpdFsKYdJpplm0v+gwg3HbyIBxJzldKgk2IV67l91URn/v+cgTXCudc++T45YvdYVO
         m4nqX1R40fkxKumvo5/oaXDmVbZ+rACNjdChswsbgJkIe4K+KZRfJjpReJQDPUrXR0Jv
         PWQA==
X-Gm-Message-State: AOAM532B39OzTePXxKXntsPGIdi6ivdKz2ehr3XEOoWICZWIFayJn0l2
        yfyCnSPtM7dDOB60uMq7+/Rq9ajd4URslt+u5btQs/DXScac00wW
X-Google-Smtp-Source: ABdhPJw873ayxPtk365vXCqOZxUhhoCU50dp//VICNZm+oKIL9JRviM6sdz+MfwkLbYdvuSKHKN92ckIwJ4x8f9dJSc=
X-Received: by 2002:ac2:5986:0:b0:448:3400:47be with SMTP id
 w6-20020ac25986000000b00448340047bemr6250185lfn.186.1646775966354; Tue, 08
 Mar 2022 13:46:06 -0800 (PST)
MIME-Version: 1.0
References: <CALPV6DsfOQHyQ2=+3pKF3ZfavL21fgthQS+=HStEfMQbhZU50g@mail.gmail.com>
In-Reply-To: <CALPV6DsfOQHyQ2=+3pKF3ZfavL21fgthQS+=HStEfMQbhZU50g@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 8 Mar 2022 14:45:49 -0700
Message-ID: <CAJCQCtTWGW4nQWWsROXrovW0uRHf70d_Cn4NeYNNqX=JhfXvFA@mail.gmail.com>
Subject: Re: Updated to new kernel, and btrfs suddenly refuses to mount home
 directory fs.
To:     bill gates <framingnoone@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 8, 2022 at 12:05 PM bill gates <framingnoone@gmail.com> wrote:
>
> So, I recently attempted to upgrade from Linux kernel 4.19.82 to
> 5.15.23, and I'm getting a critical error in dmesg about a corrupt
> leaf (and no mounting of /home allowed with the options I'm aware of)
>
> [ 396.218964] BTRFS critical (device sda2): corrupt leaf: root=1
> block=10442806968320 sl
> ot=8 ino=6, invalid location key objectid: has 1 expect 6 or [256,
> 18446744073709551360]
> or 18446744073709551604
> [ 396.218967] BTRFS error (device sda2): block=10442806968320 read
> time tree block corru
> ption detected
>
>
> Interestingly. that 18446... number is a power of 2, looks like maybe
> a bit flip? dmesg, uname, etc included in pastebin below. "btrfs
> check" found no problems with fs on either kernel version. Would like
> to figure out how to fix this, if possible.

The read time tree checker was added in 4.18 but there were
enhancements in ~5.1 to 5.3. This could be a bug introduced into the
file system from an older kernel.

I'm not sure why btrfs check isn't seeing it. What version of btrfs-progs?

You can recover by copying the affected files out of this file system
to a new one while using a current 4.19 series kernel. It won't hit
the tree checker error. One strategy could be making read-only
snapshots and using btrfs send receive to replicate to a new btrfs
file system, using 4.19 kernel. If you can isolate the problem being
triggered to just a file or a directory - you could copy that
directory to another file system, delete it, and then copy it back.


-- 
Chris Murphy
