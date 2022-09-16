Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFF65BA3D2
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Sep 2022 03:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiIPBRi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 21:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiIPBRe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 21:17:34 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01hn2218.outbound.protection.outlook.com [52.100.223.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15DC77568;
        Thu, 15 Sep 2022 18:17:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHySZeo98zLAwkITHSwPOge6SSbyoF/vFDx/cKEARd4nmrRUOmaSPM8pIHbqzmlDLRbjibhyaLAYmI7AkkwSG9iSkOigyn359W/cTnhm0/9h/B0gs2j8NrCLx2MVjuczky6wLrhlG8TkCM/8yOtLUYHq7+z6y/DtXlTyvnlEs/+vaVAHgby880SqEFaDOIIzZ0wqTQBrThySnaxf2F6HFuVoX5phritkOGDLpoc/8aOBL1LI1KR/KB8uKpmNteHoxJducIlkwyVRrLywJS7od5WTS5aFVtVB7X3pc8oIuPIhFDvrKbpVfK8HJJ7MuzXB0STb0ls/LxW3/LFCRMw6kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bs10Md+15nMnyayKLyd22Uv+/ZH79IcFcpzuzGLq1Fg=;
 b=bpmMSIp5G22sxE9TFGf3Y9jM7FoQkhc9QTz2BGdoOa0zPFDGnkdNtAJGBmASV8pc0AagJ6eZsaQyRoP4b7EadpllopNOaT53oonw+ijWMVcHAuSI19VWaJhd1rckafas8cyVlYAe2urgvi6uhoQsrFtAk4oseH0qrzZLvTbiMGFVVGRPkZ0a5z5RUvFavxzXZSA2JZLWvJbVP9LeXZtrxdqtuwl9yY1XiGLkOvQWgYaBCU5mZgoUvN7KX1XdwzfomUmPDz9/9vyjSzG4WavshywAyTog8hGvexdzcNDz5lO1Rvazivo4rXQVCjfLzIEf3QnmQ6S49RK9YA63JXx86A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 45.14.71.5) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=t4.cims.jp;
 dmarc=bestguesspass action=none header.from=t4.cims.jp; dkim=none (message
 not signed); arc=none (0)
