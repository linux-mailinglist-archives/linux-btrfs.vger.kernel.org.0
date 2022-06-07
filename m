Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F5353F8B6
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jun 2022 10:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238699AbiFGIwx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 04:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238636AbiFGIwm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 04:52:42 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BEA1054B
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 01:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654591961; x=1686127961;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=BW/WL0Uenfxb981Cop4KkhjDwGrx89xAWV+YtEvHbQU=;
  b=eXv4whGm2doh+Tnlfm2PgclFZl9YiP2pq1tBdRMQSMactMl9LaqAEc4O
   ThHxw9pIrrMIUFuP2FQUZ59ZnK1NflBdpEkpWb6A1f4L7vZOhLbwk4tAB
   v48O2uQy1kWx21WjRyjEUYIBCVwVVeYDphtW1gAZwQ8dNhIrZdk1Cxe2G
   ngynAX0VK35iZrkbsHr7xCJJfG91Po2cs0HdgMxBg6Tf3SLDsMozUol/I
   k6VEV1Y6mSvZAXYJ6Md36w3q1NrpVlEUn7ULBG/+H18c+1gpc/lmJC68V
   jmk0y3/Up1SOOqvjxYNymtPQtnnrcM15qpXzfjHsHNTy8+UxkaIwHErbI
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,283,1647273600"; 
   d="scan'208";a="314512076"
Received: from mail-mw2nam04lp2176.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.176])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2022 16:52:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQytFBUBzkeuUQIwNmfcyJIHKRnXL+Kekjr4+GtvZr+s9Mo+hGcrngG2Ociv1ZV2RzFXKgJRywlDXYrvqmcEMlzhnNl6Oyb3FYebaB3sW9vUrWHuRp8BV//ghv/36Q05cDgMbXIo0eFIVzlPe34MrNAG6PN99DWA9UjeXbNlPASaIAFVnS9j0Wpe7VnxGE/HQBrr4H0eqd12YCJNKaphATQJys3to7RQPmNboC8cCpC7vzjiE6XvORdKnsJcx7I0Mhpl1GLKobh/wkfOcIFCiueZQrLL5bXcjOEQWcUCjH0FGCzS6/T8BAe6FIJ9YRnNPy9rHyVgMx47kSUJ3tU3Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UpS5CBUtNS8TEMvUBvr+/5ixkYmxqgHLOOpqr3JJLpc=;
 b=EKYzNHahjIOgZpg2OjaPOEpve0tTKTZRpLS7kflle57F7KoX+ZsK80Whigghv+9eOJwXU5/2utNI2qZdtFxzbvb0FJ1GbBOtGk/dAXIc7gsPEZ+8i0j24jEtpol2y2NitISBGlzxhc/CHuJVJwCXrpeG0RN/UBOIk305iicanjmhKxDMEZ75iSEXgxpuA4T9hKdGsdygQlWqg+o7Qppof4isj+HhhPEKz7CWU9kXlRm094l6dF7FYefceL78rXnlx4H1CFVlF+KJUS/GWEDzD53PoW1Bk0PqXPBCYuL1EJNQabDzNA18HieOhxkHmUP7W0UBRDli9rdLSMrCyjCsXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UpS5CBUtNS8TEMvUBvr+/5ixkYmxqgHLOOpqr3JJLpc=;
 b=sqXoTkrd6+ksf0ggJmeIXjih34BSXpXCj/8f5lbDShaVwulCbc99EecTxbtwKKc36MC+mW5GGsr0+va/LMwPi2LzjOvEvNomyQU/i+5U4BzmUdC/8m5QGnUHW03eRkNXdUSyZnxkkVaLcJ6tidYIT03FkC9Dbh4Uy0bscEcn7Jw=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by BL3PR04MB8202.namprd04.prod.outlook.com (2603:10b6:208:349::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Tue, 7 Jun
 2022 08:52:38 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::456b:ac5f:e71a:7164]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::456b:ac5f:e71a:7164%9]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 08:52:37 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] btrfs: zoned: fix critical section of relocation
 inode writeback
Thread-Topic: [PATCH v2 2/2] btrfs: zoned: fix critical section of relocation
 inode writeback
Thread-Index: AQHYej1sJTiiR3D9LUWZ5/eSVdNl7q1Do2SA
Date:   Tue, 7 Jun 2022 08:52:37 +0000
Message-ID: <20220607085237.kykjgin3jmlofhlo@naota-xeon>
References: <cover.1654585425.git.naohiro.aota@wdc.com>
 <668df7d610ddae48ffd260ae08f433cc3b3d7ecd.1654585425.git.naohiro.aota@wdc.com>
