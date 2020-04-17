Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F0D1AE43F
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Apr 2020 20:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730382AbgDQSGd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Apr 2020 14:06:33 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:19378 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730236AbgDQSGc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Apr 2020 14:06:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587146855; x=1618682855;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=EkhNe9vmlkTSnMcW2nAYnD8b9CcpzKORCy7B+WT5v2kJXyhZtYL+f9xh
   OiPXIdPE6YjhHkMV5TGl0TMplB+WlhFVbP2TV0+kqI2adY9K3EVO126PO
   0PuaBCM+7Piji28XipFhTHVzCqRc8sUHCLqZZ9cTZq44n8ezp8bgGCJkk
   sZm8jHmwTXm8QOcSATwMM3LXI1IilBEsNKkdVJ3BsjNa6G5kRjDEB59VR
   /zc5n8AKdD7R2zJ2DAXpTneuYuZdROsrdNndBVD9WcyeT8kQaExKh0pV5
   UtKJpVXy8joJXz6MHQDdCHDKsOf54oU2rBKmircaYKivP84fbNvTz7Giy
   g==;
IronPort-SDR: +TADz9XOF0avOpIErrYiE8poAODVApTCIduUt6sX5eSXd7lLdv6bzubIazF1GIWx3UQweLnpC9
 7U2CheRpZ+PKg0iQjo+SyZtkeHNSE7pcxJOxL3Pzw6t0OEw+wmPWc64hMtY+AelcHa2sqBXC1Z
 lVdJbdzmxZKjVjxx4249p0EG5Pdvu3ngsJp2p1GO84G6aSsQow6+Hiq9/xAKMffeMp7U+MQMP7
 IaQ8YyEObb4cvH1FkY5iwzule+PYuFnCZGxDTRJdiM6RbexIHiu/+g83z/3iYf322iV/kPNZS+
 8Zw=
X-IronPort-AV: E=Sophos;i="5.72,395,1580745600"; 
   d="scan'208";a="238011821"
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
  by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2020 02:07:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7Ka9BGvJ33bmeJhBms7Cy2sCnqGudfR7iDRjiBnn1y0tQ8raM0tVdWDUiV/q8EnXBlwt7GOKXbDXm9Zhj+5UdcEjcvnE1vEVDDB2RS02he7ee4ralUzkSnAe+4XMfwFvKyd0orqmj4NKpagNO2vsJTTt4ifr7vxcdYS7XrscFq7OM4Wd4+VweJQfc9g4VCvWZMS6E8dX0tE9+SJ9n23UvCm6srF9ybdfZUNzoopgaU09LNNlgqhlrOlPkadBoxu/46LgUxs103flwixnrxByhsbg7KFhdE1ft3vt01Fnl2iVgl/Fhr8lgZfw+XIWLFMDW1/O/j4Xm/NZ3HBAdEo1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=GoAHmNl3jhcmaPNkxlypdAAbq2UWJSB2YnPA/LAB+AHgmV9wrpIdyh/eSGNGqCOJWz4Si8tENQC1C12lH0ZQ/x+ItNiTr4H/OzKnoJ2EUpoE4o5ela/VtQtAhQcKbBYBSBlnRENW9OUR1MfaDbIE/G3TbfLHgeYOM9wU5hSMKtHb+lkft2MKihc7sKSzBtsNNI7BkFWxh79VhJQf3OYBfxLM1oxhpkvknryr6m5eTFdeIm5RMMGFZ7I7z2jZpYH2J6rQ+J8wgsytM/QuzHt/Fguz+suUQBPaaCAd3CQMOw9hfW/nPj7DB4e/ibmwZ/QkEUVFcj+XplT1pY0DLDFzAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=K/X3XRrV7/uTZmo/O8frPBXlsmDzUYvyeEGvvmMcagRGHG2DPg2YE4XGsTEeonPMHGekeMqM+H04jBNex9sszCg2IiFodPD2TgTUi9W5+00BlDbl4qqWJctdPrUCdyI2uNuTDmU6gmG6r9ymvyKYPxsGJUi03qDxT5bI/totG+g=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3615.namprd04.prod.outlook.com
 (2603:10b6:803:47::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Fri, 17 Apr
 2020 18:06:30 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2921.027; Fri, 17 Apr 2020
 18:06:30 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Omar Sandoval <osandov@osandov.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     "kernel-team@fb.com" <kernel-team@fb.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 11/15] btrfs: put direct I/O checksums in
 btrfs_dio_private instead of bio
Thread-Topic: [PATCH v2 11/15] btrfs: put direct I/O checksums in
 btrfs_dio_private instead of bio
Thread-Index: AQHWFDizexTa5IH9yEa4V/z8eqCHNQ==
Date:   Fri, 17 Apr 2020 18:06:30 +0000
Message-ID: <SN4PR0401MB3598EAC75ED309DE944271329BD90@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1587072977.git.osandov@fb.com>
 <c6a8fd5e2811e07532c63cec0aee48047b8f32a2.1587072977.git.osandov@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 87b1514a-75bb-439d-f13f-08d7e2fa0e14
x-ms-traffictypediagnostic: SN4PR0401MB3615:
x-microsoft-antispam-prvs: <SN4PR0401MB36152DCD46D0B190272CF8BC9BD90@SN4PR0401MB3615.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0376ECF4DD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(346002)(39860400002)(366004)(376002)(136003)(396003)(6506007)(316002)(76116006)(66446008)(64756008)(91956017)(66476007)(26005)(66946007)(478600001)(8936002)(19618925003)(7696005)(81156014)(2906002)(71200400001)(86362001)(54906003)(8676002)(66556008)(52536014)(55016002)(110136005)(4270600006)(186003)(9686003)(5660300002)(4326008)(33656002)(558084003);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PLN7m/tgW9YFpmo8HZ1ZvKJibTeCmm+vPQpyJlSU39ywKjv/X3RKgKAvSR9unbvEy9S+CGE9b9PMkT00Dch8DM1AHgFB0qipEMbS70kkioTCipLIs5phKX39iSmmxIj/mtrB58hPEyGTTrD7ODkkVxmn235ZyMXqwlUPTFTh/cP5mkPYtcmnSX+5J5Csvj4v/KyQwPcIgGvg0eLiwKI26467AiFpOBcZAFAL02njbldly8ofhdRYOto8QXRVNprNT5SFm7UMlr4TRY7wa1rADk9oq3kRpMVJVGa9nEOMig1x6xbYSccox8PNF16tWcO17RrAntEZhsGBYT5s6QmubN8shiv2IT6IdpWLToDd+qHHlIUkbL5WD0DLxvB4yfUGdnKoCt+0GFA++OBxuEOBarhycZ1mRKktRysqMVsdOVfECHdf+xwu05pGVlEy1S4X
x-ms-exchange-antispam-messagedata: I1C1ETGjXbLu7K1/8l+ZuT6j8oN3aH/2gmU1PwZoEVyDVsKalhOkKf6uKX/bnjyEjKurj75som71Zn55iUsNWnDQWk8OK+F1zzmW/QZeb3hhvJZ21ELx7T7x7lF5P9OMXYBIzpnli75IC7CLM3qLAQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b1514a-75bb-439d-f13f-08d7e2fa0e14
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2020 18:06:30.1226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +RptgcT2QDbtYGDpuqjTJkFKW7ztYinsw1+qqUD11ayaqZTiPopKrVbG3A+4LiLdTd4auQApexxr1zDMU/JYxawomPTfKWn948nNeSSMVkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3615
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
