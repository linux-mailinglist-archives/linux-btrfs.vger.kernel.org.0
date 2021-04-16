Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F346361D08
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Apr 2021 12:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239951AbhDPJPF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Apr 2021 05:15:05 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:24731 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241594AbhDPJPD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Apr 2021 05:15:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618564480; x=1650100480;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=fhWVs7McQSJnigy4Hm+0wpPpJT5kbB74UzH67gOSU4g=;
  b=HKfmQ3i4M4x/12hGpMGIFezgx6HB7pGEaUntE54tfRvAclhZQGFUfPAW
   48eP1CgIqSGE6tUS85AtolgcGu0QsJ/cyJwBJBxZdnI7ia+m4D0nkfe93
   2/bga3IJJbimthKL/6IxZFRh82dwOXiB1HxB1XttH54shXlaOLd+8knlg
   oDxmySiug9WAZQ0qAHipb1o1bSzXZVEZjVlWx+Es0UVNS1s/6zpXmbfyO
   k9HEo96ERcg+fm066pn9bPkGtkemtO3y51Wn4bnemjCBtEmJ3X1coTl90
   onnJrTbdg94OyjOddkRkGKWgbU5W8fnSOTezetYMEQhc2BRjMwxIeRkL0
   w==;
IronPort-SDR: QhH/69IBr6EfWXZg25HygdOhNqtYM+qRgUV6jP5RNC3vG7YNBtk92o62iHgxkw1IVM+FZNBiHK
 YV7IuCLc64D+ydYlEK/7f7q9zBVVc/i1pVhUW8ZWwleMTat/7+Ox6JFjjxMD5FqYpfAwjIG4Lw
 IAzIZEaCYEutUn+vmXTdfa25GHk43u/ObfxM4BGm3vZTjO5swhqLjq6FCevH7R5jISm69rmvWS
 U5VRKXPgen0f83OWVhgQf7otpvqMVrU6V/UG5Kcjf66/DcUleDFKxt8WRzVXv0IYATkMhLSZ+t
 zMs=
X-IronPort-AV: E=Sophos;i="5.82,226,1613404800"; 
   d="scan'208";a="269074314"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2021 17:14:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QhO3dt4TBVFzdAxlXNwTlUTv8xGJz5NeRGHlXOgHCAozBmPM7w6ea3xagBqaqxVaj/dAhbwSx1ckJaNOj8baFYKmLQZWag8bmp1k/eURtvlb5ez+yYvbX21WKvOWkFQCagj0Y0X23SDJPxTUJGUp9bmG5yqmHB6b8CK/BOJejpcoSH/JtO+6nXyieEBzEskFXqysEV+g/PxDkvk1IzLro9xOmdgGPUGWPYAsgKFQsIeN0VKXoKw+Ah63WH4HMXDN3flLjHGPNT8LnI626g5P1r2VQq/pzpofPO/R7uojwBii6pcp/HHjs0D8egv4e0NMcLzM4wq8UnbTyV16kDmG+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTbbqlcHa5B+riR4rexDBWeqnBCAD99iqYqc3MZY1wQ=;
 b=exvZfR5fGCTa5wl1Hsj1yfXNqb+cIdTqSFllWivkqZJU73aSbQrQrqO6VOyPeZ96VNih9bKUvcYU6c15D1I/mzNQ8XA2HqRX763HHG8GXAWevtZcLzF53PoYg2gXLOmEle8qiNjs2UB/Cti0rdOsEvGCMAvp1NTeGr+pgBLMNT9Kn4EqXsOXW84djYphdNdVRHub41fGi6nuWo0zDjFgysi9rpq3wuvbkHlgj8UGSZkYlZ1Oa0MCG6jM8/krT1XZvQqb9OaQmegJ9RcV29OE9vDLlhtm+0fXa5lilrwSOwwzYgnRyTHHo4fVPmyoGVoys41K6N5BgUy/oFKiGVgEcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTbbqlcHa5B+riR4rexDBWeqnBCAD99iqYqc3MZY1wQ=;
 b=hrL0bqyA+7hQkdAH/MVdAFlGtTLsCDJigleAVPGrG2slHROBIlMgsGBQY2DROZ540F2oEz+wKlRaAyMs3WLWrQkffg0b4a82Dxn9FPttgRapQtGvd4eCvPN3Wd9WUsRU8BLvjTfmpKlV0/hqF9HbgD1+fFNL4AdizZDRQFfdXTU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7623.namprd04.prod.outlook.com (2603:10b6:510:51::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Fri, 16 Apr
 2021 09:14:35 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4042.018; Fri, 16 Apr 2021
 09:14:34 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "fdmanana@gmail.com" <fdmanana@gmail.com>
CC:     David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v4 1/3] btrfs: zoned: reset zones of relocated block
 groups
