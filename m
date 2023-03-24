Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92E16C793A
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Mar 2023 08:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjCXHxA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Mar 2023 03:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjCXHw6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Mar 2023 03:52:58 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891521A8
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Mar 2023 00:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679644376; x=1711180376;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IXvywJ1OFRshmHfmoGxdpcFsQbhAvCOVcTUgWY94wSE=;
  b=FkdBr/DNnDL6RB2iI/YYqsxT15m87+lpN4vHMRA2FIOv/1q4edUU3xW9
   qRJBS8QNutEbbY9HM9g3VN6L/BfjeR+WZrvBa9ZoogFEy//hyPFxScw3f
   AJBul1gjqLljce4QGRDQO9DXCASDMH74rE9lU5DSZC789VeP5kiHt41f0
   StTXMXWZnuYa6Vs161Q2rnbGvDGDB0QOHiqYneQ9oWBZQ5QfKyj6nr5UG
   ifiOMqpJ8wLtB7EqgtHdKv+3wl0Z2VGbQKI3H7rHlMFIbXCjRofjDHUX7
   /QSD+QP5SQV+vvAZX7PstRWgkyJlpLxk8oHE/O09s57WpfvgnFr4Qgj1Z
   A==;
X-IronPort-AV: E=Sophos;i="5.98,287,1673884800"; 
   d="scan'208";a="226404947"
Received: from mail-mw2nam10lp2106.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.106])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2023 15:52:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3Xk9iOxuCus1mTOE3X5LR6AjGg2OgO1S1FdYWkylszm+eIJJdncrkj2BSJWzFylPLR1M4gJkuCEXImhPmtpUysCz3qKNGl7QHRSzh6D8ZDQ1qKwkblLZdciDfhxIkav6Ctutv14or7aIonL0B8xYlThwJIj1ejXQCXWNEqyhbvuP3eqVSWDGFM12Zi1H26p6PJ4LuE1lAmn0W1VwDnnDhuNfUP96ogKEP/nFdMXNugBJ/sQHUnTzi6rKRfC/8V2wQKEpj/ZmhgdVz5GYpGoxfyde3nivZu+AhFP709ggwLfnm69HsiSikvthMFlePzayV0NwQsqusqdQGwZESzxXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VIXRxiGtSn+4hz2bD8C//Q2SGJotk0XkMsQGAt0S9w=;
 b=Dst/4seFUkPzjHNXc10NuopraEogrP/Bc6RSab7D0dP1QZqdMfMaaVGooBG25E0ahJYV573jYwGLemv4M9/0tAnq5K74hb29DASC3mUSy5nHg/3h0oCzcZxNbX5Dbt2bnqrLdufv/zok17eJl06W4koRI9NwOhmzM9EksBrdRd3nC4eEQE8b2UILr3tv8HBcU632ltQKddMU4ppk/2AxN6V5PvBqCdDWDoBsOwSYUffaXJIm8mFau88Xqn7wBctYU5jI2//do/mM3uErfiHwnqQNgaxPvEAVCJC95SacFwFXm6XV9NuRneY75q+rl4RD6JF+MpE6ZhSg/dVzUg23eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VIXRxiGtSn+4hz2bD8C//Q2SGJotk0XkMsQGAt0S9w=;
 b=HWNxF0EdgkUynMvYW+JKSpQu0Kk+Y2HKIcSzVJ3e5KGypu+jAVypxUpmdhi5k7ehKmRIvAc5Sn54KgddvTBpeXaxPJaeDvokLmMTkhnWQ0GYJgUNuGbFJw/Itn4X+sPqxdkgj4VPDlMd47wElfBPXgedQF3DcQqUcGVFSZDeESY=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by MN2PR04MB6432.namprd04.prod.outlook.com (2603:10b6:208:1ad::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 07:52:49 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::2e44:805:e7e7:8544]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::2e44:805:e7e7:8544%9]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 07:52:49 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Boris Burkov <boris@bur.io>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 06/11] btrfs: simplify btrfs_split_ordered_extent
