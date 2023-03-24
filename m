Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA62E6C7923
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Mar 2023 08:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjCXHmd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Mar 2023 03:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbjCXHmU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Mar 2023 03:42:20 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC7628EBD
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Mar 2023 00:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679643720; x=1711179720;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aCe5UPizHlF+PHZwUJ5XZi2e5HsvNSoNLDVoZT42+uo=;
  b=BwIunS3d4ouVUjibFSQHaihwziKhO2rMS7YtvZPCkxK/3ywqYZZgUaaU
   Dy5sy2HB5HM8aDrTAc7LUHmZX9MFT+A5w/Yv7/l2wnxeYRQJSlgq2keLF
   pxnm0vfSj3NXYIA4yma2mGkIro8dlqRPGGU5mO88wj/wDyHmZxXdMzxS1
   C3QY+PSD0pj6NPnZthZ8fq5YM+ScnJJfb7QXjHRzDagynxdd+1p6JWxo4
   uXde+GMj8qaWbtlkRICjgwu44k/FgSNFCEYXB0CCei/T5j8IVm7fPGdTQ
   7nHIVY0yfW6r2S9IOpsG9xNTTSKEPrfFSsnj4MdoJjPO6vkgq3Pw413vc
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,287,1673884800"; 
   d="scan'208";a="330828980"
Received: from mail-mw2nam10lp2103.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.103])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2023 15:41:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clci893vNM9eXPBb0Z4SWl4S5IniRP4yUFf2gpf2QSG1Nhpoi2t+U4kCGTdwWOh9vzJvv7yJLLjP1U5i2mieC9cVUzCW/5SCrA+A/WhrMHll7/6/4EthMtbV6VheFv9OhwXPxbPjMVim/QOCzhhYOWzQqSTGsGxqPn4sw7SRVFcmT5mGjL5c1AaXqpHEn9zyjuEDokRgKGFkN1mwnEFpwwd/pydFMHaO7z7o0yVVUw1Gb9Czv3EtsI43NjNG/EjfqkipbDqCGE5k0yHT1EgYRaocMbpMHWexQrIRO2sGzMbhsj7Tq9cumzS2+WKl5jKbR648x4VQ24MLjmJYe0UrTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iY3nRrF3+wP1KIErWuipHruIBRXN2vTSkm/JVw2YM+c=;
 b=IFZ+gGgdSO1oKyOYClIAXJwzcCwSp3ML+Tx5JivU6BZc+8o2OKX3guyQYyJLjWrJQcUP7arnem3Di+IDjLfv1GNuReuTAh77IfC+QErNjUh/IrPJhERZoabNMq+bDQXuqwE6Q+KQD93oyluFHu0SL09K16u6IODyrZsLxeT+t1rjZ0ZVM+osYfqLjBjdSUY7sIIGcuLJlqPxrzbwl7WuzbGoAydxYPVqGNmCIdQ7G8YRhBwCkuf+wh1wOloFkLcLVU05KUfPz8TJUA4IWayDmV/44+5Awx96NihN/VbyY1gvCdU5pMSKywj4zrafggRm0TwYEFU0LtZAoBJ2ev1ZFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iY3nRrF3+wP1KIErWuipHruIBRXN2vTSkm/JVw2YM+c=;
 b=KF1EKNOYdRTRbeA2fklVyHR3SInfMb8EOtco9fViT8x8UfEhzRdCgHhGaPJy4oMfqLJgDZm0+9TxEzGSywG0mnBpfSv1ABCqgyYmD1zjNjc7ayWtBAt9BgNgaC5QbzwHkbXtfBXbDEQrnW/4SDw9e1gZdk5IBpRAtuT21JYKrEg=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB7806.namprd04.prod.outlook.com (2603:10b6:a03:3bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 07:41:53 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::2e44:805:e7e7:8544]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::2e44:805:e7e7:8544%9]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 07:41:53 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Boris Burkov <boris@bur.io>, Christoph Hellwig <hch@lst.de>
CC:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 03/11] btrfs: stash ordered extent in dio_data during
 iomap dio
Thread-Topic: [PATCH 03/11] btrfs: stash ordered extent in dio_data during
 iomap dio
