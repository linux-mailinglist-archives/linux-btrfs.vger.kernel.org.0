Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95DB0168DB2
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Feb 2020 09:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgBVIul (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 22 Feb 2020 03:50:41 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:19400 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgBVIul (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 22 Feb 2020 03:50:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582361457; x=1613897457;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=cJlhfD8Qge5/8fjXXD4Bm2IXJTNrzZ8jofHOs2Q+CcKayfftyjJGSgTs
   rdqfvcrsYwl9Uqvl9GSdZvNL2Eoldd0uN3SxcJa4TZp1cV6B7hBh1iJVM
   jlCw1ULSQkbHlfELZhPYIxXW/bp/GaRpk82TZwmltrZw23Uj9J3mrMvFU
   ItfImPIAy1cpmmp67qiqtDhAUYtJFIvmgB4tiBH6JhQrZUGpPHs3xz9lj
   sNLrajSesEb4PVhMkygmMCUOjcnHA3jHJR92xyqiAveLBHIsbWvY+ctaY
   27nse0SKt5lJeL6p3c48ykmP7pzaU/8pgpUO0zytS79ajA1ZfBG0W5J2b
   A==;
IronPort-SDR: zppQl2KRv/9lt2BI+Ph1NitLanS2dc02Z+rZ/5awxViGobdbeM9h9UAEV1gRI+slY9NjPqfHLt
 74ApyNssQu7/VBjjJA6B/lzzdF5+2gJTFooM31swUWEcJSk+Pc4OlIOz0U/G94cLcSfd7m6z7U
 qWBp1pa6S+DRshgeOvz1CAz9w5AaXlSAfxBAmmbewfnEh+GaoIZYF2txXzsSzn4lp0WQIB/4zL
 NpZA+zVSdcHB7/Qoo7tEQEVhSrbkOD1meYicIQ8bBX/qn65+HzcXOs7dg5jJJuDsnmcHrbFsnn
 1zU=
X-IronPort-AV: E=Sophos;i="5.70,471,1574092800"; 
   d="scan'208";a="232334673"
Received: from mail-bn8nam12lp2177.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.177])
  by ob1.hgst.iphmx.com with ESMTP; 22 Feb 2020 16:50:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VyDEE34XFak0F3kVeHp4x+VHv7oijfe7jZNKcZI6oB1BIQjaBHtYDJXQ2FVrs/3W/KH2lfBn6uhLhkB91avGIVZ42S1xSdj9OukmTNKeY3A5+FGjmK5ZXD86LqDfXIlo1WMYkYWPucD7hfU4+wx2AZ8BZf4Rhtya4W7sS+f6v+jQhwQ6EhmP7ch9uBpoFIHIWYRaTN+5ZMWQqkZhmegA8gQ+UlshMUHV5nr1oGUqsk5hG8jMCjK+SGlIQ8gqtOg3gpJDcEXGCgamFhKZMQkHF4b12BRhzQJo4V2Nwdy8XSajPEc2p8dQTDrDYROsqV1tkjTM3lhDfohJtHQfqczPfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=BFUPYsamFApj24j9SIOgd8W3Mkg2jr0Go73w/P9HrRGksozljoj/7NgDBzSLQjNuxMePQ+ikMIfVIRYmKrDVMkDvmh9+Sp+hKgBZL0zXk8D8fMuWHlUDBt5IdWtTf9AgKsfsyRl8NIkTAF26LQU1mzJJMUuSrj6+7eJ9SU9F+OR14BoCuedp3v/SxEQLnW8p8bA3fwsW9R+iI9Lb1HW1wFpsZFtBhHtQXiBlmIKg1c0nLQj61hy44lY5XlnymxmYzMg34ceJ6s4UJavxWOHFr0sBIHv30wll1HsyekvgQRMV16A0YTMZrIqNWJGrIJ1+KygR9yxK+sfNY0f8vkptaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Yp+2nSEvopyhvlhcbgKuiTIUOK/cfUBbw01epA5ya+Rl+6Wrz54EraYwb4I0gf3aeHRAwErK0KtqXCR1+2rXqD9Vicv10dWdQ2wiynHXAjwJ4NCIRylrFHW6Z8EwwlNKqNx6SpDR/BKZtd1P8H/q/ogMlCzBSL/k2rZc/yBaEfg=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3568.namprd04.prod.outlook.com
 (2603:10b6:803:46::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.23; Sat, 22 Feb
 2020 08:50:38 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2750.021; Sat, 22 Feb 2020
 08:50:38 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 10/11] btrfs: merge unlocking to common exit block in
 btrfs_commit_transaction
Thread-Topic: [PATCH 10/11] btrfs: merge unlocking to common exit block in
 btrfs_commit_transaction
Thread-Index: AQHV6NRqFhTRcB2jLkK+4mtTVr9sGg==
Date:   Sat, 22 Feb 2020 08:50:38 +0000
Message-ID: <SN4PR0401MB3598341FF4EA69CCC332CA809BEE0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1582302545.git.dsterba@suse.com>
 <133258557ae4387d6a1d01bafa3e5214ca91228d.1582302545.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [46.244.212.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f430790a-618b-42c4-39ac-08d7b7744a3b
x-ms-traffictypediagnostic: SN4PR0401MB3568:
x-microsoft-antispam-prvs: <SN4PR0401MB3568419F25EEDC0A4684A8539BEE0@SN4PR0401MB3568.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 03218BFD9F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(189003)(199004)(558084003)(71200400001)(9686003)(91956017)(76116006)(66946007)(7696005)(6506007)(4270600006)(19618925003)(186003)(26005)(110136005)(316002)(2906002)(55016002)(66556008)(64756008)(66476007)(81166006)(81156014)(86362001)(8676002)(66446008)(5660300002)(8936002)(33656002)(52536014)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3568;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2pPCI2HOv/862fsv/k7cAytPxalixnjvJyK1jpe7Q95nLSvLz/iLPajeo1QqeuVpRolWPy7+t5m8g/pr/ZV7Aj1Br8/+OeLjfKx31+aBVPcw0K/kEa2PACe/X2AA/NYNPt0z4WJNg2LrPlsWQ2Prt8USZZbK3LcJATojVxPGk2PXXCSGaI4CKOC1CSmMqxJAaAoZtTvyND587aLYSdRp++CMe4p0M1xGNKgd9sb4dVzXcvyeSI4zZnzgnph/yqidiRGqhQE802Y96rxDyoEpE+I2ItdIV53lErKnSS2MhJ2oCKHP+T/JHzSfaWc49Cr6269Uas/PeeNRzJD/o8fpENte+lGHCyqOX3EOI2tTPB1pJah5OYDvhup5qMuSK160V7B37fOXrIRaietbR5MeRXEIhybT/hDy3EM5LSPHcjjBnIsRPuk2VnpsQcOtRs4D
x-ms-exchange-antispam-messagedata: OkqIabbsJkLw4dUm5UxiTPGFm6jLaSabeNOxwgx90031ut8Hicl4ErGECCOtTMp/Wvmj8BcXqMEAAZWryMpBsJJRA3E89jFMYrM68SVeXYSy9NUh3HGse7cEGyt5BwmcYxVXhQK08RaD+dm0Voiv4g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f430790a-618b-42c4-39ac-08d7b7744a3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2020 08:50:38.4869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NmjGpJ5Vy+RtVt26jRIDw7E9DtEVFqmn++d91yT78C76MwNXI2Vbj/JnzJPWE09TCxWP2lZfVr7TBCdG1GqxjmIqZyJqoAcs7ItyYojEGN8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3568
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
