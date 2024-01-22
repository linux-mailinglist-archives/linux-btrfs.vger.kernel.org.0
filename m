Return-Path: <linux-btrfs+bounces-1588-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBC3835B80
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 08:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DFF81F21A28
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 07:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9371B125D2;
	Mon, 22 Jan 2024 07:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KiiErv+p";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="vGh484OA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7233011196
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Jan 2024 07:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705907875; cv=fail; b=sT0uCzulLXo98fu71Hzvl6Ycf/W7AlX7m+LrjRR04CX3JVfxelGpsyUj5cLcG/JK8LUCc1KkZMnAjPG/ER6Vjemc12cgi2HvECcCEcwRPvc/Sn4iHmR184nMr9JVCT0IRDhBP3xwWuyCHXYdMGGKLzxRbCjSHRKt+5cs/o/qmd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705907875; c=relaxed/simple;
	bh=XCIDCGJ0F+vsZZVkSa7vc63rH0XiBh1yZhE547XbXyA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=utEvpy6ykicMVrJFJ5z7yTDNtxkpTzlfAs8MO7TBMTMLjg9V9rN68tfr1yKvJG4B6Rq6uIgn+drvMasbyGPmhdcJmLy6uYZK1pq0AzyjVHez9ADI2jCAubdvh4F3/MRuGBiwRA0G62HIJdtrBus2xwMmglx51/e7brZCyOBYBXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=KiiErv+p; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=vGh484OA; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1705907873; x=1737443873;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XCIDCGJ0F+vsZZVkSa7vc63rH0XiBh1yZhE547XbXyA=;
  b=KiiErv+p7InE0gbzvOd/bNKrjFMUeGmaWmdTo7bX7upnwO/UZvrKG9cD
   xZKZizwo8gJ1tdl37EpHgkEKJHR22R0rQKX8ImmyQpVdF1jKVBiKmhDlW
   pDOvdd0JsZREYg2cr+wEuspwbsZJns1f3R5OtwEkwGddm+vNpq07iyBjx
   kT15h63muW6Pr+adnoCveMdMig00bXZh19wpabCgi8mhqjsdebUy90Vn+
   8Erxp+7KjQxpifmrKSw+kdJoZWyrAsMx9muEKO4Pn/WTC5jdmQLtJqIqP
   uOWcQxCy5JQy5jssO9Arn8CZ+Vn4XWlY8oBcw5A2K4lmiC63k4T7c7uwe
   Q==;
X-CSE-ConnectionGUID: kQMsrxAZQ5yMAhDQTPLoeA==
X-CSE-MsgGUID: 60OglPLWSRqD+qNm/mwiaQ==
X-IronPort-AV: E=Sophos;i="6.05,211,1701100800"; 
   d="scan'208";a="7413400"
Received: from mail-westus2azlp17012025.outbound.protection.outlook.com (HELO MW2PR02CU001.outbound.protection.outlook.com) ([40.93.10.25])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2024 15:17:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KcZMzI/wt6GCP03nRWMAXg8hlPiaStRCTD7KrKPO4aQRxrf8HN/dfI1vWBpVApdevDmbwsdvrHFypqbL9EFViVPrFywlsfTtRKxtfYrfylj4Feq4HGdtP0OjxtTDh+HjUCDaXIWWOBlhiztJo3Jik4adi4x05Q2e/h8GNCthcIvu7H784x8nTacAVZgXG0+ELH6wVwR3raDg7Gw4o6Sk8KJvKsE+FyHuyXY1mVgMeYq0j1zKH9GjBfwzs1ZJn5j1l3SE7+RWJL10MCJoll+XTWROJic7XeHPzdlhfHTnuzUuTchILXYexBdMF2bDc75PtsWDJQoVg0wnwvLS31aWIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1ZrXNdTWsGVxCZagFJkXPapt3shdBLOqzLPtFKkOcg=;
 b=EFUlPZr/Kf1vqGVEHomf8DzZFEww7l2l/xAiznMcCIg7hU0qGCYkN3a3Y+YZwNJiJ5hToZ8TlH8shxO9u/cfEpky4UfhyOiQGL4u/ftaxNhP7A3EHj/ntNxS0cmS1GIMa7eT8f2oZnBwZkt78lw9rDQ2foZGjw641unawpjLzlKkh2ju0eZFfwdKe/CP+2R/cATjG1IuKpGoE79EfeQFYlI9g4gwsXjhU2qvu8Vvyi+DyZR3hD6b+wJaIbXm3MXLYt0ISH/4b3YJyylnA1iskkezgXl6vjnz8otdOqMWK5DiUuc4XK6V8InC88Swn8m1mPvL1yjf8bKBaQa9Iq9ciQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1ZrXNdTWsGVxCZagFJkXPapt3shdBLOqzLPtFKkOcg=;
 b=vGh484OAfy9PLbDDBQHLi5flLp6abJavNseGxzzx8ZG0WoBk+oHfH7gHMwzQeT9+KTSIn479PHMhJGZF8ABeAbALHZF3qM15+evu2eZwmlG3ZXZ6TgKOkT9nXkF8mPdPI2U7w2uW6FzvzMm/xC0e4Pd8tCsURAc9jhxervyuN08=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by DM6PR04MB6281.namprd04.prod.outlook.com (2603:10b6:5:1e8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 07:17:43 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::6c12:a7ce:2b9c:69bf]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::6c12:a7ce:2b9c:69bf%6]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 07:17:43 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Roman Mamedov <rm@romanrm.net>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"wangyugui@e16-tech.com" <wangyugui@e16-tech.com>, "hch@lst.de" <hch@lst.de>,
	"clm@meta.com" <clm@meta.com>
