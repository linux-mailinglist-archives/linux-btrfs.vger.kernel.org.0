Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C5E564E22
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jul 2022 09:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbiGDHDC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jul 2022 03:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbiGDHDA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jul 2022 03:03:00 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8AE55A9
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Jul 2022 00:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656918179; x=1688454179;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=SJurCjjm8vPoyeHuRY8+dAxMnnq5i5RP1nWNasSS6Yc=;
  b=rgZk/x8l7usV24Q/KexdXvAUcGd0Vnw5EkUJa5QYfakxLbHy3o69Vwzg
   L+u+1LNIQ7apciMfltE43ioPNvH8rKkP9Xpzcuks8krrzRZcBj1Q6+k9D
   Wvvz09auD0WtaLpxz/VJBJZGsRrKWBMVRQEavUSXL51IRQ/RPgjN6FIUw
   bVELkpRSvYKc5XNjpJJWQ9x4zv7DoiXOaOyLNVDGZCYJ9212iODbSrjtZ
   s9fBehFjbvrBvJ23xNj2TkC11OPLaMp8DMWqENFu4+H9SPiIL/+meKcXl
   xUFg7VwR2lMv5NqS0fDYj9o1pDNtMQ3Wc7biua26S1nHqS51YEdMEJ8cX
   A==;
X-IronPort-AV: E=Sophos;i="5.92,243,1650902400"; 
   d="scan'208";a="209633096"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jul 2022 15:02:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISmgZ13b504ZRkiG1osfoUGa54ARuD6nFRxPbD+cQIQnwXMkiDWw3mWOhA+w0ekv/HzPIEp8I+143BK0yR9M45MgMmaZLlhAdBh3mmq4sxQCLtFQquWZQadxPAFuxYCVh421FBpg6rNXzowxuasm5GM+npIB4ZC2HlmbRWud7c188gIyCMgw+SYQAJJiglKSjUEOBrrS8viNaVxI00uR5YRYjqLWAitolYEemd8Y+2eVZl0m4gJ5ZxDuZ36f3twYrcPDnWZm1JU/YDMKD2nHd4TBEf3nuNSldHUbjQhZ+QCUWzwa0bTdgT2WBojiZbmnP/nU0e0DZ5Fv5lIkuiQSbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GysaiCT0EYzGAwC1ZaGUT5q9kR8LfOnWpyUyJeaVofU=;
 b=jeyCMdRBD1DWzBFseCJhA5rDVuoQ/1sLkC4f+1/WN4dJGsJ0VFQxqf+70RTgUboRQ/1IEeZ0vEif/8gWYYdgIfJth2wsvpC9XEc4Hy5eVin73zNcgwLMs0k9jHvAogBb6tcZf5PfetRK89OhNPEOwMOI/wMQnZgqEq7cVilW1Gzr0MhWIGqAuK/0wrNgZp1MDjaxaBKjJ1m9dAgaz5xWQPrAcEsLvYz74PP3eWFEyf8HbUiGUvG9W7N6DPTO51sZ2ZgzNpo2324JsQgHurNSyEi6UzFPjkgeZ3LKcELkozRfCAOhGe8C/NeLEoUUf0vpejgqAop8Nmhq8Jv1W/4SRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GysaiCT0EYzGAwC1ZaGUT5q9kR8LfOnWpyUyJeaVofU=;
 b=hnDtPSq8KSHZlVImym3WLbNj9lhxdAp+kGSuaDerTkt00n/CoCUdidVrpJGhZiRWB7D6gXjKRT3whY/RedoUYrgs66WbvlM+LP+JFpyjRCSbVBF+3313aW/tav7MM8yYiVHGwAQ5kmf+XJc9yumpMqyDoh17NwP9rNpQZrjfqnA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN6PR04MB0612.namprd04.prod.outlook.com (2603:10b6:404:d9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Mon, 4 Jul
 2022 07:02:57 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91%7]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 07:02:57 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 03/13] btrfs: replace BTRFS_MAX_EXTENT_SIZE with
 fs_info->max_extent_size
Thread-Topic: [PATCH 03/13] btrfs: replace BTRFS_MAX_EXTENT_SIZE with
 fs_info->max_extent_size
Thread-Index: AQHYj2LIJARTTzMBiEO0aIKzhHP+Mw==
Date:   Mon, 4 Jul 2022 07:02:57 +0000
Message-ID: <PH0PR04MB7416C5E6911C2EC0F7FEDF139BBE9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1656909695.git.naohiro.aota@wdc.com>
 <128758fed168a54587c5a0902216aff0e6a72131.1656909695.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6686c591-15ce-48b5-61f1-08da5d8b39a0
