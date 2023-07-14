Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128817537F4
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jul 2023 12:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236186AbjGNKYl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Jul 2023 06:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236176AbjGNKYj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Jul 2023 06:24:39 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE84C2738
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jul 2023 03:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1689330277; x=1720866277;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=frcCV1k9oG9oKj3dpUqdJg1PxRT2RSN/XKdLCPjaYaY=;
  b=gRzaS8ztW1oZR/vXFQ9E9Y2DAwz0YC3w1JPPLPxMQWyjG0jCMAKB6sSg
   /IvKP+qOkDe270UYd49DF1vHvTrx84VCcyUWtiib2QKHbE+F0gKzQhSM6
   e57HGGyjVCGlLmC8HuUyH7JSREW9SIRInrus1p+WbzaVnt+1uWkfopKs3
   4xfP7BxlEYUkNM7eUI5H45bg9MwveAqVQJhkWLWt2MHlom/l8+aJSMqG2
   EFbeFXpy7R8jYoMs/Hhv5yKhN7hHIx1FodxuH5Ov0oUFURNOvfpkSJqcY
   aiJtXZ/p2OwJFnThU7EcKxi8AcTTUiInyULgoPKSpKm21aVEAZ4Z2CrdU
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,205,1684771200"; 
   d="scan'208";a="349962214"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2023 18:24:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZyDa+4x4H7hK1a8YbuD2d1KlVNDwdKiD+Ft+PN/Q9UQVgAh4H/iWxSEL2npaHRc/Hd70V0FbUgW9aQxWLeJo6IObwIfhLv/S27q4WrWh3MNSdM1BAZ8hdLFY0bl2e/2/kJFhXww7OI6xh/9t+SLvDeNI95bF5mgRU6w1COn5rMxwDzBF1PrTGHeWX2AX4pSbc6+KCd+9zrj9urktgfskUR5uKFX1jjppsaJ0y8f0v+xyERyat/7aHcO6fJZenCM5OqRJyjCNOaeMjnKcJ1x1jTrAf432gdFS7wxjpiLTU9iK5fWKr9+cNtiii0X5xOVvu7J7ZEnlNVegH9M3HycZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=FwgS+iz5U/180fFpniYTYpz6Ho4JHskW81ewyDrJCwxSOWiSyMSpduAzFD5zy/q8UZd+HX0UqAScu3CFHM378GewmvB8HqIlWs8MqqqF2w3FC0OI97PGqHOae16Ql2/B8DRIcyUh9NxGc6zouAsQXB+tznXpb1UWMMyBjmPPmvmUJaBUebh6PMeDLoYBcIrEhq22cAEifxsK8ex9jNvUK0HQmv0z1HRP4dYxpJx/lz+DYwUEtcsa8O9ihSmv9MnhYsvG0gVsVRF/vl8twbpTupAqjbcM8Qs/uaGJe02aPeFO5bXhe78nWgR5gJKygYRb/8/YtNWWV4Bp7E5M2gqaFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=pc8Buyw8Z/5cokBTyobh6TE7IOmlDv+KLOqU1nCCKMupxFGqncpoBo8ZUcKWNc5zB/qZYlejrbkvcpvaBnsibZmadD8m6U8581MpN3SKh3oI49tVdkAihezWe4iXVcrXZ9IZEHZ1V4vxFoyAK12WH8xLGXxxI6CzZwNKfm6Iuv0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7382.namprd04.prod.outlook.com (2603:10b6:510:1e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Fri, 14 Jul
 2023 10:24:33 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d10e:18ac:726d:ffe0]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d10e:18ac:726d:ffe0%4]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 10:24:33 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/2] Minor macro and type cleanups
