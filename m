Return-Path: <linux-btrfs+bounces-3948-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA198994A0
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 07:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76E281C22359
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 05:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478A5219ED;
	Fri,  5 Apr 2024 05:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JHaMXK7B";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="UqlQRLL1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215A6A21;
	Fri,  5 Apr 2024 05:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712293421; cv=fail; b=UyKgcPiSrINFbJEZ7Rx/450Z7mnZtGjUzdC9hXRxZy+ejzQZcnkc5WfyqgT9IvTvQpDG5d6njDOt8VvMEJXYvjH6+uDHaWO+5w9ZFv1YiQWmeLW8YpO9ExkU0YmnNTrayhZ/61MS28PHE60tj83gErBTznEW7ob+9tltGWU7bv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712293421; c=relaxed/simple;
	bh=qa6XPVwX5+acbOB9U0Bjt/hWJDWOEEskTWAlwZH8saM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bJgGY7q2GpGD6O+2jitgANfQX5VGdNQU9ZrMV1joz5z0DHmfxmP84pnKLaPKYIOBkLfzSFRiLCx/CXj3wTc5yiMisGkWIMYJEhdE1egwoyMah+LgTXLqgtYpUvW2Ekrf8KvEdvotj2K4SOKt+C/0YA8xwLic5PofPW+ZQONi4AE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=JHaMXK7B; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=UqlQRLL1; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712293419; x=1743829419;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qa6XPVwX5+acbOB9U0Bjt/hWJDWOEEskTWAlwZH8saM=;
  b=JHaMXK7BwXQ8DFgnQ+cISF+m6AbyzFJ21FirGPKMpCvK1N9zirV/Xq71
   oGnQzytQNdNW5GYDLas1GX6LhplWS1hWkc/1eNH65dW9qJF1j93pMD8TY
   SNS4PtZyPm79ZBA1TpJaEkRnDMhk0xTmaF3tw0De/YOPJGAPbnDUbG71Q
   OGJwfze8nMHMJEm3zmH599/dQzXwEtFI2ZhbpfEYHtHe9xaUt1oHUTtVT
   gzJwwnryG1eCdUgrxnXOfA9utkCE1ISR4L5HABtdTaSHrk7WyIAN6KJln
   SMkfXd8xJTd1rFK7BXOVnrvg8XjYQg1Jpm5vUEbHxVocbLZtZml53KluL
   g==;
X-CSE-ConnectionGUID: VfdTQjnkQ9SHrAccAXRDhQ==
X-CSE-MsgGUID: HW2ZD+h2QOKL0CCLerOygQ==
X-IronPort-AV: E=Sophos;i="6.07,180,1708358400"; 
   d="scan'208";a="13554128"
Received: from mail-sn1nam02lp2041.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.41])
  by ob1.hgst.iphmx.com with ESMTP; 05 Apr 2024 13:03:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2Qh8TIh3in75OgERoaJtJGyvIiHETfoA/N+NFvZFXkp7+YcvxOrrwXyaG+RDonp5J+D2ZU4odI1i+VDE4XnIC/n1tJYEJFiV+NRKA/O/PIN34hiDXsovUESFEvwKuMpUfIianTzp47YabmEy+XhLm1NQn7Eb90950iFE58vq+sNxdf2tgxynEo9FiUwqNIPp9iaDZXUd54YHrgKDYCMrnJRJjVYtUax2iMtIJQ7fPflaifm8kvGFkIIGvVUgFCGsLwGLpk5ZRzHbd6lVS5VCgrSjyxN+6u/ybHcPC31LHs99dCF8K6i1ViMdQB0rNTtg3bcqNm4/5q+oj7x3KWCcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jfgLFhmbQitbqP1CPTDeH0Yr/amuVhsk2D5Ca3yjpBg=;
 b=Is+J3c6TCE56WXDFrdlDUoWPqfIakbyuiQQm0nEi79lxbKg+//+3KSBHm9TqzVRBndzb1xtpT7qIlpm78CvQ0zemr/NeAFjcKTcPU2OF5RYbjhef/veZnzQYjTcvgWPDkY/8nGj4Ko6rsrnp8dS4A1ZJdKM9+XP684LGsufe/dqo+emXZgwplv+i6L+dDocvsZYM0Pvagl1LkElA+iD6jLd3r8uBbuxzJT9gwJ3MDhGJ/FrUx+aMq2sGiUbMUhfTHLaSsTiZoNkD8YukamRSBqDEc66puSOQKzPSAd/oYeG8dtL3Nw7K/iAgkbEYQ1KPIUv1AH2PMAMfXwsZefx6rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfgLFhmbQitbqP1CPTDeH0Yr/amuVhsk2D5Ca3yjpBg=;
 b=UqlQRLL1k22tDYgahn5/GREx/Deemrm1nkwYnXtvnduPWLwcnhTHy8GtBsEWfrk+HB1/MSYKr6E5C+YI4Ao1a07vgpztYD+Pc1EkP4wMoRxd3uPFUDAqd9v452Rc1HXF0ikLgNhFMrcEsbMFXPOTFctzG8UB8TbVoRR2jaWto7o=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by BN8PR04MB6387.namprd04.prod.outlook.com (2603:10b6:408:d7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 05:03:35 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::117f:b6cf:b354:c053]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::117f:b6cf:b354:c053%7]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 05:03:35 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Boris Burkov <boris@bur.io>
