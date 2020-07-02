Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B80621245E
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 15:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbgGBNQL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 09:16:11 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:33064 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgGBNQK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jul 2020 09:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593695769; x=1625231769;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=CZcoyrfoCsRZZ5XwrJ4BpXSwwH1Je15jvsCjJG8zvyE=;
  b=G9F6/9vyWw6ra1yDeY9OapocyJZSSfxEqHbSG/f6pCSQanTj9EyLJhXY
   xTztcMQile53Iqy9+Kc+NcbNt74gi5oKQw1M6OwORt1ig/MKnMjGwRl0h
   sZY7s7iL40CKfm/eO8WUumh/JhD5cVa55R5TmlcF9hUVgZeZ86BrQYYGm
   eEoycdyeJRtZ1Xeea+1I8btqyvEUF0jsE468TSAqFpfSvIXF5HSRG0z31
   9M3HuOsHfI9L2ZjccFqbt4DIXmY4sJEvWdqnAtaYMTi+J014aZlwR61xm
   oPj1ofPRM5KgX4w42TH5IokbbAAhmQ9Kdw+faYLpY4BQnV2wMGTXEnKX9
   g==;
IronPort-SDR: OC1H+hw5Hl7u8zDVcaaIeO+abrucH/10Q8cFE/GIhKrAJGTbzkT2Ho4lFGAF+Coq6XAg/x28sF
 EnJV22ZOAxrysFQoHHgQ0uqdaC2IsfPFsNJ/sZP752e15qMLlZRcDWgnxjQVRohcTrAgHQ6fEM
 QLo1BN4GXj92GjLIedns7DaCrw0K4fllgQl8uGlhpz6sPle7Dc5fvT0qbmq3895BqcuCjZuw0V
 O0V75pUUSK0F7Cdw2iLJj3kPU+f/F9eSrKNpDDgOjvwHPP5m4z2qm2tItAXRo+VeMI6tF4c8s0
 A4A=
X-IronPort-AV: E=Sophos;i="5.75,304,1589212800"; 
   d="scan'208";a="250716339"
Received: from mail-mw2nam12lp2044.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.44])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2020 21:16:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZg/V9Ai6ZmShciTz7dmm3ESeuWr/eUc4GiuRmZIYJSs/I41S6usnvIBXA3JLXWVaC9U98T4rhiH4+cOCgE95B8xMoLIGroimJZkAmdaeTmowmVKat00i9e+asvKIHHk/3+1D6Yjvuca6BpGpxB7mSh2x9iFI0UFpWQND55EdWlPerSIlatfC7H/ayRUYqMQktur6Vgvi4QnqNhedefPjAP6n4IMcYl+aloz63RHdgfynXaqlxbhmCB7bxNDN4i91yyuXfniKL4xea4Ia3OUVylgOOVcavqJbFdvhKmEt0yCDpYZMQsH9S7kWvtg1Vfb7kHpumv27NzxLdJMisa7Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0YkngLagzh9ozbAwJukcgKppcReCZWFfPyhvwrQoyo=;
 b=ApvcupKNdg2EUN6IfTJpw/tMWOM4VHaylY/4n+/Ls5xkkx98dMTKezXaCksqDftC+vDYSRVyEF8OEw7xWAWNJoqvRJyjrOuDn82xodyMMHQ1hvWDWNdPrLoahFHxAZivBKKn3mBAq1Xbh9/eCl6uL3o1xAqXPSGI/EfPbNHgrMi7in0G+CN3uXhAdkHFASBoh3miSjwh3CdElqMUhb/zXiHl9cW449TRHNzjsbWPFPFV055S9Z3BVujdC9lFuIHkiiP/YI09Ol8Oc5mPCITqWxDM0qWQF6EWwBTve1+2Dgb8BKeARcd02bTf0eSRqM2Q9ijiOPNp8KXOfXQ3s3hEyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0YkngLagzh9ozbAwJukcgKppcReCZWFfPyhvwrQoyo=;
 b=fOGQXctIDylTguVtf/Y75RFezpdg9P2ow6ELjQsTeEU/cC91o5U+WExu3fdWrdHVfZgiUdDIJvg7OgwYfeRh26Q+j1XJbX7+VQelO7OpDsaqRuzz/7GHRG71OAEpqFDNVpolzVp6nwJj6ZTtXPRpUiaN+kwxk/onJoGKM6qx0OQ=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4782.namprd04.prod.outlook.com
 (2603:10b6:805:af::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Thu, 2 Jul
 2020 13:16:00 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3131.036; Thu, 2 Jul 2020
 13:16:00 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/8] btrfs: Record btrfs_device directly btrfs_io_bio
