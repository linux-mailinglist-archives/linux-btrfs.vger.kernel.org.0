Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7EE5467D4B
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Dec 2021 19:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239548AbhLCSfB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Dec 2021 13:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbhLCSfA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Dec 2021 13:35:00 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E7CC061751
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Dec 2021 10:31:36 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id v64so11883057ybi.5
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Dec 2021 10:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qMMUH2n47x5idBxzpnwobUZAnZoOsKzZsTacOauLFBQ=;
        b=pRCdLqnHMjFt0Lhqqqk+dOw9Yf90JjrdqB+lOPvKQ711lkxqjvvAeQISOTjOP98c9V
         LwHp65/DzsbWCT5ZuOiskHzxHkfnAUxZgxQ7MVUy/q4kxcsIadutrPPHPktQdI8VLWfS
         js3hZWdJ0amwuD9SB4hgEdAUtvPDDZd4Dx83DOsJYPmGv7C8L8xr1pbnq+FDsY8uxfDV
         frd235SpCkh3c2X6joHk2MLHzXY48EjytEQm6nYoh1g02v+IUjMc6L3YcGd0WVPF1UhJ
         SxZ+p3zHljbrlRLYa8ulJ22x29pV+qiKtdMaYje+Zr8pGc5T9b73jq545avZXGk74ihc
         KNhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qMMUH2n47x5idBxzpnwobUZAnZoOsKzZsTacOauLFBQ=;
        b=QMNzJgQRG4kM/nk5gsrNZpEC1hZSYdaJhbu8F2CZkW/L+fUPA5FLlEQbVZc7iPnzE/
         fP1La+qrkpQRaudjDDV4lMtVZgnIjXLUfWMChOEFwk2xfPyNO8upl5NP9xzGaW25GaTr
         CktEwfvZaXLQC8Qy7R94A0wzLKNad35DPWlb3UJ2rgjiAIiVKwm0WKdmz0gJGwJGbQfa
         d/XuaaFklklpRQd/wi9GCJQO/zEmf/l01Zf6aHVyVkyf/Z2MHgO8ZjxXspTFT34wbHyy
         jfkI5JgpIcVHLUPnDVD/iw4ah+r1NLKObFSUrhkVefDCvsPEaIvuvdN9SSCAJtLofy4Z
         7bew==
X-Gm-Message-State: AOAM533M+0Ka9Aip9lmEnvx+Uo8+Z8QBq/SdRUXKSdVlttUy7HIszRtC
        pqa3URwwfLEaCTKiqDbLJhskYSNLN8n1Oy8qtkph639+Cxgu+tOr
X-Google-Smtp-Source: ABdhPJy+WkRe5/s1w00zorLtYwuL64C33W0x4fX01dZRGqP5x949c/UsfB1jBGEXPGVhBAStnfYMODCvL2DrDk5vCH0=
X-Received: by 2002:a25:99c7:: with SMTP id q7mr23582505ybo.642.1638556295997;
 Fri, 03 Dec 2021 10:31:35 -0800 (PST)
MIME-Version: 1.0
References: <MpesPIt--3-2@tutanota.com> <87r1azashl.fsf@vps.thesusis.net>
In-Reply-To: <87r1azashl.fsf@vps.thesusis.net>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 3 Dec 2021 13:31:20 -0500
Message-ID: <CAJCQCtRPnbjM+Uu=j2Ti=Gw4WKh6dzjnCg6uMcg0Qcr2nzLUiQ@mail.gmail.com>
Subject: Re: Connection lost during BTRFS move + resize
To:     Phillip Susi <phill@thesusis.net>
Cc:     Borden <borden_c@tutanota.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 29, 2021 at 10:33 AM Phillip Susi <phill@thesusis.net> wrote:
>
>
> Borden <borden_c@tutanota.com> writes:
>
> > Good morning,
> >
> > I couldn't find any definitive guidance on the list archives or Internet, so I want to double-check before giving up.
> >
> > I tried to left-move and resize a btrfs partition on a USB-attached
> > hard drive. My intention was to expand the partition from 2 TB to 3 TB
> > on a 4TB drive. During the move, the USB cable came loose and the
> > process failed.
>
> The only tool I know of that can do this is gparted, so I assume you are
> using that.  In this case, it has to umount the filesystem and manually
> copy data from the old start of the partition to the new start.  Being
> interrupted in the middle leaves part of the filesystem in the wrong
> place ( and which parts is unknowable ), and so it is toast.  This is
> one area where LVM has a significant advantage as its moves are
> interruption safe and automatically resumed on the next activation of
> the volume.

Whether LVM or Btrfs, you can just add the earlier partition to the
storage pool. No need to move extents around, and near as I can tell
no advantage of doing so.

i.e. if the btrfs is on vda2 and it's now desired to expand the file
system "forward" into the space defined by vda1, just add it

btrfs device add /dev/vda1 /mnt

The command implies an abbreviated mkfs on vda1, and resizes the btrfs
file system to encompass both devices. And it's also an interrupt safe
operation unlike gparted move/resize which should come with dire
warnings about the consequence for any interruption.


-- 
Chris Murphy
