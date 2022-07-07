Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BA656A1E4
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Jul 2022 14:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbiGGMXn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Jul 2022 08:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234925AbiGGMXj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Jul 2022 08:23:39 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B9C1837B
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Jul 2022 05:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657196618; x=1688732618;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=C5IlP37iMS9DgbArkwJjowCGPK6KcsWSfZMUawWyGfk=;
  b=U+JlyElpDrMWlX7I44Qu1A8m3C+0etghPr9Xb6SoNDS/5XbA2XYgmE6e
   pZ4f+2Jico2LHO8ZgAT0rxNKKXfdnd70RfNZaVMYF52n65mCLJVoPHvcL
   Xnr/hL0TUwjDnXEWqe6tI7Rf13vUM55KV4n+854HS1AvJPQF7iwrhfSxl
   lYVXOVZYhKkFmRUFJTIYacvk+yrYj5hglR5h8osf+Zok5P7Zz7WLYKSRC
   uJXzd603yW5hAcYmJNOENkFb8+7cgQv91m+aurzjC3qj10cokzm4LBmeG
   NnxByu2zvPZXzfifzWJqaOC3SfEVt5qAO67kDAHPnSfYhE8ev6L4mOgsW
   g==;
X-IronPort-AV: E=Sophos;i="5.92,252,1650902400"; 
   d="scan'208";a="309405993"
Received: from mail-bn8nam04lp2047.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.47])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jul 2022 20:23:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZsI8FQ9E5kUsNnYoyroyAmGCDYUJBlk+LC5CWX5VuIW8Ei4GWSGjvx2rR7dylbcBB5/GLiQdzaaK84Wvj2qz8hxncyPgAIo9m0sHymdXxaUfsM2UWSnvzC0XHC4CIPjec731gPoa0dQ0UjQppSqj1a3NgFtteBuBcwLgR2bRJ4SDS8SE3glB3wIJzofXDepO8N1h5TF1xM/Uveq0LYFyKn8qUg8w3ifkk3orRDzyXml4KF5J4P22diugDvlLKKxt1L8U7TixDSHdbldAVTqtN2UIxojN84TucbsFi5PTKhRHBZanerwoyp+kEjOs7J7fUAvUFNTVMqJnLbLic0AYgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b16iAPSGiBjqx9nXDufqt4yQFLTh4rqmgNOtzUUOILw=;
 b=Hs6qyQ9fD6NiQ/jLmti/2rgt0egumEBbFbNAeqwD8jiaBgpQ9Z8QRgRCgLOOBKhACazCbwrBsuc2HyNOopzc4cy4NT2zqx0j0GNC5ybax+wdiB9lf0ZThGY9a5m9j82XmX8Ibe9dPuaQny+e7tG3y23RgboOxzSHkmmvc5cCAZG6irxR96eFwmIQK7SVnHEtuIKE4cTzg7MZEOymQ6HNJIsr9r04sUt5tssx+1v2iewqC04T4hy0JOvSwwuOjSecTv5/MBc+xsSSxlWV9pqDalhrld1sr5PblhGLxKzFIu10EtbaCxU00kcsCwVZpSr9EOo/RLs15nK8R2dDMMKDbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b16iAPSGiBjqx9nXDufqt4yQFLTh4rqmgNOtzUUOILw=;
 b=qZ7My3WVMQriYFiqRhn4WHcBszfFiyT1ezGB2vW5vQOs1ZZHYYWW/woqqGRQRbcF9UOnnYNUb4H/xEDUO8rmXMtyDlXpdrw7XLJA40kbVMW0Ms3ZGoGdP5lPLdjlTHq7jgE1VH4C9frkBv+e8SMH0y7QhzqSQXdiQgEd1K7EcB8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB7016.namprd04.prod.outlook.com (2603:10b6:610:9a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 7 Jul
 2022 12:23:36 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91%7]) with mapi id 15.20.5395.021; Thu, 7 Jul 2022
 12:23:36 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "hch@infradead.org" <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 00/12] btrfs: introduce write-intent bitmaps for RAID56
