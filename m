Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 807C93D456B
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jul 2021 08:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbhGXGHJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Jul 2021 02:07:09 -0400
Received: from mout.gmx.net ([212.227.17.21]:36049 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229926AbhGXGHJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Jul 2021 02:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627109260;
        bh=4XnSYsGzYNL1SC3yA6jx/MWYCvwNTxOSRItdt+9TOk8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=LcH5dDAU3HNfAUjdDg3KbuW5GCtE+4noJnP7M7aMYNSKU8XFchbxA7M+/ci3waKAZ
         /1CsZATJUZ3I06tNJryx9LAVKqbo0eqDcLNUnjrulzkrDMZn7Nc5oZyPHUCsazmxIs
         IcyUWMZBhlW1egUWoXROzUylrFOpOkTl1RqRFddo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N0G1n-1lCAW42Ei7-00xH4v; Sat, 24
 Jul 2021 08:47:40 +0200
Subject: Re: Balance loop converting from single to raid-1 (kernel 5.13.3)
To:     Wei Tang <wei@that.world>, linux-btrfs@vger.kernel.org
References: <f85b8b32-0fec-056c-63ba-1ebb64f2bc09@that.world>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <f7c02e15-f76e-2f34-dacb-b72976b30750@gmx.com>
Date:   Sat, 24 Jul 2021 14:47:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <f85b8b32-0fec-056c-63ba-1ebb64f2bc09@that.world>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:J+nTRIpURCdEl9zYtY8Std0LDlGMr9KVtM5vLGoddiyWf4prGDu
 yRACKU8QxKkI60+ZHYtbmsbDpG4QbijSb4WC4WMVCusCvhS05NcpEpi3HGp+Qtsw4g51bH2
 x5+s3b6q++VacQBIdkaEWLG4Y3HVX7/rTU+IcA8ZDhcxzTwFyC0L9uchq7Rf7egcTgSXuDq
 IR5MIuMOMq/FJJSM8pHOg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:548C28P9JWk=:kPSwEF8tCLOAo36XKsOnYM
 DLn4/rqGm6eqRyit/b/0qv38zYaUi3Iw1f2hzcfrA6ULxtxlZaWEgGfskACrZhHvhDeIGzc31
 JHjZ42Js8hTChjmd00N09G6gSpm5uedc50Y626nmR/aEVvqH8QYdzh8L6EUIEBFHQNqxci4HJ
 ZZh/emANTGG9Y8eHn3c10qtxrFFNEgEoN/bl+tFuwHkVcoBUq9N575S/rcWWT8NZbYhNIQIi9
 FIbMIX1t0lIcAUyuZocDDULiADcVv3bK2Z/Lmcl/c4dya/2KYVS4yzSqU0mr1hy4jRd1+tHPs
 UnBn+FosgSdubqHD2I5ONHGn/ECRWYeT6o6PRVC8DAXFQpap0Zum6Geb9TsNNg3AHPdhwB7/2
 sZFS/IiHjh+dOSpYKdbXIacPGE77waQ2xINDCeq7+venhR4kKO9dVoLLW2U3A4IsSz/VShZsi
 j39YeXT8o+/y2DDLiI7vMnLvuUikkUcJriGrgfAg2FV+BByvQywuMtnhnTufrtKP6VFDIduhb
 Uwsh+YSE8e4OLP/WxzbrKDgCFgEel16X1X4r3fRsYz9rmUpSCDC4ioz30AMHpua3TrXvFbfEz
 f+p85m0dmZeXfdCd+sDkgN2JVGYZ6lz0WoLkU/DyfvWlTfQAKOkXmRbCOuLtywbAr9oD6xQil
 OHPzJj1rbmXi5mHasDRtPgnxHjlrIRP6qJX2zhQWfr0qmOJfkPeNCY8Q7EizOxEKR2Eabxuo8
 tVaFtavPZwtnindEmEzs9UfV20c0BMRmefuyqZDu5o8mkdKL3oXSLSLlKQjSXk7bRQC59fvkZ
 j3agDzn0Asx/cwj5ZkQJHlJsVCkYSz7N4iqJCzgV9V7naxiYYx6MA041FXo2NT6f64GclwI0T
 x+FWXMhPmqLfIbkL0CpyrNPq0TKrh9ukCWSgxEmyEn8awAxbYS918xI9PKEWpJtqOcGQteX9a
 FceP9zCrjlSf5XaTkShX/9nZStMQCiZTMjhyddh46HvPuRc8/d+rG2CYH2OLOnKqVw3V/ihCv
 EIEs0XtfVnvNjy5Iuv1ErqvtdOuHQEpiTyKwlJ8B1nLYiTMwe4d5gLh74dC22MAviigpMUiWX
 le1TAOZ6ukC0Fj3B541riiUp7unPYuSg7IS5Qc/iuoh3P9v9vLln9x8pA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/23 =E4=B8=8B=E5=8D=882:39, Wei Tang wrote:
> Today I was trying to convert a btrfs disk from single to raid-1. It
> gets stuck in this seemingly infinite loop:
>
> Jul 23 08:30:48 loopforward kernel: BTRFS info (device dm-5): found 1
> extents, stage: update data pointers
> Jul 23 08:30:48 loopforward kernel: BTRFS info (device dm-5): found 1
> extents, stage: update data pointers
> Jul 23 08:30:48 loopforward kernel: BTRFS info (device dm-5): found 1
> extents, stage: update data pointers
> Jul 23 08:30:48 loopforward kernel: BTRFS info (device dm-5): found 1
> extents, stage: update data pointers
> Jul 23 08:30:48 loopforward kernel: BTRFS info (device dm-5): found 1
> extents, stage: update data pointers
> Jul 23 08:30:49 loopforward kernel: BTRFS info (device dm-5): found 1
> extents, stage: update data pointers
> Jul 23 08:30:49 loopforward kernel: BTRFS info (device dm-5): found 1
> extents, stage: update data pointers
> Jul 23 08:30:49 loopforward kernel: BTRFS info (device dm-5): found 1
> extents, stage: update data pointers
> Jul 23 08:30:49 loopforward kernel: BTRFS info (device dm-5): found 1
> extents, stage: update data pointers
> Jul 23 08:30:49 loopforward kernel: BTRFS info (device dm-5): found 1
> extents, stage: update data pointers
> Jul 23 08:30:49 loopforward kernel: BTRFS info (device dm-5): found 1
> extents, stage: update data pointers
> Jul 23 08:30:49 loopforward kernel: BTRFS info (device dm-5): found 1
> extents, stage: update data pointers
> Jul 23 08:30:49 loopforward kernel: BTRFS info (device dm-5): found 1
> extents, stage: update data pointers
> Jul 23 08:30:49 loopforward kernel: BTRFS info (device dm-5): found 1
> extents, stage: update data pointers
> Jul 23 08:30:49 loopforward kernel: BTRFS info (device dm-5): found 1
> extents, stage: update data pointers
> Jul 23 08:30:49 loopforward kernel: BTRFS info (device dm-5): found 1
> extents, stage: update data pointers
> Jul 23 08:30:49 loopforward kernel: BTRFS info (device dm-5): found 1
> extents, stage: update data pointers
> Jul 23 08:30:49 loopforward kernel: BTRFS info (device dm-5): found 1
> extents, stage: update data pointers
> Jul 23 08:30:50 loopforward kernel: BTRFS info (device dm-5): found 1
> extents, stage: update data pointers

This looks like a runaway balance, but that should be fixed in v5.8.

Thus it's pretty weird.


>
> Canceling the conversion then restarting it, or rebooting, does not seem
> to do anything -- the same "1 extents" loop always reappears.

You can unmount, then mount with "-o skip_balance" mount option to
workaround it.

BTW, when you unmount the fs, could you also catch the kernel messages?
As since v5.8 we added an extra warning to catch such problem.

Thanks,
Qu

>
> # uname -a
> Linux loopforward 5.13.3 #1-NixOS SMP Mon Jul 19 08:04:55 UTC 2021
> x86_64 GNU/Linux
