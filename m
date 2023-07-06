Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23D1749605
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jul 2023 09:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbjGFHHU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jul 2023 03:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233511AbjGFHHS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Jul 2023 03:07:18 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64E11732
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Jul 2023 00:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1688627228; x=1689232028; i=quwenruo.btrfs@gmx.com;
 bh=1hKteCVdGVtrDntB3mKq0OQKQNzIf4gRIAKpMTgwJ6U=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=XITLdigNzuK/ngq0Do1wxg2GssksMqthhwFQ8leGSmR78uInyh3MZeeWXP3O69SYxuHqav4
 hrzTxXhu+Hji6g8TCWFeepnmAPq3YHTywhDc6EC//U1e/80UVtIw6XGyCXefD75WgaGeNFWhp
 lqiXo1rYNvSq299pNSPFiNveZ1cGKIEP5m/e5/M5UKNeWCf7ZHnbG9Da+QplKldDFryu5HSIN
 HWuUCewKOnTyyYLcsbHttc0euCCkXKZ5NGKwukfBWBoLojWIG06GYpxlmPOjlePZIPecVc0Xw
 1e8HwMpqfLh99I7SRe6iSOklEeHVDIhBoyNQzLhdClrTgjMJi1PQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MdNcG-1piFNU0Jc0-00ZOSL; Thu, 06
 Jul 2023 09:07:08 +0200
Message-ID: <5e5941b0-bd9e-e64a-251b-0e90688378d6@gmx.com>
Date:   Thu, 6 Jul 2023 15:07:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: question to btrfs scrub
Content-Language: en-US
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>,
        Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <PR3PR04MB734055F52AB54D94193FA79CD625A@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <8a3d7ad6-0ddb-3160-eece-8d6228b9c0a6@gmx.com>
 <PR3PR04MB7340BD6CD63180053CCA023ED62AA@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <3d208b62-efc2-afe4-e928-986dc4c53936@gmx.com>
 <PR3PR04MB7340ACCB059FA7C9A22052DBD62EA@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <e4237dc0-2bdc-a8b3-9db5-6b0e24b7b513@suse.com>
 <PR3PR04MB7340B6C8F2191ED355D1232BD62FA@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <80136f6f-0575-58e8-ea8d-7053c8af4db0@suse.com>
 <PR3PR04MB734063CF2AEA3709D3AFD9A5D62FA@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <11a9ec6a-7469-fdba-4375-c24e8ea5f7fb@gmx.com>
 <CAA91j0VjUiXZJi=S2h7uox8sL3B84yNSw+9SLiL0AxntO3TDDQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAA91j0VjUiXZJi=S2h7uox8sL3B84yNSw+9SLiL0AxntO3TDDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FlbwfgX00+xqj+Cg5xGGLDDWDvwgsjxJwKJfOY9vyrVAkDAOF/2
 bbkZDB7nkl9FpCmAKIPze0TJ0aHba6u0XoCFkBtEonnvvnIlTxSPKiSONURdH5sd6ZdcUES
 LtmvSLvnRG0ozZ5t+SFr4UKYO1r/t48hyrGftKFvq70JZVXuh9E8onRtqDtfZz3wcZYVubS
 wmO/dpj8UWpy8s5oYx3eg==
UI-OutboundReport: notjunk:1;M01:P0:fZhJAX2Xs4Q=;WXpVf3hSiZ5TXSTfMNpBB0k3RJs
 1BlzwQfL69Yqf9PVS9OJsuDTvzZZxUBp6swj1MfMnRH34eV2oQmaTpNWJrTC8cMzAOaYj9h6v
 uJQGm1L2og+cE/0ft0LAEJCipyveuGMlalJQFuvIp/M3VVybeuHogTANTggkseK9N9bi+2tnC
 NLg9PfGvSQXmf5MGXEIgcGBxjxScKRwzjsgGYP+qFaDoz67f7gPfQOxP9K5D1FQmIiVp1PpuW
 wmWSuMiob2GWWjJoklmzm0yaSp94QVexW3buErmo37HzeMZU25w7wL1mDSBg05TtDQh+utHTu
 EVCNd1Jh19UxdhMnWsDHC9Zz6XwV/LV4Akf9fgHRmMfAZR1BSQUterPVGRL7gSrA2D9ShCAW2
 J/yIHKx523zu+S+xA3a6PAZmhy+o9uxoZVZTHtuqDQwC8AdehYibQKZ3jf+vyfIgDDTG98A3E
 5E0YPVeRBc7hFuWjcmD493M8yzToVmhF9M0lGlwwDWXumNEVOi6plM0swQBupOJypuzAOAEXw
 3pPDuYjgM0Zw5GKU4ckaNh8zjrh37zwHV1Xr6XxkNR4YTZHQSjIJ2mOuYIpztavUg+OUz1Fp/
 9xuBjF+4Ny8jyN3o/X8gVafi5jl9N1r3mmHayxN0eGeCHbhsx9j1c9migT6+62lA0Cj7NCiOn
 espZ8mjo4vhGxDLKA35H8HfBtdtLk7P8LlPt7uVpxfbEl7z43E1FwGDGlyrAYSTEsmT4Q2NZD
 SVMrKx/4uwnpfWOGWQQXqwLxHSAclgm8YlL0yHH2pM2Mcm0m5KUQ9rZkysdPNwtKROFnp8VbI
 XQuI9zpGwMCIfHRqvkCNc1e1D7Jq/hKKQxqZHUJU3urszxoQ7jQHKG8ueOHLRpg7Y7k50lw72
 lwu3LM433Gedj9QErQx9Yp9CVdgHsAtKuzfwc4SQxluJn6auiVUH1Vc1bHKOL73h+i+Saj1uA
 jv52zPtQr3Ia5egVGY6IRno00SU=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/6 15:04, Andrei Borzenkov wrote:
> On Thu, Jul 6, 2023 at 9:22=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com=
> wrote:
>>
>> In your case, since you're already using LVM, thus I believe the fs is
>> using default profiles (DUP for meta, SINGLE for data), thus there woul=
d
>> be no extra copy to recover from.
>>
>> So there is really error detection functionality lost if go nodatasum.
>>
>
> You probably mean, "error *correction*".

Oh, my bad, it's indeed error *correction*.

Thanks,
Qu

> Error detection will
> certainly be lost. And error detection is certainly useful to detect
> data corruption (that is not usually possible using traditional
> filesystems). Yes, it will not be possible to correct these errors on
> btrfs level without redundancy.
