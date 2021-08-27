Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830F23F9E73
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Aug 2021 20:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238986AbhH0SCh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Aug 2021 14:02:37 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:34727 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbhH0SCg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Aug 2021 14:02:36 -0400
Received: by mail-lj1-f170.google.com with SMTP id f2so12904265ljn.1
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Aug 2021 11:01:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FefjUAPzQkrE8tjdY9Cim4Tvcj6mKDg1C8/kdc54AoQ=;
        b=HdWTN1IZU+vk8VHGYarFhAMW9yT52Eg5CGGYZJzNeb3BtUZ95D+zApcK7J8IfINfmo
         DYjKjvKRzjtIGx4nFIQA6okNkDT4H0qelbUmDzdG+J5UOTJNCzfK2rC1GYFXO51yzmf+
         z4s/qdWayelsNpGjFo7mncIgllUBciJZWthUMezTiVpGT2mclZtBvR/kSIC8A7v2izr6
         EqFqotNfFgJeeQtoKxHRC5AjnzM8xZzOJj0ohWu5nyyztn5RF1uyPGeJhmBPxMOdJugk
         F/k7H+UX9aziJYkHkrhtx8CX21PsXplN8DvCSPKL5FUxKxKrSj9gRryvF5mwNbrl3HnS
         DYpA==
X-Gm-Message-State: AOAM531kJHxVI+1zJxLQeNakKqAiL1b4TM7jTgdeXBBHZui+5CL4UUnr
        uL7CeputkrkLFfXjTF/0atjF6b+Idc18JQf7MS6CDVK8/d8=
X-Google-Smtp-Source: ABdhPJzGsBBnyePhNyRgAImVnS1tx3FZD5hQB8bAuAds3sqimEwwdrS4Ol2gHKLUTWT+B8W0iZcuEkQAXj1K9dQdIZg=
X-Received: by 2002:a05:651c:1792:: with SMTP id bn18mr8898354ljb.325.1630087304838;
 Fri, 27 Aug 2021 11:01:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAOaVUnV3L6RpcqJ5gaqzNXWXK0VMkEVXCdihawH1PgS6TiMchQ@mail.gmail.com>
 <CAL3q7H5P1+s5LOa6TutNhPKOyWUA7hifjD1XuhBP6_e3SQzR8Q@mail.gmail.com>
 <CAOaVUnU6z8U0a2T7a0cLg1U=b1bfyq_xHa8hoXMnu6Qv1E-z+g@mail.gmail.com> <CAL3q7H7kbgsiTfLWWYJikuWOFP9yXSdgav2EEonx98pPhSEQNA@mail.gmail.com>
In-Reply-To: <CAL3q7H7kbgsiTfLWWYJikuWOFP9yXSdgav2EEonx98pPhSEQNA@mail.gmail.com>
From:   Darrell Enns <darrell@darrellenns.com>
Date:   Fri, 27 Aug 2021 11:01:33 -0700
Message-ID: <CAOaVUnV9FJSVBxmX-tAeZJCq+0rPoY2zga8nuw_toC=tdt8K0w@mail.gmail.com>
Subject: Re: Backup failing with "failed to clone extents" error
To:     fdmanana@gmail.com
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I tried it with the patch and it still failed. Here's the verbose output:

