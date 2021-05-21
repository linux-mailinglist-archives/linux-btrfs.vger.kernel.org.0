Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B116138D04C
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 23:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbhEUVwa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 17:52:30 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:16389 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhEUVw3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 17:52:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621633866; x=1653169866;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=EN2oS/Ex0mQP1Kaf4HI4DHxmR/Rfjft+Vw2eG/WP50w=;
  b=bSJVUDbsx685z9843LDpcfUXHTxKakhDT0zj9gG7o+5PSUGQASvbHYUH
   3fca4ReEKBjtY5VXz59bR5e2aNGu5Lr8xSLXLxh1N+AGPy3hFCqSUHJDP
   rSWo37xT4RDzehzcKjQ3pCFiWwc9XyJ45TOR3ytgcNS6blUvHDNhoBeCh
   5pzCjJk0ROB3+bxtwi/HnJfA4hHB6Y8Fg90kwFlAe9yysTHXOZsjXNPkW
   R8HIyPN3BjxAZ0GkPp/xSK3XeRjn2+d/R4Z+m2oY/kk4QWmavWYkzWA51
   nTTJHEimV5a2v7zKDcDm/2I4aCN3HNXCkK7anBqUf7YlALB63ndwW8mEi
   g==;
IronPort-SDR: nxCil0yPMMbn4DXnj2iVkf58PgyCD5PY8QUhKqCPsp5H/Cf4NYATfq3XO/3zjqsklO2GusmmE2
 em2ZkFlCT8Gukin+s1W376V05aILmnLXbNIwwOO23eWW+9HT+WaXMsBVTA3vQUILx7DEq6X2UC
 OPUZFFwQKj+npl/zz42krADyjExDqY801C2k6Et25F6ukgYMfvmPbrpadwub6l7ZfpS8W2z6mk
 cOhRrcBKD8mqvMZi0GUoyJmK7dvfcxRCyhTOTH9gN7kkI3lNUy5RqRys6bpxc+3X4MMzrvAYi7
 Uyc=
X-IronPort-AV: E=Sophos;i="5.82,319,1613404800"; 
   d="scan'208";a="168365172"
