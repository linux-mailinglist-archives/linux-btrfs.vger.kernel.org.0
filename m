Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAC937E85
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2019 22:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbfFFUPL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jun 2019 16:15:11 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35744 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727082AbfFFUPK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 6 Jun 2019 16:15:10 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x56KCw7x014690;
        Thu, 6 Jun 2019 13:14:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=uFxS+HpbQdPGuyT6DMQGXVowWYrSTxP801cJs+y+7PE=;
 b=iTUYgu6TweW47DLGYfU7MsGvhT3JAGxf6NtshBOvsnWXjIBMVLhcNs6Eh4fok3BxQMgh
 7vHSis8lo86bI6eRx5eO2wVKc88bjVhfmm8gqr8H8VWnjS18K2RYtJQzwRYioHyXyEVC
 FYxfe1bQ5Le+6vnUB68qADnxki+kkIAK0SI= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2sy0e8a4ae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 06 Jun 2019 13:14:40 -0700
Received: from prn-mbx01.TheFacebook.com (2620:10d:c081:6::15) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 6 Jun 2019 13:14:38 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-mbx01.TheFacebook.com (2620:10d:c081:6::15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 6 Jun 2019 13:14:38 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 6 Jun 2019 13:14:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFxS+HpbQdPGuyT6DMQGXVowWYrSTxP801cJs+y+7PE=;
 b=mwdKQ72rcvWIW66SxyPUtEwnImhYcVTPGfk/8CKAPFJWbi3wPUCe2p3MgzgGjuV72mgwKsBMSDgZ4xFlTJ1bVvo7siBrpc++HLdCTG0ci0CJlfwTRUqi6e7O3EeMaypX2Oaxw7AhFELkxoFLx8k5Vy56RDe224jhdaCR167+Iis=
Received: from MW2PR1501MB1993.namprd15.prod.outlook.com (52.132.149.157) by
 MW2PR1501MB2076.namprd15.prod.outlook.com (52.132.150.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Thu, 6 Jun 2019 20:14:36 +0000
Received: from MW2PR1501MB1993.namprd15.prod.outlook.com
 ([fe80::ede1:f275:2869:8156]) by MW2PR1501MB1993.namprd15.prod.outlook.com
 ([fe80::ede1:f275:2869:8156%7]) with mapi id 15.20.1965.011; Thu, 6 Jun 2019
 20:14:36 +0000
From:   Nick Terrell <terrelln@fb.com>
To:     Vaneet Narang <v.narang@samsung.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        Maninder Singh <maninder1.s@samsung.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "joe@perches.com" <joe@perches.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        AMIT SAHRAWAT <a.sahrawat@samsung.com>,
        PANKAJ MISHRA <pankaj.m@samsung.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: (2) [PATCH 1/4] zstd: pass pointer rathen than structure to
 functions
Thread-Topic: (2) [PATCH 1/4] zstd: pass pointer rathen than structure to
 functions
Thread-Index: AQHVHKR2hpo9a2qp3EKL1BeVjcuANQ==
Date:   Thu, 6 Jun 2019 20:14:36 +0000
Message-ID: <673B6F9E-5BB7-4EB2-9E6C-A44E09367ADE@fb.com>
References: <20190605143219.248ca514546f69946aa2e07e@linux-foundation.org>
 <1559552526-4317-1-git-send-email-maninder1.s@samsung.com>
 <1559552526-4317-2-git-send-email-maninder1.s@samsung.com>
 <20190604154326.8868a10f896c148a0ce804d1@linux-foundation.org>
 <20190605115703.GY15290@twin.jikos.cz> <20190605123253.GZ15290@suse.cz>
 <CGME20190603090232epcas5p1630d0584e8a1aa9495edc819605664fc@epcms5p1>
 <20190606141019epcms5p1e9c394d2c2ef37506c8004fe48edd29f@epcms5p1>
In-Reply-To: <20190606141019epcms5p1e9c394d2c2ef37506c8004fe48edd29f@epcms5p1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::2:d31d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e05348c2-aaad-448b-6171-08d6eabb98d7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MW2PR1501MB2076;
x-ms-traffictypediagnostic: MW2PR1501MB2076:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MW2PR1501MB2076D0452B066B0CD3E0E074AB170@MW2PR1501MB2076.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00603B7EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(346002)(39860400002)(366004)(396003)(189003)(199004)(36756003)(102836004)(83716004)(6486002)(14454004)(53546011)(6436002)(6506007)(229853002)(71200400001)(6306002)(71190400001)(53936002)(6512007)(6246003)(33656002)(5660300002)(476003)(8676002)(81156014)(81166006)(46003)(54906003)(99286004)(6916009)(8936002)(966005)(486006)(4326008)(11346002)(2616005)(446003)(76176011)(7416002)(25786009)(305945005)(7736002)(316002)(6116002)(186003)(66446008)(64756008)(68736007)(66946007)(2906002)(66476007)(82746002)(66556008)(86362001)(73956011)(76116006)(478600001)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR1501MB2076;H:MW2PR1501MB1993.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0Ho0cIqxZ0tDcOjYbG4ND7gqgsV+/JPgqOotwFq58vGBfEMwtI23QqYuPjQZ0bnhkaURqrD+RFOoR1LiaEteOyjtWEQSUR5w8p1jgR6OApW2zpr1/kyXB3p72agRZB4jxPYMIxBMzMXXdkFnv82xQQbkxSQkAz5E1Wx+0z/IOgnuIPnbcBwn11AVvbUV48Dho7irF+NqesErsNHAaHJ4bY4zOiSvy6o5/tzAatHhy/9Me4RzanE8HPHElG2iarrJ8CVZfDHpyRzwP9Bokb+t7dbHe+h/Ei6s3hRRyQrsnhHYjRLFa+yhVeJzxSA1mXdBTAIVupdC7tPKH2sNLlS5DqZ9xMY4NUK6C6aDLjnzwA8X/iws/XNtSBhMCGAxpx8knf2eyU9cgxNhiS8fpTl3ToSavjGLlOKEAFdm/t5Meuo=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F6236908BE37D04F92F6F255008B1A8C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e05348c2-aaad-448b-6171-08d6eabb98d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2019 20:14:36.1471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: terrelln@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR1501MB2076
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-06_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906060136
X-FB-Internal: deliver
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



> On Jun 6, 2019, at 7:10 AM, Vaneet Narang <v.narang@samsung.com> wrote:
>=20
> Hi Andrew / David,
>=20
> =20
>>>  > > -        ZSTD_parameters params =3D ZSTD_getParams(level, src_len,=
 0);
>>>  > > +        static ZSTD_parameters params;
>>>  >=20
>>>  > > +
>>>  > > +        params =3D ZSTD_getParams(level, src_len, 0);
>>>  >=20
>>>  > No thats' broken, the params can't be static as it depends on level =
and
>>>  > src_len. What happens if there are several requests in parallel with
>>>  > eg. different levels?
>=20
> There is no need to make static for btrfs. We can keep it as a stack vari=
able.
> This patch set  focussed on reducing stack usage of zstd compression when=
 triggered
> through zram. ZRAM internally uses crypto and currently crpto uses fixed =
level and also
> not dependent upon source length.

Can we measure the performance of these patches on btrfs and/or zram? See t=
he benchmarks
I ran on my original patch to btrfs for reference https://lore.kernel.org/p=
atchwork/patch/802866/.

I don't expect a speed difference, but I think it is worth measuring.

> crypto/zstd.c: =20
> static ZSTD_parameters zstd_params(void)
> {
>        return ZSTD_getParams(ZSTD_DEF_LEVEL, 0, 0);
> }
>=20
>=20
> Actually high stack usage problem with zstd compression patch gets exploi=
ted more incase of=20
> shrink path which gets triggered randomly from any call flow in case of l=
ow memory and adds overhead
> of more than 2000 byte of stack and results in stack overflow.
>=20
> Stack usage of alloc_page in case of low memory
>=20
>   72   HUF_compressWeights_wksp+0x140/0x200 =20
>   64   HUF_writeCTable_wksp+0xdc/0x1c8     =20
>   88   HUF_compress4X_repeat+0x214/0x450    =20
>  208   ZSTD_compressBlock_internal+0x224/0x137c
>  136   ZSTD_compressContinue_internal+0x210/0x3b0
>  192   ZSTD_compressCCtx+0x6c/0x144
>  144   zstd_compress+0x40/0x58
>   32   crypto_compress+0x2c/0x34
>   32   zcomp_compress+0x3c/0x44
>   80   zram_bvec_rw+0x2f8/0xa7c
>   64   zram_rw_page+0x104/0x170
>   48   bdev_write_page+0x80/0xb4
>  112   __swap_writepage+0x160/0x29c
>   24   swap_writepage+0x3c/0x58
>  160   shrink_page_list+0x788/0xae0
>  128   shrink_inactive_list+0x210/0x4a8
>  184   shrink_zone+0x53c/0x7c0
>  160   try_to_free_pages+0x2fc/0x7cc
>   80   __alloc_pages_nodemask+0x534/0x91c
>=20
> Thanks & Regards,
> Vaneet Narang=20
> =20