Thread-Topic: [PATCH 06/11] btrfs: simplify btrfs_split_ordered_extent
Thread-Index: AQHZXfjowpWrWKJZzk+o1GwNmfBLEq8Jj04A
Date:   Fri, 24 Mar 2023 07:52:49 +0000
Message-ID: <20230324075248.37cagxzdugxjovlp@naota-xeon>
References: <20230324023207.544800-1-hch@lst.de>
 <20230324023207.544800-7-hch@lst.de>
In-Reply-To: <20230324023207.544800-7-hch@lst.de>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|MN2PR04MB6432:EE_
x-ms-office365-filtering-correlation-id: a515f4a4-eae8-4ec6-35ee-08db2c3cc366
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6DpaiBNca6hCN9tH2WSerV1E9mFt9GSXuEOt9J76PlTJNQYpGhWwIRoUnbQbl9JkBI5iccKMwWzCI66roh6bMBQz0JxytQScKcxjDin86SQQFE0H4Q5i+0Pg5PVNrBtj4ptn9qLp0yIS+00KK6Pfq8xvV+3+OtEl2Jbey28SZG1tEb0+SFm3noQn/GZAknhsEsT2zS+TPPgMghTN0MDnGLD4iwmN0Q+HJsOd1TZ5Huh6kf6tGNMxeTOPWJyAdXuYTmqhSAeUXHolcMmY3U2cAEtvXeYRREA5ETU7vhmOsc5OUBPZ6RmWrAV6n0c8vlZ0m9WrJnbeCfEjh04TKJOLPzktlpRyqgzIQDj7WFVF55wHlJZTmJK/XJgDNDn7IX0Gzv7M3M0lfvKeZHfm4m7Kyi15qckic8IpqcvdyQQEwSikRFrneybKYVJTEWRT/2jQxuKE/j+utn8wMvQT7IrsmtjEdTy/tYDpn+zIjPjU8RpbRCbFGoR80lokCJRFNMzHBxq+Rcn5lrCSFAwdIhGdjPHtCHWs3FXwTPnlz90aJwMUKTqsGmT6dM2HnWeUTZOmkBXzr/R4/VawsOa/fPGRCcH3IelKG0y2CsPN9HvBHdI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(376002)(346002)(366004)(136003)(39860400002)(396003)(451199018)(38100700002)(38070700005)(2906002)(6916009)(83380400001)(478600001)(6486002)(186003)(9686003)(86362001)(71200400001)(33716001)(54906003)(91956017)(66556008)(66946007)(66446008)(66476007)(64756008)(8676002)(4326008)(76116006)(316002)(6512007)(8936002)(26005)(6506007)(1076003)(82960400001)(41300700001)(5660300002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AAi9hGlzkCuodDXsO/26QauUHytEduJMI7LiallTVq7CFUFDObSZHmvLL+Ee?=
 =?us-ascii?Q?M9BWl5dtBIIUR7soN8EvYONVXa6jzoUzS1OpcpTBaCeGCymac7urRuzvifbd?=
 =?us-ascii?Q?WCzcV+ars42f9KC3poKsV1ywUkJ/sLR+4bUxBq+uypW9/jHI4Zur7zyGwo1z?=
 =?us-ascii?Q?UvmtWcrlE9I7sgZESwUNBB82ycsECgmzI9JSoyTAiCk0oTE7NVYK7MLtCkSS?=
 =?us-ascii?Q?eeSuJIF5Q5mYpyJ/TRcoX38CZQV8MQw13lf18ruWDv5c+B1q9DVSjZYbX2lj?=
 =?us-ascii?Q?Jf2aLgfNIpsy/5urFmgTkHttdNdnDi+pellJrlPXT7yw/AJhUBi02RMLPMdQ?=
 =?us-ascii?Q?xEhEkSEPu/wwAvkYTgDmLoymS3iLGBBuHL36qsP6RU6cOSa8zuXKK2rlYPAX?=
 =?us-ascii?Q?JIJbYghqrCMwQZ3iFaPFvHkgn4u/iS0/pPEndlG1LXKbww4yj5gWBNGDCj26?=
 =?us-ascii?Q?3kivIa9tsu9Kj3cfP3lpn52BuflWOZzgGGtCVhHgv4retj4A698skrxd900E?=
 =?us-ascii?Q?EI/Zc1ZaoCYU7eBqoRU88d9Z7Day55lWGlEev+T13ATAZLGwCzajHi1TD4fo?=
 =?us-ascii?Q?WqcVaDCtcXEOzC9pPG3s69FJDNJHyndBXAVnFCGwKDaJv9mDVEp6WPiyhl2V?=
 =?us-ascii?Q?MVMHGRkI2shg9OEKTFGGr2n5gjM/qF/8HkUcEUNnCt9nZzdOQDcBFRRfbNsh?=
 =?us-ascii?Q?WuRQYa/lWMSrgOzMRohMn5aXWIqIwdbseH0Cs/+l6KZ7TBeSO5D20RGvYBKr?=
 =?us-ascii?Q?gfX6KtqjMm9+yhScQWzl9sZ/lObtnR38XX2P0S95OUFkpW1Fto4y+x+h8DZp?=
 =?us-ascii?Q?elecC6uQESn16Kki4cz+IiNOel7UVHsbTUHD30MQckik5lR3GrNgRaC8kl7T?=
 =?us-ascii?Q?HbcTvzC1PwP6zd80G8KOqEYQme0xwFjQQxSJPRQjXxRy/3KRyHdSZizo8hct?=
 =?us-ascii?Q?UOhMD7sCvBqtQkmDjC5cu/Z3U2sCvudAmHM2VQbFEY/WMeK99+wNdrVbpDZf?=
 =?us-ascii?Q?2mN+2M5LVhB5EKTDu28Kcgwm19MYlbSHYXHx/IsSPcuNwQ39jSdvl4nNz3FG?=
 =?us-ascii?Q?pFrNdnBTHFueOe61SZ/7m/b+upCHetokCPzZPH87Ee+oyabBeuVJ99Xb+sg7?=
 =?us-ascii?Q?AmEGdaSZB7xOKgsBlvWQveVoVN/Oh6bCXUTyX7y6t4vSJrKHmHA0lDCh+MfD?=
 =?us-ascii?Q?U/Q2B6Ve8VRTaIo10c8RUeEthSe2D45oW4lws9fciMzHyQdfo3nt9lUx6T+z?=
 =?us-ascii?Q?plQ1ipktjAEXkVmo7u+Q4xkCsuu+eWvi1dh+ElPU1J++y8VfyxR//XqpYgMN?=
 =?us-ascii?Q?qXIrVOl4DUydgksA2RKEeSBDgG0aCNGpBhYn2VA7WOO9mjF0WP6WP5JM9Euc?=
 =?us-ascii?Q?9m8Y83Ch6zk1FhiIxg5KhsdN+Xd5Q2uPGFSErFjxYF8dm0bg3sKnCr690Cxi?=
 =?us-ascii?Q?pgWG2JChX1EJRTH7t6FyDJzIKM/XLknv+9nFc8h9nFt/DsLgMFHQdPa47jl+?=
 =?us-ascii?Q?uSwFXoydU8MgkDRl4AdGO6gqPofh24Ewp98/IbFllJsj2/UqpOYa50xXCKDQ?=
 =?us-ascii?Q?a2mRj8KbQ+YtL67p6+WDa6l+/MfS8fot3KKzlrG8Mr9QF69IgMDH/TW6MkHr?=
 =?us-ascii?Q?uQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A5C577DA68C50D49B9820AC360ECBC04@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SKJrXmRH5HQNVwSYoGqpP4dxF3eK4WXTsdpubWzMf/CIOwCUzjyRTY0Uwv0r8jx4fjjIJdVtIRnHVVnvTRoLRV7lCHCZ76DInZ1gAoz+q6KOfCbOT8BqN4kMu8q0+bMLLkkf5VW2XYHPERns+MBwKdFQrt+QFnXmdjRnJB5io5Z6VVXugmLwxXZskmDQibRolKQbEXPM7X/vgRQb3hjfqb7FScRAR4VVY9ic4XyezZyOD9vgRqBTEg2h+ovj/UrOJMPwBRT/Q+5l+Qe4FGMH1Ov5jjFAJXF9jpfI7EEAuGU3sQP+hXZCVEMV5nhbaGQvSxIdd+YEIhN6yMb8qMIGyr4pKnwHrbCEYgKQ0+YNqiKdix06+YEhsga/4sFypNLYXDkgR4dJysgmdFzrI0r48DhHAG9b/VuerKXUbVNWQQJ88VrlygSRln/kS8AzoO8DZ9+m1Eqo6uE3vD7dUnmPfppH/kSX8H5TLBeDSmxW0x8dRTeQQ7RqUI+MX/5lVGJxXMNSnslKPrf5rtRgkRMTzdcPTAlxlozx2V8Ea8Q4L5h+98rpT+jnd/O2mV8gEwaCrQ2VIRgxS06/5b+ISNmcGGsHf1Lemqx9lJEwQp9rAk4f+Jtmyr+Q/crEdz876bQUiWOtE2v4sOi+QYedtzieBCmoZV05FIqWeaNEJ5n3Xa3qcp32U/fhAeMeDhG7HkSa7h14p40T0wwn2LMWPdUdpMqHMDVQPx3Wz6GuGvnjraC1qzbb384yhMfxPhyL/NhgyiXbeyAoHEEEp6PoMdpso6O82D2RsNPSmbdF5lkiiKGR18y3PNY6h66BWUydr1xGI6fgr6KwNBKnutinje74Pw632+hzJcBdI1g5xyurfcl06cf1+bis0iMp2+X7nKACaX+Uh77m/XVF8GbTQncskw==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a515f4a4-eae8-4ec6-35ee-08db2c3cc366
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 07:52:49.0816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3I1cdeykG2egaiPaWWWTetV3cGtbDp9Cl6wk4gSZsM9DASnSJHIU1Tf6B25Czwv1zrvomDErL7mQvzWJonKm8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6432
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 24, 2023 at 10:32:02AM +0800, Christoph Hellwig wrote:
> btrfs_split_ordered_extent is only ever asked to split out the beginning
> of an ordered_extent.  Change it to only take a len to split out, and
> switch it to allocate the new extent for the beginning, as that helps
> with callers that want to keep a pointer to the ordered_extent that
> it is stealing from.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/btrfs/inode.c        |  8 +-------
>  fs/btrfs/ordered-data.c | 28 ++++++++++++----------------
>  fs/btrfs/ordered-data.h |  3 +--
>  3 files changed, 14 insertions(+), 25 deletions(-)
>=20
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 2cbc6c316effc1..bff23bac85f2ef 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2646,17 +2646,11 @@ blk_status_t btrfs_extract_ordered_extent(struct =
btrfs_bio *bbio)
>  		goto out;
>  	}
> =20
> -	/* The bio must be entirely covered by the ordered extent */
> -	if (WARN_ON_ONCE(len > ordered_len)) {
> -		ret =3D -EINVAL;
> -		goto out;
> -	}
> -
>  	/* No need to split if the ordered extent covers the entire bio */
>  	if (ordered->disk_num_bytes =3D=3D len)
>  		goto out;
> =20
> -	ret =3D btrfs_split_ordered_extent(ordered, len, 0);
> +	ret =3D btrfs_split_ordered_extent(ordered, len);
>  	if (ret)
>  		goto out;
>  	ret =3D split_zoned_em(inode, bbio->file_offset, ordered_len, len, 0);
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index 4b46406c0c8af5..1d5971b6e68c66 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -1138,17 +1138,19 @@ static int clone_ordered_extent(struct btrfs_orde=
red_extent *ordered, u64 pos,
>  					ordered->compress_type);
>  }
> =20
> -int btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered, u64=
 pre,
