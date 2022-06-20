Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA35E550E8E
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jun 2022 04:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiFTC2e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Jun 2022 22:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbiFTC23 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Jun 2022 22:28:29 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F459D8B
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Jun 2022 19:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655692108; x=1687228108;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=m2xFzV9rzAuc097dRhOGyPHH9IoggRyQNoYYO5walXw=;
  b=WYODr9kjjpxNJZtc5G+OvRG0MOWGvX0Tz8FusVtROs7tucgAklwJaW1B
   p6BZbtcY7YFkjG8bOhfWh51aCwjIEfMcRbmtujzwaoMxdT8Tag5ITPl7C
   LedzUYoPxhBNLiRr9qjyAT/5uxuhrJ6doZ3gbHDX5gLZF2Pz62HEQSEMH
   97TpSPv/AdtfaI5PdO8lMQTkG3PqfmgknbM2djYCYGUY0GBWOxXRHUwyB
   kM7mXWoYiVo576ro2WSPVDsP6j5lQ6lpy+8dTLmQ52iejwqSeCfGjGhIV
   rLpbMpJ0kvCilsphqg6NEA35O114kVfyOvTRxVFjSn62Ds4lofGP/abNX
   A==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="315680240"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2022 10:28:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Af+jEzjUSneVFuWV9pXACWPzt1lWnFi+c0dIb/HqQN0bUQzQiKsDFCjTHyVk6cftE/0H2sDBNdWbbtnsET43z7S5aQacR4ev7AoNw6Ukm4HJkph26gYQ7Wf1ToyjzpCLAcpMm9gMqUziMC0imqhOauymGhtOh6xSb5NeJZLU6B07pfMaN2F/yyIP9Bo32t3KGWtOEvd4MFq+QMmhmxD/1wLVQwcyxxlr39aReXmP0vL/95V/gEI1mpT8Na+twwiekH9A/5h4wwmxzQaX/dpNmy9rUiZu1iCxIf+z69+TRB/WyUWzDcabvpu8km64HItYYRbohQini1iiErsnN88f9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6ssHQxUAryYb1cR5JxRb+ANLkxayaVsl7cPdNeHpto=;
 b=QY7lyaFfgpWD75V3QOsyEEVCKNI+eYh7r5aO+Ot3SaYOR+7lQ92350yii2hqWpERtD+7b23FgUSz/3iCgbEjMat4vqIyoHg7XLJjZs9V08W45rF6a8pyjdRN3rtg2I/QbgyxdCRjPFUliSyqPyV9yvFuNv20QUTA4c+Qx1YkvI7PH5zw2DsmRoo523eMpuHUvlBBsf+BerujPQy8QSWIcTFbiJqtkwus+jF98na83KQMdDw3fbdqSkbtYS0+1/Dn6RP3seq9GCXnrKT+lMusgN/zzAP2nPfNjuZKBXzjTryJioFEWcoW6NWSXUA63agZtKFTjyD07mBdQocEL7XXLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6ssHQxUAryYb1cR5JxRb+ANLkxayaVsl7cPdNeHpto=;
 b=MgLrGKMJOwarFR6q0H9ACPkHRlS6JXEbPrmCHmfv09Gc2u83TlCdpTEd+RlRzFfZgeegkxBMiAA+S+yroSMlA0sL+xy7GnleBvE88019CYi5MJFWmqPWXs10aikJR0EV8XcNmxG9+UFh5lhIBhO+KWBZHeHAWaSZVsyksp3STbk=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by MWHPR04MB0576.namprd04.prod.outlook.com (2603:10b6:300:72::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.19; Mon, 20 Jun
 2022 02:28:26 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::456b:ac5f:e71a:7164]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::456b:ac5f:e71a:7164%9]) with mapi id 15.20.5353.022; Mon, 20 Jun 2022
 02:28:26 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Filipe Manana <fdmanana@kernel.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/4] btrfs: extend btrfs_cleanup_ordered_extens for NULL
 locked_page
Thread-Topic: [PATCH 2/4] btrfs: extend btrfs_cleanup_ordered_extens for NULL
 locked_page
