Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC6558789D
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Aug 2022 10:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235970AbiHBICm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Aug 2022 04:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233907AbiHBICg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Aug 2022 04:02:36 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D544248DC
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Aug 2022 01:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1659427354; x=1690963354;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=66ANM8UEyMEtw2T8cgjcdTVb3YB9d4Qnp+uo73nw3/o=;
  b=e/KgFvUvS+w7+jaH89xdDQ7EgCNoB9yi4Wfm+avnM4COJSz0azeLur2T
   WBTlwUjQxhswg86SnIX9BSycfekyA3k/KABzI6xyVtCkAShiPnOgfLdh2
   KVkjdc1VeUGchQ5hqxpi/q7w4c+DUsXsf0aPPJ4o7/JHe//ROyesMghvo
   F7BC/eH3sGd/2fqriDKgeI3P5O9Pl8yKYeBbZlerThZSns8t6Hdmh2kjv
   H8J3oN3clzOCRzxygDPKwMg8JrQtbCI87K/FarMQrAWMUmlFCvFGHSEda
   a1iY6lHZQyySQ7JmGksYubGrRFhkOROZUlUkcJa1D0Ygg9/Joi19I7rTQ
   A==;
X-IronPort-AV: E=Sophos;i="5.93,210,1654531200"; 
   d="scan'208";a="206085780"
Received: from mail-sn1anam02lp2040.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.40])
  by ob1.hgst.iphmx.com with ESMTP; 02 Aug 2022 16:02:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qla0wL0ZgxuJStD3fCDsk8WBwSUPyiJfVCVn2z836Alpxa4ldGtI84/d9PIL+v4iyXmFUDmR8Ip6lmSB4AbEOkanoJ11fJnR1nLJlMgEvLSetfMHDRhvRxCdUokeGNS6f6dWG6NXcRWKa9RfzIRdcMS5ztXngu2d0W5YqYdBz8LEhMYffzmkU1QvfPmKi4L+fIFOxmhLtuG5wN3PwnzUfzTHGZNRk0TmSpWl9gJ3yoGxUd5Ggj05FmOmLVtGmewjJrQIi1lFsDZCMsjYO3qkbck7pO2EO1ViElnI6DngaTceWtfELJVojyK2T5DO/M25BLIHL2KyeFKjVqtgZXrMAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxTxOXFtm96NLPX2IECwJigPawrTzs4945viNQgAYcQ=;
 b=eWmHU54QWhZLoVz8Yai2xeLJgpAfQvGCv/ASHlJLU1O4HlXtrcqEc6ZCsKXbVL9quyO6PpvL8hba7oj3X6QviBNshTP2j0z7qpooNGPvQXThNRpBJLJevDdABgJGNZSAb4GAduOTBRWWJ+WJ4kFiAC1s+Lqmip8PyBpHBRFGZBNRuZC+SOtGEdYYuyrdLDSaG8amHqWU1fl/jX+h4Lu24oOS6vabDbfbp87xW5QUZIFu0euxsGoF4swV++JRrg5zC345zNdcJ9mGmKa5evkz2fmWfT5RXXiJ+LSKuJUE90TAYbeoYKJDCi09Du/hLo0Us9d29KL1e2nAGhC2DiRydQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxTxOXFtm96NLPX2IECwJigPawrTzs4945viNQgAYcQ=;
 b=octm/1u1es+p/wfp11KnDz+upm8CdsDoIx67Qb2WIqiaa8s+ammVdcEtVzUOfJNepsxd2SynJjbSCvRPXKIFKVEuQK7ZnDc30OiHnJvmXcP4YzLyHKnuQEDjNU4E/BwEXYxqo5OHTohPT1VKbzFwUwSDFJPdjMEXqGHIjbxt+LY=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BN7PR04MB4241.namprd04.prod.outlook.com (2603:10b6:406:fe::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.15; Tue, 2 Aug 2022 08:02:31 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833%9]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 08:02:31 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Qu Wenruo <wqu@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs-progs: avoid repeated data write for metadata
