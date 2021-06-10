Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0385C3A2701
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Jun 2021 10:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhFJIaW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Jun 2021 04:30:22 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:20638 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbhFJIaU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Jun 2021 04:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623313703; x=1654849703;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=0iU870zn+shlaNG/jpIoIywz7kYD36bVpcsTO9XZqmM=;
  b=rvf7Q6zM4KToOjbbUdckZIUM8ndQ+NuBZeSbmYr2inXNtlc8CCo8HMoc
   0cGK/vu7g1nNW8GhlLlG+ogzXoR01xQ+rZVxesINIsQVBIlB0zkhAdw5l
   bE/RFQskCKu6WmxxKLXy858PGHB4CSOFG4kuxQp0nN59zplsuHcxN9aiT
   1AkI8zlkmUFdeIb7SO0g2fWGwJjb+Pxni33AZNgLOe2QyDTCjmyuYdD7S
   GEJwoFJyrvlRA09EYqB3OJWgsChN4vr4GN5shFHqjxKv9L5LQwxg8tZqE
   ITughA4KNlVAdH6xrvbaZFSAJyTLJ6c70fYOWFg83kwHFsOxUJ3c0pTjV
   w==;
IronPort-SDR: YJxeM9RLR6olqYVy3JY/8j5RnGyNzVVczVpPwKDh92tq/UGh2gKa9y8JHIhl9+VydobmJBzOKe
 JhkmjasyQGBTLzcLGZLLgkRZYx0LnwRmay/Snwq5ieujvQVfT/8dCfh4X9F1+nVxIT0Dhznx0N
 IHzHnsw9muVzwIRq7gIt9fVIMd9mzxABML+8WYSyakgBHYmyF2n5Rf6M9vj+M27U1DbNSRyMK4
 ScvA2Ygu+CMwi+6HsL0KQrkgedNtQgZ8G6+lCdBYkQ0nXJTUj+kuouw4L98mW6JFIxCmUZZ7BN
 OCY=
X-IronPort-AV: E=Sophos;i="5.83,263,1616428800"; 
   d="scan'208";a="171427077"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2021 16:28:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1g7kfRU4AEseG6egu6fU9PD8FWfj02RKcl4P/ynQ9aCsG7J+65976WrjEpO9K90V3Mvh+gHH5kzl6aGxGm4aDzPCQa8hd80SEdOt/ulcG5J202mMR0gSPCChMWuLFaioS7gMt44S/0bmMV8zeRJxnjbExBVZviL2ddgD36cSTVHfPANJacdeN3kl/IEMavwzglrjxywp81pRQC9kwaOX9+9XMs0Ro+nMHFLOzKB1QeJNu4kvQBVhK1oINOk0qVX8ex39EGUsLe/Jcz6l9lM3L4mFk8EDkXYh2zDL9NZCSGIDJ73hIYJPrqUQ7bQpxrnfxXeLE/2OSK6rcEzmmujlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRQgbuyTdWjFoe2ssHO+y0fj0UnEEqyz75LhqJC4JIs=;
 b=DQ9FSytYAyASw4wrxRtCRB9z5oeosezJvzRcX1wrxAYjUkwctJgbfOm9rhjxaTjMSjOh5fh9KjM5IlukZbbCjZiZzqFNK1uz2sqnHvcsqLi8YcRbZmzbWYZM0v866CnvRHZ79QXrshQ83d9x1KuK32WWt9GUK+btfJ8ntqqlUtqlp3JIrBmxo64RvIXXFxJU0m3wNOkS+NjlY+R2H86aVgJozM8LmwCUmGT7B2xBuaxWKDnAC6d++LFqGxCEZRb9Vozkofuwk8TAYb1xfurQNZBFlRlXWZvzMSr3D5VgkNE27umD+f4VIJAjpozp2ydAFRzJ9m1yBAVoJpTphJXmnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRQgbuyTdWjFoe2ssHO+y0fj0UnEEqyz75LhqJC4JIs=;
 b=qN3X93rqhBU2ko9c7xfzBHAMI4FZTVP4ubc3d4ACKkq5vwbbJxCdNcLeLHwQG6XN5yn0Zm2PHy30tk97qy7v5HOnIYkrjWSl+4fyjAldEw6wsgkutyNPVysbWEn6N5l8fRKf7xhgDKGss4a6eLrXKy00pLePGwem/TNIIAhVMOc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7637.namprd04.prod.outlook.com (2603:10b6:510:5e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Thu, 10 Jun
 2021 08:28:20 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4195.031; Thu, 10 Jun 2021
 08:28:20 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] btrfs: zoned: fix compressed writes
