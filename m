Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5874F1E5BB0
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 May 2020 11:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgE1JSU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 May 2020 05:18:20 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:13954 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728189AbgE1JST (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 May 2020 05:18:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1590657499; x=1622193499;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=B5mvoXtXo7aA9WR/qvfMWyAk8VZ5DHNvhMzlXbftjjE=;
  b=XFyG/0epyV7u1Fdd+dms/UVQPrfKTJwkD6Z+PrglMRbAeNKauKNYXEbW
   Q+iqcpkGpnpg5Cz0TuJHORmZJLNVoTftv52HzD1pd4DJssW4sRjnG2o8d
   NXSn1xb3tbD209ix1PCBBSi02mHa7x/HpwH8sjLMmX2bHfLKN8hd6k+fZ
   Z6w558VH4tsleCxYPs2LzEpIbr3kexYUiYS5j4XCxHGmFX0NMZ/SwTALE
   RvQh4O+oG7xiFXlaHxdmEaNXF8yQQvHU3Y6IQyVZFLDUOCnKBCvh/bTXj
   aRrWkkHzHyVoSAY3dbqbAGwzTFXTe/oNnxpUW1YL6tZyLJh6ADq+A0YD3
   w==;
IronPort-SDR: HSXCcPS0kNz/M6VlesWwy1x1pOq1wt+YiT9mRxXWhZVHdozCtFp3IIOpmLZ5V0badzs9GQUUbe
 rce4Z0JGd6qIZ5mu/MZsJDj5+SAC79RlGQtUDls1nQ0IwTi5r8brkwlUm+MJFOj6tpSJ9PweBM
 aj3OC/unCnb+HL4GVGXRiRKy8Ig68TGd0bM1j0vXHex9K3Zc6VlGxaD45nKMMWEW4ivjNgRS9S
 ptDPiKrPjyTznqltlLyWKXt3oxSrgHOjrnoqnq/kIFy8LgbuuUmA4lQAt6VjhM8WeLqNXNaFj6
 IYk=
X-IronPort-AV: E=Sophos;i="5.73,444,1583164800"; 
   d="scan'208";a="139019912"
Received: from mail-co1nam11lp2172.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.172])
  by ob1.hgst.iphmx.com with ESMTP; 28 May 2020 17:18:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZoeCl0xmXYeMHFYSKeYWnbABfpyVWNi+oOsBoU0H/TJ4Tvt6UINRUiOAlLs/yOxJUXMBvxzzobOrhS9YB04j5jTCu1AK4uu1uIlGsXn/xB12mbeHJ0T+DvwKs8w/OZLSpp64OVB0IXG+8rckp9io/hfJIvPpVxWz54jX6FRsm5YNW2n1wQoPM3mOm5yI1GV7tzqgjDXSjWJdk60KQxMoJ5zMFtSoYxsnH5mlWqAVai8leG81OPMsoAgW0dQIla8bsWmZEnGpqgYn9jrBbHdYmhBpjiQrgbbVytzwhwKKwBl89sbWgdkgKy6L01rtdGwoLnuVXSE2AhVQukVyBPOpyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5mvoXtXo7aA9WR/qvfMWyAk8VZ5DHNvhMzlXbftjjE=;
 b=i3VKfcThyJmlP2d2S7P78KnRVDUKjMu5+R1Xkyvo0aOFJtSTCuKOfsLALPbnsC+3lieLO4YLZoJr6wZ+TVQTvgPypF1QXtSAi6W19wdT+8rYFk42crCKkpYa0ZJPVNpH88eRK74lclREbJCMIzuvnMDhDOueNX9GvvwHwW+WAx5gdrOqvUXZW0v5zph3/uq+Up8FDMrVmoy1Dgu2WgerLz+Nzic/NrhXZ9117UrPyzk9LzwM5Rya5Lq08OJyV1j5CQRHl0U/qkcIg/bLa8LBfTUCqrxTbgipTXbMxhrZCJlIQ+pWe8Pda7I6C6DwsDiGyZy2ysY7EbxEHSoyC1dPig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5mvoXtXo7aA9WR/qvfMWyAk8VZ5DHNvhMzlXbftjjE=;
 b=xW2OPHs0M/F/w7DrLQWrcwnn83jcoSm2vN4K+RR44LrVQx8OO9h9xEcCuWnPRZCHDWhToscUUygTiC8lFktyP3bl/QxN7qtw7a5Zveoq09F30vNmlTN8sLc8Nkcpp83Xq1UgPIJiw0HXdZ96AXp+cUXFJRSfAnCLt0phV1VtGGM=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3662.namprd04.prod.outlook.com
 (2603:10b6:803:47::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Thu, 28 May
 2020 09:18:16 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3021.030; Thu, 28 May 2020
 09:18:16 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Arnd Bergmann <arnd@arndb.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
CC:     Johannes Thumshirn <jthumshirn@suse.de>,
        YueHaibing <yuehaibing@huawei.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] btrfs: select FS_IOMAP
