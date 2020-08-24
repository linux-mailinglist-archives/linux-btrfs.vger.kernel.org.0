Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82504250B21
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Aug 2020 23:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgHXVuf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Aug 2020 17:50:35 -0400
Received: from mout.gmx.net ([212.227.17.20]:36277 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgHXVuc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Aug 2020 17:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1598305831;
        bh=RQJjQmFUEB+dL7pzD+dFF89oWDnbYfbIK0jCsVoM6oQ=;
        h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
        b=J2/K4JrUVDjCpUnq+aDvP4ZBMQBE5Lwart5QcAq1eGByP41kbwbisD5QhLRH2Ccps
         Bw60q4aTPYoOBXDMmQACDqh9/3miD6ufHIgdjmW2x+RJgbj46EW/v4rTmSIOPZCjgF
         BL6QHYQIQyotB44nZ4GgsBgQ0+XAvB1SJzxtQsVw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [89.245.194.229] ([89.245.194.229]) by web-mail.gmx.net
 (3c-app-gmx-bap63.server.lan [172.19.172.133]) (via HTTP); Mon, 24 Aug 2020
 23:50:30 +0200
MIME-Version: 1.0
Message-ID: <trinity-963db523-ba60-48b5-997f-59b55ee6b92b-1598305830919@3c-app-gmx-bap63>
From:   Steve Keller <keller.steve@gmx.de>
To:     linux-btrfs@vger.kernel.org
Subject: Re: Link count for directories
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 24 Aug 2020 23:50:30 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <e592fd12-1662-49f3-75bd-94609e660517@suse.com>
References: <trinity-57be0daf-2aa0-4480-a962-7a62e302cfde-1598031619031@3c-app-gmx-bap35>
 <e592fd12-1662-49f3-75bd-94609e660517@suse.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:pXm075bMtoHT2a3/mVuhb7kOrT3nsnYmxXuiiy7M5o6mqje/DE7Zg2u/dao/Thgn+D4Ok
 XzP/9IvpeqAxWTmPv0ZyN10+pmtU9PIAzhhaF4iu9a4VKVUwCnNKF92Uk95oP9iZ5kCUUW5Nffnp
 wl/8d1a0T65kqTL0R8kF+DQkqgJi8x6gSYFSKsi1/ULHUDnI50Dx5/eKH3DWMZsZ3kHyWMRzH61F
 Bbz3TjkyfGvpUiomeybtKfqzRtLOqS85HnPRvBVap1O4U8aWc+hKM5HylIVymXqopYfP2df+3ziV
 Ks=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:cv6K6tg2HyE=:aPD0/RzePrx8MKVFVJwRex
 RbfggBBKRBe+gNYDrB6sIyhSEhWFxgdEz7XFmtt3Wv4Da/wFqeRh50cy58rROjKq7WKL9UG4m
 kaWFvAJ0C2/AQ8NJTF+gga+18W0Rxiy8LmKUl7y+IFiAmld72O/ysMShrUCCLZy97pULVHh7c
 03l37CFeByO5t3IKryVVNyZoekzSPDvmPslGzWxyQLFjxC5v5z4V9SESYRvSnq8+zWhZBbj2r
 cKYjq9sU+Nq8ZZJiFUQydRx0elEgy9Gb9HcI0rh0f2XOyCkXTlohKhYY+RH60lfgwNdgbLurG
 WPbHHgEkv/beHk8NvUor9JZ/HJF4NSU2C5Q3R7B9ZLFEaUd37zdb+viyD8nS4lDMsnzRveHX7
 oTfSkkgAKpyvuZ8XxEaLfNRK/yVVbtw3aWRh4Sy7yRMyyXSBYkAw3hvAVxP/j/ig4bA9/NqMY
 vJyEDDGBuHhMSdhsoDLYhtxMLlcqwbT4twMD+ZLGWReLCnMwrYLdVs7z5T4ohphzkuRTkFu8+
 GI/uiAZ1FB0Cp4RziqLbp52VWY0VcOqi0E0SKFygXkPL5eNDkBGO7UNMPDm3pIJPVCCjlR6li
 5TMfEhT/XtDB55cd6lOGt8GoioOIPm7QExyDoOl5wu4j9rRQ1L+T35Lp6dMNNE1LcqEScH0o5
 yJb+FKdQ7/wd7odatKqvsSL1R6++nHBRprkyVVnOTlJyp64REj8ysgK27cztdFOE9xBU=
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Nikolay Borisov <nborisov@suse.com> wrote:

> I have implemented it so it's not that big of a deal. However turns out
> it has pretty steep requirements for backport because so far btrfs
> always kept the link count of dirs to 1. So such a change should be
> justifiable because it's not only the kernel code that is affected but:
>
> 1. Backporting relevant patch to older, stable kernels

Why would that be needed?

> 2. Changing btrfs-progs so that it doesn't erroneously think a kernel
> with link count larger than 1 is broken.

OK, should be doable, right?

> So how effective is such an optimisation to the software using it ?

It's not only optimization like in find(1).  As an old and long-time Unix
user I'd also like that traditional behavior.  It just feels more correct
since if you do mkdir ./a ./b ./c ./d, you will actually see the 4 links
to the current dir if you do ls -ai a b c d and the two links from . itsel=
f
and from ..

Steve

