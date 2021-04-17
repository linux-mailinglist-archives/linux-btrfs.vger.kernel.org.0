Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED8CF362C8E
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Apr 2021 03:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235263AbhDQBBk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Apr 2021 21:01:40 -0400
Received: from mout.gmx.net ([212.227.17.20]:52333 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235046AbhDQBBi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Apr 2021 21:01:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1618621268;
        bh=lf0S65L624wrpbfWhPn8O+NFUVsYzB4amKHETV5POck=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=CfpAU/kHf+roP9ctzXzljDZ8z4q+Wp0IxBnSyb8NvL3/0d3T5jqutft9vWNMrm/0x
         UtlRKh9Ns4Jb9FunqOqFVdwFpmJR/S9TRn3N+CG8Ca+w1d2hgexW+pUapFMwQ9OG2+
         GM68i2dgR/UCyCFKXrc64OloHHWBBRRNBPGR02nU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MHoNC-1lKs1V2XNm-00EyNs; Sat, 17
 Apr 2021 03:01:08 +0200
Subject: Re: read time tree block corruption detected
To:     "Gervais, Francois" <FGervais@distech-controls.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <DM6PR01MB4265447B51C4FD9CE1C89A3DF34C9@DM6PR01MB4265.prod.exchangelabs.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <666c6ea6-9015-1e50-e8a7-dc5b45cdac3c@gmx.com>
Date:   Sat, 17 Apr 2021 09:01:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <DM6PR01MB4265447B51C4FD9CE1C89A3DF34C9@DM6PR01MB4265.prod.exchangelabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EDG08VQJg23sU6VzUcf90VaYO/1e6YeuCf6EHkSB616Q9hD+Ula
 TjR+LS6+8qgbpepDKV/hPd/nRSeQbZJUroOX1nloqCwMpVwe7+vRhONOnhxwhVP6yuzMZrN
 XUER2Np3aSjj9YTD/7VOdw0i5g2HcCcCnZA3h78Q+RN8N2nqXi0gktj2ShObbpaVYNGbpQc
 07Jg64WFrfPbjTr+ESFFg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:HubKvN2gEe8=:WT562xXhZ0BeSt/z4lOs+y
 kv66FRYVuRZfevvN95pOFH7cdy0gcFZHnyZ4IeWhIs6vs3l3khsCxwq3fD/WemVPkDCtrYl1O
 /ohLH3ooRMqwQGsqBHTj3/iWSlMVYx6XPgvJ8QaOsDH3wWyu/IRYzG0INQOS3ZLkLkGy3NsTQ
 V1j+O7dtoHK6LOKrbJCV7QINeStTPtL39Qj/3kVdqxC6OeG7UL4+LDkF+vMZjDsuusdYFhMCK
 lh3SSZhzSYynxemUYaofhvEi/15BzmoRMmWHZn1lzIbgJ6gykqEFr5jDk9oPePHUfOUh8fcT4
 4puLW3E1cwW9jGrHtaIpM7GJVq2AzaaDnoXvgDSSHcVEgALDIH6jYlb43mYIVFSQKv9y9vApz
 812XYtXaEZXftbRrwCsUKIccYOdCTP5yKrNZ9EQUAXfHVBbaOdKuBBeMdyb0OcADtfq7Xx3HT
 tIRmKcJqR16bCZs696cIOYmlE0JuXQIcXWKjeFa7LNjjefWACuetS9WTrrq54tbanTpPpHpVE
 16ZFBaivsRwwn4/PLyDO8MtTIzdhUuMgj5e+BoJ7t0Fi/q7s3mFXUJ3crqAnLSTQKyBXYgWeC
 gVrwQCVDFoSaPQMidrAQekgE9u9sjGDrinF1bLc7RabTjV3W5c55A7A6P5QZPqnU1OzkoTlDo
 Wd+k1MIctP+Q5Qf0vDCBsRk/WjkTTA06PETbL3PJrnkwa71zJcd/o/83KThr7wYKfz0xweN49
 LGukCuFjv1hXa6Pxs4YlxLarNDmajMsT9SGrKM4v3gjODNcdeGxDMJt9PwdUSNGsXpnke4yFy
 AJCOWkIf9gMKktBnV8ICOwgWXOeowuUv8ch5Qg4q/0OMnrI2aYYpcAtg8ieRWYajzmzZdn9GG
 2Rnf8cNV4+d2oKnzq7C9utUn/9AjupDGkHYvs/y4z0tpppCuTF0oKOI7HG3yHedOKT2eyVbHo
 RfVWBzmHYpndRj6OfwSwQWognJP3qLPI7PiMeoJtzTKlUXaZTQDPTkbS4nxTQqX+WijUHHQBG
 YRQlc4LUv75XOZDrhIzXMU6s6Zl+4bVQZJVJGvRFAmmUXpJWgtesqfMCsSZmHdb9nfUaUinqj
 ifKUO0rtZkhJxL13pZBv+KPzYQkG9LOZBao2Y1Bjcf00bdGJunvirgZ7erHm3mPQEGiszIBZS
 fSP8TbGhI1qqxenOY4Bh/Jsf+Fkl3xZdaBj/dQjFXWz1ZncDlCUrP+drCFVnaSUm7o/NJ8tmi
 tCeqmZOLTM1ADAyP7
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/4/17 =E4=B8=8A=E5=8D=883:35, Gervais, Francois wrote:
> We are using btrfs on one of our embedded devices and we got filesystem =
corruption on one of them.
>
> This product=C2=A0undergo a lot of tests on our side and apparently it's=
 the first it happened so it seems to be a pretty rare occurrence. However=
 we still want to get to the bottom of this to ensure it doesn't happen in=
 the future.
>
> Some background:
> - The corruption happened on kernel v5.4.72.
> - On the debug device I'm on master (v5.12.0-rc7) hoping it might help t=
o have all the latest patches.
>
> Here what kernel v5.12.0-rc7 tells me when trying to mount the partition=
:
>
> Apr 16 19:31:45 buildroot kernel: BTRFS info (device loop0p3): disk spac=
e caching is enabled
> Apr 16 19:31:45 buildroot kernel: BTRFS info (device loop0p3): has skinn=
y extents
> Apr 16 19:31:45 buildroot kernel: BTRFS info (device loop0p3): start tre=
e-log replay
> Apr 16 19:31:45 buildroot kernel: BTRFS critical (device loop0p3): corru=
pt leaf: root=3D18446744073709551610 block=3D790151168 slot=3D5 ino=3D5007=
, inode ref overflow, ptr 15853 end 15861 namelen 294

Please provide the following dump:
  #btrfs ins dump-tree -b 18446744073709551610 /dev/loop0p3

I'm wondering why write-time tree-check didn't catch it.

Thanks,
Qu
> Apr 16 19:31:45 buildroot kernel: BTRFS error (device loop0p3): block=3D=
790151168 read time tree block corruption detected
> Apr 16 19:31:45 buildroot kernel: BTRFS critical (device loop0p3): corru=
pt leaf: root=3D18446744073709551610 block=3D790151168 slot=3D5 ino=3D5007=
, inode ref overflow, ptr 15853 end 15861 namelen 294
> Apr 16 19:31:45 buildroot kernel: BTRFS error (device loop0p3): block=3D=
790151168 read time tree block corruption detected
> Apr 16 19:31:45 buildroot kernel: BTRFS: error (device loop0p3) in btrfs=
_recover_log_trees:6246: errno=3D-5 IO failure (Couldn't read tree log roo=
t.)
> Apr 16 19:31:45 buildroot kernel: BTRFS: error (device loop0p3) in btrfs=
_replay_log:2341: errno=3D-5 IO failure (Failed to recover log tree)
> Apr 16 19:31:45 buildroot e512c123daaa[468]: mount: /root/mnt: can't rea=
d superblock on /dev/loop0p3.
> Apr 16 19:31:45 buildroot kernel: BTRFS error (device loop0p3): open_ctr=
ee failed: -5
>
> Any suggestions?
>