In-Reply-To: <668df7d610ddae48ffd260ae08f433cc3b3d7ecd.1654585425.git.naohiro.aota@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85ce4e5a-4cd2-46d4-28dc-08da486312b8
x-ms-traffictypediagnostic: BL3PR04MB8202:EE_
x-microsoft-antispam-prvs: <BL3PR04MB8202A6E24CAFFBD2104811E48CA59@BL3PR04MB8202.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dafMGIfIziNjElGftOhcnM7RtdhPy2AHg6r/WIhLEsCQsOTAb4duFZCOOrwSbKQQBaacYnleEctZHWReIsRrBOSnDA/uz6L7SxPR2BgjknuOyC8cdNhb6/Qvf42XwNj7/7VQuOq02upiIY5Rq2Fsu3kgzUjlx/arwBjn9NWu7hu4MYvhhO2tXMa1qeFynhogr7uzk6eIcW8uxVTWdBLF6WrYdiRqC/58fNutAcYqhErOi5+DGNYHgL1wpaAK9yzO8Vr8nLGL+UAzupgBGbNRyXdJWL2FYXt+6eJeoGAwyExupumnU09V8y1r3Dtm3emaKVPVX++tP1nUbfKykYLs0W6LMbmeykfiskhMc+gbZ0va/K1JhOOXHjZn98Pyzh4RQT3smTXPT9V27/4qJa0U7iEYdE4cXooHFLxvkSx/7MHTZEOvlvxQTBImSXex1A/zKVOD8yZgJGXXi0+/h/Fac3I5gEy1PScc9kS7IPtOpoGwjVlymVEVCGxUyBODoUPkGNcjLPG++5YhFt/7l6uqYzkvNRq5FN2CUWu+QKeVfEDUs9lc8slfVjzXdOuEcGcpfgU51v/WOcv61fI3XLCx7YVja0xHRn4J8iIe+5Meu0yNfpS//HYSos+9RL1vK8hOEwPPpUUqdzmfEUarZDICdzMLUq23nF3SdpJXsuFHzc9rNz6QzSa9a8xkHy3tPcLRPXckhRMI6s1M9NtPQHqwjQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(66946007)(66556008)(66446008)(33716001)(8936002)(508600001)(8676002)(186003)(82960400001)(26005)(316002)(2906002)(122000001)(38070700005)(1076003)(83380400001)(9686003)(6916009)(66476007)(6512007)(71200400001)(38100700002)(5660300002)(6506007)(64756008)(6486002)(76116006)(86362001)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0rIFiEeaocJIlRM/O624A5Vcrb9TahI/vtfPb/JcHdF4Q6MlVtNhfUDYbm5s?=
 =?us-ascii?Q?OGm9eQn7Ntz4knnviTkHt3wTyYpx6DCqbCv/7yDovNJ1q2eZ8o0xA8CMIFlz?=
 =?us-ascii?Q?YLX5OH/0qvSs57mm2JRLhEVb7B87v+GJpHu6wc/BaewooPsOsU9YFg9Uz6n8?=
 =?us-ascii?Q?sf7wVKZNDKaqUPk9Zmk9OxhgTPmm9+Wf5xPCTXXaQYFqO7GPDD6vXXK8E7vP?=
 =?us-ascii?Q?EaFJ4UstwOSkxmoxG8hfMKV/9P8/KSif9XcvlwGACpw2ljJc7SJ2zWX0pCAg?=
 =?us-ascii?Q?p3OJ2+EchzeRkZYLZHPznAjXHibL6FcVoXiW9x5jKekVwGNlV0dWSfGYBT2P?=
 =?us-ascii?Q?OiZYoKVMQED34hIe6VbUuERtphIXjdYrn2rorJV0/0OK6zR21QGKoUBa5unC?=
 =?us-ascii?Q?i5o2MNUK4fXN/wgraOc613SSfoVha+xN4EBFDyJ7DTEppP0YSBf3XH90OrBl?=
 =?us-ascii?Q?aAGe7ei+yTnclonwHtC98B2/3ren07odOl1S+rKfD8UjnduJr/pCaJGqQNM2?=
 =?us-ascii?Q?i5NTq5LcjArLDbWrkYqLrdnK5vN80vqkESik7hM+PjwZu8EaK8bJcilatymh?=
 =?us-ascii?Q?/MiehnvV/kMS1JhuRdIn7Zc8HawTK4zwwEkhfSMcG8T4ACtI/BdlTdSd8m3c?=
 =?us-ascii?Q?Rlze+ZujJf4zufsmIMB2I8cYhm09gvWcb2MOvyJ1SBqGFx6qqz2biXLrnoQq?=
 =?us-ascii?Q?L6oqc5m2Uqjpwd0S627aCp4ONhdg0V8KD1ywUy0i79qAgCOdSEH+61MqDQeX?=
 =?us-ascii?Q?DykrNSBkzxsIeYFA5p59XA/vpDmpDtiebR59APJqvOy8+Bj94dhJR4pIuwr9?=
 =?us-ascii?Q?y1fBORE/licejpk6dU+sWDluub80PzwhCXIpP+MlfAcGwOJ6cryyZTozu8iu?=
 =?us-ascii?Q?FCh553PPLHu3TEVrPl9nSiuMhAieCRYli2n0pcOJUSNxrlfXNBbLH9C3+qWk?=
 =?us-ascii?Q?zNyUCmPFwtu9vEBmA/J7dwmlLwx3gXrqfzeq0MemuzWWi0rG+NHKyQ571nCP?=
 =?us-ascii?Q?LopkZbF+8wlJy++5Qsu3o2clxTAE0Dzlopxc4wqCRjur+8cRu6YrGUAKN9hA?=
 =?us-ascii?Q?g+e7IEGXsCokNUgmfQG/XKp3h8nhbY2XymBcsbXr4DQZcZL7LVjQpyZLoTov?=
 =?us-ascii?Q?osrTStJq+XZKEePGYHyz8gVT2uTNkZ3JhJBEfdOo2mM03EoNGWI0R4XwVega?=
 =?us-ascii?Q?8dsaIcbMOM5wTiCMeuCsZDeM9GPtfP1XheGa4PoK0yn+eGloN0kBmHccnIjd?=
 =?us-ascii?Q?FgLjr8P86VdKunWwqp7lIEj6QsQJZMQ4JNU6+5epuKdOCou5zLdl7RWDcQyC?=
 =?us-ascii?Q?ZFWKiMQVuvuBoz08Seq0RtBg6vumufvIthfp6CzG4gndd+2gF8wPNgPtiu8k?=
 =?us-ascii?Q?I3W5JuYWRXlr/QWcvd/HU2rejNQHhg0/FgF2dWip+A6s/+bPe2mShpwUc6tr?=
 =?us-ascii?Q?3CtWlFCBtAWJ4enQ7poq0ozYhGvoE3xEG8Kg6j1CuDuiPHkjlLJnam/G/OFw?=
 =?us-ascii?Q?OknnfhyBzejDBESoByETXk5QsybyD9jxUhtafZQdvw+RfUY3+QQXFHLyI16l?=
 =?us-ascii?Q?EU8OdBvFlvUioL6QN832nnwmplVsQlNPrBmGpwT6g1IcOx1gLrBmzGYGrYRK?=
 =?us-ascii?Q?IYO70PYH+NlYRh9XJ1fXw6j+KRfDQwKnT52hmAixX0pVhP7JbbL4FlWuf+HO?=
 =?us-ascii?Q?gV/9h/HVrlhTkfs1KlJva72q6Dkr05wITA4mAqm0bfKwV17JtmdwwxdeCQLL?=
 =?us-ascii?Q?kVsQammUrqN2f1wuHxDEvM+V3s+n6mE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <75BFC7AF1252BD44ADB220662164E9F7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ce4e5a-4cd2-46d4-28dc-08da486312b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 08:52:37.9055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lVbDHHuPSiHhOLjFWHzI+mbcfZrsjLQMN6YmDm+OKn/m3b+lB5aXwp4kouBK+noVb8KzTsOIBGv7oBkqjXS8TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8202
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Sorry. I forgot to rebase the series, and this patch looks conflict with
the commit "btrfs: merge end_write_bio and flush_write_bio." We need to
place btrfs_zoned_data_reloc_unlock() after submit_write_bio().

