Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2E472F258
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jun 2023 03:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241901AbjFNB7p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jun 2023 21:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240237AbjFNB7m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jun 2023 21:59:42 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB9BE79
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 18:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1686707980; x=1718243980;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=2s+jQyMDw6Pxp35IRhY6P30PRG+s5eL1sNdtU82FGIM=;
  b=EXoJ5GnnbQuPlyIx10tTRXNU2tPFyJtRWEJYlmPiXBA1wj1iqMQYe2iM
   fdCVzxa8jkVM1sqMRNvMVJ2CZmEgKDccVPmXfUJnT/swKk3qJX0hyxSfc
   3I2xNP8SwNbqxXjGwM7xnvCkiD3EdgVv7YjFZUba4M7+KN177sl/a6Xti
   zfPZmlF/C2wf0n1HmoLMohYCEnRdT95araBAXc+N1kPZYWUzI33k75CTs
   4K3kQSOzCbBnDn5ZsM5RRwiItgdmllg+7UXcWGBIt+eX7E+6tKRU+bpc2
   dH/xU5eSwiK+SFDwKWK2ipEssPPg40BQjz+1QHU3DFlBo29hK9bTArgCl
   A==;
X-IronPort-AV: E=Sophos;i="6.00,241,1681142400"; 
   d="scan'208";a="233706213"
Received: from mail-mw2nam10lp2108.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.108])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jun 2023 09:59:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ufu31mKw4opQhWllL2mCjmZiviDxmvxM7tft64gMqlD3Xe/WWN0KyeFR03F27K513M4+hO/0gL9vUfQyeXg7uXn0B1y3tgeCxJMwCmFSVWtMWYjMyArHq47Rpc7PmXjcbAKgEi85qxMjSFsc+CyeG+RTBLYZR/VFTTlwY/HWcowMioUEjniIJzux3c8hroWAUGLmuHaSiKJsA72oZrRZlT5hOmAHca8Qr/H20s6teAvISDSMpNZdhpmmi2Flrj0TX+cUQW5JIk5D8/h6ervbCNY8XtgtcCe2dtzGwJyaSK0Oonx2mBPnn0hP1X2RcAdPY0faNcSPGYXuhOFToCNfeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OosMq8n8kH+wUxX2bGdNwe/3XC3/wn/q6g2YsVrWoFw=;
 b=VSllONPVjZ6aGnREJdcIS4rXMjpleJpSfF02PVdLPZvCTodoHmSRhz3RaGX4LleSLVXwVuOXJE8C5rH3ySWNf4AJRYqvm1Ley0VAVlMpK0u0RVPQ6Q5lf+DOdN4x3GvT3jA5bV7vZKznLnoThXLMy6LNLcnlR0snvYys7heVvDfx5aWgbx6Lj961QjORIXLt58cV8mODmQv3Nfleat5xFRSerLGpWahg5gt+D+SdUzxMVlE1oZkxFGk15CEfPHCZgGRp6xCY434PcDyctzSYuAc6xhXTrBoSnIkx9upu+7Q2AsLPm9YfFsrXpI5JgeP925/XmdvpVEoy+DGLVvqXpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OosMq8n8kH+wUxX2bGdNwe/3XC3/wn/q6g2YsVrWoFw=;
 b=wXuK7qmNZY0FUV7mOjWpNMoj1wVuzON7Aj36xKuE+l7v3owjEmEjC2Wi90i1NBsjWlVubsTLeK4M+H8iDuC8dbqfsiS/EpLan/0XO9pxmt4jJM+Jk29yxOCGFAcN2LvEK0559JzaUWwIccwmlHv9qvIHIjOUVBTE+fad+bifpyY=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by PH0PR04MB8388.namprd04.prod.outlook.com (2603:10b6:510:f3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Wed, 14 Jun
 2023 01:59:36 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::e9d9:ae8:fb59:5f01]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::e9d9:ae8:fb59:5f01%4]) with mapi id 15.20.6477.028; Wed, 14 Jun 2023
 01:59:35 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: do not limit delalloc size to
 fs_info->max_extent_size
