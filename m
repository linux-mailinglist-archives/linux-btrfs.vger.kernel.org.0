Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2464E9833
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Mar 2022 15:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233986AbiC1NdB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Mar 2022 09:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243135AbiC1Ncv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Mar 2022 09:32:51 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE1A1A3A4
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Mar 2022 06:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648474268; x=1680010268;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/uD3vMC/PQt+bkzQ2Tm/vBeWy4MYcegFWRMm3Ebr+JU=;
  b=iq+4rbWTyU1WBUUqunOxEkg2WqTS1PI010Ss8rNYeF7WIt7JjkiLzS95
   5vbnCo3hMrepZxagjoBgzgDlMYihJZZ5yv7jTuSCS5fGOwuhq6E3WLevn
   Y9a00P6WRZOZD4sdYsQMTwl44cJ4AbIdfOH73PuFGYSbSqdovM8rRzM/t
   Yt2dC7NlUpi/YDDtHQAuJK5W26BJdBm7uZ0LWuzlAegMyMmv2v25r2Jr1
   k2SGDBE2RQyCJnlJBHxiTzK5hMxisQuoaiH9RAH/GsUjs+1APhDzcydWa
   LW201owbEK61qmpeGIFUKxoPeLU0kUGMAOaCnWAY5XlvALSnSb8RTfKtM
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,217,1643644800"; 
   d="scan'208";a="196449409"
Received: from mail-bn8nam12lp2173.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.173])
  by ob1.hgst.iphmx.com with ESMTP; 28 Mar 2022 21:31:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMjdsFf6o+m9H6C9rZJGALkaXiVUM9zS9+BFWyZSxgCZmN1lsnExQ3iqpxBY81OFne1XDXQRPT/ujmeLtzE2FmGwRW22rUM8+yPGaZIHgtPseO7jEtwuTouBO7VOPjUJ+rkSyOFtnp4F31HENQ3/GDSW4oBtbaiAmhDCFWzws6DdoFCN7tMuAu9M9Y0+X3mb5JF6DDuD3FUOHMjyEdixj4ACnG272J7IVtMo2l5MY+b8cqIUn91n+7pPLAq1GBkxAtnThroKw2VMVM3I7hzrMwZ/tamamxU1g1Jag3whTDk6Lk0MHRnSoHLSBYATmz8kbHdxhB5tKeddszYNI8Hu4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/gQ/9/y6uQqFSMBDwZodhpvYrhXlwAYXCwRZdiKJG8=;
 b=Gn2vyswhjTSS9PQOvmVAmd1rQiY4BEOlC7aPNHZZuyHQ6ss4PHXNa0S6X9haO8fmFuPlHGcmnziWjWEKYszYBplagE8TYEDzjVtRF8Oezf/4+1BwliUNJJxkBoKbN/PJ3HbIt33119ihiBxS4ZSaJFfYzm1Qo7aEOmBjeev26a0rTFWseFE3zTyrI9h6VqS0nPHY9so0decOBrhFpgd96P9xpdw2jI8nN3vNpgorAwUoX68D37B6fprlf3qPxNpPsY34XzGa75/nyjV+v6lYYpVSr6qLK4ZjEx7De8h4Cg0ixMDJUoAqgSy5ojSO0RqnANLBZzcMuV7ZHoPGaQqPcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/gQ/9/y6uQqFSMBDwZodhpvYrhXlwAYXCwRZdiKJG8=;
 b=q9F7n0/jFHKyJmGsb2LnPoQSHJizTuKLKsinBmLg83Wo9hibayotBDp9YtzXp29N5cJIKvxr8Cq5sOHWoJ3XWPy73HYakxCC5eTi2WtYFzfWXjZHQGylhbFZEwbUGLifKnZ3Vv9WJQrgMfPcrxvSbmCCOBdyIHlqCB2NjCBD+R0=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by BN8PR04MB5700.namprd04.prod.outlook.com (2603:10b6:408:a4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Mon, 28 Mar
 2022 13:31:06 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::8d96:4526:8820:de4f]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::8d96:4526:8820:de4f%5]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 13:31:06 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/2] btrfs: fix and document the zoned device choice in
 alloc_new_bio
Thread-Topic: [PATCH 2/2] btrfs: fix and document the zoned device choice in
 alloc_new_bio
Thread-Index: AQHYP5+Jnhg0j6SKXU29xkjU4dpmuazU0OgA
Date:   Mon, 28 Mar 2022 13:31:06 +0000
Message-ID: <20220328133106.gbwzjxatlell3xsw@naota-xeon>
References: <20220324165210.1586851-1-hch@lst.de>
 <20220324165210.1586851-3-hch@lst.de>
