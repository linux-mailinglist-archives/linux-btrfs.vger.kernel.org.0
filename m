Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97D83A63CF
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Jun 2021 13:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235586AbhFNLR1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Jun 2021 07:17:27 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:42352 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234603AbhFNLPU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Jun 2021 07:15:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623669197; x=1655205197;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=PNFHl4DXVFciaDZKMRpPZFJmLcPl5uOlhSPiMv/Nkuo=;
  b=j9+1/RcyGF0w7VAwzxsZpI8nPLm2xCNfC7ysDCJCVxX6oM++87/IW2M/
   QisnmhjoGgpS7paMsynQZjP2ovjkw1AmlBKMUMOu/W3ht2ErxPWDcrRcm
   EuHihOMA7A42jvKKSk56VmeuSzqUbdcxEyAcYc+WFPineTwmJv+L2LFDx
   oDsRnMMl14ydtL8p6AOW6PUljPiO4kUwF8nLESsFMJgEHmAtala37AMJT
   HZj+C9ZFUBdUaaorZa3PLQsY5WE8enA9wJGduwtm5r+E1Ug0C+x61bFD8
   qaC2B1hzPPY5Qlfq+Pm4uJaog1LB7FTkmgJvtm8yZ4QFn9iXkKpLoO/Fe
   A==;
IronPort-SDR: PsL2FXvtYkrWNlLHNPTjYsYlSZ8jagUwsz5zT+11XOTFWVy6hO96MySB8YzoCZ578I7YVFc6yV
 W3TvryqNJi+W58QSuLbFBZYAfBaL4CrABYHhB7PA5nrlt4W4Vu9sTnUjOpg71NMG5C56PTeHzD
 R7hKK4FoPiPX+ly3Dh1g24hKO36JAoiKZyhEUfyNA4nyNEwjAdyqAtID9C1PAO2opYJ6fFaNiv
 Oo4XjzyAx0DwJX/PWMLjfTxE0on1y2AIG1dM6lFCqHZf3xVY7Qs51mVziCrEP4a5ALf1AnDvnW
 IW8=
X-IronPort-AV: E=Sophos;i="5.83,273,1616428800"; 
   d="scan'208";a="172381124"
Received: from mail-bn8nam11lp2171.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.171])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jun 2021 19:13:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dua8ma5wySCwxrNoImvAdcxNtKxkZSm9UrBLjUPJjt2ESnNnmctvLwJyZRWPVM3ah9QrynbqmatwIXsKdWYkuEOh0354YxUYnrCtWJUPQ3VWtiVINyQ98igrEYbAQFB7qQ40ZbEwTpuHO3BZiVmw1JmRYMvi8C6Epl3anr2dhSIleq+JriGevV9yf3vQpijHa7/UbElNZhIa4FprzH/VVnFvzlVoFpJkoFKUhNEY/JtMyXujOyxShsf/tsNf60+KSVjsX5wh8xwyydNiS+v3AdA569apx7uaG4v1gow9EZkaEdk4xpAx71n21UtKTue4k4YPwiHvJ+m1QfNVrcovyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q28w098wmi0Lw5Oql1bNGnFWuCnu6qBZqHmkRtnIaJY=;
 b=CIu5Sw0kv7+fnoWVlNQ/sRc8vWQ0HHOHItDZjxPuQtnOIGvMGmRIAeOVBM/Y9xXcE8YPDeW9TMoZolD0Lnabe9oRTr+wT4+D8LQc7MXn733WnAqFSULRHYtqd+Yj1FIwvyPjaH28SraeJjBPk5O8R+4xNI/6Wkmrt4f+Iy6mLEbMGW1MGl3cWuXM53RtWN6WNicudDx9w1TKJ2EK7qbJ7TRke5WqXBYJwos8iGvqINEehRYiTk7O0cBcy11uuuAFVXac/L3WQIpM/zk13+YnC2jhumx6W5poZHgb2YQZDv7a1FMiPl4xN5Ytwy8MRxSpGJKSwK7KpKnlJk2AymSb5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q28w098wmi0Lw5Oql1bNGnFWuCnu6qBZqHmkRtnIaJY=;
 b=QBE4q9yQ496/ZJ+sEH50tMm9sYtKqBvuj1E+KzU57s3RMaihPyuPy6iZ5hFhaAavAC1SraruzjdQ8ceg8f0LYHxE2Kqa3q0Xflu9pvnWtQ5J/j17UmaLSwVnRC2a/KLEvIny0HhdsJ7tYBiGaYxLR/j6+PFii5bLErnHFS6Mnm4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7574.namprd04.prod.outlook.com (2603:10b6:510:52::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Mon, 14 Jun
 2021 11:13:11 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 11:13:11 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 0/4] btrfs: shrink delalloc fixes
