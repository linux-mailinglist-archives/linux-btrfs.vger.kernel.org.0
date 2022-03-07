Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE184CFBD0
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 11:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237930AbiCGKuK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 05:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241986AbiCGKs1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 05:48:27 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871192982A
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 02:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646647686; x=1678183686;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=La/aqdU1KXewE9puOhOg5+uemA4bk1NshR4flhFwbkI=;
  b=QMIZnSzXRMykjZg5XSwbLxYb2g9oV0SIyqLKkFFh1MAVjmGiGnQ4BFXb
   ZLw3cNCaBFQqd0kQydbvi9ZzZR8J/vAYl7t9Ipe+8s5iHr0yrCCruaZp5
   FLxzNp+WDa6ZSe0KIeR1FkF5WLgeGQu+lAlo/xruXL4PToQgWPL0ATYXw
   /5lVwTFV8aawK5f/94fnBQ5Gm8ROf/PRN3c52edGK8i9RUI2rBO8sbMGt
   qcyzm/OtrGVI3CABtMwIbcHawMCO8s6DnskUDg4kJcvYUxP9fm7wG+CKr
   wGcN8uOBsGU0dGHmtmNvdHBhae8YP82+GatMfPL1nqRy1uLhfGWOaHuV9
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,161,1643644800"; 
   d="scan'208";a="195613173"
Received: from mail-bn8nam11lp2177.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.177])
  by ob1.hgst.iphmx.com with ESMTP; 07 Mar 2022 18:05:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jlrVklU/kx3H1ytujNKLHuzt5ECKXIyo44eZVjGPz8DSMbgL9X5tsg0YfNZfRN6BURWOCHZjkaNbp5uqPYWsTsYrnxAGy0rWKcj4g0D+v6y3A6KkP4xifmsWWjypgaspT7DFoCie0FtCHFTNt+PitjBJRgjwK1swhTRXPm7pUchTKIIA8gNyCp87qVWPKG2Zc4v8jFSnA5nxzxDxqaI8TzlNSBbbSbKRa6sYYKS+iYmC7qDlvMwAeHJsy6nPtUg7NA2WFioKxaXfycRGmRqqsaTJ6dPO0q6u5EdvXRKUNGhj+KheK26ZPOCMNEaA5IMkLOt5KqYhMrp+mWcRH2dD5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u60Zl9FqhRuQoXBTZpVAiKRvUPFQjDZ/0CvEymJGn0Y=;
 b=QlE/7es1orH0yzl0qx7Ond/kQUdIcYEyzd6+C5Spmv93sTSwW17vLRwWT6Klot9TjPKOZoqyKdoBH/umW4Y7WsPqvF1yS/Bi+0gpmfG1k9RbGZiQmIOaazJByrnDN99f8hubOEKt0apwaUFe0dJCHrgQiLJfTymccKzufIckQ3P/zEpuSELXUUGQSXBKrdC7TwEHbgmajteJvylvbi4VdQby+CAOWolghfRQQOKm+kqslnA5bTSwspQqbJLF4Ip5bh8fKJfQCozPLRaQckoME1CD3wA38HQl+GjvGudFMVGPtttEMTSPMMiZswyrPKRTMVID9xeXndlr5caccHmQJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u60Zl9FqhRuQoXBTZpVAiKRvUPFQjDZ/0CvEymJGn0Y=;
 b=X1nHslymfjWpjh49MWQApoDXdriE5e0sEiMp4qjHFX3FO0bVmZVkt51gRsstNYEWC0bkHYsoGgZS+zrntBWoXRyr0+sphBwC+2sV33tUR0XWq3gvr2SGgiN/vVGRG/kX11Mjru+vpKZJE+m/AH9GhE1TNCzjWcZS6ekK+Wy56n8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN0PR04MB8110.namprd04.prod.outlook.com (2603:10b6:408:15d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 10:05:35 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::e8b1:ea93:ffce:60f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::e8b1:ea93:ffce:60f6%4]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 10:05:35 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/2] btrfs: zoned: two independent fixes for zoned btrfs
