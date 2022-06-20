Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F063550E8D
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jun 2022 04:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbiFTC0v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Jun 2022 22:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiFTC0t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Jun 2022 22:26:49 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AE5959B
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Jun 2022 19:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655692006; x=1687228006;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jXYjf/zPTHj5dzV3npJTgbApxbXp4aezmrWMkcPLxeg=;
  b=cci++15Ku/SKVdrsuM74a4PQYgpFTv1J5AafCzGqp73GUMyKr3WWGX0p
   E8lB9q6X/8T+9FdJMqzUzOv46EHQpsvYNQ3uglr0k8soS0dAHvQeiCBRY
   8urTt6BflnIjbmx1OOnSbXlfbqqc80prUxYE83oWamkmJINYCOpMC79cR
   Og7Q3EbVNOfvHckuG9moCYLY/+E+c7Xf+P9fLLm0TMsMUNyR1vpcGb943
   0Lj4P1BhD8Q+71mRlVGTYXDw5IRFuPseLx1F5Nr35cErMoS+KZM9BsCg/
   l/gw4ynEzj15L92Et5295+jMK38K4gbh9dU2kqnPuIr2yzEMSKZSqyuA2
   w==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="208443072"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2022 10:26:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tmhl/dVF2Vr1osdxUdz0ZPG824l+Jd7y8jeXWwArQbU/igvhWnUREcDw+VZNF/MJg4tNr6hvPF4alVtCy7iw2KgcvE8AUEDwaxKlHzsO6HV3HXF+hJ6KTsuX520Um9vi2ABPbSn1F26pwMijXFEfJs9ito5KSD534d4skrpGAM/Lg0auo8SX/DWuKuB3YaD7mtGdMWpSD3fQ2rqjOadRAlHKKaQBWvhj/tVR0Rrxg51KL9MQBuULQGQotCD4p+4hQt66JOt4SgYeexvMQbkQOpZO6L+vmOOy+dd7kdwB4WkHzTNGXfBZtKhjtAF0Ne+NzT06QEeMhA+NEEViXcWf3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ir2Bl/vIUbau3qyCHzkHD5MjEvtNpPFaDsoWVrqxoN0=;
 b=coYLb5KviabWW62WEk1YWjEL4zg83WCIhxnQ2gm07xK1Epm+U2OaghSVYXBJ0oV9f3vNPuee8e7w9reMGsbhIQLMJTYhmuZ4tJED6ft2MIfTWqdinfgR6TmsCUSY/D4HQX+hwXzXNG1HntUQfQ5uvSwBEBcg2HbHpTb110u5DZ0bLhQp+5zlQgGxycX0p5OXKlBAwnKi3CGYuABRo12kGOrFU7yRYBKyG0Pa2TjYkxLZF/CuY8MsL391Zu7PHLOwUbwigPaFm8me/WVRjhQ7iMarbZqbCsGQMn+KiCUxROudPPSWLmbKPyWyakwHsxa+Vun3ZowBkLGnO3LbGkRWYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ir2Bl/vIUbau3qyCHzkHD5MjEvtNpPFaDsoWVrqxoN0=;
 b=XWoJ5WmBlF7qaGTcsNcbFp+dkOJyqVZcWqW+xujKUO69Iz5NKkJK7Tzt/zUJBnZeo7l3yJgsJFdvsqADmCxFqaF7W6VPR4DLpMtym8uVJksERCZY3bR3q/bD13xOOvJo+DecncHzFE3P3ahi699GLDmbjtcylbUXM3TxR51eOrU=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by MWHPR04MB0576.namprd04.prod.outlook.com (2603:10b6:300:72::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.19; Mon, 20 Jun
 2022 02:26:45 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::456b:ac5f:e71a:7164]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::456b:ac5f:e71a:7164%9]) with mapi id 15.20.5353.022; Mon, 20 Jun 2022
 02:26:45 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Filipe Manana <fdmanana@kernel.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/4] btrfs: fix error handling of fallbacked uncompress
 write
Thread-Topic: [PATCH 3/4] btrfs: fix error handling of fallbacked uncompress
 write
