Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AAF64E76C
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Dec 2022 07:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiLPGxm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Dec 2022 01:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLPGxl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Dec 2022 01:53:41 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBDB55AB9
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Dec 2022 22:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1671173620; x=1702709620;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eZBgzitKBWY2W5pw2bUtyrvjj+gS+doY6K3Zjixb8o4=;
  b=MOwicE3P9G/DZYw+ZcVM/nJzNaKfRwkH40c8EiljcqKfcCo9plfmMqN8
   s9pH4AR58kD1DlBgpN/A4u+ANsCPxu1iuT3uPkNhilBQlPhwFJ/RcHcda
   GaK/sWf80HpOnhHTiEhZT2gQaBRtcjUlTPRTTH+x+v5CKWfRkJ4oKxuiU
   5VngQCni+hsTFBAPNhIBh9V9B5m6e9727gI7OIHiZcubjw6Of18MMlrXI
   YeycYvI41OjUQQDZM8JpxClPQpGkUN1xMaDkt9DbnB3g8HeDy8g+QwHWY
   Yyb7w35BSM9pIYmTgXfxwL0kU6HfTtsJU13f27R6wHNlAoo9o2YwBZJZg
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,249,1665417600"; 
   d="scan'208";a="323170129"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 16 Dec 2022 14:53:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PsEjf7nKgxnwlbFe8wwoWLYLznXAOpfkraetaAdjWD27XTjdu91usjQFATwMKN70+fJR/vIz/51TXXkF1/ZocF2rvNNqwRf79FUfUmrfvaLjyavgtARyWx14YLX3N0K/wz2qOIL/T5XSpEEjcGxu6PQN8DyAapPGqyHb9ky13744BWxfgMH4E/4t85pe04h456TtEqjoNUM/X9nLCO/WwC7lq/JxoyUpNv+2xorawjxCkqFNoMR7DrP+hY0LZghW07OhJahGPvejSZMoZL+0p+V6voa3xnInAkGpprbUWkuYTKQQ93TT5uwQSklwVTBQOvV2kJHbhR/nt36PndpInw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5msEAUQjKBTOYU7b4oVBhaYowVhO/CBpk0sgbtFubM=;
 b=YWF4pHtej0SbZi1IabOFnAT6MJ0rBQqCym6cDSZsD1Dlk1QvBG94O/lPVC5kcLj5MOCEw42AspEQUqeJsFl1OwFsLb04fpfKgOdde//DXpunu/aQyvSbcLh+3XlW1bIwQG8Lyl9eb1LmUuEBzNBlaxNreCVM3Z8jJdEzObzcXAHhgjYxVj8+B22DCiU7W1+aKZU3n+OAzLqvv1PTkJ1duOc8qlREBOJE9wTbtjxye99veYB69lbQLgAQbgDWHRg/85s1xIVek+A7j7XY82W9JE9ce22wNCliVrUb0VC9QLbITOGljOViLC09qSOG3j4WVx95knPydDOIbsc/SDjcLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5msEAUQjKBTOYU7b4oVBhaYowVhO/CBpk0sgbtFubM=;
 b=JIpqLF5YIBxAABaSM5vCVN/VAHrwWmkZQKGUAOxb3QyoXX+z7gRRK9Dr+8iJM4/g3UMQbXLgMdHLVsvwVEB+eoK8IAQBsWA2ynqZTqJq9Kxd0UcHAAygnTfOWXWAJXmISVTQUepQ0ahz3J281ls+CGBdXKkVFkZhknLukxvFs2E=
Received: from DM8PR04MB7765.namprd04.prod.outlook.com (2603:10b6:8:36::14) by
 BN6PR04MB0659.namprd04.prod.outlook.com (2603:10b6:404:da::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.12; Fri, 16 Dec 2022 06:53:37 +0000
Received: from DM8PR04MB7765.namprd04.prod.outlook.com
 ([fe80::f360:c1c2:6aab:3265]) by DM8PR04MB7765.namprd04.prod.outlook.com
 ([fe80::f360:c1c2:6aab:3265%7]) with mapi id 15.20.5924.011; Fri, 16 Dec 2022
 06:53:37 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Filipe Manana <fdmanana@kernel.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/9] btrfs: more optimizations for lseek and fiemap
Thread-Topic: [PATCH 0/9] btrfs: more optimizations for lseek and fiemap
Thread-Index: AQHY9cPqVfDtAIM+a0yo62/Je674uK5ruiKAgAAYl4CABHf8AA==
Date:   Fri, 16 Dec 2022 06:53:36 +0000
Message-ID: <20221216065336.abwmu6zk7yvkwfgw@naota-xeon>
References: <cover.1668166764.git.fdmanana@suse.com>
 <20221213091107.aezonr65mivb2ijq@naota-xeon>
 <CAL3q7H7pdt0jbmGMV7mr0V6kT2_-VYF=6B-TiGke5Nkos_TfzA@mail.gmail.com>
