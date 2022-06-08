Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB67543ACB
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 19:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbiFHRtk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jun 2022 13:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbiFHRti (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jun 2022 13:49:38 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C797B1183C
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jun 2022 10:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654710577; x=1686246577;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=b185ATgg+/MyqBPr4knGx4PKpCvsZnwiTyv5K9meC8ULaosyT5fmkDtJ
   DR+cKBPzJ+9osOKV8xsdiMzhQRsVi3NvO9FqpPlOQV0ULOPgPW7YsPpq+
   zIBIGvFon3KpTmEPfNL+RFZ15TcfpzGOIe5yCumQe19Euw0A8R//ogbk7
   lRImE82OSjPp6npMzK8wDcwHrCcQG+O7KwObbir0+X1iz9I9an9Y4pZd8
   DW+XWoo5Qkj8UNAsncbhkuxIxUQ4L6QRMDJJPu0a/zxEsKMrpLaGFR2FF
   rmqEwIG8x1TEkR7L4MpHmqLvw+vcvJr7NQ5rU5f6qQbXtiNCEWqeLEZhS
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,286,1647273600"; 
   d="scan'208";a="202624488"
Received: from mail-bn8nam12lp2177.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.177])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jun 2022 01:49:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZhrtAspvyh0clfCk9ixh8KDXSpQ+zf9OFXMXTu10o5Goa1D5m43sTBsl/qSJgZbjhVU0xc+NBsiIOmBu7qAMYctHqCEnqt1HDSCSslIxgZ0iJQ5YrksrQ9mdRqyzFUrJyeu8jRWHwS3p7verLmaZ7qBa4GdwY1HxUFXol45sos7QdCMgNptnN6foDYLDBlJnijsgIzvwZcMyHOBBbYkh6ABClkjQ9wz3BaCQMNnYPwK147BedpbQ4Vhaw+weozWd446+Alu3FWQY7RcRA2ojVmUz97CrdU1MvHQqdV46Mb8xGwTI79uZxDGiODL0c8rZnDbNMifhlGjYTXeR9CcuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=g0cWIPNL0ZXKFCIer370+bfuqbl5W8gecTx/Uv14iMkO7hG5pH2qvpwDkWkqOn8WtsG99Qc8hG7mhhAZLiOabA2EZDxRwI8Mg9OGPmEzEuI5vha03G1RMSPIkXtMFCLPbpiMmOq84GpHo0+7Di0xdpuMujoQFN/9hYVoffbWxVktWokkb7jnheE6bL5BBthpdq4tXZ6EsA/Tb2fto7eTGYAh4et9qdqhX59jw70ktzaFeeyLlfAm2gLxMpIT0sO0vao57wOs4FM4ppCjOyrQN+SrHqp3fPM4GRX+CekDBrVxd3YHI+cuvEhXr11EIKgCL4IKUXmiapH4n+S/etX6qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=f7w0tpDvnQbWNdBAbmFpdIkThIQBVE7PXnOWktE82ygzpbh3/GF/+FXLx4z/BmHow9QJybzcOk7fjWzXsGu6zz3Tdyj8eTnQEcKLhPO8kjin6ktqUaGiEkbsZI8VGbC/B+5g8kAL+dz/s0dNIVg1HSFw9NvSYxaPRUsBH+QlsH8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CY4PR04MB0359.namprd04.prod.outlook.com (2603:10b6:903:b3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15; Wed, 8 Jun
 2022 17:49:35 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81de:9644:6159:cb38]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81de:9644:6159:cb38%5]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 17:49:35 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     "willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH] btrfs: use preallocated page for super block write