Thread-Topic: [PATCH v4 1/3] btrfs: zoned: reset zones of relocated block
 groups
Thread-Index: AQHXMf93GJooZ3c0CU+2cn3hwVcHMQ==
Date:   Fri, 16 Apr 2021 09:14:34 +0000
Message-ID: <PH0PR04MB741694A4912A97C6CC5365EF9B4C9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1618494550.git.johannes.thumshirn@wdc.com>
 <d3aec3e168a547dcc39a764f242d1df9d3489928.1618494550.git.johannes.thumshirn@wdc.com>
 <CAL3q7H4WKR4bamLij43gDL9RA9gREi_zNFME7LRqj7ex-YBLaw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:15ab:1:e10b:72a5:d443:5e5c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5d79e85-159e-41bd-93e2-08d900b80d79
x-ms-traffictypediagnostic: PH0PR04MB7623:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB762311549C9F7D2E4FDA37D69B4C9@PH0PR04MB7623.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lSJF2s+f7s/0ScUBxmJnH6RdnH3wvh7z58STE5ySCA3AL3C/N5TXN4PfK6sD7gMNhJ4nWQTSGTuJ1+vSve/7DFBi7Vz495forhvXw2Zg3KKWr26tK8gPU0iUQxK10DuFz2/meLfpDb2X0OGEq6enqrP6tBp0KtEGGGGeQk+lgFLrLdFbn+w/DyxC7SfZUKBlg4SvXiL/dBmZQ8q2x6G02+lQ88CTUplSAneouO3tJTW79jPliUEsFl/cHcctObdFpHupFsMvYBJnOFEbECWXhxYDhoyjwrqr5JVmx+gLf9TFwP/70pVF0OEKlCAcg0HiqgxchtTfdh19qShwm8Cz230RP1rYTqpb7Z61jtS5/K3Mq1UniDOXfjGSyz+ao+4X3DpJlCRs6CUTjrGHFQFUUK18cuLst5oUuZCPQKMkefnAQXc+qfZspc2IQSe7l0UlNl0stiHjzRpmopUNMRfWQEAC476VOSRJKdQKSdg1Fa86ewL4P3hyORQbDWmT7RXs80X16smuL088Purml9Kree1cESf8uUY2nmINc0QTRfPG16P0IigvaHvf8c1tSAsamiXFFZ+GwhIsSakMq3wvTJbrx5KEnsx8qn/Fobb+vzh+P0VPT99DAZ27IbrWGga5gq386yBdKaKJ24IedMAtuqjYuHh//Xk4lYFMpFw/PYcut7t2ufyugCNT4VxsLUTN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(396003)(136003)(346002)(6916009)(316002)(5660300002)(54906003)(186003)(966005)(91956017)(66946007)(7696005)(52536014)(478600001)(66476007)(76116006)(66446008)(4326008)(53546011)(64756008)(66556008)(55016002)(71200400001)(8936002)(86362001)(8676002)(6506007)(122000001)(9686003)(33656002)(38100700002)(83380400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?vRmLt7mFN44qJbACXml87vya6TYO4V++Gi8ut+qP3CDFIGqzpTGV9OwFwRJi?=
 =?us-ascii?Q?fYSUSs2vitXim/noZaDQkRtVeAmmTj25mwo2bpwBKxC13WzWwS8T4DCBG2Id?=
 =?us-ascii?Q?zFNh9T25EwiIoG+FurwZ1WEhwsnxFhJLbhSjjfbFjtx7fUJjsOzE8DRplOdD?=
 =?us-ascii?Q?ahXwnP3wFfgJH0RphlE4rZatTn/IHybsZtx2RVw0gjCnNdfF3LhpR5KGSEq+?=
 =?us-ascii?Q?hn5nD/QLiGXGD/WCce3bmEw2hA75db8LdHBqc6DjkuDhcuPxjCGN5CPcMfPc?=
 =?us-ascii?Q?p4qHpylMDNkPy2XhASibanYlkKdfGPlB1T8GtRDpixh0OvDqMpRoECwBRQ/L?=
 =?us-ascii?Q?VG5ECvKunupwK9JOHqA32YjEbBH7Uefwz1bWWpQQvZwCxmxLW14ztsTHGFjV?=
 =?us-ascii?Q?Yin5NE6W7FNVg8izGabCBT6QJze5vqZCgxi7lMrl+Y85DRyGt0cmTsg0Y3SK?=
 =?us-ascii?Q?8VE+KsVKM7nRAAItKdiY1iO7vgLpuE5zNvmKUZcDyvV6VxEm5yohF9jqN0xZ?=
 =?us-ascii?Q?pBj9Eteb92Nq5op9QNyamRScVkJJfEAg4pNjn1V579IdIXLbr4fqd67ieucg?=
 =?us-ascii?Q?7JA6jcaroiuG+yNNH9Xliyf0P4yhGDN9wKqgBOknvLYC1GpNd+DkCDXDOrI/?=
 =?us-ascii?Q?KihqEMPpg1ZeecRuEV9bEPrWoU9KiRqhQW6B9bGD3DtenAHQWJckIkC6MqE+?=
 =?us-ascii?Q?CxnkfdDWbGP1PgfH42v9lSczX9St/yWCQsD5/t2JDc5kIHnnT/49M1TvNuOx?=
 =?us-ascii?Q?JVlSapORkrPD/2MerSs3Nn8xsHHFdtPkHucxiWp0U0MMFq6IMyTdojrSePH0?=
 =?us-ascii?Q?MrgCZKsd737rScCyDu7eifmgjtkdf4lybujyj+a/UkMLu/KfU0gUwhMpts9f?=
 =?us-ascii?Q?FX2JaQVwqwkz0LHWDyQq7np1H16/AkN17QC/cPZMKTLPOAzj9OVZejd4nPhG?=
 =?us-ascii?Q?249CXKuCJI/DaLyuOci1gJJ8xX2vQJTs3JWVmtYXnIPrecOxfTizaLogJBdX?=
 =?us-ascii?Q?mRAr+EHLH4NoL5LdLLVP+rJDX+LSk79PUt3ksvAvrbBhCEFxMeM4hAyrf9J0?=
 =?us-ascii?Q?3OhyLBHjRFhsVdSiOCw+NTokGxkFUQ70DmA80vuh2neWRnPHmEJPYWOhGoAu?=
 =?us-ascii?Q?gs3TdiLrn1BFK3LdP59oTLOpHklxU2sTBLBYoZCBhUxVcsIk0FVGLYQEGKrl?=
 =?us-ascii?Q?EuPBuv+Ff+cSLI61Yrh5ml39tiLKsWPk3B+4jc0/tvwI5KJQV7UOWu3z9w/z?=
 =?us-ascii?Q?MDhtQbUbpnT+DkYClwdbjGLQY2uXHOzL2Zv0HIMiHvO+xNgyqC28zCQAUeRR?=
 =?us-ascii?Q?gMHpVbWdAktyF449T6/aoRj1LLWPF/hzJEE8W05c7/GuAgH3c5EpdER07RKw?=
 =?us-ascii?Q?eJ5esEY7BFhLSKgUT1FdlmVXWeHW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d79e85-159e-41bd-93e2-08d900b80d79
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2021 09:14:34.7768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: afk7gJ479Sfb9a/00fta2En0VdRwZWvLdda6fEq+Iz/R3ZnxuHFX/DmrcFKdKWZdIbA0/H21ObsrJmCqHQySiTKnijEtiNcNNFf3nagRcwU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7623
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 16/04/2021 11:12, Filipe Manana wrote:=0A=
> On Thu, Apr 15, 2021 at 3:00 PM Johannes Thumshirn=0A=
> <johannes.thumshirn@wdc.com> wrote:=0A=
>>=0A=
>> When relocating a block group the freed up space is not discarded in one=
=0A=
>> big block, but each extent is discarded on it's own with -odisard=3Dsync=
.=0A=
>>=0A=
>> For a zoned filesystem we need to discard the whole block group at once,=
=0A=
>> so btrfs_discard_extent() will translate the discard into a=0A=
>> REQ_OP_ZONE_RESET operation, which then resets the device's zone.=0A=
>>=0A=
>> Link: https://lore.kernel.org/linux-btrfs/459e2932c48e12e883dcfd3dda828d=
9da251d5b5.1617962110.git.johannes.thumshirn@wdc.com=0A=
>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>> ---=0A=
>>  fs/btrfs/volumes.c | 21 +++++++++++++++++----=0A=
>>  1 file changed, 17 insertions(+), 4 deletions(-)=0A=
>>=0A=
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c=0A=
>> index 6d9b2369f17a..b1bab75ec12a 100644=0A=
>> --- a/fs/btrfs/volumes.c=0A=
>> +++ b/fs/btrfs/volumes.c=0A=
>> @@ -3103,6 +3103,7 @@ static int btrfs_relocate_chunk(struct btrfs_fs_in=
fo *fs_info, u64 chunk_offset)=0A=
>>         struct btrfs_root *root =3D fs_info->chunk_root;=0A=
>>         struct btrfs_trans_handle *trans;=0A=
>>         struct btrfs_block_group *block_group;=0A=
>> +       u64 length;=0A=
>>         int ret;=0A=
>>=0A=
>>         /*=0A=
>> @@ -3130,8 +3131,24 @@ static int btrfs_relocate_chunk(struct btrfs_fs_i=
nfo *fs_info, u64 chunk_offset)=0A=
>>         if (!block_group)=0A=
>>                 return -ENOENT;=0A=
>>         btrfs_discard_cancel_work(&fs_info->discard_ctl, block_group);=
=0A=
>> +       length =3D block_group->length;=0A=
>>         btrfs_put_block_group(block_group);=0A=
>>=0A=
>> +       /*=0A=
>> +        * Step two, delete the device extents and the chunk tree entrie=
s.=0A=
>> +        *=0A=
>> +        * On a zoned file system, discard the whole block group, this w=
ill=0A=
>> +        * trigger a REQ_OP_ZONE_RESET operation on the device zone. If=
=0A=
>> +        * resetting the zone fails, don't treat it as a fatal problem f=
rom the=0A=
>> +        * filesystem's point of view.=0A=
>> +        */=0A=
>> +       if (btrfs_is_zoned(fs_info)) {=0A=
>> +               ret =3D btrfs_discard_extent(fs_info, chunk_offset, leng=
th, NULL);=0A=
>> +               if (ret)=0A=
>> +                       btrfs_info(fs_info, "failed to reset zone %llu",=
=0A=
>> +                                  chunk_offset);=0A=
>> +       }=0A=
>> +=0A=
>>         trans =3D btrfs_start_trans_remove_block_group(root->fs_info,=0A=
>>                                                      chunk_offset);=0A=
>>         if (IS_ERR(trans)) {=0A=
>> @@ -3140,10 +3157,6 @@ static int btrfs_relocate_chunk(struct btrfs_fs_i=
nfo *fs_info, u64 chunk_offset)=0A=
>>                 return ret;=0A=
>>         }=0A=
>>=0A=
>> -       /*=0A=
>> -        * step two, delete the device extents and the=0A=
>> -        * chunk tree entries=0A=
>> -        */=0A=
> =0A=
> This hunk seems unrelated and unintentional.=0A=
> Not that the comment adds any value, but if the removal was=0A=
> intentional, I would suggest a separate patch for that.=0A=
=0A=
It's moved upwards=0A=
=0A=
+       /*=0A=
+        * Step two, delete the device extents and the chunk tree entries.=
=0A=
+        *=0A=
+        * On a zoned file system, discard the whole block group, this will=
=0A=
+        * trigger a REQ_OP_ZONE_RESET operation on the device zone. If=0A=
+        * resetting the zone fails, don't treat it as a fatal problem from=
 the=0A=
+        * filesystem's point of view.=0A=
+        */=0A=
=0A=
'cause technically the "delete extents" step starts with the discard now. B=
ut I=0A=
can leave it where it was.=0A=
=0A=
> Other than that, it looks good, thanks.=0A=
> =0A=
> Reviewed-by: Filipe Manana <fdmanana@suse.com>=0A=
> =0A=
=0A=
Thanks=0A=
