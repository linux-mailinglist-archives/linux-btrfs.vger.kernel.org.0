Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66F53F987C
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Aug 2021 13:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244978AbhH0Lgg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Aug 2021 07:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235295AbhH0Lgf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Aug 2021 07:36:35 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A04C061757
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Aug 2021 04:35:46 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id s32so5015165qtc.12
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Aug 2021 04:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=/0uruoAa7PMVtQ/i1gV926oJPO4mycfOpoGf0Hbz23g=;
        b=bRLs4FeK4D9KMGvXGqYnsn5UxxmpQod46jUNf/VOINyonUiaNZKdqLN3eKsP++Ax81
         8jsntF2MqBaALaexDktfaVsam1R4TFEGEmktrIYhz/BBG/Z3DuTbM+Ltt2+fpOUru04T
         rCcpQiyhqpTg8X+WMql8aXdhyRgbkHJs+4alVOcQe0XF22qX1Sni8fU445UH9GubDyY0
         b44oOoc6H0o80ztZ8CRoUf3JViQrEEZcFQFEX6Fxu6fPTJcDwC71Icy7r2gQt/KFnSZ5
         ImNl2+BnjWBYVd/5ebP8bBo4YTCQeG1s6RhVaEozNrEOjM5SJPHaW2Y7tu77hgy5OCaQ
         WI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=/0uruoAa7PMVtQ/i1gV926oJPO4mycfOpoGf0Hbz23g=;
        b=WrllNM/qKLQryJeshfq2ARjBlOBfoXqkGEcyEibmiIgn9zvMMnMTK1xktHGQPW2xUA
         b9YRlUVObcqXtp3MBsB38VfQuwSttS4yQRP/YfLiP5CRHVoS7/hjkxiP4w+B1YvPuIxI
         NEMRfNRqxvOPIa2gs2NEc59Ms0TwEe/Q/a7+nkJMBtiAYTteXON32REayJK7wGmBoCQU
         KomDQdzXllOqIxe7RYXlb6NKPjMqYPMlv0TxFn7wfoKxKTsYvhwE7Q07XGfdLWEI9YmY
         1ZJoBK9NYAmBCaYD8R4Lhc+iBgdBEB3jmjPXESbsDVaK5/757QowPevcSxU0tV8BXFek
         NL+w==
X-Gm-Message-State: AOAM5334CaCW0jNIWzv5jObwv8+HIoogluYa4kBy5/L45M6O5qwAViXl
        YFQkTjdQp0+MM686rC6Etb1uN5+XhTJNsrg/5PwNgDyw7wI=
X-Google-Smtp-Source: ABdhPJwIl7XCl/Ktg67QGyAcbwUAXxRkYfak7dF8Qx/gwXsLko9LtQmeHeoOzRawv3rpO5UYIhxr/ebcUf1UHFBgXm4=
X-Received: by 2002:a05:622a:58f:: with SMTP id c15mr8018997qtb.21.1630064145665;
 Fri, 27 Aug 2021 04:35:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAOaVUnV3L6RpcqJ5gaqzNXWXK0VMkEVXCdihawH1PgS6TiMchQ@mail.gmail.com>
 <CAL3q7H5P1+s5LOa6TutNhPKOyWUA7hifjD1XuhBP6_e3SQzR8Q@mail.gmail.com> <CAOaVUnU6z8U0a2T7a0cLg1U=b1bfyq_xHa8hoXMnu6Qv1E-z+g@mail.gmail.com>
