Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558D27421D9
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jun 2023 10:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbjF2IPg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jun 2023 04:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbjF2IO4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jun 2023 04:14:56 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72A29ED7
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jun 2023 01:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1688025864; x=1719561864;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0UsIkgpas6SaYVnAIWgYdW9P56nClbkr2DdnbfgAv2Q=;
  b=Dv4617GPA4rXpwN89CowYadk+IRTTgkmk+djFMCnrXOIcua7zXUG0zfU
   vzmFcfnMK22riDaqy3wkc4REZNQRzXJm05xwkUlKWYDcgUmUjD5Gi8sbQ
   skWnwqX0kqayFI0bs6w67iZwgKOeytxyqNlRobJolt5fHMy7k+PsgDjex
   3MHruGJgfB9zNszEQvY9jscYpvDdDwjGiW5Q2o9JN6+zvj6S5BQJ6KTcB
   kOjfWi+RQqwMfrjGi/siwrAS2kgZ1yZimJyVuRedsRPgfqrC3qPPIu7JL
   UHNPqdXXCEleMF+jn3uxKiObPvpJ6ouQBw3itR/o4tiNNCDEkER4CcMUE
   A==;
X-IronPort-AV: E=Sophos;i="6.01,168,1684771200"; 
   d="scan'208";a="236516603"
Received: from mail-bn7nam10lp2102.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.102])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2023 16:04:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BhD84Memfn0+2m+fNYpA/5wG2jaLsPJbe2g8qVcJS5mbFeSIxJuT8Kx9s+iLJTiyoSwY2qDy5r4v7tCCPmp/AwgSQWhixIgab5rSeG39Av+EtAGH9y2LvT/M+Mvwq2d9NeOdZCS4Cy4kEwdmTHBf4/pvsEnyiCDKL2e0BxE1iyfQ3BJCIL0omLUT+1cX5yJdS3ZRTMBf52W1fDj0SdEbXL/SikuT70S/FW7ExaZcaW3aHpXQkbDKQpMejcoLSkMr0ElYpuvt7z+joBdGTzPKxIbtc3T6LXS7Gs4mkJgs32L6VASghBoKCq4V7H/iPDimzhZxa0ivTpGRkKA9hraKsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rAX+z8eTXLHqXC5A2C8qinFChs9glYzqJoOjJ86yCY=;
 b=FqTm0PsH+lgxXVHEH1cvhWTLjB+AayLiHY2ZvjC6SjIccBHGEmLZFmQwXakMeNOj8n1C8TTwEKphbnMooh4vmHXbkfNZaTX5yBsLozi/+lwY8qovRtrgFs2O9TAje8JHjfgYlYK/+HdK7oMHV6NPPGmEZ6jj1FyivPa6dUHyfHgSucspXjICN1vBOg39JYuVFYKJPCjRWxj/nyIyYwHWsk1ah1PEi4e1mc744v7/cGR2dgdBdkOiynko+TCfwubRHF/e4KdbhGWndxYW9dXx00c0IvB17Xl6j41DS5fd0ataQXc6LubiDVqpYV7WJmv3fSPvZLfJ9h3Tb/WuE6Dhlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rAX+z8eTXLHqXC5A2C8qinFChs9glYzqJoOjJ86yCY=;
 b=dzKkkjaSgusfJmzBHLoENoVPpx/5RIo3AM28m7gFcrkTZTniXYi6rF7nWrPzuC8A+GPALOnJGe+Z/x4xumq4fEiz5k5yzr9wVwRSAuyX2Ozc3wteW4k4NCeJB6V8czkApD1M2e0xAlQVoVk4sPeYZzdkwFTqWI+IQn9xT5m82Pw=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SA0PR04MB7290.namprd04.prod.outlook.com (2603:10b6:806:e2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 29 Jun
 2023 08:04:20 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::e9d9:ae8:fb59:5f01]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::e9d9:ae8:fb59:5f01%4]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 08:04:20 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Damien Le Moal <dlemoal@kernel.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: do not enable async discard
