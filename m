Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8245521550
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 May 2022 14:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241689AbiEJM2x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 May 2022 08:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241838AbiEJM2q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 May 2022 08:28:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C482A376A
        for <linux-btrfs@vger.kernel.org>; Tue, 10 May 2022 05:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652185477;
        bh=iBS5L6isDkslBVrKnofGe/s02UqJT0JovHTfDL/Lwnw=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=CdiqXPOLA70rQkKbxZPmk0p5yQWQrqo3dRLvcM2RIY8v+cqOr9A68e3J81fyemO5L
         /kb+zDjc9uIht2+BYTF1UBtSAGpTeNBf7XAG/aMPfbO4BeBs36ASxohR57udAB1PYh
         EiMEuZRGyj7BARWKUAxoK83LCYn+yV8AXd8ZqBdo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M6Udt-1ni38H1blh-006t73; Tue, 10
 May 2022 14:24:37 +0200
Message-ID: <99bde932-f9b4-5212-4dff-2748e8e0489b@gmx.com>
Date:   Tue, 10 May 2022 20:24:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] btrfs-progs: print-tree: print the checksum of header
 without tailing zeros
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <38bf1bf79e8443d570e982edb8a6b71f27cf1ab5.1652162441.git.wqu@suse.com>
 <20220510114858.GL18596@twin.jikos.cz>
 <87f809c9-3b85-4eb0-8919-a80fc68740c1@gmx.com>
 <b3bd300f-7b1c-6bef-5377-b437e947f1c1@gmx.com>
 <20220510121900.GN18596@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220510121900.GN18596@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ec8A7AJ9AE+HX5EE7OZavhdUlPMVacW/fNYn2wenfwfrLl22YTJ
 NkF+OEsu8xkfZ+DsABUnjhkfbM5/HnkqBLS0nGJW7TvFex7b1/KXygXBC6xAXMOrXmD7gIn
 mokamceiphvATI8YFAiDix1Si9t6KYhK4pATtK9YbDgqG95Xec6K6ljBlDaTsTMW8ibSfxI
 lygLASaCterI+1xhkL4Cw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7QTs02MiAfE=:DMxjTLKS5DOJGC/2jLKmVh
 RxT/k0nufbewfdWXMmkCTi0ENhvlCLr0nSbI+paLdxspCrpFP/b7UAtYe/ol1ASaQebjXDrxw
 opvF4WYUC8xoFddM1abMpqg0O0j9ZQjjJfn07MC3V5w9tdA7Ub7JyPDkitCB2C5HdqC79QNtv
 mSrsW5I/W2yOKlNrTImgYMA2vBI7ovjrtofSsPo4pA7X6mCPq2mMccXOZ6zllvdGY3r1fNhHu
 uFBrDrTb6Fs9rOn6SNksMRMMXk/zM3JUNgRG4M94GGrGbWyjo78nwQIxFC7SMajBi7MnL5cEe
 hVhgjU8lJYHvR5gaFsio0WwTWnzTNi1IMZ/CqAK+QPTnPInFNxvBsicIp0ZIs3bKrPYhtDxW4
 DEuD24c5yXaFmXABP7xQ/d2JzYwBBsSbVwmVIG5VgM5dgLYzjmccqhkPS7d1SMUlWLhcCYW3+
 yWW4NpmYrGT3nnFJ43VpQPE1MnJP/T2lpIy2bNH++yXM/r8aOv6DWHMUkCYk1NuMAhy2dZBjP
 YEfY8B8PpCaBkR/1l1B+thbJstzRnAjTrj/45Nyy4X9iIxE4BSXXB6ei4Usa89w/71e9S44QS
 ixsAyA4Gj93r8ZZkzuAGJ3kvwJlhLZNoUyqaXHxS2S1oyj5Aq99rZv9nL5YLEOk/IPbuQsh4Z
 IU+LSvXBg9PVTlFUS5lNpo7WmBpdxOHbpJ9H6stk+7NTEVz6Rnn++NXrjQSvqDJJ9HenYNF10
 LSLul6U4hdsMz65aP7T/in0UE2ftsr/htwVd+cm9n37x6dVXiqQtlIfiTTbGWLHwqAsOPLxAt
 v1BetMLaJA3LR7vSo2fU4vz/hpn15bQGLckhAtM1/fodMrpfU6fGKdnqslKTU4mfU/DBAR6KB
 DQXOOkFL2HPx/XqfPNhVaT7y97FQue/agvSxxaToy+0Bb5vQ0d9vk4gCPacqpNGwP/BCw+Ui0
 P9oNooV6dok5ChAscHZ8+jtiFjAZDyS71V+Zq8OKrsSpDb0JOka/GCU4onkriJFrEhR+pgjjC
 bu/r+1XebzIMMlNjDe8X8a4fDXy+O3yHcqt0UFlCF1VWdSJ0BDuaM1Usg1bJAyo5zD3/Lv2Zi
 RETuGUQa3bGoFuQn3l/zF1rBzNY0+gbK6t/qRNougW/BfC+lmjgrB+NDQ==
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/10 20:19, David Sterba wrote:
> On Tue, May 10, 2022 at 08:10:22PM +0800, Qu Wenruo wrote:
>> On 2022/5/10 20:02, Qu Wenruo wrote:
>>> On 2022/5/10 19:48, David Sterba wrote:
>>>> On Tue, May 10, 2022 at 02:03:18PM +0800, Qu Wenruo wrote:
>>>>> For the default CRC32 checksum, print-tree now prints tons of
>>>>> unnecessary padding zeros:
>>>>>
>>>>>  =C2=A0=C2=A0 btrfs-progs v5.17
>>>>>  =C2=A0=C2=A0 chunk tree
>>>>>  =C2=A0=C2=A0 leaf 22036480 items 7 free space 15430 generation 6 ow=
ner CHUNK_TREE
>>>>>  =C2=A0=C2=A0 leaf 22036480 flags 0x1(WRITTEN) backref revision 1
>>>>>  =C2=A0=C2=A0 checksum stored
>>>>> 0ac1b9fa00000000000000000000000000000000000000000000000000000000
>>>>>  =C2=A0=C2=A0 checksum calced
>>>>> 0ac1b9fa00000000000000000000000000000000000000000000000000000000
>>>>>  =C2=A0=C2=A0 fs uuid 3d95b7e3-3ab6-4927-af56-c58aa634342e
>>>>>
>>>>> This is caused by commit 1bb6fb896dfc ("btrfs-progs: btrfstune:
>>>>> experimental, new option to switch csums"), and it looks like most
>>>>> distros just enable EXPERIMENTAL features by default.
>>>>
>>>> Which distros?
>>>
>>> Archlinux.
>>>
>>> Their PKGBUILD can be found here:
>>> https://github.com/archlinux/svntogit-packages/blob/packages/btrfs-pro=
gs/trunk/PKGBUILD
>>>
>>>
>>> Which doesn't enable experimental explicitly, but still got the full
>>> csum output.
>>
>> OK, got the reason why the EXPERIMENTAL thing doesn't work as expected.
>>
>> In configure, we set $EXPERIMENTAL=3D0 by default, then
>> add the line into confdefs.h:
>>
>> #define EXPERIMENTAL 0
>>
>> However in print-tree.c, we use
>>
>> #ifdef EXPERIMENTAL
>>
>> Then it always get enabled, no matter if it's 0 or 1.
>>
>> We should either don't define it at all, and use the "#ifdef" way, or w=
e
>> should go "#if EXPERIMENTAL" instead.
>
> Oh you're right, #ifdef is wrong, it's supposed to be either
> "if (EXPERIMENTAL)" or "#if". My bad, I'll fix it.

Although personally speaking, I'm pretty happy to enable experimental
features for everyone, even just by an accident.

Thanks,
Qu
