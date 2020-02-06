Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C48B9154519
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2020 14:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgBFNkE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 08:40:04 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:40874 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727900AbgBFNkD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Feb 2020 08:40:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580996403; x=1612532403;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=G/9bEUGUmtBmifihZqw04o8QP49mlcSNW/5Ds18EFCFl5M/k2apIC0VS
   fhTtFDCeAKv7mRb0TE7hWWsn1n6t5lPM0YdIC+8qNZtxmIBYLAUGdQY0x
   JFElwY+TOLTyeZcmasW1CdfzWdBrzo3E01/KlodtJrzbcd6FnodUVqsPc
   ch3Vr6ZlulHNXejSfIGpUDC2mRCpc8SXXabdloc+oUxU8xn79gk6OLL95
   Hs9+zwjyP7Brg7dgHw0+4aqSV8klk945QJIIua8Zf6/CuqENbTXdx/p9Y
   J14oPBEwNiDU6N6jyUbDeixyiW9uJkpZq9yel9T2RCN/5mYyz1bqj84Uy
   A==;
IronPort-SDR: 7JJE13D9v11lRzJW3nQR1CP9vh2wixWIL+aDJKppkVtiUTCzch1V7tx+WCDFWufie4zEhrXIL4
 1jngY9AryWKL0LEo+5Cgy4BbXxHhk0Y4db+wSW4iiLX1YSwGksJEI5EWAUDhjFPm6Tyuxwa2oz
 ls8La06qh+ee6FFIW4E942h0/7mFKUhBq4uLfjTElXekMBi8YOKhZtc51+YXLyxTzgi9oTH4l+
 2uFwr2RzR6++WNrIBEiS+Q3o+kxe+GHKJFDlR1NmMiSRiwJvV352YT1VXqmeY3vto8wCOhmRW1
 PLY=
X-IronPort-AV: E=Sophos;i="5.70,409,1574092800"; 
   d="scan'208";a="237221482"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2020 21:40:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5DuxiPmZ6/eTmJG4KX1gu4zLEi19+UP9Ha0TbJREsC/+FW3UQvdPYzp3hv5S+Mk33ZGlYDfQR5z6TZvi+jvYPbIUCI1AS9vK81Zjj3d2Vx4EE6RcgHFC8NSWtvW5axFXMkfKhsCacbnm1IzDX1KmcdnOprrI9Xq6DGeJuk3/6iYvcsn3JV8T5DmiBZSlHrJoa+uHpXYUwiDQLmgzFBYkkEykmzaSSRJZ9lQWts0g0lsufqUqxYLN/YtKOQlQ2IaxDRHXpedz/yhoyCAYXOXKxzSRRo7Ry1SadganU7w2IQqRt3tRA9dQx8J9iQ2RklHaLf+Zq2Mfj4X68AThjGXtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=X128fAR6TOPGc+Cg1KD4++JOZ1YQyHfY0rM8bg2f6uREDZ/Yt47eTD9f/DZofXuk/K6Ynxy0fNhbPmLEhMuy4GXy5PsU0Mp/etUSCsZb8FMGAkIg+r8W8Rx0m/rNgOHIL8PzkUSMy0A1YKk8s7V43/guLcu0Qvmwc7U1zNdIc+bNur+L+cMlfXbT1hkmI8m33B+cLYtV4OCmrTLb2iwijSJ4sllwBE0R22u/WKf90f6urWfkIexjht1m8Kcxrz9/YaGyRVxyI/nUsuJYfZ+vLyhzzvGM8SejeRXHP64YlwpP0xz/6wBcvZn0XsqjV5IVhY+EQJnxSQMyLKBSHKMp7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Sf0OkQiBPwuuOEIdYlyCB7U5TULX9udHLImJpi+7oQXLDBMe9H3GAYfbmBhKujcwA+v5ww7oAU+aShhQH+dl2meMBhM9wL7Wl63s49IgsOUvw8Cf8YnoPHCNMPpDJuXVeq0AXVFl68w29+9Azv64ITFC9sEMR6JaXqKCRl/9/CI=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3518.namprd04.prod.outlook.com (10.167.150.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.24; Thu, 6 Feb 2020 13:40:01 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2686.036; Thu, 6 Feb 2020
 13:40:01 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 5/8] btrfs: sink argument tree to extent_read_full_page
Thread-Topic: [PATCH 5/8] btrfs: sink argument tree to extent_read_full_page
Thread-Index: AQHV3E93Pz9pVQs3IUiIRcZM0JbcRw==
Date:   Thu, 6 Feb 2020 13:40:01 +0000
Message-ID: <SN4PR0401MB3598AF153CFA7CF08CA0BA2D9B1D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1580925977.git.dsterba@suse.com>
 <fb262a910895eaa84572cd94b6f412215b2967e6.1580925977.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d82821e6-d2af-428a-9eed-08d7ab0a10ee
x-ms-traffictypediagnostic: SN4PR0401MB3518:
x-microsoft-antispam-prvs: <SN4PR0401MB3518A513517A80987141F72B9B1D0@SN4PR0401MB3518.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0305463112
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(189003)(199004)(4270600006)(110136005)(8936002)(316002)(52536014)(5660300002)(8676002)(9686003)(55016002)(81156014)(81166006)(558084003)(478600001)(19618925003)(33656002)(186003)(7696005)(71200400001)(6506007)(66946007)(26005)(64756008)(66556008)(66476007)(76116006)(66446008)(86362001)(91956017)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3518;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 83swQC/nmjcKt6IVN4qp2mMf+nBGAiFMBHY0dLZt2Zc9uFcvPFSGZbY8z1/LgUjpV42phkreKpC/fxTjC+lMnJa4zlhkGgkHEcvTwy7+FY7r/9EGPVHfujlv9ipAPFX82dHvgL/QB28KhLYvxxi6uEOZyQtzvEChyiQ9smlVrB6AYd3cQP+f90twYdtgLlMcVnRXYIWvYGDoxH6OW2s3ASEAQt8vlr/5dWI0bsl3eCI1Avlv2Y8RPQDQwZbSxQ1D5LkWx4WZYmCzZerZ1kd/WPOr/Ncy+NYWTfYPfyX1xrSN9IJWIt+HpAJMQDdY+ns1UTbgc5kflZYjUSPbOLMFTY+J/ORp+CQwSW+mxeaXgQ6UaJVq1bFnGLX1ZTR7CvAdkg/JZA0yXj+Gwpual6oFF325CF0x9RknIxINxZdhyht9/6Dx8Q1JtbhMeZqxuf7r
x-ms-exchange-antispam-messagedata: pw+bqGf1k3anrIRw31o5hAEnSIraU6irIFCsEyi+3jo/bzjtt3fC8wadA5nmo44wRBMh3dzyCQidY24dlTAEVYqUW3CJSvfP7xksTYlg+CVKCxVm3ZoFmbR6vf+0APxjSzdb5yiCtLUk9pZOAMcg0w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d82821e6-d2af-428a-9eed-08d7ab0a10ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2020 13:40:01.6801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ImjU8ONRVIhNn1dhy4zumv81Ml0p7Pl7ChKnhjpDEmMX4Bc8HUaojH2MFmeu5N8jwx4/sTTLeFTdKS9cJTAY5ft2buemmGOaSEBL+yrWj7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3518
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
