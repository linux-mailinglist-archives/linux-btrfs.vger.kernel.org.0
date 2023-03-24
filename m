Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B2B6C7794
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Mar 2023 07:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjCXGHf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Mar 2023 02:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjCXGHd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Mar 2023 02:07:33 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273E515540
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 23:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679638052; x=1711174052;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LeMndi2rHFQZlDLgkDM6StjEvHqHE/zL7xgxVibtfLE=;
  b=YtchUKgkyaYgD8CYPk4gLC7WK3y0W9Zi+Hqjh6CqNtZa8AB1cF/6nZoO
   LIcMbsdNyrucn7QlIPnPw3fj411hX3mrFHM1tfCZxs4wKOi/o+UL8EzCe
   ehYz5KcDV6jAWIkSl7+iQ1IZRIczMYtIca4MSQ5CdVRMBMpid09v13Jj2
   R43JbACMYJ+w+omDDrOGWrK0Dg1KNOzhrH9xYCAIbdVuk7E0m6R3l7GRF
   6NkJjI3vt+A0L6oFAWIxx22ll1BWBhZoocvwn+p8DmcunGsm+Dp7n5rs1
   8FxVYBodMFG8W2xcIiqp9/BPTWVzsjtB+d4XFZPfegY1Y3ZAbuIxQ/j+n
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,286,1673884800"; 
   d="scan'208";a="224682145"
Received: from mail-bn1nam02lp2046.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.46])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2023 14:07:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MW6v0PyNGygVl8NQGA/lMt4uy/wMZmGZ+7cBlkvDzOCOeXVzpNWw5Xuhqp2I1JvIEyjgbv/4rzHpxoiPSyGvzFRSIGeqy4TPe5LfMcN1SvzBBSkLxtIjPBMKMmbD/P/tRsKfJPXCJ36m1KBoNBiA5cquLIJsVaGj7XiEBLFCXjG/+XSNXc4R5/DaoJ0OH9LXl5U6jmv7Ae1aQZvv3RUgve/s92nkYS+TnAmR+iktDGdoFji36SEmb7cin63CMHLsLf5utD2d7Va0Wa8D0E/3s3cka+9v8BMUT3SYW6JnGs+DuFXX6liId/a/Zu/7aU2Lb6kMQB4u14XTihnss1c0lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8ejDi3UUgLdy/HuXjhxcYHcIvQTaIkoatIWO2sakyQ=;
 b=CvlgObWUXS2H2jQdfwXfw3gZK9zLTClGZsJgMdUYI7a+/PDk3XPdQaljQ0lQghJC34zMXljs1V42b/mxMjMPs0DlTzD8Pdu89bTDs2mvSfe+G6gzMsP/buvk/TF01U8C5QKl9hWekqWodZDmqiK71pCzmGu4dAraU0NkzUuDCQngC6aI6WYwv8N3ZrQXM1+LNr4ucburWTi0nIT/BkxJXh3lCV7zZ/425+IjDBP/nVD0kyakQI6EQovf6RZ7u7AAZ7NwoRmxzbo7XRJR5sWX6cBzWrkM/5V7263pENUwnqBDT6Wq7fE0bE3uTHKuBTA+WQmvFApuzJ2XtCFDiMxH9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8ejDi3UUgLdy/HuXjhxcYHcIvQTaIkoatIWO2sakyQ=;
 b=lF9ddiUUKhLW/CNUHFUg+mOraPgNc8p3oBN+K6k/smUxmgG48P6St5Agq3Ery5mEjS3Z0tTBBN1yhSswT0M2A0/9s0pEHX8VP3sg6D7z03bGivFP00GivRNbAwu4322Dpqe1JAn8ojOZF7lL4IkOE3Tq3tLmzntRGSH3WSsCRAk=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by PH0PR04MB8338.namprd04.prod.outlook.com (2603:10b6:510:d9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 06:07:26 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::2e44:805:e7e7:8544]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::2e44:805:e7e7:8544%9]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 06:07:26 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Boris Burkov <boris@bur.io>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 05/11] btrfs: simplify btrfs_extract_ordered_extent
Thread-Topic: [PATCH 05/11] btrfs: simplify btrfs_extract_ordered_extent
Thread-Index: AQHZXfjpCFtz/i4PkEOHy3+KhZFELK8Jcd2A
Date:   Fri, 24 Mar 2023 06:07:26 +0000
Message-ID: <20230324060725.q2jd6z2wzeytehzb@naota-xeon>
References: <20230324023207.544800-1-hch@lst.de>
 <20230324023207.544800-6-hch@lst.de>
