Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3912C571B0D
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Jul 2022 15:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbiGLNWx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Jul 2022 09:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiGLNWw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Jul 2022 09:22:52 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3856E41D22
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jul 2022 06:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657632168;
        bh=lVaMrKtfAsdlZvOZUJdFt8D1PxLhO2KhudXp68WVRQw=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=BJ/ih1pjBTSS5UIJ+r5XhJFAexg6sEoQ9B3Ikq/XeIAZpblIvqIjq9BbyJ78odVKh
         bSpJCpeUe5qKXRK1LnZ3ZDl/31smayFaC+58zReyALKuC8Ht7BI2U/jsiUYIIiMHDf
         9DA8QyNANBcgmWafZE0u2ZwFmOCSKI0iZn5v4rFo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MbirE-1nZRzV2Lx0-00dDeB; Tue, 12
 Jul 2022 15:22:48 +0200
Message-ID: <eec791a1-f7f4-b897-3f76-b08418c148a4@gmx.com>
Date:   Tue, 12 Jul 2022 21:22:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: BIG_METADATA - dont understand fix or implications
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>,
        Peter Allebone <allebone@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CAGSM=J8K7_GfaqL3-7obOSytNhtoqmJ1GQrOKAUgE2dF7OehTg@mail.gmail.com>
 <2ba98b68-f22b-5013-8c4b-47b5c62ed437@suse.com>
 <fbd58f24-02ba-3c84-0c05-4de5f44d779c@gmx.com>
 <097bd15e-9afb-7170-06d3-2fc365092ff1@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <097bd15e-9afb-7170-06d3-2fc365092ff1@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Uy/7JJEWM/ZcALqQ1g7b0zsTxz7Aw96dyaT9o7VlQ1ssKMVghtH
 anSy1nr+CEinsB7aEIzcEWSziO/ATSV6C/EQr9rLx+pEEFbNNrqiDPv08xdYYeq4TqToMi5
 4oUadeCBXAYMkXtfnOjlkFimmp4bwqsOD7b0lAWg355pv/Fp+9GvBxZ/7t3UEmF9T6NB7Iu
 a+cTV/Yl+RU+ce0DESSEw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AQS9iVm/ZBA=:7OqEkIpkZ9gkVyWkxnz7Zg
 soaHxjprgY6iitXPrYhkXcRUl3fpd6EjIB7dz4TWXf7DU3mihWnQzGOkwkCrAC0fIK/EknZkX
 U8JjSJKxeaYUIAzTYnoLcqa94uKFEs7UqplNMUmpYeNSeWXN+povaAun92m9g/V+3bBeO9MnN
 NP7OMdYy3SY/4nqEsEwan6Sn6YDNOk7ERta2EmQ2CIAcCEenvixCRWG2YKK3v9duV355BOrSJ
 zYA+5ciGrb34xGFZbinwIrWIlz+ET4zTLK0kIfJsnkfEvgWfatXTXXjgkTNe99xICldthtqO7
 Frh67Pr0y3aa7BHi6o26/IQzt/M7L4kkzbFChc/aZJ09VL5NnB0L7tYpTdKJgDnXeRzM4ChVO
 484ngzdfpcMiExgj3JQ1ZJ7+UKvdR4kDP15BZS5eczSvCphYeNtdtr+lh2sEH6r5/p477PT3T
 xvjbbsdAie/TwYXom/Rn4fvxT8HzwewBhBDu+USDXcAIwf6AB+wZwOP16MIPDbwbUaFMB7HcH
 YImM2PexQ6PLTEdr+Kpyr4J4R3WD8ijNyl0FEiz0UGzAlbSGxClu62QHjihxqwG15wIoJr7ib
 WBKckSCSi6EzrYanRn0WbvXZbXwGvfNWIX/2C+4/PHfYrCOGBcLe8FQsuf5u0imGcDTbp9DO8
 Wn+J7spQ4D7yxIZj6lwxlUuhIKLH2fv13b+Pyn58SDm+eCqh21Pnkj7ZmtzxEYyBgsd3GgTPT
 JnO+b+9iElHPUsVZ844KPh6k+yeof7IBnJqnDfqUzZjjHHFNPCnD/7q1uvp0q32Zdz33CQNXl
 X6lHQy4Ip0MwPxM67U4ZaxBVnBrnZ6cUnRp5vXbPDhUWok/ikG23V6vYnnPMK1s3kZcXHlxlK
 hmiUXrkGJYIQNmxsL9PdoLcbG1h8f7tORlUfmhN0EmR2oAyWTzxSisBml+xHQoAvO7eoMthF+
 MtT7afIT4/eju/LNftAmKmuDGXi6YDOHbVgZRC3atWnGM55xsfghKa2dkLc+vi1hW1dDG62bw
 21uzA8H9I3fKMycxyia1VJOLz9qsINEYoiYssSMQbNSqx03XpNDLQm+r2B6IYDRKcKYwf9WQU
 B29uc51IEwMeqiskISOMeztRhVs6NqFLtN7jk5W8/eCLmdrMVLUA/5YZA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/12 21:18, Nikolay Borisov wrote:
>
>
> On 12.07.22 =D0=B3. 16:13 =D1=87., Qu Wenruo wrote:
>>
>>
>> On 2022/7/12 21:05, Nikolay Borisov wrote:
>>>
>>>
>>> On 12.07.22 =D0=B3. 15:24 =D1=87., Peter Allebone wrote:
>>>> Hi there,
>>>>
>>>> Apologies in advance, I dont understand how I am affected by this
>>>> issue here:
>>>>
>>>> https://lore.kernel.org/linux-btrfs/20220623142641.GQ20633@twin.jikos=
.cz/
>>>>
>>>>
>>>> I have a problem where if I run "sudo btrfs inspect-internal
>>>> dump-super /dev/sdbx" on some disks it=C2=A0 shows the BIG_METADATA f=
lag
>>>> and some disks it does not. I posted about it here on reddit:
>>>>
>>>> https://www.reddit.com/r/btrfs/comments/vo8run/why_does_the_inspectin=
ternal_command_not_show_big/
>>>>
>>>>
>>>>
>>>> My concern is what effect does this have and how do I fix it, once th=
e
>>>> patch makes its way down to me. Is there any concern with data on tha=
t
>>>> disk changing in an unexpected way?
>>>>
>>>> Many thanks for any insight you can shed. I did read the thread but
>>>> was not able to easily follow or understand what was implied or what
>>>> would happen to someone affected by the issue.
>>>>
>>>> Thank you again in advance. Sorry for emailing in. Hope that is ok. I
>>>> was just concerned.
>>>
>>> If you are using recent kernels i.e stable ones then there are no
>>> practical implications, because as soon as you mount the filesystem wi=
th
>>> a kernel which has the patch this flag would be correctly set. As said
>>> in the changelog of the patch this can be a potential problem for
>>> pre-3.10 kernels (very old) so the conclusion is you have nothing too
>>> worry about.
>>
>> I just went checking v3.9 and v3.5, if there is no such flag, kernel
>> will still mount the fs and setting the flag.
>>
>> So it doesn't seem to cause any compatibility problems at all.
>
> But that's the point, fs created post 3.10 should not be mountable by
> pre 3.10 because they'd see an unknown flag.

Oh, got it now.

Although the introduction of that flag is a little older, in v3.4. (v3.3
doesn't have it).

Thanks,
Qu
>
>>
>> Thanks,
>> Qu
>>>
>>>>
>>>> Kind regards
>>>> Peter