In-Reply-To: <CAL3q7H7pdt0jbmGMV7mr0V6kT2_-VYF=6B-TiGke5Nkos_TfzA@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB7765:EE_|BN6PR04MB0659:EE_
x-ms-office365-filtering-correlation-id: 0367872f-7320-4dc5-4c56-08dadf3241b9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hWtOZ+Gj7bI2Nt48hmx0/U78CS0vkZZ6KCY7J9Ra4H/JwN4AikCbmF0o09MJQFvgTHUWAw4UQ7x81k7y5AUKZBnEAt5bc7I/MvZhb4JMsdKhz5HF08FYdIZ4oDwKKh2v/o2gwWYPCDLJR2TxBLo945D/a6oZUB6l5e7cwdrEtBJZtzYsdcGiHsZArgImYHmgpd4hK6vFK9Di8cXsr6//UYARDn+Sj7uXrtA7Z7rqTElK2D6jTOwjMRe0T36N6WTzAWPjyDrv8/oN8yBu+lbMRK8omIAARAswYTyJMVXLfGsIk5EUg2ybrD5JWAkchb07SafdvFWYQa5GVDBu1TU8PYHtkyogdkYJNJiFMePw7p5fbFW+utxdwa3kN7OtBsqajsotz/4lklokBY0j+ti5vryfc5n+/ztbmbs1j9PEwXhAi5vQrRBrmVbhAUG2SL/mixvViQ+ckHEA3aF+Qk1m2UONAo+AK5zZc1X8yrKs+1sbHtWjJaouVQe1JkFNB56arRdkTA0INzACWe5uf5QJek+sRIBORfvyE8o+HDYRFBkCP3fWvG//l8zaHPJAk/gjhXAppU1jlufMPCErILg/CynSIa2UAgUPwk4+FKXMh8fKae28qTx2LnmPPcqV3+azl/HYdCCBFCswf9YGoE5OLB+x84zTpGDFdEA6f7LJqqN2DpWQCjnCn9IFfbmOgndtgWhHKNsKiWDINBjVBCH4Eo/HIqdvZRwKTtTf74gYVzqwm7ybsyZzcC+/Ch9jNqpbog7SlJmcQLZPe+TMX5phbg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB7765.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199015)(33716001)(66946007)(64756008)(91956017)(186003)(6512007)(9686003)(76116006)(26005)(478600001)(966005)(71200400001)(6486002)(1076003)(66476007)(41300700001)(66446008)(86362001)(66556008)(5660300002)(8936002)(83380400001)(2906002)(4326008)(122000001)(53546011)(316002)(6506007)(6916009)(8676002)(38100700002)(82960400001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?S5hhHNexH1NU/q5HKD+fekvJIJ1fawem4Unx+/sPds5AYZ5tqSSrNOkPwX5P?=
 =?us-ascii?Q?Lh0YSh3ohSgEsuFc+1HfTN81jYHXZT87rzWCcEPr0gIDf7t610oooXUz4Dyh?=
 =?us-ascii?Q?d7+EAoQK/DVeiavlpfGQfJEKZ1OaBX6qXO9EiyDlfL1BFR6NJhQGAHxgqFht?=
 =?us-ascii?Q?A4kNEXDIkdiSST+xN6mrAihcWBCYnBxiJSXFvXtUpXSnqNE0bqGUT9nQrtjO?=
 =?us-ascii?Q?2OESIpSLjoyfs6fL1CyULBDDqW/UMYr4FW9esHnTvCq8nONant3lPrZvH+0s?=
 =?us-ascii?Q?y53B7NnsCGSLscT+Qo5fDd/4dCT9T4AeUC8D71Ufq6Ija9kPeanDTCn2tAoD?=
 =?us-ascii?Q?ZZxEcCycXHzXhP71gUoVD8Tc+B5Rkhfbx92j6Q5rd3OkjU7WN5SrwtRVmMwX?=
 =?us-ascii?Q?DajwLIsenlYT0cVOFccYJfyBafxkiOtQ4W60SeFSGwLeE53P0q1bPeu2G0Oj?=
 =?us-ascii?Q?mtRuD2CwzafB+g8Q4V38b1o8DFqkZPSk8m+27YfkqLfMgAWNnSeGb+fvhre2?=
 =?us-ascii?Q?dyDKrcBX4VqMC2fq55+W2sGsfnUekHHeBCec7QrWNPuHzNBIx9kapTYml3n6?=
 =?us-ascii?Q?m6Y/ZiqslQMBE+p1nFNs/9qSH8IgdY0NwoVi725k760ZX6ErIa0yNP+HNHGK?=
 =?us-ascii?Q?M1MCFeI1Fv/faao7oc7gbD/MT0sgRArSCjCrEZenpnTDILvmOTdxzlpAs/D0?=
 =?us-ascii?Q?VAo1aZKOK2LC3Fm7BTQ4Gpz0Y5Y9re1JcAYXks2L+TVM//2Oi+Rd1t597HPH?=
 =?us-ascii?Q?Z6BjRO1ycjV05wPzbYsyWXHIpOKEMi7BrO7dPyw9piUof9HExM0Iu+RkKJxZ?=
 =?us-ascii?Q?BZbhvMkxtqv/LdgifqNv1fsylb+mCAMESMkN2be/5vJhYNoajXgYZZb3Fx+Y?=
 =?us-ascii?Q?XnEcuEv4SYF5XliWFd2fZeHUn2wrpzyD3U6WAAFqWjBGENEAV4cIxT5IB+yw?=
 =?us-ascii?Q?fVgX3y1NEzJxMZ1UclcWjVJfLiJIqtCNGzNdq+jc96thBrtrPLkrhAeminEj?=
 =?us-ascii?Q?rjuEhsiFFT0HOEjtKXQ6cZcR5W2Bbt13q/EIGILwIRiOleUt6Ab5gwC6IqwK?=
 =?us-ascii?Q?0r2BsXkHxL2k5bEBkVA+FqIx+vRuKw8eCJ58xEuZtmfvBWv3CT0rLtGHiSNW?=
 =?us-ascii?Q?UXrEUodHQFJ8mjVEQxPlnjZNmpbXGZeX1JDnStBHeww9GKLB232OfrihIRyI?=
 =?us-ascii?Q?EpTQDjfFyI5bZk8saMInSYTZry2Ex5h7Iu6EUkiUsNenYWWHCS24bablXsjb?=
 =?us-ascii?Q?M9fxnC3RYilKahqiheT/XUUf8XjgLbEze3sQX1g0AcYeWI8MF3lk361uhVOs?=
 =?us-ascii?Q?WBpRWqladX7Tz4xr0TwXbFQDuXeBPzu680grJJ+o580r6MeFNWtr96cfJfgX?=
 =?us-ascii?Q?c6SDsyhIz5inB00VjE+IpM9bejQWOgTF5t/IZ5C4ZgCxA6Z1HGro0sYii+eI?=
 =?us-ascii?Q?zXUg+CJ6GCmCzYIWDb3BKulkcDrKvkOfEMQr1UIxgrfX4pntfNQl/NDljZE6?=
 =?us-ascii?Q?x1hpiGzVYehI5fKQ6G44Zt5pCFY70W93HsyvVKAkiHxhedkGIFylGE9kzxDr?=
 =?us-ascii?Q?DdvHVl5qZEvUlzsUlbp7kt+lZSnDbYMd7gnr2qcNvYI82Y+XN1ozp5nuqHuH?=
 =?us-ascii?Q?ow=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E9F24C4D2564074BB9F0DCB77AE55297@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB7765.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0367872f-7320-4dc5-4c56-08dadf3241b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2022 06:53:37.0055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 91MAQp68Mt8RfI3EMCbP2EzEfzran12du8anKc1MsV0AYC4/Atd0MQdaTRgNJqTGB15ONWi5xoBcg9BU5JrRYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0659
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 13, 2022 at 10:39:07AM +0000, Filipe Manana wrote:
> On Tue, Dec 13, 2022 at 9:11 AM Naohiro Aota <Naohiro.Aota@wdc.com> wrote=
:
> >
> > Hello, Filipe
>=20
> Hi Aota,
>=20
> >
> > Thank you for this series. We had a performance issue on a HDFS write o=
nly
> > workload with the zoned mode. That issue is solved thanks to this
> > series. In addition, it improves the performance even on the regular
> > btrfs. So, this series might be worth backporting. I'd like to share th=
e
> > result.
>=20
> I'm afraid backporting the whole series is not an option.
> It depends on two very large patchsets that largely rewrite fiemap and ls=
eek,
> focused more on performance improvement but also fix one bug with fiemap
> extent sharedness reporting.
>=20
> In reverse order:
>=20
> https://lore.kernel.org/linux-btrfs/cover.1665490018.git.fdmanana@suse.co=
m/
> (introduced in this merge window)
>=20
> https://lore.kernel.org/linux-btrfs/cover.1662022922.git.fdmanana@suse.co=
m/
> (introduced in 6.1)

