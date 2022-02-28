Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8572D4C6076
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 01:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiB1A42 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 27 Feb 2022 19:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiB1A41 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 27 Feb 2022 19:56:27 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C876E4CA
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Feb 2022 16:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646009748; x=1677545748;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=e4E8ud/XupmKpR2fR3LfSB4grViE+iDxRHJlcGFpPuk=;
  b=Y6hq309YdlGdsf7jeKDS0NrwyaoUw+ApxtXTBtzp2dWx5vATYCHVVWYs
   KJqkiMT4u/B/wNrt9WiiAuRUT8RNnOPU3fErjmebEmr2fStqwyFHYOLFK
   yVfDRHqZCXkPlpM2h5kId7RlWzyOdaNcXIxpT9CztOzmWyQZCdyQJPNfN
   FG5ZmCOrDCVH0r2gepDFC57W0Bitzf9MNySiJha+KUowpoCQ2Tuk/0F9L
   x1IUw+03jYK07X93mKkC00qNK2rqdg82yobaY537JRMycWlgal7zJdu2M
   VsmNYa7OSQ7C5x1R0FdopCBsATWGOHOn1J97528dn5ijwIt7EgQcKwX7h
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,142,1643644800"; 
   d="scan'208";a="194061889"
Received: from mail-mw2nam10lp2102.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.102])
  by ob1.hgst.iphmx.com with ESMTP; 28 Feb 2022 08:55:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqMxISOYHexPFI0Oe0YkRxFKUbBCsysoyhqmBwsClhilsxU28ux4jMdAbH7iOmG6le2JdzEr2ruf1IQaHPa8sYQ7GIm69vsR2tAsAB+0qFu8RCPQGJNDqase07A8+jmQ3zlqpxcuch4Tzn2DbnUYFcxa28Ea7Ez16LyJDP0Amix4c8M+3xGNPqYR7BlKpifQ7w+pCHLGwEc8nUAEH7HUd8qOeUezrXdzh5m9N/eBAPqYcWYpLbsZTFnMYyggj1PReBwXmAP/8S3Cw9pe6MSL8Gx0qOf4kDTRGO21JbnH+s2IpsCHOAKvDnDdvUmzC4cBeak/lrKq5aYSYJsuwGLBfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ica/RV1eQU4iY6cUFonaeT7unrVQfImOwinYi8+TomQ=;
 b=dQHhoENG+kUQ4qzXa8dK/T/s9EDmRdAGmT1rsEas/eTsgDcFGI0JUN33wxFN0CQnkm0+5lCA01K1KWMF5qB1CnVpEpy5JzFZMJi0fiN6wJGnOWxmKE/v7XWyImm3MmDsXalT0mKTu91VExE0wYm/WiiSiIlpi1D44b5nFKapytUcvDbrlQwtkSzhYo7KeZtjhVxgHSroEOI1+M6S2Nl5ppr7EZ40567Gu/OmRoYhJSEF5JcnT8KfdjKmD/ri9dpPvKL3nPsjABtSGuRr++ZRmkUR0TBeayR4IdVZtYj1uehiNsQkqzFTm41w2fVzn6yoQbzzjei/ee1sGnniYNWYtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ica/RV1eQU4iY6cUFonaeT7unrVQfImOwinYi8+TomQ=;
 b=n67HiVXpmDyfiOrmqkJjKk5hlPZACgH2mcYHhBOFbyDxzbJsfl4RCOFvpYJ0XvK/s/m53rSo/0t5SNVjGCBDI2ThEt62I1zaCpV2nw4fYtDk1xXrfQsTf8uSEPsXh1Gd1FDFhTpK34qUBkggsk1fcoLufyeOp4U2ScA5GP2ys0s=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM5PR04MB0747.namprd04.prod.outlook.com (2603:10b6:3:f6::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.25; Mon, 28 Feb 2022 00:55:47 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b13a:2b9b:b0a2:d17]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b13a:2b9b:b0a2:d17%8]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 00:55:47 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Sidong Yang <realwakka@gmail.com>
CC:     Filipe Manana <fdmanana@kernel.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v3] btrfs: qgroup: fix deadlock between rescan worker and
 remove qgroup
