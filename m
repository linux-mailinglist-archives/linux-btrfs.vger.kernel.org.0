Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88194C47C9
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Feb 2022 15:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbiBYOjF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Feb 2022 09:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiBYOjC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Feb 2022 09:39:02 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A491AE66C
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Feb 2022 06:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645799909; x=1677335909;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yfs0cQFLbneAo4HG6+ae+7oiyE4cyOuPakh5r41fACc=;
  b=i28FVFf6x/44vA7IX3AyPT5XXtaTPEbItqjYxIL4e04Ro60g7CBdFllD
   9xT/+NYr/BbBa45L2Fv953xcxdgGFz1Octvae6JxNrftikjsRjnwiLV6E
   QHzzQrucGINVYTEJ5IG4LjcHEFthImINfUi1oEz4Q0gRjrxK+xYnL0FhS
   qyw3toIK0Np1hg3xSOKRN27HYbAtHUNbn/wOP1aF8+71AQcajukUkTSzf
   IUmfRc7RXAEP3pBMbw60GnNoG1nlPqzD2119A9OI1qSvAwAjWVvwByXDP
   KO2eE9g1AoiiEQZP1IGcJAe2AIczkE1O/tAH2gVYdMoOibmzyl2NZRUHb
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,136,1643644800"; 
   d="scan'208";a="298069091"
Received: from mail-mw2nam10lp2107.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.107])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2022 22:38:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/XxkAqZb+xsy3fQES9EwQXExs5vUDwDD/e6KSiS0odQKqSxmwKSCghUnNz38HsEpw+vhXPbHk1iNNZ07NU9wnp7KJWhAV2ozPht46rEz4w+bcT2za0Fgd7NGPRb0C4Q80VUq1qeq4FODkrSZGgz57m9UWvc7vgn7yFjtXpYoTkDU+jBHrXfvvcyzV0PWqX5syxsuAANFtDPC8mKn3y6dLt01GSwDr4nanEZ6ZDzSwkBVWBUKbVhgmahcIAPkC8hnVw/S2iC1fvDIQw6iz3hzZGJF2ddD6qcUXMepbF8UKU0h/vHGtBVKkrIEMWN3E0wsB+WqN8DoJrvYvv7eAbNdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xc0ZC+RWi/gs71vXx8BKWRKjt3MnAMTdXCuaB6mtzgU=;
 b=WPqbuQcWxm9mEr6AySSyAMz1vN2ynv6gXVd/t7MFCg+xcjmv6i5g1QtY5O8qzt0nao13rIBPpyXfQ4nW540H8E2cqk0cwBHk6TVVBezdpSonJ2kCJ32J4HR7vAmwp7LUaEIgCjGp1Yk+amIJf5UNFYqvL9vePia4HLgGGuQtB5Z38vLNGIcoP65kLiMBN+3iZY2MrCV5ZnqSqQzUOB67RDeLYXgKQ7JsoeblcakvTnp1Yg6DIcrXgeziHWTFKzxTa0NSB6idJNTOdNeJ4S8GNqI0CQA3NyOSyPs1sNGkG8x1tubf64n1kMbZCS2WgsxQszyY0mWVBi6h1hFn9B8n6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xc0ZC+RWi/gs71vXx8BKWRKjt3MnAMTdXCuaB6mtzgU=;
 b=lWnmVLF3CrTqoZZpDwrJ6ZJ1sfNhThPLM2AS04+kpVCRvFymwNy6MNO5gMM+j9Nu0EKgSgwGmiYyNJd7fVEZHGcSygv/yQhoeoILiY/e92UBnd38QsArMmp/oaycglOXlCEI/n0h4XjvhPmWRv8EGUs1+VOoygzpNj2IiAkp5uc=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH0PR04MB8051.namprd04.prod.outlook.com (2603:10b6:610:fc::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.22; Fri, 25 Feb 2022 14:38:23 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b13a:2b9b:b0a2:d17]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b13a:2b9b:b0a2:d17%8]) with mapi id 15.20.5017.026; Fri, 25 Feb 2022
 14:38:23 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Sidong Yang <realwakka@gmail.com>