write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=0 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=65536 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=98304 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=131072 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=163840 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=212992 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=491520 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=557056 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=753664 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=786432 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=819200 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=851968 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=884736 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=950272 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=983040 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=1032192 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=1081344 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=1245184 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=1343488 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=1376256 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=1425408 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=1441792 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=1474560 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=1507328 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=1556480 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=1605632 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=1638400 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=1671168 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=1703936 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=1736704 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=1785856 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=1802240 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=1835008 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=1867776 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=1900544 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=1933312 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=1982464 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=1998848 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=2031616 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=2064384 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=2097152 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=2129920 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=2162688 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=2195456 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=2228224 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=2260992 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=2293760 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=2326528 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=2359296 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=2392064 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=2424832 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=2473984 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=2490368 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=2523136 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=2555904 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=2588672 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=2621440 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=2654208 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=2686976 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=2719744 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=2752512 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=2801664 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=2818048 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=2850816 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=2883584 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=2916352 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=2949120 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=2981888 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=3014656 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=3080192 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=3112960 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=3145728 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=3178496 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=3227648 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=3244032 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=3293184 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=3309568 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=3342336 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=3391488 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=3473408 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=3522560 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=3571712 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=3620864 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=3670016 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=3719168 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=3801088 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=3850240 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=3899392 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=3948544 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=3997696 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=4046848 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=4096000 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=4145152 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=4194304 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=4243456 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=4292608 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=4358144 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=4407296 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=4456448 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=4521984 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=4620288 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=4685824 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=4751360 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=4816896 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=4866048 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=4915200 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=4980736 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=5029888 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=5079040 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=5177344 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=5226496 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=5275648 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=5324800 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=5439488 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=5488640 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=5537792 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=5603328 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=5652480 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=5734400 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=5783552 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=5832704 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=5898240 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=5947392 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=6029312 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=6094848 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=6144000 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=6193152 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=6242304 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=6291456 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=6340608 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=6389760 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=6438912 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=6488064 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=6537216 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=6619136 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=6684672 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=6733824 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=6782976 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=6832128 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=6881280 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=6946816 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=6995968 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=7045120 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=7094272 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=7143424 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=7208960 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=7258112 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=7307264 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=7356416 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=7405568 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=7454720 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=7503872 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=7553024 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=7602176 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=7651328 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=7700480 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=7749632 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=7798784 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=7847936 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=7897088 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=7946240 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=7995392 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=8044544 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=8093696 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=8142848 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=8192000 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=8241152 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=8290304 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=8339456 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=8388608 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=8421376 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=8454144 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=8503296 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=8552448 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=8601600 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=8650752 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=8699904 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=8749056 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=8798208 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=8847360 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=8896512 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=8945664 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=8994816 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=9043968 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=9093120 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=9142272 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=9191424 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=9240576 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=9289728 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=9338880 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=9388032 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=9437184 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=9486336 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=9535488 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=9584640 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=9633792 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=9682944 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=9732096 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=9781248 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=9863168 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=9912320 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=9961472 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=10027008 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=10076160 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=10125312 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=10174464 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=10223616 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=10289152 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=10338304 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=10387456 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=10436608 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=10485760 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=10534912 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=10584064 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=10633216 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=10715136 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=10764288 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=10813440 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=10862592 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=10911744 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=10960896 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=11010048 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=11075584 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=11124736 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=11173888 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=11223040 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=11304960 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=11354112 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=11403264 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=11452416 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=11501568 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=11567104 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=11616256 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=11665408 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=11714560 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=11763712 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=11812864 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=11894784 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=11943936 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=12025856 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=12075008 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=12124160 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=12173312 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=12255232 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=12304384 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=12353536 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=12402688 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=12451840 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=12500992 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=12550144 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=12599296 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=12648448 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=12697600 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=12746752 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=12795904 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=12910592 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=12959744 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=13008896 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=13058048 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=13107200 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=13156352 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=13238272 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=13287424 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=13336576 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=13385728 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=13434880 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=13484032 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=13533184 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=13582336 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=13631488 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=13680640 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=13729792 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=13778944 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=13828096 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=13877248 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=13926400 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=13975552 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=14024704 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=14073856 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=14123008 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=14172160 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=14221312 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=14270464 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=14319616 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=14368768 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=14647296 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=14696448 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=14745600 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=14794752 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=14843904 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=14893056 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=14942208 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=14991360 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=15040512 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=15089664 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=15138816 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=15187968 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=15237120 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=15286272 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=15335424 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=15384576 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=15433728 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=15482880 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=15532032 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=15597568 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=15646720 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=15695872 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=15745024 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=15794176 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=15843328 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=15892480 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=15941632 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=15990784 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=16039936 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=16121856 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=16171008 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=16220160 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=16269312 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=16318464 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=16384000 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=16433152 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=16482304 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=16531456 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=16580608 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=16629760 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=16678912 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=16728064 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=16777216 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=16826368 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=16875520 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=16924672 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=16973824 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=17022976 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=17104896 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=17154048 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=17203200 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=17252352 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=17301504 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=17350656 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=17399808 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=17448960 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=17498112 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=17563648 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=17612800 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=17661952 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=17727488 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=17776640 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=17825792 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=17874944 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=17924096 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=17973248 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=18022400 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=18071552 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=18120704 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=18169856 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=18219008 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=18268160 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=18317312 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=18366464 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=18415616 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=18464768 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=18513920 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=18563072 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=18612224 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=18661376 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=18710528 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=18759680 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=18808832 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=18857984 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=18907136 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=18956288 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=19005440 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=19054592 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=19103744 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=19152896 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=19202048 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=19251200 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=19300352 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=19349504 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=19398656 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=19447808 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=19496960 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=19546112 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=19595264 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=19644416 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=19693568 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=19742720 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=19791872 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=19841024 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=19890176 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=19939328 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=19988480 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=20037632 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=20086784 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=20135936 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=20185088 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=20234240 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=20283392 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=20332544 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=20381696 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=20430848 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=20480000 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=20529152 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=20578304 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=20627456 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=20676608 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=20725760 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=20774912 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=20824064 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=20873216 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=20922368 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=20971520 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=21020672 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=21069824 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=21118976 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=21168128 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=21217280 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=21266432 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=21315584 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=21364736 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=21413888 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=21463040 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=21512192 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=21561344 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=21610496 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=21659648 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=21708800 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=21757952 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=21807104 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=21856256 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=21905408 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=21954560 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=22003712 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=22052864 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=22102016 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=22151168 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=22200320 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=22249472 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=22298624 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=22347776 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=22396928 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=22446080 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=22495232 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=22544384 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=22593536 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=22642688 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=22691840 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=22740992 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=22790144 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=22839296 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=22888448 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=22937600 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=22986752 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=23035904 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=23085056 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=23134208 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=23183360 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=23232512 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=23281664 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=23330816 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=23379968 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=23429120 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=23478272 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=23527424 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=23576576 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=23625728 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=23674880 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=23724032 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=23773184 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=23822336 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=23871488 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=23920640 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=23969792 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=24018944 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=24068096 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=24117248 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=24166400 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=24215552 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=24264704 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=24313856 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=24363008 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=24412160 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=24461312 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=24510464 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=24559616 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=24608768 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=24657920 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=24707072 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=24756224 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=24805376 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=24854528 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=24903680 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=24952832 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=25001984 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=25051136 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=25100288 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=25149440 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=25198592 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=25247744 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=25296896 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=25346048 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=25395200 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=25444352 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=25493504 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=25542656 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=25591808 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=25640960 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=25690112 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=25739264 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=25788416 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=25837568 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=25886720 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=25919488 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=25952256 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=26001408 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=26017792 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=26050560 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=26099712 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=26148864 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=26198016 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=26247168 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=26279936 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=26329088 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=26378240 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=26427392 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=26476544 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=26525696 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=26574848 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=26624000 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=26673152 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=26722304 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=26771456 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=26820608 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=26869760 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=26918912 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=26968064 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=27017216 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=27066368 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=27115520 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=27164672 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=27213824 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=27262976 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=27312128 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=27361280 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=27410432 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=27459584 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=27508736 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=27557888 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=27607040 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=27656192 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=27705344 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=27754496 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=27803648 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=27852800 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=27901952 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=27951104 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=28000256 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=28049408 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=28098560 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=28147712 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=28196864 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=28246016 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=28295168 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=28344320 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=28393472 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=28442624 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=28491776 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=28540928 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=28590080 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=28639232 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=28688384 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=28737536 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=28786688 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=28835840 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=28884992 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=28934144 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=28983296 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=29032448 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=29081600 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=29130752 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=29179904 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=29229056 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=29278208 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=29327360 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=29376512 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=29425664 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=29474816 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=29523968 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=29573120 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=29622272 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=29671424 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=29720576 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=29769728 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=29818880 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=29868032 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=29917184 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=29966336 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=30015488 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=30064640 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=30113792 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=30162944 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=30212096 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=30261248 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=30310400 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=30359552 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=30408704 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=30457856 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=30507008 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=30556160 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=30605312 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=30654464 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=30703616 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=30752768 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=30801920 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=30851072 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=30900224 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=30949376 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=30998528 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=31047680 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=31096832 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=31145984 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=31195136 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=31244288 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=31293440 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=31342592 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=31391744 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=31440896 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=31490048 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=31539200 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=31588352 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=31637504 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=31686656 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=31735808 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=31784960 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=31834112 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=31883264 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=31932416 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=31981568 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=32030720 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=32079872 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=32129024 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=32178176 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=32227328 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=32276480 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=32325632 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=32374784 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=32407552 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=32440320 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=32489472 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=32538624 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=32587776 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=32636928 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=32686080 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=32735232 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=32784384 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=32833536 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=32882688 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=32931840 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=32980992 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=33030144 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=33079296 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=33128448 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=33161216 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=33210368 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=33259520 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=33308672 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=33357824 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=33406976 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=33456128 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=33505280 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=33554432 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=33603584 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=33652736 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=33701888 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=33751040 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=33800192 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=33849344 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=33898496 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=33947648 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=33996800 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=34045952 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=34095104 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=34144256 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=34193408 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=34242560 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=34291712 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=34340864 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=34390016 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=34439168 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=34488320 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=34537472 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=34586624 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=34635776 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=34668544 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=34701312 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=34750464 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=34799616 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=34848768 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=34897920 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=34947072 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=34996224 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=35045376 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=35094528 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=35143680 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=35192832 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=35241984 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=35291136 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=35340288 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=35389440 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=35438592 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=35487744 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=35536896 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=35586048 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=35635200 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=35684352 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=35733504 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=35782656 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=35831808 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=35880960 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=35930112 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=35979264 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=36028416 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=36077568 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=36126720 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=36175872 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=36225024 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=36274176 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=36323328 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=36372480 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=36421632 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=36470784 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=36519936 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=36569088 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=36618240 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=36667392 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=36716544 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=36732928 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=36765696 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=36814848 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=36864000 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=36913152 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=36962304 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=37011456 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=37060608 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=37109760 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=37158912 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=37208064 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=37257216 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=37306368 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=37322752 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=37781504 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=37814272 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=37847040 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=37879808 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=37978112 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=38010880 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=38043648 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=38076416 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=38109184 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=38141952 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=38174720 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=38207488 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=38240256 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=38273024 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=38305792 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=38338560 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=38371328 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=38502400 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=38535168 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=38567936 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=38600704 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=38633472 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=38666240 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=38731776 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=38764544 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=38797312 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=38830080 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=38879232 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=38928384 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=38961152 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=38993920 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=39026688 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=39059456 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=39092224 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=39124992 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=39157760 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=39190528 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=39223296 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=39256064 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=39288832 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=39321600 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=39354368 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=39387136 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=39419904 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=39452672 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=39485440 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=39518208 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=39550976 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=39600128 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=39616512 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=39649280 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=39682048 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=39714816 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=39747584 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=39780352 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=39813120 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=39845888 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=39895040 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=39911424 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=39944192 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=39976960 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=40009728 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=40042496 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=40075264 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=40108032 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=40140800 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=40173568 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=40206336 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=40239104 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=40271872 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=40304640 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=40337408 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=40370176 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=40402944 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=40435712 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=40468480 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=40501248 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=40534016 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=40566784 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=40599552 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=40632320 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=40665088 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=40697856 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=40730624 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=40779776 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=40796160 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=40828928 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=40861696 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=40894464 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=40927232 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=40960000 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=40992768 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=41025536 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=41058304 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=41091072 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=41123840 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=41156608 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=41189376 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=41222144 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=41254912 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=41287680 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=41320448 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=41353216 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=41385984 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=41418752 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=41451520 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=41484288 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=41517056 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=41549824 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=41582592 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=41615360 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=41648128 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=41680896 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=41713664 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=41746432 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=41779200 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=41828352 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=41844736 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=41877504 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=41910272 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=41943040 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=41975808 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=42008576 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=42041344 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=42074112 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=42106880 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=42139648 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=42172416 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=42205184 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=42237952 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=42270720 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=42303488 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=42336256 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=42369024 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=42401792 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=42434560 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=42467328 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=42500096 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=42565632 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=42598400 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=42631168 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=42696704 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=42729472 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=42762240 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=42795008 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=42827776 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=42860544 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=42926080 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=42958848 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=43024384 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=43057152 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=43089920 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=43122688 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=43155456 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=43188224 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=43220992 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=43253760 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=43384832 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=43417600 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=43466752 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=43483136 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=43515904 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=43548672 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=43581440 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=43646976 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=43679744 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=43745280 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=43778048 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=43810816 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=43876352 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=43941888 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=43974656 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=44007424 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=44072960 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=44138496 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=44171264 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=44204032 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=44236800 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=44269568 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=44302336 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=44335104 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=44367872 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=44433408 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=44482560 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=44498944 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=44548096 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=44564480 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=44597248 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=44630016 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=44662784 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=44711936 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=44728320 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=44761088 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=44793856 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=44826624 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=44875776 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=44892160 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=44941312 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=44990464 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=45039616 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=45088768 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=45137920 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=45187072 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=45236224 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=45285376 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=45334528 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=45383680 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=45432832 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=45481984 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=45531136 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=45580288 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=45629440 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=45678592 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=45727744 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=45776896 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=45826048 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=45875200 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=45924352 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=45973504 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=46022656 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=46039040 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=46071808 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=46120960 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=46137344 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=46170112 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=46219264 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=46235648 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=46268416 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=46301184 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=46333952 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=46366720 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=46399488 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=46432256 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=46596096 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=46661632 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=46694400 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=46743552 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=47022080 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=47349760 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=47415296 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=47464448 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=47513600 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=47546368 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=47579136 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=47611904 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=47661056 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=47677440 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=47710208 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=47742976 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=47792128 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=47841280 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=47874048 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=47906816 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=47939584 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=47972352 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=48037888 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=48070656 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=48103424 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=48136192 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=48168960 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=48201728 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=48234496 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=48267264 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=48300032 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=48332800 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=48365568 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=48398336 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=48431104 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=48529408 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=48562176 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=48627712 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=48660480 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=48693248 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=48955392 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=49152000 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=49184768 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=49217536 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=49250304 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=49283072 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=49315840 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=49381376 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=49414144 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=49463296 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=49479680 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=49512448 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=49545216 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=49610752 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=49643520 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=49676288 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=49725440 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=49741824 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=49774592 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=49807360 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=50954240 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=50987008 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=51019776 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=51052544 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=51085312 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=51150848 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=51200000 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=51216384 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=51249152 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=51281920 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=51314688 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=51363840 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=51478528 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=51511296 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=51544064 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=51576832 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=51609600 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=51642368 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=51707904 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=51740672 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=51773440 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=51806208 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=51838976 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=51871744 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=51904512 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=51937280 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=51970048 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=52002816 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=52035584 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=52084736 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=52101120 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=52133888 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=52183040 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=52199424 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=52232192 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=52264960 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=52297728 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=52330496 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=52363264 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=52396032 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=52445184 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=52461568 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=52494336 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=52527104 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=52559872 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=52592640 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=52625408 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=52658176 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=52690944 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=52723712 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=52756480 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=52789248 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=52822016 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=52854784 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=52887552 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=52920320 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=52953088 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=52985856 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=53018624 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=53051392 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=53084160 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=53116928 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=53149696 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=53182464 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=53231616 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=53248000 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=53280768 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=53313536 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=53346304 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=53379072 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=53411840 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=53444608 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=53477376 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=53510144 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=53542912 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=53575680 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=53608448 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=53641216 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=53673984 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=53706752 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=53739520 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=53772288 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=53805056 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=53837824 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=53870592 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=53903360 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=53936128 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=53968896 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=54001664 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=54034432 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=54083584 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=54099968 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=54149120 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=54165504 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=54198272 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=54231040 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=54263808 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=54296576 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=55574528 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=56229888 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=60620800 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=61079552 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=61112320 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=61145088 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=61177856 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=65732608 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=65765376 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=65814528 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=66158592 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=66289664 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=67174400 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=67272704 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=67305472 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=68517888 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=68583424 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=68616192 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=68714496 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=68780032 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=68829184 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=68845568 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=68878336 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=68911104 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=68943872 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=68976640 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=69009408 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=69042176 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=69074944 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=69107712 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=69140480 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=69173248 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=69206016 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=69255168 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=69304320 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=69337088 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=69369856 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=69402624 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=69435392 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=69468160 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=69500928 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=69550080 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=69599232 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=69632000 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=69664768 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=69861376 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=69910528 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=70057984 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=70123520 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=70156288 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=70483968 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=70647808 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=70844416 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=70975488 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=71008256 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=71073792 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=71172096 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=71794688 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=71892992 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=72089600 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=72155136 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=72318976 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=72843264 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=72876032 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=72925184 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=73007104 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=73203712 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=73236480 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=73302016 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=73334784 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=73433088 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=73482240 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=73498624 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=73564160 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=73596928 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=73662464 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=73695232 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=73728000 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=73826304 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=73875456 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=73891840 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=73924608 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=73957376 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=74006528 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=74022912 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=74072064 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=74121216 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=74153984 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=74186752 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=74252288 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=74285056 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=74317824 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=74383360 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=74416128 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=74448896 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=74481664 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=74514432 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=74547200 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=74579968 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=74612736 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=74661888 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=74678272 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=74711040 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=74743808 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=74809344 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=74842112 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=74907648 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=74940416 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=75005952 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=75038720 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=75137024 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=75268096 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=75300864 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=75333632 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=75399168 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=75431936 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=75481088 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=75530240 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=75628544 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=75661312 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=75759616 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=75792384 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=75857920 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=75923456 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=76087296 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=76152832 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=76201984 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=76251136 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=76316672 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=76414976 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=76578816 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=76611584 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=76677120 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=76726272 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=76742656 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=76808192 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=76840960 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=76890112 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=76906496 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=76939264 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=76972032 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=77004800 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=77037568 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=77103104 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=77135872 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=77185024 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=77201408 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=77234176 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=77266944 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=77299712 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=77332480 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=77430784 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=77463552 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=77529088 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=77561856 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=77627392 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=77660160 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=77725696 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=77774848 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=77856768 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=77889536 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=77938688 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=77955072 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=77987840 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=78036992 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=78086144 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=78118912 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=78151680 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=78184448 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=78217216 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=78266368 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=78282752 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=78315520 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=78348288 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=78512128 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=78544896 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=78577664 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=78610432 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=78643200 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=78692352 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=78708736 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=78757888 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=78774272 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=78823424 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=78839808 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=78872576 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=78921728 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=78970880 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=79003648 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=79036416 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=79069184 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=79101952 length=32768
clone home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
source=home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite
source offset=79134720 offset=79134720 length=4751360
ERROR: failed to clone extents to
home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite: Invalid
argument

Snapshot IDs are 881 and 977. The compressed tree dumps are still a
bit big for email (166MB total), so here is a download link:
https://mega.nz/file/wF5EHSCZ#P0E9S3291NOO4chjPbj7IbSCJ_9LplpKagGE431jzIQ

I'll leave the link up for a few days. Dumps were created with
--hide-names. I did it with the filesystem mounted, but tried to avoid
any significant write activity and also made sure firefox was not
running (so nothing would write to the affected file).
