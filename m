Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34404D5CCA
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Mar 2022 08:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347313AbiCKHyF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Mar 2022 02:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347312AbiCKHyD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Mar 2022 02:54:03 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6F2B54EC
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Mar 2022 23:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646985169; x=1678521169;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ueGZWtZmxGSajzVtHc+72ZGlveX+6/x6bdxXbcDt4x4=;
  b=f70n6s7A+XL0Rs8VlJWtsxLN9WHgfGaOAAPfE716frD5SO/S8mmxqxRx
   ET6FKXCauwVGqtowOpyCt70VPT8eaAACvBMZhSgP5Xxjb/amcM9KjQNkv
   Q5axISMvoe62bKLqpKBi9r8gkI3C9LMabFlbfzhS6xQSQ9J2j+27xU94I
   pkALMIql92NDODqRZzYViXvVJDXTpvjjrlhZXg37fG+ocqSZ1/QPRsQRC
   iPTq0spw7RUKb/eGBPlV8E7UrbdTLwcBUsSPFn/q5KwdzxsPIgGmcV+Xd
   j7z9PxToYcepce5CV0ocTSsp9KGkbzLHQauKPILKkWruMezVfFbpzaAO2
   g==;
X-IronPort-AV: E=Sophos;i="5.90,173,1643644800"; 
   d="scan'208";a="193981619"
Received: from mail-mw2nam10lp2103.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.103])
  by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2022 15:52:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQIEQeHv+RhiOrvdEmk1qdJTkL6rzzNXYv08h0yVLizUmTEJe7wO68tu4vYCcVhGPw7hO40zCu5uHGEyDXtLpUq2TZTdkfyJEPQUpZ2f7CveI3h2rqf7impgEIddn11hbxnXBBnnPXsC/NsfYsi0uRn1swj18RbSjdhPtmbIfQX/QBq8bqXFWdnyUYZRlDabm33Rimfn3aLSIY1VDsWjYB6IaFqUp0oLyqRzvAiJEW5+aayAohRr4vPe10mtQv/winjPgIFgvtWKmGMVrUgu0QhUV+tuAczjJ9IHPPGwfkYBPNlqitCVoAsscstxXTW2qnhPvtoFunmaoB85gBU3sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMjKPCO15r/5CUi5npX/3icy5b4k4wUl8+iHmH6rvTY=;
 b=JzV6Om+2SUJCbU5CWZ/1zZ1SuaRJBAKNJ2MO2j3PmF8caGamww6SfbE1R2PCWsaDelTD46y6ERraUloW9UPjFfaLnnaZtfjrYhAfUU5EZxIglM7gbjuhVD+TcQfpikG72diNHKfgaAHbZMwhHuMUYjxmVi3s4s57i4kODDVu/62S2/LSIc9mbucwky1GPyJ6outWcPS9Maj4+wTGjdMbT/jBbjkhle47ukOayJJ+BFDnPdbWdDMyE6DmcxqydQuUV13JQz9bjBicSoZdpduUmHH6XRbGN99NQ3ZDk9vlHKVkS0wpiTF90blMltB+MJk+M2JDpDWfRwH7iD1EQa8aug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMjKPCO15r/5CUi5npX/3icy5b4k4wUl8+iHmH6rvTY=;
 b=B1j4SVtx8uhoSWdw19cCFzi4jZnn1aRnfLdtU+BFW9nwfnN59mM59cfrO/LvTu0qaqNTfSrLbaU1socxM3PmZfpVcqyLspKl8ASWWs0KnH9M6oYiTPc7h55+N3IjE77anQWLe1c5KYLQ1gm42GML7sPK+wg8iAQA43tNxJyNnAg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN8PR04MB6468.namprd04.prod.outlook.com (2603:10b6:408:dd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Fri, 11 Mar
 2022 07:52:46 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::e8b1:ea93:ffce:60f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::e8b1:ea93:ffce:60f6%4]) with mapi id 15.20.5061.022; Fri, 11 Mar 2022
 07:52:46 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 3/3] btrfs: change the bg_reclaim_threshold valid region
 from 0 to 100
Thread-Topic: [PATCH 3/3] btrfs: change the bg_reclaim_threshold valid region
 from 0 to 100
Thread-Index: AQHYNKh46ckVLaI8I0mzfGztdCrVAQ==
Date:   Fri, 11 Mar 2022 07:52:46 +0000
Message-ID: <PH0PR04MB7416F8C3DA7D7F821A07DAE29B0C9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1646934721.git.josef@toxicpanda.com>
 <234b8cb6da042df7d5bfa4ee10ff6d80c5908e90.1646934721.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ddb85ceb-ebfe-4bfd-2db5-08da03342191