Thread-Topic: [PATCH 00/12] btrfs: introduce write-intent bitmaps for RAID56
Thread-Index: AQHYkcM9alGZpxHAsE+tS/mKw9JDjg==
Date:   Thu, 7 Jul 2022 12:23:35 +0000
Message-ID: <PH0PR04MB74164908E78AA652481357E49B839@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1657171615.git.wqu@suse.com>
 <YsZw9O8fRMYbuLHq@infradead.org>
 <ba4c42bf-cebd-72e2-d540-c3b16e5485e3@gmx.com>
 <PH0PR04MB7416EDF3C4EC0AA72A2C2A619B839@PH0PR04MB7416.namprd04.prod.outlook.com>
 <f2179520-f8d1-d029-661e-56d4a33b5b9d@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d990dfa-e554-479f-6e19-08da601383da
x-ms-traffictypediagnostic: CH2PR04MB7016:EE_
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tFnyddOMf3+PFcSVHh0hh/SiFX9WkTEUNZUaFBSp6wE3dwzrlnvjV29dTXDPv1TMMp/qpyijp47fdadzuLjQBdRTJtl9zFqJz2h4waEr2tMJRRJAa/ncrYlu7/sbeiEBu+omgD/Np7WJ5kz5b7Wq1Mf5ZxwrIcihv3GXq+oJwLlS03u6Ne03kAYuxlGVFxFWkRSiFCE9YW9JNLNv2EXlD35ByygDaVDwlzdewQOYkFozKRcQJTHCEPY6V2OXzEMIX0LSlUViJ4L+6k8YoYd3i2P68Sfmxg7mlAPL+B54xNHlCqeqMxqpj+bwrkgCsP4AKGF+PTFfLaTHr8ACzFHzaCQ3I/tjtr+uboGn/7rlKmD8OJOoQDvWMRk2Fa9Ti4oGABaCqUcGA7evJV+T71me6jk/l1gtllt/3SlvTCW1mrbpMBjjsiBHMT73LiNixPVPX+YaDWvUGFlzELVbY+59/ePgs1I2pZIRG4NVWTxbN3Rk4hNAzcTjerQCACnbOfmAUXHTNm30LEBPOEK4UXx4yhikHHtzI4KTRQ7kLjpmUC+yl+u93qdDuxV/QChkr8PeidEyhm2EocP10Mju5jkqwKfhp8yctQDlgTX6uisjXrhUasNtJXYRk+ewF3UO28YEoW2czbn3hmTKfu9NDXYvB9mnWXQhs0XbF/JI3FAmAbbGhFjvttBtcpt2e3AZFbUxiyAwlre7pM4C1zcTX4H3Vo0DbI68n8kauDQalVsuzUpJ0nDA35C76yN5i+6tYqLBrdFkp75I2VitBvlYrYacHAJD3jXFKxRbMMwap7wqt6lC2L5dx+orrf+DxgWZOBNu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(91956017)(38070700005)(316002)(5660300002)(55016003)(8936002)(8676002)(66476007)(66946007)(83380400001)(64756008)(4326008)(122000001)(86362001)(82960400001)(9686003)(186003)(66446008)(52536014)(38100700002)(76116006)(478600001)(53546011)(66556008)(2906002)(7696005)(110136005)(6506007)(33656002)(41300700001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QDIp0NBgJJ1kgtz99nIzS2DXUaqOi+Jb8F8kudtfNWvDsGClnFD9QH3bV4G0?=
 =?us-ascii?Q?WWYAyj6oHqu20d+QKgzuNmz+YAW+lfV9OtbhUNPst+f52OQkTYIW02Jiana0?=
 =?us-ascii?Q?sgh1d+jJ+khQMGQAx7+YWWCE3BCHYHi6DmJ0zdqDh8OaOi6BhtJVHANSyQu5?=
 =?us-ascii?Q?grRbcjUSUW4VFU3ozi+9qA/VwjY5a8ZKwAFfPy+ZMQaRfBqiNAlFn4dDWtUI?=
 =?us-ascii?Q?2PwF85rnjM8ft4/Yz/Tl8EMHeLyalR6VB4elebHLkjILHIRsYnLDuPLslvcl?=
 =?us-ascii?Q?cbidVvYGd8I+5RmKHAIqITxUUOMZ0b61PptL0QdDemyuLzOL2qthfndeLnYF?=
 =?us-ascii?Q?Z7mC3lqiSvM+0/+EiSQs+stWhaS+IcN5IwS7uniVEs/9xrPL39TbeXHtc2Tj?=
 =?us-ascii?Q?m8rIoJjkeFfQI1Vom5CLgpU2KcK/sXPegZp5WGlrwH6FuV0wnvIEFiN1KffW?=
 =?us-ascii?Q?V17TtWbo9uXyuTQmbH2R7U+cdg5+XLPRWLEsQCUytdXpRtn9Co6LMokueDOU?=
 =?us-ascii?Q?t7SalW8bA6/Wr4h7S9sLn9vezlNAnMfTB397pz0n16OILfscgEAbtHca4KJL?=
 =?us-ascii?Q?tt5B9dVVTAuaPrlGZk0Jy89EZZit/2AFfFJeBb/HlZKF3euy8DrEKoXFg2DP?=
 =?us-ascii?Q?AaCcA9R9aM/iauNIyWkQ+P4uuzL/wWminLNu6nOF7VyZXP+k3Vvfc2uZnqPv?=
 =?us-ascii?Q?D88UvIoRpU/+u8eHwEscGBGvIzEbA8Yayh/3kmLxxcNXaDpV+zBh++qLE7iB?=
 =?us-ascii?Q?XidNj7KJItXhB176wxL/1EHXHD291EZH/pcyuI6u5Z7fKB929WDUSeNRwt9Y?=
 =?us-ascii?Q?xo/ftV3Csu58YcI1lo/7z2T7rsohYRkJS4qSumu2Q4oqZkHRlcH+N9c6vMHi?=
 =?us-ascii?Q?M7LPdeevNtCV2qpwb0wRGRe9qJxWQlGxwyxWEsTu/140RGGzaY5kkHpJ8g0T?=
 =?us-ascii?Q?p609faoZOQwL4mj//9La3Q5rqXupHeiPxBpkLpuMx4OIq7PRlxZvwaqxYlWM?=
 =?us-ascii?Q?H8i0v8C0J7SJ4MEKvfaj+DYoC0FfBlYVWO7pMyATqRMWUotcz7I55kx85P2A?=
 =?us-ascii?Q?tkWjTBNjBxIgbYsts1g61sdlVC6Jr1wfjsXLWg9oRuRnuetwsz2mT1Z3Rb8r?=
 =?us-ascii?Q?sRJms1lpbOaXj2f5CXvHlvUNiLFZYeZ2djc1R2rQC29LwPqdeF1nzFCzlW8Q?=
 =?us-ascii?Q?PMVB5c4yOGIDo9f2e+CrYnbu8UupNz7y7QEYDhHnwBPJN5lD1gZ2zNR7qqXN?=
 =?us-ascii?Q?/mu7c3AfYw+KnKr6nT9tQwTrxVsgv1bBVLy9w9dWk5+bpvM4naNhJbwFLC5h?=
 =?us-ascii?Q?Prp/q4Xz3LD4wiSGwrweWGieU2a+M5psqqpvarKtRqQDc3txLMHZllgDRLnK?=
 =?us-ascii?Q?C8mkOydm9fBWvvr3kI9xTjxDcMbTQ8xh8CkmoZt6Us6eNZ9/grBYZyvDB0gb?=
 =?us-ascii?Q?bvhYcWzPFd6R0yT1Kfty52EF87aGFnftPxEv1NPtK5uDxJAkdIkv032JTgcO?=
 =?us-ascii?Q?8UQuWuNuKIyoH3FhVgDNjhyZde4lY4a1dl+YWnapJEdVRmG5beo7aPyWzToJ?=
 =?us-ascii?Q?QXEOfkGapOsinSsRbxN9D0LvassxuPz64ieRRSFIQtc1IJCCvFwFjBJc5k4t?=
 =?us-ascii?Q?1wIROxeYPoqwJQvjgH9dskE3+J7G97LNfsutRczn+0w5xdHBuZBHOyB1Tbym?=
 =?us-ascii?Q?J4gl/Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d990dfa-e554-479f-6e19-08da601383da
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 12:23:35.8965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p0j0kCF7IRsOCmaQvMZetJgwOtgE/V4zI0HE4thFKRyxkCXhvxtsmm3WrvygUWwob7J74BNWg5jGeL+mPv2MKSMR6R/lvmUHGKn26n98MHg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7016
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 07.07.22 11:45, Qu Wenruo wrote:=0A=
> =0A=
> =0A=
> On 2022/7/7 17:37, Johannes Thumshirn wrote:=0A=
>> On 07.07.22 07:49, Qu Wenruo wrote:=0A=
>>>=0A=
>>>=0A=
>>> On 2022/7/7 13:36, Christoph Hellwig wrote:=0A=
>>>> Just a high level comment from someone who has no direct stake in this=
:=0A=
>>>>=0A=
>>>> The pain point of classic parity RAID is the read-modify-write cycles,=
=0A=
>>>> and this series is a bandaid to work around the write holes caused by=
=0A=
>>>> them, but does not help with the performane problems associated with=
=0A=
>>>> them.=0A=
>>>>=0A=
>>>> But btrfs is a file system fundamentally designed to write out of plac=
e=0A=
>>>> and thus can get around these problems by writing data in a way that=
=0A=
>>>> fundamentally never does a read-modify-write for a set of parity RAID=
=0A=
>>>> stripes.=0A=
>>>>=0A=
>>>> Wouldn't it be a better idea to use the raid stripe tree that Johannes=
=0A=
>>>> suggest and apply that to parity writes instead of beating the dead=0A=
>>>> horse of classic RAID?=0A=
>>>=0A=
>>> This has been discussed before, in short there are some unknown aspects=
=0A=
>>> of RST tree from Johannes:=0A=
>>>=0A=
>>> - It may not support RAID56 for metadata forever.=0A=
>>>     This may not be a big deal though.=0A=
>>=0A=
>> This might be a problem indeed, but a) we have the RAID1C[34] profiles a=
nd=0A=
>> b) we can place the RST for meta-data into the SYSTEM block-group.=0A=
>>=0A=
>>> - Not yet determined how RST to handle non-COW RAID56 writes=0A=
>>>     Just CoW the partial data write and its parity to other location?=
=0A=
>>>     How to reclaim the unreferred part?=0A=
>>>=0A=
>>>     Currently RST is still mainly to address RAID0/1 support for zoned=
=0A=
>>>     device, RAID56 support is a good thing to come, but not yet focused=
 on=0A=
