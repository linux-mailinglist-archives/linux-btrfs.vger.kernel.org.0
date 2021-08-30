Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4623FBDB9
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Aug 2021 22:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236156AbhH3U7u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Aug 2021 16:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235661AbhH3U7u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Aug 2021 16:59:50 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5652C061575
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Aug 2021 13:58:55 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id m21so17188950qkm.13
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Aug 2021 13:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=9ODQ/m9+b+HsuAdGVnjbm02L1cj1wJT5aN9WfnHqnsA=;
        b=ExWz6rdA29RN8pcWt68sL3qIEsFiiCSqWLCd+DOkX0QcBQxIzbCWhrP1R1Y2ckz8z9
         0WI3H6njnvpwRatCrWLT2Mnqs+a5FkB1hbTsGNNwpNSdqyHqsXrv+wb2ImuUcPfrR4dX
         U1pbW4G/xZUgCrtTAQgVr6o+15TYZH3RX8ycf6nkTNXiGmAqPTk9x75LbJWQJCAx7jTm
         1gJD4e7YkXsvrW8IFQp7VBbUVwaWUi+qdAPNqSlpwsvSTSJ9sgYVv0hD/HZJriHMCsH2
         Kv5MzXxAurSp3Bqks3BeCzXlQMvyYZ/1GNXRly13BFEDhdzt4WvCrp2mdjkrkCk8wDt8
         lDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=9ODQ/m9+b+HsuAdGVnjbm02L1cj1wJT5aN9WfnHqnsA=;
        b=pVFW688zq7OsQsmwetr+0t74ui9RDi1/L3EAdfT05kTDyVjKSs09zInOQX6FxMytJU
         1f9mFFvMqF/qGEhyl7LJfXbgkAZOX4OxX1qa9jWypgwH2fSnTpSK9fPU0FJl22C20m9p
         NqvXScXpp3YDrsGeauG99/9TAf31h/R5RUQu1wcSqfsAoZFmzTdHfG9C8UJVAulzTKwm
         bMB0PUH2STmqnyBZmYgreK4dzr6vtUAkexaupSZcXQnp8O1c/shOEi9OLtAEktJi/tNT
         +TBSOVRVR/AN2tQZhcTg48+m3IphHODxqlfQbAAL5jD9JKZmp2a+muL47hA1Oh38ZVUi
         ZrrQ==
X-Gm-Message-State: AOAM533AvIyyo/IZ2vx1xLdmGdy0yy+/5RvhGJmXedo6ohRs4XQViBL2
        iHHtPg44XTQFwmDb0s9F+pH8mqgARrkbIVHa0o0tE6vHAUI=
X-Google-Smtp-Source: ABdhPJybIiUUjdP8sdvqNxMbrk97s90Kn+6+Je5t41ShkJ50Wp8fPRNlryVjp4t9kjdbArxV2NfMUjnifggMGwqp2nw=
X-Received: by 2002:a37:607:: with SMTP id 7mr24982497qkg.0.1630357134439;
 Mon, 30 Aug 2021 13:58:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAOaVUnV3L6RpcqJ5gaqzNXWXK0VMkEVXCdihawH1PgS6TiMchQ@mail.gmail.com>
 <CAL3q7H5P1+s5LOa6TutNhPKOyWUA7hifjD1XuhBP6_e3SQzR8Q@mail.gmail.com>
 <CAOaVUnU6z8U0a2T7a0cLg1U=b1bfyq_xHa8hoXMnu6Qv1E-z+g@mail.gmail.com>
 <CAL3q7H7kbgsiTfLWWYJikuWOFP9yXSdgav2EEonx98pPhSEQNA@mail.gmail.com>
 <CAOaVUnV9FJSVBxmX-tAeZJCq+0rPoY2zga8nuw_toC=tdt8K0w@mail.gmail.com>
 <CAL3q7H5xkGiLcfMYDb8qHw9Uo-yoaEHZ7ZabGHhcHfXXAKrWYA@mail.gmail.com>
 <CAOaVUnUwoq69UZ_ajoxYYOHk8RRgGPNZrcm9YzcmXfDgy24Nfw@mail.gmail.com>
 <CAL3q7H67Nc7vZrCpxAhoWxHObhFn=mgOra+tFt3MjqMSXVFXfQ@mail.gmail.com>
 <CAL3q7H46BpkE+aa00Y71SfTizpOo+4ADhBHU2vme4t-aYO6Zuw@mail.gmail.com>
 <CAOaVUnXXVmGvu-swEkNG-N474BcMAGO1rKvx26RADbQ=OREZUg@mail.gmail.com>
 <CAL3q7H5UH012m=19sj=4ob-d_LbWqb63t7tYz9bmz1wXyFcctw@mail.gmail.com>
 <CAOaVUnVL508_0xJovhLqxv_zWmROEt-DnmQVkNkTwp0GHPND=Q@mail.gmail.com>
 <CAL3q7H7MxhvzLAe1pv+R8J=fNrEX2bDMw1xWUcoZsCCG-mL5Mg@mail.gmail.com> <CAOaVUnXB4qoAyVcm3H03Bj2rukZ+nbSzOdB4TsKpJjH8sqOr7g@mail.gmail.com>