x-ms-traffictypediagnostic: BN8PR04MB6468:EE_
x-microsoft-antispam-prvs: <BN8PR04MB6468A8E7FBBDFD3CF162713A9B0C9@BN8PR04MB6468.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BlR74ZhDpPXt4kUCyfm28P0YrOMtbY9rxzOTElJZaEr6RBPifbQyFRu/3QanNm/lifhoqK7T60QDyPOztsUFCqTR2PTdtmE3Kx69BYBvIzyYJ0XKhhptxcyVtbBqZUnvuyXFAe1zAWn0m8h8qeNpO0gzfZz8fZjOUnqJbmkwLPtsN/bu11Q44ITBrpsuIysvudvF5QqS8xhq0uoQCWvCQSMiaCg88ne+ywbqNFW9u90tgmmaqpi9aEAR2mrd6/mdLnK4ENyBIDkR4vLP8X0vlk70diepYDrYhG4acE0sCRMIPbxmxk0Co4joqrOzDU03oxH91ErGUbFgAoMOB/QcFghkLVNUdvUdW8yMJeHby9QYH+JtjotDzoLAKjYrzcLfP4C5ARxL9f4JD/GXf1uGwwtToU6xzjRfOGGe1AP493TgT699OQZBL+mdvxLXAXNGVRkvUaeLayrSp2XH6AUa2VkBkpsrcTWEVS6sdg/7ayKGXUpi2AdhLU1XXKdc5YBNIywdWgxiM8rW9vDdnMq1gZS1kdf4C6yqruklZaXG6qIj8g130T5gS0axXB45uRczNTzUVMk5zoWRzuq+c37Cc/DbJpREr5K8dOf/AK0gojayesLX9IvzjmO7kRAnPTE5VcHXkySc7WDgVU9I1qExdAD4oh46++SK+3N3Wu6fcN62FBxCoielTFksmI4TnCWIxqEmFECjhuxVYl0WzNMjtQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7696005)(5660300002)(6506007)(38100700002)(26005)(8936002)(2906002)(186003)(82960400001)(52536014)(53546011)(9686003)(55016003)(122000001)(316002)(33656002)(508600001)(38070700005)(86362001)(91956017)(83380400001)(64756008)(8676002)(71200400001)(66946007)(110136005)(66556008)(66476007)(66446008)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HySfSWaF2y1FL+l3u3/QV6mZ17vMOpB/Pt6kFxFc/xd+GgVY120cqFyDFzJR?=
 =?us-ascii?Q?BQDmV/EbZk+ohaXWadPY0/TqJELOo0uF7Yw8Pi4wTdXz5njzmNP6wZwIDyvB?=
 =?us-ascii?Q?2cyFWEvnfaCyw7oVTavCtuybyQ68cwufQu1USzQzWHKpEa97d5F2WXr26g+2?=
 =?us-ascii?Q?jBV4N+nKngCaiBydajxZ5hXl3+/GY+kURgD52y/ZozryEa2c7dQjCueUkJS2?=
 =?us-ascii?Q?XLkUcw6lckzW+aYXUO2VVQx0/V4mXRxbaMV8HwTYtjrmQNlXGaDDqI5wRGTm?=
 =?us-ascii?Q?D76GwKIiAmkmw/XBL1g1+A+vYIDF/xhx1rfAPOnNG+08axNp4+M9Xs78+WDt?=
 =?us-ascii?Q?jMHtxPu8BxEc0bCRLUXxnG30YGVjXy/IMcqQGflgrazCU91MQLcDXovpHYBm?=
 =?us-ascii?Q?nlIxlMB5Kj54w+X01thpdygDxVqgA7tzQYH19F/1kxVKre/wm0aKvc74z7rv?=
 =?us-ascii?Q?8nMoN7FeHETyqOVewbo7jia4xqs0SEJVv264y2SacqMztTcVsxHp8Zb+t6TO?=
 =?us-ascii?Q?cJbdD4Xr6IN+UkaRD0oWqlwjefCddkT5DddJPQCcagImC0JUb+nsJvjk3Fvf?=
 =?us-ascii?Q?4y6sGhgXo5y3qj4iMaeTrMfAGUom6DUq6Bubb6xiy2qSSwKYSryvVR1bvvXg?=
 =?us-ascii?Q?Efxk0oo3mLv3hZgGpeqbjZAQKdZ+/1KZfSIKDVEHo1/LmBirnLdmnIdLYJml?=
 =?us-ascii?Q?YoYMBT2ovRUTo7thL03wbP3OMjZT2NFEwpeOSWRsIovKzQgtV7pt6mTw+xac?=
 =?us-ascii?Q?SePe9te25DrBDybq0t0pSmhj7s7AC3eNcmzoFCO/70etLcbGcQ+A2ZVY8g9d?=
 =?us-ascii?Q?cIh460yp92mvN0ooAO5f6lhrjQW17LnwPWD6E2DpU/e5m69vBi4i/ZLQrK16?=
 =?us-ascii?Q?c6C9lvifd7lWWB6eQUP0OsYfWzMBYITBJGWGT1XJqZtcMdlmx6D+DPyMhbD2?=
 =?us-ascii?Q?N/LoZVszvKiEdyQpCujw82gR56gMijZrx+wJjXONIq4CQNb75wKLLk0JxHQl?=
 =?us-ascii?Q?V/OFQXGlkvw2HevF7qsxt/CZA4HcCEsosl4Jl6nKg4u8Jn/p6tzBsJ7Dvr/m?=
 =?us-ascii?Q?9zmiBCk3WgEzkW+1AiHDx/wGo87THeGDqhBJvf0ASZeA+/Don4JwfXT/Quft?=
 =?us-ascii?Q?pNYYPHFsVbe57CZFEMrU0PLRmaxZ3rhyruiLKkrGzN4cWiurzwl7wkS7g01X?=
 =?us-ascii?Q?jeKUBuIdIA+yyghLN4VoOPHeuBlv2c52Zp8Zuo+IC4Hieup4V4y9vG5s8fTm?=
 =?us-ascii?Q?7xT1GlBMNCzHli+oWDoZFTvOBiD8QCduG7LmD2ZgTzx7b9IOwIF9AztTjWSA?=
 =?us-ascii?Q?T6/rjjuCOTYhtJ2ods69jcAS8x7ckrAtPZsR6oCLKFaiNcTed5svflIzg2CH?=
 =?us-ascii?Q?iiiPsCrVUjFg75SFAZF12G9+y2RkEWR2mpfGCgeM95eGnxZxdmTiRBA78U4x?=
 =?us-ascii?Q?+cnHccfbHzPgn5tifK3yw/5bbbr/rOhPdJ3MIb1sSvO0WzVzp1FWdMUmCFO1?=
 =?us-ascii?Q?+4iF3knkv2/Bf44=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb85ceb-ebfe-4bfd-2db5-08da03342191
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2022 07:52:46.1286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A6fRFvl/7BI6GvM9vABN/Fa4fAWxL8WA+ekAvQ0IC1J7DblA/T5oSsxP7P7PohOANTLIQrtxOPIr+pe7wIX4XV7wP3yTnuS82Z7ayWjdqe4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6468
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/03/2022 18:58, Josef Bacik wrote:=0A=
> For the !zoned case we may want to set the threshold for reclaim to=0A=
> something below 50%.  Change the acceptable threshold from 50-100 to=0A=
> 0-100.=0A=
> =0A=
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>=0A=
> ---=0A=
>  fs/btrfs/sysfs.c | 2 +-=0A=
>  1 file changed, 1 insertion(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c=0A=
> index d11ff1c55394..400ce18d6a81 100644=0A=
> --- a/fs/btrfs/sysfs.c=0A=
> +++ b/fs/btrfs/sysfs.c=0A=
> @@ -746,7 +746,7 @@ static ssize_t btrfs_bg_reclaim_threshold_store(struc=
t kobject *kobj,=0A=
>  	if (ret)=0A=
>  		return ret;=0A=
>  =0A=
> -	if (thresh !=3D 0 && (thresh <=3D 50 || thresh > 100))=0A=
> +	if (thresh < 0 || thresh > 100)=0A=
>  		return -EINVAL;=0A=
>  =0A=
>  	WRITE_ONCE(space_info->bg_reclaim_threshold, thresh);=0A=
=0A=
That could be problematic for zns devices with say a zone_size of 2G and a=
=0A=
zone_capacity of 1G. This means all block_groups are 50% zone_unusable righ=
t=0A=
from the start, so if someone set's the threshold to 50% or lover it'll =0A=
constantly try to reclaim the bg.=0A=
=0A=
I'm not saying we shouldn't do that, it's just a "with great power comes=0A=
great responsibility" reminder.=0A=
=0A=
Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