In-Reply-To: <CAOaVUnU6z8U0a2T7a0cLg1U=b1bfyq_xHa8hoXMnu6Qv1E-z+g@mail.gmail.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 27 Aug 2021 12:35:34 +0100
Message-ID: <CAL3q7H7kbgsiTfLWWYJikuWOFP9yXSdgav2EEonx98pPhSEQNA@mail.gmail.com>
Subject: Re: Backup failing with "failed to clone extents" error
To:     Darrell Enns <darrell@darrellenns.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000005d480705ca88e25a"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--0000000000005d480705ca88e25a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 26, 2021 at 7:30 PM Darrell Enns <darrell@darrellenns.com> wrot=
e:
>
> Yes, kernel version was a typo - this is all on kernel 5.13.12 (both
> send and receive). I'm doing incremental backup to a secondary disk,
> all on one host.
>
> Here's what I get with btrfs receive -vvv:
>
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D0 length=3D32768
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
> offset=3D819200 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D884736 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D950272 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D983040 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D1015808 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D1245184 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D1343488 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D1392640 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D1441792 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D1474560 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D1540096 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D1638400 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D1671168 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D1703936 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D1753088 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D1769472 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D1802240 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D1835008 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D1867776 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D1900544 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D1949696 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D1966080 length=3D32768
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
> offset=3D2424832 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D2457600 length=3D32768
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
> offset=3D2752512 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D2785280 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D2818048 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D2867200 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D2883584 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D2916352 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D2949120 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D3014656 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D3080192 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D3145728 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D3178496 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D3211264 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D3244032 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D3276800 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D3309568 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D3571712 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D6193152 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D6881280 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D8192000 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D9732096 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D9781248 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D9797632 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D11796480 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D12550144 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D17399808 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D21528576 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D28901376 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D31096832 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D31326208 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D31817728 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D31850496 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D31883264 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D31948800 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D32538624 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D34734080 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D35258368 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D35307520 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D35651584 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D36503552 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D36765696 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D36896768 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D37224448 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D37289984 length=3D32768
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
> offset=3D38764544 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D38797312 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D38895616 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D38928384 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D38961152 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D38993920 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D39026688 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D39059456 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D39108608 length=3D16384
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
> offset=3D39550976 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D39583744 length=3D32768
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
> offset=3D39813120 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D39862272 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D39878656 length=3D32768
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
> offset=3D40501248 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D40550400 length=3D16384
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
> offset=3D40730624 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D40763392 length=3D32768
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
> offset=3D41025536 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D41074688 length=3D16384
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
> offset=3D41779200 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D41811968 length=3D32768
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
> offset=3D42958848 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D43024384 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D43057152 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D43122688 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D43188224 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D43253760 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D43384832 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D43450368 length=3D32768
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
> offset=3D43876352 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D43974656 length=3D32768
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
> offset=3D44335104 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D44367872 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D44433408 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D44466176 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D44531712 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D44597248 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D44630016 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D44662784 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D44695552 length=3D32768
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
> offset=3D45088768 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D45187072 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D45252608 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D46006272 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D46039040 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D46071808 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D46137344 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D46170112 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D46235648 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D46268416 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D46301184 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D46350336 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D46366720 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D46399488 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D46448640 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D46596096 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D46661632 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D47349760 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D47448064 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D47513600 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D47546368 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D47579136 length=3D32768
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
> offset=3D47906816 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D47955968 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D48037888 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D48070656 length=3D32768
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
> offset=3D49414144 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D49446912 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D49512448 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D49545216 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D49610752 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D49643520 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D49676288 length=3D32768
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
> offset=3D51052544 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D51085312 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D51183616 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D51216384 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D51249152 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D51281920 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D51380224 length=3D32768
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
> offset=3D51937280 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D51986432 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D52035584 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D52068352 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D52117504 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D52133888 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D52166656 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D52215808 length=3D16384
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
> offset=3D52396032 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D52428800 length=3D32768
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
> offset=3D53182464 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D53215232 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D53248000 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D53280768 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D53313536 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D53346304 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D53379072 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D53428224 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D53444608 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D53477376 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D53510144 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D53542912 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D53592064 length=3D16384
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
> offset=3D54001664 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D54050816 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D54067200 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D54099968 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D54132736 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D54165504 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D54198272 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D54263808 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D55574528 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D56229888 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D60620800 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D61079552 length=3D32768
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
> offset=3D68780032 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D68812800 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D68845568 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D68894720 length=3D16384
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
> offset=3D69206016 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D69238784 length=3D32768
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
> offset=3D69500928 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D69533696 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D69566464 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D69599232 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D69632000 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D69664768 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D70057984 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D70156288 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D70647808 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D70975488 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D71073792 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D71794688 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D72318976 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D73203712 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D73465856 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D73498624 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D73564160 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D73596928 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D73662464 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D73891840 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D73957376 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D74006528 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D74022912 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D74121216 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D74153984 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D74186752 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D74252288 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D74301440 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D74317824 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D74383360 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D74416128 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D74448896 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D74498048 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D74514432 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D74547200 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D74579968 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D74612736 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D74678272 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D74727424 length=3D16384
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
> offset=3D75431936 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D75464704 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D75530240 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D75628544 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D75661312 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D75792384 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D76251136 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D76578816 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D76677120 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D76709888 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D76742656 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D76840960 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D76873728 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D76972032 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D77004800 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D77037568 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D77103104 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D77135872 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D77168640 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D77234176 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D77266944 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D77299712 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D77332480 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D77463552 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D77529088 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D77561856 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D77660160 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D77758464 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D77955072 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D78020608 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D78086144 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D78151680 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D78184448 length=3D49152
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D78233600 length=3D16384
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D78249984 length=3D32768
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
> offset=3D78675968 length=3D32768
> write home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> offset=3D78708736 length=3D32768
> clone home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite -
> source=3Dhome/denns/.mozilla/firefox/dtfto95g.default/places.sqlite
> source offset=3D78741504 offset=3D78741504 length=3D5144576
> ERROR: failed to clone extents to
> home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite: Invalid
> argument

