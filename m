Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB36CAE175
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2019 01:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389897AbfIIXW2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Sep 2019 19:22:28 -0400
Received: from mout.gmx.net ([212.227.17.21]:57705 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389827AbfIIXW2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Sep 2019 19:22:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568071342;
        bh=arUJvIcKnIwsa0Pcg0Yii1f1unOqGWehmk05O+wMf9E=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=BHNcvX8/1N/WC3M2ztM7N9fp6+86x2KwbtT+I0Up2i35eQF0z7kolwbpybsf7JVtn
         lmIMz09daMvDXDKbmC9bFHZSCoep1zDPgIYcWJgA7v8bnWEZ4S1PsegfkyI0ZTvOpS
         W3xxa0717noEoaH5AWkmwFtgIg+23O0s9WM87Kz8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx102
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0Ls7MZ-1iGu9K0moJ-013x2k; Tue, 10
 Sep 2019 01:22:21 +0200
Subject: Re: [PATCH v2 6/6] btrfs-progs: tests/fsck: Add new images for inode
 mode repair functionality
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190905075800.1633-1-wqu@suse.com>
 <20190905075800.1633-7-wqu@suse.com>
 <9c772db6-74e2-6760-54bc-18b09294dc30@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <b72730b8-b658-51ee-3d4d-3b2aec7be8d8@gmx.com>
Date:   Tue, 10 Sep 2019 07:22:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <9c772db6-74e2-6760-54bc-18b09294dc30@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2BmlQyVrbTnArGvI45Dl/MFFmnko5/7epAiylqrQH5q9axwbTX9
 fk1vw346/uQG4naTS52gByCQEw2qrLqPcXok6RXhqmvgUcs7YDHbZmtLtwx9vMVihJbRRpb
 SuKcLvqSKxVXEPreKB5G/KMEmMSSiUKlNVqbbnKCitipnU9UYHyp5EkSHEiizcrfePD8Ycs
 un4DYsHSb2lzyJawyEl1A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:XW5Y+GxclXY=:XkOfP6+tVfiG6J3NNIs5BH
 wbLbqHzX/8CGYx0Gq2m97nzep41FT6R88Uz7LJSXs5rwOV4SQ+Ww4G4TZcm6qTMLu6gV6ZvxK
 XDVCTvGfpKu+B0qQ/jdfczatC6Vvk2oyVAFCJKKB5eM7JSBvJDc+6sq4CKfk1R0e/JOmpZn5A
 zki14hOlh5XX2Oeex8s+H3moBqpS5/0F22tS/ey3H1F+KBhdLjPr8SQIBt6BaGkTrXv63Y4ww
 6DDlRgF/ShyUH/AnIFcNXe/4f9j7/42QcDdpA3Foc/T7mBuS+rcFSFGoIvIeS2gKBptmR0jVZ
 TTcPmItCIFLRg33sbIT1kq55ku4/Ox2wQNmaeOej+/mFC6l7AM3BZAmEqSHtkFs2LGOtHaOHl
 GvBAd+PdiIwFfwhcx38ZVZWYZn0Xa8Tv69srJYwo/EY7po6Z1Nzge4OXbhQMo/AvTxd/OClj1
 HctLWax3IJ5j+NM05O1sOaOvo5XZ9dRswPBcvgICbsnXZ1lvgwPrSIQ/CdexRuTCMRFPliUe+
 2IJw5jD0mU+B7jAEp/9B4a5dUth+QRfX7E/LZvt6s7Sr8zgQoGkUcodCZw469PQNIp4XFFBdg
 QL2xeJOKxPSFohiAYiabvEXKvh5g5EqPXZCXQP1DFQ5bM/R/LxSFR1ddFrKZWQ2ZzggsQUxOA
 fKtNb6uHBlDQ7KzHmZACFJG9MQxfNvXHvrbaS0SXrLaW0QjMtXSRlSBbDZwTnjVjCb0YI3yn7
 1V14CDcgl2eOjXKMkaK9w96kW6PY08WPW62+2pKEGA7yDmhjUWhxxPPldM3B+IqOHgjn98J8E
 mHalWlMcPBn8Jvj7cPYABwvB0UsbvzV/lIgPgdxPTw+c2NYiL0O3uj/Q3/Yp2zdnN6fbnJVql
 n3kdSNJf6eGydidPSThhk//WvIL9/TfFFsYQH/dskIR2YXdH5s8gJYWsr0nAyYadyb09U2XHz
 uTTUwlBdBAKA/L6tOQN7HI02mdPibtT6NlNnHlBiHedq8zHOybCKpPE0Fx+OURhkQOAz+v0DH
 cFU372jFx311KIttPMVpTIyDetHItDs9hKFj5jtARzO4FoINazqAV7M5X9Z+/XOyWHGxeItjT
 5N4oZW5mab5bLmukMjrwzvGOp0iGvIItv8R6SyPFVWtLoh5xxgZL6RZRoSzzivTBrC5vdxZ8b
 LR0mcPUIqdlijmD+tj11DfEn/wO3OVpD/55H9ZzHGU78oUtRWLyfHc2zT01z3+7I+O6r65qzd
 myvvHEcoLyUiFA0qt
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/9/9 =E4=B8=8B=E5=8D=8811:37, Nikolay Borisov wrote:
>
>
> On 5.09.19 =D0=B3. 10:58 =D1=87., Qu Wenruo wrote:
>> Add new test image for imode repair in subvolume trees.
>>
>> Also rename the existing test case 039-bad-free-space-cache-inode-mode
>> to 039-bad-inode-mode, since now we can fix all bad imode.
>>
>> And add the beacon file for lowmem test.
>>
>
> What kind of corruption does the image have?

Just bad imode, all 0.

> Ideally it should have
> cases where both DIR_ITEM and DIR_INDEX is used. As well as DIR_ITEM
> containing collisions.

Yes, that's the best case, but in that case, we will have more failure
modes, e.g. we need to repair that missing DIR_ITEM before we use
DIR_INDEX to regenerate the filetype.

So I'm just sticking to one test image for one corruption.

Thanks,
Qu

>
> <split>
>
