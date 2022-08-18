Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A094B597EAD
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Aug 2022 08:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243692AbiHRGcn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Aug 2022 02:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbiHRGcm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Aug 2022 02:32:42 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B88BA99F3
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 23:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660804351;
        bh=c4E2ugWo8rp8uefiVhLifwuNyXbquOwIu4WRW3heybA=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=RY8ENFsOiYHj5YG9dIGT+whNZqwTl61vP7yOEsLI6afqLpBVNfEGOrOc+wCJw/Gem
         bC5/NN/DKLAuG1qKby7gy45tG/VJGNOo+RAerMMRuEp0vTWYs9yo8NjE1nHUexsSA4
         kz8XMLqzr7+yrbffuA2eESCX1yQ0B/Jkr+jxzYzk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MZTqg-1ntA8u1CUA-00WW8O; Thu, 18
 Aug 2022 08:32:31 +0200
Message-ID: <ed38f48f-0dbf-84f7-4fc0-1a50980b0f63@gmx.com>
Date:   Thu, 18 Aug 2022 14:32:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v6 1/4] btrfs: store chunk size in space-info struct.
Content-Language: en-US
To:     dsterba@suse.cz, Wang Yugui <wangyugui@e16-tech.com>,
        Stefan Roesch <shr@fb.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20211203220445.2312182-1-shr@fb.com>
 <20211203220445.2312182-2-shr@fb.com>
 <20220723074936.30FD.409509F4@e16-tech.com>
 <20220725134149.GY13489@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220725134149.GY13489@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ts8I6rCJIjijZ9Io4hEfRYgSq5Id1gkYuDLshbqhOU/OrmnlFYj
 CDoL8fmSlwuJuTLg5JkZUpgjgdkvnyAGxCTT64FC3TWAnlL2ILHCpx1xw8wv6nNOjrEJX/n
 52McFIMcHK2KQJQWKDu/kWfElURqAqB74Wa8c75FcP7dTMFU7f3Ysyo8SQ9zgbjFBd2VvQA
 +FZx6dxUy25CRMcTbooYA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y0CmHpHY3tc=:D6KvbPQOHuw85+BLae9D9I
 q5unyQiE4Lxsry+0mSCJ7Poif7N5RkSBXl2Vk7NmTKAKAUW3TUR85CFz9MVuH+lsEQzkYJo2Z
 boxYukFZLSt9+/9Q+1ofaG4FaC7jPmVwxh89j+trVeu/ssGbPMYjtdQftt0nArJCsorAQ2ls3
 l5+geFBqZkkmgSbSLG6UytA5ON1nExC8bdSguo0JsI173YO0ElcZ78mFsw/he0wxB+yzzfg6Z
 ShUdIaW20WN2uh9WH0mBOiBGjX3O/SzJmQUS+/DTzMXwMu6dxivgnVyXSEfx9u/fFhil1MRM1
 yHWyl/WvEhtBU43O4bI9mPEs1dvIVtrQQ2gitc5pxhpkJel/kt/ltdCQLmii6/R5qS1cvZe8n
 f50nc9xIxD+2Go0hEOlzkV8XofF1786ff6N1wERxFffBABi6mHaJxsgeLxjsbac8W7pcqu0of
 M6xdv6qCYgcPp17mX5vxNccI3vmtAflnOF5nv+ImbxiK3arpiF/Bg8qDSvRV/HQFnAzWrxPGu
 pU6Fx30RYK22o2TcFcoUcit5Dp/ZlJwKu9xXFq0h83vdWRnCqO76weq5PukvIqF50j41tRHbw
 UJRrl1lGfHJ4LLGA/SZoBHWKd+LLkrY9HCOTJgoPOm/LhpTCF0R7WhsJevArYwmHT76QsjS1H
 QAfsw+z+i9PETJJWxtSgXGCl5NlMF1UzHsxgZJT8XpGCCsr70B0FzE37KCTaIkvSQ1dwCIiVa
 xBFLnehD5dVoSI3+o8Ap6sE4NiW11jmXojtvcvIGmiE9WvXj7FFjWgWC4eqG1RmT3rFli9nRi
 HSDdE1/VYwxiU0MXjut4Ad67qpKermXjtwxDvroYFcd+nmzZg95kuiPN2cP47+UQOGFoH97dI
 xh4aeX/hfhnjs241jY2EjbLJq1hgMRXMDmbrbFnJWnU2W0g3udnXIlyMGvdKvgmgN4j5dYL+e
 MkXhwR4GHdjQQx+Y0IkPh9ccCFxx1hDkq0gAPJY4jMuSumKg9qbkPgm0TQ/2tboelO1DzK/K6
 z9DUuw2nd/bWd+D8Waf6SF6xsKaQoVn5AJ8Bt7Hl6QoLZVkyHKxkh2b0YNtt4U9f+8Za5E+9K
 azNtXZoN7uV4yHqLBGhq7NhBlLm6nCT89zmCVd/Ksu569MmLItxi2IgtA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/25 21:41, David Sterba wrote:
> On Sat, Jul 23, 2022 at 07:49:37AM +0800, Wang Yugui wrote:
>> Hi,
>>
>> In this patch, the max chunk size is changed from
>> BTRFS_MAX_DATA_CHUNK_SIZE(10G) to SZ_1G without any comment ?
>
> The patch hasn't been merged, the change from 1G to 10G without proper
> evaluation won't happen. The sysfs knob is available for users who want
> to test it or know that the non-default value works in their
> environment.

Nope, this is already in torvalds master branch.

Furthermore, this patch now completely limits all data chunk size to 1G,
previously it can be 10G (but stripe size is still limited to 1G).

Now for any RAID0/10 based profiles, it's completely off.

For RAID0 we have at least one time more chunks, and the more device we
have the more chunks we have.

Such big behavior change is not really properly reviewed at all.

Thanks,
Qu
