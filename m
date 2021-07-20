Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC3F3CF3D1
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jul 2021 07:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242809AbhGTEVw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jul 2021 00:21:52 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:51174 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241125AbhGTEUP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jul 2021 00:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1626757243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z/gIPkQNLzdBZ/RP+ANO8Ql53zVdHx23JxbLY84yJYY=;
        b=nHbobnJDB6YxMChbzjnQXh8leCPQIhX/akWT71LsproB5pY6dgZu/v8qsP4kMuBRBibrfq
        4ep5tGoG23r3Kvxsqm5is20+wXN1C54/3xOktmAuGRIj1loiDG8D0nfE0eKl0tmg3IlHm7
        OXoWmcv3CN+ytW53SwlIa1gQ+BbXNMA=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2056.outbound.protection.outlook.com [104.47.14.56]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-10-17pizTL_MtGH5PX0ipQQoA-1; Tue, 20 Jul 2021 07:00:42 +0200
X-MC-Unique: 17pizTL_MtGH5PX0ipQQoA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oSsdi/rXGgLBurgdO5+vvG60aJOtPLUX2HD19n7xBQmugNPrHUsU6HQhpJw5u9jDW0EGxaIHI5xxRqB/w758Sdy3TbDaK5tBAUjphzvcQ5omnuxHGu7eBMVx5aDuzD2m81XtC2QtRr5ffyq543wvYt61Uo1+gBije2V+hZvkaLhwfylvGJGVTZJYKrl5fgcrRHl7Yhf6w6aOsWXiMOTWFhD/XO7Z3rFzEM4CDgGxWgjELkJm8yfUL7Vz6shSgNUEZK/Hmly95N+zrYGZ0JjzDwFs/qqV1JL8RTOUfAmKpe7fxt3ylNkcFLWleY8ruan2wK02LYh6nwqvqhIuxYWzCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sC0IMe8L2EiqahOHn7SeEnoxqcGl9t9EBh8Bf6iSNg=;
 b=evummBstI29D1YMX/A1Se8S9H7ipjLppPCWz9S3s/U/cNzBZV5eNvVT5a8juJqwfS3V6Uks15P94H3LecKaS6IWuZxFBpbm0Z6EZw3U1j1YIR97+gwFp9wyBTVvV/dveOQT3GGeiu/pth2Q7+cWaAfjIT1LKjHEgWbL+Emrixx1ih3hyQJBX0lqd0rX+Bu4zSJfNZQV3md5xPQHiSIW2BNZfnSniXBMuNhgEtpXiZvCYXau1BvQo4PTfPod2sUr/u6X60uOimHr12JzKvAYyQPuH5ghPbt1Uz/ygExMCOcbgJ2mpEYEM0E3lB9TF1X7APJeXJC+o3oPn8jMsZiZCwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AS8PR04MB7686.eurprd04.prod.outlook.com (2603:10a6:20b:290::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.24; Tue, 20 Jul
 2021 05:00:41 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::816b:1f6a:c279:1b65]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::816b:1f6a:c279:1b65%3]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 05:00:41 +0000
Subject: Re: [PATCH 00/27] btrfs: limited subpage compressed write support
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <20210713061516.163318-1-wqu@suse.com>
 <e9d5c7b5-c078-850f-3441-1c0097eb73d3@suse.com>
