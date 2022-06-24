Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DA15593A6
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jun 2022 08:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiFXGlO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jun 2022 02:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiFXGlN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jun 2022 02:41:13 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AED262C16
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jun 2022 23:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656052872; x=1687588872;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=QvBeAanpOQAvnWMcSWCas3tRErto2YwRwf3wvd47y/g=;
  b=eNDoIehsxkBrkFtY4OJIZgZqDzOAChHzWjwFHl8bmoH6xqdu9ePng4Re
   EZhOuIELXLKjUBCgTvuyz5sQsuZo8vbaYyKWB+EEp8Iu/sZkljOCxorm+
   PRKsfhsDROCRpyKo4zBPzYOXChAs6yk1pCo3VO18HRg4CLNJ+hdvTQBgk
   VixF40zyuXTn7n9Ug2ms4c+VLKxgN9xjrzURwxU3UsPKTe88eNXQAoWXI
   rDL7G4WOiPaLytvpyQZUwqAQGksQyzck7/d00YMBdUytV3YK06GX+of23
   TrsBesaXYHlCvfOuMeLqcmrnZXPelLItOekE0180A1d1CYdNjnscKlqNw
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,218,1650902400"; 
   d="scan'208";a="204740452"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jun 2022 14:41:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3o3/aqawAvpOTQtS1gfSLo7zZGWpL9pjlMT1OfO4gpzTvGK5AiqSUwB6aECyTLx01gjvALP2f3EVQArfEV9BhJj7aM+Jy+h2s2BfxTbbRL3sRDnu/0d0V+APZcg1ficVqezKt+fGiwWIsuBNTgsrw6yiKQObzkCQESve9V83UcLNlZqAvGymBcbA19HSLTaxHe4U3WrJVnNnPn5ealLyVdOA1op5JSoKSiiU/KLxFT3qqXiDajNEzxZRDEzXgYPvckl+J/daGZHdkVEbuqz2E4r6KZkIg0bm4DzKBOxluZlOMVPy3yirhtFy9hjENC8KuaCMwQZqQu7VKqn7Vt1Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0ry7duBSZ7g+VOeTHloXN8sw5b5pWboTnUO7k0SwhY=;
 b=fa7QVm9Hmh4K2efqdRDVfylg9u/MpRq+h8xvkuZTRvJZyE4zhQakP9KG7oFDeAIBG+sIjL9qxylmexviDWCRl/PL3MXFtYtmlS1z349f4EYmoXMBGqoJt1nRpNZXhtVPAmqKHvdXEEb2+l16YbfnjH9P7A5Cr0jgU16PfupVUkUiyaHozan3j5RgOls15H3s8uFgVLwXlewDZACuCGFk4ZchFY6AMnbreTx54NauLRQ9uyRyj7lQg4mX2hU5VLmFY7UefpmGY7AmvtZq505QgAUNwhAjGjeop33jt2qWU88i17hZMFl3w6xceDHD3QfYsKN9SSXhv5xqDfz4i48yrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0ry7duBSZ7g+VOeTHloXN8sw5b5pWboTnUO7k0SwhY=;
 b=X/D4RvCxofxirqBq8HifPMwZOYfJZNS1Zd8w04te7VR2AyFBJVtt9Xq+6GVKsbWR6IX5pOk7MD5iYfSam0R+pLTT8lTFXdMh1pl8CTuaxsHkgr5KoBudbSYCf1z+4VDngAgTU2WMfbUKuhSFlya/I7gL0wLPGsnjpABKR2U2Wo0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL0PR04MB4802.namprd04.prod.outlook.com (2603:10b6:208:47::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Fri, 24 Jun
 2022 06:41:09 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4c0:544:ac07:fe6d]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4c0:544:ac07:fe6d%7]) with mapi id 15.20.5353.023; Fri, 24 Jun 2022
 06:41:09 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/2] Profile mask and calculation cleanups
