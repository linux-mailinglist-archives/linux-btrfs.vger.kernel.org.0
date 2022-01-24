Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16246497800
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jan 2022 05:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241309AbiAXEP6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Jan 2022 23:15:58 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:24190 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235321AbiAXEP6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Jan 2022 23:15:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1642997757; x=1674533757;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Q3rInkqS2FzXyxTv9odaEYf8gh1QYY0TVO7w/ii/vV8=;
  b=iHuag9Tkl0liDO5kKO34ojddCGwLph1Yncdov4s6e9/jBxjPVWrFfIyC
   /wvtPHO3tyKY91lKF1+WOmjBR8n/FV2/RkKOrSyEdamuuUPIvpveFzU3L
   5fHt4TRnHB+JYmDajLPOwMPkVCLqjdpnygJqUhkvjuVZGLdjWlh1uorji
   aOR7HmZyOiIWxjmgnOdL740RaIZfOvjOeJEbAb7y1W53HEL7FOeHqiDWb
   Ql7QbKfQDqzm15eDN204UpiYQJ8WsZN2JXVyx1g05SeKSc1alkvaPIAIx
   PUbA8dXpvlzGs4Ttxevd2VzgH39qu9E2KZM44C/OOZVq/CL2RtynyqM4l
   A==;
X-IronPort-AV: E=Sophos;i="5.88,311,1635177600"; 
   d="scan'208";a="191189323"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jan 2022 12:15:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCkNLYhstLjcZs1NEoLmjtUT1z73pfqGK8FkNzHbhTAfr8rwgYpqgdIn/w60QP8jQV+pKlSFILQJrXi4ITz4msS31ImIUlsfqekmeuOJlBV9cLOCF/zSXeOPgPYSbqVVXeNc3XjyfKnwIYYPuJXGH3M8z/GNAjuw2lGFQkjqb0HN9t4g3zC+TMwYs2/hiHqOMMb/wj+kjzXoEzOiPa62xp25YxJIysaBYdY88NKtifZUe3TJMuLmnjIFY8RUdKG+H7AWiZX8j6/uPbrIUZRaXmRnwuN34kX0f06k/AP1FjEoDyGMy+gDRY7yjoSW9UYIHTUpjvP34+gJFRq6h0fYig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLlhM5DRwq/pruavaI19Uq/u8PlPLNGECFvfhUlgNpk=;
 b=I9wZN6sVq6WXJHWPz0IsMlr/6Aac6Wn5I4mqI9ildJ+XzNvXLC+LKYNBVAq5RnEoSiN3ob/Dk3vsZtVfdtvL6VFJIVCmpUoZ+92kSyhGMkKG5L0e3jA/c6gNznOtRu+7EsUdA36JU2AA4Y6r/QHDCeM+9Ur7ZNAh8e3fiKfbWJZD9hST0hR+/EQP7Za9UlbqqOj+gzZV34fnUtZurPuzl3u7ZtDKP+972nZzVtVAbQIQPlB0hHWntil4LBwTVjn3Edoe3x0zR1kBFaZhbCOtsVZGLfi7T/4bwnSaEpelOvWbL4JAsDnD8Lwg84K4QurfVrHTP20SoRYWkrnyPDtJ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLlhM5DRwq/pruavaI19Uq/u8PlPLNGECFvfhUlgNpk=;
 b=EtPeumyEt0RivedFwohQz6OYT0nzBavW1f+zxHRSrcYhWpCjrJmV581vHbZ00G5d92/dr3OnPeCtoQlSXXUZne2eJFMyIN6QWiNpHQ9G1BpBcX+N8tsMBqxrBUCyqbWhdV/F9h7Ce9i0MNE5SKN+5ErxDWaOyVSQo0AK5FhjwPs=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by BN7PR04MB5220.namprd04.prod.outlook.com (2603:10b6:408:39::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Mon, 24 Jan
 2022 04:15:55 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::1050:194:841b:1908]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::1050:194:841b:1908%5]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 04:15:55 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: mark relocation as writing
Thread-Topic: [PATCH] btrfs: zoned: mark relocation as writing
Thread-Index: AQHYC3FU+NfW4PsJ60CKCA93tJZ6w6xnSWMAgApR4gA=
Date:   Mon, 24 Jan 2022 04:15:54 +0000
Message-ID: <20220124041554.hb2vrz7xev7sabe6@naota-xeon>
References: <e935669f435882ba179812a955bcbb89d964db26.1642401849.git.naohiro.aota@wdc.com>
 <20220117144014.GI14046@twin.jikos.cz>