Message-ID: <54845ee2-ff93-8dcf-f05e-9688e2156ac7@suse.com>
Date:   Tue, 20 Jul 2021 13:00:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <e9d5c7b5-c078-850f-3441-1c0097eb73d3@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR03CA0354.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::29) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR03CA0354.namprd03.prod.outlook.com (2603:10b6:a03:39c::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend Transport; Tue, 20 Jul 2021 05:00:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d51b769e-5844-4590-c1e4-08d94b3b5287
X-MS-TrafficTypeDiagnostic: AS8PR04MB7686:
X-Microsoft-Antispam-PRVS: <AS8PR04MB7686143CF72842C7C433C356D6E29@AS8PR04MB7686.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qg5voFAXFvGPpWFrKLdXNFlKmNvFVjZyCAd1+GA/P0Bd5ukv+gKroIgF8sYoN2ets3ETS9l5DiNU5FzsASwKjw8UyqWeBvIWU0rqG7rE1//yVkYmlMRe90At4BLUzVsGrcFFOkjwtSqqJbOGygHB9he462eJSF2uqTOs7q/3qhLJg1loskdJn06jf32Te6w1MOFRFH5KGOiEbV8RarBnz8nIMVdHT4BuRMKzUJg12E4KOW7HlyG7/BaxPBE56lHvyG/Yj5VnWsKMaOmXeIev0aJQXiPD+7vY8ZkwOXu21l5+LscLLSNH3iKn2lO16OkrR3oEQ2ubPk4iRQOxjRZMNDGkJZeNRw4H7Y6ihuOW+dwdsG9l70Ti1Tbsn04R+6bzMrFjdQN2urW0bv1sLEDIVJyWJFHTWQ1fLN8xmqo8DPyjFR1VaZP0rlO3CZrUMxfDqu2lVpdUBgYRsT7JowgPXyaxqW9KoLBzhsg699ZKkEWN9c7Fn8Q2SHvnrUFqO0O9Vez5NLs7xyxkT2XXeCsRNPwkqDJAwQ23dGaIgMDBXf1IGelpZgYwNblsQwtaFVkZGclprrQNIWZJ1Evk0Y+Soc9iiw+8NvqxScyqlR7stBSh73rvIQH8/WOTF04zFouu9lizPunHJiW7xeAepbYay/b/DAdrPBvAnk0qCrx6gDuEJK5F5L5zCcX/z9V5M3nUqp8m15Di6BBVqmBQFGo3Epv7k1aKpM770dBe3zk2GQNWDgAm/Th8Eonk4vs2HBLLkSQPsnlRfrx0/XAhdJ2PxL939QwuqX3tR7uc3FxJj1TTc+BOiCZ1o0CdrB46Z21HAeSrpP7CCCkTnwsrBeRh7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(39860400002)(366004)(136003)(2906002)(8676002)(6916009)(6666004)(8936002)(6706004)(5660300002)(6486002)(478600001)(186003)(26005)(86362001)(38100700002)(2616005)(966005)(956004)(36756003)(31696002)(83380400001)(66946007)(66476007)(66556008)(31686004)(16576012)(316002)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zQIrOuYTLDMvMN6YnafefQyEzLMwcLx6H+wtbXt5eXNoIzT9hDs4ynnrGlqE?=
 =?us-ascii?Q?SRvQlL9Yz6VUp54pXKyheTptUR0M1xV+GVgnvLtfMt47B2UjA+6hD5qkfiym?=
 =?us-ascii?Q?Pk0F82X0z+Xm7X45E6c3c0piQ03g8bXZeT53QXP5BOU2vkwNNf2Hsti9M/SC?=
 =?us-ascii?Q?HIcSv46Y6ZcsSYHOaKXolsHasIyLGT9Qn52gMTK6UimWHjMRMyPpGDls+bXt?=
 =?us-ascii?Q?uJRJJUVRlsxg/EAKwbdlGpVIs4OsS8zYsvJDh+rYzHK9Lx4SNnC224TTqXZi?=
 =?us-ascii?Q?hXlymG1Fc/P+Fh0+G8W4qDKKhoHuEP0eJxVlcZ/7l+tEODuk5F/BdnME4xQw?=
 =?us-ascii?Q?2y3v9E/vU8OQGQw8STSbSTSi25ONp7JLxwuSjdM/2q6tF8ssDn8FvwsdHDSV?=
 =?us-ascii?Q?BgT7KENbNf6nXIV0Lxh1ILu8bdAQNSurx0eRxFcZPlrBGXvo2Sc4kOWIngt6?=
 =?us-ascii?Q?NAMvNFOOHOEaPkYglk5oruNNfKaM07uWk7mCuuDahyaFwhYDxycCZTbu/h85?=
 =?us-ascii?Q?C+KVdwjMuA4Tg6a71b0jriSbd2EVjIxwboGPROAhBSWVhJqLtuNgDjCB6BjD?=
 =?us-ascii?Q?hqH0M4H4PdYwSS7BMzO/i55R2denA1QKVHdHrVSNUySvv3iy2nrxfV5VcXoZ?=
 =?us-ascii?Q?p2zV50Lv/+v8hy/HPy7ioHm3owEV62F3gVWhNVu0Ghe0lG59K9JVwxjUWETj?=
 =?us-ascii?Q?uxJyN0istaz38XLkpvIQ4m9cxA6IwZCN2TISn4JgxaWmZi/9S2PWs601jBHB?=
 =?us-ascii?Q?3IXOYWvKHx0yTdkHAZY9drreEn2Bo/TUAvoE73whmKQjUPOGZD65jC6fRCEr?=
 =?us-ascii?Q?e4FBDprwzpw9wZEw5ixVWrXOu4BGTfCKV/PbUbqBh3Lt25IhRgQGasvEORqY?=
 =?us-ascii?Q?otyezvL2DYIkf36Za/mCdroFJ2KCokM9vWlHB38ZL1JjDI+1972hjeHA8qg+?=
 =?us-ascii?Q?qkMgDWV8MDI7EoL1R/f8phCLS/Fz7HLTznI4fithjmDVKW5BQJPdnxQ8E+9A?=
 =?us-ascii?Q?0BKfh5xyP5ro81+kggUpmbuLbbHr1TNCDB3rExPi5jwLaNPoloupccZ4hrFx?=
 =?us-ascii?Q?MXtr+PxQ7gHQUQBn4gJPFS2EgHci5zET0NrM+RD6mMJ+kf7psPKBWZANgxmu?=
 =?us-ascii?Q?K8MkDnoy0XA2Rof94AbsittQfX5e71sDC/pUp/cwH897u/4ofxj5nM9sHHuy?=
 =?us-ascii?Q?QmociqhgNEsqTKElhSp3Ih1g7cR899NPWnLgowUDDn8xnzJri6igOpuCYqcw?=
 =?us-ascii?Q?SjvKq/MBek7qYNdsobA2+HKGtGcA94cxVte7OQ6kHC04j+OjlXq5CswKD+pJ?=
 =?us-ascii?Q?pCZ/FiiTuuBjisTsDVAII7pB?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d51b769e-5844-4590-c1e4-08d94b3b5287
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 05:00:41.2136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RXb0x7FbdzeQysWWT4pE60lolevvaVwEXGDDo3Kzyn1rRA0DixxxAoATXwVMHSJf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7686
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/16 =E4=B8=8B=E5=8D=885:11, Qu Wenruo wrote:
>=20
>=20
> On 2021/7/13 =E4=B8=8B=E5=8D=882:14, Qu Wenruo wrote:
>> The patchset can be fetched from github:
>> https://github.com/adam900710/linux/tree/compression
>>
>> The branch is based on the previously submitted subpage enablement
>> patchset.
>> The target merge window is v5.16 or v5.17.
>>
>> =3D=3D=3D What's working =3D=3D=3D
>>
>> Delalloc range which is fully page aligned can be compressed with
>> 64K page size and 4K sector size (AKA, subpage).
>>
>> With current patchset, it can pass most "compress" test group, except
>> btrfs/106, whose golden output is bound to 4K page size, thus test case
>> needs to be updated.
>=20
> It turns out that, btrfs/160 has a very high chance to crash due to=20
> ordered extent tree inconsistency.
> This is only exposed when running with "-o compress" mount option.

To make things more weird, if I disable space cache then run the test=20
again, it no longer crashes anymore.

Recent debug also shows the problem is inside the ordered extent=20
cleanup, for *space cache*.

By somehow, it seems with subpage compression, we're creating larger v1=20
free space cache file (this behavior itself can be a bug though), thus=20
it's more vulnerable to IO error half way with large ordered extent=20
submitted.

So this is a bug in generic data writeback path, but some how only=20
subpage compression makes it easier to trigger.

Thanks,
Qu

>=20
> Will fix all the bugs exposed during full fstests run with "-o compress"=
=20
> mount option.
>=20
> Thanks,
> Qu
>=20
>>
>> And as a basic requirement, 4K page size systems still pass the regular
>> fstests runs.
>>
>> =3D=3D=3D What's not working =3D=3D=3D
>> Delalloc range not fully page aligned will not go through compression.
>>
>> That's to say, the following inode will go through different write path:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A00=C2=A0=C2=A0=C2=A0 32K=C2=A0=C2=A0=C2=A0 64K=C2=
=A0=C2=A0=C2=A0 96K=C2=A0=C2=A0=C2=A0 128K
>> =C2=A0=C2=A0=C2=A0=C2=A0|///////////////|=C2=A0=C2=A0=C2=A0 |///////|
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \- Will not be compressed
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \- Wi=
ll be compressed
>>
>> This will reduce the chance of compression obviously.
>>
>> But all involved patches will be the basis for later sector perfect
>> compression support.
>>
>> The limitation is mostly introduced by two factors:
>>
>> - How we handle the locked page of a async cow delalloc range
>> =C2=A0=C2=A0 Currently we unlock the first page unconditionally.
>> =C2=A0=C2=A0 Even with the patchset, we still follows the behavior.
>>
>> =C2=A0=C2=A0 This means we can't have two async cow range shares the sam=
e
>> =C2=A0=C2=A0 page.
>> =C2=A0=C2=A0 This can be enhanced to use subpage::writers, but the next
>> =C2=A0=C2=A0 problem will prevent us doing so.
>>
>> - No way to ensure an async cow range not to unlock the page while
>> =C2=A0=C2=A0 we still have delalloc range in the page
>>
>> =C2=A0=C2=A0 This is caused by how we run delalloc range in a page.
>> =C2=A0=C2=A0 For regular sectorsize, it's not a problem as we have at mo=
st one
>> =C2=A0=C2=A0 sector for a page.
>>
>> =C2=A0=C2=A0 But for subpage case, we can have multiple sectors in one p=
age.
>> =C2=A0=C2=A0 If we submit an async cow, it may try to unlock the page wh=
ile
>> =C2=A0=C2=A0 we are still running the next delalloc range of the page.
>>
>> =C2=A0=C2=A0 The correct way here is to find and lock all delalloc range=
 inside a
>> =C2=A0=C2=A0 page, update the subpage::writers properly, then run each d=
elalloc
>> =C2=A0=C2=A0 range, so that the page won't be unlocked half way.
>>
>> =3D=3D=3D Patch structure =3D=3D=3D
>>
>> Patch 01~04:=C2=A0=C2=A0=C2=A0 Small and safe cleanups
>> Patch 05:=C2=A0=C2=A0=C2=A0 Make compressed readahead to be subpage comp=
atble
>> Patch 06~14:=C2=A0=C2=A0=C2=A0 Optimize compressed read/write path to de=
termine stripe
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 boundary in a per-bio base
>> Patch 15~16:=C2=A0=C2=A0=C2=A0 Extra code refactor/cleanup for compresse=
d path
>>
>> Patch 17~26:=C2=A0=C2=A0=C2=A0 Make compressed write path to be subpage =
compatible
>> Patch 27:=C2=A0=C2=A0=C2=A0 Enable limited subpage compressed write supp=
ort
>>
>> Patch 01~16 may be a good candidate for early merge, as real heavy
>> lifting part starts at patch 17.
>>
>> While patch 01~04 are really small and safe cleanups, which can be
>> merged even earlier than subpage enablement patchset.
>>
>>
>> Qu Wenruo (27):
>> =C2=A0=C2=A0 btrfs: remove unused parameter @nr_pages in add_ra_bio_page=
s()
>> =C2=A0=C2=A0 btrfs: remove unnecessary parameter @delalloc_start for
>> =C2=A0=C2=A0=C2=A0=C2=A0 writepage_delalloc()
>> =C2=A0=C2=A0 btrfs: use async_chunk::async_cow to replace the confusing =
pending
>> =C2=A0=C2=A0=C2=A0=C2=A0 pointer
>> =C2=A0=C2=A0 btrfs: don't pass compressed pages to
>> =C2=A0=C2=A0=C2=A0=C2=A0 btrfs_writepage_endio_finish_ordered()
>> =C2=A0=C2=A0 btrfs: make add_ra_bio_pages() to be subpage compatible
>> =C2=A0=C2=A0 btrfs: introduce compressed_bio::pending_sectors to trace c=
ompressed
>> =C2=A0=C2=A0=C2=A0=C2=A0 bio more elegantly
>> =C2=A0=C2=A0 btrfs: add subpage checked_bitmap to make PageChecked flag =
to be
>> =C2=A0=C2=A0=C2=A0=C2=A0 subpage compatible
>> =C2=A0=C2=A0 btrfs: handle errors properly inside btrfs_submit_compresse=
d_read()
>> =C2=A0=C2=A0 btrfs: handle errors properly inside btrfs_submit_compresse=
d_write()
>> =C2=A0=C2=A0 btrfs: introduce submit_compressed_bio() for compression
>> =C2=A0=C2=A0 btrfs: introduce alloc_compressed_bio() for compression
>> =C2=A0=C2=A0 btrfs: make btrfs_submit_compressed_read() to determine str=
ipe
>> =C2=A0=C2=A0=C2=A0=C2=A0 boundary at bio allocation time
>> =C2=A0=C2=A0 btrfs: make btrfs_submit_compressed_write() to determine st=
ripe
>> =C2=A0=C2=A0=C2=A0=C2=A0 boundary at bio allocation time
>> =C2=A0=C2=A0 btrfs: remove unused function btrfs_bio_fits_in_stripe()
>> =C2=A0=C2=A0 btrfs: refactor submit_compressed_extents()
>> =C2=A0=C2=A0 btrfs: cleanup for extent_write_locked_range()
>> =C2=A0=C2=A0 btrfs: make compress_file_range() to be subpage compatible
>> =C2=A0=C2=A0 btrfs: make btrfs_submit_compressed_write() to be subpage c=
ompatible
>> =C2=A0=C2=A0 btrfs: make end_compressed_bio_writeback() to be subpage co=
mpatble
>> =C2=A0=C2=A0 btrfs: make extent_write_locked_range() to be subpage compa=
tible
>> =C2=A0=C2=A0 btrfs: extract uncompressed async extent submission code in=
to a new
>> =C2=A0=C2=A0=C2=A0=C2=A0 helper
>> =C2=A0=C2=A0 btrfs: rework lzo_compress_pages() to make it subpage compa=
tible
>> =C2=A0=C2=A0 btrfs: teach __extent_writepage() to handle locked page dif=
ferently
>> =C2=A0=C2=A0 btrfs: allow page to be unlocked by btrfs_page_end_writer_l=
ock() even
>> =C2=A0=C2=A0=C2=A0=C2=A0 if it's locked by plain page_lock()
>> =C2=A0=C2=A0 btrfs: allow subpage to compress a range which only covers =
one page
>> =C2=A0=C2=A0 btrfs: don't run delalloc range which is beyond the locked_=
page to
>> =C2=A0=C2=A0=C2=A0=C2=A0 prevent deadlock for subpage compression
>> =C2=A0=C2=A0 btrfs: only allow subpage compression if the range is fully=
 page
>> =C2=A0=C2=A0=C2=A0=C2=A0 aligned
>>
>> =C2=A0 fs/btrfs/compression.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 678 ++++++++++++++++++-------------
>> =C2=A0 fs/btrfs/compression.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +-
>> =C2=A0 fs/btrfs/ctree.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 -
>> =C2=A0 fs/btrfs/extent_io.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 123 ++++--
>> =C2=A0 fs/btrfs/extent_io.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +-
>> =C2=A0 fs/btrfs/file.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 20 +-
>> =C2=A0 fs/btrfs/free-space-cache.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 6 +-
>> =C2=A0 fs/btrfs/inode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 455 +++++++++++---------=
-
>> =C2=A0 fs/btrfs/lzo.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 280 ++++++-----=
--
>> =C2=A0 fs/btrfs/reflink.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
>> =C2=A0 fs/btrfs/subpage.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 85 ++++
>> =C2=A0 fs/btrfs/subpage.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 10 +
>> =C2=A0 fs/btrfs/tests/extent-io-tests.c |=C2=A0 12 +-
>> =C2=A0 13 files changed, 996 insertions(+), 684 deletions(-)
>>
>=20

