Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0234D4E7E5E
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Mar 2022 02:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiCZBMq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Mar 2022 21:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiCZBMp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Mar 2022 21:12:45 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6E217288F
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Mar 2022 18:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648257056;
        bh=uFoZummTS7MyxuzLCE6WGaEjhEgtrXS6otgj+1iQk0w=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=eADY6fgIwmBTBHiOYUmPsK2Imm+9xx9OBOpM1DmXJrVVFtG/WV3o0raUVMGuXmDxx
         DW4qWvc8MgbmzDDKfrCvt0wEWptOfecPTpB5Mz2fPEkJ2x0FJf/H3MHeWUV8KoY9RW
         WgphHeuUQUj32cPk42EjcElWvUes8MNMZ3LaH3MQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MeCpb-1o5szY3nSJ-00bO1r; Sat, 26
 Mar 2022 02:10:56 +0100
Message-ID: <7225af7b-eec3-b5a4-fa4c-6333fae5ac4d@gmx.com>
Date:   Sat, 26 Mar 2022 09:10:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH RFC 2/2] btrfs: do data read repair in synchronous mode
Content-Language: en-US
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1648201268.git.wqu@suse.com>
 <1b796a483efa008ba5e2090621161684b3c4109b.1648201268.git.wqu@suse.com>
 <Yj2ZALUKtblRSaxP@infradead.org>
 <dd03a779-f996-4e45-e06e-f75acea97ff7@gmx.com>
 <ba5e64e0-8761-3cc3-e3e6-c78f02ab4788@dorminy.me>
 <84178851-8c88-dea1-1d0e-844b6ba7bb7c@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <84178851-8c88-dea1-1d0e-844b6ba7bb7c@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WnMZTbHz7u4HmGJa69UgGmDSwOvRi8L1NkGpQzWVxRKhI9Wo7EN
 KajAP30KvabpW/vYe2uhoMQICaL+fOPaFD86VoTTyehvAnt6MMG+uV9XG3bwLQBr3CJ8dnT
 Ox9E6cjV0M++KqWaWuC3GIj9Qt5P4QyZ+AsIkekcvY9ByZvGtf9qp8XNG0AUBpIhTYA0jLP
 8LPKLyRm83SnxBi+tA0XA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xni6gfzbJYc=:9soh8nI30jYGKM05hf7XyN
 m/r+JQsgxctqenHp+TmrU714PRqNPimj05h4sSnYbBcjsmY/v6gOOKPK38zL0akQSuy4xyu3V
 OFhLuep4/Dw5uM0VB48AY0dMtv1N8rqyFqPsZLRX+LacIlDOoEPRNv7PUuWf2heLmPB79lNGY
 bz7SnLfMULpCY/z+3eaWXlMKVuUh8+F0wTsn3B+JJLXVW3bwNWcwbBVnrLrNh9KnWB7ICNEoT
 vO/vWT7ZH4kOrzPYDkkHjwa+X8dbenMGE58I3gJzUgRW1arAB81ePP6S11L1zCCLihl+SHWao
 HsBeoUsAUJVxfEJtG7Wz5zEeIM6eMFwm/xfZFIUQzPJxpasPFwn7XQAlTvce+4z0KgPH0aeKm
 yvbGDH1/qM+dakacIdU4O95MONc53RaEO6B0iS1UV5c8v5E4u0xCL+VjjIxKhKb+N+hykZ20T
 swWjMn0n/UjR91kPwSXsdJ7MO1FnDx7nJDLU9xt2nHR6/W4U3c3pbmCx51W0V0LCvjeGH8DIj
 ba3SNotQz3TFS3BS+Iy8vr6FskWUxLoRxFZI2h9MfQuSf+CigcJ+3G+ocSkGTKjWFTiDalFhD
 b1zTsthUIjL8SnlOIKvAAp67Blf7gM06UkwLeWng4gbQIQKaaoHrRJE2kiLFccR4ZG+6aTFU0
 1rQRdj1KGgkUIWuB6U3BHtLnNCgwOg1/0cEGAichOvWh5JLlnRKO5xB07DVbJf8H6zP1o41C/
 BlUyUosp4KQKc1qsSsd1Nr0Hgxliww3IiQWfLQRyWzrmJUetWDT4WurzzkpgFZj8MpPFOJx/t
 Z4Iwq+dwiEX45n/RSOptZxcAH++vlbS3cL7qfhu0xl/ahAuD4zLge+emiMixGcSma+KW6mVxg
 86Z9hExvlZy0/mLuaXOWQgO/ZAK6eqDJQXeP0u9yI0shEdWaN0KaztkGWVo3pCEszD56wePfn
 d9ePMOTpH6cUguqYI9dbfNnxqZAy1nGpm/AR4byFgzHn94LYXjjSF43UIQfcppAChht4YyLDc
 uss8v9OTJJVSAHLSpFa1+PP3Hri2hpEUPdbEGuHMJY6cWWhE6PcprwH0QR8VdJG1ov/SLAFoE
 D8P6O4Pm7to2vk=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/26 08:13, Qu Wenruo wrote:
>
>
> On 2022/3/25 22:58, Sweet Tea Dorminy wrote:
>>
>>
>> On 3/25/22 06:53, Qu Wenruo wrote:
>>>
>>>
>>> On 2022/3/25 18:27, Christoph Hellwig wrote:
>>>> I'd suggest to at least submit all I/O in parallel.=C2=A0 Just put
>>>> a structure with an atomic_t and completion on the stack.=C2=A0 Start=
 with
>>>> a recount of one, inc for each submit, and then dec after all
>>>> submissions and for each completion and only wake on the final dec.
>>>> That will make sure there is only one wait instead of one per copy.
>>>>
>>>> Extra benefits for also doing this for all sectors, but that might be
>>>> a little more work.
>>>
>>> Exactly the same plan B in my head.
>>>
>>> A small problem is related to how to record all these corrupted sector=
s.
>>>
>>> Using a on-stack bitmap would be the best, and it's feasible for x86_6=
4
>>> at least.
>>> (256 bvecs =3D 256x4K pages =3D 256 sectors =3D 256bits).
>>>
>>> But not that sure for larger page size.
>>> As the same 256 bvecs can go 256x64K pages =3D 256 * 16 sectors, way t=
oo
>>> large for on-stack bitmap.
>> I'm not understanding the reason why each bvec can only have one page..=
.
>> as far as I know, a bvec could have any number of contiguous pages,
>> making it infeasible for x86_64 too, but maybe I'm missing some
>> constraint in their construction to make it one-to-one.
>
> Btrfs doesn't utilize that multi-page bvec at all.

All my bad.

Thanks for your hint on this, the more correct term is, btrfs always
iterate the bvec using single page helper, bio_for_each_segment_all().

Thus even if the bvec has multiple pages in it, we still treat it as
single page using bvec_iter.

And yes, that would make on-stack bitmap even less feasible on x86_64.

Thanks,
Qu

>
> So still one bvec one page.
>
> Thanks,
> Qu
>
>>>
>>>
>>> If we go list, we need extra memory allocation, which can be feasible
>>> but less simple.
>>>
>>> Let's see how the simplest way go, if not that good, we still have a
>>> plan B.
>>>
>>> Thanks,
>>> Qu
