Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475E452A689
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 17:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236009AbiEQP1k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 11:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbiEQP1i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 11:27:38 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4894F9C7
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 08:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652801257; x=1684337257;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=txJwQXosPQNakhRQs1iV+RmwcIFIdaegcfNbVRzFGGQ=;
  b=XVkvKjAelT0F2UesSuF9D8nrmxeN/XDc+gajVPlJ+CgtIwMWkqV8Oc8k
   B+XBfxzHPdLEnBbXpG/wPpNAUrC6IV23T0p88nnh1GGZl0LYRHUjKE7QF
   Ptwh8+b5QnRIwHLggR4p6NCMWB8UR8nVb8Yk4zoacGjsvAqcXENmeKt44
   bqui4WJ8J+Fg/TR3+ZnPC6rrrPr6vD6XQRSL/QDMe/FkY3M2UYhEjc9SU
   nwuVVTYl8QMK+lUjfuqQ2QeGx39ToelYHAoam6XBZbF03urx8VsI0beNh
   q0QEe73TU6nXWzaxybYsAUt9kinVz3s2VGO3O+rOR8+BnSj/ZyEgJlv3J
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,233,1647273600"; 
   d="scan'208";a="312551074"
Received: from mail-bn1nam07lp2049.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.49])
  by ob1.hgst.iphmx.com with ESMTP; 17 May 2022 23:27:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a10FgUwQHGNmo8x27jyZd444It5WJEsI0JY108Qq+WGHud9Y4MxyTa5tIjAHtSPorF0Htb+zV0dl7f8pRfBwaLFfNZ1WsKxXKx8mLVufw6HjfbVhiRoAlKC2cA3QXIG4iKV6N/2zdNr5LUyBU61J45sBh+MVWLz9LBfHanR+fnVM+kDnGoy3DMzXGlffpU2RWIOieG7Oh2xl9hDy5kRxRwUe6qNGE6NvVYqXceH8HiI5AiMXT/3cmJ0uglnM9YsshTF9zlCW0VlUdwqzvm8/GR55WXf9Y67ZMA0udvRF/d7r0gdYcCXlZ3yvt6O64SZtN6GmtG/WpQwLEw6/4d6IKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bO9govuX6fuVd8s+cqofobao8oHLrAhiOvR5kOyDAAk=;
 b=CXBSea/fmy2CMR5jPwCrSeCCKZDhgigmvgCeTpLmyfi/jwv0xS8qzs6cZySH9tVenMziaTsDYwdALtRcclX6mWZBPX68RXclhOPrz3QjPAEnU8Nu2vWWjQrbX9DnFPG8SXnWmZxPOYFTKLgUmdzosmqVWFnUad8wyLNAQa9BUleTt4YPR7senC+50HLdIKB9WbgX45Cfy2EblD2shvC6h/Xqn2SXXhkbhhBXkPI3dGXzmal7fQxfivqIHUN+LjL6F0C5ullpKaI46ckfzxN3ewb1Nz1+YeFvP3xsYfN0L8dGIiSnq9rycDZv5kcHtENbOYHCZBofySF3kpHk1vzVTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bO9govuX6fuVd8s+cqofobao8oHLrAhiOvR5kOyDAAk=;
 b=FSFRJVvxvxfSzwnf1jIB2cTeXMEMEwaWddwe4UQ6xhxgumwgVvO2PIHs6IcNLM/LsAmmVD8hIrCknGtuay7OCAASJIO2dJz6iwW7rbZ658CyVliXZY4dgufxuSUmxMm7+WBuxmlrfrg560GQmwOF0/RpUGITNr32ZaKELxNK5iE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB5519.namprd04.prod.outlook.com (2603:10b6:208:da::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Tue, 17 May
 2022 15:27:35 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 15:27:35 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 05/15] btrfs: add a helper to iterate through a btrfs_bio
 with sector sized chunks
Thread-Topic: [PATCH 05/15] btrfs: add a helper to iterate through a btrfs_bio
 with sector sized chunks
Thread-Index: AQHYaf2eTt5uSaCpYE2h713RlulDLA==
Date:   Tue, 17 May 2022 15:27:35 +0000
Message-ID: <PH0PR04MB7416A9EFBE86253DD0DB4DDE9BCE9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220517145039.3202184-1-hch@lst.de>
 <20220517145039.3202184-6-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 397643a8-f679-4969-8365-08da3819c4c2
