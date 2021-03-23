Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD7A9346D64
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Mar 2021 23:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbhCWWkb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Mar 2021 18:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233988AbhCWWkB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Mar 2021 18:40:01 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C5BC061574
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Mar 2021 15:40:00 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id z6-20020a1c4c060000b029010f13694ba2so172806wmf.5
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Mar 2021 15:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9MBmVurF2/24xv1hMJ4FlBuR8SWYyI5EX4m7Q6nWok0=;
        b=vqCCxtHY2ovNPvq7mHQ+lW6OPQbWw/pOg6DB0ouJPad/3r2gTiD8bsIhr0tQ/qGBOE
         2uVOYyjkqanqNbn11aULBtKIxsV/hAn4LischrP8bwg3hIYUOnzfH0cPo/T/FHw6NEar
         IsWDsZB7N0YpHi9ohjJI1TG6ycMS6swYr+MVIuQ6aiQwKg6X8jkI7Z2b/U+i3s9zQxLd
         8nlO+r1U5qTbzLH88q5pQjC65nWc3Kh0oRFXLc0nC65EltRSOiFeAr0/40Oja6JEg+dD
         vFy0WB4zzI9jxx6K9KA481G8jgSFJ3zfHcAHdt9CWRXsY6+UBolQWak4AKPmMGTc8dRp
         yHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9MBmVurF2/24xv1hMJ4FlBuR8SWYyI5EX4m7Q6nWok0=;
        b=jhQUIorD5hTL0sSJVglZigfjbYWwjOQ4jbjOqYvuSXzvIB8SwAH0EWh7uu5ALngxSd
         gYvJdJ6zCp9KKcckcS7FFUAmW0KDSgk9GlvDIKlgMb/8FzzhYiJyEkhc+rqMLWtUOEkJ
         jGNswNAxCxp0IoHn5tev8Bqj7XnnHahLKnsq1rF5oSq/AFPGuTfRzEBgq9CFYbzhUVrx
         Jhu4FrMYP0t7VhmdlqsadfuxLH48HXQjw0LECMM6PRftuyyWdgLidgvfNzB+Elr3NgzN
         EwWBJMlvLCNQ2yuPUkFKuIkiWAdycqhzl9uZpgSzlN0aqqWwaeaIGECjH4E8H6TzYOE/
         TunQ==
X-Gm-Message-State: AOAM533alL+LY1ZnWT0hSWLSSp7ieVVg8IEc/UL7y1hp73thnaobFBlR
        b5I0h60oBW0xLJnRL2z/s2qW9GsaQ6mrwkHvD7izRIOuV5paxw==
X-Google-Smtp-Source: ABdhPJynBjwtfAeT5u41eNYp0pEKhS8mhW0mPcqtsy5nrckICiAfeV8DLs32pdH2v9z68of20MLLffEaET1Q2exF3Ec=
X-Received: by 2002:a05:600c:4f55:: with SMTP id m21mr177911wmq.11.1616539199016;
 Tue, 23 Mar 2021 15:39:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAGdWbB6JtU54uEOotj=H-DG_7oeUT5KZQG5uM-ibiC2YDbV5Nw@mail.gmail.com>
 <CAJCQCtSBc-Dmks2jdgr-Bcpdh_iLvVevtGOa4LdYgHc2eZE6Hg@mail.gmail.com>
 <CAGdWbB4dN45=4T_WbF7tXmm2UsmF0bh=Lb_z-H=QVQWaW=C=Bw@mail.gmail.com>
 <CAGdWbB61y3CXTbSxe9Rc7ijs9vsLg7qcX4JZ_WpW-73m_1-6_g@mail.gmail.com>
 <CAJCQCtRyhh6AY25+RwikJKk_HUW1xveVxYzGvPpFDdWq618KUg@mail.gmail.com>
 <CAGdWbB7kCM8DzbS5TzZg=DhsdjTE5nij1SuEnibi3B=OqPBRow@mail.gmail.com>
 <CAJCQCtSNsVkTaZb4Zbz7AeTVUNgxca5hOfaQGHQTUf8DsY-Nrg@mail.gmail.com> <CAGdWbB7K4d0xhKGTLni_stKStG-gTarWd08BUN9Mt-rpQktp8g@mail.gmail.com>
In-Reply-To: <CAGdWbB7K4d0xhKGTLni_stKStG-gTarWd08BUN9Mt-rpQktp8g@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 23 Mar 2021 16:39:42 -0600
Message-ID: <CAJCQCtQs6udT3Qm7kQTT65E0YNWfXiVRoEVZLxWkLCPSd8T_AQ@mail.gmail.com>
Subject: Re: parent transid verify failed / ERROR: could not setup extent tree
To:     Dave T <davestechshop@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 23, 2021 at 12:50 AM Dave T <davestechshop@gmail.com> wrote:
>
> > d. Just skip the testing and try usebackuproot with a read-write
> > mount. It might make things worse, but at least it's fast to test. If
> > it messes things up, you'll have to recreate this backup from scratch.
>
> I took this approach. My command was simply:
>
>     mount -o usebackuproot /dev/mapper/xzy /backup
>
> It appears to have succeeded because it mounted without errors. I
> completed a new incremental backup (with btrbk) and it finished
> without errors.
> I'll be pleased if my backup history is preserved, as appears to be the case.
>
> I will run some checks on those backup subvolumes tomorrow. Are there
> specific checks you would recommend?

It will have replaced all the root nodes and super blocks within a
minute, or immediately upon umount. So you can just do a 'btrfs check'
and see if that comes up clean now. It's basically a kind of rollback
and if it worked, there will be no inconsistencies found by btrfs
check.



-- 
Chris Murphy