Subject: Re: Re: [PATCH 0/2] btrfs: disable inline checksum for multi-dev
 striped FS
Thread-Topic: Re: [PATCH 0/2] btrfs: disable inline checksum for multi-dev
 striped FS
Thread-Index: AQHaSewVbT8W0k+HTU2pfeXHKHnXkLDfSRaAgAYpPYA=
Date: Mon, 22 Jan 2024 07:17:43 +0000
Message-ID: <irc2v7zqrpbkeehhysq7fccwmguujnkrktknl3d23t2ecwope6@o62qzd4yyxt2>
References: <cover.1705568050.git.naohiro.aota@wdc.com>
 <20240118141231.5166cdd7@nvm>
In-Reply-To: <20240118141231.5166cdd7@nvm>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|DM6PR04MB6281:EE_
x-ms-office365-filtering-correlation-id: b7e3cdac-99e5-468a-1d98-08dc1b1a39b7
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 FQZtvi9ZcXDPjJ2YU6OJ9AwE2qL/WqF8nAspJ35VQOLq7tNYDz368VQkwlNdNkPWICqI+5XxvCwG3ruYhH3uqCUNT0jzR/6jgiTxapO684LK12SWc6GaV55eLCFwshvlHDSuVx3eB7CnQKpGr5bIWSgZvV+coWkpRj0AWfJaxSTOIRq/pUfW55vqWVq+ctpfp4imkzHzHV3baj0Z2Hk04XU/j/sR7euo2p+kq8hcGit3U1kfUX8B+fTjCb5ukabiVMFGDZMj8G14nbEwTSGPOEPYn2g9OXhNFkCU4az2QEVznbkouRyoKeaJ9QJ1rjqkqOdoyzU8X5e7dF9qk9f3aSXeT+99Y6+D2ECn5fS3JaZlhY+VP9flxKnMvKa9VXwwq3pV/R3Iyntg2BsoqD8L7yGhBvBrNHTVjYVlDy0SZoLG6gagwvsc+wF1HVJrTnykGbASlqaAzpEYzz3BwJwvaKiPN/xLvV2syIWeKIwSyrTvH6TR8y71TVdLX5d3pW4Npz0H7Po1Hpp9bKsyNo/7b/P5vjP5PPhn0nD9PGdh4rWsXTACA0FfdiI4ldTwYCVLaqBljFYNeO64f8V6pQMFJsCKhB36YdTkr5tgW8R1jAAHeH4jkN5meuoZiAfdPq8gCrTNVeR9Eof50VzptS73lw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(376002)(39860400002)(366004)(396003)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(38100700002)(26005)(71200400001)(5660300002)(122000001)(9686003)(4326008)(8676002)(8936002)(33716001)(41300700001)(2906002)(478600001)(66946007)(966005)(64756008)(6506007)(19627235002)(6512007)(66446008)(66476007)(76116006)(66556008)(6486002)(6916009)(91956017)(316002)(54906003)(86362001)(82960400001)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hTp95axjEkEk1qf+wL66BBu94X2WrkV9dfaeFyK0WFcROylhfTj9usVp/zxg?=
 =?us-ascii?Q?26kBSbovXXP5v6ixDtj3u2NhaigHvXjgsUuLU91NZ39sEZY1iGrE1544PqFf?=
 =?us-ascii?Q?Gpv7zBfWshig6tV5bg8m4Ubxie/o3ACSJGBzsKtXz6OzOuOc6JIqxihlWo3P?=
 =?us-ascii?Q?/s4Q8umFzxOUDyi/+sRL0KV8Hs0gmMTt9n9L7rAeVLiTOQSE33XIFXbNiNKk?=
 =?us-ascii?Q?NtuKeSd2VAwyYrs0YiKPWtX0wjKvHhBubHe+aWlY96e4uZLwRl5LL2W/sctg?=
 =?us-ascii?Q?2bgVSiwjLH/Vp9lFufyLXS4Q3l95+Q3dZ3jAqSptsKiarIILv7p+zChMZ7aU?=
 =?us-ascii?Q?xDx2bD/5byZwvJ/yEqmiHdr/draEMKhpT+WVjdgakPyyAxfDfLfGFQc+0y6l?=
 =?us-ascii?Q?YCYOVmBjUBHBk++RrrPt6+EaS+GOHTQKZh4yrduc/8VqYJUiqgoqcG5SX8ke?=
 =?us-ascii?Q?yoUV4/Bb1Y6vDC3dlRdUopRR5abvhkfgqLA/zeMT3UWPed5kuU7KcfKWGG2D?=
 =?us-ascii?Q?8btbYeGKyRWCVU98yZs3BFh8xwhJaqoWKsLSQ/uVD9R+FDKg/lpaMbWOOk8W?=
 =?us-ascii?Q?R9QZSx1g/Xvma9yt6qooOAmmDvbbCBMbqiAVbtk3NoUcrVM9wp8gNdKDSsvD?=
 =?us-ascii?Q?TZNF28o0QS2Tx6oRUp1p0hga4CMlrfXnivBFv1yLoMjuepe0Ck9va21fk378?=
 =?us-ascii?Q?078wKhOUELK6BH6Pg3qtHTx9y93OebJmL6R7Rbbl/TOpClgUQS0Y91uO/ydq?=
 =?us-ascii?Q?AVTVadXisyT5xOuj9jsi/w0NxCrFPW500RWb2N0xEFeFp80igQcZtfo0nZzT?=
 =?us-ascii?Q?9WFCa2tnlLWXIHqiev4ex0PuNGJY8HixWuf0k67MRIihntcU2ve4tQktUvcD?=
 =?us-ascii?Q?HeC0Pk3qXYan+xsxjuPQf55kos/L8fE9hOx/5zqw8EbbtBTsNJeuiXh8cRon?=
 =?us-ascii?Q?w+fPAR/p0CGKxjg6fI+leDSsLIN0jBJLC1AGmJ3yjYb5E25e78Z/MS+P7/9L?=
 =?us-ascii?Q?iUAKe8BpaY6x8/rzGFUC0H7u0sB9VsBbp5zFgg/SvRQkiKZqXSZu6aJH0Zd7?=
 =?us-ascii?Q?sR40kSCAKnK6KHhUdiBjJ1/OhXYRob0uFEkB1UzYYZDhAUkhv5Evzcu7mlAp?=
 =?us-ascii?Q?yZBo3aF2343164MjunNqkUo0VqnP+1bsPsKd0scewXUVMZyYrqPVEVxWdMSQ?=
 =?us-ascii?Q?JgZFtYeY+zMBDunej3jnWOzw3cn3SkP0B1RFc4KqQrnzWDVaOHkgnfnZERlY?=
 =?us-ascii?Q?g7xcnujCtwAhr8dU98MDdPiNFIPKF2TTK8JVCP6QRLzzBpR4fG68fwgJA6c8?=
 =?us-ascii?Q?oFTq7iymRJMJQ9AR71mje6BArLnO8ckj9IDDEkg2VKvoq+PeNJczHNLjNOFv?=
 =?us-ascii?Q?IW5mA32H0pD9+r87Yrum7Yuy8iW7j4Pj+KE+0HD+6VvIvu7hzwWw9gWaSP0R?=
 =?us-ascii?Q?TGRwlJVbxkW1sjxLNQfUtvgUvfI+xn73hc6CX/ICFFAJW48uv0gEmsBOzGId?=
 =?us-ascii?Q?nmM7MqCorsRJazZtL27K1GpQop0RTTe5XwpSdPU9BnJIQzpTvtd5Vx5XHnmU?=
 =?us-ascii?Q?AfvdkDSO4spneJJEYFYUl7ziDz/Nu+88rgHWbTkV1Tr6pnXnZYB1HoCG2Sn2?=
 =?us-ascii?Q?7w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E5A1195149169445B719F089B6457C47@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Bx40a4Zgr6NggnbWLDoZCI7bl6IlDoDPlVGhv+3LhnoAQUZN350zF+kNgvimN2iCQo7WU+EpHSOzo72ABmA49RvVrdRsnA4ieJZJkKy2fLBQ6jhZTqgpfU87EF3aV/MVpaG1DUAWmlI6ZoapsQ7m0kSEZQ1dlNE7yBxv2LvL3HPAAUElku9OMq0Qz9fb+W+iPvpe8M5M7lb3HwDWs7kBXKtTI8JUPf0Q844cTi2J7doYfxdrPNPDKACpSo+lsieBn6/U/fkDBP1GLDGeY+3/4uZYRD5/G6mXhYzJH/0lSp63oyX2o4naaANUhP2mW+F99JnvO97fzBRqiaMW6ZH8k37B4mXcRD5BSAqKou4qpxZuc/jbZwq0kqYNFxZRb1u+CxZo9k8Ha1yfgGHV/X+UCY9BadOPUNucUTrXezsQd7FNp/QXGndAGLfXLRdldUWsdzeqM6IbyZqrzJIn8biAs9bcE05n2X5eOOAuXjFcBT7Y4XtD+i+pZJzeG7vFoYU7cN5YAIW1MuZJoWAjPWOXipd5G8jwyiOJrDzhFa1mFaD5dUCE8mVivXU7hk2e6AZFIzm385biLBV7osmTGdNMQg34BQi9EkrhkivDA6eO/5k8dUyX/69rO7TyeO4uE7t1
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e3cdac-99e5-468a-1d98-08dc1b1a39b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2024 07:17:43.0977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0o+F10zDwyI5I/cA4sNlTefjAEh0PBQM+0Cp7pl3nnrHc/puVwIjME3pzvgEFAHvQ90U/OAEQ3noGKJfah/a6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6281

