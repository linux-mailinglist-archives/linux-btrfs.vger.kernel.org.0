Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 480A5272960
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 17:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbgIUPE4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 11:04:56 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:64084 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbgIUPE4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 11:04:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600700696; x=1632236696;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=aQea6AJXp/i2Nb6f1Kwr2k8DV8poYnBXcdiQ28WKxEQ=;
  b=gwAYOKCIa1g9XAJFP3Yp7mCzy+WVVSz4Uslh2aBKs8cpwzlXP7+QHo0r
   wMZPVB4qMKIdET4Q3qj8OHyt/zEqfOZkgQZ8TZGV89P+tsqGstJ8HByDN
   Iu4UzGh0e0tZG0+M4uzhh8G6jQ2tf05twNrZdVxrdPYr+1Y65EFt3fm+l
   JiSNYy5Q7Y4nxS/6/3Ff+Les50S1g6xvDRbHNod+kqP7VPd4zBVH4xek/
   L/V7p6ikggI6LKivEeg6jM05cOXcqC+YmVpKwCBEj6aFe0yyTdL6DAC0d
   ft8HQsrQET6NJjf+rLr/ElK70oIpGys3AEt6Lk6FaYhmFH/mpJbray3j3
   Q==;
IronPort-SDR: 0+3j4AUhVv3p76/ifDiqi6utVvnIbPbhWXAsP2J/P3jCURFbQaXYkxFqpaZVVzNhQNbfeDeegO
 NshBK1M5euCTNP8Nll6NpADMcwTbjSfzoa9khoyL69qLHaAGTwhf5XmvHzB01vFnMUiI/4vnu7
 ZC/6J0WNPA3OTo545WdjjsrLywFG4t1C7BX/WusL+J+PuVvqE5Ie3nfvmQj3cz4AlrnJgi10s1
 pN3HVJjMgMCpO58NCuWUiuLiPFhTb91LMFgKt2HFFzJbG1Bv9qWHFORko8KIgq3yvtgGuTXN3D
 KgA=
X-IronPort-AV: E=Sophos;i="5.77,286,1596470400"; 
   d="scan'208";a="147913386"
Received: from mail-dm6nam10lp2107.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.107])
  by ob1.hgst.iphmx.com with ESMTP; 21 Sep 2020 23:04:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m8t7eY0Ez3+QEth20GKMqv/R62tNdWUDWZXVnG3pe3N9d/nuBrtvzd4/jVpWoOfPQ4wW+z1ylTjQYU1jltEZEWv3G3UPyzcncwP+rE4jqbgEtn425Lz8v/en2JreAfO5gjt8XziELb7ZbwV9pUXLF5IzWzRCiP4JG9P4opq9PR0vE5LqFSpslPhCPh1TY3y9e/Ya9c0tqKxfMuwYjVtypmaW8dX0woOOCcpRxJAbFQq1G+icp8FicZvAxRUMGIUxfPF2co7EeDozCWiCJU5BGb+Be1wAuNV20CHpcq+2KnGwpUqGILFSiycyIYmPeNfZYdSJMWBtVeD9PQ/TJ9oeGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMt9ikifDc9PGYlvB8TK14OltsH177gg31k8z+GYWrw=;
 b=f1kRyfjXWhZt6vyIylAKXKwMWXQNO7hWj42sXE2CQj6q4FZCQwxFPgm23to5iN5TKJAobJC5rufTaTkKbO6AladwJZaYKugV8Nv61deddeuqSz/hl+CmyVmuLYuN7YTxogGNdbLzTvHUlQUpniOH4lP8BzgLvUMrhW2WY7YH4bqkCEV77AZwgw1K1PjAhyBPj1gZ3qVqZLTIpqwjAGYGQ6Qa1pTsHwakHUXUgqDcbivAC0k72TsFqabQTXjbivUCea7AnkoKL/PFqIVG0s+x4pfWYu/dorRACs0Yif79v+DVmgMoaV/84L/4deRfbBywCvNUN5loIUJVqDLNVRQ7QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMt9ikifDc9PGYlvB8TK14OltsH177gg31k8z+GYWrw=;
 b=jTzx3WQvSEDn5tk5l4tYK4Mb70/xWpOl/PMhqK5z6uSSiFBtYRD9/bqaRmJzM+koqOut5VWXGa2BJlwobUalyfaHiAWWkXzlBL0N82jO+ru4HBSZezpWOGRLci9M8CmMeE3t8W2kk2yJXk++AOG8s81uvFntLejOJkQF2XyZUMs=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4605.namprd04.prod.outlook.com
 (2603:10b6:805:b2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Mon, 21 Sep
 2020 15:04:54 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3370.033; Mon, 21 Sep 2020
 15:04:54 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 6/7] btrfs: Call submit_bio_hook directly for metadata
 pages
Thread-Topic: [PATCH 6/7] btrfs: Call submit_bio_hook directly for metadata
 pages
