Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CE651419E
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 06:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237892AbiD2E77 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Apr 2022 00:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237887AbiD2E74 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Apr 2022 00:59:56 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FAE23BD0
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 21:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651208198; x=1682744198;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=orU103PX0CM3GoZnme/daQ4V1ms1g6yPng5PGG50yWA=;
  b=XC8VEvA99YW0p6oUsWISp0Y+watCqSRo8Ju8NCYNYS1g+kMl85Mfhl+F
   gu2VuTtAr2ExJ61Svjq79f4EQpoj70Tpnps4XpwujJXKx1ePiWpSLAjpn
   2IupMvhly6IB8O+j7O4ycadrNHMipQS2csi8hBrvlbitDnC2BnM5/TLSp
   6XBQEQQyyQ5514gyeeVEtwIhOQ84cDeFK0mhFoeGd+bWvfQm96mIw1Qka
   e9XHUBcxzg0HAztiqj7jnaIJYUYzObNcsogYWiF7h9n9ypGfh7cR2zazg
   II77m6R/agNlbNCoFNvpeLWe8+xNXjBwAtvTswyQXXQa37xIzi/bp+5Dw
   A==;
X-IronPort-AV: E=Sophos;i="5.91,297,1647273600"; 
   d="scan'208";a="303336877"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
  by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2022 12:56:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PeVBpCt6ihg3MC3+uoAHvrMOkCq4ElAE9i432Kh4Rg1hB7RHgSDRKV0vRqMqp1Tx+EBNovEcKjCI9dAzETJxZHHMnoqRBU4NmPYZHIYg1UnH53IvJ/FQvbOAwfDcwEH8HI/Gy9pLMnhtuKJHK3Hvmds8x+yZmQI4n1iKp7FlY5p2Dtks5PDHzOZs70XlbrVfA6575xSFVl4uxnI2VN7knmtBbQHoaaAZ5Y00iHf7r4wj6fuVXE4JcTW1hGGCdl6po6rT8ZaSkphZscYX/rl/eEonPKAU0hEbILIqjLltBcfckyRrf1qEtEDaXRSxKlZguXuoK8nRFZUuz5yQLDhIzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZDNJeRAhQ2hftMh3XngA9DXvWVxYQBB9Dw7alWN1mc=;
 b=AyZ4cir0BuVkTS4sOCOjj5VHLgTxxjcsqpAnXW8YNLv0jrQajSu+s1YS+Ycy3Drg1Y1pEFrAI/uEbrR3NJxckK6rXpSblW5NadUvR75fUxeIQaQASG1V8E0RpEhROoWMj17E5enMg6EChl9+RP1FG03lixeF9zo+iUT/5PuJ0iAOWwjVlQJBjTJQ9rSLCwT0bIMZAMPD/jF3gDgZaX+Akt5nPR/Mi6KCzoxMFf+PH2HWL81dJEYo0vc5rYpjf+KknvEVXgJLmDOsZFMEH6v+UPlwJGSUDuh9BfssNC57r3PhVMu1gxLpMn3gG2bq7UL0wxeapBnMut40P/iKaouH6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZDNJeRAhQ2hftMh3XngA9DXvWVxYQBB9Dw7alWN1mc=;
 b=IhcqOZJPtZhMFqnE/Jkn7KltHBqfCeQF3zNkUp3ShfKVm6OBggGHANB/gWvwi8yI7LDbdte9AgCYHoFdR7wHce7aT+ofhV6s02/C/c1x4ATOFaAjOj1mcHvg0CSDGkboj9KcGJKEGOZ5ox+V+ooP/DBU05xJe48ICwpRFEozPjI=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB7632.namprd04.prod.outlook.com (2603:10b6:a03:32d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 29 Apr
 2022 04:56:33 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::8db2:701a:a93d:9b93]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::8db2:701a:a93d:9b93%9]) with mapi id 15.20.5206.013; Fri, 29 Apr 2022
 04:56:33 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/4] btrfs: zoned: consolidate zone finish function
