Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4D4575D3A
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Jul 2022 10:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiGOIRB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Jul 2022 04:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbiGOIRA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Jul 2022 04:17:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6577E839
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jul 2022 01:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657873012;
        bh=5BbWk1f9EndT1b6SNx94w/lxVmKANqIPuQl2u/Rf6Ok=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=f0xORvGaOcM/cVQJsOPNTBcp+UuEboQ2aJUCEEGRQy0oHKDpDhoNNDMkjMNMwZWCx
         JlJuy85EuWlpyvcowmAnMKNX6JbSeE705k/b/x8L8RkXGvVaAO/krPSkHNm849aTHQ
         IvQYaaCrip/pMH1qN52CFrJAwOBt9achK7VvxpsE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MRCOK-1nrSMR3f7M-00N8U1; Fri, 15
 Jul 2022 10:16:52 +0200
Message-ID: <2c0d5fa5-a2e2-25c7-9687-cfb12ab177a4@gmx.com>
Date:   Fri, 15 Jul 2022 16:16:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/4] btrfs: make DUMP_BLOCK_RSV() to have better output
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1657867842.git.wqu@suse.com>
 <d0096ee10270e00362471c7a842aeefed20806c5.1657867842.git.wqu@suse.com>
 <PH0PR04MB7416789E6373C3685094D8009B8B9@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <PH0PR04MB7416789E6373C3685094D8009B8B9@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZvwdmGO+CP0DBe5ExtpsuZnYwqbdkgpzJocR2/UkygFxULr6dcM
 dKr823U7evdAX/0S9m/BMOv+2FA+bnWca+hSnNLyKgSjfhUkmeDVEEYCgNZvUMXPU72krNU
 uQpCZsz3M4q1Rb+yMd3wHKA32n5h2+Zm7fQBXDugS5zfVt6SubG0u6oNUYRU/VNG4imS74t
 CuKGGKn5nkzFh2EBQNnTg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hK96td77f3M=:opOo73aBiZ/yPpesv32t/v
 D3fdhPMuuQta77gJmbLEQIvxPO2NaeSpCryO5rHWgxzaJKv3Ulk+TLaP7NdbrTsl6aWfsHWq4
 2pdNRMP4gQPAfJiYGmEiyW4DfusIGjtqEjDeRIMNxe/bGq4A9GIPCeB2RPbGepVVMEfWd7VmK
 u191quL1kHfNJSPEVHsQ4ePLVT7/yuHiqGx/6Mi8ppECjN1kief8Pf3+htfAtpN9WWRYn4iCF
 VxObDP5FI0gO0SzZTY3i0rRIOL74QxBtaD/Apg/UNJpHIulfpi36IlVtPSYv2SoajsHVFMBxE
 hSbfFRibosoOj8R9vvwdYohAvznWxNuNdkr5Nx6Xy3EZYmn7bYgGkcC7ArkbpMWMNXJ4ar4UM
 YDSZj7+U8BEJauEVRJj+62M1NT12YYIQboR+udnUzDNSkQ/HeDtJYaLqR8G64Q8KCYjjfnlY8
 90MuoBmNId+WDjmvTq5yiuIwvYQ+91+5LgL6kYiw/GUb1x+rFvTdsiqc9XMIKR4Z4Nx8jmkPH
 oPDHdyvwcXJR8PvOBvcOKFcf99pNgS9ysVh+j4d5tIJrnHw7AYt0AiRRUuIVUrsSiaza3MQzk
 z4w40b3KcK70AIei3hPhmyOI6D/cIZW1w+BUvIpqzu7TH28ZofjKaMOcplgnH5PCFWLMWAP1N
 uFP1KEyTrVOt5NsAR2Tnnq4gFdM23zup0VQeVvZ6cLZ52mHmOmzQSzM5QYvnVzmZ5wD0iQaxG
 DyqZ4bKl5pm4kj+xnjPQF8l8UPIyqz/AUQNgCcakDesWKVR57Ay8SuA73RF7Xtjx0PR64H+gg
 G7QlqGCTWg/qh7tknUaznKtOZF03jwxZPGzmTfbsaTiHlJKnxbV8ZnjGCXjEXUqgg3hZ9dQFc
 bNK1goVD+a6hsIO51NCSZdPpRhf6fRGQVB10svI43wj5ibNAV4+LxdaKfRIhdr1WMfAUrufTw
 IFc4V+dHxmURid8qWLzVYAx03kR7qKJl1l4oIkciCn74+sMgSVqnWvhfMSXoOmNQumqv0yH7f
 +hRygaFIxBe04408x+2MfATxRxmfh8APtO5e7JETSPwi8RpiwbdaxBAZSOvsY9n9s1EKHb9Gt
 0laV/1MPLNy7CkdJkjaVhRG7jJifrVkhosODX7yVb1LJdCU6dAZSgSzjFRbTnN4YiaH6Jp2oI
 RT5F0EvBMsczJ/5jMvcmbZ0hBMrm1KcVPZ4ZRXByjGBys7QKu4JBL5BRBqIEmUfQIEsN4=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/15 16:14, Johannes Thumshirn wrote:
> On 15.07.22 08:58, Qu Wenruo wrote:
>> - Skip "size" and "reserved" output
>>    Just output the numbers directly
>>
>> Before:
>>
>>    BTRFS info (device dm-1: state A): global_block_rsv: size 3670016 re=
served 3653632
>>    BTRFS info (device dm-1: state A): trans_block_rsv: size 0 reserved =
0
>>    BTRFS info (device dm-1: state A): chunk_block_rsv: size 0 reserved =
0
>>    BTRFS info (device dm-1: state A): delayed_block_rsv: size 0 reserve=
d 0
>>    BTRFS info (device dm-1: state A): delayed_refs_rsv: size 524288 res=
erved 360448
>>
>> After:
>>
>>   BTRFS info (device dm-1: state A): global:          (3670016/3670016)
>>   BTRFS info (device dm-1: state A): trans:           (0/0)
>>   BTRFS info (device dm-1: state A): chunk:           (0/0)
>>   BTRFS info (device dm-1: state A): delayed_inode:   (0/0)
>>   BTRFS info (device dm-1: state A): delayed_refs:    (524288/524288)
>
> Pure personal preference, but I find it a tad bit easier to have size an=
d
> reserved printed. So you don't have to look up the code when you encount=
er
> the error.
>
> Maybe:
> BTRFS info (device dm-1: state A): global:          size:3670016,res:367=
0016
>
> But in the end of the day it doesn't matter I guess.

The reason here is I want to avoid size/res affecting the number output.

But your concern is also valid.

What about a new line before everything, showing something like:
Dumping global metadata reservations (reserved/size) :

So that with that line, we know what is reserved and what is size?

Thanks,
Qu