CC: Damien Le Moal <dlemoal@kernel.org>, Johannes Thumshirn <jth@kernel.org>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Hans Holmberg <Hans.Holmberg@wdc.com>,
	"hch@lst.de" <hch@lst.de>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH RFC PATCH 2/3] btrfs: zoned: reserve relocation zone on
 mount
Thread-Topic: [PATCH RFC PATCH 2/3] btrfs: zoned: reserve relocation zone on
 mount
Thread-Index: AQHagRfFZPYyrls190GkY8abHfqDl7FNxrAAgAa+H4CAALjBgIAD7XeA
Date: Fri, 5 Apr 2024 05:03:35 +0000
Message-ID: <qjoy4nrjxkc5zft266wvzfpwciz463zv3jdtpsdcn2wwev62xx@lfirgyk3ikm3>
References: <20240328-hans-v1-0-4cd558959407@kernel.org>
 <20240328-hans-v1-2-4cd558959407@kernel.org>
 <e32027a2-6032-4937-a362-287897abdf11@kernel.org>
 <ozmewhhflwko2z75luj33futfnkhoryyhk7vvb76suuagqse7o@gdwyk3dj3yw7>
 <20240402170451.GA3175858@zen.localdomain>
In-Reply-To: <20240402170451.GA3175858@zen.localdomain>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|BN8PR04MB6387:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 7R3BB21X/LOl/rNxtTcMciyoNwbGGqgvh+4VWUdIdh3GaXk72dYD6lHaJz9vivffo568wN4+loyDb4YAJwaTC0rBt4sMrvpzodjBfASe/an7nYszEq8p77NB08qEE1T0Rkk8mY0O3TeuFWEcMor9WxVfRQ/iuHL6Hc+LapUJuGR04gNkNU7wQTFWtz1r+7pgag3Hq+s6rB6SOu16erLzp91hLIRrdRjQeYLII5wKHkp1LhWo361F8iSchubct0pmqzEmfglcftI9SYjxfqEfweLRA10+7e54rgXKVz2wUH3k6T2HZQmdEm6D9VffS5KGXldbmIv7LP0O+FJzdH40oGfkPbAm5qLM9aReW4RiC47I3YSjYaNFc0jxHVB0VUglRfuh+jyqf8ex8rN/H7NFdnkppYRNjhXqkYPIvI/UpDRKbMTwjh+MtZSpbURQaBUGdQPGIbyosJptwOBKnG4ydVfUnwGronspSW9RNy+XRSXFWaktRolUF+59kKXsjSqrfLla2c7V9cLcPBPrvnLKytW++1d82rvyDZFoAOCYrdZDXk8M9KaX49eu84wnolZ+tp/D2CGUQbjis8xMlbwg1zMD21Bg0oJJL0VZJmTU65/7VtUnfTeX2DjZcvc3dT4e6kRoqlz9m5C+3fZUfCFti08SdBmEu0lw79NUJNpD2rw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QlFI1nPBsAl8/rWzFHCGVZb+yeTOHLVk0zlsbE7E55qSiktthFGCAhHTQiUi?=
 =?us-ascii?Q?oxPB4EmUgm25UfOO14Pu1d/Eq8CxGesz7s7xSXiObFtFBYuzYMpdgCRkICx5?=
 =?us-ascii?Q?oL0nL9wjwx5NO83Z5sVx5dTho9J2i4vxIZJ+m0OM5NBEXTuOFlmQVnjVq9yr?=
 =?us-ascii?Q?kmZ0KnTyW3aViQgM85UzXHR3snO0Otxr6hxORZdYbc72Q6oxffwC4hChlRbK?=
 =?us-ascii?Q?zQfgjlAIMAcWefaU7L9T6swVeWryQfca1KPHeBqqPZc+azM6UOggj+DHxtOy?=
 =?us-ascii?Q?JHGcEgiGFDeppzYE7mAav2vW/FgMAKQq1fq20k2MbMth3ZVrmfaD3+FwhErn?=
 =?us-ascii?Q?hQ+hpkJLD36PO7ok+mWNq0tchNpK6ggWSAAOrsd/7O0lsTa7tQaO1y87lEWr?=
 =?us-ascii?Q?5azP9aR/fhgNysIvQ9el4dqUPYIvx2wV53pv7DT9syQ5Jm1OEGHpGByd840o?=
 =?us-ascii?Q?+XGBxhtC2amV8zATdO1qHUkUbMjgx9wVz4yLTDlwjil7/joOEWoMb/vho460?=
 =?us-ascii?Q?gF4VHKrU6JV4l2Ab0SnZtU2fTTe1CcfMRscTnKlDgYMuZUOeMOxZsbdjjlIQ?=
 =?us-ascii?Q?v17dZjY2R/l1fO0d9maO3epNy1sz5OH1CbQqRdh1P/8w6J5PS0Fck50Ogscy?=
 =?us-ascii?Q?unfE5JR0OpD/qYtMKGluJRNK4CxkE+qhf8ybaBq+8L8793Ad/QFRG/ggAWj3?=
 =?us-ascii?Q?Iwwd1Hp4tljcjLE0HrqUQcBwSWFGyb/hYjqslmaBiRje2cmlvpGgtlMiA4cG?=
 =?us-ascii?Q?gHA3gUMHSU6W28b/o/Q9iuBxQ7BfrdbpO1EK9hRcOJXrQ8wZI7Fbd1WbW49i?=
 =?us-ascii?Q?FTr6BNLWwZbL5XTuU3ScqrMgm55PhevKH/QMrHV9qON+YlKQwC2G5R/mgp83?=
 =?us-ascii?Q?rQ/CSluFtX6qNs3QHhSuosirEpYWAdxWXx0HtA+ZK9RGEi2Do8gHXZR6gtUA?=
 =?us-ascii?Q?fpllzjHSGjLozHke2/B7sO8+mrGQhVF0lNjNyl46D+4jqZa6XIxAsViyczY2?=
 =?us-ascii?Q?kDuerxxHfANjjMUa9w/+YIfxnRpiAnbOnZhJMOnnUkBMe6YmI5EjWEPMiwIz?=
 =?us-ascii?Q?D44mrsG4aW/MmJQI1wlgNSO/hy7k+tb8wIyipw+Nf6aBx+epQPRiFONLIIO/?=
 =?us-ascii?Q?LFoQmJKUQSJxwDJek/7KeIoeBekzB6VCzMjVOD0b35TR4UNALWNvwYDeCDEy?=
 =?us-ascii?Q?5QMbH2hH3y1RGgmYF6J71BKhJzrlU545T3mF58bCGhp5VPibLCF840ePfE2w?=
 =?us-ascii?Q?HQAAr0zwBMQaNEaqNjgwEgw4wgqdB95V38S6VbPsOCJ2OIF7igl0GUDI12rs?=
 =?us-ascii?Q?ndYZsxZgZO4YFTiKyuCOq4vn6SRMpLPQthjqT9G134cGHUYmOOSC4AO1zUJx?=
 =?us-ascii?Q?wKnVQWrZ7N9G4tgCHaAlAYHBe2Hvh6J5k9GqJ2LeToHiVsF4br8R81jWGDed?=
 =?us-ascii?Q?j55TM/CoFoVwqcvCNXm7NcfGOsMl2EiNDA+8m28MOHfmBmR9FuyhyGsstAcV?=
 =?us-ascii?Q?Zzn/wBiFlyfH5DQwMgSTzl8l8kSV8nK6ZmqiMlpilr4Mp8d+clvat5oXpWBT?=
 =?us-ascii?Q?pTy0Q9WVjxUbe83yzRdckf0XKzff76AbVVMsmkhiPHCQ+Ght35BqJxen2KFg?=
 =?us-ascii?Q?SA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <25527B2624A5CD43879093F38CA913B5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WTdz/7n2JR0q6Kt2WuugGL+3TO2iXFmD0iK/mvqswlM5SIEwefyKKns+CzyHeWxXWn8b8SrY2Pp9ywaS4LMuIqCn83BMoTvB6/M7mFtNs8pHxjG6kwKgVhtVL1kK4KxxyW0k59iJkF5dworFLdCcEOaNZa+c+TdEz66m8Yp/0qpNZG/JfE0r25TawxPQR1URWGceWCRyf65yUmx54FBNo82/v+AgdAjAJ4M0hoFWI5stK7Y5j+8nGkXLzSGBJ79OWtphCGSTW5fxBoxgmnzcbQlgLBkAF59gl5Orssv9m5Y8u4nwzag3jEhmIWhR3gy05P5NBmz8fyG+LE7ufIm7h5aNdVLreIn0EA2SGjIu85yEVu6UAvLxXiv3/myNvmWWxPuaDiU3g4hucCM3HoAeNjmCUGDFkiQUmMs2kpvFRUShmDVWVNdS2Vx8r/gzOsT8GHyD/+liYkVWWN3uEOf9Z2SP3fhZjc7IvUZbdW/844kRgbI1QsidApL/8DdMi4UlEo+e1sepgIC5UAsDf6dccNaM1xJIRsV0THZlyKqSiZcu0/o4BNmHu9BMjzA38IHHutnBe0DHRWjSaTtwH7pbEbWSx7Zg0QUzEITm5YlqXoomMvEielS/jdu0pEVfcf1Z
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 909a139d-50cb-4ede-a437-08dc552dbf64
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2024 05:03:35.2142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L1MeVg6dGmTNwOUMCjrZgM08CNpyYxNAsFaGUBrEs1PRNWx6zPyUPgoD87NrRxL8QuVcE7E1cPS+SvivXV158g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6387

