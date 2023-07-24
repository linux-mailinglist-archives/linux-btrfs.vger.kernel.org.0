Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C3F75E754
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 03:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjGXB1E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Jul 2023 21:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbjGXB0d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Jul 2023 21:26:33 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725DB4217;
        Sun, 23 Jul 2023 18:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690161860; x=1721697860;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Lw3TStxiyuLDAI2eLfZqoQ6hEIK00MqUBc8llOCkXCA=;
  b=UN10cqtjam+6Q1DQweWqO22lhQQoFoGyUiZbh6ETwUgjGMfyunuGAT+J
   liAKlz7qD5XlZ9iLwZG0yCS21S0cqQ8tiiuZfg+xpUdgXHP1qqm8oq8dr
   hB5Zcm6gFFreUQziwZUWGrLSrbvGlphU4NBfOPZPkl7VWK57swpznc3Sx
   wI1aYWKIoGKS+/Tedr4e3QrVqe0E9TAb0jlE0sW+jLRnvL5hxxksmpLOY
   qZw5V7AE3g3Al/5hCqYaiq97EcGOz/xcb5Zmz1YaBBfm52MNr+k+SgAUU
   TrZygqbr9y/of4ruzR8jqPTMzfmaqhjc3xf6GNg4jFVLOsRMfxCv4iz1h
   g==;
X-IronPort-AV: E=Sophos;i="6.01,228,1684771200"; 
   d="scan'208";a="350848321"
Received: from mail-bn7nam10lp2103.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.103])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jul 2023 09:23:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDPCNKcA38vPN6F0VTjUnSfxO+ZmxaFF1C/g42kmzARcNP1encEKmzSwJvImt/RXq6H8CrMEffh4j0XqQSSOHfnScRoyFpcU73+RsLGYXMmMNAPpqm6PbeCwx2T8R9lPDMfK0+9Ei0KAQ6aO0/y09ppLpHvBBsfjIMF6/BkceqtDZs/44FOtyY6K/wubJl6gmWLLxt5snJll4H6sgHhNXC7UwNdRuYR/cKMUh3xhUk7a/2J0u1ALX0p42shd+Td/YbI5ousVqqH6TezAz5sUk/ozoStoqpftGc/kSBqdYfethGe6iUFrGpjeFYEo24LpY9PxL/boXTiTg1Z1DYlN9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ycFfnIxL3hueUoWncxfh5O07gVW3UvVgg9pmjLkQC9E=;
 b=Hw5ZW/LkKnDvaydKTX/Rrf8XI/JOcJwC+jWvFxMreo/cCUvH96DBAQ0e1FZv8iwFhH2XcMQA1re4ludwSwyAy8fLOPl4tbo/oW400cp82ewV9K62T4A3IVUL+AyYru23SL5cb+h8ABa5vxNqMEgxFhD+DU2mqhGr2C6xmFDYkfMKJzrX8jfQrLFhdRocpKcxVVvoDIqiUs/rieMLmQ9Wn+rdrUvL62Su4NyIg6jQTGO9Op3Dmj3/TL661AzSQUc1XFR/9vlJL/FCo/DgoNqr5Tb8JedgMDAz2a48HJD3FqGwG9dlWIXRhCsdnL9A+VaxfghIDLLqRGlFu7t3iJSGPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycFfnIxL3hueUoWncxfh5O07gVW3UvVgg9pmjLkQC9E=;
 b=AK10hMxeIDnBAv/7JenRb7UEJ6K2NI+AeBO9i940eI0X+ZBDhqrPyQFzWX8XIvWDDm1p4dWd9QpSQn+gBfAtyWMGgwnMow34OavEOOe4b7jNbuvg2w9KNV+PlmEUkl4oHhsJCOdTMpnv0oKpsGxoarzzyn8L0oUFQAcl3TMfyfo=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by CYYPR04MB8839.namprd04.prod.outlook.com (2603:10b6:930:c5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 01:23:06 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::95cf:429a:bc0:991]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::95cf:429a:bc0:991%5]) with mapi id 15.20.6609.031; Mon, 24 Jul 2023
 01:23:06 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Qu Wenruo <wqu@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH] btrfs: add a test case to verify the write behavior of
 large RAID5 data chunks
Thread-Topic: [PATCH] btrfs: add a test case to verify the write behavior of
 large RAID5 data chunks
