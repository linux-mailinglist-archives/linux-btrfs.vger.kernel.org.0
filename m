Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD58336B670
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Apr 2021 18:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbhDZQFK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Apr 2021 12:05:10 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:59323 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234198AbhDZQFJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Apr 2021 12:05:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619453068; x=1650989068;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=MYZCr3pVSO1ala4utfSxui+T1Pql7jP74ndzlumh8S1SwFVHtgHW9gKH
   eR2JqfdG0Iaw9HCTEdc5BTmec/m4WdzP6JloBLps7ObzPgFeyRN4e5806
   zUA+cuWJ2xcutQrt6dg6ZghA3gcORGE3AymU/NtN2Mpsr6t6r3yxK0BZ3
   JeGhWQtQHz8URLfwHfFBvVo3Lr2mnIfb5C6Eedc93o3BhAHze6V/Y4gui
   hUqkORYWXaA23ERd2/08GjhSaD5mYTBmsc7H20hLnfGU8PUtuokE5ySyC
   WuuJHVW0KUcvFnG0dDpiWa4wzP2p/mHHCnVxl/QmFrwei19lhRwwBD58a
   Q==;
IronPort-SDR: lvBGZjU7UvmrV2vEe+yoe2J+kPgqFz4EcVvJmVyX6Xhjnf//U3QXM6hRrf3kPrQWpV5HmSf61O
 FjgvObamt/lkMwHdh3Dpd1sK6A97Y9FMu3kaBBZ+PDvJ1+MN/yrTxS2pecJ4/n+X+2AoS022Bf
 nmc3e05DJWRc9IBCSV80uWLvSYgqtSLxDhwNDGzqfb5TX96r6dwchUUlO8cKBPwWBnFrs/Kh9b
 92iUNtBPAyHxVcmPttzK0+3RzAQ9+9c0rvGwCF8V5LvtfwmLqv1isyyxur7WNzVlH7bo/Zl1Qz
 +QQ=
X-IronPort-AV: E=Sophos;i="5.82,252,1613404800"; 
   d="scan'208";a="277285117"
Received: from mail-sn1nam02lp2057.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.57])
  by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2021 00:04:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pa3K2Pm5VP2RkRa6STd6r1prbzdwtGffZGXTfP/ptkjFxuKtrtjio/YS1K4e2btmn2CWSPvT+0QbutbtwFpG6bIX0byDTCOHPnOcJS7w8G2Qtyef3je87o8D7Ev++qfEkr3sVAiQaN+CZTvPGB/qabrNyuEkg5fBwU+Wy/4aGTwQ6tmlnAfUaMZnJdxRySXWxKkBU2ZXAG07ZiqaA2l6YS2jhosfnD/xLhqlx6T8NQPkEWeNg1hiy4HOUyXVgPJd71GlRiBW7p3KfjEUK5T7T8G+S78y1ISjBlSfYJTsViZhl7XFetSLG52eGDjpET92G1DokatDN+jkXPAxWFW3mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=CENoYKOROGQI6DO2ccoSkesLftN0hGKvjdDQV/qXR5EH24ULKWeKta/pjHtCH0xd8iMz3ald0BKhGCq7UlIgJApiSh63ig97yDNemeW1RyX64zZkLPpbHrxq5Clat/XMDgsPZrLTCGqSlkzzPVH8zQgGN0Jy9jyEW9iUPH6ZD522mxTkrkIZZmQBqfYRCn+odiCYTX9rsb8DcThdwtf9OPkcaAPyNl7gBrmFgGJeukU2u40m1jo9mQJ+B5pRfdcbG+8kzS1874IF0evwvCNj5rUpTMFgS0p8Meol5G9m9qAKhTTlVbWTKI8tq7IuTu7qQ9xVUkzgeAPxsBYzKJqrFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=wGihKe5WuCbY1slrDw3NaYJUOhlEPjZ7HQKHp0uBv1EQ1teRLX47Cimd++BFFLx7SaNpKOJNRsUvN38qALYIrIJjhscfGs5H7F5ttwj7fhLD//cFgvtGrSy1AK1RJHPpFbBfP6rpuzAf+l3n1UyMJLaoRICAbl8ZveVgCoHUupo=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7718.namprd04.prod.outlook.com (2603:10b6:510:56::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Mon, 26 Apr
 2021 16:04:27 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 16:04:27 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 10/26] btrfs-progs: zoned: implement log-structured
 superblock for ZONED mode
