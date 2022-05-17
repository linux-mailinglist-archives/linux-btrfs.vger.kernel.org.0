Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51DC0529B91
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 09:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237671AbiEQH4o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 03:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242375AbiEQH4S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 03:56:18 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197B1220D8
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 00:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652774173;
        bh=ehgeDi9ZJA8+l//nK3rzyOrEBzEzBRjtu4oUiykUpwQ=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=GvcO9mPUg+f8EskzRwHiaWFcXFJf22JtEgop51+TztYDWGRgcpfAKNWL4eE1fHaoc
         1b7JMY0GSOaX6nbNby+Wl7gTTTOfpJKpMvd0cCMQG2zKoo+aDYrRR5368W5JQViw4B
         CGqpybXBFoaidkUBztQnhUNvlSy3xUai/mVqjgqc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MQeA2-1oDKck0658-00NgeX; Tue, 17
 May 2022 09:56:13 +0200
Message-ID: <55100777-78bd-91df-db2f-d15b210c16e1@gmx.com>
Date:   Tue, 17 May 2022 15:56:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC ONLY 1/8] btrfs: add raid stripe tree definitions
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <06a217ce02243fe88b9649d689df89eea7a570c7.1652711187.git.johannes.thumshirn@wdc.com>
 <cf5f8445-a622-bc8e-bfdf-8084a00e87ee@gmx.com>
 <PH0PR04MB7416044172EDAE0F7E17E3959BCE9@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <PH0PR04MB7416044172EDAE0F7E17E3959BCE9@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ABBIKXQZ7FiaNn6Mzsdp2ZQtqpC9ZjfDkk2McXK/bxiwbjguAcn
 ioJxZskGEe6wnq40vJh9EGIdiZhRsbtgognpl/dvwbCoZVWlQPIIRH7a85LUO4ga1OWCD1K
 /iF7tbdvdb3w0/OU2aJ5sqlSuGxVWC1SnIQe3dbVweFYO7azwZwpuRI6ugOFsMBY5AtbQq7
 JDAbEGMA5oy0hnqFj3MAA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vAFSm1ojgMk=:XpZ3O0aANEhgAxKvpsvIWU
 VUxxBjl7CzXKw83fpQGr7x6tEb1X1SQ1k9/2ATZYUcROVYdDCtwlymFjywoHV7+rj8MnJtfaE
 8owKgr4QcllJGA13PQvquU3Z1/7qHWYoy6V2CAPYyZY4apime8kL/SATRNZHp9FwaEoQBZdkN
 AzfdrTzo74zXyg4c+b732o2hmMFKIkI33Yv2hrD88qkbpnXbmQ5FGVEHuzIvmlH3Jf7HUb674
 ak8aWOUPcrQzg8SShornPSm41lrj9tjBl5b54nw9q7qUutpkd62fjflIkbBdFCMHBWZL3m51t
 vCqP7HXMqjzwWliYRnq+ITiaM338xYwQfI05botwrHBZbrMxLKdq+AmeJHomljXLzMDhM0h/v
 PewLzoN1kJJ3njzfKkxOvWGGxorVM+dFBtrE1F8pNM66wzeltBzseXJdRNTj/LxSPRKUOa03I
 ZAT7EiwNV1mAmPOzQzrp2MfquNii6+TpbIktJWOgZBP7RaYJDnZm92kJme/H4rLBVbfhAR12w
 woPKcyiwZMLLI0xnO/G2hFihtPEKmnkHyr7SkIDIDDJ8eBIK3FdiGWw+9XgPgRip/gxaV/+Xa
 9Raj2URhHGTxkfjFZIP4B5pIyG6ju6RsyM/Mg7JZmbJrcwIW/5zEG8rXpZiADYDb3KzLA23rk
 YqmZxtgS+F7HhE6DupvVUpmu3cY4SXPQxnvNq8HBTVjog5qMVNl1FOLtI+I0Nap8LXxNZos8j
 6b/VsS6gMs8dc56hK8ZSqTFlu7BJVczp41grA43rivJRywgnzySdZRw84D/8eQ1hqO1m00SXf
 ggnY1x7gAqTpu8w+4egGOmc/WhVPRmRhnxDMlWJU1v17EZL8AFEgYC3FzPPqgMxIwBGoIYBIn
 FZ5xiEaYMGBSo7W3e0bd7qPXh+hlqP66/Aqf6vwwt1hcZdlOFAg5FRdEn5RWTSjJuiK84QtEc
 cMJ8pa1bXEeyfohoqsT5DR8V3r30c0YMgY9kJ0OB3fHw4frEx24KonRpyMy3/RMJ8Q0HTjucC
 jX1AyezRdRG8CHxuv0jPFc37kZjDSFMaSbzq6ajHeBJtIqxxeU5Uf+kPL1EpJftrFNv3ufvKs
 uDk/LA+QpY1A0Q=
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/17 15:45, Johannes Thumshirn wrote:
> On 17/05/2022 09:39, Qu Wenruo wrote:
>>>
>>> +struct btrfs_stripe_extent {
>>> +	/* btrfs device-id this raid extent  lives on */
>>> +	__le64 devid;
>>> +	/* offset from  the devextent start */
>>> +	__le64 offset;
>>
>> Considering we have 1G stripe length limit (at least for now), u32 may
>> be large enough?
>>
>> Although u64 is definitely future proof.
>>
>>> +} __attribute__ ((__packed__));
>>> +
>>
>> Mind to mention the key format?
>>
>> My guess is, it's (<logical bytenr>, BTRFS_RAID_STRIPE_KEY, <length>)?
>
> Correct. I'll add a comment here.
>
>>> +struct btrfs_dp_stripe {
>>> +	/* array of stripe extents this stripe is comprised of */
>>> +	struct btrfs_stripe_extent extents;
>>> +} __attribute__ ((__packed__));
>>> +
>
> Another question, should I add the generation to the
> btrfs_dp_stripe? And does someone have a better name for the struct?

Why you need a new generation member?
To address the problem of possible RAID56 device mismatch?

Thanks,
Qu
