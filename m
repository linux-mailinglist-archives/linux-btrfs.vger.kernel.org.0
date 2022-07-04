Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74974564F17
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jul 2022 09:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbiGDHw6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jul 2022 03:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbiGDHw5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jul 2022 03:52:57 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73A9A1A0
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Jul 2022 00:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656921176; x=1688457176;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=IH2GADL72LnAtDxeeuRXjgne74cnYOsimQAz45K/XTUKhHai+ZGmjEn2
   DYC5to+DFQx3gghx5v5Zy8idRp9rHOAX6aM19YjqboMIz8XjbpkauRHFs
   jbpTsUJjA8US8v2Ybp0PC9xtEKPKU4bly5nnxj6dRPyEOa2kzX7nL7deM
   BzaDy5fCLb6Es11GjjqYlr9gP2BW/yzzVnn2ah/otx/tB+YjG15HSYog6
   ZVEd+K/rE2gHJ/enDTgPk3KbXWIAPhjMPbXI4LCePq5O2BAUS7O19mLHU
   kpa76NLzLJiwHOsM2/ju/Mo7MW8w2HqflWCsd/nUcCavp4l62s04/Biev
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,243,1650902400"; 
   d="scan'208";a="203405192"
Received: from mail-dm6nam11lp2173.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.173])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jul 2022 15:52:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNuL3RLHgeapICwJpilVDgq4n/dF1GjOuQuF51MSF1Z6uJLTE0cqAo2kQT3OOlYJskuPfoxaXJdvSbAHNwZEn3ucLmV4Z/QjU9Sn6UNpqG4SItaPQwNM8WZQljC3O7SlgcLsyhaSCogf4DuGUXbToxHSIhbVcjpVxJEWrzUTFjJUuBicvYtwnsCjhjmV2I1vVaIuSz3+sRoa6HLiV2XTRsh1ZAC2mBW6x3K1YGDQdqQ99rctTy+K2gpo9tBdrG4J56NsrTZoAip2r9OP4clQVh7juiKilBCSTa95TCj2HKe9b7GrGlbbHLLBj5M/7xAl689yDEkpZPM6vTgzIYKHnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=fNhdYYSVt2uRjFpJHZaPedOU09urIaXx3/S6zApzZoORRjHkEUgbFwTtJMRE/epIviu6mWta8AhjVb/NVx9NFf04/WEnZRaA4X7elfPAL/hNudm5R6KSRCElg2AEAI5lP5zyMT3QOjCbAObiZyLR0fREMlYluZtx5gVIpWOoF2sCmUCbYyLG/ZQ8gJcARrLiZmiUs+7jkr4F5Sta0WTCNQvK1CSzGWuwPTtzfOsaShuQxVxjLySndxlpurVUm7JoghBrgvY3QvcmA8tCakBc6lMsqeVKLVHFqUlyMPGzrypaibru+KNrAXT/p6fWLly4owtkvEOJot8NeZXH6zLD1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=arh3Rwmi0cMq1H2byLWZunxdb4L9SXMmTz4SDs+CQLbqan+x4wBXEUAlm1Ky4c4sZMxgBEbgtzNzcKIK+iGsNZXrBgPvOvuSVAl8OS2X8dngYjo8KQRJvNyZTBdekX/H495dt8A4043rIoHCQ0CgCkQEme05Wzs7Hysb1UOVmos=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL0PR04MB4561.namprd04.prod.outlook.com (2603:10b6:208:42::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Mon, 4 Jul
 2022 07:52:54 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91%7]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 07:52:54 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 09/13] btrfs: zoned: disable metadata overcommit for zoned
Thread-Topic: [PATCH 09/13] btrfs: zoned: disable metadata overcommit for
 zoned
Thread-Index: AQHYj2LMvuRePJV1wUKyIaiXZVKTfQ==
Date:   Mon, 4 Jul 2022 07:52:53 +0000
Message-ID: <PH0PR04MB741658F3C08B3DA3A092BC6A9BBE9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1656909695.git.naohiro.aota@wdc.com>
 <3d7e559990ec7abe5cc5433b1916f62b5c44e818.1656909695.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fda4404b-24c3-4e28-eb80-08da5d9233ad