I see. These are huge.

> >
> > The test workload is a system call replay, which mimics a HDFS write on=
ly
> > workload. The workload does buffered writes with pwrite() to multiple f=
iles
> > and does not issue any sync operation, so the performance number is the
> > number of bytes issued with pwrite() divided by the total runtime witho=
ut
> > sync. The total pwrite() size is about 60GB.
> >
> > Before the series:
> > - Regular:         307.68 MB/s
> > - Zoned emulation: 269.32 MB/s
> > - Zoned:           231.93 MB/s
> >
> > At the first patch of the series:
> > - Regular:         349.84 MB/s (+13.70%)
> > - Zoned emulation: 363.48 MB/s (+34.96%)
> > - Zoned:           326.40 MB/s (+40.73%)
> >
> > After the series (at b7af0635c87f ("btrfs: print transaction aborted me=
ssages with an error level")):
> > - Regular:         350.22 MB/s (+13.83%)
> > - Zoned emulation: 360.96 MB/s (+34.03%)
> > - Zoned:           326.24 MB/s (+40.66%)
> >
> > So, before the first patch, the zoned case had poor performance (-12% o=
n
> > the zoned emulation and -24% on the zoned) compared to the regular case=
. As
> > the regular case and the zoned emulation case ran on the same device, i=
t
> > shows the zoned mode's penalty.
> >
> > This series improves the performance for all the cases. But, the zoned
> > cases have far better improvements and it somehow solved the performanc=
e
> > degradation.
> >
> > Also, even only with the first patch, the performance greatly improved.=
 So,
> > interestingly, the first patch, touching only the readpage() side is th=
e
> > key to fixing the issue for our case.
>=20
> Backporting the first patch only seems reasonable to me, and it
> depends on the following one that landed in 6.1:
>=20
> 52b029f42751 ("btrfs: remove unnecessary EXTENT_UPTODATE state in
> buffered I/O path")
>=20
> (it's mentioned in the changelog)

Thank you for the info. I backported 6adb9287e3f8 ("btrfs: do not use
GFP_ATOMIC in the read endio") and ccd2d08b91ee ("btrfs: remove leftover
setting of EXTENT_UPTODATE state in an inode's io_tree") on v6.1, which
already has 52b029f42751. However, the performance number didn't go well :(

I'll dig further to find which patch is necessary for the improvement.

> It seems your workload is probably not fiemap/lseek heavy (I only see
> mentions of pwrite).
> Thanks for the report!

Yes, it only does pwrite()s.

> >
> > On Fri, Nov 11, 2022 at 11:50:26AM +0000, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > Here follows a few more optimizations for lseek and fiemap. Starting =
with
> > > coreutils 9.0, cp no longer uses fiemap to determine where holes are =
in a
> > > file, instead it uses lseek's SEEK_HOLE and SEEK_DATA modes of operat=
ion.
> > > For very sparse files, or files with lot of delalloc, this can be ver=
y
> > > slow (when compared to ext4 or xfs). This aims to improve that.
> > >
> > > The cp pattern is not specific to cp, it's common to iterate over all
> > > allocated regions of a file sequentially with SEEK_HOLE and SEEK_DATA=
,
> > > for either the whole file or just a section. Another popular program =
that
> > > does the same is tar, when using its --sparse / -S command line optio=
n
> > > (I use it like that for doing vm backups for example).
> > >
> > > The details are in the changelogs of each patch, and results are on t=
he
> > > changelog of the last patch in the series. There's still much more ro=
om
> > > for further improvement, but that won't happen too soon as it will re=
quire
> > > broader changes outside the lseek and fiemap code.
> > >
> > > Filipe Manana (9):
> > >   btrfs: remove leftover setting of EXTENT_UPTODATE state in an inode=
's io_tree
> > >   btrfs: add an early exit when searching for delalloc range for lsee=
k/fiemap
> > >   btrfs: skip unnecessary delalloc searches during lseek/fiemap
> > >   btrfs: search for delalloc more efficiently during lseek/fiemap
> > >   btrfs: remove no longer used btrfs_next_extent_map()
> > >   btrfs: allow passing a cached state record to count_range_bits()
> > >   btrfs: update stale comment for count_range_bits()
> > >   btrfs: use cached state when looking for delalloc ranges with fiema=
p
> > >   btrfs: use cached state when looking for delalloc ranges with lseek
> > >
> > >  fs/btrfs/ctree.h          |   1 +
> > >  fs/btrfs/extent-io-tree.c |  73 +++++++++++--
> > >  fs/btrfs/extent-io-tree.h |  10 +-
> > >  fs/btrfs/extent_io.c      |  30 +++---
> > >  fs/btrfs/extent_map.c     |  29 -----
> > >  fs/btrfs/extent_map.h     |   2 -
> > >  fs/btrfs/file.c           | 221 ++++++++++++++++++------------------=
--
> > >  fs/btrfs/file.h           |   1 +
> > >  fs/btrfs/inode.c          |   2 +-
> > >  9 files changed, 190 insertions(+), 179 deletions(-)
> > >
> > > --
> > > 2.35.1
> > >=
