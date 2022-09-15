Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C845B956C
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 09:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiIOHaI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 03:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiIOH3j (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 03:29:39 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C578467461
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 00:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663226952; x=1694762952;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f4qc9ntCUr06faH0Z9bZqO9ozpL0U0ek+yWSM/8ZneM=;
  b=d/Ltpfzy5/d/s+wW6wUqimLVj8pu9eFHiUtiYFHDZkWUTLHSYGyQWQ3d
   L9uyPuyIkhSwFhqv/cs/1H6uh4JYsmzw9SVv+OrC4cgLyNtrholCGYlbw
   8mKorelvLEHiRMwcyY/YBXj+pAv8CEKME0K46ZIHNQsULch8DI7wmjJic
   Ns3MgdQx2gnCpanypvk8UL6dHNonRx6m0Py/03dbKM8GGVJvqoudXu1d7
   sChswUsNl/3FDMjEoLvU31cXtjnOEnZNOLz09TqNdWFPBWufWiu0gj820
   zlJ5vBZqtgz7VeNqTY/GSe4HHtocqOH9CK1LwIv4bjNmUfNXb4nShPupa
   w==;
X-IronPort-AV: E=Sophos;i="5.93,317,1654531200"; 
   d="scan'208";a="323514322"
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2022 15:29:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VhgrTsHypShSYYcfDRDGNmR00HFD36wk+Nlnj5omMEnpDTYN+ywjiTF5gzE5kVyGn9Mpy0xy9e+HyahFd8kOkWRZ70am1NsiGhR8sqyVi6OSvvOqHWj5vWxO8gvq1j/h/SBuXef+0O2mTiFGY/9PZnl1Ntfk0qbrKdcndXWEOUHKbiYdRpkKRl3iPGg6q3q3LUXGKhmshXS92GJBYeJFPoubTsmc8KqZ4LXCYsUdC5p6+uqnQNt6T1RCeuY8Db3e5MZCsQ7L6onSPoALpUXbn1sbBR9SibOIhpJ6oen3UeXEXryvTkj7mTvtlIllFWRTtJ6sjkoriF6uzWnef59FKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/MrIDutP9k9Ci4yq8glRwg67SN9moSkVeTlrh+ZhEs=;
 b=PuzrhoMoPnqBWgAXqbgOhCJp65PNqQXNB2YL1KDIj8eV5LqR0byqCAEovCWkhF+4hk0uwO8OAWGWD0k/JjqQW91KskXbK8E/ti3RdUKdvtATyBitOE3gNlaUmZEJNYJbIXtzA0LeppZKwGxevwIx9uD2FvQahU1gQHwUordktEXmnD3Y1rzlYh15cYfh3MbBIATDKsHEbpj7Ie+D8Bt6/bTR8GXs3PcXSvEZoKlwzfSmjs3gcxjvEqQKCUGAz7ClgD2f4i7Q61JkpK28IGZtzbK3mjmb6HSP9xHVBC2sRxtAE+JerVXzH0sxg2EzrX8QLIv26PY5/Y6ouF8jFBcdVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/MrIDutP9k9Ci4yq8glRwg67SN9moSkVeTlrh+ZhEs=;
 b=Xnp0hLGReCmuQcmKgIwAQ2dVj768fbqX4dq81CjnrhT/Xl/T8lnx49vZxelpPrvBMCTC4RZjV5JOQn2Q3VPQu7/mPTbNJBrbSaV9o5vzN/PS+IKoVFAXOajcB27OkYXNWS2FNQ83X0OgaVH9zQhfYWFNgv5ffPvUDQwTQ/JPp8U=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by DM6PR04MB5212.namprd04.prod.outlook.com (2603:10b6:5:10b::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 07:29:09 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::7412:af67:635c:c0a9]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::7412:af67:635c:c0a9%7]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 07:29:09 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 10/10] btrfs: delete btrfs_check_super_location helper
Thread-Topic: [PATCH 10/10] btrfs: delete btrfs_check_super_location helper
Thread-Index: AQHYyI7fBxOt7iZvR0+wCIts7H1qRa3gGJEA
Date:   Thu, 15 Sep 2022 07:29:08 +0000
Message-ID: <20220915072908.uekh4xn2fxzrcwtf@naota-xeon>
References: <cover.1663196746.git.josef@toxicpanda.com>
 <b3b607429c224b37bf77571a3759a0c5b15c71bc.1663196746.git.josef@toxicpanda.com>
