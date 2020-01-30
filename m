Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D43514D99E
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 12:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgA3LX2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jan 2020 06:23:28 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:14001 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbgA3LX1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 06:23:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580383407; x=1611919407;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=yE9ICOByA422uYaDANHs6X//An5K/y62TjJ5NCFsrzw=;
  b=QZ2iL4eTFnxnojxGz76k8WXV68Gha8/VPG4kk83MBOvoFlOtpaul3wki
   TEQ6r6WZ+sumEyYLqWB2oGymUy573o2kwzGaDp+YV5AmIx3YTKOqZgxAL
   cJ8TU0dzreVrbD8FaAMp4DTc38Guy/zbMNysVN057ALrcXrFIjvNTu+pG
   K2vdU4tCFvghc1vVujoTsPxoYH/EFg4XfEoNOlj35n01TrcB5DQ8LsGsO
   ENudi7yfr7maYzFnkwStluipqesgF2V7+ugo/xKt+CiW9FP7TL04FZaZw
   necda7vgENLSnTuU/vz3BjhZU+BR6IkfKivc8ELaNX/Xki/9DLgd27Uhw
   g==;
IronPort-SDR: N8VpwJJ3KIBHkcfFQEGoWFOHhXnYiQANVAWjTDyIPq9VCaMHBsat5lgTaSxRvuXsbcZcMZwGqQ
 H3aS5ULfhWRlwz57Tp7CnAb8NHJoNEFgUzHRe9EX3WdQNV5U8q3xIFkSTUTN10JO00nogLNiww
 +ZnHGFBnRx4c/s3S+zdYKdnbaTijJVccfFC2XR/paoLDNeRx/KqXRi2pyV5LO8MxDHJ+aKKH9v
 ddRngUXuCvpXzumhUEjWF9RUTsmQ/7GtdDRbAviT2QRR5WyJpNbMDTthZtuARDS+IJ8tnMB6cW
 Hpw=
X-IronPort-AV: E=Sophos;i="5.70,381,1574092800"; 
   d="scan'208";a="133095738"
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jan 2020 19:23:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVPT3rnF7uywo2Vjg8ksiAenNwMt3+DgudpI1x58mgcDbhcR6r68ks5ScK0JRMOGlX39m0Z3v3sGHt/IYY8wo6HlQKpZoIHnaod27WhfBK0va3SoKpt8sb8UhIZ25ItECOHn4tMGMpULKFrRytbvubgQbCqFvYG+rjXrWk9n8XKynhIBJj+mM1a7UaDrHn94w98FTZRVikWzgutM4oW9n/xw2m0IqjIXRaHWiYoE5gTF7x2TF/2LT4h1J6dtO9gfnli91dkV06/2OG66ixFLuMUQ35QJXyy8q/XJJFlQies4Xcj2HgwYXi44HWwZNIzvR2t6kYY3JXAr17Q9K74MFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3Psc0pWN48A8I6zaE11E2FQ5ppGGC0zx9BtEdaC2bs=;
 b=UdjWdjjjRO00674HVKSEvo8z7vH9+YuMe8/F0nH+/9w9rYBshffbtK81F2GL5XAhawUjWDt7Lsdou6aSZbUBeqwfUEkB309hFB5Bm+9DqCGuD7YsI9yf7jPpE322Bib97GZI07tfLXKUqvW5ORABHpAo2WtB54tnEqmKJZq6HbijRb4zv6RY0Sz5ZEXTYLeRwmZbaPxHc6Fmg/cjIL0ecjmzTH2INMP5NuGKP4qTJKkAh+RDphiVuWkxW/3NEUNiTip3SGo1ThDTQwNCrfJrASL+8ISyUtYvSXl3FAwbpJ6Okd8AqSlpdd2pRK91q7IruRQmJOzpCjgOI9M5WO3qBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3Psc0pWN48A8I6zaE11E2FQ5ppGGC0zx9BtEdaC2bs=;
 b=QENbRsYNo23ab/SVs+ys3sqVGzHdaPF/HTNPqBZkdFe4XQJF+y3nEEwC6DedakS34PSiIO05Y4pp//s002UykXHiYwdbQtgFKhWkM9zJ/RBKs92LFj5hbu7vLfTKPyNXEwAylsar5+uLZN48HafPYciXjqKSe90mCFMSSXTYAoc=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3534.namprd04.prod.outlook.com (10.167.133.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Thu, 30 Jan 2020 11:23:24 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2665.027; Thu, 30 Jan 2020
 11:23:24 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 0/5] btrfs: remove buffer heads form superblock
 handling
