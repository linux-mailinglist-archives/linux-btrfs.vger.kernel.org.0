Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9D04DAC98
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Mar 2022 09:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354441AbiCPIkr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Mar 2022 04:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233630AbiCPIkq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Mar 2022 04:40:46 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B034366B7
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Mar 2022 01:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647419972; x=1678955972;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=93cbQEPAxPlNkTDrSsyJc4l2Hqe9EKvPEVpTy4GTlw0=;
  b=h9b7hG5yK+0gw20y/Q9V57GICBStNVEtRiNsuhmu7BSJ4Ajer6R4SaoP
   RHqaqmva/rHC7K3IYOAYu0lY//FkcBQDynEgkJvxQxqp+b5KApKWJYl2K
   7POcZZf/5JKfkwwwYCcUgXLDgZ0B2SwU18WpJMvpT/2zHErvndt/dAn7Y
   ylOPcr3rJfMbtpG9+3ti0slXSyrACLfeSAg5X+kCMl41djHH1S4ohJCB7
   Xb2C1KvDEvyy/W+qdaNmq8P/ILoho41XEo2TvxSQYW+2L0etH9lEmQHiD
   2Mz24TlnlQDsL0fJMVdXsOU4YlEkAg3mFwtS/ZGaDMLIABjKnT1GCmHcR
   g==;
X-IronPort-AV: E=Sophos;i="5.90,186,1643644800"; 
   d="scan'208";a="307443072"
Received: from mail-dm6nam11lp2175.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.175])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2022 16:39:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NjEfpmeIjPGLhIe4esTKjK6E3jItJbVsLN3hx+Q8EjYB0tWHJJaonlMNHa+BoWmBLV4fjNBFTP6dlv+MFZizWF1yZTowtDse1oqxyGPJxucg7VfRV2kcmz+bzwUvxNN1h9pUlej5FC6nfXKp9hpLZT5pk996LvcwtSgeCAkRuxQrD6UfNgl6jZoTfMz+QpqNdgFKhmc8Fjdfav8EMi8T/1i27bUQ4jWab/GMB39CqRtVde6vHHcf3z1uY6o57qJyTKkPdZZOZ+cxsB5OOBoCVVhJietVitg4OmOVVUqXAdiF2IMLD7xURVjnKUxT5KnXOGFHagG+M+ZGdg19aNiX9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=giUJtqJIdLH24XhE9r+Bb7htJl30obG46qWBqVNrjgA=;
 b=hAd300eMWuV3ix02tHHXNhtXvvjTznCB0k7ZaPs8zH4NZYTF8h/4WFWrSgRemBbOtQI+x99/8ov4rzonvl+ForYvtrj2JDYX0Dg1pm4L55ie7tRUVRhEHSaoE2miUsGkygW4aN58hrF/S93Q72l/vzBMy+LStTwJ8GuFKBTYAWrbJbOMIfrw5Sb9Emm38Qsg+TZTg+FmbFPiWKtbcsA95vgBj3ZDpYSmjcQ9wWw8Zn8i/mougkm7ljZjE83JQMGF6VIG0Ka09aK+g7wvUIAyKu/8G9GQumrDBIgO1thnS7gyBlHbdHvODCKJcOchsxIvWHyBwCdM+x4s7jO46K3/cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=giUJtqJIdLH24XhE9r+Bb7htJl30obG46qWBqVNrjgA=;
 b=o5pmxQTOX864QWmaizcDwtrHFaXlBJ8qYZGaN/1Nm9dmhfktegYI3WAEDKc6QenG2AtYr9yKKKs+8XGL/4f/+Vf3jF+D75dcOaKtUhGS4cLEmoeYETpNd9v3H6cXOibLoNJwFL/awZtHK4gmD1TSS1SF0KL5nEpMRKWHkZBIDrg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB5582.namprd04.prod.outlook.com (2603:10b6:208:e2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24; Wed, 16 Mar
 2022 08:39:21 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::e8b1:ea93:ffce:60f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::e8b1:ea93:ffce:60f6%6]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 08:39:21 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: use alloc_list instead of rcu locked
 device_list
Thread-Topic: [PATCH] btrfs: zoned: use alloc_list instead of rcu locked
 device_list
Thread-Index: AQHYN64o0G+R+GP9ykCkaqN1LTRckA==
Date:   Wed, 16 Mar 2022 08:39:21 +0000
Message-ID: <PH0PR04MB741638373ACE0D828C9A59529B119@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <f7108349f3a7d690166c88691c5dc1932cab3610.1647267391.git.johannes.thumshirn@wdc.com>
 <20220315200330.GW12643@twin.jikos.cz>
 <4af521e5-82e3-f21d-ede2-9da3fd990fe9@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2576328-3acd-4718-fd06-08da072877cb