On Thu, Jan 18, 2024 at 02:12:31PM +0500, Roman Mamedov wrote:
> On Thu, 18 Jan 2024 17:54:49 +0900
> Naohiro Aota <naohiro.aota@wdc.com> wrote:
>
> > There was a report of write performance regression on 6.5-rc4 on RAID0
> > (4 devices) btrfs [1]. Then, I reported that BTRFS_FS_CSUM_IMPL_FAST
> > and doing the checksum inline can be bad for performance on RAID0
> > setup [2].
> >
> > [1] https://lore.kernel.org/linux-btrfs/20230731152223.4EFB.409509F4@e1=
6-tech.com/
> > [2] https://lore.kernel.org/linux-btrfs/p3vo3g7pqn664mhmdhlotu5dzcna6vj=
tcoc2hb2lsgo2fwct7k@xzaxclba5tae/
> >
> > While inlining the fast checksum is good for single (or two) device,
> > but it is not fast enough for multi-device striped writing.
>
> Personal opinion, it is a very awkward criteria to enable or disable the
> inline mode. There can be a RAID0 of SATA HDDs/SSDs that will be slower t=
han a
> single PCI-E 4.0 NVMe SSD. In [1] the inline mode slashes the performance=
 from
> 4 GB/sec to 1.5 GB/sec. A single modern SSD is capable of up to 6 GB/sec.
>
> Secondly, less often, there can be a hardware RAID which presents itself =
to the
> OS as a single device, but is also very fast.
>
> Sure, basing such decision on anything else, such as benchmark of the
> actual block device may not be as feasible.
>
> > So, this series first introduces fs_devices->inline_csum_mode and its
> > sysfs interface to tweak the inline csum behavior (auto/on/off). Then,
> > it disables inline checksum when it find a block group striped writing
> > into multiple devices.
>
> Has it been determined what improvement enabling the inline mode brings a=
t all,
> and in which setups? Maybe just disable it by default and provide this tw=
eak
> option?

