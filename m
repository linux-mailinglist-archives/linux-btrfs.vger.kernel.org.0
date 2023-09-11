Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B0F79C1D2
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 03:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjILBnw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Sep 2023 21:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbjILBTC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Sep 2023 21:19:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D98511C8C7
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Sep 2023 16:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1694475264; x=1695080064; i=quwenruo.btrfs@gmx.com;
 bh=k646O4fRYMxnP8IP0z27J3oDN+NPbYiQY++iJR5GF04=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=nQB5IJTMzdN1RBtSgX3A8ogh4hPU+KXoaJmvLM2YjtI01lS6HgxDUUMDbWQwuJnba/jhHv3
 ixLWMf0CQZjURkQzPmikgRNySc+MLDgFvo1GxFxuRxmbHEp5ee890XyA4sjn1ThSFu9TLQF1k
 sa8C0IXMHytsarzh9avqd/BEvcc2hrfuXHpGAKXptYkz5WwbbSyKcCnrMFZqYiDz3hEdekb7c
 L+nPqN8jR/ZuicPuir9FVI3Z5NKcmERLMkoa1EDttFqO9NMP1TK96WXl4ePemFU4ht89SdhsC
 re6yRrsllo7l39Dwy3GliWREs65sof++q/kFcUKqMrO1f8QVu1kw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.23.112.148] ([154.6.147.212]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MybGX-1pgzqJ49vB-00ywX7; Mon, 11
 Sep 2023 23:07:15 +0200
Message-ID: <2f663b7e-76f4-4e3f-a8aa-af79007f6683@gmx.com>
Date:   Tue, 12 Sep 2023 06:37:11 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: rename errno identifiers to error
To:     dsterba@suse.cz
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20230908191006.31940-1-dsterba@suse.com>
 <43024b78-debe-4764-8dc2-098e398df719@gmx.com>
 <8dbd9c7b-0f51-4edd-a6e5-0ad6c30e2dd2@gmx.com>
 <20230911143529.GB3159@twin.jikos.cz>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <20230911143529.GB3159@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yrY/YxrL78iTCz4TVaGdczuRPkxnrgaRlsWcDHyq2LcFPXen/ow
 BWtS8xvQbQi1mUlzjfVuhCdHsDrqawq5UMr3ACrEQReF2jW1+T7nPId8k2pXVUC3u1X/dEH
 h5vLNmL2xm//pyLJzYNXEIGxIhdX4sCRSlPvbf+NZdjEUAgHqU/Xv8wEDV36VOtMsRf9/VE
 6RLSzYh+fTrHJvC6Fwk6w==
UI-OutboundReport: notjunk:1;M01:P0:LfBLGCV+WxI=;bDISLq3JmLQO0PwqZ9scKPzMXyq
 rtOGFZmWifezbXHpkyoBsh1yAli66K5Psu+EwAZyNl5vxav/b6GvjoDf/LN9nQKuzSPwG3mls
 HEoPWlh/VNh9qT8SxjbD4Qvz7/IpgQzfVXy+aV12D9oHtPEX4ZzsuofVsRyh2Q9h6R8FZvEuT
 hIb40LlRAorbPaBj3QzDlJREOgMdTEw6O6qpntk59qalfpFSJX3/oSUJThKeJxaQXCbn5MfXA
 71uoYH0u258Xsv4cm5hehoUphNnyR2fGl5+F9LVuGkiojWiSUq42yqx5sJ5l1bE/K3vgrHI25
 NnZfOwrKXbDlaIJbJfxq/7XP+vKzeXsNoHvoLrwkacG+KgpsfN4wPBmRSq5CCumbIxp0nRfSK
 Es8D4svRrMCmdWMMPSmscwAiSwuLSfK4tZFZqmya/uW/fKkxKMsEx78jG0G8B/vZ8sEMxExaC
 ujUrx+Kra1xiA0jplE505bVj9zZy+BvV1tkkSWSSkZu6NyGesFO0fa7j+LWMKXzupvhVYvL1i
 0cZlvii6AVGcNvgzy9cL0ruw2Z+FhtAErxTQjYfqNuVb7PM3Ds9dFau8uqQ96cuBhO7mvwhxV
 x2o85t5oQy8mC/LTUM/v/AZMPKcub5eNCOUFJMjZoYS/sqFgIA4UBjnKrrJ9bypFjFf8aiqjI
 nxQ2qndCl5YnpXInXvv/ueZc+v+13/BTJ5mVBJIkHqC5IWVB0gwlxIMh+z1UhjY+UL4WMNjHd
 OUkL90Q6uN/FlcZ6g11dp4JoTmOPF+Fqx4pwmyr2DuGsol9MfzwqSPyCecM7oGSShg0Zd0myF
 +OhNFk0gEicbe/3y5yo9y+Rj4sBmlwLXo1QKrYOw4x6RibSvWJsSzTSMK32q4/fdW6Gyl27Yd
 qcuOoIXrkRgvKSJl2/Si4GPHnT/Cgk5DSmtvQDHHHKMyhwzvyuZMP+fL3/R0WMna4DxNbwwM1
 omwG+lNIPKHl1M0x5IbrPuTOSrA=
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/12 00:05, David Sterba wrote:
> On Sun, Sep 10, 2023 at 02:35:30PM +0930, Qu Wenruo wrote:
>> On 2023/9/10 14:28, Qu Wenruo wrote:
>>> On 2023/9/9 04:40, David Sterba wrote:
>>>> We sync the kernel files to userspace and the 'errno' symbol is defin=
ed
>>>> by standard library, which does not matter in kernel but the paramete=
rs
>>>> or local variables could clash. Rename them all.
>>>
>>> Well, initially I thought this problem should be exposed by -Wshadow i=
n
>>> btrfs-progs, but I'm wrong.
>>>
>>> When going W=3D2 for btrfs-progs, we indeed got some error on some sha=
dows
>>> but not any @errno one in the current devel.
>>>
>>> Is there some warning option we can use in progs to expose such warnin=
gs?
>>
>> Never mind, those files are not yet synced to btrfs-progs, thus no such
>> variable shadowing problem.
>>
>> For this -Wshadow, I think after cleaning up all those existing warning
>> we may consider put it into the default warning options.
>
> Agreed.

Sent but not really arriving the mailing list due to regular vger
downtime...

Thanks,
Qu
