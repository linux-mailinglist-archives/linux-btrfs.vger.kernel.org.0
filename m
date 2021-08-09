Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44D393E4166
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Aug 2021 10:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbhHIILL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Aug 2021 04:11:11 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:26792 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbhHIILK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Aug 2021 04:11:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628496649; x=1660032649;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=4tFoC0Xn6YVEmQlPgOVggxpGP0roA3kFZHDgs8LCBww=;
  b=FAL3FwZFmxW5Qqfl46muNsa80gadRSR3J5GYl3EUUMW951m2Q56eTpjZ
   SyPaVnT2wKWTmWWHZqnQYfnh++qxE0imgxtqLlPB/x2SbY/0fvD1qr+sZ
   RiwA9HpaXWIe1jct2tfQ/v8+FYh2FNCoXlXkxfltJD0twsNPJBbWiwuJJ
   M8n1gXDh54jQ0qdIXqZwtPuYPVD+cP6cZmxfB0QqjqExsB9W0Ye+aWMX8
   BqnPnnS6Zx+MNADJT6Bm7pbRPBWuG75ziDKUG8QzPtN2LtiFnNqT6XtMQ
   iPVyNJ9SmzFM4e9IEtYCjzdCQepiUKNJ1KdP/DcoElclxNuWu6PLdP72B
   g==;
X-IronPort-AV: E=Sophos;i="5.84,305,1620662400"; 
   d="scan'208";a="176664953"
Received: from mail-bn8nam08lp2045.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.45])
  by ob1.hgst.iphmx.com with ESMTP; 09 Aug 2021 16:10:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8X+oXPCDgVIQNX3l4cIoSZF2Lp/viAuFlWZ/X09R/IoFeQkLRQg7YF2FlzeSa8ckLsJslKXTsFX5Jr85QAk69tkWohQgTTdPnmi0AHKBtGET5Eob12T6wIlSe4VMoKyuHBdMhpQlt01hK2rZV7xbPoWSolH6JP5WbKEkCcsval/uVXXf6cVIeFpFlYn9ujXvYCkMmO1H7v2NQIIaBOQZ7r0cTeKtr1Xve+ZpUOvhbUA5HijxfVffjSCrK4sXhaMbF/V1ID04UFHat+qhZzCdOzgM5Qi4kBm2XjyFtDmNi5RzFa0NR/bMzW7EU3vx/tsTto0HP6+wewYUygB/YM6Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppnCHhu0UdjZHa8TftUxc2w+yAQsuF4dDpncNf3OVcA=;
 b=HN5nxuz9qZrGnHuxiCtg+FM6rQDfcpKDJodPfr6txEIy4OxlW1mGaO4ItEUik5G5DZbCbavv21OkplTZs8GOMZluA0I0FzhT3ElOHrCXi6JRDouMrlhsei64Gwhj0rEuB6SSYpH/g11nZTEO9GlGg1yQ8icI7Q2scrIeZjdKylzw97QSxc7HluHln6nip9iuQESHpCLtOoTcd03dvqJ+lxT3veD8B4wUoDqwdZRw3+wepfo1bw+y5qLBbVLZ2MLxGmp31c8cB501byys2EEpDN/C/oXnIE5THCe99BCjxtXjAMCyEiJhbY4fX9gNNmeGMgOemraaBDIIw2BrAv5pSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppnCHhu0UdjZHa8TftUxc2w+yAQsuF4dDpncNf3OVcA=;
 b=HiEiVzaaMIomS2Hs2A2rm5/X90taJtG4/qfiLWMZkIy4FCq7oNdhSRZnC8p1ZdD1SUyDaCmiq/24T9D2vbO8E1suxdtYeK/wJ/55seGGh08pFDXcIw/p8ycfywoYaxuXUGGaJT9PyPpnhZGUIE/GjTx0GsP0h78+qHzJ2Kid3vk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7351.namprd04.prod.outlook.com (2603:10b6:510:a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Mon, 9 Aug
 2021 08:10:45 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f1f1:286c:f903:3351]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f1f1:286c:f903:3351%5]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 08:10:45 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: allow disabling of zone auto relcaim
Thread-Topic: [PATCH] btrfs: zoned: allow disabling of zone auto relcaim
Thread-Index: AQHXiqVACC93zRMSn0CluO2PfMXqXw==
Date:   Mon, 9 Aug 2021 08:10:45 +0000
Message-ID: <PH0PR04MB7416697049A900B9A3DA038E9BF69@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <fc988b42d58cf2e6b0ae2030fe0e67033ce27eca.1628242009.git.johannes.thumshirn@wdc.com>
 <20210809075059.odgjmdq4kyu7gyya@naota-xeon> <20210809080640.GI5047@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d84d206a-d4f5-4e3b-ef5e-08d95b0d30a2
