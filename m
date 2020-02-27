Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72CE8172B4D
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2020 23:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbgB0Wba (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Feb 2020 17:31:30 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:59092 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729881AbgB0Wba (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Feb 2020 17:31:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582842691; x=1614378691;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=BX8ZhdPEniPmb1C7hjhotrNvxew5aY9eLsJnaoOi1h4obK4LMDSOb7Sr
   N2k7OOqUBrLf6fsLGOvio+JZPxuSCi6AEEc8SirygZrw/wQaSYySvGpFq
   CwnlF+IpIQ5I4SizEtq16F82iVjyjek+ionRbUGj0T7Gq8U4Fla/+Pi3h
   +iBBKsz8JMvnE3iJa7ReNRBPd2PvtLNSg94ScPcVeSXnLxcdUGA+l6l/L
   CSxlCPR+Ngr3IWX+gP1mx/5kU5U1DMQ7kN4nyXq8hdfRz/dSjrSqGDWNW
   AXF8gFeoENAT3ekxg0xGs8GJe8s/TrNXkKmY173uHq4LkUkTfq94yUiHZ
   w==;
IronPort-SDR: rZWf9cq7ExE7jELiXmW32u4/E6mhJp+Jtc3vTkSFY6qCEYCEQpFEAL1IrNRwVpdOcBCK9nq466
 sPrShIb771BcXoCfsVGR+N05rpukmrMbHHBHYDZSXzhZI+dADiphof/1Mrjg+Ag9Dtjn3yJL0C
 tGQVAvplAKQSHGJIFC4bo+oFXNMulsh/yYexpHOpeJp1bRev6Fvxr6y919QKEftA/Zjh2ojexs
 BTcDS/rsrfO/7nVFfHdUfK5A5CihKolbHC9jhIJ5RijNdUgxAjV8vkXXHLOBu7BsmFg9KfzeTt
 fp8=
X-IronPort-AV: E=Sophos;i="5.70,493,1574092800"; 
   d="scan'208";a="132395583"
Received: from mail-dm6nam11lp2171.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.171])
  by ob1.hgst.iphmx.com with ESMTP; 28 Feb 2020 06:31:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fknY7uN6Ucm3pnZkmQSSmDpU4qEv5/ytqEYrcIaXc1/K6PbkwpIHXTauXRZEiRPG23Qg2WLrj/ozP0ypF6u6cIGM5oWKdr/NJqYaxE7CmpQfY0uZDVaLbt4NYzgG3ZG9nD/XF52eB74L6dJIqCLC2JdsXiKSqt7QWzbH7eVg1L74H+jhm32XU1cynqCTqM7b5RPZYyG8royAL4Xy/PSTSZNT7U8zgD6DI5A39yIZadDlvC8iYu1qgJwiUt/c+0B0wHbRtYB+3D893sjV2S8H64kyxUw5WhtoLtwJmvOJYObOZHDDx40SOO/LfNzvPZpFeTyiqh1efn2p06KUnGcodQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=i0khIX3yYS4D7hBY2sfM2S/3nw9fOkZ9/XjaU9zihD3V6rMc0ACBJOSQz4eq7xZWMhJg1Z6IklmzNf5cKLynyoCoq5OmfXfSupX9AkVSOA4DmfWWL2JdTXDKoanOSEXxY2EnjWuVDpn0Prfi5nfSSswQCB7ZaUlAbzxnxquG7XnaCYysprehMI14+jcLxqCk6IlMqpCsAgTTsg65HGpzN0q0nk9FAX6eg+7IUgW5rfhkO9bRdEtYxHG7TQ8A0p3hbWrQSkw3i0tLSi1tbmUh1fSpsA9/g98L9xegFnBemfi6kaR+HHaoRHDKzUhG+uVMaNjpNkuzL4IGuiqUkxpLWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=w8rqNpibz2ajR4JP7RLYvzOuYDD1fdDy5mgafUnjpKq0+sqIQs8p5ci93AgikyGxTE/ONCQMCD2Dq6qXZgLkecrUzIeGSq/J4jRhzEhvno9iFLDVEAhkci7isJ8D3tMa5Z4/Og4G1tP6VmGrdI48oIMGYrERAkE0M+XLWOp/zVI=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3613.namprd04.prod.outlook.com
 (2603:10b6:803:46::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Thu, 27 Feb
 2020 22:31:28 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2750.021; Thu, 27 Feb 2020
 22:31:28 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/4] btrfs: inline checksum name and driver definitions
Thread-Topic: [PATCH 1/4] btrfs: inline checksum name and driver definitions
Thread-Index: AQHV7aiti0sX1yYE2EySLvGj919OHQ==
Date:   Thu, 27 Feb 2020 22:31:28 +0000
Message-ID: <SN4PR0401MB3598C2E6E9F9E0370A2824399BEB0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1582832619.git.dsterba@suse.com>
 <91753cb284a2dbce72e5b5b31b658e1c50ef084e.1582832619.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a80e80d7-b92c-43d0-8945-08d7bbd4c9b0
x-ms-traffictypediagnostic: SN4PR0401MB3613:
x-microsoft-antispam-prvs: <SN4PR0401MB3613100424C810BF4C2640169BEB0@SN4PR0401MB3613.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 03264AEA72
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(376002)(39860400002)(346002)(366004)(199004)(189003)(6506007)(52536014)(26005)(186003)(558084003)(7696005)(55016002)(33656002)(9686003)(2906002)(91956017)(316002)(4270600006)(66946007)(478600001)(64756008)(66476007)(8676002)(71200400001)(5660300002)(86362001)(76116006)(19618925003)(66446008)(110136005)(81166006)(66556008)(81156014)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3613;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KidGYKfjNHeC4NsvRTtXkXr5i6UiPxH+IipQNzmxTiibzm1V7PRH3jhwHt3YWGe1AQ3eh2hnkOri913cMogxGGPCIcaX8bnsS9yVXCGRMOSz0MTBYUuj7QUAZIQkwMpFJwjYNv2ry1G8cRCynKJLm9GeHF4XV9FByqoxsRlszp1OYHXzI5X1vfqKhGJWG9Uqf4f2ZIgtAPTAd/S12VO9RWSaO0ILZJuZMtnKQgOiNFnBVczwCanqrRATiEIqLt5DrNoYS2/XxJ6VmfaJAKNNwU3o3I4ICCCASYO6U8ml3C1KnQEcqpXakM9L6aetPohNBCkokyR+KeoKnhaiprmH09j1GEsVhmwlLXaJq2+KuwDy4v/KH+/8ll3+ODz4t7V3ZKJMWe8oegdsiulXN6oUwAibQpETa5czuaj0oyjBKpJ9aGd/JciZlB05b8xQHVAe
x-ms-exchange-antispam-messagedata: vOcHZqSi3THptkrEGsuQCcskGo/mRttaMtGe1e0lRV6FbbUvGp9EQ/h8wEAbChLu+Isk2efoh/CFaYH2Lk8nm2HkHsSg1ZW+ADaP0Ca0ITQkpu/l0kD0zXmloNWd5/9qsk54kckQkjDdMM2NYqg51A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a80e80d7-b92c-43d0-8945-08d7bbd4c9b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2020 22:31:28.6485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zw/EIgY0y1yVpozrci5ApVwVHR5ed1vEmvgHiNNJMrdZ3oYMvW7QdBLDEWT5+CwvmY2o+CUKmx0o1qiRWiXV3o9e+w35v4EQPrUfl3qfQhQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3613
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