Ok, that confirms it is a clone operation in the same file, with an
offset apparently greater then the current EOF at the receiver.

Are you able to test the attached patch? I also pasted it at this URL:
 https://pastebin.com/raw/NGSrW8Bz

Regardless of being possible for you to test the patch or not, I'm
trying to figure out a file extent layout, in the send and parent
snaphots, that would result in such failure.
So I would like you to help me out, if possible, by doing the following:

1) Figure out the IDs of the send and parent snapshots.
    We can do that with 'btrfs subvolume show <snapshot path>', for example=
:

$ btrfs subvolume show /mnt/sdi/snap1
snap1
Name: snap1
UUID: 1998337f-82a5-3446-b588-5d21ff55330e
Parent UUID: f50da3bc-ecc7-4a29-8c0a-0f92bdc1a856
Received UUID: -
Creation time: 2021-08-27 12:00:09 +0100
Subvolume ID: 257
Generation: 6
Gen at creation: 6
Parent ID: 5
Top level ID: 5
Flags: readonly
Snapshot(s):

$ btrfs subvolume show /mnt/sdi/snap2
snap2
Name: snap2
UUID: a2a16d06-ee9b-1040-a035-c8db452d6a1f
Parent UUID: f50da3bc-ecc7-4a29-8c0a-0f92bdc1a856
Received UUID: -
Creation time: 2021-08-27 12:00:17 +0100
Subvolume ID: 258
Generation: 7
Gen at creation: 7
Parent ID: 5
Top level ID: 5
Flags: readonly
Snapshot(s):

Here snap1 has an ID of 257, and snap2 an ID of 258 (snap1 is the
parent snapshot, snap2 is the send snapshot).

2) Then grab those IDs and do the following, either with the
filesystem unmounted or if not possible/convenient, try avoiding any
write activity to the filesystem, and do:

$ btrfs inspect-internal dump-tree -t <ID> /dev/sda1

(replace /dev/sda1 with the correct device on your system)

And then send the output of the 'inspect-internal dump-tree'. If it's
too big, send it as a compressed attachment (it's text output, should
compress very well).

The output contains file names and xattr names, which might be
sensitive information for you.
If that's the case, then the option '--hide-names' can be passed, for
example:   btrfs inspect-internal dump-tree -t 258 --hide-names
/dev/sda1.
Buf if you use --hide-names, than also tell me what's the inode number
of the file "home/denns/.mozilla/firefox/dtfto95g.default/places.sqlite"
- you can get it by running 'stat <file path>'.

I'm asking this just so that I can write a test case to avoid a
regression in the future.

Thanks!




