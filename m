Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 158773C1CDA
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jul 2021 02:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhGIAot (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jul 2021 20:44:49 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:14462 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhGIAos (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jul 2021 20:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1625791325; x=1657327325;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=E093IeXQg+MnZW2zcG4z3p/4CiZW5LuMGgT8SZbQ1RM=;
  b=HScKwED0W4pNTc2BNjXnqnWYem4OWSoSQxlJ/C30mobsDa/GhhxKF76e
   znC74oYR/9XiRm6KolaLYNkXF+6YBjsBCDvPaL6YaO47TpnKFnVMP0VIK
   6CABZGBCLr0wuA6+Yq7q7DXC/C96s/bw/1URUZ9WBuqJdyfM6bUXC2jUB
   aCh9WGq3HVlD+vE5NOpn2nLvFuPxRinSOt55nxCDoMYu3QH2ryMc1A6fw
   JMXTn2g5jH1fCnfZi/X/CaX270IGbNJycQB/BO0FwQ2nn5KwnHTeuY4Pl
   Mgs4MKEpunwXis44Yl1ASvrdt7YroDpF7pgeQpm3DCtYekW7jzD6ECMwD
   A==;
IronPort-SDR: YZEu4hZgEdX6T4Ns5Et6s3gJY8sHqsytbXWKYBZLe0EvFqrMOiz9sVtC1cblBUiy7SsLWQSrqQ
 i/rM8rRzYV6lV0EE3z7cnAVExNI2OlyBBuJ0qCcvgSqAvJyJSUuIRhK5yr0Bxj136S2TFuGGzD
 k0OPa2KasChvDxWnlqFYdqAkm7LK+739rbVxS2NSQrhAEX6wGiiRsPwIiJyrW8h1RM2pEHMBkP
 3L9fhQZNe4zp6yRzB7gxBpuxbE93ZTvMwRGJwPXEQnm3K6uOekzGless3ZLn4kOCgdRkF8gg2v
 6Rs=
X-IronPort-AV: E=Sophos;i="5.84,225,1620662400"; 
   d="scan'208";a="174109782"
Received: from mail-mw2nam12lp2046.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.46])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2021 08:42:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P1cWt2d56vaNQMIBqDYebT1my9FKf7SDB3Kae08uMz0hiADNJX2VA6KI5E1RUrrw/RMHuNI5C+iMknAc7mJnC81LWas12NfHiR0IwPjMMqhpZTl2bUXHpq76GXsJLcL+vc9q/VIyhcIBkN5yhxAc62k2UeXlEw6M0FmkFwT4CoQvj3KR6baPdFQEZ0k9yPxDV5wmCP+m6TAd4yk5ymXZi4kCFl2Ysrf7nTJ+mSvmXbeAuQa/UEjM5VIvTWcj8p7niT4UyFkGGqUgYyS9I6KLvXfKlXfC1N4jK6fwwLatAHD5NYvSlqjSRYsAlB+o9aypRXf7M0sDsjhfgRi+QkC0lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=risAMwiGO1C8re38RHA6ONW5YyLjaqxTp2b2yYwdA9g=;
 b=iLbuac/oekfX94noC8hjoA0+W99GHgKoY76EpYgGMbQwxNc/cCcu8rNv+E5aWhD2WKeApyag73cmcPQY3oNXdItuH1Y8nQjy13y0scZZKmXO91W3Hdl6kLD0zjW8nCLtRxNcQQ5PJhg2ryqzgKnJ+5csmaaVXHrT2k+wosxKGaIkpzzI1ICNwhH97NhdgBA7x/Rl1eWQAMIXQp64O9R35agVk0mrlbVtVrMusUJNG9vexReB+/vMxuS1cLv9q25hzDHurV+jYZg4PSoHDnVVftYE0ii0KJxPc4B+6wGDsnWnrkGSfCSoaSL7oJwZpvQ6JhmXOhiQ3QQDk3z7/WnFpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=risAMwiGO1C8re38RHA6ONW5YyLjaqxTp2b2yYwdA9g=;
 b=eqLNUIpNLcIM42Aju9tVLtEEvxYR6BqT9AIqVHRzdLNSn/BQYDcSCYyyL14yOUgiUJj1yp+Am204n8wdjaHw7AankTvUelmK9dJJmiRBhq7EFVdgHQR70Y+SvTDmBg7y+mOdsf4dxzpkwtGLrNAdpk2L4LEGahIdH31FChiQtWk=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB5882.namprd04.prod.outlook.com (2603:10b6:5:16a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Fri, 9 Jul
 2021 00:42:04 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::44e6:14cc:4aab:3028]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::44e6:14cc:4aab:3028%6]) with mapi id 15.20.4287.023; Fri, 9 Jul 2021
 00:42:04 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH 1/3] block: fix arg type of bio_trim()
