Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0A6482CB6
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Jan 2022 21:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiABUhq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 2 Jan 2022 15:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiABUhp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 2 Jan 2022 15:37:45 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7F9C061761
        for <linux-btrfs@vger.kernel.org>; Sun,  2 Jan 2022 12:37:45 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id l68so1698501vkh.4
        for <linux-btrfs@vger.kernel.org>; Sun, 02 Jan 2022 12:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4t1n3lz0h2Sos9PG1FGyV5dZvzDaNsB9p1MF9+J9JqY=;
        b=HYnTF/Gko1K6ne1ivWmnoLAXMh9dpqq1mAq6o07QXieg251EI0b6HBgXDFzzlo6uSP
         /Njw2E8CKPGHkdPSOb5BeXzB3oBCesSkPYQfrmrFiowIWYbQWM3cj/FZJlyUqy6v1GfR
         ttzwl4eGtNR1Ccq+1pZB975+jNdRb8m0CudiNEQYhOeBCgjFduQa/4/fimyL5sPbANQE
         QYpP+mnCPk2dYNJ+hF6lXlA3CZw2m1lIXH7gEWyqMdPhiFJzeJz/0FloYBGdz3iuYoG2
         N40HRCp7gtkxcjFkz5xeJOjZrIHZJ8bY721THKLBUnhkdAlsH6Rkem39Nw6CNSZ+gREH
         Gbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4t1n3lz0h2Sos9PG1FGyV5dZvzDaNsB9p1MF9+J9JqY=;
        b=UmUSS/Fx9Jf5hCcGSPm9/i8NG7VtisC/z7gZNw8MfrNWiUKvFL4DBcLc1GxmBerjaw
         gAF2JoM7ewZ4wvo0MzSta9fEye6A9tFFphlT4iEOEdQDIryXrpcsa0DHQWQhTz3+PupJ
         ROSASXata7gRXJ7HN611bP7UpzWFyY5QxJaqbV8kHgGCHuiVakGqoKCXP08fnMzvN75C
         APHtktf+QVReGw2+rsgO/oM7d811kG2xM+Pr4CyEpzzLJJACuydQ3yySeLU5yiGFVwYU
         XL1oZhKZ3sdT9cgebPdRFfskgZyHBh9xms4hCeWxARAFFN2fsOWYWzXaw4/nsjPcL9ic
         azEw==
X-Gm-Message-State: AOAM532V0f2AnMuBtYVdScAGMF5c/r5CLEgGVwz2tQFwPGRGAJkc+/4J
        0kmfTzH+g+ljxX1vzg+WOxNns4D2U25+CxNkjeo=
X-Google-Smtp-Source: ABdhPJzM4FZmTTL6aiVbPOhVQcPuuSod3l7dWtCsy7CHYjaZgAZTkysyee+48w9J7Sv2ETC3huqq0WkRGWtn13AZeU8=
X-Received: by 2002:ac5:c4f4:: with SMTP id b20mr5994713vkl.17.1641155864605;
 Sun, 02 Jan 2022 12:37:44 -0800 (PST)
MIME-Version: 1.0
References: <CAOE4rSz2f3xHj7Mi_JFgSMHHN8XSGxMr4NWZdcu4qd1-zOYOsg@mail.gmail.com>
In-Reply-To: <CAOE4rSz2f3xHj7Mi_JFgSMHHN8XSGxMr4NWZdcu4qd1-zOYOsg@mail.gmail.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Date:   Sun, 2 Jan 2022 23:37:32 +0300
Message-ID: <CAA91j0XmeOUA=sioDh7p8Of6O3n8=E8nCAeYs6GXE4awr=Cs+Q@mail.gmail.com>
Subject: Re: btrfs send picks wrong subvolume UUID
To:     =?UTF-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Cc:     Btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jan 2, 2022 at 8:05 PM D=C4=81vis Mos=C4=81ns <davispuh@gmail.com> =
wrote:
>
> Hi,
>
> I have a bunch of snapshots I want to send from one fs to another,
> but it seems btrfs send is using received UUID instead of subvolumes own =
UUID
> causing wrong subvolume to be picked by btrfs receive and thus failing.
>
> $ btrfs subvolume show /mnt/fs/2019-11-02/etc | head -n 5
> 2019-11-02/etc
>         Name:                   etc
>         UUID:                   389ebc5e-341a-fb4a-b838-a2b7976b8220
>         Parent UUID:            36d5d44b-9eaf-8542-8243-ad0dc45b8abd
>         Received UUID:          15bd7d35-9f98-0b48-854c-422c445f7403
>

btrfs send will always use received UUID if available, it works as
designed and is not a bug. Bug is to have received UUID on read-write
subvolume. btrfs does not prevent it and it is the result of wrong
handling on the user side. You should never ever change read-only
subvolume used for send/receive to read-write directly - instead you
should always create writable clone from it.

This was discussed extensively, see e.g.
https://lore.kernel.org/linux-btrfs/d73a72b5-7b53-4ff3-f9b7-1a098868b967@gm=
ail.com/