Thread-Index: AQHYgZgum7c/UXHQN0eqTSPjDEMcxa1TZOUAgAQySAA=
Date:   Mon, 20 Jun 2022 02:26:44 +0000
Message-ID: <20220620022644.owk5kbqrtxj4x6e5@naota-xeon>
References: <cover.1655391633.git.naohiro.aota@wdc.com>
 <f0ac3032fcd07344a84a9b1f7d05f8862aa60760.1655391633.git.naohiro.aota@wdc.com>
 <20220617102144.GD4041436@falcondesktop>
In-Reply-To: <20220617102144.GD4041436@falcondesktop>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c26dc63-b424-40e8-6b5a-08da526451d5
x-ms-traffictypediagnostic: MWHPR04MB0576:EE_
x-microsoft-antispam-prvs: <MWHPR04MB0576F1EB8C4CA83BC617BBBC8CB09@MWHPR04MB0576.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cmziJhBSR3MYSO2grWUt36aYrvSE6nhPqlnrZqnMui/mrcGgb0AgEDXqPuAenAcEKFVuhhA2ZdpnCzGflj99wX4KzkRXPyIGnImbc6EF4/BPeeFCY5fBNr6mmQp/l+HY7ZNaWt6Rd8G4Ii5sC0ybFN1+P5ZLISJksBCemnF04EpoAtt0+/75hGJpwhTk5mU57E6yI6To12oFL+Vc3QOTBgnZBE4Psu5ywa6INNzlebX/J27qaYAPeyl4L6xFOmqLxPE5P+EmeM7uF9xu7WDsgAv/ALdy9Yx9PBXLlM8DF8kUHqzXyF/P5QHZmWHEHTmf1bzVnrqZvLTKStq09ASqDHgPy4APMjv512wBuPgIUO3KLPnEGIWan/SF9jBGtVRTnvhCAaCGr8wsWUiXqZn+CpUqcZqzKh2zRO6tGhRDMKLXp1A5diQiwm18UyzB/ojpyDtsqWvrMEKQ+CHloivXs8WwdZScmCXVwTsLxE5XDKb/DaLZVMa2yvuCKKS5OvwUUyPu/hVxUzw51XZ55g6U9/WKyW5SuwP9xe1zpfsE/xoLDIfe6nIIUAIzO8wl7QzAXs92xshc5Pikeh+igv3aZ6CPUSBPgC1z2ifP5xctMMtmDADcZHdyFjdHsig1305tkUKpIFvg/piHGpsphX2bN3wRFKU6lINqXH4TLgRt/07OGnu4/gNWZaAQOL/EMAw1OqQRJKX3GoGXjSVwEtSYyg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(39860400002)(346002)(376002)(396003)(366004)(136003)(478600001)(186003)(8936002)(5660300002)(38100700002)(316002)(33716001)(122000001)(83380400001)(41300700001)(1076003)(86362001)(6506007)(71200400001)(4326008)(6486002)(6916009)(91956017)(76116006)(66946007)(66476007)(82960400001)(38070700005)(8676002)(26005)(6512007)(9686003)(66446008)(66556008)(64756008)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qSMHGx1MSX1LnuJGVrO7ltISjg8cbhFH7N+ERgPWtsdkBL1e3TGqg4p9IS0o?=
 =?us-ascii?Q?mqlvbEDPdm+t4cTTx4P3HOi96PI4x+paKTvPRbcehCJOZCml2/UchcaHoNR8?=
 =?us-ascii?Q?Aom7bkJTlXDtPfidLG5WO88ifuUSsFsj06PI2mqRi3l+tvOHxKDO7emGP4V9?=
 =?us-ascii?Q?GoJmzIUyzpxZAurctesNZo5GxYQMgL3EDOyaS2XsiGBM0il8JLdHxuY5JVMY?=
 =?us-ascii?Q?oDIzEhBXxW+gsXcgcnfeTJqcqEDZt6+mpJYQ5fkyYpjDwq5sR35/1GQ8ovai?=
 =?us-ascii?Q?dXLlkwQ9noTE76GOR3h6ELmQcUNYQGsk+WCTBYzo6ohhuJA66fAxeUdx9Tf2?=
 =?us-ascii?Q?UuY4MvafoYtJ5drEIdnPVs3Msar50BIfgY/zeC776fOMCUJM9jEGpDQzbi60?=
 =?us-ascii?Q?4HgBvYSmug12aDbQBBjgfeEIAFhhL3kHZUvt6QBi4vmpMcoI43dkDnvihI/o?=
 =?us-ascii?Q?R59+OWUX6OjztNj12VA82EFYcKyo+MCncFFIj+tY8bvCmaY10cfk2Vv1wlAW?=
 =?us-ascii?Q?RwMQircYsl06D1b0VvSphXGwCpSHj62zMyyF0/iKi2j3rhMch2QWrEAZ68t/?=
 =?us-ascii?Q?BmpZNPnvLTBV46qATgHzJRwEZ9lf7xkmZ1bgkz195rSw2amr5Mc6fmQyjmTo?=
 =?us-ascii?Q?vPMfmf9RrLn0lZsyCLLH3tD65HKaoLpmKPENcP31eliipNvJsOO/YswSj87x?=
 =?us-ascii?Q?a1pjotch6wKFMetC0MhNj6zv+8LfZqtrNzEGEC+J1z5xF6jy4ehLBvx2vxGS?=
 =?us-ascii?Q?BNQAR8dNk/ToRF9ENEcARiSf2nj1peh7LcQBPDmo7XonjGunu4PWlukgp+sy?=
 =?us-ascii?Q?VXSSJPoYet6OH7MraBVT5mDu92yj/N9nr+u4YvHgoYVeRu329C4KloQfeICp?=
 =?us-ascii?Q?BbugUylx28Ucv1+DEY0FXV5+m6gU5qDBjkzxdGQGy+sOiONJ93ZfLeETE1z/?=
 =?us-ascii?Q?E+pbZrdr2LIGEnxeDavch2hC31vqgHbv+RyBM/h9kANMvbl8Fqi6/LSUtEOD?=
 =?us-ascii?Q?im+OAH5WQXF9pT8CdAoFK00UWbdI+kn4nPut+XBWHZ8WVEXOY9Ym5MBc2LNu?=
 =?us-ascii?Q?6YJ44+GcyY8noodtZz9n4eu9186zG+lygELp9VsxVGwcgCJJNummCPqNfxhq?=
 =?us-ascii?Q?EQRF3qULZ+LQgNVxgCv7MlldEZ05UnUKEjP2xHqOpufvUL2gInVBQDUgmVFx?=
 =?us-ascii?Q?+N3nxG1wqUuc7HKuIqFOckMLXixv5DfT5who58pPN3dC/zYE7nlSoa8P5U0U?=
 =?us-ascii?Q?U0CO/5nnIOJx4FfdFT4iU8hwxli81bVj/iI2SOFnGqgmL5+8RXLQ6knwjEsq?=
 =?us-ascii?Q?VwzzWAFvwl+hQe/N1S9l/aACDgnZzgyUEM2U+W4riMxWt9WV9aWRPoie57zk?=
 =?us-ascii?Q?hK925ENCt3X9NSA/neAuzrEAphfPSoSVr2mv94mbdc7o7bJryxtsVieiJBaW?=
 =?us-ascii?Q?vjzv34yFo43Noq5ZXDi9higuZOVXsy+lDOqQXW5JTkL0ldOmCXmWzJsuhjlW?=
 =?us-ascii?Q?TgLCypNyezekGyOsarOkAr7Bu/jgOH1NiKaiCdEROc99dSxnC7+csiHMchmq?=
 =?us-ascii?Q?vc+JZHwtxvatSkDjvrX5guCxv9YT4IMiXpfdcNWgrVSmivXV3UCaIZvgFpuu?=
 =?us-ascii?Q?VTLCGyq2Wxyx9WNTZw0vqwaKh8IBMAXVa4WIibsnujuZASUQAS1olZmROVsC?=
 =?us-ascii?Q?FMXG3MqpP7RSkBLJRFU1HZ456ZGGSjWlBcWwZCFvQ7W1cQ8NXfIEvG65Odch?=
 =?us-ascii?Q?7OGuA3D62EGtACCpD5WvQqfAtoPOZnM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DC587C35F168954F8F2121BA0DFC536A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c26dc63-b424-40e8-6b5a-08da526451d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2022 02:26:44.9338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8oVQhSaLcfLceEf9ISdnI/62yqYHrjjheUS6+QF8zZGF16sdmAvLLXIaH/3gcFl4vZb7kE+cujeNYG50nJmGEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0576
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 17, 2022 at 11:21:44AM +0100, Filipe Manana wrote:
> On Fri, Jun 17, 2022 at 12:45:41AM +0900, Naohiro Aota wrote:
> > When cow_file_range() fails in the middle of the allocation loop, it
> > unlocks the pages but remains the ordered extents intact. Thus, we need=
 to
