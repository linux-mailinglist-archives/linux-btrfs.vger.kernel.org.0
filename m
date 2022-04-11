Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9074FB465
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Apr 2022 09:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245163AbiDKHNp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Apr 2022 03:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241772AbiDKHNn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Apr 2022 03:13:43 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C93338A5;
        Mon, 11 Apr 2022 00:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649661086; x=1681197086;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mOfEBPs7CzVBwFhtXIw7PMR9OKZ7dITHx//oHKEIZ3I=;
  b=EK+4GvtVkdZTLisZOnxTWZ9KTdm9Cskj1KCe+oe1i+sA9auGQukmvw3l
   gp9F0FLV7ueg8IWNrfLXKnOI2OR7VfCn8oDsW3I/fnaeLrEJlv5xe9pOU
   +w9DHPZHPIxl1meuJ4P1dHPAS+BTxLMBkoJECRyERbY9lwbRmokbjQlnc
   VyirHXfT41mAokaCUoFE3vQXMB/SoaW2WZ6ntikMfasrMEs/oXbrHmcXQ
   S8hXz6qSkjNtwvls3AONzixWjw5sVjadlkNoCDwM5LyBKRYaKW407vu/9
   05Qsi8eTMT5IHJ33Zniw8UU3LpxnSrMjkXHwl7H9xMh/SNluyyJgXK9VG
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,251,1643644800"; 
   d="scan'208";a="309567009"
Received: from mail-bn8nam08lp2041.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.41])
  by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2022 15:11:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2aClRT2QRpoTHPnjPgY7nIzKPuOhi1R/dbnpJnnWNHKYL6XHCR02MDKvgWqEXsQLn2LxEZlP8K2y1yH7biNPc0R534SAmkwY3N41N6EvT7X8gLyJxGsgF1e/ph/KzTaMbUPUGipJOk5k3c8LQMBQ453oKhN0J6YWcqwrevCrqlUlNriXaqOSK40mdDyynZIfE6scbAELACv9XcdaNTXADjQtn1D9Al+HoT/dsEZlYo8nZYu3kZY7aAmRfAOoQ1FBol+zTcOb+R/vYKD86DOgdUQ4Lv6FI0cyaXO6sRVpY1u6VnpH+Hk+Qg96H2RvLbEa2vkw97tfrwjKI3lzcnKkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZH1zmobvA3dt4rCEK743fSBUTTsmN+tEsyNEQ544LE=;
 b=foA9vFtz9h8BTHL0hV06Jyr4AqIigYnOi8zMEJuLkFF54nZG5w6jpmRF2RgURS0p45lVMNaoqAS7P9CPzlifIKi/XH16Ww2da+yB79Pn/g7Xu9udP0Y+8Bc8fjy6/AmXWw1aPBr8KfpgFOP/EN2SAclCC1oE6PPLYdnv5m1NjkFalh5QdPsREInE66WU8dcEG1e0ajhyX780P6LRjIVZrcLrzpzU6E9vgZzgrVx7kkehilTAycCAT1lZOHMHzYvWLP8hvL3rsGFITWBykwx6Byz6KTNa3dSD9JinvsSF20aP+arDjKGaQDYMVx9rl1eBEYfK67GGZOFTqE+m2P28Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZH1zmobvA3dt4rCEK743fSBUTTsmN+tEsyNEQ544LE=;
 b=YPpSwAv1BPQm+lsF97skNlck5uakNx+SZ/jd2LQdosd07vv/CDRBOMtjVoljulbPJgFidvWpUy3eiggVcQCDeYPpCIMIcjrRFLCH0UuSbeDddicRlN0L+owNL4/If66dj+PGO0hPqRz2s5/a+b6VkeM4RB368IkNU4tQFYgsvI0=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by CY4PR0401MB3587.namprd04.prod.outlook.com (2603:10b6:910:8d::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 07:11:24 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::8422:d8d:3844:1536]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::8422:d8d:3844:1536%3]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 07:11:24 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
