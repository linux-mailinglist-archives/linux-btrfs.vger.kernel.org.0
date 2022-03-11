Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299EE4D5CAA
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Mar 2022 08:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244821AbiCKHsD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Mar 2022 02:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347314AbiCKHsB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Mar 2022 02:48:01 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730791B71AB
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Mar 2022 23:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646984818; x=1678520818;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=82TsCn/++bKk9nim5GfD5m41Ssk1HtymFc1xrqfLvqE=;
  b=jiXbgMqRGCcsghC3FP74ruMJuZoB0wjm0nd4Db8Im1KZN8tFkaGMCXP0
   qpinwMlLGrgqXda/zWnGmH6qoDqQR0qI7WLmnsMCLC0EnRiE7bClhO6tC
   0TxcYT1yo7o09lN4s5DSM0td8atFMT8EPPCyAqjQyZWjaxsWglZX4bz7b
   u34mHcncWHamPsIRXzypgfnl94/52KsBMjwK6WbF05C+ZTVlEGZKNudqW
   wnlzV7/1GR1uGNa8udDzphs5j86DAUmRcaLEFaeAacPtVtSEs6s8upNwC
   wo0V8wqYgdwAK/qgr0rS3YhZUD4pUS9nHGloBiofFqTZGlaQDLaOVVVQh
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,173,1643644800"; 
   d="scan'208";a="195058147"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2022 15:46:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYL4khdKuCbRJ5WaiTQdhVRhl5w2fQsKxy73DM+t4xJuiQdMDJfFZJeuKq0Cw2BzP65lkBIVT7KqapjxdWk9CMvwsTA1PDtbGuF1NDrPHDaG7YCn6mShylJAt1FFWm3IBAMZVhVBMyZkPHc0SHqk5/a+nykjf+ZZ+IVVLlW3DhTkCcBHuuV6ZGzJpkSAsHZLZplnomfvYdKb2t8JGnC797CddGbizuGrOcO5AE+QaeWo9SWRcH00D+foDCo0mk5u3BuJ/PHYy0CvmwE7gY1AqToqLcyKTK7ClU7W/xO7TzpSEDtFktHgIyZK6557IoNP2jrRN6F13vmVyMiNzihN7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lhBjRaM7Obd2LtNv3gQs1RzWt3qc1EL15+mYLobTTe0=;
 b=Jz7L5ZvhbgiKvPnhR4oollGJMbd3lHfcX+ECuWOglJEFTryELBKr/DmnvWKT/5kIRjRHCyk86rVTN9ZqeEGYzP8kAwYjK6B+ZOYEcTP/6sH14hmNIEaeffvj/KVxaAXrSteShwMmRpr3Vbz2X7JxgJLZVAiHs+oh/kM+GJGeHq553x4cb4l1zyvNb8qP4UFOBYDow8+Y/ivof1zV0OqBEoxHBpKLXHpZNKTfLZncbPk+0LSWc1y+u4a2TxpX9FLvb10VTh4lIffQe5p+YQxDg29F07Al50C8VyYRboohIwqTosqCc37/cEz1Gwxp+6d7YUSUEuxgBfoBeDWEw3GguA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lhBjRaM7Obd2LtNv3gQs1RzWt3qc1EL15+mYLobTTe0=;
 b=Id+5yinmd7oligv8n5RPgFZEpfMb8g3bU2C4hAOKqiMBOYpYXusejZ/Nq/bvzQROmCTjOTto6hdDKHBLCnlgY4OjIFDPm0paBEUJjLFDVqKQgvDbrIBpGcTJLb2AQrD7dRTx3MmepRaBOUfMylxyZIqY3kjCwaZAAa4CMPaiZag=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6982.namprd04.prod.outlook.com (2603:10b6:610:92::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Fri, 11 Mar
 2022 07:46:56 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::e8b1:ea93:ffce:60f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::e8b1:ea93:ffce:60f6%4]) with mapi id 15.20.5061.022; Fri, 11 Mar 2022
 07:46:56 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 1/3] btrfs: make the bg_reclaim_threshold per-space info
Thread-Topic: [PATCH 1/3] btrfs: make the bg_reclaim_threshold per-space info
Thread-Index: AQHYNKh43nsvDqOzGUOlAioPJqpmBg==
Date:   Fri, 11 Mar 2022 07:46:56 +0000
Message-ID: <PH0PR04MB74166A816B22B1412D8C44AA9B0C9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1646934721.git.josef@toxicpanda.com>
 <5f0232b262e067282b26a4bd26bfbea440f2a329.1646934721.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7543e614-c45e-40dc-5c64-08da033350f7
