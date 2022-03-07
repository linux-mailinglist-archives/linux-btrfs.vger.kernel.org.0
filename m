Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D0D4CEF35
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 02:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234623AbiCGBoJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 6 Mar 2022 20:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233543AbiCGBoI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Mar 2022 20:44:08 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F4B2DAA7;
        Sun,  6 Mar 2022 17:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646617394; x=1678153394;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vi0Z3pet8KL3E3j1fCRiLy7LBKBJuysF0GmNzmBp824=;
  b=K124JcIKe/VAqkl0w2VLIBCZgrpZ7UJVBJl2LAuFdKOiREeKlDR03wu7
   YZ+IJdQq8q2f+iHtrZWCTD+vHzPbGvTL9oGKPrKKZ/ZJvo4VRPqfMSuNQ
   xz07f4qJtIIDSbOyobEPnH3OyjeCIJ6V9L5NMXcV60Xq1R12q63HYK0VM
   Mfo5u5fNQcolnkjz4K2DgatVn2yPcopVx5oepGROX3ZcWmA0TBEwpx5yM
   mDnQrOEsfZXMOMaynN8vggoCh5icfs3rtgdreByNDA9q+0viafFfjU1bu
   Hlfou/Cx6FN1dNyzB6koyXxQLQUardUcw66hItQZEm6zw4ASZQ5RUTqoS
   A==;
X-IronPort-AV: E=Sophos;i="5.90,160,1643644800"; 
   d="scan'208";a="298755299"
Received: from mail-bn8nam12lp2171.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.171])
  by ob1.hgst.iphmx.com with ESMTP; 07 Mar 2022 09:43:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDlY5DoeO2v9s3fERO9+DvJLYFDKB+uVZFsN/XrB5LbKjUGMdfmb1bGxZPSik31LmmLEFPxMLF5celOdmPB4JbRYKj9zJ9Os5VdQbvk7ByqDq6lFMOLrGnfnc7GjddyHmuZI7cy8SUnxqNxl8rNZxtx048HT+Z32nwmnKKhBKAcU13T89UFExxmVU0NyQGd/Nf5ToZNpTGyL7AvDGnbK0b55iyBQEEUdU/p5UOOYkf+qm1++D/E4fBQFOIy0LOaqF84Fw9nHRIKFO46CqTF6KhsDcU0y1h366hhDB2hRgcdOKsIuxer2o6KiayubN4cufkqwmOuhhIIbNUfnpwSvUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vjpKHYrMfFr8q0FR3XxS/qwogCqCfgDgB0/eIn/vEkU=;
 b=e17z+MCReE5Ezj7muURxhz6dT7Qu3J+NQ6WUUYYZWsR6VIXdiy/rgBWBr5VgbQaEtpFrFPWRJwrzLw/VUB0dluL7kD3CQqjRgET9snc/QluE/zGDv/xnq5lLWXUd1XZCZI/dTWR8eQuM9xwg8kWp3L46ky6ymDdiH0x63VzrthGNy2AG2Yi7d1udRJ2GTtZe2dPwtVOevBW19dzJakG9GUKvTvksnZMzq4M1tEA1v9KEgi8PxEu14Vymf/9HrBThQb3rzwB8lD2TZqmhc+IgpURcYIKvoCaOsN3LsV2MOLo7bq+1sB4WMYDID/PmEwh4JyDPTKR3l3C9zyKklLbruw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjpKHYrMfFr8q0FR3XxS/qwogCqCfgDgB0/eIn/vEkU=;
 b=xRbvyd+wnKO/WNnl2/lmdhDz5idS8N9V7Mp/R5AEieegdqqXMF1NGCb6dRljH0cNfc4kGvHKNqs6iaYSFeKFhnAcA9PyLti11FgwlLzLuoLYnySPtP68iRq8/Dw5VZUJabOk5FQJOvU+N9dX0+OnmcM3jXKMBpGadN9GgPypbr8=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by CY1PR04MB2331.namprd04.prod.outlook.com (2a01:111:e400:c638::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 01:43:11 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::d179:1a80:af1d:e8ee]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::d179:1a80:af1d:e8ee%7]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 01:43:11 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH] common/rc: avoid mixed mode for zoned btrfs