Thread-Index: AQHYgZguIuxjrvy1CkuIscl43qmsoq1TYxWAgAQ0kIA=
Date:   Mon, 20 Jun 2022 02:28:26 +0000
Message-ID: <20220620022825.ulwrxlmhypoqya6y@naota-xeon>
References: <cover.1655391633.git.naohiro.aota@wdc.com>
 <6de954aed27f8e5ebccd780bbc40ce37a6ddf4f1.1655391633.git.naohiro.aota@wdc.com>
 <20220617101515.GC4041436@falcondesktop>
In-Reply-To: <20220617101515.GC4041436@falcondesktop>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5241749-6c15-4dd7-540f-08da52648e1e
x-ms-traffictypediagnostic: MWHPR04MB0576:EE_
x-microsoft-antispam-prvs: <MWHPR04MB0576C872B3B33C421F98E00B8CB09@MWHPR04MB0576.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ggwS/BbwWN4BUSN8OLDk5ALzgJPr5Y5Stl8oyW0gWcBayI3J0y3Nufh6bB4dx98DpIsjxBKyu3h4M/z0QdGaDJN1KMK6sG/WMaebAbKID5MLsRw29UJtkuun9G4BNrABBrrKNj3w1uEHa0FHiM3Apv2538T6UXbQ1EKqKMzOhL0nd/FFHbGRcHGH0Hhtb0TtFH+UFMr0uUoouF3k2PwUa/+7vVtkcmOdtWk4REnSuFlxYyiAdDrI0ixxjxTll/hGKge1tQNhY78L46kHmm5xfQMwmsmTzKajsMSeVKphZq1uxZdmpiTlPh3ZuM0AuHG+xczG/sxsOts6CdJNh0F7KbBK/8vNm8mckU7zENLv0MQHjMD73mvRpB+woHUOds9ZWEDvNTUrmprP8lyaQJ7MC1C6up8vjn7i+fgqMFN+w9ktRbztKUIqV7U1cja4MmirIOzPx2RaAIN2t8t5FyuAdFvEzXEOII50nA9XV/icr6SgZhZ6QqGiXMCDxsLR96mnT9dYmV874EDimhWF5qZVAv1f8LeJ2mKsHb70IpPU+h2EbuixKkn7W8J5iTXoCj/tikbqWeGCJLOi8wH6oGQLimPhrbDkRUvWrzY2Emok9al9yfc3zxQxWknyQFu69bp562Z1nEaLn1VlFpn6tgtGU13Kk9BtkSolhBnyQIR3U6obNuyizKNjp4NqWYbSEDUT5pefmHq/LWaQ7i5V6DaGQQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(39860400002)(346002)(376002)(396003)(366004)(136003)(478600001)(186003)(8936002)(5660300002)(38100700002)(316002)(33716001)(122000001)(83380400001)(41300700001)(1076003)(86362001)(6506007)(71200400001)(4326008)(6486002)(6916009)(91956017)(76116006)(66946007)(66476007)(82960400001)(38070700005)(8676002)(26005)(6512007)(9686003)(66446008)(66556008)(64756008)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nvYP3M/fqYPoMxtgB08c6jrw9HLN9d1aeBRgAGnUTinQH4AkeUFKQ1bxDrXm?=
 =?us-ascii?Q?BTLoPfUwjFBRK0QPxp48gVJVN9EuWUbKQZlLsRQQmKvgEtzKy/W4J9LMZVj0?=
 =?us-ascii?Q?R9kH9HLofHrlIWtExuSBsf/dmUIumz1TBbZxQkVeHMM1X7A4jB+xQ6RYPSdO?=
 =?us-ascii?Q?l6HgzZ/dM/PCvFmzWyG898Wb3di1DvjrkSga61GsNezbjgoL28I9yle55aih?=
 =?us-ascii?Q?u+ALG/PXmnSpp6EVTDLVAaTU4Wji8O1CEA4Nd8dEy2ft5paYvWCzXVvsr93w?=
 =?us-ascii?Q?K+tej9Jejxozd61GkAiWZgWSHJqBrlf51t6LH0Qk5g5o5va2J38Uq2F8tvhJ?=
 =?us-ascii?Q?EznSTTdO/hvhvJ1Z2LJTiNVxee892OqC3oGTonk951Lcpjo5cavdMm9gKbad?=
 =?us-ascii?Q?vGmQIcfAHc0UKdDuAgFLCc2Dudnqc3gh060d0tgGJXIdEubvSR1lDXR6eB4U?=
 =?us-ascii?Q?D0z+hC3sltvZCjVfCFDdK5SDG2IRGP4ezZDRDvHCiSXd0h7F276Sv/6VUXlb?=
 =?us-ascii?Q?SjjFyR4vyFNZLzVseXYbl/BhnYm1F9Mf0dehQGt2J1NiFsYW1fYHPj1SPK8p?=
 =?us-ascii?Q?m4Zl5wfh/T5MB+H7cC2RvXQYy+Yt4xAnnBL5r7WN5Da9xmw5zsNuqq5tVTh8?=
 =?us-ascii?Q?YeXDDXWAxd1AOkLKsk8+G2OopWcSSdzdZ6BrxLHj33hzznpe+g+V74L8kd2h?=
 =?us-ascii?Q?BjQCkTj6/S4YUu37q97Zarje2/njODIrQ3ivj6aDssEVozuQnWtc1NRx5lSc?=
 =?us-ascii?Q?olcYfCk6YrxCvKw6MGe4F+bSv2zptoApSLqR1cpv4MjRD3GNa/FIc1dB1Oxh?=
 =?us-ascii?Q?EOB9pgxYfINADZ5Lg1PZLP7OlrVX1QLPj9bS2v+Y3aCZcRgsLADbsDqLFH2A?=
 =?us-ascii?Q?2rMRj+gJfrmWpVjfFuOOfD4Mrw/R7alCVfbTjd5L1AvabSQmYqBRZp4lC16y?=
 =?us-ascii?Q?4SHQo9eqEQrzwpSVk16is0q8WHJ0yV+5VIeuQtcwjBm55JSRX41yxGCJpW/X?=
 =?us-ascii?Q?IeUclqaTRe0pLPCUZrMyPPT2bppjUpS5Mrp9AvOjh3wRL04jcVAZ/KgcrBd4?=
 =?us-ascii?Q?nRrCWT/O8/VVuxjes5h8cNaJlQ6CobEnFKiAtnneHr7gWNFAmEvi+FBU/Y+8?=
 =?us-ascii?Q?wiKLCi3XOU8V6jFqoYgG7s1v3yXMer6gMKudB7MFRB9xdtncqSfVrmgbQbhk?=
 =?us-ascii?Q?iJOoTnnhdB3iFMjHmxgF5kCXCFI+1R8ezDzE+RMkunoz6M6nNjifr5P3wtBt?=
 =?us-ascii?Q?B6fjGVZSnqA7K82UDIcMVYLGjeFf85cgAGQ+deypNCpni9pw3fFQLqdEi/GW?=
 =?us-ascii?Q?+I2lMowMhsLFHIMofb2mayHtySytyJ5oa9oO88Ut00D6IpuiqgMs1+cxPVNl?=
 =?us-ascii?Q?1dmLGSwn8mrWXTn8wrVp4BitXdcvMn001Xukpcw0CdGTU6J22dgP8PSzpzo8?=
 =?us-ascii?Q?cmsXM0SD7KwXFn44HP+Se1PUg7JuPmalvKThoE0jBAGuI06tNnnBIDuVg761?=
 =?us-ascii?Q?32W7KlEqzv2kV+OtfUlFYToVQX9oRuKieCh3tc6v1V88CUIOkiqa9x3vn5qi?=
 =?us-ascii?Q?EPCUi5YehcKr8gEsKjhVFXuY8HrhJTo4OSvWk417VDD+Tk83G7GsdVGAVbOe?=
 =?us-ascii?Q?jhvlI0nNwN3rS5+zMho//NyaZVtl1tUDlC+q/3apbZlmqF+fdZlfqip1EpxI?=
 =?us-ascii?Q?2bj7t23mbBvrdNoUrs1auMWDyvvrtrq2O6tArmqlcgqm04Tevl27h722in3Z?=
 =?us-ascii?Q?pj2svFg/8KFZ33qNvMlDm8gj7D53j68=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D13148073C113B498F611045DCFB6413@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5241749-6c15-4dd7-540f-08da52648e1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2022 02:28:26.0124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EqYezIlIwMrp5MXhdKvB1/otlLpGPMY3CTeplq/z6k/HM2WPamyYVeytZMyZ05s1r7QENrx4QKIiQfMix/d9xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0576
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 17, 2022 at 11:15:15AM +0100, Filipe Manana wrote:
> On Fri, Jun 17, 2022 at 12:45:40AM +0900, Naohiro Aota wrote:
> > btrfs_cleanup_ordered_extents() assumes locked_page to be non-NULL, so =
it
> > is not usable for submit_uncompressed_range() which can habe NULL
> > locked_page.
> >=20
> > This commit supports locked_page =3D=3D NULL case. Also, it rewrites re=
dundant
> > "page_offset(locked_page)".
>=20
> The patch looks fine, but I don't see any patch in the patchset that actu=
ally
> makes submit_uncompressed_range() use btrfs_cleanup_ordered_extents().
> Did you forgot that, or am I missing something?