x-ms-traffictypediagnostic: CH2PR04MB6982:EE_
x-microsoft-antispam-prvs: <CH2PR04MB6982F09ECFC98D1736EFB2109B0C9@CH2PR04MB6982.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7C0KroSJ7kmZJFPOGQL/OaVMviIwe9nBzwNw/erEqW8iytV2EOS9FVI5X08hPX9OLHWs1ixup6ZoRmkqLKOu6R/ORfjqJWPCxWJCD/Tl6L93wrYWsTQhRGEdFfQfbt/d2d9vsGz9Pnu36o58pW0ijSX666qVfjGXG3oBcydA1zCpsoZWUA0aVehGapebuaN1CVU3PeCQIi1z7j3/boZy185CqYShNTact7qPriTjZ6ZwelcP4Y88vbgBEnNyzxnlm/lt9RBOwbVX4QZGsCiuDgNkpVyz89FL4TfKb0ZkP1XaFv5OwScoqTasdLLu3e3qYsL6TUas3SSUZutGOeFziSDGH6JrrHBHKbGCbJN8Pvq5kHdJ6SFuftwl4Vc1ltaGaiClyAfzIggGipsD+EaPjGv80b3ERFr8xLcAMwAPWtnh90a0Pv/m6jR63MVp6yBJ8dTz8vlaSYSwWjB4Fba3U0WTMt6rk0xwX9zdwe67NRJWkRFVrC4OyGtL/kbEHLxwyTYLZbBW4znWrlw15bHJMxMfU9y4EKG+reRDCiZCyoVHS1bDD6ictFFqiUrTUkbCuuKDkJSExxG5AG+pggGR9NXsq+jjk8Zb/tYzLEC2aU17trgXzmaUoOq6LIGuJOJsUBBGhuQaBYiaYEM1G3BniuMTWKpHiuS92Q3DBIPq5OFoOOnuTjCHCW0OiBvboZDrqSdDC4odlmORGGbEWedwng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55016003)(38100700002)(110136005)(26005)(316002)(186003)(33656002)(508600001)(86362001)(6506007)(7696005)(53546011)(9686003)(71200400001)(52536014)(91956017)(122000001)(8936002)(8676002)(66446008)(64756008)(66476007)(66946007)(76116006)(66556008)(83380400001)(2906002)(5660300002)(38070700005)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?j6rh31eqj1rmXrHDNTP7h1eKywjrWjn4xx71h8b2aNeYEsWCBk747kObQNsk?=
 =?us-ascii?Q?fPcGOvzJH8rhhJHVYTyAd0pqPmqxFElOJ83eNVTa1XRRxPVriQq/lLoTfdnA?=
 =?us-ascii?Q?F3s3xQxIa8vgYGulffnfX8kuhqOQWP0KN/mPR1jHL0/dq6otGFs9MuNSgDMV?=
 =?us-ascii?Q?cwq6VP8EYJ8kq93YNxOI3cVNv61dJWn2wvBqIzisE43klpOiDICHU/YeejvG?=
 =?us-ascii?Q?+T2fzj9YdqQHsKI8Inyz+n+lWOpaFDSJI/EQd351RvP76fvvAsdU5Jktv0lt?=
 =?us-ascii?Q?WJS934q+TZU4Atr7BWMNGpLmtKr5/FPpBNjEYDTTqjMzj+MytJRGlrtNgF9P?=
 =?us-ascii?Q?h5NAFvSk/B3paqwJG5nHhod+Dp2XRvcKY98e4doP+CTbFV8BHCkhrb5gLwgj?=
 =?us-ascii?Q?sBtXDcBJbz8UJsTia8+Onz/MUp9XoxJLaZMGSGmxsYORFnxLuqPRUiahuo/5?=
 =?us-ascii?Q?j+5WO4Swbjo6Xhl46MbEr5MopE4bGnTQHFIOkzlWI32Oz50uf2rFq5Cy1JWB?=
 =?us-ascii?Q?iTFAyYNAIViHZsZhxAfA0rEWUibgQgmvnTNuyxUpcVMRqztgn0IfvZXP4Km0?=
 =?us-ascii?Q?m3X66a/QpC+8PJePgavQWyauR+k3l7Fx6cHOiKd/nnKJjvL0+cCCRfNwrfc2?=
 =?us-ascii?Q?zUblFRcJmqkM5hPHB5CLGhiK3z8XKxf0MUri6KDeEsWktyL3wRgoO73mWXvj?=
 =?us-ascii?Q?tu91XkDyWewvw0DKi4KuZYalnlBDDCM7WBNeJTBPlDUGy0U8c9lUFhk6S3O/?=
 =?us-ascii?Q?XGVAb0ohE8sPAfL/L2dcPW4aQyjeZUMw2RDJQfeiYIXZqWHhzMjjLaBoOOjg?=
 =?us-ascii?Q?clvb7cl83YnPp7plAc+3AF/dywCtoIWXaGSMu74hYkMGAfTTY+18yeFt8Giv?=
 =?us-ascii?Q?EAnVma+ZQsz0b3BJvhcS4DL2clJpz2yXNh/00I+u4GyjjfXbrN1yiCMNHZoj?=
 =?us-ascii?Q?cfsqFqlW2U7M9LI2hlqdYbuN2u3JGW4UF41GsxqWr5AA00kaHKZx6OQfcVx4?=
 =?us-ascii?Q?qR4HjB6+zR/ME9S1dO9P0clhi2l5TGEcmbqBwvTN3WWFxOXauDc2SiLEhP5P?=
 =?us-ascii?Q?btl2OU2SbBI4S5Da+wCrsQ8wbFB/T6t6iz0BwjFvsspztLvHosocnSP9YH7+?=
 =?us-ascii?Q?GIlBv8LbhudvAGxC2iTA8x4Rgao/M/RdSjvMIBJGGrdKRdm6rmKSZOnoDz0l?=
 =?us-ascii?Q?z/wBrZVEueZLVix2FQg2c9OfoBt+oEK3msBKJY4uZo1+OmzdueegI8b1gZQ9?=
 =?us-ascii?Q?7VONXq1wZqUfT0KUcS6l6C7INQEHWVlv6t3drcQPmG5rfzlfntJYOyPxFgNI?=
 =?us-ascii?Q?HPC5+q5e1h+4XpmoHIUGwK986FXAR9DVHYTMzGXFb3zOgjW7bBup1pKPtmNl?=
 =?us-ascii?Q?mv6XcetVadZ+9IsOqqxYGw+8oNqqUUgpAVNL/IyJ8ukL+oeOqE/iNX/akBuj?=
 =?us-ascii?Q?mYE9HGeoXRXPus8EaUFzp2Ft6OwFlAEm5jGehZPvYgpULYcNnicZa1t0HC4+?=
 =?us-ascii?Q?qCxTxVP2wRiscAk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7543e614-c45e-40dc-5c64-08da033350f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2022 07:46:56.1699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vep61pNMe7rZRXpLdglJe62zkJiaCs93Abr45K/DtkZlwS1O1/XT5SjTTwQRPNRufx7B/n44xArn1Xy8PZfsI3QeAJ0sp2wk0UbDdN+UjGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6982
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/03/2022 18:58, Josef Bacik wrote:=0A=
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h=0A=
> index 4db17bd05a21..1953ea40755d 100644=0A=
> --- a/fs/btrfs/ctree.h=0A=
> +++ b/fs/btrfs/ctree.h=0A=
> @@ -1015,7 +1015,6 @@ struct btrfs_fs_info {=0A=
>  	/* Reclaim partially filled block groups in the background */=0A=
>  	struct work_struct reclaim_bgs_work;=0A=
>  	struct list_head reclaim_bgs;=0A=
> -	int bg_reclaim_threshold;=0A=
=0A=
[...]=0A=
=0A=
> -static ssize_t btrfs_bg_reclaim_threshold_show(struct kobject *kobj,=0A=
> -					       struct kobj_attribute *a,=0A=
> -					       char *buf)=0A=
> -{=0A=
> -	struct btrfs_fs_info *fs_info =3D to_fs_info(kobj);=0A=
> -	ssize_t ret;=0A=
> -=0A=
> -	ret =3D sysfs_emit(buf, "%d\n", READ_ONCE(fs_info->bg_reclaim_threshold=
));=0A=
> -=0A=
> -	return ret;=0A=
> -}=0A=
> -=0A=
> -static ssize_t btrfs_bg_reclaim_threshold_store(struct kobject *kobj,=0A=
> -						struct kobj_attribute *a,=0A=
> -						const char *buf, size_t len)=0A=
> -{=0A=
> -	struct btrfs_fs_info *fs_info =3D to_fs_info(kobj);=0A=
> -	int thresh;=0A=
> -	int ret;=0A=
> -=0A=
> -	ret =3D kstrtoint(buf, 10, &thresh);=0A=
> -	if (ret)=0A=
> -		return ret;=0A=
> -=0A=
> -	if (thresh !=3D 0 && (thresh <=3D 50 || thresh > 100))=0A=
> -		return -EINVAL;=0A=
> -=0A=
> -	WRITE_ONCE(fs_info->bg_reclaim_threshold, thresh);=0A=
> -=0A=
> -	return len;=0A=
> -}=0A=
> -BTRFS_ATTR_RW(, bg_reclaim_threshold, btrfs_bg_reclaim_threshold_show,=
=0A=
> -	      btrfs_bg_reclaim_threshold_store);=0A=
> -=0A=
=0A=
Can you leave the old, per-fs threshold and sysfs attribute in, as I still=
=0A=
need it for zoned?=0A=
=0A=
Or should I send you my zoned change, so you can add it to your series?=0A=
=0A=
Thanks,=0A=
	Johannes=0A=