Note: as mentioned by David, I'm going to say "sync checksum" instead of
"inline checksum".

I'm going to list the benchmark results here.

The sync checksum is introduced with this patch.

https://lore.kernel.org/linux-btrfs/20230503070615.1029820-2-hch@lst.de/

The benchmark described in the patch is originated from this email by Chris=
.

https://lore.kernel.org/linux-btrfs/eb544c31-7a74-d503-83f0-4dc226917d1a@me=
ta.com/

* Device: Intel Optane

* workqueue checksum (Unpatched):
  write: IOPS=3D3316, BW=3D3316MiB/s (3477MB/s)(200GiB/61757msec); 0 zone r=
esets

* Sync checksum (synchronous CRCs):
  write: IOPS=3D4882, BW=3D4882MiB/s (5119MB/s)(200GiB/41948msec); 0 zone r=
esets

Christoph also did the same on kvm on consumer drives and got a similar
result. Furthermore, even with "non-accelerated crc32 code", "the workqueue
offload only looked better for really large writes, and then only
marginally."

https://lore.kernel.org/linux-btrfs/20230325081341.GB7353@lst.de/

Then, Wang Yugui reported a regression both on SINGLE setup and RAID0 setup=
.

https://lore.kernel.org/linux-btrfs/20230811222321.2AD2.409509F4@e16-tech.c=
om/

