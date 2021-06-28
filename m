Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26E183B5D98
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jun 2021 14:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbhF1MKc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Jun 2021 08:10:32 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:2666 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbhF1MKa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Jun 2021 08:10:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1624882085; x=1656418085;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=+ACA8wN898ROTAJVvhbd68EnEsVDDnxcCjFycrrA4HI=;
  b=nPtmlz7pBSAUi4+S5GhOMEA/TYlpwTbnKn58UlZd3mYYTr9SHuwKl6iv
   /OAs/PXP0Aq2CalAhOzrspf5AwWXSMdjOMahpx+giLDU7RULJSPlW1KiK
   1lYftCXvoZoqu3aeCD5aCF9ZjBvrB8LYg3zqIM6yvoPBzlwMKplMLvpta
   0swcvBlPtaFjfWhH+eUdYnK02jVtk0e/a9xN5ob3kOTblyqFqL0wqq17B
   5FndaDWsqmjc8dFLykhBWlET3tMfn2kY69bISx6dFUttEzqMGljkB0hIT
   LMEkMx6+sNajOXWFbgyDE4frEKNYgdBdfHoGBh8JtwEHKi09uxQWLscyT
   w==;
IronPort-SDR: ZNKzVt6c8Uu6yB+BCzKwdxoPLzs7xIOJFRZQKJbVPlu8B7k4U0yVw/1rfNgxduh5I616yCDwWc
 fnehYGTN3PNb8bA3Ka/hPETQJAHFr8cZU5eT+fYVQlbKgDZbX69X+evfcUOuPTX22zgIJdYCul
 iiwyXyw0qKMKNQZyuiyzz3kxDlvrJnUzM1NZKfTNRDMzpX0q+Tc989GukB8VRYJkgm6o4qI2Ms
 cIE0hxyA0dwZYT5cico+2lXuXAqdxsbM7fD64LklfQowBkO1HgHA6H4qZnX9d935gX5xNHbYHw
 u/k=
X-IronPort-AV: E=Sophos;i="5.83,305,1616428800"; 
   d="scan'208";a="173090517"
Received: from mail-dm3nam07lp2040.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.40])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2021 20:08:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HoLDxnfICufBpzUlk0PCp/5089t6f31yJUbWECHJX22lbUvu2zgUFxXNB/fPBbtlpXjDJhCBz5rdtcYYBE8J9u0s6BYbY2RLOhKIm92PElJtNwbVmvMaGXAIAiUFKNjVvjAt8G3Xl1aJhfeNWIuGwRlvZxthe8nMCxYc+hKLeD0hGJtnmTeaVeoqNB3SPGyyrzeA8Vm/2IH8h7sI6NkQwjD194ktybu63dawD7Cj/PHF14j7oP3ciNXmt0PWFLBX5InCybuTBGiE7yE5wQd0Qxhn29U8lhjUaKmrKkIEgRSZc+FHs7iJ/sa8RJE2Vbao8uvkp284e7oCPQY9iK21SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4O30Cl4Z6eWrTf87GcN1/uN5MddJpOPgLIOBw0S1iA=;
 b=Ary6XQzuOzjRZu1d2SA5CtRZR8p3HXZeFNdWv5IxbZaZ9ZaVhaxoHFgEJOOR7RT1s8C31ANwVawQVxQKahhwSyLCG/BSX0gdAOOvIsWwRYfjDpm+KMPNAHfZXsvdZOPeEAq1Y/++K0v9MflF1yelKYVkSDdKDLEyXsspRnSuvJqyn12WtgXFILe71wmhaNrFn6KT5lNMFCfEoDFf0rUwAetIya+olajWvPhah2MU5oEjpxmLQ6qcLaHQYiPP32A7U2vaedVWdgNyjZQCYfetsMibao2EEC9M5AeyhboiiU/TMqqhXV9cFnGQyKkPZFRnoGrTu2ZyUA2G06q1sv6/1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4O30Cl4Z6eWrTf87GcN1/uN5MddJpOPgLIOBw0S1iA=;
 b=CrmzUWuqODIlg+jIo/Eu+OwQ2n/kbTmAx7a98BrPAgUZA9g2pWVixMFxkl/n7J2jk38CJFJ6fFV67r17ElQ9MNn6yLMzz7f3FS/YpE2RhL6/rGKXwKikiMXkAkX3et9hW6u8jy57neXmeDDrd6ggpYLAFvxT906YnCilJ7fhFZE=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB6606.namprd04.prod.outlook.com (2603:10b6:5:1b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Mon, 28 Jun
 2021 12:08:04 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::a043:568a:290e:18bd]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::a043:568a:290e:18bd%9]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 12:08:04 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH] btrfs: properly split extent_map for REQ_OP_ZONE_APPEND
