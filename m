Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7A8EE9BA2
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2019 13:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfJ3Mij (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Oct 2019 08:38:39 -0400
Received: from mail-vs1-f48.google.com ([209.85.217.48]:43061 "EHLO
        mail-vs1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfJ3Mij (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Oct 2019 08:38:39 -0400
Received: by mail-vs1-f48.google.com with SMTP id s130so1502179vsc.10
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Oct 2019 05:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=Or1/F4vMvIF35blodszSXJw55B0UV131hZjDUpFcSYg=;
        b=kA8zvc5AwE2Kk4+YK/fRqXFlGbYursOJ6FwCQbxLYUzbtg2P+Wy2d6vQXyY+V0Z2lc
         pfBT/AA6mV/eyyAl5ztQkBiG31QbFgU0fwmds+K6toFmdmVpX967roH/b0pM1qsIbuJE
         ErPVnLcEnK9G8864b2aMndovrbsClwZxVYcmC/bfGQTsq3o4AqEeoG1o+r3RXZh9ljXO
         VKR3Qb0a5keTvDd5xf/AKBFmti8eay/7a2Xx0alhi4JPbJWiLn3NxuKnDraqdwF64Lw2
         WjtwSyuwUXVCKi2ZtR+ynzBdnjy5BK0zBf9BN33zG/ijhmqbIqhN8vdbK/ML16fVV8VG
         60CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=Or1/F4vMvIF35blodszSXJw55B0UV131hZjDUpFcSYg=;
        b=l4rqzCdhCEb2tWeq7WeO3n7f5DGNZ64PCbvZnsTGDbZeu59VtZ5gh/sZPvXtZF3w0w
         n0oQiy7EtRG41UM3k6LBZIeH/1++bjW1BzAvziAlsOhZoBYCq+4QHmK7V0addC6LlnrI
         xe2IXXuMuYXVBAlL83gvza9kOEUclwu5smjeyDQVUHuRbYcxPURqWqp59Ws+YSklmnQM
         dmtellVu/7JnFqTnJfluqiQewQxd+Br+ZaYIPXykDAGqPxGkbWLRzWhDam583pFwnUT0
         aiDHRFjBs3+Km3qsaRVm09gXJd6uwtF20IYwt4GUtdWYEcFHSqvZaZzU+wYKoI2kV4Nj
         3huw==
X-Gm-Message-State: APjAAAVDpERas3UR48jUFwFgksxWjDOeHZ+H9KZAxNSMv4RnUP/7ZvrP
        P1rtSPk7YZVlzsWqUbrH5SjNdnYJ1BmOnVemxoJBtz58
X-Google-Smtp-Source: APXvYqzNKInzSOFJQmYjj5Ug26/pUsa6MUrJc4532IHqaJ39YpBSCX4RCnmR68LfmtywVfX/7h6LR4IRHPgrIBJ5UH4=
X-Received: by 2002:a67:69cb:: with SMTP id e194mr4178408vsc.99.1572439117792;
 Wed, 30 Oct 2019 05:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <af5343ac-2896-51ef-18f5-de05498c01f9@roznica.com.ua>
In-Reply-To: <af5343ac-2896-51ef-18f5-de05498c01f9@roznica.com.ua>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 30 Oct 2019 12:38:26 +0000
Message-ID: <CAL3q7H4+JmU05D9quxSekoUcRdWpW7DiyDMgzr7gQ4JbXcbq2A@mail.gmail.com>
Subject: Re: Read-only snapshot send speed very slow after modify original
 data. Need help
To:     Michael <mclaud@roznica.com.ua>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 30, 2019 at 12:17 PM Michael <mclaud@roznica.com.ua> wrote:
>
> Hi linux-btrfs,
>
> Step to reproduce
>
> 1) mkfs.btrfs -draid6 -mraid6 /dev/sd[abcdefgh]
>
> 2) mount
> -onoatime,nodiratime,thread_pool=3D24,max_inline=3D0,ssd_spread,compress-=
force=3Dzstd
> /dev/sda /mnt/test/

Have you tried without raid6, like single disk device case for
example? And without compression?
Did such dramatic difference happened as well?

Thanks.

>
> 3) btrfs subvol create /mnt/test/subvol/
>
> 4) dd if=3D/dev/zero of=3D/mnt/test/subvol/test.dat bs=3D1M count=3D65536
>
> 5) btrfs subvol snapshot -r /mnt/test/subvol /mnt/test/subvol.ro
>
> 6) btrfs send /mnt/test/subvol.ro | pv >/dev/null
>
> 64,1GiB 0:01:18 [ 833MiB/s]  - fast
>
> 7) for i in {1..16384}; do echo $i; printf '\x01\x02\x03' | dd
> of=3D/mnt/test/subvol/test.dat bs=3D1 seek=3D$(($i * 1024 * 1024)) count=
=3D3
> conv=3Dnotrunc; done
>
> 8) btrfs send /mnt/test/subvol.ro | pv >/dev/null
>
> I stop it at 0:01:18
>
> 464MiB 0:01:18 [4,67MiB/s] - very very slow
>
>
> uname -a
> Linux storage.domain.com 5.3.7-200.fc30.x86_64 #1 SMP Fri Oct 18
> 20:13:59 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
