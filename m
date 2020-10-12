Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68BF128B319
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Oct 2020 12:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387810AbgJLKzg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Oct 2020 06:55:36 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:33613 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387791AbgJLKze (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Oct 2020 06:55:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1602500133; x=1634036133;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=dDDGQYe+o/+n/c4ov4wIahCktUu2C4ODIOFUcPuQxuA=;
  b=YNzSG6P30F2kEMFG2hifOTaAIw+N55mRVtyvJAMBnLpY3J6o+z+gWKmk
   TpAvc9NJpqibaPADUgCwMpTrHxfbLwunCwQNj/aQAyKWQNW437JpUxkbW
   4yBMHMgQTyfTTBxveDALHz0luobo0mQt2uGdtsN4xN00/JbulCxkET1Qr
   sfOJbnwb+ooyc3D4eN2n8aPSY2n9Dmfun5MsX+4L8aOVrBRSGsU5+TzWB
   rhashGcQ9ArXjycBBK/8ouOCReHyg9W87D1QgKIwafCc45EDRhVyFT6US
   jF3ilUU4+oS4RpiyCgvd6CoHU2C6+9pKHxirWdXkeg/5nKOrh+HVdRpzd
   Q==;
IronPort-SDR: tnRrl4Lv4q2q0VpoXfnAD8hg+oMjLUMzlXQnak0ENqv75Vy0Me2JtV3MVKGqSBUUuLi0ZvgiBP
 AoY74sDmCmPNASMTUfAeis7r/J7YXQJ4OLHyvPvBMdtLpcxZzz7SYjo8i05XSJOX/KvOElLla6
 SyFx7ks6QAQO46FxicZ1ZJAd8GWTKnxsx4KdOLQU+8XWzzqKH6xP9iBoHi/5mwWqts3o5IrSFl
 KeBC6i8PkfeKfz62q3Y29nO5AfvRWWGcTg7EfSNhcnxojnIRQ4+o1jW5zGagVW0Uhknw08AEJV
 pxo=
X-IronPort-AV: E=Sophos;i="5.77,366,1596470400"; 
   d="scan'208";a="149536586"
Received: from mail-co1nam04lp2058.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.58])
  by ob1.hgst.iphmx.com with ESMTP; 12 Oct 2020 18:55:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FKY3kF7OhxS1V1/DLOI6tvqamnQK0WS9DKBWuMRHGWZfw6m3dp6IGmZf6CeutpDxTM/WRjESMCWOEzsxffQiF9d7Dp/5FaeGQIjyDKMle6BA7Q4nK1+k7Wo3DjIAhimX7FwNoySyYN5juDwBGBCxRx2Fd3g4ZCMiHkKDcU2FMVB7AXr2wDjeyBl4kiKoSEVZ/V/yrOu2j6bBXu4mlsTD0/UwcWoyd1ywJVdbtRI/ySLeIwPGakZMi3LWODGXXXe5FXy0Jo5chbl15UZEmOWIt+T71iwFsJdnMV5ZJNcYR6ZQa7CqBbODRvCHsqNAY/W1AiT5xohV59ur5hlV3zzD3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDDGQYe+o/+n/c4ov4wIahCktUu2C4ODIOFUcPuQxuA=;
 b=NIMZF3RNCijJQcsjli9iktp7CZcmpdZ/EPoQDeYjuxFD1DmkWvE8x3WO+oQP+UcCOxEqtjrYeFfNu3QAUqxHyvaJjYgj+ufWRwkgNnaYBJTi0lPUQ1+BNGXGrGRANAXxR1dIZKvm4rBZQ/KppVsJrUqdaXgSaXhZje0tVKfvB/MKWEv0p3j/y97mLw755qjgGjIKC2Hm9OPVhFWO1E1M5QJ8RHK9QRKNJn6j84MfY4TxINqFgFmxvrGk25YCQo8hJDONkppM0V5ZIwselfIY/DMgIxGL+1l1/E6QY4MOt6z/st1U9Clo0c37LYnls3fvZYunCtBUpEPj+TZ850e+bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDDGQYe+o/+n/c4ov4wIahCktUu2C4ODIOFUcPuQxuA=;
 b=K1T513FruUhfr0/dmc5CQNXof4Xi/+uUQ0W3POW27kc7wk5p72gFxYNcbXF3sMwrQEZwxD5AYW61qzVJwTC5rtQqQYsa/4ptPaDwt0ccVB110NtJj/6yixGRxWxhzDnDOTLzsbPRT3KF+89A9tNH/QJDj39TAx7rFU6+CKK0u9k=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5168.namprd04.prod.outlook.com
 (2603:10b6:805:9f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Mon, 12 Oct
 2020 10:55:32 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3455.029; Mon, 12 Oct 2020
 10:55:32 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
CC:     Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH v3 2/8] btrfs: push the NODATASUM check into
 btrfs_lookup_bio_sums
