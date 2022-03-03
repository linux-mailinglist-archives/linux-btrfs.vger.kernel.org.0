Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB2B4CB423
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Mar 2022 02:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiCCAwd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Mar 2022 19:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiCCAwd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Mar 2022 19:52:33 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC97EBF97F;
        Wed,  2 Mar 2022 16:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646268708; x=1677804708;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DG8uI+vtP+knuVw51EdFOwONXTS1M5s+B9g0/r+vTf0=;
  b=Jc42dxtJFQY6GXswgWLxi9ripxiogsKvd45bn0Le/9HBcHcOgls3uRGa
   ZSGc7wMmKOV5+KHMRzUXVO1LtOFSsPktEh3RGt53L7bv/E+zF1xmthKSW
   2nmHn+Z4PdeKTAICRDygpefI5DgyNBgzG4jupIElBOn3kIA/4QYBzX+JG
   ai8zQuOjYCHPiSz5/qb5UyOmCzneCIGcsMBJU4p3EbVoCN0N56DU6Rg9W
   CGTsHIPQmgwwFPXNCY+ReaUQ5iQK62AoalU3eo5u06Hp8YGjm68MTduy7
   uZEAvVM89JwNG6a/EIYKykGIzgaQgrBiT1lROwUaPKBpP7vNl+4tUxkMt
   g==;
X-IronPort-AV: E=Sophos;i="5.90,150,1643644800"; 
   d="scan'208";a="306238895"
Received: from mail-bn8nam08lp2043.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.43])
  by ob1.hgst.iphmx.com with ESMTP; 03 Mar 2022 08:51:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jq27354ztoXDsBvln+g+iGzvYA5UtOnRYXo7bRid5Glns7dd/bZZW3gAgu3bexLjuvDmEOq835jOtFXAViUSYV3/dhmU+30X/YCc9n0HhzXZyaMQamOOMArw2wCX4vXTfmZOl3xV1goF96+G6//9bzrJOXdTocK1i9LBjVWgf4GiE27sL4gBKoXWSdIKucCdXtMqXyY3WpxJR09YBLzqihjzObJ+CxQh/tYxgaD7gzNrlmg+PeEX5wfppKyuLaSWGF5gzR0jy4MMux+vhO+AD46Iw80zS7lMBlQXUMFcQhr/6Q26j3q2b7kW/RwjHpmpLd04S7u64OB32tjjpbSQUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQ7atsSzIcLJKooyaRYkYXQsbNwZFKyxeLmb1gs/hLI=;
 b=M5MndOGxXgSGzhOBxpQaYNMGYF8E1cfNZm6dtEY5/OmPwOqJDTkeTtC3wCGaVRBSfOaFtC5Fy+M51bR93/1TkPHGpNdOpdxFs0aH8Qi7YdatdoOUZwAnh0+4zkWBDB1ppv7eDi4JqFW+z5rbpaWpT2zQ/P5r1e2biewmkMgIsdyZt65KVQPmdEd4ZRDm3GyCCAnqDzpjvfaXEbI0GHmyRqvYNXpSZPF2Wj/syFqqQ37N/KPLdwhJntcuo+uDh2ETyLxVRaWqmiQr4C/QKctUdWAH+wmpwKA8ZA0tVl9oZmNaLtsW4NsGZfdll7NWekptdibzX7LUd2jLwEzy9Jievw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQ7atsSzIcLJKooyaRYkYXQsbNwZFKyxeLmb1gs/hLI=;
 b=Rm2Vw0Ctwu3VwgdKQknLTOJ/kJgCxdZP40UNwv5wjRIiEaeZWD5tyQTaElGlhrhSJD8ywqTp1o9HH6gEz6asi7kJ6XOMrV1RLuRJ2ISmEx1xFI3CMZ8iwU/B6m5jBYBFTJ5OeFXqaI3vIhmSUKd48apgGbvjVWlS6k9Pp3F67sc=
