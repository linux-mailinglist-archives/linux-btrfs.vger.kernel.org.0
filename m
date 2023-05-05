Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E966F7D72
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 May 2023 09:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjEEHFm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 May 2023 03:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjEEHFl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 May 2023 03:05:41 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3E27EF8
        for <linux-btrfs@vger.kernel.org>; Fri,  5 May 2023 00:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
        t=1683270334; i=quwenruo.btrfs@gmx.com;
        bh=7Yjs3AwpPt0uTm51SOYZuTkym1XsD55os9uEpNgEShE=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=fxVxZhmmkOyTO2HvoG+AlB+H331rJwUeMQlN5VbIgkiLDoaTFHx2wrEm3Fznl6+bG
         NT4nbHWxBdSL882tdgR+0ash7MF77+i8n9FFnAz1xMMD+ajfzy7TBo4rL1khqZpOoX
         28hmSs3hM0nbHJ8PmkqnS8japzjnT2u8BAxaRYvk4GLWd/zKB3Bgs+2wo69lK6RiDp
         n8KDXn4GgPQ1AI6rJWCK2Tl+LAYSA8kIgMfnyYEfNfeXLnqGSxWNsyrunDIpn1skSY
         k+2Voo18Szd2ro+7ABYoQJCme1FqZsYfRHPzWcyDJKIF3VP1o1AYXYtPg5Tfaxfeky
         S4SJunELABzvw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N7i8O-1qHI1n0mXq-014kN5; Fri, 05
 May 2023 09:05:33 +0200
Message-ID: <2d918ae0-8097-3dd6-267d-d762bbe1f749@gmx.com>
Date:   Fri, 5 May 2023 15:05:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 3/7] btrfs-progs: crypto/blake2: remove blake2 simple
 API
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1683093416.git.wqu@suse.com>
 <6f15cfedf228f6e8d855fcdcf125b678273534d6.1683093416.git.wqu@suse.com>
 <f84102d0-29ec-11a5-2777-9dd27c3b4123@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <f84102d0-29ec-11a5-2777-9dd27c3b4123@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5W3L/WaqPYZeP5z6cn0C4plIYlh8ackhn2/Pju3mnWeia70QADf
 KZvjoIk4UJtUJ/yOXmCqUMcAh4ILxr5qzFWJhN41pSq+NqgWcREzmwsiifas3vNSeT0cCET
 tx+aLuzCq0HVIIuGM+44bc3Kd6Pa382tvvXo0/1C5DAp67+ZIeeYEWSCB+mzAuveDh1uCpS
 QfQawW9fk3qqFDG6QIKPg==
UI-OutboundReport: notjunk:1;M01:P0:Cr1xZm0mClM=;H7yewi32devJgn34PHrVqcE3yLL
 GdTR2hYLD1dR90L0wNPSWIEzddQH/7l3ukCStkM1p2gxWdM99mLGiI8WKQOPbr7fF+8sV9vtS
 lKrE4ZeCck3i6Zr1AIKSzy6UXPbmjYNBoQIvtx75N7aIVBcOP8pnfpOG1/+0pXCLEeRgRCYkh
 V1aulXHs6DqrzWdS/34DJdF7gpCCucH95cPiBSqfh0+Gu7akP/vPZvJfhUDAAd2Q2ANxJOXZV
 Xi+jQrO0Ct6bYef5u5PR8KlzhPl5Tafr571YOsGw12MuZSZaJJH//aW/tr7YMFILJsi7qoWQU
 beInv/g03rixaaSxsrAqV8Aqi0BlwicZ14xVaT0EXo+6dRuvKU5Vd6anlCQjQqST+zQa/qM1P
 1FDtmBfCLEmUL9DKBBdG519tL8gPr4q2eCrMAJne0+uox8ojNpBn/9an7KPjGtENoC5UF8YQw
 UxL6hoyoqsOBu3RLeobqEQW3UMTXq2vw6OUYgk2NHU9MgqsB/HrXnu02EjVDWGySfKuDn2po3
 4cdvqu6OpKTo8U2dsnmt6smDUOb47ma/GCc8vfa5M3xyX3QvBM6sgA+k8VmJUsMiun8YIGrvl
 qJHkeRumqmxRcXFcEjP/5wAntGX/Gbj1GVUwKjbMQBIBSduazfqLWq3yjRNZO5gYgIvY5lbpT
 MSDWGOHfhlRi+0/yIBKfwDTXX7irMHPnaGUbPKSm7W9H5nkNDnAbknuGoAehTZctNQQV/jx8H
 3LICLNVswqPZJZGg3VCBPDYCBUo1CvuVWUHRaaHMJDFcXt5ZbFOzulr4GQlAZ6XKI/eu8ThGM
 4eHYL4vgnQynWhTeE0FtnXqWFKF2DuU9ZkskBHj6QXoljOEdAgolWYt9j+X0vEdDNQOo6KocX
 JpCmZhK7v5v2QKEdvk4/KGm0cghmI3TEo4eYJD55i17HMeIEqHB0z+mo7HdmzLsEVSbIpwHBu
 UdlMUyvD7JEj6S6DSJSBIhIcH/c=
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/4 17:08, Anand Jain wrote:
> On 03/05/2023 14:03, Qu Wenruo wrote:
>> We never utilize such simple API, just remove it.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
>
>
>
>> ---
>> =C2=A0 crypto/blake2b-ref.c | 4 ----
>> =C2=A0 1 file changed, 4 deletions(-)
>>
>> diff --git a/crypto/blake2b-ref.c b/crypto/blake2b-ref.c
>> index eac4cf0c48da..f28dce3ae2a8 100644
>> --- a/crypto/blake2b-ref.c
>> +++ b/crypto/blake2b-ref.c
>> @@ -326,10 +326,6 @@ int blake2b( void *out, size_t outlen, const void
>> *in, size_t inlen, const void
>> =C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>> -int blake2( void *out, size_t outlen, const void *in, size_t inlen,
>> const void *key, size_t keylen ) {
>> -=C2=A0 return blake2b(out, outlen, in, inlen, key, keylen);
>> -}
>> -
>
> It came from the ref implementation. With minimum changes. Maybe needed
> it for future sync? No?

No need, that function is only defining an easy to use interface for
callers who doesn't care the details but only want a fast hash algo.

In our case, we explicitly want to use blake2b, thus we don't need that.

Thanks,
Qu
>
> -----
> commit 3778ece7ff4114dc071667cf13a60c4ef1936576
>
>  =C2=A0=C2=A0=C2=A0 btrfs-progs: add blake2b reference implementation
>
>  =C2=A0=C2=A0=C2=A0 Upstream commit 997fa5ba1e14b52c554fb03ce39e579e6f27=
b90c,
>  =C2=A0=C2=A0=C2=A0 git repository: git://github.com/BLAKE2/BLAKE2
> ----
>
> Thanks, Anand
>
>> =C2=A0 #if defined(SUPERCOP)
>> =C2=A0 int crypto_hash( unsigned char *out, unsigned char *in, unsigned
>> long long inlen )
>> =C2=A0 {
>
