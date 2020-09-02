Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6449725AF5B
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Sep 2020 17:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgIBPhS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Sep 2020 11:37:18 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:28861 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbgIBPDq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Sep 2020 11:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599059025; x=1630595025;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=8i15wle1U4g9zkPMNWCzeLegDLgwEpE+FRiKCRShuK0=;
  b=d+W4al6DwcOEFbLyjnx3mAqNGItXOC3JxWdYBgBnH/mjqcYu4MjVSOiq
   2C9NyL7aqL8ytG8GVfDQ/dZkUdXn+XS7KDfwFzpeoNZs4t3sWTlnxHqOq
   w8UAQ/VaJC+KyhNebiWUbwtfTWcC1bVpVbAuxSQQTZKbIx17yf4Yw9+NI
   XBFof436Ki2uDR/hICcSthxi5/e5K8YIzMb1M6HQZ5hm2t3EuGAl7S/Nq
   kl4drysIXovJkpPGivOq4cFrC7uTaKNy7otGzy/L0sNS4DG9IPTJJfGpv
   gqPhRkBQEP4cglTXaaGrj8s5djgnfbVBefR9SVrgIAbMNQMKd+etWb1jY
   g==;
IronPort-SDR: JewXucGFTXSP/vHd08v3WpAXetJg4hng86zb3BoeJ/+Um/czRyFC/c207txzE2fPQAHIPbS9ls
 xP5+uxcchHXeUCUqaMTgWRh/qC2LnqIeym5De2gU5RErw4OMBal5xzyWtmVdW8mZjc/eO9l+pL
 gApevTvHY2Fd2Ub38NWvPGSnG4or5tlyWiv/u/Wy2GA42Y1mlWn5zthE8x2GZAnEOa0bH1FRQz
 K3ohPP2A2KooohzB36A9F8vdNIJnvjt+2zA+14ednNKNfmTJtKI5p+ZcQIUk19TVFPm8MIkXL4
 t2k=
X-IronPort-AV: E=Sophos;i="5.76,383,1592841600"; 
   d="scan'208";a="146345515"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2020 23:03:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfVyH2UmyujZf2TSZMCugjEMQ2ydvNQJsn/0y//51n8/o3n94WgT6wbWElzA0r7E1WifTv9eiheOahH9f22FbQN0/ctZC9CzIDQsU+JQJnyLthaxoSXpBrqh4gvkHYnG0uGTweNg5x89YefNJnPPMRLZIBERLL9y9QnQ/UjG9JwS9bP2YSyQD1eTchWK6LcnKTFuybbSyoKsSr3J2LK7vGDg7dduf1MyElbbFJ2w0RQxxJDgw0YNeX0SsUPPIQTlhDdczaWCrbdwdOzZ70koZsp/KFgJXA+x30jIRaU9ezkAW4kZh8PY7MlMk9yKkP6ehaQJLeJtotUSct/L5zbSlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8i15wle1U4g9zkPMNWCzeLegDLgwEpE+FRiKCRShuK0=;
 b=EMPMJEl4SLVxLLPp80wFIIVUpyFk3CZF806Jo8z3/z8mQgl/1IdWiGebJb5NuHIb4yrTGjwV/HY8qEA4bvT6yY+6t8YFM/Wx6Ftnk1YhGMg+iw7NjfwKtHmGHyrv6KgqTDJEaYYPdRKpMi70K7lgkD8Okdd4jA1Yp8XPzA4Pjg9rKvRuToUMpYpIybMykbwEhEAkdrCBfzTAyOulei6yBTlA+JvJoRlQDpOT1b1g3aJ+hpZIqgJjlqf8U16YL65+fxZoIrYS5B2aFX6n0Et0EHDcc54GSISLaXxrqPMrpzcpm/0gmf3nvSBcdWlANu5REHFGJCRKd8oLE7m0kksBzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8i15wle1U4g9zkPMNWCzeLegDLgwEpE+FRiKCRShuK0=;
 b=hdIO2sEFsdZcTjsbQajnZTfzDj3GknWv7dB5MrG89qmiL5QvALnFWaeUSVTCHL0J7kDXNp+l0NmwLL/Yg5PpmeC+VmH++NCC5grmQM5jYDqYpRGXAr71ImUp/aT8vXRD+tAHa/mbAumLtbCpzka8UeyyQeFFNpQGIMfxq8y14Xo=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB3965.namprd04.prod.outlook.com
 (2603:10b6:805:44::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.24; Wed, 2 Sep
 2020 15:03:43 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3326.023; Wed, 2 Sep 2020
 15:03:43 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH] fstests: add generic/609 to test O_DIRECT|O_DSYNC