Thread-Topic: [PATCH] btrfs: zoned: do not limit delalloc size to
 fs_info->max_extent_size
Thread-Index: AQHZnUAc/ChoELfa0EizJWklxAILA6+IMiqAgAAJ+QCAAVEVAA==
Date:   Wed, 14 Jun 2023 01:59:35 +0000
Message-ID: <bvtfl35llmzudy6lpiaqlw62n2wctgfy26ejwcqtnl3aoagisq@waq5rpmq7d6u>
References: <a2f4a2162fdc3457830fa997c70ffa7c231759ad.1686582572.git.naohiro.aota@wdc.com>
 <ZIf74wFg7NmvmQxn@infradead.org>
 <jmbvm4co36av23vly5e45hhyeth42ebl5ulqc7uw5cc6qdu6bf@x7i66logd62j>
In-Reply-To: <jmbvm4co36av23vly5e45hhyeth42ebl5ulqc7uw5cc6qdu6bf@x7i66logd62j>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|PH0PR04MB8388:EE_
x-ms-office365-filtering-correlation-id: be6ab85b-9a58-4f33-f211-08db6c7b0120
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j7gF1KH/Sgyj3nK+vvi7kcbHcT9CiP5f/A/n4sv5icL79Q4q32Y/XrbCWtR23YZNiJxzcX/ir5Za1OYmRY270+QQSkt4meYa2s9R8ft2sh8mJyKzsJVuHmWGiBcOX5OS/8BwpS14UWVmtobfrI1uIp/IdzYoSz0TjqcdzF/uv38f7qP7WA2l5heaFANRgUm3L+v+n28ZiL68P+YAjskLQZ8RFXUb5XvSsOZGI3DZzsf1bWfiXKg7LkNsdx3qJ/zbXVcKGoihVl5pHw66DbXbFu1CJoE+er9t/He9ZMCkBtKfJ0rM3cgorjaNcEDXIq5UL3NtIxXC0Vt21B2fVcPfSvR1nfP51YHsGzB8Env9g/dGcMSlapXFnMoY8zjkY7sWys+/Sp8q6zPpz2+S6rgaDawNB8Fvaf14pcOiCCp04to1LcwdsxZfjxC0zplSfnNMJ/0PwgEBjfrp2vIwaJMLtq+fKXO+IdWkW+a6HT4+Qm9GK4YXKlxxK3UmqJj2930XSoYgN6vU+1fCGPgDv3wnB7mycIArOXHN3EPL6JxcGbckgNj816f9Yh6Ld3b2p8ETSVoO//4esVUcGCkXnQA+Qs6SMwvEfLKqJ0tgwJQHm4s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(451199021)(66476007)(5660300002)(66946007)(66556008)(64756008)(66446008)(316002)(91956017)(76116006)(186003)(8676002)(8936002)(110136005)(2906002)(71200400001)(41300700001)(478600001)(6486002)(6512007)(26005)(33716001)(6506007)(122000001)(9686003)(83380400001)(86362001)(38070700005)(82960400001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Vjevk76eE1reqbfr5JcO4tV2oaLyhSytZpOc9ACLQvUtpiW1HJoK4M0UhAyA?=
 =?us-ascii?Q?MOuLDTUW1OngPkG4rh19N2hSwCH/2atN/xsaVc8KTDcNJTVtr+pgMzTIoIfL?=
 =?us-ascii?Q?lxcMw54yDhpPGych229eJRLbS3+1+5lvw09G+XJZmeYOxP4X0zcrhp2sxY+d?=
 =?us-ascii?Q?xos1RCWJ2oczbHQFda2XFSpfg1Kd+QzJun7GOSbxPXGdSsRtqe7vOiLFFTOE?=
 =?us-ascii?Q?ktvoygn8yrfZ07C3OLp6EEpO62wL93UkVebkEUWp+U+Rlm4+bHgdpkeAdxFX?=
 =?us-ascii?Q?4v+p8xksM7fkI5evUZB/ZPwQtPR7FE7/TFWLhffTkziLhXxnT00SmKkTeDxp?=
 =?us-ascii?Q?tCgT8koGipNwiJ+A9yHeuwngKgmqEjPVQ7eOHdLgPAMBy6bBeLhSnuUiEnaG?=
 =?us-ascii?Q?kSVLyJDDgp/c0B+pkO/8a+N1k73Wi2aY5j2vXSZBVe8S8Y090SRDazRnb72/?=
 =?us-ascii?Q?QesPaZqEcsl1MQZ7icQfy3TFM1CyrzxPXB/T5wXIivW3cz5G3k+U7I31cSWI?=
 =?us-ascii?Q?gTe5iERli1/BDX6t7ynwxJajrmVTyeOcjjRR7NHl/GiBKR1u6t4njtxsUflP?=
 =?us-ascii?Q?PmqJr71HF55AhzG/NTBl5ilTml6jsKqh0V7DJ/laKGJgBnXRefXJk8s784GM?=
 =?us-ascii?Q?iwCHppEZg10waI5dl50Wu/yQXhkLnWe/jzM5mbJ2z+pMjpZK0ZtC0LGqY+BF?=
 =?us-ascii?Q?9osD7Zfvi0jSIeSISSS09rRe/Dl3SKiImErSIwXwmcqIXbfHJe5zLT9X7bzW?=
 =?us-ascii?Q?Sz1kagdOVSQs3Fot3Ue0nUQndBszpn5e5LKn5RSGCWQZFtWr0AsCpsDYyVCh?=
 =?us-ascii?Q?G3BNl0/NdY7NjBx9awZ9mRNZOG4+pQx4wPyE4QQiSqws6pKDpyuuBpQsHFQR?=
 =?us-ascii?Q?wMqQsjWF1yw5gAi0pxBCr6LmptqQXo0GPbV3c5mWnHeHXnhUuYIE4fjEeoc/?=
 =?us-ascii?Q?DwIQ0F//umRekTWLo/ZygMyj6cnZrdvEi4mFYvPDt+ldshdtGKGygez6O557?=
 =?us-ascii?Q?iLOe8wd5OPy5ZAilr4gXyVkNLEnMZBV3+S3LdhR9tEnv7grEwaEddFAt81ET?=
 =?us-ascii?Q?StuHpVvcJEoBdcKyOgNrMrPH+ihLtNrTUHFDUQC/nK8XxMzeB7UliWMz317+?=
 =?us-ascii?Q?NHn8Pj628jqfGYQGJGtq73srDunUnsyF7axQkg0Xlsop1rd1XxRYfibvP+wX?=
 =?us-ascii?Q?dxjooqO9mLb8HtPBJkpSlGgdr384lHkVLcrZdK5ExJXKVF8fnTl6CzKZQra8?=
 =?us-ascii?Q?6IX/K3Z4WOyM+ei8j5IpksSKxdWVY3J6CK6/Xb9GDAPOD3YCx+XykKAMVCL7?=
 =?us-ascii?Q?PzYn3rFuxGW9YjUUm9IooECHGwI0MFbOQuX9/5olz9YC6IlGebusmdQxI3wb?=
 =?us-ascii?Q?YLLFDHQrcJsgmiat81zcWTLO2HqUVQ3kuePIOLMzCKYx6IaC4D5fFddbcjah?=
 =?us-ascii?Q?kCs0lRyrm2eTwvu8f4NSkuqwxtmXOmWgE+hhbQgRMGyHPVOZwa9KYk/Zjcnt?=
 =?us-ascii?Q?IpIurDM9W7WMBTUY3JZTl3QOO1uf3gj2HnTyhJJpRlqAJGCFpBhYl24aTvl7?=
 =?us-ascii?Q?4AYxz2NyBOI4sLW52gqNxFYj9C6FASF1VOtR8s8ZKUnkW7DQfgp90sn6589U?=
 =?us-ascii?Q?lg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D858419E36E5444088AFEA38991DD389@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tsRuFAvfAzZBa0YKi83aVy5yaj43/Q9b8LnfoeLtxoDWm1d/CtGFngYSbC7ielIi0qJZhj/7MFizzGllM1opMYpsAm8w4zrvg2Wa28Spcs4ITZK9r7CV4btBpLVluvSRVGmGyHJh0xLq2X4o3JXiyNstXfuA4sFslXNmjcqpMkYukJZF5r+cxEgiWj3Umlf20MbGFfecdFY9/jmi2qY9sdupMMRjDzVM7tlkmJFNOkwK0M1UuIVZ+J5X7gXk6A7iq6vobyPxepKZiSGmQ+LDwM3KYX522uuFybIRWMCsqaZt4BMec9njQjzPuB3qV/HTVfLX8L6FDOztEctF21ZT2bUGQZmHsk8bTvCt0ZyAoyTBQo+h7vAqpCeVwIw6B95yBkylUvzuPKL3zFZgxpL07nsVd2Y9juTZurnHA3k482AN7YqI9iE5qQkRPHjDD90NZl0DIF83jbyYCusaFGo7yvgxKKtIij40IEYseU/SmraY93I4NZEkOE/ty9CIZkrNUbNxkkL6j5KEX6vR8Pxt8bwnP6AjfRznY4vCgSjJIDARUVHouj6xbFuF8eMm0GIFdKFDHXdpu2ADj7y2MSakYgz2UDYM/g5IP0dMQeTzU8HLVAPk1cbL+wIaeTYZ5e+MPr7dv4G+RVjk73BQ0aNyXGh7V1Bsgulhyg2NwViBTkeY1skakJ2Sw6sDGvOATfXH6Dbj1qvlFPlnuiFTHMbRV0qfrVYEz2mYEsbnP3yqpmCs+DwY7XG1EwZS3NAmKDl0tjz3UnVqkmYPJLUfokiiuBljqb+BqL4uUHcWPOkSP3zsLXhdW3GcsygOfHm4mWcN
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be6ab85b-9a58-4f33-f211-08db6c7b0120
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 01:59:35.8508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PXeJ80U+TmoeOPF3jahpTptQLCgOjMLerBQwzS0KrnuY7dTTn66S+6ju/+CJvFK0GjQwBQvATZ1l/7tm2AVv0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8388
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 13, 2023 at 02:53:04PM +0900, Naohiro Aota wrote:
> On Mon, Jun 12, 2023 at 10:17:23PM -0700, Christoph Hellwig wrote:
> > On Tue, Jun 13, 2023 at 12:10:29AM +0900, Naohiro Aota wrote:
> > > This patch reverts the delalloc size to BTRFS_MAX_EXTENT_SIZE, as it =
does
> > > not directly corresponds to the size of one extent. Instead, this pat=
ch
> > > will limit the allocation size at cow_file_range() for the zoned mode=
.
> >=20
> > Maybe I'm missing something, but that limitation also seems wrong or at
> > least suboptimal.  There is absolutely no problem in creating a large
> > allocation in cow_file_range.  btrfs_submit_bio will split it into max
> > appens size chunks for I/O, and depending on if they got reordered or
> > not we might even be able to record the entire big allocation as a
> > single extent on disk.
> >=20
>=20
> The issue corresponds to per-inode metadata reservation pool. For each
> outstanding extent, it reserves 16 * node_size to insert the extent item
> considering the worst case.
>=20
> If we allocate one large extent, it releases the unnecessary bytes from t=
he
> pool as it thinks it will only do only one insertion. Then, that extent i=
s
> split again, and it inserts several extents. For that insertion, btrfs
> consumes the reserved bytes from the per-inode pool, which is now ready
> only for one extent. So, with a big filesystem and a large extent write
> out, we can exhaust that pool and hit a WARN.
>=20
> And, re-charging the pool on split time is impossible, I think... But,
> things might change as we moved the split time.

