Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888C57245A9
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jun 2023 16:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236116AbjFFOU6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jun 2023 10:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjFFOU4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jun 2023 10:20:56 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218D21A7
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Jun 2023 07:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1686061254; x=1717597254;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AC0FkH0lbrBDsFOP4OASSbi+xest2E2XZQ6LHh4mzLI=;
  b=QGLbbHYHHz3Wf1z+/S5BRJqzmzR1z0GbAptjMIo+wYPnxhH/+hjs6OSQ
   hgDdsAPiKxkRHNBjSFL2Upb9T5ZtaqfbEzY3ILvPtH9lVqNmydyCQbzKb
   fkKQchmi3GbmcVtidCHhjmh9Ss/Vc2cCNJVAV/MbLKXGn61xXlb2HoBJS
   FqhkwvfUNn+9+2ffehandpp30OirxQx4wuFyyx1EdbYyjRVyUjAGEmspM
   hHhCrPZKszfaZHfCmtsL5rAl3K9c1k79VXLx3AwsvdL+g7ATf3AzuLtj+
   2Y27bXDv4r7g8/otN+ayBenW4C7owSAuSGYB8rppXTdWR3LjM/73h933n
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,221,1681142400"; 
   d="scan'208";a="232755965"
Received: from mail-co1nam11lp2173.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.173])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jun 2023 22:20:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jVAzBeFSC5PAgyCduXbWzHttt9Bz6VN8sHkwMQ07L3RZogVYDnpsKhkRnpjRESW/yJkLCZRIP0JqyYaslypMyae45jvChxy4zjODAq11XjcM6V7a5qeE8nNEx3AbUflVg4iVTqAySrUzZb9yaL7/Jff425zRekK4eeG3H+PrhadKCyjjqSDO+L6L2tEAke6WR8LkMIsYTnTscr+Dqf/IeH1QbKGPF73b9JRKKGjLBdpUhkNw5xS38rUZ6HuJgYhK/58V/mC8OHp3BaxRS/fXlj1jMTyErw4jZoZMvo4rG1B1vMe24wieejXw5GYsyltTnNxaOrXc5D9rr61g7KN/6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVgKJfv4iBzA4adFeB5zAz0P+VDVkWsJjzk6uVd4KfI=;
 b=eymt2djrm/qZduMazhtmyaBPdKJiZI/Uwzw9uHRGObY6H/rw75SlMfZLZNDFSm/BLw8LpPE9smErGHYzCtXRPrfeE8EqkkXxDUm6iBidt1t8r7+uPdUq2aeImWUDiffQNX8ViEhfjiBAWznUM315RDP/9L4/de8mhncy5g+YJ/7SA7SdXJ9I6HN6UBHeusRDVq4WLJn0qmzyy/+sQcXIOAl6mDhMvUTqkIu1oGNRsS/neov52tIGPlCYCH+fS9ylaHCOaPolxogNPrtPu6AYydOiIEwTHE5RWyDSv0f1tcr+yMK42/2qHnmHGOzllUx6W1kky/mVIiBf3Coyvi07fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVgKJfv4iBzA4adFeB5zAz0P+VDVkWsJjzk6uVd4KfI=;
 b=dPMw1OoDS43UEEV3Wxo+PEOwX41y1HfmKROkak3Rt3KwYDF8/YYxTkyzIUEALfGbkFRD90anjLzvu0Oq4XEb2MSy9Vi0dpnHNp/cLx8kYYQeG29EvAZA1K7zL+r8e7KmjUjD4glrPAIvTKTA05uTRmz5ry/MWhYpEaIHbIv/Mns=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by DM6PR04MB6428.namprd04.prod.outlook.com (2603:10b6:5:1e1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 14:20:51 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::b52e:3dc8:52f:b0cd]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::b52e:3dc8:52f:b0cd%5]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 14:20:51 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 15/16] btrfs: refactor the zoned device handling in
 cow_file_range
Thread-Topic: [PATCH 15/16] btrfs: refactor the zoned device handling in
 cow_file_range
