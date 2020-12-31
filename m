Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3DA2E81A0
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Dec 2020 19:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgLaSeS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 31 Dec 2020 13:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgLaSeR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 31 Dec 2020 13:34:17 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BA4C061573
        for <linux-btrfs@vger.kernel.org>; Thu, 31 Dec 2020 10:33:37 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id n7so13466776pgg.2
        for <linux-btrfs@vger.kernel.org>; Thu, 31 Dec 2020 10:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NvsBXSxoLGdSC8tU7DAxQ5HxGh3Z4VvarebEyY/ESIY=;
        b=OwCMVLUZ+XxXYj4jmlb5qgg5vMiKlYVwGEC/vnCeWYhDGZ9xfk5YuZv6Jejz/iQn2j
         9ra1lBVsUOpt6k98DHKcnyxSp50mCF4ACqR0XPT3UaYPkHSmZPjEWd+FoARfBli4NFf5
         wb0JmyD0MRm6HiF72L0iTWdMEvvcbzL/odKjVWU7iy6Z3K03opchZZHnqzp6yLRo6eES
         qFPVxZiaSpqAlflFhn8OrcJISEJTTtRiwsSggSnkzduj0gmLIe8GYN4abAlmRckV0rxp
         7/hLDkgjzo/HXktae8O1w8UetU6+EI+yr3E7ive5WKINAoIA4KGHmHyGNrq70lemhv+v
         +qLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NvsBXSxoLGdSC8tU7DAxQ5HxGh3Z4VvarebEyY/ESIY=;
        b=bAvb6dw6oABXYsNTq4XP26w4PmTCPQBmq0fbHkFgjloaWWxAZDGVEx8Pw8tPtbqahn
         0FrLnzIDSTEAmf53xFL9GyYRHabua2vihlwgoeRtGSy0AK5UefMM46AmBF06T7kgI4Ek
         WYHry6ose5oxzRr86mwwLNXExviT5ncS7A6tS+pXQfpkwDPKJbY2W3+JAYk0VOYr6boR
         37mMxYG5s6Skny209TEk5l92dSi2NtX7LvxZ+dpMRDgREei9LMqkrFpl06TcRcRrjWdn
         T1iA7fcBhMojfbvrqfTfQQ0/iD7zRaH3E41cm0XtbjrlJS9yoY18UUWAbqBWS6lem/1U
         jUQw==
X-Gm-Message-State: AOAM533BwB0ybqIfjaREPOhO/pkLPWRQoSSkvT9lFn5DxiwAx627PRy0
        lYEK7SJt5YcM5hzPwkfaYHM1wdp8OEI=
X-Google-Smtp-Source: ABdhPJxuC7DGQLUDnYX3cf57Vi90mSRGlku4Utl21iS/ySgezDyx2NOkvogJISro04sJnqJfN73bMw==
X-Received: by 2002:a63:8f4c:: with SMTP id r12mr57276764pgn.311.1609439617037;
        Thu, 31 Dec 2020 10:33:37 -0800 (PST)
Received: from [192.168.0.17] (S010664777d4a88b3.cg.shawcable.net. [70.77.224.58])
        by smtp.gmail.com with ESMTPSA id jz20sm11167709pjb.4.2020.12.31.10.33.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Dec 2020 10:33:36 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: [PATCH 3/3] btrfs-progs: add TLS arguments to send/receive
From:   Sheng Mao <shngmao@gmail.com>
In-Reply-To: <20201231191656.8816.409509F4@e16-tech.com>
Date:   Thu, 31 Dec 2020 11:33:35 -0700
Cc:     linux-btrfs@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CA733030-4654-4D1D-9A29-5199178B0C79@gmail.com>
References: <20201225045037.185537-1-shngmao@gmail.com>
 <20201225045037.185537-3-shngmao@gmail.com>
 <20201231191656.8816.409509F4@e16-tech.com>
To:     Wang Yugui <wangyugui@e16-tech.com>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Yugui,

Thank you for the feedback!

1. Yes, we can do that. The reason why I use =E2=80=94tls-addr on both =
sides is to introduce least vocabulary for users.
2. I don=E2=80=99t have a 10Gpbs NIC to have a thorough benchmark on TLS =
vs raw sockets. The flame graph shows=20
decrypt_skb_update (related to TLS decoding) takes about 3.5% of CPU =
time for my 1Gbps setup. The transfer=20
saturates the bandwidth. Do you have any 10Gbps devices? Would you mind =
to help me benchmarking after=20
introducing =E2=80=94tls-mode none?

Thank you! Happy new year!

Regards,
Sheng

> On Dec 31, 2020, at 04:16, Wang Yugui <wangyugui@e16-tech.com> wrote:
>=20
> Hi, Sheng Mao
>=20
> some feedback.
>=20
> 1, can we use 'listen-addr' for sever side, and 'conn-addr' for client
> side?
>=20
> 2, can we support '--tls-mode none' for tcp without TLS,=20
> and then change 'tls-port' to 'tcp-port'?=20
>=20
> Is there some boost performance for tcp without TLS too?
>=20
>=20
>> +--tls-addr <url>::
>> +Address to listen on. It can be an IP address or a domain name.
>> +
>> +--tls-port <port>::
>> +The local port of the TLS connection.
>> +
>> +--tls-key <file>::
>> +Use the key from file; otherwise read key from stdin. Key file is =
first parsed
>> +as PEM format; if parsing fails, file content is treated as binary =
key.
>> +
>> +--tls-mode <mode>::
>> +Use tls_12_128_gcm, tls_13_128_gcm, tls_12_256_gcm.
>=20
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2020/12/31
>=20
>=20

