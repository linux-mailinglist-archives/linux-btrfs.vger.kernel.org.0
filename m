Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF36F3D1AA5
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jul 2021 02:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhGUXh5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jul 2021 19:37:57 -0400
Received: from mout.gmx.net ([212.227.17.20]:50301 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229600AbhGUXh4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jul 2021 19:37:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626913106;
        bh=SOHDMKp6NUqB0eLarDg71BPdfJUItAKt+JCA+XvDq0U=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=RhMs7a1RO6N9PcaVHAVqUauHt8jXXYsUXLRFTHMAEFvxhBW9xBL2OGGvV20C0XE3t
         C7ofk9RzF+HHi6eA6bM3+LQTDPfG/fw1cBN6xZW820gOeKI/gsp1psJIwMfEn0rbNy
         Oeaf9y8QCfZW52UnEOOgkBPSAYbhAxqEqGG3FAmQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MpDJX-1lJUsg19yR-00qhhS; Thu, 22
 Jul 2021 02:18:25 +0200
Subject: Maybe we want to maintain a bad driver list? (Was 'Re: "bad tree
 block start, want 419774464 have 0" after a clean shutdown, could it be a
 disk firmware issue?')
To:     dsterba@suse.cz, Jorge Bastos <jorge.mrbastos@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <CAHzMYBT+pMxrnDXrbTJqP-ZrPN5iDHEsW_nSjjD3R_w3wq5ZLg@mail.gmail.com>
 <20210721174433.GO19710@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <8b830dc8-11d4-9b21-abe4-5f44e6baa013@gmx.com>
Date:   Thu, 22 Jul 2021 08:18:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210721174433.GO19710@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FpNGBfFxdMD5ehcyIDBOZ3lLZmCiM9q7FTRZ/xYFvYxHNq31rj0
 y8guzPcvDmysImIWUirMQE9lrIqtRosrUqZ+frV41fB6mFUjYn/UVwhRtEupZFWf18iyozG
 ZUmuysA3yADumWxf8pIKQt5TyiTCqzT2DTzekfZtA7N+gjhgLgt65WaH6Ww23xmgD4jpW5i
 gFwiYEwBpN2QxcT12LT+Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Tc1z5SYw008=:WfZjPxwMcbNI5GNgw4XLe0
 Z4uFh0agYxVTlWcIVPP/kAKPHPGOKuksNm/04v78jPugv8D7BSuHZ8fxoe+mUeRpE8Cj9nTp3
 d9eEdj3eOmQ9glz88z7PKGmjbzzeVoHXlnrFtNSu3mMn28HuvyaC03kTwxZLql4BwlD0E3aq2
 6orr7ACoNNJ5EXFSKag9Oo8nSlcjUM7m/u9mYV8n70sX86N8sUiPKm79kl5qLaQ6KPFe3Mkvm
 aFks+Y9gWowyvkh7+JjKkTrmu15u2ZvvCGamcqS1NCOn0wFfm4ozTZRF6Bv+KR3UEUbYnpBQ5
 NRkH3DiFItYoUjtcSo02oyLCMnqHijfqcwEgW5dATazO3pW7DofJ5sLsdAy7YgiIhdh5Y+t5P
 ZArDzeQKTwBQF6A4eMCK+MxbNaRlhm4OYl1AYrlTUdngeBEi0wpXlUDqu5FCHmi7HZ5QeGPvh
 xK5P5yO5n3WLBnVk2KoegRd6kAITvsgyD5gncmEChmfokoXBkPYjQYOyVve1L0Mdqx+CKKJtz
 oeYbD9BC1ZudQQ7AfcBFrB7A+j3J2C8mHjfYIM9E+H//0FwhagaN2n0NshZ+EtJ5SI/gDjQVf
 +PPBe2k9DY5rOjmiPargacSenN//L3kstTIXwHY/QbdxEA4+vgcrVz112CsnumBNfVcN7uhtC
 BJOAmA2hTUhqUrA7ckkoQKe0RRhzHVyoKYYDmN3yJuDuHgLbxGFTkZCVHjxpVpQRWKNfDytvA
 VjN0M9KLIjH/wctghDKDUio39Zm2IGQxCpEsfErGLtRSflDx//o7iwW5UGGenXyAMDn/S2VCh
 EcPPwrqQKaQQxvT8LR4UC7ir5AUPWXKewPFRZLV2JAkd0xnIgw8o9CF4nCIqf9g0zqsVx94mY
 vcC8OvefSZQ6bqUzAV1pn3JuKQ9He6bkskBHQWEqnsjROBaU1K3T8jlzswam3hK83O1/hzrbR
 omhu4QPbinrrzkzB3nPEEaizBSrF3oR0vGaSotBXvASDTorJSevySNiabtiVHdud3WT2NmSHu
 gtL1nu+qR+X8d+x5yIYxHPk1cflhxrGoJALORrad5a84b1g5V0LnSjs1H7P1y1oozIjv3WAYl
 OOT0ys5/rLm0K+MohI1R3cSMY1NLlioot7juGEDikBoRKdMMO7aqb59Hg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/22 =E4=B8=8A=E5=8D=881:44, David Sterba wrote:
> On Fri, Jul 16, 2021 at 11:44:21PM +0100, Jorge Bastos wrote:
>> Hi,
>>
>> This was a single disk filesystem, DUP metadata, and this week it stop
>> mounting out of the blue, the data is not a concern since I have a
>> full fs snapshot in another server, just curious why this happened, I
>> remember reading that some WD disks have firmware with write caches
>> issues, and I believe this disk is affected:
>>
>> Model family:Western Digital Green
>> Device model:WDC WD20EZRX-00D8PB0
>> Firmware version:80.00A80
>
> For the record summing up the discussion from IRC with Zygo, this
> particular firmware 80.00A80 on WD Green is known to have problematic
> firmware and would explain the observed errors.
>
> Recommendation is not to use WD Green or periodically disable the write
> cache by 'hdparm -W0'.

Zygo is always the god to expose bad hardware.

Can we maintain a list of known bad hardware inside btrfs-wiki?
And maybe escalate it to other fses too?

Thanks,
Qu