Thread-Index: AQHZk4X7jL6oN5vjm0erFWzc0Ccexa993SQA
Date:   Tue, 6 Jun 2023 14:20:50 +0000
Message-ID: <d4csqyddmdeg2rlzonfsdusggur2anpi3gepwyvjnihbrcnfws@yiiytibnjfb2>
References: <20230531060505.468704-1-hch@lst.de>
 <20230531060505.468704-16-hch@lst.de>
In-Reply-To: <20230531060505.468704-16-hch@lst.de>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|DM6PR04MB6428:EE_
x-ms-office365-filtering-correlation-id: 3dda4936-9f40-4749-ac33-08db66993b1c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ug21xFZapr1x3RXakl6w14c+7MBZo1OyWLEDm0JozsuJazkInhJnOTif4ReFNcEfHBJlyOSe/qevA/LBBtyyMpJhg5lm+W77Z5qq6p26grZCMXF8assPWqdHM/70zZ/PJ2kVbHqjge3umBL3nlH688K4Pd47y7dzdIbP256cn773NoAe24tDu1ilk+IG2OX5KVLLZofi1mW3F/q3TJ3LVru0pcoukmJopqmzMcN8d5kmfWtKUpZF4gZrdSMcPCBCnVppRzE2JBSQTozQXkUWlf4BjrjrIhz4ZvQUeTaXvuTAt7Poxe7h29LqZOb1hr7FdDDfsMS7p3uqWZSJkRXytIR1/5IdClMKe7MHUYTSDmoTdLDOnaF+w8dIGjZ8DzTQaVnIvQ8iBsnJT+PyN+ogtp/p/xpoRZbCDdchPghhzpPA6JyoXgbhgaKv49Omq9NpzgsTZzkekS/xRTjLNiYLDo1q380pq7NQeRoKQ62FyLPaYaJkg+b9FH5ssN4UNFhwacqlf9SpAOBV/ds2Gq/eoB1VCgB2sv2ipSp1EN/N33K049owAKwQXnf5lQvWaS92kVHduMQwm6KygcZGSUr8MF0ipbPYC3UTBJ3o7XHEKAlQ9YaE7gy8t5zY2qfT2dgF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(136003)(39860400002)(396003)(376002)(346002)(366004)(451199021)(54906003)(71200400001)(478600001)(6916009)(8936002)(8676002)(2906002)(38070700005)(33716001)(86362001)(5660300002)(66556008)(4326008)(64756008)(122000001)(66446008)(76116006)(66476007)(91956017)(316002)(66946007)(82960400001)(38100700002)(6506007)(41300700001)(6512007)(9686003)(26005)(83380400001)(186003)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NwKmA1q41MqU4fjfDSz0IPTZGwVkcdoY/LBssvku+hwkTRqyvPBdgsGscDzB?=
 =?us-ascii?Q?owOCIWpKs1B5s6CTjkttagZw04ZMMn01mndP61ZGk9nsDt9hm5HsbysrqfjP?=
 =?us-ascii?Q?BVbK+UIxP7CtVzuhaF2/FtyRXv2NknzZf7UR83B2nf+NeAMb9gSHC09MaXaz?=
 =?us-ascii?Q?h9dLCnXKb5s7En7RctGb7fMruE0AuBb6fSLUd9A7SW2VOLP1xMSq9nH2b0+0?=
 =?us-ascii?Q?HOLcdRQdNtgT41HWumkRW1Pz1TZo1P1xa6eiDHfhEKDQ69lcyzBFIAiJsjms?=
 =?us-ascii?Q?2/WQydz1kCBU2QSUUj/sZKXbio92ftRChkPSicFpXolu1qAzHcwH81MazWw4?=
 =?us-ascii?Q?ghfmR0WyLzmOQjYm20qkTfPOul5lsYn3I0/sXsy1Ry99QtqgJLU461KvohaF?=
 =?us-ascii?Q?dm7hJCw7HO34elmkXcKG5Js9q4L4QkFzFuA9kUy+a8EEUSnc++BHzMVhRyfT?=
 =?us-ascii?Q?uN2ydvY/P1Yy0TTYZSayFxYSbGwp0pSv1XHx9BPTcaPix4y4pvzaNMTlL2n7?=
 =?us-ascii?Q?vDHv8m30gv4Cg67O6PfKmZ53J+2nDbtFgzvEFWdpQt9o1o08514DYxBJhWI0?=
 =?us-ascii?Q?szhLmn1u2r6W9Lk65gZvZGcrxPogj6uP1QHQol2YEDuQSWwo0X01gTR0p0Ns?=
 =?us-ascii?Q?mYU0lsCxL4ssF3E0vx3DULiDlbBR0iKZpidLYlROVsr6Hn57Sl2SBNQDSPs1?=
 =?us-ascii?Q?U1mNd3M95i9pa4fzKRYIj0okFkwTQ8bHqtkW4kUj7wonZBz4GySbK6E+mG3h?=
 =?us-ascii?Q?1UMsuuIinVCZMrxVgbIi7YjN4xvsLJtabdRHFIpRjnedCKgHOdEvUgoSSDCb?=
 =?us-ascii?Q?6VPPXwQshzzpEd92sJRoED7lbBLFXnlESt5z8sK+2QGyJfWH/DWPOaWGdEv3?=
 =?us-ascii?Q?Gydiind8Mjepxh4MfF+W/qT8/XSiDgszq5TmtzTHqtu1xGCZbX0PstJ8z+Is?=
 =?us-ascii?Q?ApJizvgOlWraj9OBhzFVh3cyJDVnA3E/hxkiBrY/Qh2wbaSijuKBUk6xd7Fu?=
 =?us-ascii?Q?2crHJjfha83+d6E73Jsh+habo0O0+VpfECZ20J1si36UU5KbuA9sLLCd8szv?=
 =?us-ascii?Q?tw9xchdH1jKwr30jBFNsOUYx5ggWtJLBBLJnu9Fq49ki0rnP1CeOthZx6PL+?=
 =?us-ascii?Q?rxWXsThCjjRVaeiQjGW24bZ2HIKpqoNGMDQ0w5sRXt15mx9/IPXpDAaoRX/g?=
 =?us-ascii?Q?HKeCqWR+r9XPWVqvb1I1kNpEeO7Eh5QCuF1OFkdcUg2PWzYcoITn2u0AqN1L?=
 =?us-ascii?Q?fWbuH6nM/Kz1t8dgIK4YZIg7DA9fJ/k/m/ZqLeBFLhjizVIBoEWornqViCMd?=
 =?us-ascii?Q?yLmWfXKFnGLNkqKJOu5xJmxPYBRcCp17DFIDkjFALV5Df2tMqPkim91BIcov?=
 =?us-ascii?Q?j32ALZHcKy2r5BAn0t7vu6dR+6wKh+73I0PiJXuqwVONWin82XYqQBNMktAP?=
 =?us-ascii?Q?3LIfNVvTypYvt29MQUj4B4+VAQ0S6pmhu710bQCGMlX+1vSPnxA/WuA17jQi?=
 =?us-ascii?Q?TM7GB+jWgwc7DIWKOKhmFOmPTPx2NPtmdxbxd1fJ6rj98TdUGwdoKuezARGe?=
 =?us-ascii?Q?bxgZvajSKBBqOc4JRJD84b4pDq+wXoi82+5ACtWSbYxdgq3m6IE/x6IOBYDW?=
 =?us-ascii?Q?MQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F8DDE7A8DCF14E4BB4FC3257709A9FCC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lBj87qG8GsZ5tTQymaCQtDnxkDo7juYYbmXA25ZBdJem6gRd7G/2A9CfITc5i1cNCuxY5hMjFBmudG4J0Ng9T+po5zn5Ua7Xa9zNmmvkE79GnKTlZprG3PiywWhPR7qZuIuKsRJ3vaDMOO3BAByUTDkPFt7P8gd7UF1RBmswxwXlyFCPKHJ4i+8GDNNNKHdapBHssxl4hU1WoO7PvsLfc5p1khSpbjq4FF06vuZzZSHRX3rsu3/ot1bpKJ1+iqoQYFr5ENglTbsS2dJXujwBejGN+wa8iiu+TMFdf+w9v18qxJfr9sEkuJXDJnOwULC74OS37hSuCaMlSE/kI73xgn6l4L8wKYwIpvB/RKe7+gZ3RYWl0M9mVIDIiMgxeZas/yk6CcE33xf5xMSygJ9lzt6r2kXj913DAnoU/jNCUP/RPDvZQhVK6Ttj+IIet9r5aehZxF6KNZ/+wYeE1mAbsIEtUnoqfJc0AVHgJKy2xyQnQZQr+1MCP5KKELV4hPXxCat2evWJeiGdeNXqqC7FuIiXDk0pCJ5ANDBDXv+JdGTOPXMillgjnuzvIuECp3JyLLskac8dIOAyXmL+tkglN+lhY/DODhBY7zFc7nBuIlB/MGlNRIgmasQ1FGHe/0UFia86E9pV5VlPU+TFEN06uPajbVQALolFN3GKXnXIEgik3K7mwl32uFJDQJtAZ6Oi3DH5TAbjX0eSefsT7K9LIISyRPabG7jiFAxiNcxpUeAhZL3W8RkUZZDLyRK4yDcBrYDOq/Xe8cSB3HX7HkKfSBQzgXgluBSL2dTtmdqg0k6G53GBO6YWqyjYcaofsyP/va+XeDHuSWRkxsEj734WWZnfzkPSXog5illAXBRY9FJ8aEhB7aRChrdecfywa6Bg
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dda4936-9f40-4749-ac33-08db66993b1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 14:20:51.0231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2VHfuBMEBIaWH+cvDI/0EjqUx38dYA4OOUz2e8pTcfjQQrIGyadWyjLz62ZKUvAfLIiQg0gQnXmKc0tm6kRGaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6428
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 31, 2023 at 08:05:04AM +0200, Christoph Hellwig wrote:
> Handling of the done_offset to cow_file_range is a bit confusing, as
> it is not updated at all when the function succeeds, and the -EAGAIN
> status is used bother for the case where we need to wait for a zone
> finish and the one where the allocation was partially successful.
>=20
> Change the calling convention so that done_offset is always updated,
> and 0 is returned if some allocation was successful (partial allocation
> can still only happen for zoned devices), and -EAGAIN is only returned
> when the caller needs to wait for a zone finish.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/btrfs/inode.c | 53 ++++++++++++++++++++++++------------------------
>  1 file changed, 27 insertions(+), 26 deletions(-)
>=20
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 68ae20a3f785e3..a12d4f77859706 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1403,7 +1403,7 @@ static noinline int cow_file_range(struct btrfs_ino=
de *inode,
>  	unsigned clear_bits;
>  	unsigned long page_ops;
>  	bool extent_reserved =3D false;
> -	int ret =3D 0;
> +	int ret;
> =20
>  	if (btrfs_is_free_space_inode(inode)) {
>  		ret =3D -EINVAL;
> @@ -1462,7 +1462,7 @@ static noinline int cow_file_range(struct btrfs_ino=
de *inode,
>  			 * inline extent or a compressed extent.
>  			 */
>  			unlock_page(locked_page);
> -			goto out;
> +			goto done;
>  		} else if (ret < 0) {
>  			goto out_unlock;
>  		}
> @@ -1491,6 +1491,23 @@ static noinline int cow_file_range(struct btrfs_in=
ode *inode,
>  		ret =3D btrfs_reserve_extent(root, cur_alloc_size, cur_alloc_size,
>  					   min_alloc_size, 0, alloc_hint,
>  					   &ins, 1, 1);
> +		if (ret =3D=3D -EAGAIN) {

Yeah, moving this check here is reasonable. Currently, we check the return
value of cow_file_range_inline(), btrfs_reserve_extent(), and
btrfs_reloc_clone_csums(), but -EAGAIN is only meaningful for
btrfs_reserve_extent().

> +			/*
> +			 * For zoned devices, let the caller retry after writing
> +			 * out the already allocated regions or waiting for a
> +			 * zone to finish if no allocation was possible at all.
> +			 *
> +			 * Else convert to -ENOSPC since the caller cannot
> +			 * retry.
> +			 */
> +			if (btrfs_is_zoned(fs_info)) {
> +				if (start =3D=3D orig_start)
> +					return -EAGAIN;
> +				*done_offset =3D start - 1;

This will hit a null pointer dereference when it is called from
submit_uncompressed_range(). Well, that means we need to implement the
partial writing also in submit_uncompressed_range().

BTW, we also need to handle -EAGAIN from btrfs_reserve_extent() in
btrfs_new_extent_direct() as it currently returns -EAGAIN to the userland.

> +				return 0;
> +			}

Once the above issue is solved, we can just ASSERT(btrfs_is_zoned()) for
ret =3D=3D -EAGAIN case.

> +			ret =3D -ENOSPC;
> +		}
>  		if (ret < 0)
>  			goto out_unlock;
>  		cur_alloc_size =3D ins.offset;
> @@ -1571,8 +1588,10 @@ static noinline int cow_file_range(struct btrfs_in=
ode *inode,
>  		if (ret)
>  			goto out_unlock;
>  	}
> -out:
> -	return ret;
> +done:
> +	if (done_offset)
> +		*done_offset =3D end;
> +	return 0;
> =20
>  out_drop_extent_cache:
>  	btrfs_drop_extent_map_range(inode, start, start + ram_size - 1, false);
> @@ -1580,21 +1599,6 @@ static noinline int cow_file_range(struct btrfs_in=
ode *inode,
>  	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
>  	btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset, 1);
>  out_unlock:
> -	/*
> -	 * If done_offset is non-NULL and ret =3D=3D -EAGAIN, we expect the
> -	 * caller to write out the successfully allocated region and retry.
> -	 */
> -	if (done_offset && ret =3D=3D -EAGAIN) {
> -		if (orig_start < start)
> -			*done_offset =3D start - 1;
> -		else
> -			*done_offset =3D start;
> -		return ret;
> -	} else if (ret =3D=3D -EAGAIN) {
> -		/* Convert to -ENOSPC since the caller cannot retry. */
> -		ret =3D -ENOSPC;
> -	}
> -
>  	/*
>  	 * Now, we have three regions to clean up:
>  	 *
> @@ -1826,23 +1830,20 @@ static noinline int run_delalloc_zoned(struct btr=
fs_inode *inode,
>  	while (start <=3D end) {
>  		ret =3D cow_file_range(inode, locked_page, start, end, page_started,
>  				     nr_written, 0, &done_offset);
> -		if (ret && ret !=3D -EAGAIN)
> -			return ret;
> -
>  		if (*page_started) {
>  			ASSERT(ret =3D=3D 0);
>  			return 0;
>  		}
> +		if (ret =3D=3D -EAGAIN) {
> +			ASSERT(btrfs_is_zoned(inode->root->fs_info));

Is this necessary? run_delalloc_zoned() should be called only for zoned
mode anyway.

> =20
> -		if (ret =3D=3D 0)
> -			done_offset =3D end;
> -
> -		if (done_offset =3D=3D start) {
>  			wait_on_bit_io(&inode->root->fs_info->flags,
>  				       BTRFS_FS_NEED_ZONE_FINISH,
>  				       TASK_UNINTERRUPTIBLE);
>  			continue;
>  		}
> +		if (ret)
> +			return ret;
> =20
>  		extent_write_locked_range(&inode->vfs_inode, locked_page, start,
>  					  done_offset, wbc);
> --=20
> 2.39.2
> =
