Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B41760F34
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jul 2023 11:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbjGYJbZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jul 2023 05:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233266AbjGYJbC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jul 2023 05:31:02 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7158930C1
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jul 2023 02:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690277344; x=1721813344;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xim1nfyzihD/dsweFJNCeWNkhEBLg+vKkLlJo7pOnHA=;
  b=YH8fDrbjyICxndXgb2UDkLp8nBv0VpLYFnZwLUPruH6G8fCmrSs5KT33
   1jydbZbKZlV5VtBeG/ylHAQ8nXGJv/9T70Ut0rV+S11S8w7GSSMiyBfWi
   LijJac9Vp6MsoMBFpIxMBqvxkdMBQEGjbidNigOM9PaZoAklYsvHXa1EG
   83DFwiOJEbDm3yQP/wytrhBsflhlCwnUaHxT5hUoYjGNLD7npI4kyD+TH
   NNw6+Rt46ertQssbdyUxjAJwx6ZwJ8N/G/LZ3cGtKjSRt9H84K6vMvv0n
   E2Ml1rF4HBVyZ66UiXuh98tbG7RZgeOB07GY5vwlPVDt3GDZ/KySXDvaA
   w==;
X-IronPort-AV: E=Sophos;i="6.01,230,1684771200"; 
   d="scan'208";a="243652493"
Received: from mail-dm6nam11lp2173.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.173])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jul 2023 17:28:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcuaXo7QQupPiD2Fqv4zW84mlGUYgvHstUguRdlHys6gD7QzeoxY84KesuBCvp/tzVoCFsC0gFmcLOGXtRgNzOlsz4uirpdluplDIBa1St8JrX0Nx1fv5miIH2nn6Dc+pdKCsk4m3Ply23P6+oB4jhj9rnwHD1k/Vkrz/EXAPHeLEeTf6A/k2lObbhqfx6A4R70j7dchntyCfKRu54v+x0Eely/eKj0iPbdEt/LlZz8iBY89JxE8EFdpttv9xgmRNbGFTVqCvewPZv3OW4bIPK00mnnMeyhWyfd3bEpLR2+AxLTOHgBwkSznOOhMkLQMz9L9xvtzi53XYaFFKn/3Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2mt1jxjtfg68Pr92p7vUgxC4nAhGQkK8bMaNEADeNI=;
 b=TRYM/yrISVYSVBLqIDbdzmr1q5nkaSAlIElflJjiLDdIzvlMB8tTS9KNZhm73pTwe5XW/dtvrhFT4wSMqmbBl7cIsUda2O092aBynfZmaMqYWQ4+Ko18ZP01MwwR0k6khXXCrzQGq6fk68dJ03kELCGM1NRR/CDzKvDNc8j/YQ+XLk9fikqmcVpnzvRRZkJMXyP61cP3IdJ02PEu3Yu7PF8GGSGWvLyk6Y4VKXhq1/HS/KaEd3WdoDn9gkSv3qdW2vfpWDcEXngSPBZ72Sw2ej5H3T5oZUDQ3wsHKjuOoI/azOY2c+xgHy4DVrK46h1K1Z/70b9bjYa3JMNeADvmpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2mt1jxjtfg68Pr92p7vUgxC4nAhGQkK8bMaNEADeNI=;
 b=AHAQejUe3hfScHA2mCtUCO6Kjz1tG5wARmYFY6Aehf0R35I2CHUSuLZ6qaHwBH/zL2yOJ46sThGNW13x/VzCEMI2HPIWPi2ttk9x+CX+56l2StGmUel3A7yRyDJdLKUABT8yyv0f22my6aDInFMZyupanJiF1p63VVDaGH3W9TE=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SN7PR04MB8644.namprd04.prod.outlook.com (2603:10b6:806:2ef::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Tue, 25 Jul
 2023 09:28:10 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::95cf:429a:bc0:991]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::95cf:429a:bc0:991%5]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 09:28:09 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 5/8] btrfs: zoned: activate metadata block group on write
 time
Thread-Topic: [PATCH 5/8] btrfs: zoned: activate metadata block group on write
 time