On Tue, Apr 02, 2024 at 10:04:51AM -0700, Boris Burkov wrote:
> On Tue, Apr 02, 2024 at 06:03:35AM +0000, Naohiro Aota wrote:
> > On Fri, Mar 29, 2024 at 08:05:34AM +0900, Damien Le Moal wrote:
> > > On 3/28/24 22:56, Johannes Thumshirn wrote:
> > > > From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > > >=20
> > > > Reserve one zone as a data relocation target on each mount. If we a=
lready
> > > > find one empty block group, there's no need to force a chunk alloca=
tion,
> > > > but we can use this empty data block group as our relocation target=
.
>=20
> I'm confused why it's sufficient to ensure the reservation only once at
> mount. What ensures that the fs is in a condition to handle needed
> relocations a month later after we have already made use of the one bg
> we reserved at mount? Do we always reserve the "just-relocated-out-of"
> fresh one for future relocations or something? I couldn't infer that
> from a quick look at the use-sites of data_reloc_bg, but I could have
> easily missed it.

In general, btrfs_alloc_data_chunk_ondemand() called from
prealloc_file_extent_cluster() should be responsible for allocating a new
block group. It allocates a new block group if the space is not
enough. When a block group is filled exactly, there is a chance we don't
have data relocation block group. But, the next relocation cluster will
allocate new one.