Received: from TYCPR01CA0122.jpnprd01.prod.outlook.com (2603:1096:400:26d::11)
 by SI2PR04MB4137.apcprd04.prod.outlook.com (2603:1096:4:f8::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.16; Fri, 16 Sep 2022 01:17:32 +0000
Received: from TYZAPC01FT053.eop-APC01.prod.protection.outlook.com
 (2603:1096:400:26d:cafe::65) by TYCPR01CA0122.outlook.office365.com
 (2603:1096:400:26d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19 via Frontend
 Transport; Fri, 16 Sep 2022 01:17:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 45.14.71.5)
 smtp.mailfrom=t4.cims.jp; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=t4.cims.jp;
Received-SPF: Pass (protection.outlook.com: domain of t4.cims.jp designates
 45.14.71.5 as permitted sender) receiver=protection.outlook.com;
 client-ip=45.14.71.5; helo=User; pr=M
Received: from mail.prasarana.com.my (58.26.8.158) by
 TYZAPC01FT053.mail.protection.outlook.com (10.118.152.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Fri, 16 Sep 2022 01:17:31 +0000
Received: from MRL-EXH-02.prasarana.com.my (10.128.66.101) by
 MRL-EXH-01.prasarana.com.my (10.128.66.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 16 Sep 2022 09:16:51 +0800
Received: from User (45.14.71.5) by MRL-EXH-02.prasarana.com.my
 (10.128.66.101) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Fri, 16 Sep 2022 09:16:21 +0800
Reply-To: <rhashimi202222@kakao.com>
From:   Consultant Swift Capital Loans Ltd <info@t4.cims.jp>
Subject: I hope you are doing well, and business is great!
Date:   Fri, 16 Sep 2022 09:17:03 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="Windows-1251"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <0135ac95-8929-4d45-8a5f-93547c102f2e@MRL-EXH-02.prasarana.com.my>
To:     Undisclosed recipients:;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: ip=[45.14.71.5];domain=User
X-MS-Exchange-ExternalOriginalInternetSender: ip=[45.14.71.5];domain=User
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZAPC01FT053:EE_|SI2PR04MB4137:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ea11b2e-dba3-4db4-6365-08da97813ab5
X-MS-Exchange-AtpMessageProperties: SA|SL
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?windows-1251?Q?27C4NJfFKZgDG5cHZywkbuN9AlsZ/R+LT2SDpH3esd6rzewy/uF5Ikd2?=
 =?windows-1251?Q?QHN4fwZjm9vXHH6VXw67j1K6Ejx5yiIsp1K12ZkN4FjFIckxyZX3rLAM?=
 =?windows-1251?Q?EJ8d9siWYXQQQNC2JVEfxo163pwfnju6ybc0PAAgFLuzDAF7272+mcVB?=
 =?windows-1251?Q?paA/8YnGaZ0RHR3NdmRVKuAAncQJ4ibGuuTwzFP82pz4u0qcox3t6eg3?=
 =?windows-1251?Q?uU3qw0L9gcm+mVrcCyLkDhVyTdCw4EE/E4p015Vd0PmyE1tm5gcYq1XY?=
 =?windows-1251?Q?FI81i37wggWd8CryMy5w68/YZ3L/FBlS3vQHxyA6i9yJxiQVlY1mngjb?=
 =?windows-1251?Q?g2xRwI9MEnRG2ei5gOylrviz5ajsUs8X6iYTKEWDGf2c5avE242BIwwZ?=
 =?windows-1251?Q?cTDsd8uXdtyj19Kmc3YinX9bjY7aYGyBydlF1yxbZibj0mtUkxoMFrVl?=
 =?windows-1251?Q?NAdkzB7z/PLD7+u70tjgLQNVWU8+aZwpTSGgO1Pd+dsuNzKELTFZJaG8?=
 =?windows-1251?Q?kDHlCqfd1aRz+Ch/fgi2sVGIJPx0YNZE7wHH7emXnkXtAfyp0VFMiQlV?=
 =?windows-1251?Q?jn9RMokVhMHqWPt1v3EGxDm2szo9gI2S/NZn3ImT0Tw6ogSfRti7TTKR?=
 =?windows-1251?Q?RfbtOoOrjZ/Klo7ylF+OcqPNByQbjzusVZb5x3gYtWJ1JPbBZl35qYgw?=
 =?windows-1251?Q?YnSLzDag3iDgguj2uVS//uU+7R+jKoya2S4Ixlsu717lNB+P6qmEBfee?=
 =?windows-1251?Q?qugQYBsvC9JjdcJhw8lXIPUHuO3AhfSfSnEZcTz2w3G7hC6RQsi21kcY?=
 =?windows-1251?Q?aF7+vOQ5yWEiIlNULc2cGf1ozwrB+IwFA0qRYMWQ4g2Up95rWMm9ZWM8?=
 =?windows-1251?Q?1uXF1QS2EaFBD5/xLWYTjDjW7HZkwaytLDUqs8OmTStcQi6USnsdYy1E?=
 =?windows-1251?Q?RpSRZo6fZ1Cfd3nbYZWHgWWWGlhTNw0Gv9e2IceeZpTxx8ZFqvlPpCO8?=
 =?windows-1251?Q?9+XPTQ3GticBsqpY+ewFLNqRpdPfvdpc3ejOt++uQTR0AUAYHM/LXC+F?=
 =?windows-1251?Q?Cn7iYoZhAA2fskt23RA9Zpc3NjYwFfGe0cgfaha9Vm5m/yEeLUpFM1w3?=
 =?windows-1251?Q?nUrlMn5+tFhwxOH7URRD3oFSgZMumPzXSUc606LkMzWa93WIYXLVLIVp?=
 =?windows-1251?Q?2tIzt0ApJNxGoIV+QZiSP4YPCUzPAJ72WwQaEvuNn9DPqSJf7mLzPpI3?=
 =?windows-1251?Q?PFm8G6B78oAOPemwEoj0/vVH6F9HxM3hTNTYSS0/9Rl2Ayr7W4TBTVwk?=
 =?windows-1251?Q?xa4JChRApsohZw0FNkQa4v7eSHUVYXYCrIlj7G3/69Bh9f02?=
X-Forefront-Antispam-Report: CIP:58.26.8.158;CTRY:JP;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:User;PTR:45.14.71.5.static.xtom.com;CAT:OSPM;SFS:(13230022)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199015)(40470700004)(82310400005)(40480700001)(32650700002)(31686004)(86362001)(70586007)(70206006)(8936002)(5660300002)(336012)(956004)(498600001)(8676002)(7416002)(7366002)(31696002)(7406005)(81166007)(4744005)(156005)(316002)(35950700001)(32850700003)(41300700001)(36906005)(2906002)(40460700003)(6666004)(82740400003)(26005)(109986005)(9686003)(66899012)(2700400008);DIR:OUT;SFP:1501;
X-OriginatorOrg: myprasarana.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 01:17:31.6325
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ea11b2e-dba3-4db4-6365-08da97813ab5
X-MS-Exchange-CrossTenant-Id: 3cbb2ff2-27fb-4993-aecf-bf16995e64c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3cbb2ff2-27fb-4993-aecf-bf16995e64c0;Ip=[58.26.8.158];Helo=[mail.prasarana.com.my]
X-MS-Exchange-CrossTenant-AuthSource: TYZAPC01FT053.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB4137
X-Spam-Status: Yes, score=6.2 required=5.0 tests=AXB_XMAILER_MIMEOLE_OL_024C2,
        AXB_X_FF_SEZ_S,BAYES_50,FORGED_MUA_OUTLOOK,FSL_CTYPE_WIN1251,
        FSL_NEW_HELO_USER,HEADER_FROM_DIFFERENT_DOMAINS,NSL_RCVD_FROM_USER,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [52.100.223.218 listed in list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5181]
        *  0.0 NSL_RCVD_FROM_USER Received from User
        *  0.0 FSL_CTYPE_WIN1251 Content-Type only seen in 419 spam
        *  3.2 AXB_X_FF_SEZ_S Forefront sez this is spam
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.0 SPF_HELO_PASS SPF: HELO matches SPF record
        *  0.2 HEADER_FROM_DIFFERENT_DOMAINS From and EnvelopeFrom 2nd level
        *      mail domains are different
        *  0.0 AXB_XMAILER_MIMEOLE_OL_024C2 Yet another X header trait
        *  0.0 FSL_NEW_HELO_USER Spam's using Helo and User
        *  1.9 FORGED_MUA_OUTLOOK Forged mail pretending to be from MS Outlook
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I hope you are doing well, and business is great!
However, if you need working capital to further grow and expand your business, we may be a perfect fit for you. I am Ms. Kaori Ichikawa Swift Capital Loans Ltd Consultant, Our loans are NOT based on your personal credit, and NO collateral is required.

We are a Direct Lender who can approve your loan today, and fund as Early as Tomorrow.

Once your reply I will send you the official website to complete your application

Waiting for your reply.

Regards
Ms. Kaori Ichikawa
Consultant Swift Capital Loans Ltd
