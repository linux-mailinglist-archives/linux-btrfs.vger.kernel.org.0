Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3AAA74E9A1
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jul 2023 11:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjGKJAL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jul 2023 05:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjGKJAJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jul 2023 05:00:09 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D6610C3
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jul 2023 02:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1689065999; x=1689670799; i=quwenruo.btrfs@gmx.com;
 bh=LYBQTaIw6ddA/iRUEb9lJqDubpyF9m5RmdhrMV94ItY=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=ZGZmYOG8mumlq6Sf+Itkk80if2S1GE5zcAdkYV90bZk8nkOBXdeKJB7Ufp1sk7lTqKgvSWK
 /ydW3BSgvmljLpLA6BmAgZKbQLofj2GEqU61X49XZX95RxjQ2W9mWzCgHOvKHSjEciuQT/Np4
 uXZEAMo46Ito9cSLiCxzcob6GWZYuv1BgIOc39iYT0kfzkVj8DEgPEBZeGwk01eGGfWbjOe9y
 6A5obF8n5IuzO6Yb0rVHxSF8O/KQaHlHEQ5/8T5wzkn1fd5+ClYMr2fRBAJvKmNEpTTcqrN/k
 IfKCZjwXsX4M/yXCz89Ed6uBXOwRtegU7h2GI/cPsw1Bf5PHVdgg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M1ps8-1qGwIY1CK8-002GLl; Tue, 11
 Jul 2023 10:59:59 +0200
Message-ID: <22b2a8da-5225-7703-e8c6-75c25baa986d@gmx.com>
Date:   Tue, 11 Jul 2023 16:59:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Scrub of my nvme SSD has slowed by about 2/3
To:     Martin Steigerwald <martin@lichtvoll.de>,
        linux-btrfs@vger.kernel.org, Tim Cuthbertson <ratcheer@gmail.com>
References: <CAAKzf7=yS9vnf5zNid1CyvN19wyAgPz5o9sJP0vBqN6LReqXVg@mail.gmail.com>
 <5690570.DvuYhMxLoT@lichtvoll.de> <2149714.irdbgypaU6@lichtvoll.de>
 <2890794.e9J7NaK4W3@lichtvoll.de>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <2890794.e9J7NaK4W3@lichtvoll.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uCFZPwjYfVIp9an8tiy6r764JJix+QXKWApPZa+G8R3VGbrX/KS
 o8IJqHx0Mlq4QnG3TmZX3yF+GnWfK8HQP4Dxi0J6QVDypAP1a5YaH8ELM+olew5ru76ky/M
 tYQXFAT1wxKu6Du0M7ppjIWIlVrE9il21gw6EPcrPYnIPDGn9LN0CeMaAyN6pvrdkaoXWsF
 YbsPoiT8Ih9r/H+ZRxPbg==
UI-OutboundReport: notjunk:1;M01:P0:/UY7QK8Tzpo=;/QWdZz7lQMoKW/upHKGZ80eMwv2
 KuxrjQpV2O6NqWyqpvXn/PIX3tcG/hJ6xAZBVTAvuOp5Cos6iiBKCjMnBjbpBAi2v7KoDPMDl
 vdqaT5K9iIY68YhSktx7dO13QuQlKbcGvOgiFdAlyUMSWLlYsTBa9ve71zxE7TjNz5GqexkJC
 zV1wf9X2TZoJzmM7skfT+VefIEzfTXi4csru/zNaeRXc1MV5WE1nC0keRkbYulLYKgdHWFoDC
 Itn7WBB2QW4IzY9CxMGr/m2o7G9398yr0w4vkyuJvb+HqEQVRyo4rh6gF6a0X83oOaOcFOvjE
 GeuAgqiemNcYblkeBWnimMqFocPmZi6fmfwK02DkHgtPJJdma4MV8EHU/31Ye0eySxU5V3Zor
 TJE93SMOxyFokTXvGxl0fdXGO0lXXHYf1HaLlkJMSvwjTl3EftddzMzruvsVn+3nlEUDaABtJ
 a8iysPMdsf1UMdU5rTEqe2JC0ghmgRbwelwboxMegjcvEWSkgreOemADl+tBVhj/82miE+tlr
 zZLrpX/mQi55Us26vnn5mRtC+OJwESygPP4VtC0DqOl28d5oZAkAirx8yeZTbn4VArcoEPZ2b
 F1YmAU2Ly5Lkul/weM1uZTHFWOZfCwluOFnne+qGNEGoXYa3fJVJLLzHxrXezt9KouWo43Hx3
 SiQ6XEvEkQJSqf0Lx6uHJGAzmqD4i03G/nVlM2N51en7EA4vFO16iRbKBvxMWqwHjZEAHXZOs
 EV4t+kfVJQGJRmqBHZE8zEGIRCalUwvK83CRkXSKwHI7Mm8NpyYIqy0alypk3Vvy7pvkq3C0n
 bQl7zg4mzLOZE+pA5WmpzXkjGCAnAmPWIlFWBBjWbW1aWUhu63ghJhLYbwumyggmNS4hhzGhe
 Gu/vV0mA65mjdlqx+58HvzcjKW/ELOLP+lNTQQ8YI7bB6vqltWmjWpxPtt/8ArIfEqPTUzh3l
 N59I/WinFdDaLAhPHFD905lN7Uc=
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/11 13:52, Martin Steigerwald wrote:
> Martin Steigerwald - 11.07.23, 07:49:43 CEST:
>> I see about 180000 reads in 10 seconds in atop. I have seen latency
>> values from 55 to 85 =C2=B5s which is highly unusual for NVME SSD ("avi=
o"
>> in atop=C2=B9).
>
> Well I did not compare to a base line during scrub with 6.3. So not
> actually sure about the unusual bit. But at least during daily activity
> I do not see those values.
>
> Anyway, I am willing to test a patch.

Mind to try the following branch?

https://github.com/adam900710/linux/tree/scrub_multi_thread

Or you can grab the commit on top and backport to any kernel >=3D 6.4.

Thanks,
Qu
>
>> [1] according to man page atop(1) from atop 2.9:
>>
>> the average number of milliseconds needed by a request ('avio') for
>> seek, latency and data transfer
