Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D61A5324956
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Feb 2021 04:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbhBYDUL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Feb 2021 22:20:11 -0500
Received: from mout.gmx.net ([212.227.17.20]:38285 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232723AbhBYDUL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Feb 2021 22:20:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614223113;
        bh=DYXwRtAip5A0U1SG0YLw4mN2fjoxSecntQAAcksTp10=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=fNWffFf85IcXqWVBxBMF/EImnRLUyoyBOeR8c55/QlJI+oz3OhYWwABeQmghGwDW9
         jfYGN2dVJSZoDao3tCOGS/Qg2F46RUOFnKcM1AoiqOa+pq5o6RlbUEGrOimEjB/ZAo
         yQwkXYJVgSo/aCy+JENBGl/1rDT4o2O9FyX9ATB4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MKsj7-1lXbvQ06g9-00LIa1; Thu, 25
 Feb 2021 04:18:33 +0100
Subject: Re: xfstests seems broken on btrfs with multi-dev TEST_DEV
To:     Eric Sandeen <sandeen@sandeen.net>,
        Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     fstests@vger.kernel.org
References: <3e8f846d-e248-52a3-9863-d188f031401e@sandeen.net>
 <5e133067-ec0c-f2c6-7fb6-84620e26881e@sandeen.net>
 <407b5343-4124-2e30-0202-13f42d612b7c@oracle.com>
 <68737772-deb2-6429-2ac6-572e15cffe57@sandeen.net>
 <b119f3a9-bf78-5b09-2054-09a2f583581c@gmx.com>
 <eb0d9c05-2818-fb57-4b2c-75b379d088a5@sandeen.net>
 <74ea7a30-fd25-7ac5-b3ae-98cf7b70e80f@gmx.com>
 <5fb6c496-dc53-662e-1970-9afb9a9dd62d@sandeen.net>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <d7183517-95e5-7b75-3909-1b2d30db3a87@gmx.com>
Date:   Thu, 25 Feb 2021 11:18:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <5fb6c496-dc53-662e-1970-9afb9a9dd62d@sandeen.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4JT2ncs95nwwSGlUC1NOFtWL8YjqDQY651vyxAeuNlnAppYl4ep
 C80evr06Rw6LeKUDEqPyrDdHzymDIQsiA5dZNOvw3LiJwLjaAd6lOaoqMnnLVFNvXFz+2Dw
 hPluVZPvU9dFoiH5WeMdFGB6eoSGtNF63x78NSnxeEncqZSGe04tZFdTVhD6+l6zT1RRMjr
 qf1j+gcIjo9t86mbBUv0Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wBBJDHp9sDQ=:urlhUD2629H8+kVtdN1pLx
 6X5n0EMAvbMtkR8quHy6abRAy1mnBNNNcpKH+f5OROm0ih1vLdFuNCsruJ41QbeXOwWDw6RdQ
 aX+H1Q6qRfPzfu48LrGnqmUl1xKOnR3JKtYZmbKxGGGIPPa+q94u6lR3jemmE+Z+KmMlWyFdY
 0e6AnvZod2jRW81FpzLmqtquJjID4p6RTa/zyYjK7qouxMyVp3qozOOZboV6PJVc1JlxHY/em
 Eonn6CGwcFO9kINSmGFtXitauM2MBHfHpE2bDL6pR4lV2dd1Z5VPcaGlsPQe3Q0vLaUTfWA/q
 LnJGTiaSS+3+TRf6Dew3pQQlZQvjQYCfowYTAb85LGupRtIDYSIXqG8AZQYp9yjZHZQ86zeJX
 AB0CyUFTmhhO7FLEY0j53Pf9Nip01JleF7VebmaCmUFewElsHionDFu+AYcFCbM1zm+2YcOrS
 8rl4F2UyE7BtJ3iyheEempLyNrfAbgJa6Yd+NrSYO1ShalxaoiVC/Oljsj/ifS7UVJrRoWezj
 qilGC/Orj9WB5udxjc4EnM5bntAr5VyKeo7jhxtmn+tp0xnZ7cAwYUjYFHnIfFK1p9bdD/xt+
 0hL1R0rt7801jHf71XVRqaHAGdjKKsjZL9zjx+wGjTexCisHvpsAc5kLGOiW4NTnrVE1tMYjq
 H2bnvmOy7ZdQYPv+UTcBsHg9mHrH5t3ik+EW7U4kKWLZw/e9sRcGJgfDN3muGLEFCaKEBDKIQ
 eP2ubd/OBBQaQenc+bvdFunnjz6L8uKbUYobCI60H+rAI1AxZnPOWL3Or1kD+UFbVslvZ9Y5n
 tzkenoqS0bNJMRtw9t+PgH7n5nmb4YbVp99qW2P+MCDq7WAxiROYcEfeYKj9vdpAOHyMPgQML
 +b2jap7hMSCO/udg1E9w==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/2/25 =E4=B8=8A=E5=8D=8811:15, Eric Sandeen wrote:
> On 2/24/21 9:13 PM, Qu Wenruo wrote:
>
>> Now this makes way more sense,
>
> Sorry for the earlier mistake.
>
>> as your previous comment on
>> _btrfs_forget_or_module_reload is completely correct.
>>
>> _btrfs_forget_or_module_reload will really forget all devices, while
>> what we really want is just excluding certain devices, and not to affec=
t
>> the other ones.
>>
>> The proper way to fix it is to only introduce _btrfs_forget to
>> unregister involved devices, not all.
>>
>> I'll take a look into the fix, but I'm afraid that, for systems which
>> don't support forget, they have to skip those tests and reduce the
>> coverage for older kernel/progs.
>
> Can't you just rescan when the test is done?

Oh, that's way more simpler.

Thanks for the tip, I just over-engineered.....

Thanks,
Qu
>
>> Thanks,
>> Qu
>>
