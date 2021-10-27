Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52A843C40F
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Oct 2021 09:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240524AbhJ0Hjr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Oct 2021 03:39:47 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:38983 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbhJ0Hjq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Oct 2021 03:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1635320242; x=1666856242;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=pzlGULnj4ezaZA3eqYsqzEXfgAuclDqMfNooAdqvXpc=;
  b=oYrXPF3Tcfu+MDyQ5R5EqFZnMnslItZ2ees2rBvaFF5Yd0LZIfQfa2Hk
   NbFSUHVeTWKBIgh8gNOh4mCdHmQgbFrY7/B5d1bVPKIJt9ktT9ZRabHQB
   kl4Re4WCR6IDB9ZyzLnVUwFJubzfAHXN3eo21BRXbehQwwQRza2YUDbED
   JGLPGDe+bXKf8FUleiLw+BSuxMLTuskvafJhT3M8u7YZSBd/2JSHP7Xzh
   3wlJXfz3CzzK86qbp7FUjd2o56yFzmnoBdsWKqMeWOG36/iFzq/+VpKpr
   KfWNRXDhNbBqpoWdgFR/KKPLWWRtW0Doj/Qp+qrytLSNgJt3bhjdzXd+u
   g==;
X-IronPort-AV: E=Sophos;i="5.87,186,1631548800"; 
   d="scan'208";a="184884582"
Received: from mail-co1nam11lp2174.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.174])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2021 15:37:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CH1cEFkh6/3E+JsA6+jLKqplSJ+5XrEEXMpcVKRCVYxYBjBf95l2I4775/2dAe2lHQt1uP1qrXs4dQC/CmTdpgNmOJj1b/9mdpo8UG58hDCK5E7v3vwc+/UrUdXJAacneuw0ISvpPtN8Wyd4b5TmGpJa8/WmgcXEE2pBHLceP7O+QNqsFFsOZ5nFsChHgiQJtqtt4jw2P06Lf0iCF3pUZRN0hprKEc4HtMnzqQ8emdiaLitf4H+23fVTg2o15v1z9ZedELChHw9F8peQkQLNn4i6BHUtXHIRh4Jxxysk4Eugk7dF+/YrerrMpf4HppTmtPLP87V6dbJyttOWSFcUgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wwHjiakSQ38PHyB0gQzi98h5ri+o8UKvzle1LAtrQPo=;
 b=dHuUdcmGqB7blqwx8JtEXCDHJiz8cALFddgXXMbsfU0H6BMfL6+Lcd1uD2oWGDcr/hgRlVRHBh8D61McAqRgvnYURTNFu9slzedu4HnhjHeS5RfTQecaKAzMcFer2kiDdynaeDkWsKS/0RXEGufDvFI+36GtX9jNJkIHR+JPXoGJwNH3KWmkc2BNZcWVRWbWNqAWdn4yyp31J9lK/+wf9a2RCelK9zaVJ665iBVLy74+nF6NaFfdgcE0IxVteqHX91TjsBEv6yqU7Le5QiuukCjn9ELYiOSPbOWQdy4rikUJX+ZrZtX3nYQffqqlR5+ANIpddCqj6ZMBpGcPbOkyLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwHjiakSQ38PHyB0gQzi98h5ri+o8UKvzle1LAtrQPo=;
 b=nhWUbsasRx0Sw8R6deO73I3K+6brRvrTuLeTQUw+f7C6m+FwBuEvX+Ulp9OFFjAMHHtiPlTTtu68tgSFXoICnO6QbZTatc1QA1FzwHlx7gtFS7/skkSYnc99zEA7Gz6jpo/F0/40DT2LQ9crqhkKB0fkCrjKKs8o0qu3BvhIAdQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7606.namprd04.prod.outlook.com (2603:10b6:510:5b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Wed, 27 Oct
 2021 07:37:18 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::79d3:3357:9922:a195]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::79d3:3357:9922:a195%7]) with mapi id 15.20.4649.015; Wed, 27 Oct 2021
 07:37:18 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Stefan Roesch <shr@fb.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] btrfs: sysfs: set / query btrfs stripe size
