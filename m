Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846D7650785
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Dec 2022 07:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbiLSGXO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Dec 2022 01:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiLSGXM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Dec 2022 01:23:12 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5F32AE8
        for <linux-btrfs@vger.kernel.org>; Sun, 18 Dec 2022 22:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1671430991; x=1702966991;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=y8oaxRi1o/wbcFtyLkbpLrtaHmdrgReu9Lw4P4PRGzk=;
  b=rIbh21qsyPEPhJ7QXIrIlfN7Una9g4xWSUyrZYCUEQ2EaDDy4lKnzPTA
   nBGScTSEuvmR6pER6QrJrarIFkFzCIyet4dmk2CGo0F0vw8Yi1UiZfxfv
   7gd7O5zt40l6+9woDkJYnHA0pLcLl0F/i5xD4FFd92tC33KOavoM4qjde
   JD/Ff2Nd9nwS4+G2AckSQZmoPyU8PI9z2FXJ87OXPyH+7zdmQjvf+Qk37
   fES2HqK7L+zTs5XxmMWipE1seSbwnzaFlhWZNBm5ktMoU8+AS8Ew7qYHo
   rYNhdBfAsa7NU4X87vVMZGI1zispTf9tlJlfEpZC99i2cp4PfD0wU8CH6
   g==;
X-IronPort-AV: E=Sophos;i="5.96,255,1665417600"; 
   d="scan'208";a="323334395"
Received: from mail-mw2nam04lp2170.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.170])
  by ob1.hgst.iphmx.com with ESMTP; 19 Dec 2022 14:23:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOUcxjNA6hImspCrsuFt7PAy+uucMKfqUiujm3Saj/KUZ6ECr13USjaUQ8KJC0FPxBB77Gu7aGw6zcti1+E96C3kfTh74T7f2RT050BGv0YoHnbBY2SUjRluJ5eK9w9x/AAUqzZm4Te5RSsh5iBTrCWZegGfIYfcXuFDkgmV6jm4sKyQplVqCQnhGZE5qfPI/BVZCyACKD2ZcDYULi/cYthlNvHswBZgv82lI3qtMUKYvL6Y/e0m1BHux5iBtL5bE7SSCGSOYpxchw1jWfCHNYJvsvbNKgtQQokp6CFXCQ2tnnWEFXD377V/ZclbhCDj0wh4hrdwbAL2bXrr/TI9kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQQ8QdIZpovYQ+Pt23SYX9DKSXwr0tS5z61Dcqderwk=;
 b=dfV/oeNHCZ7DCvRJhqWheJyZlEucmNvlEBM/eVnMiDt4/orxphf2BqJOTnwC3IknQrJhAez/XDcJ9j2iiodjvUA8IrbenAMOyhLNgjlANIs0QNgYWvlkiNVeq2YQPLiazTeN1u91WvP0mOjhnN2d1tTaU5TwmhdQC9ewVba1QWL71+6KIhosc3T8k+b/DCTVzeywICZuYfpp8aisx6i4pcyND3c0qY0NXZtQ82MOXkYNJqnLiR0xA2Z82vivV4/XWM+9i27vdBM/R4A6tGpfsyi3W1D4M57OUO0/tahltaP3q86FGsKkd02ZIrhUy5dqM9iv9XbwBYywUBj72NlwSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQQ8QdIZpovYQ+Pt23SYX9DKSXwr0tS5z61Dcqderwk=;
 b=i2yobB1GPMcQ87naxtOADwW6zqgsXBXpJrfW9sq6hOlGlfP01+ACoM459C9GsFBi+6lBxgCUWI0nIErbF+lbgOKyF+GKU177LKjozs4ie8kiZJNFTujgat+kWTyQACjsmH0s8Dm8Jdfe0bitml5gJ+LcU57I/61bwrDs89bXuuA=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by BN8PR04MB5537.namprd04.prod.outlook.com (2603:10b6:408:5c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 06:23:05 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::c080:1687:4429:ed73]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::c080:1687:4429:ed73%9]) with mapi id 15.20.5924.019; Mon, 19 Dec 2022
 06:23:05 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 7/8] btrfs: fix uninit warning in btrfs_sb_log_location
