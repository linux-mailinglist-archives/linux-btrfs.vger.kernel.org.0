Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DC9596BFC
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Aug 2022 11:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbiHQJYa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Aug 2022 05:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiHQJY3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Aug 2022 05:24:29 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01hn2216.outbound.protection.outlook.com [52.100.0.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29FA53D09;
        Wed, 17 Aug 2022 02:24:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ebHEnr19CcKiAzWf55Ji6HVat2e2Gw1HcRcHXOMSEVNRW1iqeIMJWf/xXfwJ+c/ZUgedX2JH+DnhyC3nfdXcYQ2EBsyC0dum2K5H5NKCj/2JLyPGovUsdYfyul0mBDUbTo4rcHANDuQYRpMc/ps/VcAwe7vetL50NWkfUnnCiMLTcvUx+WxMdcMTUNEuNwUKreKkzuofr56BCYzcAgW/A+QoCu8n2rcMo5tIlCQZtF88QmDNxb1/YVjWqMUwuM7AM5HXcpmxgvEjXFZsbBhHnd9oV01ee8EpH19PweSDHY0UNynt7rdo9a9iYNZwu4BYiONPcJ+oc3xX2kJNzX+3UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4msfIOxQ1crv5MRswH2o3Ys3WmG66EQY49NzE9fa/Sw=;
 b=ny6vfsb4Mqfaxo+RTg+M6qF4APNRrbKx7iPDZVcucZzRY4G1h+nFdy00y1aHExQHAApBbDE/9L+DhNs/lUVRLbmIvUNKTMBgGCa4gXuv6VLxqc4Pd3/jOgaVx70JDdFFBDSbFBOXNUFKuRfn2dtXVjiyK6uHhee30FX3XWXyP4Xa9gD+Q2TWtSxR6V7I3Mxd9eBzNAMuFkoS21mwg726mI3AY/UPJLqbJw/jDiWsWY6H+CL7W6zpvNtGr3O1Rb6vp8BXrJcHN2KjpbGjIifCSsi4/wJRdygZmJtA9iC/2NxyBsZ2fWPZrPDxbdztXoAUxSn+AEwGSF742HYAYL/pig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 34.130.58.223) smtp.rcpttodomain=gmail.com smtp.mailfrom=t4.cims.jp;
 dmarc=bestguesspass action=none header.from=t4.cims.jp; dkim=none (message
 not signed); arc=none (0)