Thread-Topic: [PATCH 0/4] btrfs: shrink delalloc fixes
Thread-Index: AQHXXslBFGexZqNHJ0K2j9ntLgRm3w==
Date:   Mon, 14 Jun 2021 11:13:11 +0000
Message-ID: <PH0PR04MB7416C662FBFAE76EE0371D879B319@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1623419155.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:141b:f301:b8f2:4976:f3ee:4d36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16ea47d6-f6a4-4cc8-f4a8-08d92f25657e
x-ms-traffictypediagnostic: PH0PR04MB7574:
x-microsoft-antispam-prvs: <PH0PR04MB75741CFBD5AFD7F3BE91083E9B319@PH0PR04MB7574.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aAv35Ld5GfvX+KgGvb1lne6ZVA5udB52jkmcaoX4O/yIvsAWZMwiQQMIbPsx0rFqKk6G9pHlNPgDCTkbTpdS0Tl0YOQKfsnaj+rNt8C5lT9SXqv5EuKF8kojtFz0yaQpamYN7NaIC1kZae/HEtuvgHkhuALYtA5WAW4SLiYIElAl0sWRXRRyOI6W8Ycq6Z9PMhF6kJ2Or6uRdJ9xCliHs8VqE9kAnKVdSPSqtb3V5ShsR5wtjysQ4s1mYf03lmyxsaVDJcZIO2Wq/7S3DIswxHfryCzbOrDgIoz6x5jcTeAu8H3rBdOo+dEv/sbREjTfd3rubSqNgmvkcPu9358hm/m91Y/btUKqfFFSOVvMCKyTeSwWimgJt5CrKFVQAyUgyGS+KP8+IZJMvffG9pLj6fCI6SWy6M08xXWpIKKgbrsVuLinX+0akGsGdoY7b21dIJqWz1svNd19TA+BHbWGQXDEj3rSjKxJ/QmEsylLmBhYkDo/35K1pJfJUboQ7JQAuJYv0yZ/5l6YLz7C91riK+Fr4suf5x82svcKSBYTO1b6+8pdd5ZxZ4buZtrX0kSgGHZ43kl9YLnUjvyOKil2VBF88uDrlhPTg1wrZ/Pfwzc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(86362001)(83380400001)(66556008)(66476007)(9686003)(5660300002)(66946007)(76116006)(38100700002)(52536014)(8936002)(66446008)(64756008)(33656002)(8676002)(186003)(55016002)(110136005)(2906002)(316002)(478600001)(7696005)(71200400001)(6506007)(122000001)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b7y+X2UwDXDMnIZCMoUhCqu44nBxCwMeIt1NVal1agp8wpNUNkYD8uXmWRuF?=
 =?us-ascii?Q?+8CJCERxIoxk0V2lTE6VxQb3V0+a7Reeknw/X+hT0nCGJlN8D+j04Py1lkyw?=
 =?us-ascii?Q?Yu2GF5W/ZNAAScq07i/igZUMrJev8O0YjZMLX/t/CltBPp/FAK7ipdcUrZzP?=
 =?us-ascii?Q?pfhB8bZRBLSEU7zsOsxp244TlpQBRYd8IQDVWXVIyRfgcGoatqRIaFycIZA/?=
 =?us-ascii?Q?8OY6DruRJvFRw70YCb3m53JEc/upt+3fouabKsPvxIuI1EA0Fpe9PA2YG+Pt?=
 =?us-ascii?Q?/mykt3zn63ccJen1rRumLtcHAcIDOIPm+k959c105hLEOMiohNI+v9PADsrC?=
 =?us-ascii?Q?QHz8U5Kk4A/sG3sS0rE7o47Vj/H/zJe9tluxRKDQUTPkfj68YFqn6AlzZePP?=
 =?us-ascii?Q?1OmivZ3TYodldKIbtb6f7rKqGmsU+9H+32foV1Hhxt41fc6GLiKXgEp5jvKZ?=
 =?us-ascii?Q?kuiEsk7PNB0ZY4qJ8EIU2fPYLGQnLvrel/DRmCEkW0FEhhFPqvb2fvjQbCnQ?=
 =?us-ascii?Q?qCx++rKQ9fwD5SppI5lO4muiR8nALFV9vG7TywBoAp82KKvHqIBzdPlfjIOO?=
 =?us-ascii?Q?5w/5g3ZxT9Pd52V1xk6BsTu4MniGbL81eeyNL8Daumbh8DTPYlhGhnfeTA3A?=
 =?us-ascii?Q?uX0Om1+0Tdpm95vyVEYxtz/oHsBn4hyFI/wUA47b9n6DOtSUKskFP6ocP7oU?=
 =?us-ascii?Q?JQPx0KhZ5TM2vj333V4f1MCq5YEo8ze9OgL/4AHoTwZk+C02R6icKJVvySpR?=
 =?us-ascii?Q?H/kvfDL9P9HRIzYES2Adr2MHD4TTbGsCUlhqQ68itUNAC5NECbyNmSIpwCay?=
 =?us-ascii?Q?NqU9ZIcYKr2XLgfjygzo6YzqqBKNk/2Ty18jasxNdhKiuLuCJuRYRsofwljz?=
 =?us-ascii?Q?onQa+krntt6VDobTnsqu9JA6gDOCjGfzxetVW2if6CETZ3qFm676yX3JHBqO?=
 =?us-ascii?Q?vVh/f3aV3+eyfb9Vc0e3xD7YvINwbgkGandQapi52U/f0mGQ/fdSdKRmTBCw?=
 =?us-ascii?Q?LfQyaI4pTD3HmU3pmzqcfp2gXP9C7JS/mLp+UEKLOx+N9eHaGAp+TACwuXFg?=
 =?us-ascii?Q?VVohDMB7A20T/zzBFFfTqwAMwMUGt6RQVR1M5hxST+vFK+4u6Uan5D1mRv04?=
 =?us-ascii?Q?Lvpb7MCQiP3b55w2Si+mXWJg+TkX6igf750uN4c4/cTtcLDpocIPeeHUFb12?=
 =?us-ascii?Q?0PbxX3FfB3gkR7axb4FcVaDVjGeP0fpsXCx8KKUbkNERTWLT+r3rE+VT/OkT?=
 =?us-ascii?Q?YNA9G9jlUdMkVf8mGASG2eRdAQxwyOBxPtY394gdvVrO1QUQ5P/bXwWJRWe0?=
 =?us-ascii?Q?/wFlufrQWl22odGkHnHJiojBBjeU32R4Wgt1gTc+IiXV9G3OOZiZFPwmlE8n?=
 =?us-ascii?Q?shV7ZGkdKsOjYUI6KSiw2p98JACbZd1HjkbBMW7g6i8XvVsgGw=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ea47d6-f6a4-4cc8-f4a8-08d92f25657e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2021 11:13:11.0958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YkViOpUuTp49xlBKOsdfRqL63bTtHiOaeAsuaWNDo4bMa215cd0JNJQN0yKW41k5XbX424wEK2NVevyZM7QGjNfNRpQHZ+JjwYUgjUX4UEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7574
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/06/2021 15:54, Josef Bacik wrote:=0A=
> Hello,=0A=
> =0A=
> I backported the patch to switch us to using sync_inode() to our kernel i=
nside=0A=
> Facebook to fix a deadlock when using the async delalloc shrinker threads=
.  This=0A=
> uncovered a bunch of problems with how we shrink delalloc, as we use -o=
=0A=
> compress-force, and thus everything goes through the async compression th=
reads.=0A=
> =0A=
> I ripped out the async pages stuff because originally I had switched us t=
o just=0A=
> writing the whole inode.  This caused a performance regression, and so I=
=0A=
> switched us to calling sync_inode() twice to handle the async extent case=
.  The=0A=
> problem is that sync_inode() can skip writing inodes sometimes, and thus =
we=0A=
> weren't properly waiting on the async helpers.  We really do need to wait=
 for=0A=