Thread-Index: AQHZXfjlzimKq8fUnEaQmW/DxWQUkK8JjD+A
Date:   Fri, 24 Mar 2023 07:41:53 +0000
Message-ID: <20230324074151.fzobcbgtoqw7me53@naota-xeon>
References: <20230324023207.544800-1-hch@lst.de>
 <20230324023207.544800-4-hch@lst.de>
In-Reply-To: <20230324023207.544800-4-hch@lst.de>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|SJ0PR04MB7806:EE_
x-ms-office365-filtering-correlation-id: 36a3bbbc-d161-4c02-1b7d-08db2c3b3c9a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XgzE1kdV732EBeXkEvUqguiTtVybacpuFhXvnytgLaBwS373HrhpRHHjW/WeEpC+BYXZSI6QOP2FIh79gZvV5MZTwzb8h3OIa7Nq453NIEymHtRIoTi+/u0Bm94jMOAJ1UPqfNtpCDftX8avp9RbKvcvhA3xBFeUfp/GLQ8Gi/OurwMk7b8OLeOx9PXq0F3yOtVH6yyX7DijuPQNUMVSF5jBxLyRFppVsStIWcczBpJMVQ3yoJjKuJ6MtKPN7pAqA+1/uf5zaQbXnKxHZVOHl8pBiBamQ4l1EJS+75ttK7qfZ89QsgQioNzBVLiMQZ5QG8EpGO+J6CYkvQExYeoj+8ilWCzElyY0NPGit04zXHim+n8yYio4Zm/EwPfwF7vX4kJ4k5UdHd0etL2VHgzjiqJgsySSt1joPPk8FZOSE2stUQITh57fNW5A3G1A7ovteNuQZWJghZRYR0ydICXMDeBLXGBo4EcTIaaX26JxNHmO4Tz97zpfHAgLOxr2ZFQAJaNCwnSa/VPeRMJnAya6NB7GR3Ei6RCP63gGC2C9tRhPACxGlxoeF6Og3TOv3W1Z0PsvgDwje8lFAnih7LEoWZG6JZDF25d53sSjhQ2+a4+KzV65PlggnW+7ywKmXzHi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199018)(86362001)(186003)(66476007)(8676002)(66556008)(4326008)(64756008)(66446008)(41300700001)(5660300002)(66946007)(8936002)(71200400001)(478600001)(54906003)(110136005)(91956017)(76116006)(316002)(2906002)(33716001)(82960400001)(122000001)(9686003)(38100700002)(6512007)(6506007)(1076003)(6486002)(26005)(38070700005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g15MMfxOsbvTt7A7/HsgfQ+bxP10wjhn8wWgKVLxVrz3JPuq4SBXAOs4B0lv?=
 =?us-ascii?Q?yOfTIpfvSDB4+Q0IPeHiaFpPTglluZJkVALSdCKY9UlXPYS4xFsR2sgQf7Vc?=
 =?us-ascii?Q?m9O18eYhLEaT38FtWONyq3J4+lROPk9GGUW+PO5WSj/mVoo3GTgJzxUjbjFV?=
 =?us-ascii?Q?wvHlRKT35h2LROrn0COVBad58j0zeKSZMfB59/pttT0q3E/0+xfEKtWyMAef?=
 =?us-ascii?Q?/2Qtt2igYo6+AtEQHFa+ZfQLHYqWFnfZYuR3pemacIsZ0xttNR6istmw/m7B?=
 =?us-ascii?Q?rZ34OQAXtE/aMNsw/BcsQCy118k5XN+YKHIElZaaFkfLiOU3v661RBmbpOOI?=
 =?us-ascii?Q?oRvw8VT4HcI2tSAVjjA9tAfKYwM9LJxVBFztyVGXSlMgjpmyXC2bpHh743XQ?=
 =?us-ascii?Q?wwiRQ+bw00PMF594bCFXI6tBS7ACBjx5btiOq+qZ5/bJXAC9y24Z3Oj1QloY?=
 =?us-ascii?Q?LPZ4zsyUPEIAI3fv84Xu42pkD41MpnDpcYRjN07NHz4oZgBYG/zDBvfnRoIK?=
 =?us-ascii?Q?NllSekoVColz2U1vrPZ1HuHF9QfcC9vPEpMAEjsbxrBwlsLw1v/zHlIeY1v0?=
 =?us-ascii?Q?pAOfynrla9LX8cIzjSC+3sKnRCsYaIBolsr013VGLoja5N6bV+JHgH82fD/u?=
 =?us-ascii?Q?KXN8rABEsttP8ynirgUaQg4+T4Bti4MFjxQIlCl+Np7O9woswSdTT+BkX/ZO?=
 =?us-ascii?Q?wj/TTeHe9GGvOfXOeg1e5UFv+C0eHqHZL7dbA/7slzTESSpD/wwTfnzgepl1?=
 =?us-ascii?Q?MSeO32WOsfTY6dEtS9OjznO14l6dj1JtDH2px4vpS2Df3x1+D0CL7cz+H45n?=
 =?us-ascii?Q?9YImzETMPYQmKeij3HqovoBqYImrT1zY86C8j50M343+MPYSHSV8x2UxrBft?=
 =?us-ascii?Q?GIhHzFZCuxRZ2XQrYdSzXRzlJ0JkHKBp7p2QK7m77rBbec6NF2f/ooPEnBUQ?=
 =?us-ascii?Q?ghiDcC3qmd29CAHcdsTKPK2/wv2KOgCx9Br6s8zrh501sgFkpzcchItRQ+rD?=
 =?us-ascii?Q?sqFJrwu+9fQFxm8H0l17rW6nKjfV8tNFZAai8G6S+nlx6NKqAroQpsPx58R3?=
 =?us-ascii?Q?zg8+83WthjVkAMhJGiewIlf5D+K+BLOc/8UkujsOgZgdS51i0GjMQr4h5nCD?=
 =?us-ascii?Q?RBQ8oKp2Qneo4jyiEj1Tnq1+E+BAz0JsBg2y27Wq5rAQvtpskCJfeLw/m+Dn?=
 =?us-ascii?Q?k+/+2642hdQ3gm0tCk/PuGBHTnDW8jLRUsUofFn5wQ7Gcasd7FIblFkBbGDW?=
 =?us-ascii?Q?IZ0f6gj7H53MNLyW9tQp6HBTBW/fSAhbBxQ3seU9EB7S8ksqtFB4ImmAvRYw?=
 =?us-ascii?Q?YzCNUcio3Yl0+TUen7C7h6pUysc8RjPOaahfoQ6nWXXSrnhI8hqZJckJ1Uyd?=
 =?us-ascii?Q?euoFyajU6/40dF40E7g24ErBpMcsSIrO3LEBKipFQM7tx9BEV/+FWsBk9oq9?=
 =?us-ascii?Q?kj25Quu4+oOmfaBNqCg2CPputFpk0jvcYtPm363ZcrxdFtJbnEa/mUhQTipR?=
 =?us-ascii?Q?TRuRUlkwtehFMQaL2DDLj81pgkjbNsrai+0zahMu7mdIha6n8H7jU0uW0fIF?=
 =?us-ascii?Q?RXJRrF349ukLMKukImZasyvblXpYSiOIyuKnwe3Hbr++pKiEtcEDXGS34iIE?=
 =?us-ascii?Q?/w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6453E8EACAA85B44A05653C6AF6FB1D1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WBfP3UD1LNHR8AIi+/DN9yTyRSE8oRfm+OndR5c9JUCdP9CykyFHxDo4VkG0e7jvEfWbkVoUJU0t47wQQr3D1ZeXqukubzUNqqteO5RjLSnJOYKAS+ql8iU7HRC8OcIVowRjL3Bx+N31OVcdsTlydv8pprzEmcmPp9hTOmdyoJpDri4X6QT6rMsblFOhYNOzbk8goZ3MMfLtUwAO73YMf41UEFqvVA+Y8BbFHHy2+fC0/IkVvJ98emMeNgVvR5yUNozqP2owB5SlWes2C5FXCBzVmhQbFFoueUM5kutHLJ8MoW0GUA7/q70UnkwQ7aXZ6L/Ij9dkgYk6VeM8iywWjmC6WC+ZeIL00a0EorSYGKrAAJ1vv8R81PW7cGklhy9btUW5zmWEC4uaaS83V7+32q8xI3W2lO/koFkOlL25goe17Aae2aY5hAP0qgUl+lRU2c0ARhIpkvxYtB94kDnF5KhUeZkxn9Nw0IIr+0ebcGKiVCsZftwUmNN0NtwvDRiGlX66w0AeM1n8Y7dy9wv82QWVBEj0Npprsxt3J7zesAUDSSmoa4YNFywxp06KWK6SpVkkMzbzE3y5zPFysVdJ6T2jUDowMQ2PaPNbIG/ZIz+oAlxOI2rBq/h7HHPXqN7xqfch9WnFTMhSRUXKzPIh/0j3QCtxKaGVbYOp2jTOkGedAGKynx4P3G4wx2bX4xoUMV7mUwcPWFb/fMtd09WPFgiJ0qAQ/Z1ijUChuwy4JY1Kjw0pg+AEadoNps5yEfF6c3sljTnvllsMIxgeCbdsrt7dSlW6Ki4bTghXN/fqXaaxVen0ljkmkfCERi5RQ+bHbawUN+XM0KXkZqbGmSmvtsr38XCpPTAyVGpuxToPJCccyV3FYk6wCSTjHGjRb4/yrvbvVWvdhKnl14BQPg0/6w==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a3bbbc-d161-4c02-1b7d-08db2c3b3c9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 07:41:53.3857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jhqy2IYRJwGH/498CgEIt75TbLdUUQzMjwYlMqCCcdCrp6Q7nPWRAHvefHQZV5SrOS/mZ/ugutSKeLiX8EPwKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7806
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 24, 2023 at 10:31:59AM +0800, Christoph Hellwig wrote:
> From: Boris Burkov <boris@bur.io>
>=20
> While it is not feasible for an ordered extent to survive across the
> calls btrfs_direct_write makes into __iomap_dio_rw, it is still helpful
> to stash it on the dio_data in between creating it in iomap_begin and
> finishing it in either end_io or iomap_end.
>=20
> The specific use I have in mind is that we can check if a partcular bio
> is partial in submit_io without unconditionally looking up the ordered
> extent. This is a preparatory patch for a later patch which does just
> that.
>=20
> Signed-off-by: Boris Burkov <boris@bur.io>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/btrfs/inode.c | 37 ++++++++++++++++++++++++-------------
>  1 file changed, 24 insertions(+), 13 deletions(-)
>=20
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 865d56ff2ce150..a92f482e898950 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -81,6 +81,7 @@ struct btrfs_dio_data {
>  	struct extent_changeset *data_reserved;
>  	bool data_space_reserved;
>  	bool nocow_done;
> +	struct btrfs_ordered_extent *ordered;
>  };
> =20
>  struct btrfs_dio_private {
> @@ -6965,6 +6966,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_in=
ode *inode,
>  }
> =20
>  static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *in=
ode,
> +						  struct btrfs_dio_data *dio_data,
>  						  const u64 start,
>  						  const u64 len,
>  						  const u64 orig_start,
> @@ -6975,7 +6977,7 @@ static struct extent_map *btrfs_create_dio_extent(s=
truct btrfs_inode *inode,
>  						  const int type)
>  {
>  	struct extent_map *em =3D NULL;
> -	int ret;
> +	struct btrfs_ordered_extent *ordered;
> =20
>  	if (type !=3D BTRFS_ORDERED_NOCOW) {
>  		em =3D create_io_em(inode, start, len, orig_start, block_start,
> @@ -6985,18 +6987,21 @@ static struct extent_map *btrfs_create_dio_extent=
(struct btrfs_inode *inode,
>  		if (IS_ERR(em))
>  			goto out;
>  	}
> -	ret =3D btrfs_add_ordered_extent(inode, start, len, len, block_start,
> -				       block_len, 0,
> -				       (1 << type) |
> -				       (1 << BTRFS_ORDERED_DIRECT),
> -				       BTRFS_COMPRESS_NONE);
> -	if (ret) {
> +	ordered =3D btrfs_alloc_ordered_extent(inode, start, len, len,
> +					     block_start, block_len, 0,
> +					     (1 << type) |
> +					     (1 << BTRFS_ORDERED_DIRECT),
> +					     BTRFS_COMPRESS_NONE);
> +	if (IS_ERR(ordered)) {
>  		if (em) {
>  			free_extent_map(em);
>  			btrfs_drop_extent_map_range(inode, start,
>  						    start + len - 1, false);
>  		}
> -		em =3D ERR_PTR(ret);
> +		em =3D ERR_PTR(PTR_ERR(ordered));

We can use "em =3D ERR_CAST(ordered);" here ?

> +	} else {
> +		ASSERT(!dio_data->ordered);
> +		dio_data->ordered =3D ordered;
>  	}
>   out:
> =20

Other than that,

Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>=
