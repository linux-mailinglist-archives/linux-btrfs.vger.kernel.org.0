Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80764E71B7
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Mar 2022 11:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352944AbiCYLAU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Mar 2022 07:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352917AbiCYLAS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Mar 2022 07:00:18 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2142E50B25
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Mar 2022 03:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648205922; x=1679741922;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=EXS7xNxQu9VR2wG5lhrytSbStbsyIRYr7DliSpV87ME=;
  b=oJnDwp4udpf+K2uK8OtszzMO7woV2M6po7/W8UK5XRfG+NknhoYDdywE
   tpBpPP2sTgnlgICYgoMhP81vqM5tdSrXPPohNl7JJH02uiwQYTVvZmONJ
   GpZbiLN2ldgLLx3YqJsw7TBOu8o0CVWucYwSuB1vgneE9frbuhHqQNL2w
   Qoepii8/LEqJP0NOahoWnk0O9JQUmNWHu2r6q7jkL4X77yIKolIbCK6zd
   qj3Jh7Wqcf7xYFHys99hfadBTsOcWLh2bjiuyFoDdWuiDFFjEkJ5BPG2C
   gD0MidGBCfrjOjosj34lIqLk851jZgzfvBvj8kij+igzzaktJGQ8Rlajo
   w==;
X-IronPort-AV: E=Sophos;i="5.90,209,1643644800"; 
   d="scan'208";a="201107636"
Received: from mail-mw2nam12lp2046.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.46])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2022 18:58:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nB26cIGhig570un17QhnufIx6AQQAPEV7YIZHPRreKuuX7L3Eo1Btraq/t3/Mua+4awfpvDDa66+0eorWNUki1W3SFeSBBo/F1YYdYUmUUoZOGUdwD6Ue5/b8eteIDbuR14+KvyfDPAjpu8Su8aGSk4iB57JF3JgyM/sI2kUWfgpQcJGFwb8hmnjqkVp7HUsCvMFbTlmu73RdPu/4wbF134syCgX/PIu6A/V2SbC7X0FMNYBT73ecJxgRdHwXzH8NYRGxSutdSAeMNC4FY7A4oFaduxg00ZgMBxJykQes7hQxQ3AFZIpq8PFbmQEN6ZLnB7HEEMQplYzQkofuJDemA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXS7xNxQu9VR2wG5lhrytSbStbsyIRYr7DliSpV87ME=;
 b=fvuGHa0EhrhbDwLqR8OegIjEAAgeEmYKTPoQ3fysilc0/cEw4KM/265A1nh9oa8QZWc3m3iJKlw4HimpWsoaYhwRUafSqoKOgLT0eXIAlvZ1n2aOgtuG0fIK1gkCnPUKcw37DRuuZNgq02ru7Np5ofSXVyQ/OB92G1z+TIyyoD1NS7kal2tAycq4UDP9Ydz6HY4y2J8tNlzlKGdxefO4w/kTihGOH8TlB9lyxaxdzaLVfYf64VGAZWQXz4bVCVeUJ+fChu7aeXTLBzO+6XtSkNFOignJQ2E1XUpMClgBPwyl2bPQ6+lIpGf+W6TSf79F61dWZUCgBLogpSm2qsz3ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXS7xNxQu9VR2wG5lhrytSbStbsyIRYr7DliSpV87ME=;
 b=VorA+GYEBTUuv6lhN99l1Bd/p1JBbz1DGRqzC0bZIDTK0uNZ/ZN2SoHEmqKF90MBDvhrrO6TTla5yx/UWiQ1ySQ1eG4mQXrgCk7t3XiLuSJCTig8/74y/5VjsRYuWhTslF+38uxQzRnF9gqlmiXXnr1j3shiAWghXrPiowO7GvM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CY4PR04MB0999.namprd04.prod.outlook.com (2603:10b6:910:56::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.19; Fri, 25 Mar
 2022 10:58:40 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a898:5c75:3097:52c2]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a898:5c75:3097:52c2%3]) with mapi id 15.20.5102.019; Fri, 25 Mar 2022
 10:58:40 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: replace a wrong memset() with memzero_page()
