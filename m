Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE0C2E8640
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Jan 2021 05:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbhABEJL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Jan 2021 23:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbhABEJK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Jan 2021 23:09:10 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E163C061573
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Jan 2021 20:08:30 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id qw4so29585443ejb.12
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Jan 2021 20:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RjEkawcL+sQ2m8Fv/KBnf7w0uzJS5JQVMSRX1bKaOXQ=;
        b=pccadW9TEAi6V3GVMbmbl7bqgYR8L56UEnYRJTofsR6alGl1m+Xa3/Fh+93FzXc51N
         hUZZ73kGISF1kUf/mKK/r8QHHiq3/B3BO6udcjkicBK9Lt0d4W3VulPoVDzsscXNlPiR
         IF4Hk+d5W1jbpIvLEUtX0AOy7RsxORXrETFubxCKIeqTXVDVxf7Q6ymK05jcJowrQeUx
         v3JKCfDM+Y88YdboDRGv/6WPcA18sVnGnEGS8Alxf4wjMbgDbMkckvQ9fKE0cJ49FaWE
         tDcZxcWZrOccYMc0Od2ffysZl+OGNA9CMiWiJPx42NDxEJh6Og6AsDRdOadRJFS7FDir
         JkVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RjEkawcL+sQ2m8Fv/KBnf7w0uzJS5JQVMSRX1bKaOXQ=;
        b=PsK6JKkZQnTMAbCrFTDqbu4vwjAnFwSHDgrobTFTwsM9Sxu/mVEzmfw1TBImO4FhOL
         Z2EVuitr58UVaEsXCZfdMX2Y4/+JriG8v+LS8sT96lDwQ2Zk2juvKgA3AyM3q+E3vHbN
         ipEL2BSOjxE6tQHrxzquWiUHBv41uuB5hyGM7Gmd6kdkv8vZ6YWk2O4d3h78s1I7q/26
         qd1iQcguXCRjq0qCWreTBr7toTAEdSPxyYPjsluvOd2B9Nr4JSpSJ6bbo87nQGuSkX84
         3Lm3unUHhhuHDwllcB3hS7CuJld5bYSDKOhxe68UFT7D+vgbAGf93u+fIW+mZGUBeIRm
         7mog==
X-Gm-Message-State: AOAM532Tr3cqjA0xyJw1IbYXYrDOfxoy3yQZlG+dDH9dy+ITzQsZ1Bky
        MHea+ghTqX+qRdepcpcVHtb+IcTv3Z11017ro2AkkA+EF0M=
X-Google-Smtp-Source: ABdhPJxe1FyeaJPBraA7arCtxbChwsAuaU7k2cc0EmMwJc5VwvjEUiOsFZYrwOjy8dD/IcFDZdTNIUijTgS9SLtbvKQ=
X-Received: by 2002:a17:906:b09a:: with SMTP id x26mr34883501ejy.199.1609560508783;
 Fri, 01 Jan 2021 20:08:28 -0800 (PST)
MIME-Version: 1.0
References: <20201231191656.8816.409509F4@e16-tech.com> <CA733030-4654-4D1D-9A29-5199178B0C79@gmail.com>
 <20210101135350.AD49.409509F4@e16-tech.com>
In-Reply-To: <20210101135350.AD49.409509F4@e16-tech.com>
From:   Sheng Mao <shngmao@gmail.com>
Date:   Fri, 1 Jan 2021 21:08:18 -0700
Message-ID: <CAAtnRhmjL2vtKqSkdAic9prJeK-AorYjj4hBBsQ=Q_Aj_hsUXQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] btrfs-progs: add TLS arguments to send/receive
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Yugui,

Happy new year!

Thank you for the help! I have updated the patches according to your reques=
t:

- use listen/conn-addr on receive/send respectively
- use tcp-port: later we can support DTLS
- support --tls-mode none: in this mode, send/receive won't check for key f=
ile
or prompt for password.

Please let me know if you have any questions! I am very curious about the
performance of kernel TLS too.

Best regards,
Sheng

On Thu, Dec 31, 2020 at 10:53 PM Wang Yugui <wangyugui@e16-tech.com> wrote:
>
> Hi, Sheng
>
> > Hi Yugui,
> >
> > Thank you for the feedback!
> >
> > 1. Yes, we can do that. The reason why I use =E2=80=94tls-addr on both =
sides is to introduce least vocabulary for users.
> > 2. I don=E2=80=99t have a 10Gpbs NIC to have a thorough benchmark on TL=
S vs raw sockets. The flame graph shows
> > decrypt_skb_update (related to TLS decoding) takes about 3.5% of CPU ti=
me for my 1Gbps setup. The transfer
> > saturates the bandwidth. Do you have any 10Gbps devices? Would you mind=
 to help me benchmarking after
> > introducing =E2=80=94tls-mode none?
>
> Yes. We can benchmark this for 10G Gbps or 40Gbs.
>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2021/01/01
>
>
> > Thank you! Happy new year!
> >
> > Regards,
> > Sheng
> >
> > > On Dec 31, 2020, at 04:16, Wang Yugui <wangyugui@e16-tech.com> wrote:
> > >
> > > Hi, Sheng Mao
> > >
> > > some feedback.
> > >
> > > 1, can we use 'listen-addr' for sever side, and 'conn-addr' for clien=
t
> > > side?
> > >
> > > 2, can we support '--tls-mode none' for tcp without TLS,
> > > and then change 'tls-port' to 'tcp-port'?
> > >
> > > Is there some boost performance for tcp without TLS too?
> > >
> > >
> > >> +--tls-addr <url>::
> > >> +Address to listen on. It can be an IP address or a domain name.
> > >> +
> > >> +--tls-port <port>::
> > >> +The local port of the TLS connection.
> > >> +
> > >> +--tls-key <file>::
> > >> +Use the key from file; otherwise read key from stdin. Key file is f=
irst parsed
> > >> +as PEM format; if parsing fails, file content is treated as binary =
key.
> > >> +
> > >> +--tls-mode <mode>::
> > >> +Use tls_12_128_gcm, tls_13_128_gcm, tls_12_256_gcm.
> > >
> > > Best Regards
> > > Wang Yugui (wangyugui@e16-tech.com)
> > > 2020/12/31
> > >
> > >
>
>
