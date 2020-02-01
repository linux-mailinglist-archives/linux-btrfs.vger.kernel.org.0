Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D107014F795
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Feb 2020 12:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgBALKo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 Feb 2020 06:10:44 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:35808 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbgBALKn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 1 Feb 2020 06:10:43 -0500
Received: by mail-io1-f66.google.com with SMTP id h8so11319897iob.2;
        Sat, 01 Feb 2020 03:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tqG5bSyIXwjq9Ttkq8nuWelaIXOGRyVYFrRUDUMvjXU=;
        b=DZh9k7xY46VX8brsFMUweNUSlKIsgbZ+3KBEHouIyY60KAcNx7swZ3snBFp9BIsyDa
         EVjzihAXlvIZEVsp7DzCWUyK53a6jTYyirBuDTACF2D+uDgzB8QhoUxGh4yMY8bXQxlP
         DlLQwHbHx6D3tsZ+ul/8GnvDZlTPMHp/hOnQ+lGJ6Bl8cKJxUV1D6CBShk0nYCpc9g1q
         dSWJH5up4gwNFgawIjbb2Kthg7TzXzTJlawV1/Hrtr/w8fb1XIOvfdvyTa6lT7Hld+PB
         V1p3wDOsvzvjqWeIPKpZtOgl0Xl53t0ZW9MdPfU3tf6HbRweNFjhRuP0+hkAk7kDs4SY
         GrIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tqG5bSyIXwjq9Ttkq8nuWelaIXOGRyVYFrRUDUMvjXU=;
        b=rOa3/V/ok1M0D5Uv6YjpTm6QVu51+MmJS09sbiM+RTEvM/3iz4qVCFuJ7akTc5NKwZ
         MtFyqumtgaLh8hLujXbxICG1djHxgRZokRtRZHw6frZyzFUdorODsBrgCUFrRZBxX3Bv
         2O6PskCWBgC0Xs2VzwaDMi5pkhG74FPUsBFVZ4+yJnfHG/eF6ZyYKV3yS2GVGQHa/31z
         LMlQRW7p3cVPTNt7DjNO23hT0F6UJLArCnYqUMiudRvckxXCf4vkeX30V8PwnIGDkJhI
         +qG30j6zVEL4crwtn1HItjKSK3tHchU01vZAslgqg0X5FUF041rN3nZYK2TZGaMEAC2x
         ceOg==
X-Gm-Message-State: APjAAAWjjoY/bnmb7YpDomnd6gudefmqVCz2BVUCigOCnVBESPSMipmp
        dv60/pQGBma1Vp89yj1qoRpijAPfcy05HQlZfvc=
X-Google-Smtp-Source: APXvYqyGnp3xafelQgwi+Fw/l23sRkcw/01eQmpC4dMFvoxZL7xHSEu4u90+YvRaH/3LcCAJwyEgNcY+QbSjCx7I8fI=
X-Received: by 2002:a6b:d019:: with SMTP id x25mr4228892ioa.275.1580555442957;
 Sat, 01 Feb 2020 03:10:42 -0800 (PST)
MIME-Version: 1.0
References: <20200114125044.21594-1-wqu@suse.com> <20200201073649.GA2697@desktop>
In-Reply-To: <20200201073649.GA2697@desktop>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 1 Feb 2020 13:10:32 +0200
Message-ID: <CAOQ4uxj_MFHrWthckSVUaHp3us2eNFeZRc_wuD90CxcUveYUTA@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs/153: Remove it from auto group
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     Qu Wenruo <wqu@suse.com>, fstests <fstests@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Feb 1, 2020 at 9:41 AM Eryu Guan <guaneryu@gmail.com> wrote:
>
> On Tue, Jan 14, 2020 at 08:50:44PM +0800, Qu Wenruo wrote:
> > This test case always fail after commit c6887cd11149 ("Btrfs: don't do
> > nocow check unless we have to").
> > As btrfs no longer checks nodatacow at buffered write time.
> >
> > That commits brings in a big performance enhancement, as that check is
> > not cheap, but breaks qgroup, as write into preallocated space now needs
> > extra space.
> >
> > There isn't yet a good solution (reverting that patch is not possible,
> > and only check nodatacow for quota enabled case is very bug prune due to
> > quite a lot code change).
> >
> > We may solve it using the new ticketed space reservation facility, but
> > that won't come into fruit anytime soon.
> >
> > So let's just remove that test case from 'auto' group, but still keep
> > the test case to inform we still have a lot of work to do.
> >
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> I'd like to see an ACK from btrfs folks. Thanks!
>
> Eryu
>
> > ---
> >  tests/btrfs/group | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tests/btrfs/group b/tests/btrfs/group
> > index 697b6a38ea00..3c554a194742 100644
> > --- a/tests/btrfs/group
> > +++ b/tests/btrfs/group
> > @@ -155,7 +155,7 @@
> >  150 auto quick dangerous
> >  151 auto quick volume
> >  152 auto quick metadata qgroup send
> > -153 auto quick qgroup limit
> > +153 quick qgroup limit

Hmm, if removing from auto it might make sense to also remove it
from quick, because people often use quick as a sanity regression group.

The issue at hand is a recurring pattern.
It is also been discussed recently about generic/484:
https://lore.kernel.org/fstests/20200131164619.GA13005@infradead.org/

I also handled something like this with:
fdb69864 overlay/061: remove from auto and quick groups

I suggest adding a group 'broken' to mark known/wontfix issues
then a default regression test could run -g auto -x broken
or -g quick -x broken for a quick regression sanity.

Thoughts?

Amir.