* CPU: E5 2680 v2, two NUMA nodes
* RAM: 192G
* Device: NVMe SSD PCIe3 x4
* Btrfs profile: data=3Draid0, metadata=3Draid1
  - all PCIe3 NVMe SSD are connected to one NVMe HBA/one numa node.

* workqueue checksum: RAID0:
  WRITE: bw=3D3858MiB/s (4045MB/s)
  WRITE: bw=3D3781MiB/s (3965MB/s)
* sync checksum: RAID0:
  WRITE: bw=3D1311MiB/s (1375MB/s)
  WRITE: bw=3D1435MiB/s (1504MB/s)

* workqueue checksum: SINGLE:
  WRITE: bw=3D3004MiB/s (3149MB/s)
  WRITE: bw=3D2851MiB/s (2990MB/s)
* sync checksum: SINGLE:
  WRITE: bw=3D1337MiB/s (1402MB/s)
  WRITE: bw=3D1413MiB/s (1481MB/s)

So, workqueue (old) method is way better on his machine.

After a while, I reported workqueue checksum is better than sync checksum
on 6 SSDs RAID0 case.

https://lore.kernel.org/linux-btrfs/p3vo3g7pqn664mhmdhlotu5dzcna6vjtcoc2hb2=
lsgo2fwct7k@xzaxclba5tae/

* CPU: Intel(R) Xeon(R) Platinum 8260 CPU, two NUMA nodes, 96 CPUs
* RAM: 1024G

On 6 SSDs RAID0
* workqueue checksum:
  WRITE: bw=3D2106MiB/s (2208MB/s), 2106MiB/s-2106MiB/s (2208MB/s-2208MB/s)=
, io=3D760GiB (816GB), run=3D369705-369705msec
* sync checksum:
  WRITE: bw=3D1391MiB/s (1458MB/s), 1391MiB/s-1391MiB/s (1458MB/s-1458MB/s)=
, io=3D499GiB (536GB), run=3D367312-367312msec

Or, even with 1 SSD setup (still RAID0):
* workqueue checksum:
  WRITE: bw=3D437MiB/s (459MB/s), 437MiB/s-437MiB/s (459MB/s-459MB/s), io=
=3D299GiB (321GB), run=3D699787-699787msec
* sync checksum:
  WRITE: bw=3D442MiB/s (464MB/s), 442MiB/s-442MiB/s (464MB/s-464MB/s), io=
