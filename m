Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7AB5167B5
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 May 2022 22:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242459AbiEAU0M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 May 2022 16:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbiEAU0L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 May 2022 16:26:11 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CC63A1BD
        for <linux-btrfs@vger.kernel.org>; Sun,  1 May 2022 13:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651436564; x=1682972564;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=bLkm29lpakOE/Cqfst3EEwA+NxhEmxA8Moo22FYcoQM=;
  b=UGCX/NLhXTb1S5uuw7IbAqZKucIqfNmjRDl3Vm/Z/k8zBk/ir2PaTsVd
   /ILD3uMASuIO86LlDa0EBwL1HLejbsoQE4h8BJ5T7MCb4g7cu1VEL2k4I
   ZCTyC02Xs6Hog5cO00XP5cporyrDBrVDAuRVzSNunB0NkwUsxqB0l/Gy3
   0AKPTcuQWBNiawkxdMGnCwa+HXQM5jpRs+RCX4zNuv0HbSOhTojZvcLGA
   n5f6xJd/J0mBwkm+nOnxUHdKvnWn/REmDuL1OXTnLtInCLEdJVBi4mWtq
   Abi9YCYML5/NKOzSL9Lxypj9bWTFJ8IZ2LGY2qIX3DnHqPLrlrW1I+HjV
   g==;
X-IronPort-AV: E=Sophos;i="5.91,190,1647273600"; 
   d="scan'208";a="311261200"
Received: from mail-bn7nam10lp2104.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.104])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2022 04:22:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzOomrMBT2yaf60ndYYf3ZmR5a4yvfwy85jSfL74YlK20W4zmjBJX2JVqURGKcCh1wR6Qah9CLFrHiMD6dv3h1rbpF7QZHH7Lf/YJSzzgExATPQ7zEex++SQZEqTRXUsuh9kZkPJKbScmyD1Qzo8SWz7j28GOGWKGkgRl29TyLPK2UJPdDSoj98WZ+9oC2AJ1X66n8FhhT4IB+eYCbPMKyj7op9PVZUoHsCldVClaCvXGq3+dELHz8cNuv34HAxNbkd0bL/Z1Mzq8N7CnRM3fH+39U2yd6QQ4kuL6R+NbMypWNDEv/k/j3aNjcox4275dKa3d7z+rXPzteOT+rbO1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=McnnVC++gXM8I+xFIfgkBTC6sQ2bH/nnjFQX0tVz09o=;
 b=RrRw6ECZ7rOtP3VJ0ARNFH4d09qSm9avAeEjQhRW/Wky1MoqQC3UjPoHbEiFbm09R7N4Z6MesOlzd9LecmYPfrfWRX10D/y8L035lKRMiWmxQ2YkL4BPvPWhFAtc8TXTqGBmyi3FmCReDmSYQrioz226RTOA8kV5+l/Zkkko2hU2yNOXbb6Si0/cydGwrkyWJxMDxeJDuBDMboZ/HO2RFJ405xg576jaa9mmjUEGI2JABPfEk29n4EDxCkiYkoGvAUqwKRvT2ElliDxZ0+goyNExauTVJWlNozkhezjyr7Mb1hcPXv8YADVkKXg8rxSu1MAkm1bNGNTLFo80LQmIHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=McnnVC++gXM8I+xFIfgkBTC6sQ2bH/nnjFQX0tVz09o=;
 b=lt9saW8xN2BHOVTKfNhJQOg4kaUbhRVHjJLPPMDQIMGV73kK53NR4MxuLYiQsbN7yKXqnmWtgH5f6ibpRyAhOsEsKQ0wdVGeIhCVAnINqEIV+e0oIVuwWQKAj53SvfEnjxbtwERaAI5m3ogdAZCKG7K5OPocuuvWVJ+bBlD/Dpk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY5PR04MB6689.namprd04.prod.outlook.com (2603:10b6:a03:228::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Sun, 1 May
 2022 20:22:41 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5206.024; Sun, 1 May 2022
 20:22:41 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 7/9] btrfs: rename io_failure_record::bio_flags to
 compress_type
Thread-Topic: [PATCH 7/9] btrfs: rename io_failure_record::bio_flags to
 compress_type
Thread-Index: AQHYW/dzkKEzE+jMckCfgwZPJ+TiWw==
Date:   Sun, 1 May 2022 20:22:41 +0000
Message-ID: <PH0PR04MB74162830148A045DDBF6FB199BFE9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1651255990.git.dsterba@suse.com>
 <54b867c85b5891611c1a8f5a412abb06bbe5db61.1651255990.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a354e849-8f42-4ba1-d432-08da2bb057e1