Thread-Topic: [PATCH 0/2] btrfs: zoned: two independent fixes for zoned btrfs
Thread-Index: AQHYMgjJkOH7SGjjqkKWqSVyGQuSAg==
Date:   Mon, 7 Mar 2022 10:05:35 +0000
Message-ID: <PH0PR04MB7416446CA0E595F6FF84C8A19B089@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1646646324.git.johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ebb370a-f8fc-4840-9e7d-08da00220626
x-ms-traffictypediagnostic: BN0PR04MB8110:EE_
x-microsoft-antispam-prvs: <BN0PR04MB8110F5E6C09A3CE223BC872B9B089@BN0PR04MB8110.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JbA3dNsEfEAiWtoM2vElUNYohU47wyF4xo85HaCPbiDzd+Wve/uiFgVO1d8zbbn16lKGbaPDVevNRbfRoTEPkZU5WU8gHdNiC2ne4QRnX5TbhvxzWku3o0TR3UqHhbMlT9MQKJYH5iHQWnmuGWJTTLqaaV+Ys/WXrN8TZ4z4xlAGbkrsFHeGJ73YLx8lUtECHcr7lW3xjn7pVM8gmVE7jezlnX2rFO/b7J/+fAd9y5rUZ37FyP1FH4SnBjE9Tq2SLhQ3fU3vWuf7ew5Y15EoJCCElfkp4Jj9DL4QG8G6sDAOrpFmABjg6GaG6cnzqeUChOKku6uDpkNVZk0BULwEoCfi9TRoi9uc4xmGyPnmvgqmLFBNy9vb7FVY2YzgsvPZEO78c57yIgkkUBXOI29I0Oj5XhkKmQDGDyvCAzBZoh+xqYHlV21qqduO/rWevqawLRIOOU6z1K4k72HffI0f3uD/RCOtRhWYiEIHBTQ1F7Ueoqij+MVfzIn4avM+YFCeRI1Nnm18scNtCV7QvanbCTrD7krtCLgN1IEoY5cdAhWxeGMU3ZBRmQWufiiOW/LRPGgJ59LkCLo9UxCng2UndXJb6AZ3X3Ds7t9+TK85pVImR713RKHGE+uHL7pwMXwaZShJKLmUtpUP87Dr7xAbu6m1mNSmSbMk5wNDIwgiHb+aNM3TuTHQxFMZOf0skY61di9PM2PmcIN0pHI02EzlJq9dkYqAXPUr87R1quhPg90=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(122000001)(33656002)(38070700005)(82960400001)(55016003)(6916009)(508600001)(316002)(4744005)(86362001)(8936002)(4326008)(5660300002)(52536014)(8676002)(91956017)(66946007)(64756008)(66446008)(66476007)(66556008)(76116006)(83380400001)(7696005)(9686003)(53546011)(6506007)(2906002)(186003)(71200400001)(17423001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mh5/2KCfFTqETO+FgpoPuSCd787ABODby+qVjAl5R08b5U/YZG9gLYjxKW7j?=
 =?us-ascii?Q?tHnIBuqDUACSiUqrQPAaU6hGskXzr2dMu1ZbOSW/oaRrCHU9NE0M1ubZP98a?=
 =?us-ascii?Q?A/0trKye3qE77LQrc0y5THKZAqA14cpQO3Km/T0gYf8WhZZzsFC+qHwMaGMO?=
 =?us-ascii?Q?8rHIdbO1fRHVmObTBndTP2gvJiGrQZiTWTAIlbINlIK6b+t+iZ8899SFc6vh?=
 =?us-ascii?Q?QPuMmI0zo1kj7F8D0JO8hSjd5Vx7wCY5hwoXdhhAd3jU8gJBVChKSP8gmqyE?=
 =?us-ascii?Q?VPiHBdaSGvM9Vx3IzvylPnIrf+z7MIMFUszVR8bFXfHGb3xl68Vlgp+xkj9g?=
 =?us-ascii?Q?BeeVAR7UU0/kixTa6YuQGu1BPUgIsfQSW48K+ok+fQJAocWkV6E1YbZsw6/K?=
 =?us-ascii?Q?c53QTjw+MKY9MFALiAAOPfeHLo3N5r3AwVyH8uOrsKSqbRlgpVq/XLtYEts0?=
 =?us-ascii?Q?k1PJpT9eguzAS1XbM1Ogt3N1zDkB/wqoHYsN97wPTnQ5V/hh8qJi9jP6l6hp?=
 =?us-ascii?Q?usssK0TvpKsQ0uVVbPp6wbnzgeJ7nibaNHrwOToqyVp+04AbAovyrOISy9wU?=
 =?us-ascii?Q?TXFAr/hOlTHCSLKh/jM93ArG97PJlgsd4i64AGQRQaiJXSPINbJm9Xn13bO9?=
 =?us-ascii?Q?KaIqQH60vVzoagDysb9D9oAqem3k5v7M8FzfnS45Xw/HwjfeSf7OJ2pL4NWE?=
 =?us-ascii?Q?5DK2XnApt5vDLo+3n4x3/17N7VVHZLjgE82LEZfM+rv9basm3LKqNKByw1lS?=
 =?us-ascii?Q?vq4ybTEYXD4LVT3oC97Bw9kMtQMAmYhsV2uwOIglR6jQPYxjcqKYUpyv+B45?=
 =?us-ascii?Q?Y99Ds3r6dH0KxqcZB21FIbzSO3WJrAiG6Yep9J6nl5qA7aBATFOIq82dTUdF?=
 =?us-ascii?Q?mhmuIPE/MD1G/NHZz6ZA2GejeLhXPZZzRyqJYlqI9dnkt7ayJF3gxjBqx4Wd?=
 =?us-ascii?Q?l1MZfRwS2hdq5teeG1Ul65HOhCvAQpjTytgGC4WPD1a/peKrQFC+vBYENs3W?=
 =?us-ascii?Q?a8WJqvxchUlovw2RUbCC4qDAOmkIoTmoM7sM58JXvhsFMyZI+I3mHOKNnm2T?=
 =?us-ascii?Q?9n5Z1GrMuCgG4NJYK10ebt6sF1N7vT//17V5FeRpFq5aWe9I3AWvmeqySCt5?=
 =?us-ascii?Q?4vxdE90mMG3t6KbbME/hz/Z0LROojQcZ5Q8eslQoLsZU+EOL+lOqLnlglO8M?=
 =?us-ascii?Q?uty4YfoSswjtCyxV3hjPSxunMGxSEqcizor+7QTyY+I2BI+UkUaqAd0BqIFw?=
 =?us-ascii?Q?4m9O2r//QNQMl41+FHQGH9dqWTV+NdsQr3oUVoBBq1bRSzDMLEQk+KQlkGNh?=
 =?us-ascii?Q?K01pNdzPgGcxjvX/N8hO54ByMZdEDugkHnDRpAvLACfWaOMmA6ccN+XL+59M?=
 =?us-ascii?Q?J7oM1NMAOuLfWGtRqXDme2lUA5JdCIJIH1aOt54652B8+pw2M4eLfoXTVoPd?=
 =?us-ascii?Q?NNd1GB+5FXhqgh9OalE4ShX6svpVzl7ocUP2OTfXxY8DKIughBAFFXTzodmd?=
 =?us-ascii?Q?UWS/fl5iMXA+p7T/j7NdHwmsh6UHE5J158uRNE5vVKP7GqLpp2I0y8Q5bB+P?=
 =?us-ascii?Q?yh2ZoUecCz8/RB1RH/8djv00wQFyTHCVJ+HAfdZnMWvo7jR0nQk4poUwN5eY?=
 =?us-ascii?Q?uVuzYjWmYtweAti+nqtY15mM9P2rEABbJWnrIr/fNkghcCKEAR1Q0eKCPeX6?=
 =?us-ascii?Q?yphAOssMXJMP/iKUf4Inwb0sn1xhgzuWFMiRMEYIJD3JqFFd3xLNh91zW5Bg?=
 =?us-ascii?Q?HcnHtdfhhDNbWhettxeGPjSznM15DPg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ebb370a-f8fc-4840-9e7d-08da00220626
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 10:05:35.7022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EwMEkB2k19POt/u44C4RZT0G7OQJV3RTy8Ut0V6ZlvLOWqQGL0iSvX51URuvddyltgLdA1I5IXgFl5fyqYmo/kHTY/sPdbWfA9LB+84XLkk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8110
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 07/03/2022 10:50, Johannes Thumshirn wrote:=0A=
> Two small and independent fixes for problems found while debugging other=
=0A=
> issues on zoned btrfs.=0A=
> =0A=
> The first one is a possible deadlock and the second one is for removing=
=0A=
> leftover ASSERT()s.=0A=
> =0A=
> Johannes Thumshirn (2):=0A=
>   btrfs: zoned: use rcu list in btrfs_can_activate_zone=0A=
>   btrfs: zoned: remove left over ASSERT()=0A=
> =0A=
>  fs/btrfs/zoned.c | 42 +++++++++++++++++++++++++++++++++++-------=0A=
>  1 file changed, 35 insertions(+), 7 deletions(-)=0A=
> =0A=
=0A=
Please disregard, the 2nd patch contains  changes not belonging there.=0A=