There is a problem, however, that it only checks there is enough space for
a relocation cluster in the DATA space_info. So, even if there is no space
in the data relocation block group, we still can have enough space in the
DATA space. Then, it won't ensure the relocation cluster will be written
properly.

We would like to have a dedicated function for the zoned case. It checks
the space against the data relocation BG. When the space is not enough, it
allocates/activates a new block group or takes one existing block group,
making it a new data relocation BG. This new data relocation BG "promotion"
is also done in do_allocation_zoned(), so moving the logic out to
prealloc_file_extent_cluster() would be interesting.

There is one issue when we choose an existing block group. We cannot use an
existing BG if that BG is already "used" or "reserved" to avoid mixing
ZONE_APPEND (normal data write) and WRITE (relocation data write). This
restriction makes it difficult to use an existing BG.

Here is one interesting solution. We can freely choose an existing BG, then
we can wait enough time for on-going IOs to finish since we are in the
relocation context. It is easier to implement the logic in
prealloc_file_extent_cluster() than do_allocation_zoned() because we are
free from many locks for the extent allocation and the writeback context.

> > > >=20
> > > > Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > > > ---
> > > >  fs/btrfs/disk-io.c |  2 ++
> > > >  fs/btrfs/zoned.c   | 46 ++++++++++++++++++++++++++++++++++++++++++=
++++
> > > >  fs/btrfs/zoned.h   |  3 +++
> > > >  3 files changed, 51 insertions(+)
> > > >=20
> > > > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > > > index 5a35c2c0bbc9..83b56f109d29 100644
> > > > --- a/fs/btrfs/disk-io.c
> > > > +++ b/fs/btrfs/disk-io.c
> > > > @@ -3550,6 +3550,8 @@ int __cold open_ctree(struct super_block *sb,=
 struct btrfs_fs_devices *fs_device
> > > >  	}
> > > >  	btrfs_discard_resume(fs_info);
> > > > =20
> > > > +	btrfs_reserve_relocation_zone(fs_info);
> > > > +
> > > >  	if (fs_info->uuid_root &&
> > > >  	    (btrfs_test_opt(fs_info, RESCAN_UUID_TREE) ||
> > > >  	     fs_info->generation !=3D btrfs_super_uuid_tree_generation(di=
sk_super))) {
> > > > diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> > > > index d51faf7f4162..fb8707f4cab5 100644
> > > > --- a/fs/btrfs/zoned.c
> > > > +++ b/fs/btrfs/zoned.c
> > > > @@ -17,6 +17,7 @@
> > > >  #include "fs.h"
> > > >  #include "accessors.h"
> > > >  #include "bio.h"
> > > > +#include "transaction.h"
> > > > =20
> > > >  /* Maximum number of zones to report per blkdev_report_zones() cal=
l */
> > > >  #define BTRFS_REPORT_NR_ZONES   4096
> > > > @@ -2634,3 +2635,48 @@ void btrfs_check_active_zone_reservation(str=
uct btrfs_fs_info *fs_info)
> > > >  	}
> > > >  	spin_unlock(&fs_info->zone_active_bgs_lock);
> > > >  }
> > > > +
> > > > +static u64 find_empty_block_group(struct btrfs_space_info *sinfo)
> > > > +{
> > > > +	struct btrfs_block_group *bg;
> > > > +
> > > > +	for (int i =3D 0; i < BTRFS_NR_RAID_TYPES; i++) {
> > > > +		list_for_each_entry(bg, &sinfo->block_groups[i], list) {
> > > > +			if (bg->used =3D=3D 0)
> > > > +				return bg->start;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	return 0;
> > >=20
> > > The first block group does not start at offset 0 ? If it does, then t=
his is not
> > > correct. Maybe turn this function into returning a bool and add a poi=
nter
> > > argument to return the bg start value ?
> >=20
> > No, it does not. The bg->start (logical address) increases monotonicall=
y as
> > a new block group is created. And, the first block group created by
> > mkfs.btrfs has a non-zero bg->start address.
> >=20
> > > > +}
> > > > +
> > > > +void btrfs_reserve_relocation_zone(struct btrfs_fs_info *fs_info)
> > > > +{
> > > > +	struct btrfs_root *tree_root =3D fs_info->tree_root;
> > > > +	struct btrfs_space_info *sinfo =3D fs_info->data_sinfo;
> > > > +	struct btrfs_trans_handle *trans;
> > > > +	u64 flags =3D btrfs_get_alloc_profile(fs_info, sinfo->flags);
> > > > +	u64 bytenr =3D 0;
> > > > +
> > > > +	if (!btrfs_is_zoned(fs_info))
> > > > +		return;
> > > > +
> > > > +	bytenr =3D find_empty_block_group(sinfo);
> > > > +	if (!bytenr) {
> > > > +		int ret;
> > > > +
> > > > +		trans =3D btrfs_join_transaction(tree_root);
> > > > +		if (IS_ERR(trans))
> > > > +			return;
> > > > +
> > > > +		ret =3D btrfs_chunk_alloc(trans, flags, CHUNK_ALLOC_FORCE);
> > > > +		btrfs_end_transaction(trans);
> > > > +
> > > > +		if (!ret)
> > > > +			bytenr =3D find_empty_block_group(sinfo);
> > >=20
> > > What if this fail again ?
> >=20
> > That (almost) means we don't have any free space to create a new block
> > group. Then, we don't have a way to deal with it. Maybe, we can reclaim
> > directly here?
>=20
> To my more general point, should we keep trying in a more sustained way
> on the live fs, even if it happens to be full-full at mount?
>=20
> >=20
> > Anyway, in that case, we will set fs_info->data_reloc_bg =3D 0, which i=
s the
> > same behavior as the current code.
>=20
> Well right now it is only called from mount, in which case it will only
> fail if we are full, since there shouldn't be concurrent allocations.
>=20
> OTOH, if this does get called from some more live fs context down the
> line, then this could easily race with allocations using the block
> group. For that reason, I think it makes sense to either add locking,
> a retry loop, or inline reclaim.

So, implementing the above logic would help for live fs context.

> >=20
> > > > +	}
> > > > +
> > > > +	spin_lock(&fs_info->relocation_bg_lock);
> > > > +	fs_info->data_reloc_bg =3D bytenr;
> > > > +	spin_unlock(&fs_info->relocation_bg_lock);
> > > > +}
> > > > diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
> > > > index 77c4321e331f..048ffada4549 100644
> > > > --- a/fs/btrfs/zoned.h
> > > > +++ b/fs/btrfs/zoned.h
> > > > @@ -97,6 +97,7 @@ int btrfs_zone_finish_one_bg(struct btrfs_fs_info=
 *fs_info);
> > > >  int btrfs_zoned_activate_one_bg(struct btrfs_fs_info *fs_info,
> > > >  				struct btrfs_space_info *space_info, bool do_finish);
> > > >  void btrfs_check_active_zone_reservation(struct btrfs_fs_info *fs_=
info);
> > > > +void btrfs_reserve_relocation_zone(struct btrfs_fs_info *fs_info);
> > > >  #else /* CONFIG_BLK_DEV_ZONED */
> > > >  static inline int btrfs_get_dev_zone(struct btrfs_device *device, =
u64 pos,
> > > >  				     struct blk_zone *zone)
> > > > @@ -271,6 +272,8 @@ static inline int btrfs_zoned_activate_one_bg(s=
truct btrfs_fs_info *fs_info,
> > > > =20
> > > >  static inline void btrfs_check_active_zone_reservation(struct btrf=
s_fs_info *fs_info) { }
> > > > =20
> > > > +static inline void btrfs_reserve_relocation_zone(struct btrfs_fs_i=
nfo *fs_info) { }
> > > > +
> > > >  #endif
> > > > =20
> > > >  static inline bool btrfs_dev_is_sequential(struct btrfs_device *de=
vice, u64 pos)
> > > >=20
> > >=20
> > > --=20
> > > Damien Le Moal
> > > Western Digital Research
> > > =

