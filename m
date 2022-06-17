Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23DD854F4A8
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jun 2022 11:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379952AbiFQJxu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jun 2022 05:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234921AbiFQJxt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jun 2022 05:53:49 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41A149F87
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jun 2022 02:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655459628; x=1686995628;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=GboGujwP4xW/1VQGRLcuEGnXkyZAfwZeWeQzZFgORYjJAq+1uoP4/3ul
   X8ue2+/l3S6+3zTDM5elWxno08YOOxA3fTwv2DweSEogPKELX50i8Zk0J
   krNzV5Vpbb+K2NcgxKyqjoUGlDIto2Ceny5jHhkWFAF68crCSUoqoP4pI
   6eKE3X01Z5T7LK/8FCcd0JpXVzD2PDZPoIrbXoa+2KSUR+jqJx7a1TzRm
   ddCMoDB4fg6S2OIhwM4DhPoq03CEv2rb4QJQwHoRi4HqQmfOAJDjEa+Pe
   VQriCfl3LdxeDE3+nmBoJZ5bJ3T/43IpHkE2RUedYzC2PiCmjpeG7S8JU
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="208274237"
Received: from mail-mw2nam12lp2043.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.43])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2022 17:53:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IpXR2sqs+jY3EsXTjrE3YPQQYFI/ewgQ2YNKJHGGOLWfhUuah56VST/eyLxUwRCSqdKtipRwuL0uY1OEiUCAt+UXMCph4EWYS3mEOeKb1BMZanQ/X3A5w3dRixzur64cdWZ6I2pd6AGd8nntnJ9R9Z0PKQ+zJsRlzKfh5K/f/Ex9gNTQzfrfHjpQWLcrA7Q/nP94Q6lIoRAEQtFgh6khsc1QpjU1rJVDcE3f7ncZnP7mIwNa8XupxtIs/Kdq0OTo1SQtCsa68uqwCaTUy31BPYNR/rAR6mvgVRtHnlKAPV5Q7hnbaiGnC2csdfF4JKr9K9tJ1anOcNagZvZGQenPRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=QVQ+/lSoGr9VUv1E0spgCsIW9cII6dJWxWezmu71vN7nU7Axyf1OlMh4E7MY5Q+uiPIIkpuHisfUOzSUqAHC8BQbnItS0Ror7vq91LblNfZFxQosGuKdGt7S5aAP0VWZmEJhKSx5RskejqQpR47ibA2YGNVf5NlEDTW0fbbls/8h6DLY9qgWZhgluEkaaVYAT3KXzsuNzK0megcpcuzAt3aIeEq5FpWoi1uZiA9ZaOoK9zz88Lh7q5Dt8rW5WoC9WjlRUkxmPcO+o4tfEZpPbLtowC2PRlfxycoEBolIm3c4AE19RYHT2lEkfCjw/rOOFyuPgsT2nqzndoPHG7sr8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=wt2x5JfFG0OlTp+dLe0QtAU5Vh7KaPzc+VSjCd5wB7qcR+n8K42YVaxCwf60wFcEQUkSkvBcUr01LUm6Nt6tY4CZKuULoH7ghFBhGEc85SR9wAC1TqkCY+7KSakonvKEMuvSR0kbphbzyE51j1R6Gq8UwPvWCiReNdC7jtgX9ss=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BYAPR04MB3973.namprd04.prod.outlook.com (2603:10b6:a02:b8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.19; Fri, 17 Jun
 2022 09:53:46 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4c0:544:ac07:fe6d]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4c0:544:ac07:fe6d%7]) with mapi id 15.20.5353.016; Fri, 17 Jun 2022
 09:53:46 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/5] btrfs: remove a bunch of pointles stripe_len
 arguments
Thread-Topic: [PATCH 1/5] btrfs: remove a bunch of pointles stripe_len
 arguments
Thread-Index: AQHYgMrK1xHFfI3vWEOu/bIpsQAWQg==
Date:   Fri, 17 Jun 2022 09:53:46 +0000
Message-ID: <PH0PR04MB7416CA8654E98631D10A7A569BAF9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220615151515.888424-1-hch@lst.de>
 <20220615151515.888424-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66884e5d-bed4-47c4-77a1-08da50474578