In-Reply-To: <CAOaVUnXB4qoAyVcm3H03Bj2rukZ+nbSzOdB4TsKpJjH8sqOr7g@mail.gmail.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 30 Aug 2021 21:58:17 +0100
Message-ID: <CAL3q7H7vTFggDHDq=j+es_O3GWX2nvq3kqp3TsmX=8jd7JhM1A@mail.gmail.com>
Subject: Re: Backup failing with "failed to clone extents" error
To:     Darrell Enns <darrell@darrellenns.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000db371805cacd197a"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--000000000000db371805cacd197a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 30, 2021 at 9:08 PM Darrell Enns <darrell@darrellenns.com> wrot=
e:
>
> Yes, same operation, same snapshots, no dedupe tools. I just re-ran
> everything below again, and the inode is still 400698.
>
> $ btrfs send -vvv -c /.snapshots/327/snapshot
> /.snapshots/374/snapshot/|btrfs receive -vvv /mnt/backup/test
> /* SNIP */
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D0 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D65536 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D98304 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D131072 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D163840 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D212992 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D491520 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D557056 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D753664 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D786432 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D819200 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D851968 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D884736 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D950272 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D983040 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D1032192 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D1081344 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D1245184 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D1343488 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D1376256 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D1425408 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D1441792 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D1474560 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D1507328 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D1556480 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D1605632 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D1638400 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D1671168 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D1703936 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D1736704 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D1785856 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D1802240 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D1835008 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D1867776 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D1900544 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D1933312 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D1982464 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D1998848 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D2031616 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D2064384 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D2097152 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D2129920 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D2162688 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D2195456 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D2228224 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D2260992 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D2293760 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D2326528 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D2359296 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D2392064 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D2424832 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D2473984 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D2490368 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D2523136 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D2555904 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D2588672 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D2621440 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D2654208 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D2686976 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D2719744 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D2752512 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D2801664 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D2818048 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D2850816 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D2883584 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D2916352 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D2949120 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D2981888 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D3014656 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D3080192 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D3112960 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D3145728 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D3178496 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D3227648 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D3244032 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D3293184 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D3309568 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D3342336 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D3391488 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D3473408 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D3522560 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D3571712 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D3620864 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D3670016 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D3719168 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D3801088 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D3850240 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D3899392 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D3948544 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D3997696 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D4046848 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D4096000 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D4145152 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D4194304 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D4243456 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D4292608 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D4358144 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D4407296 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D4456448 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D4521984 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D4620288 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D4685824 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D4751360 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D4816896 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D4866048 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D4915200 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D4980736 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D5029888 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D5079040 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D5177344 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D5226496 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D5275648 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D5324800 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D5439488 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D5488640 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D5537792 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D5603328 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D5652480 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D5734400 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D5783552 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D5832704 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D5898240 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D5947392 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D6029312 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D6094848 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D6144000 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D6193152 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D6242304 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D6291456 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D6340608 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D6389760 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D6438912 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D6488064 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D6537216 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D6619136 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D6684672 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D6733824 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D6782976 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D6832128 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D6881280 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D6946816 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D6995968 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D7045120 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D7094272 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D7143424 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D7208960 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D7258112 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D7307264 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D7356416 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D7405568 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D7454720 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D7503872 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D7553024 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D7602176 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D7651328 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D7700480 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D7749632 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D7798784 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D7847936 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D7897088 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D7946240 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D7995392 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D8044544 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D8093696 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D8142848 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D8192000 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D8241152 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D8290304 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D8339456 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D8388608 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D8421376 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D8454144 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D8503296 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D8552448 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D8601600 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D8650752 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D8699904 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D8749056 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D8798208 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D8847360 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D8896512 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D8945664 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D8994816 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D9043968 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D9093120 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D9142272 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D9191424 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D9240576 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D9289728 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D9338880 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D9388032 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D9437184 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D9486336 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D9535488 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D9584640 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D9633792 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D9682944 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D9732096 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D9781248 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D9863168 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D9912320 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D9961472 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D10027008 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D10076160 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D10125312 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D10174464 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D10223616 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D10289152 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D10338304 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D10387456 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D10436608 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D10485760 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D10534912 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D10584064 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D10633216 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D10715136 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D10764288 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D10813440 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D10862592 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D10911744 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D10960896 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D11010048 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D11075584 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D11124736 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D11173888 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D11223040 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D11304960 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D11354112 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D11403264 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D11452416 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D11501568 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D11567104 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D11616256 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D11665408 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D11714560 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D11763712 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D11812864 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D11894784 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D11943936 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D12025856 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D12075008 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D12124160 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D12173312 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D12255232 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D12304384 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D12353536 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D12402688 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D12451840 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D12500992 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D12550144 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D12599296 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D12648448 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D12697600 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D12746752 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D12795904 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D12910592 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D12959744 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D13008896 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D13058048 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D13107200 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D13156352 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D13238272 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D13287424 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D13336576 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D13385728 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D13434880 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D13484032 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D13533184 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D13582336 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D13631488 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D13680640 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D13729792 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D13778944 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D13828096 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D13877248 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D13926400 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D13975552 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D14024704 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D14073856 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D14123008 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D14172160 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D14221312 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D14270464 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D14319616 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D14368768 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D14647296 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D14696448 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D14745600 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D14794752 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D14843904 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D14893056 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D14942208 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D14991360 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D15040512 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D15089664 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D15138816 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D15187968 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D15237120 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D15286272 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D15335424 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D15384576 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D15433728 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D15482880 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D15532032 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D15597568 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D15646720 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D15695872 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D15745024 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D15794176 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D15843328 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D15892480 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D15941632 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D15990784 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D16039936 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D16121856 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D16171008 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D16220160 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D16269312 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D16318464 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D16384000 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D16433152 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D16482304 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D16531456 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D16580608 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D16629760 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D16678912 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D16728064 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D16777216 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D16826368 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D16875520 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D16924672 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D16973824 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D17022976 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D17104896 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D17154048 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D17203200 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D17252352 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D17301504 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D17350656 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D17399808 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D17448960 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D17498112 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D17563648 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D17612800 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D17661952 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D17727488 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D17776640 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D17825792 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D17874944 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D17924096 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D17973248 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D18022400 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D18071552 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D18120704 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D18169856 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D18219008 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D18268160 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D18317312 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D18366464 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D18415616 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D18464768 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D18513920 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D18563072 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D18612224 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D18661376 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D18710528 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D18759680 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D18808832 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D18857984 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D18907136 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D18956288 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D19005440 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D19054592 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D19103744 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D19152896 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D19202048 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D19251200 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D19300352 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D19349504 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D19398656 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D19447808 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D19496960 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D19546112 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D19595264 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D19644416 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D19693568 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D19742720 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D19791872 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D19841024 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D19890176 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D19939328 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D19988480 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D20037632 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D20086784 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D20135936 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D20185088 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D20234240 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D20283392 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D20332544 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D20381696 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D20430848 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D20480000 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D20529152 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D20578304 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D20627456 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D20676608 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D20725760 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D20774912 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D20824064 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D20873216 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D20922368 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D20971520 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D21020672 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D21069824 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D21118976 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D21168128 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D21217280 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D21266432 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D21315584 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D21364736 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D21413888 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D21463040 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D21512192 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D21561344 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D21610496 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D21659648 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D21708800 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D21757952 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D21807104 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D21856256 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D21905408 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D21954560 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D22003712 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D22052864 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D22102016 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D22151168 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D22200320 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D22249472 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D22298624 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D22347776 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D22396928 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D22446080 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D22495232 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D22544384 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D22593536 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D22642688 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D22691840 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D22740992 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D22790144 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D22839296 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D22888448 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D22937600 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D22986752 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D23035904 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D23085056 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D23134208 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D23183360 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D23232512 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D23281664 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D23330816 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D23379968 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D23429120 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D23478272 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D23527424 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D23576576 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D23625728 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D23674880 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D23724032 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D23773184 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D23822336 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D23871488 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D23920640 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D23969792 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D24018944 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D24068096 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D24117248 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D24166400 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D24215552 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D24264704 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D24313856 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D24363008 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D24412160 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D24461312 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D24510464 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D24559616 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D24608768 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D24657920 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D24707072 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D24756224 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D24805376 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D24854528 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D24903680 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D24952832 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D25001984 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D25051136 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D25100288 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D25149440 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D25198592 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D25247744 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D25296896 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D25346048 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D25395200 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D25444352 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D25493504 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D25542656 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D25591808 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D25640960 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D25690112 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D25739264 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D25788416 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D25837568 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D25886720 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D25919488 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D25952256 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D26001408 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D26017792 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D26050560 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D26099712 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D26148864 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D26198016 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D26247168 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D26279936 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D26329088 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D26378240 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D26427392 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D26476544 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D26525696 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D26574848 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D26624000 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D26673152 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D26722304 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D26771456 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D26820608 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D26869760 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D26918912 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D26968064 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D27017216 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D27066368 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D27115520 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D27164672 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D27213824 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D27262976 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D27312128 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D27361280 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D27410432 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D27459584 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D27508736 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D27557888 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D27607040 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D27656192 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D27705344 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D27754496 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D27803648 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D27852800 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D27901952 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D27951104 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D28000256 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D28049408 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D28098560 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D28147712 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D28196864 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D28246016 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D28295168 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D28344320 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D28393472 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D28442624 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D28491776 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D28540928 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D28590080 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D28639232 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D28688384 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D28737536 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D28786688 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D28835840 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D28884992 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D28934144 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D28983296 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D29032448 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D29081600 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D29130752 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D29179904 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D29229056 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D29278208 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D29327360 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D29376512 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D29425664 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D29474816 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D29523968 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D29573120 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D29622272 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D29671424 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D29720576 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D29769728 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D29818880 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D29868032 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D29917184 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D29966336 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D30015488 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D30064640 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D30113792 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D30162944 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D30212096 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D30261248 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D30310400 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D30359552 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D30408704 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D30457856 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D30507008 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D30556160 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D30605312 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D30654464 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D30703616 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D30752768 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D30801920 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D30851072 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D30900224 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D30949376 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D30998528 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D31047680 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D31096832 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D31145984 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D31195136 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D31244288 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D31293440 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D31342592 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D31391744 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D31440896 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D31490048 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D31539200 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D31588352 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D31637504 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D31686656 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D31735808 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D31784960 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D31834112 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D31883264 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D31932416 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D31981568 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D32030720 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D32079872 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D32129024 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D32178176 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D32227328 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D32276480 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D32325632 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D32374784 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D32407552 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D32440320 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D32489472 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D32538624 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D32587776 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D32636928 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D32686080 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D32735232 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D32784384 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D32833536 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D32882688 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D32931840 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D32980992 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D33030144 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D33079296 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D33128448 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D33161216 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D33210368 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D33259520 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D33308672 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D33357824 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D33406976 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D33456128 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D33505280 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D33554432 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D33603584 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D33652736 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D33701888 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D33751040 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D33800192 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D33849344 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D33898496 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D33947648 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D33996800 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D34045952 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D34095104 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D34144256 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D34193408 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D34242560 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D34291712 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D34340864 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D34390016 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D34439168 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D34488320 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D34537472 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D34586624 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D34635776 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D34668544 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D34701312 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D34750464 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D34799616 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D34848768 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D34897920 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D34947072 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D34996224 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D35045376 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D35094528 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D35143680 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D35192832 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D35241984 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D35291136 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D35340288 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D35389440 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D35438592 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D35487744 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D35536896 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D35586048 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D35635200 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D35684352 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D35733504 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D35782656 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D35831808 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D35880960 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D35930112 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D35979264 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D36028416 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D36077568 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D36126720 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D36175872 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D36225024 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D36274176 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D36323328 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D36372480 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D36421632 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D36470784 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D36519936 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D36569088 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D36618240 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D36667392 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D36716544 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D36732928 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D36765696 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D36814848 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D36864000 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D36913152 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D36962304 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D37011456 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D37060608 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D37109760 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D37158912 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D37208064 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D37257216 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D37306368 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D37322752 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D37781504 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D37814272 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D37847040 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D37879808 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D37978112 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D38010880 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D38043648 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D38076416 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D38109184 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D38141952 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D38174720 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D38207488 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D38240256 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D38273024 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D38305792 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D38338560 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D38371328 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D38502400 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D38535168 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D38567936 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D38600704 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D38633472 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D38666240 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D38731776 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D38764544 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D38797312 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D38830080 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D38879232 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D38928384 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D38961152 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D38993920 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D39026688 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D39059456 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D39092224 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D39124992 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D39157760 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D39190528 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D39223296 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D39256064 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D39288832 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D39321600 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D39354368 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D39387136 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D39419904 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D39452672 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D39485440 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D39518208 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D39550976 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D39600128 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D39616512 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D39649280 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D39682048 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D39714816 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D39747584 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D39780352 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D39813120 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D39845888 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D39895040 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D39911424 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D39944192 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D39976960 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D40009728 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D40042496 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D40075264 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D40108032 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D40140800 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D40173568 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D40206336 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D40239104 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D40271872 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D40304640 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D40337408 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D40370176 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D40402944 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D40435712 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D40468480 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D40501248 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D40534016 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D40566784 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D40599552 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D40632320 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D40665088 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D40697856 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D40730624 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D40779776 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D40796160 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D40828928 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D40861696 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D40894464 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D40927232 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D40960000 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D40992768 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D41025536 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D41058304 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D41091072 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D41123840 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D41156608 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D41189376 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D41222144 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D41254912 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D41287680 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D41320448 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D41353216 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D41385984 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D41418752 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D41451520 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D41484288 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D41517056 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D41549824 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D41582592 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D41615360 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D41648128 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D41680896 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D41713664 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D41746432 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D41779200 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D41828352 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D41844736 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D41877504 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D41910272 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D41943040 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D41975808 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D42008576 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D42041344 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D42074112 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D42106880 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D42139648 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D42172416 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D42205184 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D42237952 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D42270720 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D42303488 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D42336256 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D42369024 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D42401792 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D42434560 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D42467328 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D42500096 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D42565632 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D42598400 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D42631168 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D42696704 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D42729472 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D42762240 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D42795008 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D42827776 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D42860544 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D42926080 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D42958848 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D43024384 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D43057152 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D43089920 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D43122688 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D43155456 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D43188224 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D43220992 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D43253760 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D43384832 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D43417600 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D43466752 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D43483136 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D43515904 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D43548672 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D43581440 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D43646976 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D43679744 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D43745280 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D43778048 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D43810816 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D43876352 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D43941888 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D43974656 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D44007424 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D44072960 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D44138496 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D44171264 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D44204032 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D44236800 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D44269568 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D44302336 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D44335104 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D44367872 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D44433408 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D44482560 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D44498944 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D44548096 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D44564480 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D44597248 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D44630016 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D44662784 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D44711936 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D44728320 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D44761088 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D44793856 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D44826624 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D44875776 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D44892160 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D44941312 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D44990464 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D45039616 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D45088768 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D45137920 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D45187072 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D45236224 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D45285376 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D45334528 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D45383680 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D45432832 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D45481984 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D45531136 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D45580288 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D45629440 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D45678592 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D45727744 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D45776896 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D45826048 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D45875200 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D45924352 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D45973504 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D46022656 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D46039040 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D46071808 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D46120960 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D46137344 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D46170112 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D46219264 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D46235648 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D46268416 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D46301184 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D46333952 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D46366720 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D46399488 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D46432256 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D46596096 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D46661632 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D46694400 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D46743552 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D47022080 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D47349760 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D47415296 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D47464448 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D47513600 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D47546368 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D47579136 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D47611904 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D47661056 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D47677440 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D47710208 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D47742976 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D47792128 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D47841280 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D47874048 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D47906816 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D47939584 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D47972352 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D48037888 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D48070656 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D48103424 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D48136192 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D48168960 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D48201728 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D48234496 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D48267264 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D48300032 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D48332800 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D48365568 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D48398336 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D48431104 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D48529408 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D48562176 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D48627712 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D48660480 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D48693248 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D48955392 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D49152000 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D49184768 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D49217536 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D49250304 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D49283072 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D49315840 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D49381376 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D49414144 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D49463296 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D49479680 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D49512448 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D49545216 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D49610752 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D49643520 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D49676288 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D49725440 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D49741824 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D49774592 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D49807360 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D50954240 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D50987008 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D51019776 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D51052544 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D51085312 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D51150848 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D51200000 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D51216384 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D51249152 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D51281920 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D51314688 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D51363840 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D51478528 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D51511296 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D51544064 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D51576832 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D51609600 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D51642368 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D51707904 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D51740672 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D51773440 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D51806208 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D51838976 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D51871744 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D51904512 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D51937280 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D51970048 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D52002816 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D52035584 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D52084736 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D52101120 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D52133888 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D52183040 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D52199424 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D52232192 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D52264960 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D52297728 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D52330496 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D52363264 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D52396032 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D52445184 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D52461568 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D52494336 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D52527104 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D52559872 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D52592640 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D52625408 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D52658176 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D52690944 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D52723712 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D52756480 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D52789248 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D52822016 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D52854784 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D52887552 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D52920320 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D52953088 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D52985856 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D53018624 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D53051392 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D53084160 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D53116928 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D53149696 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D53182464 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D53231616 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D53248000 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D53280768 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D53313536 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D53346304 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D53379072 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D53411840 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D53444608 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D53477376 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D53510144 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D53542912 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D53575680 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D53608448 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D53641216 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D53673984 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D53706752 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D53739520 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D53772288 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D53805056 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D53837824 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D53870592 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D53903360 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D53936128 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D53968896 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D54001664 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D54034432 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D54083584 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D54099968 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D54149120 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D54165504 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D54198272 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D54231040 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D54263808 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D54296576 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D55574528 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D56229888 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D60620800 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D61079552 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D61112320 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D61145088 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D61177856 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D65732608 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D65765376 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D65814528 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D66158592 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D66289664 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D67174400 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D67272704 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D67305472 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D68517888 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D68583424 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D68616192 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D68714496 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D68780032 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D68829184 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D68845568 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D68878336 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D68911104 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D68943872 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D68976640 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D69009408 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D69042176 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D69074944 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D69107712 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D69140480 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D69173248 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D69206016 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D69255168 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D69304320 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D69337088 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D69369856 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D69402624 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D69435392 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D69468160 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D69500928 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D69550080 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D69599232 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D69632000 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D69664768 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D69861376 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D69910528 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D70057984 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D70123520 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D70156288 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D70483968 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D70647808 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D70844416 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D70975488 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D71008256 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D71073792 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D71172096 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D71794688 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D71892992 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D72089600 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D72155136 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D72318976 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D72843264 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D72876032 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D72925184 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D73007104 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D73203712 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D73236480 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D73302016 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D73334784 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D73433088 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D73482240 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D73498624 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D73564160 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D73596928 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D73662464 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D73695232 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D73728000 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D73826304 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D73875456 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D73891840 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D73924608 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D73957376 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D74006528 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D74022912 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D74072064 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D74121216 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D74153984 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D74186752 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D74252288 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D74285056 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D74317824 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D74383360 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D74416128 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D74448896 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D74481664 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D74514432 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D74547200 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D74579968 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D74612736 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D74661888 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D74678272 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D74711040 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D74743808 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D74809344 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D74842112 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D74907648 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D74940416 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D75005952 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D75038720 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D75137024 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D75268096 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D75300864 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D75333632 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D75399168 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D75431936 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D75481088 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D75530240 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D75628544 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D75661312 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D75759616 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D75792384 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D75857920 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D75923456 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D76087296 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D76152832 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D76201984 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D76251136 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D76316672 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D76414976 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D76578816 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D76611584 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D76677120 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D76726272 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D76742656 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D76808192 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D76840960 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D76890112 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D76906496 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D76939264 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D76972032 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D77004800 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D77037568 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D77103104 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D77135872 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D77185024 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D77201408 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D77234176 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D77266944 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D77299712 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D77332480 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D77430784 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D77463552 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D77529088 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D77561856 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D77627392 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D77660160 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D77725696 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D77774848 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D77856768 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D77889536 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D77938688 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D77955072 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D77987840 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D78036992 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D78086144 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D78118912 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D78151680 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D78184448 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D78217216 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D78266368 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D78282752 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D78315520 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D78348288 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D78512128 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D78544896 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D78577664 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D78610432 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D78643200 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D78692352 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D78708736 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D78757888 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D78774272 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D78823424 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D78839808 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D78872576 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D78921728 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D78970880 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D79003648 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D79036416 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D79069184 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D79101952 length=3D32768
> clone home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> source=3Dhome/denns/.mozilla/firefox/dtfto95g.default/places.sqlite
> source offset=3D79134720 offset=3D79134720 length=3D4751360
> ERROR: failed to clone extents to
> home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite: Invalid
> argument
>
> $ stat /home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite
>   File: /home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite
>   Size: 83886080      Blocks: 163840     IO Block: 4096   regular file
> Device: 21h/33d    Inode: 400698      Links: 1
> Access: (0640/-rw-r-----)  Uid: ( 1000/   denns)   Gid: ( 1000/   denns)
> Access: 2021-08-30 12:46:18.630071823 -0700
> Modify: 2021-08-30 12:46:57.689779394 -0700
> Change: 2021-08-30 12:46:57.689779394 -0700
>  Birth: 2021-08-07 20:16:37.080012116 -0700
>
> $ btrfs subvolume list /|grep '\(881\)\|\(977\)'
> ID 881 gen 35385 top level 453 path .snapshots/327/snapshot
> ID 977 gen 39922 top level 453 path .snapshots/374/snapshot

