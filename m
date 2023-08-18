Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F55E780D61
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Aug 2023 16:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377596AbjHROEJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Aug 2023 10:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377425AbjHROEF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Aug 2023 10:04:05 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C2E3C31
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Aug 2023 07:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1692367441; x=1723903441;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dWjsdUT/5ZU7vDejp69YOPhrzHdEV/aLNVFH2UPKWYU=;
  b=R8AJ61gfXpCr+cpa+kxhPfECA57IaM7mWSUjwPC7Y9fuvTOY4Zq92LC4
   S8HprTmFt/nwhiDYq9J34uYNdxNz1QIbFiWcIEr143cIg9NXLo3ycHFtb
   Z9LS4KBuf7xCHqKXatc6sMCfKq3qgWC/+hakcqj47/DfnJQnpGCTFpsyz
   tkP6SSGZw+CbMVE7PXavbRYmUoirfYPhiX1AadQPBqRQyhL7qQcNZywCB
   FMlCsM4ukpKrCPkVjSzIm5nHbcNSbKOcSwxaftGCOAjcwS/kFgARJn0mN
   lOzz8fbwUvCWvCqQouFUZ+nDCDoG9PpSoiVauc7svvH8Tg6W/D9q/sfWa
   A==;
X-IronPort-AV: E=Sophos;i="6.01,183,1684771200"; 
   d="scan'208";a="353467776"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
  by ob1.hgst.iphmx.com with ESMTP; 18 Aug 2023 22:04:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+dUyoyL9VEDESyapqztm0jWjHEm8UBabv7alEVufPUv5LPt34VigtMOWVYSEQVGSApeqiclkT8k/edS8hYpMTTntti0Ztth1VHbxmOjWFekfJ7xsZuu4h1gHPCE2kZ4ouR9wlVBP0b0QCbGi/2hA3Z/pKlJscQYPO5922rbgPuNAvoRpmEN9Z+Jp8G2RzBAulXFgNFLBb9apZqDug0Rvx+DtApV8kfc8eRAuKWoDl3HooxoDrAXo96D3qFos8aENz98qKFLrwvrWkJUQA4rPIzDNOcCK43cWCc23E8YXTIssoZb4Yqu4QlE8mpiJWFKqzD4E7uAh3xTJkDt7mQxXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXZZAzBISg3BDwAZ/Fw0052pYE1i/hJv1ifbAJYrgoo=;
 b=RpeWZM/kMrajdebHTcZakiIQJpHktQSsYCjsT4FZDUneHgtmakeiKx2JY/Kbzgos8d9nwY1XFWzjdeq0GUhzLdLrisH9rEQQiddFG3+mEW4kEGy/Jh406e7Wc0HENtKFVPDq4lUcJZ8VYgmTyJlUP52Y+SJMGlF5DsNWdS3YrrGO+2+YYJIpqavBDlY3nm0YC28sq5dcly4cF+KM7FMt1+0DOo/6J2HZEhkeEZHTbjD27dhDMWO4K/b0+Sw1IWeoTG9xFMNFOSIeNKFBInMalboM3WG4JZb4N9gOzxYlGpCE+r3qikqXhExvkNPOjvB/9pxZdUMCGEeLt8ks17g2dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXZZAzBISg3BDwAZ/Fw0052pYE1i/hJv1ifbAJYrgoo=;
 b=dLm+wes1rHyr5yK+7LjsedjFzUww1htu2nsiX8ygwUwUMDyDDKleprxrB/02F5S49STX9nb/y1OtHzZyXjVK4KutHKEs7uav1kKN0qLggvVmiE2mq1UPatqNJJy9zut/JvWoWfDpz6WRr9Gf5leBzqTMp0a4hvEksVuimtwXHco=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by DM8PR04MB7957.namprd04.prod.outlook.com (2603:10b6:8:e::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.31; Fri, 18 Aug 2023 14:03:55 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::275a:b2f9:29b8:e60d]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::275a:b2f9:29b8:e60d%6]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 14:03:55 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH 05/14] btrfs: optimize the logical to physical mapping for
 zoned writes
