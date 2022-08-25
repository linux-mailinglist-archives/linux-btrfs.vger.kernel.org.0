Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFDD5A0BA0
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Aug 2022 10:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbiHYIg2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Aug 2022 04:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiHYIg0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Aug 2022 04:36:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C20A3D76
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Aug 2022 01:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661416580;
        bh=cX3Zif6jRJU6oiALQcLTJxKx2XkzlTRn6kVjX5v3Q8E=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=iYgaS7nwv9WzjIX661aW6dNd8OUuT2+qN06ltyULXz2dKUyCStlrzYjnTRLDRDUcB
         j8FCT7EuFFV3TaOcKoUnCxBpIheeVX3Fw/OPJ7DtFEFaxnMNie3Aw/I1TjvW/wFMkV
         6JYZLUnZ5fHalMagT7cqWAt1haf4goemc/f+Iz7k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mk0Ne-1pBRT10Tc0-00kLlg; Thu, 25
 Aug 2022 10:36:19 +0200
Message-ID: <1ff7ddcb-0a95-d023-d346-e86cc6195afd@gmx.com>
Date:   Thu, 25 Aug 2022 16:36:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] Make btrfs_prepare_device parallel during mkfs.btrfs
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Li Zhang <zhanglikernel@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <1661357103-22735-1-git-send-email-zhanglikernel@gmail.com>
 <c3dc352c-8393-c564-4366-42fb9ece021e@gmx.com>
 <PH0PR04MB7416B660C501F73F47E7D4159B729@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <PH0PR04MB7416B660C501F73F47E7D4159B729@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ezAstNpIj77J56+aeWdj8WlvwgrP8cMc5UnsQhOo6S/DjunTJiG
 wVnnAir5mYdLF/Gxe30Sj8AeRYAbygB2XingvOfvYit1H+GwfEDqZophbEXqITd5qcvOcl7
 zLOmUYk09W1WrH7xdgOtvC8IF56f4SPhZyrPecXOuzFqfhHwwG/MSLn2CtDnWPQS5VvM2NX
 OV8b6oi7YMBet34lJOOfw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zwSCaFf1odU=:a5dLCtAu3B2hMQavscuDR1
 icXZdZLw51AnEqi3UR0ipnjOaa7k1ukZVHyIVbRFVF0dNs4qBVSv5whz5/aUk6BTolQbQfHD5
 ZoehChjmE3gjyY9GgRDUdjkZ1ON1BsPrhfv6yHB3uPu0Lp6yd3p1lvWWs+IkWCCMpBczXaOVb
 Ybwv03E8Kn5Kg25keMzgFXnW3UGFJAIcAjSok9CRsIhWAStbk0vpX0O2VqtLstKiAWRaKVYS9
 vyD47iNmBL3ObhP1HYQLiL5I9ci/mGEgQDWx2dEMnvrTArVpFLRYXLjZOOHYvhJIUe1MGfeW7
 8uhkbGqWmZAODXJmuoArwKe5AqA8CZPNBnWW7h4UixcJJSy2WVCqv+hspPL8RmvZut+gQxAR6
 V9PZBFAI+UvYV/pVwYpKDIwfVb9wBvedq0sE1S1UPwC+ts0VzLpDbHPJ3JPD60U6csl5pan1u
 sUb3TTejbfsn0qNbuTCtb72A+P2rf3T2XwJCdiDqAnDiXLpEAsZz0T8oirroxk6k0AMaxgB3W
 64Bolzd4H2Hmi4ve4/ljM4CN2hemVU4AUW2073NyLuZHu1QEPr36orVoE5P4fkj5oGmwnY06f
 60RpTmp2m8BUL10brMRm5JKSdudwQh43GcPI3NpDslTQOVlCvKeUtw3PA9KQ2X9gLaxn6wMH2
 UlLuE2/SBN4wumoD+dXAOA4JQyDw1Vd4JuBeBhpukAGRPOL4DicZjfFcnRWajl1nllWbqpp87
 JrAJuSyquNDIsoNkpXXOQxH2+IXyw10KTIocVELiis4CJNpS9jVzPwMkyK9Pa5mkIpC3ZGQly
 l1UwRvY7qLNqXXgHIdlaq2mm0t3gPLaRZBHPNG+SXV/ybGIaIBBS2UISa4qFSpRrGeK0/65Bb
 lty0czR+cHAzb+SqG32v0S09ix/aB+UutQQxHHllgW/kxlQFAxJ5iQLE1n4vPcyT9x4nsQktD
 xJA9G6xZkYs4aKuntXaYRMBseBPM+NXACW5o9K2jaN8tz7m/Is1Bcz5FEKynC9Ax7/zX41cS3
 fMPXVprLgLckZmj/Re+z1m2BZs2j6137ZC7ESxlDCUy0D30If6xvtyrvFv3X2a+xeV7QsuPU2
 G969meStIPtJ8Qxq2TcVuZoTp/P7yKKqQ9v0/C8GTBIB8da++IEiwYkmg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/25 16:31, Johannes Thumshirn wrote:
> On 25.08.22 07:20, Qu Wenruo wrote:
>>> +			if (zoned && zoned_model(file) =3D=3D ZONED_HOST_MANAGED)
>>> +				prepare_ctx[i].oflags =3D O_RDWR | O_DIRECT;
>> Do we need to treat the initial and other devices differently?
>>
>> Can't we use the same flags for all devices?
>>
>>
>
> Yep we need to have the same flags for all devices. Otherwise only
> device 0 will be opened with O_DIRECT, in case of a host-managed one and
> the subsequent will be opened without O_DIRECT causing mkfs to fail.

Just a little curious, currently btrfs doesn't support mixed
traditional/zoned devices, right?

So that O_DIRECT for all devices are for future mixed zoned mode?

Anyway I'm completely fine if we can use the same oflags for all devices.

Thanks,
Qu
