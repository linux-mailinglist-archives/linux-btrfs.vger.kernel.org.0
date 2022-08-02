Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E528587CCF
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Aug 2022 15:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbiHBNAw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Aug 2022 09:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236953AbiHBNAo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Aug 2022 09:00:44 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B67E1DF
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Aug 2022 06:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1659445242; x=1690981242;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=C/xj3RPKMKmdnANriLW0WMl4XN1tsyzpkBNA061Gu8dvTW88h3RsJxHw
   VHsFFtESJp9o4aWqwr9NGvU4NuUGPVaos0guIkAB2wX7WR+jUsM+RI5X6
   sF7FSiBclGNajh1fqWgsuBa790O2kWg/c5GG/2jy5KuwDI/2YSsqoezxW
   dfowdmW0RCbp/hiGyv+h2aufmBzeceU1Ly6/6697unZ4/95TvzrFt5b1n
   xsWbGOi9wOuecQWYLEUj1/FwqrrzqKbXAyY5FC5NOV6eJb7oJUWTgVkyh
   AwEUK9pA7Dli6zxmuJ1uVXUbmcJuVX2O+WDhdkj8I8JBN3MohZXaubVcJ
   g==;
X-IronPort-AV: E=Sophos;i="5.93,210,1654531200"; 
   d="scan'208";a="212548991"
Received: from mail-bn1nam07lp2040.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.40])
  by ob1.hgst.iphmx.com with ESMTP; 02 Aug 2022 21:00:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3V6VehhYfwFXU9whqz2HkThY9zBdSA9alKbnUJxpU1iU6mblIA3mQdhx7Se8Xgh7PjGg54vCFNSIOiJrmkE4uB0QZofre6asUvqJuTNlOWw8oMBqMfvBuaO0xEw+jsN+NzjkhyJFULsIHuljiPFETq5JAtxJJdDF2gF9ILBy0BHkDcsKfjmhW99SsDcMv/5txCpYUAGU6F7OS0lKXBEb1zSqUoSsShKuzixoqoC6zRRvxk8L6NA7oacYF5ZQB55+v/HsMZGeZL/RcUYTSDr4sELU5yvkZRlkyCWB7ONJb9U+1vfmXKkqcr4UPkZDxMvqJvPlw5cTkWJy5ihJcQSuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=KcT150K9FJ0Iaq+It6+x0T7XyzbI4/Y97F7p3OgZd8xGQnt3tgJOPGsubMcMyw2t80kYFnnVw1KT5PWIeGbZ1CjiH+GYwryi/JPBcU1N/A7HyMuwuf/rdJlgwoKmxZj7R5PRtX2O90C39LTHQ7pWtDd2lamlPTuFTHY1yc/PbDA4XCI661M14xh2BwpjPjT6TY+q7Z0WzfU77N3X4zr8Bd0NTGInXueX7kP6XHUKs4/lpZZBPW4Mslzco0keQL727QmN7J7LpG3Vu4V5uJ9yPCB6fOJQRwEOO1YoKkKjXcyhCHM227rnaLoJZjHXLPB5Xm40UTCKpECrcSS82aNDLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=o9V1Qcm1b5BmGsWkWYBayzayllCRBCKKu4iPD3txzzwxbcHfT3T2ErMLVdSZkksFOZNAkiAcPls9vX6moDqKcA2yq2ZAoEkslrAoHS7ZLqrHoVp81PqvW2gzzKfo99CDjuCsV7GpUARnaNpJYp+6QeUDOCfiHPyP1Lddf/UCH74=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH0PR04MB8179.namprd04.prod.outlook.com (2603:10b6:610:fc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Tue, 2 Aug
 2022 13:00:40 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5%9]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 13:00:39 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] btrfs: prepare more slots for checksum shash
Thread-Topic: [PATCH v2 1/4] btrfs: prepare more slots for checksum shash
Thread-Index: AQHYpmwZEBaKtk82dkqgSOCKfi0CcA==
Date:   Tue, 2 Aug 2022 13:00:39 +0000
Message-ID: <PH0PR04MB741646E1E3FB7008B4E083629B9D9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1659443199.git.dsterba@suse.com>
 <42f231d8d6f95fdc731b423fdc7c3ae2a6685318.1659443199.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aeb209df-e43e-4b8d-f18b-08da7486ffda
