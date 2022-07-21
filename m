Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B1D57D5D5
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jul 2022 23:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbiGUVUt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Jul 2022 17:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233304AbiGUVUp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Jul 2022 17:20:45 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-ve1eur03hn2225.outbound.protection.outlook.com [52.100.16.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2261AF1C
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Jul 2022 14:20:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P6qp3qfBh+nxSLtZ3oUeqBkrZlPU4a0VbhI3mRpIaxnO4jERF5FAPANEb4kSrb3C1MhZQwkuzCx7zBFHGU76QFCcVoGKP7ghNHPxvzbHig1tk70ksABvOiiK1AzU13r/Oo+UOUvhNYgGQKfNNuWTdevAAweeT8jEGuLp8DFlBpJF++Hka63Ko35Pw7LwegUIUd7g/9fdO9CLlpdSr/YEeVv8fSYSNkRwXqZuUBSlm4Z3La3C8rbMsVJ5TKrVKV/b2Ta/EilE+DbAvZr//o7+YDc0s8dVEyAo+RstvPWA+uzZrGbm+xiCPddvFLSUdKMzcy5nVXOkLZIswP7xUBb2/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPRvuS1lylBXPFPS7bRSqdxncLyN3FrXzLFg1hRG9Ys=;
 b=KV3t52XmZftEq3oukbyMzwZ2mzDibhsDe0AO266eFoKl7kjVxC9kHaENLO0v8EPL4/yOIIRLWtrtkFnlJJ5Zece3tVDqZW14oZJxbNShXFW6I1YV2tQ3hzSAG46RDc0AoxkB8VkXIT/wAOndTLruq5xDKJElyDxCyqsDCTh8PGkZl8gl7cv+Cq1DJsby2a9y2rCu6kDqyQ5Wcw3fMoFWYIyHcm+XIYycMpR1ToeShPy90FhoomteHBBGh7BMDRJT9OKkGw0HgL2LtfG6XvtSI+BKC5Z7iB9+HlfenEHObs1BITMhlA+Xq9Rwaow8fBgHx+3fH5i6ck8PYU8KA+Vq/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 193.183.126.23) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=hkma-online.com; dmarc=none action=none
 header.from=hkma-online.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Husqvarnagroup.onmicrosoft.com; s=selector1-Husqvarnagroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPRvuS1lylBXPFPS7bRSqdxncLyN3FrXzLFg1hRG9Ys=;
 b=jZ7ihGNBEwBUvLYlSmyE7qFFsgNMZ3PNNrO8GS5/GR+qioagDVIvo/KNhwCB9GIpzCEzaBYIcNPKztt5pXZX5YumFAj92DtKg4UNwjq/G25ZDtPtjIXB3f62qcx25JWJvf7lTnuNjQL95bG/i0liQUhOB4NTujkL10kyVLjWIwg=
Received: from OS6P279CA0008.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:30::9) by
 AM8PR04MB7858.eurprd04.prod.outlook.com (2603:10a6:20b:237::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 21 Jul
 2022 21:20:42 +0000
Received: from HE1EUR02FT070.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:e10:30:cafe::fc) by OS6P279CA0008.outlook.office365.com
 (2603:10a6:e10:30::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19 via Frontend
 Transport; Thu, 21 Jul 2022 21:20:42 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 193.183.126.23)
 smtp.mailfrom=hkma-online.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hkma-online.com;
Received-SPF: None (protection.outlook.com: hkma-online.com does not designate
 permitted sender hosts)
