Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 724A31AE431
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Apr 2020 20:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbgDQSBd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Apr 2020 14:01:33 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:20656 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730278AbgDQSBc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Apr 2020 14:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587146492; x=1618682492;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=T5cdXRqj0Ur9bIAA7iB5ILgmF3ZN5qUT2EYABznzZA8=;
  b=YOpARkOyuuvoXqDwDZHftPMV+Vv9WheGj1csGhT1TkZj9FKXANx8ma2Z
   e2Mj4OuXy5UAOuSX04w8yDqmpX5bxtxtH+qJdPqb4UkKuxqrz4u8WA2Qp
   IAUpJjEepE562woO9MUMhl5WHPMvVX4gCO124Q5/X4/7zAF14BwkzOTXW
   71gdSnhgPbiy1GmE7VS8icZNRj61Y7g52Ki2ctu43N1N2Xxdf4vBfV1Ly
   fifc/t5XyiVhy7uZqrAkzQcVfi21TSMjqLm5qp9PxJq5ZMmqOuHKubTOd
   1MQXq8t7ZUqcxQF3Vz68ZrpVVB3Ycl6k20upa0u/m43t8xG0OkuZTV8zk
   w==;
IronPort-SDR: 24wcvnB2oLPgyHMZs6djldmsB/ehsNKd3fvdmONR1a0+aS83A/iq0L/xdhEJgUEnha53I7wRRr
 f/s2n+9AziqkyZScUzhDL0lHEnf6sPXCQ5DqxclwgPjgOOt+Y7C2lVVbSurbdnosxkHxxwoQZH
 KhXWUUxf/lMc3KO4om5Afdeuql/t/wjspFTKG4WkMqfWqx/l907i7R0dP//ttf10C8hzAd7qDK
 nQJ9usvbS+KcpAUA9iJASHBKlo9dEcGdZ+ja6ygzJKE3yMlT29dnunXsOsc3EBgiDCeW5iyS2a
 p6k=
X-IronPort-AV: E=Sophos;i="5.72,395,1580745600"; 
   d="scan'208";a="244253709"
Received: from mail-sn1nam04lp2050.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.50])
  by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2020 02:01:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gEsfM/ylNEiNuUcsviVddvD4DkYIbY30MdyhDjr7ApY0swim8YNTP2xEOaFcdQiyPsoV127DSiYGVVgq1R4WzHQLF8tQwm3EKTG5ujQh0ehs1zNYcvqzYIkQUIMdPN9tuNdN69FIrpf0sKEK7k7painfaf1QD+cLd214CORJbOmSWSuiraJIhtyE2TLzZGcyVrEY3WMYZ2JHr6acBSXrk0ezYHhA/V8KnfLVuJsFMKb8B2uQfS8lYyAFqhoACA22yiGSzTQhF6nKAKe3FJxfvZvLmuzp2aqSrVvHCTEDDl+Rxw6ULonA5M/0EewArDlwFsZypnQyz+6iddSN8roy0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3g0JiFOk69zhxsHNUq1qTl0aUSCplDJzVVMb/qAO3/I=;
 b=M+Xx2usiYktnf6pLm/IQfDQ9WVsyZuFQiKwckFWCihqm5683Hbcvjca8G6pImH5/5VBzvErY3X44hRaoTC8BuXs50j5Mk5EYRSshoq9r6+NAf+wwTr3rKquTvZdy1lqGymSe6oYJpk7T8zeY/Krd1yrdLuEoGV0H5lpmqz1YH4ix/rpHpXyH6oigoY4KJXHxw0y1ynKo8ilDdiOPhS27p7CEqm2SauBqdF1y2aEsKqPUeoyzWD+yySiJZamsU6Gd0rgxLrlA1j5TOHTAjDbVZgiNLrA7p/faX/kc4Y61RbudSIhv2o0RV6Xki2sX/Vz2nbNz0wdEv9cHf/CfklNqMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3g0JiFOk69zhxsHNUq1qTl0aUSCplDJzVVMb/qAO3/I=;
 b=FpIs983NVKdutFVgFilp+xPqA3nBuAZHqx2K0a34ZjZnjPTOtmFP26nafooKEEGNK27QviENXt8yrFrHOrOsfgcMDF6wMe75s05cmSBaoAJJw7pr59LavJILltt4/L/7swwnuxjpz3eZAJvGyGqWMcnaJT1+m6RieFTjTfqHuiM=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3615.namprd04.prod.outlook.com
 (2603:10b6:803:47::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Fri, 17 Apr
 2020 18:01:30 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2921.027; Fri, 17 Apr 2020
 18:01:30 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Omar Sandoval <osandov@osandov.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     "kernel-team@fb.com" <kernel-team@fb.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 06/15] btrfs: clarify btrfs_lookup_bio_sums
 documentation
