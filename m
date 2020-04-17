Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0351AE427
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Apr 2020 19:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730235AbgDQR7w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Apr 2020 13:59:52 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:52856 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730033AbgDQR7v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Apr 2020 13:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587146392; x=1618682392;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=dUgWmW0ZLcHlgnXsE+7smwQ1U8YQQiG2M42foXaCyaxgqjdSTFj1xIwF
   3yNieDUWIeAX3WIwuItGbeBLpTJTUh43JpgCil/4K3QzLAePqs1o5SWK7
   YC7OukdMZfMcUu1GQElsqGmVSUmbQFLrQ8+Y28+wyi8SododmnQao4bes
   nWHlaE5T8LfwEIvmxLJYTv0/c04JceA+ZlNCy5ZZIg/ZSgVi28JATR0jG
   zGzfBlZzL2hG/l9Cq6GujVUeV93rkJ2GRcGMXcmG+BnKvsub5Am15Obnv
   Kh5La2UMkPbWqcv66Q1nXEJAZfVHFggoKZ37gX7zEJ3HexTgaY7gbW9t6
   Q==;
IronPort-SDR: TZETmSnCxZD4Fw9dDt98HLaCxIXDKMqasQh28zcrjmiuBBOkictFS4J6jjjrUW8UqskEsiz9JF
 lbGQAwTYVk9Y2yaFPuN+GTAOX9uQwD8c5xy2YrzFvLXr1ut/tcBdsKRgoxRTybJ5tBvdjGkHYH
 7/fhylvGj/wPONxpWzgy1CwnlDkV4wQ/iGOOvAFvTxEKA5tJfZOmdL0QMK26ERizs2UGfL+j6W
 N962WnER9nRfwtWSpCUgO+ABt/sgm0CH1qbaJPGX0H1lhJ7p9ODkmAk8ePDvXCZpQ8EhZVEKja
 D6Y=
X-IronPort-AV: E=Sophos;i="5.72,395,1580745600"; 
   d="scan'208";a="135887765"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2020 01:59:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RW0K8moB1cB386iNYZ2t1x99O0TLpYFzhURsz3hPUJiYipZTCETZfxG27g4ecfDbZAFYld+kHywbtkm3CGP9HSVMztSnm3Yfx3GXiuSYb/iIqjsyAX6mL3OaoqZNMbSj2mVi3HaMIta0S7qBVLsnvUxf/805VnDUElig8Ud/3ohndWkTvrMm+817JQ4wjY+fZGbeYhO5F6qH6qkP/y78BTx1UxOoBLT5l9woWwMdOecY8PRjIkHyOHZjTZE+8Q83nDPGiD6OPwKVsBCDlm0nWx5g7EjPLUuVFjFExumKnA5rIxme2emCsus3svpnDJG0Tq/HmVqO+Faf4v/Fq23ByQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=KN8ruRPMIak1jDPvMk20iTQXTRa8rP3p27875QWhneQ4DCMIi2qHLtIwmMHXXzoaGStrOb7eGXIWchv5EFtpm4iyd7I+rYQyTUHiJFbvfN2d29DeGJ1E8aasSw6jWvVZEH/450pgqpc/IoaO21pMMvdEoOXlVXFuoYuqFMlCL7/6mqFsaBlhjriye4OyBr9U+e27lZjJfru+f52YpNjG0br0I7xPPecfsoefpCmLz+76tB1ATxCa08JRCDVuO6HFfzNRJ9wtNnsUIZntEQ7SgOYDfILxLtxSmgVXo2Haw5cnfkxbkUTqWAPXwxxzT9Qs1FQ4rdID9NsozmfnXvq9yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=AVXzqnELJrtZulBjkXBNXadFsdVVBMVXXwzYomSkT1s4waQxioJhNTspRk9aFlHJ8CHHIegs5MZBM+SX/LSC+pw+mLYllSw2ZI1heTZ4UtHTzGFQ5ThYbKat60WenQjRGai2fKuTEy+mXUwHtzvIRygTMZVQY8DU8A9X2US/iQs=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3630.namprd04.prod.outlook.com
 (2603:10b6:803:47::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Fri, 17 Apr
 2020 17:59:48 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2921.027; Fri, 17 Apr 2020
 17:59:48 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Omar Sandoval <osandov@osandov.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     "kernel-team@fb.com" <kernel-team@fb.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 05/15] btrfs: don't do repair validation for checksum
 errors
Thread-Topic: [PATCH v2 05/15] btrfs: don't do repair validation for checksum
 errors
Thread-Index: AQHWFDiq5fdIsPYetUujBVSVIcbOZQ==
Date:   Fri, 17 Apr 2020 17:59:48 +0000
Message-ID: <SN4PR0401MB3598D1D0E066C04AD8A433139BD90@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1587072977.git.osandov@fb.com>
 <a66720d2e8acfb7370e4eca6ce3db87f847f9046.1587072977.git.osandov@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 11764097-f7f4-406a-0029-08d7e2f91edd
x-ms-traffictypediagnostic: SN4PR0401MB3630:
x-microsoft-antispam-prvs: <SN4PR0401MB3630FB53CC2F89FC87EC75E79BD90@SN4PR0401MB3630.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0376ECF4DD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(4326008)(478600001)(26005)(5660300002)(66556008)(66946007)(64756008)(66476007)(316002)(7696005)(8936002)(8676002)(558084003)(186003)(52536014)(76116006)(4270600006)(33656002)(66446008)(6506007)(91956017)(54906003)(55016002)(2906002)(86362001)(9686003)(110136005)(19618925003)(71200400001)(81156014);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o07xBF0AxiK7hM23ftG+6axAQ8gKWPK1q8zI4vZoAzksjj7wm57gPFoEQmOb0nS6zbowIjcXi5qqFOx9ZbA5HRY+0f5QeWfOLRtB/rasxa+21OdAofYRXfmHvoo7A613Qr+mXoChkwdSevt8Ck492cOfILxsr7VH45KBw+NYfCnlgCOBdDK62jpdTbkP7faO+1Qht/CqWi4+xd9vH9opLoiE1QKL5fZo80mn0zj3oxKHFm+lGMUdQp0ixSDTapkVJ5X1rloKArT0RvkD6CKjkz+4J/PUJOK6dgEjymQyfrxzg0jTkuOU0dByLKRWGEawi1jczrFmXSJAcfK10ra+1Svzihl01VRSl7cnObrLZOEdIRMrFwIppPIMjLME8B4cperqMMs8tULbdq2yZInQJ+NZsIX2R62KEFUZIZeJg4aCYiOU1o0K3jybcUk6hae1
x-ms-exchange-antispam-messagedata: udmbbXW7U/SXlDaknHw3AYF8Ya5ZnjsT95Y/9qBeBmhig+YpNq89bA5a3d1+bY8Ft6cVmSXli/CreO4u/qexYmwsKU+TY1WPSDfhWSlYldTT7HqSOz940dz0ahSGalQ2XexCFr7qOrgDfXqlkCZ+dA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11764097-f7f4-406a-0029-08d7e2f91edd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2020 17:59:48.5449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H4i6Yanvfjopj5RrZ+Lzc+uehYPmCjJRhw6W7kMoh1GE3DHnfl3mbsWnX85sBLwfIHvJq4qHIX2VN1fscJpwNerHCvkRmMtPqpoUfGFRyuA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3630
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