=3D302GiB (324GB), run=3D698553-698553msec

The same as Wang Yugui, I got better performance with workqueue checksum.

I also tested it on an emulated fast device (null_blk with irqmode=3D0)
today. The device is formatted with the default profile.

* CPU: Intel(R) Xeon(R) Platinum 8260 CPU, two NUMA nodes, 96 CPUs
* RAM: 1024G
* Device: null_blk with irqmode=3D0, use_per_node_hctx=3D1, memory_backed=
=3D1, size=3D512000 (512GB)
* Btrfs profile: data=3Dsingle, metadata=3Ddup

I ran this fio command with this series applied to tweak the checksum mode.

fio --group_reporting --eta=3Dalways --eta-interval=3D30s --eta-newline=3D3=
0s \
    --rw=3Dwrite \
    --direct=3D0 --ioengine=3Dpsync \
    --filesize=3D${filesize} \
    --blocksize=3D1m \
    --end_fsync=3D1 \
    --directory=3D/mnt \
    --name=3Dwriter --numjobs=3D${numjobs}

I tried several setups, but I could not get a better performance with sync
checksum. Examples are shown below.

With numjobs=3D96, filesize=3D2GB
* workqueue checksum: (writing off to the newly added sysfs file)
  WRITE: bw=3D1776MiB/s (1862MB/s), 1776MiB/s-1776MiB/s (1862MB/s-1862MB/s)=
, io=3D192GiB (206GB), run=3D110733-110733msec
* sync checksum       (writing on to the sysfs file)
  WRITE: bw=3D1037MiB/s (1088MB/s), 1037MiB/s-1037MiB/s (1088MB/s-1088MB/s)=
, io=3D192GiB (206GB), run=3D189550-189550msec

With numjobs=3D368, filesize=3D512MB
* workqueue checksum:
  WRITE: bw=3D1726MiB/s (1810MB/s), 1726MiB/s-1726MiB/s (1810MB/s-1810MB/s)=
, io=3D192GiB (206GB), run=3D113902-113902msec
* sync checksum
  WRITE: bw=3D1221MiB/s (1280MB/s), 1221MiB/s-1221MiB/s (1280MB/s-1280MB/s)=
, io=3D192GiB (206GB), run=3D161060-161060msec

Also, I run a similar experiment on a different machine, which has 32 CPUs
and 128 GB RAM. Since it has a smaller RAM, filesize is also smaller than
above. And, again, workqueue checksum is slightly better.

* workqueue checksum:
  WRITE: bw=3D298MiB/s (313MB/s), 298MiB/s-298MiB/s (313MB/s-313MB/s), io=
=3D32.0GiB (34.4GB), run=3D109883-109883msec
* sync checksum
  WRITE: bw=3D275MiB/s (288MB/s), 275MiB/s-275MiB/s (288MB/s-288MB/s), io=
=3D32.0GiB (34.4GB), run=3D119169-119169msec


When I started writing this reply, I thought the proper criteria may be the
number of CPUs, or some balance of the number of CPUs vs disks. But, now,
as I could not get "sync checksum" to be better on any setup, I'm getting
puzzled. Is "sync checksum" really effective still for now? Maybe, it's
good on smaller CPUs (~4?) machine with a single device?

In addition, We are also going to have a change on the workqueue's side
too, which changes max number of working jobs, especially effective for a
NUMA machine.

https://lore.kernel.org/all/20240113002911.406791-1-tj@kernel.org/

Anyway, we need more benchmark results to see the effect of "sync checksum"
and "workqueue checksum".

>
> > Naohiro Aota (2):
> >   btrfs: introduce inline_csum_mode to tweak inline checksum behavior
> >   btrfs: detect multi-dev stripe and disable automatic inline checksum
> >
> >  fs/btrfs/bio.c     | 14 ++++++++++++--
> >  fs/btrfs/sysfs.c   | 39 +++++++++++++++++++++++++++++++++++++++
> >  fs/btrfs/volumes.c | 20 ++++++++++++++++++++
> >  fs/btrfs/volumes.h | 21 +++++++++++++++++++++
> >  4 files changed, 92 insertions(+), 2 deletions(-)
> >
>
>
> --
> With respect,
> Roman=