Thread-Topic: [PATCH] btrfs: sysfs: set / query btrfs stripe size
Thread-Index: AQHXyordsU5W6HCCtE+CLExpPEpQgg==
Date:   Wed, 27 Oct 2021 07:37:18 +0000
Message-ID: <PH0PR04MB7416288E25DF11291B1B10E39B859@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20211026165915.553834-1-shr@fb.com>
 <PH0PR04MB74165B2A0D395AD9A45310C79B859@PH0PR04MB7416.namprd04.prod.outlook.com>
 <9a0a442c-8409-3401-da85-9032259a7bc5@opensource.wdc.com>
 <285f0f7f-a2df-7f23-2ba3-8ad3c12293ad@fb.com>
 <PH0PR04MB74165DE04219D13232F3D9CE9B859@PH0PR04MB7416.namprd04.prod.outlook.com>
 <44bf1de4-53fd-74e8-a204-ce12e33722c5@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fb.com; dkim=none (message not signed)
 header.d=none;fb.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a712cfb1-e7ac-478e-744f-08d9991c9b10
x-ms-traffictypediagnostic: PH0PR04MB7606:
x-microsoft-antispam-prvs: <PH0PR04MB76068A83F626D908D7BEFFA69B859@PH0PR04MB7606.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x1cWCb5eldGEdVvGnUralJIe/jslFiAym9ppiwCCNQGYAr2I2LsrTfSXbGmr2E9xWUeUmUMqqqCaqAiCw7GPpoA/M8ZsD6knK4ikDbCikTRzWgsgrcuGFxQLmvjRhDu58QjB0BQh+z9PdaIlAoFsBo0UbB2yrpudznUWdl4I2Z2nx368ThQ6hccRRa9OJwPTVBaMSVH/J9lMIhLj0B6Yr6CbkVupFhFU5u08j+g85NDzGAY+Wnrc6hzaIrufrLZapJlOdKT+nW59v8rm9h0/7gXc+XDdHiuXWmfeUFzDep68deSZTyO4MnvLxMTF+54pntnnkAkyyjcfrHvtNJHAJEda6JzuojPcIQbKUEDtNYmXw1O1u+9TY/FCKmZW6wx5HSBs4cf237w/Q+M4eseFQb/3tbXdGrtW73v7d0LjYb1jmpczrcnom6TOcipnO5QoRwXwUOcWobm159pUrqLnXBUaiQHIDggEHdwA9ihkZkFlJMMCv23aSN5IR6J6Cq0j7h4NgYPlgqhc+47rUjUduKmJGOvk0FnqyAE3xb3m4Fj5tdaDIg+Rw9lvjpVSOWr0keTRbCKa+vDxZVUaASzEN14nl6KQVNFz6hYcn5gKebYevZsWuy7fxIeUPZzTYrh0lvBqeTWbR+a3z2FeWUWhK+lg33eLaJ53pitYhdVnlUvaxcDrptyZ4L/ywg/lWL7XXgbGH0mvBrSUSWNPIhgISA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(8676002)(55016002)(52536014)(83380400001)(2906002)(64756008)(66446008)(186003)(4326008)(508600001)(122000001)(316002)(66556008)(38100700002)(7696005)(9686003)(110136005)(5660300002)(66476007)(8936002)(82960400001)(38070700005)(6506007)(53546011)(91956017)(76116006)(71200400001)(66946007)(86362001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Af7ntpp5bdDuItXNSu6gL1L611fPxGDl7FeN7W+2cXDXx0UVU6m9nib4wPD/?=
 =?us-ascii?Q?GI002VprXDQq084OhorJZmOnR/D5a67bJ5sgvrrk68ZeRrvF74TnoIpD3Iyu?=
 =?us-ascii?Q?LTpfW36pDxWom46gGhp69j4S/p+Z2+AA+PJ9wZ+jBSdS/s2YXlO2imaEsaNf?=
 =?us-ascii?Q?G2OUAOkOxP7UPvDtMSVTbvkks7JZWNeLHSVp8ThA5e4MVemid4qeP1zY1aTM?=
 =?us-ascii?Q?yuNnAoAlfPetP82D8LylgJzCJ3WJgZ8fQuaEog30wLZ2ZF3kVJiHnJUHobpp?=
 =?us-ascii?Q?B4p1DM9RoktdHI7Gt/IkEtOQMse0vEjQvNifcwPZdC0rCNakrP4QuA15yydV?=
 =?us-ascii?Q?cg2uIWJWsLTRwFk978xqtZvvqu4hj/yVyw/Te1fQsnGc5ElW6i73BONNmdxL?=
 =?us-ascii?Q?CHqp1CsQZx2/EMA7tqYzfCgyUl8dGW4/bQ0DTaD7Qp5OPTDGzjOqcDl4bYg9?=
 =?us-ascii?Q?GzS1oW0xaDuOmXZRmkwM41ZMqHck+QPe+rs24q7jZHCxGVSXVIEkIEmvtk7+?=
 =?us-ascii?Q?+EA7KGikl5az+YDfV7hgk0kNN40Yg51ZMYdAGfzJ9FpbaXm6/1ITecKqFcvc?=
 =?us-ascii?Q?fRedu8FM85vgDnbrU1Rd5a9LuqMJmbYagHL+bS4oZGIB3+9TJZuhOjwONfqx?=
 =?us-ascii?Q?/WCebNyJwbFGEzuiOXJATe1dViIq5HxQhBfvVPuZUMUsfjVxgptz9od5TeRS?=
 =?us-ascii?Q?C4N2PjF0l9xxN/ZKkVmEHrNXJZLl+Szi5fMQ2AQpYzLzPS65fKAOd4vtMsKB?=
 =?us-ascii?Q?V5K62fNa3P0yHWTV5B0vjMqTmQX5V/nH0TUqTck4T2pG0fm0JZkBewvSsgFG?=
 =?us-ascii?Q?zGNOxIPHi+WoxYqnZ+LS6r0sZyL85bsqrDmE2wXjw0lpQbV1PbbILUMm2Dtu?=
 =?us-ascii?Q?ChZ/itcpuY8qE2FcgPum55oQnOEjy/9tDRD8x84CCh6PeoWBSqDW1R+LVJ4m?=
 =?us-ascii?Q?aup+jPUNnAfd2qX6Ilz+fB98FG76QoAnAOEsiZBBf3awsoFzUlsxFKNZDK8d?=
 =?us-ascii?Q?29/niOWWpd2rxbvZKLDmkjdqmOBTodBMTckotAC7iwbUu7Kh8X07vv/u1IMu?=
 =?us-ascii?Q?2I2rCKuVD1MitflOp0YwDnDBu5IelgegdduawzPpL45OGkhVhoSYGPJiCOJQ?=
 =?us-ascii?Q?nhEnY83Xvjz/zPpGRfvMewmq2kIKAhxZWSZp6ClLcv8K2kDSwaTQZccGcrK3?=
 =?us-ascii?Q?pNzXTyC2aCsIJiszfGOXe3VMguKahS2atyr3+V3DoFsBJ3KklF7nS2d8wSMd?=
 =?us-ascii?Q?gRp6KRNeZNox2vl69wgl6VXCC8mnLAWlgA4WslMkucTkmhY5JQp2WTLzdvln?=
 =?us-ascii?Q?7lFhJLqdmAuCLaffHXMTNwXabBu9UPrAouHCEn3nnigqhC1aNlnW5psJojXb?=
 =?us-ascii?Q?1W3jaj8xtihzpl/u0zRVPlOgqGCd8GmB00uAEqGosBl4zjAMBbjPz96FGiAx?=
 =?us-ascii?Q?bR/ta36uw9V0AKBshaAIgs/OEwvAQUGArqLIzAnohCfxIdkcUvOZXvKGpe0e?=
 =?us-ascii?Q?hrxjv+hcJoRmAmCTcPk4n01FgG+zijxsLF6+LOKh/HBHCo9Ff5IsVEpXsGbO?=
 =?us-ascii?Q?sMJr3W2oN2O6uIoGtl7q1xiwHiNrFYvOqbyYyvbhqiALOIbyU0aw9BiNvo72?=
 =?us-ascii?Q?XNt8WqHRdeL8lEv3cmSkyUMEDcS35wVo1T0u5AiCSiWtVnuKNpPFJ13IHgqR?=
 =?us-ascii?Q?UP0hvtJSFJrQFObnph8kwR6vPDA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a712cfb1-e7ac-478e-744f-08d9991c9b10
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2021 07:37:18.7474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zsis9MzMpM+6hS9L+/+deRNNNwr4ibeuaIs0fUZfExw1sa4iJs9FHfrm6Zy37Ba9BRpTPyg5VVkIQHaIwwpJzH8Ztow35m9ux4aFHRODA/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7606
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 27/10/2021 09:19, Stefan Roesch wrote:=0A=
> =0A=
> =0A=
> On 10/27/21 12:09 AM, Johannes Thumshirn wrote:=0A=
>> On 27/10/2021 08:59, Stefan Roesch wrote:=0A=
>> [...]=0A=
>>>>> static ssize_t btrfs_stripe_size_show(struct kobject *kobj,=0A=
>>>>> 				struct kobj_attribute *a, char *buf)=0A=
>>>>>=0A=
>>>>> {=0A=
>>>>> 	struct btrfs_space_info *sinfo =3D to_space_info(kobj);=0A=
>>>>> 	struct btrfs_fs_info *fs_info =3D to_fs_info(get_btrfs_kobj(kobj));=
=0A=
>>>>> 	u64 max_stripe_size;=0A=
>>>>>=0A=
>>>>> 	spin_lock(&sinfo->lock);=0A=
>>>>> 	if (btrfs_is_zoned(fs_info))=0A=
>>>>> 		max_stripe_size =3D fs_info->zone_size;=0A=
>>>>> 	else=0A=
>>>>> 		max_stripe_size =3D sinfo->max_stripe_size;=0A=
>>>>> 	spin_unlock(&sinfo->lock);=0A=
>>>>=0A=
>>>> This will not work once we have stripped zoned volume though, won't it=
 ?=0A=
>>>> Why is not max_stripe_size set to zone size for a simple zoned btrfs v=
olume ?=0A=
>>>>=0A=
>>>=0A=
>>> My intention was to not support zoned volumes with this patch. However =
I missed =0A=
>>> the correct check in the function btrfs_stripe_size_show. The intent wa=
s to return=0A=
>>> -EINVAL for zoned volumes. =0A=
>>>=0A=
>>> Any thoughts?=0A=
>>=0A=
>> Hi Stefan,=0A=
>>=0A=
>> struct btrfs_fs_info *fs_info =3D to_fs_info(get_btrfs_kobj(kobj));=0A=
>>=0A=
>> if (btrfs_is_zoned(fs_info))=0A=
>> 	return -EINVAL;=0A=
>>=0A=
>> But why not just set the correct values for a zoned dev and show them?=
=0A=
>> You can still not allow setting new values.=0A=
>>=0A=
> =0A=
> The code you proposed above is what I already have in my local commit.=0A=
> I can change the code to initialize the stripe size to use the zone size=
=0A=
> for zoned volumes. Then we don't need the above if clause. =0A=
> =0A=
> Damien mentioned that this should only be done for simple zoned btrfs vol=
umes.=0A=
> How do I find out if this is a simple zoned volume?=0A=
=0A=
This would even be preferable. At the moment we only have simple zoned btrf=
s volumes=0A=
(no striping, RAID, whatsoever) so it's all fine from your side.=0A=
=0A=
Once I have striping working I'll take care of it.=0A=
=0A=