Thread-Topic: [PATCH v3 2/8] btrfs: push the NODATASUM check into
 btrfs_lookup_bio_sums
Thread-Index: AQHWnngx5ydvMbe5h0m24ThODOpSpA==
Date:   Mon, 12 Oct 2020 10:55:32 +0000
Message-ID: <SN4PR0401MB35985FBD168912540793AE7A9B070@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1602273837.git.josef@toxicpanda.com>
 <668ac60b9f619639eaedca3b3fe026f546751517.1602273837.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a921f37d-b687-4187-9ace-08d86e9d5705
x-ms-traffictypediagnostic: SN6PR04MB5168:
x-microsoft-antispam-prvs: <SN6PR04MB5168EB17806E7DE132909AEC9B070@SN6PR04MB5168.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7xYg785LchvwYsFjxowz1jHhWPIeSCJOLHynkfkUpGDmqrYuscMNRp7XE8L9T3eZOft+9FXnhw+86T6QwORmnKUro44bYNVBb56TOZdGvIGGDS9bGhTZTxzMlTVpJuyHfVvfi/OYecesOWLaZgbr2C2iqf4Y2NigyOGig0wrk04LkzQ1d5gEyTBHtjDtP9UC+KohYegWbdI2bRj9ZN46F6+Eifh9AX1vDOopznEU7CkgsANgOIA/j5qKWY0EQL/Dj6DfinCtnEWcSNEYM5tYdhvPD1Iu7ZuQatOwTgF3Rqyu1AtO1n7NwghBOCv2k/+euyzqEkTb12U+eeMvtxKIiA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(26005)(2906002)(33656002)(86362001)(4326008)(8936002)(66946007)(52536014)(5660300002)(6506007)(8676002)(186003)(66476007)(478600001)(558084003)(64756008)(66446008)(66556008)(55016002)(316002)(76116006)(4270600006)(71200400001)(110136005)(91956017)(9686003)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 0xVFiRkJecPP1Fh9jhlGphk6fauCWvUyY8Tc72hsBNm23JftYY1ih9FH4blAvgHEAX51HLNEHYO815WCZaXEuedVm7F2jzQtRaUG4tB7GsyFOTMStUFAF9B8rlJCL7Ljf/4xSgrdGfS4WZnGEEW8CIOQt0Ncrts26SqZ0nqmarh2RvTp09ZgqaZS69faHZNnej1Mvz+CBshkzKrNgNDtsHRlu7I/D8gdc1ZdtQcU8ytAxaWqiRi49lLcUHwdYAqYGtkdeMfDwuu+JmDw/R6Ic1mIaBjgzxEmA/r8dpY5a5qLJESkG3g4wJPP5J0JI41R+jdz7h3ob0goQJJDEaEe4Afwgrt528bI1ncBuOuWCb1sKb41cg3aYF/T86gJ9g/hd6LrVVSOY/CAjx77lNZtNeP2k9fZjHbdwE/WiAwVUvtmYJdxOq62EzWyQpJoPs0uRF5V5oF/qnSQAX7nmDISo6159K7Vcxdheh/4oxGeqJ7oRx7e/VIm59MTFUhbSTCI/kn+n/RTKR5k8hWv23Rjuh2middf3dK5+/uTDN4KtbshBj2vKi3F+yU6JFthzQfuAEUaVQQ90oWLNpQfVTTIcyck2Jhg/MElNyslJCUzYCOlze30LzfcDBXL5sjN9lFYqQYlThfPuH23Na4bMu/AJQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a921f37d-b687-4187-9ace-08d86e9d5705
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2020 10:55:32.0761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: weoWr6tZ/jm+djAijrJj1WaR83bXwbsRfKRAenF+0NaBlaWEP1t6A3yGdPI3y0lGjSGnTZE+2Ifax108dRdBXoU7hh3ytqyD5kMcFeIMEbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5168
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good to me=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