x-ms-traffictypediagnostic: BYAPR04MB3973:EE_
x-microsoft-antispam-prvs: <BYAPR04MB3973A18A2A00A9B274A5C3B79BAF9@BYAPR04MB3973.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZBwBXTgYBQ0Wm6hSTn9cTaF651vavFyEEK2muodWpQnaNg1QnL/LjWzFF241PZklYd6rTLyCKgV2+P00HH/IBXpe07PQ1XLqAvU9Ah714PGmP1rHAWjUCvGl7OY8qcScg2uJ0lazoB0q7F27GBNZSPoJal17bPJ0Uj+VoR4qwhtRJv7nILSqSq6JNeo88oou4AENotcAEKsUYThT+bvuk22idu2SICykTX8tdNtC9BfShlGmeweqP/ClJw7eX8+Gk+Wy4+wmyJcD+ze6R1JShUdXk7Adwzp0pYhjzRuFk3CWsiRDpPqBS7UKV7NdxZC8eAK4Ed0O1PWk3xD1JiCEqGvYbXgvOMADGo3nY2tAma4t61W1ivqwYO0zMlM1G6PLcuQ58nu8df7BMwQaBnNlyKaIxiHTsryb6Dq8AZRe7FkgiTgqyHglhA2c2AGa5Uz03AEr5UDuh0mggUpwuKOmJtbTtWGbfYi1HxjNpXxQsUyLJMJewDIkK8SS06duKwUZ6yVA/moKfPnHNUObfNR0X8n8ffPMCC7bvm7FfqG54VmuvSpZpIyLmZ8zSapNW1za5aCyZFGhRIxt3OvnQKGDvFpt1EraQtPKnQ26V5TSmVgGrGk0GaRqItpe51yjXwVftn2i38KtztcDuuftXmPCFAGgzRijgDaxpmblwAe3n+uvruKtb1sjL9Eusoj3YifKF1piAbR3IhXy45VPlphP0A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(110136005)(66446008)(64756008)(55016003)(498600001)(38070700005)(66556008)(558084003)(4326008)(7696005)(122000001)(76116006)(186003)(91956017)(2906002)(66476007)(8676002)(33656002)(6506007)(82960400001)(4270600006)(8936002)(52536014)(38100700002)(19618925003)(86362001)(5660300002)(9686003)(66946007)(71200400001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mVQs/EUoeb73lODY2hXSVAuWtZ0DniN2AKNNfLTTCULRcsuX5628SmGMWAVY?=
 =?us-ascii?Q?zcNpAqB2Hlm+Z7J0X2BWY8gi1tiXsj6cMSf0gtYk8KZNQHtqF9y7k08uwywJ?=
 =?us-ascii?Q?Hg9pK0p1iXHSBsZuZBC69lB1Wsbu6LAQW2ituNL7p6Fm3tVD2Q5o9VEY3dA0?=
 =?us-ascii?Q?hMshBe4LXNJpKSo/xDWrV1FuW1sQeiFS9tWos8Ra5gt85ZZOIlL7IuaSnLJC?=
 =?us-ascii?Q?n8w5rzR/h6B5byuZUqJ+pMGWkaS33x+D7N416qcFyPbrg4Prtdg3SQYoPSQs?=
 =?us-ascii?Q?0x2w/4+EYorJL38WM/TcsEKsPY6/6Ev9QONmClmA3rXeZthE9x2ipMsdbUAP?=
 =?us-ascii?Q?EzA2pqDX/JDyxxCeg0FJt8GUk05f2WZKWVSwdqOcA9xo0ddivCML5ZVEZC4l?=
 =?us-ascii?Q?yKRFmn8suoYS5UHWfQJL5ktJ6726v8g0YChGSqwfdDQ87ZhM6/jKgsXLjuen?=
 =?us-ascii?Q?gZcwMxi/L/5nHEJPD4ioepTtH3F7LCoW2CfERLAoCFqG6JEHnVE23WEUn0xl?=
 =?us-ascii?Q?WIadtptzjMPHkTnMee3v8sXxSGpiIa1ca4N7GFCpoENtQojMGm/E7mY+DbB1?=
 =?us-ascii?Q?k97equkQ3PIQWQmmoMx+1DWv2oj9Bk1spZVaOQe8EoxkrE9+YGrztoQhyguV?=
 =?us-ascii?Q?AXav95JFfQhykurpalQWP0/iWn8PVuNqJwCPa00NOEonoilq9Z8yWh7pPvP6?=
 =?us-ascii?Q?col9629SFcFbFO+mZTGcQSeFmDFLUOpzj94wWFnNxg4dr2GxRetp2G9+g7/M?=
 =?us-ascii?Q?+X2lGHQGuakHqsLxFvlV4bDEFo75R8qMFpUBrWVPMsL/hRD46VnyLW/N3LfE?=
 =?us-ascii?Q?B0JAPWiVuX4f2t5nJK6jiA7d9bgLNLmcMluW4H4xYGKgPS5/qmta/WNQG1Zc?=
 =?us-ascii?Q?L8ZQ4DUllni9XpmawvcaqERIyoIIxi5RNRwpKzFQ6/QASt99urGWOTMBNS3d?=
 =?us-ascii?Q?W0ee9hK1hTyUV/OY49Fenfstbiwt2T1cvU09PmbM3va+Y9VtN01CWDdvBiE3?=
 =?us-ascii?Q?Nl463rUp/CTq9nhFDUpPJNxgmSONfQ0LbjK7TkGKzVIuoSkhtt7Ivd50yBw8?=
 =?us-ascii?Q?W/X9PahG6y2TWQqK0LHTLOXyyqh8AOQPvaDjd9onkBtpTXz8URDLwA3TH3mq?=
 =?us-ascii?Q?GCtVZdzVo+3rAHA9nom3YDQEQ32GvGGZYIz53xqjuh+cF/7oP0yZlj9+IAZh?=
 =?us-ascii?Q?yriC7aX2QVjB49jUV5++jIIwkdlxHWceaPIfCGRrwoG9ALwXsMZUkmLgNwdc?=
 =?us-ascii?Q?eYk8KdLCjAyZKzoL806DL3ChqcLQOfxbGVQaWhGnRkfPOzdvBHeYmSqxJ3XO?=
 =?us-ascii?Q?w6Gu5hTgtDYsF4+c9t7HTjCzPiDYNUpoOeHhnmSBWe6sJeWYGJnsEl1OhKHa?=
 =?us-ascii?Q?D7DkOB+puQwjH2C7mi1BaxvzI9LyLNHSPwxQ2TplDeKavQzRkyirt49GzZhX?=
 =?us-ascii?Q?zHMoFv1HeepxJ5j7tsLr4khPBOe36eeb0RewzfIfbm76PYujVf5P4OnM//O+?=
 =?us-ascii?Q?6GtmaMNOMddTepfF7b8d+HhydOdfxSfHmFcRntO/PkXpLToxGwnfR6oJRVur?=
 =?us-ascii?Q?J1p8hJdzZ9/h129WsWZ+8w8lz2wvez84Y5jLHtPds04xeY7WT5u+rMsxDaXp?=
 =?us-ascii?Q?h/nGM3Vgew7O2N+zHkBXj2A1QODeoCEySN8eowQFoiln0Z1C43Ypo0FChuOv?=
 =?us-ascii?Q?PoaCOf7A6pDtkdcPtaqrmdgAePi61BzZiNaiWPqRxto5+YpF0AVtfit63gDn?=
 =?us-ascii?Q?Vy05UdLqGog7ikcgO6weCvAgSisyjtx3/CpiM8cBFYgDt5anD86xBJ9rs028?=
x-ms-exchange-antispam-messagedata-1: DFAoOsLfB/Lr4dCM5Hw6/r9Dhe42Y+/QLKSA81fzhnNPYQHZgDnWvxTu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66884e5d-bed4-47c4-77a1-08da50474578
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2022 09:53:46.4300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n3l+aEVerHTq0CwT4mpvx8C5MEa+qMcc6IqZPiCmbIvvWaj7DqGVdacQajwKYn9zaxibZ//4tdwacriTm39E6atgQKbXkzFto7ikNzOI6y4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3973
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
