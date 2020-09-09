Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DECF4262D57
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Sep 2020 12:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgIIKkS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Sep 2020 06:40:18 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:16432 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgIIKkP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Sep 2020 06:40:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599648022; x=1631184022;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=yG/HJy+Rd3RvnXm0wO+leTB4FaQn98WoB3oz+YMuKqA=;
  b=rX7PWgFjnLR5sq47VwnLS6w1+dx6G0dD1RjX1B6YQs+uek/L67a4V5lm
   QcLEE4Iw8il9tKWvgl6hPjghMTUQENs68Xh428UW+qR9eZkIlSkb3IBry
   GB0kBLmStd33DErtO7dLq/7nXm9kaQYJNJGfACZHx0slhAbu7/Je9u/fJ
   c37pYgvw+eh2uhu3v3Wnhx2T0KX3EUTUBc5ixS/EZALGpK+8gq4753BSH
   dhOAUh+3AtLS9IxchRccd7UIhfDVSMnOu/VNglVDnkbNhnUdBFH2a/+jQ
   /k8LZLysx4sR6IQKzn9ek2cxB+PR5mYfltANscF22zhHPjGQiV5oAr93y
   A==;
IronPort-SDR: DQXDSsL7JHC26mjD3t32fJf3q171W7KDT1OFvt3ZpA6JnV8YS+o1Cl53mfOZ9JyF3fI7FeMVL9
 fMBeHfyZgJQxsQdAKca+6cLynWWe1NEwJWsdVd6jqMQ4mcz91Wj8ITpPyAjmGXNz0ZYRljLHwc
 HijV5lR/UjLytUxEMqmnd/GVMgcRIlhC/0IJORG2GSGfMK33EuLctxG4rw36B/bevS8mpgPlzI
 vaH7fQb35Bc5KkzmgZUhyfP7TvcYPdd03HwD+iaYv+uQtepWeo5haCKiI3njb+MZTpOoUrBaiU
 UJY=
X-IronPort-AV: E=Sophos;i="5.76,409,1592841600"; 
   d="scan'208";a="250215874"
Received: from mail-bn8nam11lp2177.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.177])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2020 18:40:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UtqHAiUsYNrzAnsjwL0zSfptPQl54SJwRuCtv9/lARMJ4i2dS85G1ZvT84/DqUxLRupdpHeH9ewVDqU5td44mRQKXkf0kjlxiAmLA5yqj8sLTu+IdARoXqA0y9qxCoqhDI8zGr4bVvjyhWsNvAB7f5z2uFxz2jFSXv3KSiab79tPHbyj8e8/6FNqpuClyKhOxWSHYc6ZA76ZEhdoaNVqBMgqXL+VswYHNxKIBxc4QhK9bhWDwZW1phW2ecsQnV9Tg0Z0gH3y22YzkJYPGpPFdu/IvcYDF9VLFE01dQMRFFeYdVkaIr+6jRmQbCPwVe4QVH/yJsng1xAbtvmAQPOifA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Z6+xsZlOB74M7U5EAAYOYWbEIAEm03/AbRWtbywydQ=;
 b=BJqgUn3Yf3UWQTChXG2NtlIm388rgE0xrOTJJ+pRIaEDbsx2E9ZZTc2w4dl7LPZyXkoO77JcyfyYlK4yrQ80e/S5GUwZee1/7Ow6AfeEeg/quGVVXNITs1uyWy3MXOZnHTQM/NIf9opwPJgjyIkIzYN0bpGww2SuMv+jVJkro8D37Jx8si25WCcnoftTkkzSC3nHGDsrnMzqrsQTEsrnH1aFaUNtTD3nh2N8iLmR92cgGZU44Tk96bgP+w9Hnc11lV4Zeom/v5y/prm9cy/nhJi+w2R2vtluswtJzqbY8ejUIbzLL6G+w5DP1He6qhHufEvpddFuuYjY2gJN7DEwkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Z6+xsZlOB74M7U5EAAYOYWbEIAEm03/AbRWtbywydQ=;
 b=hTKojrEZGdqIFlvs2Zedz/8kRH9f3UNFotBUsJmo+Q1yBvcLLF883Ycp2ZHjU9G0QnWKhRhyh9Aat8NT0fghbcRCeya7F/2MaFQW2+B+BShrWPDXa4dORdmSb0Uxun43ivLtDm7xU9Id3McMugqS8ofZAhXMHhFuMXIHtpIG8AQ=