CC:     "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [RFC PATCH] btrfs: qgroup: fix deadlock between rescan worker and
 remove qgroup
Thread-Topic: [RFC PATCH] btrfs: qgroup: fix deadlock between rescan worker
 and remove qgroup
Thread-Index: AQHYKa+bxecSbqbIwEqTnhUXKz0P0qyj9dAAgABhfIA=
Date:   Fri, 25 Feb 2022 14:38:23 +0000
Message-ID: <20220225143821.ut4fghtxztresbpc@shindev>
References: <20220223095112.10880-1-realwakka@gmail.com>
 <20220224184803.GA12643@twin.jikos.cz> <20220225084926.GA14534@realwakka>
In-Reply-To: <20220225084926.GA14534@realwakka>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 601cf1a5-b46f-4070-b779-08d9f86c79cc
x-ms-traffictypediagnostic: CH0PR04MB8051:EE_
x-microsoft-antispam-prvs: <CH0PR04MB8051BFEEE0F05983E5D11FC3ED3E9@CH0PR04MB8051.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a7845s9JCJC4KN6pL/PnkHVS4krsuRtuLYfUFELQXVAnVgM0D7q++BGVevE9jz41O5YWTkcT8vqaCMnhe0S5b8E1M1PgNtXRstjgjiZhHGPA/cnQnMiS6+L4WDVK9976bmqBrFfZytFQSBEpMauGaD5YlLHnK2wlGsCvQsadMg8AlmpJ/PSg7i24k4jogTMuaMnLNcSPmpJ4i1rCde0vS5O5SmY18LpjgBGRGvYIS5xhIn2Vd3+DzSp6nwaVXy35UWzhzH8DmaYHtF+kr/27rS4G+kXIxhlDxPvFOctFOUm7HSqv60fvOvqQZnXcULv+QTyTpgg8YWTZTiStpKNI81VYN+6qhR7oELJuN+cwItoKRblkKv/A+3GlSD6EG6rers99C08R2U9Uj1VVhdKRGLp3lZXmUkMTrTNiZxF/tA2TpE9S4tKYeshOYGm0ZdcgWm5S6or8XG0/xI/pWa8KlfwZ7Wahg/HtF2G5mWRWro43KcgwvAK7VlWvnA/xqAMHghrAixZXlAWSEj2Nb6Rrxp2P7uYH3f0DrgKSXtpnWav6pg5vv6EQ8qrf1mKQyFGKcHf58TLUNLUG/DRAG6w3dm9/4FDp5o2UpcyeyLwXXS4ZRzA0n0q4sao/0npaSMNK8xRCTKI4OiIzOkYgfyAZ9ZEODz2Ms/s6Uq0hiwGNb+BtJ+um4Dy2XtmSBbPMowi2ReKItJ2SBw8WVyJ++bmQVA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(1076003)(6506007)(9686003)(33716001)(6512007)(38070700005)(71200400001)(6486002)(508600001)(38100700002)(86362001)(82960400001)(122000001)(83380400001)(186003)(26005)(8936002)(6916009)(44832011)(8676002)(54906003)(66556008)(64756008)(66446008)(4326008)(66476007)(76116006)(2906002)(91956017)(66946007)(316002)(30864003)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?96L2MNCZyRNj6uDMhKCDkBSquyMyIsxRwk3krYodZb/0oYRo0STiSgeLGVwH?=
 =?us-ascii?Q?jk272S6sAAfofYUkMkmSlG28Z1p96spyauu5vYsw4Lcbfh6kPYO3gD0sx0QU?=
 =?us-ascii?Q?j1co3PL4zwIVRL3ZNdQeoO7cKnMgz8cXfsJ7Q2Gi9hCLay3tijK9XVhsXyYR?=
 =?us-ascii?Q?Hvj/J1JmRj/+A/v2/DFrECpGjLTWT5KtQFyHcGbXNo6pjS8072OwzS6CJfwN?=
 =?us-ascii?Q?YZTvxf1hXXa5a5KlfG7uFsLplvKjAif35OmlhqsxPsjTgcNk0I9DFbVafisl?=
 =?us-ascii?Q?sd6agPBC/yjfTOgGp8YC0X9GZFsW3q+ZHXUxK+aV9fXJxvuCvQVUqhUjRBz2?=
 =?us-ascii?Q?v+eS0rE+ICw+KmbZhg8+8aLyigrWYLIx1hhaGtRFtRPx8+7+vlI2sHjH6kQh?=
 =?us-ascii?Q?XrgBjGY5PILm/85QBjRY2OtKxRyLm1bLlrKIQDiWN6j3MC9o3KoQF2E4DPzl?=
 =?us-ascii?Q?yyZ1zqbH/jrMiU21/GcM4nT1q0F79tfFuHS1dY8dBRfo8c/TbjNBLbaeX1HF?=
 =?us-ascii?Q?UwDi/1ooRn0aCfSNUPeHvnOvsamYADNpFxjk1GAQSyiyQfR7uAEn5d8xLfMI?=
 =?us-ascii?Q?bFXrLwxhzBJQ/y0E8SAPl+0BLJthuGrN0wTSDZxrmLc2aIeIWgZG2RSfTHG2?=
 =?us-ascii?Q?OGE/Qp2ZTnZgzC/2QzpXOG6Xbu4yWeSssN8pfvC+aJRdBJCv4mAs47ovSlou?=
 =?us-ascii?Q?sfGRYWAOf/ck6W7CgJ3kMzw5wfBLDlNEUijiXZL8MOc/BTCeDtP9x98PN0h9?=
 =?us-ascii?Q?0fCmM/iwuwPcQUn1/5UGBB1TlkcGg2nQcOZqzm22DahSEkC/rv74E/5PtfeK?=
 =?us-ascii?Q?ScAzHMhnFI5bOJ7QsNQw+5yRauoA4z4KZp4M6WoWd4feSctwFpFS5PwPrYdJ?=
 =?us-ascii?Q?JxnIHl4IGzYpK7aO2QGXmHLBYCHORQMl7OfP4S7dv0pVzsFJCHSFBCmxLX2S?=
 =?us-ascii?Q?OYVpHGTR8P2rwcSHh+4nlFIQ7c2pdu9fxc7ZNr1Y3LKNa3o8Xi7MbNWUFxNl?=
 =?us-ascii?Q?OhBn0/9xPSlikoYRmWFbGQ+QRt/CT+c/2HJs+GLsVoxm+5rN8Rs5WJA0NsW4?=
 =?us-ascii?Q?5MeMp1nW/QKRq96uH1+WBwkY/38g9Nds4v5NKyX9uHq7aoVRAlr33oLUFw99?=
 =?us-ascii?Q?vbneJpqZmQx+EuQ6H8ZWojYM2P1QvQ/LW6Ti7rceJF4FSwK3BnMXWy27cUg2?=
 =?us-ascii?Q?vYWuyBdVbJKThcje/9MzbYGDel6S6+Q5DLUCZXzVEeL0iKyEjPWWJ4c0V5S7?=
 =?us-ascii?Q?PP5J1DthQFMY39irs0Yn0iY2NQG5zy3+UxtYmj5bWFmTXmZEorfo5qg5pcW9?=
 =?us-ascii?Q?Pbd+BCm/DpZxxUN8tjggyIQ0QP87601/+qWAHGQA9f+SNr8fBnmw/ANX9/nj?=
 =?us-ascii?Q?n55zNCo1V1ZUWRig+MNfD2EUK9q7CsBt2pB9rv28MkQecsTKMbt5cEP8414o?=
 =?us-ascii?Q?1Mx7iODGEaY8PH9A+0llNwJWWPwUGbMdp/UFB5L+uQveiqxYi/1gTt9dSald?=
 =?us-ascii?Q?CzdsyK+G/fmk8ZfTgWK8r5nC/308RlvX68Isv+OWPq7q+g0OIsT+kqVLRBDo?=
 =?us-ascii?Q?8lpc6p+Dnk4UjtxJ68Ta+IRhU0vsCo1N4pVQTlAy6x+/os4u0iWSSdPjwUiw?=
 =?us-ascii?Q?NI+2S6Jb5Fl4576RvjGHAk+x3nNgDtylp+Z/BOSbZhqcI7PascbeXrbmGl3+?=
 =?us-ascii?Q?XuHb/K1xSwqwV3S1/7F7EwryeZE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C8F1947FCBFFA14DA9EBBD70E6179149@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 601cf1a5-b46f-4070-b779-08d9f86c79cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 14:38:23.2158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7vH4s+ZtmGWNheyEBzneodqVD31Q4R4Pk3GTB8JjsEtGkCHHad90fA54qo+UZsC2kBzDtPXYhknDAco8xg3CutjXdrhXZ0uwHWRoNcMv4s0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8051
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Feb 25, 2022 / 08:49, Sidong Yang wrote:
> On Thu, Feb 24, 2022 at 07:48:03PM +0100, David Sterba wrote:
>=20
> Hi, David.
> Thanks for reply.
>=20
> > On Wed, Feb 23, 2022 at 09:51:13AM +0000, Sidong Yang wrote:
> > > The patch e804861bd4e6 by Kawasaki
> >=20
> > Added to CC
>=20
> Thanks, I'll add CC for next patch.

