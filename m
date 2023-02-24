Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729076A1714
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Feb 2023 08:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjBXH1m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Feb 2023 02:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjBXH1l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Feb 2023 02:27:41 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D322C63544;
        Thu, 23 Feb 2023 23:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677223636; x=1708759636;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cDSoxUBUHnAz46IhVSBgN4V57JAszykAjM+o77LmVco=;
  b=reV56i9hLxvjr/I1iQS7ZwyU3uxvPM3/j4JzUZnfyzt9DrmwOb0C9Wf5
   C28DCXVqF0DLmZmj3aDbfcibaGXeKl8dXXpmT5mSP7GZBssRUxGjpl2aA
   hRA3pRfCO5FQVdbo3IfOIkg2iOInLXyJKxWyEhko9kNEgrM22gC80dhc2
   arYZx68Rrhkn5VvxD63DSFyblDGsWPzAUCBSp9P+U1jIi8tAsNQhHgEKQ
   ipNRwtxM64d8cfnbrlwZgn3Gu0kcS9zYMqtdchdqbn+hGUlC4bGDW7RRX
   j94JR+giQBz/ESUhX13KMCumjtt2Q5mWkRN9W7Hh5AXKtT1/opz/58SEc
   g==;
X-IronPort-AV: E=Sophos;i="5.97,322,1669046400"; 
   d="scan'208";a="224117309"
Received: from mail-sn1nam02lp2042.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.42])
  by ob1.hgst.iphmx.com with ESMTP; 24 Feb 2023 15:26:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwzLDPNzU5ELwvSeW6agNONhNbzh5a5AqGTG5Y52qrRPx7e0kWa8yu0rOyL/BPb7QCgT3h9bTuFwkYf2lI6HqKcXQlrVAh4UmIdGe4nk/4nTtdJaNvXYOnepXoumIMUXDMt20KdfVFsG051LQAqgWpBoD3CVPi2j4/2fnHAyoAtRJODKtdBloJUKfXVTaCphRxKiQ5fjEIbAN1caRzHnAttTlnXNtqWM64/PeBtptR7cgrIAikBxwWLEqwmfPsxIJ+NIBHs1zM//G/nB2y6Ccsy8Uis8FZWVhHqtRrAOpCVjThMR40yQAMFFQCC1YVtWigr27zAoHCTNEQt12b9h5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3sSR5/A1SlyjvpUvQ8ySCFxLzu4X9OXTrjsouSoGB3E=;
 b=MOldI2OP2YVvMc6RYfgs0V+T9o/c2qRtBCZHc+Wv2RKPvXeaK5Clfmm7eEs8Mb0FbsfSbVV0TwieZZb3Gc8ohEsIoDVpBqCLM++mHayl2HP13+nHf8X6OT2bu84bV4olvU07pufmkSbphzOQE/U3y/m+QpfhvyvuIlgPqIHLPbtFd5R52kjFinVGwYkE34t7IfSur3lxEwrkzozMJ474wfkkIU2uDSLDefCclBFAkahuninHiM//GpkYGNRlWe6ztZ5lDBrX0CqzCsmEH06LMCWQ/G5ruKgYu4bVdYDbxYdJIYnGKYkO8QHlXFN9zrDkKSDInus+nyiDd7K3KU99/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3sSR5/A1SlyjvpUvQ8ySCFxLzu4X9OXTrjsouSoGB3E=;
 b=fyHKGwIOpQehohDSGvHIkDzVcjCmOf4q8hnoysF1z/084W/vI9hubQZD6WBcXmSuUWubjPJi1u8yjxqAv9DQG3116H8k8MR5i9VJ44Y54VPrJ3eFEC5/8w6ByfZbH7SRb2KY50igRWO11W4w1J9RxTBMYA5RIG8Cmsw6BzTydAE=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by MW4PR04MB7139.namprd04.prod.outlook.com (2603:10b6:303:73::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Fri, 24 Feb
 2023 07:26:57 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::2e44:805:e7e7:8544]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::2e44:805:e7e7:8544%6]) with mapi id 15.20.6134.024; Fri, 24 Feb 2023
 07:26:57 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     Zorro Lang <zlang@redhat.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH] common/rc: don't clear superblock for zoned scratch pools
