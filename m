Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E3A7DE9EA
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Nov 2023 02:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348180AbjKBBQj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Nov 2023 21:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346865AbjKBBQi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Nov 2023 21:16:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15B3115
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Nov 2023 18:16:35 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1MiNvj019668;
        Thu, 2 Nov 2023 01:16:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=/gtjH05+INknAQ9I3aCyKPMV7/0Ys/5I/hVU6ZX4NoU=;
 b=kwq/LsmJYtjHeY7ToRaTwjNTcOy0dSTU23U3Swbqg/y6ylKZrXbmmmfgD1MwZY/kQWDx
 xf0LlmIoJ9OF9Rc89dN0LRj3PvrAaiAAW9d4Uj7jZ9ehC+GpL2L+lkcNWQ+7qhKdwrPP
 7gyVBub/UH1VFVNuyh16sY3aTVoaY6AHt7VeZB0hsQp4YH7jPwkJTIQjQzjEaCepNhvN
 2iF+6+yt/U0itoFKV1arErozlP4XheU674m+xtTssild3v3GnZ0xcd0IbwjfLlpuGu6F
 iKJbz9jQNH882liYD6TwAQpPIeDYz+H9tpYtO4CrvCWlIDGmJmyJVYhsyiRTBqb36yTJ Dg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0s340u98-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Nov 2023 01:16:32 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1NABEw001116;
        Thu, 2 Nov 2023 01:16:31 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rr86618-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Nov 2023 01:16:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JwhRXGXbyVu27vOwFDgjf0VItfH0Oro7LEBYupgTMbIpOlgHrMC26+YbjRA42YQ8FgXRX2FU4HahsNZsR1KBBZnWe8dgMOsBFaHcEIcij3C4B5zxeesomPz8G45GBg7C+0DgYn9wmoHyeocXb3StpO+ylAEE71tCMqfipyuA1RvmnpYZFPuxon9Sr6rBpN5xVqmeLjdksTaKhZLK1QWH+gOzJVETPTY9cavqIOY6SDBLdYPnYPJ2F0lbLpvLjaC3Be3yeriYDXU0yMtQf1G+a5tm3kgRkpNawsaWxJOMT+clM4/6XxmENIyM3WsLG7t04/jAmj2SO96wVtAcEl1jnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gtjH05+INknAQ9I3aCyKPMV7/0Ys/5I/hVU6ZX4NoU=;
 b=CeP4sbGhOHgM7Ncj7FMzyS2CUZIp1rsZwbp/499nnEB4BZ6HbQYIJ89o96486SxiLfJAwbV185Noe+vqKQeDTiS3WNzNd2dtm3yMxC4v1HqhwJpTIeCG4Dx2vyAWt0tBDxkvNLEtHct0AFIMwDl7JlYceOmdfC9urU/jzJ/+gQ6DVkGKZ8WT8yKSf16cARWPMxSve1s2MivgDOvH0YgSpCwU7pOvWUgQfE7T8uLz5i6oaSqy4/j8YlkTI9BeaVQtKPPXhUhkUVG+sSsGmSxfJmkLU92FjrqMvCuPYUdoPL4pLLzwYoXiUkeVAsmxgAW8fvOhMiwbdoVZPAukvzcpeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gtjH05+INknAQ9I3aCyKPMV7/0Ys/5I/hVU6ZX4NoU=;
 b=WPE/uKAzw3tX8S3uTmDhpI9kJXwyVOrlBB7rqthbuZP0c3IH+o6DWk0at2u2ria9UXIDQNMOC3yvr6xpHtswShm/jSu0qCmlifpFErEGdDt8afRPZUW61Alu5fzmKdVlBYJ3pjp6M0CfWgRgxkL0JodooILxaI8kDGNsQjzHmZ4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA3PR10MB6952.namprd10.prod.outlook.com (2603:10b6:806:31b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.32; Thu, 2 Nov
 2023 01:16:29 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::8732:b8be:e262:1fb]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::8732:b8be:e262:1fb%4]) with mapi id 15.20.6933.029; Thu, 2 Nov 2023
 01:16:28 +0000