Received: from smtp.husqvarnagroup.com (193.183.126.23) by
 HE1EUR02FT070.mail.protection.outlook.com (10.152.11.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5458.17 via Frontend Transport; Thu, 21 Jul 2022 21:20:42 +0000
Received: from AS400TGT.CP.ELECTROLUX-NA.COM ([10.80.249.221]) by smtp.husqvarnagroup.com with Microsoft SMTPSVC(8.5.9600.16384);
         Thu, 21 Jul 2022 23:20:28 +0200
Received: from [107.161.81.132](107.161.81.132.static.quadranet.com[107.161.81.132])
        by AS400TGT.CP.ELECTROLUX-NA.COM (IBM i SMTP 7.3.0) with TCP;
        Thu, 21 Jul 2022 16:20:33 -0500
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Re: Hello ....
To:     Recipients <eddieyue@hkma-online.com>
From:   "Mr. Eddie Yue" <eddieyue@hkma-online.com>
Date:   Fri, 22 Jul 2022 05:20:10 +0800
Reply-To: eddy@edyue.website
Message-ID: <SW022022h84U135TcfM0003ffcc@smtp.husqvarnagroup.com>
X-OriginalArrivalTime: 21 Jul 2022 21:20:28.0491 (UTC) FILETIME=[B35D61B0:01D89D47]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1e93174-fac9-4dc2-3f7a-08da6b5ede12
X-MS-TrafficTypeDiagnostic: AM8PR04MB7858:EE_
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?Jy/uxJTAXI4C89D4xtrVGQ3XPykG+vrC2tFPPsC5+Cb7y7VBvQoeM4900E?=
 =?iso-8859-1?Q?QJds66s5woe5AFxCCwB2qJ+f8R4c9vE9fFni1ZY3gCKDYopIdkWPmRJsFa?=
 =?iso-8859-1?Q?vCqZwZryDSW9qwVANNem2O9hOpAax+buVzlx44Sk/ia7w2LHYfKsGia3Fd?=
 =?iso-8859-1?Q?GTWVwuSepKadK9kcFAEQmjO5VJOM+LyjIisQRmnUHLAC4WAJiBQ2tgo6EL?=
 =?iso-8859-1?Q?0FzgPQCJiY8LLLObcSxS+hHcHD1Z1wNhSL39Mr2QtanUcxpDfrRf+UrH0W?=
 =?iso-8859-1?Q?MWMEmpJXt26BrFmrYEYDKpZ9gP+B9rv0rbWQjeWdvYA9Wfla6Robu+ZqO6?=
 =?iso-8859-1?Q?b3m/uXojZd3kYqNd9/zQD7lm6+5aXSFj8KG/wlCjYEdBalrQg9QoJQg1Fb?=
 =?iso-8859-1?Q?v/QDxV9ZUH3hb2SgzFP//9s9MPMgRPiM+4dbHsZdv7Q01G3Ea7pTEW5RrX?=
 =?iso-8859-1?Q?8G2leEflnBtrIjKu4TcBrdRAO4NiW2+MD1a1my1SNt+Ujtfsk/15siXhuR?=
 =?iso-8859-1?Q?ngGdy6VRDfRrEjRHacMOGit28ljTpsQnvYnnxi3UFELvIi0haoRtPxjvan?=
 =?iso-8859-1?Q?l/vxNq2Fd+7xDNXkMVbUGWsgtZABOENh7WuVCKdidiG1+86uI0+/GmjHZu?=
 =?iso-8859-1?Q?qtuJm5kL5eX8bsmuvBtFG4njui4X5+c3ZYEEri78PB/jdNJ6UUTNnaxHNv?=
 =?iso-8859-1?Q?II7v/PMSSx1bWU5oZt4+rhV2St7pUcZnzmhBLz7yGyIFWGwR9CutTw0tie?=
 =?iso-8859-1?Q?Cry7QqPC4mmVkQlOFGFOEBqJURuotpcLEIpgsDrLjNSoK6g4MOrydyuEao?=
 =?iso-8859-1?Q?qxkWuEoEQ0Ok48OIuSwinES9RMB0seReAHXS2KfPXxNm3BBoabLLQhBu1F?=
 =?iso-8859-1?Q?VQNcN01eKJ3MwHcNqkg8XxGygqvsK3miC1/O2p6jfqsWlNpRKUdaDJJm3+?=
 =?iso-8859-1?Q?H27sefnKyFtwG4a4gIpddb/ijRMzwOPVwRVmTWk+lzLwaw0Ly8BSJdW+Gd?=
 =?iso-8859-1?Q?MZGtxjrK2f1Kzt4mXU/jhCWjkLY5vt/Yi2Sep41RYPuK+mP04S9JluLivu?=
 =?iso-8859-1?Q?Pz+sNk7AVhSfCK5nL28Roez3wM98UFRCothlLcyfRWQSwH0MZWmGSvkN7T?=
 =?iso-8859-1?Q?yHsFb346pdOlQH7bBevJ28lQG8d8KqFoHNchdfyPQSp7rwvtOwCgzg/5nj?=
 =?iso-8859-1?Q?aLWnuEiq6F6m0g=3D=3D?=
X-Forefront-Antispam-Report: CIP:193.183.126.23;CTRY:SE;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:smtp.husqvarnagroup.com;PTR:InfoDomainNonexistent;CAT:OSPM;SFS:(13230016)(4636009)(376002)(39860400002)(396003)(136003)(346002)(46966006)(40470700004)(316002)(83380400001)(956004)(7116003)(40480700001)(6666004)(41300700001)(3480700007)(2906002)(47076005)(336012)(35950700001)(8936002)(82740400003)(6200100001)(82310400005)(81166007)(26005)(356005)(9686003)(70586007)(5660300002)(498600001)(70206006)(8676002)(6862004)(4744005)(86362001)(40460700003)(62346012);DIR:OUT;SFP:1501;
X-OriginatorOrg: Husqvarnagroup.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 21:20:42.2401
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e93174-fac9-4dc2-3f7a-08da6b5ede12
X-MS-Exchange-CrossTenant-Id: 2a1c169e-715a-412b-b526-05da3f8412fa
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=2a1c169e-715a-412b-b526-05da3f8412fa;Ip=[193.183.126.23];Helo=[smtp.husqvarnagroup.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT070.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7858
X-Spam-Status: No, score=3.1 required=5.0 tests=BAYES_40,DKIM_ADSP_NXDOMAIN,
        DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_NAME_MR_MRS,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,



I have an Obligation I will like you to complete for me, I am ready to give=
 you a commission for your time. Reply for details.


Mr. Eddie Yue


The information in this email may be confidential and/or legally privileged=
. It has been sent for the sole use of the intended recipient(s). If you ar=
e not an intended recipient, you are strictly prohibited from reading, disc=
losing, distributing, copying or using this email or any of its contents, i=
n any way whatsoever. If you have received this email in error, please cont=
act the sender by reply email and destroy all copies of the original messag=
e. Please also be advised that emails are not a secure form for communicati=
on, and may contain errors.