Thread-Index: AQHZveX/e46fW+rbQU2ciKn0XmRRuq/JBrgAgAEyIoA=
Date:   Tue, 25 Jul 2023 09:28:09 +0000
Message-ID: <3bhaod54j3jasck454wbqaovmyaraxbypz3umcd24v6jmx76xp@vh54twyvcpns>
References: <cover.1690171333.git.naohiro.aota@wdc.com>
 <2f8e30f966cfd9e06b0745a691bd1a5566aab780.1690171333.git.naohiro.aota@wdc.com>
 <ZL6U3DYVw9JHLUC6@infradead.org>
In-Reply-To: <ZL6U3DYVw9JHLUC6@infradead.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|SN7PR04MB8644:EE_
x-ms-office365-filtering-correlation-id: b3c869e5-8744-4529-35f3-08db8cf175f1
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OE7Xp6TO5fifgx4Rip1KheamxZFRtjqEPnQsqMxgeh5U+SpzH/suIAigKlUFP95PJu59GjSagRrpPU7dX7fz6sAX/F2077H6k5e6l2HdbRzU5r2sow8iFToieWSGFNNXMlZgKDw9kfGDNm2ZVD9G4WrSUBcrGpp54DBX+oS+CLFBOkaJP3xe/5gvMcBun6i4zlcbl0AonEfuVGS564aygrP0w3ifk8tR2weJ9nImi+A5w9fF4SKya7ktc4OpokEt5/QIC6zLEvmMwfj73tNqrMhpHf4qv2/cRJ0w0LR5iILM1qenFz6jRf+5+byIHFZEYTbnYNLE9UV/hweKftfCfhYctlFtxjFnYLLjpFDKujBUSRZWnNeq0RK85X0jJSt8sqyeWUzA72MwJ8gnlUxrB+S6a3zEzUjMoC4j9zhRSMdgKTz+hiObxPd0bBLm/c1BzwTR96JAVMabIrIBTJYKeib0Y9QzkjtJPTmotJrawBksJr6fYM7DwPkcSV5xKUmBSEHsiHItFOiBOjt1H0x8udsNjwWBZFWNnxWO+ZudgwvWoSH5QS3wXNy9pdBTH40QN0LPsZysvDOiYCn+5zv13+Rhlv8c5sdYqnKZUs0yMxRhY10lKf0+bBO1TCZEqRJs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(376002)(136003)(39860400002)(346002)(366004)(396003)(451199021)(83380400001)(38100700002)(33716001)(122000001)(38070700005)(82960400001)(86362001)(478600001)(2906002)(186003)(6506007)(26005)(6512007)(6486002)(9686003)(71200400001)(8936002)(5660300002)(8676002)(76116006)(91956017)(316002)(41300700001)(66446008)(64756008)(4326008)(66556008)(6916009)(66476007)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8MNHIxJs8sblzPK5KFe8C/rFYKCFwZEpYQ115vxBIgqxQzz4A6LPI+bCfq4M?=
 =?us-ascii?Q?YMGScT8vCDNW4S9ypQ+h+N9/Nyy9X45qamjT9cra6KcQSFwljgrWpnOc0Onk?=
 =?us-ascii?Q?k3cYmwSkib26kM1GjWpcV/k/Bp3zfzMuHcZzl7Gp79Vn2BCGkMvnNyvlOLsu?=
 =?us-ascii?Q?k+DH5mmcYV9XGWNTgRMhen0XmSAColM+LMtwUbL8892e3jMMXrrPpuqFonsx?=
 =?us-ascii?Q?96XAadP0WzBDFlXapKpPruznAqAadnnuh27S/Wk0hcXrhZyCz7bs5hcb8pMr?=
 =?us-ascii?Q?k4ebDo+475JbmTtCWoAUVJYke+MMO3kMfUzFggrBZ9pc7jdSd68x+jJEbj2T?=
 =?us-ascii?Q?oPonZWechJX9ylb6XaPtPrEl0Lco3cYxVFV+JOIjhKlt/ubusOZlmL3JOUlu?=
 =?us-ascii?Q?5bUtLcNEkV+vmxA6/F9/R/VYGHHNo2WljD056lFl931iQVsLVY8TQrtwnzHn?=
 =?us-ascii?Q?vhhFV7BMolBbeGOFDjF8BJibmlJktM6pDb2lz7tULB401cTc9vzIy//Ue/Gu?=
 =?us-ascii?Q?k+YxTFoLgegu+vdtn/Q3RbCk8UFVTpqO27YcsVKN4fSyluAcF4vahrF7tgA9?=
 =?us-ascii?Q?frQr0jeqg0ATbS1UMOb49ljEBdxiOdGuTnei4T3UeVRRkhcQlzzY2oxPW2ec?=
 =?us-ascii?Q?l0aKLIy84PCz8cyPTVzuUgRVY59G+xekOi9lUS0CeK/iorlnqHt0OodjQXuR?=
 =?us-ascii?Q?I42pCU41y0w+iHyb9bPpWfjO8KXULnZoSlpFHk/+MB1OZrt+S760C81FaLKg?=
 =?us-ascii?Q?KVii/Of89XGyvPHLSuk3JPPy0Frlk19j/drC++l4mkECXT/Z2Ym3jg87uG70?=
 =?us-ascii?Q?fm8nIiRE41x3HBBXaHvvNrHOyS4YcQapQPskOD5r/DxCaZRX/mz/ovs/0PDx?=
 =?us-ascii?Q?OcMsOrpLzh/EJ4CpBcOpgpkL55WnmbpQ8I6+Kfj1FCkQyC2gWNA9DY7L3jFe?=
 =?us-ascii?Q?DD1HDcS+JosARIn3HKT7r3qrdHHrUOBOKxwE0pijWIk8RlTIYc+8ZR0txJpH?=
 =?us-ascii?Q?X6NVKXbfl0zBnnv1fBCCbl+3pLElcsPUxSj41Vxg49pzdPcG9YvwxfqlfXLf?=
 =?us-ascii?Q?Mli0y3UwCez+Efd3loRUQRF9Wn26g9alGkSI2AH94XpmVeMtLZZDmiGyjm1+?=
 =?us-ascii?Q?TT+LwiuT0EflouvrOX5D1d1k+iGaRV9Futfk2bo1GnClu7VcBVvuq7Z0VvOc?=
 =?us-ascii?Q?b29VsrX0Ca88d70HBmWyOWtTcKHtcVNAT0FGpcKcCpTasQEmliMDJvJYJsLb?=
 =?us-ascii?Q?wpCKB+m8ozc5OCz9/2Codlzo2E7ctpK5UoR9pv01mxy0D8TbhaS8trsHd67O?=
 =?us-ascii?Q?voia5a4IeQ1lefE/TBiBJJT87c5Sce3IOPbFgMzYc8NgnN+s/FZsZ3u/jDTm?=
 =?us-ascii?Q?aIVZmCZc4GVlYiESQ6/iLVr3yo32zqfSMprzDIQQiWes58wpKd+EC2usmuXf?=
 =?us-ascii?Q?dWV+msNwphwx7vBzT4NFORwUrjZRIhjiM2KFRttkhdgMjWGuQTrdAafDVuzs?=
 =?us-ascii?Q?rCSwZ5oae23v5tzl+IHzkrePGa7Rc9/ymaYjTMxoiYh4B/M8NADP36PJDsdW?=
 =?us-ascii?Q?F9ufKQIWB9vg8n3A4f2NulmLLdXw2BJdTrIjwgTw6jQ5Hvm0vM0Mv/IDKR+N?=
 =?us-ascii?Q?oA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <459ABDA4A6A25B419F66D23E76F2AAB0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: s0WpLc+U/U+mXqa84Y6KpOlsuQP9wHSZuHITl2T95JdoQRMc+AHFGninY/LqqTTMbHnezFuYwzwHIHbGZWGpFNmBwPcQNb8HA13nV9+MPi/6TyWqH3/L9LkXEJJpoCAsY3EkypUrSnIMMm7nwlntQyUnIlu2wH0CptC6gIW0FRnebjImfssr1W1JokwftIXQ0eyebEeNqYmkcD1SN7Bw4ZAQWLOXbY0lpqiOhiATg4tEjdUnQi0SU1K7ZTFqIu3cH9ILzumE/Zm60+JvzMC6iqUZeNdRQ/37e7GbLS1VVHUs5/EfMuxr81Tvo4B6dVbWlpiSHuoUlLRBthDiaprnZ6FJSqlUe/e0PfajuGkr7uaMnrXIyFqhJPCY96Dd+sOwgARU9Xm998seVwTUnZBl1AfKFn+VkmcUcvjcNBa8rruIhapdz6EwZ4nAzqC1V2A06INpbom1Drk6fQZ2c9I9B1sC7ZQTNQFEi2C9tvYxeQvxNwgrg0o/0A62/Xqc6P3C5EPW/iVmsL8aUIigXdkh1rEXv2dlu3GPXAnAkMchEOvrZJPxEZ1q+xuWpLv2YmTPN2C23/smLvfRSOvKDEpZbmZYFCvDKcREoDMpvepw048jqIw4gu4p209hBVYuMtLHs3Nt1/O108x5LoTlUakWAO08S182RMpgbXztQbjKcN9wkLx8IioMuSIwbdPxe/2mdHQoe/kc9M8+xIj5qyEMaMEFn8tCXV7q6DG0p/Z3oegFE5dXWdnrrPe1378IK6CPJf+Tr16KpxjzXc9AkRuoGNJzDOkFS1cbAz17LOXXQDy3teppPaGYjTXzlrCT5d0W
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c869e5-8744-4529-35f3-08db8cf175f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2023 09:28:09.6613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sxwEdS9hfEZCS5DVFngcsTtpb9ixQN8doWZLu8ZXwKLn54DJFl6qCLzpbmb+EKBBpLhu8SnjMbKJeHzGe7SOnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR04MB8644
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 24, 2023 at 08:12:28AM -0700, Christoph Hellwig wrote:
> On Mon, Jul 24, 2023 at 01:18:34PM +0900, Naohiro Aota wrote:
> > Since metadata write-out is always allocated sequentially, when we need=
 to
