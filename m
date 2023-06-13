Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470D472E01F
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jun 2023 12:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235573AbjFMKxD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jun 2023 06:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233941AbjFMKxB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jun 2023 06:53:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC8A107
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 03:53:00 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35D65GC4002074
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 10:52:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=5PLSV2/rvdQyFCsexQyGsPLIu+XcvDqz0H1/LYxjozU=;
 b=Eo0MwlNcetRBHTBhWzyVfoh7X8lKKjyWBZJFJYLOp69K7JXG7LMql4QfKUgG/KIWr2FE
 iIaTfAEskhhT8kgmwXT/MxqzvP83xfCywOZ4LthznwPMszqK0T3uDNvuMgJpjJ3iStAm
 T6AJXPr1DTEKrNBNqt/opkSMe0+NMNDKkG9eBD7o+B8zNyK6eMSUncedOcBQPop7Wb1/
 9kuZEa4JAUK3J+SOmHcKw++lOYpniuJGrmSQaRyCjybnpqvPbS9FIyPQxkBaEdZHeVUy
 M5++/z6TPo3uxu+XK+WraCf/hlk7Ql7729G3sqB8rmgBQwv98bYq339N+ZL+0fY4Gweb Vg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4gstvuy8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 10:52:59 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35DAUM8G008944
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 10:52:58 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm48hw7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 10:52:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7rm4robbKP88/oau08LpI5thpEZwuekHjNS9FVilZU/uy3OHW+vPtc8m56ZbI1/jVoR+OM6KieHx3CBEUNYZ81yYaXLoMIGUSrMljtfR2JdvuANa6EMbSLorzpeEXXqOCvwjqYxuPb/W3Q2h1KSe32ZKJVH7il181+yQ5binhhuTAVpGtqAw3OyGp77qsULvebmmj7nxiQXjs16KBLNIDnGwiERRd7j1Hjl9i42hZvpsHNGNiJbSRxZcGDcSXXA9dDB014FYbGq9s9jd6M0imE0JbCMoU6HsIsAOQj80a40t2TNzqz+oLT4Z7JCBQhd4LfLgeFqiuw6P83GXIp+WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5PLSV2/rvdQyFCsexQyGsPLIu+XcvDqz0H1/LYxjozU=;
 b=P3AdrXjO8BP0HTFUayGTymIlImzFzFY+aD84h20F850ZZfCo1qQBBmGBY2Rc13aGZk3NYWbHwWq1VPQydL6pihL9pF8wQ0Dvzx0A8r2AngAQh0LVId+tI7Y4CDn6Gj9/9JGuPo4U6syTOaXmAxCgBWc/KsrD0tMJo9aZnJU9RJ62hidW3XxBqUxuxk+6yRHbfrezqjdJVoxbvwoGZXUTlU1OgycJpGBKaDYKfZDgVUoa7A6b2nvX3TK9X42cvSomcLn0pgkwr05KrzREWWi8Xgci55qU4bzHyoiGypOeA37POU9J3w6cdWDCjs7iutw4nUTJnZQWIUJ8xbbJLRrAjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PLSV2/rvdQyFCsexQyGsPLIu+XcvDqz0H1/LYxjozU=;
 b=x9zH4Sy7h+2JTdDlUNJ7UDjtO05R9hIQdSTy10YSqor8v2880WSk9L0cpHeIkHCkeUmBsKtqsyifhY6qUMeRTIsKdW4jYqZeSuQX0YbFO0Jbp0nWuvTgbYtAk10dr25IVRmEMmTKiJl2RJbG5L+9v6M9hNu//npIET9e9y2rj+o=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB6197.namprd10.prod.outlook.com (2603:10b6:8:c3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.39; Tue, 13 Jun 2023 10:52:56 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6477.028; Tue, 13 Jun 2023
 10:52:55 +0000
Message-ID: <305ce6b2-f4d4-a5c0-d6c7-6695f7f4c41e@oracle.com>
Date:   Tue, 13 Jun 2023 18:52:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/1] btrfs-progs: tune: introduce --device option
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
References: <cover.1686484243.git.anand.jain@oracle.com>
 <4640d0c2f0fea0ccb009c26acfabe53cfdf61b31.1686494057.git.anand.jain@oracle.com>
