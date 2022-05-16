Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF94E5287E9
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 May 2022 17:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237967AbiEPPEo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 May 2022 11:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiEPPEm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 May 2022 11:04:42 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9653B3FA
        for <linux-btrfs@vger.kernel.org>; Mon, 16 May 2022 08:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652713478; x=1684249478;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=opKBaICCpeN6JfDWsCvKrKx7CxO0YdLKa3QGSo/HMQQ=;
  b=lXPs+oKSF1fF1kt03BQfiy+IjlFX6UMa5K3f1nAsl8oOmCf37RlhaKcW
   Y9vrffIIHuOYmVVIVEaNqtfuOkUgoQE7kUdf6/kU3RTVvEMz6CYZcJ/ha
   ZyDwKv8HiGFPW7cVHVClwxddLkNE40CTMjNNnnA/gdKLbbdqjK0C7IPxC
   Bi5pDjqzQDvayE12SVLSOvnsx/yHoLAAUmZnmuOSreMM1frl7fHV7g1BF
   wcJKvYsDuzEYiXG0vIaebaqbjQTzP0KtxubFp14g1B3uADkubz1R2NvAs
   Is1vh083cHOpVbEQwrIwel2mx/jH7eEC222uGHillbooDJfr+bh6NYf4C
   w==;
X-IronPort-AV: E=Sophos;i="5.91,230,1647273600"; 
   d="scan'208";a="312425308"