> > write to a non-active block group, we can wait for the ongoing IOs to
> > complete, activate a new block group, and then proceed with writing to =
the
> > new block group.
>=20
> Somewhat unrelated, but isn't the same true for data as well, and maybe
> in a follow on the same activation policy should apply there as well?
> I guess it won't quite work without much work as reservations are tied
> to a BG, but it would seem like the better scheme.

Yeah, we may be able to apply the write-time activation to data as
well. But, there are some differences between data and metadata, which make
it not so useful.

- Allocation of data and writing out is done in the same context under
  run_delalloc_zoned(), and so they are near in the timing
  - While, metadata allocation is done while building a B-tree, and written
    on a transaction commit
- No over-commit for data in the first place

> > +	if (test_bit(BTRFS_FS_ACTIVE_ZONE_TRACKING, &fs_info->flags)) {
>=20
> Just a more or less cosmetic nit:  there is a lot of code in this
> branch, and I wonder if the active zone tracking code would benefit
> from being split out into one or more helpers.

Yeah, I'll create a helper.

> > +		bool is_system =3D cache->flags & BTRFS_BLOCK_GROUP_SYSTEM;
> > +
> > +		spin_lock(&cache->lock);
> > +		if (test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
> > +			     &cache->runtime_flags)) {
> > +			spin_unlock(&cache->lock);
> > +			return true;
> > +		}
> > +
> > +		spin_unlock(&cache->lock);
>=20
> What is the point of the cache->lock crticial section here?  The
> information can be out of date as soon as you drop the lock, so it
> looks superflous to me.

The block group's activeness starts from non-active, then activated, and
finally finished. So, if its "ACTIVE" here, the block group is going to be
still active or finished. It's OK it is active. If it is finished, the IO
will fail anyway, so it is a bug itself.

> > +		if (fs_info->treelog_bg =3D=3D cache->start) {
> > +			if (!btrfs_zone_activate(cache)) {
> > +				int ret_fin =3D btrfs_zone_finish_one_bg(fs_info);
> > +
> > +				if (ret_fin !=3D 1 || !btrfs_zone_activate(cache))
> > +					return false;
>=20
> The ret_fin variable here doesn't seem to be actually needed.

Indeed.

> > +			}
> > +		} else if ((!is_system && fs_info->active_meta_bg !=3D cache) ||
> > +			   (is_system && fs_info->active_system_bg !=3D cache)) {
> > +			struct btrfs_block_group *tgt =3D is_system ?
> > +				fs_info->active_system_bg : fs_info->active_meta_bg;
>=20
> There's a lot of checks for is_system here and later on in the
> logic.  If we had a helper for this, you could just pass in a bg double
> pointer argument that the callers sets to &fs_info->active_system_bg or
> &fs_info->active_meta_bg and simplify a lot of the logic.
>=20

Sure.=
