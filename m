Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB8C5B9DAA
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 16:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbiIOOrS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 10:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiIOOrQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 10:47:16 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5480B578BC
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 07:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663253236; x=1694789236;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=OefypmDVlFOlLbSWidYaDnHgeRsCxgNSJZaErXgwq+kZEAGlN0QjPW5h
   vsYs3o32jzRftrvgzHPJDwa+udtiRrdRqOWqTjW2i4jo5TURW0PnQMhqE
   DFTDBkFwT2ShrxLyfIr+DIjz9W1szWJ19J/qL24a6teVBK8vOg4TQj/Vi
   hFUIhFttCQqWOOzGzuBHSIqaPJv6nxrV5gmVc4aiG2yWqjPvwtogWnkKL
   dHWn9/enEraeUIT7MfyN6qfolibGkVRRr9GVe+4tN1fg7nlPAlA/T2wO0
   +2dpXFx/4el+ze2INtt9TfRTcEdKlZcJHtVn4bOq5rxwMvxD+mrNLV7cD
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,318,1654531200"; 
   d="scan'208";a="209842577"
Received: from mail-dm6nam11lp2174.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.174])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2022 22:47:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+DoqN5W7bttFX+jLbjKVhBawR1p3IMYaIFtcHkgnioqfkOoSk6kuRWd+qJCFkchuaF6XTGHvbzZxAYe9R+7hqmUNOORu349f4+qKfddH893UPxJP6r/MK2fRVfqp8CHwAzY8/a+e7S5Aq+d8VWOdLeTfE6+Y9cu/DIyNiRyJGzXPPJBiBItyH1QwOG0erKuXJzQgs4YMFnFQe0WM49CitfeGYH5khlNHRvO93N/FqAyfya47ZkDYNvj7yv6WfDx7SddgFxMHrseQEXyv9odwLUsXpJtU6nn7Vr82Q27wKpjakq4kRmuE8CQeKHOI6q9uvLOF6j9Y4w9VQ+cVP56YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=anMX0gmIpvaqfEXZ3LOQYR+jrmm9XkfqATAs9eeQjuWWNFpfOHmxrhA5xLN2z3VmzIt5bHzdykjeQUSII7pUttEZ/weOjyyoWkYWLYNBzZijt5dTmjHCwGIE++PYabkTvKzHrIR6Ob2kMGT8L/BaRP8ZopGYRMFAepLFSniR5FWJYrAjlncRpf8cuI8soOm+um2xmCHgHUE5tLnZfir1z241yzJ5JtAdaItP3zkg0cKE3f6LYI/GTWgX23ckhNgQunqWiMYcGctZq131bGeqEy8//HPQw+pYtYTUX+MWqjS5x8J782v0ZXJx6plp3bOKyerD7L5ci2QGksqMTiugYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=M3443dC6+mEOQZYSwONG8XhpZqdLO/W8SNNmn8Shhoc4R4s1110J27GsbUjfOCJ3PgeT6/ThFPyIKrUrkgWA9hy6fMnX1IMpVV6T10yco1D++xgJwNAUVnpBf1TENErKQy8bvWeipmsLEB9XUGEGEKt9UHWZiWceM5dxOVOUO9A=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL3PR04MB8170.namprd04.prod.outlook.com (2603:10b6:208:349::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 14:47:13 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 14:47:13 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 08/15] btrfs: move fs_info struct declarations to the top
 of ctree.h
Thread-Topic: [PATCH 08/15] btrfs: move fs_info struct declarations to the top
 of ctree.h
Thread-Index: AQHYyI52gTT/iOXZVU6i9EzThT/3pQ==
Date:   Thu, 15 Sep 2022 14:47:13 +0000
Message-ID: <PH0PR04MB7416E0CAB5AA17789E2AE8C99B499@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1663196541.git.josef@toxicpanda.com>
 <9506fef3a36ca9a740283dbf1df1f2d884cb732a.1663196541.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL3PR04MB8170:EE_