Thread-Topic: [PATCH] common/rc: avoid mixed mode for zoned btrfs
Thread-Index: AQHYJ6NcJ4Pob8HROkWrmdRfsJRLrayzOiAA
Date:   Mon, 7 Mar 2022 01:43:11 +0000
Message-ID: <20220307014310.l4rmhlrydc73myvz@naota-xeon>
References: <20220222041908.3213724-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20220222041908.3213724-1-shinichiro.kawasaki@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f7a71be8-7aef-4a52-24d4-08d9ffdbd69e
x-ms-traffictypediagnostic: CY1PR04MB2331:EE_
x-microsoft-antispam-prvs: <CY1PR04MB233194E7854FA8DAC4EB1A1E8C089@CY1PR04MB2331.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5EfIwdno9PhLdsflxdu0sWyLpu7Do1f1eESZibNns1CG9FELjjJfNVawIIltYYOAnDMB+qHMIfEgKiVgHJdaBX19xr6S90SvCwK0bez6D20M/Mpl+18lQEturXSmMOOdgLlpZUDPSvr/TOhQg6ZkJHUDMVHtL0pVyfI++l89gmNOmlhNvYGZL/sQGbsS0IyJdpB2rpv3PXz+NOunRYDQY86VHLTPcsj0ivL66PRkBhEJItlAA9rpOFzPOwYTsJ8Y3gPKbcG4l0r2eucWUeT3LmEYp2qiHCMD/+v4bvNUi4OtJKVRNl1TnUUR8aySlIMRYrQFb5rXKpL486LISJRbpjzHB/L72VYwsNVt9ehZUZI5ggoU4gppS2zDaqsQGNF5URdn1rUw0inT6QiwvanNAD317sw9mtuyp8pL7mLe2HFia6i2OkyMz8K14/eTFNXkI2p3rkiye75XIjAzZuLvedLezu9lQ3Haoa0GzWiWNNnkCKFcN3fWdqDOEoEZfhgVN5fX7Ocb6o9XoB8hO5ud9g2jksHXRRy3oaFdPyzcfVWFdxG1+wH2i/CI4AXod1djduhqYVEUlU8N/mDQ4LpPuV26yIYfgYAW0weBSX/mpj8gG+k+8cmbfwPD7UkcF0WRp1jFYgTRnreidAx8jXePCQeOaV5SeurlgQ8v5yyhVhQXcW9E1b+m805xx8BNwIRN1HlZ4JpW4xdNBAddPKGBgZEkQd7sQZ/W3iPYYT5xIAJ4Iw7LxRIBmbFaLl4DbUF9KlzXXJ/bcANcMKuNJMcHJ2HlRfh0hlFbKSTA40H0VE4ZeB1Ru+CB3wUr8AE2Y+Yn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(5660300002)(4326008)(8676002)(66446008)(76116006)(66476007)(6862004)(6506007)(71200400001)(508600001)(450100002)(91956017)(966005)(33716001)(83380400001)(66946007)(64756008)(122000001)(6486002)(66556008)(38100700002)(316002)(38070700005)(8936002)(1076003)(54906003)(186003)(26005)(82960400001)(6512007)(9686003)(2906002)(86362001)(6636002)(17423001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6+iUEHWCA9uMsUGrvCoIfuWuZ0A3iVVuxU8y67JzR410ZqkE6/ZouvNlRSFU?=
 =?us-ascii?Q?QyR9gjAJm3+tuxl9+/j/x0PUGNzVnlZO+YokL1HaCjEu3ZiLtLfSlRxr0Ntr?=
 =?us-ascii?Q?9zGwfQPA3NIv8ZCdrsd/4cQ592TqYyE8QoaG8NfVxwytW0qM1cCHIiuUvTKZ?=
 =?us-ascii?Q?C4EAUQZxtAnbkwtEGN/TP63/wZhm14GDaY0S8Wrz2AG5610Sy/xnOrwxpcWZ?=
 =?us-ascii?Q?JYVjVKeMqU8K2biHDxCEp+5t+bc7iN36BKhv6Pvhl3QwpR8lYiUrcUYzGAdt?=
 =?us-ascii?Q?KW5Qs3oyJLfHDzKp+L19H1p5rhC4XWrD3+P/2QYxzaSjkyNXCbGQ7q8rZU1x?=
 =?us-ascii?Q?3MxNJJRvJFtriSJQb1NKzleZiXaYOfeCIj3nDEwQNsgCeR8K4wOT7D0GrNYr?=
 =?us-ascii?Q?Wzi7tdyejsQp78fsJC2D6a1vGlcO2Nx1v1YoI3xTtkZpxgxDcOyXpDPC967K?=
 =?us-ascii?Q?xCkQHl8TK2GHKQOfY+dY/P6Dy5nsYZEuPAKmIu1ZuBmr85XWmQZhFEm0KLrV?=
 =?us-ascii?Q?I0pUyawmG1F3VjlmUm9bPr83fEjjmSM8Pq6Y+z1kX3c5ZjfEXUg6iJC4lFa5?=
 =?us-ascii?Q?OuylefnJ7W6QSnyG0a11CcKXiSjdT8cd6iDt/DrxP9OMranZrihMrj/lzWvv?=
 =?us-ascii?Q?hv8C6pOdSuKWfdEmXuDV0rbYASco705Gm9adjB0U3kx6eGN3rvMdBVS2FkEm?=
 =?us-ascii?Q?zgCeklUTLOgP8v/nkBDTtTFHTwV5dfZruMomknAMObQg+tmjMKi3Ja/ijklX?=
 =?us-ascii?Q?EdedB9dNLrK6oCYyy/wpWjlljrb17g5eg9+CzB/EaoYFFUbBoh2bUjnHFQK7?=
 =?us-ascii?Q?t2Cru3jodx2ZIH7lScexaafzRSQBrMVJ0u4t6ii5RDYYuRVKDGXfvez4HTyD?=
 =?us-ascii?Q?2REwNAL04roZsHONKOa3u+imQzXaLOoEpZXV+PI319BV2vBGKAU+RNfW3X38?=
 =?us-ascii?Q?6VUWjHjrr4t2fg92IQqhx+LVIeE63I5xV+fCKCiVPBqUVeS70omwj+kXon3V?=
 =?us-ascii?Q?TDzrc9VqTk1k6kkTHrjDLVk6zYfZEZAKVCVYyWT8HwD68DXHueG5kgy5+Q1P?=
 =?us-ascii?Q?iNIRWQQH28q3ef5++apOAEtRiGWpKT7ay2RFZ13KhwGTJevLgdFc4c+CJmRR?=
 =?us-ascii?Q?SStqQWmlo0STnFerqoHJYDEBpgkFSH+Z7KdcXVb5BC2HYiYWk9EALLhbYB+S?=
 =?us-ascii?Q?M1z1HovDKqjjmYYx4nopSOplmexHT5BhYwLvK+mNWXzJ8oagSwhO0bCqxpoW?=
 =?us-ascii?Q?mkpaspgxkRgPLuAJ/OD1vLByOkmfGf3qNSwllp7Tl9TYdTS0W7VY8nkHph30?=
 =?us-ascii?Q?rxxJzOXIAsB85HWBk6puSNvtFGS3w7262SikMXdc1uj+UZt6xsa4YOQnpv8u?=
 =?us-ascii?Q?EgzsEfWw5TvDjXDqjWIUtVIruPAtS5lQIfI96/97U/810+VCLSNoYasYIIsA?=
 =?us-ascii?Q?lO5MDSVmf8OF3BoJTR+h8Y3fsn87M8kMKlGcq3jq2Rsb2nlvwajza0xXx89H?=
 =?us-ascii?Q?mWblsQBXYkyWm5cn7r0VwV42V1WwEwSAjU4P7JjDQeIXUM5C/yTIdHLvlHte?=
 =?us-ascii?Q?zxZpC4fVRzIZ4KE0FfUedN1qcdIx7tTjoqM+t/zfwOuzTvfrBY9nFamNI30j?=
 =?us-ascii?Q?Wd12v/dNAxEx1iMF1J/xcl8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <85FA32714C22F145AE9F2C8ADD6F3B0A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a71be8-7aef-4a52-24d4-08d9ffdbd69e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 01:43:11.1526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yh6IoKHPkDiOOHAvwp9xNFyZJwA1Vn+Vpi2FZ5qGNnBr6dMuMqgT3pYrocZvSZb/ViYJ1gidq16YUD/csRgP1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB2331
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good.

Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>

On Tue, Feb 22, 2022 at 01:19:08PM +0900, Shin'ichiro Kawasaki wrote:
> When the helper function _scratch_mkfs_sized is called with small
> filesystem size and FSTYP=3Dbtrfs, it calls mkfs.btrfs with --mixed optio=
n
> to enable mixed mode. However, mkfs.btrfs with --mixed option fails for
> zoned block devices since btrfs does not support mixed mode together
> with zoned mode. To avoid this failure, do not set --mixed option when
> the scratch device is a zoned block device.
>=20
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
> This is the left work of the series posted before [1]. Reposted as a sing=
le
> patch.
>=20
> Change from the previous post:
> * Keep change minimum btrfs device size as 256MiB.
>=20
> [1] https://lore.kernel.org/fstests/20220221110254.y2yb7xdlf22ahh7k@shind=
ev/
>=20
>  common/rc | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/common/rc b/common/rc
> index e2d3d72a..d326572f 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1078,10 +1078,10 @@ _scratch_mkfs_sized()
>  		;;
>  	btrfs)
>  		local mixed_opt=3D
> -		# minimum size that's needed without the mixed option.
> -		# Ref: btrfs-prog: btrfs_min_dev_size()
> -		# Non mixed mode is also the default option.
> -		(( fssize < $((256 * 1024 *1024)) )) && mixed_opt=3D'--mixed'
> +		# Mixed option is required when the filesystem size is small and
> +		# the device is not zoned. Ref: btrfs-progs: btrfs_min_dev_size()
> +		(( fssize < $((256 * 1024 * 1024)) )) &&
> +			! _scratch_btrfs_is_zoned && mixed_opt=3D'--mixed'
>  		$MKFS_BTRFS_PROG $MKFS_OPTIONS $mixed_opt -b $fssize $SCRATCH_DEV
>  		;;
>  	jfs)
> --=20
> 2.34.1
> =