Thread-Topic: [PATCH 0/2] Profile mask and calculation cleanups
Thread-Index: AQHYhxIq/4gWx1W3bUGsCOI8/J9DWg==
Date:   Fri, 24 Jun 2022 06:41:09 +0000
Message-ID: <PH0PR04MB74162FBDDD7B5C8D137C188F9BB49@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1655996117.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09052074-9728-40b0-8879-08da55ac85a5
x-ms-traffictypediagnostic: BL0PR04MB4802:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lTzG2ZGJPVkcQiB1yQaURLiD3d+cnNI39MW6danYqXMnFLrVByDzuRO6M7b2HbUpYmLRedXVSqba6b7OQTAoR+JzW+sbtClkQQ+dzgpFLZFB0r96C0Lgo/fdkWg+8StER4nnnBufS+BV+swpBJgrW/ldKaaCqfF+GUd6iuVkCjjcK3taj8aK9TuO5gS4oUR2XNAx0TklwYyu6MczMqYwwCOgi3EM8Wd5ek8QM6JO7bPiwj8T4J/nNvjKF6rLzZIezqB3bZQqEpaxhtVuLYYbdGdQARXcM5qkKakqQdo2pyVnjr/tdJ1c/b1BfiWZu+tAOItaadUNFlRYwsi/5bmT68yDtM51TVmPrt4BZymxAoJ2/HhTq7DmXc+YSDR421JlJ+mLveH0XfI76R0r+/cHyMIW8b1FkQKH6hK898VCP8F1iAmmGcueNtXz0EX4dIAkVgPy5UABXEG4JYLMsOQkUKCBhhMDgC+4oLqPPhBmvXBvivK7SeEevud1LT9NN1vS61riaB9N/Oj83ap3GA/RKtmLoiENEm22YPhTDgl4b7uxFJ9Rhz13tnYEWmOoDbOpuGLU4kX3RySTEhjmqdNa3Cqce6eiquHHr9RfcJhSlgJa8bPnQjrUQXuvtLdP2fDx8jkmkc01cyzpcqYPVgPMB0Y2XqvdVXTQ/lI6iKqFOYdeWFnAu6d4XEcIBXWjoaWUSfU5ldPDMtR0WVrZrByKfGIB15ZSTzlq8zoTfKcxiLocRYwDkSlY48kXKmoJzujRMOT4EKxDsqXyiqTQhL1slhSEMUlweVsIN564EFjMeG4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(136003)(346002)(366004)(396003)(53546011)(4744005)(71200400001)(5660300002)(2906002)(6506007)(8936002)(7696005)(55016003)(52536014)(38100700002)(33656002)(76116006)(86362001)(478600001)(83380400001)(66556008)(38070700005)(9686003)(41300700001)(91956017)(110136005)(66446008)(82960400001)(186003)(8676002)(64756008)(316002)(66946007)(122000001)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GgLRVuPlltCfl5/fM21/EcaZKZeV5/QNh5lS8FgRvixoPPSwXJ0zBj6MY7AC?=
 =?us-ascii?Q?U/1Ub7lHieoi2iwikkx8YF4hS3ABIkEGWbS1hPu/N6n3tpCnHvflcbm8NhcG?=
 =?us-ascii?Q?HnpygUdBskQYsqp+hP7pYwmFTuoUc5eW6tl70s9NgfK452w8Ook2Qi8yl1Lh?=
 =?us-ascii?Q?mC62ckB0ssTgXBgFTvKziiEcp+2LDu1LtXbGzkY7Mqc6q/dqWn7eOpXvgqEc?=
 =?us-ascii?Q?yMWaYxQGrzL3e2/k5TbGI8kEQxGpU5ABEKSbIejWeiuX0GRuyIFGfWyOUTOh?=
 =?us-ascii?Q?PMlv42b5WVMEn74Aik4mHry8xzaWAWfkRG7LX7z71RbMghCPex4K46ZFzePP?=
 =?us-ascii?Q?+QzeaW2gL1qZ7TFfWZKp32yvX25eE/k6IwklCGWlaE4WG3uOGziJiQ41MDHx?=
 =?us-ascii?Q?n1KG5/FnGW5VWXFLT1lgGFWgVRDH04rNEV51dcgDIjf18lTl5xwPJPpcjtoX?=
 =?us-ascii?Q?1lWDOAZVawxWy9m1t2OtQiwZI+YXvBZdqMZEb/Uvi6OAnZKnEvJ7GIoGdPNi?=
 =?us-ascii?Q?zkS1X0x/cVpiO1KNtwIGtHhlVgZ6kJyyM3E5/BZZ6w423/4/Z2G2AR+m9X0E?=
 =?us-ascii?Q?d1rJRE0ohe0AtPRVeOGSiuG1UpjnC6OEmFgw9GKMMXuwSd00BRnzvEsD6x7n?=
 =?us-ascii?Q?59Vh6nesaHKYj6Qjf/qEuLGasqnZ7qDxR0Bj50YQUF/4EKyMmsOya6dLlBF9?=
 =?us-ascii?Q?6zzJbH7yrGsHnrnp/95YKFNxTkRB6TkkXxLHHd2mnogFFe2b22W4pBHG8Br2?=
 =?us-ascii?Q?+KLwr2V5BO4HJky/GdIoaY26mrQgq5ni8UEdNRRUgFYerhXOVnjr6igT4mcm?=
 =?us-ascii?Q?OdJGZmZA+STQlx9PX/GzRXQE5oB2k2Smj8NH1zNbvUrSO2WqQ1ABPoZsllrt?=
 =?us-ascii?Q?fCYjrZ74cQiAYUp8Pkjqlpnj+D9vl1LRLTx5HCaQa25kFUvM/1cmJXH650J2?=
 =?us-ascii?Q?fpd3kim2pG18siGNCYOUWczngJK2Zcl3wiHsLLWt+D6ZFC7WikFOzSPezCCe?=
 =?us-ascii?Q?4GrmB5VGmB5a78HqNtVV4ZMG6M7Xv5ePaz+kHVdTkfw2w71xot0JtMqlz+E6?=
 =?us-ascii?Q?8wVF8em6SalRf47wW3NchCo59b4EcxbLArR6TDmyWggGRX4yrgplYcsAikBO?=
 =?us-ascii?Q?jZ6AGJR1yhoD/iv2IKLJ/bk8S/O1fmJGQ9RQ7QO5UF8b71QUjsSVZpvJjpzs?=
 =?us-ascii?Q?kiXd6cRG9CWCSoKiebsSbQuWQG0yq8FPPCHS79EU4TGV0HIb5+Hfy+XtCwHI?=
 =?us-ascii?Q?IlF0wy6JybfDHDRLWhkVDIt/E1Kx0IM2FEJIVOUq46EB0CF42l6QqG6F3frS?=
 =?us-ascii?Q?NOJ7qT2PjP+YvcdhUT2ktl3DzFhtWNjdyBI/kJDQh+j9CeDUglj8iPS5Ci+t?=
 =?us-ascii?Q?WUzFgPKC5uzKrWtxUWuKz84X7l6bUoHndrczwNBZ09zy8E8guX0ObZb/g6IN?=
 =?us-ascii?Q?iKibCHjkzP8st1c6mQVQCMT8txXWMF3yrtukSZxIg3bv7MW1LaKr7POhYfAv?=
 =?us-ascii?Q?VYk0rrWJCDnjHmPbk1UOPGjssvHLd5RSD5mId33KmcVlxUVFyEaybFw+DlUk?=
 =?us-ascii?Q?Yn0h8nV3txz7iUbNURKW0YE7deVOSsNEyCbzOe8+TZYhg3XxquH88wN7VAC8?=
 =?us-ascii?Q?iYkRR//Q8gx0Hvj9xUlJEjwaAQv5b18BH6M8yIhqxu2AjBqRIytISx9yryBr?=
 =?us-ascii?Q?gr//wRIEmn5wMpP12t3TVPwJqRc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09052074-9728-40b0-8879-08da55ac85a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2022 06:41:09.1143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KDQiP9UWKyDBKxFCFDOOwgpXCqYtFZu0p+OgZ0g8QHKgZc2kR90//+GBt8eDD03fw2s6NzfWGZgKkr4rXntThV35sVwkediTEo7R4A5S2tU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4802
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 23.06.22 17:01, David Sterba wrote:=0A=
> There are still some instances of hardcoded values repeating what we=0A=
> have in the raid attr table or using a similar expresion to calculate=0A=
> things that can be simplified.=0A=
> =0A=
> David Sterba (2):=0A=
>   btrfs: use mask for all RAID1* profiles in btrfs_calc_avail_data_space=
=0A=
>   btrfs: merge calculations for simple striped profiles in=0A=
>     btrfs_rmap_block=0A=
> =0A=
>  fs/btrfs/block-group.c | 5 ++---=0A=
>  fs/btrfs/super.c       | 8 ++------=0A=
>  2 files changed, 4 insertions(+), 9 deletions(-)=0A=
> =0A=
Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