Thread-Topic: [PATCH] btrfs: properly split extent_map for REQ_OP_ZONE_APPEND
Thread-Index: AQHXa/ytIQD5CnSI+UO6uXcBdC+c+Q==
Date:   Mon, 28 Jun 2021 12:08:04 +0000
Message-ID: <DM6PR04MB70812FB4651CB36497CC35CAE7039@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210628085728.2813793-1-naohiro.aota@wdc.com>
 <5c8fd0eb-0f7e-2ac8-af64-909501ec1ac0@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmx.com; dkim=none (message not signed)
 header.d=none;gmx.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:49b5:3cc7:e59d:b478]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40e2354e-3cdc-474a-0993-08d93a2d6209
x-ms-traffictypediagnostic: DM6PR04MB6606:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB6606B5B26D3962F5E11C207AE7039@DM6PR04MB6606.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iGmh/M9C9ndPnBIW4z+tnrRTSScdVytFppxiYqbRdE1XltuBqcDabtMVwEVEDFeXMpCgT0AbghEceu6Uscxk0gOpf83qzdK8IJN1HyJ+zxwAIZioxB3oSRIUbO++nOlYx5w1B5r/EKBvbeXYfkSrLMFuWSmBfnN38/qD3BqeTZ6EqBtcFE1MOQBT/qLNEmlYnKFaFWQfktJqZPiO40ywlFCmMhIHD/OBvvi+onNmJgP3TkJGXDnWr6DDrYX7TUb1IqMMsYYrEhZB7qUEsdIdydaAohp2wamgn8dXOJwQ+lZ7Q9kbwPmM77NqQld0Xa01TKYtZLoQfHdoVf9bhR3RG3/2Tj8rsDMn2Q5GhhspxMY7UQhpCV6IYrT8AqQUANHOyuauD7PvO5MWp6o8+dBs3yzqV9OBTyRQ+t4lDC/ZmeTsjh77Xum93fUkZWLBwDe1jeHDg7uQ7NbdRVJj52a+D3ZGQ6n/Kb54jYh4mio9RKdpzOQZbOy45Asaza8YhthXDP5TiAWX32mzZL/LfK6k+Mntf535lvJ7NIWSDs169OLrWOY91Mpn7n0UhToJzCZAq3aOE0u6JY4mNKJXs/8wCyK/iDJM6OpV4jFXbnhzWTU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(5660300002)(33656002)(71200400001)(66946007)(9686003)(66476007)(91956017)(76116006)(66446008)(52536014)(66556008)(64756008)(83380400001)(8676002)(8936002)(55016002)(186003)(6506007)(122000001)(316002)(86362001)(7696005)(54906003)(110136005)(478600001)(2906002)(53546011)(4326008)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?UjFZajVmalpQZDZqL1lJelNnNndnQ2JhNS82Z0d4dlFaR0VVRUVhZXNr?=
 =?iso-2022-jp?B?ZVZrNWgyK0ZXTHpQTFhCOVBIWExMTEdEb1c1aUVMVFJJdUNLTnFiQllq?=
 =?iso-2022-jp?B?TVRRcU1COWNjdUZydHlUajQ5WDNuRlpyM1dQYlh2eDJUNmg5Ynp6MVVv?=
 =?iso-2022-jp?B?elRRSXRaRTJieGNYbnN1a3JWSFZmY1k1bm5BMVFCTTRFVEZzczF4L2ZN?=
 =?iso-2022-jp?B?NkZBUmxRVVBUSXBQOXV1QlBZcjg1TWt5MkJGTHZhWTNPZS9tSElyQjVP?=
 =?iso-2022-jp?B?L2sxZ1doTFhldWFkQ2tzb0RId0JReE9WK1o3Z0VNaUZFa2ljZzF1NTJC?=
 =?iso-2022-jp?B?c2NnbG1zUHAzQlR3N2JXRmE0Zy9VYXlDYXZuNkpqVGRKb1VnWXd3dTJP?=
 =?iso-2022-jp?B?VjNYbE9mdHIxQldqS09yU2Z6ZUsvcS9nZ3NUWXI1dmo0SFRWOTh5OHQ1?=
 =?iso-2022-jp?B?QU4zY1pqQStJV094QURDY2p4c2h5dlpNeVJlNHFtM2NVUEM0MCtiZmdZ?=
 =?iso-2022-jp?B?czA4TUZINm41ZjRKV3F3S2gxM3Y2N2U0Umo2RVliem5NNWFoclN4VjFk?=
 =?iso-2022-jp?B?cVJhUVV1MVlEOXJocWdsMFI1bEVicjd6T2FEd3JrM2RjeGRLY1dvMjJq?=
 =?iso-2022-jp?B?WC8yMitYeGZVdkNXTmJiOS84bitYV0gzZkhzYU1mWTRvd1c1aDhlUkVY?=
 =?iso-2022-jp?B?akM4cFlodzhGR3psYW1oNDJCTEFkNnpkSHJua3VtdXpubENla0M0dXp2?=
 =?iso-2022-jp?B?aG5OU1RsdmZ3UTdkL3dlRGhkejZRWHNYdEx0dmI5U2NDejRoRS9XNTho?=
 =?iso-2022-jp?B?UTlPNGJ4dmttNXA3TXBQY3UraTF5SU45SEhqdkc2cXE1T0h2NSttY1JB?=
 =?iso-2022-jp?B?Y2E4ZmRJUzcwNWRicnZkQmIyLzc2cGhxS3p5RVRsRXhyS0o3a3dYM1k3?=
 =?iso-2022-jp?B?TnVHUjVOZjFPSDNFUXhNU0Y0T2d4OTNkNmVyd0twSmo0V1B1SFdDMWM0?=
 =?iso-2022-jp?B?Q2I3SmxkenhoVnJWS1E3bkNmbFdZN1htOVA3WHVyUVlSeFpOc2F2Rmxh?=
 =?iso-2022-jp?B?c2p6ME5sMzR0NkRRZXp0YmY1Q1FQT0M2czdTTVJQRFdrLzZSTERHUDFN?=
 =?iso-2022-jp?B?dXV3bkRIMitkYVllcGIxbTRFWU9rdFR3UWF5eEhCbXpQQ0kzNGR1WnBo?=
 =?iso-2022-jp?B?VUY3Z1pXL1VOaExuSVRqN0xyMk5tY1lyRXdYZzVVN2RHdmZqK05ScUdH?=
 =?iso-2022-jp?B?S0RlUTZzRHdFQXJQYm12NkxDakJvZk1ESExtQ0k5eVlPTlhSNnFFamN1?=
 =?iso-2022-jp?B?TkYxZ04zdGxIOExZendqNFhnVWo0WXI3bS94dWx0UXlvcmUvTHNUamYw?=
 =?iso-2022-jp?B?OXVuREVxaHVhNUhYeEh1MlZ0cTNiR1lsV1hHWDZVOENmckpmVGZMQnNt?=
 =?iso-2022-jp?B?Nk5XcnhHTVlyUnV0T29MZGVYdHJnZnZ4MVZyWmpma2VFWmlEQXdJa01i?=
 =?iso-2022-jp?B?Z2dhUnJxQ1NlWnBuK2VZVzNnT3ZvSGViRGFvbmVzRGJsLy9kOVhIZUxi?=
 =?iso-2022-jp?B?cWJKc1RZK2IxTWhmN0I3a1dtZVJzVTRlYVFqVlQ1eVh3UlNPME5xOGZa?=
 =?iso-2022-jp?B?TGZldDBXYzc1UWhWRnd6Q0dlT053K01OUEgrUDJObmhXM2xZYk56UkJD?=
 =?iso-2022-jp?B?bkxtSG5MSDlTblp0N2poNDNkQjExbXBtem1QMjI0TGdxN21wT3dXSHM1?=
 =?iso-2022-jp?B?ZVFaaWk4WmxjeTlwQ2d6dHdHVm1YaEhaZjU0d1hoYlh4dkYxN3VPTmlt?=
 =?iso-2022-jp?B?cTBxelYvb1lncjd4MDNyVmZmNTdqaHZwVlVpYXFKY1FkUWxXMis2ZUto?=
 =?iso-2022-jp?B?T1RKK2pQZmZEbitERkdqcDRCMGZiUmlMd0tlWFBmYnU3TU5MdllOWkZw?=
 =?iso-2022-jp?B?QWUyZDc4UTdkeWZPR09sdlZXQWxzcEVMZzh3S1BaZ2JEOTVZNlM1Ujdp?=
 =?iso-2022-jp?B?Q3ZMRmlQQno3ZTNlYU1VNVZVa3MxSGFNVFl1eGpnOTNDdXBsczR2UGZi?=
 =?iso-2022-jp?B?NlE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e2354e-3cdc-474a-0993-08d93a2d6209
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2021 12:08:04.1050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6cAzXwgpCAcqW5qh4xvyrUp6D3mYSqTuU0yonQjpG/gi5WuZeOxMk6OltaAB6QlP0EoT9x9h+vtRrKyM+YjKRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6606
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2021/06/28 20:50, Qu Wenruo wrote:=0A=
> =0A=
> =0A=
> On 2021/6/28 =1B$B2<8a=1B(B4:57, Naohiro Aota wrote:=0A=
>> Damien reported a test failure with btrfs/209. The test itself ran fine,=
=0A=
>> but the fsck run afterwards reported a corrupted filesystem.=0A=
>>=0A=
>> The filesystem corruption happens because we're splitting an extent and=
=0A=
>> then writing the extent twice. We have to split the extent though, becau=
se=0A=
>> we're creating too large extents for a REQ_OP_ZONE_APPEND operation.=0A=
>>=0A=
>> When dumping the extent tree, we can see two EXTENT_ITEMs at the same=0A=
>> start address but different lengths.=0A=
>>=0A=
>> $ btrfs inspect dump-tree /dev/nullb1 -t extent=0A=
>> ...=0A=
>>     item 19 key (269484032 EXTENT_ITEM 126976) itemoff 15470 itemsize 53=
=0A=
>>             refs 1 gen 7 flags DATA=0A=
>>             extent data backref root FS_TREE objectid 257 offset 786432 =
count 1=0A=
>>     item 20 key (269484032 EXTENT_ITEM 262144) itemoff 15417 itemsize 53=
=0A=
>>             refs 1 gen 7 flags DATA=0A=
>>             extent data backref root FS_TREE objectid 257 offset 786432 =
count 1=0A=
>>=0A=
>> The duplicated EXTENT_ITEMs originally come from wrongly split extent_ma=
p in=0A=
>> extract_ordered_extent(). Since extract_ordered_extent() uses=0A=
>> create_io_em() to split an existing extent_map, we will have=0A=
>> split->orig_start !=3D split->start. Then, it will be logged with non-ze=
ro=0A=
>> "extent data offset". Finally, the logged entries are replayed into=0A=
>> a duplicated EXTENT_ITEM.=0A=
>>=0A=
>> Introduce and use proper splitting function for extent_map. The function=
 is=0A=
>> intended to be simple and specific usage for extract_ordered_extent() e.=
g.=0A=
>> not supporting compression case (we do not allow splitting compressed=0A=
>> extent_map anyway).=0A=
> =0A=
> This may be a pretty stupid question, but why do we need to split the=0A=
> extent map (and extent item) into several more and causing more extent=0A=
> items?=0A=
> =0A=
> =0A=
> I understand for zoned write, we have extra limitation on how many bytes=
=0A=
> we can submit before reaching the zone limit.=0A=
> =0A=
> But we also have stripe boundary for non-zoned device.=0A=
> =0A=
> And in that case, we just split them into different bios, other than=0A=
> split the extent into smaller extents.=0A=
> =0A=
> Of course for current zoned support, only SINGLE profile is supported=0A=
> thus no stripe boundary to bother.=0A=
> =0A=
> But I'm wondering if we could do the same thing without really splitting=
=0A=
> the extent map.=0A=
=0A=
The problem is not the limit on the zone end, which as you mention is the s=
ame=0A=
as the block group end. The problem is that data write use zone append (ZA)=
=0A=
operations. ZA BIOs cannot be split so a large extent may need to be proces=
sed=0A=
with multiple ZA BIOs, While that is also true for regular writes, the majo=
r=0A=
difference is that ZA are "nameless" write operation giving back the writte=
n=0A=
sectors on completion. And ZA operations may be reordered by the block laye=
r=0A=
(not intentionally though). Combine both of these characteristics and you c=
an=0A=
see that the data for a large extent may end up being shuffled when written=
=0A=
resulting in data corruption and the impossibility to map the extent to som=
e=0A=
start sector.=0A=
=0A=
To avoid this problem, zoned btrfs uses the principle "one data extent =3D=
=3D one ZA=0A=
BIO". So large extents need to be split. This is unfortunate, but we can re=
visit=0A=
this later and optimize, e.g. merge back together the fragments of an exten=
t=0A=
once written if they actually were written sequentially in the zone.=0A=
=0A=
> =0A=
> Thanks,=0A=
> Qu=0A=
> =0A=
>>=0A=
>> Fixes: d22002fd37bd ("btrfs: zoned: split ordered extent when bio is sen=
t")=0A=
>> Cc: stable@vger.kernel.org # 5.12+=0A=
>> Reported-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
>> Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>=0A=
>> ---=0A=
>>   fs/btrfs/inode.c | 151 ++++++++++++++++++++++++++++++++++++++---------=
=0A=
>>   1 file changed, 122 insertions(+), 29 deletions(-)=0A=
>>=0A=
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c=0A=
>> index e6eb20987351..79cdcaeab8de 100644=0A=
>> --- a/fs/btrfs/inode.c=0A=
>> +++ b/fs/btrfs/inode.c=0A=
>> @@ -2271,13 +2271,131 @@ static blk_status_t btrfs_submit_bio_start(stru=
ct inode *inode, struct bio *bio,=0A=
>>   	return btrfs_csum_one_bio(BTRFS_I(inode), bio, 0, 0);=0A=
>>   }=0A=
>>=0A=
>> +/*=0A=
>> + * split_zoned_em - split an extent_map at [start, start+len]=0A=
>> + *=0A=
>> + * This function is intended to be used only for extract_ordered_extent=
().=0A=
>> + */=0A=
>> +static int split_zoned_em(struct btrfs_inode *inode, u64 start, u64 len=
,=0A=
>> +			  u64 pre, u64 post)=0A=
>> +{=0A=
>> +	struct extent_map_tree *em_tree =3D &inode->extent_tree;=0A=
>> +	struct extent_map *em;=0A=
>> +	struct extent_map *split_pre =3D NULL;=0A=
>> +	struct extent_map *split_mid =3D NULL;=0A=
>> +	struct extent_map *split_post =3D NULL;=0A=
>> +	int ret =3D 0;=0A=
>> +	int modified;=0A=
>> +	unsigned long flags;=0A=
>> +=0A=
>> +	/* Sanity check */=0A=
>> +	if (pre =3D=3D 0 && post =3D=3D 0)=0A=
>> +		return 0;=0A=
>> +=0A=
>> +	split_pre =3D alloc_extent_map();=0A=
>> +	if (pre)=0A=
>> +		split_mid =3D alloc_extent_map();=0A=
>> +	if (post)=0A=
>> +		split_post =3D alloc_extent_map();=0A=
>> +	if (!split_pre || (pre && !split_mid) || (post && !split_post)) {=0A=
>> +		ret =3D -ENOMEM;=0A=
>> +		goto out;=0A=
>> +	}=0A=
>> +=0A=
>> +	ASSERT(pre + post < len);=0A=
>> +=0A=
>> +	lock_extent(&inode->io_tree, start, start + len - 1);=0A=
>> +	write_lock(&em_tree->lock);=0A=
>> +	em =3D lookup_extent_mapping(em_tree, start, len);=0A=
>> +	if (!em) {=0A=
>> +		ret =3D -EIO;=0A=
>> +		goto out_unlock;=0A=
>> +	}=0A=
>> +=0A=
>> +	ASSERT(em->len =3D=3D len);=0A=
>> +	ASSERT(!test_bit(EXTENT_FLAG_COMPRESSED, &em->flags));=0A=
>> +	ASSERT(em->block_start < EXTENT_MAP_LAST_BYTE);=0A=
>> +=0A=
>> +	flags =3D em->flags;=0A=
>> +	clear_bit(EXTENT_FLAG_PINNED, &em->flags);=0A=
>> +	clear_bit(EXTENT_FLAG_LOGGING, &flags);=0A=
>> +	modified =3D !list_empty(&em->list);=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * First, replace the em with a new extent_map starting from=0A=
>> +	 * em->start=0A=
>> +	 */=0A=
>> +=0A=
>> +	split_pre->start =3D em->start;=0A=
>> +	split_pre->len =3D pre ? pre : (em->len - post);=0A=
>> +	split_pre->orig_start =3D split_pre->start;=0A=
>> +	split_pre->block_start =3D em->block_start;=0A=
>> +	split_pre->block_len =3D split_pre->len;=0A=
>> +	split_pre->orig_block_len =3D split_pre->block_len;=0A=
>> +	split_pre->ram_bytes =3D split_pre->len;=0A=
>> +	split_pre->flags =3D flags;=0A=
>> +	split_pre->compress_type =3D em->compress_type;=0A=
>> +	split_pre->generation =3D em->generation;=0A=
>> +=0A=
>> +	replace_extent_mapping(em_tree, em, split_pre, modified);=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * Now we only have an extent_map at:=0A=
>> +	 *     [em->start, em->start + pre] if pre !=3D 0=0A=
>> +	 *     [em->start, em->start + em->len - post] if pre =3D=3D 0=0A=
>> +	 */=0A=
>> +=0A=
>> +	if (pre) {=0A=
>> +		/* Insert the middle extent_map */=0A=
>> +		split_mid->start =3D em->start + pre;=0A=
>> +		split_mid->len =3D em->len - pre - post;=0A=
>> +		split_mid->orig_start =3D split_mid->start;=0A=
>> +		split_mid->block_start =3D em->block_start + pre;=0A=
>> +		split_mid->block_len =3D split_mid->len;=0A=
>> +		split_mid->orig_block_len =3D split_mid->block_len;=0A=
>> +		split_mid->ram_bytes =3D split_mid->len;=0A=
>> +		split_mid->flags =3D flags;=0A=
>> +		split_mid->compress_type =3D em->compress_type;=0A=
>> +		split_mid->generation =3D em->generation;=0A=
>> +		add_extent_mapping(em_tree, split_mid, modified);=0A=
>> +	}=0A=
>> +=0A=
>> +	if (post) {=0A=
>> +		split_post->start =3D em->start + em->len - post;=0A=
>> +		split_post->len =3D post;=0A=
>> +		split_post->orig_start =3D split_post->start;=0A=
>> +		split_post->block_start =3D em->block_start + em->len - post;=0A=
>> +		split_post->block_len =3D split_post->len;=0A=
>> +		split_post->orig_block_len =3D split_post->block_len;=0A=
>> +		split_post->ram_bytes =3D split_post->len;=0A=
>> +		split_post->flags =3D flags;=0A=
>> +		split_post->compress_type =3D em->compress_type;=0A=
>> +		split_post->generation =3D em->generation;=0A=
>> +		add_extent_mapping(em_tree, split_post, modified);=0A=
>> +	}=0A=
>> +=0A=
>> +	/* once for us */=0A=
>> +	free_extent_map(em);=0A=
>> +	/* once for the tree */=0A=
>> +	free_extent_map(em);=0A=
>> +=0A=
>> +out_unlock:=0A=
>> +	write_unlock(&em_tree->lock);=0A=
>> +	unlock_extent(&inode->io_tree, start, start + len - 1);=0A=
>> +out:=0A=
>> +	free_extent_map(split_pre);=0A=
>> +	free_extent_map(split_mid);=0A=
>> +	free_extent_map(split_post);=0A=
>> +=0A=
>> +	return ret;=0A=
>> +}=0A=
>> +=0A=
>>   static blk_status_t extract_ordered_extent(struct btrfs_inode *inode,=
=0A=
>>   					   struct bio *bio, loff_t file_offset)=0A=
>>   {=0A=
>>   	struct btrfs_ordered_extent *ordered;=0A=
>> -	struct extent_map *em =3D NULL, *em_new =3D NULL;=0A=
>> -	struct extent_map_tree *em_tree =3D &inode->extent_tree;=0A=
>>   	u64 start =3D (u64)bio->bi_iter.bi_sector << SECTOR_SHIFT;=0A=
>> +	u64 file_len;=0A=
>>   	u64 len =3D bio->bi_iter.bi_size;=0A=
>>   	u64 end =3D start + len;=0A=
>>   	u64 ordered_end;=0A=
>> @@ -2317,41 +2435,16 @@ static blk_status_t extract_ordered_extent(struc=
t btrfs_inode *inode,=0A=
>>   		goto out;=0A=
>>   	}=0A=
>>=0A=
>> +	file_len =3D ordered->num_bytes;=0A=
>>   	pre =3D start - ordered->disk_bytenr;=0A=
>>   	post =3D ordered_end - end;=0A=
>>=0A=
>>   	ret =3D btrfs_split_ordered_extent(ordered, pre, post);=0A=
>>   	if (ret)=0A=
>>   		goto out;=0A=
>> -=0A=
>> -	read_lock(&em_tree->lock);=0A=
>> -	em =3D lookup_extent_mapping(em_tree, ordered->file_offset, len);=0A=
>> -	if (!em) {=0A=
>> -		read_unlock(&em_tree->lock);=0A=
>> -		ret =3D -EIO;=0A=
>> -		goto out;=0A=
>> -	}=0A=
>> -	read_unlock(&em_tree->lock);=0A=
>> -=0A=
>> -	ASSERT(!test_bit(EXTENT_FLAG_COMPRESSED, &em->flags));=0A=
>> -	/*=0A=
>> -	 * We cannot reuse em_new here but have to create a new one, as=0A=
>> -	 * unpin_extent_cache() expects the start of the extent map to be the=
=0A=
>> -	 * logical offset of the file, which does not hold true anymore after=
=0A=
>> -	 * splitting.=0A=
>> -	 */=0A=
>> -	em_new =3D create_io_em(inode, em->start + pre, len,=0A=
>> -			      em->start + pre, em->block_start + pre, len,=0A=
>> -			      len, len, BTRFS_COMPRESS_NONE,=0A=
>> -			      BTRFS_ORDERED_REGULAR);=0A=
>> -	if (IS_ERR(em_new)) {=0A=
>> -		ret =3D PTR_ERR(em_new);=0A=
>> -		goto out;=0A=
>> -	}=0A=
>> -	free_extent_map(em_new);=0A=
>> +	ret =3D split_zoned_em(inode, file_offset, file_len, pre, post);=0A=
>>=0A=
>>   out:=0A=
>> -	free_extent_map(em);=0A=
>>   	btrfs_put_ordered_extent(ordered);=0A=
>>=0A=
>>   	return errno_to_blk_status(ret);=0A=
>>=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