Thread-Topic: [PATCH] btrfs: replace a wrong memset() with memzero_page()
Thread-Index: AQHYQCwVua9dYMym+kuSOsI5USV3Zw==
Date:   Fri, 25 Mar 2022 10:58:40 +0000
Message-ID: <PH0PR04MB74168F61ABDD11E1B566510B9B1A9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <8d6f911a0282eba76f9e05d6f1e7c6f091d4870b.1648199349.git.wqu@suse.com>
 <PH0PR04MB7416A2B700E658F640B7FEF39B1A9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <3cf47cbf-ae0d-2942-d427-7b6cb9602d27@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58036054-6e29-4f57-622d-08da0e4e6ba3
x-ms-traffictypediagnostic: CY4PR04MB0999:EE_
x-microsoft-antispam-prvs: <CY4PR04MB0999FFC45924A3839257BA349B1A9@CY4PR04MB0999.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1GJdncDYbCWAsxPehcGDoeCkdRQH1zWsmGHykcTUeTy40vxwUrHhaM/DQlaPrFv2jOpU5qFGThrpzwO5hC+5bUh7K7ai6OtkMiJRrZZ/8ONEptANkJxMrePGwmfLHMyNYffiTto9Bf+O78pYcIw5HEKcabJe28bACY1kedJR/2wO2N5gJN1MLIkOWFGdjBOkmFbH3AUumDwmG07mIqakaqHw/A42Iv8zf2iKWBlwjGMdSZEdGPkdGgF1fYWxmbVY/+kbz5zbHB7urDIBvhqYlmU56KqXdv9u6l3LgIiqihOysjCkFG8BogSdWGN66H5KJDVDfH0QgfD9EN7imnnlTNzv2AXwdjwXloQ5Yto6vxRROSQAgfjcI+UmeadB63gY3xPWbR//6tWHTuB9Y06bMwEdO+tzOBA4R7Dt6KDBN5Koex0a6YNOYMr2cnUmBOwPN3dlHu6RjGra7oT72BuzIuIuryU8syEQqPsBVTgVe8kWucEiUOOFZeH6D/3InzXXwYn3Neod0WI53dysZWeYWaEvt/16NeQgO5gkw26d0QJ4fx3hZw0KQ+Dt8hTjuAXPH/HBlkJtXBWlT4VGWpWFdlcftpnvuvQHHTK0icbDhbUDgV3pvd3GamQI+RKpU/bFVru+LJH8gCDF7fWIVlvdniI4H6tRcLQp66gQnvHMVY186xk1ZdDNJizDksLnLvBy35Vm2b8vRxjvEG63zVerNQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(66946007)(76116006)(91956017)(71200400001)(4744005)(508600001)(2906002)(38100700002)(38070700005)(186003)(64756008)(66446008)(66476007)(82960400001)(55016003)(122000001)(9686003)(33656002)(52536014)(8936002)(110136005)(66556008)(316002)(53546011)(6506007)(7696005)(5660300002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JjYYKTYPn1PtwwRQbmYUGs5tnt8L1nBgAONZuXX7wAcEHS/6GGFotnp73qQP?=
 =?us-ascii?Q?jdfqDZfHaYZkViSSlzo5bYfOy+2Rk61Kwl5Bi98T/t6kNdCpwwfGZx/qn1Qs?=
 =?us-ascii?Q?1oqc3lmZsJ0WnPBGanN6a4kbhyTPc/9kNWgKgl9vp2FOm1tcRrsZ5yvPCW/U?=
 =?us-ascii?Q?IP2VNZj9ZtM6lKF2tRsTZsdoJi8g3H1cYhjHaO6PPzGvyydWhuIuXAV/TwEb?=
 =?us-ascii?Q?JabTNkoq81rItqKxEzAVrdZeY/nH11d9LnBHNZ79IxLLGcclIuBBEQjJxVln?=
 =?us-ascii?Q?cxcNDHBhtK/a1oWsROyhhdlDBG+7poe2ecoZKoX/wWiZ66M5RVxTrIPHWYuI?=
 =?us-ascii?Q?uJ5t8anFOQf2a3n9ErShNA4THfjJ9wNI0ODkc1/xVRxqnBCbwoagClHv8Njc?=
 =?us-ascii?Q?vmVy5g0PqmpR4KXdbuxUBzsWJw/TirH7yz8VNKKwVAbY8muFSSWqXzD9L8m5?=
 =?us-ascii?Q?bHQOYMK0qywueRde75I303a2OWuQQCoyUrKQmEYdV4MVURY3jeWL03FQkI4V?=
 =?us-ascii?Q?VKT2MrYCbPiKEIkOkvJS9Iumf5I6DRM921qRxe5hfGfioHPBIKhwi63JpSjH?=
 =?us-ascii?Q?gB2F/3DcDD9xuwURPyCGw+tVaDmPrc+WLoLz3f3f/Hyxnt/hpM+WvZkLPdt9?=
 =?us-ascii?Q?O6coXQV84VdMC+zTStl59nGMPRjAd1oWsEFefmbptgfSYyZnk35hrkGQHtVm?=
 =?us-ascii?Q?w1AsHjKNsWcRqVoEIr0wpgmpRdvfoXkEWbqYfjZtb6QF+9j82/cDUtvk5Wgp?=
 =?us-ascii?Q?wSD6rLE/biT+FRXxA673risQBJ8iYVTEHZj6NIJvWT/yWq3qT436ZSTVABg4?=
 =?us-ascii?Q?F73LduTVOlT90WoanuawJe6UbqPFTP+8lYou2Tsg917mfLlT9fBedb5FiLD1?=
 =?us-ascii?Q?kR7vZ/iehVrufxRY1qrudRyZLka4Jd+3nB/lGu1a120UGfr2jbWoCcoApNGp?=
 =?us-ascii?Q?dtPnLQyieyJDDM7Yy/DkiIVkjW64ilWWyQHXWGLs/RBhgZ4nKMK8EguaiaN+?=
 =?us-ascii?Q?fOuCwmaw1nyYcTRlgqrV8OHawCya9WGU96GrtXXm0NS4mwYN2Aq8hx7/pIE5?=
 =?us-ascii?Q?H/3+FdaqQySaCin82LHF2q/It+jNRhbnwJYFksmbDsvyliafvydprN6GZ6jE?=
 =?us-ascii?Q?q2PnXEZt7UfasTyKlQ/nr8vbE9U+rGqTE3VeiqZuRyb8e5+UsG9MA3BDfX2r?=
 =?us-ascii?Q?Qs7dF/bCorjkZsgWYoTbS/0zWVQODavumcYqVK2E7vUAr+ZFyRfclcuijIfr?=
 =?us-ascii?Q?R1uYx1nmAEwa0JYWGqblRjtQK4ZzrWgZD4P4x3/FbzYyU7c+2yYRJ/iF5aTR?=
 =?us-ascii?Q?KeWMrUZKBqVY6+Oo/6ZuBSN5S8CeWsS3I5XTY6WL0Qhpcbfg+UoiPxoRoCwq?=
 =?us-ascii?Q?EYesxgMNJmXWASWQUoe3Myz1lBYp+ppk7p/B/y5MHBAS+kxn4VFa0Px6vGIc?=
 =?us-ascii?Q?C0ZR7abbYjlSXWGjLQSegp5f9QHTuWiTFiEkPoK+BBCICnksTydp6Uq8FMaA?=
 =?us-ascii?Q?/POgbOk7FTHjWKBvFCSuOG57zW7VgacDqzElqTRPOdKT5O1LxQom/AUCCpi8?=
 =?us-ascii?Q?cRVQubnECenLGnndanQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58036054-6e29-4f57-622d-08da0e4e6ba3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2022 10:58:40.1048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HUmBJ4zfvk/ebKfotLueTw9si46mnuqS5hve/xgbZMM7aiuBEWu0Lz5pNwNu4Pb9dGwycVljCm74GGXUHNagOSSbBKyPPa9fWQ3K9bGp3X8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0999
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 25/03/2022 11:49, Qu Wenruo wrote:=0A=
> =0A=
> =0A=
> On 2022/3/25 18:10, Johannes Thumshirn wrote:=0A=
>> On 25/03/2022 10:38, Qu Wenruo wrote:=0A=
>>> The original code is not really setting the memory to 0x00 but 0x01.=0A=
>>>=0A=
>>> To prevent such problem from happening, use memzero_page() instead.=0A=
>>>=0A=
>>> Since we're here, also make @len const since it's just sectorsize.=0A=
>>=0A=
>> Any idea why we're setting it to 1? It's been this way since 07157aacb1e=
c=0A=
>> ("Btrfs: Add file data csums back in via hooks in the extent map code")=
=0A=
>> which landed in v2.6.29. So basically since the dawn of time.=0A=
> =0A=
> No idea at all, maybe just a typo.=0A=
=0A=
Anyways,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