Thread-Topic: [PATCH] btrfs: use preallocated page for super block write
Thread-Index: AQHYeoXcP0ZIGnwk/UOxfosMp51O2A==
Date:   Wed, 8 Jun 2022 17:49:34 +0000
Message-ID: <PH0PR04MB74165DC0AEB9B646A85FE6EC9BA49@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220607154229.9164-1-dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 46c844b9-cee2-40da-9921-08da49773ff2
x-ms-traffictypediagnostic: CY4PR04MB0359:EE_
x-microsoft-antispam-prvs: <CY4PR04MB0359CA8DAA37DE7C9E24A8BE9BA49@CY4PR04MB0359.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lF6W3p188yc/LxoCw+/c7OwRVbmPwXaE1iDC3Y2C26yWXhsBuio4TUDC8TUZ2Mcos1mYPIqYOfLz1pvASMj8F95vPugDTWZqdudbBFL3up8pOFl6EMUS3cOwQ8Vp2qB5xRqY5hb4co1GVm7Nfj4TOKLy2X2DCYPjT3TuCjmnh0F7cDAYbaZbW/IEAY/ggtZGdE8biVx3OVW+JRHyh5Oqf9guP5y/6QpktO/lF8pjx+3ghtorWmk/pkHY4fwo6sSSQkhK+gYiBE6PxHG+Q268wupSOZAicMH/qPHL3yrHLvR80wu319Emow3f1R/2M4hhXVqaEwb8YVz3G048jQ4zWSUhd/HAuvFgHxSS/4KUgWjs47yCyfZFQsRQV/SVaXp23QYzBCFvwjqNgTMCcmgL8qVJzywYJHD51lVBrE5L2LA5onMTVtEla11uh49DdCk4uT3HDpNiaAxVff3gA/8u75eQ4v/bwjmVaDNvP2hytvl15ukvQYXk79IRypC4rvS8SbjaAjTjrxnAVnuARPmfmNF/MMJzE9Pf6ZAvZaTcdacXUYjSr7mp9jJ8qzuy/kyxrr641p6BOl/44NUcd7+rhlpEF2l+3Oqi+QGx6VWcnNJpSTw/ggNxUXBF8Y383ucCHNcHFyreGh+7G2PjeQ5+UNUb5sF390bpl4+Lr41iQCVs9UjIapcDoZDy33drYyJ5aOsD/4UYnc2F+xbGMITQAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(55016003)(64756008)(66946007)(4326008)(19618925003)(71200400001)(66446008)(8936002)(91956017)(66556008)(8676002)(9686003)(4270600006)(6506007)(7696005)(33656002)(66476007)(86362001)(38100700002)(558084003)(76116006)(110136005)(52536014)(2906002)(316002)(122000001)(38070700005)(82960400001)(5660300002)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DNaFVtzDl/5znrd6TyPU+5zyK/43JApHn11dk02lb6KbWlUWBGNhunJaQWeV?=
 =?us-ascii?Q?q35fJyylIgcG3WIztacxMJd8OlyQdbQXv/Q1phtnsu3ZNryQTyfXG7zjTSo4?=
 =?us-ascii?Q?VvfJ1mq94ciz+gtc/Rq+uu28frPH1PQ0oUP7VhgJiUz6Eotipz2bZaxL8sRb?=
 =?us-ascii?Q?5gznta81pP7x1Lc3V9bQXfi/lq0MSJ546XLK+YK44XfvhTb+dM1Yoq6CQSdc?=
 =?us-ascii?Q?nM+f10J4zwYv2qzzz0BFPj+fLaTWSYw/zymH6W6STI12uqPZlHBGSHKMsjtL?=
 =?us-ascii?Q?WepdhO4blLAyp8q8tBKYHpbhK53da2kA0QOmpToTaKQMKxFFxhXIZF0XOwLw?=
 =?us-ascii?Q?3pwStblI9wn6aC8fX/hfRAp2U2xGS+0kpPC1ZpBcmzER/td+gdxLQ0/xP6hr?=
 =?us-ascii?Q?YuLN8LNbn/1mvikIoCyIj+e7wFhI05cmDjVWz1PGzNE70JRxuD17CcEFWHzk?=
 =?us-ascii?Q?8b93VaY6oGpA+z8v3Sv/ULoKju1Sj/kYJ9e67zJkMd8Bd3wG51oU4x7weh8A?=
 =?us-ascii?Q?IGZV9KLUc31M6teJ6+CKMXqMu+3lDLv2UnH5/xUAnThCVv2fFeaU4JGApJkO?=
 =?us-ascii?Q?P/X5EZzthH+JoMrE4YVplvOEzfdeB0fIg9jZ2nfl40Y54Zbaw4FgTLR4VX4n?=
 =?us-ascii?Q?LB1n1oVfYJW542ByFILXjc/BoYGRZEV52XOi4oLhiDWszWtZ5SnAnYw8l5Nk?=
 =?us-ascii?Q?yf8xMO+LKuinVLWMbzO5fiTyVHiKaFfXSdNDpC2Dler1ERiulwU3EmsxbYLH?=
 =?us-ascii?Q?u3N8dKfrzefa7RchjRG7ZlKBae4AqHuwj3vzkfW3FmIRs7wa2lm1KDZL49R1?=
 =?us-ascii?Q?/DQ/DGjSKfXOukvtNwhcBEr66jf5RWnS2db190tHPK5JnMaei6HCG0xXOqCx?=
 =?us-ascii?Q?mESBGp8w8ZPLKh9pbBq5BmxhFIz54d7tyGjIGvwITdT3aJuNwj3fEsrMK40G?=
 =?us-ascii?Q?qifCqdWGbrbRSbkSHOqmZObdVmagX7K0uVEAkAPoSu4KE79u2zhJWFKgIxP5?=
 =?us-ascii?Q?RvhjbhvqwZi/m4bbuH3dGlYsKESNKGhu6rpi7nFXdauLEQ8kb9VTkcE+YJzr?=
 =?us-ascii?Q?IijAOBVVswz8JwO7c1aUgEQSCHT6hhTMixALCc7S2X8mfo6bYhLsf8t9PRd6?=
 =?us-ascii?Q?OKaJjl218lYhFY5rJ3FnA2mgyumm2mYaWeMZqzWPaaTkGxU51cUh/YG32kXO?=
 =?us-ascii?Q?70OXK6Fr+Qtal3GtTDb6od9km9fQlC0Qu2yT+QHlmmyXrY1rg3RmoSTVs/nE?=
 =?us-ascii?Q?mLoVxe9H2l0eOVHnaZRxaZxlHBjjgWMiSSTutjNL06o5wSVwOwNG1I8ubhwf?=
 =?us-ascii?Q?IzQavbxJdXrzoHUixODTB5FzdQqQKyWNgXo/iqQw+UJVUo/OvJGsYVZAFq/k?=
 =?us-ascii?Q?wXDN0wBxqShcj6fo39O96FGYRwpVx9BGCNrL91JMn0GRswBtC8zElobDoGR2?=
 =?us-ascii?Q?/HVjomi26gwqgV2yQHYFOWEdApwsc7VmhREh9avplzt9aShbWb0yuXMLBmrC?=
 =?us-ascii?Q?KWyFl5zI0+3UiRV7KY8RFugaRxKtQSUa4pcHBEmVMOmPk/3KuG2+lLTmO/53?=
 =?us-ascii?Q?GaKuxOaUYwUKbnAYlwnT+y2snoUPBs13UxNTws0OMLSAla0mmEn+Xnsr/fDJ?=
 =?us-ascii?Q?RlTsdwFkrbQxwY+Ns4GgvTpq1oRaMycK0Dkhz4zqyGI5Q4q8be1WbZkDXSSe?=
 =?us-ascii?Q?q1iXhgdtew7rt1eEWwHA4j4cTDwQ5GV7tJ7eg0oqFqzLIBfYQXlkoQjuXtZP?=
 =?us-ascii?Q?3piYqly2Fb5T751zOv9yclnymJUdT+KJuP610ZO2TIdy10I+OLXNPyKJzZyx?=
x-ms-exchange-antispam-messagedata-1: SCx21jIO+SrXsQpu2PEYCTaZan3Klz5C6/eD0Mm22RgvTYABfGzfQG2i
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c844b9-cee2-40da-9921-08da49773ff2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2022 17:49:34.8989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pe/MhLLh2/JZ5Yq11ouJBbY9O4Ik605olLdN7jplOqfeU5t764zTDhcMWFsTfGH5L6m4jI68/2nhQ3cdwqs9Zv4uEXEBmiaDqMR0EBorOxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0359
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