> the async delalloc pages to go down before continuing to shrink delalloc.=
  There=0A=
> was also a race in how we woke up the async delalloc pages waiter which c=
ould be=0A=
> problematic.=0A=
> =0A=
> And then finally there is our use of sync_inode().  It tries to be too cl=
ever=0A=
> for us, when in reality we want to make sure all pages are under writebac=
k=0A=
> before we come back to the shrinking loop.  I've added a small helper to =
give us=0A=
> this flexibilty and have switched us to that helper.=0A=
> =0A=
> With these patches, and others that will be sent separately, the early EN=
OSPC=0A=
> problems we were experiencing have been eliminated.  Thanks,=0A=
> =0A=
> Josef Bacik (4):=0A=
>   btrfs: wait on async extents when flushing delalloc=0A=
>   btrfs: wake up async_delalloc_pages waiters after submit=0A=
>   fs: add a filemap_fdatawrite_wbc helper=0A=
>   btrfs: use the filemap_fdatawrite_wbc helper for delalloc shrinking=0A=
> =0A=
>  fs/btrfs/inode.c      | 16 ++++++----------=0A=
>  fs/btrfs/space-info.c | 33 +++++++++++++++++++++++++++++++++=0A=
>  include/linux/fs.h    |  2 ++=0A=
>  mm/filemap.c          | 29 ++++++++++++++++++++++++-----=0A=
>  4 files changed, 65 insertions(+), 15 deletions(-)=0A=
> =0A=
=0A=
I've ran this through xfstests on a zoned device and got the following lock=
dep=0A=
splat. I'm not sure if this is your fault or my fault. btrfs_reclaim_bgs_wo=
rk()=0A=
very much sounds like my fault. Writing it here for completeness anyways.=
=0A=
Otherwise no noticeable deviations from the baseline.=0A=
=0A=
[  634.999371] BTRFS info (device nullb1): reclaiming chunk 3489660928 with=
 22% used=0A=
