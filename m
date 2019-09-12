Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46F69B0AEC
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2019 11:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730558AbfILJGw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Sep 2019 05:06:52 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:45009 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730327AbfILJGv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Sep 2019 05:06:51 -0400
Received: by mail-ua1-f65.google.com with SMTP id z8so7738078uaq.11
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2019 02:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=lNPz2xkWSo5hB9ZAIkWJI5oZzD5ogmjjXMDLqjH2WEE=;
        b=Fbby+e0aDZ6oi56JNf5FIjQr51N1fZQhhZLhhohJ5hgC+dNgkZG06J4Gfyw4GtcVuI
         kJm8VfpNe68yN3mW+2v7tj3SxRufQf3xomp5a5znTRQoAtIXP5UDykBtkZylekxyHps0
         LXbEgczGmK7zYDpCc4vH5ns/Xrxl2l3yluabLANhAi01QJQCZgGMM2vSZPGiOcNbevQi
         tycIO1B1le4GiX8tYFz5LVq3BtawP0Yy9KtG4cbmdalB0SgCYTmQuraPKgg156swOg3T
         fyFycb2pD+epXU/U0X9/3qUQ5PiDCXPg519uKqDrkn0hFv8W2aN/XU60WLFqLL9qpM3a
         NmKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=lNPz2xkWSo5hB9ZAIkWJI5oZzD5ogmjjXMDLqjH2WEE=;
        b=ayaprLviXqJLKNFtoDogS6BBescDCS3SdhPDoH8B9Zi4btsA2YoihLSPGYklK9/eGx
         NInQ4o0rheT9ZBYHGOtyZImqZvQFP4FiDZbiuRaKnaf2x+Pk/ZwId7H0rMTVyFwjTSOd
         97+bRA6b8Qyz986X7zU6njuhPQJTkZMzF9PV3LK0Mdu7S+WksELDoHYhx4WT3SdWh1Iv
         bmvnbLRa7KB0yvmE/IbCsxASX6EvsM2bpI1N+1OX3ZUtI4OBOyC7wt1f0W+EHK2MVrb7
         2/ZVfJ9NT1bD5oK8aYLtNrksWvUX278L1vwBUWjLdFadgbRFP+Ch4QwOPtXbHL+L44to
         8BBQ==
X-Gm-Message-State: APjAAAUYYqqgQWDrvdHBxlkTO7+/D6bWwOoMFKxAltP7iC5j/Tcy2nn6
        6D5qphxE+s/KiVJf/l1w8hqWvhbXn441X+sU3HI=
X-Google-Smtp-Source: APXvYqwH2+FAJirca24SpRH0cHbUZI6+0KFzQiPUMYN09Zp1KqRxix7HOVu6MVHlwmAL+bdZ0/aY82uvkfyThK4n6SU=
X-Received: by 2002:ab0:30ef:: with SMTP id d15mr18825608uam.135.1568279209710;
 Thu, 12 Sep 2019 02:06:49 -0700 (PDT)
MIME-Version: 1.0
References: <11e4e889f903ddad682297c4420faeb0245414cf.camel@scientia.net>
 <CAL3q7H4peDv_bQa5vGJeOM=V--yq1a1=aHat5qcsXjbnDoSkDQ@mail.gmail.com> <CA+X5Wn7GCed+bWNq7jkTHgDc5dT-OHyUkTRxfa1eHv=25_ijrQ@mail.gmail.com>
In-Reply-To: <CA+X5Wn7GCed+bWNq7jkTHgDc5dT-OHyUkTRxfa1eHv=25_ijrQ@mail.gmail.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 12 Sep 2019 10:06:38 +0100
Message-ID: <CAL3q7H5HKVBij-hupEG6wwDWeDKzUwXT1FkOT1+ybJJ6U8UPMQ@mail.gmail.com>
Subject: Re: Massive filesystem corruption since kernel 5.2 (ARCH)
To:     James Harvey <jamespharvey20@gmail.com>
Cc:     Christoph Anton Mitterer <calestyo@scientia.net>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 12, 2019 at 9:24 AM James Harvey <jamespharvey20@gmail.com> wro=
te:
>
> On Thu, Sep 12, 2019 at 3:51 AM Filipe Manana <fdmanana@gmail.com> wrote:
> > ...
> >
> > Until the fix gets merged to 5.2 kernels (and 5.3), I don't really
> > recommend running 5.2 or 5.3.
>
> What is your recommendation for distributions that have been shipping
> 5.2.x for quite some time, where a distro-wide downgrade to 5.1.x
> isn't really an option that will be considered, especially because
> many users aren't using BTRFS?  Can/should your patch be backported to
> 5.2.13/5.2.14?

It's meant to be backported to 5.2.x and 5.3.x (probably not to 5.3
since we are at rc8 and too close to merge window for 5.4).

> Or, does it really need to be applied to 5.3rc or git
> master?  Or, is it possibly not the right fix for the corruption risk,
> and should a flashing neon sign be given to users to just run 5.1.x
> even though the distribution repos have 5.2.x?
>
> What is your recommendation for users who have been running 5.2.x and
> running into a lot of hangs?  Would you say to apply your patch to a
> custom-compiled kernel, or to downgrade to 5.1.x?

Sorry, I can't advise on that. That depends a lot on the distro and user ne=
eds.
Going back to 5.1 might be ok for some, but not for others due to
important fixes or new features/drivers in 5.2 for example.

It's really up to the distro and user to choose according to their needs.



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