x-ms-traffictypediagnostic: BY5PR04MB6689:EE_
x-microsoft-antispam-prvs: <BY5PR04MB6689E911EC7B4F3D9022E9759BFE9@BY5PR04MB6689.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k9Sy9EbPq0TyUInZi1kp6FUGfg67CFDFR27h6m9+AVlV4bvIzT0y0bmA5OrStsN0XEO4Gd4rQS1u7y5y/gGseciItbajJQ525WixdYKlo0QF1B6wTFZYLmIQjAvliI0SDoKFLn0i3zUoCh9cOUJZFS43a41ap7WQMD38f6LWHzP+XmWklvG/fftAH7ZElzwTJHhvxPKMSSAkYW9Ncy4gnP9zafwu2bBZRfpcBzDrbJE1iTHEjXUE9nJdrn5a9SuQaYU+0TiVUckHG+7ZJqCzH2ZrC87QD9rAGUYtjbYjkGqWEq+GwniySSFwTC1/jIKz5SIxGb4bPcYIEcz+0A5K1DKTQcihHIc0G8v4ZdT1CLDZoFHAPWqYKWuiQm1+iMkESnXRcv+8MJMkZm8m3x+9K2j+HA60rWsOFR2doErWFlne4pKuTR9kMFUDgdXlyZ6XP7jOhS1WpAxSgT9EnGjBMkJU69JvO1iJq968ZNPLz0kl+NKXlFLPG2KZlPZY3Lp3+cXh4z+dzkDFy3sviPUZ0jUzwrha4siG9VB0iOTb3aQ13uBq+pZknkmzogvgTTcFkrrr5aQ4lWQVJWaYOy9P0fI0Tbo2/8v3+t8RjxOASp7TA8P3wPQBR52JSCKDGW5etpeNLmbKVZq371YaF9lvQclVuzsNcmyltaP35d7kMjKo23LRpbIRF9W2JTk1gCgBuvtWnM4XEXQxeeWlQhY9Ag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(26005)(110136005)(38100700002)(52536014)(38070700005)(2906002)(6506007)(122000001)(82960400001)(86362001)(71200400001)(186003)(83380400001)(9686003)(53546011)(508600001)(7696005)(55016003)(5660300002)(8676002)(91956017)(76116006)(8936002)(33656002)(64756008)(66476007)(66446008)(4744005)(66946007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MEDgKwpLGRCOd+zsUqDYs2KpEgiFSsXhX03qZ6ekTqhnKLqcfsHTgU2JTyqK?=
 =?us-ascii?Q?1BZKvcwpqA+S0BOMXUw1QvgChoFrjudVp7ay2suCVo/wr9N5anV8ltEJ6C4j?=
 =?us-ascii?Q?j/H9XvxgcqycMdiZi11/E3GMWz6KVwTp/sS+HRLnjoNv42aBbKZb9waN9/69?=
 =?us-ascii?Q?yz8rlk0+Lc/OwXA9u25ZY1DgT2Yi5tohtZJ471fEZoy17Bszr79YKBPSnOpE?=
 =?us-ascii?Q?DXi421ib2WItzhr9XdxgS5L0ztMbg3Rhxqxz6ToOrLHM+ixUICr0L5wH3Mjx?=
 =?us-ascii?Q?qxaYCpnteeyex7PL1PR/WAACRdCyW8Np4BSrc8EjJeCe1nOHS32oitvjUXR/?=
 =?us-ascii?Q?bdaxzVrEHUW02URoO4xOwImrOv3WZXC5NApq0ojwusirGooyunofYy9X6EWK?=
 =?us-ascii?Q?qtWQ8DfPXLmJ6YUPfdL53mDonvnEtC5jIwjcp7eDFJnt0xGL7jOKjG4DFf4h?=
 =?us-ascii?Q?PzMyBVj/hCmIOGe48k6Cj0uuPwc4hwmnwqEIyYen+6bjuNWH58YLyfX/xF1s?=
 =?us-ascii?Q?P7m1PxX8HUU3UWixHt8S7zrEeAdmpF1BmmABeNK30UFLmUn2OnBDx8z67us/?=
 =?us-ascii?Q?XENEepvzuO1O3VljXtumJL8FyLw385Yim1mSMrajt3CG9fb+aEqhxyXLWjAw?=
 =?us-ascii?Q?lVqpcw8QqrcL3h0XH4YHb31w1K8z+dnlTSQgZOqCxE5aibO7/iFL2lK2pt5f?=
 =?us-ascii?Q?rCRLUQT8bFSYuXwL88CQhNqzsIiu/l26LO95j69PmiKjBFySXSn1EkC/P0TB?=
 =?us-ascii?Q?MVMLUwa/7VL1dJQHpHnc4l74pIlMQPkNDwQQFUfD2PgxZ9pH3GWf/ri6YhIt?=
 =?us-ascii?Q?SU65MNJK77w1l7eWohGQbv3Tr+UzPGIv7InJmRLDJQhJZH2YXRbq6gDdJfqY?=
 =?us-ascii?Q?wu1DisLlL3GzuDuGEP3V/DT8Vt2dy0r2sGbxJIRvYr/Tad0yY0x3WPnyKEpK?=
 =?us-ascii?Q?NeT7BHDiX8vUkanki6Y8krnT78HxcZmrpNGp1wLXNOZpjJydJjCX53VMSSpp?=
 =?us-ascii?Q?itCd+OmOUvgiP/tu1pG3C8JaDifnwY3q2xFioX68wIgjuT4dgGc2l6x8zKlb?=
 =?us-ascii?Q?KMjMwWxj2AxPeY+nr2DzzmezpL3iYvIL3zutvQjSI52pA/SZoP/RVmy/djOx?=
 =?us-ascii?Q?vBD+pxJ3YTw4aToemmIrT+f/NkGsVYoYjQaCUcL36aWQZJBeIp9nIbCBdE0P?=
 =?us-ascii?Q?tp2sHdAw9Q4q0rH4cIVi12rYTf3cnWBEbz+VhRyHs2Vk5fu0g++pc+xzrTNT?=
 =?us-ascii?Q?QrEUF6N05c4OFq9XNr/kr5qIhk4xW310BKlZ1MJgXTEYjr8RipIPbhTbNGHY?=
 =?us-ascii?Q?Sahe8G+Qj/pCR34JTea5iaVHu7sDrEQJBTjAunXBGlVJM+UWJm0igW1clOOC?=
 =?us-ascii?Q?xEk9EdkzJx9P5myiXqyxeDxscz990WDSN2ZyKAqwdxRzE33KJHffIp3Vyfxh?=
 =?us-ascii?Q?Opp27RwACVQG9a1vScTLB1Fu3Fcp6RqHpReX4Kt6RmSQHC2A6KiiD7yAffYK?=
 =?us-ascii?Q?xfgtDghkhGn33CqcQ8yPuMoi7MS0dAc9hTdjYzVcCRyMzJrMhLhW2y7EB5e1?=
 =?us-ascii?Q?t7soUncnH5JL4mCO4sYgOxU/ejJBj8iKFKDApZA9a2C3d5m0T6qerHTl0kDM?=
 =?us-ascii?Q?/7xclE4ORP3Yr/2ENC0mXUrA4Rjgrya+rarq6QFlNsx4/uw8N+98VB8ldukr?=
 =?us-ascii?Q?L8LUhf6WNApakltJK2GfABoz+bbAmYmERk00gt20BYs5ns+TLmULMe2l9Ck4?=
 =?us-ascii?Q?y2q/E3JQpFZqE8rryPLqUQfubIpxuqA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a354e849-8f42-4ba1-d432-08da2bb057e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2022 20:22:41.4690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kDNxB8jQ9QY8XeMufAJLjV4wT6j70BNoGoRkChSRgQZghtohQLKuCpjDCAvK9HcI4fpvMSDYs+VA7MZmlcAsL7tJ7ZD4I83T/eA3xur+v28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6689
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 29/04/2022 11:32, David Sterba wrote:=0A=
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h=0A=
> index fdbfe801dbe2..1fa40ab561df 100644=0A=
> --- a/fs/btrfs/extent_io.h=0A=
> +++ b/fs/btrfs/extent_io.h=0A=
> @@ -266,7 +266,7 @@ struct io_failure_record {=0A=
>  	u64 start;=0A=
>  	u64 len;=0A=
>  	u64 logical;=0A=
> -	unsigned long bio_flags;=0A=
> +	unsigned int compress_type;=0A=
>  	int this_mirror;=0A=
>  	int failed_mirror;=0A=
>  };=0A=
=0A=
=0A=
Why 'unsigned int' and not 'enum btrfs_compression_type'?=0A=