In-Reply-To: <20220324165210.1586851-3-hch@lst.de>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c1bd1a9e-9ef1-4f5f-5929-08da10bf369d
x-ms-traffictypediagnostic: BN8PR04MB5700:EE_
x-microsoft-antispam-prvs: <BN8PR04MB57000E081D6AE1AD3A7DE3C78C1D9@BN8PR04MB5700.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oOO6jcsY9OClGqfFtpShbCu3NT9CJZXL39Np3NLvhaH7HOtFCh7gzoEcDghcr9D5yBjNlQbb3GuBZZgS37mdeX7RdboG84ila7srD3InhZ7fkC1oOxEYoZ8t6qkbxnip5sAXHYjpt19DSbs46hlkiI/hCNTh0ps3QVRuFaYD7oTBNiMroG+bREPGDpIS8yQAL5Q8YFhmBEzW4tzoKSa1Ft1TK94gtecLbEsxZjoMRIeO04H9yPQmHm8+tkQmJrF7qJ2It0IMK3+mlURywl7ZL71uulD3r+2VSS/JwK8EZwv/lc2VjsbQknkg124iWM9AQ3Rd2mMu5B4HRho1p7v2PeaJFzeWItMZp7Rpl6t0OQdVMhF9xoVn744jmTX1xBCV/9YAF/2yT7ChQQ6XIxEYF3VOPIEkIRcvjoQifzpbd8VjqyNLfvnD5gD1TBECn1qAWJJW1Z2IELKLyiWJroorV8Id0cJt2QVdOQuZkjegfwv0ZdYvC2v5WAJrGg6ScZEXhlwwmx4y+qiu3y+TK/D5b86kNDGXIJIOoqPkf2KB6FMJHws7s9kSFqRNZzQELKbevRIbJ1u9us6uXkMJChtqPwQU6+O9kTyQY3IBQkiFhBBsueoSzVwGhTueG0hL82nWBzgGrpPlmXQz/l3mCImrg5PN/VbLRUGyel/aGFVHXlfXCjxBGS8mA09r/AwuMrq3BDV0KGX4wLJKoi4saP+YEw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(86362001)(64756008)(122000001)(38100700002)(82960400001)(54906003)(316002)(6916009)(66476007)(66446008)(2906002)(38070700005)(71200400001)(8676002)(66556008)(4326008)(66946007)(91956017)(76116006)(8936002)(6486002)(4744005)(1076003)(186003)(26005)(33716001)(5660300002)(83380400001)(508600001)(9686003)(6512007)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NH6hAzZ2uEO3SQrDj0D5Eh37vzeCWR9JQ3UIG58O4ap6e29shIv5G3smIP/r?=
 =?us-ascii?Q?WJMz20bSVHQTTdguxvuYh7wbqGTtWIw/MYEwB3U332RoNPdvWyuQRSMgRQJp?=
 =?us-ascii?Q?4bqNE0tU3VPBnx27IIfiPtrlYvHrdrE0hw+nKAKsJVSaB34nujh8ff1DYFQg?=
 =?us-ascii?Q?kxKi3kZDdaaKwBpojuneR6BKWQP64w9uSrprJO2Tbxogz9B9344xyXEWe60k?=
 =?us-ascii?Q?B1SSHclwnq1dx4fMvkO1fVx8/Hf7IQU7EtOQZUQ263aHAlW5qb3wv2QRCc3M?=
 =?us-ascii?Q?9BrpIKUuTCJ4zVvXVfm4va9TlueI8crxsQHzxkUrTbObg9ch+jIP5Ug4YdA6?=
 =?us-ascii?Q?QL9jbFZvXdPBPkr0s1g2uFDm2yBWUCemNVPTORiqYqqi83WbkgYgkbOfQKGp?=
 =?us-ascii?Q?vPWV3HRUWoeCPLhD0lk1Fzh7XUTtInaEwkNe/yd4adGWcywf8grBN/exMD3U?=
 =?us-ascii?Q?6FrPnpyxIdVS1cP4iO29DHMVVEnAGhGsN2JtsQ/jZFi5DbUb/ykVCaXyA2BX?=
 =?us-ascii?Q?5U622sZ0In73Wjwc2Ig5dqZ/80uBlEeCng7BbofhufDxtWNS5kuuVaB2vxb0?=
 =?us-ascii?Q?VEZftlK126I5++hV6NHnAdbyLVmqFWaOUBu3o07FWYT5tqb5KEvseunDISJL?=
 =?us-ascii?Q?udmv3I46rtt0miqktOmaE+rUDDv20Hm8/REuFX8sXozf6j+B2tl2Q9chaWzE?=
 =?us-ascii?Q?V7Sh40j3fK0RwHab7zOB9HDqAmlqZ3tlOa1611hX9Jndhbl6NzPT+ENGElyP?=
 =?us-ascii?Q?aMwafMovks5S3s3N0OKumBon8qfoDRc0SqbmvcUMFkmsgVXQtkTidoNp1rKH?=
 =?us-ascii?Q?U9EHVtk3lYBSXF4sa+R7pRkpgP1LXFruFt/CS+EFJexwbbijm4t9hcONjTyj?=
 =?us-ascii?Q?THT+Z4KBFiQJAb1JSzA/CarG1Tet629bu0J69fAGLrIe8OlwO5ju1xMuIukh?=
 =?us-ascii?Q?WUFnqA7VzLlH06lB5C7M65tRGInlXs009jzrBgLjgJgaHFIflVIBABE0QHL4?=
 =?us-ascii?Q?YWYgacogjryGAd/SH1IuJHBM1M56v5YveDJ/+R0+gIVH95ZOK0ap5Q30vPk7?=
 =?us-ascii?Q?fXcX8fMMJE4PQ4gxRAPN5H5va323a+0giYOIzXu75Cp7E5XF3UPPWCtfYTpz?=
 =?us-ascii?Q?0h/DsTXrUoK2YCM6L67L36Sul+y65Z5K0Hc9E+owExhFgSM55cqPU0She+sI?=
 =?us-ascii?Q?W4tvu5dG9bInRrfEkmL+3lojsYTpcKDpAVyjb7Zpi9pW2jDWCFxaUM/vHtVE?=
 =?us-ascii?Q?MPpWEYWLQZcSN+Dn6Cwua3xnJ7hdWImlfqg1JqxPpE3Oz7zluc9dmohmg9sp?=
 =?us-ascii?Q?eZJsfXrAHlf5kUzazan6KjUbfA5fcHQqEkTulZJSTKpTopALtqcnPpg3ce2P?=
 =?us-ascii?Q?x/fZR/I1NWzsXY8WUexHvkzFEuX3q81cqyFMbUumdDCPe3Ka7Pk+KFzpwD5J?=
 =?us-ascii?Q?ahq7gNS05cMXK5lYrv1reIUv+I+B6SOmPlJgUqqZCjU+W24LjhfBhyvIMLaH?=
 =?us-ascii?Q?7GBVoFwNUBdKc2ttl6siUayJmrceYjOHY9ZmhV942ErZKrbuOO+WuNpNr6fO?=
 =?us-ascii?Q?8tOCt07oX+Tx6jCvqWMZGTtSyNK1njpFvVjSMxXI9V4+ZbRE6pbZVKP7gJF8?=
 =?us-ascii?Q?TTC+PhTQ5FndTyEKchCp9kDyv2hnkA/RhHqhTSNW8+h8dQoroKyfpLf485yD?=
 =?us-ascii?Q?LcvwgHA3EDtUrM8Bbg3JL3yZXJ8JEbmnPFlKnD8etEeVlhqmTFKpUB6pTK1c?=
 =?us-ascii?Q?RPD6sTJAG3Sh1YyHK3G9McvvniyQAcQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A7CEBDF76EF0CB428633741CBB91E856@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1bd1a9e-9ef1-4f5f-5929-08da10bf369d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 13:31:06.6644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KeRt6mzOzd9iw7P/9gwzoqxSpH/fVyt0FVfrOzrO4VaJW/dgcYk/in04G3tD8YX4RZol/4hXh8V0SH9dboU1nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5700
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 24, 2022 at 05:52:10PM +0100, Christoph Hellwig wrote:
> Zone Append bios only need a valid block device in struct bio, but
> not the device in the btrfs_bio.  Use the information from
> btrfs_zoned_get_device to set up bi_bdev and fix zoned writes on
> multi-device file system with non-homogeneous capabilities and remove
> the pointless btrfs_bio.device assignment.
>=20
> Add big fat comments explaining what is going on here.

Looks good to me.

Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>

I'm wondering why I used the ->device here. Maybe, it was left over
from pre-btrfs_bio_add_page().=
