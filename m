Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A156B366316
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Apr 2021 02:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbhDUAYu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Apr 2021 20:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbhDUAYu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Apr 2021 20:24:50 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF470C06174A
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Apr 2021 17:24:17 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id p10-20020a1c544a0000b02901387e17700fso272757wmi.2
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Apr 2021 17:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jse.io; s=google;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=rjImKk0F3v2gf62nQDw7soj2kXUyK1R1g1kFQdQ9HJk=;
        b=Iz+LE45/21uYdGuhMr1Zom3JnSNKQC7pbP8RHqbZAfwL6o5kk6fWMVRl8VrMFhHmHW
         nsTGlff2OZqEJ4cg6gFgFRTelIKME32VnyoxYe59UgR/lmaqhXMMsxedjb2EFNyw8k53
         wJXaBLT47TCTi3VfMF8eJ9NCiMn8MgOi6lghRGvItBcAnqiS6uil/3yprOGOQfglYV0Y
         8F4gRUr5B0/oVlqSklyRt7jb5s4a18HMAqLpJuD3fPkPswaqlE3W2Ww60igVZkPgvsOQ
         wgzWflJhyJK/JrZKpEy7BSaOlOyL0D/xRuGPlTmDRcmTqZ/0AJLvrZ1ixgrKODuX0jCl
         sBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=rjImKk0F3v2gf62nQDw7soj2kXUyK1R1g1kFQdQ9HJk=;
        b=N222lK7blHRzRmtbK3DV44ed9m15aOIMxEixEaJ8rwKXR++Nl1pjb5AXQ6RxqUx6WL
         flbdjezsW/QzkFnU8lT2ZPpnonpKEt8QeGfqCLZ6g8aXbH3oexT08ZFPsitWNyl91pdP
         4ot53OaMx/5ikLPxcBGEfP0GCwy+YF25Pz+Cs3BgtruIf++GK5UZR7TbOTw2UMd44lz5
         oc89eW5v+19GoMdWl5D+mhZ6HNtNbkOmBDIpkdRM33qiKtqwsGqEx0eGeJ8MWxK/9jdm
         DncIboXWD5c9jhsxvVJPhecIphAO9+F06jtX+q1vSY7L3R51KGaykBH8CKx/VO3V86To
         8Miw==
X-Gm-Message-State: AOAM533g+zI5sYeTNuFXzVksggAaDG99a/1LrOFPh+Uy19e1oO10gmj+
        Czeaw+f0Chex/jMqPmcOWCrlgaUowzbHX6yKNUBSrSA9/5yqOg==
X-Google-Smtp-Source: ABdhPJwsesFgHCJlfQYYbTAR+SPHMAcm/W2VOR9EgULZguCItVC3LfqPWnsrLgUEIeMdMWgi6zRDgqzrTU689ZvX4DE=
X-Received: by 2002:a7b:c30e:: with SMTP id k14mr6865428wmj.128.1618964656400;
 Tue, 20 Apr 2021 17:24:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAFMvigdvAjY60Tc0_bMB-QMQhrSJFxdv2iJ6jXbju+b5_kPKrA@mail.gmail.com>
 <9bdb8872-3394-534f-a9e3-11dcc5ea2819@gmail.com>
In-Reply-To: <9bdb8872-3394-534f-a9e3-11dcc5ea2819@gmail.com>
Reply-To: me@jse.io
From:   Jonah Sabean <me@jse.io>
Date:   Tue, 20 Apr 2021 21:23:39 -0300
Message-ID: <CAFMvigfQ+XotjO_578LvSvycD3sbLcV_AP6A+B0U+ybApU2zGA@mail.gmail.com>
Subject: Re: Replacing disk strange (buggy?) behaviour - RAID1
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks for the reply, it's appreciated!

> Mounting raid1 btrfs writable in degraded mode creates chunks with
> single profile. This is long standing issue. What is rather surprising
> that you apparently have chunk size 819GiB which is suspiciously close
> to 10% of 8TiB. btrfs indeed limits chunk size to 10% of total space,
> but it should not exceed 10GiB. Could it be specific Ubuntu issue?
>
> So when you wrote data in degraded mode it had to allocate new chunk
> with "single" profile.

That's strange as I didn't write actual data to the disk during that
time. Perhaps Ubuntu wrote some hidden file or something to it, I have
no idea, but I didn't interact with the filesystem beyond doing the
replace after mounting it. Still... 10% of 8TiB may be what's
happening and if so that's really strange... and massive. I'd don't
think it was a single chunk equal to 10% though, as when I converted
it to raid1, I specified the soft filter with `-dconvert=raid1,soft`,
and the resulting output once it was complete was:

Done, had to relocate 825 out of 1648 chunks

So the hypothesis that it was one large chunk doesn't make hold up to
me knowing that output. I thus assume the chunks were all 1GiB given
that many. Unfortunately I didn't save the output of the balance with
`-dusage=0`, but I do recall it being in the 800s as well.

> > Why didn't it free
> > those up as it replaced the missing disk and duplicated the data in
> > RAID1?
>
> Device replacement restored mirrored data (chunks with "raid1" profile)
> on the new device. It had no reasons to touch chunks with "single"
> profile because from btrfs point of view these chunks never had any data
> on replaced device so there is nothing to write there.
>
> > Shouldn't it all be RAID1 once it's complete,
> No. btrfs replace restores content of missing device. It is not
> replacement for profile conversion.

Makes sense, knowing that I would expect that. I just have no idea why
it allocated 800GiB, especially since I didn't write anything to the
single disk during the convert process, much less ~800GiB.

> > Everything was RAID1 all up until the disk replacement, so it clearly
> > did this during the `btrfs replace` process.
>
> No, it did it during degraded writable mount.
>
> > Did I do this wrong, or
> > is there a bug?
>
> There is misfeature that btrfs creates "single" chunks during degraded
> mount. Ideally it should create degraded raid1 chunks.

Hmm... would be nice to see this then. Is there a patch for it,
assuming it's planned?

Thanks,
-Jonah
