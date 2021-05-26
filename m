Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 246E0390E8E
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 May 2021 04:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbhEZC5b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 May 2021 22:57:31 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:63448 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbhEZC5b (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 May 2021 22:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621997760; x=1653533760;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Nd1cOrIBfPKim1+YxkGdgGwyduzd11pXfTWeUFUCl8U=;
  b=HWQPdrpGCmpLxMIBvYkH+5inKv7Tzc4uUr6IWPuyJ25uRg5b5sHhu1xh
   51C4KiXTFhOL7AcuSf0gM0CK7FTxHA44tfmMhHuOk+CO1sd/1KvYAs8aM
   5Pe+VJ7SlMgRtm7zGf1dQUfjKP2WUOxk6hg7kWkpu+b9LiXPvT5yeh6FA
   Iehtvfqk9kZ6L7bzdKy6gsDnNNXUqAZlel+DA48bxWGRaxxwCPT0B4zs9
   dkw2ho+n7JuCyIhNNxeAMhOxiNgWv3tG/JilDze7h/nufEkHvnFIu4G59
   2/Y7NgJbmAynbJlpBlSg0qcs0oFJOfSJOl87N088Rh1dZ5DzWnf192SeZ
   A==;
IronPort-SDR: BDPnJtQtkN98QEtuBQA7sF4EhD1Ds/vC5FtI4Q6ND8X8BxRUmpG3L38kmIWNCMm+xKa9ov+YEb
 AWgZ57vBI9eDG9jQ8KbgNKYioXcXYdWLl8rcDCIixd5ktsZ7LgDoSB7xzZkpoDepQNhs495Xga
 vwIz9Pvm2p74bmgGBGO6dCWxNXbBBucjWhvUjuCOqPGq+/fG7QtrSaxrGoa1KjF+9/CU8i8keE
 oZg48PjxZQq4RomRO0aDzv2KGco++YYd2jqymvZveZKu0gojbZm2yejjiWV2y5OI7jRWpQuFek
 kRc=
X-IronPort-AV: E=Sophos;i="5.82,330,1613404800"; 
   d="scan'208";a="280745105"
Received: from mail-sn1anam02lp2048.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.48])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2021 10:55:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idAPk4Yqsyzrd7PGR00WW6mgDFSbw7T5Tilr43wVPTvLjk6kl7riSkN0pe0O9HvHW3go4sbS8eJJRFS7MAw5Oo3PhqBClVCerCyNZ5BXQ94QkPq3/h65cWzYepdOS3YjbpUseBeLOV8n0ZJug+n12fNST4L9MmuDQRp3MvzLorKiV8IkdP17SXp4cjMEPC5n2CuxeWGrcQk2GBxjb516JCBtmWMyBVyKDgxFJk3/wYTHRqG2C+1LaY5C33YupfxwApnovO59pa3oiSHr4XAcvP/9qcuD+OI90/AGIdE8FZoYfWXYbVzNdqrso/QGBRDh2tFzzWcE6VIRAoLrHdgDMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhu7bu0XcdjJpWGL8vr9yk6iEbJIRk5IMJeHXVusU1g=;
 b=CB7hKmnX+gRH3lXa8m5vsZ4HMdyYwUnvXZ4cmqgn29hQVbKDRaO0UZ1QBOxlXJ4iOP6heu8CXmo3aDYyqw5S+IwWFWqwRE0MKRpcogWm9N8pPuOTKo9KKYzagb5iWsxrrvQ4DOWfilDEch8aZiDDCjCH9pKHUw2pWDL0+UzrgTxQ+Sv3+1VTjqOHFmmcfLtLpVg40YrqOz9nAysTfYeNYvar2eIzMWiDy2tO+rmU0k3QaIGZYgm1pjIean1U+YXwjBVBK1FRbStHKqmzYWSs0IZSf4vrrew7mc1BGndB7Pig1e+eJ8kSibIYQtZcCndFlNzE4eoKde72A9IV6C9h3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhu7bu0XcdjJpWGL8vr9yk6iEbJIRk5IMJeHXVusU1g=;
 b=XYoVSfDKcYqyDCdc8BJldCjhj7gwr4ddOqqn5wFDGyZ/2k1oFSQW00pJfb9ZIDTbxftdTgQsLqZJKRXTNB9Hb++K6Utq1roIyUWbbuZyKY2fKI5EiRviCfjC8zBGd5X8bvVzgSU7rHUsipxlFwUU+i3ZzpTVfMLTYHo9dTWtgpo=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB3861.namprd04.prod.outlook.com (2603:10b6:a02:ac::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Wed, 26 May
 2021 02:55:57 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 02:55:57 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Matthew Wilcox <willy@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
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
        "jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>
Subject: Re: [RFC PATCH 0/8] block: fix bio_add_XXX_page() return type
Thread-Topic: [RFC PATCH 0/8] block: fix bio_add_XXX_page() return type
Thread-Index: AQHXTUCZbkdV5W8mbU+6O2TFfy2HFA==
Date:   Wed, 26 May 2021 02:55:57 +0000
Message-ID: <BYAPR04MB49650508F2C5A4EA3B576D5286249@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210520062255.4908-1-chaitanya.kulkarni@wdc.com>
 <YKeZ5dtxt3gsImsd@casper.infradead.org> <20210524073527.GA24302@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6fd60881-8d8e-4488-937f-08d91ff1c965
x-ms-traffictypediagnostic: BYAPR04MB3861:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB386159894AC15178C668AC4886249@BYAPR04MB3861.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M05AWDI0nFHBzH6AB0SHAvX5vfKddw0uB5WOLb+TwZAq707WH+euHADubeV9FpyKeCFgxlbRjJ05S/ybWaTzTchKsCV264T6so42aEoWzwehcLArktwn02LYMWJPadbEHfK+Mbw2jMRPhSueLgk3W3Z4ShkArZgYvaOTu+Y0IclbwmNr/QlymP9K8kLdJe29xHI4pfSKlOW/JYxk7MU0n0Nf3z6bKOR9+LS3YO5gQYRKpKJi95Le7KltXHKjUF6NIqMvo8dsyvsokr/BUjMOcHNxOM2Lhq7bDEO5w0txw04OWVFPmtFx1+6sD2WKf53gQUuDz1ghVQTsoUmWW1hVT/hh+rodV8771puglpftUlLhmx9FFMOyJN+XjksdLG38459a+KUlvgaqr+Kw+TWRpznKL2YU7VPTv3zep2Xi41478slXOY7d7AOHgXanCDhvDv3hee0kM3rOiP1e43nG17e66qhiBzJJKLVSW/k/woVJV4CgEcQ/IEjZnRo/LcMrXnLLrL10fF7pyHIsZ3/loMOl3BfP2D4F553Zh5oDDy6y1hl8anQt0Y0XaxJjd0pQNYdVbEbAKXh2ifQuvzrftnaIXb/HWfqK5GTNiEF64ptq08JyOvRQQSNSbgk6KwN/HScDvhydwCYCpPXDv6QTipqRr4SJGZO+i6vY4fZZ7WcIkMeoaXBjhXyNF47nwTuQiUxFwOhfAiLmeoKP0eX1jmVEuiptKBBIGbGuV91Pw8LA51d0LCMhQwLo6hWdrfbV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(8676002)(52536014)(2906002)(76116006)(7696005)(64756008)(54906003)(66946007)(53546011)(966005)(66476007)(66556008)(5660300002)(71200400001)(86362001)(8936002)(186003)(26005)(478600001)(66446008)(33656002)(6916009)(38100700002)(9686003)(55016002)(7416002)(316002)(4326008)(122000001)(6506007)(83380400001)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?5TNKfo9+CqauyvdUi9O5WMhaBVSvwVn12FsId9lCzYrYNrVcpdrnYMTTLDz9?=
 =?us-ascii?Q?K/H7YlRzxbqHE2nVHzxQ2nA43bYdlPwD+E6inDIkVma9+dCC5THbRIvL/bXa?=
 =?us-ascii?Q?5reMtnhbR4MWeWu5A1PQknTfJv9GYJKmMUbNKtk71PiD9jWUFXqk/hPRC++1?=
 =?us-ascii?Q?bB2CryChhPiZ0Y62fnOTpZ+BhyUJj4SdSd+AYuxI3EUBkTRr1nwjtptOUNmY?=
 =?us-ascii?Q?jrJp0Geu7Qg+jVEAXyTGVqz8oTR+o7Q2tlo8O5bnsxaQ5kbvloM6VcOP4uPh?=
 =?us-ascii?Q?pb861S6jaBaWLJHt0/3ygTRWYGgC7UDfFwrYiipbQF+DPk0XN9NgHwM0f058?=
 =?us-ascii?Q?kNlsezhLxp2SkzLfg4siz6ex3yUPb1QLhof9Da8r1lnVtAJqSdPMp6zE80Wx?=
 =?us-ascii?Q?btowIcWxdQzFAC95FDBXSViNmynNKb+Nrlgi2Ech9G1+Qh211I9YeXu0jM6N?=
 =?us-ascii?Q?O6wWsiz94Fx0LX54v56Y3M4s0gHENRRjHNytXiNf6xcZ4dsrG6DxtxbI4ma5?=
 =?us-ascii?Q?08pGF7V8LU4xIyXoDz+VwtRy/NxyLQ6E6GuNJyx8qzStshQTqAUhO+UuI9v+?=
 =?us-ascii?Q?iOe+UkzLj5Hji24MzgHCS8GgPJYdCm88HidnrxaWGfNUC/6YgsokjBuVheFZ?=
 =?us-ascii?Q?0diHtE9TM+iAH7uWUJNR3z/GTk9ULgMh4Yl+IM9M5go64VRuVAJ4rV8ead4N?=
 =?us-ascii?Q?98oRq8PTha12AOxbgimgyjJhrbigOiBSFsc5bkeJ5RUO2wc/PTvzEhF8iyJE?=
 =?us-ascii?Q?Uw9JdExoirwNqllCkScUPRa1uybSn8sY3N4+nfBPgZDXn1KFpS1BePl5YrC+?=
 =?us-ascii?Q?iEzrvcVH6y8Sb4CnqGGlEwvlYDAk+OmFxKmdJvetjDKsfcGxPtS0rQkDSwpv?=
 =?us-ascii?Q?6YHl+sHziAGIlv9Ii4o8gMk1XHFsYtrYjTLslwEDceieV7LyBRauao+DkFGs?=
 =?us-ascii?Q?dLJ5OBHehICpPT3Z/dzOGHj+ECjp/8438+HYVSVaaifFkGWNkErb0gRytGhu?=
 =?us-ascii?Q?iWn+vOBoTgLANQ52bNnkSXZztkuMnuDM2yDdlnSS2ttcwJ7TVIqaM1wvVbBa?=
 =?us-ascii?Q?IEoFGcnLXxWJL48vlgNkocyCtfj4xPm8IJP2cJ7lS2v8clUHQuhW3kKh5TnH?=
 =?us-ascii?Q?vI6puK2nnOHJMMbJgmu4lKN1nf5UUUxjU7q3o+KS8D1Yl3jpArTWFsoJfSOW?=
 =?us-ascii?Q?IH7nxLt17ru2o4+65a8dlGF+/gPl6OcLnmHt0uvuHYlOF3L6DSXXIOfGbs3q?=
 =?us-ascii?Q?cRG6tVM0h6NLQCYYs3HpmPqDhEycgE8uM7sjnOObUWPkZHeZ57pPRzVX9QLP?=
 =?us-ascii?Q?1oaNtH5NFSVP+HPXA/bYAdtX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fd60881-8d8e-4488-937f-08d91ff1c965
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2021 02:55:57.5133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7SGHYw4wP7GxduunB0G+dnjRIS1Pvbi4NRN96kd0u/04IVb7oCJsO9GdTEYUq7Jw2p4bW9BLT5/XiLqNe0mLw/pe3ajyBpBc9PAr1G5R05c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3861
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Christoph,=0A=
=0A=
On 5/24/21 00:35, Christoph Hellwig wrote:=0A=
> On Fri, May 21, 2021 at 12:30:45PM +0100, Matthew Wilcox wrote:=0A=
>> On Wed, May 19, 2021 at 11:22:47PM -0700, Chaitanya Kulkarni wrote:=0A=
>>> The helper functions bio_add_XXX_page() returns the length which is=0A=
>>> unsigned int but the return type of those functions is defined=0A=
>>> as int instead of unsigned int.=0A=
>> I've been thinking about this for a few weeks as part of the folio=0A=
>> patches:=0A=
>>=0A=
>> https://lore.kernel.org/linux-fsdevel/20210505150628.111735-72-willy@inf=
radead.org/=0A=
>>=0A=
>>  - len and off are measured in bytes=0A=
>>  - neither are permitted to be negative=0A=
>>  - for efficiency we only permit them to be up to 4GB=0A=
>>=0A=
>> I therefore believe the correct type for these parameters to be size_t,=
=0A=
>> and we should range-check them if they're too large.  they should=0A=
>> actually always fit within the page that they're associated with, but=0A=
>> people do allocate non-compound pages and i'm not trying to break that=
=0A=
>> today.=0A=
>>=0A=
>> using size_t makes it clear that these are byte counts, not (eg) sector=
=0A=
>> counts.  i do think it's good to make the return value unsigned so we=0A=
>> don't have people expecting a negative errno on failure.=0A=
> I think the right type is bool.  We always return either 0 or the full=0A=
> length we tried to add.  Instead of optimizing for a partial add (which=
=0A=
> only makes sense for bio_add_hw_page anyway), I'd rather make the=0A=
> interface as simple as possible.=0A=
>=0A=
=0A=
Is above comment is on this series or on the API present in the folio=0A=
patches [1] ?=0A=
=0A=
Since if we change the return type to bool for the functions in=0A=
question [2] in this series we also need to modify the callers, I'm not sur=
e=0A=
that is worth it though.=0A=
=0A=
Please confirm.=0A=
=0A=
[1]=0A=
https://lore.kernel.org/linux-fsdevel/20210505150628.111735-72-willy@infrad=
ead.org/=0A=
=0A=
=0A=
[2]=0A=
bio_add_hw_page()=0A=
bio_add_pc_page()=0A=
bio_add_zone_append_page()=0A=
bio_add page()=0A=
=0A=
=0A=
