Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F814E519F
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Mar 2022 12:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235963AbiCWLxk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Mar 2022 07:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbiCWLxj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Mar 2022 07:53:39 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFA47A984
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 04:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648036329; x=1679572329;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=PmvHSr6W24izF9t31Ojhh48eAFQAWxak8h6ppCr0Dig=;
  b=fc2eK7U6ABmlRbDE0gBkLijDZphyjlAe7nikPWaimz1ao8HP+MDvp0P/
   y1TFeZQw+K4wRthyJCYhxt3CE4jzaNfmaMFnfUx+DsZKqOwOl0cUTzawA
   gh4ctfcyoUIrM+MtaOvMwE6ZIQ4hSP77JEFbG4mKkVsrSqGqlRUpmQ7Px
   CzyE6dolTtuIFZlk+4gRo87g1RljJQyxFPsttpF38wAkdNOr68fp8FGrk
   gMfOZ5a7/BzjEoYrEMMHuDh9+V37e9CK8Xk8ryg/xKAoQ0jO+exb2O3iN
   9M9dtzH9aEB/6X0m4Giv00E3i8a7QWFssZQZIszRlQm5lbys50DFcLJxK
   A==;
X-IronPort-AV: E=Sophos;i="5.90,204,1643644800"; 
   d="scan'208";a="194961112"
Received: from mail-dm6nam11lp2173.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.173])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2022 19:52:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ebf9JcfBOaw0z2CGNYqpoEkz3OR2S8hDmUdQtZGgQfU6X9X19naiy7ifubGkYtoOeWH0YaSJb9752+aLtieHi3LteD4bzzm4QGBn/h+PVNX/6VANR20QjMDglizaIYDIH475TCAiQ7JE8cuW9tgfwWu1JodX3QhZ6ZeurN4OLC3mumPdaWkAvQbIRpLQrsKgNGheFe70LQmwb159HhpHN1XABMAP3XUfSi7T7GELV0nYnO7oBfsshuhhKkcLT7rvh4cXmRYGjkGk0abGt93eGYS1v4OGYz5ZwO1++9cJe7kUsTqvFa0CobJJrR2XGwwWUxSHjZrFijcPn7Ix1tLeMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlB3TEfWkK/XAbOspjkJT4tTC2a44P/xl6DaYzahdgQ=;
 b=BVC9aP2bW3Z8vfEEyVGL591BWjc6c7vRn+jM39oGBLQWBIdp3YPeKiu4ZPcq2lQ63URU1vqCOuZfQ4gcoiL5fexhNmHmOHX/lyuN7S6snGZ+53+j2nVdrqfjKYmRIJ6hs9LMNI+jS2l+HkwFsueZAKCUKoDHwnMlPlpzwEA3KbjKfZ5oGqhB2ZCSoer0VAuJf57xY6C8eicgi/aQgm0XeeibW9HHx9RZnGsaWDKnBwiV7hJziY66u2NGDE3E40QOnRNBFL/OPbretoN/dvGDZM+mFCTkM+4xB521Wnnd97NZl5GuPkEXZnpQfKVkhrtdXF/61AVo3mDZyQUxpE+lfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RlB3TEfWkK/XAbOspjkJT4tTC2a44P/xl6DaYzahdgQ=;
 b=ZK9aXwHboTHI6yjNLi9vFA/nB5Phk81NgbeKgmC1GH2TMJx09rTelRmAfICC/6IxjCP6oKk372Ay72Ed7t/Bgcu/OQl6a8D1PMCNmIxym44dVvOUXDXYo2Ip3NKWyAqM3fSeoxb+sIcnJEWTL9Qd4gzd2ALp0syfG+yLnZgg6Tg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CY4PR04MB0214.namprd04.prod.outlook.com (2603:10b6:903:39::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Wed, 23 Mar
 2022 11:52:05 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a898:5c75:3097:52c2]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a898:5c75:3097:52c2%3]) with mapi id 15.20.5102.017; Wed, 23 Mar 2022
 11:52:05 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Pankaj Raghav <p.raghav@samsung.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Javier Gonzalez <javier.gonz@samsung.com>
