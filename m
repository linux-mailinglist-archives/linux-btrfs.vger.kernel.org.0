Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 611B11528B2
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2020 10:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgBEJyQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Feb 2020 04:54:16 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:8049 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728030AbgBEJyQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Feb 2020 04:54:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580896455; x=1612432455;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=igVeoq5m88fcPo1JUAc3SBLn0y9NfCaaoxgJ4yiYMH8pS37PXTQ1iQ6C
   /WP2eAGyMyYbDbv6yu0r4TY2jjINjvGDl7NNP66WtTIiUe+tB5Pw82C+/
   VzUCA/0qoXXxQbpsf3eFFBhUczEj5HICy+Z6ujjb8TgWO/GcQGGsZNc2i
   S8JV1UVUW9J389BZqvaE9Y1aOAk9nJ1HEHSQe9oaKIAU05EmkeqZWuJq7
   O0iSyKC1DRrfQ8/uJ6RhcRMCGNeLTWd3zoPT++4jLKMs+HxP9YJKE8WFx
   Yto6Is0V9m3LFeqWTSdMg6TiaVji/O9bg+nwHz8ddUV/RtdXNFtlTafOv
   g==;
IronPort-SDR: lvQ1ppE2BFtAGJtnGY2QFIlixxILFACRABtg4G2yuO1Hu64u1xL7SkAS9WOqIYBUtAFc6jZ0zV
 UBUmSE1WjvljeS6djK17oUtDFujtfk0r/hqY9mrGueAGauIcKpY8nHjD01DbO5mz/qAlOD3U2j
 FUorryvQVGj0uksb4wR3Oet/Nm/p+jUo1Fgn0W6zUugjdNxs+jttHUOzeo5r4DyURu/A3pD2e6
 OCdBMqbSDuQu/pGUkN0eS4MMdK/l/aa31GlviALHC7Wyomy6iN5MtCVI5+L3HScYZVnnv2aBiu
 P5g=
X-IronPort-AV: E=Sophos;i="5.70,405,1574092800"; 
   d="scan'208";a="237105738"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 05 Feb 2020 17:54:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UI6bKWFsbkcW0NpLEMmr+9VCrcUHmwIDfZcdrS8at3kA7PbRyNHYgq6ZOILyKhRlOQzu/aY85d15ZZm8wfUtKukOrY9LNlWEg6CDwm2AtgIxZlKpjYXddhulXhEaVF9mzzuB3kpf8eO5CXm/wcjXMCCezY8fUQHP5YoR0vkNcycYUJ3uelJOKCGCx/cPMwUndzMOa1txG16cb9ZJkq6qVM6bGdibXi/lQbjlvNjfgDLTfMTpbJjY2ly3vwqKjIwm2VtJnKskfeV6EiOHEjgRpWG9iootrj725WgOcRdSjMN+vg5chxc0rQ76WA+TrqRmCcqqAOO/Z17SR1z5bb0Bbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=QmY1vs2lC4F3QM8B+VaP85X0+EDjQb4VFFdGvE44WBQwiCuJr9xOALWCDDFOvAmrz9sI7hppiLjIC+m0x/K4UXpk1RMtCDa2vc4srF7NvjzduQHP/4ayKd5eBuqLTmb9WSEUp0PbylWCnw0v6ChhmUku0+rGyRZanQwfx80ep/Pf3y7XrdA1AjIX6wC2KnHThWaZjSz6lTh1BvA8JuC3+IlczU0i6j9UZekQ+qeWci8aXq/LJzA0wpvXHQO2fxVKkRgEzb4dD019/xxHLsGZma2hajJ3LjnWKDGYWjwZPhTzCppuZuvKf/OiQ++eayRMTLp7Q0vTQHHU+Eo5vMwmFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Xcj0CrZgWBTS/10j+PYugr988KGavV/uroGGr9IrEM+O+ft1voMHC/6+5CXq9aa61Mjar1tL3ifo6PUU8wEOun1MHRKFnY9g+86aQr0adWMb8VEEyOACp8XXkEPAXrXabIfQyncoZ3biyjcnJ2DwxpyjMRizQP+2IGL8Y2qIQow=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3711.namprd04.prod.outlook.com (10.167.150.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Wed, 5 Feb 2020 09:54:14 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2686.031; Wed, 5 Feb 2020
 09:54:14 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
CC:     Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH 22/23] btrfs: do async reclaim for data reservations
Thread-Topic: [PATCH 22/23] btrfs: do async reclaim for data reservations
Thread-Index: AQHV23cLkQ00VcLAV0Wf/A0AKQuqyw==
Date:   Wed, 5 Feb 2020 09:54:14 +0000
Message-ID: <SN4PR0401MB3598BE3DBCECC4641871471A9B020@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200204161951.764935-1-josef@toxicpanda.com>
 <20200204161951.764935-23-josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4bc37fa4-3324-4e33-f3b2-08d7aa215bab
x-ms-traffictypediagnostic: SN4PR0401MB3711:
x-microsoft-antispam-prvs: <SN4PR0401MB37117A67A28ABE9D731E80E19B020@SN4PR0401MB3711.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0304E36CA3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(199004)(189003)(81166006)(81156014)(8676002)(8936002)(52536014)(2906002)(7696005)(316002)(110136005)(55016002)(9686003)(66946007)(64756008)(66446008)(66556008)(19618925003)(71200400001)(5660300002)(66476007)(76116006)(91956017)(4270600006)(33656002)(26005)(6506007)(4326008)(558084003)(86362001)(186003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3711;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AvNlxt4tySB1394Z/kv6aCvAfv1BQTV/C89gLSoIZFs7tLIz+1P19dwjDRp4fwnRFNS/GykfBAsvf6Lqos81LS5zSlVkAJ5X15GM+ZTpwjtLD1cG99WH8uuQ6Zw9Zqdt0fnQWz8CtFIym/Qj4Ufwtdp488/BMfPoh+HTGNdPvP2cpemBazbMhTJtrkbsbMrBfFRoigxFZt+mcU7sYgx4iIR6ZkElkMLVEwIbMBvWijrDZvDIkxkW3d+KAzmT0cQCxb6VbQzsiryeiaZ6/cs1ZngFE4eSqQCeITyJDbGR2xbF0TYx5H+4qZxkiI2uUEUoQOUyVHuTCJwuKvR+rn5WrilEQynuw2aEhjvynAU50Rs+KEjQvhSXmq3uc6o32CJTL6vVr9xK/aTfwYFN+l1r49wtPMfQmSrKYdkZtpBwpajWd5xmahM1ULI/wQsUhZe0
x-ms-exchange-antispam-messagedata: vh4erypUxti0oKOouoHC00iq5Ft21mWiQK5XMk+2bsnVouez63EvJsqmjW0uPW9pCngGpTt4UGWhMDAyWDLYokjJzsleSH4ssWAJ7EFEBDr5u0AYhvyEvkrAriLBRI00yrHTRgaV5aLNZmQyryi4fw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc37fa4-3324-4e33-f3b2-08d7aa215bab
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2020 09:54:14.3523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BdoIywn0BiUboJaku5ymD5Pkuv814whowQtO+M0lij4XeAqvKo2tC0XYn5Chj0qd62YyVBI8/dAhasbNyMXwU9f0Ygc681UlwmLR4GUbNRw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3711
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