Thread-Topic: [PATCH 1/3] block: fix arg type of bio_trim()
Thread-Index: AQHXc/r3c4tH/j2F7km2hyvTid5Elg==
Date:   Fri, 9 Jul 2021 00:42:04 +0000
Message-ID: <DM6PR04MB70816886A482C04EE21D2C5EE7189@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210708131057.259327-1-naohiro.aota@wdc.com>
 <20210708131057.259327-2-naohiro.aota@wdc.com>
 <20210708145722.GD2610@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: defa3275-7bf5-4165-7ca7-08d942725f9a
x-ms-traffictypediagnostic: DM6PR04MB5882:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB58829FBA445F6E5EB03CEAB2E7189@DM6PR04MB5882.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pab/DaJ3SWqtFGPxUd9yp/MYH/GcSPD1u7+NG98lknANsllgotWEooFWz8A8LpstNNz1g4hzumWXwm4vQkXxF3oaOz1itF/zTb/bDDamgH0QVnuF5y9d8J14SCJw6xMrjSYPX0wL/5+naNe2eNMwSFCTzdB9nOfthpTyzrdOlUogPsRPU3q6W2M1sYAIB9TESvcegYIrLcr1hO/ZtkstDKaItBtbFDtwBold8QxEdp4dAXuPtcRfWiw2kvuV7kodeKRvXdRSP4asiwuzJSPjZwfLvniM0VxY+Pls0qAfsMRPO0Gfda8u9ljpPUR8DA+Q3fJozXwcthonJFYchtgB1hBLa3n0WdCHpBXnc/zHXYo+8/TqJSwhHs8ZxBUTWgscppgEs2qhE1I5p3EKJ3nMSePZNSIspXxGKh1qkoo8sBXxkimT682n56KQZTTzo/9UPUj7HGeOP48GhQswjIATtZPsF9JkKuvcRvse25D2kH1xwSubq9g6+jiewSQoax8DCE5jzNodCdRnKL+mTcxHHemelgcDAceLETHtja5rQLhJ+WWUBc2xAVbVsednwesl+ja/6rkNoeQ89hg1bY+CaWqaQNhy3//0jzl/jWpOAr9XWJE41c7AxpYDkYpk63MpXIvRaJcd1/vBJ89tOkXHwA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(7696005)(66446008)(33656002)(66946007)(2906002)(66556008)(6636002)(8676002)(52536014)(83380400001)(8936002)(66476007)(5660300002)(76116006)(71200400001)(478600001)(91956017)(64756008)(38100700002)(6506007)(110136005)(316002)(9686003)(186003)(53546011)(86362001)(4326008)(54906003)(122000001)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p+7rv4fD4oV/nEvx7Q9ycmZ4vyLwOfpmyX2JCcRW29vDEd5u3HaXb+SiKNnJ?=
 =?us-ascii?Q?o1nhzJN75o9u00ZbaseMW3V+9rrHvThW8EEjMQsfmyqBa6IbBg1U62tvDIv7?=
 =?us-ascii?Q?uHlSGBaphrQP+sMOEct/1qTiHi86Bt78+LJgGSrfU/Xmle6hO74WdVIGScoW?=
 =?us-ascii?Q?ZOAPxGQaaU6jIaHhUT0/fQp4wBBPIXei+BHzVeQMjl/ib5PtXc0gqE1Z1lpj?=
 =?us-ascii?Q?sFjxApP5vznA1D7NQheC7AHl86MOsH1RJForn5TcxO7veJWJew38PIznDN7I?=
 =?us-ascii?Q?q9IPa6VA9dRB534LO7/g62Flw1565T54fk+HyG1Ih1MJpyJnO+WicnpQMjhd?=
 =?us-ascii?Q?/Dpck/a0m/v62ktEd3BwiBU4V1mlEFT5BBjgrYpTY6q7pp9Nmrm9eRonWQ5K?=
 =?us-ascii?Q?XKVZN0VJKHKV+QhkBHDzTZ+sbUhQ+rlgBYTTWVOyjXW8TBH/napZUagZak4B?=
 =?us-ascii?Q?fY1L1EgsQdSV3nipX5bZuXOHTQVfIxnAKIun4llEdP+zyFsFhYOnzunCGtoW?=
 =?us-ascii?Q?gNbM19mnFpCRSrfIXdLWVbCmehh4auI6SpxxNzBvfcPdey5ZEHdgzadkrcbS?=
 =?us-ascii?Q?9MVfttxKFd//SXGABsfqDBYiaDXgAWiARq+WJ9z70EAB/4R7mSsl3ibRuEz6?=
 =?us-ascii?Q?gjK44TmeXlDt82vQTmAfenwKBeCwBVwvIFsqne2+Uob1GJ4/bZTjJTpgfoWC?=
 =?us-ascii?Q?GNra742nDze+AwT8NgnuFPvYttwdp8GfDJ/XsZcUYTvvMxr2z42aerebfbCI?=
 =?us-ascii?Q?7shC7GlsXBnTQ+dHxEA2EZ4IfBibJ26qo0DA1jINarjZdeSzGM2gWglzZxbE?=
 =?us-ascii?Q?IUFolhKJb/I4lhBPb8b+2SNIqR97LmQ52yrzEOUjdDucBEypaYBf5xtSj6Cg?=
 =?us-ascii?Q?aA3QO+pXjCaWUe4IHVJjKD9/5dvx3ahaqLyoRhqfpQb4EzQTsiMjoKIVlV0z?=
 =?us-ascii?Q?Ra4imYY6Fg3g/xgk7slPjwO4qEVkp+dgno6gfFzTrHxV+gFus2BGPF1hXxiV?=
 =?us-ascii?Q?Hy8c3vKQmNzxEvza/QduHYwslNZbO76oKnnYi58awRFfRSvFIlTU8qNe13wa?=
 =?us-ascii?Q?rVYg5KANjpum3t6zxCtJILanx2/oPyFXWQTatGLJd741FqkY1N/aJb6N4rt6?=
 =?us-ascii?Q?q5l8oTqbimnHw1gDPoMJxU65luY182qpcq1YPb6X0o10RqPWwC/xzdDrymNQ?=
 =?us-ascii?Q?CQ5jrRVckzu5JbNyKHK83fzw3zowOpIy9Bz5PDwckdh6FLuiZN06fDJZoyP2?=
 =?us-ascii?Q?Me3+rOvCKlzydoIomplk4UNSFyEyP5iirUo5NF3mnQXi0J1aJ70ajQjSggQz?=
 =?us-ascii?Q?XOXHb8W5snJcyd5VwovkCNiUWMrcfo4OVw8W9phjwKG+5xCs+m+b/L9WoqnI?=
 =?us-ascii?Q?gmBceZkj9sO6RN+FZtUZ3lOfQzQ36WhyzAhidSxQM+vPIspbLw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: defa3275-7bf5-4165-7ca7-08d942725f9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2021 00:42:04.6573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P1kU43NMYAgHXaWHdO3Oe9htp5poiXXVzB0Jf7RMkqbiEzvhmaUKG/O2Ny5s6mYkdHTl1fjvBMdxQfUTCjSmag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5882
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2021/07/09 0:00, David Sterba wrote:=0A=
> On Thu, Jul 08, 2021 at 10:10:55PM +0900, Naohiro Aota wrote:=0A=
>> From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
>>=0A=
>> The function bio_trim has offset and size arguments that are declared=0A=
>> as int.=0A=
>>=0A=
>> The callers of this function uses sector_t type when passing the offset=
=0A=
>> and size e,g. drivers/md/raid1.c:narrow_write_error() and=0A=
>> drivers/md/raid1.c:narrow_write_error().=0A=
>>=0A=
>> Change offset & size arguments to sector_t type for bio_trim().=0A=
>>=0A=
>> Tested-by: Naohiro Aota <naohiro.aota@wdc.com>=0A=
>> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
>> ---=0A=
>>  block/bio.c         | 2 +-=0A=
>>  include/linux/bio.h | 2 +-=0A=
>>  2 files changed, 2 insertions(+), 2 deletions(-)=0A=
>>=0A=
>> diff --git a/block/bio.c b/block/bio.c=0A=
>> index 44205dfb6b60..d342ce84f6cf 100644=0A=
>> --- a/block/bio.c=0A=
>> +++ b/block/bio.c=0A=
>> @@ -1465,7 +1465,7 @@ EXPORT_SYMBOL(bio_split);=0A=
>>   * @offset:	number of sectors to trim from the front of @bio=0A=
>>   * @size:	size we want to trim @bio to, in sectors=0A=
>>   */=0A=
>> -void bio_trim(struct bio *bio, int offset, int size)=0A=
>> +void bio_trim(struct bio *bio, sector_t offset, sector_t size)=0A=
> =0A=
> sectort_t seems to be the right one, there are << 9 in the function so=0A=
> that could lead to some bugs if the offset and size are at the boundary.=
=0A=
=0A=
Need to add an overflow check:=0A=
=0A=
size <<=3D 9;=0A=
...=0A=
bio->bi_iter.bi_size =3D size;=0A=
=0A=
bi_size is "unsigned int" so if "size << 9" is larger than UINT_MAX, things=
 will=0A=