Thread-Index: AQHWjcB/alMxWxqgyU2mqkxDkkV+rg==
Date:   Mon, 21 Sep 2020 15:04:54 +0000
Message-ID: <SN4PR0401MB35988E131C20F42AF70484FA9B3A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200918133439.23187-1-nborisov@suse.com>
 <20200918133439.23187-7-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3505e9df-4dbd-4844-c8c6-08d85e3fb27e
x-ms-traffictypediagnostic: SN6PR04MB4605:
x-microsoft-antispam-prvs: <SN6PR04MB4605C19622BEF7ECB9700D0E9B3A0@SN6PR04MB4605.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wWREwfqmPHu32VgPgIT9tXRcqmEeqbzZQr5WhPWdEBoQr1G4fl/KKREQAMI3FwWMiTdli6YWuslI3PqlVU3BpYlU17CLL1Z+yhPJMUjcAROYsbA7uR4EkOAg3+6uWrXRMz+N8Y0VyfwzWfwqJVPyKNCv5GACT4aoVhrgWFmpFnkGZbpqfbDnee5BQ7x0WH58O656h0+jlkcA08F3p8HEUEWJUzUcCGpAiOK0WaeiW3UKbzFpQ5RpiP5PxwJmcDCXFVBe+r/3gg+PpIshHAUEsiPCym+szKLRHOxOrA+sqffkYjTpxOOGZ//9ZVp0z1qBRrKNpDJjQdcWGn+YEo0C6I7+3y2pVLDqKGiqfBuIHvESGupJPS1RjjA5U7zxqsnc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(26005)(86362001)(316002)(76116006)(2906002)(91956017)(186003)(7696005)(4744005)(52536014)(8936002)(8676002)(9686003)(33656002)(55016002)(5660300002)(110136005)(66946007)(6506007)(64756008)(66476007)(66446008)(66556008)(71200400001)(53546011)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: mutsdfjN+L4yik9Xse1Kc2ywmevpGXzWEMzfW6Faxh4+jM65gUl+QbGuJLBu47XEkoyAhFj1+3qu8TYn7YgJNyXrLpldE1aFbWOhpHNMOYiIcg+Y1EK9kFpx/B4UUKKQXOwdwADIpoyETvwhcms4Z6XGTdiVMWltiHLQGlDnQdCV9cIVQplo+Wc0cEhDD96vBZNlWUroJ0zzlTzfX9FkH/yvYSAHFDkiOcDBsrMtZdUPPzEGfUqeqB1im2KbbGnPLngaX9t+iEfQVT/loMW6PT7U9ZRuSy6H56lt/QZ1WNRjEFJRryIJwsaYRAjL+7l2JRe2FnzTB+LnkGzW651zOQsW8caADW7y6YVOv69go8OOahHv9qUGKdmrdQRMBv0CkBPixxl3oC2AoPHMPPrYztFV36PkbcY0HoazI8m+3mO1GyMy48O3ecffRenDcX+PKGru8vg/hffBKqoqMO45ht4P9RaK4EsAyxlnssWfdqOMyvzCT03n0SuBiraDZXsYJZvMf835hBolFMNUsgcMiZg1WRCHhd7QsE8b+A/qCxYSE4xNGxnb0MdQ8Qh6qt6SVBSnbtOx21bmpPBKPK6HiOt1FP/BticVzMHksao7V/9+SNN1nLM6zFgOt6XM/riIrsMUPGJLwJ3Nc419lctbJQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3505e9df-4dbd-4844-c8c6-08d85e3fb27e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2020 15:04:54.1880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k0tCYLPDzfQELxuodGUvC+Oo8Qp3PaICCP2hSVGvOk1Yj1kIzDrCrUwr3WSjCiMHyBoAmw3LI8vUaqtsgeqNvD4vaU9yVombHAF0qUuKAok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4605
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 18/09/2020 15:34, Nikolay Borisov wrote:=0A=
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c=0A=
> index 8cabcb7642a9..4a00cfd4082f 100644=0A=
> --- a/fs/btrfs/extent_io.c=0A=
> +++ b/fs/btrfs/extent_io.c=0A=
> @@ -172,8 +172,8 @@ int __must_check submit_one_bio(struct bio *bio, int =
mirror_num,=0A=
>  		ret =3D btrfs_submit_data_bio(tree->private_data, bio, mirror_num,=0A=
>  					    bio_flags);=0A=
>  	else=0A=
> -		ret =3D tree->ops->submit_bio_hook(tree->private_data, bio,=0A=
> -						 mirror_num, bio_flags);=0A=
> +		ret =3D btrfs_submit_metadata_bio(tree->private_data, bio,=0A=
> +						mirror_num, bio_flags);=0A=
>  =0A=
=0A=
=0A=
Hmm we could even turn this into a little helper calling either=0A=
btrfs_submit_data_bio or btrfs_submit_metadata_bio. But that's just stylist=
ic=0A=
preference I guess.=0A=
