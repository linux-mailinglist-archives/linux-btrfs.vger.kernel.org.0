Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA8B3158A9
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Feb 2021 22:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbhBIVaT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Feb 2021 16:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234206AbhBIU5A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Feb 2021 15:57:00 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C49AC061574
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Feb 2021 11:02:13 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id l12so23405427wry.2
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Feb 2021 11:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SYcphlIN6dLNR6a1FsHxnAGmP9jd4fXXXbjOgu38KKY=;
        b=womYaCcVCzxO+YSREUzrDYNc/M5BvtDtpIn5MMSxXr/9r+fOFy9EoDCHA4Sc3ek+s7
         qVCVHaU9y31IucNlv6onlXyjXf2LiWcDM1dqWF1BRvgvHd4vkK/ss0y7kNl3B2Es6ZRG
         kmBpg2OBp7FG+UTGauF1FYHIrEmvUCDzd1zhAPNof5Aa+FEnHySp0Qdbz8Hzy0SaA7+r
         5qC2roDzXP3bhTzqZtrEATU863gYA4UZZfQahD6DDXcR6tjANqGMqvsEK1tDTeADzIbF
         8xwD9TM8XpkFUbmPDaC0nZ7DKCQ6b4aJ6R+T88aXXfnmVnvp91Rx2sPaU6PNikbeX5es
         Z2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SYcphlIN6dLNR6a1FsHxnAGmP9jd4fXXXbjOgu38KKY=;
        b=NpVJVqC2CvZQk5NoMGJO84TIR8ZTZuLgDGfPf/qo4c6lQ8U/Q9tHJQU6O6MsudbkqG
         v0Nz1+LI9pOyBGN7HuV+9anT3aFlzr1OCp9NXKbRoav84qPgLgZyaSiWe4ldQiwCLtg1
         s2kNfswANyzegUrP2PFYo98EuY2SEdm4FQ8HPOfM1EzOQJXGyIi9zX3kuf6jTwtbTYZU
         +z+XmlIhfwdeu0GGL51iZzpk3GgDfzse8cLETUL9QH5If0tUhcj7MJjd39G+7pBvcMC8
         f3US+3l2QjQrbE4iNT4PP/uRidtpu0iYr7DcjojEvyIbOP9mqyuJjwPoGrneFWLuFOC8
         1/zA==
X-Gm-Message-State: AOAM530eCjtJdWUyPiBipGDGJ3qSiqbOzwz9B3w6y79LwMvHPpFsa2me
        uA9z+QJGp3HDHCbqH8SOnLmfr9lDlRLzJERHMkdWfA==
X-Google-Smtp-Source: ABdhPJz0mWEvOGHEoeDHrpYxB0lO0kPVlL95BgE2j1+ZTJE4W5QxitU1oZLJjAugVyDitRzaXMhWlWErG4GOLL5gdnE=
X-Received: by 2002:a5d:6983:: with SMTP id g3mr3419775wru.236.1612897332123;
 Tue, 09 Feb 2021 11:02:12 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtSx=HcCRMiE0eganPWJVTB+b4zfb_mnd68L2VapGGKi7Q@mail.gmail.com>
 <3897f126-e977-d842-f91d-b48b74958f3d@libero.it> <CAJCQCtScUYMoMpw==HTbBB6s0BFnXuT=MvSuVJYEVBrA7-RbHA@mail.gmail.com>
 <839d9baa-8df5-7efd-94ee-b28f282ef9ec@inwind.it>
In-Reply-To: <839d9baa-8df5-7efd-94ee-b28f282ef9ec@inwind.it>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 9 Feb 2021 12:01:55 -0700
Message-ID: <CAJCQCtSqESuYawuh6E8b6Xd=z4D13J2=v-6rn8+0mwuThXNtkg@mail.gmail.com>
Subject: Re: is BTRFS_IOC_DEFRAG behavior optimal?
To:     Goffredo Baroncelli <kreijack@inwind.it>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 9, 2021 at 11:13 AM Goffredo Baroncelli <kreijack@inwind.it> wrote:
>
> On 2/9/21 1:42 AM, Chris Murphy wrote:
> > Perhaps. Attach strace to journald before --rotate, and then --rotate
> >
> > https://pastebin.com/UGihfCG9
>
> I looked to this strace.
>
> in line 115: it is called a ioctl(<BTRFS-DEFRAG>)
> in line 123: it is called a ioctl(<BTRFS-DEFRAG>)
>
> However the two descriptors for which the defrag is invoked are never sync-ed before.
>
> I was expecting is to see a sync (flush the data on the platters) and then a
> ioctl(<BTRFS-defrag>. This doesn't seems to be looking from the strace.
>
> I wrote a script (see below) which basically:
> - create a fragmented file
> - run filefrag on it
> - optionally sync the file             <-----
> - run btrfs fi defrag on it
> - run filefrag on it
>
> If I don't perform the sync, the defrag is ineffective. But if I sync the
> file BEFORE doing the defrag, I got only one extent.
> Now my hypothesis is: the journal log files are bad de-fragmented because these
> are not sync-ed before.
> This could be tested quite easily putting an fsync() before the
> ioctl(<BTRFS_DEFRAG>).
>
> Any thought ?

No idea. If it's a full sync then it could be expensive on either
slower devices or heavier workloads. On the one hand, there's no point
of doing an ineffective defrag so maybe the defrag ioctl should  just
do the sync first? On the other hand, this would effectively make the
defrag ioctl a full file system sync which might be unexpected. It's a
set of tradeoffs and I don't know what the expectation is.

What about fdatasync() on the journal file rather than a full sync?


-- 
Chris Murphy
