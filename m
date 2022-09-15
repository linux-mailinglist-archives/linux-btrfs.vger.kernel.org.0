Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75BC5B9CD1
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 16:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiIOOTq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 10:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiIOOTo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 10:19:44 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F3013D04
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 07:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663251583; x=1694787583;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=T9nn5GqRo+ViBmEMXHf/9iWSkmPpOyrMGh9TzRCpprcV89MFucIDZ7qe
   1kYPDmoUXFI1WNiKNRBOIU9W0fb9J6qyUQEU2aNCbOhPytSco+Q+C6oo6
   B6XQ0fx+NhIjz00cf5wZaJ7xAbPO1d4O6QlOwHfCY+yU+l4xGm2uz+fzT
   doc4xBuON7tCFmsA7lglKNKgrB8rdsFQmgiKdPTB2p39Spdcq2tFdUYYK
   P5/Iae/MngeNPY9vay0SyEGfBE2rcdSYrafcFrJjJqCA2bjTuSds1TSza
   9iZO8kxK1MRjPfMciRJhZ6N92tgR7yANCowikMHf3NKXrXQYd26+9T3Ip
   A==;
X-IronPort-AV: E=Sophos;i="5.93,318,1654531200"; 
   d="scan'208";a="315725155"
Received: from mail-dm6nam04lp2046.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.46])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2022 22:19:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fktQjps/uSstUxn8pSf7itbToLpFuR5lIDuedpFVq7ibaRJXsax+Qv7BweWFdA/WVDvFWboSih6uM8uzIhqVZE2bo8/iopX+7FOo/EehcWRU8uKAg2zEmDPTusWBC2zJkvB26jJbHnQZaNw0Ma8dtMNwLHBuoYon2uZX8h4ISjP2YGtMdrc+MYQjHX4VXSRNNOQqc50Qvn3mDUJ4pKfHtFJKQV2NmxcMmtFYIAyzknYwXycYuA/k7os26+mdnN+wKgn760voU75duhzDmpq9JR550rYtSVIiQvz59XtMdZkMHjIq1yp/MvtfCQQvXRyw1sf1InpRf32ThhHszve4uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=nP+MtRh2BNwGt82kUyVLkYaMomSFP5J8BIQR3jTGQXZRsMKE6FPY1yFpfM/ordn+lHeXUtRzk+YWr0/SbEUJ6kUvJ3oHwSG4PKcvWpJhJGbQuK4wZ798KsQS4KTvCRwV8dpph8xFDhFIju3+8SKzBBIOEhj9RsUbWOlk8Ce5TBxfwaqtqp1O+VrBEyx19E0yxVGGsNWG0qeJ8KVFpGAdBGTFkpFk+34TiKWn9jX+l6nXSOF18QbQjwMLtIHeP3rU3Cml22FdOfs9x1mUIF1sIU/IdtB6mrm1mdFOEPITGtdUQiruxCcs+Ee0EXIqYUg/1HfECPJES9TTFuUxWmOadQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=nbNgmpX/cDNUqSKgqJ2kptNgMYdmCqi/zxz2sUx8osmGNsL/IJgdfNmqRn27rsp9hSSpvy4t2wKwkek8jZpCPuh2GasPk4OX78ggvSGwRW1zRIyeLwqedB87/lXWibEWIb79SbbtnyvVWoEM+xxidcawuJ+CGxIHV11M+swa4cQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CY4PR04MB0984.namprd04.prod.outlook.com (2603:10b6:910:59::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 14:19:40 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 14:19:40 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 09/17] btrfs: move btrfs_chunk_item_size out of ctree.h
Thread-Topic: [PATCH 09/17] btrfs: move btrfs_chunk_item_size out of ctree.h
Thread-Index: AQHYyEvB2Calb5o6vkeEFOAluVxfzw==
Date:   Thu, 15 Sep 2022 14:19:40 +0000
Message-ID: <PH0PR04MB74166B24A12B2C28A628DBDB9B499@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1663167823.git.josef@toxicpanda.com>
 <3744e0ae6f8087daa9608174aeee00c53732f8bb.1663167823.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CY4PR04MB0984:EE_