Thread-Topic: [PATCH] btrfs: select FS_IOMAP
Thread-Index: AQHWNNDJKkYBMs71QUykoFOpQuVVzg==
Date:   Thu, 28 May 2020 09:18:16 +0000
Message-ID: <SN4PR0401MB35989CC2310D560D96E4CD699B8E0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200528091649.2874627-1-arnd@arndb.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9783d94d-ffe7-4049-7820-08d802e80dff
x-ms-traffictypediagnostic: SN4PR0401MB3662:
x-microsoft-antispam-prvs: <SN4PR0401MB36621D3DE7F7E75B2D075E789B8E0@SN4PR0401MB3662.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0417A3FFD2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gfiNb261fGSATe55wvpTBZSK6vMl57uf3rpto45UCDlFu9HXucd0A7lUwMI6ZQGpKVR3AcGMIpM4K73clRuQoCOQv/eSWta7xRR53ygAAPqZ8ICMUp0IrmyBeq1FsmYBOE/ykn+pVFfpwMZrgDTWy7VVtQCxwN79drZ4LdJLMId8nlQZJ2j0Gq3mw/smehevflOrPacji4bLgYYp553FCtEt8UCM6qPNcW3g5W/uctpVewP58cgFGI0XICazGrvPpjjCWlIIBwjQdtz41nrsTbVZwsXD45mVD9fAFI/ZV2NRVljpx8oxvYeK+v2lOPr6XvHM7FkXZX12YDPpH6Z+DA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(8936002)(33656002)(66556008)(64756008)(66446008)(558084003)(8676002)(5660300002)(4270600006)(186003)(66476007)(478600001)(71200400001)(54906003)(2906002)(26005)(19618925003)(316002)(110136005)(76116006)(91956017)(66946007)(9686003)(6506007)(7696005)(4326008)(86362001)(55016002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 4dDr2YneGg+rjfR0y8SThLuthPjehxmI8G3SjQBHFncxUwtemO9X/VnzK93lazNqObya5SV1+jF5blrHUII4HYZL0BqX93pPMRI1q+fuBMvW8NR1yf1p6YCbKiT9tzZ693pDgxVlQYdJTaTOSYFDQiMF9K1C8moeA6h3r9SGKSEIkIpyREBRwCZj55ttbmUGD+9OTIocIQ/4k6XuWglKkbMlKjJaU0KoGRRMkGJQExFFxmZh62mK+JAWntz25zMryLqMRoQX2Vp2Bz8MTj6lVN7X5fJ3WUQWCIcmLMx2bilcnHEjsmAAb0YVvbPycFDxgQtbabeS97J/t4/BdOc0ucoUtqB24H6orsV6IaB3rnctFm/9Ow9aFoq9HeOwf0XWTvw4uJeqw4hDiBozN0axZaQys6kZ5pqjC8nfzUDljdF9yc2V7t8qNK6focVRHh1nd7OUNzmWXfFnNxrHhfm9q2HXKqy9gANTMwRQ8sm/FjsRUS5DPjJZrc8tj6sUVTl7
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9783d94d-ffe7-4049-7820-08d802e80dff
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2020 09:18:16.2780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wNLmCc96n2dyCfRw1GN6Y+eKeOK/f/4qc4qiJer+yVZR1aFt9yudAZGSSJNqPc53LgDEvrenxiEzvubdY4ErB7tUklFHOOCcJYcJiEueS2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3662
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Right,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