x-ms-traffictypediagnostic: MN2PR04MB5519:EE_
x-microsoft-antispam-prvs: <MN2PR04MB5519F51185EAA8E671A989669BCE9@MN2PR04MB5519.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DwKddXN9f+Q15R7DzDoxW5zrN0psxM3HXTOQqocIKICtTK2GbC3gYmMHEhCSdRIhVRfBSR+9iQldtJN2nEUFYRfNAif7N+v9/EXreh0scKqhFLncWjnepocdS9w/gwmIz+aX3NjBkhXMnN7yXmO9cCThWcLoeDIcybjMLtUY7qOW7Cu4nEqQ+NKMN27hdltJry8cUXtvyI+JBidJ5B2wVdhwzZKfgqZY8u9ScHjyOEC4fmi7MR1GAjEioZ1bzWUXBpLcpX5FcSKcm3NuO1Klvfw5lkHA9b0hPTi7EHeDf7yISWDdc/bsWWxB2+gHs06fVjrXkOAuX8pVRGkM9rjqHuO//knyWWbPPqi8qWMKdvZLEG6AOQtUNHtxPB9sBT1V35c5SNk9efcyeYGlZvhrWHjdGR5x2F/Wd+Uc0r+w6Pey8kT8DAyOgFFnrE5erjEIdWBYwCM6oLJ3YSAox9q1JxaR18j20jEkwEcL6TuTg/NUAXk6EzSgWSIcrLuaxBaj+36fdBMUury8XRoM+R9nHv8ncdauHwPskJZlYKpHgJ2M3ixzAjO1cOEmS8gwy4axNOEiTuaxDs49SYqc7xOpMXXW07KzArpIMok/9DpkyJLhn8h3PCN5TfWcW9Z+/2Gs+e66n2WXUNUBSpaVDLXRa/9pWRV3xAArWT1Fnuu6edWITedeXxGCv53yLytRd6FuFMoIHdboXEvZlPy+s2M4qQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(5660300002)(66446008)(8676002)(4326008)(86362001)(9686003)(64756008)(66476007)(76116006)(91956017)(66946007)(66556008)(54906003)(110136005)(82960400001)(122000001)(33656002)(55016003)(4744005)(6506007)(38070700005)(53546011)(508600001)(71200400001)(52536014)(316002)(38100700002)(7696005)(8936002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wUW+OLeeB/zicd5ZaPk/F7DRzvw4ZYqEmwZJ2h3gk7bmosoy0BnUX8l7+bnl?=
 =?us-ascii?Q?w5UCAhFnxoZrSuPC8ap+8vY7R0T/Ot9Z4I1CPOFFORollTAut+eYQj8vxZyE?=
 =?us-ascii?Q?ogBu8YgKtxFRRtIBpqpIePApsUcexokJdiujhXQAMxs3Qv85OOiyLkqjL4QO?=
 =?us-ascii?Q?c3DTl66OTjJ3lXSd7MRvo1hknWzB8grSPGdX0A9ujo7OJ4EDugMFWJgyArwX?=
 =?us-ascii?Q?DROxCdvkvIyxP3ICPUQJs2qrlPcJP9RwcT/+AauoMzWJOyW3tBzTyFnPvUOJ?=
 =?us-ascii?Q?zkuwDifXIkihbv8x2QFrV0tzwendsqCx1nccx5dbUI2uRsW4bhB9JngpxHBw?=
 =?us-ascii?Q?oTOGsT5ApMSWz0BJJL++axIdwZ92ln5UyVHeEDSEPfBc2kUSAKTuKSDa+2ei?=
 =?us-ascii?Q?Nozm4kUDwzh0yMnQeWuqVVj17eu+0OLBt4tSoGBTo2LvOL4QVGqLcsIJFFK4?=
 =?us-ascii?Q?0gm+SXd0RO1nP34I07SKDQd0JjEnaVpRgs3gE7ioN60Yqjjs2hwU5ltsz8RX?=
 =?us-ascii?Q?2NKUIjgPYdoyzBV7DmyvW5TgIW3dpbO6JfNNYes4OXPPmjUPrHqIhch2+ncE?=
 =?us-ascii?Q?LgtuY42z2xkJOkxIjfxR4DSN5zE0Vr3Me85dlMtXKjoTwmPFsYC6UU8Kb/9a?=
 =?us-ascii?Q?3gsUaJow7zEYGyAXkFKDVX5V71kAO9OEJba89/rVvac7JZ3gKBlEYBzhmvQZ?=
 =?us-ascii?Q?A9YJ0FhPuvQcP2L2o7SSlH6r2iAa+cdYfavWoWSsRNfUEPG+FBqShuEghTjk?=
 =?us-ascii?Q?FjCZPZuk/USbJXu4TaMXMpr7g789bAnEUAIJSwpAsOJ6FpGUp/2EaPVMmrZs?=
 =?us-ascii?Q?3iI0nUKqN7uo4l3KEMJnso5XDGoRGBj3lFSlFPUmRWpUe5n9tPG6yM2Hky7h?=
 =?us-ascii?Q?r3mNp6IcMJJBWx8t/WKVBKVqQphRLpBQoXW+/C+Wix29Bd7dXkAILnD721Jr?=
 =?us-ascii?Q?AInpI6mPpoTUFBGMff2FHVSTIaF0q0PHjAWS/QO33zXm8IsfzG9PWhI6GJnX?=
 =?us-ascii?Q?5160H1UAi52696buepnC/UILc2fN1+2+P5s9tbg+f5txJ5gMgrJ+1bPdwYbh?=
 =?us-ascii?Q?cLVQufaFd72QuXwm2/wL4GgZPJY8UIKYT2nrLZTJrfRL0TNeByYAWLg0D5t8?=
 =?us-ascii?Q?+WnBbUGSCsermwbBtOekBss2QNaDLcQKoiZ1qznxIgL8+Gr72UzNd0fMyRSk?=
 =?us-ascii?Q?RJeD2/q+tOfcef8j8M+kD1r+NlOZjYD59E0Vs1t+OvG+v8tl73SqFd/9Ji6a?=
 =?us-ascii?Q?pAUpz+ITiDy/IBlymgwMOMCqiIcZmmEhExXtuGhZVSSJP6/Ioy3i6yy5Dkkv?=
 =?us-ascii?Q?rZGMqbqpVrLA9Zfjk5gtKRrq+JGY0OvdFj593M8vIo7dlqunxk4RIw9e2hrL?=
 =?us-ascii?Q?3hqW2TcYG3iQSysUsymafBqo0ylQDUDqD7p/JmGBr7zuMF1ps6f8gES9FqEE?=
 =?us-ascii?Q?v58SYBwiHi/hzpSfaJ55KTo1gOvHAzqSwmPGbzr9IImC3zdznOQACrmKiuiJ?=
 =?us-ascii?Q?j7E1ArznB+rcqj4raLjcr0QSsUDWS3e58k/tk25ZY6Dx5ENzKV9OcL/E6FvY?=
 =?us-ascii?Q?voRq9Z7eg4RxsCUOLH0rN7POUVbYymPrdBFJrawHa48svVS7QC9LnfHoBVOq?=
 =?us-ascii?Q?Yg6sW4dtGFwghFUCawzdhKJx/4CnIuyoTjIU5q3yD/7qDmB0MR3PRcvdBPZl?=
 =?us-ascii?Q?xM7sZza8BarNLzmM3lwjzV3bTrRt295RYH+3zpL9/ReSjq/ZZpR2D/eGxVFj?=
 =?us-ascii?Q?EJeG9Uj0gJfpB9QGijK+GVdhyVGTLiTt0WixfivDFayob/5QnT7T04XxSkkH?=
