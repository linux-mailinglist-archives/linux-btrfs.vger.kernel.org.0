Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C9E7421D1
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jun 2023 10:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjF2ILS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jun 2023 04:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233080AbjF2IKo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jun 2023 04:10:44 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E1A35BB
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jun 2023 01:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1688025733; x=1719561733;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tZrvLlPyz0DyffUGfT49zAEEq3Tm/E4Vxs3MpUbvWos=;
  b=RBF1FL+QD2hXXFly2orWGlXMyiobkLHaJ68cEo+vKr3eifvCHueHsR5J
   hkAGqU87+gLHCWQwxFvw+gR6gJ2sJEdG+WY93wuJYrOhSZpZaLqZ9isub
   3iaXfKEC24cLr452rXoyJspbu3cI6HDAFSV2zKQN+WzUqTJRKLDzEsyVs
   FfhZ4BH0Gi5NHO+FZXFCMehdyqfJJdeacdH8joULZ+TasSCDmbq2yWTvO
   n735OcPbt2e9vljUkrVq8WROuNubQoUb1P0P/1JCc3rh5Du/rXXKIRj5E
   h+AU+mEqJOLyIILwJ4Z4fCLYo+ABaX8Chnn51AcQYova5wyMCeKsc8pC6
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,168,1684771200"; 
   d="scan'208";a="341870084"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2023 16:02:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLAtB9D+EnsUGIk0m9p9g3eHZvd0gVYolSGob7GoFTjGJVeQMNcACa3/Ge3wYzq5yn7ww6Sdb3X38mBcE1szzwXwhTl4KsHX09/xJ+B+28OURBYo6dsi8L4Tu76SMmvk0W45TnSuYoYYm7g70DHYwiE3ltReMZxBaWUuivQUM/DYBKpSNhIcuvNRYPQY1M1b3dZptb69G/Sl9Otm3yhPOKd8AznapA5c1MbZLfjGtF+GzSw/PvOE5BobWe/rnEtzCuuIQn7rs9zNnuLJDCDtuM7SCyvwkvntCgQ7CAZbN+2zHVyvY7hq1tZppw5YkS2JkoEr/NDPmqczczAaWDuJZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lS1lSA/ad8a6Zjd3lPt8akLqpTRETWmP7k0vV/KLEhs=;
 b=DCAhg5PCy9LKpqhQOuokIc9lk3d3Wq0Sttr1kQ8rSCVVz5pOAv1Q2PCxsB+lLRfM/eGCIjoqFj2kOnq0NEYBujcp15naKB1HzcsWT4sj8jCOg+L+2V5eYHpmRzhWAcUlZYM/ICaZSVUMGx4Ga4DcnqrzxoSKL7RO+KsHmCJElCXOksYC3x9dSXzISg+pWlpI+60FIichrOFDfE2iu887D55Db/6BZgPx09MIqahyWN1YR2x31lqFSacXtFNYskCUEMqtfDErDvUdSbJ9T1d0UqKoA9orGjgkgXaBces8dX1dp0ar9vdyFU6by/L6htRq9B52lj6rirGSlX6TyYLuDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lS1lSA/ad8a6Zjd3lPt8akLqpTRETWmP7k0vV/KLEhs=;
 b=hl3QvIan0FC3NiOopQX0bYCMLVeUvRgeYyxlLFxNIKFt3JDbqctSzX0J0uDrrqLYhzh7J9GSRv4HJ0wkAAuraXBGAEvFg4TsguytktIlWbg1Xg9xL6NAAFcR5l97+PeTfoW+fykltPnEkJKL4t1MU0gNJOZtZZE3zi6yW2FKTGg=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by BL3PR04MB8074.namprd04.prod.outlook.com (2603:10b6:208:349::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 29 Jun
 2023 08:02:10 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::e9d9:ae8:fb59:5f01]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::e9d9:ae8:fb59:5f01%4]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 08:02:10 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: do not enable async discard