Thread-Topic: [PATCH] btrfs: zoned: do not enable async discard
Thread-Index: AQHZqVr56gNiVOO8M0uRnnRtfLuBBa+fucYAgAG0IIA=
Date:   Thu, 29 Jun 2023 08:04:20 +0000
Message-ID: <wsottnbmkwzdjfvtixoe367oc7va7pkerumlwfr4vpogbela7b@2yflrzmhxhrc>
References: <87c887259bfb49878be9990f4dd559ee90d273ec.1687913519.git.naohiro.aota@wdc.com>
 <203c7896-0e57-ce3a-5ff0-2bc3a7ab7bb3@kernel.org>
In-Reply-To: <203c7896-0e57-ce3a-5ff0-2bc3a7ab7bb3@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|SA0PR04MB7290:EE_
x-ms-office365-filtering-correlation-id: a70c4e66-85d8-4caf-535a-08db78777161
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H4m+bwcA5yTEqiFdQGnFNWwvA5vo41bCoBdFxi+hNqH4jJO81MMJNeVPhIsL0EEzJw7VCJq2jSP/ue1Vy9kuOCB9fEUULcYizI/FnFmRta242hA53o/zmxXfQaC2ACkoac1nX+hsAahIGsAdsfXUR9YSmWLenlzocUAS1rkG5jbVYCy/ChJaNWY4bdkrsX3Ucoc7zvTf5T/yPCQsB0n+R5oFWY2BRFVrson4F6UwvuPO8dcKa4BkIOH55GNeYk54CNoidyxPAXdq3+Cslal0X5RtN7PRPByEp5uNZ8LLngFTarhNMfH2aG8UOTKGoiOxKHlemwmqBmduDfX/zGR7NV49mZvbTiA0cY77CkIiutsrc/dZGBDppkUGEVLoiL9d9Fm/dyIK0cq+u4iwntHbK/mPaOyDP/ZtufLVr2utnAgUfmKrDSJh5LdSFxExiJOz+hbVTIZ92QJ/VHwMjNi82wsjXocPum/n7BTsg7ybi7NoriQMPaCHXZT8GQZqNRWRGNe8yB7ZosuEGvYlhfQEvHwlhsqOWqoc9llUSYMb6H2y/ZWSrb7pRduh0r191ZvGxmAv7ah0d2no8lYVCXMArDE+lFSs5i2vkaaWqXaHH17gMepTNpUu0dH28iXrzIDa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(451199021)(5660300002)(6506007)(64756008)(66556008)(316002)(66946007)(66446008)(478600001)(4326008)(66476007)(91956017)(6916009)(76116006)(8936002)(8676002)(86362001)(2906002)(6512007)(26005)(9686003)(41300700001)(33716001)(6486002)(186003)(38070700005)(71200400001)(53546011)(83380400001)(38100700002)(122000001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?z3Cw31wpD+1XsY08z5aYsoYfCHWpoj5C7rxxthJR3tXb71eQltT0G1B8JLF1?=
 =?us-ascii?Q?mhJJUCoAhzQJJo0mf1LvntJKEzYZLnGgD0ZzEl6zKNJ9IsBuP9VJSOt6ZFED?=
 =?us-ascii?Q?2h43qGssRcArxyWiV9i4fgzwsR+gxIhDyZqGRVBCL/ussePDVe35IuXWzJ6H?=
 =?us-ascii?Q?vtHJuP+FzGC/Cj39dYlLnKZ5d1B2YSpyyiU40cL2y5DVyg16RRKOg9mc7R+m?=
 =?us-ascii?Q?m6zOzHBieqUDEEJubqiDes0ecYQqjMyURVdZ+lfNXMOU/sSAjpaUuJ2Z/c6g?=
 =?us-ascii?Q?eKv3YPJIuqYblHQXR2chL3HYw+yysFpWQCjChd1YUWQ8YPPWAVnBWMOzyEM/?=
 =?us-ascii?Q?5LP3jZ6ADxZrKS5twOfs4t/PK8SBmotNFJKmnV5K8IWU/eNy1fiTRv9utFqH?=
 =?us-ascii?Q?Nd1yPFIEsBICf8vcsaSNBGsiUbDGOL56dUIuuDQyW1XmESrX2aaRxenRnkLH?=
 =?us-ascii?Q?fTcwSYRK/UVXIXGYuWgNd1gmJSpJSOJeMcmpN6ri5qd91kUk8lDcj/Trb3l6?=
 =?us-ascii?Q?FhtyqSDsFq6XxJm/Ms0+YrbdQHomYU/IQfOljvCJ7P4w2cvmUZqJjht2Hwtc?=
 =?us-ascii?Q?tjNDga06Lgxm9tnPcroX/0OmlIGP5QIZr66N21RW96hAvqIum8hEm2ntvvuD?=
 =?us-ascii?Q?FusM6vdn6ueEl/lR2EMTnLSdxGFiyEU7sNgbmJotqSjUI+fEPZAVCDZjttwS?=
 =?us-ascii?Q?iLloVYheU0iD2AQhL4uvcHSJs+ca3Li6Hdwb+raILc1rEapthLeUI8wVeDTm?=
 =?us-ascii?Q?KWR/oA4xxhBTUpvA80et8kzmpG1+/no9KN4stFEil1KOL7TO2Ao4vDduqi0Q?=
 =?us-ascii?Q?/8Dhp8te7cQ6JeICZTaeOkzSyf8jh1BaW6/quNB2dBtDHAxVZ5f74wtPeO7+?=
 =?us-ascii?Q?aCN4FT9mJxmYqtw7Il9o3NLfFy+Ik3F3bfU268psZsh/feqifB8lOUV0lLJ3?=
 =?us-ascii?Q?KLCiqLurLgA5zRi7tLWcJMqd2D6tAzN95PPHcccoHeCejzf06Oh1Lsfw32I0?=
 =?us-ascii?Q?jhxmRYIPxgdD7QC/3BJHIJlV/QfaR9QoGE8NMIpyyknctScdx8LjYVoJaKyu?=
 =?us-ascii?Q?3SczxF0ZppR7FPdlEgHFIo7lsaocx+y0mswiQGl2KnvfJVV0kQvsTUqfE7Qi?=
 =?us-ascii?Q?FUn2wjDM0qnLOP4I7frJchoy4tzNc8hlXBUXfy8HzV2nSoxhsifsTtM843z2?=
 =?us-ascii?Q?CUxwS4vPDxyChcRUfl8W14rP3vp1J70WZZgD0VgG2h80RQTy6PmPDOPbyd/1?=
 =?us-ascii?Q?pNbkdpOvKLks3NYaPGQmQixSSkRmW6Gm6Gpz7nUrYmFAnxvQZD2q0W1HXfyP?=
 =?us-ascii?Q?yMrDjHRUzDD4W+knOTANvlvu3/XsI/0maRTzb73bSLzUQ5mtkMW0QkUSmEt7?=
 =?us-ascii?Q?5KloIjfXEFs1xoJbnqKmXd1OfhplrSJLsOU1AgryQmFB9Xdo9bPyrAODq1Ez?=
 =?us-ascii?Q?rAeidycYQ6yz0CHZ4nRvZyA0/4zvoTZ3LCmVSxVuKTBXfX4Ax2aSAX5Y4Ff+?=
 =?us-ascii?Q?sPa3v00IVECZGmtO1sYU87/+T1xgGcYx+Mw1wYhg4xDKyHBRwer3Vyy0fU4k?=
 =?us-ascii?Q?S4/wyHCnazd/O/77xqiZO/ljwvoEXRmF/NgzI5l4h+aC0q8+GpUp7NVE2WH0?=
 =?us-ascii?Q?ZA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D986B40F52764647AF2820F6999B9EAE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bKeHA6ZU2ORXTjz5xaTEPGC9RnY3T0yfwkdNeUGUFvvCzIUOulLf2Tvyb48Yzd2k5SENRa271PrM50jk5VvdGNNLGm8yL6ztdXClnXgx3u08gXoniYYwmhmlkHpICjj/Jn/BZj8tzZKdIThpMLGcWLWJw8XSl4VmAEMl3/hb2Gkxf8VQ9cRd/5oKKFEOZmjK+RtnvcacqGiHX+u/Iq9tr5VZqVConuDrI81gXd62YUX1JvxDnpPJ540B/Ej6qRLNHzqNsxPDCid3qZMDQtMpHUi5xdSdY4NTJGeJ7ynbQdytj5P4SoFH0+5DRWNpsJAcGZuUlWoLYFO4ifA+amHK+LTvVqiWuLbWQbbIILtwd2O1QBepRhM2TaUI6+oykpezNlPinPRPB0dPffHSTdXIHazm7dHDZB8V4EBcYV0lCwbIvkH/VeDZyrfGoHrmVCCUwGNN8UBIdLDzrUOVDVRNez09m+5k8QBhemiBHFtQUSuhZmo/vvqKzZGOwObKbFlpvJeKzUkKJ49HRABmYZaltJnpC5x0v43nXmRVp0O6XsVWBAyRDauYun+/01RvN71HHFLKE/MlPZqffa3k2gN7AgwZWIUrMSz8NMEfdvc0bS7cSaWQyeBtzuB9y+fOcl8ZiwpBrMmQE71TXJqlqIEuMtU8TgtvHyIwIkIYV8ZeRBrltI1d90IAsQcoQHy9dCmXrbxD5KLQ/Q1nNrE17VDLXpiIAO+NEs+MLie0UdHfHej0JqFmf5bam8lrbEZeBeFQOlxnFp5BpLslJ6wODQCuzq3g9ZVzsQ+ibkaMxCosiZJYElLBm+tiipNQU5IV7LRN
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a70c4e66-85d8-4caf-535a-08db78777161
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2023 08:04:20.1586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ex2o9Tg/vhhCfEGH4RE4zc7ljDR9RewON+X3NMU3AOzvZriwBCTOXALW2Z1h2NeI/j1a5QF3ppEoeH+lMzjKwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7290
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 28, 2023 at 03:03:22PM +0900, Damien Le Moal wrote:
> On 6/28/23 09:53, Naohiro Aota wrote:
> > The zoned mode need to reset a zone before using it. We rely on btrfs's
> > original discard functionality (discarding unused block group range) to=
 do
> > the resetting.
> >=20
> > While the commit 63a7cb130718 ("btrfs: auto enable discard=3Dasync when
> > possible") made the discard done in an async manner, a zoned reset do n=
ot
> > need to be async, as it is fast enough.
> >=20
> > Even worth, delaying zone rests prevents using those zones again. So, l=
et's
> > disable async discard on the zoned mode.
> >=20
> > Fixes: 63a7cb130718 ("btrfs: auto enable discard=3Dasync when possible"=
)
> > CC: stable@vger.kernel.org # 6.3+
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > ---
> >  fs/btrfs/disk-io.c | 7 ++++++-
> >  fs/btrfs/zoned.c   | 5 +++++
> >  2 files changed, 11 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > index 7513388b0567..9b9914e5f03d 100644
> > --- a/fs/btrfs/disk-io.c
> > +++ b/fs/btrfs/disk-io.c
> > @@ -3438,11 +3438,16 @@ int __cold open_ctree(struct super_block *sb, s=
truct btrfs_fs_devices *fs_device
> >  	 * For devices supporting discard turn on discard=3Dasync automatical=
ly,
> >  	 * unless it's already set or disabled. This could be turned off by
> >  	 * nodiscard for the same mount.
> > +	 *
> > +	 * The zoned mode piggy backs on the discard functionality for
> > +	 * resetting a zone. There is no reason to delay the zone reset as it=
 is
> > +	 * fast enough. So, do not enable async discard for zoned mode.
> >  	 */
> >  	if (!(btrfs_test_opt(fs_info, DISCARD_SYNC) ||
> >  	      btrfs_test_opt(fs_info, DISCARD_ASYNC) ||
> >  	      btrfs_test_opt(fs_info, NODISCARD)) &&
> > -	    fs_info->fs_devices->discardable) {
> > +	    fs_info->fs_devices->discardable &&
> > +	    !btrfs_is_zoned(fs_info)) {
> >  		btrfs_set_and_info(fs_info, DISCARD_ASYNC,
> >  				   "auto enabling async discard");
> >  	}
> > diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> > index 85b8b332add9..56baac950f11 100644
> > --- a/fs/btrfs/zoned.c
> > +++ b/fs/btrfs/zoned.c
> > @@ -805,6 +805,11 @@ int btrfs_check_mountopts_zoned(struct btrfs_fs_in=
fo *info)
> >  		return -EINVAL;
> >  	}
> > =20
> > +	if (btrfs_test_opt(info, DISCARD_ASYNC)) {
> > +		btrfs_err(info, "zoned: async discard not supported");
> > +		return -EINVAL;
>=20
> This is an option, so instead of returning an error, why not clearing it =
with a
> warning message only ?

Sure. I'll change this to btrfs_clear_and_info() that clear the option and
print a info message if the option is enabled.=