Thread-Topic: [PATCH] fstests: add generic/609 to test O_DIRECT|O_DSYNC
Thread-Index: AQHWgTneDcWxsIEHCkGWset2dorjTw==
Date:   Wed, 2 Sep 2020 15:03:43 +0000
Message-ID: <SN4PR0401MB35983E735C2BDCCE839570ED9B2F0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <f5ba8625d6277035b69e466f6ea87f19620f7fcb.1599058822.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1590:f101:1584:4722:fd5f:b30e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d4e9e615-5ab3-4557-d6a5-08d84f5162a3
x-ms-traffictypediagnostic: SN6PR04MB3965:
x-microsoft-antispam-prvs: <SN6PR04MB39655C9B59B4E05A5C62BB529B2F0@SN6PR04MB3965.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fj6q/0anFNYB27zJwag6Ld6W4AMQL9HJyLZf8x4T4sKN6cFOAC3r26D5hwrZAAV7KwrTfIOghML6dhcI6kPJcM731wFhd3Y4gh27QT5CRJk41K9wMtmzfzddlMHBOOI3W6BVP5/f1CmAerSHmLa5Ma1lj+tm8sUG0+EQ6vZbUHEFOM2DhqyJUh8P9ioNyzCBuaYYe7qF8E40luquRpqC484ekd7cAcxeJL58EHNMkVC6zkU+WJk43HHX7vfx/vCvXx0nNFBcDL2yWXs4/UmUjfKB6RRSYHfl26SvBkdB1XyVVyctzX7S4udv/jNe/p9pBIk6ra8ju25rLbXUU/GhY7ynnph++kGU4OV6jImlZ6KSICmrLF+bNs0+JgtL0NwB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(39850400004)(396003)(376002)(52536014)(110136005)(316002)(478600001)(55016002)(8936002)(83380400001)(9686003)(71200400001)(5660300002)(8676002)(186003)(64756008)(66446008)(558084003)(66476007)(66946007)(86362001)(66556008)(6506007)(33656002)(76116006)(2906002)(53546011)(7696005)(91956017)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: QnO17YSPg2RYYdLDaKMFJjhcbGxkiaIu33qolBIebPAwwcZK9OSfkANZGRd5ik3h+JjekXicR4Npz+TnP6Rk00k3v6VZkJL97YtrEtfsUpZBzTW7MNhpoZQM+uQm2Ius5kehOh2AN5tEM1Gc7f/1IAIa1PZ2H3/kpcT3CR/AyOVKavvTAZNkxnkPVOO1Piyn4JcsGuusHxECwdpMUmLLtirsMKYXgMkAb9RisCsoCymJ3jqsRPiqzpHw3iRCHfGrR6JMkiZci9j1aLX0azzFKcmAA4vr4UVNshpv3tgcpuTUgQMmLats8RyKx6Hkok2hjH7Rlsxu4vxmqGCCfW4t7TdNlO0ONKBIUhhcE99ABICh8iukP1L3/RXP6IDfF1ct6yjLx96LMlSQsLOZrEtK/LMVnBQR9NcGfSmCC2au6w/yeHAcNhdGvaHc/eAKmkQ2yUOaSZJHD83lvAW1ktJH913M6bf2PpOZG/LhCPqI62zHRzDKk9gp4T7JUUpM6rUmk1bhG7G1vtuNFjhmpcpovSuxZ4QASGUSlOrGN/XzknowgUmm9fz6p+2lCy8SC2CWEO8YSslR1l6aw6eUAnhpBEzv0l/osMI0wU5QBRzpBadpRIleSZ6jBaHN6KZwPtKxdC6yYq3ODJHwDQ78D/NKNum3sndnqExgYZhELQbbkzOH7OrCodwPJjIofrNso7EL1J/B5ZeHeXLL6WUiloV6dQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e9e615-5ab3-4557-d6a5-08d84f5162a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 15:03:43.6716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K301U/fwa056+FxENt05bpQ1uSNA2f9fml5wCnIIA8sS9TM2mBMAwq0yrShpFwZp+i7W2vz4PfxxnGfHX5aH2NGLedBdwUu8W8IwHw5MTl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3965
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 02/09/2020 17:00, Josef Bacik wrote:=0A=
> +# they're locking isn't compatible.=0A=
=0A=
Nit: their isn't it?=0A=
=0A=
Otherwise looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
