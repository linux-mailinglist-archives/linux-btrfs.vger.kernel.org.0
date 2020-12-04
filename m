Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C642CF045
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Dec 2020 16:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730420AbgLDPBt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Dec 2020 10:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729365AbgLDPBs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Dec 2020 10:01:48 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0FEC061A53
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Dec 2020 07:01:02 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id p12so4075048qtp.7
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Dec 2020 07:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=dybUq4WzWzC9BORqYWgqnWlsvZ0xP19+Ki1axlhPEoI=;
        b=u/Gm3tSJGGIUkEAJ39UGnqN53shO2fjeoDvkLeIT996zBRdyC/xWY003Kt36KjITVU
         Z7wHi6J1aWQJtVSVmYWCkavhZ6eXS7EDWx/fGLgL/EVeOqqD6fm8FPusnSciFjfpchQb
         9ZleH8WLJtCSQP2Tc65+4vU+527AgzewZm5k2mYR4pjKDRkyeW0HrFcsBRYhxehx+G/x
         1/lRfB3CSGSccrdAxOTxakHZQEIr7nTAm47YxYqtB6bnc69qHVi3kSjZSCGEdILxG7Ae
         uLOOpBwuvqYYx2oT6+mLdynVvdgXonJj9edfu6vW9nPD0V5VSVB//3YuY/sekIIXpLu4
         umxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=dybUq4WzWzC9BORqYWgqnWlsvZ0xP19+Ki1axlhPEoI=;
        b=hBOeTtuTQaJZDKKHZqHYYA8bLbUY2p4hfh003iTs3is2JRWlWtFGQ5g1mK8x+GheqY
         ZFgmIRym0C45ggjg+Cjsuo4i4miq4/UT60vzE1zXbBuAycNse4gRpmd2j0aAuQBQGue5
         UbqK1WTGNQi48Up1htY8glkIDtVIzFCMeMaC9EKVX/giF4TgUMFVtvSvYJgptwX3DgHf
         yAjk9Ql4M/Wm7JQw4HQB0bQT/sRQEwfzD0aOFm0MUTYJss01b7kH2AGqvjbC3/9XxVN1
         z8Img4javiLNdYts0z4hL9BFM4vxVJIKIKylaLlBUjVJhd/NA+/VePjnfkrOe2co+5ai
         c1EA==
X-Gm-Message-State: AOAM531JF6Zv2CVIAHHA5ST4Y5tGnVbOxrP03hOwJvSNKYW9gz5CcvsR
        p7dXtscWg1Umx4OUJOhHONBCYx1hAFusXOigHlYxaQZXeL26Lg==
X-Google-Smtp-Source: ABdhPJxwDDyTV0WQO1D6QiGt3H692kFqkPxOS8naD8DP2WG4pQ5x/DWYoF+oEmZuVYyF6szq3mXXPUITV15m9bx+Ihs=
X-Received: by 2002:ac8:5a04:: with SMTP id n4mr9929109qta.21.1607094061969;
 Fri, 04 Dec 2020 07:01:01 -0800 (PST)
MIME-Version: 1.0
References: <6ae34776e85912960a253a8327068a892998e685.camel@gmx.net>
 <CAL3q7H72N5q6ROhfvuaNNfUvQTe-mtHJVvZaS25oTycJ=3Um3w@mail.gmail.com>
 <d4891e0c7aa79895d8f85601954c7eb379b733fc.camel@gmx.net> <CAL3q7H5AOeFit_kz4X9Q2hXqeHXxamQ+pm04yA5BqkYr3-5e+g@mail.gmail.com>
 <40b352dfa84e0f22d76e9b4f47111117549fa3bb.camel@gmx.net>
In-Reply-To: <40b352dfa84e0f22d76e9b4f47111117549fa3bb.camel@gmx.net>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 4 Dec 2020 15:00:50 +0000
Message-ID: <CAL3q7H7oLWGWJcg0Gfa+RKRGNf+d4mv0R9FQi2j=xLL1RNPTGA@mail.gmail.com>
Subject: Re: btrfs send -p failing: chown o257-1571-0 failed: No such file or directory
To:     "Massimo B." <massimo.b@gmx.net>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 4, 2020 at 1:49 PM Massimo B. <massimo.b@gmx.net> wrote:
>
> On Fri, 2020-12-04 at 10:22 +0000, Filipe Manana wrote:
>
> > Ah, that's interesting.
> >
> > There are two different inodes with the same number (257) and
> > different generations (359797 and 1571). Are you using, or ever used,
> > in that filesystem the mount option "-o inode_cache" (it's deprecated
> > for a while)?
>
> No.
> Which mount options do you need, the sending or the receiving btrfs?

The sending side.
It's not a big deal, even without the inode_cache being ever used,
it's still possible to get into such a situation.

> My mount options on the receiving:
>
> /dev/mapper/localdata_crypt on /mnt/autofs/local/data type btrfs (rw,noat=
ime,nodiratime,compress-force=3Dzstd:15,noacl,space_cache=3Dv2,subvolid=3D5=
,subvol=3D/)
>
> Maybe that space_cache=3Dv2 is special.
>
> > Even if not, it's still possible to get two different inodes with the
> > same number, just not very common (specially with such a large
> > difference in the generation numbers), and send is generally prepared
> > to deal with such cases, just not this case, and I think I know why it
> > happens. I'll have to see if I can reproduce it.
> >
> > If I send you a patch, are you able to patch the kernel, build it and t=
est it?
>
> Yes, I will try.

Great, try this patch then:  https://pastebin.com/raw/8NcPVUb0

I haven't had the time yet to craft a reproducer and confirm that is
the case you are running into, but from the receive -vvv output you
provided before, it seems clear what the problem is.

Thanks.

>
> Best regards,
> Massimo
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