Thread-Topic: [PATCH 1/4] btrfs: zoned: consolidate zone finish function
Thread-Index: AQHYWxD51806VLnkHEKb/zvsvdOUaa0FfvuAgADV4AA=
Date:   Fri, 29 Apr 2022 04:56:33 +0000
Message-ID: <20220429045632.jlt2fn6chxubycbp@naota-xeon>
References: <cover.1651157034.git.naohiro.aota@wdc.com>
 <4d5e42d343318979a254f7dbdd96aa1c48908ed8.1651157034.git.naohiro.aota@wdc.com>
 <20220428161103.GD18596@twin.jikos.cz>
In-Reply-To: <20220428161103.GD18596@twin.jikos.cz>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e042d34e-8428-4efa-0f9d-08da299ca1bd
x-ms-traffictypediagnostic: SJ0PR04MB7632:EE_
x-microsoft-antispam-prvs: <SJ0PR04MB76323F0CD763422A5CC453558CFC9@SJ0PR04MB7632.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UqNDTl85t267omRhXHP8DP5E42906bKPXAvjltz3G11AxE+vzZXR+qmUccqQTh8Vn5IQEpnFwexh5F2udoV7VkSRJLF0Hm9jJlEZsaWnAzFPC3whL4COUyhfzqeLQr2MpaB0FvLy2+zVxF9chQBwk6iR0+6HqX6Ubn9cdSNj1pF5UgOHeSrWRL2QTke1Q/4TziN8TEOwAlVtMvfc3qTw4Hn2kHxNKxDtPjUeJQA3dOv3EOKLzQ52x/4cXmemCU7OldBOReSnC4FlhDqvvf3xy8ZLYhmCs6XdlW9z3PpPGJVG5A9AjO+psv8Y7gtXFu1J3YlqyzpxAhBPtzGpC6k5N/jDWDDC4xiFtwewECDIaElt4xvxYiR5oFSVbw+yT+EB8/UdVga+Y7HF7/mdYd162508tGRMEpOIe/kGiQ9rDHgY0i9GNHt4noiDaIT9SXyKI5/7oVzxlIYFxR/N5272qTQLEDo2wk2o7DwlJHqzDs87r6uzNYP4JRMAUCRi9ckpwE+HAdai+om1mWwfwkaGWY+ITmh1tlBbeSIpfQUBrZi9GrXxKRyuHo5xFsFxUzg1LmejxayuOsz3FEXgRB0t5Ps8VIyI+S2IwNUhAlUUZ35nEuh+NAvs3W35ls4eRLh4b0p9xM1+Yj1EHWCDvdU5hVUpDjtzr7oHfiUlU4gd14j5ofjqVLgDtJzc94vOqVDOvQwG0NVAbeunxMmOxXHyPA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(86362001)(1076003)(186003)(26005)(71200400001)(9686003)(6512007)(8936002)(6506007)(5660300002)(33716001)(110136005)(6486002)(122000001)(82960400001)(2906002)(316002)(66446008)(66946007)(66556008)(66476007)(64756008)(8676002)(76116006)(508600001)(91956017)(38070700005)(83380400001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7mkYuke2r1CcCLpI3QDQ1q86gQP003u7g19P3lWG14CQTC6e72eARz6daVab?=
 =?us-ascii?Q?2jeexFnf2Rw55QnGOMwSwv4xZua61x+77X/XirEf3L3joxwpcjalLmJFB9sF?=
 =?us-ascii?Q?Wt06vYHizefkH4nveQScXPPx4mdEutJV38KEwIiwmNXj7LQgT1qA7QpsBfs3?=
 =?us-ascii?Q?8ftAeII0qzVshgLighdyY+XpcaPraiYTYvAywV73i/ZsReCMv9ZifNKYGq/j?=
 =?us-ascii?Q?qoW4P+Mz3cyX2hK651RIqimoysPA/W2JdPf6RdPo0fjJftyXfXQfLxjLKH/k?=
 =?us-ascii?Q?lq88N8lBRj0jZguXESFEhdLBVW/ScmvCK6IKW+TfPalPOvFCw3tY/uWSQ49p?=
 =?us-ascii?Q?1PCpmdIfzFwzWyOj/8w8bcIoWhq75dEFnviIMxQuELr7b9vsy9BST16DlDBa?=
 =?us-ascii?Q?C7HkbjVH13LzXK3Rc9/l67e+EJw95YZwas0ItMF+e9zBf4heMq6uuNS5m9Wg?=
 =?us-ascii?Q?XB+6xJ4QpAKHZHFUdQiO4PTyh42SDrLNcQ5eCVh0YQ5Tlm41pP7VoHGkPqPD?=
 =?us-ascii?Q?yj4XQqMBHO/++2uhGQ2sD/vDb0TSXrG5SskEkdxrgGRACS9AsBMT930ZEVug?=
 =?us-ascii?Q?HmAee6/yJ4fcN44ps8EJZAH7eXl1vOzeFLyALgCTiUww060FDbubKzBdFCHu?=
 =?us-ascii?Q?ClidwpBK95VcUqI4FyL69P2F/VFC1KLEWv0pfouNvmOkzaHRCo89DWJqz1wI?=
 =?us-ascii?Q?OZqjyi48AWWVq7YXfYV2C+bSifNfzCQYJsBKsK7XtDzKRU/vJQKouzwIOAUc?=
 =?us-ascii?Q?wBr95dXc/jxIU9xEsXZwa8+D0ggWAxQ9SxLwEzZSaUUW4A/Kmo5AP/wiuDOP?=
 =?us-ascii?Q?5TD6tOdv6Rls9heRibA15/Qri5pKFyU7cF1LSw0nzBP+o8F7SZjIrF1jDQjs?=
 =?us-ascii?Q?CZAJIkwgzpknii2e31k08zNmHVNF04+cAvAJuwvJmXRZ19+QrzMfPP1UW7PT?=
 =?us-ascii?Q?FA4VUR7M1kJGIfcaFN7emr+YPrL8LP7SVEO5pu/xVfPYClgOa2RNUU9fD9Vq?=
 =?us-ascii?Q?acEbG/uyYJd+/OqeYl1IB0RN2IK3jpXoj/L7LyDpA0gLtPbM8Ivzy0VIINkO?=
 =?us-ascii?Q?qrx1J7JXW+gWTbWzxyLF2JsTVhtzlHD0iZcJhjZ8bbQZyXesrGDRbbrq1A6I?=
 =?us-ascii?Q?szHwCANUmRtNfyTAUUkwo8KbxrjYelQMdPwvtquZNdJSmxBibIwCTziAR6Je?=
 =?us-ascii?Q?CMqo0L+OsBSrMrWnq/DXILRiFjtFaj/kF/vpMiIuKNJMNCZtRHH6oLl2eDSc?=
 =?us-ascii?Q?W1uSWgfbJCQsGHIUv5a5qHbyE6cwEWnYU0SP3K9HrXwMCd+WH7y4UYddq/To?=
 =?us-ascii?Q?8Zp/NO0YHIu0ZZUswrlOgjbI0Umm3mvFTcoBdHM2nEcaPFuDgzVKIpxpHVYm?=
 =?us-ascii?Q?lNEtwbkkp9P+jPkjIT8Q0SMCk202OH/XbYf7iWN2SnRdhttUvLiPwlR0Gszi?=
 =?us-ascii?Q?2/cz+yPzb5qvGsh2jkhTQxAnhwUfuA6s+MqyvNlshxdtGMpw2FJuNBISyyHb?=
 =?us-ascii?Q?J/fYG7oEI8k3EQrZ8fIpYrddHHvmukK5E3z1PZvC0Tt7UbjN5XGOwWtqTHmS?=
 =?us-ascii?Q?QU3UP5dyqHCuch9SSJBdAw2n0TxvaIdWje2F+sDr5z2RJ4rwAG8yxxhEzDr0?=
 =?us-ascii?Q?3hqyeBmZHNRIwvx4QZd4K6IXw4DDnl/BfldWlNQalWF3YM6S4gwHWpqqya0c?=
 =?us-ascii?Q?fi7H1T0IurNVPughvZ6oLHCEFMRyN0qP8QaLH62+LDwd1S9VsP3o+ro1hpLm?=
 =?us-ascii?Q?Px28jVewCS3XFlCMoeQPMHmWr30pNE8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <472D492FD2FDC441BEAC046EA1389590@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e042d34e-8428-4efa-0f9d-08da299ca1bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2022 04:56:33.1349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RqNAL3AqvspoL3wql94VefjOB/TFRTC77X402aSPZV0gVjdNh2BeAvfwWSpIGYm4/CANgNKMT9oLQaqhYNIh7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7632
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 28, 2022 at 06:11:03PM +0200, David Sterba wrote:
> On Fri, Apr 29, 2022 at 12:02:15AM +0900, Naohiro Aota wrote:
> >  1 file changed, 54 insertions(+), 73 deletions(-)
> >=20
> > diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> > index 997a96d7a3d5..9cddafe78fb1 100644
> > --- a/fs/btrfs/zoned.c
> > +++ b/fs/btrfs/zoned.c
> > @@ -1879,20 +1879,14 @@ bool btrfs_zone_activate(struct btrfs_block_gro=
up *block_group)
> >  	return ret;
> >  }
> > =20
> > -int btrfs_zone_finish(struct btrfs_block_group *block_group)
> > +static int __btrfs_zone_finish(struct btrfs_block_group *block_group, =
bool nowait)
>=20
> Can you please avoid using __ for functions? Eg. the main function can
> be btrfs_zone_finish(taking 2 parameters) and the exported one being
> btrfs_zone_finish_nowait reflecting the preset parameter and also making
> the 'nowait' semantics clear.