Hi Sidong, David, thank you for letting me know.

> >=20
> > > resolves deadlock between quota
> > > disable and qgroup rescan worker. but also there is a deadlock case l=
ike
> > > it. It's about enabling or disabling quota and creating or removing
> > > qgroup. It can be reproduced in simple script below.
> > >=20
> > > for i in {1..100}
> > > do
> > >     btrfs quota enable /mnt &
> > >     btrfs qgroup create 1/0 /mnt &
> > >     btrfs qgroup destroy 1/0 /mnt &
> > >     btrfs quota disable /mnt &
> > > done
> > >=20
> > > This script simply enables quota and creates/destroies qgroup and dis=
ables
> > > qgroup 100 times. Enabling quota starts rescan worker and it commits
> > > transaction and wait in wait_for_commit(). transaction_kthread would
> > > wakup for the commit and try to attach trasaction but there would be
> > > another current transaction. The transaction was from another command
> > > that destroy qgroup. but destroying qgroup could be blocked by
> > > qgroup_ioctl_lock which locked by the thread disabling quota.
> >=20
> > That looks like the cause.
>=20
> I agree.

I ran the simple script, recreated the deadlock on my machine, and took a l=
ook
in the deadlock detail. I think the deadlock happens as Sidong's explanatio=
n.