Then we should see a message in dmesg mentioning the -EINVAL error and
inode 400698.
Previously that happened for some other inode (and yes, inode numbers
are preserved when doing send/receive - if the number is not the same
at the destination's snapshot, then the snapshot was changed - turned
RW, and files deleted/recreated or renamed for ex).

Anyway I'm attaching a new debug patch, it will produce more logs as
it's not filtering anymore for a specific inode and root numbers, and
logs some other variables to help figure it out. And please use the
same snapshots as before.

Patch attached and also at https://pastebin.com/raw/gEDMbKtX

Many thanks for the patiente and trying all this out.



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D

--000000000000db371805cacd197a
Content-Type: text/x-patch; charset="US-ASCII"; name="debug_send_clone_2.patch"
Content-Disposition: attachment; filename="debug_send_clone_2.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ksz4f7jj0>
X-Attachment-Id: f_ksz4f7jj0

ZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL3JlZmxpbmsuYyBiL2ZzL2J0cmZzL3JlZmxpbmsuYwppbmRl
eCA0YTVmMmMzNWMwMzQuLmE0YTAwZGI5ZDU0NyAxMDA2NDQKLS0tIGEvZnMvYnRyZnMvcmVmbGlu
ay5jCisrKyBiL2ZzL2J0cmZzL3JlZmxpbmsuYwpAQCAtNzgwLDYgKzc4MCwxMyBAQCBzdGF0aWMg
aW50IGJ0cmZzX3JlbWFwX2ZpbGVfcmFuZ2VfcHJlcChzdHJ1Y3QgZmlsZSAqZmlsZV9pbiwgbG9m
Zl90IHBvc19pbiwKIAkvKiBEb24ndCBtYWtlIHRoZSBkc3QgZmlsZSBwYXJ0bHkgY2hlY2tzdW1t
ZWQgKi8KIAlpZiAoKEJUUkZTX0koaW5vZGVfaW4pLT5mbGFncyAmIEJUUkZTX0lOT0RFX05PREFU
QVNVTSkgIT0KIAkgICAgKEJUUkZTX0koaW5vZGVfb3V0KS0+ZmxhZ3MgJiBCVFJGU19JTk9ERV9O
T0RBVEFTVU0pKSB7CisJCWlmICghKHJlbWFwX2ZsYWdzICYgUkVNQVBfRklMRV9ERURVUCkpIHsK
KwkJCXN0cnVjdCBidHJmc19mc19pbmZvICpmc19pbmZvID0gQlRSRlNfSShpbm9kZV9pbiktPnJv
b3QtPmZzX2luZm87CisKKwkJCWJ0cmZzX2luZm8oZnNfaW5mbywgImNsb25lOiBub2RhdGFzdW0g
bWlzbWF0Y2gsIHNyYyAlbGx1IChyb290ICVsbHUpIGRzdCAlbGx1IChyb290ICVsbHUpIiwKKwkJ
CQkgICBidHJmc19pbm8oQlRSRlNfSShpbm9kZV9pbikpLCBCVFJGU19JKGlub2RlX2luKS0+cm9v
dC0+cm9vdF9rZXkub2JqZWN0aWQsCisJCQkJICAgYnRyZnNfaW5vKEJUUkZTX0koaW5vZGVfb3V0
KSksIEJUUkZTX0koaW5vZGVfb3V0KS0+cm9vdC0+cm9vdF9rZXkub2JqZWN0aWQpOworCQl9CiAJ
CXJldHVybiAtRUlOVkFMOwogCX0KIApAQCAtODYzLDkgKzg3MCwxNiBAQCBsb2ZmX3QgYnRyZnNf
cmVtYXBfZmlsZV9yYW5nZShzdHJ1Y3QgZmlsZSAqc3JjX2ZpbGUsIGxvZmZfdCBvZmYsCiAJc3Ry
dWN0IGlub2RlICpkc3RfaW5vZGUgPSBmaWxlX2lub2RlKGRzdF9maWxlKTsKIAlib29sIHNhbWVf
aW5vZGUgPSBkc3RfaW5vZGUgPT0gc3JjX2lub2RlOwogCWludCByZXQ7Ci0KLQlpZiAocmVtYXBf
ZmxhZ3MgJiB+KFJFTUFQX0ZJTEVfREVEVVAgfCBSRU1BUF9GSUxFX0FEVklTT1JZKSkKKwlzdHJ1
Y3QgYnRyZnNfZnNfaW5mbyAqZnNfaW5mbyA9IEJUUkZTX0koc3JjX2lub2RlKS0+cm9vdC0+ZnNf
aW5mbzsKKwljb25zdCBsb2ZmX3Qgb2xlbiA9IGxlbjsKKworCWlmIChyZW1hcF9mbGFncyAmIH4o
UkVNQVBfRklMRV9ERURVUCB8IFJFTUFQX0ZJTEVfQURWSVNPUlkpKSB7CisJCWJ0cmZzX2luZm8o
ZnNfaW5mbywgImNsb25lOiAtRUlOVkFMIGZsYWdzLCBzcmMgJWxsdSAocm9vdCAlbGx1KSBkc3Qg
JWxsdSAocm9vdCAlbGx1KSwgb2ZmICVsbGQgZGVzdG9mZiAlbGxkIGxlbiAlbGxkIG9sZW4gJWxs
ZCwgc3JjIGlfc2l6ZSAlbGxkIGRzdCBpX3NpemUgJWxsZCBicyAlbHUgcmVtYXBfZmxhZ3MgJXUi
LAorCQkJICAgYnRyZnNfaW5vKEJUUkZTX0koc3JjX2lub2RlKSksIEJUUkZTX0koc3JjX2lub2Rl
KS0+cm9vdC0+cm9vdF9rZXkub2JqZWN0aWQsCisJCQkgICBidHJmc19pbm8oQlRSRlNfSShkc3Rf
aW5vZGUpKSwgQlRSRlNfSShkc3RfaW5vZGUpLT5yb290LT5yb290X2tleS5vYmplY3RpZCwKKwkJ
CSAgIG9mZiwgZGVzdG9mZiwgbGVuLCBvbGVuLCBpX3NpemVfcmVhZChzcmNfaW5vZGUpLCBpX3Np
emVfcmVhZChkc3RfaW5vZGUpLCBkc3RfaW5vZGUtPmlfc2ItPnNfYmxvY2tzaXplLCByZW1hcF9m
bGFncyk7CiAJCXJldHVybiAtRUlOVkFMOworCX0KIAogCWlmIChzYW1lX2lub2RlKSB7CiAJCWJ0
cmZzX2lub2RlX2xvY2soc3JjX2lub2RlLCBCVFJGU19JTE9DS19NTUFQKTsKQEAgLTg3Niw2ICs4
OTAsMTEgQEAgbG9mZl90IGJ0cmZzX3JlbWFwX2ZpbGVfcmFuZ2Uoc3RydWN0IGZpbGUgKnNyY19m
aWxlLCBsb2ZmX3Qgb2ZmLAogCiAJcmV0ID0gYnRyZnNfcmVtYXBfZmlsZV9yYW5nZV9wcmVwKHNy
Y19maWxlLCBvZmYsIGRzdF9maWxlLCBkZXN0b2ZmLAogCQkJCQkgICZsZW4sIHJlbWFwX2ZsYWdz
KTsKKwlpZiAocmV0ID09IC1FSU5WQUwgJiYgIShyZW1hcF9mbGFncyAmIFJFTUFQX0ZJTEVfREVE
VVApKQorCQlidHJmc19pbmZvKGZzX2luZm8sICJjbG9uZTogLUVJTlZBTCBvdGhlciwgc3JjICVs
bHUgKHJvb3QgJWxsdSkgZHN0ICVsbHUgKHJvb3QgJWxsdSksIG9mZiAlbGxkIGRlc3RvZmYgJWxs
ZCBsZW4gJWxsZCBvbGVuICVsbGQsIHNyYyBpX3NpemUgJWxsZCBkc3QgaV9zaXplICVsbGQgYnMg
JWx1IHJlbWFwX2ZsYWdzICV1IiwKKwkJCSAgIGJ0cmZzX2lubyhCVFJGU19JKHNyY19pbm9kZSkp
LCBCVFJGU19JKHNyY19pbm9kZSktPnJvb3QtPnJvb3Rfa2V5Lm9iamVjdGlkLAorCQkJICAgYnRy
ZnNfaW5vKEJUUkZTX0koZHN0X2lub2RlKSksIEJUUkZTX0koZHN0X2lub2RlKS0+cm9vdC0+cm9v
dF9rZXkub2JqZWN0aWQsCisJCQkgICBvZmYsIGRlc3RvZmYsIGxlbiwgb2xlbiwgaV9zaXplX3Jl
YWQoc3JjX2lub2RlKSwgaV9zaXplX3JlYWQoZHN0X2lub2RlKSwgZHN0X2lub2RlLT5pX3NiLT5z
X2Jsb2Nrc2l6ZSwgcmVtYXBfZmxhZ3MpOwogCWlmIChyZXQgPCAwIHx8IGxlbiA9PSAwKQogCQln
b3RvIG91dF91bmxvY2s7CiAKZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL3NlbmQuYyBiL2ZzL2J0cmZz
L3NlbmQuYwppbmRleCBhZmRjYmU3ODQ0ZTAuLmYwYjBiNzg1YTNlMiAxMDA2NDQKLS0tIGEvZnMv
YnRyZnMvc2VuZC5jCisrKyBiL2ZzL2J0cmZzL3NlbmQuYwpAQCAtNTA0NCw2ICs1MDQ0LDEwIEBA
IHN0YXRpYyBpbnQgc2VuZF9jbG9uZShzdHJ1Y3Qgc2VuZF9jdHggKnNjdHgsCiAJCSAgICBvZmZz
ZXQsIGxlbiwgY2xvbmVfcm9vdC0+cm9vdC0+cm9vdF9rZXkub2JqZWN0aWQsCiAJCSAgICBjbG9u
ZV9yb290LT5pbm8sIGNsb25lX3Jvb3QtPm9mZnNldCk7CiAKKwlXQVJOX09OKGNsb25lX3Jvb3Qt
PnJvb3QgPT0gc2N0eC0+c2VuZF9yb290ICYmCisJCWNsb25lX3Jvb3QtPmlubyA9PSBzY3R4LT5j
dXJfaW5vICYmCisJCWNsb25lX3Jvb3QtPm9mZnNldCA9PSBvZmZzZXQpOworCiAJcCA9IGZzX3Bh
dGhfYWxsb2MoKTsKIAlpZiAoIXApCiAJCXJldHVybiAtRU5PTUVNOwpAQCAtNTI4MCw2ICs1Mjg0
LDcgQEAgc3RhdGljIGludCBjbG9uZV9yYW5nZShzdHJ1Y3Qgc2VuZF9jdHggKnNjdHgsCiAJc3Ry
dWN0IGJ0cmZzX2tleSBrZXk7CiAJaW50IHJldDsKIAl1NjQgY2xvbmVfc3JjX2lfc2l6ZSA9IDA7
CisJc3RydWN0IGJ0cmZzX2ZzX2luZm8gKmZzX2luZm8gPSBzY3R4LT5zZW5kX3Jvb3QtPmZzX2lu
Zm87CiAKIAkvKgogCSAqIFByZXZlbnQgY2xvbmluZyBmcm9tIGEgemVybyBvZmZzZXQgd2l0aCBh
IGxlbmd0aCBtYXRjaGluZyB0aGUgc2VjdG9yCkBAIC01MzQ5LDYgKzUzNTQsMTAgQEAgc3RhdGlj
IGludCBjbG9uZV9yYW5nZShzdHJ1Y3Qgc2VuZF9jdHggKnNjdHgsCiAJCQlwYXRoLT5zbG90c1sw
XS0tOwogCX0KIAorCWJ0cmZzX2luZm8oZnNfaW5mbywgInNlbmQ6IGNsb25lX3JhbmdlKCkgc3Rh
cnQgaW5vICVsbHUgb2Zmc2V0ICVsbHUgc2VuZCByb290ICVsbHUsIGNsb25lIHJvb3QgJWxsdSBp
bm8gJWxsdSBvZmZzZXQgJWxsdSBkYXRhX29mZnNldCAlbGx1IGxlbiAlbGx1IGRpc2tfYnl0ZSAl
bGx1IGNsb25lX3NyY19pX3NpemUgJWxsdSBuZXh0X3dyaXRlX29mZnNldCAlbGx1IiwKKwkJICAg
c2N0eC0+Y3VyX2lubywgb2Zmc2V0LCBzY3R4LT5zZW5kX3Jvb3QtPnJvb3Rfa2V5Lm9iamVjdGlk
LCBjbG9uZV9yb290LT5yb290LT5yb290X2tleS5vYmplY3RpZCwgY2xvbmVfcm9vdC0+aW5vLCBj
bG9uZV9yb290LT5vZmZzZXQsIGRhdGFfb2Zmc2V0LCBsZW4sCisJCSAgIGRpc2tfYnl0ZSwgY2xv
bmVfc3JjX2lfc2l6ZSwgc2N0eC0+Y3VyX2lub2RlX25leHRfd3JpdGVfb2Zmc2V0KTsKKwogCXdo
aWxlICh0cnVlKSB7CiAJCXN0cnVjdCBleHRlbnRfYnVmZmVyICpsZWFmID0gcGF0aC0+bm9kZXNb
MF07CiAJCWludCBzbG90ID0gcGF0aC0+c2xvdHNbMF07CkBAIC01NDE3LDYgKzU0MjYsMTEgQEAg
c3RhdGljIGludCBjbG9uZV9yYW5nZShzdHJ1Y3Qgc2VuZF9jdHggKnNjdHgsCiAJCQlleHRfbGVu
ID0gY2xvbmVfc3JjX2lfc2l6ZSAtIGtleS5vZmZzZXQ7CiAKIAkJY2xvbmVfZGF0YV9vZmZzZXQg
PSBidHJmc19maWxlX2V4dGVudF9vZmZzZXQobGVhZiwgZWkpOworCisJCWJ0cmZzX2luZm8oZnNf
aW5mbywgInNlbmQ6IGNsb25lX3JhbmdlKCkgc3RlcCAxIGlubyAlbGx1IG9mZnNldCAlbGx1LCBy
b290IG9mZnNldCAlbGx1IGlubyAlbGx1IGRhdGFfb2Zmc2V0ICVsbHUgbGVuICVsbHUsIGtleS5v
ZmZzZXQgJWxsdSBleHRfbGVuICVsbHUgY2xvbmVfZGF0YV9vZmZzZXQgJWxsdSBmb3VuZCBkaXNr
X2J5dGUgJWxsdSBuZXh0X3dyaXRlX29mZnNldCAlbGx1IiwKKwkJCSAgIHNjdHgtPmN1cl9pbm8s
IG9mZnNldCwgY2xvbmVfcm9vdC0+b2Zmc2V0LCBjbG9uZV9yb290LT5pbm8sIGRhdGFfb2Zmc2V0
LCBsZW4sIGtleS5vZmZzZXQsIGV4dF9sZW4sIGNsb25lX2RhdGFfb2Zmc2V0LCBidHJmc19maWxl
X2V4dGVudF9kaXNrX2J5dGVucihsZWFmLCBlaSksCisJCQkgICBzY3R4LT5jdXJfaW5vZGVfbmV4
dF93cml0ZV9vZmZzZXQpOworCiAJCWlmIChidHJmc19maWxlX2V4dGVudF9kaXNrX2J5dGVucihs
ZWFmLCBlaSkgPT0gZGlza19ieXRlKSB7CiAJCQljbG9uZV9yb290LT5vZmZzZXQgPSBrZXkub2Zm
c2V0OwogCQkJaWYgKGNsb25lX2RhdGFfb2Zmc2V0IDwgZGF0YV9vZmZzZXQgJiYKQEAgLTU0NjIs
NiArNTQ3Niw5IEBAIHN0YXRpYyBpbnQgY2xvbmVfcmFuZ2Uoc3RydWN0IHNlbmRfY3R4ICpzY3R4
LAogCiAJCQkJc2xlbiA9IEFMSUdOX0RPV04oc3JjX2VuZCAtIGNsb25lX3Jvb3QtPm9mZnNldCwK
IAkJCQkJCSAgc2VjdG9yc2l6ZSk7CisJCQkJYnRyZnNfaW5mbyhmc19pbmZvLCAic2VuZDogY2xv
bmVfcmFuZ2UoKSBzdGVwIDItMS0xIGlubyAlbGx1IG9mZnNldCAlbGx1LCByb290IG9mZnNldCAl
bGx1IGlubyAlbGx1IGRhdGFfb2Zmc2V0ICVsbHUgbGVuICVsbHUsIGNsb25lX2xlbiAlbGx1IHNy
Y19lbmQgJWxsdSBzbGVuICVsbHUiLAorCQkJCQkgICBzY3R4LT5jdXJfaW5vLCBvZmZzZXQsIGNs
b25lX3Jvb3QtPm9mZnNldCwgY2xvbmVfcm9vdC0+aW5vLCBkYXRhX29mZnNldCwgbGVuLCBjbG9u
ZV9sZW4sIHNyY19lbmQsIHNsZW4pOworCiAJCQkJaWYgKHNsZW4gPiAwKSB7CiAJCQkJCXJldCA9
IHNlbmRfY2xvbmUoc2N0eCwgb2Zmc2V0LCBzbGVuLAogCQkJCQkJCSBjbG9uZV9yb290KTsKQEAg
LTU0NzEsMTAgKzU0ODgsMTUgQEAgc3RhdGljIGludCBjbG9uZV9yYW5nZShzdHJ1Y3Qgc2VuZF9j
dHggKnNjdHgsCiAJCQkJcmV0ID0gc2VuZF9leHRlbnRfZGF0YShzY3R4LCBvZmZzZXQgKyBzbGVu
LAogCQkJCQkJICAgICAgIGNsb25lX2xlbiAtIHNsZW4pOwogCQkJfSBlbHNlIHsKKwkJCQlidHJm
c19pbmZvKGZzX2luZm8sICJzZW5kOiBjbG9uZV9yYW5nZSgpIHN0ZXAgMi0xLTIgaW5vICVsbHUg
b2Zmc2V0ICVsbHUsIHJvb3Qgb2Zmc2V0ICVsbHUgaW5vICVsbHUgZGF0YV9vZmZzZXQgJWxsdSBs
ZW4gJWxsdSwgY2xvbmVfbGVuICVsbHUiLAorCQkJCQkgICBzY3R4LT5jdXJfaW5vLCBvZmZzZXQs
IGNsb25lX3Jvb3QtPm9mZnNldCwgY2xvbmVfcm9vdC0+aW5vLCBkYXRhX29mZnNldCwgbGVuLCBj
bG9uZV9sZW4pOworCiAJCQkJcmV0ID0gc2VuZF9jbG9uZShzY3R4LCBvZmZzZXQsIGNsb25lX2xl
biwKIAkJCQkJCSBjbG9uZV9yb290KTsKIAkJCX0KIAkJfSBlbHNlIHsKKwkJCWJ0cmZzX2luZm8o
ZnNfaW5mbywgInNlbmQ6IGNsb25lX3JhbmdlKCkgc3RlcCAyLTIgaW5vICVsbHUgb2Zmc2V0ICVs
bHUsIHJvb3Qgb2Zmc2V0ICVsbHUgaW5vICVsbHUgZGF0YV9vZmZzZXQgJWxsdSBsZW4gJWxsdSBj
bG9uZV9sZW4gJWxsdSIsCisJCQkJICAgc2N0eC0+Y3VyX2lubywgb2Zmc2V0LCBjbG9uZV9yb290
LT5vZmZzZXQsIGNsb25lX3Jvb3QtPmlubywgZGF0YV9vZmZzZXQsIGxlbiwgY2xvbmVfbGVuKTsK
IAkJCXJldCA9IHNlbmRfZXh0ZW50X2RhdGEoc2N0eCwgb2Zmc2V0LCBjbG9uZV9sZW4pOwogCQl9
CiAKQEAgLTU1MTEsNiArNTUzMywxMCBAQCBzdGF0aWMgaW50IGNsb25lX3JhbmdlKHN0cnVjdCBz
ZW5kX2N0eCAqc2N0eCwKIAllbHNlCiAJCXJldCA9IDA7CiBvdXQ6CisJYnRyZnNfaW5mbyhmc19p
bmZvLCAic2VuZDogY2xvbmVfcmFuZ2UoKSBlbmQgaW5vICVsbHUgb2Zmc2V0ICVsbHUgc2VuZCBy
b290ICVsbHUsIGNsb25lIHJvb3QgJWxsdSBpbm8gJWxsdSBvZmZzZXQgJWxsdSBkYXRhX29mZnNl
dCAlbGx1IGxlbiAlbGx1IGRpc2tfYnl0ZSAlbGx1IGNsb25lX3NyY19pX3NpemUgJWxsdSBuZXh0
X3dyaXRlX29mZnNldCAlbGx1IHJldCAlZCIsCisJCSAgIHNjdHgtPmN1cl9pbm8sIG9mZnNldCwg
c2N0eC0+c2VuZF9yb290LT5yb290X2tleS5vYmplY3RpZCwgY2xvbmVfcm9vdC0+cm9vdC0+cm9v
dF9rZXkub2JqZWN0aWQsIGNsb25lX3Jvb3QtPmlubywgY2xvbmVfcm9vdC0+b2Zmc2V0LCBkYXRh
X29mZnNldCwgbGVuLAorCQkgICBkaXNrX2J5dGUsIGNsb25lX3NyY19pX3NpemUsIHNjdHgtPmN1
cl9pbm9kZV9uZXh0X3dyaXRlX29mZnNldCwgcmV0KTsKKwogCWJ0cmZzX2ZyZWVfcGF0aChwYXRo
KTsKIAlyZXR1cm4gcmV0OwogfQo=
--000000000000db371805cacd197a--