Thread-Topic: [PATCH v3] btrfs: qgroup: fix deadlock between rescan worker and
 remove qgroup
Thread-Index: AQHYKypz8a1k5XB5MkKuSBQpQ/sHtqyoJYCA
Date:   Mon, 28 Feb 2022 00:55:47 +0000
Message-ID: <20220228005545.j657d2jkrtsope45@shindev>
References: <20220226160330.19122-1-realwakka@gmail.com>
In-Reply-To: <20220226160330.19122-1-realwakka@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0afbf941-e235-45b2-1bcb-08d9fa550ee0
x-ms-traffictypediagnostic: DM5PR04MB0747:EE_
x-microsoft-antispam-prvs: <DM5PR04MB0747A7A61FFBE2785C34351DED019@DM5PR04MB0747.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0hYCG8rE4BbuxOywY3k8ADSxEVJ0sNTp7F68q/snTMY230gsNZ/Yet4G6MmCF9NPvxEpQaIDUIWcyYNZogvIrY0LHHY6n4Z0Opg2qXWmv2DrOK+iEvpevB3n7/TtNKLSuJmUk6O2C2wC6RLrDRFyCpvy56TPfyDga8kYPpK6f1i9fdFeWpR+De2hKzkjXFmVTzAmp4PzCRtMjaO8sI5EvUVg6Q/cnqGbL6BTbjFMdo6wChlu3AU3gsMAjDdYZJHeN6qw6J3atFHion32ad3tpB9YBtz/N26RF0Ey9/6o0rFxzcDzteBy4YFVGI1Y8zQ5wd8nDJHetnH3REVPShOoD2V0zQ/Qh9ZIZ0MC9+tOfXuQWpm2a/4tj6Z92nLt1bO60FGPwtKXXVL9qJv9a20JacdbUzjPia23TUAtJ9/09CHBPw+tUBHCcsQgJOOI7ykLW3INUE9QxXMttvVWwB+JxlOlMFulkGq6nt6sYAfpbsFqDM2qjFlIg1LUvHR17FHDAl3/OBA+q5Aj7WEUJ0QN2GegUiwc1vHW03yZKre0XDZteGHV3599375kcfNne+XBrsbCq89sQ+qo7qgQWE97pbNlMU3KMCIC6ODSOlAbSsKl4gJD5WU56cSC2Wj+UFqpIaGAskW6J0sImzJSCTTzpUhfOxfRpMZLh9kSNGzRYcA5j2G1pEbxxE6JpxiembgHB/w4aAJJqfeYlAB5RzWcvQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(33716001)(71200400001)(1076003)(6506007)(122000001)(83380400001)(82960400001)(26005)(186003)(2906002)(5660300002)(9686003)(6512007)(8936002)(86362001)(44832011)(38100700002)(54906003)(316002)(38070700005)(6486002)(6916009)(508600001)(64756008)(66946007)(66556008)(66476007)(66446008)(76116006)(91956017)(4326008)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2N6bLWQpfqsdP7+/VD6HRf5FzMDAX/RCSil32DRP/MHm4gd+/GiAflaQtlAu?=
 =?us-ascii?Q?hLtBrjaJQd4bbhYM7iBKVOpgSoONSD/IhGLDkIbdAAW+zD/Tp/sxIGG4EkH0?=
 =?us-ascii?Q?YSrhHt33Vn9dchtwU3Yqh2IURxEAmFB7SYNd0MfGOe9hKhosqqJsOf99/u3J?=
 =?us-ascii?Q?VQ3yG6kyY7dyy8NGBOSeDEwZFCV3txPkRHBzFp0syY6Vohc028u07vcJ7Znw?=
 =?us-ascii?Q?eM3FMIgZrMqWJIg0MGngL7pwL55b6gS3FQ/UkUfP7UNjdilAmBPQQKzctfMT?=
 =?us-ascii?Q?lIeT5l8sEVW0Ru0y7Nqmww6rtM+RJ9GVtkX53wQtR3wty3uD0O5neyHtxlXU?=
 =?us-ascii?Q?sf308waKn+3XGsnmhrNML928CxxKnSQcqCSkzZTO2dxp5V6iYgo7JQ8UjkMn?=
 =?us-ascii?Q?vHuScg+fCMJCLgd9i8leoHI/O0wDHKluWSrnbim9O/wtDRgfWQ7Ry/t4N4UT?=
 =?us-ascii?Q?lKL1tWATNaIb35Bt6WyrwwZOEh+wRhgZc9dwCtarUvrbi7FXoriVjINvNDwB?=
 =?us-ascii?Q?cqL/+1z60X1IM0nFUzyacBK3ygvael6v7fN7EEvIKQUVTrvXISCM7/7b8gI6?=
 =?us-ascii?Q?YaMrTkYxq8nyhlSerBk0IHZPMmNVzBxDqpK7odDjU0iR4ErWEKJQ/hiESj0m?=
 =?us-ascii?Q?BHB96FoYSgMFdcpE70wFousLdjY4TLifDEJtuunHdsKFg/c0GhJMGm7pNsq9?=
 =?us-ascii?Q?e0GlCc+BNqK3VswkgBXK8TbBUBsRCsvZYvd6yyfPRSSBjCfeAXOlJ3w1mxiX?=
 =?us-ascii?Q?xS/nqBk9n0bfStWY4cyWzPRja+hTHlKw1u0tEd7W/cHUBIjwQAFf7R2OJk/R?=
 =?us-ascii?Q?5E7u5Fu2OznV6oq63c6GTMSEul35NOxQ5GeYYgsn8yGmhLR8epGeupBb92nz?=
 =?us-ascii?Q?ksquFL0y3rDnt/fWeVlA45kMvy7A6T0glpDO6PR39YmzbPqmc/DVtQA4/HEG?=
 =?us-ascii?Q?BJ+H1gTHih1ImQUtKowZa8pWuypqqVZ1PondkX6Jr5qZwD0e5Z6IcLMO4B+8?=
 =?us-ascii?Q?GwOTiybL0O+XzP5unx441T6vyQygi0IUkOrzgYlzzLqSB9Bf8lBGZ4Kn97pU?=
 =?us-ascii?Q?PO0qVLC1J1IkwJjkf3N4ExxXwxjirElYPKSxbsJrDoOQKsz5V/d3uruLe7nn?=
 =?us-ascii?Q?tNjDL+4nODXM55Om2Cu1A1fTZOp1R/MBcEwgQmcIyjDvWL+e/FBOuS/quYgy?=
 =?us-ascii?Q?Ror/7AcBgFfkc8G98LHhrmjeLWMbBFgXO0YyP3IUA3+1ytsV8Ab2U/XSLJwJ?=
 =?us-ascii?Q?uXk4v6YfY3SN1p3V+tP/OlfJ14726KbN+ctcG2uQiBxHUTRjstPZHwualSww?=
 =?us-ascii?Q?bDN4kRFLzlewX+cTo9vanloqtgDMEj2jkZA+6g/PcYyp/ucd5HO8n0g5OI7o?=
 =?us-ascii?Q?dUjT05YCuNjVK2+tfyzyfAsCIHRsijj694wfhDN/HHuUsCrmSkNWJxPOmZdG?=
 =?us-ascii?Q?ipou8WATAqndeWU1nexsMWhPfuygyGCmbc0vXjG61ZjLalbTZfnSWvxxAiOp?=
 =?us-ascii?Q?7BK17XWe0Poi0jBctG4D7kEwZfhzXeD46n1UhiE9bHmzoh0TFSvjtUfn+k0b?=
 =?us-ascii?Q?dQgmZ/S2FNPcrUQ4eu40het0H6KBuOzKN72TrhJt1PDaGCb1MWSROCR1LoNl?=
 =?us-ascii?Q?dizgivw1404b1azkDKMO9xo6OkTH6NiuAWOlUW2rWjch6bqkFyzKkWnDkDGD?=
 =?us-ascii?Q?NF8tyd5bDqRJUx966aFBf+nkbIw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7D23D96CFFDCF94DA76CC7EA9F6CACBA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0afbf941-e235-45b2-1bcb-08d9fa550ee0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2022 00:55:47.7574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3kKmiO6GUnrU3aWlceJx2aB884f+LH/Y8Fcui3pKF7R7TppTmHcbZIFji+pUIFi3fMTJI/OezLDXqzL95NJ4ivU2/VzqPNRsZ843UON8wSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0747
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks for this v3 patch. I found some more points to improve in the commit
message.