Received: from mail-co1nam11lp2171.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.171])
  by ob1.hgst.iphmx.com with ESMTP; 22 May 2021 05:51:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HeHuVkDKgXpxzJD4tZJ+SPB1YYPVMWa6pv3d/ySZagJHBIMvHJcim2Zt8YhldqSM1FAyX0Q5wGX69FdJTb8Zu9Lyupa+07wUgBX8G3n9WCc2+zzGQMzm12/8tcfXuMxEPYtno2zH3THS8pUUpgT7D/QU9A0eKEQdAD87AM/4wXdh4x26bdnTOE1ODK7BSw8ZWfh+ok3iyZq75f0meIhow+uNhqHbQ/mfJ0mZXkb2eeIdn63bMgeX5ogHero5OfbSWJNt11G6fzcgn8Ue0K+CB+KeYAJ2Mh/6jWxmIOP7ddztAVaYc1/FUtvH1Difam9aTRPKDgcrLNbKiDOlmL0Jtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIY4+VVAnOLgIMmCQAAM99GqFnxKo0yt/RfaCmzoWw8=;
 b=Jl7ediyqbEiG49boX6a0lWFcn1KJ0x5wJaahdU8o8bdQeXNnEVHOJV8R6/UlZxoVOc0iTzMfxMVMpEj65RS1yFKpKThb3jyBaqG56sqMRmQEOGvr/sNAKKqs4W8r8t4JF9Wo9YFMZMKQ3VkRjubP62NxbX3C1qqcZZLC5fIkX/jf7Cv/yMNYEmH45slPsvVrTVq4QKGEFdZzrGj345V1BEeeHSGFp9nrCjZqzvjd3OTAEpHSEu9LgEvkF7TzC8WjwlA8wfkppuh2cujjBt1hBcFDUytkYQG9NQRD0IB+Iy8W5SIWN6bz4hr1DhEOGAn9QxmPYqJVGhqK1T5rAr1O+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIY4+VVAnOLgIMmCQAAM99GqFnxKo0yt/RfaCmzoWw8=;
 b=Y0ZTToz6oLYPOzcdhaTMFk/7vd/s9mD10XJ0cFVorgGVUh3a8ZU0P7ssZN3p0JJUM6Qebzv0A46xERPblzAy/HuhS/d7EzP8t2pl98e8JcpJBsxBXfj30sJYyZ6lAyjHOSbX/OFGLRyIy2R9tsCajJZSUv7EIEDXl43t2bus0QY=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4982.namprd04.prod.outlook.com (2603:10b6:a03:4c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.29; Fri, 21 May
 2021 21:51:03 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4150.023; Fri, 21 May 2021
 21:51:03 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "mb@lightnvm.io" <mb@lightnvm.io>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>,
        "hch@lst.de" <hch@lst.de>
Subject: Re: [RFC PATCH 0/8] block: fix bio_add_XXX_page() return type
Thread-Topic: [RFC PATCH 0/8] block: fix bio_add_XXX_page() return type
Thread-Index: AQHXTUCZbkdV5W8mbU+6O2TFfy2HFA==
Date:   Fri, 21 May 2021 21:51:03 +0000
Message-ID: <BYAPR04MB4965CE78D07F91E6CD88693986299@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210520062255.4908-1-chaitanya.kulkarni@wdc.com>
 <YKeZ5dtxt3gsImsd@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f012b2a-ad5d-437e-1531-08d91ca287bb
x-ms-traffictypediagnostic: BYAPR04MB4982:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB4982C85C5443608F2F42C55786299@BYAPR04MB4982.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5r4AYcWf66SiU98Es/UloWcpy+1rYfIryW3KprPYG2a2XeiHWpC1f5rBvtiEROyraAe7FD6rhgfo8ZHFKPp1y8FbWylmIxGBZueYYSKr473YW/Wt1Q3BK/XBx+wFvRdRUKeIsSIeZw4tpKxgNczp10pnTbKUTyTS4vYVQLR5AraRY1Oayeke09AqQ+oaoEmBIWEwEMan65s7ddQ2aAmZdHzBKlp6kORKQyvw3kkuyLC4wyzo2O7Wlc67Kr4qaedNl0IzET0BF/igJzZUqlkwXboikqBVE3IrRZWuejsqC+84J+gzGQeO/HIvkma3lkEqOmzzhkGpd2BwKwXu0acM0Or1AtLjK3qy1nIUA4/Z0Fc8IoxMwR+3BVFw0IVgLNY9+CY74JfUsQ/Vrt1m/1bc01o9gLIA6lNBWk4ZnVS6CMm8pPlqWn+FPz+b29jaq4YdkNvIElbF67PS6qzJTvoPA0svncV3eswaaTx2amRzIWjHAlsbVFcjM+SgVFirLD7OQJKoJqBBbpUKXgObN4/r4PyedhmNKRKLNoN3evOsGQ1a1jQk5l3eaKfzZE9iRW4yo1DpZteq4j92zJChbcDRVbneOu35u2PQsj/X0l0uyOCB/ZuTKOlGNl5GG45/03F+RmmwnIATmX+Uw428Ftu/hncv0Gj6lZML38Io85yDRhD8lVT+TStnToBFdmQfVbzwuPJesfc38aGHtrW6aGyO8zmDHtsttgA1nRwH5zYVaVNDF71oSwxuoNWlFrehHgaFAoIX7hGx+onByWIl7d8bDw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(396003)(366004)(376002)(53546011)(2906002)(86362001)(9686003)(66556008)(6506007)(66946007)(66446008)(186003)(66476007)(71200400001)(76116006)(64756008)(7416002)(55016002)(26005)(8676002)(33656002)(966005)(316002)(38100700002)(4326008)(54906003)(52536014)(5660300002)(8936002)(6916009)(478600001)(83380400001)(122000001)(7696005)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?sQau49azbC/Up1y57RCiY36vrTnP18tYmiqNNt+mvVss2/ioA65XwbEZChGH?=
 =?us-ascii?Q?BmBCKFOtrha4tPhuZ+WiRa5JusHYsnggctv4DlAiiDAPLqaf+Aa3ODhF5JpX?=
 =?us-ascii?Q?Qc2Dv86HM2FV8IW+ryxp2oiPcPZdpLm3n5GBSDUEBTy6BVes2cfqDGpfF6RW?=
 =?us-ascii?Q?+NAQ2Dizj/gCRUPSJrLv264gLLtf79l//mIXbqkczbKNvmXphMJwXyCvIM0A?=
 =?us-ascii?Q?octWnAfHB2mMGgn4JS+6VL4xz1aKwtmzyOGQP6ES7oHSCRJXS/RDNT43ZBEE?=
 =?us-ascii?Q?+4+0SWur66hJogndQYZEa5I3c192lg2YV8lu0hNVSXnQNsBcIOugIWPfiCqJ?=
 =?us-ascii?Q?ndOfVCkC9NFcZDHyNFHFXjdV5N/3zf2Rd58CVyKgTMZbO0q4CbNDZw8nSuTB?=
 =?us-ascii?Q?KCJLfBVXxPnXYzda4PDfzFVN6NYIZc5zod4xkCLFn3QlC58ECNcQ9O9AVLVe?=
 =?us-ascii?Q?amitY8fD1KEE4mLNrG4aHWRI/32qnKMx91yu7fUZG+FB58aRSEheB+sDqEEs?=
 =?us-ascii?Q?78rWH5tE51JTZ1fhv18wqxDqbylODSW0ANjvOhlWXIqT0HHB6lfFaLQtp0zc?=
 =?us-ascii?Q?0IRI/Qa3bB6kJ8XowEtuZM1dEIEyx7F3k2+NypylXoe9GbLwGrPQiDRrNTDQ?=
 =?us-ascii?Q?2uphreveP0n00jggAMaNiSoeuiux6qMo0y8GcbAjeWmEHSRLHH5fgUYMa1zK?=
 =?us-ascii?Q?Ii929RmdeTsnG51FkQkEnZExZdOcgxC37XJhs/VEuv9Kf5u6EdvYFbMgkeeE?=
 =?us-ascii?Q?G5u4vbY9OFCiE2SkGugK2Yg0l6bR7Udwrm3R6oICMHO07q8a/2e7vmTNduQ4?=
 =?us-ascii?Q?XxiqL0ZXZQEb/3CYHamYbnT8e3mhiqq/yPp2QyG3G/hQ/AzDeX8wHSkZ/ZE6?=
 =?us-ascii?Q?SHGn6ncHSvbSoQeSW28LOMLRqdFkFHtvFTK8rRUZmudEEpSMVUX6AD8NP1e6?=
 =?us-ascii?Q?cdsbFHS59MocuSBR+7RRE69sFLb6+4tYbu1j3N2/2kEPVzJslpmek0ibJiX6?=
 =?us-ascii?Q?0eZ+/KTmDr4LJ6GnQsrw4aBbJAA+UYLWKxaZEm6w0L4eA/dkvbD+wQAh+lZa?=
 =?us-ascii?Q?pagZzXzjGf5NV9U3tMMosxb75u5D0dBKdkiYq4wsUXSQVmvr7AARL9aH/F/c?=
 =?us-ascii?Q?sDSC7fSbTtvts4youGHE9X3Fg7yQ4FDYnc9H+ZQDaTkOGHEOpZ9aVd78crCJ?=
 =?us-ascii?Q?Mac/rbZR/gxBxDF8Aocj5cVBbz/xGcy/Irc1w7n0waeo1qn78v/wKsn3+SbK?=
 =?us-ascii?Q?Aiefpd6KnjIpo4csu+rsgZuZgtH7aUQnkUbfHnnSi1ACbiCYZ7sCpt5j5KYX?=
 =?us-ascii?Q?ptDHEODNoapZt2kuT2uQQbfC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f012b2a-ad5d-437e-1531-08d91ca287bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 21:51:03.5431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N4m6KYx1g2B/uwdR5FXJU7ZTQzIP3cHygTTdFEXAcaTQsmCQR6eoQqETCVPCdYMArSCDU9AyDX/YJONHkSoUYqw3hd2PRjmJlFN3Ue3K6Rg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4982
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/21/21 04:32, Matthew Wilcox wrote:=0A=
> On Wed, May 19, 2021 at 11:22:47PM -0700, Chaitanya Kulkarni wrote:=0A=
>> The helper functions bio_add_XXX_page() returns the length which is=0A=
>> unsigned int but the return type of those functions is defined=0A=
>> as int instead of unsigned int.=0A=
> I've been thinking about this for a few weeks as part of the folio=0A=
> patches:=0A=
>=0A=
> https://lore.kernel.org/linux-fsdevel/20210505150628.111735-72-willy@infr=
adead.org/=0A=
>=0A=
>  - len and off are measured in bytes=0A=
>  - neither are permitted to be negative=0A=
>  - for efficiency we only permit them to be up to 4GB=0A=
>=0A=
> I therefore believe the correct type for these parameters to be size_t,=
=0A=
> and we should range-check them if they're too large.  they should=0A=
> actually always fit within the page that they're associated with, but=0A=
> people do allocate non-compound pages and i'm not trying to break that=0A=
> today.=0A=
>=0A=
> using size_t makes it clear that these are byte counts, not (eg) sector=
=0A=
> counts.  i do think it's good to make the return value unsigned so we=0A=
> don't have people expecting a negative errno on failure.=0A=
>=0A=
=0A=
Sounds good, I'll wait for few days for the feedback from others and then=
=0A=
send out the V1 with your suggestions for using size_t and bounds check.=0A=
=0A=
=0A=