Thread-Topic: [PATCH] btrfs-progs: avoid repeated data write for metadata
Thread-Index: AQHYpkHiEQZVlnUTMkmHfpZbbdOkY62bP+qA
Date:   Tue, 2 Aug 2022 08:02:31 +0000
Message-ID: <20220802080231.kzrywmuduunmhsn4@shindev>
References: <cdfef9acd4b34751791cafc49612a35328847847.1659425462.git.wqu@suse.com>
In-Reply-To: <cdfef9acd4b34751791cafc49612a35328847847.1659425462.git.wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8f2c5d9-40d9-4751-84eb-08da745d59f8
x-ms-traffictypediagnostic: BN7PR04MB4241:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +tX8ka24/cmDgD2HCaGkLtiV2Tt8nCrNKoR05GVAqZBZx8Z4+EDoPlI3tN6JUgWaCW+MdIdg5cEJnU8CzLkTN/rGWTnsqkhrGw5FPOXrCBLriZOeRQd+bE8ChS47mHYaMuyv0hSUCjnBSqxsAIy8ay27ziODvJbKCCFLJ5jSnJG7dYfYZdEVMHkS9D6kLTapUKpWQ9lw2TiVIRNZnNeYN1rmDOlWWmv8Lq49rE7+3Qiy+I9DibSvIRuP15OceeTvk2GreW3sXoimM/iTmvelAyUvxbKqf8/rzkk7ZU+0uXVseHqZvbxqj33K3P/xnTnOAjdKVMLzIeBupGYYutFt3CTvCWiyIlXzkEzORXXxy/OYXretVMBxonIgSKz5afVblPedIV8EpLh5+kcOpCyI+gNuIhK4b6JE7KN0Ur9rq127C//D1kTtKtzYJDmzr27ijw4RQcsyBYSu+0SaZBwgAXbNG4VHydNO3dZGd9xHGylH2PhgM8JlPEWAzqbhWoFloCI2V4ta8YzLgzlhY0HterpXYczqE0C9NobRmEbiQ5mh5qJaZX/f+s+UKvfVZVUZPAQuapOh6cwcXG3aMywjHlxALfVMr98Ko3PepgOJ694he0w1hxtZKHkzWEeTO9pgDj2ypfbgB6w02seel94rY9gGcbGn1Gs8WbEVuiQwTA5dtes9CVbcEGFScC4bPw4QI74Axt5xCTXkvok+1Ns99OP8hXefw0XgXEc8LRUYUnK11FUmcKVWQAZvhhuYUGrhbFORlGmC7VNecTDeGsOQs33bK4BxScxCVAUlwnm/o9sVJ5NJkPOKzqeCgWagvCZA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(136003)(346002)(376002)(39860400002)(366004)(396003)(122000001)(38100700002)(44832011)(82960400001)(6916009)(26005)(9686003)(6512007)(6506007)(1076003)(186003)(316002)(83380400001)(2906002)(33716001)(66446008)(64756008)(38070700005)(6486002)(5660300002)(478600001)(8676002)(4326008)(71200400001)(86362001)(8936002)(41300700001)(76116006)(66946007)(66556008)(91956017)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DUFM7xTOwdkuiR38pZUKQiDjfdQ2z0OHcKmrK7LP4aDWUmKRyMlwdd4qfFpL?=
 =?us-ascii?Q?wO+LPhKarjUnwbB8PivPdvsdhJ5VAUKv3PKb0r1W8nt6rjXe+Tr0CJoZ0p4X?=
 =?us-ascii?Q?TMgu6Vpmjf6ZkmtCErYER4RvoI8LBqH7buntGf/6Blux4Fc+t2XwYQlownqh?=
 =?us-ascii?Q?gUARysB/Fy7kc8lz1zceUyU3957Jk8u2gxo2En3WWUCZlIqzka+jb75JboRv?=
 =?us-ascii?Q?os3NYMCMvcrGzXjdwr2JnERAxZSYxT+18mqzsbasWoqompWIsvLgtvx72RiW?=
 =?us-ascii?Q?H8xRiUOqLyn7aRbXDw3nSFPq1ll98atTSLsXEEMeg143zfPIbdvXmSwic3ud?=
 =?us-ascii?Q?c3dE9RnC1p7o+5ikIwaWmG+3c+q6ez966dl49PDD/CG86Avsv4L+mPoQ7CZT?=
 =?us-ascii?Q?DqLfJuMw60XWzmKymCZkiUTsSVN/TxBg2Ys1+QFa2Vd2pkP2E7eVaqUYFfTA?=
 =?us-ascii?Q?BlO3rnPwVjZsFp2inmgjGcD2QFHWzpMWuBGZuaxuZ9FkAy7xvRLVn1kESKDb?=
 =?us-ascii?Q?HP/i3UhLdBL/TFw5mITzjnDSIjAX72rNyDwMK2tfRIpugPuNVyPE5bh9RZkj?=
 =?us-ascii?Q?wGTOrMl/yKphhTvp8oDNz9frXr7VreBuR3IpoLvm8+qG1ieLe+P3ntgZ/PQB?=
 =?us-ascii?Q?SPsP6ufzkfy1jW6CYNUi9ru/ln9lpYaeWsa1p976NVqJlpa1zHSN8iNlZRye?=
 =?us-ascii?Q?WOL+kNGvrf9hm0kmu8EKa+NCX1CM2QD9Jk+gTBraFHDfDSjEWMMdEeUpt3NE?=
 =?us-ascii?Q?hs7RpN9m93C6SdjyM2KZqp+51R1BW2zlxyjy4pX3/fMh6DI2TW/AzttVR9U/?=
 =?us-ascii?Q?w7rxCXjUaDOurA+YKD4Vio1tiPssAGG5rKqcDfKnI3p0ePwphk9f1wD/la2G?=
 =?us-ascii?Q?/1mznAi4GHYnnKleYeIggo7DPr80rBj6Cgfn0GcUn5WZ7WDze9FkD7Oqvhip?=
 =?us-ascii?Q?8U4NVB22ABG47ts47sALYh92MSJioAoc7qF49kQqDjZ66uDd3886hA0cNLUu?=
 =?us-ascii?Q?uWW6nW25VftN2R+gClLKHtgcP/qKGoYZrOK8BXHh7Z+DXTeyAt4paEvMfjpi?=
 =?us-ascii?Q?RKFFJ1F1h0sa4cEAeMfZxItgZbi8PO/jRMfkxA2r7AjhDszSwfh8jIryXoSX?=
 =?us-ascii?Q?OndiNCmkFmF8wOZhLxPKt3d5Rr0wl53cuhl5Po2rOyq29xz/rWPmlEkmYxA4?=
 =?us-ascii?Q?C7u3jbWBvJdGF8WXIswftKcH/5fqlIKrqdm48IpG0lyuVp7ABRKIc1R3grA1?=
 =?us-ascii?Q?unPUeydZBDK0zwQ9ShLPAcoo6yFqG2jCS6yeiyRA7KNRGztekANX/GlBhE+/?=
 =?us-ascii?Q?q9mMa+u2Mj7aHPfatiMXK7gfK0VLwRmKsG6OQ4NRnfMC73aXgGV4gvt0eM9E?=
 =?us-ascii?Q?XqBAQoAgC9p2Yzh0Vp00oRhlXUZqRigOnsRklInk0jPxZT2beeRETKTDQE79?=
 =?us-ascii?Q?h2cM+fySlgpu3pql15idCuu0McHjdDUz3vqcV3euPYgYDhCVF6boohkHeudX?=
 =?us-ascii?Q?QIYQIlpIyGATo9J4d3R5kZ26Nj/xHeo75/5nRRFOeYGBu3QJevhXQ2qvR5MW?=
 =?us-ascii?Q?TKNczNtZ26VOL26NbmCblGoiX8SIePUAdN0q14NnHCOO4zkylj3fbs6SoV0c?=
 =?us-ascii?Q?9FM9XN/u/uvWZyw6jmpg90o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1F4D41EF01F1A9429F90B32CA9A8530F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f2c5d9-40d9-4751-84eb-08da745d59f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2022 08:02:31.6430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b0GkJBunIoVhEOz/xyo/c+AEuZokq/NhQt0AUMNIUrEf0aKQqI863ja5ovwNFU373xvWSJezgRPbbshTZplZJMQnq/7Ei9kSof6KHkBaN4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB4241
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Aug 02, 2022 / 15:31, Qu Wenruo wrote:
> [BUG]
> Shinichiro reported that "mkfs.btrfs -m DUP" is doing repeated write
> into the device.
> For non-zoned device this is not a big deal, but for zoned device this
> is critical, as zoned device doesn't support overwrite at all.
>=20
> [CAUSE]
> The problem is related to write_and_map_eb() call, since commit
> 2a93728391a1 ("btrfs-progs: use write_data_to_disk() to replace
> write_extent_to_disk()"), we call write_data_to_disk() for metadata
> write back.
>=20
> But the problem is, write_data_to_disk() will call btrfs_map_block()
> with rw =3D WRITE.
>=20
> By that btrfs_map_block() will always return all stripes, while in
> write_data_to_disk() we also iterate through each mirror of the range.
>=20
> This results above repeated writeback.
>=20
> [FIX]
> To avoid any further confusion, completely remove the @mirror arugument
> of write_data_to_disk().
>=20
> Furthermore, since write_data_to_disk() will properly handle RAID56 all
> by itself, no need to handle RAID56 differently in write_and_map_eb(),
> just call write_data_to_disk() to handle everything.
>=20
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Fixes: 2a93728391a1 ("btrfs-progs: use write_data_to_disk() to replace wr=
ite_extent_to_disk()")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Thanks for this swift fix. I confirmed it avoids the mkfs.btrfs failure wit=
h
zoned block devices. Also I confirmed that the duplicated write is avoided =
on
non-zoned image file [1]. Thanks!

Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>


[1]

$ truncate -s 1G /tmp/btrfs.img
$ git checkout v5.18.1
$ make -j
$ sudo strace -y -s 0 -e pwrite64 ./mkfs.btrfs -f -d single -m dup /tmp/btr=
fs.img |& grep btrfs.img > /tmp/prefix.log
(apply the patch)
$ make -j
$ sudo strace -y -s 0 -e pwrite64 ./mkfs.btrfs -f -d single -m dup /tmp/btr=
fs.img |& grep btrfs.img > /tmp/postfix.log
$ diff -u /tmp/prefix.log /tmp/postfix.log
--- /tmp/prefix.log     2022-08-02 16:58:43.517472861 +0900
+++ /tmp/postfix.log    2022-08-02 16:59:08.197196602 +0900
@@ -32,66 +32,36 @@
 pwrite64(5</tmp/btrfs.img>, ""..., 16384, 5357568) =3D 16384
 pwrite64(5</tmp/btrfs.img>, ""..., 16384, 38797312) =3D 16384
 pwrite64(5</tmp/btrfs.img>, ""..., 16384, 92471296) =3D 16384
-pwrite64(5</tmp/btrfs.img>, ""..., 16384, 38797312) =3D 16384
-pwrite64(5</tmp/btrfs.img>, ""..., 16384, 92471296) =3D 16384
 pwrite64(5</tmp/btrfs.img>, ""..., 4096, 65536) =3D 4096
 pwrite64(5</tmp/btrfs.img>, ""..., 4096, 67108864) =3D 4096
 pwrite64(5</tmp/btrfs.img>, ""..., 16384, 22020096) =3D 16384
 pwrite64(5</tmp/btrfs.img>, ""..., 16384, 30408704) =3D 16384
-pwrite64(5</tmp/btrfs.img>, ""..., 16384, 22020096) =3D 16384
-pwrite64(5</tmp/btrfs.img>, ""..., 16384, 30408704) =3D 16384
 pwrite64(5</tmp/btrfs.img>, ""..., 16384, 38813696) =3D 16384
 pwrite64(5</tmp/btrfs.img>, ""..., 16384, 92487680) =3D 16384
-pwrite64(5</tmp/btrfs.img>, ""..., 16384, 38813696) =3D 16384
-pwrite64(5</tmp/btrfs.img>, ""..., 16384, 92487680) =3D 16384
-pwrite64(5</tmp/btrfs.img>, ""..., 16384, 38830080) =3D 16384
-pwrite64(5</tmp/btrfs.img>, ""..., 16384, 92504064) =3D 16384
 pwrite64(5</tmp/btrfs.img>, ""..., 16384, 38830080) =3D 16384
 pwrite64(5</tmp/btrfs.img>, ""..., 16384, 92504064) =3D 16384
 pwrite64(5</tmp/btrfs.img>, ""..., 16384, 38846464) =3D 16384
 pwrite64(5</tmp/btrfs.img>, ""..., 16384, 92520448) =3D 16384
....

--=20
Shin'ichiro Kawasaki=