On Feb 26, 2022 / 16:03, Sidong Yang wrote:
> The commit e804861bd4e6 ("btrfs: fix deadlock between quota disable and
> qgroup rescan worker") by Kawasaki resolves deadlock between quota
> disable and qgroup rescan worker. but also there is a deadlock case like

nit: s/but also/But also/

> it. It's about enabling or disabling quota and creating or removing
> qgroup. It can be reproduced in simple script below.
>=20
> for i in {1..100}
> do
>     btrfs quota enable /mnt &
>     btrfs qgroup create 1/0 /mnt &
>     btrfs qgroup destroy 1/0 /mnt &
>     btrfs quota disable /mnt &
> done
>=20
> Here's why the deadlock happens:
>=20
> 1) The quota rescan task is running.
>=20
> 2) Task A calls btrfs_quota_disable(), locks the qgroup_ioctl_lock
>    mutex, and then calls btrfs_qgroup_wait_for_completion(), to wait for
>    the quota rescan task to complete.
>=20
> 3) Task B calls btrfs_remove_qgroup() and it blocks when trying to lock
>    the qgroup_ioctl_lock mutex, because it's being held by task A. At tha=
t
>    To  resolve this issue, The thread disabling quota should unlock
>    int task B is holding a transaction handle for the current transaction=
.

