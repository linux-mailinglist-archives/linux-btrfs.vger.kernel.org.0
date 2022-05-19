Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CABA52D527
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 May 2022 15:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235570AbiESNwr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 May 2022 09:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240075AbiESNwM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 May 2022 09:52:12 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3559254030
        for <linux-btrfs@vger.kernel.org>; Thu, 19 May 2022 06:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652968298; x=1684504298;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=eeOw1JUIaTfnK4w4w/p7KHte27rPFyXzFwzC9bGxA3I=;
  b=NGM6cTKB38mwHd4DaQywItA65H/NucudUaVWMgMJYGtFQQ4De1lnwJjL
   CxUfiV4iYUM+ZvQE6ZrUf9yHRH2FajfptPb+mTnezK9qEG8qH5LVmkU9c
   yMBdPohVldS86Wl5uBMbF6pzItKu0ls8k11nIJ46g0oAn2qluS6T/PWQx
   x/B+Bji6rqEpGz5mwpV/T9CvQaQAiREpDhcUIfurrMlKwr/5MQqryOQSs
   5bay+o9GrJ9MF96hWfVO/q9VtOZxPUEFUyoPVobk1YbZzicBMn7ikEPSm
   k6g8+S73qk2iRBduGfRfGJ49ZelMlyE0mInLvAmALszbcNCHExb76PnMc
   A==;
X-IronPort-AV: E=Sophos;i="5.91,237,1647273600"; 
   d="scan'208";a="200799209"
Received: from mail-bn8nam08lp2048.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.48])
  by ob1.hgst.iphmx.com with ESMTP; 19 May 2022 21:51:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kt0xpMRKRI0+n6zIrgvaZSVL+IR3jECtbi2bDk9gIPZ4FNjHvxOAwBIPlFLlZrpWpb7WP2hcM+99MVxeTvPkWqjKviLoApSqKfeJYly1vG6K99sQG/DzT8iX2nqTvZNEqmBAT1dVNJJq+NpLNhp6bugmog2AXZQfDLDAMHI+20Eqn90ps890/QHKuo64TyAfSJ8l21G6EilCKBLbdrw500AzOdrqpcKU6toxAX79pMZEfFEKjUydZmTYBQXP1OweD1Ti0rZ9FBXG63gxZLVc4FRQcSPNm3AHzuKav52neGuiHnnrxxroqzY0XbQgQAQyejx0ksfN7cu/d3ynl+Nogw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eeOw1JUIaTfnK4w4w/p7KHte27rPFyXzFwzC9bGxA3I=;
 b=NunM75s+IAzNiK/5ocPJ3BCwELj5tNnpfKXPdyuiaP5mteZE5cnN2heodKRL6pT0jrOMcAeKIl1Q9qXVS+P/Yo7YsYuqNi9oXjp+x0/I6Ekm6fboUlqHxfE+wuksa7JnTRXXkNIdsWWUy4zD2IfPChm7lPo8U8QqpWEeg9bxY6F5e2ATbk7E9NddcV5hOPuDqW6r7jYdfCrjgZatqMNUjZd3iyHN6vxMrVc5wRXIKaT67Tm5Rxb+IZMjo3LczhxiWlmjz1cNNCX6ShFrpXLSWNvF5QUfj1k0aXkKXdc8FRnWTuYDx4x4sSRKBBhLCfCRaHL3xKuPlfifkf4Mx9JRjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eeOw1JUIaTfnK4w4w/p7KHte27rPFyXzFwzC9bGxA3I=;
 b=G4M0896D645s9hgJLADOJKNrTw6dvTRHgLs2r9D6RWXWUuxFGJxVxsU7DlSnkG3zWsxUjTVRA7jDFsEgCF5lqvf6eEkJhuett9u5YJDn8/3KUvjM53NgCtslyNH58/v5X6zFlm4/vOOPWVXdaazTzA8HLdaW/n3qMDxySpkS8yY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB5820.namprd04.prod.outlook.com (2603:10b6:5:167::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.15; Thu, 19 May
 2022 13:51:34 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81de:9644:6159:cb38]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81de:9644:6159:cb38%4]) with mapi id 15.20.5273.016; Thu, 19 May 2022
 13:51:34 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Filipe Manana <fdmanana@kernel.org>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] btrfs: ensure pages are unlocked on cow_file_range()
 failure
Thread-Topic: [PATCH] btrfs: ensure pages are unlocked on cow_file_range()
 failure
