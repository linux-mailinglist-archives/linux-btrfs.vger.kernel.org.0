Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5D46FBBD1
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 May 2023 02:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbjEIAEz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 May 2023 20:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbjEIAEy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 May 2023 20:04:54 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631F57ED8
        for <linux-btrfs@vger.kernel.org>; Mon,  8 May 2023 17:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683590693; x=1715126693;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5GdnwONbs+MI+VNzMsBsDwAgYnjtfDI5Y6AEgfl51OI=;
  b=iszP91/XueAJiydtANEqR2AYS+WSZBBn4affWc7VRqiE8VmdLQqon0ci
   4ahyj3yrTbnD2pKar8jUyKtID5wx+7nN2O2A8QKuV77Im0h73iYbSTHmP
   6VERhHfY/4qM3RsL1WA9fdpm+48dn1rp9ukQQwzKD81XdtGwmxVE/+AvK
   iZqOt/GnD+R7u/dyKzCa97eiMDeA3LYxs3OZAYcIee53HaKcxcIvZ2LhY
   GfKClCi9OClQkaaJydyah2TkqAXyPFAStDeLLWGJ0PJZMrM02vnGAQ//w
   +vYEVVAVUH156mXSuBbG2S9LUXbZARgSSiyMHX63P6gx/X/KosyEJaRG5
   g==;
X-IronPort-AV: E=Sophos;i="5.99,259,1677513600"; 
   d="scan'208";a="230214212"
Received: from mail-dm6nam10lp2109.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.109])
  by ob1.hgst.iphmx.com with ESMTP; 09 May 2023 08:04:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQ4Z9G9JMOgSZ2qCTtjfoRwtZ051iriNM9SsNeVpLBKwtrjoQbAkczVeukbEzaBmpl+MtuEMZfb5QXjCJvBritKbAShsvFchlX3mCQJXzpxt6ewJRHujA6FaZtI4NoMINetYcpcL9exHtgu+zeYwUGDMWI7tBgRh9YS9/oDTWNUGmpIRlIapnshMr1oQ4zoa8w8rV9fR9wt6iKx70XeOZN9cuA5CNXbfmqmZu0gRMetlLvDnhlk71LKuE38xsYK7zm9mlbfvNCQdZbgBhR0kOM3t/yDzdEwpjq/Y+kpcKvkVyYu0nFTVcy/HP9Kqj/ZrbePTUwmYbt3F8aPzODNpqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5GdnwONbs+MI+VNzMsBsDwAgYnjtfDI5Y6AEgfl51OI=;
 b=Fqh0rXs1YkDFHrDahEpX2z8Hz3Af2jewrxHyg7Njj/XQQWXkqQaiVzKMtI9QoGHsyT1qkQdUTrTSDuv6pzR6THeYU4A+0C1Z5F5HoClx8+tsPuN3gvRJbdcT/ta6woD9XfDgXrympCHrHt8EHi88anf+S7sOD0i63SxDr/lxISX4R4RH6AkkVatUEZRxA7DRBlbB/Z7kKOrJO+m7xLaCPeL9Tm4i6eXeIVHD88GcSgomN/AHY1aKkpeG3AwQXly6kDOuNPTYJ+F5lpR4UKg5XhaG3M3iPTpH6EIwC/bE0RP5slemYRglLTbqFhJ1KigYGiNKfJixG+hlyh3Nt0nQnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5GdnwONbs+MI+VNzMsBsDwAgYnjtfDI5Y6AEgfl51OI=;
 b=tgrJlad4YtkakhNVh0Xvn0k6RcNGl9BFG9Wd629oAg99EyvBESrOg7lSt1ym5mIBmGDJKcTKC+huXZnzfNjUbBY79y9C3ujPjcIDmJ3h8p6COsL2pjNog+Fmucd6Vs89LCm4Csh5qojxEsqWLAa66OP0GFHmgnEiDB7TgVPKWxE=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by BY5PR04MB6626.namprd04.prod.outlook.com (2603:10b6:a03:223::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 00:04:47 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::b52e:3dc8:52f:b0cd]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::b52e:3dc8:52f:b0cd%7]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 00:04:46 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 07/21] btrfs: reorder btrfs_extract_ordered_extent
Thread-Topic: [PATCH 07/21] btrfs: reorder btrfs_extract_ordered_extent
Thread-Index: AQHZgcdwwa3XJEg2hU2tqOPRCNxQw69RECgA
Date:   Tue, 9 May 2023 00:04:46 +0000
Message-ID: <6ynva7csz6l3jbn6pgydnyzhogprdz7ne43fwxxt565nn4t42k@mdaqpibk3irq>
References: <20230508160843.133013-1-hch@lst.de>
 <20230508160843.133013-8-hch@lst.de>
