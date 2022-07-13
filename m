Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27335572E5F
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jul 2022 08:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbiGMGqp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 02:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiGMGqp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 02:46:45 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F95EDF3AE
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jul 2022 23:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657694803; x=1689230803;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=PytU2bDYxO6n0VW2t6ElOJdA9/SZNj3yw8U0LLbStas=;
  b=Ya8imtfbbYOVz5xV3PEl1Mmi2dapur6y781x/gzAxpH3ESNXppjuf1Dw
   VeKHm2MAZFHCLP6raGsM86SQaj161/LQYUPM9ebR5CKeWGj0jQq+etpHm
   6njdzPs3/4J/clHxEe9+/LNxAoIPozzL6g2AKvFh92mN4iXlBB+Szvbnk
   QkD2uoHluuqKi+DhkIslUQ1whAlAFcxB9udwolCSZZNHsX2I1t1JdGEvx
   n5RatfbYdGncgNmEubajryRBxaornj0ief+H7OhN8jmdc+FhX0f77mrE+
   CIwPdAqoEEMbk1CzZkY7Wd9WA5pSr+5oQH3/j6k5oxdsOUaBF7u/fPDnW
   w==;
X-IronPort-AV: E=Sophos;i="5.92,267,1650902400"; 
   d="scan'208";a="210525054"
Received: from mail-sn1anam02lp2043.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.43])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jul 2022 14:46:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hPeD7laC4K2HpbWC5Ue7tw0xhsV8Ar+BWXgu3ifmgU6FtSjgxvsAoTlGhq4yUe6ggw/bugTSqRbMPTidq3rd6K/GWcAi0q9l3zhw/mvRR+9wXxzjYXoz7rlBrZcR6o+k4B8giaiXJiTfDdzZDD9uDsA7vKIvaW3Rx1JFOY+ILYbcpgJJ/4UQuDb5veud31gIsoOanDe9CP5ci5CYZiRMIt+Xjecd12DgnbEnmwlFL1/prpv2kKnMO4sCJFkvY985Ow2f3AgTpRIpe2PO4rgjpDrJG+/ONYGypKVUZxDJ3OTv9fyDUYBNRkgdhSLuPHSVgkfRRcGPqTLXRZyJ35Q0RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25OKZHCwULPkEUxF9378XaiFpkqytw+8neSzTaWIlcI=;
 b=m+YBDyIZNlHojlv3TmUOExLicOLuT0rz0uJD3aSmt1zXMyzdPPOpDYr+jmFT/9b3TcLFzhZg7i66zOX9hpoAKRumPhLFEB8JWGguusIKzrro8xQayTzdThHOQJtSDfMzADHC0E92+qI9X8HaO2QaKumDLQzxloOYKoK7ZibkSmam2/wQ3Vr3JMP7IMPDj6wkW/q97WkcPw5rqu69Q0PA8sBGrEDTnGA7slOXts4JTTXOa/iubVvCyGLQOapa1XEgUmR7hTUuCk9UnH0BA34/+zqqopM5ZXwuycZE7DmD7bExRdQG+z1CwpzLWi5+m15MHqDtd9aU034xg3m7N2W8Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25OKZHCwULPkEUxF9378XaiFpkqytw+8neSzTaWIlcI=;
 b=WOsnAbJuvyTNbzLEh1Fu9QCgx8tR1l+ChjVgt4qY0F8xQbFF8fr01pdt11BWpQgA7nd3mVLNatPwGpw5SGrUMoU6PcQbbfYy47s5gs+wt3Rkhz6jmJBmHbnXkqglDzRZezyQk7+lObsPf8QM2sJYAzgEVV01HbJeJl/EO05yzuo=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BYAPR04MB3893.namprd04.prod.outlook.com (2603:10b6:a02:ad::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Wed, 13 Jul
 2022 06:46:41 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91%9]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 06:46:41 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 08/11] btrfs: split submit_stripe_bio
Thread-Topic: [PATCH 08/11] btrfs: split submit_stripe_bio
Thread-Index: AQHYln/MDXBrHKhcRUe0tU5xWuvWaw==
Date:   Wed, 13 Jul 2022 06:46:41 +0000
Message-ID: <PH0PR04MB741681A236D9F0C0F834BAFC9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220713061359.1980118-1-hch@lst.de>
 <20220713061359.1980118-9-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a78af1c5-e663-4457-6a81-08da649b7162
