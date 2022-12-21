Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0EA653453
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Dec 2022 17:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiLUQrw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Dec 2022 11:47:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiLUQru (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Dec 2022 11:47:50 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94072496C
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Dec 2022 08:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1671641269; x=1703177269;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YKCT+1yWBzyfl47GdWVqQRv2A8fs5NBYmDMJDDYIFqY=;
  b=bPZIfj/NVqF7DRuiCwA/XoDHim6I0tulcPIhkhMOBto3O4KCvhbEeaNG
   Gkm87LDht1mau8AGej3o0ubIGNIVNY50aiNY1PJuLg3yHps70RmGsJsB6
   G21acJBYagZ3clc8AQC82rXJE96CqLEwvNH9tD98uy1O/ebQwXPb7SM0j
   Z5U/ergOOMXtPjt59WfyL7E8+dLmgWON+0XlYAVrRIazUoFcwfFGktOUO
   SAG6SMHp9wdbFLvWCCBCEGhjaCEZ6B9dxlKEc9f6e1XQ7nWgeGsTrOoNf
   sIdmFokH0AKG4YRV2mE32K1uaRj6+BouWZCQOiOu6uM0LXBaUg8yzuPPb
   A==;
X-IronPort-AV: E=Sophos;i="5.96,263,1665417600"; 
   d="scan'208";a="219162003"
Received: from mail-bn7nam10lp2109.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.109])
  by ob1.hgst.iphmx.com with ESMTP; 22 Dec 2022 00:47:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mucc7wqpbvAcmWnsf2pB/ruxI6QG9vMW4HZP8wOPP958ug6A9HuYjYdgh+qq7PuT4BSAvJQ5kDDe7gVFSKE7l4RJaYUBlw6TMyRmRBnG8gqcVj64d7Yi4R8vMUoDfF5bAWdjjZRGx5rdF0dobA9BFQFPTgppmroiJ5AUArSfSgQJY+gWmlMz1RJsQVTfBKuIwJl7MYqenmQtYphvhqUPKzFmYNGlOqLS8AJ6sWZzeYoktMsD3+GGatN8WEBQC+G4B8zMzGPgssGoYbxLYQivb2GBBRWO3bVAQc/uhRH3ddCSO35XHs/TshyAhvmbp6zIJ9HLBka83KZ0dBexE7C2zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ut6xjOLKd3ps3kBXM605uJAgXLZxPNjI3Y52dBVXBSg=;
 b=K0S/sqaLfDBulOH1R8YTmDM8aR2kLEliQQhYS2qyJ7f7gxOuIgBpyJwjcP2UVyIZ7pvQs+AnWi7g3dxQHIpLAQeL8VFheEHYDFNCOQyjP93Uro7KZws6lImfhGQvvwWZyvnbeitzvkhGbulydSrTUlLCUd9khw+3XuDpqudw96nk4kIbK1lMPxY2CB+aeYcuYg3eT7hSpvko0xLepQ3xXaV3XMhUgpzcu2T8hMlekov1h8B3hzu7jIOyXJlzmjxGG2gDibK1vDYNbMSUr1e/IsiCzjIIeNzHSkUwUZ0zMzNkoJADMMVe6FwlFOniEX+k+PvSF0hjgFJ6Po8UGFrLUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ut6xjOLKd3ps3kBXM605uJAgXLZxPNjI3Y52dBVXBSg=;
 b=fk6UOW4iKWwat6hsKcs8ikdxa9pUWVW2sZbBMzgNcWmMXvkILAReqT18ta7QLaXj3gxAAHqtg2P0h8eP07hMtZOdfTFzHj166dhg0R10QX37cwoHyffb4wfkP7g0wFToSvaoZz/KkkGSR0dm3u12drlYXj6+agtcICmIHs83xY4=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by BN6PR04MB0613.namprd04.prod.outlook.com (2603:10b6:404:d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 16:47:46 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::c080:1687:4429:ed73]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::c080:1687:4429:ed73%3]) with mapi id 15.20.5924.016; Wed, 21 Dec 2022
 16:47:45 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     David Sterba <dsterba@suse.cz>
