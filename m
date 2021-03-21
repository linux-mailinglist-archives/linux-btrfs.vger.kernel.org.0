Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E04534317D
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Mar 2021 06:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhCUFyU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 21 Mar 2021 01:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbhCUFyC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 21 Mar 2021 01:54:02 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EF3C061574
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Mar 2021 22:54:02 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id f73-20020a9d03cf0000b02901b4d889bce0so12626961otf.12
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Mar 2021 22:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=G1q1PlKRhU7irD2oluCBMO6FvihslTq1u/3a5ZgdDPc=;
        b=iIN8wkj1sbOHdjvGB2JD+HFcBJZi0ail2aXmxSX13OAX90J2BYzX8vwtBRkVyrN1AI
         dJSFDpgOh3tH+W9xtJ3Nckw9Ulk3yqqrZ956BF7xrsYTWYSrg05ZSsN1ZM/xv5IFcUy3
         qkOrIggYhYXuv2hCJDOoPXc5yY2576OMc7PQBPM0IYT5YkQmF3w2dLYS8dqwMNKUxV8B
         wOHa9aihLg0g5fTSnht/BD5rPwaZLahwy0f4YjJFKnG865xfXciE9ld2tOffpiW3i6+0
         g8IeMCsn3HcFEf4FPauiwbu1iXyDBphh/5j1cVp27NKbtmaNntGtGgKaIzdQiFiF8bx/
         WtwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=G1q1PlKRhU7irD2oluCBMO6FvihslTq1u/3a5ZgdDPc=;
        b=qiY0VMSJxZAycXav6B2ovFHSs+KIVg0gXfYIrAqVLbYFXqhYJBeFU0b7l64TZYRKOF
         mDOCUTEnletFAsY/MNMa9zCMkGupoCYaKNBzsI2hW92u4Yu/Oupm7EIWnpzFt9rdXcqf
         KVrzCx8Ht6LjIUZeKbGiVQIT9gnibOi4oydjndvU7hwxUv77Mh9pl/0hMakqOJJcciBs
         fjgsJjE4j0r7fBwGgNP9n3A/90VMEuukuqkoz70Sd4/Z7TmRsuKB/5KhrBkSiN+rpSrE
         CFJczV/0T034SqN/rIVtne85r4uyl5vnhJ8KO+7NLySvGLlN/aBucLButFDLRlHvz4dl
         WEKg==
X-Gm-Message-State: AOAM530+IGpwweU5iHrTNGK6K9ELfH6571IoN2khAD8zuKOGN6xoymq1
        RiPc4Kx9HOCRaSlHBKS+zcGZBy6smAdHbLv6lHhy4cqe6FQ=
X-Google-Smtp-Source: ABdhPJwi7NZc52Q3NbhJZymNxi9EqPb2Mz2ui6QOYDFnyOl2Edw8NgyZftD5XVWcJ78LKnUP/wL9ao/P7p4/kij95QI=
X-Received: by 2002:a9d:68d7:: with SMTP id i23mr7185829oto.133.1616306041445;
 Sat, 20 Mar 2021 22:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAGdWbB6JtU54uEOotj=H-DG_7oeUT5KZQG5uM-ibiC2YDbV5Nw@mail.gmail.com>
 <CAJCQCtSBc-Dmks2jdgr-Bcpdh_iLvVevtGOa4LdYgHc2eZE6Hg@mail.gmail.com> <CAGdWbB4dN45=4T_WbF7tXmm2UsmF0bh=Lb_z-H=QVQWaW=C=Bw@mail.gmail.com>
In-Reply-To: <CAGdWbB4dN45=4T_WbF7tXmm2UsmF0bh=Lb_z-H=QVQWaW=C=Bw@mail.gmail.com>
From:   Dave T <davestechshop@gmail.com>
Date:   Sun, 21 Mar 2021 01:53:50 -0400
Message-ID: <CAGdWbB61y3CXTbSxe9Rc7ijs9vsLg7qcX4JZ_WpW-73m_1-6_g@mail.gmail.com>
Subject: RE: parent transid verify failed / ERROR: could not setup extent tree
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Mar 20, 2021 at 10:04 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> On Sat, Mar 20, 2021 at 5:15 AM Dave T <davestechshop@gmail.com> wrote:
> >
> > I hope to get  some expert advice before I proceed. I don't want to
> > make things worse. Here's my situation now:
> >
> > This problem is with an external USB drive and it is encrypted.
> > cryptsetup open succeeds. But mount fails.k
> >
> >     mount /backup
> >     mount: /backup: wrong fs type, bad option, bad superblock on
> > /dev/mapper/xusbluks, missing codepage or helper program, or other
> > error.
> >
> >  Next the following command succeeds:
> >
> >     mount -o ro,recovery /dev/mapper/xusbluks /backup
> >
> > This is my backup disk (5TB), and I don't have another 5TB disk to
> > copy all the data to. I hope I can fix the issue without losing my
> > backups.
> >
> > Next step I did:
> >
> >         # btrfs check /dev/mapper/xyz
> >         Opening filesystem to check...
> >         parent transid verify failed on 2853827608576 wanted 29436 found 29433
> >         parent transid verify failed on 2853827608576 wanted 29436 found 29433
> >         parent transid verify failed on 2853827608576 wanted 29436 found 29433
> >         Ignoring transid failure
> >         leaf parent key incorrect 2853827608576
> >         ERROR: could not setup extent tree
> >         ERROR: cannot open file system
>
>
> From your superblock:
>
>         backup 2:
>                 backup_tree_root:       2853787942912   gen: 29433      level: 1
>
> Do this:
>
> btrfs check -r 2853787942912 /dev/xyz
>
> If it comes up clean it's safe to do: mount -o usebackuproot, without
> needing to use ro. And in that case it'll self recover. You will lose
> some data, between the commits. It is possible there's partial loss,
> so it's not enough to just do a scrub, you'll want to freshen the
> backups as well - if that's what was happening at the time that the
> trouble happened (the trouble causing the subsequent transid
> failures).
>
> Sometimes backup roots are already stale and inconsistent due to
> overwrites, so the btrfs check might find problems with that older
> root.

# btrfs check -r 2853787942912 /dev/mapper/xyz
Opening filesystem to check...
parent transid verify failed on 2853787942912 wanted 29436 found 29433
parent transid verify failed on 2853787942912 wanted 29436 found 29433
parent transid verify failed on 2853787942912 wanted 29436 found 29433
Ignoring transid failure
parent transid verify failed on 2853827723264 wanted 29433 found 29435
parent transid verify failed on 2853827723264 wanted 29433 found 29435
parent transid verify failed on 2853827723264 wanted 29433 found 29435
Ignoring transid failure
leaf parent key incorrect 2853827723264
ERROR: could not setup extent tree
ERROR: cannot open file system

It appears the backup root is already stale.

>
> What you eventually need to look at is what precipitated the transid
> failures, and avoid it.

The USB drive was disconnected by the user (an accident). I have other
devices with the same hardware that have never experienced this issue.

Do you have further ideas or suggestions I can try? Thank you for your
time and for sharing your expertise.