break in ugly ways. And since trim is a hint to the device, in case of over=
flow,=0A=
the BIO size should probably simply be set to 0, with a WARN_ON signaling i=
t.=0A=
=0A=
Note that the potential overflow already exists with the current code as th=
e BIO=0A=
size can be less than requested or 0 if size <<9 overflows the int type...=
=0A=
=0A=
> =0A=
>>  {=0A=
>>  	/* 'bio' is a cloned bio which we need to trim to match=0A=
>>  	 * the given offset and size.=0A=
>> diff --git a/include/linux/bio.h b/include/linux/bio.h=0A=
>> index a0b4cfdf62a4..fb663152521e 100644=0A=
>> --- a/include/linux/bio.h=0A=
>> +++ b/include/linux/bio.h=0A=
>> @@ -379,7 +379,7 @@ static inline void bip_set_seed(struct bio_integrity=
_payload *bip,=0A=
>>  =0A=
>>  #endif /* CONFIG_BLK_DEV_INTEGRITY */=0A=
>>  =0A=
>> -extern void bio_trim(struct bio *bio, int offset, int size);=0A=
>> +void bio_trim(struct bio *bio, sector_t offset, sector_t size);=0A=
> =0A=
> You may want to keep the extern for consistency in that file, though=0A=
> it's not necessary for the prototype.=0A=
> =0A=
> The patch is simple I can take it through the btrfs tree with the other=
=0A=
> fixes unless there are objections.=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
