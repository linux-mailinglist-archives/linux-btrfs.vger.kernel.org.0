Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86216151E89
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 17:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbgBDQwg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 11:52:36 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:16675 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727321AbgBDQwg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Feb 2020 11:52:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580835156; x=1612371156;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=m5pYf4K1km9BtV1S1tQ3mk6OGTLSPYkNSUDG6fiVkNX9awS9ZxblLlGN
   xnZUHU2aCtbe5y6MuTdKd9lJKYJlvs6ejDwd90W+Q5baOvXYmxxiKP1NF
   mJyYHM/euR280emhwKj9N02WQB8kF0Rkxip1Yb5uc9OXNvci4Ul+8U5L9
   YzKCDRLNsY99Mw3D/6MQ4jvknzTmCcSegOYd6FdiskStaatHK3ac4cQsb
   uJSNxYGKOnrG1fEaJW+4EaruivValDXSW9OOG+9E7SSWRndTZN16hjY0l
   QsLVJ51IXtvKgjRgEhewoqkoji98ENTKyf+KMrb8+VF4eq3rgLrGU27Kd
   g==;
IronPort-SDR: G9QqHOA9HJq5dfYvl2THZTYv/1eDr6rDI14udclMiWL8uTPaRI30ecDtwtodIiwCh4EWSs3r/D
 gIvPgBo5qqU72Uq/vCwE/NB7Y0wzDgMVQxyr7h2Bnh02nP2CF2qyrKq1OGgAB17jXw6NThBt1H
 AP6gigNdwmQ56RbcwnStA1Xa/VCb+WQoZaKm/2yoSoMPAUwS/AH2sbETpNN+qDMEZuSJLhThHO
 8YiwjO5dPtRAoXJ72pdHzetppmOlRUAUBV9avb5SXpNStK66v7V+8u5YlOhob9Jdn2Nr/wuo0f
 GfY=
X-IronPort-AV: E=Sophos;i="5.70,402,1574092800"; 
   d="scan'208";a="130539855"
Received: from mail-bn7nam10lp2106.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.106])
  by ob1.hgst.iphmx.com with ESMTP; 05 Feb 2020 00:52:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NvMseUJpQHLx59xbVLpp0fewv1jG04tjSP+oSMBedEcX6R269L9ygCBdTcYtuB8fMBhCcNtiwDfWvIFvlUiPm5QZp2qPsXhLLhM5NLXAwOcevwfurQsyvZW4XicgXl2fKt43/nj7PqQWlr/xL4EtdNmDDnUlfb5IBIIyLGQuVchuG5Yy1Fq66LqWb79yBQ9YreWErKJRWcF51OVHgqL8oXUAqaOMmsGmI2hB64bXblaRAdeW/jWkwb/hhBGMjuE1oAHyD8DsagwcQt5NgCdygWdw1SmN0sSnVSiIEzft+IQyqzIKB+kjd248gCXmOcx+uvCBjOQNjErL1CEwKpARIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=VcnEAjzeDaCj/Mzr1qUPv0zgYsmkvzqU9VGWMXYDlHGdj7z1HsW3miGY29lCsOKf3TeP3f4RcSNWlw5Fn9nCwK72PBwaPL5++WZRnkrQorLsOWPmSKWI+XSyVWjAcgcpSNzNWBc25hVt0mfR3dvL3UxeAU+jVfAK6NCIZUn1FH4GKwLmOMjDVwsAHjOcXcucrfSbiC4MgyZ1l48f8M/8+NnpdJlbkw7orjZtVYDgSUlm7c5EL1A8E+MHsAuqy+7UJM83lffdlAPYOobyBpoieWBPvp0zWl8lxtnwwX6tKePVmeKvNYmxNoDCVVSxtx/iOoZNTOW9mUoUAcmOYBQ5hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=fQFnKmOyMzP57OmcWR4mUY94CUe8SFlUsMJzON/GKq1uDe6renP46rL6Uscle8iqFuuaYneoTWMhsxTwNSfEABfaZtwTR4XlGfP3PPqnkbnSBOzkXgz14coKtWEew9cBvxRw2Svt1DzpLecrKhkML/0LX6hniWuVgu19t4ywd3c=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3645.namprd04.prod.outlook.com (10.167.129.157) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Tue, 4 Feb 2020 16:52:33 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2686.031; Tue, 4 Feb 2020
 16:52:31 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
CC:     Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH 11/23] btrfs: check tickets after waiting on ordered
 extents
Thread-Topic: [PATCH 11/23] btrfs: check tickets after waiting on ordered
 extents
Thread-Index: AQHV23b+ac6Clztk7E6G+6UfFrgfwg==
Date:   Tue, 4 Feb 2020 16:52:31 +0000
Message-ID: <SN4PR0401MB35985768384D0AA8714169039B030@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200204161951.764935-1-josef@toxicpanda.com>
 <20200204161951.764935-12-josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7f03d71a-e82f-4c6a-bb2f-08d7a992a030
x-ms-traffictypediagnostic: SN4PR0401MB3645:
x-microsoft-antispam-prvs: <SN4PR0401MB36457EEC1EFD3D585C6C81679B030@SN4PR0401MB3645.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 03030B9493
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(396003)(136003)(346002)(366004)(199004)(189003)(52536014)(4326008)(66946007)(9686003)(55016002)(64756008)(66556008)(76116006)(66476007)(91956017)(86362001)(8936002)(66446008)(2906002)(110136005)(7696005)(316002)(33656002)(186003)(5660300002)(81156014)(8676002)(26005)(81166006)(71200400001)(478600001)(558084003)(4270600006)(6506007)(19618925003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3645;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /bHm72s9An8vrJfonWqRa93NyaUTSE1/1xoBmNb1NnhZ7yqDuBzxIPdqnl/73IM5LlQh6LHSqW3ctavJir2vh7ESuqQWEn4Pv0GGrFhAHbJBT2SEfHSdPzeYB7aFdKAK86uEmz1/QrCCh75e5bgYHG143yLYT3f9k2dFSmhRfQKsJ6APuqKGzRbQGKY0whCtcu37LvyHRnSRNuSL9lgVl/i7oDn9yKGbhmxyM9dTz4PD7X2qfeANCzcC0hGWNFU2Yx9sCQlxu2tFAosX/jcF29q1jQ5edynC8etVHa+4FKp37JTiFNzbLfF75F/ILe76ig4BbgjWJYoYSfkDLysZWQO3yvbRZ4mN9DLwezrUs+VBiyRgP/VfVZaEBDsjUVbD3D4I5OsNT9vXCc79/PiQ/USwPkc9fhruY4AYZaVD80fo2weMFi3woehOjbrxeNil
x-ms-exchange-antispam-messagedata: RhyR4+1ZnEqCiHcmDqTSGHfUYwMDyKvAhdG/F/mlGkwW/b6i9E30XLG6CX8K36RErM++LnVrD/hNutRxqL+o3ZZm6DaUHXPFyfFxYfjYI8Wk/tzkabHVi/SrbFMP3gElojk4H6GbQGbEew1Y2kiDGw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f03d71a-e82f-4c6a-bb2f-08d7a992a030
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2020 16:52:31.2982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Opvkrz88UmGsXhw56T5UcP4f7zmLzwoWqEwEyLRTLDJLuatn3WQ1vlWkSmTgNWNqd5Y0cQ3rKJsK24n1Bp2GlqwkSbQafY0or7UGFobaAfc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3645
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