Thread-Topic: [PATCH] btrfs: zoned: do not enable async discard
Thread-Index: AQHZqVr56gNiVOO8M0uRnnRtfLuBBa+fqXMAgAHD2IA=
Date:   Thu, 29 Jun 2023 08:02:10 +0000
Message-ID: <7yoo4jss7pb6wdqkxzlqf4elqgg5y5zel2sgopfjjxyso52bt5@3jxtjkaiznay>
References: <87c887259bfb49878be9990f4dd559ee90d273ec.1687913519.git.naohiro.aota@wdc.com>
 <ZJu/eL8jn7i0nFEu@infradead.org>
In-Reply-To: <ZJu/eL8jn7i0nFEu@infradead.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|BL3PR04MB8074:EE_
x-ms-office365-filtering-correlation-id: 30af743d-a937-4064-5c4c-08db787723f4
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y0UuJfFeDxeOEecd7BcQ8/pbDHUrZZJqw37lN+b7ZZt6lcl9OyAQoR9jr7LWCN1oeOI3/oOn/OGyj9GLKCXtYo6601I+hadWipp93huBVVPJcJEpeStMAh4+pxvQRuvpkTh7e9Ux5SUBMBfQnz0ggNBO4/WnnouD6itiMZzu7T8foFcsevX0owS4c/SE1aKSgmRz7LEC/JB8MocanQbsL27eprRkKnjx9gO+cNpBnTROwy4vfJkFIc7d7P2zKbhgeKUN0EoB3pxrtAGCII0yTKUQ0lhi0lm+YQqUzmY1xfP7hh0W5yx9KZH3AJbVUJvefN0M0/IfKdiM10E09rX5XTn8OvBtIWr+ufdxDh38UgeCoTyF5wkrh5ScELzcCQ55UWMSrE87SbaumEhYWSKEFzNKUgbuW5NuFhOPKXpQIM/7+GZ/QSHWtSnscLpvDELfnHmDt+OEqBKa0Iek5+ei/BM8VIIzkhk60U/PjwtZXNpaSTQizV9X8GVuckx6T/u19lNc9RnSo2gf6eNrjeA/88EVMidMOObNPUorfHJ0dTDDVmYWH7PF4Zq7K3zj2r8xLbIuUSfateGD5SMV3XHPA7QbXl21ES4yANfr+MqWI9RhUachyqqLezrT8PgTX6+8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(451199021)(6512007)(91956017)(66556008)(66446008)(4326008)(66476007)(316002)(76116006)(6916009)(38070700005)(64756008)(478600001)(66946007)(8936002)(8676002)(5660300002)(2906002)(26005)(86362001)(41300700001)(6486002)(33716001)(6506007)(71200400001)(9686003)(122000001)(82960400001)(186003)(38100700002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1aIuUeerwubJzdwL2FaC3OrP4Abx/ll+HzFMag4rotK08IH/sYbvTvmXBeS8?=
 =?us-ascii?Q?I/D9GTALajMBrdcSQsFdsPmt4uYhBuEUHKbF50Y7nUFlpPMP7XXP2chtEa/9?=
 =?us-ascii?Q?TYOka0cwqSOxYfnUL/ckpVIUHs+kQdm/mqzDCEWfVpBTWBZEvhKLFFfUWhzm?=
 =?us-ascii?Q?LuMQMSXYVKGkFcS99yfUB9NLTZlUkJDxSjKEMOIAantXuVv9xiE/fRSBYfN+?=
 =?us-ascii?Q?MXnEM7oT1nTCRryCwUQp2NPg0odKLPjK60fssEFsrSqABMP+PGghlqWL7afH?=
 =?us-ascii?Q?Xa0SJneyEYrajYTAAyfAeo91n5bj+Bsvb8Fz1rlsbTaFfHMRKxEmLLjF6EhK?=
 =?us-ascii?Q?aORoxSIRH2wn7esnI+OLWtZPzW05eLc7lHMAMHS0cF2SHNMiFnmSrZmMi3gq?=
 =?us-ascii?Q?JmThs36AI1v/MRa399XkEZs8SfOWUT+pofGXsFWfGwZ1TqCArBB0k89s5mQd?=
 =?us-ascii?Q?gCJcOKx93Jm+OTACed6UKzX2LJPJQ4Jk9cGLPamq1aSgeCO3ixLzbEnM0ApI?=
 =?us-ascii?Q?HEBZEVEwnc6xeGLBheXVwkip1VDQCTF59e59/bO9e1JkUV9rhrwqgpkTtDd+?=
 =?us-ascii?Q?2xNZMHeJIoqcTU31OTq2ZTOSBa89tWYpJmIklRxNl1ANCq1RFtqbjBOnbaiK?=
 =?us-ascii?Q?CIweDE9XKMONrZ/dTldiWhH601Ky7zyvG/jZLCz/u/wf3NWpZ5rZfC33HOb5?=
 =?us-ascii?Q?WbkRfSujUIQrtOm1inoNTvxTtJq7+GWZiUcw4pd5T7f6JwpdHAmgM423YaeA?=
 =?us-ascii?Q?8q3AmFi/mA0RGfIyFp7F/qsAKzflm2fY36K2t/ROuOnInKwkDhmKkWjiLdrN?=
 =?us-ascii?Q?ZYx1En1AAQ5+7NmnkanbMITpKWcXP81S7Ah5H/V3TlejPBYax89ksEtJ+NHf?=
 =?us-ascii?Q?xHyg4WfxKC3sEjF9DpaOGelmdoN4YbmW7SO5WXcfge1O2CUIZjseNnNOdC0m?=
 =?us-ascii?Q?GAptI5OyCm4txK3NfS7FxzlgCbgjhJYtAv1P8+3HI3xjketj+5BC83fEtoKk?=
 =?us-ascii?Q?7zsOJmm5uwSEVGLPh6RwvjT8dRM2gCNmyeojKqAxh421Kp4tlBXbWU9OOzGw?=
 =?us-ascii?Q?VeM0Rx0o4glckrsD7ILzezrGGHPJbHOMQDAMNJwnZeLsaNnfUPSFjs1wNm2P?=
 =?us-ascii?Q?G8A3eFJCvFieC50uFRLqwgsdWHOOZrR6K8MlTweC5eCq4NPxyNK+Qtd4gngg?=
 =?us-ascii?Q?nP3jKu48l00vRsNA1P5iIMMmPaUm0prjdjMO+qMY5d+tH+I31zEwB0J40AF5?=
 =?us-ascii?Q?rt2xtX+Z/hH0KcR67P86QD/hM6DyIWxuNbW/TJwZSQ1A6vOGKPL3s9OwhWZO?=
 =?us-ascii?Q?jeZ7YPR3Bf0hDpUo6Ql0U9u/PACbyhfo762MtmWccjBnTZLH9wPZwztdFuJ/?=
 =?us-ascii?Q?X3i1xXiWXGmpxHvtgcOtEUtqpkFKuKwoBqtGUfaC5kFbxtlmLyz5IPbQ+Gh7?=
 =?us-ascii?Q?zU1nzI39cpBD7VtPVV0Oex+SpCK6Ti9JfHKDZAN0vDti+eBzwNozYWZK+cnU?=
 =?us-ascii?Q?de8kOjKHqR4FLFBI8AnVWMiGRXfW03EnSQljnVpKd7udpn82QccwebV/OTNK?=
 =?us-ascii?Q?PE0/773Y/Fc9x4xJVv6TRvEixNaX7IJj9Kp7QXb1+1AeQuLNZxkzXGp9p1oP?=
 =?us-ascii?Q?Yw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FD86B5195B64B54692A84FDB2849B51F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bclru8dA5RxwtyINGDt0bcvQaKIcl78MyvEGh0ZQaaLSc2SlYa9doooKANVol1MwGKMlpLKGP2A3YKkLN2Qw3ogKDq1BQ4ZlRs1V9HQXKOuIkTrUvkT9xf5UdArnZXDJ+p2pxB5VsmyJjkbHiSu0jVa5wMjd7e2gV9OkbrnglSp5rjEmw7AuQQWtHJhuIXlcOPwsC6/Nvy2Wu8Kq4yzz63x8tzgpaIZkgIcgsLVtk4pa0kqzxLghqOzhqPgZJ0b19CuS3UK2l6stXJuR8xEKvRgcRNjBhuV2pfSNYKdxULQhZocZZGp66ZR2hBbkvABKou+f7HdpbiQTP6BuKKthlH3V69NDd7M4BdUB5Jtw26AcICU4bFjHl4mZUcSFB8BWGI6OP4U3LGggW9+xtEsPhLN44DA7zpMDhgD/UeqBxyBrzWpG+lKOmIIt07GtERL4h+tqIQqA7KvmXmEZ1PQLIqZTNM6ocpa7clriYWQIVNTNIxsU9boF10zUtg4HVcyBg+N3qANOrkXAuiEL3bRDDLosctqKnTgvHeIqcCp3aeViykF/fPbTYuMhrQenuhAoJlAfNXnPlZ9AaWOEKM7AmSEWYF5tioyD+pH0egvmLVv+Jr0bUrVAxN+RD/gU/nros35ABQqa/X9W4mtQ3SEYvPTM2gql6yKgw+TzHqt9Wh+J8B2y4aqgR5frCjpY8MXnfWdUnK9HB70PTsV+q2kYPnXjikNe14/ili2ejiub+clvLeVqyf+MSMvBs5bE84C+5dm28m5KoisVEvyQYodb5LSCNVG0Q2mMzjNIk2bR14tuOi5VODRloo0P6r29OWM7
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30af743d-a937-4064-5c4c-08db787723f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2023 08:02:10.2561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /wLpvxiw2KJJUNna+CAQHerG7wTszwyz6rgIZDfK4tp1TaQvVGHCG4vwpEyRBwWS065o7rmXUFr8dB49+ncMPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8074
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 27, 2023 at 10:04:56PM -0700, Christoph Hellwig wrote:
> On Wed, Jun 28, 2023 at 09:53:25AM +0900, Naohiro Aota wrote:
> > The zoned mode need to reset a zone before using it. We rely on btrfs's
> > original discard functionality (discarding unused block group range) to=
 do
> > the resetting.
> >=20
> > While the commit 63a7cb130718 ("btrfs: auto enable discard=3Dasync when
> > possible") made the discard done in an async manner, a zoned reset do n=
ot
> > need to be async, as it is fast enough.
> >=20
> > Even worth, delaying zone rests prevents using those zones again. So, l=
et's
> > disable async discard on the zoned mode.
>=20
> Agreed.  But I find some of the logic here rather confusing.  Is there
> a chance we could just decouple the ZONE_RESET logic from looking at
> the discard options as they are a very fundamental part of the zoned
> model and thus we should not rely on otherwise optional mount options?

The logic is mostly common, so it won't be worth decoupling them. The code =
is
implemented in btrfs_delete_unused_bgs().

Here, we check the DISCARD option and zoned mode to do trimming or zone
reset. Then, that block group must be kept in transaction->deleted_bgs whil=
e it
is discarded or zone reset. So, I don't see much point decoupling them.

		trimming =3D btrfs_test_opt(fs_info, DISCARD_SYNC) ||
				btrfs_is_zoned(fs_info);

But, with discard=3Dasync, all these logic is skipped and the async discard
work is queued.

> > +	if (btrfs_test_opt(info, DISCARD_ASYNC)) {
> > +		btrfs_err(info, "zoned: async discard not supported");
> > +		return -EINVAL;
> > +	}
>=20
> I'd probably only warn about ignoring the option here and clear it
> as users might have the option in their fstab by now and you'd
> break mounting the file system and thus potentially booting entirely.
>=20

Sure. That works.=