--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D

--0000000000005d480705ca88e25a
Content-Type: text/x-patch; charset="US-ASCII"; name="send_fix_self_cloning.patch"
Content-Disposition: attachment; filename="send_fix_self_cloning.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ksu9g0vx0>
X-Attachment-Id: f_ksu9g0vx0

ZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL3NlbmQuYyBiL2ZzL2J0cmZzL3NlbmQuYwppbmRleCBhZmRj
YmU3ODQ0ZTAuLmEyODU4YmM2NzhmNCAxMDA2NDQKLS0tIGEvZnMvYnRyZnMvc2VuZC5jCisrKyBi
L2ZzL2J0cmZzL3NlbmQuYwpAQCAtNTI2OSw2ICs1MjY5LDIyIEBAIHN0YXRpYyBpbnQgc2VuZF9j
YXBhYmlsaXRpZXMoc3RydWN0IHNlbmRfY3R4ICpzY3R4KQogCXJldHVybiByZXQ7CiB9CiAKKy8q
CisgKiBJZiB3ZSBhcmUgY2xvbmluZyBmcm9tIHRoZSBmaWxlIHdlIGFyZSBjdXJyZW50bHkgcHJv
Y2Vzc2luZywgYW5kIHVzaW5nIHRoZQorICogc2VuZCByb290IGFzIHRoZSBjbG9uZSByb290LCB3
ZSBtdXN0IHN0b3Agb25jZSB0aGUgY3VycmVudCBjbG9uZSBvZmZzZXQKKyAqIHJlYWNoZXMgdGhl
IGN1cnJlbnQgZW9mIG9mIHRoZSBmaWxlIGF0IHRoZSByZWNlaXZlciwgb3RoZXJ3aXNlIHdlIHdv
dWxkIGlzc3VlCisgKiBhbiBpbnZhbGlkIGNsb25lIG9wZXJhdGlvbiAoc291cmNlIHJhbmdlIGdv
aW5nIGJleW9uZCBlb2YpIGFuZCBjYXVzZSB0aGUKKyAqIHJlY2VpdmVyIHRvIGZhaWwuIFNvIGlm
IHdlIHJlYWNoIHRoZSBjdXJyZW50IGVvZiwgYmFpbCBvdXQgYW5kIGZhbGxiYWNrIHRvIGEKKyAq
IHJlZ3VsYXIgd3JpdGUuCisgKi8KK3N0YXRpYyBpbmxpbmUgYm9vbCBhYm9ydF9zZWxmX2Nsb25l
KGNvbnN0IHN0cnVjdCBzZW5kX2N0eCAqc2N0eCwKKwkJCQkgICAgY29uc3Qgc3RydWN0IGNsb25l
X3Jvb3QgKmNsb25lX3Jvb3QpCit7CisJcmV0dXJuIChjbG9uZV9yb290LT5yb290ID09IHNjdHgt
PnNlbmRfcm9vdCAmJgorCQljbG9uZV9yb290LT5pbm8gPT0gc2N0eC0+Y3VyX2lubyAmJgorCQlj
bG9uZV9yb290LT5vZmZzZXQgPj0gc2N0eC0+Y3VyX2lub2RlX25leHRfd3JpdGVfb2Zmc2V0KTsK
K30KKwogc3RhdGljIGludCBjbG9uZV9yYW5nZShzdHJ1Y3Qgc2VuZF9jdHggKnNjdHgsCiAJCSAg
ICAgICBzdHJ1Y3QgY2xvbmVfcm9vdCAqY2xvbmVfcm9vdCwKIAkJICAgICAgIGNvbnN0IHU2NCBk
aXNrX2J5dGUsCkBAIC01NDA0LDYgKzU0MjAsOCBAQCBzdGF0aWMgaW50IGNsb25lX3JhbmdlKHN0
cnVjdCBzZW5kX2N0eCAqc2N0eCwKIAkJCQlicmVhazsKIAkJCW9mZnNldCArPSBob2xlX2xlbjsK
IAkJCWNsb25lX3Jvb3QtPm9mZnNldCArPSBob2xlX2xlbjsKKwkJCWlmIChhYm9ydF9zZWxmX2Ns
b25lKHNjdHgsIGNsb25lX3Jvb3QpKQorCQkJCWJyZWFrOwogCQkJZGF0YV9vZmZzZXQgKz0gaG9s
ZV9sZW47CiAJCX0KIApAQCAtNTQyNyw2ICs1NDQ1LDggQEAgc3RhdGljIGludCBjbG9uZV9yYW5n
ZShzdHJ1Y3Qgc2VuZF9jdHggKnNjdHgsCiAJCQkJZXh0X2xlbiAtPSBleHRlbnRfb2Zmc2V0Owog
CQkJCWNsb25lX2RhdGFfb2Zmc2V0ICs9IGV4dGVudF9vZmZzZXQ7CiAJCQkJY2xvbmVfcm9vdC0+
b2Zmc2V0ICs9IGV4dGVudF9vZmZzZXQ7CisJCQkJaWYgKGFib3J0X3NlbGZfY2xvbmUoc2N0eCwg
Y2xvbmVfcm9vdCkpCisJCQkJCWJyZWFrOwogCQkJfQogCQl9CiAKQEAgLTU0ODYsMjEgKzU1MDYs
OCBAQCBzdGF0aWMgaW50IGNsb25lX3JhbmdlKHN0cnVjdCBzZW5kX2N0eCAqc2N0eCwKIAkJCWJy
ZWFrOwogCQlvZmZzZXQgKz0gY2xvbmVfbGVuOwogCQljbG9uZV9yb290LT5vZmZzZXQgKz0gY2xv
bmVfbGVuOwotCi0JCS8qCi0JCSAqIElmIHdlIGFyZSBjbG9uaW5nIGZyb20gdGhlIGZpbGUgd2Ug
YXJlIGN1cnJlbnRseSBwcm9jZXNzaW5nLAotCQkgKiBhbmQgdXNpbmcgdGhlIHNlbmQgcm9vdCBh
cyB0aGUgY2xvbmUgcm9vdCwgd2UgbXVzdCBzdG9wIG9uY2UKLQkJICogdGhlIGN1cnJlbnQgY2xv
bmUgb2Zmc2V0IHJlYWNoZXMgdGhlIGN1cnJlbnQgZW9mIG9mIHRoZSBmaWxlCi0JCSAqIGF0IHRo
ZSByZWNlaXZlciwgb3RoZXJ3aXNlIHdlIHdvdWxkIGlzc3VlIGFuIGludmFsaWQgY2xvbmUKLQkJ
ICogb3BlcmF0aW9uIChzb3VyY2UgcmFuZ2UgZ29pbmcgYmV5b25kIGVvZikgYW5kIGNhdXNlIHRo
ZQotCQkgKiByZWNlaXZlciB0byBmYWlsLiBTbyBpZiB3ZSByZWFjaCB0aGUgY3VycmVudCBlb2Ys
IGJhaWwgb3V0Ci0JCSAqIGFuZCBmYWxsYmFjayB0byBhIHJlZ3VsYXIgd3JpdGUuCi0JCSAqLwot
CQlpZiAoY2xvbmVfcm9vdC0+cm9vdCA9PSBzY3R4LT5zZW5kX3Jvb3QgJiYKLQkJICAgIGNsb25l
X3Jvb3QtPmlubyA9PSBzY3R4LT5jdXJfaW5vICYmCi0JCSAgICBjbG9uZV9yb290LT5vZmZzZXQg
Pj0gc2N0eC0+Y3VyX2lub2RlX25leHRfd3JpdGVfb2Zmc2V0KQorCQlpZiAoYWJvcnRfc2VsZl9j
bG9uZShzY3R4LCBjbG9uZV9yb290KSkKIAkJCWJyZWFrOwotCiAJCWRhdGFfb2Zmc2V0ICs9IGNs
b25lX2xlbjsKIG5leHQ6CiAJCXBhdGgtPnNsb3RzWzBdKys7Cg==
--0000000000005d480705ca88e25a--
