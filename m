Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0939052E024
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 May 2022 00:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245586AbiESW4x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 May 2022 18:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbiESW4u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 May 2022 18:56:50 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372CD4ECC1
        for <linux-btrfs@vger.kernel.org>; Thu, 19 May 2022 15:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653001003;
        bh=MsFSEeAg4KtqD/qPjdo+IF2KDaKbDPCwZwvU6rmqT1U=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=BeS/iHhXM3HxmWwlbpMGGZaCSpB8NBA2FVo7CgOq0ylBxcwAYEFV1uY2gRE0sFUr4
         IJjC52tf8WkdLX7AS+TcIPcxKQensHrFC4Y7SOjHGtaP5/wanw70qG0SWzvFN8/ieD
         GO6xS9KY0vnreNXMMY4Fx042X+0TTr1hELpKT7q8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mlf4S-1nQlmC3oKQ-00ikid; Fri, 20
 May 2022 00:56:43 +0200
Message-ID: <e14a2990-193d-024a-856a-c56ded756042@gmx.com>
Date:   Fri, 20 May 2022 06:56:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC ONLY 3/8] btrfs: read raid-stripe-tree from disk
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <2ccf8b77759a80a09d083446d5adb3d03947394b.1652711187.git.johannes.thumshirn@wdc.com>
 <6ddec77c-2aa5-d575-0320-3d5bb824bd04@gmx.com>
 <PH0PR04MB7416E825D6F1AC99F8923B659BCE9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <ab540ece-37b4-7cb5-216b-dad26ee75ccb@gmx.com>
 <SA0PR04MB741858084F504990FE654F879BD19@SA0PR04MB7418.namprd04.prod.outlook.com>
 <a1b876ca-6e6e-39df-ab70-0dd602229f0d@gmx.com>
 <PH0PR04MB74162E6BE1BB1F9519C440199BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
 <a6540b7b-409f-e931-dbfd-98145b48581c@suse.com>
 <PH0PR04MB741655C18EA13F9152DAEB509BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
 <e66ba88c-52f0-3db9-7284-f7a161542634@gmx.com>
 <PH0PR04MB741660F84BFA0F9C4E0204A79BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
 <e0ba76bd-72c0-fa6e-212f-92e060d79d42@gmx.com>
 <PH0PR04MB7416361C433278AAECFCF6A39BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <PH0PR04MB7416361C433278AAECFCF6A39BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yTAU04gwkiRxUkftho5FJGu8DGsTifYSs/29SJVsWj38572vREi
 k8nsM6D5VaPbFUectBySQCO2OAMvF18HT2RbMYbzzJaiSSPa+B5iHhMiwvLRHfFoRwAhinS
 9py2gur668JVXxseEi7HSzJQ5CHCGML7gCHfw/z29s7SZq7cSjg8PCfINfP//vt7fKcfCem
 RUqUcvNMs7kur+HC/ax1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pt75I6l+Nhw=:detqtqrlRHt9PbpLDVcPCx
 0Tq6jyKx9fUmeTGqmqMrv3yxfDOP21cPIdimNBi93jRby02jtqPAaEmuTB9bC6qOBveRgswDC
 52mHm/ktIVwxmlqTncVPKQa6XdjGdurtJyKZOiZM+lMELPBYKEg7go5DDYYX5xKkYEpnchjCG
 1QrbzxW/CSaZL5KhmM4TSr6Kgj+oR/VXBAD3O91wkS0/lJ+Q2XVin8zeUCR0wecWobVTSoAww
 EUHpSe6MH6vfUaHzeSwXK6pE66EOBRAoZ4mSq0tvCN67KR3uIAGS5sA/Xu3tC9J6QkZg8HvUF
 XglVPFJqmXv47go66rUYS71QmOAhhNDk0PoaJvhMm7qd77ItTfUNb2GkalP2Fs8YeOi7djxXK
 atD1fprgKlz3JCVU2kmrVqHGZ2ehP663Jt1IeeyjtVFvrhILu9ke2BHpwXRb8Rjgh4y/MeKGG
 0ZiWysS2gQ0fP/De3gZr/2gGdrIiux0QHjH5PK9gOARejWN6DMciuykTutP2sm5+1U8TjNOpO
 HxAsa7GpZKJ6S8VsYPpmfsdNXlz011AAhA4liZ5ZHXY4OZMU50IPu0uwcFgW3YQa1vcY03+g7
 l7074FkqLj2zmpnKcXc1s5Aqyz3tImJ8GlYnFDuINsqJSLVnPbcukBcQoPnT0BSr2GvHA+yY+
 w3DP7MmaO8pdPo0nCd3elF0QpK3iWAv5kidP6AaUwwFF3TrxZS4NQF/woSx8TBuf9IEH2YvSa
 3vljy962TKMCdCkdJUb71GCwFtSEgrw1TosbUnzan2dSqtg3jjy3lQbbvq0wAcik6Jk/Xo5cQ
 ARSQ01QOHzOVDCnB5XF08U+3HG35jTRlY/bNuwOAv6qMlM5aZheElCqfn8dK4/wpNC+5k3yNE
 FN0HZE0C22sHvv3qtKN6EosEfU3Dg2jKp83QOeu4LDkZn3hTgrCJEmQ5MavbB0a1wUb2Q4Ut1
 ZRG3gLCmt2qAif3c376Y6aWdC5cqvGB3Nxd7vkhXnhgqitqz8zb/e9Q1bfOxH3+t/6B2apmBT
 vGB2nLv+J4li5ilwrJ8WQ9sxqqN57cl+6aTTa+uWnG/KYJBHJwStFz34j6B45pZ7tX7FxeCOG
 bYaK81v+sHMcchZ5/Y8ubVB77Jc8ucMWAfba9Tdfsf/ZlpNB6FEG906bA==
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/19 21:49, Johannes Thumshirn wrote:
> On 19/05/2022 15:27, Qu Wenruo wrote:
>>
>>
>> Then let us consider the extra chunk type flag, like
>> BTRFS_BLOCK_GROUP_HAS_STRIPE_TREE, and then expand the combination from
>> the initial RAID1*|HAS_STRIPE_TREE to other profiles.
>
>
> That would definitively work for me.

Just one thing to mention, does RAID10 also need stripe tree for
metadata? Or since we're doing depth =3D 1 IO for metadata anyway, RAID10
is also safe for metadata without using a stripe tree?

If so, I really believe the metadata has already a super good profile
set already.

Thanks,
Qu
