Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7763F8DDA
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Aug 2021 20:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238277AbhHZSbr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Aug 2021 14:31:47 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:37410 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbhHZSbq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Aug 2021 14:31:46 -0400
Received: by mail-lf1-f45.google.com with SMTP id k5so8842908lfu.4
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Aug 2021 11:30:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rUeFI++HJ/rv/bTb1nNVd0pguQdxD4gkwgPYM40Nj7Q=;
        b=qBhvwznaB16+ZxozZCT1+3FEKhAxxzwsYmBqRsASOvtsEJJHue8aJA1aPf28hEru1o
         7D3+C3Qt4CDXCobciExOaaC3d64mHJsHcQ+B0dLMY6wf+fDPJnnA9/GFiI/hJTBpu6aZ
         +9H1ZeWogJrEP+drysT6VEZQhN13vlxm5RIo0R2qqIY8wv0T+VGwF3RBeG7nLcSnwwuY
         URZhbI3+ixNpxoQ/jPw6UM1RuEFHQcM29eqSWJksdG/Lj0EITt02sva2CRFoAjvw+6Xb
         TKGxHOG4dEX+6zqPmUHnjEhW3rotMcoLDJeodVrMKKtMzwD1ThgEj4/bwOIZoCVGK/YC
         etSg==
X-Gm-Message-State: AOAM532To8uInUsyK+QNLRQQSXhIijkxRsGshhGaC/6Z77tyIdW2JhcH
        SF290+J/GfvL5h2P0/JkoTOk1LiSWwTGA3bfAnH/imUYwp0=
X-Google-Smtp-Source: ABdhPJzd8pwbELnUUryjJAn03XzBiTdkKZ5r1ee83CfGgk5zMcz/mHaUbJ60PUioTqhTKiJTLIiTrRp9jDkt+n6v+dE=
X-Received: by 2002:a19:a409:: with SMTP id q9mr3673065lfc.408.1630002656873;
 Thu, 26 Aug 2021 11:30:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAOaVUnV3L6RpcqJ5gaqzNXWXK0VMkEVXCdihawH1PgS6TiMchQ@mail.gmail.com>
 <CAL3q7H5P1+s5LOa6TutNhPKOyWUA7hifjD1XuhBP6_e3SQzR8Q@mail.gmail.com>
In-Reply-To: <CAL3q7H5P1+s5LOa6TutNhPKOyWUA7hifjD1XuhBP6_e3SQzR8Q@mail.gmail.com>
From:   Darrell Enns <darrell@darrellenns.com>
Date:   Thu, 26 Aug 2021 11:30:45 -0700
Message-ID: <CAOaVUnU6z8U0a2T7a0cLg1U=b1bfyq_xHa8hoXMnu6Qv1E-z+g@mail.gmail.com>
Subject: Re: Backup failing with "failed to clone extents" error
To:     fdmanana@gmail.com
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Yes, kernel version was a typo - this is all on kernel 5.13.12 (both
send and receive). I'm doing incremental backup to a secondary disk,
all on one host.

Here's what I get with btrfs receive -vvv:

