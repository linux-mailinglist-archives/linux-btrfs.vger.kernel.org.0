Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025E138C49C
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 12:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbhEUK1G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 06:27:06 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:64927 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhEUK06 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 06:26:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621592735; x=1653128735;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=rTkubRX8hcLvTFdfBhKG/kLxRB2EMlCD95Akmm6UCAk=;
  b=FcsV80NDoOmKi3bgSCLot14PZFaeD7hvSE52l2qKWuRRKn0h+AyUxFFE
   p9qva5SqlEH06MRjZh1fmqQlw5qlN1WvT89FD0YChIh1e4S6SWPRcr2qg
   0HO9aMJuwSFvjvK2PR472+2ImJteFMyd41Zes7ff9vL0me8cd0E/UlPl6
   K6zxCKBL6VQnJ55VMc5CdRFKU9yaFblLWDOZyQLF1Fl/04oALskqVR9XA
   2BzXplpujWdftR5hmqM3TmARQcwdwC0WdQjKtL2XgLY7wpy9b492v0kAY
   G6mjdXEDqamf7hB1dWblFlTuGACtpm3ECKd2kh6Zqp7OluVAApQxh229w
   A==;
IronPort-SDR: tR6jvvqtydyvS+6uXICI3QtusnUv6FBLJYMQR21/+oosLCcngCfl/rjoYmYyMZ0rDVG6NCanQH
 URdVIdFfCkTwoTLrgoqyGOKMk1utv+TEz6aooSBK/AIgBXrveyuvSkJUYP+/EDJlfUc95/oPtR
 wNA1PM8eLhcawldeXPCTzBuYQ6zcl1u671ZhECJcM6Ssk5vbn4sxih+4U7ZvVYdriwwgNLsgSx
 YCWvSeHDpCru/A6HAmn1YGVW5DOBZziYdbrPVUaKA7SIMXqNgajom/dX2Ty9D194rSt4d4m/qR
 owQ=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="168984160"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2021 18:25:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1d/TBfd/KYGXh2evIwnDfloL/uThSzG270sCgyic2pfMFwrIOtxpv+ToKl2Ogh+YfOggoltwjz4OUvpWXY8JXf1R2QaQBgIqWz9okQqspJX/DpwLmsm6ib/5g6CaHRdEN/oLdTHavpLENzzJPtQac9nMmcanqPNzM1QknnvryFk4P0cz5z5hkW84zl8aoh2TEpDjQaoDSGF/xYUNj083Wd1+V/7Fv5jpy1XCH4xYrILV8vOS2VuM7Nd0rYX9O0SlD/Cq6ln5kXOPnDxVXZicX8x+R90Ec1L1cz4DMGRjwzqecWZcGY2Ta2eESe5DyPpwNsmgapzHmGDbCvXBAliNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCiC1RvtQHHWKe1h6CCulUXtHOiDfJ/WTSUchcy74Ik=;
 b=c0eA+H4gdJgaCCbEPS0eHiI9T6RnysSo7zCx83aJOIdqRsla+zyAzf1l1v5/ARv11mA/eHMsV6M5tTTJ5EAx0HaLHR7WCdiN2yQXCkq221gz4dc8MaPr0rTb33zjZvAvk9gqbr+VmeVjl9j/4NswiiVVAs598PCaX78LUH6t3FlMi9u6WqZkp29/dGQFyM3Ng7aokgflYO0fhiUboHpSDGIpjEWTba4QBspyxduYenTpW3midhB6/pWJJf2sVNJ+bg0HDR/sonN5EarrsAw9xUoZRIolTD7jiq49ftTkzx38obe28bPsxrUZ7U/sFQQscVi9BojbMChe6C7NwooSKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCiC1RvtQHHWKe1h6CCulUXtHOiDfJ/WTSUchcy74Ik=;
 b=X24ym+cBE17vyTmbZxV/4jo31NuGxw1Qwk3yU+kkxr+1SVOKLpSgvQMEnv0BYdLEY3TnDvdW02ojqUSH6CRDKpKdy6fuKUkPyQrTV1StvLRxeDL5Zi6a8d7o7TgZQGLStQvHF6EGii5gaHkCuoi1pP4d0i++LuLWD9sKfFHfF3Y=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7512.namprd04.prod.outlook.com (2603:10b6:510:53::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Fri, 21 May
 2021 10:25:27 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4129.035; Fri, 21 May 2021
 10:25:27 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "mb@lightnvm.io" <mb@lightnvm.io>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>,
        "hch@lst.de" <hch@lst.de>
Subject: Re: [RFC PATCH 0/8] block: fix bio_add_XXX_page() return type
Thread-Topic: [RFC PATCH 0/8] block: fix bio_add_XXX_page() return type
Thread-Index: AQHXTUCb0LxyZPgwi0al9qWUl5DExQ==
Date:   Fri, 21 May 2021 10:25:27 +0000
Message-ID: <PH0PR04MB74169D71E3DCB347DFCBFCB59B299@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210520062255.4908-1-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:152f:cc01:f8bd:921e:9aa5:6d21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e3ede47-319a-432f-ad81-08d91c42c09f
x-ms-traffictypediagnostic: PH0PR04MB7512:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB751214CCF6A54D3FD1A82B369B299@PH0PR04MB7512.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5iXzgbZKo7WrO5OtBJl1yjORWMC+NbwMhSW2XaqNuKcX89s5JiXa2JwpQoXJK76VIsPEXIPN0lSMTl/RVAHoh+EZU+Cj1r1Mi438vwkQ3ICEWYBdbCD5tKM/kyVasfwk7Yk8pKK/wpAaxITrPMrGuxcVuuoW0Aplrx6ulhYlLtdZ4NL397p+UMCFuSwwM8QsuukPdSzyRw//Yl2tC2NLjjch4NlU1fis6zlH3vZ0LNekY0V0xwEmJ/2gZBDEq41/O2bM0WamOM3DAIZeKQtbc0Y2EbP8x13h/wFLpryX3PIJXwGa+Am5ST3s2SPVr77ZvKWe32S4AyQoLul9KF0dxcTYU2Th67NKNQ9uYnTlj/JK9je0h462ITIJUY0Iq6ZPfJBBeuBBKRzOULccFffldj35AQ7GTLaGaOns74PKthlaPqx58+fcLVeMxb/Lk8eZzWxnvB2CU7PBOpnDTTAhzkpkOj6ASx99NkjcjTHqFj7zmnmp9m5UbkCUX4GB0A+ZZyRVhIxzQVoDHv+ukOkiPh3kTDgWFdYnJKM13T5a80RBe0ksCJH9q7/R1STbhg3Dk1uneZUI7avr/bfTY24UiS9VFQOt9otGhFRevQOIbu1fDaoIpep+fgeWcUPghswIV8XFQkq7a5fF1H1yDP3yHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(39860400002)(366004)(346002)(478600001)(7696005)(7416002)(316002)(122000001)(2906002)(52536014)(6506007)(54906003)(55016002)(5660300002)(53546011)(110136005)(8936002)(8676002)(9686003)(33656002)(66446008)(64756008)(66556008)(66476007)(66946007)(76116006)(71200400001)(38100700002)(83380400001)(86362001)(186003)(4326008)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?esIqWVoUyEhk53qPO+RY64ejybSe69SON2u5wBgycDSNGlcJ3bJ4aceqKT?=
 =?iso-8859-1?Q?AUQtBgJeEKKNIzVECIoORTerPtF+LkC3zxtQ9DdCtP/KnQEv7L9jWvUw9+?=
 =?iso-8859-1?Q?IDIptV5Zr5EaccZzDFKLmtKSI/kAQN2itxH4Hwx1GchJMddk4m6QlgYGeu?=
 =?iso-8859-1?Q?9FDuua8+vFNkxv2IIXMvrYKtalY0rorfdaKRnMO2opYc6qBh4vmi2oMV3z?=
 =?iso-8859-1?Q?P7tE4zL1uLdHTO/FOh+IWtNHXtWQMpT9AgyvfFga4Iikt3G3PN3kFIpD16?=
 =?iso-8859-1?Q?awfPbdsC0x1SaZDxADSpvlsacIgnkeQV4Y6b6TO5Fcsb9qx7m9TorEbeqo?=
 =?iso-8859-1?Q?KLNxm/lw6X7psYma7RhfDSy+wQPzYRWVW9BZARWTIh0xEMAsEsR54f4ykG?=
 =?iso-8859-1?Q?6rtDhyWFGelvg2S8vIPUkS5MX+U2a4Pf/8RZeIOW8u8qW57lqcq8390MkP?=
 =?iso-8859-1?Q?54r9w32B9jzU5Mr5XwUrDkdM+DGM+UIQ/+1O40IfBS37iEssAR6iQgcQGu?=
 =?iso-8859-1?Q?Jwn0t4BKWxxWWw9ikY5i0iV2hEp8h7uF7IeyzsGTAtN98HTQ1r8iJBmBTt?=
 =?iso-8859-1?Q?EmhKISOqmzFH5/weSJOgGeDJ60/Xjy+e/L869695RnwIz5kPeQN4m19Djl?=
 =?iso-8859-1?Q?1MCOv342olm1N+NIjtaC4uPpznkM7/5cETe8tvquMSiuQCXs5DugDD/1Sn?=
 =?iso-8859-1?Q?gCWVPDf9yxkHFaqD5EOoIxDgtkqjeInigsMFxEjHxVykgsmiwFQi7LYl5r?=
 =?iso-8859-1?Q?KO+UGfkf3L2h47HqmKsx9wo0c4m9go4ymAJIoBD6ytJZqfetphRNT0WbHx?=
 =?iso-8859-1?Q?zQ+cmUCGE0Oz/rj7zPLClgPGcMYSDwg1dgiQam9u0ISwILJcn9nNA+dbhU?=
 =?iso-8859-1?Q?/8KR+pOMIS5WJ3NGenh7OAh47x2tM1eqG5kTk6jMKKIMM3VNeMOVJX01rl?=
 =?iso-8859-1?Q?hdOZPjoDJmF011vLH9onT6Q2HFz/tzFsXDe4GxfSgSSEQVCmScQODTLnix?=
 =?iso-8859-1?Q?Pr9vNfes6/gs4OW37XDWdm3hceJXthPqyyvzTOs0k60JL4V996dTRKgBgD?=
 =?iso-8859-1?Q?Di2NfcdEt7b6iwleo6MqdKQzphmxbBfWpPe0djJVw41MuQyLSP/4QMFRhz?=
 =?iso-8859-1?Q?YhgIpsQn0RazUdr2AZgnIcmfNYVeBpI7thn6cAkjapKhnFkRaAjVZGv2bA?=
 =?iso-8859-1?Q?sY3f2VcQYcwQOv+sgNcQqjRy8341HlamJR8aVqoNAsJFN6ENT/yM+Gczgs?=
 =?iso-8859-1?Q?TOmfJV9crXDYIQbeQQnRRKhVXp1yzXWoEPwGIA11gQWplSrqsEGb+s1/Fs?=
 =?iso-8859-1?Q?+kK/P8CNEmWDf5Utm8S0UgWG+BiNPKjsYrttA6LuYyUnMj/2ZSVNJE7Ttf?=
 =?iso-8859-1?Q?4h59qmqxd0+E8DXIpIJC3bmcHx8fxOloVkPAM99GAXp1HiB7GBA4ZBht7t?=
 =?iso-8859-1?Q?aptKRrgeN5s2+7SvVhyGJqxyHVBUpifAJnDSag=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e3ede47-319a-432f-ad81-08d91c42c09f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 10:25:27.2793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FrOH2kG9fEq6klfpPA1awzYwW6Z+fpsrUIscXlvcTVGForE5+VvhASBplwTPHj75g9OpLsXRtmJeACBjafeKRuEIm9gos1by7E7X0dzu9ec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7512
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 20/05/2021 08:23, Chaitanya Kulkarni wrote:=0A=
> Hi, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =0A=
> =0A=
> The helper functions bio_add_XXX_page() returns the length which is=0A=
> unsigned int but the return type of those functions is defined=0A=
> as int instead of unsigned int.=0A=
> =0A=
> This is an attempt to fix the return type of those functions=0A=
> and few callers. There are many places where this fix is needed=0A=
> in the callers, if this series makes it to the upstream I'll convert=0A=
> those callers gradually.=0A=
> =0A=
> Any feedback is welcome.=0A=
> =0A=
> -ck=0A=
> =0A=
> Chaitanya Kulkarni (8):=0A=
>   block: fix return type of bio_add_hw_page()=0A=
>   block: fix return type of bio_add_pc_page()=0A=
>   block: fix return type of bio_add_zone_append_page=0A=
>   block: fix return type of bio_add_page()=0A=
>   lightnvm: fix variable type pblk-core=0A=
>   pscsi: fix variable type pscsi_map_sg=0A=
>   btrfs: fix variable type in btrfs_bio_add_page=0A=
>   block: fix variable type for zero pages=0A=
> =0A=
>  block/bio.c                        | 20 +++++++++++---------=0A=
>  block/blk-lib.c                    |  2 +-=0A=
>  block/blk.h                        |  7 ++++---=0A=
>  drivers/lightnvm/pblk-core.c       |  3 ++-=0A=
>  drivers/target/target_core_pscsi.c |  6 ++++--=0A=
>  fs/btrfs/extent_io.c               |  2 +-=0A=
>  include/linux/bio.h                | 11 ++++++-----=0A=
>  7 files changed, 29 insertions(+), 22 deletions(-)=0A=
> =0A=
=0A=
I couldn't spot any errors, but I'm not sure it's worth the effort.=0A=
=0A=
If Jens decides to take it:=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