x-ms-traffictypediagnostic: BL0PR04MB4561:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s9BSJ/BGQFFIfE/tkT9yyBFxqZYAx7DldR9WknIl67TQVyouJf+jsJDKZJjrcQ/Yk2NAmHt6L+vEpabWqe9kYnugZDvhKLirWTVzr88D+Bh247onEDq9ff+Al/FvkDkOlztGKwu1VFYUru/uxQoJ8TrKblEdYYDZvpEkUc4UY8j6j2AlxqYoWwPGaDg24o0ObBhvWrb9EYkOu9Qwf7Pu1eXmJCVFLkM36lrXTFQRmB7PdX5/tfb3lc2lvDrdWy+Psa2BJBVZqtpU/198skgTkV+UJCeIzR30unEXot4n/U7foOS8iFYyrwPY8E6yOEY7zG4uk1WzyUjIZgk46nwN4RAM6mWp4Az+PWiI96Be+iLfLKta5Xr45Z/F/5STPEDgotHA42uu68mlxM9alfw9qVV/cujfk6byXILHjwQPurgKzhu9s16Sn9JtBfAG1DyicgaSdgtW+cZRcSvbdHcGdaxOoAA6B5Thn9ktqzWaAb7gksgg7WDQiJoTaJKSTtiSXjcFtUUdNsUy3558cAdJD8NJjSzLkEmmK8XxvFxT/fD7W/56KiaQ+A3qtIduEQqZ/Uz45Wl/j5vx+E0MTPJv7drPSkdi6dpqCPz7N4ZAcuOLSBLO2JrUnYtUXYcS7oWIQp/SFiocdjmA24DQpxmORGgd34pAtmOZPnmRs7BCo5DjCb0HKzaleHSUmj5aOX0mp0kOCzUNnGMe9bGcuArV0efcXTvdlL7zOUVoH0/rnvtKTUULRYpjhKCUKlwuWWxzy2okXbKBL4vEJ24xdq+vy6LmHQlcuay/IQ0QZ4lF1pmAgG7n1UPwJ6BDFuodlfjG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(478600001)(5660300002)(8936002)(38070700005)(52536014)(122000001)(82960400001)(110136005)(76116006)(316002)(33656002)(558084003)(86362001)(71200400001)(91956017)(66446008)(66556008)(64756008)(66476007)(66946007)(8676002)(186003)(4270600006)(9686003)(38100700002)(41300700001)(2906002)(19618925003)(7696005)(55016003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YWCvxw3tmKi2YBhDCmjOLwp7ZIeEP9Q/xLUtNEhVhF8gfnsFRynIpxqeyFBr?=
 =?us-ascii?Q?i8XPCfqJV6jAVaRXlSW3aSNc6QEkPOZNEjdAJLR+1P0vuwd95j6pZ1Sh4EPX?=
 =?us-ascii?Q?UnBasaCrpgtN78hvN96loJu6ZUu0KejEJ8h80JXYYVoLeQzKQwXfOhM4XAM4?=
 =?us-ascii?Q?qFzehUiWoq5or9Uz/RZEb+qJuyA4rFQ4Gis2mUtKZNeig/VfV2eOsHyx0Jmq?=
 =?us-ascii?Q?vimKjZBCSq6opkpVfbZj+Vu7cLEQcwqjBJDsme1ZPqRabur9alpyPsAPYLKv?=
 =?us-ascii?Q?suoQ3aNsUDD8oo0VbKyBEgPLt7zDy9XhUxUsYTMTOocr6l0SOrbD7GQqqK4L?=
 =?us-ascii?Q?I++nrmYuvTrAv47q2oZJFwkNnlv5pHlJNqaUubNVhQngGsGXygbkYwRcPmvn?=
 =?us-ascii?Q?kY9wVHhtx8b+ytPBRySO4smM+m8yA9JVV0ajtof/7+vWjgVDTW7q9i+qvStx?=
 =?us-ascii?Q?kYxdOZaQPOysQJvq7lujKbjD5yXSGE0oRa4oOFlvza3kh8JKpUmNgGX7Ebe8?=
 =?us-ascii?Q?l1ucBmGRXL+uYeWhQFAfdPeDxSowyUBoGqOlHOGw/YWV+prk9nwzfVl/QRy2?=
 =?us-ascii?Q?iqxzHac2H8GtJoadYcvSdERx/4GDNosHZXWfTvVOSslrz92TgxkFtesBDzFL?=
 =?us-ascii?Q?JV2Hpk3j/fARmfVfMsZ1GygcUMHOWFIOp6kJecGp/y+seXIDk0oBT9RA9rtO?=
 =?us-ascii?Q?GL96/IXOaHNhYSrkeqHYbqzMy2LHlpvJeLFk+Nu36WgZGuGW805fE992nn1R?=
 =?us-ascii?Q?mdWm4FXlRKQR3G7FkMYvioOb3ZbM//8A8lLzS8CXu0ElBYErekkNByht+/4l?=
 =?us-ascii?Q?Ovy/9+6UrUT+dw0Q1ye2bzqoREl8NTIm1UwgFVLJKXx6gR6WRZRk3x3ooPuD?=
 =?us-ascii?Q?EseciYvv313jsVI13Qbic4Wd5ggF82vsjB4vmgkLr6ovdNtSIwKVXGgCJTiZ?=
 =?us-ascii?Q?xzKtP84LIdQaffL14QMLT1Q/h5Do7px4lauGHQQuCasBW3tQ7W5Zg5/BIWvz?=
 =?us-ascii?Q?EmnhhI9H1t35/Ga3S9RVTHR+KkS1xQke9phhcktu67ahNC2xSD7mu6N9ea6H?=
 =?us-ascii?Q?ER/Eek4+FoXKBTO1/EdI2XED0oNnCojDAoiwllpal5FjTOrANaiQozp54RLp?=
 =?us-ascii?Q?tJi/A4zBDkG9xkaokHZcsAyzE/kSXxsJ1pjHlAi9M234gfNj4bDfuFpHjYXw?=
 =?us-ascii?Q?23Sqk7IwngmiFWHzVn/JSEEeVwSh2B+12NYXWMqw9dJDYntiBoZ94xQafEgm?=
 =?us-ascii?Q?nhx7gU4hAhZUtJfsUICBPAaLd4qZ2L8X4QTzkPdLj0wOqky5EcbPZ7Grv2PZ?=
 =?us-ascii?Q?61dTOXLAuoOFATa2AQH8jK0Cx7swfeo8F9XV8xPDjaCsekC5vnYO6JVLy3+j?=
 =?us-ascii?Q?TRMmiB3EIgRPUNjFys72QHFNKvyCzXUxy+r2J6VBUgVnti36p2/qu+LPC8ym?=
 =?us-ascii?Q?x1xb7PwH3beyI20kBy2+eOwGK7jCPNYTcceyjc401NqrgPd/P9WVvy33PSS7?=
 =?us-ascii?Q?7XZwEl7Z6X1IJpJQ4aMhrXaR3s1sr1tqCIr/+OGqMEEZ0lTEu3ibTkXJP1AL?=
 =?us-ascii?Q?cYx/DyyAB15N2yFlw6L3sGUKogxD70Ybr3NjgeA8ZB3Lg/Sh0NwkaMDgsWK+?=
 =?us-ascii?Q?K3dNXrqB96msSOTOGRxvewhSVGn+xFyPb5gVxHtllzD1GzfJ8P83C45+8IhA?=
 =?us-ascii?Q?1UgIjBynlD7bs7NNiOPpwfgQ4gA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fda4404b-24c3-4e28-eb80-08da5d9233ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2022 07:52:53.9521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A/ALUwyzrGpYGdxOiqCTLY78Mgk9Elxf2X2o2XYgykrTUW3spuLb4xG78QeCHmhESVP0yQZwUOqLwootUWlCLdBKaK5FSMzQWHgiWt4FOaM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4561
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