> >=20
> > > An example report of the deadlock:
> > >=20
> > > [  363.661448] INFO: task kworker/u16:4:295 blocked for more than 120=
 seconds.
> > > [  363.661582]       Not tainted 5.17.0-rc4+ #16
> > > [  363.661659] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" dis=
ables this message.
> > > [  363.661744] task:kworker/u16:4   state:D stack:    0 pid:  295 ppi=
d:     2 flags:0x00004000
> > > [  363.661762] Workqueue: btrfs-qgroup-rescan btrfs_work_helper [btrf=
s]
> > > [  363.661936] Call Trace:
> > > [  363.661949]  <TASK>
> > > [  363.661958]  __schedule+0x2e5/0xbb0
> > > [  363.662002]  ? btrfs_free_path+0x27/0x30 [btrfs]
> > > [  363.662094]  ? mutex_lock+0x13/0x40
> > > [  363.662106]  schedule+0x58/0xd0
> > > [  363.662116]  btrfs_commit_transaction+0x2dc/0xb40 [btrfs]
> > > [  363.662250]  ? wait_woken+0x60/0x60
> > > [  363.662271]  btrfs_qgroup_rescan_worker+0x3cb/0x600 [btrfs]
> > > [  363.662419]  btrfs_work_helper+0xc8/0x330 [btrfs]
> > > [  363.662551]  process_one_work+0x21a/0x3f0
> > > [  363.662588]  worker_thread+0x4a/0x3b0
> > > [  363.662600]  ? process_one_work+0x3f0/0x3f0
> > > [  363.662609]  kthread+0xfd/0x130
> > > [  363.662618]  ? kthread_complete_and_exit+0x20/0x20
> > > [  363.662628]  ret_from_fork+0x1f/0x30
> > > [  363.662659]  </TASK>
> > > [  363.662691] INFO: task btrfs-transacti:1158 blocked for more than =
120 seconds.
> > > [  363.662765]       Not tainted 5.17.0-rc4+ #16
> > > [  363.662809] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" dis=
ables this message.
> > > [  363.662880] task:btrfs-transacti state:D stack:    0 pid: 1158 ppi=
d:     2 flags:0x00004000
> > > [  363.662889] Call Trace:
> > > [  363.662892]  <TASK>
> > > [  363.662896]  __schedule+0x2e5/0xbb0
> > > [  363.662906]  ? _raw_spin_lock_irqsave+0x2a/0x60
> > > [  363.662925]  schedule+0x58/0xd0
> > > [  363.662942]  wait_current_trans+0xd2/0x130 [btrfs]
> > > [  363.663046]  ? wait_woken+0x60/0x60
> > > [  363.663055]  start_transaction+0x33c/0x600 [btrfs]
> > > [  363.663159]  btrfs_attach_transaction+0x1d/0x20 [btrfs]
> > > [  363.663268]  transaction_kthread+0xb5/0x1b0 [btrfs]
> > > [  363.663368]  ? btrfs_cleanup_transaction+0x580/0x580 [btrfs]
> > > [  363.663465]  kthread+0xfd/0x130
> > > [  363.663475]  ? kthread_complete_and_exit+0x20/0x20
> > > [  363.663484]  ret_from_fork+0x1f/0x30
> > > [  363.663498]  </TASK>
> > > [  363.663503] INFO: task btrfs:81196 blocked for more than 120 secon=
ds.
> > > [  363.663568]       Not tainted 5.17.0-rc4+ #16
> > > [  363.663612] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" dis=
ables this message.
> > > [  363.663693] task:btrfs           state:D stack:    0 pid:81196 ppi=
d:     1 flags:0x00000000
> > > [  363.663702] Call Trace:
> > > [  363.663705]  <TASK>
> > > [  363.663709]  __schedule+0x2e5/0xbb0
> > > [  363.663721]  schedule+0x58/0xd0
> > > [  363.663729]  rwsem_down_write_slowpath+0x310/0x5b0
> > > [  363.663748]  ? __check_object_size+0x130/0x150
> > > [  363.663770]  down_write+0x41/0x50
> > > [  363.663780]  btrfs_ioctl+0x20e6/0x2f40 [btrfs]
> > > [  363.663918]  ? debug_smp_processor_id+0x17/0x20
> > > [  363.663932]  ? fpregs_assert_state_consistent+0x23/0x50
> > > [  363.663963]  __x64_sys_ioctl+0x8e/0xc0
> > > [  363.663981]  ? __x64_sys_ioctl+0x8e/0xc0
> > > [  363.663990]  do_syscall_64+0x38/0xc0
> > > [  363.663998]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > [  363.664006] RIP: 0033:0x7f1082add50b
> > > [  363.664014] RSP: 002b:00007fffbfd1ba98 EFLAGS: 00000206 ORIG_RAX: =
0000000000000010
> > > [  363.664022] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007=
f1082add50b
> > > [  363.664028] RDX: 00007fffbfd1bab0 RSI: 00000000c0109428 RDI: 00000=
00000000003
> > > [  363.664032] RBP: 0000000000000003 R08: 000055e4263142a0 R09: 00000=
0000000007c
> > > [  363.664036] R10: 00007f1082bb1be0 R11: 0000000000000206 R12: 00007=
fffbfd1c723
> > > [  363.664040] R13: 0000000000000001 R14: 000055e42615408d R15: 00007=
fffbfd1bc68
> > > [  363.664049]  </TASK>
> > > [  363.664053] INFO: task btrfs:81197 blocked for more than 120 secon=
ds.
> > > [  363.664117]       Not tainted 5.17.0-rc4+ #16
> > > [  363.664160] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" dis=
ables this message.
> > > [  363.664231] task:btrfs           state:D stack:    0 pid:81197 ppi=
d:     1 flags:0x00000000
> > > [  363.664239] Call Trace:
> > > [  363.664241]  <TASK>
> > > [  363.664245]  __schedule+0x2e5/0xbb0
> > > [  363.664257]  schedule+0x58/0xd0
> > > [  363.664265]  rwsem_down_write_slowpath+0x310/0x5b0
> > > [  363.664274]  ? __check_object_size+0x130/0x150
> > > [  363.664282]  down_write+0x41/0x50
> > > [  363.664292]  btrfs_ioctl+0x20e6/0x2f40 [btrfs]
> > > [  363.664430]  ? debug_smp_processor_id+0x17/0x20
> > > [  363.664442]  ? fpregs_assert_state_consistent+0x23/0x50
> > > [  363.664453]  __x64_sys_ioctl+0x8e/0xc0
> > > [  363.664462]  ? __x64_sys_ioctl+0x8e/0xc0
> > > [  363.664470]  do_syscall_64+0x38/0xc0
> > > [  363.664478]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > [  363.664484] RIP: 0033:0x7ff1752ac50b
> > > [  363.664489] RSP: 002b:00007ffc0cb56eb8 EFLAGS: 00000206 ORIG_RAX: =
0000000000000010
> > > [  363.664495] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007=
ff1752ac50b
> > > [  363.664500] RDX: 00007ffc0cb56ed0 RSI: 00000000c0109428 RDI: 00000=
00000000003
> > > [  363.664503] RBP: 0000000000000003 R08: 000055d0dcf182a0 R09: 00000=
0000000007c
> > > [  363.664507] R10: 00007ff175380be0 R11: 0000000000000206 R12: 00007=
ffc0cb58723
> > > [  363.664520] R13: 0000000000000001 R14: 000055d0db04708d R15: 00007=
ffc0cb57088
> > > [  363.664528]  </TASK>
> > > [  363.664532] INFO: task btrfs:81204 blocked for more than 120 secon=
ds.
> > > [  363.664596]       Not tainted 5.17.0-rc4+ #16
> > > [  363.664639] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" dis=
ables this message.
> > > [  363.664710] task:btrfs           state:D stack:    0 pid:81204 ppi=
d:     1 flags:0x00004000
> > > [  363.664717] Call Trace:
> > > [  363.664720]  <TASK>
> > > [  363.664723]  __schedule+0x2e5/0xbb0
> > > [  363.664735]  schedule+0x58/0xd0
> > > [  363.664743]  schedule_timeout+0x1f3/0x290
> > > [  363.664754]  ? __mutex_lock.isra.0+0x8f/0x4c0
> > > [  363.664765]  wait_for_completion+0x8b/0xf0
> > > [  363.664776]  btrfs_qgroup_wait_for_completion+0x62/0x70 [btrfs]
> > > [  363.664995]  btrfs_quota_disable+0x51/0x320 [btrfs]
> > > [  363.665136]  btrfs_ioctl+0x2106/0x2f40 [btrfs]
> > > [  363.665385]  ? debug_smp_processor_id+0x17/0x20
> > > [  363.665402]  ? fpregs_assert_state_consistent+0x23/0x50
> > > [  363.665417]  __x64_sys_ioctl+0x8e/0xc0
> > > [  363.665428]  ? __x64_sys_ioctl+0x8e/0xc0
> > > [  363.665439]  do_syscall_64+0x38/0xc0
> > > [  363.665450]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > [  363.665459] RIP: 0033:0x7f9d7462050b
> > > [  363.665466] RSP: 002b:00007ffc1de68558 EFLAGS: 00000206 ORIG_RAX: =
0000000000000010
> > > [  363.665475] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007=
f9d7462050b
> > > [  363.665480] RDX: 00007ffc1de68570 RSI: 00000000c0109428 RDI: 00000=
00000000003
> > > [  363.665486] RBP: 0000000000000003 R08: 00005629e953b2a0 R09: 00000=
0000000007c
> > > [  363.665492] R10: 00007f9d746f4be0 R11: 0000000000000206 R12: 00007=
ffc1de69723
> > > [  363.665498] R13: 0000000000000001 R14: 00005629e8e5708d R15: 00007=
ffc1de68728
> > > [  363.665510]  </TASK>
> > >=20
> > > To resolve this issue, The thread disabling quota should unlock
> > > qgroup_ioctl_lock before waiting rescan completion. This patch moves
> > > btrfs_qgroup_wait_for_completion() after qgroup_ioctl_lock().
> > >=20
> > > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> > > ---
> > > Hi, I found some deadlock bug with testing a simple script.
> > > With this patch, it seems that it resolves it. but I don't know much =
about how
> > > transaction works. and I'm afraid that it has other side effects.
> >=20
> > I had a quick look and did not see anything obvious, the qgroup waiting
> > is done in onther contexts without any apparent conditions or other
> > restrictions.
>=20
> Yeah, I think it doesn't have side effects so far. But actually as a
> newbie, I didn't understood correctly that you said. I guess what you
> said is that there is no other cases that locks qgroup_ioctl_lock and
> thread removing qgroup goes deadlock again. It is right?
>=20
> >=20
> > > ---
> > >  fs/btrfs/qgroup.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> > > index 2c0dd6b8a80c..85e5b3572dda 100644
> > > --- a/fs/btrfs/qgroup.c
> > > +++ b/fs/btrfs/qgroup.c
> > > @@ -1219,8 +1219,8 @@ int btrfs_quota_disable(struct btrfs_fs_info *f=
s_info)
> > >  	 * deadlock with transaction by the qgroup rescan worker.
> > >  	 */
> > >  	clear_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags);
> > > -	btrfs_qgroup_wait_for_completion(fs_info, false);
> > >  	mutex_unlock(&fs_info->qgroup_ioctl_lock);
> > > +	btrfs_qgroup_wait_for_completion(fs_info, false);
> >=20
> > Yeah waiting with a mutex held can lead to problems unless the locks ar=
e
> > compatible in that way.

Yes, I missed that point... I put the btrfs_qgroup_wait_for_completion() ca=
ll
within qgroup_ioctl_lock guard expecting it would avoid qgroup rescan worke=
r
start by quota enable ioctl. But, now I don't think such guard is required.
Both quota enable and quota disable ioctls are guarded by fs_info->subvol_s=
em.
On top of that, qgroup_rescan_init() checks BTRFS_FS_QUOTA_ENABLED bit befo=
re
starting rescan workers.

>=20
> I think this lock is needed for checking quota_root. Is it better that
> unlock right after checking it? It would make shorter ciritical section.

Agreed. Since clear_bit() is atomic, it can move out of the qgroup_ioctl_lo=
ck
guard, I think.

With these changes, I ran the simple script and confirmed the deadlock
disappeared, as Sidong reported.

--=20
Best Regards,
Shin'ichiro Kawasaki=
