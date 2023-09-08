Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9BE1799201
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Sep 2023 00:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234941AbjIHWD5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 18:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbjIHWD4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 18:03:56 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F4A19B4
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 15:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1694210622; x=1694815422; i=quwenruo.btrfs@gmx.com;
 bh=5Ljgq+H7SkTzVPfsF1yYeLRPgCNrb/4ZGlnQM0A/jG8=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=KePvt+I8bcx3rrjyEPjoB8ifmjOwKmFvjlGI2TRZRA4GhGkywr3yxcGNpumaEkDhw3NMoUN
 KI4CmW0Z5CscarlypUTSZP3LCdp8vncN6vnu9lwf2toWOVmTdbPmzQp07wV4hGqgi2WEmimrf
 X/RGrDUVuYDmyiEAmNo4lXuKqknidRq5zHqhgLpYJ6TcgxAKx84tXudQPyUrwoOzB0VbZH5VM
 vDXZM7E3rUeO6Bbo40eNh7+pTYvqN3OqBR6xob7y0+0r1uBarun2NXxEaWQxpLXW/NqyItA/7
 cCbid3dB3R+xQxiuvF9emz995FJrsR3X6ZY5h5zz+g1XB/7CtUOA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N5GE1-1pfw0h0EmD-011Bkp; Sat, 09
 Sep 2023 00:03:42 +0200
Message-ID: <4f5fee23-2ccb-41a2-a64c-1675bc378ff5@gmx.com>
Date:   Sat, 9 Sep 2023 06:03:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Scrub of my nvme SSD has slowed by about 2/3
To:     Martin Steigerwald <martin@lichtvoll.de>,
        linux-btrfs@vger.kernel.org,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Tim Cuthbertson <ratcheer@gmail.com>
References: <CAAKzf7=yS9vnf5zNid1CyvN19wyAgPz5o9sJP0vBqN6LReqXVg@mail.gmail.com>
 <1d611dbb-8aee-9a6e-701c-6498f1b51c34@leemhuis.info>
 <efbe13a5-1c6d-e6fe-25be-bd942823432c@leemhuis.info>
 <2169630.irdbgypaU6@lichtvoll.de>
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
In-Reply-To: <2169630.irdbgypaU6@lichtvoll.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PIn7D1LkpohwKyNMIhYgxukMOg89dhtWUrhOd28xvQerO86oT7n
 /TL9eHxCAwKbMOFi2ysjcCdj5th8+5pyjEJfCQDUEC5+SZ0yym/S9D3N6F8VzuX4EZx6xU3
 MHJOdcVvQHfMhPQSAq6vUOZTDomrLvdCKPvQiVc1/eQAPFM4n2o9vaelz/MX1a+jxdtTVvj
 a7YeG15bPLyGPpXrw2Udg==
UI-OutboundReport: notjunk:1;M01:P0:VF7NGNkx3Gg=;IeRp0KLJcvnxc0fRyIxgVZOu+zi
 UcqtVrCWSvA35uQ9MFjL0V4UGRrOnEqgg8S90+DI5uaJQoXkLel9wcnpL0lh1OlfH+2wyUVuQ
 ZRtx7afQ8ShFHLdoO4teJVsO0uQFIO40hVpPS78b7jU5vV+oZ4u2U4e/Ga4nOxpa6JU6Vxmma
 e8QZHCR7mWNxbjvATrjUxZ7cN21DDurwO/nCcNHMV2pIsj9yF/GdE8UTZO1UNaHpu3lufopIu
 984RwzlYZPQhitZJp9BopnbxIih4wTVvGMyhr5ibVvRTv5NEIQ0M3hy0+3Q9sH96tCgxsY198
 sZyKXgCiyMlNxtPXVbNfA/qNzsb8ND0TnT3deI4ISMP2wv9uZrEER7SCiioFWBmiSueCXX+GA
 sYnpo3aqjdOgvJfA+xnXEzpBqJCdbT2xwhZWU8HqPTeinzOPqp2UXbjq74mXl6S4AGikLi6oj
 QuGmxOnetGX3KVK4GrJIzPnN+7lPSJtiYrW50X1cNGJcIvhC+gmc+PaRF/7EjG1jNtDvimObw
 56eLfMdM+bBTlHEBek4zGjGM10gnVxbOQEZDw1xnA8xJyNicBm2RcMCCa/YbHBh4RKOhfd8YV
 PM09X2ncLjBdt+jjM7ex1xSx8Hh+eQJvazoNmXjDiifaMKP7a788OM0etMiNy+EUl2wRDTBVh
 gux42aBvC7u/7vzQjsJlNKJoBgUJNbPEkAOCEz1Q0+rSB862oMGNXuxFUxsfHaN10+qX+D6nB
 afstYy+Z4AJWrtia4AVck/fdu7wFSQY3DpYR22rR0G544t8o9EcbKSFEMJFmAUt+/F43r4RvG
 torYUVTW8SU8Kq7zb8nhDatZStmEZDNLZ6GjVZWmbR/y2o5HY6yLhxu2IkwCU153QpDWjEnqZ
 +QqY7gR3Q0O0bC8638sa/sVbLlC49if9Oa+pcdPDur999Eogdwh0dHdnRh1WneJqLAMYW+Tmz
 Prgmf3bIYvlqiXwylsuaqF0wCRk=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/8 19:54, Martin Steigerwald wrote:
> Hi Thorsten, Qu, Tim, everyone,
>
> Linux regression tracking #update (Thorsten Leemhuis) - 29.08.23, 14:17:=
33
> CEST:
>> On 12.07.23 13:02, Linux regression tracking #adding (Thorsten Leemhuis=
)
>> wrote:
>>> On 03.07.23 22:19, Tim Cuthbertson wrote:
>>>> Yesterday, I noticed that a scrub of my main system filesystem has
>>>> slowed from about 2.9 gb/sec to about 949 mb/sec. My scrub used to
>>>> run
>>>> in about 12 seconds, now it is taking 51 seconds. I had just
>>>> installed
>>>> Linux kernel 6.4.1 on Arch Linux, upgrading from 6.3.9. At first I
>>>> suspected the new kernel, but now I am not so sure.
>>>
>>> Thanks for the report. It seems it will take some work to address
>>> this,
>>> so to be sure the issue doesn't fall through the cracks unnoticed, I'm
>>> adding it to regzbot, the Linux kernel regression tracking bot:
>>>
>>> #regzbot ^introduced e02ee89baa66
>>
>> #regzbot resolve: various changes merged for 6.6 improve things again;
>> more planned; backporting is planned, too;
>> #regzbot ignore-activity
>>
>> (yes, that is not idea, but that's how it is sometimes)
>
> ideal?
>
> Scrubbing "/home" with 304.61GiB (interestingly both back then with 6.4
> and now with 6.5.2):
>
> - 6.4: 966.84MiB/s
> - 6.5.2:  748.02MiB/s
>
> I expected an improvement.
>
> Same Lenovo ThinkPad T14 AMD Gen 1 with AMD Ryzen 7 PRO 4750U, 32 GiB RA=
M
> and 2TB Samsung 980 Pro NVME SSD as before.

The fixes didn't arrive until v6.6.

Thanks,
Qu

>
> Ciao,