Received: from BN0PR04MB8048.namprd04.prod.outlook.com (2603:10b6:408:15f::17)
 by CH2PR04MB6728.namprd04.prod.outlook.com (2603:10b6:610:91::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Thu, 3 Mar
 2022 00:51:46 +0000
Received: from BN0PR04MB8048.namprd04.prod.outlook.com
 ([fe80::4db7:e845:4326:2c3d]) by BN0PR04MB8048.namprd04.prod.outlook.com
 ([fe80::4db7:e845:4326:2c3d%5]) with mapi id 15.20.5038.014; Thu, 3 Mar 2022
 00:51:45 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Sidong Yang <realwakka@gmail.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        Filipe Manana <fdmanana@kernel.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>
Subject: Re: [PATCH v2] btrfs: add test for enable/disable quota and
 create/destroy qgroup repeatedly
Thread-Topic: [PATCH v2] btrfs: add test for enable/disable quota and
 create/destroy qgroup repeatedly
Thread-Index: AQHYLj60r6UXXZGKpE6cO1VqgIZ5uKys1TcA
Date:   Thu, 3 Mar 2022 00:51:45 +0000
Message-ID: <20220303005144.txquz2gvoyxlhlqv@shindev>
References: <20220302140548.1150-1-realwakka@gmail.com>
In-Reply-To: <20220302140548.1150-1-realwakka@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 794ef342-b38a-46e5-af20-08d9fcaffdbd
x-ms-traffictypediagnostic: CH2PR04MB6728:EE_
x-microsoft-antispam-prvs: <CH2PR04MB6728CD9936A96D45EC4BEF79ED049@CH2PR04MB6728.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9UA5lET0BmKOGPlWiAxCTM4+uc5wMikqB7J/3Nu5L8WVfBdfLsQS6VtETc53pFlVmgiogcl/OiZrAYoiY8GdD6/MzNIk6xtGoM1sadBEo13VCVECsFXqrPgBe1fda1vodom8olo+ot652g6s9zuODmYERq2HGsJhXo/vw9pFoFuftOcYI+hvIa8e+OXCl6pQe8lHpeK8YXmq0loXWeP4Yaz3aFJfycRUo6oik9hzueSA854LnRDpnfzS+QDAwiZ+68ju7q6jCgvo/PXTw3X9lXrik4gJlGEJkXeRMAH+R2sVFWkuaYiDniHIJWxG1LcxgDdn9R2Zp6ziBldOh1I+yKMg5jcJKnFOEqIsdPo9hNDYCc1dkMpog/+9Ps+6QrXN0wwOmGPIzgHEpzHrCUWSbejAAujejkrsHOZzKpEZxhCnlQKxtF+YKDta3Cgm7ONOQvCtmTS1F6fGu/BxgxTV64bcRXF6NV/PwiuWzHaRM0nazn1UZ4PYv0stMHTetJ4UTXWyeau1FCxLX+XHYbsjYGD8HprG7ZISlLdyCOyuDWITbHhpwYITSBAVUDgZn6o/+zh0ZXZOJ3q4DfbCdyIx5wPSNmlVPNrOHwhFE6XoSPHzD93diss1GFbwYXWm1evJy5973zmue5r/V9wiNUhZuevqlmVDRpiYrwcB+VFJxiVQ2UFK6Vt6UfOO7Tq2u0buNwTPydpeEhO+fcKXNGKAM00j2YJ5Z0v0q4+94tUbaNwkhpIamQbOpPCJO3lT0Sl0vnGZbPbGhCAolWI12MGGv+65Qzx0vQZXF7C7M7Q7utY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR04MB8048.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(186003)(54906003)(26005)(1076003)(6506007)(83380400001)(6486002)(2906002)(966005)(71200400001)(38070700005)(66946007)(76116006)(66476007)(5660300002)(66446008)(86362001)(66556008)(44832011)(4326008)(122000001)(64756008)(82960400001)(316002)(8936002)(508600001)(8676002)(33716001)(6916009)(15650500001)(38100700002)(9686003)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L/qUMkNuLW533bCGBvUJAimbVumNz5iYn8ggKHXtwzsXhd/ZPYIgbGzeMhcQ?=
 =?us-ascii?Q?pbdiDywHQlQ9y+ttkpUtjMUiAHvJnOcHE/bFhKw1I0bQ9dro4okd6Xks1wqH?=
 =?us-ascii?Q?V+9DtKmmCNFZ+WOCjmgwSd9YKh1uoa+qscy4i05EI4lkfIYJ19J7dSxfgH06?=
 =?us-ascii?Q?mgfm2jkE9t+Mc+mI1AJfEp+/hC0Mzc/YgAE2e5ne85Pi0w0Kr7nmMgvk0egs?=
 =?us-ascii?Q?qzy7JvH3usOcBbqgVlfdOUnwzu4RI1PzlGhIoWSFnU43Av6ETJGfmkqnp5xZ?=
 =?us-ascii?Q?d5jVl0vg6HYiofW4LdgAoDf7zljI3cWGA+ct/gXjIqKiIPR6y+34pnYl+LqB?=
 =?us-ascii?Q?0+wCtW4MjUFuuTenQMdhrNLF0RWrrym6xP+nT3Z0E04U4tVD3cAY5tG0VGNV?=
 =?us-ascii?Q?Ttf586ryFIM4rmBsRpXOpBDwrvU6CrAGkouwTRqcdqunlV/jy0rVhEyCOvoj?=
 =?us-ascii?Q?+VQIrxt3yAAA+VvGZAp+qV6yhB+lgd4EaRbxHsmfmU6S2L0ncnKQDm/WHGcz?=
 =?us-ascii?Q?L+CUNh8WjdJtw8MY4tvLNfJhTKawtE0aLbNC9FmIeP0myo7u/kf8/txqqfce?=
 =?us-ascii?Q?wUET+vN6PdPtpszXOM0j55csMMfGXFJXvfy+eoobVx3JOLECru1Eq+Lkemnl?=
 =?us-ascii?Q?k1hx81iX5/OzWWA2+cIn96NyCgqxO7EZ/EgXPuc1Q9KBThC2GPxLl+jAHYvY?=
 =?us-ascii?Q?42QzN3MgtDCgJqFcFCWBH9QGbGAORwsEABskvkBvdDg4fVgr4kaUvkS2ATnf?=
 =?us-ascii?Q?0eH45DShIXY9nTyPTJAOZaVoC+EFLEjyeJzWL+KCOCEB91FUY5e3kzzqEkzX?=
 =?us-ascii?Q?yoQB2ZV/VXLqiwtfhMqwU8B6W9FVWL2MPErAK03O2q79FxnHsyvaDgji3v8Z?=
 =?us-ascii?Q?HLIZyAINxtPcjye7ZfpRl818Za5hMSzT31+aTnG7CWsIb7YYpMpCWrjO8W03?=
 =?us-ascii?Q?WPzY/1+RHyI+OGUP6+1PMpYz4DIVMSrAwuNytERVb7HQSttmN0PlBSSmFAKd?=
 =?us-ascii?Q?hPqrVzZIOi0gMUHofuhkZ97p3CSnggtbElALObizVfigtI4rPwd8cx3CE3wE?=
 =?us-ascii?Q?tkNbV56sr7LaC7Zp38BdITSVjHGKED73/VY8q6rPniN5QHBfgbrppIR7bbIb?=
 =?us-ascii?Q?D9kAzkLO1LVhMMiwgnjj2z4Si0pAsK3OAKjW2PKs1YElkTvHcuMpjdZzXSb4?=
 =?us-ascii?Q?TbfA6sDLH98c5C28uyzp4YoAYTuIZn3jF5KM3WXBqDwvRA+bT3wQbBKkKACV?=
 =?us-ascii?Q?6b52X4l+Mor6MXm+Yg1Owi0cZiZpTdHAk2fKZEL/8r99fx6GFC8hsBQ68vFk?=
 =?us-ascii?Q?/JlsNcmH/juKMcH81jwsJnal6xEquBBtfS1HMnir44L80vUWy/jgZPX4bYZa?=
 =?us-ascii?Q?qYL98yZmr1Ng1Bqk1IhzXalTuXPwbYRFKl0ecuooxUolZsZScLuxn5WAuEdZ?=
 =?us-ascii?Q?4WpBo8VrF0FNozWbLxLTTBdACEA2eGm51OC8HUS7uMBEBvSIWgmKlvawEEey?=
 =?us-ascii?Q?cCJggp+zNUKTn3NgkLDsYg3/x9rLv9ZXLYSI5F6sXxsVKfx/RcHaw/MfrQbV?=
 =?us-ascii?Q?4Xdf5eqcMcyLqTKV+Qw9GkS2ij2AXl7DOe77GK+Og9ZM6vuNKuCs+YocS8XD?=
 =?us-ascii?Q?/LlCVYWpRhDz89q96RWzmDwm5BJTubQ1d7ANpn1kc5fB0cke0H82f/rZJZqY?=
 =?us-ascii?Q?MDue9hZ43d8xxhvrwiugsILBZ9E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6B47A4C4B0723842AB61E3E85006D3B7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR04MB8048.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 794ef342-b38a-46e5-af20-08d9fcaffdbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2022 00:51:45.5554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rd6kRScmSAwv7I69X7zapNE/SfdHbTLXWcKZfdHrn0hFLPDhYUrniuerOLvKDJhC9quzyL+iq8LNgANcVqU936fvdWojsZoOVLb64ZEBmew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6728
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mar 02, 2022 / 14:05, Sidong Yang wrote:
> Test enable/disable quota and create/destroy qgroup repeatedly in
> parallel and confirm it does not cause kernel hang. It only happens
> in kernel staring with kernel 5.17-rc3. This is a regression test
> for the problem reported to linux-btrfs list [1].
>=20
> The hang was recreated using the test case and fixed by kernel patch
> titled
>=20
>   btrfs: qgroup: fix deadlock between rescan worker and remove qgroup
>=20
> [1] https://lore.kernel.org/linux-btrfs/20220228014340.21309-1-realwakka@=
gmail.com/
>=20
> Signed-off-by: Sidong Yang <realwakka@gmail.com>

As Filipe noted, _scratch_unmount can be removed. Other than that, it looks=
 good
to me. Thanks again for catching this!

Reviewed-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

--=20
Best Regards,
Shin'ichiro Kawasaki


> ---
> v2 : fix changelog, comments, no wait pids argument
> ---
>  tests/btrfs/262     | 40 ++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/262.out |  2 ++
>  2 files changed, 42 insertions(+)
>  create mode 100755 tests/btrfs/262
>  create mode 100644 tests/btrfs/262.out
>=20
> diff --git a/tests/btrfs/262 b/tests/btrfs/262
> new file mode 100755
> index 00000000..8953a28e
> --- /dev/null
> +++ b/tests/btrfs/262
> @@ -0,0 +1,40 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 Sidong Yang.  All Rights Reserved.
> +#
> +# FS QA Test 262
> +#
> +# Test that running qgroup enable, create, destroy, and disable commands=
 in
> +# parallel doesn't result in a deadlock, a crash or any filesystem
> +# inconsistency.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick qgroup
> +
> +# Import common functions.
> +. ./common/filter
> +
> +# real QA test starts here
> +
> +_supported_fs btrfs
> +
> +_require_scratch
> +
> +_scratch_mkfs > /dev/null 2>&1
> +_scratch_mount
> +
> +for ((i =3D 0; i < 200; i++)); do
> +	$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT 2>> $seqres.full &
> +	$BTRFS_UTIL_PROG qgroup create 1/0 $SCRATCH_MNT 2>> $seqres.full &
> +	$BTRFS_UTIL_PROG qgroup destroy 1/0 $SCRATCH_MNT 2>> $seqres.full &
> +	$BTRFS_UTIL_PROG quota disable $SCRATCH_MNT 2>> $seqres.full &
> +done
> +
> +wait
> +
> +_scratch_unmount
> +
> +# success, all done
> +echo "Silence is golden"
> +status=3D0
> +exit
> diff --git a/tests/btrfs/262.out b/tests/btrfs/262.out
> new file mode 100644
> index 00000000..404badc3
> --- /dev/null
> +++ b/tests/btrfs/262.out
> @@ -0,0 +1,2 @@
> +QA output created by 262
> +Silence is golden
> --=20
> 2.25.1
> =