On Tue, Jun 07, 2022 at 04:08:30PM +0900, Naohiro Aota wrote:
> We use btrfs_zoned_data_reloc_{lock,unlock} to allow only one process to
> write out to the relocation inode. That critical section must include all
> the IO submission for the inode. However, flush_write_bio() in
> extent_writepages() is out of the critical section, causing an IO
> submission outside of the lock. This leads to an out of the order IO
> submission and fail the relocation process.
>=20
> Fix it by extending the critical section.
>=20
> Fixes: 35156d852762 ("btrfs: zoned: only allow one process to add pages t=
o a relocation inode")
> CC: stable@vger.kernel.org # 5.16+
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/extent_io.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 4847e0471dbf..7a125b319a9f 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -5227,13 +5227,14 @@ int extent_writepages(struct address_space *mappi=
ng,
>  	 */
>  	btrfs_zoned_data_reloc_lock(BTRFS_I(inode));
>  	ret =3D extent_write_cache_pages(mapping, wbc, &epd);
> -	btrfs_zoned_data_reloc_unlock(BTRFS_I(inode));
>  	ASSERT(ret <=3D 0);
>  	if (ret < 0) {
> +		btrfs_zoned_data_reloc_unlock(BTRFS_I(inode));
>  		end_write_bio(&epd, ret);
>  		return ret;
>  	}
>  	flush_write_bio(&epd);
> +	btrfs_zoned_data_reloc_unlock(BTRFS_I(inode));
>  	return ret;
>  }
> =20
> --=20
> 2.35.1
> =
