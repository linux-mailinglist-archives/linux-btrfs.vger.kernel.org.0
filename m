Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C8F504D0B
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Apr 2022 09:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbiDRHPo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Apr 2022 03:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiDRHPm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Apr 2022 03:15:42 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B354F167E8
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Apr 2022 00:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650265984; x=1681801984;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ouEMywvSf1CrY6Yl03z45nqFlqyTlIEQkGVMMWJcnGo=;
  b=mJnd7S29oFj29F6vWFh5DDObb2vEDSMtHTlvbP0SP6SQ6P3V25QBrqrH
   jlDACrXgoYaBu5nU741hGNG2OJU3mVrsGI8CBCNwtQr/vZmHBGUKIsTdP
   nc7T7fplUilpOeXXJvWVZ6JRpEYJ+sQ15I5esQc581f8of3/WRrCajsAD
   1sntAskzwXXEvP0me+7qQ3ovd9rvdx1/dBz+K2tGMsYOapZvk5ag0IRlL
   Q1F5fjQ44UuQPdlDcHjCOA2lAO0V/V4A2tOQRsxXUNowp/FOmTvjWQaZ8
   itdIapNygdCcwGg05q07rLYdQHWVT7rzEspAM+VY8GHPWuWiYBVejKek4
   A==;
X-IronPort-AV: E=Sophos;i="5.90,269,1643644800"; 
   d="scan'208";a="302338057"
Received: from mail-dm3nam07lp2041.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.41])
  by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2022 15:13:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xs9nw417pp7SfftS3qMdmO7Kbxd11IZdrwWHIav3g1Clizgj2ZZXpECW/Iz3vGj/4cDKYlCQfelO0gdYPjVWpOCVhZ5w89o92ziQFsstyHSinpYcaEQZ/Gg2DFJ7Ulc/GS2a6umjqHFDuhzrJFR4oc86+YedY5i5mvJgStzmn8HZ7fNl+w/4DhYEsSy4fNLzz2sGX3W0DOg/YsRCqn31KAG2jTx6crLSvPl8LvOfX1DE3Yr4KOrRYVf3zR0kZVBZ4C/b/+yxEvQgjXBq8kK3ISYYdhcKYerogcyweC2uPGy2H2mXBiMYY7yYsGJ1IxYTwFQTLXJjtj7cIVX+Q8Z3kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSE4uGE5gAwn6SN8bX3xX8XWZb6NI9VOWVQdThFRwAA=;
 b=aGfxtf073Dt0YgTNRRZesqcgnOyHa7VpdO+xGUPPV1Xo87gWPckvK4jNuduzsi9dEe2rjMhu8eh6Aa4q18HZpffZxl6uMk9P6s8JphuEc4xYSLoJaLeryCkY6Zl8zxXomw7vtXOEj1fJiqZzBAqpNyPIc9X9T3fPn5HiXe2l/rBZK2odfzo+A10SOxdbztb648u+O9jvxtirMemD0MGxTKT8jfw+ppUctvz5yebY03kzk3eaDRuh9uzG1PulWOwN6pP6vDXQQT2PgXeJUyYrOUIjYwWmYP0y+kpmgyAiX1mgXj0rOjwpsQA6moKyo+ztJvWxm2sMA8RZOXgqU4zrPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSE4uGE5gAwn6SN8bX3xX8XWZb6NI9VOWVQdThFRwAA=;
 b=K80DGljXxWDtZXy6KJWlMH/CNS4Qt/UEJ5xom9gh/umND1lE2sF+LsVt0q9vBPaE1sOl5G2kRaS7lGyYCtTgmIHkpEYUfpUdDm7Im5tqgpcSrtzQ86hYKMsj2nmALM7cKyBDl7jFTE8YJttqQy/kk4lKPTFDQ/czTYM7Ss3xeRw=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by DM6PR04MB4537.namprd04.prod.outlook.com (2603:10b6:5:2b::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 07:13:01 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::8db2:701a:a93d:9b93]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::8db2:701a:a93d:9b93%7]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 07:13:01 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: use dedicated lock for data relocation
Thread-Topic: [PATCH] btrfs: zoned: use dedicated lock for data relocation
Thread-Index: AQHYUug7sj33sENaQEOVw4Ke1AMARqz1Pw6AgAACmgA=
Date:   Mon, 18 Apr 2022 07:13:00 +0000
Message-ID: <20220418071300.dfoofohkoop77l4f@naota-xeon>
References: <1ad4d3f6ed32ab2d3352adb6da7ba4ff049e79a0.1650257630.git.naohiro.aota@wdc.com>
 <10c8e04b-57fd-a656-5242-17a3c57345f2@opensource.wdc.com>