x-ms-traffictypediagnostic: BYAPR04MB3893:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bzpvHxdUouOx9IDTsmx9ExZPQicxegCNo3AspKIL7OjOk1FsycMMZhU86d2xYK4owCWQS2yLAdtPUF9HbSAe8navFNBaRutapwOkKnoXWL1NTDXUio42IxMQXXfeWkF4gZyddCpyZOWGP10Oz118brYHq8ptsZbd2aFfslZpJMub4Lz2726zeljIT6pxiAYNKN7j3c27r8BFtrrmfU3eVuN7+ASTPRNeJMKutmIFGPiPCAyL5W7S/esRSnUChKxb+UC3LI9qp1XUcBgGv8cMkcl+om2I1KHpwE7wgnnbyp2jO6zPw2vPrr3pL6rVKaZ4YPcQ67L3aoMxqWz/+dWD8kPFMG7yR5N+5kgTxJV+VAT/HaR3/9rfo1m3naidLeeM2rGU37B+EHWGsdQKH+rQONxmjmlRGZAN9j+Q7smLdC0EBtWxYS7gW79bIIaGMSguCvrkSrO3IYAO/nUF461/5lzjJmYEqJ9qcfST2Ppx299H3KV1dW8CJYLPb4kVXx5I/KbmCZOX5LVTWuzlEdH+0yn/gz59Ea7QWS22uhmyt9HnCzFTFQ0q8KWphC3rQ4ey0sD7K8ANckJQZ+4EacWjkwo2rCzRxc740CD4UGe0tuMR+bzeEe/sVlMF5pD9ZriPAWJ2pdLahKgA947HgILD+9yhSaoe1PxMrx7I/ZSkw07HOtMJv5vg/CI7yCyFyz8fJrXc0l3DKfn4RobEY/GW8gCw2YVpb8SKUJXAYtpapnyiTkRLLpNiGUqeorpKDb5H5he4QZLRTBvvY8jBz7CoFc7z3Usx2CG4BQivT/QX1XXBngWCuY2yfnzkk1Cv56Wk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(186003)(316002)(478600001)(6506007)(38070700005)(110136005)(7696005)(2906002)(66476007)(8676002)(4744005)(76116006)(66446008)(54906003)(66556008)(41300700001)(4326008)(66946007)(64756008)(55016003)(53546011)(33656002)(82960400001)(5660300002)(8936002)(91956017)(71200400001)(86362001)(26005)(9686003)(122000001)(38100700002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BDJpv82prKqBbb1hzL0j+RBNTzuLihBD7Lui4qyb8Jt1YLZKID7pFjzmce3I?=
 =?us-ascii?Q?tp4ED9x6v06NaOkydjZJAELHgrmHmNNT2F1N/klwm4q5PrQXD1qw5ytakKnS?=
 =?us-ascii?Q?WF4/4jhVWASz47a+yMtj+w+SRmhpYch3rk88kKhFm7/NlAKs5TyjoJfLB2le?=
 =?us-ascii?Q?6lI6XhMB/jCD0dac48DQ/+YVdJpJVWgkuYXBx3IkhFlyVn+XJKx2UbqaiK9x?=
 =?us-ascii?Q?hSxSeNET1mfucB+YyIOy1x/z1kGmFReh+JsLMIZaPynbt/jceTgKMZfQklYv?=
 =?us-ascii?Q?q/FZ4SGr8njgX1ufHCadrmjF/V8kU4w039Swvb3KUDpLLGIFDEVP/vkPuPL5?=
 =?us-ascii?Q?6ALaj6M0lceQ9rCZ0Ib1qCUriVteNF+T3J0IsFer7v6y32UDrjx3D37bs3m7?=
 =?us-ascii?Q?rFhL4N4RkXYi3GIl8QaGpGZT/ifMfTpwmwsjqkwvf9yneou0PDP4SK1oGz27?=
 =?us-ascii?Q?QIXJHh6UJidu6sxPzUnmjVSYWeaNwzd8tqMIRmrqCHj2M1h80dt7YeYaZGf5?=
 =?us-ascii?Q?IdnFuiOmpS7S0AgMRUwN9GFf+9bMAhSo2gpeadIRbLqzUFvVsyGCbLVABiqw?=
 =?us-ascii?Q?yND5u9/V3P4mjLUB6r582uWMQXtIoAzSr8d0B4OHeGmj1vmgc5brIz0MriBj?=
 =?us-ascii?Q?VcNO0ntHz3iIlOUT0/hRUiJbmxe+emiRY11JHWzO2MyC6cDn37cwEp15W/8n?=
 =?us-ascii?Q?18qJ92q668Dl5swKvmXDP3G8BGjuzZLLkH4AvNHLOZ+yVESgrLgYlhbhB77C?=
 =?us-ascii?Q?KVUxW+1WvKEPnywKh4FNgGt8mwICrYl9suqdFaPzOL7Yd2Tww9QnYf7lFxIw?=
 =?us-ascii?Q?0qNJZrfleJ5KB67S3kPFvGipd46A2H3xQeILzLxgWTlz3K38NRv8rmdqwwMb?=
 =?us-ascii?Q?KPNLkXAD6ep1lVBmMeT1GQaQ8Z7awe812ttkXkk95MkB3WNI5H0xSGSiE5Td?=
 =?us-ascii?Q?BgE/1OL/pGDKkpfK4rFGHiqFviBQGCTRQS/L3vzXLdNOvbwRUXweyFi1jF1U?=
 =?us-ascii?Q?gQQNe7PwZA9hW0L9rsP2FhGdRtR6zXXwMdzjMEC9ysBLHzDvquNJM6HsLs3X?=
 =?us-ascii?Q?hteGYGMg5l1Bm/c3RcB35739uGy/zYlCflsT1nbWbRt5hlC/TArvurCKNn59?=
 =?us-ascii?Q?REoTaxE1egW26aXFbtOMVIj3mpGwFuldhsRI/N5aRHGYx5xDuS/XfdD9qOic?=
 =?us-ascii?Q?rwkO3r1sW8avbQTai+t46Fkfcn2V7L3gZMlBZDUGXRl/fDTy5dasAuimKMRN?=
 =?us-ascii?Q?1VQkO0WyHjqyXchruVpwJn1qIdVdR8qB+NtNPk4VxI5qqjrWmaQp0L3UD2sw?=
 =?us-ascii?Q?JgRHPqaR7+Hdp0hhUmkry50ispZAmM3HYXIlGziLVNHsY9fEs7KnL8n+hm+6?=
 =?us-ascii?Q?Lvt4GCs69rjcUfFDADAQ7ujma2QLEzN5dy/KpHbP1A6QG50+qXprQuBi86m6?=
 =?us-ascii?Q?LCcz9iLqb6EqOIDzgyDKJTC1yO8qlsGexQxzEBjULhKXGVFE5pXY7kkpf1wN?=
 =?us-ascii?Q?jzHZQE3RAeTFRPXpNBROYEXMaaB0JiaPuNjsKtqRHEOOSDBI/2TYQusSJTrS?=
 =?us-ascii?Q?Klb6YTE5PmyG3hJiXaByyvpfgT2TgRFl2jJi/Dq6K1uIWr5sVYdMpdF34bXl?=
 =?us-ascii?Q?tljX+myebZllzKk/KJa33Kg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a78af1c5-e663-4457-6a81-08da649b7162
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 06:46:41.0704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M08XTwBb0krFLKnd8RsSIz6XQ/d+B2LBhY94kOf5btzIffxymruoSxGTkJ3un2XP0ylTbwCYCgJgHXWtm0U5OPpmx+4WPG7HcLxA+u6DezI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3893
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 13.07.22 08:14, Christoph Hellwig wrote:=0A=
> +static void btrfs_submit_dev_bio(struct btrfs_device *dev, struct bio *b=
io)>  {=0A=
=0A=
Nit:	struct btrfs_fs_info *fs_info =3D dev->fs_info;=0A=
=0A=
so we don't need dev->fs_info for the round_down() and =0A=
btrfs_debug_in_rcu() calls.=0A=
=0A=
> -	struct btrfs_fs_info *fs_info =3D bioc->fs_info;=0A=
> -	struct btrfs_device *dev =3D bioc->stripes[dev_nr].dev;=0A=
> -	u64 physical =3D bioc->stripes[dev_nr].physical;=0A=
> -	struct bio *bio;=0A=
=0A=