As commented in the reply, you looks like to miss the first line of added
code. :-)

> Thanks.
>=20
> >=20
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > ---
> >  fs/btrfs/inode.c | 36 +++++++++++++++++++++---------------
> >  1 file changed, 21 insertions(+), 15 deletions(-)
> >=20
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index 0c3d9998470f..4e1100f84a88 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -195,11 +195,14 @@ static inline void btrfs_cleanup_ordered_extents(=
struct btrfs_inode *inode,
> >  {
> >  	unsigned long index =3D offset >> PAGE_SHIFT;
> >  	unsigned long end_index =3D (offset + bytes - 1) >> PAGE_SHIFT;
> > -	u64 page_start =3D page_offset(locked_page);
> > -	u64 page_end =3D page_start + PAGE_SIZE - 1;
> > -
> > +	u64 page_start, page_end;
> >  	struct page *page;
> > =20
> > +	if (locked_page) {
> > +		page_start =3D page_offset(locked_page);
> > +		page_end =3D page_start + PAGE_SIZE - 1;
> > +	}
> > +
> >  	while (index <=3D end_index) {
> >  		/*
> >  		 * For locked page, we will call end_extent_writepage() on it
> > @@ -212,7 +215,7 @@ static inline void btrfs_cleanup_ordered_extents(st=
ruct btrfs_inode *inode,
> >  		 * btrfs_mark_ordered_io_finished() would skip the accounting
> >  		 * for the page range, and the ordered extent will never finish.
> >  		 */
> > -		if (index =3D=3D (page_offset(locked_page) >> PAGE_SHIFT)) {
> > +		if (locked_page && index =3D=3D (page_start >> PAGE_SHIFT)) {
> >  			index++;
> >  			continue;
> >  		}
> > @@ -231,17 +234,20 @@ static inline void btrfs_cleanup_ordered_extents(=
struct btrfs_inode *inode,
> >  		put_page(page);
> >  	}
> > =20
> > -	/* The locked page covers the full range, nothing needs to be done */
> > -	if (bytes + offset <=3D page_offset(locked_page) + PAGE_SIZE)
> > -		return;
> > -	/*
> > -	 * In case this page belongs to the delalloc range being instantiated
> > -	 * then skip it, since the first page of a range is going to be
> > -	 * properly cleaned up by the caller of run_delalloc_range
> > -	 */
> > -	if (page_start >=3D offset && page_end <=3D (offset + bytes - 1)) {
> > -		bytes =3D offset + bytes - page_offset(locked_page) - PAGE_SIZE;
> > -		offset =3D page_offset(locked_page) + PAGE_SIZE;
> > +	if (locked_page) {
> > +		/* The locked page covers the full range, nothing needs to be done *=
/
> > +		if (bytes + offset <=3D page_start + PAGE_SIZE)
> > +			return;
> > +		/*
> > +		 * In case this page belongs to the delalloc range being
> > +		 * instantiated then skip it, since the first page of a range is
> > +		 * going to be properly cleaned up by the caller of
> > +		 * run_delalloc_range
> > +		 */
> > +		if (page_start >=3D offset && page_end <=3D (offset + bytes - 1)) {
> > +			bytes =3D offset + bytes - page_offset(locked_page) - PAGE_SIZE;
> > +			offset =3D page_offset(locked_page) + PAGE_SIZE;
> > +		}
> >  	}
> > =20
> >  	return __endio_write_update_ordered(inode, offset, bytes, false);
> > --=20
> > 2.35.1
> > =