Message-ID: <18fda4f8-8f3c-4dd1-8aca-667726e278df@oracle.com>
Date:   Thu, 2 Nov 2023 09:16:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: add dmesg output when mounting and unmounting
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <215e7eea95459d1b0cc4fd9ce522dc7c8f5d4e02.1698873846.git.wqu@suse.com>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <215e7eea95459d1b0cc4fd9ce522dc7c8f5d4e02.1698873846.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA3PR10MB6952:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e9776a4-8367-4e22-faad-08dbdb415726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7PbV2yHw70WDrMUGUUwGmoYA0JQmZQzYe82hVtV0uM5ld7DlnySfZZGPTdUcJqbvLo6Mep93IaM77ledzA3rUmQeyINUfXf0vY+g+gM/IFx8lGHJGQIf/5VKdU2PUa9czyeQijCI7Pf6V49MfayFEVst1Z5qn5dBUnwg/+NuttShxF4iIfP9vB0sLkSG15TWWGnHXTEZlvzP2OS2KYPjjEK+oEc9kRwdIVdPdrSscujWfQNOaIXXTL6cI+w4k552W/AfPPepfKflFvye4XuSvBhKSDeO84RTmfTv7A95aE5UbMcIBGJDyNdwAFyvbeUznqSgTW6o3qatx1cvlLA7+ezN5fXBHBj/T4PnAYLaNUzfWsXWjmey608N+dt/CuH2sYSGthlRTwYIXxE90VIbrpIUUxZaLR6CswXiOA4NfnbSd4r8G4gHe40ajGegkbgKibApQvJP/6IcX9NPmBWtqMByYovUTfsRhbwseXwvuZMmhnqkCVhrmyE1m1d8kkp9k9HYmwZ5LMz130lOQpfJUm5LwvIIvPKgkPPRSgnYv90xxcE7qO+/RoLLNpsysrZqfhkCY+BpP5YEhKL/XzZXaOvHxaFin4W4KX/UbbZiwEMc6hwZ3mCkZdzfEzbAEXmg+YxrtVMfLklT5RyK1aYZlLCG4CtJFfz8g0I+KaV6che0jr90S+/nDiI+B30883oY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(396003)(39860400002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(31686004)(2616005)(86362001)(36756003)(31696002)(38100700002)(6512007)(478600001)(83380400001)(316002)(26005)(6666004)(66476007)(6506007)(53546011)(2906002)(66946007)(6486002)(8676002)(66556008)(966005)(8936002)(41300700001)(5660300002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1lWR0s2K1h5U1JRVVBVLzVEeGJHZXYzOFBCeEtRU3pkaVJLNzFLU2djOHhy?=
 =?utf-8?B?WThjWnhvYkZMTlU2d1pnblJER0czVHdSTFl4WUV2OUpWdXhnWWd2UlNFbEVS?=
 =?utf-8?B?WU9QR3E4bERHL3VFV2xXMDYxY0U0czNESTErcXVWYlhpRDEzTHVTSTNXY0t3?=
 =?utf-8?B?Tk5hRDRiMkV2WEZsYUlZRUxSQlpoR3Yvd1dNMFhhSlRuMUMveVgyc2JmTXhl?=
 =?utf-8?B?TGVoN25zSmNiVmhyYnE5aTVhZjZJK0tNanpvNFVkNVlNcWtKOS9pZllsK25S?=
 =?utf-8?B?RlBDSXJMbFNwRFczYmJjcTFHUUNZNW5rak1aTUFZYzRmOFJVSEx1NE1lMG52?=
 =?utf-8?B?aGk3QlBsNWNBU295V1VUUG9jRHF2RWE0aEJ0NVA2UnJseXh2Nng3VFVVVFNR?=
 =?utf-8?B?Tmp0aHRnSEtiYWZob3U4MVZ1SHhRU29mL0xIbjNQMWNiNkxvYlBSeGV0bHBJ?=
 =?utf-8?B?Wk9GSVR5Szh0NjNkbjBVVmlFS2pnZnBTRzlGWmc2MWFWTGRiTVNCNS9adERT?=
 =?utf-8?B?T1NCZjVZa3BEMFZUT3BOaWl6WE1uWld4TnVtWHlubG14bVcxK2NSRktUbXh2?=
 =?utf-8?B?TXhxM1VwaHBtT0l6VkJ4R0ZvSkJ2YUtGMTJoYmpORDFCUUF1WjZGdUlvbDRy?=
 =?utf-8?B?WnlJWUtsNDQ5V1pqSXZWVE1sMVpPUnFyVTM3SUx3ZmhoVFkzQytSckNDYlNW?=
 =?utf-8?B?N3ZVWS9yYkh4by9OR2ExY0g4QlAyQUZFemVmakZSNUtvMTlqTzU1bFJuODBu?=
 =?utf-8?B?anZyRHRVSEFKUkJEVWZTTE5FVGZzd2JabVZJM0ZQaHhFK3Z1dDQvTllYVjVu?=
 =?utf-8?B?cEs5YTdmdmRMLzNPUUlNSDdNNjNIZHNHVEdkVWc2WTdqQ3h4RmJVWXRsdFhX?=
 =?utf-8?B?a3VLVDNXTFpQNlRFNk9sQllXbk9qbk4vN2ZHMHpVUDlDK0s3OHArR3VtOGRU?=
 =?utf-8?B?cDVJanlWRzRYeUREdmJkOWRobE9JWGczcjNpL09pdnhqMEhIZW93VWxwVnYz?=
 =?utf-8?B?dThITWVYV2JMd29uekk2QzgvU3RBUzBSMVdzZ2QyRnl0VXFHbko5d0dzUkZN?=
 =?utf-8?B?QTVOdjRJWTFGbXQxZTh3QWY2NVRWbHB4M1ptYWZURzVLQjcxZjVjTVB4a3FW?=
 =?utf-8?B?cXBhNTFGbDJsSWJtdi9XMCtZYkw1dmpsbnl5K1d5MitXSTRTZjBWTW90aXlk?=
 =?utf-8?B?Zi8rdmdaNTFob29DbWdhMUxTUFk5cTNLQk1KZXFteVVsQ3FBZzFIQWVWSDNx?=
 =?utf-8?B?b3dzaEpNWS9xbFgzTlFvU3dIUWtiZXNkQXpzRC82VzVrMFF6K21VQmRLWklF?=
 =?utf-8?B?cm16bTdWMFk0clg3N29VQjNrWitUSmErOVJXdk9taVhFaGp5QUJoazhicjEz?=
 =?utf-8?B?UVB2ZVhSVXpEVE12Skw4YlBEeFZ4emtTQTVKTHg0eGxBL0NqYkpHK2JDRVVN?=
 =?utf-8?B?L29zNzNNQUZxL3BZUTZieVBxaCtSMEhPcVhCOSswbUE1L3NybEUrVEs2RVNk?=
 =?utf-8?B?eWdWKzNpK0J4ajlMOGphT0RaVndsWmJzWFh3N3dpYzJMUTRrUThnV0VBWlFJ?=
 =?utf-8?B?dVIxa21LcW5HR2pWV2hYSmZBdmhWNmYvSzlZUmJ4dElzbjR4SUtTVHRsKzZE?=
 =?utf-8?B?VTVldXhyUEtRMXVZdzA2aFAvUTYrYjd0U2xXUUE2REVIUEZUK2s4N2FQbmxW?=
 =?utf-8?B?MlZWVXYwN0ZaanF1Mzh1VjlpT1dLeXdFZHpOTmxYTytNeVF1cFF5YVc3aGdG?=
 =?utf-8?B?LzZ6VmRJWjFaanZsQmtlbG5nTFNjYURvV3VPZDZXZmh6WjVRcFlXby9vWWNQ?=
 =?utf-8?B?NVhzdHRuRmZBMWRQZWdhWExDaE9EUHBIOUNHTUtsL2oxUTNnY2hKSG9JUFlC?=
 =?utf-8?B?YU5QMjhldGlxUlZscnN3RGw2NEZGbm5pSzBSYUcrMlZhVFdCQ1ZWZGFXVCs4?=
 =?utf-8?B?RThobDBaY3h3MTZ1aUdnWTd2OThxbWZGZWFQYkE3S2szelE5bTVlWlZmZEli?=
 =?utf-8?B?d0Z5ZFVvLzZFZ1NzOEwyazk0QkNmTXdUMllkZXo1QXIza2txQ0ZZVmxHcmwz?=
 =?utf-8?B?NFY3R2Y3U1I1NTBFYzVEKy9nQ2MvRDM1Y01yQTVvSTlWSDRHTnJFY3RGZUJ0?=
 =?utf-8?Q?XEeUUUFykTJtbL/gkdGSpGHzW?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pdylT9Z6f62P6mE/IgAPQ5kBPK15s5H/tG7hd2FD9CXft3F9opAgPwET8Hwu/nCtfXKVWUHyN909J/hHKupYQ7l/iVr9Ly7lf78zdr9kwUurmatMufe0tEL9SRfTwfahownHWqFsA6dbN28t3N80S2ZQdQ/WPDIHlpgZSErm1BQ9HagH8+E2bp4ftjsDP3IsHt71izmwuP2P+lajSPTRcQshg0NHhNlTE9S7Zoy/DLtj9RteLJ5SBrVmNgY4IbWqzMnN+roO+muNzOYmGfCdJBJOdJ4Derp9PT3zkvpNtcCXOnTvcqys3HA+MHIO3QOkkqVAg93e1JuC7awS4Ssu+vsCwn0c3VKw95gRNhEtD5x4uSUVpmrkWXLyHn7l/Yu7bzeC18b1t5YJjE/UHWlRr3d/tVTHyf0znMUC8kmntjiiEvZHDrHLMsT59zNlMvIO5gWQ1Q5Scib2dA2LgpWYaggX5GNwvyXcF73RPTVTSbSAGv9P3ETrVp0hFtmWhhnqoZEJpV/iTUiKwPFbYIPqEngNoKMeQr6mjtc7CkPX6zefeAupozIaO8D4AmkjDH+FvwOwXs3OVOaTAZEBCxA411NiifFCH69Jlpjffo7vViX2ORb0kWJL715bOKssEFXXNS1y8a/YTv//DwUypTX+Ce5FpvhRFCqDLKN1qGC8EEAtW5SkRopfbWdCX3PHI5Y8XQwBq2RN3n715YxPVg9kgugUtgEbFXjAk4k3PXF8pqPfYYGBaVhn1r0Ibjd6t2zHePVeL/sceRE4rpASI3BUfFRcsLzBvo99h1kxP+UlUpc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e9776a4-8367-4e22-faad-08dbdb415726
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 01:16:28.6032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: io8viUpPNpvDuIT3BDvPDi9DbGNSlpV1T5eLLf8Dfm874KXgWL3JyFknFcLjeBDUV7NZ8abz0rd2vHMWIkhv4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB6952
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_23,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311020008
X-Proofpoint-GUID: vQUUathbPkzrc863hzF6dwtrEbp1UDye
X-Proofpoint-ORIG-GUID: vQUUathbPkzrc863hzF6dwtrEbp1UDye
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/2/23 05:24, Qu Wenruo wrote:
> There is a feature request to add dmesg output when unmounting a btrfs.
> 
> There are several alternative methods to do the same thing, but with
> their problems:
> 
> - Use eBPF to watch btrfs_put_super()/open_ctree()
>    Not end user friendly, they have to dip their head into the source
>    code.
> 
> - Watch for /sys/fs/<uuid>/
>    This is way more simpler, but still requires some simple device -> uuid
>    lookups.
>    And a script needs to use inotify to watch /sys/fs/.
> 


> Compared to all these, directly outputting the information into dmesg
> would be the most simple one, with both device and UUID included.
> 

Well, I submitted a patch for this in 2017, but I'm not sure why it 
wasn't integrated or commented.

https://lore.kernel.org/linux-btrfs/3352043d-dbb1-0055-f50a-c91ca43aff1d@oracle.com/

Thanks, Anand


> And since we're here, also add the output when mounting a btrfs, to keep
> the dmesg paired.
> 
> Now mounting a btrfs with all default mkfs options would look like this:
> 
> [   81.906566] BTRFS info (device dm-8): mounting filesystem 633b5c16-afe3-4b79-b195-138fe145e4f2
> [   81.907494] BTRFS info (device dm-8): using crc32c (crc32c-intel) checksum algorithm
> [   81.908258] BTRFS info (device dm-8): using free space tree
> [   81.912644] BTRFS info (device dm-8): auto enabling async discard
> [   81.913277] BTRFS info (device dm-8): checking UUID tree
> [   91.668256] BTRFS info (device dm-8): unmounting filesystem 633b5c16-afe3-4b79-b195-138fe145e4f2
> 
> Link: https://github.com/kdave/btrfs-progs/issues/689
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/disk-io.c | 1 +
>   fs/btrfs/super.c   | 6 +++++-
>   2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 350e1b02cc8e..2fef94bfa2ff 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3209,6 +3209,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>   		goto fail_alloc;
>   	}
>   
> +	btrfs_info(fs_info, "mounting filesystem %pU", disk_super->fsid);
>   	/*
>   	 * Verify the type first, if that or the checksum value are
>   	 * corrupted, we'll find out
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 6ecf78d09694..fbcd8c8d23dc 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -80,7 +80,11 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data);
>   
>   static void btrfs_put_super(struct super_block *sb)
>   {
> -	close_ctree(btrfs_sb(sb));
> +	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
> +
> +	btrfs_info(fs_info, "unmounting filesystem %pU",
> +		   fs_info->fs_devices->fsid);
> +	close_ctree(fs_info);
>   }
>   
>   enum {

