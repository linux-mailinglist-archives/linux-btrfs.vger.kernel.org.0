Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06ECB5878B1
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Aug 2022 10:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbiHBIGd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Aug 2022 04:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbiHBIGb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Aug 2022 04:06:31 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6116117E21
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Aug 2022 01:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659427585;
        bh=Xxgow6T0zG7gK18HEGpKv0vtm5G8r8LLpuVNY/MBaL4=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=ABnZbzbso+LjFRsvssP0WS+wV0OQwkCNmuU8ry1OyG1N4Q1uq1m3t74W+81lD/5JZ
         TLOLguP6yUqdq8Er+U5wXyF9cRFg+ldlvnRr5vXnGiME65zZ9lCIHPQW3DppO/LRR5
         SqerpdbuWOaVr5y34LHHCYPZNiF6ghNT7drF4Ock=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MXGr8-1nwBLS2pmY-00YlvA; Tue, 02
 Aug 2022 10:06:25 +0200
Message-ID: <b506958f-1c09-187b-ae3f-32c9becabc5b@gmx.com>
Date:   Tue, 2 Aug 2022 16:06:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 0/3] btrfs-progs: avoid repeated data write for
 metadata and a small cleanup
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1659426744.git.wqu@suse.com>
 <PH0PR04MB7416920769E0F9FF573040C59B9D9@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <PH0PR04MB7416920769E0F9FF573040C59B9D9@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CefeipkAnsI8yUM8JGmbWWBiC3qWr2rb8/c3O/YK8G/p8BjLUDE
 gqurKh6pDkumti4YsJ7iqotVBrCt4EDf4gPiGLsFCxpCyARlOIm1YPRJxA6+Nn8B8jKxx7R
 isY6ikxylR/N/PlmAoKqXKXGrUlPBKpgw93QZnAg8FukSv/CEKdpX0Vy7pDPAqo2ruzl7gk
 DJEptKL9zmPYbkBvL108A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wOOI1Ag80T4=:zI/9fxhbMHuRANPOJHgv13
 Tr2Nqat7zGUYb4dJ2CaQLhYyRo2bJ1u3khjhgyhBIjUYzdaTMISsB6d2pBRmamIfWV5yXwhUt
 vz6bqtVZ1KGA3rMsa/srOrfJ+KNDDDau/cY1QGoNFKSd9c6D426/PUovkLdgOVxxI7orxHJ62
 1dTk/vu/s4UI8ZKvMbGerQ7QZuABZf1Pk0y6ybqFDyswxlCrI/ObL+rmnEhB+ym1eSPn0NKB6
 wIeHikT+sk+9FiA1oAtvFmM1M3hCArzNKFsTECkLmx3/txST8aMQt8NG40rHdlkzw/b4r9nhd
 8nDPy9la9voedOtv1nO+5Fc0Ovm+TSv/CtEQvX9+M88MFBPMx4ggpyO2rG/BbEdjCpeiDB1Ti
 X6jzvG8HOg5WbiXokJxFUUZSaGyqA8oCD1Cq4v8U2m0bNUbpb7/W0xG61I4rK99uBwyAyvUF+
 lR6jJkpkySpyaXkjmD5uOfQXl14X8Y8XK6iNWowQ9B0FuvaMA2bBefqZr7NWbS8iTeQ4vmDH8
 5UB67AntO5k5bK8M015bnvUS1M0sXI2DTML+7Vw9cdruWGYxM6E5aX4Zhu3DblTuQf80nqNc0
 hNXXbzFHwhD8Lum2oGgjk3NL9aEJnuiqPW3xmUpk10/P5IbX879pPgLCQ8Ci7y44QVHBPgicC
 uugaa08eNlY0Brz0z7ajnnnO/t3lB53gPHIh7eLXFhxbArZDCsaHhCkLUTDfCnFRbO44QMRIp
 PibkKpZ+p+p9Z8ibT9RBAzOQ+vPAQqvA9kf5V0Unlkglh8w8LL/aVU3HJq5sjitDfL0J4TMFr
 pqG69JDba/C/SNwIp/BcPgBxnubhzcgrgHffFre+BpPyFweUC3dvTY+NkHptrPcyu30kiRcL2
 FCzPUcDoqBHvoC+jojsM/q0LtCvhYNJD9vSuz6duYoZYLk/4w0GrsgHTXQlp/PXP2eEFWpJWL
 ZGjSiJUhJhfGsEXcARQWuv87Qt/iwaMwfPzPB8N724H1sLFnRy3XR0Jdw7n483xBcpB+OKij5
 Lvf/duomEYcWtcBitvUMwHxjIozWjD5a4dSD9I7eDol6juwRge095ExTTa4RMs1766rY/Se7y
 nRhlWicXaAJK6q+KDuqn7gjly4MwpM/0lj8gIwN0fYPZ36ZYFB3EzWXHw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/2 16:04, Johannes Thumshirn wrote:
> On 02.08.22 09:53, Qu Wenruo wrote:
>> [CHANGELOG]
>> v2:
>> - Separate the fixes from the initial patch
>> - Fix a bug in BUG_ON() condition which causes mkfs test failure
>>
>> There is a bug report from Shinichiro that for zoned device mkfs -m DUP
>> (using RST) doesn't work.
>
> Nit, it's without RST.

My bad, for RST it should be -d DUP.

Thanks,
Qu
>
> Anyways, for the series:
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
