Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B93F6306566
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 21:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbhA0Uvr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 15:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233424AbhA0Uvn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 15:51:43 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274CEC061573
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 12:51:03 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id c12so3314943wrc.7
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 12:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T8UhTsgyAVrPbyAdtKQvyUMWCyeEaElQ5MFiZfhzEQY=;
        b=Pd0M2zASXMflMJXK5Ny3jIwL0sCy9GBwzImpwkxHQUxY14wxtf65CWEbCfSCL86pxG
         qt3G5H4A+mA+w9Xp+HLmkVzXiIKje/G/ThZ89SiApWMbMMAzlSv2r+iE5swxxRnfgJO0
         tainZv5dL6hNV4lHJC2cpqwyB4i6IkhB3jSusN+OhW3ew3s4/boV0CnPJN+dg1IFsBki
         S+q9QbuIE/451EiqKfDK3b6ncivF84VxVX36dDNZxKnzEYuoiYTGOQPoXuJDdNs+iXIu
         W0nNFzaUzsZVbBhLcxL1El+B3VGKY6WadH8VnXaJkyxiYxuzNTtoQVRpiL7oveVlQLL5
         qqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T8UhTsgyAVrPbyAdtKQvyUMWCyeEaElQ5MFiZfhzEQY=;
        b=k5rP9GfVJTzU//PcVqm+Ag9otsmbPJTVpcApl+8i5SOYQvWdNtCzP6d5lpFgOoUSvo
         /ZEeyNrCCUMDxgQ7Y/BgPJ+b+S2i4nNjH+q93CK36z+CKYUsT0YqxX+H1cS3+3cjnuTd
         jWXFopbm88NGznT8nl5pra/62ugVbNp3tApWWkZaX8hHJ3sOSsrKqfwqzJuDgHGy7eGn
         ZEK/Pln4cxN/DZB1hYheyXj3hi1jdkeUJNjltOH51s73KpcST2kOtF0boKjKevmiU89C
         cv1kQI0Mf6I5bZxkYQVObpwzvdC2uNVeBFc1uR0qJlSxv1aqp8kSmbOTSP5nW0ZtpgiZ
         AY5Q==
X-Gm-Message-State: AOAM533ilHXQ+wJyWbBAsmlIFoj/vvpmF/O6Fa1J3OpHevQBVSZZhc5h
        DiAoV/lT8eV62bAEsOr7af0crdliL4l54UuNayRa0k94phb6DA==
X-Google-Smtp-Source: ABdhPJyUOK8GMMS1VU8zXiW9wrNlGMZJnuBPot2u+KgpfuxAU88tyET8dGxWbgY5JHdja42ebInpaGYenc21FFqIHj0=
X-Received: by 2002:adf:83a6:: with SMTP id 35mr12890410wre.274.1611780661952;
 Wed, 27 Jan 2021 12:51:01 -0800 (PST)
MIME-Version: 1.0
References: <cf9189c0-614c-26e8-9d3e-8e18555c064f@rqc.ru> <CAJCQCtQFniOd53+3FFoOo4UM8CzY_vranrrHiWH86HugNvaOpw@mail.gmail.com>
 <635ef4db-3854-d544-474b-4ecbdea5bc0d@rqc.ru>
In-Reply-To: <635ef4db-3854-d544-474b-4ecbdea5bc0d@rqc.ru>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 27 Jan 2021 13:50:45 -0700
Message-ID: <CAJCQCtQKZFd-evfGhJk6eti1ZjRJFZN8LuNde=499gnF6fLcVA@mail.gmail.com>
Subject: Re: btrfs becomes read-only
To:     Alexey Isaev <a.isaev@rqc.ru>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 27, 2021 at 1:57 AM Alexey Isaev <a.isaev@rqc.ru> wrote:
>
> kernel version:
>
> aleksey@host:~$ sudo uname --all
> Linux host 4.15.0-132-generic #136~16.04.1-Ubuntu SMP Tue Jan 12
> 18:22:20 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux

This is an old and EOL kernel. It could be a long fixed Btrfs bug that
caused this problem, I'm not sure. I suggest 5.4.93+ if you need a
longterm kernel, otherwise 5.10.11 is the current stable kernel.


>
> drive make/model:
>
> Drive is external 5 bay HDD enclosure with raid-5 connected via usb-3
> (made by Orico https://www.orico.cc/us/product/detail/3622.html)
> with 5 WD Red 10 Tb. We use this drive for backups.
>
> When i try to run btrfs check i get error message:
>
> aleksey@host:~$ sudo btrfs check --readonly /dev/sdg
> Couldn't open file system

OK is it now on some other dev node? A relatively recent btrfs-progs
is also recommended, 5.10 is current and I probably wouldn't use
anything older than 5.6.1.

> aleksey@host:~$ sudo smartctl -x /dev/sdg

Yeah probably won't work since it's behind a raid5 controller. I think
there's smartctl commands to enable passthrough and get information
for each drive, so that you don't have to put it in JBOD mode. But I'm
not familiar with how to do that. Anyway it's a good idea to find out
if there's SMART reporting any problems about any drive, but not
urgent.

-- 
Chris Murphy
