Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9742125DA
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 16:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbgGBOO3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 10:14:29 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:30831 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729535AbgGBOO3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jul 2020 10:14:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593699269; x=1625235269;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=OJKkwkcHoh+7f5u96ylPxGGBE+35TusVvIEoQqeKWmezfQDDFmIP6orQ
   oHWrb0p6TLaR+VoBBmZOEth3fPOLI8VmVj38BZDrBERp2Ft3BdlDyRO/9
   NMU4IK1dt3p85GK3LpA7s4m7INDisjZQHJHbC9o7Jacbv697RuMiP+0np
   LVRs1qqtFmkNxSRbxVlWAjvCQ3Xm2HsO2vHBEo5g0PUCYH/MLMsJL3gIA
   8cvi7R+6oeEZZoSb9UhWgGQsJgqZqoK8j1Ojf+TlXoSRZCojzBJlLYiVU
   honu58XjFnlS4Xvxb4HoCbLjXanPOmZ0KHpJt3J1bq02N8fs+rE7Ruv7/
   Q==;
IronPort-SDR: VKqydOngGzPoXgxfiIsntPh5FJ9EqNBtpozZIvRS+tKmmpQk4sx1td402iUWEBq3LVJT+YunWx
 gngsjVONSGTNS+JKhVf02mBy4UrBLIMQXNSIfgOiB6hJC/D9gKNDdRuxiHM3e3PQBgiVHzpWCT
 W4FeGgMUOUud5bQfFkUM8N3EDQxFcLgDtYGlb8dqPC2ulko3YJUde97ac59PJ2QWiMsFQAwFTe
 BzUhDat1drZ5pZUBL3xylMFDEs1+nO0PdF1Dx/Q2tWpVUnMjuEBwdr1U4aaeUsotPRGY8YAfPG
 rHg=
X-IronPort-AV: E=Sophos;i="5.75,304,1589212800"; 
   d="scan'208";a="141683865"
Received: from mail-bn3nam04lp2055.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.55])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2020 22:14:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KtlwI22J5oADUiOKMhtnzMJBVWihBEkjm1YQkqND51ay9tnMYkGgfAP98oXyNrYkpZITVhTDtlNlBEIzeUhKHWIHBUkBdZPOx55FZQDG9e1V+bma2j/EfmjrG0SgZ8/QqEVV8WF9nO1zYfjy3qQX9JoB9MVzBHtfanQkn1pIqvFfsSxtskTm8Xc1y5++TxjaCAHtsL0VeC+NyGLpj6q33VRB6xRxIQTfTqVJteCkT2A+Zvb7AJ9aq3qWh9h8TlVn/2zpetREZ5gUUt1Q2ImwijvFoWbCaa3hG8ANc1W+8mKw5+zy1FMOpcQoO8K9ZNlbAmn/mOBf6n93/I8xzMurmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Nggg1hoPbNSTyq5Z3xiHkZEESzotphf535aCtadsR0tE0Gklk0eLelTSB4Tf4bNnEeD/KxkgjmAn1j7ZxyUGsXhnUZSUkCFqUizxkGULwaRDuodOUe/rYAaxYwJ8wOa5vSfm4/Zork01fF16A91zqV/ubhXaSQugYmF41/e8obj9+bMOmr2BZ2dd5ulLFHlOw+YkK2FUTz3jLFKwOwnzitLhzF37vL1MYVYbwQmaPT7/9yG1d+4TV4khFGK2ayYVT3DsiVqHRFTZV7poGYGSnq8tFtsPdK16cbWucIY0XVdsiUIfu2itONsp8YPLGkRMy9y5LKKiTF8x3esiFIaX4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=OIiNmG0HnmVDrLm7V/urFA1YlfPgElN3LH0n9UAN8saju0xu2bAFrNbU9eJdLhMYB/VyysAL/bdufAntH1iJT/B8o/kcx84i3x08NSX1QSMSsHvmzB32H23/pwOgFulPTkCb6YmTpOkSfOhOnl6Q2NfNntpxzkLxm+HyND/z/AY=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN2PR04MB2317.namprd04.prod.outlook.com
 (2603:10b6:804:6::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Thu, 2 Jul
 2020 14:14:26 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3131.036; Thu, 2 Jul 2020
 14:14:26 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 03/10] btrfs: raid56: Assign bio in while()
