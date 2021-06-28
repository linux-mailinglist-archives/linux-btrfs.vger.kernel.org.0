Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B475B3B5B95
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jun 2021 11:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbhF1JuD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Jun 2021 05:50:03 -0400
Received: from mout.gmx.net ([212.227.17.22]:47493 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232488AbhF1JuC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Jun 2021 05:50:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1624873485;
        bh=GF7wZeqA8nJErdEy4vvl9wmI6UaDyuQ7iOxvjLe4hm4=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=IPxOfZTQHqOsHLZtKINBxwbjRDH2c3Kq22/PuqVdNxT2X0c7pDvJinZM7gwv4jtdo
         YUu0Qv/EiBY1mGcTceVHCj5pv+tIf8fhqa9aPkxuZi3O9k6gd36QRAE+Qn739g+IZt
         PvXs36uiE06WHI9YpqR/+abTiskzh/eYu6ZSy3HQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mqb1c-1lSsvd0BZA-00mZiE; Mon, 28
 Jun 2021 11:44:45 +0200
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "13145886936@163.com" <13145886936@163.com>,
        "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        gushengxian <gushengxian@yulong.com>
References: <20210628083050.5302-1-13145886936@163.com>
 <ee06042f-da1a-9137-dda3-b8f14bf1b79a@gmx.com>
 <DM6PR04MB7081A02339DB3ACC72F86261E7039@DM6PR04MB7081.namprd04.prod.outlook.com>
 <PH0PR04MB7416F1BC157F848540DF37389B039@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs: remove unneeded variable: "ret"
Message-ID: <e73fd408-d5c3-0e17-b3f4-e12f2c105bc0@gmx.com>
Date:   Mon, 28 Jun 2021 17:44:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <PH0PR04MB7416F1BC157F848540DF37389B039@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6+iUWNTrRF1HVwy7gL0p2R1loy4yX+uCGeTGnZF27Admo+6isWi
 L93KS/khzE2FL82cGc0aVcQus53hKREHLphA5l/szapG9mAblkcDZvlIlqHglNOasV1tQe8
 VqcY6bScYc6yMWNt1dRIV79BxdBFAABPSpBv4WIdCf2d2+tPsPAqr/xxM+4A0t00pu9ONh0
 wiAY+jkEl/znDL3fOgJoA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4A1pO8hqPdc=:zV71KNuyZpFjYkkSXs7EGs
 N3Q9awGagvQkb/qhABYIakZiPZEEm30n00fAtK8jPzxpOYKDZ8njIKqISRMP7Vka6nTRtbJ2O
 oWvm7kMXfT0rZGwHmiMgcskdfb3KNyKDfKKThXkJAfpneJ10w5MK7IO+/qSc2ovZJqeTXpF1y
 B0cc2PBorFUUkTCwe5oyPOWs17qftNIIML+yo06rgNIGdScpMyy7nSAOSMdDF3UAx1sKkTTIA
 /bOBj5X2qjZc8Q+Czuj8JyzmWWqYurU96T1dUcj0CLEkdZ7/LCfTuJVH0sudg0iRK7EKEpLAu
 Kbtlb2gvM0VACqeiGHkMrljeTzKuk0tJEG8iZKM3vYjxtPghQQ+Ssu6U6dl7CyrBsGGBVh33t
 jYF+x61mMqEHVGozPvO325HpyW3Dm+y9rd7mDEmZLowxB7foYlqqxROLIVosmEFIJDRcSsPk2
 DVmxJIBYr2VywuAE3amlmV7aLbt8rVf5WKdsNeCk2kYvTKCRextaUN78Jo+IixgVarFJe+UQx
 LMvCrMkFAq7aiQZD7NLkDpXN17iZGz/HgqhvfJRLHYNloNtVaTlYJ43QEcWfIDzeHi6xXTcz/
 8SRnVryw6U1iIPwaHxrxqXrd/MP59a01hNkmLvvoGPPeBt4Fuk0ZeiVjw/Ehm8TazdPRzk3sX
 AlTyA9J+lWbRkN8OGwEz9bnlmZ8KtXYAWPmeyv99hJtEP+3T+3XquGBztGaddvmt1p2swjcpv
 T4/O5OMwH9+M5WLcjBRB7Lx4BW8b/EFspsaP5mFRgsO1GHUKsIqmPx0R0ffRgj/fsKXe40be3
 umUBwpR7tuS50sc2DYX9ZY84pQZhJY+U66zbypkbmgTEQBCeDyeMDEoFrKwRNALMTOOTit7qR
 6vrYKrqWFK5HUf8zrgYRk1Jswy60Cx+caF1mYOyOHSG9kl1KlYWBs+Us+XE9eTa2h/HmmYVkC
 J4yrXIWVB2w37zYgkQmKXhlhB1Ur/9nKuml/z0eBG4uMwVt31nPQROFcy7FDqytdPh9sTN+lm
 Z1grQJuc62pxzLtH6IVJKhKfkXiLphjltHVbTNdFfBbwInno1cwVP05Oe2ETyl922fVqoQzZE
 Xws3Uj2aS9k2pPREJX9rwPUKxOO+09v/Ja1zKvGuyFloUqfmm7S5G2vbg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/28 =E4=B8=8B=E5=8D=885:38, Johannes Thumshirn wrote:
> On 28/06/2021 11:34, Damien Le Moal wrote:
>> On 2021/06/28 18:22, Qu Wenruo wrote:
>>>
>>>
>>> On 2021/6/28 =E4=B8=8B=E5=8D=884:30, 13145886936@163.com wrote:
>>>> From: gushengxian <gushengxian@yulong.com>
>>>>
>>>> Remove unneeded variable: "ret".
>>>>
>>>> Signed-off-by: gushengxian <13145886936@163.com>
>>>> Signed-off-by: gushengxian <gushengxian@yulong.com>
>>>
>>> Is this detected by some script?
>>>
>>> Mind to share the script and run it against the whole btrfs code base?
>>
>> make M=3Dfs/btrfs W=3D1
>>
>> should work.
>>
>> With gcc, unused variable warnings show up only with W=3D1. clang is di=
fferent I
>> think.
>
> Nope doesn't work here, as the variable is actually used (but not needed=
 at all).
>
> make M=3Dfs/btrfs W=3D1 just prints some warnings about improper kernel-=
doc formatting.
>

Yeah, that's why I'm asking for the script, which could be way more
valuable than all these small fixes.

And, again a Chinese company doing the same tons of small fixes...
So nothing could change their behaviors, no matter whatever...

Thanks,
Qu