Thread-Topic: [PATCH 05/14] btrfs: optimize the logical to physical mapping
 for zoned writes
Thread-Index: AQHZjlDvn4BAx98Luk2TOa/zEGEuDK/wnQMA
Date:   Fri, 18 Aug 2023 14:03:54 +0000
Message-ID: <yjowz6ydsszvkl4tahb2ta7xr2agnuldavetbu24bx3a3xzzio@csnq67ij6g34>
References: <20230524150317.1767981-1-hch@lst.de>
 <20230524150317.1767981-6-hch@lst.de>
In-Reply-To: <20230524150317.1767981-6-hch@lst.de>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|DM8PR04MB7957:EE_
x-ms-office365-filtering-correlation-id: 7e7d119c-1390-4524-c9a4-08db9ff3f5a2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RXaQQuKPecq1KOeI8ilNtLDN9R9dTjIZeyeqFbJE1vpgHcYG/ZtOhs50VCbf+FOLSBkryQgW3H5M54NqqUV/tkKCsgg7tdL5W3O0vtJaWC4R3BR8B3rZzgMEpKAUIo02APrUQqRsXoxxCobB1RlqX5V9bsUwUp5V6+WtG6vqkV/tsdhcXfVdtURzyINgw/C9y2vTpN9vcsVQyIrxVLgX8ju9dGC81mH/x5xVE/U8HWgJx5wHLksRvFJcnC5SHVI5YYcjfUk7qiSfLyXwd2slZJ0xKyn+ByO2uNFRv/nn+Ok4AHrshoDOP8d2bCaJOPFfZCi+WPOZ3eKTU0liOj5tHB98ssNuQ7jEutavh8XLXLaTfIL5mOr/qTeqIeMnzwCKCcVXrZf6jri8xQsPZ4hVU9JqzaVZbCCapd/wqSp46M/0TJTLh96St9r1fLAAOA2dvKpqRjyWVNxwgSQPU/r5kQR3paX6Y0sxEOsTz6+5ThotejVfA3dCBx2SKba4KSe2WUj8GyMxiJnUFobzB1CsTbrywiS//C6RRndGCZtfQAyqsvKHDrlQ20aqDCKN3k0hZauT6MFxSWskmwT5tKoqKxQ3vdfLwlePdfujtTMD5umPPT5j6lSuH8QrNO2EWQds
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(39860400002)(346002)(136003)(396003)(451199024)(186009)(1800799009)(33716001)(86362001)(83380400001)(8936002)(8676002)(4326008)(5660300002)(2906002)(41300700001)(26005)(6506007)(71200400001)(6512007)(6486002)(9686003)(122000001)(478600001)(76116006)(82960400001)(66476007)(316002)(6916009)(64756008)(38100700002)(91956017)(66946007)(38070700005)(66556008)(54906003)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m5kCw58kzk1GGnS1NirgnRvbACw/uqX7/Eop5uozvhjQsGB5idpd/y8BSz4I?=
 =?us-ascii?Q?W0ZyrlmsE8kWZjV6VtwbX8Fugi61bl8Yr4U3k4M0WjXYBWVETzZOMGHHPKQM?=
 =?us-ascii?Q?vsKaDv7CGKB3zvn8wiacFPNzasguenyKqz8PPpvzwmagVVAiFvq0LHGwz0YS?=
 =?us-ascii?Q?gCc7veUWZ3NsJa+vtVepc/Z6y0fuN0UQ1V9yifa72/TjwXBCUoiRapHXa4Dd?=
 =?us-ascii?Q?rzT623ThfFUsVhSHnDqAajtBE5ejCbe1FRabuRGUL+2iu6M14dUtz7pA7mH9?=
 =?us-ascii?Q?3cVp88/XYdNY0fF1gIB5oqEgxrsec+1unWGZ8/g9xgzCrZJLxrKHA4lT9yrV?=
 =?us-ascii?Q?22pMJbOFjwKKj8J8HJWyJIZeIA9tD8H9A3VV56FHnJzTVpckherIwPdnb/FD?=
 =?us-ascii?Q?5ubNZrTsGSdTYnE+tXkcoA3XHf2dMIdZ27k4POj07IZSrTRHVvmVRYls/Q/s?=
 =?us-ascii?Q?97K0AOD0iLoyY74gxBYU8krIKL1cz9Y51a8PA+HyoJBQNxYvj9ayrvFyGUJD?=
 =?us-ascii?Q?IMBVqkYJAuxYezlxGoV0yQi15LFEBO7Rl+wlBQAktuMbXCXLoW8UsEyA7E5m?=
 =?us-ascii?Q?uoOVo7hIqnO8TIZmGeB5ILA/6gwlx14egFsaGgyR/oGK1fB4j2LStIFsXYV+?=
 =?us-ascii?Q?fYcbyu8IoNrQCnlaxtOB2RrSM+oIh9Wm5blBM9nzRNp0oRKWldeFc6ECi+/b?=
 =?us-ascii?Q?/cCBhX0XD9vLnYj6+iuvUcpd4r0I9febLcrYz+NQyw5anAS1E+7E2DMVp2DA?=
 =?us-ascii?Q?lPVtFza5XiXtW6EAVYxIu1TYVaPKTGr+lACGeYyGnrxILEu0n494NnwJvNnn?=
 =?us-ascii?Q?7bTUmkF2283YNDeASWcEK3qHJT2QlBb8uq3Vfzed3LlyvOO/WABta6zfhHDJ?=
 =?us-ascii?Q?FcuWqlwl4Qk1GXR/8EkHQAkdKSXGppfdnW44f4Ql5Gz20P93u2H8FFq+4E6i?=
 =?us-ascii?Q?qVnCsS2HnzBZXsRbZlEU11GGeC7JKgnYehwqFsVEpogUVJM5gGEfeS3dfyu5?=
 =?us-ascii?Q?Y/d5BFuz7nCombylw3Cr58+9atl3PghR3N4bgjThS0+yTesYqM2rvZxhZiI2?=
 =?us-ascii?Q?LATKumP2sDu2e0bUuk2hW0SObo1cKKiSk9kJSxiiy191RsUyFymO6+MZltfu?=
 =?us-ascii?Q?1ElBx8jE4yReCCNSh5d71lfFy6Yx8CmmufwMP6wqGUFQNxIllRhKfhxLAeVs?=
 =?us-ascii?Q?0o/DnzrKG3roB4SNjNDYjsP73vu6K6rZuypt1tsPjmcFvMHcg+RXGIoxU2wc?=
 =?us-ascii?Q?b2pm+HpctsgSSE+oiIVANgL1NSr26kHlxS6n2RbfXwKIhpiBE/9tBIKsKF+d?=
 =?us-ascii?Q?K6XwWtM2+aQJ+T630Wk5nXcxnev/Cho0Q58UP55jtEwCK/LH2bgSFGTm072w?=
 =?us-ascii?Q?Wpy/1pNkrVwDaVb5sSOXaSucKdPCo4M2hgv6/blvr71zzJSjb/K9b9ONl9Pl?=
 =?us-ascii?Q?STT911YmlzXK9eLfrleSkDm96QgJNwiFw1NgLVZBmuczH0a/6+OafZPPliCm?=
 =?us-ascii?Q?HavkoH8zQGLEvIzF/uzbiqAN8+nLj5njUT0OsymcahRXJD1mAZk9RWwT4RTR?=
 =?us-ascii?Q?TWgxCqeEeoJ5UqYSKl8OpnI7U9uNCyQ+i2TiME+Sox1FSfnrZjKJuU61Jx+b?=
 =?us-ascii?Q?5Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <01D4B9D05FC16B49AFCF4798F09BCDBA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: txM0XvI+KeEGmg+zMA7gYrODgddEwXDhmYVNIetqaRxXJ5uhUNKGnzi81z1nMd2TZ8WC9tzQgGZc4H8q0doWmxwi1WMpbJEB8uVmzsXn9bJDaPn+lNjXrEaRYPu7UnY3HIkkye9c45xhlXeb0AvNn7tlyxedTCrCT+3jd3KlrmlMBOtKWBFMm+Ye0M3cC+UYRFt/IAQmccptpnBukgj6bPPfZA+a9/ES9+HwbzaH18uNk7JnzWnCpnQqDGsYx/EMB6H+gIUxSylFgDOFfoxnNgUgciRnX70zTv83hukoUcXrDY321Kx1JOjFFUp4ZiGKOM135peL9xdJLkGdLyx1a8dmW4BBYfSM3i5867siBapoTWmTqdmKkH86bibH1DjSA5jEmNEztl7fiNDFSGsLqYzIGueyInobMgie0gtIzzfWByWaAJFjuXO9j4CxkM48W1lzxELLqXbkrYZKEkIouCxAQLWsDj3qd2pEQUy/k/D+z7ffjcxBCS2rNHO4EXAQmwspK7wJrofugmfjSdu6dEYA02ZeeY9zsR3FLQ/Ew/4FA/gUJf570BUwqbKhseU7yx+9JIev4NJc0bF7Cgl41ZqOAoqgJGtjBnu6bkNlFOf+BUBvexezFbyp6hvpNamDKaAWOvgSzjgtMhfmaKe18mNShSkwL0L+IFFJoZ3HNn+PXPDjg8MddG1dMGoHOUY1VLnVWzx+VmsmQRFUdtK18lboIXG4xGba/50rdzfMY8kK1dJHV+2FTGckjHPfdT+rBe229A4ZK4uvy5CJPhU06CoHo/8r63CXwfnyrA8PuIM4E8LkdqvGnhStMG1vzkmIMtB+9ZuSjUO5Jx8XGqzNRJfzKiWsasDhRcfyGWbB7LYUq3HCqZjluq/fplsuqYVn
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e7d119c-1390-4524-c9a4-08db9ff3f5a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2023 14:03:54.9735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rFycDDVuwV1jwMl7B0hc6M587elyOdHJQMiTIwXCVv+tlvj4HxssQSEfTgsZInGBhWFx5IBkeU8qpA1QSDSlqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7957
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 24, 2023 at 05:03:08PM +0200, Christoph Hellwig wrote:
> The current code to store the final logical to physical mapping for a
> zone append write in the extent tree is rather inefficient.  It first has
> to split the ordered extent so that there is one ordered extent per bio,
> so that it can look up the ordered extent on I/O completion in
> btrfs_record_physical_zoned and store the physical LBA returned by the
> block driver in the ordered extent.
>=20
> btrfs_rewrite_logical_zoned then has to do a lookup in the chunk tree to
> see what physical address the logical address for this bio / ordered
> extent is mapped to, and then rewrite it in the extent tree.
>=20
> To optimize this process, we can store the physical address assigned in
> the chunk tree to the original logical address and a pointer to
> btrfs_ordered_sum structure the in the btrfs_bio structure, and then use
> this information to rewrite the logical address in the btrfs_ordered_sum
> structure directly at I/O completion time in btrfs_record_physical_zoned.
> btrfs_rewrite_logical_zoned then simply updates the logical address in
> the extent tree and the ordered_extent itself.
>=20
> The code in btrfs_rewrite_logical_zoned now runs for all data I/O
> completions in zoned file systems, which is fine as there is no remapping
> to do for non-append writes to conventional zones or for relocation, and
> the overhead for quickly breaking out of the loop is very low.
>=20
> Note that the btrfs_bio doesn't grow as the new field are places into
> a union that is so far not used for data writes and has plenty of space
> left in it.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/btrfs/bio.c          |  1 +
>  fs/btrfs/bio.h          | 17 +++++++++++---
>  fs/btrfs/file-item.c    |  7 ++++++
>  fs/btrfs/inode.c        |  6 +----
>  fs/btrfs/ordered-data.c |  1 -
>  fs/btrfs/ordered-data.h |  6 -----
>  fs/btrfs/zoned.c        | 51 ++++++++---------------------------------
>  7 files changed, 33 insertions(+), 56 deletions(-)
>=20
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index 5fad6e032e6c76..8a4d3b707dd1b2 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -431,6 +431,7 @@ static void btrfs_submit_dev_bio(struct btrfs_device =
*dev, struct bio *bio)
>  		u64 zone_start =3D round_down(physical, dev->fs_info->zone_size);
> =20
>  		ASSERT(btrfs_dev_is_sequential(dev, physical));
> +		btrfs_bio(bio)->orig_physical =3D physical;
>  		bio->bi_iter.bi_sector =3D zone_start >> SECTOR_SHIFT;
>  	}
>  	btrfs_debug_in_rcu(dev->fs_info,
> diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
> index a8eca3a6567320..8a29980159b404 100644
> --- a/fs/btrfs/bio.h
> +++ b/fs/btrfs/bio.h
> @@ -39,8 +39,8 @@ struct btrfs_bio {
> =20
>  	union {
>  		/*
> -		 * Data checksumming and original I/O information for internal
> -		 * use in the btrfs_submit_bio machinery.
> +		 * For data reads: checksumming and original I/O information.
> +		 * (for internal use in the btrfs_submit_bio machinery only)
>  		 */
>  		struct {
>  			u8 *csum;
> @@ -48,7 +48,18 @@ struct btrfs_bio {
>  			struct bvec_iter saved_iter;
>  		};
> =20
> -		/* For metadata parentness verification. */
> +		/*
> +		 * For data writes:
> +		 * - pointer to the checksums for this bio
> +		 * - original physical address from the allocator
> +		 *   (for zone append only)
> +		 */
> +		struct {
> +			struct btrfs_ordered_sum *sums;
> +			u64 orig_physical;
> +		};
> +
> +		/* For metadata reads: parentness verification. */
>  		struct btrfs_tree_parent_check parent_check;
>  	};
> =20
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index ca321126816e94..96b54d73ba376d 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -818,6 +818,13 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_bio *bb=
io)
> =20
>  	}
>  	this_sum_bytes =3D 0;
> +
> +	/*
> +	 * The ->sums assignment is for zoned writes, where a bio never spans
> +	 * ordered extents and only done unconditionally because that's cheaper
> +	 * than a branch.
> +	 */
> +	bbio->sums =3D sums;
>  	btrfs_add_ordered_sum(ordered, sums);
>  	btrfs_put_ordered_extent(ordered);
>  	return 0;
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 253ad6206179ce..2eee57d07d3632 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3302,14 +3302,10 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_=
extent *ordered_extent)
>  		goto out;
>  	}
> =20
> -	/* A valid ->physical implies a write on a sequential zone. */
> -	if (ordered_extent->physical !=3D (u64)-1) {
> +	if (btrfs_is_zoned(fs_info)) {
>  		btrfs_rewrite_logical_zoned(ordered_extent);
>  		btrfs_zone_finish_endio(fs_info, ordered_extent->disk_bytenr,
>  					ordered_extent->disk_num_bytes);
> -	} else if (btrfs_is_data_reloc_root(inode->root)) {
> -		btrfs_zone_finish_endio(fs_info, ordered_extent->disk_bytenr,
> -					ordered_extent->disk_num_bytes);
>  	}
> =20
>  	if (test_bit(BTRFS_ORDERED_TRUNCATED, &ordered_extent->flags)) {
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index a9778a91511e19..324a5a8c844a72 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -209,7 +209,6 @@ struct btrfs_ordered_extent *btrfs_alloc_ordered_exte=
nt(
>  	entry->compress_type =3D compress_type;
>  	entry->truncated_len =3D (u64)-1;
>  	entry->qgroup_rsv =3D ret;
> -	entry->physical =3D (u64)-1;
> =20
>  	ASSERT((flags & ~BTRFS_ORDERED_TYPE_FLAGS) =3D=3D 0);
>  	entry->flags =3D flags;
> diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
> index ebc980ac967ad4..dc700aa515b58b 100644
> --- a/fs/btrfs/ordered-data.h
> +++ b/fs/btrfs/ordered-data.h
> @@ -151,12 +151,6 @@ struct btrfs_ordered_extent {
>  	struct completion completion;
>  	struct btrfs_work flush_work;
>  	struct list_head work_list;
> -
> -	/*
> -	 * Used to reverse-map physical address returned from ZONE_APPEND write
> -	 * command in a workqueue context
> -	 */
> -	u64 physical;
>  };
> =20
>  static inline void
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 76411d96fa7afc..e838c2037634c2 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -1657,64 +1657,33 @@ bool btrfs_use_zone_append(struct btrfs_bio *bbio=
)
>  void btrfs_record_physical_zoned(struct btrfs_bio *bbio)
>  {
>  	const u64 physical =3D bbio->bio.bi_iter.bi_sector << SECTOR_SHIFT;
> -	struct btrfs_ordered_extent *ordered;
> +	struct btrfs_ordered_sum *sum =3D bbio->sums;
> =20
> -	ordered =3D btrfs_lookup_ordered_extent(bbio->inode, bbio->file_offset)=
;
> -	if (WARN_ON(!ordered))
> -		return;
> -
> -	ordered->physical =3D physical;
> -	btrfs_put_ordered_extent(ordered);
> +	if (physical < bbio->orig_physical)
> +		sum->logical -=3D bbio->orig_physical - physical;
> +	else
> +		sum->logical +=3D physical - bbio->orig_physical;
>  }
> =20
>  void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered)
>  {
> -	struct btrfs_inode *inode =3D BTRFS_I(ordered->inode);
> -	struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
> -	struct extent_map_tree *em_tree;
> +	struct extent_map_tree *em_tree =3D &BTRFS_I(ordered->inode)->extent_tr=
ee;
>  	struct extent_map *em;
> -	struct btrfs_ordered_sum *sum;
> -	u64 orig_logical =3D ordered->disk_bytenr;
> -	struct map_lookup *map;
> -	u64 physical =3D ordered->physical;
> -	u64 chunk_start_phys;
> -	u64 logical;
> -
> -	em =3D btrfs_get_chunk_map(fs_info, orig_logical, 1);
> -	if (IS_ERR(em))
> -		return;
> -	map =3D em->map_lookup;
> -	chunk_start_phys =3D map->stripes[0].physical;
> +	struct btrfs_ordered_sum *sum =3D
> +		list_first_entry(&ordered->list, typeof(*sum), list);
> +	u64 logical =3D sum->logical;

Here, this function does not consider the case of
list_empty(&ordered->list). As a result, the "logical" will be some random
value.=20

Then, it sets the garbled value to ordered->disk_bytenr, and
btrfs_lookup_block_group() in btrfs_zone_finish_endio() failed to find a
block group and panic.

This behavior is reproduced by running fstests btrfs/028 several time with
a null_blk setup. The zone size and capacity is set as 64MB, and the
storage size is 5GB.

I still don't understand why this ordered_extent come without any csums.

> =20
> -	if (WARN_ON_ONCE(map->num_stripes > 1) ||
> -	    WARN_ON_ONCE((map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) !=3D 0) |=
|
> -	    WARN_ON_ONCE(physical < chunk_start_phys) ||
> -	    WARN_ON_ONCE(physical > chunk_start_phys + em->orig_block_len)) {
> -		free_extent_map(em);
> -		return;
> -	}
> -	logical =3D em->start + (physical - map->stripes[0].physical);
> -	free_extent_map(em);
> -
> -	if (orig_logical =3D=3D logical)
> +	if (ordered->disk_bytenr =3D=3D logical)
>  		return;
> =20
>  	ordered->disk_bytenr =3D logical;
> =20
> -	em_tree =3D &inode->extent_tree;
>  	write_lock(&em_tree->lock);
>  	em =3D search_extent_mapping(em_tree, ordered->file_offset,
>  				   ordered->num_bytes);
>  	em->block_start =3D logical;
>  	free_extent_map(em);
>  	write_unlock(&em_tree->lock);
> -
> -	list_for_each_entry(sum, &ordered->list, list) {
> -		if (logical < orig_logical)
> -			sum->logical -=3D orig_logical - logical;
> -		else
> -			sum->logical +=3D logical - orig_logical;
> -	}
>  }
> =20
>  bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
> --=20
> 2.39.2
> =