>>>     RAID56.=0A=
>>=0A=
>> Well RAID1 was the low hanging fruit and I had to start somewhere. Now t=
hat=0A=
>> the overall concept and RAID1 looks promising I've started to look into =
RAID0.=0A=
>>=0A=
>> RAID0 introduces srtiping for the 1st time in the context of RST, so the=
re might=0A=
>> be dragons, but nothing unsolvable.=0A=
>>=0A=
>> Once this is done, RAID10 should just fall into place (famous last words=
?) and=0A=
>> with this completed most of the things we need for RAID56 are there as w=
ell, from=0A=
>> the RST and volumes.c side of things. What's left is getting rid of the =
RMW cycles=0A=
>> that are done for sub stripe size writes.=0A=
>>=0A=
>>>=0A=
>>> - ENOSPC=0A=
>>>     If we go COW way, the ENOSPC situation will be more pressing.=0A=
>>>=0A=
>>>     Now all partial writes must be COWed.=0A=
>>>     This is going to need way more work, I'm not sure if the existing=
=0A=
>>>     data space handling code is able to handle it at all.=0A=
>>=0A=
>> Well just as with normal btrfs as well, either you can override the "gar=
bage"=0A=
>> space with valid data again or you need to do garbage collection in case=
 of=0A=
>> a zoned file-system.=0A=
> =0A=
> My concern is, (not considering zoned yet) if we do a partial write into=
=0A=
> a full stripe, what would happen?=0A=
> =0A=
> Like this:=0A=
> =0A=
> D1	| Old data | Old data |=0A=
> D2	| To write |  Unused  |=0A=
> P	| Parity 1 | Parity 2 |=0A=
> =0A=
> The "To write" part will definite need a new RST entry, so no double.=0A=
> =0A=
> But what would happen to Parity 1? We need to do a CoW to some new=0A=
> location, right?=0A=
> =0A=
> So the old physical location for "Parity 1" will be mark reserved and=0A=
> only freed after we did a full transaction?=0A=
=0A=
Correct=0A=
=0A=
> =0A=
> =0A=
> Another concern is, what if the following case happen?=0A=
> =0A=
> D1	| Old 1 | Old 2 |=0A=
> D2	| Old 3 | Old 4 |=0A=
> P	|  P 1  |  P 2  |=0A=
> =0A=
> If we only write part of data into "Old 3" do we need to read the whole=
=0A=
> "Old 3" out and CoW the full stripe? Or can we do sectors CoW only?=0A=
=0A=
Well that'll be an implementation detail. I'll see what I can come up with =
=0A=
to make this working.=0A=