[  634.999445] BTRFS info (device nullb1): relocating block group 348966092=
8 flags metadata=0A=
                                                                           =
                =0A=
[  642.127246] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D                                                =
                                                                           =
                                                                           =
                                                                           =
                      =0A=
[  642.127876] WARNING: possible circular locking dependency detected=0A=
[  642.128526] 5.13.0-rc5-josef-delalloc #1080 Not tainted=0A=
[  642.129060] ------------------------------------------------------=0A=
[  642.129699] kworker/u4:5/11096 is trying to acquire lock:        =0A=
[  642.130259] ffff888278839438 (btrfs-treloc-02#2){+.+.}-{3:3}, at: __btrf=
s_tree_lock+0x28/0x120 [btrfs]=0A=
[  642.131321]                           =0A=
               but task is already holding lock:=0A=
[  642.131921] ffff8882bdc45cf8 (btrfs-tree-01#2/1){+.+.}-{3:3}, at: __btrf=
s_tree_lock+0x28/0x120 [btrfs]=0A=
[  642.132926] =0A=
               which lock already depends on the new lock.=0A=
                                                                           =
                                                                           =
                                =0A=
[  642.133767]                                                             =
                                                                           =
                                =0A=
               the existing dependency chain (in reverse order) is:        =
                                                                           =
                                =0A=
[  642.134529]                                                             =
                                                                           =
                                =0A=
               -> #2 (btrfs-tree-01#2/1){+.+.}-{3:3}:                      =
                                                                           =
                                =0A=
[  642.135181]        down_write_nested+0x23/0x60                          =
                                                                           =
                                =0A=
[  642.135647]        __btrfs_tree_lock+0x28/0x120 [btrfs]=0A=
[  642.136238]        btrfs_init_new_buffer+0x7d/0x2a0 [btrfs]=0A=
[  642.136844]        btrfs_alloc_tree_block+0x113/0x320 [btrfs]           =
                                                                           =
                                =0A=
[  642.137460]        alloc_tree_block_no_bg_flush+0x4f/0x60 [btrfs]       =
                                                                           =
                                =0A=
[  642.138115]        __btrfs_cow_block+0x13b/0x5e0 [btrfs]            =0A=
[  642.138688]        btrfs_cow_block+0x114/0x220 [btrfs]=0A=
[  642.139296]        btrfs_search_slot+0x587/0x950 [btrfs]=0A=
[  642.139907]        btrfs_lookup_inode+0x2a/0x90 [btrfs]=0A=
[  642.140501]        __btrfs_update_delayed_inode+0x80/0x2d0 [btrfs]=0A=
[  642.141177]        btrfs_async_run_delayed_root+0x174/0x240 [btrfs]=0A=
[  642.141878]        btrfs_work_helper+0xfe/0x530 [btrfs]=0A=
[  642.142454]        process_one_work+0x24f/0x570=0A=
[  642.142931]        worker_thread+0x4f/0x3e0      =0A=
[  642.143357]        kthread+0x12c/0x150  =0A=
[  642.143748]        ret_from_fork+0x22/0x30         =0A=
[  642.144181]                                      =0A=
               -> #1 (btrfs-tree-01#2){++++}-{3:3}:   =0A=
[  642.144807]        down_write_nested+0x23/0x60    =0A=
[  642.145260]        __btrfs_tree_lock+0x28/0x120 [btrfs] =0A=
[  642.145839]        btrfs_search_slot+0x259/0x950 [btrfs]=0A=
[  642.146413]        do_relocation+0xf9/0x5d0 [btrfs]=0A=
[  642.146960]        relocate_tree_blocks+0x293/0x610 [btrfs]=0A=
[  642.147579]        relocate_block_group+0x1f2/0x560 [btrfs]=0A=
[  642.148201]        btrfs_relocate_block_group+0x16c/0x320 [btrfs]=0A=
[  642.148869]        btrfs_relocate_chunk+0x38/0x120 [btrfs]=0A=
[  642.149479]        btrfs_reclaim_bgs_work.cold+0x5d/0x10f [btrfs]=0A=
[  642.150162]        process_one_work+0x24f/0x570=0A=
[  642.150628]        worker_thread+0x4f/0x3e0=0A=
[  642.151062]        kthread+0x12c/0x150     =0A=
[  642.151450]        ret_from_fork+0x22/0x30=0A=
[  642.151872]                                 =0A=
               -> #0 (btrfs-treloc-02#2){+.+.}-{3:3}:=0A=
[  642.152518]        __lock_acquire+0x1235/0x2320                         =
            =0A=
[  642.152985]        lock_acquire+0xab/0x340                              =
         =0A=
[  642.153409]        down_write_nested+0x23/0x60                          =
                =0A=
[  642.153872]        __btrfs_tree_lock+0x28/0x120 [btrfs]                 =
            =0A=
[  642.154455]        btrfs_lock_root_node+0x31/0x40 [btrfs]               =
         =0A=
[  642.155064]        btrfs_search_slot+0x6bc/0x950 [btrfs]                =
                =0A=
[  642.155639]        replace_path+0x56f/0xa30 [btrfs]                     =
            =0A=
[  642.156181]        merge_reloc_root+0x258/0x600 [btrfs]                 =
  =0A=
[  642.156773]        merge_reloc_roots+0xdd/0x210 [btrfs]   =0A=
[  642.157368]        relocate_block_group+0x2c9/0x560 [btrfs]             =
                                                                           =
                                =0A=
[  642.157986]        btrfs_relocate_block_group+0x16c/0x320 [btrfs]       =
           =0A=
[  642.158660]        btrfs_relocate_chunk+0x38/0x120 [btrfs]        =0A=
[  642.159272]        btrfs_reclaim_bgs_work.cold+0x5d/0x10f [btrfs]=0A=
[  642.159951]        process_one_work+0x24f/0x570=0A=
[  642.160418]        worker_thread+0x4f/0x3e0=0A=
[  642.160850]        kthread+0x12c/0x150=0A=
[  642.161243]        ret_from_fork+0x22/0x30=0A=
[  642.161664] =0A=
               other info that might help us debug this:=0A=
=0A=
[  642.162480] Chain exists of:=0A=
                 btrfs-treloc-02#2 --> btrfs-tree-01#2 --> btrfs-tree-01#2/=
1=0A=
=0A=
[  642.163616]  Possible unsafe locking scenario:=0A=
=0A=
[  642.164226]        CPU0                    CPU1=0A=
[  642.164699]        ----                    ----=0A=
[  642.165164]   lock(btrfs-tree-01#2/1);=0A=
[  642.165553]                                lock(btrfs-tree-01#2);=0A=
[  642.166183]                                lock(btrfs-tree-01#2/1);=0A=
[  642.166820]   lock(btrfs-treloc-02#2);=0A=
[  642.167209] =0A=
                *** DEADLOCK ***=0A=
=0A=
[  642.167812] 6 locks held by kworker/u4:5/11096:=0A=
[  642.168288]  #0: ffff8881000c4938 ((wq_completion)events_unbound){+.+.}-=
{0:0}, at: process_one_work+0x1c6/0x570=0A=
[  642.169317]  #1: ffffc900046e3e78 ((work_completion)(&fs_info->reclaim_b=
gs_work)){+.+.}-{0:0}, at: process_one_work+0x1c6/0x570=0A=
[  642.170507]  #2: ffff888136c6a0a0 (&fs_info->reclaim_bgs_lock){+.+.}-{3:=
3}, at: btrfs_reclaim_bgs_work+0x5d/0x1b0 [btrfs]=0A=
[  642.171687]  #3: ffff888136c68838 (&fs_info->cleaner_mutex){+.+.}-{3:3},=
 at: btrfs_relocate_block_group+0x164/0x320 [btrfs]=0A=
[  642.172877]  #4: ffff88811d11f620 (sb_internal){.+.+}-{0:0}, at: merge_r=
eloc_root+0x178/0x600 [btrfs]=0A=
[  642.173871]  #5: ffff8882bdc45cf8 (btrfs-tree-01#2/1){+.+.}-{3:3}, at: _=
_btrfs_tree_lock+0x28/0x120 [btrfs]=0A=
[  642.174906] =0A=
[  642.175362] CPU: 0 PID: 11096 Comm: kworker/u4:5 Not tainted 5.13.0-rc5-=
josef-delalloc #1080=0A=
[  642.176215] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014=0A=
[  642.177366] Workqueue: events_unbound btrfs_reclaim_bgs_work [btrfs]=0A=
[  642.178065] Call Trace:=0A=
[  642.178323]  dump_stack+0x6d/0x89=0A=
[  642.178670]  check_noncircular+0xcf/0xf0=0A=
[  642.179085]  __lock_acquire+0x1235/0x2320=0A=
[  642.179509]  lock_acquire+0xab/0x340=0A=
[  642.179889]  ? __btrfs_tree_lock+0x28/0x120 [btrfs]=0A=
[  642.180442]  ? find_held_lock+0x2b/0x80=0A=
[  642.180843]  ? btrfs_root_node+0x93/0x1d0 [btrfs]=0A=
[  642.181359]  down_write_nested+0x23/0x60=0A=
[  642.181781]  ? __btrfs_tree_lock+0x28/0x120 [btrfs]=0A=
[  642.182327]  __btrfs_tree_lock+0x28/0x120 [btrfs]=0A=
[  642.182862]  btrfs_lock_root_node+0x31/0x40 [btrfs]=0A=
[  642.183411]  btrfs_search_slot+0x6bc/0x950 [btrfs]=0A=
[  642.183940]  ? release_extent_buffer+0x111/0x160 [btrfs]=0A=
[  642.184526]  replace_path+0x56f/0xa30 [btrfs]=0A=
[  642.185019]  merge_reloc_root+0x258/0x600 [btrfs]=0A=
[  642.185557]  merge_reloc_roots+0xdd/0x210 [btrfs]=0A=
[  642.186087]  relocate_block_group+0x2c9/0x560 [btrfs]=0A=
[  642.186658]  btrfs_relocate_block_group+0x16c/0x320 [btrfs]=0A=
[  642.187283]  btrfs_relocate_chunk+0x38/0x120 [btrfs]=0A=
[  642.187839]  btrfs_reclaim_bgs_work.cold+0x5d/0x10f [btrfs]=0A=
[  642.188472]  process_one_work+0x24f/0x570=0A=
[  642.188894]  worker_thread+0x4f/0x3e0=0A=
[  642.189273]  ? process_one_work+0x570/0x570=0A=
[  642.189714]  kthread+0x12c/0x150=0A=
[  642.190053]  ? __kthread_bind_mask+0x60/0x60=0A=
[  642.190492]  ret_from_fork+0x22/0x30=0A=
[  644.827436] BTRFS info (device nullb1): found 3645 extents, stage: move =
data extents=0A=
[  645.132633] BTRFS info (device nullb1): reclaiming chunk 4026531840 with=
 22% used=0A=