In-Reply-To: <b3b607429c224b37bf77571a3759a0c5b15c71bc.1663196746.git.josef@toxicpanda.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|DM6PR04MB5212:EE_
x-ms-office365-filtering-correlation-id: f34ad7ad-9b5d-4b01-774e-08da96ebfa7e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pIkDEbPigh5Sk5qC0QNk68IS1LsES6EuMlHhmVkU66Pgk3XyQ+Py+RvPzDfOIQtSpNUcLrGHKDAXcrIGSD+JhDSsK9jLNMFIpXANwWxjmRlkG8louQHcnEu9Sh/v1hp3mJd+PMJYO29Kfv0rWUXg9TExtbM62aLmih+dC/7o/+PDuia7e7ENrNd03YuKg99Nl09HMhpXn3Z4AQza2rRcplmJc77T+mPiKMqqFJfWs8ET0r2foLWZUsnXk/MD2lDhtAwEZUElXHnON4N+CtIIg6D4lNKCHx9eLX6BWTmneNR9buaAMB7m0WVSd3WGCVAxMf6aQsQh5vXIwh/p8twkGiraVRiGPcOOCOJ7z6vdkX98SGWA72kxAiBvL9oNa7m9JnD26S4GGBaY3VFQpA3XuOHvi6CxeusVmAqZ0Jt2rNn83Hq1vSzKvEoDp6sHR4tc7fAJEbwESwnpSCtX9fIq74QPCteU5XA3ns5QiNFsfxrCr7sByzFY3TuuLWiAWSaWz4zc4Y9JRKQh9mikTV53GYWGZyT7X7Q8IsP9ePWpc4GdehgcgxpodhAZftMs/nN6BnAp85E506EI/YWT2k7o4cVLF1jjb8aCIdlKMsfsOv+KcTfTHkKUs8jGw5GLU92YQyFC5HZUbN5oZmT65xBuLJr5WCoZuQCkkUXuCj86d9wgvluU1/RKOd9PkliKx/Q9VSt2EHVVgSClfqdZ4/P59rgPdGoI+bHWgUVnECGFKxp61xQxPIE/MSyOq0zdHq0swFH+Eoq+1hwkWh4MtsY8wQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199015)(316002)(6486002)(66476007)(71200400001)(91956017)(478600001)(66446008)(66556008)(76116006)(66946007)(64756008)(4326008)(41300700001)(38070700005)(6506007)(8676002)(86362001)(5660300002)(8936002)(186003)(1076003)(54906003)(82960400001)(38100700002)(122000001)(26005)(9686003)(33716001)(6512007)(83380400001)(6916009)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6W6PjHfaktLoHvWrgUM/w9TunPHm6JJ/vfnrke8hPeny+5stqCpDh6PBBisd?=
 =?us-ascii?Q?77NNgWhvGZpPudu6/XJARchCPEge02KAMoNdwpBBr193QyKt1dOdEzjSXxmC?=
 =?us-ascii?Q?KHPKykMbvYq/PkIuudHKV0r/fjbT2+Va4emsLxC2BzencvVZeuQ3unmoSiE9?=
 =?us-ascii?Q?JRstfem7nBb3R6WQ7LR9sGj+WVipvLyoPYQNLmZp+l8fBnzb6bA3fSHPvLF9?=
 =?us-ascii?Q?3O3W4ZqruVF9jnIlymfkCa/X3KtS5mc5PInnYNc8KCHULNT5Jju3lgyuTjnn?=
 =?us-ascii?Q?GUiwBiRCyhVM3z3bzXuKgCA0non/eSr8v8KRc92LBc2hRTy0AX9QKpzKP9+/?=
 =?us-ascii?Q?FgbAEYpV3g5CoAXhjngZBanO5VmxhsS5gaUhP8K8eJlI1CtJtMk0qRRrMAKD?=
 =?us-ascii?Q?W1QMVcxB2YTBvy8anl2pFNtHHfspTVk0wXuBpD5qFGk74YJXwfino5a7XkYQ?=
 =?us-ascii?Q?I/ZDqqJcYiBLWJIqIuw+Q4hDabGlnbku1Pb/cY4FbxRnFDnxaCFyh2sN3o2H?=
 =?us-ascii?Q?egDYfQh+9zzZoQ9KQF7QDXwz4HZhOHxdu8UQfSkj0KnBKueQkwpadOOgJ+sb?=
 =?us-ascii?Q?Afnpb/XgxIuu3InwsCkUArm4ln67uJiMQEul69GSsWNkOb+82NcXjAXiUTp6?=
 =?us-ascii?Q?v4B9U1/3sw2YLstlTMsaSqYxPdgi3zKHz+nYy9qeb3xbKerd5w/WfULz0yyt?=
 =?us-ascii?Q?8N5Ljn4hHC9ssQuoKvzKp1LGsglr9DxCQr/+aYZRyZga96/UKrWed1my8ILQ?=
 =?us-ascii?Q?Owkj+yfCrLr58gzBqzhxHKAsvfja90yK3EnBugiQTf236YR+XuTxgPCAY47w?=
 =?us-ascii?Q?l7RlOwXiY6dGCnWS39S3fvVaXQ9zjB4p3OvBomC1HDTuO0R0R2DC44VfQ/wM?=
 =?us-ascii?Q?hVEl2pEAB8RSHThipvKCQYGM6X1u3+GxRQqu9qAp+yKIqz55i1BLfGdUvSE9?=
 =?us-ascii?Q?Y0o3bMvYmUwCQYS/ilTzu4hVwvrRCGN2b9ErL1PZNWa3AGIwaaI/3+P0OEv9?=
 =?us-ascii?Q?KVlz3Ucga98mZTtmSXmvg6UQT2k9K3Fp7dpWzqIAgEIM2wtHMmJJ7MQTs+du?=
 =?us-ascii?Q?Tu9MZqxQbm12yPGd2w/iZNagW+lOp83ur6at61WD+NTTLNwODTkjdfwd7ge4?=
 =?us-ascii?Q?5aGFWe0FTh/7rGdYrXres2bzDJxsR+cQ1Daqfc1LNB2id08imZ3PgqHRCcF5?=
 =?us-ascii?Q?THN/2ygxRi0pyFyecVjJVKZN5WInm8lFEBvX1QOPexpRThjhkISpGCDY1r8R?=
 =?us-ascii?Q?99BazJus6hMC3/MoVev2iBsp835/Bn72tsOPuaNHAF2mv8gJvYJ/M5VgiLEH?=
 =?us-ascii?Q?L+qngHo2LL66Vnu0+y1nHpEoL1LtXwDl2bEIWy7Guy/Zev7LcEl+MoLKvsMv?=
 =?us-ascii?Q?Ys6Q3+DptUpg6VpG/lwqKmFUbbJ1RWl4zXQjOngmWK9qJGqC4DV2fyM4EuFA?=
 =?us-ascii?Q?XjbBx2MnZvtvb09mj7vhEAwdX+PayVNejFZ2IKhmQ06flMI8Vf4GkESM2x5L?=
 =?us-ascii?Q?PJkWrNho9mkSkaseR+n/P+JfqBDbtH1yLuolqeNr02cZIam0HoXPKKJbaA4B?=
 =?us-ascii?Q?XBoZGyUfgeT3ADu6RD4M+yFekaUxmvQYBscJEdrMzztIh3kX0kQRMnw5Blin?=
 =?us-ascii?Q?fw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4831208ED52C0B47A380FF95DD5A2416@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f34ad7ad-9b5d-4b01-774e-08da96ebfa7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 07:29:09.0107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0AJHZLu2wOQsYPdV+vujtt18Cm2dNtNeZgTQs3xsHMOuzspwikM6e7pvs4nQnS+/fURw1A6E3NOP3LJ7M5Neyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5212
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 14, 2022 at 07:07:50PM -0400, Josef Bacik wrote:
> This checks if device->zone_info =3D=3D NULL or if the bytenr falls in a
> sequential range, however btrfs_dev_is_sequential already does the NULL
> zone_info check, so we can replace this helper with just
> !btrfs_dev_is_sequential.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/scrub.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
>=20
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 66f09202ba96..9d130e13c6b9 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -4140,16 +4140,6 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
>  	return ret;
>  }
> =20
> -static inline bool btrfs_check_super_location(struct btrfs_device *devic=
e, u64 pos)
> -{
> -	/*
> -	 * On a non-zoned device, any address is OK. On a zoned device,
> -	 * non-SEQUENTIAL WRITE REQUIRED zones are capable.
> -	 */
> -	return device->zone_info =3D=3D NULL ||
> -		!btrfs_dev_is_sequential(device->zone_info, pos);
> -}
> -
>  static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
>  					   struct btrfs_device *scrub_dev)
>  {
> @@ -4173,7 +4163,7 @@ static noinline_for_stack int scrub_supers(struct s=
crub_ctx *sctx,
>  		if (bytenr + BTRFS_SUPER_INFO_SIZE >
>  		    scrub_dev->commit_total_bytes)
>  			break;
> -		if (!btrfs_check_super_location(scrub_dev, bytenr))
> +		if (!btrfs_dev_is_sequential(scrub_dev->zone_info, bytenr))

This condition is inverted. We need to skip a sequential zone as we cannot
overwrite superblock in the zone anyway.

>  			continue;
> =20
>  		ret =3D scrub_sectors(sctx, bytenr, BTRFS_SUPER_INFO_SIZE, bytenr,
> --=20
> 2.26.3
> =