Received: from MWHPR0401MB3595.namprd04.prod.outlook.com
 (2603:10b6:301:79::25) by MWHPR04MB3743.namprd04.prod.outlook.com
 (2603:10b6:300:f9::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Wed, 9 Sep
 2020 10:40:11 +0000
Received: from MWHPR0401MB3595.namprd04.prod.outlook.com
 ([fe80::158c:8261:8a08:30d0]) by MWHPR0401MB3595.namprd04.prod.outlook.com
 ([fe80::158c:8261:8a08:30d0%6]) with mapi id 15.20.3348.019; Wed, 9 Sep 2020
 10:40:11 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 02/10] btrfs: Remove pg_offset from btrfs_get_extent
Thread-Topic: [PATCH 02/10] btrfs: Remove pg_offset from btrfs_get_extent
Thread-Index: AQHWho6h9S/gRomjHUO0h6CzvTSkpg==
Date:   Wed, 9 Sep 2020 10:40:11 +0000
Message-ID: <MWHPR0401MB359530E4B74089032A445A559B260@MWHPR0401MB3595.namprd04.prod.outlook.com>
References: <20200909094914.29721-1-nborisov@suse.com>
 <20200909094914.29721-3-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [62.216.205.181]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: da95472b-9a91-4f01-2d0f-08d854acbac9
x-ms-traffictypediagnostic: MWHPR04MB3743:
x-microsoft-antispam-prvs: <MWHPR04MB374391D0D90A76F5869331319B260@MWHPR04MB3743.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TsvS4IAuPiCwzIQyEQV9fKHrM3EPJw1LR0EguIFK9C/1h/7KuKtOleWfOFdeknocamNqP+JS4zoxN8crA4NpMloK7foSp/ef1hP7beSwrXhTF9afZu6czopkrrwBvrAnKBpj/MB7Q1bwI6xyZ7bp2Q5l53CTdAUlZHzF+JSS5SJJCOCJ7qZqh3RwdcbAOalVWSxACgSpycyk91r9SP/4U71occq3LwxzBUGCuUih/+diUq7Veui7NKC3iIFnvvE88JoyjRjIOKZNfOwNkKWA2cIfGLZfNzuN7X+XVyw+pf7W7tO4UAU5QZnZGn8C1rIRC+eD/mq8tiELvLm74FMhZw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0401MB3595.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(396003)(376002)(136003)(66556008)(26005)(316002)(66476007)(86362001)(2906002)(64756008)(66446008)(52536014)(66946007)(110136005)(186003)(478600001)(7696005)(33656002)(71200400001)(5660300002)(558084003)(9686003)(91956017)(76116006)(6506007)(8676002)(8936002)(55016002)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: sSxB+lSKqFQaI0yRw0q1/hy5x/HyGI+tG7vJvmJXyOXnqn7Z8Ry61fa6ORbqw1mV+H9IvGRQ5SrcX099lZoYUGwY9+rSdyZmZsQRD33op4SvglPZNxAjpG5bhHgbboBpFZODc8xW4LFRPQ6dwWGfXmyRo2y81Gj5U+/90T/a6yJ1dAfRvBL8VSkKP3qE/TCnOwCKIFWX0/Ay0F316bitfWnpD5JM0IpEjIf6+kXqjBDjinhr0FDiX1xc9gKLyZ7dumg9Mm5u0cl1yXBX+iKlHSj96fnTtbEXcYB+fGB0jSoQSnD4PzaOAiBZkin7IO7kgjBEGDB4D/S2IDZjbc7DcYo9eW5TQMma19iy13fs/Udv4SN1SAh9sZwl0jizdRXi4TjstSWhyrzU0q+bimrdvVn06+tlTxV93fJZURQlkcGNAz5MOga93syHcF7sOL7Xp/3C1oFrkydPPIdG3Teo40B7JgDHEvgg6GksvWStRUp13UktwpblcCnMHcMivO7G/5NuFAZkovsNyd6pdg5edkrMfGDgtacHSkIqY+HoNUh/uN/FT+UVTlQjtH+/g/TC0jrGF7e/y4q6zqoF5uRFIy7W9Na+Cz1BKUNLOQjDGaI6E8q9vt9v/qwOMIm1HL1KJs8R8e2ukd9bE+96VgUBtA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0401MB3595.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da95472b-9a91-4f01-2d0f-08d854acbac9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2020 10:40:11.7160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1mBuBdiYMWxanNJXwbLKOP8WdN2LCtRXoPWQUh5nWYP2kJF06nRWpqMXCAkHEz6x9aMO4J/KCeTpGJ4rQmJpfrxwVnF1b3mZ9jM5gQtf9Mc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB3743
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 09/09/2020 11:50, Nikolay Borisov wrote:=0A=
> +		if (pg_offset !=3D 0)=0A=
> +			trace_printk("PG offset: %lu iosize: %lu\n", pg_offset, iosize);=0A=
=0A=
That looks like a leftover from development=0A=