Thread-Topic: [PATCH 7/8] btrfs: fix uninit warning in btrfs_sb_log_location
Thread-Index: AQHZEYt89wD1GjEDLkO7fdy83Eq+va50wZuA
Date:   Mon, 19 Dec 2022 06:23:05 +0000
Message-ID: <20221219062303.k6jhz5v63bbervab@naota-xeon>
References: <cover.1671221596.git.josef@toxicpanda.com>
 <81030329cd7526ec374fa4e76ac6bc4b0ed56e25.1671221596.git.josef@toxicpanda.com>
In-Reply-To: <81030329cd7526ec374fa4e76ac6bc4b0ed56e25.1671221596.git.josef@toxicpanda.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|BN8PR04MB5537:EE_
x-ms-office365-filtering-correlation-id: 32851339-05ea-4add-6315-08dae1897d48
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mBQ2/Obm0UIFV89nB9ulPlmc7ZDxN0vTNSW5Wr3FhG+u3pbCJvxgYjo7iE3JcYBmw/J/VEYHXb+waDI11PtoryZ9pP9X/lYlKYanWDgr1/yqxgUx6t+63lDNiH11dV2LdfqBn/MJcNVNHkvBfxDwB9xeacGC98dkg35UsVVvA0gasWEGhJNXx0vlS0EVZlFm7/px3I2hkffXjq9LQMSIkQk5+dKSne4P+GJuuCHqH7M6Eh9GAvQ3jgkzx3tvcZ9Ue8Wdhv+dSKJsbXbQp3f3FXOf/+llgELtp2e0NFv8Kssipfxj0tKjkBPML7kHXGxK7LPXjV+MEg9/LKQU3qEzw9w9/YiG1V6GCLmUJyMdG9KAvDIHIYn0/iHtrAb7S7Xq7jxpwM5nxgpaCV6XQF9gNmV92A6ys7nBzV+VujPUrWRtJ+O31vmGpg0yHDGQ2jPs7vvXGIA5bf70twLk1E1Mjc/U9jYWbXdllFTrgDlsYM4TT66mcs62jCy1+c3ePetCsFqbF3DjI2iP0Ps0m5ea9e8iVr9kMiQ5orCyV+z4y2b1v+rfK0PwoD0aUWpVdnTF0LUmloMgPGRSD+ec3oQ59Ehek05EpaL6ksjm2zgFaxVIHLB0YNv5T/pel9lB0T5vDrtEJgH9XjZ23+ahviMIa3MdbZI10R3Np+35Cl4nte6AI5z5ocKUzvDDCyS97ldodjyPqrqZQQ6F/1diBg81KA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199015)(6486002)(478600001)(71200400001)(6506007)(66946007)(66556008)(66476007)(66446008)(64756008)(76116006)(186003)(91956017)(26005)(6512007)(9686003)(86362001)(316002)(54906003)(6916009)(38070700005)(1076003)(82960400001)(38100700002)(122000001)(8676002)(4326008)(41300700001)(4744005)(8936002)(33716001)(2906002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PSC3wTPY7D81OeW2magV2JDT0vfiHr19blo0zUNLt/N6hEG32vdjBQgo30pN?=
 =?us-ascii?Q?7cRz98mIPjG7b38NSZ5bEJbo8s+tn1OlUSzDlN5CMSnq4WSET4xF5lL+FEiU?=
 =?us-ascii?Q?nAdtdpstKlVvOZyQ/zQhBcfaVWN7ZUSdQ64o2aCkfU+tzte0dWRJfnBWPIQ4?=
 =?us-ascii?Q?MaZS62H+qtOQZ3Gvcx34nm3LgQhKkjGGaAlmS3hAmMWTPLc92yV9xPGBeJyH?=
 =?us-ascii?Q?l0M40yCzKGew98PFBtIiYAq7hsrrU36XDjFEwmNEKKl4rSykwaRa8Yq2fKFf?=
 =?us-ascii?Q?aQlTm1rw3HGjW5wttgLuQ4rTCHSSLkOUEUUTZlUqvYKcFCtlC8Bb8sX7M9JI?=
 =?us-ascii?Q?XHFLDJCI1IIuSmHnDny1N7ucyTrEcuQKooqPgKlI2dpgHP2b4i1P0ZOAVOd7?=
 =?us-ascii?Q?sDzhJjsDWBef2Q+XUJUNXZhVnQu06TLwESotr291d2gzYU7np3smC8CXbd6Q?=
 =?us-ascii?Q?F2ldDgfX3i2RQwx52Lo6LNXIakP3U+p1yTj7rxAoqyBDJNagbdvNd+JmmXYL?=
 =?us-ascii?Q?B9Bw+yvwJq2LYko7xoCjmxxZjve4fdfqA8OeMi3G5E1o1jg/aX0Wsi0phuD/?=
 =?us-ascii?Q?U6jEfu9HlRMV2PwwVlf6/Y/sNUG0aYfJo9D+dwfzde2aFRpNznupUsAB3e09?=
 =?us-ascii?Q?Kjde0Xz2vAVeri9IQx1m0EI3NTq0iELykFnVMqVd1k3JjSRsjKm18cq0Kj66?=
 =?us-ascii?Q?hu3Bl4ULzIPTXRgHyF8f7J65zqsKD/OUP6CsvVIt5yAjdE3fsvkfyhnmXg3F?=
 =?us-ascii?Q?6tp7F/3KgDiKZ91kVSA0xZFzZNVOoeyuUGfAY9rgHJnbXJmCPUzyRXdk9owS?=
 =?us-ascii?Q?5uL4tGckmw1QH9XW94wny55rR4KGoGcZTfqYoXlSy/REs33KexbrIShKXyw6?=
 =?us-ascii?Q?mK9uHoTFTp1s6jssoS8RIXj+8rV5R0vg0mucjSsMTa0sjNBFYjaOmXyxBP6I?=
 =?us-ascii?Q?99nGItfQnEJBFrT/OgqMybNoVjsuSOLz9NuVvRfsZUfLYe594xkYnTeaou87?=
 =?us-ascii?Q?0I07toQl/PGovacjbYtaBlBenRdib9vmL/g4Wcfz75iAbylNBq9yZCIMMuz1?=
 =?us-ascii?Q?uqtMF3GPaxqV5Pud7vd1i//P5qk/etCeJO8aq+DQU8lWGaIXgOPiJSSdD9Gp?=
 =?us-ascii?Q?vg95PIIf+Bon76aNf1yAoL3HwxAkAqDLfZf92U8lQy4lE9j4aGrfiMb/7oBA?=
 =?us-ascii?Q?Bw/eb5RGvu6USfrjBcVR2p+QwA+oFFgjcInRWIudYLtFNlcRNL/CZBa06DtT?=
 =?us-ascii?Q?YGpNw3Ry8oDMbvNTRBpdhlBrIjzqU5N9ljMcyDKJeBoDjD9a/VAnooCWR2oR?=
 =?us-ascii?Q?pBdGEeOLdflMVchFdmeUUSkAG4pj71f5mMsNqz1jYAmWChCHbd6ATD0uclwv?=
 =?us-ascii?Q?mRVk0HuQaPk010RQVNjyEQ8vr5vps5HTpM1UcrSInUGRTJRQaaZjIK9gpFL5?=
 =?us-ascii?Q?yoILPVR8JR/W97wdrAzeV8ELE/7roHF+1xRLI4SOpysmD3AYpjxD0pcR/VH0?=
 =?us-ascii?Q?tcr3rTBs/rUWypZCI0xOOxe9RuavGApA7p1fIRW1EsgntmMTa0/UJjG+71wy?=
 =?us-ascii?Q?q0H80YSxysFF9JO81nh98/fzM1jrkgSg0KQ+nMO262Rt6Y3feDZefJ3RdHWc?=
 =?us-ascii?Q?6w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <696D181F97F28C468B29DA82408E09D6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32851339-05ea-4add-6315-08dae1897d48
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2022 06:23:05.4699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tHbddZg1tOLe8REFSm9IvLe5JdwwNu/M/e050/NiKUN0/V2N1QYtoPb3G9/Myp1D6gv9QIL3rfS2L63jG0tFNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5537
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 16, 2022 at 03:15:57PM -0500, Josef Bacik wrote:
> We only have 3 possible mirrors, and we have ASSERT()'s to make sure
> we're not passing in an invalid super mirror into this function, so
> technically this value isn't uninitialized.  However
> -Wmaybe-uninitialized will complain, so set it to U64_MAX so if we don't
> have ASSERT()'s turned on it'll error out later on when it see's the
> zone is beyond our maximum zones.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Looks good.

Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>=