Thread-Topic: [PATCH 0/2] Minor macro and type cleanups
Thread-Index: AQHZtZS7vGveRCxa3Ue8KrcTw71TKA==
Date:   Fri, 14 Jul 2023 10:24:32 +0000
Message-ID: <PH0PR04MB7416E8252D075A53D68E7D4E9B34A@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1689257327.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB7382:EE_
x-ms-office365-filtering-correlation-id: 814c8647-0129-40e1-a9d9-08db845483ff
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g+lywdBKQbVajXdzxlWvBO8FjSEm0YzjtX1j93ZO0DtMlt3nxHLJpA5Av+nzlSd8gDCHfUfjaPdhh64X+btwLO3nBmfsKLBotcWdlzBIRfXl4S7boYVg8M012Xl3U63RGpY79fcLKt8mHNO1TIYfBQae0x7f2LlUplG39+LIu0xoN9eTjhbx88hDLaLY1KU8VyRteh+Y7ud8uTAgkhmivrqJtlBaQ2iXin/kJ3gWKMopEBGz+03uHlWM4zzKzygINZUMqL0KqFkVDasqoBo6lTCem2JGBR3Pqhb7Px+Z9nZ/y/FRBgJ6aCO3Em/8T5X6H92FxMNulpFXUNmfIJq0tq7WJdMTBzlHbyWf+lHIgPw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(451199021)(86362001)(38070700005)(52536014)(8936002)(8676002)(41300700001)(316002)(82960400001)(2906002)(66556008)(64756008)(66946007)(38100700002)(76116006)(66476007)(66446008)(91956017)(122000001)(110136005)(71200400001)(33656002)(7696005)(478600001)(73894004)(4270600006)(26005)(6506007)(186003)(621065003)(9686003)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RQK7IJ0QUSDeCXCXVItltrQz7siTYX4qP58MYtEzq8/2Us9BShq322b25S?=
 =?iso-8859-1?Q?eoGGLlwHbj9MEhvVSrDQhdk5AODi8J4MgoWJB7eXQvdjj6/f9Ib2nwpQlZ?=
 =?iso-8859-1?Q?8yP/9FZDRoEqlRUgrXVaDOIm0cne2n06KVU99ZtIwUJW743MOkRUPulTW+?=
 =?iso-8859-1?Q?i8YnPhRy5hfbGvkgSmHoXdXmH9+V3a2Wt0qmILobgziaAJvSoUAWXjT8VR?=
 =?iso-8859-1?Q?tmYmij3bH/CgZyGUTbuob88/o311eytBUvEvta/IXcRKW10KGrv8REyc4P?=
 =?iso-8859-1?Q?H3afsVLKRbedEH7seKCjcAZb04vVoNUJj4teMjKraU02El9fIvHhe8vE91?=
 =?iso-8859-1?Q?bqE94tzaXXOIsIMtpeB9uiyM90kt1SQWxfM0ZQqa4udHMkc8wgpz0wwM8N?=
 =?iso-8859-1?Q?jIIqrOK05tbPpvwiwDdbQata3gn958yY2uoPFaT5fygLFhEJAOa7bsN1zR?=
 =?iso-8859-1?Q?w2hacJvQ773PWyAm3Lpj4nLYhHJTgyrss6tTTzPi2NwlQXmcU6W32ZfVjs?=
 =?iso-8859-1?Q?RUvYk5AbpaHZawlTXAdrakDv3o3/2g8DhU8BkSfMR6ckww8FDtv4yPNLCq?=
 =?iso-8859-1?Q?cnGMtYPAdtF07TPQ6IsPhvUzzndUjRyiFBsEPqlqSTn3iGrgRJgnqkVo/7?=
 =?iso-8859-1?Q?EyzF74nY+BPiX9Q4xaw3W/rkEEO4Vkzf7jmvmvz8COaR7pUPj4z00GbeL7?=
 =?iso-8859-1?Q?LCO+AzXYH8ul88n5mAGZLGd7JSGjqQ7djf5l6htpl8Zf2S5Neo9rryTxIJ?=
 =?iso-8859-1?Q?s1Dy/XZkNDOFvJcggt4lUxsPmpBORyuxiRUgz8ncvGdN3AeZda+MNr460q?=
 =?iso-8859-1?Q?7v83B76O1KpLtDTpQTORLbyccSeI472V5WzAJsawyeNF3xvlk6REcS3Wib?=
 =?iso-8859-1?Q?mOxPMTBdP+8O8Xc9t5QkuNFkn7jp2yRVhGffYYGxZm+g2opGflO6vK16cC?=
 =?iso-8859-1?Q?Xuue+DJO9Fkhn9KRG2Ldx7RwFjg+9KBt0al6DoFjEFZtKeg+pEG4yDTvxH?=
 =?iso-8859-1?Q?+P6JQYA/8wnKzyBKXqDs4AwTKyBCd473+YtWo5RDdryhOaG1G9duxKoIOE?=
 =?iso-8859-1?Q?jKdHR4LGTBEuyIRvkDH+V+Fn3ofpR9oZC18GcswInCiYDxKBXEteB6mzBy?=
 =?iso-8859-1?Q?msVoskMtH9vJnFvS1V0hMTkGP8gLOD1EpJ8VTMII0ZyidrF+QXj2Cwt14M?=
 =?iso-8859-1?Q?NbUYpgVqXHbqFycemsbhFRHrRkYGmoROnVcjcMoSKJS8dgJ1QZeXZoXoRY?=
 =?iso-8859-1?Q?J5x6aZmsDtjrzvLX2YpMzqgJZ8EBTuBT6vpHExs7CzZK4xcZCnFCu8qZUQ?=
 =?iso-8859-1?Q?utNxsvIATr+B5VcglZKy/L/fUKdQVdRTanFofTpWFyu3oSgD8cw5vA+/X+?=
 =?iso-8859-1?Q?loNfwWUjRP9xjjOT1ULxlbgksycMK4MKvd0HXzaylua0XQwsd5BOcxyHMZ?=
 =?iso-8859-1?Q?4aFO+dmJ3zHVhYSy8p5Pb/OZIY22Mry0ynggaO3atF1IAOd14BreWnMzMP?=
 =?iso-8859-1?Q?L4yXGLgwjtY7NYStU5q+NFVzuuw6uks6U8xgUwd9UXYIkxaL4AbrOsNeZF?=
 =?iso-8859-1?Q?+3/w8/8DsrE86r30XJBvdgiqcgHrEStDjjyfGy9GlKLvRECOVwJdRQDBfD?=
 =?iso-8859-1?Q?mKinBt/9zdyS/vd8HNRk/wWXzkXgMocFy6YOxQxevgZkJpLYAaxUc6eQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TWWP1jRzhD2aqeTiSToZw0BYxPiFy0+IGskFGkZlBaapBTBUoroY8RQkVPeAAVFfXcC0IcSlzn/9HJg+6otC59EPqQaUWqu8opciZoObPIVjL35vpMP+p67T0zsNtVQIZupQ/wVrQVN4MhTcwmsdz7CSPjWltWoCzQVyPcptJnDiMGCE+pfx9088o0xjFtZw8cUi16fHOhQBbmw9/IVM7YkibIxEGwWwYNw/8Ma10gKgm9m6i6E/B7T78vV0HWwp8hCKfB7N+E0jPMReb1sk3jL1Ykvo4K7IxWYNCO/xWDxWGX3KkMuGWxV54OaD1DBgHSj+lgX3MpdZ+E8GlcZCDAUfRiRWou0rNAp33e85WZAvWVJz9c0XkV23fSMePp5Z2ksvEb6gkrkdDRMcMfTTDg5YtijR1/zR1ONgMhS0/oitR+WAyjT8Jjw27U8e8VoLaq4kYo+NNtziDHuCyJlna87ks1uXgxyimW1ZNfqCIlpdRKmkKR+2DQ6+RhmzGJd+sYjn8zwfLneURhW0KBkNdq0ftJBu8tyCt4vpwq2Fq6/Yk14DCfE5FihuDjILdy8PR17O3iSczTKBi0WPPwmrL4JKk2N9/3nExq/3mfNo2yBRKA3KURbHBTnU7XgxOTE+05CF47kxtQ2G3ZsUL51LljWg/l0tkD16t5DOOwVPmbQD7Aqc/Amp5tMxu8s71wBY0mtOfG1SNb1M4pYkU3cnTSGx4CDCWoMNnmACz4fgPyzK512UEXYtA2bCjF865od+q+XCgM4Aws4Tf5PZrXkThC1c0CX4KOlGlHFbyutEo5gP1gBAnwxXVG2Ma57cyrcs
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 814c8647-0129-40e1-a9d9-08db845483ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2023 10:24:32.9442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1ZJ/iTsAX6yZXcWXAOitwYnBnsayU9Eos45dx0qWCvjJwVVB/xDITmQfynMCDgq5WzgWeVHXuXmOIdCAUZiezuSziAQpjXQRT0zmy/dDbQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7382
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,EMPTY_MESSAGE,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