Thread-Index: AQHX79Oi2SbbVnAj6kGfDNF5QK3rBw==
Date:   Thu, 19 May 2022 13:51:34 +0000
Message-ID: <PH0PR04MB74166AC3EE68193876D5171D9BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20211213034338.949507-1-naohiro.aota@wdc.com>
 <PH0PR04MB741660777362929B7E3D11DB9BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20220519133850.GA2735952@falcondesktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9bc6e11c-214c-43f5-e146-08da399eb004
x-ms-traffictypediagnostic: DM6PR04MB5820:EE_
x-microsoft-antispam-prvs: <DM6PR04MB5820934F6546E9B0905AB1C09BD09@DM6PR04MB5820.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: legF2HA+1PG6hG+VXYgSxQwgKPyZDfYbW9mJbGTF07TVF8VCgyUerh+co7gpmZtrb8e+QzoWDDjeGMHxzbmsIdRRDNxic0IMvXumCorikGYDLdZ3xBzRb8MfuIs9oyiDfFRIOs15fMxjkqfAwG3F7OVqDq6mjxWizL1rFz1NJV3FGUcPr/08F0kTiNFNnmnZTz1I6Gp6B1NLwTB4AQIqK4Mj60lR9OnrrBIgkoBXTgIymrBpGed/9P/SkqUwzOiP8/5dr7waH13mxYT7JC+a7tuAKVEt671s5MFKUyW4nWK6L3YBzpqIvrHcXvkp0WHmnj6xZ8qeT5InSbQ4Z1aKa8e4uaxdlxlgZW20COoEWV4TbjMMmQy7hSF5Cj/kfvctC27jUbdYyIJYZ8c9KvQI76kLYBjjA9Q4tOf6LfSpnlT1BOUcNriYq6CjQSMNQ8PkksytN7ewLnMGI0cWk5mgM731coIFfL+KhE5ngQm9hUNHRfypOmMAPLTEU3F/1eonbyzKGfoSgkRqmxo6IOOp+k2UtuPeSqMzk3R4kc3Lss3XYmg4OocX6TXitGl8UF0mdPWlkraWh/jf9yGK2MFBiitZ9H3AU9Kf5y7zO4DgE/Zt6XFVrBRrSWADpSDGgKgXK0yhCH3PVkYHfE3WotulUZ9Hrd4kJBMsSAsqBsb4vpwxV44AQRNw2ecM8SIjivmpZQRe9ktT31BWVs95K9cWXg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(33656002)(6916009)(316002)(54906003)(5660300002)(53546011)(186003)(4744005)(6506007)(55016003)(4326008)(7696005)(82960400001)(8936002)(86362001)(66476007)(8676002)(66946007)(64756008)(66556008)(122000001)(76116006)(66446008)(91956017)(52536014)(71200400001)(38070700005)(9686003)(38100700002)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?47SaZAsl6TgLVNpLHGVMhoGJAChI0dmIhivjNoOR3+Tqn5TKFwU4jfgJ0rMK?=
 =?us-ascii?Q?B0+17lZ9INrA1JcF7reUxOigZy3CRO6Z/I/tI2OjI8Wcoz7/96jGQ0FBG62U?=
 =?us-ascii?Q?5PxSbvyf0pDBoTj0zM+5rL4X9+PODalpGoANEFJ7MxkRqxDmR//+iXHCd/TA?=
 =?us-ascii?Q?RENqNs/Z7e+hBrVCt3Bfd1SpVTSEZqK/d7H6tdB/e7GZIBef/pMpnhJlhuta?=
 =?us-ascii?Q?qYHG77+kM5vNom8lxgS4c6wLN5g7wML8/CbFa65jYLNxcCMZgcrAvast+4EQ?=
 =?us-ascii?Q?7bPn9ODYFdrkGnLg+M/ILQImme/+qcWmSIYkRFJlEjF/I/H/DA8znf38KpuV?=
 =?us-ascii?Q?LbUZFFRRKLKlD7AUK0UTnoRchZyIYVQ+DkDxukRJK7ZFTR8vfEeORV0qN2v9?=
 =?us-ascii?Q?St4nZ/2BewroViWFFETZ6/2OGznc5Gk4dl0zgVI8FYGtEMusZ2rQXfeZ9Gm+?=
 =?us-ascii?Q?/e9Q5xzkL+VgyxSGSZQzC+CBftbPsOG/28dnoRhw+86hU3Lv10OQU6FPsYs1?=
 =?us-ascii?Q?lo5hrEdhc+VbQ1wkuxXlTx3k0dBbc9It4LKDAWvhLT/x6cul4m6knM6V/D1n?=
 =?us-ascii?Q?ZuoDFOOBd4b5dicUQjGhi/k+WIzPZI1Hgi2FwRuR/+AioHbeXCU/3QsrthcJ?=
 =?us-ascii?Q?xlsoaMSwCwVb1YXOuGLXZBFMwSPQQlX69Bw07JpNUNpwAopXa71whFdVhkn6?=
 =?us-ascii?Q?Ri9yyS5JgPjMNYdkADGUZL/zg2MuPkvptZqEub9MwuYv05w7NlwQ9allEz7p?=
 =?us-ascii?Q?QeIrfYjHehEa4rgW4CHb3EC5s7A7eP7tM2SpgdG60ZOuAmMUtsnHuwbcKcP+?=
 =?us-ascii?Q?cOkBI9n3CWl6R5lrxEvmchBNmmxuAsPtB4V0RcpBDplIkfPK1rCuXRTTGAc5?=
 =?us-ascii?Q?s+q7sjJHZsQBbBaSikZzSsy97aiKxlxd8ekbr+wyipluGOoS9Zmh/YKC5X8n?=
 =?us-ascii?Q?lA/uEGqREjhBOmY0HOZbe2YJkahPm1OxLVxoQz0fZqnuDIbB1eZ89RauEGUc?=
 =?us-ascii?Q?PZ22maFT66MpkZe5qgBh+6Q5YkaTCD1nXxstJfSDlPDtbcU2jg7FtXDvgKE5?=
 =?us-ascii?Q?gsT3skkitYxaldvU+vCSsW/fGzUjKqh+nKDxxC7El0oqt95QZhb11UBttnMd?=
 =?us-ascii?Q?UO9WccIxB8u2icU+UzY5QqzpzCT3OkYok6WkUM6Q0TED29K96LTPks0YrWUv?=
 =?us-ascii?Q?RUCImZ6EM9wYKzFoER2t7QN3opb3nNq601v+EuWOARSkNQX6xHioBrfWrELg?=
 =?us-ascii?Q?F7H0T5Sf3LNrY4CmRmU94XFCLBvNtL6HoDSF0883wf/6LHiqds/kmR8UseUb?=
 =?us-ascii?Q?kMULudObIbvVcHG01r6ZIiA0Lp4aXSkLxek8h1wAgdYn/aFo4l8eorwu7V3/?=
 =?us-ascii?Q?ktXhSGJOhlJWWy5KSe48VbBUu/oK2nZt908get8o6obCIG5sXbUmYKxsvf7r?=
 =?us-ascii?Q?4/GcS71QQwcwCncWaKMF3E1ESGFqWoMtMEDNZRN/8L8O6HTRQ+XfjULL0DdV?=
 =?us-ascii?Q?wYPZQzMpzY74HohNeeAXxonuxp35TJIhFNH80f2f2uaavtKkqxS2GF5aSoC2?=
 =?us-ascii?Q?3j/gPqrZk0Bf/SXq561WiXzWRbzajCs6jC5Sp5bEGy1Kyuk2KM6K3vDE2nB2?=
 =?us-ascii?Q?8+96FottaDUWdzORVi1pcJQELlhEOamrLG1piAp7ESe9QaLB/WtneCADct2M?=
 =?us-ascii?Q?S8AyjIQBhoYLVq8Pwq4tVy9ep+bp/niSPBp8b9uTdgZNwlkdCttKQUGWX3Bm?=
 =?us-ascii?Q?92Cdh56CYgIM5clYN+KyBnT2DsHMsvWz5GJHNKkrvFDGnVYmCAJiuqP/doO7?=
x-ms-exchange-antispam-messagedata-1: 4QAa174P+7hCcZC1CTyicTApf4t4Y6QNGDpevVAwYwGKE6ojRM6MfoBc
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc6e11c-214c-43f5-e146-08da399eb004
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2022 13:51:34.6603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z4stWDtd+KB4aM/yEicz4Rtjx/QUL2PHmwh6blF+67YRF0gUe5tAbM0cpgDOW1A90gipy8rtTSBt+jDwJqaNVFaN1lUu79fpOym9gpzd/Y8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5820
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 19/05/2022 15:39, Filipe Manana wrote:=0A=
> On Thu, May 19, 2022 at 12:24:00PM +0000, Johannes Thumshirn wrote:=0A=
>> What's the status of this patch? It fixes actual errors =0A=
>> (hung_tasks) for me.=0A=
> Well, there was previous review about it, and nothing was addressed in th=
e=0A=
> meanwhile.=0A=
=0A=
The question was about the general status of it, not if we're going to merg=
e=0A=
it. I know Josef's reply.=0A=
