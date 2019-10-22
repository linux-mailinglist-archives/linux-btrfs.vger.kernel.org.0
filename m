Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E90BDE01AD
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2019 12:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730121AbfJVKKe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Oct 2019 06:10:34 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55926 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbfJVKKe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Oct 2019 06:10:34 -0400
Received: by mail-wm1-f65.google.com with SMTP id g24so7344767wmh.5
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Oct 2019 03:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gJNWRCVHIag4D3XQJjKUn+Ayv4H1SKw77KxauCYKGM8=;
        b=kuggE2arLUDLYdZ9x1fYmWeKMiSYVvShu8AB1kIJ6npYoEKZfH35Yws/vJiICOAoOj
         la+ZUnd+WtiB0B20Ozd5j1Rnsnu50FSL3x+7dNfYjidsTLLxLXrbGYUnZS6irc24lgZN
         vFKXUcr6bO3LirdavW5RVYVe4RabzdLS92NXxb6gaPc60HlG0j8KlgZsXWycoEr25COG
         iEILIHJKpcqxge+FM5oXcBCAjYAOFY6gCYiMOcLnkymlBQwar+3c9LieWOfwMifK6+hx
         jI6Zpr1K/1JQUduKIRfaBrGgESvEdwSyjsqMicNtyZNMzmZv3H2LD8L2vGyYJea/OG8V
         Dh6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gJNWRCVHIag4D3XQJjKUn+Ayv4H1SKw77KxauCYKGM8=;
        b=HecSzKXN7DQK+IY28Ts5pngeMowRAAvLOtTAJuGtEeic/MrzpkbF5NyC31td3ZKnXj
         Y3XWhS3J5IILCKohofYS/KcFgSSk0XEPUvxR8aOdJ9Wbzk6m3oKzEyQYaslBbdSYdW4S
         7eQi/RngvNsfQ0tHhIfZlc5I5aZniMUjqPedHQQ+UE0avT6cFpLgc0jOYQ1ahPhhQeMP
         AIaWqmI4sFiP7Euwcxxgw98PfOSDpPjA+/kWD+l8SCgsTm9RjSTJ9EZdvrsJh0WEaMtv
         u/obMINQGDDP8qMNPldnrA4VbWhWZV2sXsAe2tCwHqn7vik+WRElxjhS6W/k46n/Gn8U
         Sbog==
X-Gm-Message-State: APjAAAU9M276Dlm3yBTv2cJc4tTwsvqNUNyKW96LVVMMnuJdDLLI60j9
        BG5mYrbGYWFPG3TTz8rWA49596dVTZaN6VRQjg3lZfhagWg=
X-Google-Smtp-Source: APXvYqz0hUg0I1SZibCiMp/4RuzIBJJaG5z1aTtiJ+LkbWBqBTBSHzc4Gk7jKsoAaz6Q6nqnSOUVAqqLOgNSMc2BrUo=
X-Received: by 2002:a7b:cbc5:: with SMTP id n5mr2309271wmi.65.1571739031811;
 Tue, 22 Oct 2019 03:10:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtTPAm6eGA80y9LYc+Jaeo1wB0+vOMvO6B02o5JJKRFrhw@mail.gmail.com>
 <d1b51dc7-38c0-89d2-e51f-803e19773936@oracle.com>
In-Reply-To: <d1b51dc7-38c0-89d2-e51f-803e19773936@oracle.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 22 Oct 2019 12:10:12 +0200
Message-ID: <CAJCQCtTNhKyos8Ns-Nf3tFgbc91FXMH9mLuyMtmRqAbzwRSgRw@mail.gmail.com>
Subject: Re: feature request, explicit mount and unmount kernel messages
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Anand Jain <anand.jain@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 22, 2019 at 11:56 AM Anand Jain <anand.jain@oracle.com> wrote:
>
>
>   I agree, I sent patches for it in 2017.
>
>   VFS version.
>     https://patchwork.kernel.org/patch/9745295/
>
>   btrfs version:
>     https://patchwork.kernel.org/patch/9745295/
>
>   There wasn't response on btrfs-v2-patch.
>
>   This is not the first time that I am writing patches ahead of
>   users asking for it, but unfortunately there is no response or
>   there are disagreements on those patches.

I guess it could be a low priority for developers. But that's a big
part of why doing this in VFS might be useful, generically, for all
file systems? I have no idea what that boundary looks like between
native file system and VFS. But if the mount related messages were
removed from ext4, XFS, Btrfs, f2fs, FAT, that developers don't find
that useful, and add in a proper plain language "(u)mount completed"
in VFS, that would be, I think, useful for not just regular users, but
users like systemd/init users, and others who have to sort out mount
hangs and failures. Just exactly where did this  hang up? I can't tell
and it's different behavior for every file system.

I'm not opposed to each file system having their own (u)mount
completed message, indicating a boundary where the native code ends,
and VFS code begins. But again that's up to developers. I just want to
know if the hang means we're stuck somewhere in *kernel* mount code.
From the prior example, I can't tell that at all, there just isn't
enough information.


-- 
Chris Murphy