In-Reply-To: <4640d0c2f0fea0ccb009c26acfabe53cfdf61b31.1686494057.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:4:197::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB6197:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f13951e-b459-4044-5b71-08db6bfc57c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ze+PQvzqmOjjdPSxMFQSf99thhXL+cPgnNEsGdfmsDzvV12kKcLSzf2ypJkK/s6WtFKXg7HNXG0IQaE27CBceC0XU4BUDH3ZQzfIsnVFRtCGuoCWSZRJJwAPkvOerYVKxHhKQhsWqejM21iYknDZm5rNsfM/wXFw43BiJQgk2BFzGBGYSspMFm6iWmz6qv7VIXgTMm7uWXqiNdb4c83tpMtlovboQ1x2zhYqAhGhpla+kiw1+U15gCR4bMqFhYPR5LZgMY2cGCPb3MQPJLjdTfWnZh3e18j3bJhtuZ/noo1uP/P+QWAxmUemzw481FUgLqE7rN8Rou+ZS5tt/GD+On11m55dKvJKdWGiNoZGQLmJW4lBTKe0FJBXUMVc5OFna35cmfWHnFVwExbHyVWLqHxP2yDhYkYlfsO+5VNiQcjYYtwa8zQIk2hYxT94NMcJ1tP+FkOHQnkavvy02fYHNl3I+GR9ZgrI9CFX0P436VIpHG5/DnEsRCMZO4NHShWWVvOXeAKlrCFVxD9u4KkDcS94wCRdhOojDh7szIA/FgrpDvG9h/wO73Gin9pJdXhBxoIQrCV1VnLLeiVs4lkpsy6EH04HbRET6dKGkbijiZ0mQ+ulBHZOzP8ExlEWxPU43LjYkO2NG/r90EKCYoPV0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199021)(316002)(6486002)(41300700001)(186003)(2616005)(31696002)(86362001)(44832011)(26005)(6506007)(6512007)(2906002)(558084003)(38100700002)(36756003)(5660300002)(8936002)(8676002)(66556008)(66946007)(478600001)(31686004)(6666004)(66476007)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXBWZ1ozUmlxOHVoQnNiTHhWVFhvc000NldqTS9yL0IwV2QyQmJYVDRUUFRr?=
 =?utf-8?B?SGZaYUNReUhvdi9NRlpmTEl6ZHpsNHRmc3VQVk8rMUlnalVISFdaVmZLR1U1?=
 =?utf-8?B?YlozQ2I3aytCd3FTM21EQlRYTGxna1RHU1BFbnh4S09PWlVjSTBHYklMYVpm?=
 =?utf-8?B?ZmpCMHNLL0hYYmVkN0Rhamd5S2tETitRYk9HcXZKcVJLK2dzYWtCV3JxdCty?=
 =?utf-8?B?STVoWXFoeUp3ZWRkSDM1VVp4NEZiNWV3Yis5cnV3TnI2TWFxY2hnUDV5K1Rz?=
 =?utf-8?B?ajdveUxCV2dXR2w1MHI4YjZxUmpoY1h4WGxVM1BSeVIyWCs2N3BOWXJBQUVW?=
 =?utf-8?B?ZmIybG5XMHB6TDJOS3Z4MU10cElDSVcyc3BKaUc2QmcwdUJhMnRQNEh5U1pY?=
 =?utf-8?B?RDVPQk96Z0preDhtVHRBTjJ3T2VWT01MSXBLNEdjUHl3bVE4NGFUem9qUzR6?=
 =?utf-8?B?a3pMMEZNQmpKSEVyaU1oWVdqYzNnazdlUC9LYlFObWpvQXVZSVNlRkMvU1gw?=
 =?utf-8?B?THZ3aUpYSGVqU0hiL29mbzVYNTUxNzNwTzdkemw3OVMwODNXVmhnaThxRHFp?=
 =?utf-8?B?NE9oVnVLcXZTRDNXVWZxYVZteEtWWnpsK3phblRIQkJHbW5hOGxCOVI3QWlU?=
 =?utf-8?B?WmFUTmZmb3R6eTMvZWJvTFZuVnRVTDNBbmFsS25hT3BpRkxmb2ZkVFhiQjZF?=
 =?utf-8?B?L1NPQU1WM2NkRFFqdzRhVTNsSVk5Nm9LQXQ2bDRYMXl1Wlg3YkJpamFzZEhP?=
 =?utf-8?B?MXl6NXo3c29IWEM4UlRiUWdpNmYxSWRSSXVZL3F0dnJBMVB2VWNxYjRvSjJz?=
 =?utf-8?B?a2V4UkdyeVFlcUd3dll3M3hDSVBWZVFPRFBvY1lXQmtESXR3aFRtQXZRUGRt?=
 =?utf-8?B?YUk4UU5mR3RKQVlUZThnZVlwaXRod3JzRHZPS2VDT3pKQmx5S0FsZGlzVDM0?=
 =?utf-8?B?KzEvOFA5eVA3dlRydTgrTXhaemJ5TVVLZTY0b0I4dThmcE12ME1oRmh5aWZN?=
 =?utf-8?B?R29rQ3EyaTJOT3A4R3E3bGF3TlBwSm5oRGxTR1BJS0gzQ1ZPRWtqWmtGNlVJ?=
 =?utf-8?B?UnBCR0JaekhlRkFEUTU0TVFzcnpybythc2xOcENDd1FFcDE3OVhWOERYc1ps?=
 =?utf-8?B?b3pvNklwU1llcnArUGJPV3N1elcxY05NYlVIeDU1cTFzUXFSOGdHL1Y3cVZa?=
 =?utf-8?B?NzkrTnh6RG5hSFJGaExjeFhRcUljUEpXMmNFZlNSZlNuV25mdXQ3dzJBQWdD?=
 =?utf-8?B?c2hXb3luVzMvaG9Gd1J0aWplNzZ2bktEK2hYZjU4NnVCekFoMmlGek9pVUt4?=
 =?utf-8?B?Y0EzK2MydmU4RXlYTExLL1JMQkxpcmlBa1ZnTW5FRjhoQmp6M2lnRS9RcEFO?=
 =?utf-8?B?SlUvV2NqM0VPQ2JVZWFhUGVCNktNcnpweGYvVkl6ekZFRHl4UXZoVUN5c0Zt?=
 =?utf-8?B?dW5VdEREQkc1TUZucEpTS3NWOElZa2lKOTF3RXJra2picWVYdE1jYS9yVEFo?=
 =?utf-8?B?YVhUWlg1aUdVZEhGNFgxdzc5V2w1bndkS1pLcTV3VFhPYy9ZR0dDa3creWtY?=
 =?utf-8?B?N25wTzBNNC9rWnVzTll3b0JWRmNLV0ZKSERlS3k0MG5ZbG5iSTlyUjM5N3Z2?=
 =?utf-8?B?KzZWUHlXaWY1TW9pYmNDNnVMbWdTK0x5VE16elQ5bGRsRkl1WVBEMVhaYVBV?=
 =?utf-8?B?aWlPblN2WHZpSURSNDdNM2lPTGlEbXFjQ1N4RmpDUkIxWXdzMmFzV2VwRHpR?=
 =?utf-8?B?ZUxucFNVWTRjUHd0VEdUbk9FUWZLMFJ4cmdxMDV4akowN3hwSUFxcDVpS25X?=
 =?utf-8?B?eXU4N3FsTS85OCtObTNWWktuQ0tMdkxZUnZDRTRTRG0xTUFyUWdNSjVxcmNM?=
 =?utf-8?B?OHR2RWsxME1Oc09RQ1NweXB6N2hVc3Y4azg1T1JuK1RWV3F2VlRLUU84Zkkw?=
 =?utf-8?B?bmlNdjB2TkZpUitKMlRId3IyQ2x3RGlUdnBzcDRxWjNUbkRGUGcyVVdkTGpJ?=
 =?utf-8?B?UUh1eTlrUnFkU2NidEhXVFZ1OS9PQllHTVBjSmtYNTlsMW14bVcvaWtvUGNW?=
 =?utf-8?B?dkdmblRubjlOTERZOGlQS0ZNUHNCMG8vWjZRNVVrTGdqVmxjcWJNWS9RcDQx?=
 =?utf-8?B?QklhUHVnRkVXaS9uNmcvQ1NNcVliNmlRUm9qVlFYVUJjWVFTTmdDUWhUVytG?=
 =?utf-8?B?TlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TlqBllwJrX5ZAoQuSmtKnXgkDpdFd+dg8qj9kWe7rS3KUp1KlU98PRXEPhb6ebYrnpRq2z/k5WthqbKKK0tqfrIURPn4YsEykw13sxR87gECZ34fUQPL23Th97VPNJHK35K/M5gaHc2qSn6pQOPJKfYaRqurKNYd2QDtqqpCeA4rs0NtXao3CMxMTGBPsyQM3mdjAnkPRTQYRPa7PNdQT2uCQI/gKs4ma+Vl024aIXYctVfgOSgWa+LUlITIXNcJEL0QsH7wqlP1wf/swgVc5opMrD/tX8icYO3jY6QzYbu3awSblnRiKzoZrSXXRWIyaNydXDCgQpJs45/Hmptl3MAAV/BVU21aoLMpsMlMbOLvqv4st2E1K8f6dWK3tTIQDXifhcMnv7WI428UGTPuwnmuOPBBfjwlBrJXpgP1FwVNRCBuPi+B9luAIQrSqBb5z39bxSHxYy4ALMh9zBPJRbjGRCLcJbuK0YNF7l1a8JUH+Y0hRpGAwfMHw8Y7mG4+Y71ispm/XEiI98ixnClZyKW8R4IVYfV/NgijmwzSItklJDWYFmnCdV+eGrT0T6Xjos2qGf5x3vn0tBWuDm07SNk0S08mEmQOKROIUTlh0jkdivfaU3R67RalmdhM8E/Iym7HkF4q3aDLJl+a128QnIcl7iD+y45hrbFj45xIpDwVJsG9S7TdO0A+zXa9adfkDZ1b7gWY/zrvJvTZiFKEpjisFI2mtdSOamp4q47AujX5BfzX5YfutI51IFM3jc0IUDJiHVjtnZT3iImUwQPfpA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f13951e-b459-4044-5b71-08db6bfc57c2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 10:52:55.4421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dvxuWZw6MdTK+y/8GOUif/XDQq3Eqj2/seuYZRjWyDyLedjEE2OYHZM2FrpKLXgnx0cIRNW/5ON2ZObkiCcjUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6197
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_04,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=463 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306130096
X-Proofpoint-GUID: XRE9fLCMi98DVanCgwHXI-0JYdx1miBB
X-Proofpoint-ORIG-GUID: XRE9fLCMi98DVanCgwHXI-0JYdx1miBB
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Pls read the patch number as 2/5. Thx.