But, we exports both btrfs_zone_finish() (the waiting variant) and
btrfs_zone_finish_endio() (the nowait variant + checking the left space
after write). How about "do_zone_finish(block_group, bool nowait)" as a
main function and "btrfs_zone_finish(block_group)" and
"btrfs_zone_finish_endio(block_group)" ?

> >  {
> >  	struct btrfs_fs_info *fs_info =3D block_group->fs_info;
> >  	struct map_lookup *map;
> > -	struct btrfs_device *device;
> > -	u64 physical;
> > +	bool need_zone_finish;
> >  	int ret =3D 0;
> >  	int i;
> > =20
> > -	if (!btrfs_is_zoned(fs_info))
> > -		return 0;
> > -
> > -	map =3D block_group->physical_map;
> > -
> >  	spin_lock(&block_group->lock);
> >  	if (!block_group->zone_is_active) {
> >  		spin_unlock(&block_group->lock);
> > @@ -1906,36 +1900,42 @@ int btrfs_zone_finish(struct btrfs_block_group =
*block_group)
> >  		spin_unlock(&block_group->lock);
> >  		return -EAGAIN;
> >  	}
> > -	spin_unlock(&block_group->lock);
> > =20
> > -	ret =3D btrfs_inc_block_group_ro(block_group, false);
> > -	if (ret)
> > -		return ret;
> > +	if (!nowait) {
> > +		spin_unlock(&block_group->lock);
> > =20
> > -	/* Ensure all writes in this block group finish */
> > -	btrfs_wait_block_group_reservations(block_group);
> > -	/* No need to wait for NOCOW writers. Zoned mode does not allow that.=
 */
> > -	btrfs_wait_ordered_roots(fs_info, U64_MAX, block_group->start,
> > -				 block_group->length);
> > +		ret =3D btrfs_inc_block_group_ro(block_group, false);
> > +		if (ret)
> > +			return ret;
> > =20
> > -	spin_lock(&block_group->lock);
> > +		/* Ensure all writes in this block group finish */
> > +		btrfs_wait_block_group_reservations(block_group);
> > +		/* No need to wait for NOCOW writers. Zoned mode does not allow that=
. */
> > +		btrfs_wait_ordered_roots(fs_info, U64_MAX, block_group->start,
> > +					 block_group->length);
> > =20
> > -	/*
> > -	 * Bail out if someone already deactivated the block group, or
> > -	 * allocated space is left in the block group.
> > -	 */
> > -	if (!block_group->zone_is_active) {
> > -		spin_unlock(&block_group->lock);
> > -		btrfs_dec_block_group_ro(block_group);
> > -		return 0;
> > -	}
> > +		spin_lock(&block_group->lock);
> > =20
> > -	if (block_group->reserved) {
> > -		spin_unlock(&block_group->lock);
> > -		btrfs_dec_block_group_ro(block_group);
> > -		return -EAGAIN;
> > +		/*
> > +		 * Bail out if someone already deactivated the block group, or
> > +		 * allocated space is left in the block group.
> > +		 */
> > +		if (!block_group->zone_is_active) {
> > +			spin_unlock(&block_group->lock);
> > +			btrfs_dec_block_group_ro(block_group);
> > +			return 0;
> > +		}
> > +
> > +		if (block_group->reserved) {
> > +			spin_unlock(&block_group->lock);
> > +			btrfs_dec_block_group_ro(block_group);
> > +			return -EAGAIN;
> > +		}
> >  	}
> > =20
> > +	/* There is unwritten space left. Need to finish the underlying zones=
. */
> > +	need_zone_finish =3D (block_group->zone_capacity - block_group->alloc=
_offset) > 0;
>=20
> This could be simplified to 'bg->zone_capacity > bg->alloc_offset',
> but maybe should be behind a helper as the expression appears more
> times.

Yep. True. I think extent-tree.c has some of this. Let me check.

> > +
> >  	block_group->zone_is_active =3D 0;
> >  	block_group->alloc_offset =3D block_group->zone_capacity;
> >  	block_group->free_space_ctl->free_space =3D 0;
> > @@ -1943,24 +1943,29 @@ int btrfs_zone_finish(struct btrfs_block_group =
*block_group)
> >  	btrfs_clear_data_reloc_bg(block_group);
> >  	spin_unlock(&block_group->lock);
> > =20
> > +	map =3D block_group->physical_map;
> >  	for (i =3D 0; i < map->num_stripes; i++) {
> > -		device =3D map->stripes[i].dev;
> > -		physical =3D map->stripes[i].physical;
> > +		struct btrfs_device *device =3D map->stripes[i].dev;
> > +		const u64 physical =3D map->stripes[i].physical;
> > =20
> >  		if (device->zone_info->max_active_zones =3D=3D 0)
> >  			continue;
> > =20
> > -		ret =3D blkdev_zone_mgmt(device->bdev, REQ_OP_ZONE_FINISH,
> > -				       physical >> SECTOR_SHIFT,
> > -				       device->zone_info->zone_size >> SECTOR_SHIFT,
> > -				       GFP_NOFS);
> > +		if (need_zone_finish) {
> > +			ret =3D blkdev_zone_mgmt(device->bdev, REQ_OP_ZONE_FINISH,
> > +					       physical >> SECTOR_SHIFT,
> > +					       device->zone_info->zone_size >> SECTOR_SHIFT,
> > +					       GFP_NOFS);
> > =20
> > -		if (ret)
> > -			return ret;
> > +			if (ret)
> > +				return ret;
> > +		}
> > =20
> >  		btrfs_dev_clear_active_zone(device, physical);
> >  	}
> > -	btrfs_dec_block_group_ro(block_group);
> > +
> > +	if (!nowait)
> > +		btrfs_dec_block_group_ro(block_group);
> > =20
> >  	spin_lock(&fs_info->zone_active_bgs_lock);
> >  	ASSERT(!list_empty(&block_group->active_bg_list));=
