Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DC4591913
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Aug 2022 08:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbiHMG6c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 13 Aug 2022 02:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiHMG6a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 13 Aug 2022 02:58:30 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06A625EA6
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Aug 2022 23:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660373901;
        bh=0qHfdVvG6Eo4Sjr8Yu1w4zR8YoCG9LvUhSX9TXKWGC0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Yhp03BwRLOLM3AHRp8tmJgEs5fWPkYJSWqJV+fOVbvWVT+L46StgnPuD7Z/qpMyQn
         imTrlQF+INBXxjxTDzlZjrqxMqaOphpe7N2zLCEW/t7imGnT2mi3WrJ4SI7S7dfy+v
         coUC/TP+ikBHnPY7CmbMx8Ubrdj2YpZNcNXoooL4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MxUrx-1nTYyz0MAL-00xthx; Sat, 13
 Aug 2022 08:58:20 +0200
Message-ID: <8b8b669c-fe7b-70d7-df2a-d9f0339d6372@gmx.com>
Date:   Sat, 13 Aug 2022 14:58:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] Revert "btrfs: fix repair of compressed extents" and
 "btrfs: pass a btrfs_bio to btrfs_repair_one_sector"
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <09b666a5e355472749a243946a9199ce2d6cef77.1660370422.git.wqu@suse.com>
 <20220813061901.GA10401@lst.de>
 <ff84cdb1-fb69-ca19-d82d-658c976c89da@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <ff84cdb1-fb69-ca19-d82d-658c976c89da@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jiJHfDvTh6oOwDn4VVHDvqDNBkFXw8LlYb7BIixnCgb/SWvWevl
 B4vlve2BwrI8rjH2OpMCcqDtBdUq4G4kNF6sMqjFvydbElcpKaZuZ8gb9s//72qwNPP88o0
 xc4EMQWmnikZgeJHau5cnVKiuRcj6f33PPmb6U3cTJrePrezV6W3ZKFKIOnDOhGkqJWIjF4
 gT3dLtiLh346kuvmIRSgA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fYiiV3lkYeE=:CbnqPORRDXzHhXt7QzDOeC
 5G88uDGnQcokouhaYTmkVEl/1SV1Xyd1p0/L+BoyTLnuwGTCgAtB0AnQ34LXNC5cHmSJ0iLF8
 hjzRriKNyVLcqY0pkcyyH9/mKWkiCA7KReAXZj09ZfQidblIvwD1z9tPcB0aLETyeb79QJOe5
 BpEOznWvWEYFM46O9oVoFJHA64SOTSjs/cysyyAEb1+7Bd1Sn38ZIU0Ad7vf8wFpY1XJEhvVV
 zFiESq+qCcNtz+2SaEK4HGM6wm8icdiXbQ74EHAOiZLH1Pyv4YvGmsae+OSjz2YLRPCqBFWHt
 ZuAEzZQ+xlecRNZ3KeSSgg3wXXYINGr2ItluyeF1U0CE8JbtChBpIWA+3bcsBifPkZxX+ljOy
 yksN3Tbq5MBHDSpO+Psr7CNe6Vo7Vwj2eIE4JR52DZUDowE7hxh91HGVsbYMNCjdWjDhGrZda
 TSFtuL1AzyHfTk7ZO4J+amHc9+gB4vMzmFaBooleQig3EjqYcY9kkh2UYicIdOqlzihoJyUJB
 L9jJ0F+Rk5l8wV2PPvmF/pGb91dSF5xGRP2xlhzwRK+pH9l4d6BOcBr/7BaQTtwDuYORrFbMa
 PWzYTdAhuqkbSymldAA1xzeT1yqP1T4KiP37l1i0LjpJucx2qb4muo3Lvyl7mfRqwYb6TQp7o
 sp3KKLJCr0KzEskog0Bpc64y2QTg9mPV6qXETQatx4KA7+y9oPUL/O3AaeVY3ON+KZa6EjJsg
 HjNYAaq4cfi7NU21obphzfJTbIMlZ843Qcm8c1yVTE76l4iMnD3oARkV92s84yG+T8mdFWvha
 4+0Exj96zZdAOlRViwqFyKwmBiQnxKvswFG+nylze4HxY8so8ogkKHXl5SMzvPG21s8iAcLh+
 2YL5SVMtxHwgz7SbYg3bMf8SHUqZtLu2oJKjYHFYOUOImjz3XfKHewFHB9sf8gIuszOgf7dBr
 6sub05Q2Ux5Tu/VGetcRmG8hvtP3vVlDxZefRNrJ4KRMjEHdFX0KA+Ip6i/lWtcCrV0DoSU21
 U7B43tVgq4vA6/W1hOcWiGbn/ByZjecGKvQgv+Oinv4Ud8MDqzTJ1IkKpOTOjxVWHfCqB1ej7
 OCNNI5a7Zz/gOUyQAgYg1m+EgxMEQBaRFm5afsUFlM9W1ZTWH5APTg0Hg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/13 14:53, Qu Wenruo wrote:
>
>
> On 2022/8/13 14:19, Christoph Hellwig wrote:
>> On Sat, Aug 13, 2022 at 02:00:25PM +0800, Qu Wenruo wrote:
>>> To fix the problem, we need to revert commit 7aa51232e204 ("btrfs: pas=
s
>>> a btrfs_bio to btrfs_repair_one_sector"), but unfortunately later comm=
it
>>> 81bd9328ab9f ("btrfs: fix repair of compressed extents") has a
>>> dependency on that commit.
>>
>> Let's try to sort this out properly intead of doing a blind revert befo=
re
>> -rc1.=C2=A0 I'll cook up a patch to pass an explicit offset ASAP as the=
 quick
>> fix, but for the longer run:=C2=A0 is there such a huge benefit of havi=
ng
>> these logically non-contigous bios?=C2=A0 They are so different from th=
e
>> I/O stack in any other file systems that I think we'll keep running int=
o
>> problems again an again.

To answer that, the reason I found so far is purely because of btrfs
RAID profiles.

Unlike all other fses, btrfs has the in-built raid profiles, thus only
requiring the logical bytenr to be continuous will reduce the amount of
bios submitted by btrfs.

(Especially for profiles like RAID56 and RAID0/10)

Although I'm not sure if the reduced amount of bio would really cause
any different, as block layer should have its own merge optimization.

Thanks,
Qu

>
> OK, I didn't consider the reason why we allow non-contigous page into a
> bio.
>
> But indeed, if we allow that, it would be a much simpler fix.
>
> Mind me to introduce a patch to add a new page offset contingous check
> to the related code path?
>
> Thanks,
> Qu
