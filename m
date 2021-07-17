Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3564A3CC1A5
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Jul 2021 09:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbhGQHIs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 17 Jul 2021 03:08:48 -0400
Received: from mout.gmx.net ([212.227.17.20]:49955 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230419AbhGQHIr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 17 Jul 2021 03:08:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626505539;
        bh=EABmhU7ehtDGNSw8dldSB6BOL/65Fn/xUhlWGyI/3N8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=IVoUkdCLPvYSkYR33aeO/cQwVrkEVkOk1fImVhrPtD7lYcl8BiwXvKD4DqKps31fi
         sYP+SoMF/mLRZ56ZFSHR/J2EY4eFwy2u+Aohdr85pMPb4FU0zExkQMfQny1vZUw1fA
         Y034E7GIUOuSHddpPVSr8hGImDGFSk7ex6QHDL1c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MsHru-1lFRiS4C30-00tlxG; Sat, 17
 Jul 2021 09:05:39 +0200
Subject: Re: Read time tree block corruption detected
To:     pepperpoint@mb.ardentcoding.com, linux-btrfs@vger.kernel.org
References: <162648632340.7.1932907459648384384.10178178@mb.ardentcoding.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <fb556cb2-4444-005f-4a94-6346f2a641ac@gmx.com>
Date:   Sat, 17 Jul 2021 15:05:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <162648632340.7.1932907459648384384.10178178@mb.ardentcoding.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VOoCPnQDOd71HsA8tNbniUvO3Up3btOsPyfcooAbjx4IlfG3SNq
 FUqeERXm+5lybncefdruG5XzLD0FIM1SHk0bafOk+Zopgow5H7DkOfAdHxoUA2V+zAbhp1q
 nJnthDcF4iVvMsN8ce4WQgPJqkYB6Ym87yNbcVW/Jp1hgQ2desHe+VBnDGJ+Xla18qx/mVP
 4fhRzxvje1CnqWdXY3tfg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:YsB2FGEWLS8=:GMG0rLy6om26vVRPKTj3q8
 KPwBsA/WsBqMQr3caP6ujQF5VSCQJ7WsPN0Yg2tgN7iIeis5uJZ8OmtNKAyDiTYXVsKgIcssK
 SwKTmx//XPruuZ2uBMpygMYv7Ms59w60ucnKJ0wyHw8Lz5JUp5mPMEikFjLFONlr3ekrGvcWL
 y7MaXKH91/aoAlqRGGDxqTfNmhiVcerGr0d/tQU9JQ9bx7XCYM2tDnskmfjCgG8adCOzPAlID
 reegMaj9Iqq13pJpPzqt6P+79EENPPBEvoBcQ84wz60CaENx3PKHzUQa/FfPyAJzIESOzn3ey
 5hhEQpD7lPo19D9OrBfnR6F1TcETAoBQusuoLPNMK6ieXVfvSr544TxOvu9uizxtzAe3FQFGy
 WizorJWf+nWTLaTrUD1UH3Juuy0yOUbzc+sqy1cLxoKAoX3akNHEkldVoSrIR/MuVNZLi79JT
 VC4vIMxxenXW0vy+vk1QifdqUo75saWlDF+WEuXR8S872+/2FBnbHbrH3sm2dUAk3yh3qYvs6
 7s3nhsOaPR+39NLlXqUMp1GPTwe3T6wnCcFNn84vrwpM9dSsGBSThscNSvs6S6Z6t+ZSVNAHQ
 K1NaWcfXOchQ+C6zxoIK2tvENd5aNei2iFTQspRHaU1aTb976YqwtoVzqfPOWukTgejAEep41
 hZjdp7N8KoiAbBahGqNHkB5StBIuVZS9CpQaHWYdUD0PYmXrIrwjBvHPZRZtuFKUag80HsWF8
 0M4fXf+/pxNwFtVvVTfxckdqjS+b7ETsq7SlkjIV0xYbaGYXDabIFti0DGYGRMw5sSs5RTDQc
 6FgKyLBA+H6OtXxkirP07JUfr4P7O4czpNatpZnp5gFssUooQbkCuF1ofdUV6BTImnW9JdRBU
 Nw9EAKNtq6HEfQV3GsQW4IfKdZqA0fsZRSp+hgI/7pySfa3ZzPRwRsYa7Pt+UNbqUbVDKjEx0
 ACcA+MAqIsfBR3HzA4Tb2eXXToNwI3En2kkqvbDf1+jS9h3AB9d/h43FmJML3LcUYIsLpVo+S
 y8+d0jXsiCrbugdhT+VuaVPQI6b2h3gcjBLw6H3u4loUmWFcnj5W5LqyWzpg5jmnf8WeLJRsm
 BQDCczYrIh0R0NSPLehzE8tvvkpVnlm+Iwob2g1IB0nkyLeOV7xBGzOTg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/17 =E4=B8=8A=E5=8D=889:45, pepperpoint@mb.ardentcoding.com wrote=
:
> Hello,
>
> I see this message on dmesg:
>
> [ 2452.256756] BTRFS critical (device dm-0): corrupt leaf: root=3D363 bl=
ock=3D174113599488 slot=3D9 ino=3D7415, invalid nlink: has 2 expect no mor=
e than 1 for dir
> [ 2452.256776] BTRFS error (device dm-0): block=3D174113599488 read time=
 tree block corruption detected

Please provide the following dump:

# btrfs ins dump-tree -b 174113599488 /dev/dm-0

Thanks,
Qu
>
> When I run btrfs scrub and btrfs check, no error was detected.
> I am running Linux 5.12.15-arch1-1 and btrfs-progs v5.12.1
>
> How should I fix this error?
>