Thread-Topic: [PATCH v2 2/3] btrfs: zoned: fix compressed writes
Thread-Index: AQHXS/wyoE+7u2fw/k+3p3TOtvxw4g==
Date:   Thu, 10 Jun 2021 08:28:20 +0000
Message-ID: <PH0PR04MB7416687F366BAFA48E0FA3EB9B359@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1621351444.git.johannes.thumshirn@wdc.com>
 <1220142568f5b5f0d06fbc3ee28a08060afc0a53.1621351444.git.johannes.thumshirn@wdc.com>
 <9464ea87-6d50-9015-a6f5-c7b3d61458ca@gmx.com>
 <DM6PR04MB70813C91EEB7952FC3EF917EE7359@DM6PR04MB7081.namprd04.prod.outlook.com>
 <2ceddf4f-f2b9-fe7c-0201-46835cc27c45@gmx.com>
 <DM6PR04MB7081051CDED378C54A364E68E7359@DM6PR04MB7081.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:141b:f301:e91f:9de6:cb32:f149]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99377ac1-db54-4391-90e0-08d92be9b48a
x-ms-traffictypediagnostic: PH0PR04MB7637:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7637568DC799846BFFDF65A29B359@PH0PR04MB7637.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nZ/xuo3YCWIFrcugEAdYVvzDNdKYE9Ek6HeKFcOCBJm+85KDRxNpgJeoLIWZGJQZwCd1O+oAh9PaiVPL1+yPMWOSVWgB2zmfrN0oN3z+9TSts8mpFqzDu53YAM5stigFtLsSzA1LkZDhPiixYN6vS/xSneY0o0R+KEpzo62fTdmaMKFIOzxLN6x5k9qtNBYfl0NMtMmQ25fbyctAB5A/tTOeDEvyF9EB80RUMYDxfLHWAQHsttMqm48N111Vh3+Qxi149LZlXmzIYYKWSC3CG+ig1v9sZvGwrJdKS55PH4riAZn215bdaDOJu7RywrUVAayrolJxQEaN9qFPSFGrRk1oit/9qxBzYn10yOtpisPz/M9IKJBYjwwyJWZlnTUvgoojPn0XFG+1GbDfksI4COmwlE9CECLwnHMFtDE498IBcMcFr3f6tZ3wS2XPXv0jr4AESikqBm81DIBhXvysYZ9N4M20ethWpR25FjY5orxCZnyz3+mOXQoQJdhbV9ceoQtI7zx525FpbMB5eT3U1gMn3VWDOJ2bk81xIngKu3+ZcFlmrOFYAVXerNFsSVVlXnTihaGE1efVI66bsnDCIEhiEkyvRKGdsT7l+glVei4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(5660300002)(52536014)(33656002)(2906002)(66946007)(478600001)(64756008)(66446008)(66476007)(66556008)(7696005)(6506007)(186003)(38100700002)(122000001)(53546011)(83380400001)(8936002)(110136005)(316002)(76116006)(55016002)(9686003)(86362001)(71200400001)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?ZnRzNWR0TitodTBZcHNkNkRaL3J0dkFOeGRCTTJjRkVmVTRFYi9QbHlV?=
 =?iso-2022-jp?B?QjRMdm9LbHNmRU8waDRUeUJvREpHVnBUaHJKWmhrYlR5WkVWNmRpUHdK?=
 =?iso-2022-jp?B?MDgvUk5Bd3lyS094anYrRUR2Vkd0dXNuN1VYNnd2RmRNTzlkUENUcWwz?=
 =?iso-2022-jp?B?b2lVblNCcUlRM1JCcmh6YTcyUTRlQVRzOXdMcVUxa1k3SWZISFRnTTE0?=
 =?iso-2022-jp?B?VVpkR1J2QUptVjRiZ2FoVEU1a3dKdnRqeWlwQTFJRko3NlFlU3BndEQw?=
 =?iso-2022-jp?B?ZzhTVWUwa1AyNHl4QmgxME9mVmJtUVJKaGI5MVBQUWxyR0NHOVVlSm1U?=
 =?iso-2022-jp?B?cS95Njc1d2J5dXlLUG82K05XazJoK1k4YXN0ek9qRkVsc1RLMlJkSHY3?=
 =?iso-2022-jp?B?blhyMVFITktkaUhQaFg4UUlCRmxTMjlNTDM3am02bG9xMTNndy9yNnhQ?=
 =?iso-2022-jp?B?dlRlN0QvcDF1NzBIc3VmR1FSZzJqYlV4cUZOSTF3V2xTcmtUWGVxM1FY?=
 =?iso-2022-jp?B?czIvR3JLbElrUG9rbGFLQ0VyeUIxQjZsMm1NSVQrMXBwclNtOWMvUDRI?=
 =?iso-2022-jp?B?cUlPaTRVMEU5SnZ0QzU5RjYvRVpvczQ1WGNoeDJSN1FHSGtvNnVSck4v?=
 =?iso-2022-jp?B?SkpoYkw5SGpoU1dCWUFpTlJTbDZFeVJwbkhlWFdMeGRTY1NUcnQyZ0Qx?=
 =?iso-2022-jp?B?TVBWNTJoSFdFQ0lrM1FZVDJNUG5rUXBRRVE3TVpPV2VqRHYrV0o3UTNt?=
 =?iso-2022-jp?B?eUJEK2xTbmRWcVVoaEZpbWlnZXg2NDN2b0pOc2FzVHF3TldaUXVYam02?=
 =?iso-2022-jp?B?dmdmRUE2RkMrazdtVlF5NXAzYUM4Y2tIaTJlWERSbEpYbVhTZStKUUUv?=
 =?iso-2022-jp?B?MTV2MjJzRnlYLzZUSG1WOVFhOHYrN0gySzlta3FQWGJ2RFpTRW1aYTQv?=
 =?iso-2022-jp?B?Y2M2STVkS0VUU1JMWk82QUlWK29VazY3NndrdUw5SWNCMGV0cE42N3pU?=
 =?iso-2022-jp?B?OW91WVNEc1V1S0E4eDFRMWZuNWpzYmRzMlVrNEZHaXZxNFA3cG1Bd3dL?=
 =?iso-2022-jp?B?OEZhREh1UlZzUzhWS2dJSjMvZjdDWXhPQjlJdVV4RVczNDNxdUZ2UVFZ?=
 =?iso-2022-jp?B?S2JJd0xTcEVtaHMyaWp2YTR6UEU3SGgyaVR6dUVQcEI1c0NmckcyRFVQ?=
 =?iso-2022-jp?B?TUIxcWQ5Q1pqZWthYnQzaUw3Qi9ubVN2OTI2bmVJY3lFZTEwbEl5VnFt?=
 =?iso-2022-jp?B?SnBEWjVxTWJ6S2l4ZkdNd3hVOVg4TXdZWkRmRWRxQXFHNTdoZTZpWkNV?=
 =?iso-2022-jp?B?REhXYitJZVZsakFJb1dUcE9ldWYrUGsvTW82a2UvZWdHYzBLWmVrQmhw?=
 =?iso-2022-jp?B?SkY2MUh6UW54THRXeHFCWjlTdDIwOWVqNnBZSVpPSmVQbzlDWjdLUk9y?=
 =?iso-2022-jp?B?Vys3cks1b214a2lXazZQTisvRlczVEV4cFNLaGh3TXNlcXVPUVpKN0Zu?=
 =?iso-2022-jp?B?eEpPdUZHTmt3eUM5ckVhbVVwaWRoellVYWNxWVd6M3I3TksxbjV3WnZ6?=
 =?iso-2022-jp?B?K3FJdk5HeG9uczVid2NoYnphbDhpWWQ4ZmdiU1FJcFZ6dURhL1liUkRK?=
 =?iso-2022-jp?B?Y2QyR0tDQXdBNCtGM3l3Z3p3VUd1bldQU290RmRKalB2SDhUQjVmT0p0?=
 =?iso-2022-jp?B?QlNtVG8yREpQZ0dLV3lsZEtMVTlKaUpvVHdNcXdmcUhXcU1qclFZbzZZ?=
 =?iso-2022-jp?B?dmxZUlcyYU5haUNlVGhKb1pxOXlNTTMyY2V4Nk5mVFlsQUlwdTI2dVR2?=
 =?iso-2022-jp?B?NlVNTVhEWVVnK0QyK0FsZVpWNDRxNUtqY09QUUNaaHo1d3hMWC93Z3g0?=
 =?iso-2022-jp?B?WldIRi9jL1RrWmxTS0FSakRiNFVkeUpZR3lBNDNyNUMwRHhVMUlKT2ZE?=
 =?iso-2022-jp?B?bjc2bTgrZmVhOGtzYUpoU0xTZGREZVFXVEVuSXYyWlFueklXVCtHV0VM?=
 =?iso-2022-jp?B?SnhEL1JrVHRHb2xBZmI2emJkM3lYNXorVHRUMStCN3MrWHBOeXhFNUl6?=
 =?iso-2022-jp?B?SEE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99377ac1-db54-4391-90e0-08d92be9b48a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2021 08:28:20.4546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VYjZqkqAsfHchwZbkB7kTAGXw22V5tAZzZ9fhShBC8gt8oHVDkO/rzJqC7sCTIQ36t7uRVQATxCAPkryWDf/rTEjb0XIcsBQhNKE7eQwJ/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7637
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/06/2021 09:45, Damien Le Moal wrote:=0A=
> On 2021/06/10 16:41, Qu Wenruo wrote:=0A=
>>=0A=
>>=0A=
>> On 2021/6/10 =1B$B2<8a=1B(B3:36, Damien Le Moal wrote:=0A=
>>> On 2021/06/10 16:28, Qu Wenruo wrote:=0A=
>>>>=0A=
>>>>=0A=
>>>> On 2021/5/18 =1B$B2<8a=1B(B11:40, Johannes Thumshirn wrote:=0A=
>>>>> When multiple processes write data to the same block group on a compr=
essed=0A=
>>>>> zoned filesystem, the underlying device could report I/O errors and d=
ata=0A=
>>>>> corruption is possible.=0A=
>>>>>=0A=
>>>>> This happens because on a zoned file system, compressed data writes w=
here=0A=
>>>>> sent to the device via a REQ_OP_WRITE instead of a REQ_OP_ZONE_APPEND=
=0A=
>>>>> operation. But with REQ_OP_WRITE and parallel submission it cannot be=
=0A=
>>>>> guaranteed that the data is always submitted aligned to the underlyin=
g=0A=
>>>>> zone's write pointer.=0A=
>>>>>=0A=
>>>>> The change to using REQ_OP_ZONE_APPEND instead of REQ_OP_WRITE on a z=
oned=0A=
>>>>> filesystem is non intrusive on a regular file system or when submitti=
ng to=0A=
>>>>> a conventional zone on a zoned filesystem, as it is guarded by=0A=
>>>>> btrfs_use_zone_append.=0A=
>>>>>=0A=
>>>>> Reported-by: David Sterba <dsterba@suse.com>=0A=
>>>>> Fixes: 9d294a685fbc ("btrfs: zoned: enable to mount ZONED incompat fl=
ag")=0A=
>>>>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>>>>=0A=
>>>> Now working on compression support for subpage, just noticed some=0A=
>>>> strange code behavior, I'm not sure if it's designed or just a typo.=
=0A=
>>>>=0A=
>>>> So please correct me if possible.=0A=
>>>>=0A=
>>>> [...]=0A=
>>>>>=0A=
>>>>>    	bio =3D btrfs_bio_alloc(first_byte);=0A=
>>>>> -	bio->bi_opf =3D REQ_OP_WRITE | write_flags;=0A=
>>>>> +	bio->bi_opf =3D bio_op | write_flags;=0A=
>>>>>    	bio->bi_private =3D cb;=0A=
>>>>>    	bio->bi_end_io =3D end_compressed_bio_write;=0A=
>>>>>=0A=
>>>>> +	if (use_append) {=0A=
>>>>> +		struct extent_map *em;=0A=
>>>>> +		struct map_lookup *map;=0A=
>>>>> +		struct block_device *bdev;=0A=
>>>>> +=0A=
>>>>> +		em =3D btrfs_get_chunk_map(fs_info, disk_start, PAGE_SIZE);=0A=
>>>>> +		if (IS_ERR(em)) {=0A=
>>>>> +			kfree(cb);=0A=
>>>>> +			bio_put(bio);=0A=
>>>>> +			return BLK_STS_NOTSUPP;=0A=
>>>>> +		}=0A=
>>>>> +=0A=
>>>>> +		map =3D em->map_lookup;=0A=
>>>>> +		/* We only support single profile for now */=0A=
>>>>> +		ASSERT(map->num_stripes =3D=3D 1);=0A=
>>>>> +		bdev =3D map->stripes[0].dev->bdev;=0A=
>>>=0A=
>>> This variable seems rather useless...=0A=
>>=0A=
>> No need to bother that, that has already been removed by later refactor.=
=0A=
>>=0A=
>>>=0A=
>>>>> +=0A=
>>>>> +		bio_set_dev(bio, bdev);=0A=
>>>>> +		free_extent_map(em);=0A=
>>>>> +	}=0A=
>>>>> +=0A=
>>>>=0A=
>>>> Here for the newly created bio, we will try to call bio_set_dev() for=
=0A=
>>>> it. (although later patch refactor this part a little)=0A=
>>>>=0A=
>>>> So far so good.=0A=
>>>>=0A=
>>>>>    	if (blkcg_css) {=0A=
>>>>>    		bio->bi_opf |=3D REQ_CGROUP_PUNT;=0A=
>>>>>    		kthread_associate_blkcg(blkcg_css);=0A=
>>>>> @@ -432,6 +458,7 @@ blk_status_t btrfs_submit_compressed_write(struct=
 btrfs_inode *inode, u64 start,=0A=
>>>>>    	bytes_left =3D compressed_len;=0A=
>>>>>    	for (pg_index =3D 0; pg_index < cb->nr_pages; pg_index++) {=0A=
>>>>>    		int submit =3D 0;=0A=
>>>>> +		int len;=0A=
>>>>>=0A=
>>>>>    		page =3D compressed_pages[pg_index];=0A=
>>>>>    		page->mapping =3D inode->vfs_inode.i_mapping;=0A=
>>>>> @@ -439,9 +466,13 @@ blk_status_t btrfs_submit_compressed_write(struc=
t btrfs_inode *inode, u64 start,=0A=
>>>>>    			submit =3D btrfs_bio_fits_in_stripe(page, PAGE_SIZE, bio,=0A=
>>>>>    							  0);=0A=
>>>>>=0A=
>>>>> +		if (pg_index =3D=3D 0 && use_append)=0A=
>>>>> +			len =3D bio_add_zone_append_page(bio, page, PAGE_SIZE, 0);=0A=
>>>>> +		else=0A=
>>>>> +			len =3D bio_add_page(bio, page, PAGE_SIZE, 0);=0A=
>>>>> +=0A=
>>>>>    		page->mapping =3D NULL;=0A=
>>>>> -		if (submit || bio_add_page(bio, page, PAGE_SIZE, 0) <=0A=
>>>>> -		    PAGE_SIZE) {=0A=
>>>>> +		if (submit || len < PAGE_SIZE) {=0A=
>>>>>    			/*=0A=
>>>>>    			 * inc the count before we submit the bio so=0A=
>>>>>    			 * we know the end IO handler won't happen before=0A=
>>>>> @@ -465,11 +496,15 @@ blk_status_t btrfs_submit_compressed_write(stru=
ct btrfs_inode *inode, u64 start,=0A=
>>>>>    			}=0A=
>>>>>=0A=
>>>>>    			bio =3D btrfs_bio_alloc(first_byte);=0A=
>>>>> -			bio->bi_opf =3D REQ_OP_WRITE | write_flags;=0A=
>>>>> +			bio->bi_opf =3D bio_op | write_flags;=0A=
>>>>=0A=
>>>> But here, for the newly allocated bio, we didn't call bio_set_dev() at=
 all.=0A=
>>>>=0A=
>>>> Shouldn't all zoned write bio need that bio_set_dev() call?=0A=
>>>=0A=
>>> Yep, bio->bi_bdev must be set before bio_add_zone_append_page() is call=
ed.=0A=
>>> Otherwise, there will be a crash (first line of bio_add_zone_append_pag=
e() gets=0A=
>>> the request queue from bio->bi_bdev). I wonder why we do not see NULL p=
ointer=0A=
>>> oops here... Johannes ?=0A=
>>=0A=
>> That's because it's really really rare/hard to have a compressed extent=
=0A=
>> just lies at the stripe boundary.=0A=
>>=0A=
>> For most cases, the data we provide for compression tests is either:=0A=
>> - Too compressible=0A=
>>    Thus the whole range can be compressed into just one sector, thus=0A=
>>    it will never cross stripe boundary.=0A=
>>=0A=
>> - Not compressible at all=0A=
>>    We fall back to regular buffered write, which will do their proper=0A=
>>    stripe boundary check correctly.=0A=
>>=0A=
>> Thus it's really near impossible to hit it in various tests.=0A=
> =0A=
> But this is a data write, isn't it ? So in the zoned case, it means a zon=
e=0A=
> append write. And adding a page for even a single sector using=0A=
> bio_add_zone_append_page() will oops if the bio bdev is not set, regardle=
ss of=0A=
> the bio size... Am I misunderstanding something here about this IO path ?=
=0A=
=0A=
Because we're not using bio_add_zone_append_page() but bio_add_page() as we=
 only add=0A=
one page to a newly allocated bio. It's a bit complicated.  =0A=
=0A=
>>>>> +			/*=0A=
>>>>> +			 * Use bio_add_page() to ensure the bio has at least one=0A=
>>>>> +			 * page.=0A=
>>>>> +			 */=0A=
>>>>>    			bio_add_page(bio, page, PAGE_SIZE, 0);=0A=
>>>>>    		}=0A=
>>>>>    		if (bytes_left < PAGE_SIZE) {=0A=
>>>>>=0A=
>>>>=0A=
>>>=0A=
>>>=0A=
>>=0A=
> =0A=
> =0A=
=0A=