>=20
> s/remains/leaves/

Will fix.

>=20
> > call btrfs_cleanup_ordered_extents() to finish the created ordered exte=
nts.
> >=20
> > Also, we need to call end_extent_writepage() if locked_page is availabl=
e
> > because btrfs_cleanup_ordered_extents() never process the region on the
> > locked_page.
> >=20
> > Furthermore, we need to set the mapping as error if locked_page is
> > unavailable before unlocking the pages, so that the errno is properly
> > propagated to the userland.
> >=20
> > CC: stable@vger.kernel.org
>=20
> It would be better to specify a version here.
>
> The delalloc paths for compression were (a bit heavily) refactored last y=
ear
> in preparation for the subpage sector size support, so blindly adding thi=
s
> to any stable releases might introduce regressions (assuming the patch do=
es
> not fail to apply).

Yeah ... I could not find the exact commit. It looks like there is no
ordered extent clean up from the beginning.

I'll check if the modified cow_file_range() cause a hang on the stable
versions.

>=20
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > ---
> >  fs/btrfs/inode.c | 17 +++++++++++++++--
> >  1 file changed, 15 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index 4e1100f84a88..cae15924fc99 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -934,8 +934,18 @@ static int submit_uncompressed_range(struct btrfs_=
inode *inode,
> >  		goto out;
> >  	}
> >  	if (ret < 0) {
> > -		if (locked_page)
> > +		btrfs_cleanup_ordered_extents(inode, locked_page, start, end - start=
 + 1);
> > +		if (locked_page) {
> > +			u64 page_start =3D page_offset(locked_page);
> > +			u64 page_end =3D page_start + PAGE_SIZE - 1;
> > +
> > +			btrfs_page_set_error(inode->root->fs_info, locked_page,
> > +					     page_start, PAGE_SIZE);
> > +			set_page_writeback(locked_page);
> > +			end_page_writeback(locked_page);
> > +			end_extent_writepage(locked_page, ret, page_start, page_end);
> >  			unlock_page(locked_page);
> > +		}
> >  		goto out;
> >  	}
>=20
> So as I commented in the previous patch, something is missing here: the c=
all to
> btrfs_cleanup_ordered_extents() at submit_uncompressed_range() in case co=
w_file_range()
> returns an error.
>=20
> Otherwise it looks fine.
> Thanks.

btrfs_cleanup_ordered_extents() is called at the first line of the added
lines. We need to call it regardless of locked_page !=3D NULL or not, becau=
se
submit_uncompressed_range() can be called with locked_page =3D NULL.

> > =20
> > @@ -1390,9 +1400,12 @@ static noinline int cow_file_range(struct btrfs_=
inode *inode,
> >  	 * However, in case of unlock =3D=3D 0, we still need to unlock the p=
ages
> >  	 * (except @locked_page) to ensure all the pages are unlocked.
> >  	 */
> > -	if (!unlock && orig_start < start)
> > +	if (!unlock && orig_start < start) {
> > +		if (!locked_page)
> > +			mapping_set_error(inode->vfs_inode.i_mapping, ret);
> >  		extent_clear_unlock_delalloc(inode, orig_start, start - 1,
> >  					     locked_page, 0, page_ops);
> > +	}
> > =20
> >  	/*
> >  	 * For the range (2). If we reserved an extent for our delalloc range
> > --=20
> > 2.35.1
> > =