Thread-Topic: [PATCH 03/10] btrfs: raid56: Assign bio in while()
Thread-Index: AQHWUHdG1ZortxD7rEO1mV+mjOFWZQ==
Date:   Thu, 2 Jul 2020 14:14:26 +0000
Message-ID: <SN4PR0401MB3598BDD54AEB05C987C678519B6D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200702134650.16550-1-nborisov@suse.com>
 <20200702134650.16550-4-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c361a478-73e0-4333-4e43-08d81e923a71
x-ms-traffictypediagnostic: SN2PR04MB2317:
x-microsoft-antispam-prvs: <SN2PR04MB23170926D7613E94917CFFBD9B6D0@SN2PR04MB2317.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0452022BE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3TyQuyNyCXCUbyAzGXKdjOHNYmIHLQtkdMmtVdEgTfgMzUoJlHDIxmk66yo1/nJOopI0u2kHcRlLXUT5W467CE3hNAScmzRTshL1k3md2vUczDvKD2eyKhFdHBECjg31lNx+IQwJchdg/9Te2Oxz0wnPJjx/DHLp1MzRg24HDc4N1E2so4IMaJ8exHt2bf1w7zZ7byK9sTB/E/Nz/HrH3f8q6rMvuW94J6LdfLhhAG9s+9K2Fuec/MyKGZU9IQTl4Kt5NmCAB0N+QiOiOwBmnc4g44FQtF7TG5qgvGGoBVYZuu3F13EC93nhXPNFHNAP2hEEqH45XlwHasNbteq2cg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(366004)(376002)(396003)(136003)(26005)(316002)(71200400001)(4270600006)(5660300002)(8676002)(52536014)(86362001)(9686003)(55016002)(110136005)(478600001)(66946007)(66476007)(66556008)(64756008)(66446008)(186003)(6506007)(8936002)(33656002)(19618925003)(2906002)(558084003)(7696005)(76116006)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: AarH2RL3QV+5kcDOvoOBSZnC7+9djXr4CaIucxkIKyWPk3Lv+JAXrB4MjutC9U3QetuRert8LGBZiKSTYDX+lcgiJPMyjJj4iOytWj87jZc2I5Dx6hl112I+qMf9uWI7DUzXR6TO1e0++0JYAezHEaReZ7XYriqIJvxuYpDDtzXXs6dOvI4b85XegJNDdeAQD1Igb4dULAHpowt1NzdqPMrMLKoDOn9/daIYCdGnTGnP4O7l3Qa17m8y6zqlBDTzjWS/QZV7sxAfNMepjpmiJ5jfoFsJGWOFeecUthQpyurWyDq6VtKUbBfyzGQZxvGpzLfTl+IOK5GHPRI6mX3dg/yIvfnTIAaU5jZzGdo/Y23d4kTDUZ1Z0dvBS2YOJU+ePcoM9x5bU0BbA7WVT1eGN26tr5NMKFfjR76DOGtUJ8+cyPUxasSS7xt5CS+i4vM1m4A97dfB1uWtgNs2TPgfYoiunL4YK1+8NKoqCIEleg+0iOue1AXCAZ/nQ2LTKzil
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c361a478-73e0-4333-4e43-08d81e923a71
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2020 14:14:26.5768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FQbdtROG+NEAaWgE+bU29ZfLe0bD94f1pBFHiLIYZFNvedVk8V90lC10Zz9oWcDTjSMOwZZhzPDU2pCqFp5nSD7hDdETq9is3MylPTj5x8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2317
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