CC:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 6/8] btrfs: extract out zone cache usage into it's own
 helper
Thread-Topic: [PATCH 6/8] btrfs: extract out zone cache usage into it's own
 helper
Thread-Index: AQHZEYt9N/X6YnnVfEGxUNqb3VHIEa50zWQAgAJhAQCAAWZpAA==
Date:   Wed, 21 Dec 2022 16:47:45 +0000
Message-ID: <20221221164744.tzgzjviq6ykrwjyh@naota-xeon>
References: <cover.1671221596.git.josef@toxicpanda.com>
 <af6c527cbd8bdc782e50bd33996ee83acc3a16fb.1671221596.git.josef@toxicpanda.com>
 <20221219070514.tgfqoiethziuwfdq@naota-xeon>
 <20221220192456.GR10499@twin.jikos.cz>
In-Reply-To: <20221220192456.GR10499@twin.jikos.cz>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|BN6PR04MB0613:EE_
x-ms-office365-filtering-correlation-id: af9bb063-6f27-4d3d-4164-08dae3731623
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vchTZIhJLt01QzS9NeZJtAD6Mey6oTJyxf8W0X4axkN/KJoMKneypM+prX4G1jcpaUTMzDHbvuITynKxua6TVWSHTzf7/7FNYwEcA/JPGcnZOkBJcum/8eMbSZnJ7witMtnqUQ+8EyXmibDgZkO+RNog5+1tAcIEMcGmrZpN+giArqBI/nSFg+X+sehjGwbplyzz0m9GdBoVX8YT1syeXLOuxMe1DjzBCuRVIha1Z+K3gMDXPHBeQ1gwhHOTQV/QPkikJ8I6y2BGrHIFox9tRHWLIeVQT5wfm+NaUXWpBMthzYesrwnM8Q8ImzP4xChTyKdRhDyLNkV6s04IGAYH7q01/Db5Z67gkpwRSvwTIxKRg6+2BuO1pxwpWHuejxmiqvSEFf46wH6jews6DNWIlgd0pg6AL3SwFusUS8sdWEiBA6xiuFh5imsIKoumRMu08y26nXfGRFvIamUTimf5rrjR9HzmB4nj/QC/ggkpOa3HUJQLvJdiaDiXlKZ8iuqH6NGWyL8AOpd8YuqvwagQosYt6f01hRQmOUEdYwKzRBzkqoTq5BdxD32NrbXRUkdAY6MPXonFe9ILkFY9czqxJO2ICPB3R2Hm6z4UPM3tYuJ5rbrlR75Xx+8uBPHfzccK37h/dCtenPX3LuBzTJRezilOsrs6ZfsUNnvY/00JYrB+F6MqcRYEjDLS0mxo0+kuR/jv5sezSkg/kFfSj5vW4VWkl+UerWRAdOB77E7WdUxaMjdjJ7uto80DxGxtlnJEePu1cS6EI4bZyV88mYHu8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(396003)(136003)(39860400002)(366004)(346002)(376002)(451199015)(26005)(82960400001)(9686003)(6512007)(186003)(38070700005)(478600001)(1076003)(53546011)(86362001)(966005)(6506007)(71200400001)(6916009)(54906003)(316002)(2906002)(6486002)(41300700001)(38100700002)(122000001)(4326008)(91956017)(66446008)(64756008)(66556008)(76116006)(5660300002)(66476007)(83380400001)(8676002)(33716001)(66946007)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?beZL+NbraS/gua11MedIFjDp2G6MOaxnwYXfjNVvmydfi67gRF9fvgsIdHIl?=
 =?us-ascii?Q?DfDvXdK7j1ojQYR1HgtH7PXi+xc/4KyycsCU70n6WN3UaXy82SQd+Kp+z2fS?=
 =?us-ascii?Q?BhYbT4c0wvxr3HPA4d8JZTb5ZD5MxHwO2BCmKW/BiAJntOHsibh4IEi0mUFJ?=
 =?us-ascii?Q?3qJQmzArMQ7saDU7S9QDU3Lrz7Mjvp8eRy7GDnJOjlIO2W5t7uAdMxM5PPd8?=
 =?us-ascii?Q?7AqqqASvXg7j/wdJ9I+KmEPvZWhblLtuaRvmUjyqW8aVGOLNaVFbeZX1Js2J?=
 =?us-ascii?Q?+xiHgVNcm1pHYe3+8PYxwIiSCFdniaCK58GvGSpb71v7j7qQgIAQ56THpnVO?=
 =?us-ascii?Q?TE2io1BzeaPi/JIDHSokSRtGtngm3p5ek2sRIBkQz8f9RTWgBy5CjC5IzERm?=
 =?us-ascii?Q?PFz79WmIYKCqGCPgdk4lIzGrdJnt4953wc/w96UhLY5CrPt/gxZ8VyKWwkQR?=
 =?us-ascii?Q?xkjEG3ZdppQt5PI1TO1OQxVtbgTyD2cSap9RmOy43BMJeZ/6KX1XicKzF/dv?=
 =?us-ascii?Q?pvkj54jf+MXFIaP9gW1xOS78xMtUlAHJO0c1RuY9bYLlfE59S1HQiBh6cxDN?=
 =?us-ascii?Q?npipJTPE1XPSYL3OvXdpyBhXN81YUuo+p2daVX0Oym2g5flYsJLw/hFvCKOi?=
 =?us-ascii?Q?OURBMjmw7BQoPPjFQASZM1FLN5KABFMGtFxTuzolROZQ+JLhrsye3bR77kYg?=
 =?us-ascii?Q?WPG9/gaq+T78XfhjbQA+dBWeCzRjG4Kx7nyQVFbqCTqg383/B/mNFOysIr5u?=
 =?us-ascii?Q?QptQCZ8gJWtdqeU5wAEz0qPjdRKuL6oNCGGspvfpXVgaTnXb80QIW5nqO1xC?=
 =?us-ascii?Q?UY2xn7/DR4FZHw9VkvM8GLxG/Am4d9QamK7RI9Sfd9Dre3u5m/fXCaFLMjyR?=
 =?us-ascii?Q?ebjA+oTC+auUqasguinUk2uw5v9jlDZ56D1RrkD4NldEO918sDlKK8q2mGL6?=
 =?us-ascii?Q?3vrA72b2Kq2iUt4DkP/8hKsQN/z3KCfDtiIBmhiq+GIGNonkFimvWDtw43ZM?=
 =?us-ascii?Q?Ib2NAAfD4cbxus9qaPJRMbmmAVxUZ+fNCeGN0eiSO+d0ytReKIgjf2i98PxE?=
 =?us-ascii?Q?hXo6hOAw/mv7JJ1xNmmmC0sGdp58J411JV6MzweZO7Ucv5MmP87mQMcdRoCS?=
 =?us-ascii?Q?rXl+Wu4t3bP9OM6y4oFG94PkdmJ6VoirNVXY2qucWMIUn/LP/MAz+Nkezhrg?=
 =?us-ascii?Q?oyUJhAvBMie054/TRvrgnArptf11OKkBVffCj5OvAi6npnizhCQIKR+2TaIb?=
 =?us-ascii?Q?P36ItRY9BjTg3w0mEEMBXA0V5fiFQO1W4brdkN9myT8hv9W8RZjPmkVnMKO0?=
 =?us-ascii?Q?h6UzePRC59LtC1rboCkMATQY6g70mspoiYM9jN3xJgVd9mUkUaO5mYhiMbY1?=
 =?us-ascii?Q?EY5HYNEvFFhE8vFxE3M4s2C89jW/PIJtIyLSPZoFI1MlI9m3Fapklfz0fy/h?=
 =?us-ascii?Q?MC2VXEfr5wFA3PVgokjmpiV3PVm7OXNN6+xxthguacxq75nE+4P5+CtrXGHe?=
 =?us-ascii?Q?QeQ3AsgKbcIy4igoX/TOMXvwLCqltcTLPKgkpQobj+6Cki/wxrmtPGkYeVQN?=
 =?us-ascii?Q?LtmerkcAq1pV1ToUw9wJmnFql/A/hiQFExkG4kxeV+iH6kth2YH5kxeuiQI+?=
 =?us-ascii?Q?TQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <28A263803296504EB12B190A97032D87@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af9bb063-6f27-4d3d-4164-08dae3731623
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2022 16:47:45.8030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ps/JbYtGUogLjwKZl/fcdH2yX/9msAC7MUPmIQH91AazhhL+lOU9PHctMJebegtS/7AxsTn8TtvRhq2YHrBhfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0613
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 20, 2022 at 08:24:56PM +0100, David Sterba wrote:
> On Mon, Dec 19, 2022 at 07:05:15AM +0000, Naohiro Aota wrote:
> > On Fri, Dec 16, 2022 at 03:15:56PM -0500, Josef Bacik wrote:
> > > There's a special case for loading the device zone info if we have th=
e
> > > zone cache which is a fair bit of code.  Extract this out into it's o=
wn
> > > helper to clean up the code a little bit, and as a side effect it fix=
es
> > > an uninitialized error we get with -Wmaybe-uninitialized where it
> > > thought zno may have been uninitialized.
> > >=20
> > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> >=20
> > I'm going to rewrite the code around here with the following WIP branch=
, to
> > improve the zone caching.
> >=20
> > https://github.com/naota/linux/commits/feature/zone-cache
> >=20
> > Specifically, this commit removes the for-loop and the "if (i =3D=3D
> > *nr_zones)" block you moved in this patch. So, the resulting code will =
be
> > small enough to keep it there.
> >=20
> > https://github.com/naota/linux/commit/8d592ac744111bb2f51595a1608beecad=
b2c5d03
> >=20
> > Could you wait for a while for me to clean-up and send the series? I'll
> > also check the series with -Wmaybe-uninitialized.
>=20
> I'd like to have the warnigs fixes first but if there is a shorter fix
> that would not move the code then it can go in now and you wouldn't have
> to redo your changes.