I'm considering this again. We need to take care of the reservation pool to
ensure metadata insertion will succeed.

But, if we can keep the reservation pool for N (=3D delalloc size /
fs_info->max_extent_size) extents even the allocation is done for single
extent, the reservation should be OK and we can allocate one large extent.

So, I'm testing the patch below on top of current misc-next.

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index e6944c4db18b..911908ea5f6f 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4452,9 +4452,6 @@ int btrfs_reserve_extent(struct btrfs_root *root, u64=
 ram_bytes,
 	bool for_treelog =3D (root->root_key.objectid =3D=3D BTRFS_TREE_LOG_OBJEC=
TID);
 	bool for_data_reloc =3D (btrfs_is_data_reloc_root(root) && is_data);
=20
-	if (btrfs_is_zoned(fs_info))
-		ASSERT(num_bytes <=3D fs_info->max_extent_size);
-
 	flags =3D get_alloc_profile_by_root(root, is_data);
 again:
 	WARN_ON(num_bytes < fs_info->sectorsize);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5f98bc8d9196..b92c814cec97 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1494,10 +1494,7 @@ static noinline int cow_file_range(struct btrfs_inod=
e *inode,
 	while (num_bytes > 0) {
 		struct btrfs_ordered_extent *ordered;
=20
-		if (btrfs_is_zoned(fs_info))
-			cur_alloc_size =3D min_t(u64, num_bytes, fs_info->max_extent_size);
-		else
-			cur_alloc_size =3D num_bytes;
+		cur_alloc_size =3D num_bytes;
 		ret =3D btrfs_reserve_extent(root, cur_alloc_size, cur_alloc_size,
 					   min_alloc_size, 0, alloc_hint,
 					   &ins, 1, 1);
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index a629532283bc..2d12547e4d64 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -151,7 +151,9 @@ static struct btrfs_ordered_extent *alloc_ordered_exten=
t(
 			u64 ram_bytes, u64 disk_bytenr, u64 disk_num_bytes,
 			u64 offset, unsigned long flags, int compress_type)
 {
+	struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
 	struct btrfs_ordered_extent *entry;
+	int nr_extents =3D 1;
 	int ret;
=20
 	if (flags &
@@ -193,13 +195,21 @@ static struct btrfs_ordered_extent *alloc_ordered_ext=
ent(
 	INIT_LIST_HEAD(&entry->work_list);
 	init_completion(&entry->completion);
=20
+	/*
+	 * We may split the extent due to a device's max_zone_append_size.
+	 * Keep the reservation for the worst case, even we are allocating
+	 * only one ordered extent.
+	 */
+	if (btrfs_is_zoned(fs_info))
+		nr_extents =3D count_max_extents(fs_info, num_bytes);
+
 	/*
 	 * We don't need the count_max_extents here, we can assume that all of
 	 * that work has been done at higher layers, so this is truly the
 	 * smallest the extent is going to get.
 	 */
 	spin_lock(&inode->lock);
-	btrfs_mod_outstanding_extents(inode, 1);
+	btrfs_mod_outstanding_extents(inode, nr_extents);
 	spin_unlock(&inode->lock);
=20
 	return entry;
@@ -580,6 +590,7 @@ void btrfs_remove_ordered_extent(struct btrfs_inode *bt=
rfs_inode,
 	struct rb_node *node;
 	bool pending;
 	bool freespace_inode;
+	int nr_extents =3D 1;
=20
 	/*
 	 * If this is a free space inode the thread has not acquired the ordered
@@ -588,9 +599,12 @@ void btrfs_remove_ordered_extent(struct btrfs_inode *b=
trfs_inode,
 	freespace_inode =3D btrfs_is_free_space_inode(btrfs_inode);
=20
 	btrfs_lockdep_acquire(fs_info, btrfs_trans_pending_ordered);
+
 	/* This is paired with btrfs_alloc_ordered_extent. */
+	if (btrfs_is_zoned(fs_info))
+		nr_extents =3D count_max_extents(fs_info, entry->num_bytes);
 	spin_lock(&btrfs_inode->lock);
-	btrfs_mod_outstanding_extents(btrfs_inode, -1);
+	btrfs_mod_outstanding_extents(btrfs_inode, -nr_extents);
 	spin_unlock(&btrfs_inode->lock);
 	if (root !=3D fs_info->tree_root) {
 		u64 release;=