In-Reply-To: <20220117144014.GI14046@twin.jikos.cz>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 71196a79-213f-4c5e-7722-08d9def03749
x-ms-traffictypediagnostic: BN7PR04MB5220:EE_
x-microsoft-antispam-prvs: <BN7PR04MB52209B378B656D7228A339ED8C5E9@BN7PR04MB5220.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IcOMkWXBFwTCUxLZX8dUhnc/3F3/z/jn8YGekLQxr1FZ89PyingdCn+7IE7/5UPzHnuCrd6JjmSXx/3o1gLTxpxaNs3dS/oN90iCxWzumM014SfedIZkkbAYyF8R3qbIO986N7gwl7KQ3JCn77hEbVruqlvLg5KLBKljVQ5GdkOSYqwlKqOS5ce7BbdmCsZQ7b+uGWXW8/DQYRdFeV1ozftn9I4DBxdostQWjQaRpY+/e0adYuN5FEVX6oIhZt0bJESvV8zb9DqTWYozoIbXCte+Yb3mi4D8uyPO+3y6bdgxhQdCVVO6pqoPp+QiRYuPNmx+BtFEcFrAYrOewgZwWBeLNi8jBgBqqp8ICZeSQIF8z1J4teuV1mLDs8dHC3eFrD1eFMh8B52V6b2kJyswVIA83Do+v2yURBRrZhSB277HnVA/LbRbTV9ORzJs2LjS6NeMhG4XjFlulZ0G9sQ9XWsXluZYUjGZheSoeNuUSmmdEmQVK6LNAiMcvPbQA8JYft14RdaLnPajZ8OFZXszmCwL4uKbPBG+Id2ve7AjxQssjjhGRtGK7RtqNoWNNfqFBS0AcVKcJwIpng55/DQdUVU7aGszBBE9+q7DEvZlSvXoAcXpc4QSGFsfoLr9CIR2qdorN/lR4cnk5ZXz65IrX1rq8IVDT5z8J9oMV6/jCJXht3v3cPKwctV004dFYynPP/oVfVqxja7dGwp/ePUg8gHBV6+BRZafeR+SRji21qaWV3iyDufyv12xyw4iTYKTZBaSimDio+QfZQFc2Mr384E7taIUj4ulznq9Cw2XKwo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(76116006)(38100700002)(8936002)(6486002)(8676002)(5660300002)(66946007)(82960400001)(122000001)(86362001)(33716001)(316002)(508600001)(186003)(26005)(91956017)(1076003)(110136005)(64756008)(6506007)(66556008)(66476007)(66446008)(966005)(2906002)(38070700005)(6512007)(83380400001)(9686003)(71200400001)(6636002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CNX8eZ7Mv2speCxs7wbDw4EqO+U5MGeQ4PZvhrU6VE4exu4FZWr55U22Lhxy?=
 =?us-ascii?Q?tZhkQWDTXJ15TK9hIZABx7351pIk/VgBDw33RC5f80fIKwn2FJ1dTnxRwm8g?=
 =?us-ascii?Q?nWUMXTQBEycIohM6UW9kyF3AkNMBibQVMbCJZYl3JDPV71EDa0T6/nTFaZd5?=
 =?us-ascii?Q?bQiCyfPuU8Jjg7wzU1liOuboOdyJsnm8BH/MAzJs3WiGH9tgsEMcpm1cPxst?=
 =?us-ascii?Q?6FOpL8c90BP9uMczS77ymRWHF+/wKoPMU/HOnFzi+DlXcPT5ZdHPDhSO86Zi?=
 =?us-ascii?Q?rWGX24dMxi8/P7eI6xh+VPwOfv6q58CewdKIiKINuGUETVSaqONOnj9i6H5O?=
 =?us-ascii?Q?BHGZ4ZnMjvC/8o3HCqZB6uO+nkwYHLds3wnggFEPUKY6xg1GtFtF2/kfIEMd?=
 =?us-ascii?Q?rUGYT+fB2PuNSMDeeTgFG8JtpUxfXnvlPtlsjr6euRxbjE8E0sW2m5Ek8KQs?=
 =?us-ascii?Q?MByV31MJGUievV8WQx+iy86WGTmiTD6nAPffGlBI8bhTi8ZT4XDnk3CWFK/B?=
 =?us-ascii?Q?ED8Jz9bLGGhweYEHdcB4hWVQbGokH1rfDmELUxSS19TingpXgZB+sZyQUWT+?=
 =?us-ascii?Q?xOTmfg6ZuGaPYR4B7f4R+Bu0GJQIm4rt0euDx/ILksin28rODZs17hkosvey?=
 =?us-ascii?Q?mByZwU0ZMeJ5M8ZfDFVOIx/ieTS9SlAJuce4FFuTiAuLHQvhvrfmKNBikLkn?=
 =?us-ascii?Q?piyZBN98ay5qPZMcwun7kM+2Q9NCzOaUSUQP8w5EXMG3FJi7rPtWpCuWLoPP?=
 =?us-ascii?Q?skkQPMAM+u3P5n/GM+LrUDiUOlpsKR3Skf2QUB1WE7Bw5E3EDSrLRlI/CMnr?=
 =?us-ascii?Q?HiWJHV7U9y0qXOvs4lRFtqVY4sUuwDbp7qpTveLz/zwJJMYd3tozqKZNV6it?=
 =?us-ascii?Q?Io13jquE23WUTDkhfGdtO3PSNrm7WGSFJZP757mhD1lYAhoj5dB4TxCkR8HV?=
 =?us-ascii?Q?GB6ivDfiqXQlWhpU/eAzTYQ6VLwx0k+ZUPIHN7KX6yP6bf1BmIGP6I5dDzfm?=
 =?us-ascii?Q?+hRC6TqmgmFppTlqo+C11DBTrUx2zoFVygpL+ZjD0kX3IHzWtGiP3rNmRR3w?=
 =?us-ascii?Q?+h3PPOIiywb6BrExQI1b4LjNv9jlfbRDbKw3u68yQKGF/Zy6q1lOmb1hV41Q?=
 =?us-ascii?Q?OG9lID4HHgO4FoYWDf2xKHckftUH5aeiL9ZuEDgm0oB0Pxzp4BpPIEHp+9r6?=
 =?us-ascii?Q?8WZuAzvWByTkpRqe5OsOFYXU47lYKTcMSZHs96rcRqcUcTWSUHBdr+Lx+79M?=
 =?us-ascii?Q?csD+tBMz1Cn4Rg9ZcanT9766TJMcV3Z6Ma17wDTciKpcoGZTQgGkTX4axyuZ?=
 =?us-ascii?Q?2S6VVnC/PISUSwaydgkV5FAIMM6795XVastFFMEQjeEEMWSWxblE5kN/kWSV?=
 =?us-ascii?Q?Mf435RvEMSE8c5aihnFQjD6S6xP4JtwZBl94qw2S9bt6mZ1uhpiIBIIL2pOv?=
 =?us-ascii?Q?HNW+9hVqFq7UItrYZmwcSrorPl/bZAbElNYuMyfbp8IDSQPr9bcRUxL87COH?=
 =?us-ascii?Q?p1OWin3LlvfP8IUBv0X69Rh+Z+/7QeJ8EkwGcEiyaz7RjOcgmVTdfm1/3VwT?=
 =?us-ascii?Q?BP7yuxsqrcNUpsuvl4vaB2+7rmW41pJCV3KlEtjs9AgbOOs1rLADtbR1N+Th?=
 =?us-ascii?Q?dRz8F9q+QcgBuxgCncdRJOU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5C89E5DD78BC2A4FB8F4E3C10F47A705@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71196a79-213f-4c5e-7722-08d9def03749
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2022 04:15:54.9464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 73+IrvbfSIBtv4B/L3DlK1BdBHRTzesI3t479+skVwpGY/fVTeWQFmHzFYZLq3Wo8Rs6B2DeEnJTJ3VpcTxzIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB5220
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 17, 2022 at 03:40:14PM +0100, David Sterba wrote:
> On Mon, Jan 17, 2022 at 03:56:52PM +0900, Naohiro Aota wrote:
> > There is a hung_task issue with running generic/068 on an SMR
> > device. The hang occurs while a process is trying to thaw the
> > filesystem. The process is trying to take sb->s_umount to thaw the
> > FS. The lock is held by fsstress, which calls btrfs_sync_fs() and is
> > waiting for an ordered extent to finish. However, as the FS is frozen,
> > the ordered extent never finish.
> >=20
> > Having an ordered extent while the FS is frozen is the root cause of
> > the hang. The ordered extent is initiated from btrfs_relocate_chunk()
> > which is called from btrfs_reclaim_bgs_work().
> >=20
> > This commit add sb_*_write() around btrfs_relocate_chunk() call
> > site. For the usual "btrfs balance" command, we already call it with
> > mnt_want_file() in btrfs_ioctl_balance().
> >=20
> > Additionally, add an ASSERT in btrfs_relocate_chunk() to check it is
> > properly called.
> >=20
> > Fixes: 18bb8bbf13c1 ("btrfs: zoned: automatically reclaim zones")
> > Cc: stable@vger.kernel.org # 5.13+
> > Link: https://github.com/naota/linux/issues/56
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > ---
> >  fs/btrfs/block-group.c | 3 +++
> >  fs/btrfs/volumes.c     | 5 +++++
> >  2 files changed, 8 insertions(+)
> >=20
> > diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> > index 68feabc83a27..913fee0daafd 100644
> > --- a/fs/btrfs/block-group.c
> > +++ b/fs/btrfs/block-group.c
> > @@ -1516,11 +1516,13 @@ void btrfs_reclaim_bgs_work(struct work_struct =
*work)
> >  	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE))
> >  		return;
> > =20
> > +	sb_start_write(fs_info->sb);
> >  	/*
> >  	 * Long running balances can keep us blocked here for eternity, so
> >  	 * simply skip reclaim if we're unable to get the mutex.
> >  	 */
> >  	if (!mutex_trylock(&fs_info->reclaim_bgs_lock)) {
> > +		sb_end_write(fs_info->sb);
>=20
> Should this be some sort of try lock as well? IIRC sb_start_write can
> block, so this would block the whole thread.

Contrary to the word "write," sb_start_write() takes a read lock. And,
the write side is only taken by the FS freeze path. So, I don't think
it's necessary to make it try locking.

I just noticed sb_start_write() should come before
btrfs_exclop_balance(), so that it has the same order as in
btrfs_ioctl_balance(). Will fix that.

> >  		btrfs_exclop_finish(fs_info);
> >  		return;
> >  	}
> > @@ -1595,6 +1597,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *w=
ork)
> >  	}
> >  	spin_unlock(&fs_info->unused_bgs_lock);
> >  	mutex_unlock(&fs_info->reclaim_bgs_lock);
> > +	sb_end_write(fs_info->sb);
> >  	btrfs_exclop_finish(fs_info);
> >  }
> > =20
> > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > index b07d382d53a8..3975511f3201 100644
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -3251,6 +3251,9 @@ int btrfs_relocate_chunk(struct btrfs_fs_info *fs=
_info, u64 chunk_offset)
> >  	u64 length;
> >  	int ret;
> > =20
> > +	/* Assert we called sb_start_write(), not to race with FS freezing */
> > +	lockdep_assert_held_read(fs_info->sb->s_writers.rw_sem + SB_FREEZE_WR=
ITE - 1);
>=20
> This seems to be peeking into the internals and I can't say if this is
> a good idea or not, some wrappe would make more sense.

I agree. I'll make a common wrapper in the next version.

> > +
> >  	/*
> >  	 * Prevent races with automatic removal of unused block groups.
> >  	 * After we relocate and before we remove the chunk with offset
> > @@ -8306,6 +8309,7 @@ static int relocating_repair_kthread(void *data)
> >  		return -EBUSY;
> >  	}
> > =20
> > +	sb_start_write(fs_info->sb);
>=20
> I was wondering if the trylock semantics should be here as well but
> proably not, because the next lock is a big one too.

I think this can be intact as shown as above.

> >  	mutex_lock(&fs_info->reclaim_bgs_lock);
> > =20
> >  	/* Ensure block group still exists */
> > @@ -8329,6 +8333,7 @@ static int relocating_repair_kthread(void *data)
> >  	if (cache)
> >  		btrfs_put_block_group(cache);
> >  	mutex_unlock(&fs_info->reclaim_bgs_lock);
> > +	sb_end_write(fs_info->sb);
> >  	btrfs_exclop_finish(fs_info);
> > =20
> >  	return ret;
> > --=20
> > 2.34.1=
