Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEF8508396
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Apr 2022 10:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376794AbiDTIll (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Apr 2022 04:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376766AbiDTIlj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Apr 2022 04:41:39 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895B83AA78
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 01:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650443928;
        bh=NDy15SeutVI0EP1X0Fc5IRs9oXAGYAKRMcmQrat4cI4=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=ZcjPek32m7NLhI0CYMG5aGfoBtC3wpCpM8umedLpj1Lu0jnTuKeV3fSeyUgs0usT1
         Nrcx6z9h/zu/3tk/aq+bChNtfNAiW06aBGzo92Wi4i1cieBfy6QJkN777YVsChalO4
         QMYev8r2EAWL+EJInl/GNYqQzQJTq0oLgDa/fvfw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MbRfv-1oDgis1frN-00bogp; Wed, 20
 Apr 2022 10:38:48 +0200
Message-ID: <e57d9b3e-94fc-a20f-ff92-ccf19c0b035b@gmx.com>
Date:   Wed, 20 Apr 2022 16:38:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 2/2] btrfs: use ilog2() to replace if () branches for
 btrfs_bg_flags_to_raid_index()
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1650441750.git.wqu@suse.com>
 <beb111504cb32088bcf4fc6bc1ef36004d0761cb.1650441750.git.wqu@suse.com>
 <PH0PR04MB7416E7100B6C5EA70446C09F9BF59@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <PH0PR04MB7416E7100B6C5EA70446C09F9BF59@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V5EdASgJebgvEfeewve9IUessWVy9J6gF4+L8mqYpXkFyFPLgeW
 o4B3B0gkyOlsS3FHPuoYb3B9+AoRH0HNg69Cu5LyCqyDWFvXv85uAIrr+EwX5FbxqTuJC7x
 9BALAT5/Opp6foxCf4WwGNbET5Dqo9wxLwwgSix+SnKisnDmwhrTbX2jR2RlW9jKrK/bhEk
 oLFWeCeEgQP4ZrtrwWg2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sEbm/vCkXxg=:2nzZry+A75kV1ibnHkXZaS
 14Aoef8jDv1ikkqBVUD4kw8gP4yufr4bXK4JcFIg+5neo7Kl+yjfPXboWhV4znA6MFnkWDlME
 t+vYiMx99IKtTRhn41mCJN5RxoazJZ1eQyALaoFVULn9wWNuNZGWOmHco9+l3z19MGF4Aa5CI
 quPpSVQPUyWfF9dLc56CfBCmPE/unoNE/qNAd7fI94gYKk1jxiM+Ide29ngx6oQD8CPYf/cvJ
 q3PJ0xD31n2yIluYso1WO9rXTnC2ZBkfcSq6O49oR81kohQNi3j3d5BhJP9bDxGJLS0K7dpPe
 xPqNuFiItcP2w3gNGqprkTKTCxff16jSMwif9zDvwJm1pYEg2TEyfZOp6SRXiWZfsga155l4S
 yJpRZjAA1M3riRtnkO+kUYeXDkvF79kaLWjTaSzPrGv14Sp8U9YfMP5jq0s1/Qs5IbyycG8SN
 pj8aFOV09JDRMpNL67mYYtkhuGzfZor8Q4ItuqGrKBbYGZF0+Mzjsi3oHnfXp/Y8Ex/07U7HV
 PZHvZWIHEDZC9MPlrUdp4lmmOvX7+dDBFFSxjlhnzTF3bu/Lq3bwCBsC0fYJcnn1XFCuxmoYP
 0GPoMrmEzXmM+NaJ4DXpoKuMeiw5n/SxNbDq80M+n8H1/MsKSX2aWOkWRr9J5pZ5uMowMAf+7
 +KnTLnIUUiz5y3xR9cjwfiVFhk/FmQk7mucdODQmnda2Bs7O6zcjCN5euklsM43zfSZ92fxg1
 37ncwe010uwf+kVt8jOWN5qWjh1JaF0P/fwPW34VVhVPRxSEzQM9iraSVnV9Ae6F/q9Xg+200
 L56sWNwGVJnBNrz5lz9NF+3UrxyLlwRrTJL8OsIuRDIHjNgiU2GaZThcnruSq78esUpeBJgun
 VNxHq365bbTcoZfTLax+A1Xfp3DoNPZLhBlHa8OgX1EAnx0cjVSsqwfAxOSoiXVShcB/2bpev
 b+3SWnkW1HH1uFPClg7ipqNvctfXamcFRQxpcFezPPRiPtlnAju8Trzz08/1Vlg231HwG/nh+
 95bNJ01PygCyKQsKIT12TXTdRclsRyh99g4PP2zf/7wmlHqn3ku03sNlyQiX6RHk9LTCP62i6
 GVk+tX7br3WQO8=
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/20 16:25, Johannes Thumshirn wrote:
> On 20/04/2022 10:09, Qu Wenruo wrote:
>> In function btrfs_bg_flags_to_raid_index(), we use quite some if () to
>> convert the BTRFS_BLOCK_GROUP_* bits to a index number.
>>
>> But the truth is, there is really no such need for so many branches at
>> all.
>> Since all BTRFS_BLOCK_GROUP_* flags are just one single bit set inside
>> BTRFS_BLOCK_GROUP_PROFILES_MASK, we can easily use ilog2() to calculate
>> their values.
>>
>> This calculation has an anchor point, the lowest PROFILE bit, which is
>> RAID0.
>>
>> Even it's fixed on-disk format and should never change, here I added
>> extra compile time checks to make it super safe:
>>
>> 1. Make sure RAID0 is always the lowest bit in PROFILE_MASK
>>     This is done by finding the first (least significant) bit set of
>>     RAID0 and PROFILE_MASK & ~RAID0.
>>
>> 2. Make sure RAID0 bit set beyond the highest bit of TYPE_MASK
>
> TBH I think this change obscures the code more than it improves it.
>
Right, that kinda makes sense.

Will update the patchset to remove that line if needed.

Thanks,
Qu
