Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C31785A6A
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 16:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235832AbjHWOZw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 10:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235683AbjHWOZv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 10:25:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B92E57
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:25:46 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37NDuaTi022701;
        Wed, 23 Aug 2023 14:25:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=k3145ZYZnYAjpvf9wBm5c1Vz8pL63ev8E6b967Ck03kEZrbCSJ3ko/YJIibHSX1DUfyo
 v4e31wJfO5GAQgGkregCC73FgXRRyJUvPbtHHPVYXyJ/Tqyv/8BJrUJN/wsHviq9FQnW
 S1k+htYJMQv9pRpB0axrbY7pJ/uJJA1psqfSmFe1xhZEAvx+iORKtW/HZG5N15FOqs46
 GLy+zp6wapvbfHsQzH2+St16YXQijJxETILgHfUe1KohIYoS1Wv3Vwn33CHj18Ose5PV
 VKcxeIBVCoiAJmxHzxPqwsjuzeyADU1AjgXLe+J1qPeIZDT+4tA5jfHb+cNDBWh+/uUQ BA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1ytsxda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Aug 2023 14:25:36 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37ND40ZF000901;
        Wed, 23 Aug 2023 14:25:35 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1ys4wav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Aug 2023 14:25:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHzwSXTXv72/2clc5AlbZepZox6sYRvByufuICHcP9UpmvrDxCNAY0If0dnL0k97HsfnLDdzrpXg15tXIe+pbEzTGTaO9H2wRJv6GoXd4XSjtN8FQ4gECokc+jz77v0XWn+G27vKL25AtY1dH6rar6z3wIWq6em0+0sW6LHeNDSDMyZG55vQUcbCMhiEAtdJ3KgIVHq1TKiqhgH60id+REO+fwNUmigBqguGUVMO5UyMp84sm1p4Fg/Aa6dEuQ+pN8asH5jcEwy892qr3odc7WMbeki/WpICj/3zgEtxDs+w1BYoBMwpyq4tUNuLWvmeUOQbxfVXSDuHrqBS45Uwfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=YNUPonVKha4gj2Ka2i1uCc+CDOdaqBcTkdKaEKHe20XCbPR9GJ28qEP+iLghPOtHRD6LkM/+tJ45XhU+bh8UHN8D6mC+YyAP7vstntIdpWzilB30ZpHCBCOeOeEmAnm1Ako6C3C69y1+eQRYFdwx2yIxuAA7IkFmeJBu4IcSAeTIukWuCsdGKzOjGfSpppjtfPi2baN/09YG36BdnxZFCatr/AFGAFhyv6j9T5Nk4PIcBLRB5yGvlKjdCiUDlo7e8VBj6dWQ+kG9Ssy+6hOq3GrLB2+N9JYVcVhveoxLRR2HmLhnbLDzppIHqZ6sm+mP+O26nRQZN4S3d1jKI30Huw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=P+5LE01EtXEw9G1VfVWxOO/jsdiNoDnE3OmYcT3ktJmATr3WAzi1qL8xZ5FLaIrQfnvDMzJwPUE4kvGlL06gIO8i6tsfPStSobeNrG5jpE8W/BpkJ+Jct0c3BaQwLswND0EuSAFGTKweaBSU8QIW4UsqLRxsj1DeAIwdmwBuJKQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5998.namprd10.prod.outlook.com (2603:10b6:8:9e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 14:25:34 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 14:25:34 +0000
Message-ID: <6c6e98df-7389-c72b-915a-d577158a3e0d@oracle.com>
Date:   Wed, 23 Aug 2023 22:25:24 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 01/11] btrfs: move btrfs_crc32c_final into
 free-space-cache.c
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1692798556.git.josef@toxicpanda.com>
 <c86c72428b7356d2a983d6943818bd9c1c40e1fb.1692798556.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <c86c72428b7356d2a983d6943818bd9c1c40e1fb.1692798556.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::21) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5998:EE_