x-ms-office365-filtering-correlation-id: a50d627b-5f9e-4261-85d2-08da97292d70
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yj3ym5V/c9vfXWHvKt3DrjwoQLrJbjc+s3nnKAtCeIEZ9VEid6+DjxCxXB4J/UTUNadiShgG2ZAjCLXCFoES5Xqki3O40U6W4FvJKC5wRjYhUSFAgT2sPZcgSLE8VfyG3nMhm95zQvwUZrP0UhEFtd9qv0HWdBa90m9iEGyNmW7vATaTwUextYjDtnXz4mjmZJdgyD+7SlIgvJQWHlvTRptRXhVowNpUrx/rJrVD0DasD+wX6Tv163s6pQ3mLgKApv99UuZvB1F2L2Uv7oU3tVcrptBvZWSahNzWfO9ARU4mliI5cx+ZkjAVhsBxyuhgYf8MzbcF7c9UU40I1m/BK59KtGLUUP0xoHlWcN8qTFArRQIZ18XP5rlbkMiD09+Tc5Po+K9G+wTcgdvspJ+0WGtGuBtSSv7HWQGHGhvdeDTiIhoib8hExPVjC3I3UYbv/jJYT9LKnArPT9EMEuQ3Gnz93D8rlBAkqVvAAKoQGWfHAtlPikS4JoHZmoV0MLcvCo7NOPAtgkmDuwjNOVkMCCd9sxSzPt0HFBDlz5nEag52CZuztm8Ok1qJpTV+zQaJSN9pP+9bsXpJfFwilBB7LgSgAoxtECZDB0NINoPzZXfZi3A+evwe7Wk9PoCW+T3+z149DnYQl1UsW1/Zb4c1XOxmMVO1v08osy8AKPSmgJZPzhX8GQk1nlQSfpUZACaEGWWf2Cnfrz+8nmQzbfsKxURaVd7bgmGlnqpXhFv3Vy8nmw89gdxQGVsWohF4O9rrAPQ60yYyZ7DYnFGJNKtnpw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199015)(478600001)(4270600006)(9686003)(558084003)(41300700001)(19618925003)(6506007)(38070700005)(86362001)(82960400001)(7696005)(186003)(38100700002)(122000001)(8936002)(8676002)(110136005)(316002)(5660300002)(52536014)(33656002)(55016003)(71200400001)(66476007)(2906002)(64756008)(66556008)(66446008)(91956017)(66946007)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2g82B0NYn9KrwxPitcpvzLuMNxOX/tNTxx8xQXYndc0H2fz7U3x3TIQOOtR0?=
 =?us-ascii?Q?E7M0fCketO6e6jbPmt4um9nzA1C3qvZqYjsRXnzu3ORMAlqzHNBpxvIKirmP?=
 =?us-ascii?Q?DI0Ix4nC7RpCE7p2v7yixRH3zF86uNiJ+/cVdykj/v37zLPsWt8J0yuH6WpO?=
 =?us-ascii?Q?59SRLGhbcoo6hsakIO1e3mCE2AjhCSECs4joi/Ewu3AEWYuMTDIlCQWGDnlz?=
 =?us-ascii?Q?Xd3LNwaZtmGNxrsBpfE6UqMbldwT92sdW6pLrcl2zbaOF0Fdve0wMKxNeoVD?=
 =?us-ascii?Q?k03rqbCyuJaUBKwcyBaXX8DEpILQ+HXJ/O70xYKcTiBFilks4gcQqe7kIXNh?=
 =?us-ascii?Q?jMtSt2lLs7UP75Z5Zce9Du8Ja4IwiqNfblvVtUK+GykFmgVmuI8CQW5P4AOZ?=
 =?us-ascii?Q?5JJURKeu4Ma48FqyHtGCZeFnFYzKdOYfz661vjaldeLogPLWY3vcAk5/8VmI?=
 =?us-ascii?Q?YdXj4NIMizxgcnherQovNe6Ffou3yWm/dX+fv59Qu4eZijkUAtGQbsvzY954?=
 =?us-ascii?Q?DjmTHZ1EntT05FrQSKQw2yZNK+4EXUgerYimsQ1KbsolCLoUlhf/CdWLFRV+?=
 =?us-ascii?Q?4uBWqccE5VJKPU2Vldeba19aP/qTxURFtK+GWly1c3Gv8patt/8qpWgc/Bdm?=
 =?us-ascii?Q?dDBR6BSX8+KJ04URpEVVJR3Ik4JaGTq0Q5e2GZYKOAPT7g0hARvzPkUUvPJM?=
 =?us-ascii?Q?cbp1vmCjcYfb9O62l6JABnqjYfyGG8UEJZQKBRekr8zcUZCbFCqERnkS45nO?=
 =?us-ascii?Q?T3vlniMuRf5vqvIF2BaVS7jjFiEYCSJjnV+VkUpGXtKPA+UdCHpTeCJWbpuh?=
 =?us-ascii?Q?qEchpqRO3903DLxgHEnPy8Z4C81eyvcI4kSlcWXqKCa8IMpPIQr9PCN4mag/?=
 =?us-ascii?Q?kcUfuNmChATTdKJm5Ook50Na9Tv/B0rN3uyEp2Uu8LThepL8VMLLvTPEP7+o?=
 =?us-ascii?Q?wEJaCyb33SI7HWtuh71yBP/3C6J/fCViOBDVPpSZwUpBuLFZ0G2CbO/yhbVX?=
 =?us-ascii?Q?QNNu7rf5cXmIrZQPwYnctEQ69W4fqhhUyajneJo2IJnRWpP2jZiWIbceVy+i?=
 =?us-ascii?Q?D+usa0QSlB/kvu9T7QSVEvlxPYVnoPV2e+3tX+fTzhhHfMSIXsX9fobE38u5?=
 =?us-ascii?Q?phuthHDG4oXFSWkl0hWoGC7+X7dp9JFmwWf9ucZUGwePMTRRWWOhJgu1BHso?=
 =?us-ascii?Q?HYUtHi8NprjL1yODRRdCLWxQTb3gdHrxx9xx6sQKFOGfdlkwEfZ8c/E0JIf2?=
 =?us-ascii?Q?c7a+VZXma07jFIPLEKv0l8IYz/0/CTsGlkFFoqHwfkBeAgfWACDmHg3i105b?=
 =?us-ascii?Q?oAQYz3bYdMmrtv08hjbDgnZ4vx81wCmYVCLo04NSX7ioSZmUQjc+3fd363l/?=
 =?us-ascii?Q?aro1ywnfPwBznbYcrMw/t/jWDiioisgC0vqVvHrvMQLdq/JgnasoSe+5BSY1?=
 =?us-ascii?Q?l8lHc0UDnI/oJb+28CDWaFFmBrmbCNNQqRRNHjQbCymhOqR0jiWLOciQMWQu?=
 =?us-ascii?Q?RtVTt782pr55IE5nEco3P6cseMCNt3FgfoOP/iS5NHeRefRFxiiRFskyJbMF?=
 =?us-ascii?Q?BbGw6IBzoJuJrvAb0FnACwY1Yxo7enP5Lh4bk2sik02zTsJwxwXfYnoYNN/m?=
 =?us-ascii?Q?6LDxklldFy2tj2TlxRP7EIpq1yPvncvHeq/c9wctI6oG5HNKvcAczLikUz6U?=
 =?us-ascii?Q?QsnNicUPxuNPq/O5WaRvI117jVs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a50d627b-5f9e-4261-85d2-08da97292d70
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 14:47:13.7679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9DIrbYn3qNhIWzcocFkjLGIqOVV15uye8aYW93y+uFhWqq/WGHMmVwYFKUL15kYhFR19RBODJKQjHCEQYJzBn9U97DrXndIpcxnw9cqVdX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8170
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