x-ms-traffictypediagnostic: CH0PR04MB8179:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VTLc1H7YeTiOMT0P5avgfO1KUeW0tF6oPUQQ2yVHVMCXEVkd4EApT/Ew4iUm1bH8xSSn55GBtFNvCXIhWhI27B+VHTxX/lOv1LWtEETyawwG0fTOqrt3fW0NiV+9G9mmfW9eMTQA4kK54V7J0rMjKIJ7+Ph8AslRx70U45OEzWNNQGrM04oUDEhIhXZ6tlW1O4gLv6En6L9lr1dhJnB5SbZLfwKX+vjFgHe+KMOuyolfU6BJv9DypVzoKJ05JY5euUg2lFqg3Bq8an8tueW2uB90iisrvL/RD8omh47QP+QU17IklNN7MLiD1VUcYMyyZ9T8KKU2n11G6RhSRX1aUYZU5sLiFdWdyhCPjHhoB99m5PMYYxp9baV99RpfWhG3z5rEw0bCjYKW7CnXOzyODzg66E/AW+QyWkl/G7f5FizFY2Cwr9WmYiQBH1AEN41IxT0rzx1nPojmjLqWSbtKCI0mynVD7vn77ueGtnODkV3kVRNUkKR8KGAj42gpS1UczwLqcR2kiAjogP8lIboWxjbqdRH7jYCmoNdf+BPLX+xLO56HTAuF5LrXh2PX8L2yqwSlU6V8r/uT/jZlLtPmI31n+xGI1pvytGwZIS4XdK7R+rb9u5TMcDD6vjG6LJDpa4BpR8q9n7q6W4ZN6wnAt2Rp6ug000m6kb2NdiwMYCdnIskfAFheKlXY857awUJUo+Bay3Dog7vuWD4ul/oScCxwmTS+f3iFkrIMN/2NCJw8hamWyoPgIQA2hnMrn/GHYPTd9MdBAOxVIEVtle1cnWNntBfFCLq6PJpHAPC58DI7vDrqMS+x9cjfm4E9Axqe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(38100700002)(9686003)(41300700001)(6506007)(7696005)(316002)(110136005)(33656002)(71200400001)(86362001)(478600001)(558084003)(55016003)(38070700005)(122000001)(186003)(82960400001)(4270600006)(19618925003)(2906002)(5660300002)(52536014)(8936002)(91956017)(66946007)(76116006)(64756008)(8676002)(66446008)(66476007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7TsnNwrvHBdl6Fy3gCijVfC/lSahNinsWvR7r957oD+u6PIPv2Vb6kddPouo?=
 =?us-ascii?Q?7Vd+pxvbs2NURNHxdisPWMFMlxj7fQj6vSv5wsbKofIpS3AikOeXsG3AOKrm?=
 =?us-ascii?Q?VKI/3qhbHsz8Y1N2lQ47hVoM33XcDp2ePeO51Qrzzt1SnGjkL/g6adCoQ+T9?=
 =?us-ascii?Q?JVngZyKvwl9OFfhLGfCQ9paTUdtL/1APHrvw1XZlgHFQv0hoa2Oky58jpTtn?=
 =?us-ascii?Q?NIHyGbouu8smH48xYJg9DZOOeoUIuV1vA5oXttBIDH9ShLrwumuzBZrLIuue?=
 =?us-ascii?Q?YiQK0JDSTZcwHTqnzjfm8l9SoHc6VXxooDlICG6YU976MmsBdrHS2hV7IE/A?=
 =?us-ascii?Q?SMuC1avaGh4epxbd61VuY/A8dVHOb92ICn1hQp0Z0aowuyQuYWIVztnlyrxY?=
 =?us-ascii?Q?FuU2QpMMI5ImHwhGhUpC40M9RrIAWPp8xJdrNnDseGOOPS0exUeYfwXACEuF?=
 =?us-ascii?Q?zdysASudf/JqfahJETRYckVy5eRkRyfay/C8l+1Frg8G+gsHi9ZKApH3oQ1O?=
 =?us-ascii?Q?LhLfE4F9PxK/sF1qDrii6wz1BH6CDXFKpm65Y6qhjV/Lmdc8/cV8kU9dmnQF?=
 =?us-ascii?Q?xsmpPRPjk0QdDVdpFEXSDflIeL8BJMKTp4u7nPj83n1S0POApOrxm+8FsZp7?=
 =?us-ascii?Q?pGHWIzRuxBJuEuJ+BvJ6xoViOrEbgaLjUaWYMd1Nsj62PuIQ4sAvX1duEul1?=
 =?us-ascii?Q?Sh7gzd6Dyu9z/TPOOosDFnfPHY4+mWq8Md/z4GCxrjMS4e0zcjdSEPeYL1Yd?=
 =?us-ascii?Q?GbIJiL0ls2LPqGH/AnmOUyaqhDVB1tJJxiQQ4umrT4fe1oaKzd7kCBE8CDDL?=
 =?us-ascii?Q?QFHAQedRf7ztl3lJyv3CM3YbQ3YWNbTQBkG7cRv5FAGxNfZQNAaw7dLpb56+?=
 =?us-ascii?Q?Q9xqMvw276XLumxOljI0QA0DLOajWhWqAfO6a2nwF0t+fCa6QleguXUGW9km?=
 =?us-ascii?Q?GS0EA9PoBl3OWLipGE2uWQH5gI45sT44X0/M5zFYaNI1mBak+RQFXjcqn801?=
 =?us-ascii?Q?CqTwD0+/0o8yifyVUhGUAzbo6f15baSBdWJqkSXO70HpPfPiaInMkkkd3O03?=
 =?us-ascii?Q?dxTrDZkXKug+Kge4x5Pn+LZ6/sCJ2RAclRlODfml/dPnUBAt0tCILtKD99fT?=
 =?us-ascii?Q?w2GwC9RPgKlDeayGjekC8VFiIAeAgRCVTIe9e6z9dX2trCYUtXgNgdWBiZ+n?=
 =?us-ascii?Q?WakZcOjxBxDr8avXkQimCwo9VgUYK/U1Z8dmJyh77xw885oEnnJsDXOA4OM8?=
 =?us-ascii?Q?VEwsjcSjVsQ53Vje4NI0MrLQt6xbATKwKh6Pa8ZjJ+K4gN7Lv/64F3f7a6Ok?=
 =?us-ascii?Q?ZLjqsipUq6aywlwgwqRTPgVGMyRrdjET/7p+uv30ZtYhpYV29pz8cPtM6uWZ?=
 =?us-ascii?Q?e0eUv6AdhFXX2rOm0miPq0Q+Zm+Pxo72aQfcKfd4qqOhp/pCVTyZZuB6Z97M?=
 =?us-ascii?Q?2r+5ViT8jV/FKQq/d29QWfgQmnvqeYq7izBh6fV8KY1AZs9CE09CmGUW1wC2?=
 =?us-ascii?Q?gx7cfqRy7H4MRA92bKUWw6aAKnnw9a9Qpxwo+M2jfeqAqnKgOQh8+r8ZX+yw?=
 =?us-ascii?Q?698ve5q5A6Hr7w8RnrDXwDghS5fPIhkMVFFcl2KWI96l3WV693SQTpW49s5k?=
 =?us-ascii?Q?8SIf51kR6TKIkM7ydYZP7CTro1EJBHBlqvBrsUm/ZWoFL9+MxtI+BrRDPV/b?=
 =?us-ascii?Q?b5TZ18FPj68UDAoB82URpN0/kqc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb209df-e43e-4b8d-f18b-08da7486ffda
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2022 13:00:39.2700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cVXIxMeedS9vjjXA29Imoux0tupODFOYQDvurjvStD9BVqfAcV4AnQYfBt6cjwgea5vjv3ooEJ4q1s0XhxknomeA97p8trNB/SvZ75qbe30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8179
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
