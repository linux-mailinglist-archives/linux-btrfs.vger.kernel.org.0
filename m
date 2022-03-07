Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C424D008E
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 14:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242746AbiCGN6t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 08:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234575AbiCGN6s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 08:58:48 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45ECE39832
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 05:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646661473; x=1678197473;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=XCuJ7vtcg93Hwq3hOPS8MaeIU3gABvuYXgAnYJ/ZAXAlGk2L2HHM5g+b
   AlTI9N1DhvDxJDyHj87lEt+QDC1/48CPsOgnLzzgxCpPGeS/3hJSBNMcZ
   NZzDzYxiHX6Zu/GRdwLfEPHbsove1MLrJFt/92yqGn5SYMt+Sowvg3opY
   kfiZIDsp6ub4yGse06WFeaPLo/03qQ2orxN0E0WQBCDal/dbfnB2tQDEP
   1jEDbOatLDfSo1W76KlvYOz7LgyGJ1jwbAT8E1cvncM88+letavinHA1Q
   z6N0JiheK72XJozNkCa55IpptcGYF7eGmkvcS1JsLp1EPV3dnqDSU2Nd+
   w==;
X-IronPort-AV: E=Sophos;i="5.90,162,1643644800"; 
   d="scan'208";a="199514070"
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
  by ob1.hgst.iphmx.com with ESMTP; 07 Mar 2022 21:57:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KnsnJP5kJUHv/zPLf8R7LW/8/2qyP1uXUg/Ajcl66qv+LOBUQ6z2Q4FsUeCndkAhmFiJxLYwIhP5CyqLNiec4rkQsSJko0s3ozc5kdPdJIq8iQpMF25OLJ2bg2vSrpP2mnGhNXk8/oDTdgv3NOTQx6H+2O3BfiA3EtbZQ+bImZ/xmlfZHA4ItPcy/v6IE3RMBpJTlpumhTnDZKSqIkI62ASf2NZVNo0WQ0pMWfVbq+8qEUNBUoM3gedlQ0Pita1GtnjkvkuOUyw/TXKe+q04VuYnzkXcXWfpnMz1hUC6CtNnPfONPNMGNWUa+LItj2xazlGgIBFXCiMGVDQdSPKHmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=gvdKy7rUyoaFPkwukXKPNGj8K9a5mDZXzogXOdG2/DJTWZ20C3IctUYMKIiEV7bLaLGyMsYuyV3WFrLgJ+fC7TbW7tbL4lyq7x+jsjeJtT0EIzVsr0mJBwm2q2qRXYCPg23Ok1WfkwZZxEXBVs65I2MdFslRX5JBFSV/HPmPUWEx/2TFllQF37gwsyTmiRpXX0ztCZ+SqnSAtKZiRPuASjYBA+bD6OlEAhzO1uMMzgAloYMXLtz2p6CLqABZ51rWHfg8GO2WB+MMsCPCo7pzWySnMqq+/RPU5PjxfQ44GFEREFNVEw8WDTdvvAESdOhRumRDXXtqSDIgbKVFYs3TWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=sp8FSaeqi20wEscZVjGVZY+pCUWo5hPmf72QLaFCdJgOZ6e3WZ4RdYGf6l6cNwc6W9kZKf8uVo4JpXP3OAvM9qbudR8NF4ZcYNEIqqGy4XE2GKEM6i/QCnQrLKOVeaUD2GCu0k1m82kpfapE7B96+HLcOFfQYXlhJXPlfSz6rfs=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MWHPR04MB0751.namprd04.prod.outlook.com (2603:10b6:300:fa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Mon, 7 Mar
 2022 13:57:51 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::e8b1:ea93:ffce:60f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::e8b1:ea93:ffce:60f6%4]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 13:57:51 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: Put block group after final usage