x-ms-exchange-antispam-messagedata-1: re+Yjzu2PGjWFGWAgt/V166Dgh8dmog0wWqEQ0ChfFy84BbhvITSE/2P
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 397643a8-f679-4969-8365-08da3819c4c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 15:27:35.2141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zP6MXe8J59r9crfCpS6mJtwy+u4bGUak7G8Q77cqkF5ZnIxlO95wKNXy7ymhhqkbQWC/lOcb7HZ/jBQKjJNMGLVZNv03KLP6dZxdBIHklQ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5519
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 17/05/2022 16:51, Christoph Hellwig wrote:=0A=
> +/*=0A=
> + * Iterate through a btrfs_bio (@bbio) on a per-sector basis.=0A=
> + */=0A=
> +#define btrfs_bio_for_each_sector(fs_info, bvl, bbio, iter, bio_offset)	=
\=0A=
> +	for ((iter) =3D (bbio)->iter, (bio_offset) =3D 0;			\=0A=
> +	     (iter).bi_size &&					\=0A=
> +	     (((bvl) =3D bio_iter_iovec((&(bbio)->bio), (iter))), 1);	\=0A=
> +	     (bio_offset) +=3D fs_info->sectorsize,			\=0A=
> +	     bio_advance_iter_single(&(bbio)->bio, &(iter),		\=0A=
> +	     (fs_info)->sectorsize))=0A=
> +=0A=
> +=0A=
=0A=
This is first used in patch 12 why not move there?=0A=