Thread-Topic: [PATCH] common/rc: don't clear superblock for zoned scratch
 pools
Thread-Index: AQHZR500GLvKvjxRD0+bT77fFSB54K7ds4QA
Date:   Fri, 24 Feb 2023 07:26:57 +0000
Message-ID: <20230224072344.go5zzsrex23f4xt6@naota-xeon>
References: <20230223154035.296702-1-johannes.thumshirn@wdc.com>
In-Reply-To: <20230223154035.296702-1-johannes.thumshirn@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|MW4PR04MB7139:EE_
x-ms-office365-filtering-correlation-id: 745415e6-d152-4e4f-a5a4-08db16388303
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nj3cfMHiqpE5j7gEXhQM3ClJeuII5zLchy1Lb9Tk/7OmH+d2m3E8Dah8QGScS++x77ubY4yqfAESi/ZWYdOh25T0auzpxZ9csJ1VF3O1jmVWpCkHnuvw/ovwXiTa2fY+oOVOt1ocjO+H9K4AeDu/54zYz6o+sDKrdY2EUusCROm+R7gqmzJEVSm+xyl7cccaa+t7G5y/u7/JkBSCGChJxbwWI2oMqYFHRDtkqhhFUOQ4hLg+awEKXR7fQqRm4X6WYFrguzyI8yf1IgXInWhboL9FDIW3KmIK5kpzUzJ6rshL8lthI8N7e8kWFhCEp3fOJAuz0Z0aHg6Cb2zpZBFIpUbbWJ9mt0f/rUu+JjKjumXrBljOGtqBS9PM5xNw9qXPWqvz+OnnaGw1h7aFZlwu17ULviajNHIuUaiV6lgfzqg5WFv2DIHgyI0lWZi1ZSrbgsTHRIYkcUvLuu91PYF6KaSSF1i7T0EPG1on4+b7x13/Ebq2pJJ3OShgEMMiQtkZll9pmMHjo6T9ysPnLeJP5986KHyyVfqxuYGsL6nPwbpE5d8OlzDy84yeMkOwETswBSy2gTsOJSiqNnZAa/pkX4jn6AUMV8p1F8Wc+cei0QPS4TErOKtvfAWADgbkLPGcl31AvGlrHzJSTKNlQW3ahJK0W9V5FZS5qeECJN9y3Lseac/cDSLtLGVJELNM+3w8PaGRQHeOtbp7594pCPyXQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(366004)(346002)(396003)(136003)(376002)(39860400002)(451199018)(5660300002)(4326008)(8936002)(6862004)(38070700005)(41300700001)(8676002)(82960400001)(122000001)(38100700002)(4744005)(2906002)(71200400001)(6486002)(33716001)(26005)(186003)(6512007)(9686003)(6506007)(1076003)(83380400001)(66946007)(316002)(91956017)(76116006)(66446008)(66476007)(64756008)(86362001)(66556008)(478600001)(54906003)(6636002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2FM1qLdkoUPNy3lXNgI9dshXIpgSAhyCBedJS2mPNOps8SyXmYZ8LlPpz7WP?=
 =?us-ascii?Q?S3WqtttB4gE3ecezHqCqrAlciykLHWJ+UPz+aApcbq9aY6yOhDTWHKyxGmzt?=
 =?us-ascii?Q?L2QBcV4JLtyufgsJqkksHqF1v/CYiyc4qcV9/LBK96oLmyscy5pDIIwdVlwU?=
 =?us-ascii?Q?a6GDeMIYj/uwOHrBQ4ZLbHQPtXVAVZlMwNkNTlyZMwRHJL1dM2XJC/XpbEzU?=
 =?us-ascii?Q?vJKL0zg4a1sGjuCPiqIxVhStM2bc5Hk4yo4zFWkiqhAgU58opc0FhlkLijLC?=
 =?us-ascii?Q?4MdUW52elPxia3ho+rOzu+yd5j7cnOnxqciUS43F0Hc3r4wyjSso+sqCCVr9?=
 =?us-ascii?Q?tr2zRoGX+t65leaDFz5JmVfveMak67EshiaZXYZ4GZpJfRCv5Jv/C2GgOcN5?=
 =?us-ascii?Q?kcBHzjGTaa3pfBv3D9+3qi4OQy2eJhE6EIRYuCCIjDOtF3jMKoqjnVOYrpxN?=
 =?us-ascii?Q?JEBwhRYAjU1iaKjYVtfslksBPIRV2s84uJaSi/B0d0eUmPOIiSJ4TkEtsWDp?=
 =?us-ascii?Q?AFnETrKdE67pu0jTLLDmj1D7SJQgwt4prxphfJcPj6GlemX5s4DV/393YwSP?=
 =?us-ascii?Q?9PNlMEODwDu+qjjQU/yZWuZi52f5kMnsvXWqFJ6Tj+Rhoq5ilruv4RDYwF7E?=
 =?us-ascii?Q?3Azo5hXPY5zjKpQYk3oRrk6FxpOpYlR7hTz0F7YQJPKWxUOAf8RpUAHouWiV?=
 =?us-ascii?Q?dg/Gi8aTiZmNkEuIbmsK/ay8IIiKgd0PvBA6p7JsYa7fGhv9oZBVbcG0BYcV?=
 =?us-ascii?Q?czwZAq1vmdCte0d5q0cu6pomflsGyR0yn5oLE7NLXzdEH3/1FwSoWVSwLlMp?=
 =?us-ascii?Q?0gOK1djGpuY26aJLEFYCTg02QVCA3OCojDfunPp14glQuE0DPY75mEbyf9ID?=
 =?us-ascii?Q?jV/ApOdyutZ1jlEcDlKdgGuFSriJGMq3mcu4urYYWrN0aWbeu8PCxf8P1dzW?=
 =?us-ascii?Q?L6cQ4qMtGjFbJp4akoe7jCsSPA0jXeAZFgkIrUNrIWMjMd+W/vi3Ea07HU6U?=
 =?us-ascii?Q?RmjdyoNllFYc9u6KXYcNOCOOGeUCwdjCwMS+Vkj3sgh02bAtjka+Csd85xD+?=
 =?us-ascii?Q?SgREr73gDZsnKih+I9Bww4ZxIp5C7ro4imfFkW+iqr6Xr0TeQ0lRj5iNRn3U?=
 =?us-ascii?Q?78l78ydFZsAXHyUaVLw2xUEt/rZo6cCa7802v6QnLBGtLYpXUxxzAeXBYnrt?=
 =?us-ascii?Q?1NtTq2eo/dv92GY1DaShytb95GlnhkytpyFIv8tyh1SpwJIp5JPkyVbxUNaN?=
 =?us-ascii?Q?K68gDWcxJfBbiSaHvRUVfz5OgK4akQKz1DbTJLTaPd1X2cQj0DXR8GLanzA7?=
 =?us-ascii?Q?SFlKr6wSR6LFdw5C/ckqOUhRLCoTO7+Acca6+zaW3jGN7u7Bn2NZxu/UgUq7?=
 =?us-ascii?Q?rMqia2/5Yaz/SHGlfcMIu3cOm9Q03ED8br0pCYlbsIy6U/mVcHX0WpxRCchp?=
 =?us-ascii?Q?S0tV8cdOpmgEeBsT+4fNnqhVZt9Dmm1p+PFByGq4P/XHvtfoe6QL15/0ajFC?=
 =?us-ascii?Q?YVceRFH4ttZSdlGkUFLaDSa3g5dQZXtQro5326XNLppByzLfyrEWowYasqqL?=
 =?us-ascii?Q?gvAum0NSgIklBVYhIGuh6NR9JRTe7ZOFOYvebI55M9XniRLVyXh4ZXQkiLlT?=
 =?us-ascii?Q?6w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <12521F096088CB4188A8F9DEFB501409@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +zvbQL9YvAV3lpjtGpG4TLvY1Y57RCiG/c9Dp99iee/9+gQJQjPdNQDBxpwZZyI0OeXkuQZNzrWcJlFSNusje7WfE4KhUKSqK7wn13RNh7wCPySNFEsG4YasHpL3J16Q+MbtDIXbyoqSHyKGSNSPztB8DR6/leWwOTjNzDS6XE9LJ8uoY6tZ+0+YB90WIRmeKnlVIfjOCr+A7NMpAMO/8fbVmitgaYnZXKdVUShplwGC0b80YWCuys2yApzjh0qMvQc7lJaWhxDTemp1yXypG0XaKpe6E87QrQH4S0dENGOSZCznap/5Wz/PKeV92PiH0XgNvxqXQkS6AN5SrbyQyjLvF1EXRhNV5qIvB6ocSFRyiL6vynlZkW5xqlonmB6dlczMKMATgZepc0D8CAUnt9CklIVD+tRuOxP1LiYofILnoN+Z6q95dUMqwHB7JFE5tzCBs16yvBPaJBOuCuCEH0ekFYUFczr5mcsiDgwr/5FGhTjizm6NRG2NqkP7X8qGkgwAcm4MPgYJCo3Kfso8RC1EYsTTDqaZ04qpC/Uv3rK5bvzY8eSLOcNpZHjAA9S7xohbauesjWdDecs6oEzsi5HDJ5eGA2rsP/YdNwuQ49N7vReEa6lOu//2P8RSNMcriX58oCfLk/+IGaqgJq4fECqAzMnLUYbMCiIGTz7nATnfWhlZKC7qlEcSnvSt2gMp09m5/PGJ5RwlP0ScB3qyW9sHIlTECWNIY0kn2gTEJSAxF0rLs2+NC/S5OA6IVINUK8AfvHVBfJKzZHhRh9uw3tewQcbMCyCB5a2BadNXT3u0sS03xSqwgnKm6gw7Hc/1
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 745415e6-d152-4e4f-a5a4-08db16388303
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2023 07:26:57.4466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mYN4cEuwsmGz+MTE8FuNm8ykbuqbcRHOOT5IFCLK++a+2gf/GNjCFLCXdq4+yRnQTDp8ChQF1cNoYh/rlVBUJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7139
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 23, 2023 at 07:40:35AM -0800, Johannes Thumshirn wrote:
> _require_scratch_dev_pool() zeros the first 100 sectors of each device to
> clear eventual remains of older filesystems.
>=20
> On zoned devices this creates all sorts of problems, so just skip the
> clearing there.
>=20
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  common/rc | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/common/rc b/common/rc
> index 654730b21ead..d763501be2b2 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3461,7 +3461,9 @@ _require_scratch_dev_pool()
>  		fi
>  		# to help better debug when something fails, we remove
>  		# traces of previous btrfs FS on the dev.
> -		dd if=3D/dev/zero of=3D$i bs=3D4096 count=3D100 > /dev/null 2>&1
> +		if [ "`_zone_type "$i"`" =3D "none" ]; then
> +			dd if=3D/dev/zero of=3D$i bs=3D4096 count=3D100 > /dev/null 2>&1
> +		fi

How about resetting the first two zones on the zoned device case?

>  	done
>  }
> =20
> --=20
> 2.39.1
> =