x-ms-traffictypediagnostic: PH0PR04MB7351:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7351397108F7DC284EA1558B9BF69@PH0PR04MB7351.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J7Lt2/PV9Pk4hdq+vfOHWgG4NeduXtLAADb6Spkfh0cQovxh3/nUnntoEb6d1l5OcuihUcc9E/PTaeKkSG9eUek2C8OObWmQYAwh2D/Hr1GdK9Cv6rpZRohFwRyebUvylVprhlBR4kK/Tsx4WhPyd5OSRokeGMPU8ItTMMTQFz0hUVLCWFdwtOoI+4N5/1DHlVzy5tGlf90NzTxwm6mEllX/bVmyX+I4doNiHle/8yZc437oORJ2t1986pXa+okTTX510zjMSrwTj6v8Zwg5+mXNalt3ajJWdbPEOiMh69qlFUweeIElwhkMNyEI4D7gQO3BT9/6PHQ7X/9DYK2AY7eqqGP5QBlZHQZ/oRKx59w3qPh0ZWDJT5XEEn74btluBr7f1VTOCZneHMurpHI0fr1GrFy4LGImQmfUqQYlMOOiR3mmB2p5B0yf4dfbI11+HRi63lV5d0jHpbZafDzUjH/5KNrzFfZZ+U5urbYwZLO2uyzw1kxG1NmY6YsLdEXUjPxLdX+uYcoBF2ux5OvBJndaX+sDuRO8PfN9RBqoJDLKtU/b11L6Fi9U9nFT5JPQf96gZwymFcd68GXvA+qO5bGwd1tbfYwbwdutp1ZYhNh4Fa+Fp0RmmWf89Z2tFu0DhxIxmI13H31xNw6IvlYwCg9JWC3Sc5iOiLzBGcxcH5P87QhoxAk/9JVQiR7jD1KS8ClcuIz19YSimueAKWFkUQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(91956017)(9686003)(316002)(76116006)(122000001)(4326008)(52536014)(33656002)(8936002)(71200400001)(186003)(6636002)(5660300002)(38070700005)(66476007)(66446008)(66556008)(66946007)(64756008)(38100700002)(478600001)(86362001)(53546011)(6506007)(83380400001)(7696005)(2906002)(55016002)(8676002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W/wi2B64jNc6oY7BlkmQO66sbbz3Gfd0bBU3ZwDsYcQil855e7WracONZF7h?=
 =?us-ascii?Q?Z7VdS9+yKh9THPhy+9BnwzIhDzVwG9ZM0WJ5YqX8LAP1RdRvXCuy9uLDx5KW?=
 =?us-ascii?Q?9UL0HdjaAaiNv3sQAlgWB/X5k0APM9mwMGNh1wDSEN4IYzMYYChZUxlmv54p?=
 =?us-ascii?Q?f8vHGEoDtREnDxuEk04nKOZq4f/n5zPenlbw1JSGq+FJ/FGNXyM149Rqnhyq?=
 =?us-ascii?Q?zVs1XrvhGxBcgwSC9X4YolC/bSP4mhxeYLi3RHKXen1gv+2aTy2RVR9P8qYa?=
 =?us-ascii?Q?nrMVC+mOYkvChQeLCvr9rSDwcdNv+Ej+szHvB6T3+ut2tRoBt8q8qVlbg4Hm?=
 =?us-ascii?Q?yThsLb4BcRG9ckoXykYOSdlz04yoM2ByfbfpajAoXX80bJnjjptjAkGJhR6l?=
 =?us-ascii?Q?CsY5V5sK1v5Bmd3tG+QJkgMUaIjfXK7TE7ooZbohUqYu/bSmrSIluuMhMptv?=
 =?us-ascii?Q?ueHioDp6LS9BKaG0htN76NP7GC1nO4nvzU4m7iLbue4bdhGYgeMEnLSbXTek?=
 =?us-ascii?Q?573UmO55HNJVJNZq2p18GjtGvsB4jxZZrcRSxca+XIwuVUTIYzQDbLAKwZlL?=
 =?us-ascii?Q?srrpuamyfT9v1pJ5ED1dhbTEcI99oQv29+63/L/p7pyEyLCJlQpVLPQJWbBY?=
 =?us-ascii?Q?DW9ihtnvos9TRfNJgm0uT3fsvZ/DQI6mj7QUErrVmxhPA7fMraXzx7ke6W2F?=
 =?us-ascii?Q?Um79El4fkcuQYfHVlRkj9+gPRJiqAKhN1/OGZvIVELNn9C/iymGG/msydOHn?=
 =?us-ascii?Q?FhhycZb6Osrxg8JZBITZ84RQGZ7/L+MMajc+78U3oi3Iob36PPF6CAYqFWae?=
 =?us-ascii?Q?LWsg7oVyYvAqYzVE/Enl6XiogQslCLxxpXzJB475i85zEgjppq4PrhyPMMVV?=
 =?us-ascii?Q?H2uDpT+Umq5M6YHZN9d5QzTYdJkp2UGG+u3q94FxnZqzdPHSP/u9fYl7MLgw?=
 =?us-ascii?Q?T+VHfrTykWlUUrfwu8USVwYCxFPpRaJufrc9hw5MGAOhf66sLef7qG0L4Q7j?=
 =?us-ascii?Q?KIVOV5f5gYOqU9V9lkVfSDTfJ4u93dhdnuf4shpk81mKyxAKOveG1D1+XZoJ?=
 =?us-ascii?Q?EBEfvuGe6KNXFCGY8o7Q8dBRRteAxzsFh7RcP7HJpTktuvN2c2pNC2u9dBe7?=
 =?us-ascii?Q?9DRYDPfT5n2CH6LXbyGlyfQOlGQWZHgf1CDF9WkShEuAwajCGEWTd15qPJiX?=
 =?us-ascii?Q?CpqV+6nZvDGWRXkFtQHp0we+1DLrDfrGnS1PANNI6YxUJ860Z9pzn2CcBhb2?=
 =?us-ascii?Q?oV5qQndXpL3h59pm1na8j1qfEE+nRQVjLS58hW28bMeMxlwDsDvbX5hYpHbB?=
 =?us-ascii?Q?DmHb5XFYHq/EyFaFBBtQAMamk6oeqcRFtZuKffWov7P+fV5Qdk9gwmps4wSD?=
 =?us-ascii?Q?zbWmv4Y9uX+zVz0AjpwDhZETWP5j?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d84d206a-d4f5-4e3b-ef5e-08d95b0d30a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2021 08:10:45.7187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gANqldSW6uxkQwfiVyDI6qnDqfVFrSjz7W5ta4P3RV/WmsXPzGeiOdm4A85lpPls/VhKUdNP20NRYtg4w9i9TISEZuHhnuAEr6GVJOrGjiM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7351
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 09/08/2021 10:09, David Sterba wrote:=0A=
> On Mon, Aug 09, 2021 at 07:50:59AM +0000, Naohiro Aota wrote:=0A=
>> On Fri, Aug 06, 2021 at 06:27:04PM +0900, Johannes Thumshirn wrote:=0A=
>>> Automatically reclaiming dirty zones might not always be desired for al=
l=0A=
>>> workloads, especially as there are currently still some rough edges wit=
h=0A=
>>> the relocation code on zoned filesystems.=0A=
>>>=0A=
>>> Allow disabling zone auto reclaim on a per filesystem basis.=0A=
>>>=0A=
>>> Cc: Naohiro Aota <naohiro.aota@wdc.com>=0A=
>>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>>>=0A=
>>> ---=0A=
>>>  fs/btrfs/free-space-cache.c | 3 ++-=0A=
>>>  fs/btrfs/sysfs.c            | 5 ++++-=0A=
>>>  2 files changed, 6 insertions(+), 2 deletions(-)=0A=
>>>=0A=
>>> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c=
=0A=
>>> index 8eeb65278ac0..933e9de37802 100644=0A=
>>> --- a/fs/btrfs/free-space-cache.c=0A=
>>> +++ b/fs/btrfs/free-space-cache.c=0A=
>>> @@ -2567,7 +2567,8 @@ static int __btrfs_add_free_space_zoned(struct bt=
rfs_block_group *block_group,=0A=
>>>  	/* All the region is now unusable. Mark it as unused and reclaim */=
=0A=
>>>  	if (block_group->zone_unusable =3D=3D block_group->length) {=0A=
>>>  		btrfs_mark_bg_unused(block_group);=0A=
>>> -	} else if (block_group->zone_unusable >=3D=0A=
>>> +	} else if (fs_info->bg_reclaim_threshold &&=0A=
>>> +		   block_group->zone_unusable >=3D=0A=
>>>  		   div_factor_fine(block_group->length,=0A=
>>>  				   fs_info->bg_reclaim_threshold)) {=0A=
>>=0A=
>> nit: can this race with btrfs_bg_reclaim_threshold_store()'s=0A=
>> bg_reclaim_threshold assignment? Then, we can end up doing=0A=
>> div_factor_fine(block_group->length, 0)?=0A=
> =0A=
> Good point, this should be READ_ONCE and then check if it's 0.=0A=
> =0A=
=0A=
Oh yeah definitively. I'll fix it up ASAP.=0A=