I think you made a mistake in the two lines above, when you copied the text=
 that
Filipe suggested.

>=20
> 4) The quota rescan task calls btrfs_commit_transaction(). This results
>    in it waiting for all other tasks to release their handles on the
>    transaction, but task B is blocked on the qgroup_ioctl_lock mutex
>    while holding a handle on the transaction, and that mutex is being hel=
d
>    by task A, which is waiting for the quota rescan task to complete,
>    resulting in a deadlock between these 3 tasks.
>=20
> To resolve this issue, The thread disabling quota should unlock

nit: s/The thread/the thread/

> qgroup_ioctl_lock before waiting rescan completion. This patch moves
> btrfs_qgroup_wait_for_completion() after qgroup_ioctl_lock().

Do you mean 'unlock of qgroup_ioctl_lock' instead of 'qgroup_ioclt_lock()?

Also, according to Documentation/process/submitting-patches.rst, imperative
mood is recommended for commit messages. Then the sentence above can be:

  Move btrfs_qgroup_wait_for_completion() after unlock of qgroup_ioctl_lock=
.

--=20
Best Regards,
Shin'ichiro Kawasaki

>=20
> Fixes: e804861bd4e6 ("btrfs: fix deadlock between quota disable and
> qgroup rescan worker")
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> ---
> v3: fix comments, typos, changelog.
> v2: add comments, move locking before clear_bit.
> ---
>  fs/btrfs/qgroup.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 2c0dd6b8a80c..1866b1f0da01 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1213,6 +1213,14 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_i=
nfo)
>  	if (!fs_info->quota_root)
>  		goto out;
> =20
> +	/*
> +	 * Unlock the qgroup_ioctl_lock mutex before waiting for the rescan wor=
ker to
> +	 * complete. Otherwise we can deadlock because btrfs_remove_qgroup() ne=
eds
> +	 * to lock that mutex while holding a transaction handle and the rescan
> +	 * worker needs to commit a transaction.
> +	 */
> +	mutex_unlock(&fs_info->qgroup_ioctl_lock);
> +
>  	/*
>  	 * Request qgroup rescan worker to complete and wait for it. This wait
>  	 * must be done before transaction start for quota disable since it may
> @@ -1220,7 +1228,6 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_in=
fo)
>  	 */
>  	clear_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags);
>  	btrfs_qgroup_wait_for_completion(fs_info, false);
> -	mutex_unlock(&fs_info->qgroup_ioctl_lock);
> =20
>  	/*
>  	 * 1 For the root item
> --=20
> 2.25.1
> =