Thread-Index: AQHZpNath9pnA9SG1UCi+PCBJ/JRLa/IUR2A
Date:   Mon, 24 Jul 2023 01:23:06 +0000
Message-ID: <f7hsga77yx3zoh27yoji7yaziaw6dkgxnmdnaf44kowtfvqass@2fk3424qvnyu>
References: <20230622065438.86402-1-wqu@suse.com>
In-Reply-To: <20230622065438.86402-1-wqu@suse.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|CYYPR04MB8839:EE_
x-ms-office365-filtering-correlation-id: ee23027e-0e22-47b3-7fa6-08db8be48891
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sVp8750nB2wr01cQ0ZHqFHNVbJvAU2pd7c45Idrx3atX41V/9J1F/Zw5vmIY1WqgLrLxBwXa3uNBfxzrGxhcbfxQ5StXn+dsoqvN3nQWn0qbUsyI6IAuoLAOnGDuWT4fViVPwf8KJe2rI1rIFWK6ocgAcRzQKfr0Jy9XHIOiRPvJMFOB+hsimy9XCJ2Ex5FzTc0c/cuTK1xwZWdI951KmM1ikcWgzWXnbsMV3y0mBCjJRsxD1VIG3f3RyEOJVDUpKQYvsrpUEylyt4m5duxvPUVtx8LZZm4oBlUdEFPu/Fk0EkKGHzIAfwJC4mSoCUuGM6tojsbQwVgv+6g2rbkU/XK3DeJhe8QYGBfb9UeiS/EtkCcAI07fhwnaFJHqjCaM5pTN59irnDv/LLh6ESbs5/EJMbWpdLflxm3Tt+jfF9uE65ZBKAfIfBvf3pHf9VkFDzzlxFVSM86gRzdx/tVVBIc0VkjGxVy47Mxq4X/dBJbQSz2HnDEr02SD/cACaIzXRn+b3o7o8CY0WzhII58TGhynWywhU921NovgAxQ3mj1izCNKOBNCwQAp9iJChganPlxHQKEHhVA8E88F5UkhJQ3Hn8o1TrIvxtp8ybtdJuJ/RQVG9j/ziJJFsj9KGi3H
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199021)(91956017)(2906002)(64756008)(66946007)(76116006)(66446008)(66556008)(66476007)(4326008)(6916009)(6486002)(71200400001)(86362001)(6512007)(9686003)(54906003)(83380400001)(478600001)(186003)(82960400001)(122000001)(26005)(38070700005)(6506007)(38100700002)(33716001)(41300700001)(8936002)(8676002)(5660300002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pSpajOItmLCFqxTxCeOGnPQIgVr7qRVEUJN8e4wSvN9tY6SHsT3A9sDbdVF0?=
 =?us-ascii?Q?okhyOesCYZk/x0mf+osaslSjk2oMpvY7icjCq+e1UOQBScXUzuYhrJVZyqi9?=
 =?us-ascii?Q?nLk1KiKn2LYKmmn6HWrBZ7FdQNC5Zboof/AaV+PTRSsL9AYFw3nysP7BwfvM?=
 =?us-ascii?Q?Nh0Og++ZADMmVYbq117vNQGv+SRwFP3KMo/I4E23Z6bqdLQym7LDsYaoX0KT?=
 =?us-ascii?Q?F8cJZeUrbvsAP8i3VoNCYe9pzzOH8/PbhJzAsVMAjg/8ZL9j1qkADp5EbNxD?=
 =?us-ascii?Q?xM8nzLQyWJ5ku85xPSlXORIBP3QAToyL42vcKtVFhADIaDEH5yswnlRe3VgE?=
 =?us-ascii?Q?AHwVLW3+nKMGe7bPhK2GRUi4RAiAu6YCTmqQBZcCFAdh2UnrKTifUX4n3he6?=
 =?us-ascii?Q?f2YromTC+WetOqeC5HbgqEgTqYZLdRPgr5KZ76lIA4zx3eI428pE+FfuCy06?=
 =?us-ascii?Q?1tXZ7itu+Q2Q2nY86W0CCtAD52Kf+nEYheosQnXTPWspESJWB8SrGxK+l58I?=
 =?us-ascii?Q?ZoRFpFBlFsoRuFGP+SltlfX1m4HRA5jk29mEQy3tWCVfjITKzNc8AQSAqSLD?=
 =?us-ascii?Q?KPa/sxOSAIhGAqiyUVk1SN3qIjNBjHawVvAbsTOq55bOKqczmC35a4qsaZDZ?=
 =?us-ascii?Q?WVDhr6yC68JVz1su8nGLmGJKAsJGH0t8ClUL/gj9iZ0KO011D5+aqEXXfw9P?=
 =?us-ascii?Q?n3RayDSeYd8yVFIK1Inbq6wjGQXGqR5zYuUPAoPtkhlElroC3bjaJWRS/s50?=
 =?us-ascii?Q?299KzwKhUTgQISsWjmD508tnmo1s6hqLWmgskzFJfbHVNI0W09fE7AWyVv7t?=
 =?us-ascii?Q?lbLFVjUL8ycUzM3ituB93hFX6RQNU7HY3cmAu3wpfTPIh49qy5Mo5sDMaCrl?=
 =?us-ascii?Q?rybLnk/rUs4ELw2goRdHhMQjHiKj1bUQbDc7snSKUZqq5gtsO3kVvBiyBoQz?=
 =?us-ascii?Q?rL3VQsrLH0wg8q2xjMJpUmFB7Htw+2zzedlqrfWarmzakCh5SZxonvZ1iHua?=
 =?us-ascii?Q?jfOWWc7+ZofsrjLmXeENht02Z9mOnVy7PCpLyuD90tzofA9DifH4zCBMbdwH?=
 =?us-ascii?Q?6pU507Ajxjf/UGm6/pYaI+8HuSmKVtjf2Pxll7lhVCO4Nl6n3kXpnGYMj/V9?=
 =?us-ascii?Q?5R35vtxGhngZz8sFxd4Hsb8yaXuxkUqfWI6uHozkrvvXFetLxgB5ZxCF6ymB?=
 =?us-ascii?Q?4/QSwsJJobWlg4BzbFiHaGuP1zbIv3YvDLxFHKYZzFHQuRk7/iN2fpfZNZ5I?=
 =?us-ascii?Q?b6owmrYJ+BN2nNDMlkAxvNTaGlK548V5YcD0Rfii0/CvKJutqkTsIAs13qHq?=
 =?us-ascii?Q?F+p+xTvV3sK+qXoQAz85D5RG1/ja1izJRovauoIoprW0uBBWn3vKSLzlmuBM?=
 =?us-ascii?Q?4QkpISNwwb/cahCpasPZRyRnXBhNnSJgqrweobmt2kgV6m8YJCmaMpvcVjSP?=
 =?us-ascii?Q?YD3HIY1TsVWDuj/VbcTF86eQwel1Gqt0Huct91BjNKlCcYu1EFwSpCe4kqKy?=
 =?us-ascii?Q?1Nhz05ZHNdx79w3oa/Zz1jrDeQ8Vl6UcW164OeB8aFmdqR7NPAjA8OEZXaS/?=
 =?us-ascii?Q?Bl+3brKVq4s7MOehczz/hE1cWbD5AXBBMm+KPLyve7YatXn4bymD88ZCskQp?=
 =?us-ascii?Q?Ew=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0BF6B4A12F18EA48BCF2F3205496763A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EnhoDP6BHSS/0jfPyTbF02fyl3vqxOKOoIDlXJnp4tEAgQp9t9iZeQejTPLBy+ZZHCllTQIsrtIucb5XlaQ4Y4YwOaQWXOTpIkX9F6dqyE3eotUdu8tlUmcClEXMOOVruZatpppVY+0Zp2gw6GYp0E1ydXdYC/uhfsfVP5D2XN/EtJESg52+e6e413wD+EU+hmGW6CHBUr47JyaFIxB6Yv2dFWo8aMhgQxn/Ub7cXp86t21T+78oDaVMUI8eMlwTGP4yU/VgisbJjQev4lopNP4hAN62tNudnW/DXPrG2LwChpEUOMkbteq8DuctbIJbzX+EhBAVbNXvUeUlich0bPEhk3uGvcQF6sKMGaUx4MR/jUbzzvi0B3yoWUUAN3Fb4aODzOUipjcxNioms7jP1k9w0I/SzH4S4nPahafCSFRVwQqWq2ZrQ2WXa9seQJQyFaKY5fWDIhYED08361L3ScUSkij//1on4uDU8MX8YRQpE6agTYwJ0ethFuYKBFIqa4s2LVaLhBkcz8+/6XGSiAgq4QPYJQDMp3m2vfmGXDiLcgkTLf9XJZxTKyk9s0ZkSDBjnMofz9Xpj483C3/xZNyBz35W/8QQiMyZezLy01cUuqH215JmcuM5A3+EFrLSQsYerYepCp2dpxPfyZZ9Dw78v5lCNwmSHN6O/jREyNlDYyzuKcBUgxcVXulb6msHzj6raDuUf3p+Nf/6fEOZuvYfYAAknBkbrfalTUAXy12B41rrB24VK6WnWdSZVJ0qRXb39LaPV36WHodD0zTllEeMR1d6nbsd7UqTOLB4k7nZmbbSv0NWvUEJYJkGpdzI
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee23027e-0e22-47b3-7fa6-08db8be48891
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2023 01:23:06.2874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZnFuMaXWPfUu+M/VbpW/iSO+1ql/rR+75MsxkCk3hM0hy1tkaq/MnIUCk8arKn1lKUVZDvYesSQboDD4stQyJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR04MB8839
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 22, 2023 at 02:54:38PM +0800, Qu Wenruo wrote:
> There is a recent regression during v6.4 merge window, that a u32 left
> shift overflow can cause problems with large data chunks (over 4G)
> sized.
>=20
> This is especially nasty for RAID56, which can lead to ASSERT() during
> regular writes, or corrupt memory if CONFIG_BTRFS_ASSERT is not enabled.
>=20
> This is the regression test case for it.
>=20
> Unlike btrfs/292, btrfs doesn't support trim inside RAID56 chunks, thus
> the workflow is simplified:
>=20
> - Create a RAID5 or RAID6 data chunk during mkfs
>=20
> - Fill the fs with 5G data and sync
>   For unpatched kernel, the sync would crash the kernel.
>=20
> - Make sure everything is fine
>=20
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/293     | 72 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/293.out |  2 ++
>  2 files changed, 74 insertions(+)
>  create mode 100755 tests/btrfs/293
>  create mode 100644 tests/btrfs/293.out
>=20
> diff --git a/tests/btrfs/293 b/tests/btrfs/293
> new file mode 100755
> index 00000000..68312682
> --- /dev/null
> +++ b/tests/btrfs/293
> @@ -0,0 +1,72 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2023 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 293
> +#
> +# Test btrfs write behavior with large RAID56 chunks (size beyond 4G).
> +#
> +. ./common/preamble
> +_begin_fstest auto raid volume
> +
> +# Import common functions.
> +. ./common/filter
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_require_scratch_dev_pool 8

Could you add following lines?

# RAID5/6 not working on zoned mode.
_require_non_zoned_device "${SCRATCH_DEV}"

With that, looks good to me.

Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>

> +_fixed_by_kernel_commit a7299a18a179 \
> +	"btrfs: fix u32 overflows when left shifting @stripe_nr"
> +_fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"btrfs: use a dedicated helper to convert stripe_nr to offset"
> +
> +_scratch_dev_pool_get 8
> +
> +datasize=3D$((5 * 1024 * 1024 * 1024))
> +
> +
> +workload()
> +{
> +	local data_profile=3D$1
> +
> +	_scratch_pool_mkfs -m raid1 -d $data_profile >> $seqres.full 2>&1
> +	_scratch_mount
> +	$XFS_IO_PROG -f -c "pwrite -b 1m 0 $datasize" $SCRATCH_MNT/foobar > /de=
v/null
> +
> +	# Unpatched kernel would trigger an ASSERT() or crash at writeback.
> +	sync
> +
> +	echo "=3D=3D=3D With initial 5G data written ($data_profile) =3D=3D=3D"=
 >> $seqres.full
> +	$BTRFS_UTIL_PROG filesystem df $SCRATCH_MNT >> $seqres.full
> +	_scratch_unmount
> +
> +	# Make sure we haven't corrupted anything.
> +	$BTRFS_UTIL_PROG check --check-data-csum $SCRATCH_DEV >> $seqres.full 2=
>&1
> +	if [ $? -ne 0 ]; then
> +		_scratch_dev_pool_put
> +		_fail "data corruption detected after initial data filling"
> +	fi
> +}
> +
> +# Make sure each device has at least 2G.
> +# Btrfs has a limits on per-device stripe length of 1G.
> +# Double that so that we can ensure a RAID6 data chunk with 6G size.
> +for i in $SCRATCH_DEV_POOL; do
> +	devsize=3D$(blockdev --getsize64 "$i")
> +	if [ $devsize -lt $((2 * 1024 * 1024 * 1024)) ]; then
> +		_scratch_dev_pool_put
> +		_notrun "device $i is too small, need at least 2G"
> +	fi
> +done
> +
> +workload raid5
> +workload raid6
> +
> +_scratch_dev_pool_put
> +echo "Silence is golden"
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/293.out b/tests/btrfs/293.out
> new file mode 100644
> index 00000000..076fc056
> --- /dev/null
> +++ b/tests/btrfs/293.out
> @@ -0,0 +1,2 @@
> +QA output created by 293
> +Silence is golden
> --=20
> 2.39.0
> =