x-ms-traffictypediagnostic: BN6PR04MB0612:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ng4VrCr7T3dzIiv7bq6nXdx2MTcYJc/iBtO+jejFhzemeYhGq2urohHiY6Wd+mSxiM0Al3t31gjkxsgmhRexTWCt+lvfw9jbegT+GqJoV99UMlh4GnvNpG9XiTkyzI9bzWTtcA/51QFWARTkqYPJLNuzy17vG/qgto0MbRETX5CVgFVecF7P/78PsJ8iYBZuntBuSygRQZZGNYJ7bzozjtSgZLC8BKkqunfH/WHX2/WV4TS3Z+dMRONaBN14GNN3hvgIcbKDBMV9cfF4QDwxZsdqzy8Ugg4abQ2ur72Ssb7R5ThsVAtpd3ieUw2g1D99GRwuxxIpR2HnP5J+oxf91SVJjfNlg5e1fhZFSdkNxsmaYLiYIqEe+gqpeaRI5F5jvVYs9kT8YepsqAzwWqf0pHZa9BerZ1kdJtEYydNtGbPjxpbHeJAf6Vwm5DSuZIwfz8v6+hUVJCaSsrgO53Or30mAv2Dnv/InjkP7ukpZC9tj1PxaZjYMSf8pUb1nDJxWg9Ug2MVwFihjOvtjwDvpEDAwcyO4yfQjCxOweNWCWbn1L7m5TgfkO8PIlR3rv59tSQ3N6GMQJe66ur0s14PncBvd4GuN6vbXW9YXGI1xszGPCFkMpxmhrRVUtHniUZmh7b8iiohNi9DQ9daKP4TMsUzKdRNlKfwh8BwyTimv2yVraNOP87c0zchaV0bTH2SzrO+Tu6EmGVVvZIXwfeDU5gi/0QxcYZsodvcv3f240o0tC1Bu0IuCiihLOYqE0zeWQxE5A+J1lV1CQS1mFERS3fDBo+E4lYuaNI/kISV69Zct8adLePBOyp/b0e5QiWDE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(8676002)(316002)(91956017)(76116006)(66946007)(66476007)(66556008)(6506007)(478600001)(110136005)(41300700001)(66446008)(64756008)(71200400001)(7696005)(55016003)(8936002)(52536014)(2906002)(5660300002)(4744005)(38100700002)(33656002)(86362001)(82960400001)(122000001)(38070700005)(186003)(9686003)(83380400001)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oJtuS1aL3H6eaVYk3v1fO64a22q6Jz4uGNxRUOqXAQLevfdwCnVCljPwrO4x?=
 =?us-ascii?Q?ek1WsAOczCyAh18cgsSzs55BKhN886jVZwl1K8zU+aR/9vP9vjLu0q4UmsMa?=
 =?us-ascii?Q?HZomOKoL+mu3d2O+IYUSn/AKaH2et9EA+YN/fGnnkREulr9FtpySx+ccZL5L?=
 =?us-ascii?Q?NQj6d8tiEBLnoE8Wa+sGgH5/WlepPFYHH5QYgRglhjaF4sufk8Ymq7DKENmO?=
 =?us-ascii?Q?DpPUE+ggQW4y2aSY36y1pXo92r7HTk2v81Us9J3M8glVDyN2q6PevRm7k5hY?=
 =?us-ascii?Q?mS5IuhTU+jUMzbs318r2m+dSVhcFKg1E9c379SJWhMYZH3BpPNV2MJhCRAji?=
 =?us-ascii?Q?nCToJjk9eeMlFe8RpGfxu4kTyAzChtmiJGVLgzQLo1UrHVoTYWzKA1icse0Z?=
 =?us-ascii?Q?Kz/EzyUaCWNxDdglhxsDN3AuES9LhatRQAZ9Kp0dzCJtGHsGWjQ14bIfd2Ya?=
 =?us-ascii?Q?vbC0a1vXHtLgaOwkEd5YNlxAC3wb1N6yjZ7Qy1gsEBvqWjBOizAHc70ecv6F?=
 =?us-ascii?Q?cHnP7hhbfccfJwM1x4sYu0+ZKoPB/cfBxQNspq46j2IxwqctXoUoUQnJMte1?=
 =?us-ascii?Q?c5qluNFdDNdhARweQsReFWQnXoMmb0pwYmA9+ii0xK/+4Q99tcqFh9G5XRUa?=
 =?us-ascii?Q?7JFptoPErICxz+ftq3fqNzKXI0OcVdf6XtrKIbmtQ7r7wfgJfIGhMGDgj2ze?=
 =?us-ascii?Q?UYW0UI4OtDMnD7NtJyvmN4Rn+OfczgT3yisxoFrb0AyGxI9lp0CdaE1mZrPL?=
 =?us-ascii?Q?1PpvDONHdnfxTSvRUtAbLz1XyDzJTPZlpImd9bHhstLiOazWI6P2W9TjS/dY?=
 =?us-ascii?Q?kF1KbpQlBBA5oaCwXlxggp4aeyg/16PZgJ9GxgwP0VJRKJ9M2nuet9lixUlD?=
 =?us-ascii?Q?l57NLYIFa2Zfldg51EMGWfDrme3Z/EglKTyS9RukiR1Iw8DKv1JrbdVoNxB3?=
 =?us-ascii?Q?Gx2HZX+VskzoUMluOntps8681jzGknCD4ltFPG0qJWAks+CkLEr7yo5sq1AU?=
 =?us-ascii?Q?lr8fxftUvgKcYEi/iKgdcPhO7Kthau4tpIIQdQaFVkNTHMfHodo6ewr0BzMo?=
 =?us-ascii?Q?okhJZ3hnNovvkDwYlZIfzpyghOoEGl5hMp1RejmBqGbT9Wiba0LpjE7w7Bhw?=
 =?us-ascii?Q?mHGpKB3vCx/D+zdiGWGEmMHfiNpAUMmY9S0DYchO0oNZ+4i+FJPEUyQoJqja?=
 =?us-ascii?Q?0D4o5sv8YjxxOE/JDenSgUkgjpfFToyQH1CN4Fu1XnJ009AndE7PtH0M28/p?=
 =?us-ascii?Q?tg/hUx01l6tp0qIwrDKB3BdD6fqpT9XTswQNgrF+UgDvCXeKu8DOy9RCIG96?=
 =?us-ascii?Q?cVjaBk39dzHZm1TKIBmoMZwOjAIWfMnF+OJAskB/5ljLCRlZ+6W2SfhnLID+?=
 =?us-ascii?Q?pEJZ1vD+cAunoBpYXiZERpq4uZWJU7nDWSFLfB69y8qiejiKDK1iL/29HSNx?=
 =?us-ascii?Q?/MRvSimzmGWV7tZG6p4fiTkgE7JBWLH/C+5kwW8xIvbVfe8jHrrfBoYzpYK5?=
 =?us-ascii?Q?IV1Wx8Lu/ia4VbXug9nhd+b4BOFE0OQVgjPlqBZfVIfAv5WfD26a/TbtaDGl?=
 =?us-ascii?Q?CVQz0qtQmBksnck0pK9cXiGB9sYQjl7WHf0RRmCumvomEGs/4qS7ef2c0Bvx?=
 =?us-ascii?Q?/nam1H/GvNxpXBJg/p5yEz6s4t+cvmwXRxaBdHO38cx+GOZekx3HoUPCl+Nn?=
 =?us-ascii?Q?bacqGBnmkdGTAtKhjM+5++PXY1w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6686c591-15ce-48b5-61f1-08da5d8b39a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2022 07:02:57.4527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ix0awtiE2aLButyG6otMG88gkA4HpPnuz7/22p9+YB4iJcbP45pn+YvwAcx9tjrCBVal74jZcuBh2Hlza7t4Za++FQ4UZFj1VEh6uOv/NmI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0612
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 04.07.22 06:59, Naohiro Aota wrote:=0A=
>  fs/btrfs/ctree.h     | 3 +++=0A=
>  fs/btrfs/disk-io.c   | 2 ++=0A=
>  fs/btrfs/extent_io.c | 3 ++-=0A=
>  fs/btrfs/inode.c     | 6 ++++--=0A=
>  fs/btrfs/zoned.c     | 2 ++=0A=
>  5 files changed, 13 insertions(+), 3 deletions(-)=0A=
> =0A=
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h=0A=
> index e4879912c475..fca253bdb4b8 100644=0A=
> --- a/fs/btrfs/ctree.h=0A=
> +++ b/fs/btrfs/ctree.h=0A=
> @@ -1056,6 +1056,9 @@ struct btrfs_fs_info {=0A=
>  	u32 csums_per_leaf;=0A=
>  	u32 stripesize;=0A=
>  =0A=
> +	/* Maximum size of an extent. BTRFS_MAX_EXTENT_SIZE on regular btrfs. *=
/=0A=
> +	u64 max_extent_size;=0A=
> +=0A=
>  	/* Block groups and devices containing active swapfiles. */=0A=
>  	spinlock_t swapfile_pins_lock;=0A=
>  	struct rb_root swapfile_pins;=0A=
=0A=
Shouldn't count_max_extens() use fs_info->max_extent_size instead of =0A=
BTRFS_MAX_EXTENT_SIZE as well?=0A=
=0A=
=0A=
IIRC I did do a similar patch once as well, which then didn't get merged=0A=
for different reasons and count_max_extens() needed to be converted as well=
.=0A=
