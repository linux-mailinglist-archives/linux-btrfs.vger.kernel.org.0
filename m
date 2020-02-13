Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E496715BD84
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2020 12:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbgBMLPm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Feb 2020 06:15:42 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:51647 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729526AbgBMLPm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Feb 2020 06:15:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581592541; x=1613128541;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=Ar0PDUcvj8zvWuipioZHd/9Aum/RlC4XN5X4wKkmBoSibP/T+C3qEovA
   gzfGwXM4CgX5ojZMAxcQumocX/usNn/8Dv/I/Ef+bS/ZuV+w6NimLT8Vp
   sq195uXkB9bT3ZFScoJ9Pzc4tFCHAfkeKrGasUqUOcoiRgHz1hVMS4B+a
   HQT/9QQjuG/on5CBvLTKhC9/wxRkjKvYmBQsBsI+Squq8n/Mky/z22hTL
   0p9D7bvn18LxzV6xNAPZ2l+CEeONemKDUxC1WG+/OKSf3ooaZDRVWjP1Z
   DoDxkKiDVTSyXv2979KakvOdBmPNz1mkzbDmeuVl8Pgx3smz7Bsj0KzMT
   g==;
IronPort-SDR: YWObDBXfTRPWWvNJ+ehW6X2cSNjYtjXKnrHafHfGEvSaEcKFeIJR4+Di59AyctSzuj5w7uJ6lr
 PtA0S380NYTnmp6EyIX3D1y1LInnRK4aiy81MiQvDbYFM5+cDKT8QW+YQhreyyf11ugbULiB0t
 kmiSaGKkXUzKDeTXjMtAowwTECfWRi3Rg0Jqt6FGVwnZJq7gD+UnxbnQeFE6TGbhY5i0CcQ+G7
 LeiyM4c2hrhSQCRBKY+fo3n56FYQUigFPGp3o1hDsxTltt5BcQzokc3vZBHSYSWFY4HNKw362e
 VSI=
X-IronPort-AV: E=Sophos;i="5.70,436,1574092800"; 
   d="scan'208";a="130298289"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2020 19:15:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBz0b+t/lDRmI2/PPtuXbnzMRIsiji6kOYzmqBSBSnBoHOeEDO8u92yvgPA2cO5c70kIL0oit88NwQvNaqOgKgW8woxgavnz4weA6Ol5rv+nxdfCSFmEkOgeMg/Ah4kmT5PtaLKrvRJt6g23FVKo5HLcsjGk0mhoMWnE8/Syf6N8YOrFLKcJhLMu2wJRGzBet2Y6n6m7o+PFGRsuNsz4rRGnJSIAz+PDcYWHtcVZisgyIqWybcc7TSeH1tYjk6WOXSHhAe442caFIJprKiLJa+iI3rk6bGm3O8BRHrwBsHj5DtvLlT6MfVB9qnVi1ygqUF+KhYJ27q2Fs4MysGSFaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=n3Wk87+hKaLqPtnxRZ9gq2HBom2Xt3Rch5qcDt1tO7Jhz6JCt3wvNzESxFLdpe9LGTEq9Sxg3WJFXB88meEybHTpMB/O+av1IeRMOy+5ToJ1pEmLWsO7YLTr3stLAqLy1IokziphKjt92wUecO7kqs+Ou9WutSix1KgubiC3aILfIcBUxVqk+8SB19efxK690PS8qDt2KEzP3zOUsDfCr4jxStRhea4nxr7E5doxBuVGvM0x7EhFV9klGMzXeOAwwlQDO/+Y2uIfDtbIbid/629GM2X/GaviOyN7eqZh/Oda9+5WrmnfbaSeSrW0QnOjp5H0WmjRTt1SZmVeD0SoDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=icoYObKyB+Jz/05IF8hK2EldMaCfY0Fm126LvQyxKcZ14jhIu+PqekRAXSz9Nr/XznlY0aqATF1POFwvV1vZjreELIbxeKUcZ7F6enXTntoy7ogLwE4xGX7cfpKx5yzvfm8/M0X4JbnCWPn6V71FQF2jez7Vbk9/fYm+Y9JcmYs=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3568.namprd04.prod.outlook.com (10.167.133.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Thu, 13 Feb 2020 11:15:39 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2707.030; Thu, 13 Feb 2020
 11:15:39 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 2/4] btrfs: do not check delayed items are empty for
 single trans cleanup
Thread-Topic: [PATCH 2/4] btrfs: do not check delayed items are empty for
 single trans cleanup
Thread-Index: AQHV4SPxs7uaO39aNkW8vC5rZzUrtw==
Date:   Thu, 13 Feb 2020 11:15:39 +0000
Message-ID: <SN4PR0401MB359862AB27DFF8E1DF94183A9B1A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200211214042.4645-1-josef@toxicpanda.com>
 <20200211214042.4645-3-josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2a52b499-55ba-4166-2961-08d7b0760e9d
x-ms-traffictypediagnostic: SN4PR0401MB3568:
x-microsoft-antispam-prvs: <SN4PR0401MB3568503AEEEF9A46E262324D9B1A0@SN4PR0401MB3568.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(189003)(199004)(66556008)(64756008)(66476007)(66946007)(76116006)(66446008)(33656002)(186003)(2906002)(55016002)(110136005)(9686003)(558084003)(6506007)(316002)(91956017)(4270600006)(19618925003)(26005)(8936002)(86362001)(5660300002)(81166006)(71200400001)(8676002)(81156014)(52536014)(478600001)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3568;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SeyIFIj1mtkWxi2AbWq6jSE/S/ZuqODNLI3Fu7TbuVliMi7JfrJQlWf8RnBjFO/eWjkKR6Gbbng+f0mKUgSfNpMpWVURBmGPSUW0IcLp8/LsUYcwvUuPDWTSP5e4KfU51sycB5LerjIKvl+PgYLHmWN5hHG99Ncsov3KPmdJoTPBVHr+oZf9mhUEfztqFmKtU2owXFgpxmz4qVHas5r8JsNVOtQSNYCMCp3W+pkLp3vnfgm3jNRuHqI+gST3xjWctZX3B6gk/qWbeTD+BWFhC7K28Ohftu+ziJoooolb+QU5Rbeh+QXEHo6Ctp4DHVUQ5eDRYmWsv+EWXegmWx5kuthoJ4ENcddzx9aeMw90Ab822YIsGpUSHlqnO6ICNQq5GXbyupSglw6fMaZyluPuvlANICEwQKGr0gNLM6e/Mn/E8P6RDpmpwqhmJPHij86F
x-ms-exchange-antispam-messagedata: JU6BfaxbwElHhm0v72UxXKRNn8RZdFrEcqYwSxDKf89aR+7yhDDSoBE6VQcmE6/TmR5aI6RjGfc7iNl3cB/roXg9jPwfoU9/3YIcC4DUDmDFLKAy0JbIBAOvAoqdXnrW4W9xKREOxKILWzsuSbwAVw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a52b499-55ba-4166-2961-08d7b0760e9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 11:15:39.2385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W33rdoHsMJLON03G00SW8vVERoG0Yf9xrGMGK+aAY7K3eRsYXvjztj7CMZ5zM96+/Mi+RiozyGfkN1wQ0CHXb4oYVH149YedNqVS4xwaA1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3568
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