x-ms-office365-filtering-correlation-id: 9db9cb55-d738-495c-b3d9-08da97255417
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3ks116kI0HLukFeloANrb8qjkrQGUU++FNMioVOIfc/uR1uM/qx/p1Chz18Nq8oWjWTwZu1X/uzKQn7zqh1NDiBe5LC0AS1GmNqCKrcrkLKDPdGnpOeNQq9zqYhuuy9DAYqae2dRbNu05N2hC+qrnsKZpSinM5AflesIJPaetZqQmnPxJIkVc46/iEJzQfK04bAKrGgsPYJ2rqnYiLuc1ZdxhnduK7iaQQm1Lkw8BAp59fP/BVNOZceLszYhYZfu8UErh9ZGNHGK0j7w968ngyRVfCOYqMVSZnV7nbQU0xrOuBrbSgscaR93zTZgwebwg42H/YZYReZIJK3vnUKHpIuxVmOvXFxw4m2wBZrofFL8/ymnfVwbYvh12uBPYJVlydsdagSUaRTXiNAVi8jp3Du6uZ9gFgWy1rf8BJbzXtQ16jgEVHA3tDKtExv0HMwjfXdsbAddlfD6GO7y4KqlK10E2zGMqz5lujdPblhPnObnfjXxzcwipTPf7ETn7nUNXc42OiZRqvL95EnWusMSwkwbv9JxsSDr3L8knNDreJ6gqRyhszN+kOV+ddABrpcgJN65g7zvix8TGHELHhYU2pfyP8onSHA2bOfqLN9FXkASR9Rkw5CSbKFjVOB+T6hWa4iZ0j0uxK2tswdJuU0J4VfS9odAdMHvSd/7pbaRXU9LGMyIB/kqnSIkETI/xLYMitLUziw8nFJtrooigGcehbPTPAIWoBe2YtrG2wwwgsGcPt78v6ijEKyzh+2W4yJ6AW1uY0gO3n6FVQ+brCWPbg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(451199015)(8936002)(64756008)(55016003)(82960400001)(5660300002)(8676002)(91956017)(76116006)(66946007)(52536014)(2906002)(66476007)(66446008)(66556008)(9686003)(4270600006)(186003)(7696005)(71200400001)(316002)(6506007)(33656002)(41300700001)(38070700005)(122000001)(558084003)(19618925003)(478600001)(38100700002)(110136005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6vqwnzt/zWF8SK3B69s/kcsdus7OLLueC/vFX3Pg/K338Dkmz/lxeTo2VJeq?=
 =?us-ascii?Q?PyKGAxrRghoDFKNLk31bYXKcV4o765qvYYWYw90Uqtuq7Z7uBmIII74wEMf6?=
 =?us-ascii?Q?LVR35vPkGeqwFlo2qa0D7hUTxhM12f1d5qbbE5HJIylLDhjOL06iWKrx1mWA?=
 =?us-ascii?Q?nvLDXGU8TqOaM1m+acVGfzuknwQFyS1F0wVqLrvfE8aT1Blv7BJMk+2zI3O8?=
 =?us-ascii?Q?Rb7vA0q3D9+3X1SOhcP0VAiG1Im/IajmFa95SCBV1npZXVuelf7jlNm7CkIQ?=
 =?us-ascii?Q?9Eh+50AnF9eoP969Wt5vI9rDpDDqMTwYVEJkElx4iDUdAk2ZENjEFmhIGq+f?=
 =?us-ascii?Q?gDpvE1vlhKDRFMhnJhdb5plh777ENPEcqBLyL+NpVTxt30wiUZTQQ4G9RWZN?=
 =?us-ascii?Q?0uA3YAWWjnuiRsySQbyj3EiUOTviQQkHNaSFHrgEvwzWmky1bjeemjg/074J?=
 =?us-ascii?Q?iARWAc8YxdTQerFhQnmn4S9k9NyN9OIVkIOHIjHcq0jx4+lcbTw9+B/dWpXo?=
 =?us-ascii?Q?tuh35SZkHPlZvUe2+6ctB+bxwGZrOaQCh3S03AhJ6e8kY7uiOewSsdFeXlsy?=
 =?us-ascii?Q?k7HoCPgr6PMpjREuSYL8EDkCkCygPJ0FnTTZLuGnPFKv3R5+GPxnmz80txUG?=
 =?us-ascii?Q?huJaNchuCDsENcN7/Y1A3XoR7WRw5NoB2FSunW2JOnCng6r2G6HIUqcOr2GM?=
 =?us-ascii?Q?IBXivwaHxXInJbseN3Giv55IGJsTOiMOkVlKB3fUCgnU1Pr/mn/1H9H75sJg?=
 =?us-ascii?Q?Jr9J9dGvPAxGR4aBmf2QyfCAfO7XjzeOomnOA5ZiwV+K3MUVn9Uv+PvAXJWE?=
 =?us-ascii?Q?AzCOzbhud5GGOyLawOtSIIHJVLALcefYwaLv+0uZqaklB6lnBf4+yWUqBhN9?=
 =?us-ascii?Q?k46zZBY0eUIIgE5wU1GNvZv7s6/8+0y5f7BCmdVGsKMaxd6FxrFPQ3jmxz2U?=
 =?us-ascii?Q?uIUEzMO3JG26y855ERnH/OlhcZV0AfV3mL/EWMSQ9sNaAfpbWoWm9AFF8EOv?=
 =?us-ascii?Q?nHUVeNRFokxydDvmPO1bscdRY3ejEysuWZMOl62AqjUQdte2/5C37LUTZpkN?=
 =?us-ascii?Q?cB1vF1578r6sQO9iCZwxbkMe5hqoPNm14wWGn07WzM1AkY+Y2JARkVOGLyXT?=
 =?us-ascii?Q?mGEYtvt0wozkN6jjgC7QjW/T1DH1FUVpA0TUPK5flCIK4hrSM7UrFkxTPPyl?=
 =?us-ascii?Q?yWtgYhFHjbQeKtHymJyj9WPwbIFNfwHi3wS3l18EIZ9dqnnS8c0eBbXG7GcL?=
 =?us-ascii?Q?mCB1CU/4wAMj9rnMLTXOQaL51nCLVUO1sd9ETZTmPc4gJW6B9v9AGMeh8pTF?=
 =?us-ascii?Q?4kSz4agcxoejB8WU17PS6ezTeGSlAOfMXiQvsuVJmbksPMmJnPulMZE16rQ6?=
 =?us-ascii?Q?uYuYSL5/YUwQ/+bS0csKBxaslRLPACdjvu/otlqD5JNOapnW0T0dyWLmnNHv?=
 =?us-ascii?Q?wxv+qWBeo0pb9inUuKfBXn+oSH6bPFJANnQ4pakfhhvnTk5fwSGYmaf42nIS?=
 =?us-ascii?Q?iEd6LwwTfWNgqYSaDZErjS3icebYQZBuHoNNR1MB5wbzue3kQb5VQcXWubdw?=
 =?us-ascii?Q?yXQLfWA/LmugvZ4DF9g/HOJ2bWQ4nUsF1raNbt9m4CoN89bjNkJ8wWV8Hn9X?=
 =?us-ascii?Q?rDjOQHN7szFXkSoZ8oedykv5ZXEUalttfjLKhQB2Q5rnl2u145h97e3JTsDL?=
 =?us-ascii?Q?NJG7kkMVaXfnKtQBaPdf4hYrXmU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9db9cb55-d738-495c-b3d9-08da97255417
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 14:19:40.6145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CyB6ustpfeZPPYrc1SfmAGkiZK/yabI1vRP3UckWT1jEiXcN9Hwm56tc5JCcTcAKyaOwCu+Om7EimDRwJsbjMkAa8FhOvfgeE3kDyZ/ga1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0984
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