Subject: Re: [PATCH 5/5] btrfs: zoned: make auto-reclaim less aggressive
Thread-Topic: [PATCH 5/5] btrfs: zoned: make auto-reclaim less aggressive
Thread-Index: AQHYPT7Bez0AiBAkLkKxIm3VhJQQ/Q==
Date:   Wed, 23 Mar 2022 11:52:05 +0000
Message-ID: <PH0PR04MB7416D06ED74EE14B13C1DB3E9B189@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1647878642.git.johannes.thumshirn@wdc.com>
 <CGME20220321161435eucas1p28901f03d0533ae246f51a3b96bfc07b4@eucas1p2.samsung.com>
 <89824f8b4ba1ac8f05f74c047333c970049e2815.1647878642.git.johannes.thumshirn@wdc.com>
 <f4e4a70c-0349-fafa-8375-8c4177a3e260@samsung.com>
 <PH0PR04MB7416CD1BC88132E22790A1869B189@PH0PR04MB7416.namprd04.prod.outlook.com>
 <b0e84388-b56f-d8b9-2795-ec8d74431475@samsung.com>
 <PH0PR04MB7416E2A6492CA8BB2DF07BE09B189@PH0PR04MB7416.namprd04.prod.outlook.com>
 <ec5f09ab-b868-7128-cacd-000f66f3b9e1@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f0fc672-3fbd-418f-9488-08da0cc38d53