Thread-Topic: [PATCH 10/26] btrfs-progs: zoned: implement log-structured
 superblock for ZONED mode
Thread-Index: AQHXOmVvVfqE07zYlUK6goIQh5H97Q==
Date:   Mon, 26 Apr 2021 16:04:27 +0000
Message-ID: <PH0PR04MB74161B1F6888867E81C8690A9B429@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1619416549.git.naohiro.aota@wdc.com>
 <3bb3fbb1f36ad682c949eec3476dcee00a15a132.1619416549.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1460:8801:a931:3ebd:289a:9adf]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86746e03-a853-43ae-a7c5-08d908ccf7ad
x-ms-traffictypediagnostic: PH0PR04MB7718:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB771836467339F24FC3156C039B429@PH0PR04MB7718.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7sH3P/O5wl2HPSOzwKFhw8SE8TsTo624PPifVgc9wc+uFH97ARZw3lPWg98UCyXldmgyoL42fmKy37cvJmhJ6jrGgCt0pfJ7SFYHN4qvwOWPbUOz317oTErwuVl3AFOi5EmkiUFwEz0uMYmavYbpKPbcXY2w6PbfjvSSOHUV2AxY/zzEUW2fP8uifb+PbUve/GAF94KVGzdYSVYlznsuv+A/J/b5not5Huxo0W+1VK3mksqi8wocbE5V+WLMH5tkfEeb05Exne5MoeBYNPit7mXyjeUx5dhfF+TwbF0RZdJ1HUy4Je8IT830WE7EC23S7jzuqNTBMZEBv5bh+RuIqTGlNP8cNDL3DPHm4A8rhosHPlL8uGpThfQTUJ8/N1S2GogS7UteVUBeDUQlQhu9LowqWd/f3pMTcW3ppItQUQS1WZyKUNHMQYzqQEfxfgrOtHWK1g4F5hAWccXp/UoWQeFFuxEjko85hh9azF93I78QECSxbeu+rh+CSS4d37ARDR3o2mYCwHZigIIQaqxCQ2DZCWN85GOWvgaVIMjf8Zj7J5/e/JQd2wUy1jp4QDcBUZ7q6uXOGKI3KCgJaxnsZarUfslNFMqArJbl+wH1FaU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(6506007)(52536014)(186003)(4270600006)(122000001)(4326008)(76116006)(54906003)(478600001)(66446008)(558084003)(38100700002)(66946007)(71200400001)(19618925003)(316002)(33656002)(9686003)(86362001)(64756008)(7696005)(2906002)(8676002)(8936002)(66556008)(66476007)(110136005)(55016002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?xcum1yAtRlxyOuvZWFMJwPK4JWVNTz4OPE6du0mKa/XlrMlNLQ7jQQ8Z6aim?=
 =?us-ascii?Q?jk+JsTpYAZBgrMjmjwRWsDa8XX8I/93yJiXm4yRcWiR3R4ldze9GRgGJ1h0s?=
 =?us-ascii?Q?Y748rBGRCqsUBe/bTtZwZtrFdg+O7//b2huW+ufKXKZR036HBzgC66Yhe3nb?=
 =?us-ascii?Q?sxNOz8NMkUBqnEODImwZ68xe/80BBceFFg0IcvGpC6P7xjkMQZ8dOYBWyFkm?=
 =?us-ascii?Q?u4NfpsN+hyUVACgRTku+ESOmOC/bPIVOrRgNm+BaoAuYIOUluvoatYbU6JG8?=
 =?us-ascii?Q?M8lxedyf9BhhTS/xM1h9bxeh/CKY+GgABYstMvHh4XrORwPUkmCb8DzgzZ9n?=
 =?us-ascii?Q?qhAt7zeZXxi4jNk54wQNIoeBly4rYsYvw0qWWCU6+GLjjQ/P5jZj0CHl7zEO?=
 =?us-ascii?Q?NnsiF+y2wHW99uLJq2fXAyT4JYGg0199NT4IZMYEElqpekLJmDxqwyH8O9C6?=
 =?us-ascii?Q?E5zzYjAHLqLd3ibJ2h9o0vG3ja3eN+T+8H7zuqn2WE6oUSGcbGLCjFiykasz?=
 =?us-ascii?Q?MgXgOQD4SLZYLpC1+GjG/Uh7Es3SuEr7H7MCUUlFire+kATupziIV5zl4+N8?=
 =?us-ascii?Q?JR1TPGjBMq2sPs2hWHdpQlooTQ6v7CvjDcwoX7Lm+v/o/XMO5da/Qx+yqqmQ?=
 =?us-ascii?Q?/hbgD8wawOfsCgNu+MsNG5VlY6ZO8Ao5NvwTs8IggS+KrA7K4HHUvwXHMaTw?=
 =?us-ascii?Q?OFZtoQYcAAVHZloHcxaUJajFOrW3vkoXuFQA8cceAd56lisP/pEjBfYa+81Z?=
 =?us-ascii?Q?gEdJuRWpApdIDrZHwcWOD/Eo6AKM6FsZ2ws7lV8iI+JE2F90pIst1kK8ErJG?=
 =?us-ascii?Q?YOOUugJ6X4LihkgGffSi1cvyXfcANh0BPnop+3OW7CuH/foBbiAaqG7QrZwc?=
 =?us-ascii?Q?0rh/DiVowufsCRLGmRrbl92Azhq3MikstGjBYBq7Ys4a2hPJI98zo+/6GLUY?=
 =?us-ascii?Q?8/5Yvz9aMK1v3NBo92g/UP/INBhfydrMbJp8mZFGDvnK3/ozKIpYV1UallyZ?=
 =?us-ascii?Q?fWBPdV0GghVWj+5BGLk3w92rEamD9VpVFmAl8D5tz8H5IAx8Nq/y3THR0CBo?=
 =?us-ascii?Q?saN4aZ1HCo4E0i9LSVLYovMSGTFVUW84iC8wFkRu5Z002Zmv1AH+y11QSnZZ?=
 =?us-ascii?Q?MqQE+iX2bbi3S8N3l+bo2YRGyteO0Vn3Q2rON7ZSr7R/19QAm316SYt25+hK?=
 =?us-ascii?Q?PW652ZdXk8Wr20SstzhBwXadJAdhp7+n+6ZsIEdxVgpRAHSvCHAh3w540RI3?=
 =?us-ascii?Q?uIIxUZ50WOTCtrmRblegMhInREx5OZCgRdFFF3EzMgdfijDbbZKJ9m/S07Tj?=
 =?us-ascii?Q?UtUZzmMsB26Zu+5XFzvcGYBnb0HFjwlt3eTxKasaACHDgcEEaV7kD1PBzp6f?=
 =?us-ascii?Q?lNi1MVU+lrutIZJ5eviRLUw3NKE+/BO/726M3ZqvVGsPrXf6zw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86746e03-a853-43ae-a7c5-08d908ccf7ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2021 16:04:27.0294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z/yg8QMhHZzYdx7MDvgLqtCiWpqqy9L6Qq83G9BSNJWyWmEVU4e4STUeSXC7DiJx3tTyaWyzIAftbzpDUMeTTKJwxLecVPD8vMR4EIRKKxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7718
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