CC:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH] btrfs: wait between incomplete batch allocations
Thread-Topic: [PATCH] btrfs: wait between incomplete batch allocations
Thread-Index: AQHYSichAkdsxoKIM0Khpq5R5KWda6zqUmYA
Date:   Mon, 11 Apr 2022 07:11:24 +0000
Message-ID: <20220411071124.zwtcarqngqqkdd6q@naota-xeon>
References: <07d6dbf34243b562287e953c44a70cbb6fca15a1.1649268923.git.sweettea-kernel@dorminy.me>
In-Reply-To: <07d6dbf34243b562287e953c44a70cbb6fca15a1.1649268923.git.sweettea-kernel@dorminy.me>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: adfe9a0e-4f11-4759-b914-08da1b8a7d5e
x-ms-traffictypediagnostic: CY4PR0401MB3587:EE_
x-microsoft-antispam-prvs: <CY4PR0401MB3587DF118C7C3C4EC4BE23F58CEA9@CY4PR0401MB3587.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rI6UMTRRdoGys4Tt6K5zOrb3RAdld+CxOA2ncMurqTefvvdxYyJ0dYrU9G77GNNicR062zOZTOue12qRpEe/0xnKfX91SsRVr2H97LHZ3KZD582TvCqz5HLhSc72Mxor4g3kvBiW4JxMV4xTqI2aNa5NKM69qA976DW0a0kP+AU4v5FWhqHGsm39dnJFIadEKpjrOgcj2Tuy4z2KEx9MsiFoLNTmFZS5kDr2lvgRjWvwjhw3ckxSRRjw/RFFOIj7QoOr003ogNV3SeAuxC/S22wvT/hzONlLQ7pdJ97NX4fxs8epoXo+DpXjWbdhnJjAMqXnvzFKdzpOjH2AfdLjO6DDafhAt3bJavJQY4tpSWUHexUFcv1HvHYh9nVQZZNAFAQwMJd0Stg/ww3ATw4imoDJiw28DQwnw0AtNss0se9yn8FJaO8lwOoECvMKmorSR9QgtByIT97/i6Lr2vTuShSq99f/lzGXU597fFIF7/Lk8qNRKwnd+MW2MX0kO6f18Y3DwlTZnPnKxdkYrR+lFg+tiO0tFwkbdac1XdtVuCcmBjzLF9dycYNm7CX0JpVC2HrKkaCVkXN2gpGQ5v6NR0tiT0HaFBm4C386Vg9sPgam7xmUeWKpBvjdfr2nahvpGH07F/sOiL2zVPyOWUWpyi+4APJlSVgk14Nq7+MOu2ulhVb4EcJRzfHkmZ/oDdHyEUYQFkRBS8X7Rz+h2CLjMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(6506007)(2906002)(508600001)(316002)(6512007)(5660300002)(86362001)(186003)(83380400001)(26005)(38100700002)(66446008)(8676002)(1076003)(64756008)(82960400001)(9686003)(122000001)(4326008)(6486002)(66946007)(66476007)(91956017)(38070700005)(33716001)(54906003)(66556008)(6916009)(8936002)(76116006)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KQOz6msJXgvd0qdtm4bSOIz2Eb9YSQoJUOpOZ/wG+EYDJtZO/yYt0tqxQ7zo?=
 =?us-ascii?Q?gQh8xRSGfg4qJYfes01HEpAD+s0hbA9PRiuZ7cPdti6Xugrd9JlNILiLLpRg?=
 =?us-ascii?Q?ejOine9MT3/5IXijg2xUmQZGKeDRc//B5Sk1DAmUdajkHMn/XC2UcXM4IWaf?=
 =?us-ascii?Q?3DOEHSQf2SDZ3YN1p9CBsL/oqrdQX6LvUvUz9K9EZUX94wRcTKZ5pdPlQYla?=
 =?us-ascii?Q?aKHrXuEteqjuLOfJfAlyL7asejKxTyxae7Y8XCBtVJb6/Mm1tb0MCZF4dcgR?=
 =?us-ascii?Q?d2w1dIUD0Aes5HNGrG2PMqWr2swunXx0/w3rMiQ3u4Rb7cj7CnCybDQAqxJF?=
 =?us-ascii?Q?qFaB3k7suzm5yOg2tG8xYQsKylZFAgqE40rbMPnY8neyEp+roZ4OQDLSo8//?=
 =?us-ascii?Q?JPFKADnNVwj2K7SbOVsYaPOUX7c2OiSiI7atOL2Gkgy57wCG6rgEmVpFVnqf?=
 =?us-ascii?Q?mLCDGH+2tD08Eg/Mxxb7dmKKY9SxC2t7eNnkRFDS0fKv3hp05LvE6gm7kxyP?=
 =?us-ascii?Q?bJInx3orv9FbvKh9ldRjp1+AoCVjav4uE3NVjT+wqfdW1R4pBqJWVT4f8/WR?=
 =?us-ascii?Q?84q/o4gkUU7rvTMOStg0nwANuYfPT7DQSKIU0YrTnU5gGK4ecgCONtjou6ky?=
 =?us-ascii?Q?OFQOiZj+cjznuMDZUqu1hbXmwbjsnSzKO8nrjJnlp99vEttrr8ToUMepCD7t?=
 =?us-ascii?Q?a4bKc9NATFIUSXCS7kq4qWby5pmLmCUokAJjmOmN0U31WeKBZlVl0m39x0BP?=
 =?us-ascii?Q?Vj/mpC/96Oh98KczSIN3PbFUfuHQfXSBB2UuOION7lvjlJSNW3vFwe9MbxFh?=
 =?us-ascii?Q?1i8wneMPRSmuuHiqrx2HNwzbilyGqFul7uDZRMhqXhTMNVz9IpGl5X+e7Z13?=
 =?us-ascii?Q?5mQYbbT3iazRiogH+VmYQkJrVvsXlpShJDXS8LIkV6PLHuGtTDzvsSULeX/r?=
 =?us-ascii?Q?f7yMWpnJZJMHSPT6bjpgDtlbWwQ00eWTx97VhhcXKbTV1MkoG3lmy5hdAuwL?=
 =?us-ascii?Q?b6pmcpamosOD9YHFG2XwiIPSysQ7f/TN/IVayWDNM4XAC8asqKOfeR3P46Dn?=
 =?us-ascii?Q?u2KlACO94REJ5IpwvWW0e4+MhzxpaSOKvPqE8ECBl2DPV33Q15iCgrQcLDum?=
 =?us-ascii?Q?MgDiL8vLy5CGEA25wr8hfkxM/XPQF4fpWgg45/63U78qCVyjqFNQ0V47+jYX?=
 =?us-ascii?Q?QU39JqKMb7DttWuky2MSRZwbkTAtU9lrmw7n7nksHERMvQVoLnR/8PbE14oO?=
 =?us-ascii?Q?onCJ+sedJ/4PfAoEipigVK3pVqCPrcqpTbEyeoqyPVOLGWkK3BVvatfhyAtQ?=
 =?us-ascii?Q?xwp7kyt5KiojLsSxQHtZ6pc0LeVfSnkcuNuabR1aB4P9O0otclDhtcj/5pxL?=
 =?us-ascii?Q?xiPddXpDx72dsTUDDLDq7xgw/zey2pOcBQXKCq4BLc4RkaDS/SoXi627DPdG?=
 =?us-ascii?Q?T8YYjjhTzqW9IpvJrDa9Y/iR0MoFojJQo+cvdFHqWIEElykFqDEIoClUT5Z1?=
 =?us-ascii?Q?RNeXC6qE6+HaUmQqowZkIZTqpg9+t73XvQjOPRg+gQBmovuh5lbn3+gzdPl7?=
 =?us-ascii?Q?i3p/6h2QpOLTQd7Lxqkph6UPGbpS8BqBc0ZjbAHo2U3j/aQQZaFvHu2oTn1W?=
 =?us-ascii?Q?ZEtlnVAcOuweRl7EJYAF0wDUsnrFgdIqR0K4tYWWloHD6yDmB2b3pE5TEpUl?=
 =?us-ascii?Q?YgIW1Rch9dtkwFsz9DdVCfWnc08I/qk5oYkk71XvNGZ0nH0bb0G9GgZZyxLq?=
 =?us-ascii?Q?ZCz9N3NjAIjCkZuyquQVtOuxlmDSojg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CF0374E0302ACB40AB70EB25D8C1BBDF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adfe9a0e-4f11-4759-b914-08da1b8a7d5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2022 07:11:24.7893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HIKzBCNgbv8ubgl4IYopk7mnP4sOexe6bamXdHPILmG+mGsCfTFCRTNUn9bcBhJDI8oSrk86zlAzwpBIS+RjHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0401MB3587
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 06, 2022 at 02:24:18PM -0400, Sweet Tea Dorminy wrote:
> When allocating memory in a loop, each iteration should call
> memalloc_retry_wait() in order to prevent starving memory-freeing
> processes (and to mark where allcoation loops are). ext4, f2fs, and xfs
> all use this function at present for their allocation loops; btrfs ought
> also.
>=20
> The bulk page allocation is the only place in btrfs with an allocation
> retry loop, so add an appropriate call to it.
>=20
> Suggested-by: David Sterba <dsterba@suse.cz>
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