x-ms-traffictypediagnostic: MN2PR04MB5582:EE_
x-microsoft-antispam-prvs: <MN2PR04MB5582D9552B231A535FE607A89B119@MN2PR04MB5582.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qgeHxqJsjZb8bPNmN1ZqTsYg2lGWtw80t1sHUsfIdRkc6RQUkLN0TNAQO2aido6fBlV03B8gCNw+XMqy76ITXNg77Mt9k9cjXyDEDqm0+OEEDfS5nQqP2GFceJsWzZ53UdcL5Fxt6kJxIFcUoRDS6tBQaIcwJEy5IpBVKMl7lzlsuq3wA+++mcH4D6LzXxF2C9P+BOZTIzytCSFxh19sModUL85jUuENFDDHO0vuCkHkZZHUjK9q4l6GqyAFb3F5GSAs3/r0FZZz2r15hrwV7UD/S/XKnp50bfi3FH3jfkvDouAYmr+T62jT4iT8A8It8RBnHbHpK1GDvusdEU7SMLAYwPvmwouJdcji0qIEKpyGsHll2WKR5zUY2Fh7Jr0ooRs6fbEnFasNw8k7ihC0q/0ErOkqobSohqGPM0rpsRLnIcOBOOKStddYXAWsZVhZU+hq3a1lb1Jk5QOs5cutRKigkxl2+et1k/lezxoHMu9AosGJ2vuFIAtrRoKAnHIQq6jmaafEWVVmDUFUCncRa0ty/nkwzBxPvBVbdQ4E2gmCkPkSQwlf+QOKfpKELpDykwfyRNMc4hD43G6vD+XqMPQtRM7bbiNEdGtaT+wOkrHnR/PYGftV3ugusQnrd134Q5VO6rORJl0cg9vQc2Fg6BZsL5/aAnpdQs+Chxpv+YEw0RDRN4y9idTR3U0uOu3BKP0vC9XON79EW2ho26tXWQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(64756008)(508600001)(4326008)(8676002)(76116006)(66556008)(66476007)(66946007)(66446008)(186003)(86362001)(5660300002)(38070700005)(38100700002)(71200400001)(7696005)(53546011)(52536014)(6506007)(8936002)(82960400001)(122000001)(9686003)(110136005)(55016003)(2906002)(316002)(33656002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?804yY9hDx5osiG97ErIK4DRl9jUWy3aG4vYONKxQ2LOiYIC7Zo1IhXr+gRyC?=
 =?us-ascii?Q?TjayGBLHKAVG5qr4AhIYMMptupxIl3E4YZ5LMOE75ythd1a4obcKRHhEIzJJ?=
 =?us-ascii?Q?BIwiREOo0mXXW2cwvAAlm8NlWIcXl/NT2soKJUAF+MNjMHQvlUZSI9SKzm9M?=
 =?us-ascii?Q?+rcrBwBlYstnVx3osfXfyqdAfR8GaMr8vRgw++eKp8rVdMFVm7/C9h3af7nM?=
 =?us-ascii?Q?9P59MRyP7eOKldKpKC3Cb0tkqbHhY23E14hrhqE8MNA+vZQnGU2ms/p/8/CA?=
 =?us-ascii?Q?j5TcC6nVQzI0K/oRZ8wJJwfWCgzP4HfuLFtt1ADnysKFQVz/W93dp3YdWBze?=
 =?us-ascii?Q?PqVrSMQbFMTFQ5lQTgBZIdhb4SieNjJwnZHaDWhnOYU1dDGe00VExZNWADsw?=
 =?us-ascii?Q?dowHoYsXtyTMTllKjDvaVeNtIxGhrZQBbZtAAC1Yc2z9cZu2UAKhmEYBLltv?=
 =?us-ascii?Q?VvYZauWHuejTWcAduHaS9P9U9za2qRJaMtT2fNlJLvtQcdqkPcb27W3AlTgt?=
 =?us-ascii?Q?1/adMNipmC4IfowONjBXZBjEcIeu5hHccDJrJPiMtKWa9atuyhLtGjK7OJHj?=
 =?us-ascii?Q?ilqLyI8azb5g2QHyQDVwo+wsACBrM9ypGufSL0uSnY22aODyMmShzLanG9Tb?=
 =?us-ascii?Q?0HDqTVvoR4W92BveTGbQX6M+ehugQ2PazV+oBJVfU6ghVDSru2SKo0Ifo3g6?=
 =?us-ascii?Q?QEiL8UCgwolY9dHBaTzGiCZQC9guX89/riPslqWeRSlLDtObXv+R8T8AuXPq?=
 =?us-ascii?Q?IVR9vEsXkYHZBMANear8+UKpC9ouSZfG21nYTaFQqWN5VJq8J+5bnoS1IKQT?=
 =?us-ascii?Q?s+dsxxtpXSJA3pbw0hM72M6ombhSBtdWvjg0IaGDGFrFiCDD4PoC5Ey/tCWH?=
 =?us-ascii?Q?W4+aDuPKxeDn5iWL30bO/5DrWlyXkZwfUnmwqSfKNNSSK0XjcJbW6kiBfhLD?=
 =?us-ascii?Q?2M+MrmQEroG5OWSkaBmxXfJBESvE2/wmUz41m/0YTYeNR4EgoQPHi6VXE+FW?=
 =?us-ascii?Q?jj21lYuvFizh5GghTJg1/6P2Dw6M/cfxE8SihyIn/RYBrE3LnYqJfffv+Xsn?=
 =?us-ascii?Q?JcBo9rDGcWTCk3Znwg0jbiYKZsZiKLpGfn4QvD0Y1gJinZhCwGkSOEO0ce6x?=
 =?us-ascii?Q?UKURW2hvKdeKuY8DdsTegNUfRdV1Jz09wSRDpjA182RjGb2//0ZYJb7y5HlL?=
 =?us-ascii?Q?CLeF/5NOFa4OOpZHbLvdOMtcst20xKeTFHNFFYFmwECMBxd3fsA4Pz3bmJNS?=
 =?us-ascii?Q?AeOMWo5AJpNoIZN3sDXF8aL8wI8MOVnsP0jIZ0p8mljMqo0F0/0+smHhGdtX?=
 =?us-ascii?Q?FPAeYg5wj+2pweoUOdJVlgg30WHMYGQCAN7WV0zRy38xRvvSU1ENfdw2gjbp?=
 =?us-ascii?Q?aKoe3uX4wFpRjEnAC872yFfrv1VKLcgQMFfxI5sz0o+d9nK3fMziyXwEoyKD?=
 =?us-ascii?Q?2Mb/R78hpLTGLE8HV8bGpeRO11WLUDjDeFBO/Qw3Tu+0dKqC51Q/K5y1Xvzr?=
 =?us-ascii?Q?4w0Uj0LSVONkmcNyKV3FTWr8pzGxxR016NECLgJHXIP2CJEzUPZT/Cqxf6kD?=
 =?us-ascii?Q?HtB327cwlJIXLkBQuu4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2576328-3acd-4718-fd06-08da072877cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 08:39:21.5184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eA4qHfQEuY89YNuJ/GIkXZY6kvA76HyV8LDGbMHcYBbZFl17kL2TP062CoWaZhoXCvJjtnN2O4vFOzqfsX2vl2yc399rYH9VsszI6mXwHZw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5582
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 16/03/2022 09:37, Anand Jain wrote:=0A=
> On 16/03/2022 04:03, David Sterba wrote:=0A=
>> On Mon, Mar 14, 2022 at 07:16:47AM -0700, Johannes Thumshirn wrote:=0A=
>>> Anand pointed out, that instead of using the rcu locked version of=0A=
>>> fs_devices->device_list we cab use fs_devices->alloc_list, prrotected b=
y=0A=
>>> the chunk_mutex to traverse the list of active deviices in=0A=
>>> btrfs_can_activate_zone().=0A=
>>>=0A=
>>> Suggested-by: Anand Jain <anand.jain@oracle.com>=0A=
>>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>>=0A=
>> With updated changelog added to misc-next, thanks.=0A=
> =0A=
> =0A=
> Misc-next hit an NPD for new chunk alloc.=0A=
=0A=
=0A=
Thanks for the change, but how did you trigger it? A.k.a why didn't it=0A=
trigger for me?=0A=
=0A=
[...]=0A=
=0A=
> We should use fs_devices->alloc_list with dev_alloc_list as below.=0A=
> Also, missing devices aren't part of dev_alloc_list, so we don't have=0A=
> to check for if (!device->bdev).=0A=
> =0A=
> --------------=0A=
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c=0A=
> index 7da630ff5708..c29e67c621be 100644=0A=
> --- a/fs/btrfs/zoned.c=0A=
> +++ b/fs/btrfs/zoned.c=0A=
> @@ -1984,12 +1984,9 @@ bool btrfs_can_activate_zone(struct =0A=
> btrfs_fs_devices *fs_devices, u64 flags)=0A=
> =0A=
>          /* Check if there is a device with active zones left */=0A=
>          mutex_lock(&fs_info->chunk_mutex);=0A=
> -       list_for_each_entry(device, &fs_devices->alloc_list, dev_list) {=
=0A=
> +       list_for_each_entry(device, &fs_devices->alloc_list, =0A=
> dev_alloc_list) {=0A=
>                  struct btrfs_zoned_device_info *zinfo =3D device->zone_i=
nfo;=0A=
> =0A=
> -               if (!device->bdev)=0A=
> -                       continue;=0A=
> -=0A=
>                  if (!zinfo->max_active_zones ||=0A=
>                      atomic_read(&zinfo->active_zones_left)) {=0A=
>                          ret =3D true;=0A=
> -------------=0A=
> =0A=
> With this fixed you may add=0A=
> =0A=
> Reviewed-by: Anand Jain <anand.jain@oracle.com>=0A=
=0A=
Thanks I'll update the patch=0A=