Thread-Topic: [PATCH] btrfs: zoned: Put block group after final usage
Thread-Index: AQHYMid54KeJQMNJ8UOJ3aM/OuUjPQ==
Date:   Mon, 7 Mar 2022 13:57:51 +0000
Message-ID: <PH0PR04MB741643FDE6DE96BF138EFB4A9B089@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220307133002.28765-1-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c0ef662-883b-4e80-c99d-08da00427856
x-ms-traffictypediagnostic: MWHPR04MB0751:EE_
x-microsoft-antispam-prvs: <MWHPR04MB0751D05648B72D3D71D9C1729B089@MWHPR04MB0751.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: djlfGy4nbY6bLVI6BrIAT8/ecYrFJp0Yz//DHmGrhJuN7nL86AO6ojvm8EQSGsBBUkLsyUN2ytMbqBL5yXYghHHW65cfm7x5SGENdzOiJbk59cC/Yv/EObMX3pKocDCErz1wvQLpteRSF02QJB/jS29K0ZuqOlmDJZFTVE7dC5yzIGIzxWgCuhvpRI5W1WeX5NklhqndrsmgAovjNUqz3QftjMjVtdx/M8Q6fAEpKnQcbwtVRkaZ79B6uAWCFtECgLuYtkXL9A7xH0Bri/DBTF2RXCOyBQ+gEY1L5rl8dLrOVEm0sgPw2JdJv/BdcG/TX15rzKSrMXNmAs+gmIfxa8rkRQoaYNZkwAiAtXNuK8OXBZjL76WTm3uSwDXYUp94zKKZF/GK3+y8nQdC4w2BNVYLo2Xy09pBP9j9sJUsBPrW7C3CUzA10NfdW/9t4mVPpaudnvykfbKqi0tidhtUehIU64RYaR83SLYnLPSzg3S3stxl39IDjFyT3LKg8oFtFYfCSyWcICHoF2AhJZGdrDD8opmVJl/2VJtcxv07XeH01vSH41q6vOxxQF/0OEM7/9/eP8hk8t31AubhVo3+EovY/VfN/+28nMNOCVC0UGeZbSjCA7X6aqbyQJRvt9KVp5PJokjHplZ8fwHN+0decrbAjkFsRYY3uR/BNeOkfzVEONaNz/PQGFseO17zbRZsbzfaiFZldgBDyG+B0w7CPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(86362001)(316002)(7696005)(6506007)(33656002)(4270600006)(558084003)(186003)(9686003)(66476007)(66556008)(82960400001)(66446008)(91956017)(19618925003)(64756008)(66946007)(8676002)(76116006)(38100700002)(2906002)(110136005)(55016003)(38070700005)(8936002)(5660300002)(122000001)(71200400001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Lyd+HqXRrI5EJGySZXfBE3pQHKkjoU/3Tmo3392eQgnSA5PhRung039svADd?=
 =?us-ascii?Q?VPjkSnszb2YnMPM6g0pCyJHyc0TUUh67j3noIYZAJB/GVVB+4EmO7SkelQST?=
 =?us-ascii?Q?3bpdFPTrRPRaf2w67EDpy01ipRFnRNDLnhJuKDdyxEl9IbpBVYJs8SJwqYkd?=
 =?us-ascii?Q?zBJabtN1/aooEmF5rmMFJrjydzVJ37AJ3DpnPEKt4EJT3N/5wSfZ8pqJDSEn?=
 =?us-ascii?Q?vLFykCGufwcpCB5tZH1vukkmYIpZITzS4BnI4hCyVIQ7AlYS3kkihWIloDrl?=
 =?us-ascii?Q?ouIAJ7bPsGe8Z/gR4atuSPxEqWF01+MrVeOtyUSvG1bIuuLeUEpgNpGOK/Nj?=
 =?us-ascii?Q?6BK97ChSCzMawJSVIeSpzx4lNlddGnuCRLYJHt5sL00WTc+2R4ieZ4AaPepj?=
 =?us-ascii?Q?eM819SpQ47aqxaonlvlt3OwEYPJb2viPOLUDrskar/xLG84L2dzwu24lM5z3?=
 =?us-ascii?Q?44Lhx9R1dxkyJ6YIeafQcehzMYUL7AQNDFhD9v3Rt5HoTQM416pa9xeSYBYz?=
 =?us-ascii?Q?NDIAgsXsxRpPhjQO9cuzuTqOfZWlKCSI3bMbbFTTSIkmLs6tT74I5jQ83lK6?=
 =?us-ascii?Q?TxSQ998OnTDbAthLeq/uJb0od+BUly0kb+HEs05OSwx2uOC2/fQWRJwPHuNt?=
 =?us-ascii?Q?SdqRZJ17vSsOgC9vFEiNQVFniBka828BgDrqwVQHgHgsTx/1JcOuurPvx0KC?=
 =?us-ascii?Q?zNyqujxpuMXhPfMleKWQ+gpsbsqjfubPHT9A3Pno/0VYXtU3ACGSwieIeT2e?=
 =?us-ascii?Q?DQN1y4+KntNCtg497H/XhULaIbl39TIDg8OHzOnqVeu62tRWEAJi69whqy9N?=
 =?us-ascii?Q?Eg1bb9Oo1VbHKaJqWDDjZhnn02alMx29bmZU14yzG4DIsUVrpZlX/g6pVKY5?=
 =?us-ascii?Q?6bmwTBwdlrt4x7l/1+8YzRb16cByZuDBd/Jb65h9fIHYVSIasyENQUCoeWjA?=
 =?us-ascii?Q?OOl29BMFgUOysNayV3ffU/FgniPsq2TAKYc/fbMQL0JwTAzbx/jW+zOLykr5?=
 =?us-ascii?Q?bboZOus7FRZzRjyxpbNpII69Y5RZ8PqEvJwSBrO4UK1EWJTV0N6GsYaSUhPZ?=
 =?us-ascii?Q?rOvSMqoIKmvmOcljDdJECivBnmOp3Us+8d8vUM4p9UTr8qyvl3qcunlIAgZ3?=
 =?us-ascii?Q?Chp3sEE1l4uisSAt6Bv1IDj85+obCVLjFkbN5eF1wFfpzK/I4UtZvvIv0NvF?=
 =?us-ascii?Q?40+uhKHFcLGP01ouol9yotVeNRHhiVxruA6gy8GdG0aH61qiw7K2tTBjTgo7?=
 =?us-ascii?Q?/ZOiQIr6JQs6cBPAs5Qp19nMhKXV3uTgvoLAqSoWbmCYCzsDtsFdeIWm0zj3?=
 =?us-ascii?Q?QVbzIuL4A0u+R5Sd+7LQ3l3fCExMVFESp6nBNVR5bhy0LyM+Oe3WB69ppG+8?=
 =?us-ascii?Q?ZNBsWcIdzp8Cn9zvboWGuQo8jbCgIVosko4uMEmZAZwV58SFgDDWCSvzZnCp?=
 =?us-ascii?Q?uNIV1d7qv6hWCMwrmxj8qloLHMa5tlUCpSEkVi94Mr5cKEqK/PLDIQCKuFL8?=
 =?us-ascii?Q?Ag0kQFcc51VEITlkZ81KKH8c5wZwHHFXB8MaESHQEA2YyIATckW4rVPpkMuh?=
 =?us-ascii?Q?/dtdPHL/TKrq5QvShUdUZRYetesQItlBZK1fMyetb8OxKYzmBqZtLkz72Z50?=
 =?us-ascii?Q?Y+X6Ax7wKCNJ8b3E0ZYAKQ23ULgEHNJz8IWKYUGuivuXjrOqXK/syF+1c4eI?=
 =?us-ascii?Q?YMaxaMCsbWzBeLLgk4wdfRIcSM78uAphN+Z5ASXEEYcWotAg88ba5b9QOh7r?=
 =?us-ascii?Q?T/fbK8l6DyweSPIvECnNNOb9BmQitGo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c0ef662-883b-4e80-c99d-08da00427856
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 13:57:51.1735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X4tde5WrN45GQibvDMdoFkJq9OXWghgSG4fUFLtnWhH4Q37U7/unNU8FptoSXefecGMx8JG3Y4RYDHo9aaR+orH2aSQJ76ebDVYHYkLnbkk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0751
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