Thread-Topic: [PATCH v2 06/15] btrfs: clarify btrfs_lookup_bio_sums
 documentation
Thread-Index: AQHWFDiq/5VJodd8NUiMb9YAWH+AMw==
Date:   Fri, 17 Apr 2020 18:01:30 +0000
Message-ID: <SN4PR0401MB3598FC2F3845EAF40112AF7E9BD90@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1587072977.git.osandov@fb.com>
 <51f9f9b917ded1057f1d24f7bbf7546492f3ea98.1587072977.git.osandov@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 16cc39a0-22a5-4705-edbe-08d7e2f95b88
x-ms-traffictypediagnostic: SN4PR0401MB3615:
x-microsoft-antispam-prvs: <SN4PR0401MB3615B398C7462ECF8E69AF3C9BD90@SN4PR0401MB3615.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0376ECF4DD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(346002)(39860400002)(366004)(376002)(136003)(396003)(6506007)(316002)(76116006)(66446008)(64756008)(91956017)(66476007)(26005)(53546011)(66946007)(478600001)(8936002)(7696005)(81156014)(2906002)(71200400001)(86362001)(54906003)(8676002)(66556008)(52536014)(55016002)(110136005)(4744005)(186003)(9686003)(5660300002)(4326008)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7wXzBnQ7lR+uq+zCjJnOzcYqqnpxDoodwUHUu0o/Bi1EK/ukO6iF53CR5zzZ3lnaYmbyc5lu9xqAlL+ryGISsFjJdieJcVRIm20SleI75HGMNCCU7gEo5lfIq15D8u004Df7tWGWKEbJF2tcSG9XAFQ97t2DjqgmiBPDgVJKipQqxQ+35Ko5q614hjXC5gCgBySTqU513+KfEk7a/FAgCX84qynobt9OFrcSGBkmr2RE6sNK7W55Vr5U4nQwCNt5PBX9yr6X/4jI1bXwQBPisjGou+Ro0xZBOsho1UFsSC+T8OIi+YYGIXmyE25h63VZEcx/3wiO4RQE8IMcA0uY+rBARKv7ZN5YVeVfxrb30NCtCsd/vrNumpAibro8cDP1i7qURx6RA9vBFG3Q9oQFjV7oQlEd1MQHYBQw6lNB07gDiWwZ0j2DZICkqytZ2+Yi
x-ms-exchange-antispam-messagedata: btIuHsciJ1Nwyxu35lwuayocULKjuvVfHIN8X1sEl0a3qn5GzQbOc47RPkcze3rr9M8SLvlN3f3ljnnGHlR4zUN622xVKEtjTv0aIKaDOHVkH2f7Yt9HgxSi1nNvG1gbItq9LdkIa9TtnLNlkNdRSQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16cc39a0-22a5-4705-edbe-08d7e2f95b88
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2020 18:01:30.5875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x6T/8feYe8LUkFJ8LjIWn8V5Nvd6EbkISZNXCU4iSHYYhW/2Boi0FMZl1/pQ3DXngZjyuPAdtruXKYxTH1Z9VRhPvPBbaU3Iog94W32cCEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3615
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 16/04/2020 23:47, Omar Sandoval wrote:=0A=
> Fix a couple of issues in the btrfs_lookup_bio_sums documentation:=0A=
> =0A=
> * The bio doesn't need to be a btrfs_io_bio if dst was provided. Move=0A=
>    the declaration in the code to make that clear, too.=0A=
> * dst must be large enough to hold nblocks * csum_size, not just=0A=
>    csum_size.=0A=
=0A=
And also reduce the scope of 'btrfs_bio'?=0A=
=0A=
Otherwise,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