In-Reply-To: <20230508160843.133013-8-hch@lst.de>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|BY5PR04MB6626:EE_
x-ms-office365-filtering-correlation-id: 5c973469-d051-42e2-a4ee-08db50210012
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wVAOUhypjb65Uj/7Y1XK1yIXUoOWFpJNT+NIXNcXu/sm/DhCWa//VJDOpr019LcFk0rFheGcw2YEnZNMixMOYW1LGVCMvZZV0PvAEQUtXiG/mioeuEMYualmS8o5ahfIvb4gdwEypRNi1bmB5i77WD25DcT/lH+U4QnkZBCulsM49s668O/s1aR2N1abUE0Hh4ErLf8a3Gt53XN8C0xivUG2ZEmsfyr3KK2azrkfhuM4fIXeIrFHJ6KV8PI+LIVPiY4lOmuJYiIYKB+OOZ82M83pOIBW0dJpDNHRQdnG7l1GhqZyCXqIRnZUonRKYP18Frzl3D7fuTR4FBjiywUiK3Q4RKCrMJiSgyRompzL2fux1PYg5PVaLthfwY9askvkL5lyBgrJaKLqnEnOntwLGA5qAT1HL92F+zVczHL7iscdsrQuq4RR8ZOlfxP0EdGQJ0hSKaEquX65mwE6GSrP1GzU0mn9uTsJOTnv5usg7oZOc1KcuUIQ8C/+oFgQFkPP7OnshJ+egKVflfwOhBSrGVM+USc8jZF3HLMn9Pj5zPEvL0YRH1Z5VzNUzbfrz7BuQnnNghrt8+pEPZmhj8y8Z8AB+V+Sty+xvuWmn7Jwhu7u+1cFIK1hp4RsfG+0a55R
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(451199021)(83380400001)(186003)(4744005)(2906002)(38100700002)(86362001)(33716001)(38070700005)(82960400001)(122000001)(5660300002)(8936002)(8676002)(66946007)(66556008)(4326008)(478600001)(6916009)(66476007)(66446008)(64756008)(91956017)(76116006)(71200400001)(41300700001)(6486002)(316002)(9686003)(6512007)(6506007)(26005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pSI0n7Yy39+XemTC6WvoN4bhG9TYII+BwZ5pF8KpVrUX7fOqMEqxAFc8SPTU?=
 =?us-ascii?Q?jdqDCYMqpq4Zkwmw0+TiDh2sh7HMR8aSipQBWPcBtdwr7Q9WJiVWG8krrcuZ?=
 =?us-ascii?Q?M8LKwHzFxY94QkLtaKTAxQxDxHxk6GKW6+gEHMKWYLHWgqJx+yvrKbaaYChw?=
 =?us-ascii?Q?V92zoa3ptUAZAIeoADUNpF0VIUAi3IGQo4CHV6w6cQhI1L1d3BKSHg8n0QOX?=
 =?us-ascii?Q?LZsV3nZfCRGbXsNgrWkeWa5pAAiHcbu6sjBCdAQ12c66dIcn5GuiuK5HD5nM?=
 =?us-ascii?Q?X2nDqgYzG0q5iosUeyFNVw15YWWuMwFLuaRsmdoxsXmi5rbTeEylkFNgT4nx?=
 =?us-ascii?Q?unp/wQn3rZ8VyJSQG6p/xDOOJbj4oAaTaYTvl4C8EPb6nIwbfuBmMe9V4wRN?=
 =?us-ascii?Q?rBNUcDsnmldCa7aBVheYwi31l192IVCIAxl6c7vxWagzjeI36TwL9DMQhcBP?=
 =?us-ascii?Q?hYw1nYatkMdeT6tKxVLqrCDkHNXFgULhNrRHs+EFgJvWYUusZAu0hHhs8I86?=
 =?us-ascii?Q?h7lpNo0vQ39oBjUprSw2Qh8L6DonYvOypokcnkdJoh65tPJucKnT9w/HH9Ro?=
 =?us-ascii?Q?sDKWp1GL0RMNoPwkMcnY+lopyUdMJt/X+IEsApLrjsHsPmeOMO3+OAuJAeg3?=
 =?us-ascii?Q?I6KA/0HwQOVIrsnLlN3xsQq1dpi6XQuEQrLRg+zampnLNc20vFIPwQcj5Hv6?=
 =?us-ascii?Q?s9BDCvHfHVv/CvPySOvuuDEBiegQVfAWSKvSUg1ep3pp2+TeaGAE8D5gFA0v?=
 =?us-ascii?Q?p+MGQ82QL5BTlsCHKW9fEdyFCLKvQMRDlM0cNS3em1upqcpW55KvSPgURx5a?=
 =?us-ascii?Q?O0Hac1xaPIlbl9xXC2v4b3fHDIY4gYZSXjoLM3PY2XrffY8ywf0019D0ACwZ?=
 =?us-ascii?Q?jUF/wxRWVM5g1QZvQE81tmRWBuaBXc6n11HcRdul7xmT3nm1tAbSTaG3ak9w?=
 =?us-ascii?Q?hkX+rWIA4tbZ24/yPiQR58jcrbBhN01cltb4o07FRUXbLg3SGSODL0G/uPwa?=
 =?us-ascii?Q?Sngs3nK794+tzB3hG442+50JN2diPCAtHOdnh274SqIizXmIy8ZSKJzPYQsm?=
 =?us-ascii?Q?zYYbBcePkRuTRxbTOK76l3RYnurPpP4puthNJO2PrtdqUgaEa9Y02InChJVP?=
 =?us-ascii?Q?ETDyVfJXc8k+1/GYVQOy3sU1wZFJoObNjGqqKp4UrjlTnk8mvvMAgBZY/IeE?=
 =?us-ascii?Q?CCpmbvnH7OZ7cWHz8fAs4za84CsEwFS6Czin6aPFdmAqpxxvas4QlV8rir4S?=
 =?us-ascii?Q?Kl5b5McA2hUVsKVTlyI8KKRftWAfHI94+EB+w/O5CjsBR7/v+qNXLsMikcJJ?=
 =?us-ascii?Q?bbbrAOTD75ZG1rlkIJ2P6A8zx7CZ+RZ/l8R02d8mbGZ7cdnASPCDQ1p9i8RP?=
 =?us-ascii?Q?MpSlz03j+iepViscNy6w0iT+xPu8mA/ddIJSR+GLlP163NQHJDFIHRAGgbDp?=
 =?us-ascii?Q?A6GSQT1RRP0AxHirIn1+MGmz32LI70QSLcZ0H1XI81G0XKCKdmqe0jpYX1qH?=
 =?us-ascii?Q?HP50zv4YkfLiu5lPWMufxl76t/iS3KZPbmxZ3twVMaZg9bgrRgsnvYh1Pp1a?=
 =?us-ascii?Q?HTAgZDJavLOs9uUFB8y2sfQ01DILQMCSaBQr68Sb?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F99B490853091E469DD470635CB96FAD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: O4WrxyC9qFKysgZIKr25kmWGI7bYbOARqJg1QarTjwSXFkpdu0TKbC0IvFP/Vlq1d2tCJFNF6wwfslhed5l4s1AC69NlP/KuqQDNaStnueGzoabGFbZfD8RlK7DRKAPZvSsYBvvMXt7HAYDDjWkaBVz5spfNRmGPKPKdOnljK6K3ccJtLZ6TnzGXTitdX+nvn+ZrGX8qM466uL1GhswwSstIWxwPkFApce6RkIJl/gND2MLsYealh3+7bVG2+KruNPncql3yUi1UmGZEM/yS/Epz9Wd9lUEN/V/a4HhW5fRZPpCbAsVYK8EjTPYXPVNIq+ODvvmhnq37Px8hqA+tjGiMPSaUNMYuCKU+Q74YNlcjPqUnHiuas2d16HYNUWK4b6OS+e7RDrxKkvxcsPtR0ActWfzChXweB6GRn3lud02OSlNXkjGrxo7nZGPXDq54xqvbBqylfu3QjpPHYSl4lRtaJ0sauWqbpSIif1OiKewFmQUCj68M6J7StTgfPHzsrBCJp+cVQr51tyRu05KNpFuvzw6CyGZEwVzNBdGHijJ33z6vDTJdlnx3USFHpGSDya9lIuZ3WgVzzbl0nebL/JeYOw56mXq8Icv2dbAfHvuyxuh+qTsPDpgYrX03cwNoQAhE42MD4VB6/XpLEeU4FRYLPzwEL8hDGvNSRPthKSMTONGQ13J/o4UQFZWdV8EhOvJ9lnvLSt3aHsOCI1mvIj61kp5NxM7ThrszllJoQ9lN/i95C2Eh7XmlbI7+HwBogguTC5rlXX/eZkngtyIF6VeMcFHzp1QQ8FLBsGfkg4GFRjIfIUck5TQas+6SszUS8Y20uOyWNoZkU6Sr1PX4ya/QGgenIw/Bbtf370JrELoW2ifk6a0+BJnkJv2+Gyjj
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c973469-d051-42e2-a4ee-08db50210012
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 00:04:46.8164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wMkehBujTrnBNOtMeBm5jcvVfiwIWqvx/yOTjVHE4o3leBppGnFQ+NY0pCOyMJHwRmxwFnyf+vJHNYJ/qRJ4Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6626
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 08, 2023 at 09:08:29AM -0700, Christoph Hellwig wrote:
> There is no good reason for doing one before the other in terms of
> failure implications, but doing the extent_map split first will
> simplify some upcoming refactoring.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good,
Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>=
