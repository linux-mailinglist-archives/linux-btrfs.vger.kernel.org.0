Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289A0485898
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jan 2022 19:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243121AbiAESkV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jan 2022 13:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243116AbiAESkU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Jan 2022 13:40:20 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8E7C061245
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jan 2022 10:40:20 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id m19so436423ybf.9
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Jan 2022 10:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cdKUBaVm5EvZTPGxY1+6hIrXsEMQpnu/tHbhgjm/M1s=;
        b=FG3pFI+oY400gajE609044lFKEZrAUW8okHCcu+NuU5IAbjdn+w6e3D+EH1vEyzIBc
         FTHqVegmyuoMfryvL14tTg/55/KuLIrqIXZh2Xn9ymPX1IoC5bmS58tR+Lkv6qslrq8/
         Wb28o5eyf+fDrMnXOioZ4uWTzTHTQHtzFqDUVZAY62EHkYT3HRZWC4zbwJeW4PPFn3in
         SV4CJglqSVZHZJteNgX102gSg+ZsmixEYRhGWy8LcnFCiGCVQC2ypO4oizM+AwHkb1cV
         Np7MfIoBt4r7ahW9fUnM6QiqGGfysRhJDXanJVlrYiSP+7kRFo7QGJXn4IZqfU7WqnHg
         GbMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cdKUBaVm5EvZTPGxY1+6hIrXsEMQpnu/tHbhgjm/M1s=;
        b=kj7zownqq/4AhkSQHFT0PPL6uME2GMzsvZShrwvACLwGfZ/yCwepsOTzPVgEnfYhcU
         2UBidMhkDQKXo25UGyBE7GFm5sw/qXATqxOjuDXwPrAw5NAbg8SUbNfdj7KuCyBjb3Th
         6zjv/PefVjy9tYH8BCqo23ZuhrRe0spM06HHUcoCS5U0kXYqZ7FGlqEDjw5lOsxrTnLw
         Fi+vw+4GnhXPxAfsEl3SQFiblIchDCTc3mF04SkdlwVuOy9EuNHqybydW8QZw9l4o/rF
         VWAs44t28LgD9alc6R2RohFJ2xi7LxhGXeIeqXCsd+VbCAE2icSuC7fFgN0xdZ7EZ+Hr
         BFjA==
X-Gm-Message-State: AOAM530/cEJi/lfqG+umuz/gCl2tJ5Q15z0P4ANnhxdAESfwoubSKdmq
        fuOG1syYQBPTr1bWq/xVSZL2O0BGUyVMGZV+KNt99A==
X-Google-Smtp-Source: ABdhPJwFrTDcxG3jltAh+5rUTMzAgjwJclaHC4/d12EgfCgIIvrWDihd6lbYm4OOdbZgYYDBfmzB4TBbAvt+Ih4YPN4=
X-Received: by 2002:a25:1505:: with SMTP id 5mr57639688ybv.695.1641408019616;
 Wed, 05 Jan 2022 10:40:19 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtRnyUHEwV1o9k565B_u_RwQ2OQqdXHtcfa-LWAbUSB7Gg@mail.gmail.com>
 <YdXdtrHb9nTYgFo7@debian9.Home>
In-Reply-To: <YdXdtrHb9nTYgFo7@debian9.Home>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 5 Jan 2022 11:40:03 -0700
Message-ID: <CAJCQCtSd8B-qgW=eehcLDxb6oHoj69UiMtvixz=WwWCuy_Fggg@mail.gmail.com>
Subject: Re: [bug] GNOME loses all settings following failure to resume from suspend
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 5, 2022 at 11:04 AM Filipe Manana <fdmanana@kernel.org> wrote:
>
> Looking at the code before that patch, it explicitly skips fsync after
> a rename pointing out to:
>
> https://btrfs.wiki.kernel.org/index.php/FAQ#What_are_the_crash_guarantees_of_overwrite-by-rename.3F
>
> I'm afraid that information is wrong, perhaps it might have been true in
> some very distant past, but certainly not for many years.

However, the system does suspend correctly and before that there
should be "Filesystems sync" message from the kernel (this is the case
on my laptops, unconfirmed for the GNOME bug case). [1]

If the sequence is:

write to file
no fsync
"filesystem sync" (I guess that's syncfs for all mounted filesystems? no idea)
suspend
crash

Still seems like the file should be either old or new, not 0 length?


> I don't think I have a wiki account enabled, but I'll see if I get that
> updated soon.

Thanks Felipe!

[1] "Filesystems sync" message appears to come from here

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/power/main.c?h=v5.16-rc8#n62

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/power/main.c?h=v5.16-rc8#n195




-- 
Chris Murphy
