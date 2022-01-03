Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC30483698
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jan 2022 19:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235218AbiACSJN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jan 2022 13:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234580AbiACSJN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jan 2022 13:09:13 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1211EC061761
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jan 2022 10:09:13 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id u6so51713455uaq.0
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Jan 2022 10:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F0VJRsQbciLjhdZP41KelBxyxAlWLJnbJQrlDIHSDO0=;
        b=dJkInXi2wmc4U1RsbU5hhi/S8E3TdgomIAGzdPUokvmy13sTFBuKiSBbHUgbaj0dYH
         1agBMAjx9SdlIbAutisO9pVpwxeRyAFlG184P4v1SKlnkAcOjVWF1SKdQ+j+YK8n5Nlx
         DdwflycJT6UxOMOu83zFvo5hQhdfxLHQpREm6yNV3aiPGbPu5e2KnHzpMoVd3X+FwtuH
         dahcB2/9X7tlbrPq5A3CE9qfwi1FB5pHMciqqzmwqZVxSjW/bJ3eIYgY8wfA2buIwSnV
         Yns6T/vLKiLRJacBUOPJc4hrETQQ4zNAbq/SfVOimsHhBfNkLIaySU4KzHOisEdS3cbc
         zZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F0VJRsQbciLjhdZP41KelBxyxAlWLJnbJQrlDIHSDO0=;
        b=LSHqbSR+pJsvwPOla8YYQXWimfDd/FuNBJD6j1EnzfRVmMDvxKEYmOR7sBscIjd1JL
         2EwRsdA811I9N8Ioz+DKYa0+H71ZX+eHmokEs6XQlZpxUPvT6+6ME63KSuIjXyp7FWvN
         oZfr6z625AqvksVxfVLzAqdvpdbsDs6NWFyWSspB3kLFhSSOaSwLHJR3GA9+oZg6qAS+
         lEA4I4ce0r4OqZQ6X/wN/3ntE2nJ1GEULpNF9xU2q3TMaO1ih9bAok8+/Hl2THhczT29
         FxE/CKS4zWD8puhEjDVqed7NhANVzf9N6aDKHBnhXR0YRPNyKcCUDJGeP5eJ5uPlWMPa
         45OQ==
X-Gm-Message-State: AOAM530MvPkL99xnFQZHoHUYsgQw2iaCx79k+5XewplCbASsr9jb3F7N
        fI9+HcvkqIUcm1gh64li+pv9SWlm1YznMcX2TsE=
X-Google-Smtp-Source: ABdhPJzjSmmjYz18ROCDfuJjLuK+C0VB/YR2psQ19h2iBMTPEDpaEZNrsIvzItWNVm/ZkFpYrD3s/DzJvK5qFWXW1T8=
X-Received: by 2002:a05:6130:423:: with SMTP id ba35mr3263286uab.86.1641233352107;
 Mon, 03 Jan 2022 10:09:12 -0800 (PST)
MIME-Version: 1.0
References: <CAOE4rSz2f3xHj7Mi_JFgSMHHN8XSGxMr4NWZdcu4qd1-zOYOsg@mail.gmail.com>
 <CAA91j0XmeOUA=sioDh7p8Of6O3n8=E8nCAeYs6GXE4awr=Cs+Q@mail.gmail.com>
In-Reply-To: <CAA91j0XmeOUA=sioDh7p8Of6O3n8=E8nCAeYs6GXE4awr=Cs+Q@mail.gmail.com>
From:   =?UTF-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Date:   Mon, 3 Jan 2022 20:09:01 +0200
Message-ID: <CAOE4rSwtend5c2EeOZDwatXLRyEXsVwjQftawFB4asCvs-Cb8g@mail.gmail.com>
Subject: Re: btrfs send picks wrong subvolume UUID
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     Btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

sv=C4=93td., 2022. g. 2. janv., plkst. 22:37 =E2=80=94 lietot=C4=81js Andre=
i Borzenkov
(<arvidjaar@gmail.com>) rakst=C4=ABja:
>
> On Sun, Jan 2, 2022 at 8:05 PM D=C4=81vis Mos=C4=81ns <davispuh@gmail.com=
> wrote:
> >
> > Hi,
> >
> > I have a bunch of snapshots I want to send from one fs to another,
> > but it seems btrfs send is using received UUID instead of subvolumes ow=
n UUID
> > causing wrong subvolume to be picked by btrfs receive and thus failing.
> >
> > $ btrfs subvolume show /mnt/fs/2019-11-02/etc | head -n 5
> > 2019-11-02/etc
> >         Name:                   etc
> >         UUID:                   389ebc5e-341a-fb4a-b838-a2b7976b8220
> >         Parent UUID:            36d5d44b-9eaf-8542-8243-ad0dc45b8abd
> >         Received UUID:          15bd7d35-9f98-0b48-854c-422c445f7403
> >
>
> btrfs send will always use received UUID if available, it works as
> designed and is not a bug. Bug is to have received UUID on read-write
> subvolume. btrfs does not prevent it and it is the result of wrong
> handling on the user side. You should never ever change read-only
> subvolume used for send/receive to read-write directly - instead you
> should always create writable clone from it.
>
> This was discussed extensively, see e.g.
> https://lore.kernel.org/linux-btrfs/d73a72b5-7b53-4ff3-f9b7-1a098868b967@=
gmail.com/

I consider it as bug. How can anyone know they shouldn't do that. It
is perfectly valid use case for sending subvolumes from one system to
another system. After sending using "btrfs property set ro false" to
set RW. Sounds very logical, why should I create a new snapshot? I
just sent new one. Original system's subvolume could even be deleted
with no plans to ever do any incremental sends. And seems many people
have had this issue which just proves my point it's a bug. And if this
is not supported, then why there exists such "btrfs property set ro
false" at all who lets you shoot yourself in foot? If it didn't exist
then everyone would use only other option by creating new RW snapshot
which actually sounds more like a workaround for broken property set.
So I would say first bug that needs fixing is changing "btrfs property
set ro false" in kernel so that it clears received_uuid and
regenerates new subvolume uuid because such modified subvolume isn't
same as source and would still causes issue if it stayed same.
That would fix it for future but wouldn't solve it for many people who
already have such subvolumes. And it's pretty hard problem to track
down unless you already know it. Like it took me a lot of time to
figure out why send is failing. ro->rw was done 7 years ago and all
snapshots since then have same received_uuid but I noticed btrfs send
not working only now. For me, easiest way I'll just patch kernel to
always use subvolume's uuid and ignore received_uuid, then btrfs send
all snapshots so it will work fine for me. As for others, in general
seems proper fix would be that btrfs send would give both uuid and
received_uuid. Then btrfs receive could have a flag to ignore
received_uuid and just use uuid. Or search by uuid and then fallback
to received_uuid.