Sure, how about this then?

From 50bc2858dc58301ca1b7d61bb72ca2566e59032c Mon Sep 17 00:00:00 2001
From: Naohiro Aota <naohiro.aota@wdc.com>
Date: Thu, 22 Dec 2022 01:17:59 +0900
Subject: [PATCH] btrfs: zoned: fix uninit warning in btrfs_get_dev_zones

Fix an uninitialized error we get with -Wmaybe-uninitialized where it
thought zno may have been uninitialized.

Since there will be a rewrite of the code, avoid moving the code around and
do the small enough fix.

Reported-by: Josef Bacik <josef@toxicpanda.com>
Link: https://lore.kernel.org/linux-btrfs/af6c527cbd8bdc782e50bd33996ee83ac=
c3a16fb.1671221596.git.josef@toxicpanda.com/
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index a759668477bb..ab63f8443e0a 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -220,7 +220,6 @@ static int btrfs_get_dev_zones(struct btrfs_device *dev=
ice, u64 pos,
 			       struct blk_zone *zones, unsigned int *nr_zones)
 {
 	struct btrfs_zoned_device_info *zinfo =3D device->zone_info;
-	u32 zno;
 	int ret;
=20
 	if (!*nr_zones)
@@ -235,6 +234,7 @@ static int btrfs_get_dev_zones(struct btrfs_device *dev=
ice, u64 pos,
 	/* Check cache */
 	if (zinfo->zone_cache) {
 		unsigned int i;
+		u32 zno;
=20
 		ASSERT(IS_ALIGNED(pos, zinfo->zone_size));
 		zno =3D pos >> zinfo->zone_size_shift;
@@ -274,9 +274,12 @@ static int btrfs_get_dev_zones(struct btrfs_device *de=
vice, u64 pos,
 		return -EIO;
=20
 	/* Populate cache */
-	if (zinfo->zone_cache)
+	if (zinfo->zone_cache) {
+		u32 zno =3D pos >> zinfo->zone_size_shift;
+
 		memcpy(zinfo->zone_cache + zno, zones,
 		       sizeof(*zinfo->zone_cache) * *nr_zones);
+	}
=20
 	return 0;
 }
--=20
2.39.0