X-MS-Office365-Filtering-Correlation-Id: be874ef1-178e-41fe-b99a-08dba3e4cf49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W2FY7RXmqMPYdlgc3kM6H7tSYw3UnKztF6umk46yKPTu0zy8vaDhyN79dozARFD35n3QeQG8lQVGfxKT7a8n+QAqv9QojQMXbeXrKp55MBqS4xl9xlWEbf42WdiiNUn/n+utz8mMwwErjcwmedD4+Qjs6XJTlL0+gjhHHdkx1NrHCbBZAVtclS7E5ZwcfrNbmqbpQX7YoOxjxPDudK6fdnDQLRyUjoQvV43WKTdEguTmph8yYTnOTm4GioQRuRTC4X1GouFdOR4R+fVgtNctHOq1+izQwVManIl/hy7Rly7Vcu/ypo8hU9cXe9uXEnne5C6LgWPJvCzDbPxFrRbx6Th62Dlz1evAE9hu3/UQKJuspAILaTuXZ5BPzNB261D60yLe1d/2kCxQotPKpwq3ESu0giRjDBtWfrg3yOGsy8L2eaZ8m5wJRZIEo8K0Rm4jq8WIepHPbNnfH0j0mnHQodcC/oR8Q+Zg0KzRmVJXP/asPh9RqkJ60I7/E/vbAkGd55CtrkwktxMTwYHk9VCLQ7HMOkWhQOW0cChiv+ByeYLfBcW7UGNI+Dq1BhrQ2IomoF7DbLZCfGx76E71RDkdotPJFFSoJFwGIAWoOnxJrnv5ADVQ2jK+8ikr0rEX8PxyexfhieuOTx/lXVlMLg2l9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(136003)(396003)(376002)(451199024)(186009)(1800799009)(2906002)(6506007)(38100700002)(6486002)(558084003)(5660300002)(44832011)(26005)(4270600006)(31686004)(31696002)(86362001)(19618925003)(8676002)(2616005)(8936002)(316002)(66556008)(66946007)(6512007)(66476007)(478600001)(6666004)(36756003)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVEzR0Vjd0xKRmgveGdraDRuMkxzRWJRUUpKWVk5a3M0OHhTNU9BUTF0V0JP?=
 =?utf-8?B?NWZ2VExVVnB6aytRdkd3bDZjdEhBblVONkZReGRZOWRCcW4yRVhVMG1HMUlF?=
 =?utf-8?B?czZlT3o3bFlYUHQ2bnVKMWdLWDVZbXVBYnBMd2wrQ052dVV1VlAxbXh3dExM?=
 =?utf-8?B?bUZRNDd2dFJXbFdWVGhyT28wd1dNNmdyQVd1cTA2RzRkNkFBdEdsZERsUCtr?=
 =?utf-8?B?MTBmeFgrd2JDNlA3V2lQUTh4SnhUa2dST0o3Q0lkSTYvOXdvOGVraXFXMysr?=
 =?utf-8?B?MDN6OXVlWi9rOVV0MjhQVzZ6SHhDU0JPRnFObzEyb3pOYkphS2ZGanR6SklE?=
 =?utf-8?B?NFFScGJxVHdlV1J4cGxra2NxalNzbDVyczJQazlWSXMxTTNORUcwVlRCQTVs?=
 =?utf-8?B?Y0ZUODFyaXFtYXNZQWR1ckpzendOOHlodFF1b0YzRDZxMnd4YXhLeUw5Rm53?=
 =?utf-8?B?c0N4ZE1majhZb0Njc05PZFF1bWM2d29zTUR5RmhDOXQ3S3M1NjRYUHdWL0Ux?=
 =?utf-8?B?S09lSXA4WmtrRnJLY1JEdm5UM1hSeXUxV01pV2pNbkwwS29tUVk3Vkp4S3d5?=
 =?utf-8?B?b3dvNU5nUG1HS0p2WmJrbk5EK3FrUGt3UzJoL1JISnhjQlovZm8vS3Nxbnh5?=
 =?utf-8?B?ajJaTkJPbnY4TWRCdStVc0JocUdxRERMUURtRVFPWlRnUUZ6Z0xNc3BvZkRD?=
 =?utf-8?B?V0QvU29GTk15MlYxc2Vua1hSWXFQVjM3WDBOOGJTZys0Uy9NaEZEQndWV1dh?=
 =?utf-8?B?ZXJWelJQVHJLRmtxbmRsVThuR0dHenFOVm5SNTlQTHMyc3VqWG9zU0JWck9z?=
 =?utf-8?B?dEpFQjZXSlZQYy83aGZ2NERxVzR4bDJGRjFqa2xKd1pUQTNxcHcrTjVVOUZG?=
 =?utf-8?B?ZitOcDk5SytkNmtnUWlkMnVKZTZBWnc0dDVtQ1Nod0o2by9qYS9OdU51eDlz?=
 =?utf-8?B?OHUxSnRUcEh0TW1QeE9jaEdZUldSZXFQZ05DYThCcXhtc29wa0dGRW9CSUFw?=
 =?utf-8?B?czJQS3lyNGRlVWxYQmZSQWZvSHF5UXAyT0t2L21ZVVNJMHJjSTh4ZURKWElH?=
 =?utf-8?B?MXhXYnpTdFpzYUdnV0plcGVraG5kMlU1OGpvVGdMZ0xtOUdRaFZPL21IS3Fy?=
 =?utf-8?B?dnlpeE04N0xvTkVlcm5BY0FFdFYycEFVVEhLeXR6dEw4WFNVYm1SVm4xQ0tr?=
 =?utf-8?B?SGpRZEZQYnJzU3I4b0gza3liZ1RJU2hnbnplOC8wN2pDeXBRRGR4WHVIWkxu?=
 =?utf-8?B?cll6dkkzVDhkTkVUSzhLWHMxRnVkNWtmT1UxWXJTWi9ncXB0S0J2azZNVEJl?=
 =?utf-8?B?NEFtTFBqbHNHUmNGOW1OU213dm90WWR1blZjUVNhSkZzREl6NHdzNkJjcGxF?=
 =?utf-8?B?c2gvTjlmVk0xRUIrdnRFaVc3RWlNM21WNEk2SmxKbUpUODhsOXlBY240Wllr?=
 =?utf-8?B?WnJIQXBFYnpWMC9SVUxiNzlzUGRpZHpGMUFKc25FUmRMRFJBSG95YjcwdEYz?=
 =?utf-8?B?RXhBbHR4dCt5aDRxeW82MVdiWmxUbmtneHNYQnNTeWZ5cGF6K2Erc2tkNm9H?=
 =?utf-8?B?TGhqajMyemYwYmI1WUxpUjRBZndxMEh6WGNEcm1iQ0JPU1lKNWRGV2NpTUhk?=
 =?utf-8?B?VWxzc0dkSTBNaFF6YTh3YzhScmZKMWNhZU4yVmZLZVQ3S1Q2WmFZWXJmVEhN?=
 =?utf-8?B?dUdtQWVvMUtCVWZOcnFTdlZPdzVoUkFuaVdiRzlycHVxeW1LcEtseHdlN1Fh?=
 =?utf-8?B?a2RWQTRuRTVCZ25pbDc0QkNsQitKZHRTSWptYWhrWERlZFlzZEJtNFNOVHNM?=
 =?utf-8?B?eTZNRTBHdVFqM3NpQ0t2ZWZ4YmJKdTdpL0ZzbVdwYlFGNFgxdURucWViYThp?=
 =?utf-8?B?WlJJdzViOGpGU0ZJUHVJKzV2aTUzSGRwK0pYRE5vbWppQkRLNkoxc0E5TGIz?=
 =?utf-8?B?VEVPTjdCS1BGZHVCZjlIcTNrYkJjYzZXS0JGSFFLb2pQODg2RmdFcHVzQm1h?=
 =?utf-8?B?c0N0VmpVRGIvOEkvMnFXUk8xZjF4Q2h1SDhOb0VJRU1QWGZqaGpUczllemVX?=
 =?utf-8?B?bFdkU3RJQTFiR09HZGwxbitDRmFISU5RbDRRUVNGSWRHRjQwbmxkSUVBVnNy?=
 =?utf-8?Q?duOIFLQXhL/iQrC0KK/oWI5E2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: e/KeOhdqqEGAT7IXK+MxknlpIk7gEtmiy+efpGnet8qykh8XVbBHHHWa9GmDl8Rs9u/eUrIEIghn3tzJp6lBovF0uskoRwlkLZDet5j5zDH4mVeoYe6PswYzdcnQHo1ievGZH+ZSvr7wz4SJiDLuTxfyWAFDG4vUB6uemSEmlzCOQjhrLBocv4zmHAJmPKLx1mcn4FjZQEjvT2Tqu116H2G28gqLznYmxPVvO5S/5tl80xD3q7g0tmxvK0kW1fHFHza8djIniQ+XoMTgVTLltoenipSXFa4F6WKXN4eXH0ngkryjvKQG5ehi+P8aXOTNpyscMdchz6QPVNnFZ3gF43ZVreUe32noOujIs6H42UB6ktsnVTkvgQ+0V0M/ZB+MLZen0Qjt4ce7nc2I/fzKzkBLVQhx8rA4dvn53oGTHW6cmIQbypv1BGKLPqUI+8cF/lZ6H0UZDm/CgpKzuv0JeKZqU/vMEyewfsSQjOmvu4Eh2biA0CxWxc9UmPIRa8w6u8L5ELoei6Vnp7rjH8xaS9GNEdJBflgA4AN3u58cc78y1CKWgr8FR1M/kEoODNlPj9p9ICoBSDWW3DLs45uFFjES5lKv+KhRxjucqsz7BaRYDswEz0uS2P+acFe+Q4BPOScgLiZmhm54ngJ5X0oI4mfcA7OYnAD+teoGGK5LLidCem1bBtqhfO21cT8RHjzUZpvYY4P00DKcAR8vUDvNqXmU7rCo8BuDPt0CF5SEdvbCt2XFoTa0kjsy5Oc+45x6o4jmuORtZysoNQJqWU0/eNPd7lsEI4f3WWKtaHGzjENKvr3PVbORGYS+7KLIOsO6
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be874ef1-178e-41fe-b99a-08dba3e4cf49
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 14:25:33.9602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hFGW6BHfd2fOoMJvsYs5GG0yLAwjPP1aEZM6zlCqZ2GSNRNKmbd6NXNz3pY53ydXxr2PELU0U5aHqjmeM3Y+6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5998
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_09,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308230131
X-Proofpoint-ORIG-GUID: Tbw7pmU8w1w9pqkSp1G9LfTgppjLPIWX
X-Proofpoint-GUID: Tbw7pmU8w1w9pqkSp1G9LfTgppjLPIWX
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

LGTM

Reviewed-by: Anand Jain <anand.jain@oracle.com>