Received: from mail-mw2nam12lp2049.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.49])
  by ob1.hgst.iphmx.com with ESMTP; 16 May 2022 23:04:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7HyAunpajCE995xn+13YTHnZSd/Xn2/kXl/sGSFWACZo7H6mofwhUNFyqmQn0Pj+qM+urDBXNbwq0Y2mmU21Jg5oWqDxxQb78lNj8lPHzGUTPqlcEJ/rqXI6ur1Bb/5RZ9AJrp0w1tGzLj3+0OGOg14xP7JzHMNf8x/cnQYZTtw31GF48WlO6Hhl+HuRVEynyUAt6lBHtBSv6Hrr14j8jvln7N2T52Fyr7an9nR2pnS/lkv/77f8hWGri9ljfyTa2vp0tBvUvBsSNNux6F+Imy21vvZgfhp/y0t0kiGVVoE3DYfemE/ZAFbYygGZhxA2cVxAxYNFjmUgffohV3H6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZvVNOepQgfFbw93IVGsr2fMpGlwFWm4sbRoAWHcAtyQ=;
 b=UYgVOyXdbBV7Nwfrl93EjvgtiWZtC2/9HgWLxooP9e7OPipfrVVNoLr15tL8aaWr3RqDrUAxGOlyXlHf8t2k64X8wl0cH+dw5b6juwT+gPpIgepLUhWbOW3DlHyaG0mqir+Nepy1p6RPuqK0MELgWbCLr9PlsPx2MeEXQ0N7XPrVEDmMuG0pTbRG7dztYChLQXYS64KflaEy/VNOeaMiW0pvQCAl8SZvrN/suM71rb7+ukmE3ba4SBdeisr9Ty8+3k3LiX8B6nLmTGWnd0iOmNQNIQ/3IFy9KnWbXGZnN2dFwEjJlqppBVez8axSGPHEWDdbr04HMuuss85EH2GrOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvVNOepQgfFbw93IVGsr2fMpGlwFWm4sbRoAWHcAtyQ=;
 b=d0YZ8Qzb5Cv0aTs0YzCbD2lY975SZEapAv5Z9g33eujyBWMAlb1Yux4soIQFmo8Y5e0d4sS5L4ZklnCxQNgdHKd52CcoxXrZzKYhj1hIgNnIif2zMlKycwsJfJ6OTq7iv8Z1wIOohYtAP4+hgVianCHQWP+ZzkFpE+fA9XlL70o=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL0PR04MB4673.namprd04.prod.outlook.com (2603:10b6:208:45::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Mon, 16 May
 2022 15:04:35 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 15:04:35 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [RFC ONLY 0/8] btrfs: introduce raid-stripe-tree
Thread-Topic: [RFC ONLY 0/8] btrfs: introduce raid-stripe-tree
Thread-Index: AQHYaTGyNcHorGSGJ0SpCqziAWVW1w==
Date:   Mon, 16 May 2022 15:04:35 +0000
Message-ID: <PH0PR04MB74166206230DEAF4BED182B99BCF9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <YoJmpxKoIUKWyevt@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 306665c6-e418-445f-009b-08da374d63c9
x-ms-traffictypediagnostic: BL0PR04MB4673:EE_
x-microsoft-antispam-prvs: <BL0PR04MB46739FD20B6D8B9A44FF7E619BCF9@BL0PR04MB4673.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kfwwgHK+2foxDdhZT7r3nsMXmgfm8uY4d/P2WEDoZ2lOdRFFvJ8cBGjq3v5JgSOOHWfWTBgDOH5dp+Vb16L8dGlhbVnruyPDXQGQaz45HVWtZbzLFKdeKbNdg1Ub41+lReDEHQVX6SRp6nk+xeQ2C93Ynnb1oA6+ARKxNIltiOvCMxdBn/K/6fkrczjqtInjlyKRhInHcYnIv7n8bNAP299cU+riAnf+wyG3wktpFgrGhiM/kig51II9Jk0ovA9Z+FQBWEAaZbb4E0rF4rAwqejnX1vJwg1gbCosad2ezHgKtSWwlip8tr02ia/WkVukBypG8MW+mhdYBnxT5Sr5US128OwTsT1yAfMSfPENVR/TgvX0m4kL0NAGMdFKhmvbv2WZM0OHsS5TY9XoxgXgzKuSVYakWdbQM9J4kmg6kJSuBO+AHKlYaMh+38YSr5hLT+vQEVfT1bpdd3t/gl8eHdjPfObxalZFUtRrF693UhIvu9PTF5o7M8KDqsY6akp+uWFqdUSCp0Q1w8L4PYufeFQg1l2MfosFX3J0AR4Oc/Uhptz+THqE58MhUYxO3+5Jw2Mfkm+Inu9ajgPWAQAMmMaaDynh+ut57WjFrDIdcEQbpS9+r2qJLQjtRhREH5z3CBAgWpbIkuWDglD2/ELQ6NO3ny1ajPLBn5Cu+OVbTGH0jKJKX63sHuS2M7Oq4HH3xg7dbrKvqoNb+LaETL16aw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(64756008)(8676002)(91956017)(4326008)(76116006)(6916009)(82960400001)(66446008)(66946007)(66556008)(186003)(8936002)(38100700002)(38070700005)(508600001)(52536014)(86362001)(122000001)(316002)(33656002)(9686003)(5660300002)(71200400001)(6506007)(2906002)(7696005)(66476007)(55016003)(83380400001)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Buxv7Er2J6pi0R3Zmwi9wPFcDrIpKwftLm49pQ+iMQcfxW45RhWg2W+Fn1bX?=
 =?us-ascii?Q?JoJ+1jlYoOT9CSBh7txPEmVZOo+GZMjHkCiWfhORck1kaLC10jQMjs+Mi7hD?=
 =?us-ascii?Q?uxCUDkDSsnEMUBdx6QOsF4TRceiHguP0pB6icjz1tfKESNiAfhp7JcBvOb0L?=
 =?us-ascii?Q?NYhmO7Jf+vNyV/KOFdKg1tAH14wL3Rm52zhKpus/gYDZR3QeNQgF5KFzqdOh?=
 =?us-ascii?Q?WRilD1ViimAJmb/36bWWy/IfDiE1bj4oKwWkVrb+ff/txRnhR95cylS1xfwR?=
 =?us-ascii?Q?9c8KUGXubwPZpECgtU/RBYMCqUtE1lldLkHNKg4sOJ3PuTL4eisEoJMbsR+A?=
 =?us-ascii?Q?BcO/gysYJzvoJhFFCmfxLgZ5STriUgAEN3dASRF0H0gkVp4cxipbRm9sqm9B?=
 =?us-ascii?Q?NXurLCw8/CcYQaRWr7HsPqg8DpU6UUHFWEfbmFJZI4urXKcZOw3Tj5JM7ABT?=
 =?us-ascii?Q?ZWPob8hFlrByhkdZ2DZzHlreM60Dhs2NC/8F2QmJHj4vXIJMTvv0IgF3VDmi?=
 =?us-ascii?Q?otB0RvbjQlYTlAnMv9v+d690Y8l5b++KlXhr50QrNhqeX/T4VZqqeTt8qIDa?=
 =?us-ascii?Q?aV9DfgfuAGrZ7YW6UWkyZNb04m/N3xjwOZ3gMwLFxO75kAkx3A6jFVWtEm7k?=
 =?us-ascii?Q?EjBAjikmKYFTGeb0Evf9Q5HPMgcvAAKnBk3QYl5llWxe3NI037Dxk/Jhv8ON?=
 =?us-ascii?Q?YM1uoF981En+ZDLcmP6ZQarjrwUymX6qbJC1bO+/VZF4ynObwb/zzqQjGfVx?=
 =?us-ascii?Q?Nk78vOXeK32/9WFze6M5zGkIYt7oRVoUtujs9VYtCHJ4QHuXWFqsnB/dbH4E?=
 =?us-ascii?Q?TgenmaCWrN41/4nOEVMX83y0kmm6jdPo2kpNoiYhHsNOwqiJLWCN5WhtyBnb?=
 =?us-ascii?Q?slKUQ+hWgH2Pvvh7t+qxNYuE48pDCPCahQ/UI5kdCmQhIZ1cLrM7t4woyGV5?=
 =?us-ascii?Q?i4oarrP9aUvwo3dnldT/0u7cULb+y2cvLMaIUNUyafZn1aZ+kkMe6m1kS+8v?=
 =?us-ascii?Q?5eN3TMO6NE7TO/tvtO36YJVjuCXZH17wT/OKjdcf5GLCYpADuksCcET4pC/g?=
 =?us-ascii?Q?voav+RnK0mJCO7TzlZtwbPI6g5g9/VFuBPArx8UEc1Shr+TfBFvjIkTSx8FE?=
 =?us-ascii?Q?xj6iXBYNuXF9J1mmIcUP9fjSLUWDSChH9N46JdKuo8e7ENxJcoH6SQVnZh7B?=
 =?us-ascii?Q?Xi2DZzOl2QMXBTAsej0lc2zHB0q5ov8X9eRNwK4IGtiDnj66xyVY+ZooAiQ/?=
 =?us-ascii?Q?Bsg/sI9/DoHz8oj3n8Ei4bZ9mlrjwoB/Odj6/GluBrVodh+gBaPwmxhM8Tc9?=
 =?us-ascii?Q?TcbW5cWpEN3vFeEQafnvoPPG5/SHP8CdqJNcLkNd6HxK04kA9NzT03w+m5sG?=
 =?us-ascii?Q?WVBR19tnY14SDVUKj4tQT3CFVzBhMWPETpgCfdHYIO1pvvRppySz4bi3IU9W?=
 =?us-ascii?Q?Dl2Ib90K4AWb2IiqKb/Fh2Rg/2zGxrjzm3te2+MGvFsWmakNrhdGTA4ewlwj?=
 =?us-ascii?Q?mbNAGVKD6GIUFmZ842yBfdYOnPkl/mcfjAEzBqcKMEoRkaeHQmA3SoNKRHFs?=
 =?us-ascii?Q?rKhfmU8beETJUX/oUUQGnSALA+Oca/bf2vw7atf2O5h6HGGmErxPPEuBHCNv?=
 =?us-ascii?Q?s9vPSWSHi6IOawhZ9yVzrrwUwbp9D7FDnNWSFvR5GHvfGMyf+3HRTz5q4hd/?=
 =?us-ascii?Q?+vYP59iQ1edmlpUXl6NNT/unGQJtADQKkvZIO5px1qBvDb2cEhu00+u57roi?=
 =?us-ascii?Q?t0JDbQ1OGTOIwZVmyEEjFLu0VNeUjDDd5bC6rWfNGLd7Wxm1LPM9aIJI8yIv?=
x-ms-exchange-antispam-messagedata-1: C6uvIhWtQUbklA482DonirsxlzlBg6ml3dov0oMB8BwxvBUfLoM4ib3v
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 306665c6-e418-445f-009b-08da374d63c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2022 15:04:35.2160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 05EO1jxpt29bkN2xBuKaWTPLGHV0YxO3kgIldZpFZxxTpJVbPfVEv9SjgoeklpRe8lGAzEHfPMK6cKK8sSLx9wrYUI8ZupGjklvnmGgTpmw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4673
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 16/05/2022 16:58, Josef Bacik wrote:=0A=
> On Mon, May 16, 2022 at 07:31:35AM -0700, Johannes Thumshirn wrote:=0A=
>> Introduce a raid-stripe-tree to record writes in a RAID environment.=0A=
>>=0A=
>> In essence this adds another address translation layer between the logic=
al=0A=
>> and the physical addresses in btrfs and is designed to close two gaps. T=
he=0A=
>> first is the ominous RAID-write-hole we suffer from with RAID5/6 and the=
=0A=
>> second one is the inability of doing RAID with zoned block devices due t=
o the=0A=
>> constraints we have with REQ_OP_ZONE_APPEND writes.=0A=
>>=0A=
>> Thsi is an RFC/PoC only which just shows how the code will look like for=
 a=0A=
>> zoned RAID1. Its sole purpose is to facilitate design reviews and is not=
=0A=
>> intended to be merged yet. Or if merged to be used on an actual file-sys=
tem.=0A=
>>=0A=
> =0A=
> This is hard to talk about without seeing the code to add the raid extent=
s and=0A=
> such.  Reading it makes sense, but I don't know how often the stripes are=
 meant=0A=
> to change.  Are they static once they're allocated, like dev extents?  I =
can't=0A=
> quite fit in my head the relationship with the rest of the allocation sys=
tem.=0A=
> Are they coupled with the logical extent that gets allocated?  Or are the=
y=0A=
> coupled with the dev extent?  Are they somewhere in between?=0A=
=0A=
The stripe extents have a 1:1 relationship file the file-extents, i.e:=0A=
=0A=
stripe_extent_key.objectid =3D btrfs_file_extent_item.disk_bytenr;=0A=
stripe_extent_type =3D BTRFS_RAID_STRIPE_EXTENT;=0A=
stripe_extent_offset =3D btrfs_file_extent_item.disk_num_bytes;=0A=
=0A=
=0A=
> Also I realize this is an RFC, but we're going to need some caching for r=
eads so=0A=
> we're not having to do a tree search on every IO with the RAID stripe tre=
e in=0A=
> place.=0A=
=0A=
Do we really need to do caching of stripe tree entries? They're read, once =
the=0A=
corresponding btrfs_file_extent_item is read from disk, which then gets cac=
hed=0A=
in the page cache. Every override is cached in the page cache as well.=0A=
=0A=
If we're flushing the cache, we need to re-read both, the file_extent_item =
and =0A=
the stripe extents.=0A=
