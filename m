Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A7C1ADDF9
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Apr 2020 15:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730105AbgDQNBz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Apr 2020 09:01:55 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:22326 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729845AbgDQNBz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Apr 2020 09:01:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587128515; x=1618664515;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=F8/ptzi1pFtQG821irC+e/XV3qp3Zjh9B3ZvU2pg1binBa2keSkl0VMB
   uX0PH86CIQI5m5atyHZ0nYZu9Rx7/4PcRmQkJ3hZjabucXeTCOct7GABo
   V44e6BqgbwrcJXDPSTIyt9/dDc8idz+ql/X5UBi/Ke5WCffUkz7sTCPTw
   01Hr8IA7aG0S3MFmgsMJaSVZDdC7H5FSa2WwlyhLKYGV6wwN2DNEgnKgv
   BTALOD2p3MTg1yPpL2MiEPvWZtWjO5U3S7Ti6OD5sHm7sN4nQWd15+Wiu
   0tblv7nQ7BtffqhReGPns8592hgXRqRN0HS/kWgPN2YWWOb1bTfrRvxB6
   Q==;
IronPort-SDR: Yj+t5b9MAiGedU1S6ybRzYhWmyNCg+PdBNQ6W+DTPaNzpfchYkLxg2nhjTTLVLaDTDTskEo+SI
 QwmHztSmARch5Z5SDRBhweWGH/wdLKBP4fwGLXrdr0bc9Ot5zURN0IZ4Bdfhl2224KmGxvywI5
 nrESMYocVDV+4H4W7Qx4qp+TKUpsnixNb82mj+bLom8LZvfv8ro1u6VIZbsVxa90hXjYK2ab8W
 Yp8f9tnV9GqGccnJksNGiljkL7dX3mLMx+dPPfZx5qzsuGjWQTxsiABifa5ZD5WiuwFQ7eQGDn
 MJs=
X-IronPort-AV: E=Sophos;i="5.72,395,1580745600"; 
   d="scan'208";a="135871117"
Received: from mail-dm6nam12lp2174.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.174])
  by ob1.hgst.iphmx.com with ESMTP; 17 Apr 2020 21:01:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kz6wiFDjJ8hYXl/FMk4hPqnEIyKM3p8Y7coGqKt299MAWbztgLC2NQozM6eJkSpuQaM+9zhC2P8vAgtSb6Kxr878zupF6Zto7qy8J9Q8ZOVS8Mgy60qQNiud4iFNegAq88ncU7ksboLoS0bl3C6IEazc8a7KCj5Hi8SmOp3QgQUceyPy7cXaEpDBlmxaRTc6cpRH54c9BeQLtQQRW16bJleWHa3ZWQkfBZWiQuFs4drCRdQ8D/mL9fzu0S1IGorK4HmhxCsneKuaQe+mQzH4lX8yv+hAGBIOvGA2zXliOsmTvS4fiOYcpsE/L+87OjpwbQNTDY3NORra+TW0KAODuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=k3gF3BRTj3v/8UUWiY3NDCy0/vHg6KvQaleQRJRCMzTkPl3+GIXqHLch0IR9BrkjVD19XmIXrUhFAM/DzbfRS+Wj1PMYMEA0MNodNgGVApjTOgOVW37RczTS4DJdUcZmCpkQrbt/UWI6G08akcUIdGfdtzRNviCbwt+MfHQr0UjgdL9WjEhI2COnv5NTlS5PbRzYG+vxLM3FL1OxtDr0eVBjUT/dCQSLRRD6KI/uC+/zsDM9Jlkzkg51kYEuAmZoECjiTvamLVM/C7jss9KfOukXzA9ffo5OJAglbmY4/h3Gud0Agbxi04FGo2BHL4NctCT5KW8QVHbd10a5SDJQhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=V/7WTHZc7a1z7pOBVFcIqN3+H+zSWdGRLJHGnCzDfC0QEZpmJ5uP3+2eCpLqr+1/fKN/J9DfCBckWGGECLhqVrp8Zguxr6FsHG7z+MXmF1CwwdN2s4Um3BSwn2l+c4kwNb8QArHKw21DgSV2kK1c37HyWg8zMwsACvlgazRBALs=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3568.namprd04.prod.outlook.com
 (2603:10b6:803:46::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.24; Fri, 17 Apr
 2020 13:01:52 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2921.027; Fri, 17 Apr 2020
 13:01:52 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Omar Sandoval <osandov@osandov.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     "kernel-team@fb.com" <kernel-team@fb.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 02/15] btrfs: fix error handling when submitting direct
 I/O bio
Thread-Topic: [PATCH v2 02/15] btrfs: fix error handling when submitting
 direct I/O bio
Thread-Index: AQHWFDioVFW9oDLaeE+5nGiBaHH0zQ==
Date:   Fri, 17 Apr 2020 13:01:52 +0000
Message-ID: <SN4PR0401MB3598BF18221B0C9CF6B6040F9BD90@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1587072977.git.osandov@fb.com>
 <6953c2afd9ba307568ca03604c76a767320d56ca.1587072977.git.osandov@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a44109bf-274e-498b-8bc7-08d7e2cf7fcf
x-ms-traffictypediagnostic: SN4PR0401MB3568:
x-microsoft-antispam-prvs: <SN4PR0401MB3568DCC71F83312CEEF4C57C9BD90@SN4PR0401MB3568.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0376ECF4DD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(2906002)(4326008)(7696005)(86362001)(8936002)(81156014)(4270600006)(8676002)(91956017)(19618925003)(478600001)(76116006)(54906003)(110136005)(66946007)(66446008)(316002)(66476007)(66556008)(64756008)(558084003)(55016002)(186003)(5660300002)(6506007)(9686003)(52536014)(33656002)(26005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RcvwHJBUdcc+qmYdwIV28M7hm3914YlcJXkKb6biocHJ6UG1gCfJBiBNxjYTU1UfjtPe7tywv3GTM45hJWT+FXGuDXgLPcueloLj+sCWiPsdq9T2WMFnd46cTqgYMSPJYUhH7YT0foh1fe6asrBSL28myX5hTutJUUMWETP+ftgwrPzd6Pw0eSUpEF5CRERAgPlMb9lxHeh6vy+8XbXXoUfp4oY7LqoTOhYizceTctHH0xBWA5JwX9WauK16YeSQoUA9T1/uEmproczV5BYoXtex4ZrtGlqmyCANr0GTav6SzcwKLMjgQKgOGdqK+t0oOxF5qEZ+7oHdK7qCLyaZeRr+J3trzKK2He8oxn+e6KisYtzDfnkqK4JwyI3UtklOwEPEyGV6YGrCkEtzZOHMgm0CeQj9DiclbCP3qvFQoB+kqGt14W6RH3ydxHiUXyXC
x-ms-exchange-antispam-messagedata: SAc8mvkc+wHODJEnQu0kEyrFneUsvvVG+7AJU8rMVUMhsqPGSghvPmKWN/MrzoSKBQ4yMXEtZxXlD7WghlfKFyEAudF3qW4dGNzwmT+atKJoMA+CV5PuKsKU/5/Y6ThC8+oPM/L7MDul7eqSwdr3hw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a44109bf-274e-498b-8bc7-08d7e2cf7fcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2020 13:01:52.5382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GJuAiA+2fr+w82tEttPtBl/ehM1E6sdE8khp+NUid2I1LFlh+diebI9O1NRx9xPboNSlTAT/cM2BDSk8gn9KMMJZ92O8zUMG1b1nKWz8HNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3568
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