In-Reply-To: <20230324023207.544800-6-hch@lst.de>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|PH0PR04MB8338:EE_
x-ms-office365-filtering-correlation-id: 3023aa18-eece-4307-d6de-08db2c2e0ab5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vqLR6MkjMe+YZGYc6PNiwr9UEEhspgULzRQmKXfolB0BcWNdWBTGKTErTIEM14TRszJcvE6oMFV0Baxj1Yarub4YOeJttwcuX6QAaR3azM5/KMK+inOjvENJUW+nPiOot6Dt8o34bCv29Tl5qY6zI2iQIwjXLV4U8Bnl3aaovF5kHyMJnMWB/Bcn5xdC5rMFUkpjsamlTV1/U3W4Zw0SK3qAppSOCVxOvitu8gz11FbE3yQT4p6CEv0qxa0Za+xk9Yf+wQiuBF7QFe1sLNQF5t42hvJDfUXqYhjMqxsf8wBH1LVEcwThrhMYl1gyzdgZnLwPBQLdxSPuN38wSTAo1nRcGLqhcFPtUz083OAy+K79IGvjlDtySNSlGTjDtjmbiqQgakQCySfsp94XZ6xfHXps43mPV/lIEeI8ghFPoSiFrZblLqhpmQ+BzfKqOTV1NnAsJdYrXPfTypKmR6v9MUX4J1Olx2WUIIn560KQZo07I8XlDqoNmlbgRbeKdjXV2fg993K2JeX9CQouGdIUl/P0QSjH7Y5LMqP6u2PSEXn2itZX36CUBCFGhE6DFK64H7H8MV82Rc4xBdTVRquy8ZN9ARadyeI1TRe677JzUCW+ChfFAogZ+YoM29Y88dEL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(136003)(376002)(39860400002)(396003)(346002)(366004)(451199018)(38100700002)(8936002)(76116006)(4326008)(6916009)(86362001)(8676002)(41300700001)(66476007)(66446008)(66946007)(66556008)(64756008)(91956017)(54906003)(71200400001)(478600001)(316002)(33716001)(6486002)(5660300002)(2906002)(82960400001)(26005)(6506007)(38070700005)(9686003)(6512007)(1076003)(122000001)(186003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6ndIO5kd9vPbWxT6SJSi0yZx1NdxQZwT5K2r/ROroITaXeFLBJBETQWDr3m/?=
 =?us-ascii?Q?4lQxqJ/uY6mC/HMxrQ081CczY1rnxd55gI3Mfhp/BKcsrZCCqk+Vp/go6RiQ?=
 =?us-ascii?Q?7HKDTyiA6VwzR+vkTJYOZeCWaGdhrjDh15Unl8feLr+2KXgfWjeIac8Tc9Bg?=
 =?us-ascii?Q?ZWmsObES+9QVFPvxskeH0wdFrxFMGw7WlOozB8ewbCjbkmf9DyzD+BF0h34Z?=
 =?us-ascii?Q?xsiqGYQO9ShHodn6gn7k3HW90M2VGag5BxFxj8dEyHDVcNBxkZigaXcaFt9/?=
 =?us-ascii?Q?jb28P2dtiMQUC7V8jaRv6fBtTfV73dNDW+jxn+ef2Waa8MAy//kBIXSqs4Kr?=
 =?us-ascii?Q?UIj3ezWxEGJfkzd5+FXmwqaOKdj/SWqlMBbODycUYNXAnEC/Qg1lP2OHedSM?=
 =?us-ascii?Q?l9s/N29smfV59F1HcH5Peb8hXEqEKB2MncrlJOHTqpFCVD5vtpsxCOAvBNX9?=
 =?us-ascii?Q?LXD6iJ5UWiVt+4yumypFnfKN176hVAL4qhSSmOaOjraECLNyF9WvqlmHomDQ?=
 =?us-ascii?Q?DSPOBAnWEYaBGH/3nD7+9gTFZBoGch9MAVag/e8Jsrhhux8lrJLq8e/khtER?=
 =?us-ascii?Q?NzZ5ygEIMihon/nYodLr4jrV8l0ebBxnBuWG+ROARMAOi+wl8stcaEd0kJPX?=
 =?us-ascii?Q?fWfzjEPZvr4cS4Q/lYQ8UTsXhvW/NcELKkEGE9GZfQ0Uu3zL1pCjtm+xaP4b?=
 =?us-ascii?Q?YNb9ytwMRJ9FUOZOb12NN88Q2eDHDVBz/1z1g2T1h5t/KIB+QdKIkR4UiKYd?=
 =?us-ascii?Q?oIXy2b/HQbp9pxS8vbdRfDuA6XnIGJpogPnY7EDNUnbz+PuZ8KzP59ZG/+3c?=
 =?us-ascii?Q?IPOahcOVcxtFVTbojTADvqn9dveE2zQNsWUccEXJO0HcV4hDuLtrSW0zcuLE?=
 =?us-ascii?Q?KS2pNrIvQ9VCBUHfZbTF5F6zThqWwYd5Ei3/MQosCkrz34UPXxrR5vqmCYSS?=
 =?us-ascii?Q?Z0x1OBTcCRJdouYKbiuOa9przhE2JVVbn0QAlQwM8XvKryDFfiEobJ6uY1Ni?=
 =?us-ascii?Q?kWPssgkdqPtIvFQJi0KFJTq0+TGlk/IlTlys7ecHJwnjOy/I5NUPtX2N8Gb0?=
 =?us-ascii?Q?2t675Hm4ggqZaXGHLk7wSBvycCwIaIkXnBN2RL4qungTdq4SQ1j05GRPExv6?=
 =?us-ascii?Q?CVz3xsY9rJfuJ3EcrTkYh3MS+C/UfkUsn6px676D894M4A9l0oRhAiryUSkZ?=
 =?us-ascii?Q?ht8hpJ6iePOrunfASYbM8lKPGvkwjkYRgppHO3cM1e9QLTf4o7zYLEvMhIC2?=
 =?us-ascii?Q?0Y336eO+ETR51CC7xKw7OTVbLsUN6ki4MHhaDKFGgj723oecXS6S+T5Xf+ae?=
 =?us-ascii?Q?b8e6ZWPDIyWZEXOUEOsjWYm5weqZ1crpLfA6i0ZRmbJaPcPx5KlnzoB+D5Yg?=
 =?us-ascii?Q?pViuMyM9reyJFU5dAz2Leo0sec5aZzQkgAx3xViHuHVjFZBfy+niRK4BsYFl?=
 =?us-ascii?Q?1kb/4MdVcy0bF67j6XmaxAU1w7GEQvkiSgFFQADcn7wPev4M8DtGVhlnZb/g?=
 =?us-ascii?Q?fmw4KcLHv2MVLVNjEkoaXJvQPAr10gCKOmzxJjGjhsjWJrazJpgHzy4PK3n5?=
 =?us-ascii?Q?j4qMIMoxDbRENUTqFCBhjLiCkcGE8KxDAJLo3V/TINcvcXlpkumc69R0Cs0G?=
 =?us-ascii?Q?Hw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <499BDF2599EBC1489F013F25A8EF2766@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6Kt8EvIAQkmxig4jusWtr7/QtnUgrpr6yzXFXXjQmX/6o4IpHYyj9vuunpKtC1lwVV64ETTGV840iQvBHBRCVh+LwPrR46wqyDHNQaBXGiVbzpEFf1QPO9e52CJOzs6yJIHSopjU3JXD+fdfavSbqxdl4s/KIzMsYvUbMHlxAx0v8AcrUUUN4/DK8hxzE5buKpVJ2+sNwwMMMnTavYbkAizo9y2LvLGjwlQKYyl+nEF37j5BCkLytZfwKvZx1ZMt9WcsLm8IPGS+F9gR8r1tsvjQKRfFYfFL74bvLgZZhr1TZkElmebdireaDQKMQ/gfov7UavyJOxxCnewkMV6rm5M7YrFzEUD6Kk6KNyph/Zhmx7b/6hgqIN6KGv/Ox3g9a/f52ypBVnL9jHoDRf5WipTrHEOHuGxREecmsOF66k89+bZvMe65/pAUhiwq31oNMaaVM+imk4iF99/prXWhNDDkb+ha3l5o1HehE9HKO90F+zsB+FZWkb2oexH07QJRz4YnlD2csbRRS0MipzmpN/4UBFIBuTXDzdEo2OIq2gQ0OkM++6SPslwoqXvcolyAcc2nWUl+rtngoWNHTgP8BOsuP2kSku80qpMStMI0tPqAS5yi695YPwC+nGva9j/O4yHd5hPCu0KGtK+8pYvddQKHnnFKtCMYwBZxTlkyusn6NWgRZxJYDCUqJAR/5dTonhSh7yTTfg26+B4+Alhu78kCYIub4yqNE9eFbkohDZYIYmIAwUzJdIz/jKbjWcBjTcdyFvjFMtpswZFtfMO6SqjDSjp3nWMkje0XX8qwpbRxxnsNeXigY0mo36D0WRSDqKgbwnM6NKoxPtCjVvWXSAK+GM84i8U7vav/EYctg0n/lNb3eV7lEHswYDHZoRHiOp8UPbUlGn6cwPW6Xik1aw==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3023aa18-eece-4307-d6de-08db2c2e0ab5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 06:07:26.2395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 90IlCKVEZ4tYgINiFI1TjUQdPKD6ukjNT18Q+E5/9P6bGX/Xa8MLI6Ypxc5HbpxFGcOEcY010C8kjK2N+9losA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8338
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 24, 2023 at 10:32:01AM +0800, Christoph Hellwig wrote:
> btrfs_extract_ordered_extent must always be called for the beginning of
> an ordered_extent.  Add an assert to check for that and simplify the
> calculation of the split ranges for btrfs_split_ordered_extent and
> split_zoned_em.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/btrfs/inode.c | 29 +++++++++++++----------------
>  1 file changed, 13 insertions(+), 16 deletions(-)
>=20
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 4f2f1aafd1720e..2cbc6c316effc1 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2632,39 +2632,36 @@ blk_status_t btrfs_extract_ordered_extent(struct =
btrfs_bio *bbio)
>  	u64 len =3D bbio->bio.bi_iter.bi_size;
>  	struct btrfs_inode *inode =3D bbio->inode;
>  	struct btrfs_ordered_extent *ordered;
> -	u64 file_len;
> -	u64 end =3D start + len;
> -	u64 ordered_end;
> -	u64 pre, post;
> +	u64 ordered_len;
>  	int ret =3D 0;
> =20
>  	ordered =3D btrfs_lookup_ordered_extent(inode, bbio->file_offset);
>  	if (WARN_ON_ONCE(!ordered))
>  		return BLK_STS_IOERR;
> +	ordered_len =3D ordered->num_bytes;
> =20
> -	/* No need to split */
> -	if (ordered->disk_num_bytes =3D=3D len)
> +	/* Must always be called for the beginning of an ordered extent. */
> +	if (WARN_ON_ONCE(start !=3D ordered->disk_bytenr)) {
> +		ret =3D -EINVAL;
>  		goto out;
> +	}
> =20
> -	ordered_end =3D ordered->disk_bytenr + ordered->disk_num_bytes;
> -	/* bio must be in one ordered extent */
> -	if (WARN_ON_ONCE(start < ordered->disk_bytenr || end > ordered_end)) {
> +	/* The bio must be entirely covered by the ordered extent */
> +	if (WARN_ON_ONCE(len > ordered_len)) {
>  		ret =3D -EINVAL;
>  		goto out;
>  	}
> =20
> -	file_len =3D ordered->num_bytes;
> -	pre =3D start - ordered->disk_bytenr;
> -	post =3D ordered_end - end;
> +	/* No need to split if the ordered extent covers the entire bio */
> +	if (ordered->disk_num_bytes =3D=3D len)
> +		goto out;

I thought this can go up to catch the non-split case early, but the above
check will be dropped in the following patch, so it's OK.

> -	ret =3D btrfs_split_ordered_extent(ordered, pre, post);
> +	ret =3D btrfs_split_ordered_extent(ordered, len, 0);

The next patch will overwrite this anyway, but the pre and post are the
length of new ordered extents which are not covered by the bio. So, giving
them (len, 0) breaks the semantics so that a new ordered extent is
allocated for the bio range. They should be (0, ordered_len - len).

>  	if (ret)
>  		goto out;
> -	ret =3D split_zoned_em(inode, bbio->file_offset, file_len, pre, post);
> -
> +	ret =3D split_zoned_em(inode, bbio->file_offset, ordered_len, len, 0);

Same here.

But, it is harmless unless a bisecting will fall into these commits.

>  out:
>  	btrfs_put_ordered_extent(ordered);
> -
>  	return errno_to_blk_status(ret);
>  }
> =20
> --=20
> 2.39.2
> =