Received: from TYBP286CA0021.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:ce::33)
 by PSBPR04MB4054.apcprd04.prod.outlook.com (2603:1096:301:5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Wed, 17 Aug
 2022 09:24:24 +0000
Received: from TYZAPC01FT062.eop-APC01.prod.protection.outlook.com
 (2603:1096:404:ce:cafe::fd) by TYBP286CA0021.outlook.office365.com
 (2603:1096:404:ce::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11 via Frontend
 Transport; Wed, 17 Aug 2022 09:24:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 34.130.58.223)
 smtp.mailfrom=t4.cims.jp; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=t4.cims.jp;
Received-SPF: Pass (protection.outlook.com: domain of t4.cims.jp designates
 34.130.58.223 as permitted sender) receiver=protection.outlook.com;
 client-ip=34.130.58.223; helo=User; pr=M
Received: from mail.prasarana.com.my (58.26.8.158) by
 TYZAPC01FT062.mail.protection.outlook.com (10.118.152.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.15 via Frontend Transport; Wed, 17 Aug 2022 09:24:24 +0000
Received: from MRL-EXH-02.prasarana.com.my (10.128.66.101) by
 MRL-EXH-01.prasarana.com.my (10.128.66.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 17 Aug 2022 17:23:58 +0800
Received: from User (34.130.58.223) by MRL-EXH-02.prasarana.com.my
 (10.128.66.101) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Wed, 17 Aug 2022 17:23:44 +0800
Reply-To: <hashimirrr22@kakao.com>
From:   Al-Hashimi <gallaxy@t4.cims.jp>
Subject: Re: Did You Receive My last Mail
Date:   Wed, 17 Aug 2022 09:23:58 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="Windows-1251"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <4f2efe3a-6464-45f8-be1c-1ed0913cd5b5@MRL-EXH-02.prasarana.com.my>
To:     Undisclosed recipients:;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: ip=[34.130.58.223];domain=User
X-MS-Exchange-ExternalOriginalInternetSender: ip=[34.130.58.223];domain=User
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0dbad20c-3093-4fc4-d286-08da80324692
X-MS-TrafficTypeDiagnostic: PSBPR04MB4054:EE_
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?windows-1251?Q?+HKyuApcLvg3ISuxS+rY/jgBMncNR9hWE6muAjRfq2HFd4q/f+Oj0kS6?=
 =?windows-1251?Q?3P6cChnuLCwVebepRcMeV+rG84Iv4bFeIDb+t1eYNUD1EWbDgZBVZf+m?=
 =?windows-1251?Q?LFKsJrM6huuyMc4wSNxGlPaM4xqkDtHcheXvcfw0zREHGlw5SC6m6olJ?=
 =?windows-1251?Q?Ia0/a7rMqg85ov2MYYW6ztPAaLvN9uPhwuKXUAqf4tarVyu7AFahdTgH?=
 =?windows-1251?Q?f2oQPuHl1M7JpUuvvdJDLS9Yof2qYLtK2V1CzCigDVfeC1JBfEw8Puaf?=
 =?windows-1251?Q?tob+GpHU/P7oU5J2aqeNWPwJjq+JI5tnj7zPXVRvJguagLDFL5bY1gno?=
 =?windows-1251?Q?YGbqfHVcag1+ahBEis6QdI3q307BoxPJX3nhyt4cgX4c2Vsf37RZne2D?=
 =?windows-1251?Q?Uw5C0SPK2NWBXSfnCA9XN+Y6nFq1bjWimq7sqg83HDE3Y9STW1V7R/Ab?=
 =?windows-1251?Q?ftx97fUABio3/32/HmVR9eyx/ulqYWE2jDZm0a/et64ONILMnwfqPrkE?=
 =?windows-1251?Q?JmDsLLjx3gsMFOASO6NVC+cBuFOs8i612GHtLkQmUcoI+dn4eTFZzAgD?=
 =?windows-1251?Q?z3V9Poh/PDPsFidq66rYw+X+cxYblFgxe/PzVRUgl0EOIZQw+9NTcoS4?=
 =?windows-1251?Q?seo1ORnh/S/qAf0efbE1IOKg2AF8tjxT9+cOdSWyMNdAIHFdt8HY91sO?=
 =?windows-1251?Q?AEUleTkURBHObbjK1A/ec0wOfdwRymBd6FFkZRWgc/Qe/EsjbIRO/tIo?=
 =?windows-1251?Q?b2w8dZ2ne583I/tsGNtZu9hHE65OHFpdIOZzNPxLys2SjW7gcOe7jghI?=
 =?windows-1251?Q?BHB687zNGuR6lXVmjrQu7pzTxn9nuTkBakx+SvXmKsW3HPcyQX+qjLG/?=
 =?windows-1251?Q?7ApXnF859PAhszVaQ9UAf/6/eMeJy1CsrfLcCVyonzhE3pl0EEHIUCn2?=
 =?windows-1251?Q?RHJyIz5CFlhUTukF1Rn3nI5P59aOkF0fibKb34R/xOa+sZwR+OfduJpd?=
 =?windows-1251?Q?KTVGcwGKYzUdM/qlwPJRCjHuBMlLuMXF/xaYinUpGHoO8hzZc9H3eheL?=
 =?windows-1251?Q?OAv6TdMJZ+maNbI67QTLP11DhRfJGQJf5R1ncu7r/y5xLAeqeHaG5X1b?=
 =?windows-1251?Q?08+zFNYMlHmTqVsGY052t14EGufDkSIqqFif965LlO9VRyGa1proVX0A?=
 =?windows-1251?Q?h4JWg8ezMVriamuNN3VuOjighA9xk1WEdXgNo7lGbbAgDOzGfUEXepEP?=
 =?windows-1251?Q?2xMa08KKHzfPTyTBADssz1Ub/+SuzmB4e/lTOSttCKmms83UpFHcKpje?=
 =?windows-1251?Q?vyUvJA2cb0iC/85yk+eed/8sSuzkNWXubt5EfECAWw0fUh9uUR2961CH?=
 =?windows-1251?Q?+XKnBy7wCHTb3aC0TbdXS+7a9HdQMuXtD1c=3D?=
X-Forefront-Antispam-Report: CIP:58.26.8.158;CTRY:CA;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:User;PTR:223.58.130.34.bc.googleusercontent.com;CAT:OSPM;SFS:(13230016)(396003)(346002)(39860400002)(376002)(136003)(40470700004)(46966006)(82310400005)(316002)(8676002)(32850700003)(70206006)(7416002)(7366002)(5660300002)(8936002)(40480700001)(70586007)(36906005)(156005)(40460700003)(38500700001)(82740400003)(2906002)(31686004)(86362001)(41300700001)(498600001)(81166007)(26005)(31696002)(9686003)(7406005)(956004)(47076005)(35950700001)(6666004)(83380400001)(109986005)(336012)(2700400008);DIR:OUT;SFP:1501;
X-OriginatorOrg: myprasarana.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 09:24:24.2876
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dbad20c-3093-4fc4-d286-08da80324692
X-MS-Exchange-CrossTenant-Id: 3cbb2ff2-27fb-4993-aecf-bf16995e64c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3cbb2ff2-27fb-4993-aecf-bf16995e64c0;Ip=[58.26.8.158];Helo=[mail.prasarana.com.my]
X-MS-Exchange-CrossTenant-AuthSource: TYZAPC01FT062.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSBPR04MB4054
X-Spam-Status: Yes, score=7.5 required=5.0 tests=AXB_XMAILER_MIMEOLE_OL_024C2,
        BAYES_60,FAKE_REPLY_C,FORGED_MUA_OUTLOOK,FSL_CTYPE_WIN1251,
        FSL_NEW_HELO_USER,HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,
        NSL_RCVD_FROM_USER,RCVD_IN_MSPIKE_H2,REPTO_419_FRAUD,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.7944]
        *  0.6 REPTO_419_FRAUD Reply-To is known advance fee fraud collector
        *      mailbox
        *  0.0 FSL_CTYPE_WIN1251 Content-Type only seen in 419 spam
        *  0.0 NSL_RCVD_FROM_USER Received from User
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 HEADER_FROM_DIFFERENT_DOMAINS From and EnvelopeFrom 2nd level
        *      mail domains are different
        * -0.0 SPF_HELO_PASS SPF: HELO matches SPF record
        * -0.0 RCVD_IN_MSPIKE_H2 RBL: Average reputation (+2)
        *      [52.100.0.216 listed in wl.mailspike.net]
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 AXB_XMAILER_MIMEOLE_OL_024C2 Yet another X header trait
        *  0.0 FSL_NEW_HELO_USER Spam's using Helo and User
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.5 FAKE_REPLY_C No description available.
        *  1.9 FORGED_MUA_OUTLOOK Forged mail pretending to be from MS Outlook
        *  1.8 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,
 
My name is Reem E. Al-Hashimi, the Emirates Minister of State and Managing Director of the United Arab Emirates (Dubai) World Expo 2020/2021 Committee. I am writing to you to stand as my partner to receive my share of gratification from foreign companies whom I helped during the bidding exercise towards the Dubai World Expo 2020/2021 Committee.
 
I"m serving as a Minister. I have a limit to my personal income and investment level, I cannot receive such a huge sum back to my country or my personal account. I reached with the foreign companies to direct the gratifications to an open beneficiary account with a financial institution where it will be possible for me to instruct further transfer of the fund to a third party account.
 
The amount is valued at $ 47,745,533.00 with a financial institution waiting my instruction for further transfer to a destination account as soon as I have your information indicating interest and I will compensate you with 30% of the total amount and you will also get benefit from the investment.
 
If you can handle the fund in a good investment.PLEASE REPLY ME ON THIS EMAIL: rrrhashimi2022@kakao.com
Regards,
Reem