In-Reply-To: <10c8e04b-57fd-a656-5242-17a3c57345f2@opensource.wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cae3fa3d-0e79-41f7-915a-08da210adf99
x-ms-traffictypediagnostic: DM6PR04MB4537:EE_
x-microsoft-antispam-prvs: <DM6PR04MB45370C9C4180A6B16D570E018CF39@DM6PR04MB4537.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6IaXhlrSKUyytQnUsROFQOddgbXd0bcVauHhMtqeOlAYGl7fs2erNXT90SJ2e7Zh948IDxsHTtpwnAzRC6udHHZxJ+62mLgf9DPRCwjCh8Sv/PRrmrYBzlPveOQeyXRRlUnD1FgNX8ehuktjy3ZD1Bel6IIWvmsqRkU2KGXu46Hel8UzW8C7TEhbmgIll6t+Ucd7mFAFVTnFo0D9VMNm6mlG6ppWcuwx/NNXlxnuRJib5J7OMI9QRV4kYQogdTz2odFeEw41Zydwew/EsXrMZzqUvoLI62vGvEnwCqrhOg+newiNqzXrqruTakF48qaRQuBRFQYZ2kGY1ZlrbBRDE3hS2wv3hrdHnVAyqXfuXX0VeV6g5C/+wCfImu4DVNwum7Kc6b5ZsOnTD+jxXI3CEgkaiUIuy8gNABEdgtF18sMrr7EDTh2NEMDQbi0lPLfOH7rfSl7OaFjEDxtSuqYNolf3CUeGSrTqIIfJUIwH7quL+MuSAqY9bCJM7RxNcMxa71hYotddinH7vtkztpuKyiV0Cu6WFXCZi/Ae82L771jvMRapa8XpX80sKXq2isc19S2p/bAcO6mgqh+eIdkqmF9o77yWjgf6GUUD6TRdJoxFNwrEM55KKzUAUOyrjqXthz7grDpRARTroZrwahkC3GJvuMbcz7VtcEKgR8mkmub7SnRgxucgZ+tKXcVnl5OeRDNMLfVl370FpBB6qFVIEw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(53546011)(6506007)(8676002)(6862004)(66476007)(76116006)(91956017)(66556008)(66946007)(508600001)(6486002)(64756008)(66446008)(4326008)(26005)(86362001)(2906002)(9686003)(6512007)(8936002)(1076003)(186003)(5660300002)(83380400001)(316002)(38100700002)(54906003)(122000001)(82960400001)(71200400001)(33716001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xoS3acFc7bGIzlEFeX9+ytNq1Ab0tsyErh4zLQH4NPUlaDZhr/HTIdjqcOcg?=
 =?us-ascii?Q?zhtJMU6XdiqsyibmRf3bZHiwEuM9yEnozsiLZGc7FATUnDT+/yAUBYUMt43+?=
 =?us-ascii?Q?zS1B67XdlopFkHLGMaoDxAqVKEFOo4ic47mF1lb0KHT3F21K6RwHWOJpMYlx?=
 =?us-ascii?Q?jIjegiH5XW51XNPZNz7sy259fwR5c8g9Gj8Too7s/CvvsKmh5uvAnpPQwj+r?=
 =?us-ascii?Q?wsjVcuRdQg9oWMdcT8oviLc7L1vN6iyagL3teW/kzHOyJKRUPIR0FsdsIAbP?=
 =?us-ascii?Q?/vEJ6Iq1atPshSDPrp6r87ldqxCFWjaAv3m8KCJmMwWtlDiB8LFeSObMJCfR?=
 =?us-ascii?Q?ETGRqpmFJlp1sAylfG//CVAt/F7YKV97/BoL/1/VsimVemXmTgmx+6d35LbB?=
 =?us-ascii?Q?wK2cGltXcfZAkVfmOLyFuIoyK7Qa3KcVwJdA1guMY0OrgbdquLlpvLvErX27?=
 =?us-ascii?Q?iteXj3+W2CeR6nrBocNxQv1d5+Pr2ykYE0qygk+0+uyOnn1+KXRfomwv52Py?=
 =?us-ascii?Q?MV9m2yA/dePnHH0JOYh3D/7KPSEE7KcJ8SClVjVp5ML+1av6Iz3XXUuaHM9k?=
 =?us-ascii?Q?xbrzrZ9UGiBnxNo6Fz5gSfOpMU3sSWSLLVa52PNqy7KBOdv+VzUWzUsxOdXZ?=
 =?us-ascii?Q?b76ejgP2FBf+cy1kE9auDR1kCeZ7u9OTjYtc3N9mJ4O0q6J3wAmiV4Muirrt?=
 =?us-ascii?Q?P3LDwdfcpjw1F7ak8IT6K02/p6hjXejNlbEjRlu99i35+NM3zcHCXVL+8VKw?=
 =?us-ascii?Q?Ey03YO0Kylfppx6exzUdDSUx9S+ANynXAZOiM5KmFI09g/3jKv3FDWKudtSN?=
 =?us-ascii?Q?fq3wiTzVJojrbYWGE6eRiBM5ZE5vsJ0zow/BuAfOFXsb/A5AWnYqstKReNvJ?=
 =?us-ascii?Q?szsJsIn0Elr0cvBgunHrVJY391aMGpyOKk91j5TzKyXxKQsuW9Io5dv4p0td?=
 =?us-ascii?Q?DAWAqzUjVvlFzCIUFy1WMoboBVkguLis2NDIBZmHVjqmlGN42FnoHrmTM7uc?=
 =?us-ascii?Q?Y/iGY7+8RS5NfTm5tfijej6qGHnpymNDABOOIev4APlyYVEd/GRdQzvieU7x?=
 =?us-ascii?Q?PXNM9++Id2QGI1AO68+NbNBPIOvB98uM9BH9TRQ9/Q+b2s4Bm1fac4bQUrMV?=
 =?us-ascii?Q?3JMFYBoqYwnVcEkfR/prAIzJAiBMcuQCeWivS1eAiBpVzvVcKisD5Lgmfvm1?=
 =?us-ascii?Q?PYRJzpJQ7ZmP43uV1oQ3gvhGGS+9qp9nt0jw+6lkj2jc9z/6hJggAZpOd8km?=
 =?us-ascii?Q?fg51BaLETrIcd/82toaezTEEM9mSjqHJjSdU7+EgOsJzJbC7FD7g97xwXCHc?=
 =?us-ascii?Q?yd46Fhf3Ptm+y8Ty6w6UUh1HThiOHABTYBa5gZdrFnGnxWn/BjOvs8LM3rnB?=
 =?us-ascii?Q?+2ncmYcyoG37hyZ1lXmZQTpn9Fj0+Kl5c6nKyep/tnmcBulHPFoUdoQFbOaw?=
 =?us-ascii?Q?zk9C8fiekhI5QaOiIQI4b4OSA5RA0ZJUHpkDgyZScA6WxKM5ELuBANRdX9fv?=
 =?us-ascii?Q?hwXrZs4cIKCbH1Vg2/my63/yL/kFy1X/Lxsx5YwnHIQqaBN6mThD0F2uxKrf?=
 =?us-ascii?Q?4r61wEbLC9d/08SD9kEyFFv4LOFAWrfs6ivZpRwM/S0g6tCxr0aV+maCj9Cc?=
 =?us-ascii?Q?BQb0x6GZJkFt3BCQslNyopv/U05Phg0Am6P0WPWWnv7CF9NRA6+2EUkCX9jr?=
 =?us-ascii?Q?SdsXaeSCU67huKxXgHzpqlqsE0qgJIiWgDoboSO3u8FY016T8gA83Q7L4wlU?=
 =?us-ascii?Q?rjy8oNkc7xVDJy0/1CkJ56DhxhwviMc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FACEFE42EE9B1340B5F031227359B303@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cae3fa3d-0e79-41f7-915a-08da210adf99
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2022 07:13:00.9869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lw+edowOPOA53/c2aaUYEZnjtkpDSp63byY+CdjfNyrJkqlbQ11xVaJ+ToHLlAT/ImgPZjDs0+xb4QMOzuXDqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4537
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 18, 2022 at 04:03:41PM +0900, Damien Le Moal wrote:
> On 4/18/22 14:50, Naohiro Aota wrote:
> > Currently, we use btrfs_inode_{lock,unlock}() to grant an exclusive
> > writeback of the relocation data inode in
> > btrfs_zoned_data_reloc_{lock,unlock}(). However, that can cause a deadl=
ock
> > in the following path.
> >=20
> > Thread A takes btrfs_inode_lock() and waits for metadata reservation by
> > e.g, waiting for writeback:
> >=20
> > prealloc_file_extent_cluster()
> >   - btrfs_inode_lock(&inode->vfs_inode, 0);
> >   - btrfs_prealloc_file_range()
> >   ...
> >     - btrfs_replace_file_extents()
> >       - btrfs_start_transaction
> >       ...
> >         - btrfs_reserve_metadata_bytes()
> >=20
> > Thread B (e.g, doing a writeback work) needs to wait for the inode lock=
 to
> > continue writeback process:
> >=20
> > do_writepages
> >   - btrfs_writepages
> >     - extent_writpages
> >       - btrfs_zoned_data_reloc_lock(BTRFS_I(inode));
> >         - btrfs_inode_lock()
> >=20
> > The deadlock is caused by relying on the vfs_inode's lock. By using it,=
 we
> > introduced unnecessary exclusion of writeback and
> > btrfs_prealloc_file_range(). Also, the lock at this point is useless as=
 we
> > don't have any dirty pages in the inode yet.
> >=20
> > Introduce fs_info->zoned_data_reloc_io_lock and use it for the exclusiv=
e
> > writeback.
> >=20
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>=20
> Fixes tag ?
> Cc stable ?

Oops, I added them in the commit, but forgot to renew the patch.
I'll resend the updated one.

> Since this is fixing a deadlock, these tags are necessary, no ?
>=20
> > ---
> >  fs/btrfs/ctree.h   | 1 +
> >  fs/btrfs/disk-io.c | 1 +
> >  fs/btrfs/zoned.h   | 4 ++--
> >  3 files changed, 4 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > index 55dee124ee44..580a392d7c37 100644
> > --- a/fs/btrfs/ctree.h
> > +++ b/fs/btrfs/ctree.h
> > @@ -1056,6 +1056,7 @@ struct btrfs_fs_info {
> >  	 */
> >  	spinlock_t relocation_bg_lock;
> >  	u64 data_reloc_bg;
> > +	struct mutex zoned_data_reloc_io_lock;
> > =20
> >  	u64 nr_global_roots;
> > =20
> > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > index 2689e8589627..2a0284c2430e 100644
> > --- a/fs/btrfs/disk-io.c
> > +++ b/fs/btrfs/disk-io.c
> > @@ -3179,6 +3179,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_=
info)
> >  	mutex_init(&fs_info->reloc_mutex);
> >  	mutex_init(&fs_info->delalloc_root_mutex);
> >  	mutex_init(&fs_info->zoned_meta_io_lock);
> > +	mutex_init(&fs_info->zoned_data_reloc_io_lock);
> >  	seqlock_init(&fs_info->profiles_lock);
> > =20
> >  	INIT_LIST_HEAD(&fs_info->dirty_cowonly_roots);
> > diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
> > index fc2034e66ce3..de923fc8449d 100644
> > --- a/fs/btrfs/zoned.h
> > +++ b/fs/btrfs/zoned.h
> > @@ -361,7 +361,7 @@ static inline void btrfs_zoned_data_reloc_lock(stru=
ct btrfs_inode *inode)
> >  	struct btrfs_root *root =3D inode->root;
> > =20
> >  	if (btrfs_is_data_reloc_root(root) && btrfs_is_zoned(root->fs_info))
> > -		btrfs_inode_lock(&inode->vfs_inode, 0);
> > +		mutex_lock(&root->fs_info->zoned_data_reloc_io_lock);
> >  }
> > =20
> >  static inline void btrfs_zoned_data_reloc_unlock(struct btrfs_inode *i=
node)
> > @@ -369,7 +369,7 @@ static inline void btrfs_zoned_data_reloc_unlock(st=
ruct btrfs_inode *inode)
> >  	struct btrfs_root *root =3D inode->root;
> > =20
> >  	if (btrfs_is_data_reloc_root(root) && btrfs_is_zoned(root->fs_info))
> > -		btrfs_inode_unlock(&inode->vfs_inode, 0);
> > +		mutex_unlock(&root->fs_info->zoned_data_reloc_io_lock);
> >  }
> > =20
> >  #endif
>=20
>=20
> --=20
> Damien Le Moal
> Western Digital Research=