write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=0 length=32768
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
offset=819200 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=884736 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=950272 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=983040 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=1015808 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=1245184 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=1343488 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=1392640 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=1441792 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=1474560 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=1540096 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=1638400 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=1671168 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=1703936 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=1753088 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=1769472 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=1802240 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=1835008 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=1867776 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=1900544 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=1949696 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=1966080 length=32768
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
offset=2424832 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=2457600 length=32768
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
offset=2752512 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=2785280 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=2818048 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=2867200 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=2883584 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=2916352 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=2949120 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=3014656 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=3080192 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=3145728 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=3178496 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=3211264 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=3244032 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=3276800 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=3309568 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=3571712 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=6193152 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=6881280 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=8192000 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=9732096 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=9781248 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=9797632 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=11796480 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=12550144 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=17399808 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=21528576 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=28901376 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=31096832 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=31326208 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=31817728 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=31850496 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=31883264 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=31948800 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=32538624 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=34734080 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=35258368 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=35307520 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=35651584 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=36503552 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=36765696 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=36896768 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=37224448 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=37289984 length=32768
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
offset=38764544 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=38797312 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=38895616 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=38928384 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=38961152 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=38993920 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=39026688 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=39059456 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=39108608 length=16384
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
offset=39550976 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=39583744 length=32768
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
offset=39813120 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=39862272 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=39878656 length=32768
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
offset=40501248 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=40550400 length=16384
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
offset=40730624 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=40763392 length=32768
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
offset=41025536 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=41074688 length=16384
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
offset=41779200 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=41811968 length=32768
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
offset=42958848 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=43024384 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=43057152 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=43122688 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=43188224 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=43253760 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=43384832 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=43450368 length=32768
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
offset=43876352 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=43974656 length=32768
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
offset=44335104 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=44367872 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=44433408 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=44466176 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=44531712 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=44597248 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=44630016 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=44662784 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=44695552 length=32768
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
offset=45088768 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=45187072 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=45252608 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=46006272 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=46039040 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=46071808 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=46137344 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=46170112 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=46235648 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=46268416 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=46301184 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=46350336 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=46366720 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=46399488 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=46448640 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=46596096 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=46661632 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=47349760 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=47448064 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=47513600 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=47546368 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=47579136 length=32768
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
offset=47906816 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=47955968 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=48037888 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=48070656 length=32768
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
offset=49414144 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=49446912 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=49512448 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=49545216 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=49610752 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=49643520 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=49676288 length=32768
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
offset=51052544 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=51085312 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=51183616 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=51216384 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=51249152 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=51281920 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=51380224 length=32768
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
offset=51937280 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=51986432 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=52035584 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=52068352 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=52117504 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=52133888 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=52166656 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=52215808 length=16384
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
offset=52396032 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=52428800 length=32768
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
offset=53182464 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=53215232 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=53248000 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=53280768 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=53313536 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=53346304 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=53379072 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=53428224 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=53444608 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=53477376 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=53510144 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=53542912 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=53592064 length=16384
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
offset=54001664 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=54050816 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=54067200 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=54099968 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=54132736 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=54165504 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=54198272 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=54263808 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=55574528 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=56229888 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=60620800 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=61079552 length=32768
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
offset=68780032 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=68812800 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=68845568 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=68894720 length=16384
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
offset=69206016 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=69238784 length=32768
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
offset=69500928 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=69533696 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=69566464 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=69599232 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=69632000 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=69664768 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=70057984 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=70156288 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=70647808 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=70975488 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=71073792 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=71794688 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=72318976 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=73203712 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=73465856 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=73498624 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=73564160 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=73596928 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=73662464 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=73891840 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=73957376 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=74006528 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=74022912 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=74121216 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=74153984 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=74186752 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=74252288 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=74301440 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=74317824 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=74383360 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=74416128 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=74448896 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=74498048 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=74514432 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=74547200 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=74579968 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=74612736 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=74678272 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=74727424 length=16384
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
offset=75431936 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=75464704 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=75530240 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=75628544 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=75661312 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=75792384 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=76251136 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=76578816 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=76677120 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=76709888 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=76742656 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=76840960 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=76873728 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=76972032 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=77004800 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=77037568 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=77103104 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=77135872 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=77168640 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=77234176 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=77266944 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=77299712 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=77332480 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=77463552 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=77529088 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=77561856 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=77660160 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=77758464 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=77955072 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=78020608 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=78086144 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=78151680 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=78184448 length=49152
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=78233600 length=16384
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=78249984 length=32768
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
offset=78675968 length=32768
write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
offset=78708736 length=32768
clone home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
source=home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite
source offset=78741504 offset=78741504 length=5144576
ERROR: failed to clone extents to
home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite: Invalid
argument
