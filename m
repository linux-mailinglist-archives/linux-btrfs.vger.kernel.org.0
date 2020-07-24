Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061D722C578
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jul 2020 14:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgGXMnq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jul 2020 08:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgGXMnp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jul 2020 08:43:45 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC87C0619D3
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jul 2020 05:43:45 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id e90so6885757ote.1
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jul 2020 05:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=M5I3b0RWBYyfZ1x/oHjkBBQdPXAogXkFca14eu2CGcA=;
        b=sFr4si/4RdDQBCyUNh0gDnLs6zXUertRjR16SXdXt/OeNh5MxmVvb/RsYLO9rFm3e1
         pCLvxoaTKcmr/xqFlO3E0Gu0uGtC6iiOzSHp2lkruQKilYUftdaQw/qP2QMX80pQ6VSL
         h+1djTOWbYPrIQ92zH5izEwt7BGeQ24OL2aW2KiD8SJnOitNnvmy6FYkqIPDZtwyBhOE
         St6FoKElVPxGSIxr/KqGpihFqyPJet9C+yiykZAk3AECx64oaqpIGuNQCXsZFb+jqktP
         P2OzwT+i6QN+IK7vChI8yrRSi4rYtQ6qn9WqrgJeQlAnWoHYsjk54NiXNLBKj3I85bmU
         QqSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M5I3b0RWBYyfZ1x/oHjkBBQdPXAogXkFca14eu2CGcA=;
        b=YvuVBVditOuj0PpLOG3vdORyO/Vy00feC6Hne9nlEsLKo03cLRrFaQz3+GSZd66i2f
         2UeZbznnqSymVd7r8DoZJO7/z32t0mv4GBWfX7hG6yzDmiGAvwUbjEj9qmIzsuWJA+6E
         kefvtMamwKlah9oDOxKZ03opGjIoTI8zGL5l6ITsQAa4/CtZV74JGq93KDWmxIGwO9vI
         Aka58PGLghIHHUWgcLTY5oGQ0lqjtFUPNkbWI+4hIVSkLOev0go7LjHk+Sw2ZtkvTPYL
         OBB1eRXOi+hutVduxEWk9BeBTv1FrNCHIFnNDAERa1NVMBCoEvZE7/RsfZutuvLiaNpq
         EHhA==
X-Gm-Message-State: AOAM530rA2MQZovJAO4MaYkJ2OX3qhWSiMcYuCCr5MyhJrshRzHeciXc
        1T/nTqHPYXd9pb3xRp4nKcnys/QcjDHTQ8XgWIVrA7We/a4=
X-Google-Smtp-Source: ABdhPJxvqznHQy+6M1uGhhSJQfZRcOUotcPhoEB+6G7SAR0BE66pY9mwowRIhmVZK5/MVWsL1qySb5vy1e2/W4Mj2Xw=
X-Received: by 2002:a05:6830:22e4:: with SMTP id t4mr8359755otc.123.1595594624775;
 Fri, 24 Jul 2020 05:43:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAPtuuyEM7YZe8oaqhLivMJLshcsuQWvGuvrmHO1=5ZhYVN7hHA@mail.gmail.com>
 <b92eebb7-7a19-c853-f79c-f5eae669c817@bouton.name> <CAPtuuyGHcpqmCgQeXb6841zK=JLiHmJwJ80OdxKPFJ1KH=q=hw@mail.gmail.com>
 <15da0462-de7e-17ab-f89c-9f373a34fd97@bouton.name>
In-Reply-To: <15da0462-de7e-17ab-f89c-9f373a34fd97@bouton.name>
From:   Davide Palma <dpfuturehacker@gmail.com>
Date:   Fri, 24 Jul 2020 14:43:33 +0200
Message-ID: <CAPtuuyGErKaXDfQGEfMUuHoupe=zT12Pkjetcdiu2VuYtBedOw@mail.gmail.com>
Subject: Re: Error: Failed to read chunk root, fs destroyed
To:     Lionel Bouton <lionel-subscription@bouton.name>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Lionel,
I didn't add a link because I couldn't find it :) here you go:
https://ohthehugemanatee.org/blog/2019/02/11/btrfs-out-of-space-emergency-r=
esponse/

However, I had the problem written in the first comment: btrfs
automatically decided it was raid1 time and when i tried deleting the
device it said "unable to go below two devices on raid1".

Il giorno ven 24 lug 2020 alle ore 01:46 Lionel Bouton
<lionel-subscription@bouton.name> ha scritto:
>
> Hi,
>
> Le 23/07/2020 =C3=A0 23:51, Davide Palma a =C3=A9crit :
>
> Dear Lionel,
>
> > I probably won't be able to help but while this is fresh in your memory
> > please try to remember the exact sequence.
>
> I wish I could give you the .bash_history file,  but the sequence is the =
one I wrote. I tried running many balances before the ramdisk stuff by star=
ting with -musage=3D0 and -dusage=3D0 and got to about 30 before it started=
 looping, I don't think this is useful but now you have 100% of my memory :=
)
>
> > If that's indeed the case, removing the loop device later on will indee=
d
> > break the filesystem as several metadata block groups will be entirely
> > missing (dup will probably have allocated the two duplicates on the loo=
p
> > block device where space was available).
>
> Doesn't this defeat the whole point of raid1?
>
>
> My point is that I saw nothing that pointed to raid1 being used on your f=
ilesystem in the list of steps you described. I understand it was your inte=
nt to use raid1 (although it isn't clear why as you didn't provide a link f=
or the advice you were following) but I'm not sure you actually did.
>
> Simply adding a device to a BTRFS filesystem doesn't convert your filesys=
tem block groups it only adds usable space. You'd need to use a balance com=
mand for converting the block groups to raid1.
> Something like :
> btrfs balance start -mconvert=3Draid1 -dconvert=3Draid1 <yourfs>
>
> Best regards,
>
> Lionel