x-ms-traffictypediagnostic: CY4PR04MB0214:EE_
x-microsoft-antispam-prvs: <CY4PR04MB02142FCA646188128E7853A19B189@CY4PR04MB0214.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PTbSzMY6NU2ckJPUdRy8N5d1aqCrFxIXHF4/aQAYAeuABcccT5tw+bW1fk08Ch4nkUSQfMGJmXt8lOa8w/IxxhnfhuD9qNdcTcNQyRi3Y+vzj1bc+REmqhxLAufEmv/v01oN/T/M/bEdTx3t8XucwPV7RylOnOqdMn7tTaVpEe5bSQl0/vR/heIQGUsaYesuB6MopyrhCC7Wu4Ws9Chb08gjymFVl7L8XW1MzzEzg42pxh1qct2mjPHqPxlC4EvU09/yAr7Jeg7r/cuoBdvaXi4S29xxKn4gAXRG26UgFyjALelGjg8UXnoASQBiuyCsIdj7GjJbDsrbqy54neUmzsjdLt01bv8hKaiwuJo9gB3u0wpyu+AiTkAjvlLdkAMu2uUWJ/Ft3OafS5JS/38Fj1Uyr1mHasfHuZlo9mzfasOIM3/zSNkL52v3Ewpa+kLi3v993+PDcRMbhzC4SMWxz/l7HxCEfsGCsdajhjF9ETbcQI2tQi0GMX8PpkeYc8sH2ubJIHU/r+FASZOkrPmpeq9KQ+bKvM2bI8BMNrmrZSI5SKEgbs0if5i1UcpZxCJFIexqd9KLbCKi0Pk70zhOfvgB2qwUFQZ0lnHKMYW0txlF9786jmQd8HXBD0CbpToK6f2yPNbqG+v4wEz4sfEw88JSueHmPtFGpCAwJuq33gHu9+Y4pULZANGSS2mAvSeln/zZFNNp4mE4XaD20RB5UA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(82960400001)(86362001)(2906002)(38070700005)(9686003)(122000001)(71200400001)(508600001)(186003)(110136005)(54906003)(26005)(7696005)(53546011)(6506007)(66446008)(4326008)(8676002)(64756008)(66556008)(6636002)(316002)(55016003)(5660300002)(66946007)(52536014)(66476007)(76116006)(8936002)(83380400001)(91956017)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZON1PGnwbRlFNctXbrdBjYWe9cTPSjzVHBA8qrsOsGy8LZE4r2zBmQpbXVEI?=
 =?us-ascii?Q?KaoChwD5dqKjj6/P6Vp/akFaiOV2nsLuLtedH+U6bCaAKAKe7D71HyxczcqB?=
 =?us-ascii?Q?P3hXYAu8zn9GTKmD4xdAcgYPsUjVsJcnC0DJ3WaKjyN2H/RwjKBQnsS72a2e?=
 =?us-ascii?Q?HgZhq9uvEbR+ZvpQ98ebzckMzv/3ztGBUKQVtB4i0hiWUhYwyEGasEiHiO9R?=
 =?us-ascii?Q?uU2Y+jw69/10YC1CBWx5SgZBVTO7r8UNpuW7LR04AaiwTT1HevXVueONeh0h?=
 =?us-ascii?Q?phoqo0/NUVJ+Cu4DSAztwDcT+C6kbzjfBltLowF65bazspADr0Osp+bNK/WR?=
 =?us-ascii?Q?FvqXapK7ZuvFIfueGzaOSQRiLFM0iOGpuVQI3hEdtIxaFZmDfUiXlg+0b0h1?=
 =?us-ascii?Q?ssA8tcLyTbjCy7l/LHT+0cNpV8176/fNMfGFck2iH/QsdFcDOgtWIS3nj+Bd?=
 =?us-ascii?Q?nck2lA3a3CZmyvlW03Kds9aQoXYDZru2bixS1NfG+V5VoTIkf3lQS8xx3gom?=
 =?us-ascii?Q?/eyy02MVznYh98Lq1MjSzrYTLRWh3MjZX604lkDqBBdF9eVrrWOMx9lfdCXS?=
 =?us-ascii?Q?3pcN1QTgf/JfGuYhc3B0jPYfUgxh2flwFCOHA/6zLBKgMcFKQAv2cjPa3Om/?=
 =?us-ascii?Q?PYonFzLPaHMyojDKyMQ9WiNb1TLS94NUBpJKU76ShUf76rY1RJYuNB8E0jYI?=
 =?us-ascii?Q?sp4juFnpKv4uvygzOcFe057VaS+Et0bikLRtOFxGeI6uENiNPrHoFSEy3Xoz?=
 =?us-ascii?Q?fLYiL2fpG38uAVZPuNh/hliH8xB45YcqooqH8LeUjbdImHT3n/QddX2bPjDi?=
 =?us-ascii?Q?eR7Y57cXa6ELPxXBf6PlN13ptKu7nv/3UHUfqQ+aCeqAfzr6lzsiCBR1b0Af?=
 =?us-ascii?Q?kcSZwFqVosPSZyFr4kTYXkwSDfPbTgDI8qzAE/tn9NhiBXdTYCDbwkg6UUbt?=
 =?us-ascii?Q?mNKaxBr38oW1s1bhDpeLJkWS2GlAGgKlw/wBfqRB8rMiodkIn/pWdbQOW62h?=
 =?us-ascii?Q?slGfIngRnBvm8/3Gng67Yo3c5ala8Qke52J2nRjhEtS2uwUZyO2Fx9Ca3hnw?=
 =?us-ascii?Q?tTDZEfb2m/WJxXzCSd6w68NZiyeh3Hf46MOnoeaZuYAw/Gnnxwf9dGO3JjIJ?=
 =?us-ascii?Q?qUEeuMlhZ2FykfCG8w9lwJkKE9C4lan51KJ71ExuoKqNPNIZPDXpqmYX11Wa?=
 =?us-ascii?Q?QIoI5p6K80goH96BnRqf9/0BO8JHybpsCYqTr0jsAg0AyEKyD5X/+hWohnAr?=
 =?us-ascii?Q?/pNk0WnJ1I5mdXHjUcS94MsBT9otx7IYeKAUmvMDnZ74mn/QGUzCRGNMNony?=
 =?us-ascii?Q?le3qO3yyeS+cPaQJRrz4vpaTUL2+pxCDUcJgCx1Ovj2CVRjXrl+f17VwooG6?=
 =?us-ascii?Q?VrDNKUvGDC+Z398QCILNZhr3h6p5zWBuLQKj6qFVzUbw3wmBmRuaBpNlXgk6?=
 =?us-ascii?Q?PuWVzI+k7Z10wKxgB2TX4OU4HSosJ0tsoHBfJNH0wDA1psjdJ2u+nT+F+bqh?=
 =?us-ascii?Q?2DEdGcQZCDeTRCs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f0fc672-3fbd-418f-9488-08da0cc38d53
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2022 11:52:05.4005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lDJWGpnOWBGfrhHhHwGtIonyaLB3lylpI77GoU6E8ho61x1S+Zse88FGDCbn1krxrEZ1TZkNeMfiuiH/UQbo8r3rJbqbc6jEuQL9wHjTt74=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0214
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 23/03/2022 12:24, Pankaj Raghav wrote:=0A=
> =0A=
> =0A=
> On 2022-03-23 11:39, Johannes Thumshirn wrote:=0A=
>>=0A=
>> It looks like we can't use btrfs_calc_available_free_space(), can=0A=
>> you try this one on top:=0A=
>>=0A=
>> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c=0A=
>> index f2a412427921..4a6c1f1a7223 100644=0A=
>> --- a/fs/btrfs/zoned.c=0A=
>> +++ b/fs/btrfs/zoned.c=0A=
>> @@ -2082,23 +2082,27 @@ void btrfs_free_zone_cache(struct btrfs_fs_info =
*fs_info)=0A=
>>  =0A=
>>  bool btrfs_zoned_should_reclaim(struct btrfs_fs_info *fs_info)=0A=
>>  {=0A=
>> -       struct btrfs_space_info *sinfo;=0A=
>> +       struct btrfs_fs_devices *fs_devices =3D fs_info->fs_devices;=0A=
>> +       struct btrfs_device *device;=0A=
>>         u64 used =3D 0;=0A=
>>         u64 total =3D 0;=0A=
>>         u64 factor;=0A=
>>  =0A=
>> -       if (!btrfs_is_zoned(fs_info))=0A=
>> -               return false;=0A=
>> -=0A=
>>         if (!fs_info->bg_reclaim_threshold)=0A=
>>                 return false;=0A=
>>  =0A=
>> -       list_for_each_entry(sinfo, &fs_info->space_info, list) {=0A=
>> -               total +=3D sinfo->total_bytes;=0A=
>> -               used +=3D btrfs_calc_available_free_space(fs_info, sinfo=
,=0A=
>> -                                                       BTRFS_RESERVE_NO=
_FLUSH);=0A=
>> +=0A=
>> +       mutex_lock(&fs_devices->device_list_mutex);=0A=
>> +       list_for_each_entry(device, &fs_devices->devices, dev_list) {=0A=
>> +               if (!device->bdev)=0A=
>> +                       continue;=0A=
>> +=0A=
>> +               total +=3D device->disk_total_bytes;=0A=
>> +               used +=3D device->bytes_used;=0A=
>> +=0A=
>>         }=0A=
>> +       mutex_unlock(&fs_devices->device_list_mutex);=0A=
>>  =0A=
>> -       factor =3D div_u64(used * 100, total);=0A=
>> +       factor =3D div64_u64(used * 100, total);=0A=
>>         return factor >=3D fs_info->bg_reclaim_threshold;=0A=
>>  }=0A=
>>=0A=
> size 1280M:=0A=
> [   47.511871] btrfs: factor: 30 used: 402653184, total: 1342177280=0A=
> [   48.542981] btrfs: factor: 30 used: 402653184, total: 1342177280=0A=
> [   49.576005] btrfs: factor: 30 used: 402653184, total: 1342177280=0A=
> size: 12800M:=0A=
> [   33.971009] btrfs: factor: 3 used: 402653184, total: 13421772800=0A=
> [   34.978602] btrfs: factor: 3 used: 402653184, total: 13421772800=0A=
> [   35.991784] btrfs: factor: 3 used: 402653184, total: 13421772800=0A=
> size: 12800M, zcap=3D96M zsze=3D128M:=0A=
> [   64.639103] btrfs: factor: 3 used: 402653184, total: 13421772800=0A=
> [   65.643778] btrfs: factor: 3 used: 402653184, total: 13421772800=0A=
> [   66.661920] btrfs: factor: 3 used: 402653184, total: 13421772800=0A=
> =0A=
> This looks good. And the test btrfs/237 is failing, as it should be=0A=
> because of the change in reclaim condition. Are you planning to update=0A=
> this test in fstests later?=0A=
=0A=
Yes, once I have an idea how to do. Probably just fill the FS until=0A=
~75% of the drive is filled and then use the original logic.=0A=
=0A=
> I still have one more question: shouldn't we use the usable disk bytes=0A=
> (zcap * nr_zones) instead of disk_total_bytes (zsze * nr_zones) to=0A=
> calculate the `total` variable? The `used` value is a part of the usable=
=0A=
> disk space so I feel it makes more sense to calculate the `factor` with=
=0A=
> the usable disk bytes instead of the disk_total_bytes.=0A=
> =0A=
=0A=
disk_total_bytes comes from the value the underlying device driver set=0A=
for the gendisk's capacity via set_capacity().=0A=