The fstests btrfs/187 becomes incredibly slow with this patch applied.

For example, on a nvme ZNS SSD (zoned) device, it takes over 10 hours to
finish the test case. It only takes 765 seconds if I revert this commit
from the misc-next branch.

I also confirmed the same slowdown occurs on regular btrfs. For the
baseline, with this commit reverted, it takes 335 seconds on 8GB ZRAM
device running on QEMU (8GB RAM), and takes 768 seconds on a (non-zoned)
HDD running on a real machine (128GB RAM). The tests on misc-next with the
same setup above is still running, but it already took 2 hours.

The test case runs full btrfs sending 5 times and incremental btrfs sending
10 times at the same time. Also, dedupe loop and balance loop is running
simultaneously while all the send commands finish.

The slowdown of the test case basically comes from slow "btrfs send"
command. On the HDD run, it takes 25 minutes to run a full btrfs sending
command and 1 hour 18 minutes to run a incremental btrfs sending
command. Thus, we will need 78 minutes x 5 =3D 6.5 hours to finish all the
send commands, making the test case incredibly slow.

> ---
>  fs/btrfs/extent_io.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 9f2ada809dea..4bcc182744e4 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -6,6 +6,7 @@
>  #include <linux/mm.h>
>  #include <linux/pagemap.h>
>  #include <linux/page-flags.h>
> +#include <linux/sched/mm.h>
>  #include <linux/spinlock.h>
>  #include <linux/blkdev.h>
>  #include <linux/swap.h>
> @@ -3159,6 +3160,8 @@ int btrfs_alloc_page_array(unsigned int nr_pages, s=
truct page **page_array)
>  		 */
>  		if (allocated =3D=3D last)
>  			return -ENOMEM;
> +
> +		memalloc_retry_wait(GFP_NOFS);

And, I just noticed this is because we are waiting for the retry even if we
successfully allocated all the pages. We should exit the loop if (allocated
=3D=3D nr_pages).

>  	}
>  	return 0;
>  }
> --=20
> 2.35.1
> =