> -				u64 post)
> +/* split out a new ordered extent for this first @len bytes of @ordered =
*/
> +int btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered, u64=
 len)
>  {
>  	struct inode *inode =3D ordered->inode;
>  	struct btrfs_ordered_inode_tree *tree =3D &BTRFS_I(inode)->ordered_tree=
;
> -	struct rb_node *node;
>  	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
> -	int ret =3D 0;
> +	struct rb_node *node;
> =20
>  	trace_btrfs_ordered_extent_split(BTRFS_I(inode), ordered);
> =20
> +	/* The bio must be entirely covered by the ordered extent */
> +	if (WARN_ON_ONCE(len > ordered->num_bytes))
> +		return -EINVAL;

Can we also reject "len =3D=3D ordered->num_bytes" case here? So, we will n=
ever
modify the ordered extent to have
ordered->{num_bytes,disk_num_bytes,bytes_left} =3D=3D 0.

Either way,

Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>

>  	/* We cannot split once end_bio'd ordered extent */
>  	if (WARN_ON_ONCE(ordered->bytes_left !=3D ordered->disk_num_bytes))
>  		return -EINVAL;
> @@ -1167,11 +1169,11 @@ int btrfs_split_ordered_extent(struct btrfs_order=
ed_extent *ordered, u64 pre,
>  	if (tree->last =3D=3D node)
>  		tree->last =3D NULL;
> =20
> -	ordered->file_offset +=3D pre;
> -	ordered->disk_bytenr +=3D pre;
> -	ordered->num_bytes -=3D (pre + post);
> -	ordered->disk_num_bytes -=3D (pre + post);
> -	ordered->bytes_left -=3D (pre + post);
> +	ordered->file_offset +=3D len;
> +	ordered->disk_bytenr +=3D len;
> +	ordered->num_bytes -=3D len;
> +	ordered->disk_num_bytes -=3D len;
> +	ordered->bytes_left -=3D len;
> =20
>  	/* Re-insert the node */
>  	node =3D tree_insert(&tree->tree, ordered->file_offset, &ordered->rb_no=
de);
> @@ -1182,13 +1184,7 @@ int btrfs_split_ordered_extent(struct btrfs_ordere=
d_extent *ordered, u64 pre,
> =20
>  	spin_unlock_irq(&tree->lock);
> =20
> -	if (pre)
> -		ret =3D clone_ordered_extent(ordered, 0, pre);
> -	if (ret =3D=3D 0 && post)
> -		ret =3D clone_ordered_extent(ordered, pre + ordered->disk_num_bytes,
> -					   post);
> -
> -	return ret;
> +	return clone_ordered_extent(ordered, 0, len);
>  }
> =20
>  int __init ordered_data_init(void)
> diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
> index 18007f9c00add8..f0f1138d23c331 100644
> --- a/fs/btrfs/ordered-data.h
> +++ b/fs/btrfs/ordered-data.h
> @@ -212,8 +212,7 @@ void btrfs_lock_and_flush_ordered_range(struct btrfs_=
inode *inode, u64 start,
>  					struct extent_state **cached_state);
>  bool btrfs_try_lock_ordered_range(struct btrfs_inode *inode, u64 start, =
u64 end,
>  				  struct extent_state **cached_state);
> -int btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered, u64=
 pre,
> -			       u64 post);
> +int btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered, u64=
 len);
>  int __init ordered_data_init(void);
>  void __cold ordered_data_exit(void);
> =20
> --=20
> 2.39.2
> =