Thread-Topic: [PATCH 3/8] btrfs: Record btrfs_device directly btrfs_io_bio
Thread-Index: AQHWUG301ixMm7XyyEGXGPN9HIIESQ==
Date:   Thu, 2 Jul 2020 13:16:00 +0000
Message-ID: <SN4PR0401MB35980F9EDF91AB6C537036AE9B6D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200702122335.9117-1-nborisov@suse.com>
 <20200702122335.9117-4-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 05b7d472-b1ac-4d24-16fd-08d81e8a10cb
x-ms-traffictypediagnostic: SN6PR04MB4782:
x-microsoft-antispam-prvs: <SN6PR04MB4782151A9F093D47C2DB9B379B6D0@SN6PR04MB4782.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 0452022BE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KwU0+Jnx50dbRkOwk2UqyT3yC6TXfQPfaR2exPfp/od8ox/oNZNR/4sD6DWJgSHYjTbbXbYJFBmGRcjK3VVWUsf1wFZ1lrHVsbOn/FHAZZvcTZuGmrGrMaKNMX0750DyW5YcIdC1a0xBquGgkdjNEK6lzhKjkOIiNUGnpUQjIUvNaUa61uLDQQJpSfk/Qw/GCZhTxPaFQmyBkcRbQIaC9DEI3MNS9zLWBwO4DhtmfenlkPm9fJe5YO+HsHM5+Q0dwER727pp3r8zX3yd/sAGdkZoK79viyqfqTdofW9fpCG0xPKitYRG3jWHeRlFFraCdJMOceX0Mfc1gaMFxQ/Bsw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(7696005)(33656002)(9686003)(55016002)(8936002)(26005)(8676002)(86362001)(64756008)(66446008)(66556008)(53546011)(6506007)(66476007)(71200400001)(186003)(76116006)(91956017)(66946007)(110136005)(316002)(5660300002)(52536014)(4744005)(478600001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: KFyfAqKyasg9vmx+Vly+sS49PiPxfHS8EPy+tWhl5a1pM05nCkgOTrh4D2cPcDSZhr1cXKwGAQaMgX0AY03t+8ImvrTevgu1OHglnzChL2mxVzYjs+EbxibguM6h3skIIO3Gn8QWK8pP13LrM8JI7wVprzFwF02PiaVEHEc8YDbO3TEjhcc1BOgGngsAwHJmHuO9MKKgLKyE+3oGaUEdBNp4D8vyO3YMFzC346TazMT8DMU15VcOkRxUwuQZmKD0X8+RRT74tZM6ZZ9QrhSTY2aL1k+/B/2ziitO1HACMiTjONlDoRXA3Gi75nsG6AFUiC8Hi/jVguwAs1Tn8K8D7O6b/8bfjFO+8T5dijH13S9A4kcAJZCuYPTMLI118srXg/dUu3kn2AlbdmFO6j3ZP4cxOikEb8OTqiQhcwJYy1BJUENwblmYw6cbab2gymkds71MITvJ5Tp+/E6+JY8CmhaB5K6iCJHE2oRoE1fZ1cqWbtxzcUAw1yyWWbgi+iUa
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b7d472-b1ac-4d24-16fd-08d81e8a10cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2020 13:16:00.7281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ALyVIGJUdAGNYKuXrkWPdFFQ3AbbO9wDq4ViaiXNKdhXeaLfmG1XhPSUAMBVQrbPctNcDuv7naI/B7vkMlHDaV4GgUNg5BO6tpPj4tvn77g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4782
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 02/07/2020 14:40, Nikolay Borisov wrote:=0A=
> @@ -6319,7 +6314,7 @@ static void submit_stripe_bio(struct btrfs_bio *bbi=
o, struct bio *bio,=0A=
>  	struct btrfs_fs_info *fs_info =3D bbio->fs_info;=0A=
>  =0A=
>  	bio->bi_private =3D bbio;=0A=
> -	btrfs_io_bio(bio)->stripe_index =3D dev_nr;=0A=
> +	btrfs_io_bio(bio)->dev =3D dev;=0A=
>  	bio->bi_end_io =3D btrfs_end_bio;=0A=
>  	bio->bi_iter.bi_sector =3D physical >> 9;=0A=
>  	btrfs_debug_in_rcu(fs_info,=0A=
=0A=
Can't we just pass in a btrfs_device here (into submit_stripe_bio() that is=
) instead of dev_nr?=0A=