Thread-Topic: [PATCH v3 0/5] btrfs: remove buffer heads form superblock
 handling
Thread-Index: AQHV1SrKCplaciq1OEKao1x65qqI1g==
Date:   Thu, 30 Jan 2020 11:23:24 +0000
Message-ID: <SN4PR0401MB359858CB7DFD0082B44D57379B040@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200127155931.10818-1-johannes.thumshirn@wdc.com>
 <20200129142526.GE3929@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4e2f72d9-e739-4dee-dcd6-08d7a576d221
x-ms-traffictypediagnostic: SN4PR0401MB3534:
x-microsoft-antispam-prvs: <SN4PR0401MB3534B1745772174DC54A5E4C9B040@SN4PR0401MB3534.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02981BE340
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(376002)(136003)(346002)(366004)(39860400002)(199004)(189003)(2906002)(76116006)(53546011)(91956017)(6506007)(4326008)(54906003)(66946007)(9686003)(478600001)(26005)(186003)(4744005)(55016002)(316002)(6916009)(86362001)(8936002)(5660300002)(7696005)(66446008)(64756008)(66556008)(66476007)(33656002)(8676002)(81156014)(81166006)(52536014)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3534;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QzOXmqWOze0BjgeiYYodvjFUhN1XCW84mj5ZCOc50n9lB46MHQFZBK5+gQRWJX/OjstW6eNVet+bRCpuypSpUk1Kky6nPQWRERMP1eoEKrG7aziJfzsKbF1WWCBqYlBkrY8+sqQQN9JZOpFi6HXS7DNyMDRkh+SjhrdDSjt1OXg7hq4lLz9HUQWCQDxkqaWvJzxxuHXhc6k+axWBFIuFGkHTFcK6wrDMONY1IgT/vY8DApHE+dR8s/+jCllh7gQo59+oj0Tter00CBHwSq6moCFM29hqhyuYir8er6SM93Y8QGTjrowouGKgNyDEXZLjcrs96wfQEu9OqjFngLNNQsG+WVH9n+hUGsWuKjpO8+eOo8xQkOjYgwDt65iAp8JXm2/zIBBj5YXsUBAykDXTZWErxBy3rvRaB14iQSkaa5raOI0+2vdykWuO43HXCoLU
x-ms-exchange-antispam-messagedata: UgH4KrDF9IigJO+11TbzyzYzHgcV3inKjDsH5ixdQTwAqPHNFqXDJUKZC1+vBLAKqmfJ7AqJBQs3QIt92enRnjHkDWxmTnsW8+HYjuGZFp+ruTWVC4ReLUdMhZd8g3NBLi8e0kzRrXx1lOQjvnfiyQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e2f72d9-e739-4dee-dcd6-08d7a576d221
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2020 11:23:24.4514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b967sBBCTB8R4gIzNzabPsR2KUZJhGvn63/0hMPxeRu0t4DV+w/ZGq9MH7zcgVydwmmJDvKTm3JnJu4lw/xMLVtu4L7bKBwrQl1DSa7R4qI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3534
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 29/01/2020 15:25, David Sterba wrote:=0A=
>> Johannes Thumshirn (5):=0A=
>>    btrfs: remove buffer heads from super block reading=0A=
>>    btrfs: remove use of buffer_heads from superblock writeout=0A=
> =0A=
> For next iteration, please change the subjects of the two patches to say=
=0A=
> "replace buffer heads with bio for superblock reading". Thanks.=0A=
=0A=
=0A=
Sure but with hch's proposed change to using read_cache_page_gfp() this =0A=
doesn't make too much sense anymore at least for the read path.=0A=
=0A=
Maybe "use page cache for superblock reading"?=0A=
=0A=
Byte,=0A=
	Johannes=0A=
