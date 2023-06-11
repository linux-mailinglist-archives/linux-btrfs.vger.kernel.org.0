Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D90172B17B
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Jun 2023 12:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjFKK5h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 11 Jun 2023 06:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjFKK5f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 11 Jun 2023 06:57:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB672BC
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Jun 2023 03:57:34 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35B5UGGb016786;
        Sun, 11 Jun 2023 10:57:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=nkttL3QFCNtdoBnm09P4wMHgDGfBcug2z21Ly2VzCCk=;
 b=xrjs6AzM+wnowmjob0/wnkljmd5QtBrWRQyexV6PFMCq0+pY7/AU+hcTtAUeaynjPSxb
 iOYhW0M5E2NoK2CZahqhYGD1ZE3Ginuw80owxSnKeS1DElVVydNXJ5d7k9KupZqfE0Mq
 /qRWG6JzwkNZqFhI4H7xDcAKskdRPb3U7NdhvfkYZquXWt48wO7V5E6IHfBEIj3/vGcL
 k9MRRKKxoZ4gtR75fwXDIvCl9taii8VOKEliKHDRYf0waRuzeJmG/s++D+JMKrmma+Ly
 1QKZJZGaqMCbRQUIXasCO84exOoHKTxQ3tljMaa1MB0aOZ2UXAp1aNS8H1IW7C4eC/Sp BA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4gsts7u3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 11 Jun 2023 10:57:32 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35B8aHV4008325;
        Sun, 11 Jun 2023 10:57:31 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm82x59-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 11 Jun 2023 10:57:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0RD1Zglv+20QXi2smhFe8uKcMovp4zR2VjAMujrEnBae3KHHJlf8VOJIQCTXkrnalFvJI6tawhMVLppgCaF0vuNyolxep7TZs795SkADMK8yZq5gVaDCACUkIXPgi3YIp52R8iooUwTs8veKOdy9NUNcPqJMQD64ra7YTn6BTYQuskMtHy0f5qjbXVnhKUpVzpwYJvJY7h1HqPCH3a2Wkq5vNd3b6N/8ilaTFk5uHdLaeTV32orIUAAV8gyRpjGl+uff5r8OBbTns0oOUDKGRVznpZHLs6ktXrmXffCbcw9YVmvj3XAI5VhPjRLIIoSAliGw7srdJYDFkBXiA9MjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkttL3QFCNtdoBnm09P4wMHgDGfBcug2z21Ly2VzCCk=;
 b=MUKHNZECtrBlxQwly2t0IBG7Lnj2Up2ueJ838edZYifmP+yJ7LtucI55jafhDqFC9r/LujXK3TesQJliOPItSA23h3tCRfSwKZjwdF72W7tLtqLni40K9waCBIQOpXGgQPYRF/FhPlezldW/yhU2mDLcFgD1bzOUjzkbg5El4aQg6PdnuJhR9WmJq4XkfJ/Us7DVFRuiN7XmbN2QITWGCc6Uk1gbt6F8EMpIhniqy59Bx2vwkruErQzkQ40RC+R3mFqOIx3LlL0e39vHSPehAwMwEk9Y9NFIVxaKhHGZp/YbxMnsx3Z4I8U0JWEMzsv9vwYjOvOoqyJ3D4nOqVlsyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkttL3QFCNtdoBnm09P4wMHgDGfBcug2z21Ly2VzCCk=;
 b=ufy1gvvZWDHH16yo3Pty3A/36CkA9xUVqLxuPbcRU9cuh9zdDq0iArMKi8xTMJpBFTWVZJ/DMtUkH8at5M2HgBOdgFWX9wCw9nUSUzpv5HduVa3aJ9P2fa+rlfEd8Zw7LqzLdO7Qi7MkabUHgrNhbBSy4AJOx8v84afKQvcBHcM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB6301.namprd10.prod.outlook.com (2603:10b6:a03:44d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Sun, 11 Jun
 2023 10:57:29 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6477.028; Sun, 11 Jun 2023
 10:57:29 +0000
Message-ID: <3e8484aa-bf63-8dfd-4705-6e7027ae6178@oracle.com>
Date:   Sun, 11 Jun 2023 18:57:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/7] btrfs-progs: rename struct open_ctree_flags to
 open_ctree_args
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <cover.1686202417.git.anand.jain@oracle.com>
 <d6b012af9307b8ff71a3715e2e3d5cc58fafbee4.1686202417.git.anand.jain@oracle.com>
 <ed6225ca-2580-de48-4d2e-bf637ead2993@gmx.com>
 <c657c159-aff1-5cd6-cd10-b5ab271bb80d@oracle.com>
 <32ad876d-b923-edc0-fa74-30ea52e75a89@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <32ad876d-b923-edc0-fa74-30ea52e75a89@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: 750501f1-b1b1-4f30-4d13-08db6a6aa5e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N1jmwa9EPmRz//hiAZRswN+sshv4E1DvqKKPIx2h+4ojskqTsCqBgikmQqxfUOQRzfwjaFa7Y52wusClZbmGmW6iQ4qmwMtqv95D616QHJDlKjG21GLuMjeiRvTDi0zp4olCqneheTgDS6rUkSpxmBS7uoeLtIfpvTB45EAMG2d/6RDhl7o79/PEHvCkiTBVYCNfXTt6c4cwSGD2BK1FXg7LfqOsyohaXNRFsEw7elgFKo/VJMct0xhJtAKwX4C3VzVv0uDo2kU8ocj8FOPEO2p78kOLfZRHdzDTPLnlaXPqVBecPi3Ech01WYrYw083vhR8yErYzJ8GenOPtgXrKox56ubkaLobKLiEdLxgMbzJYhxIrqL0i2uvnQlmbO3hlBAabDFq+zH1IIVYGn6QHZDlZRYqgkyM8BzxtenkXGuJNy28+Q/JOrUisVmDU3EijsVsETpyih1eStP1qkAz6A3hSHDj0KmA08Wn3XC70+DNWEkEvUEDG/5zsSi7IPDt2OEOUhyiPFzaxaAudjRCJDvNxwVCiGOaIwvNlm8XOEiUcDXDec9HxWvdLdI9oEW/mS9LaWG3detiyYUJWjHcE6e86uXfa6a+U/ADQhX5y6cpkqlUCsLoFPv2GJjECRTfIpcLdsJcZ5UAdFYdoMoOLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(376002)(39860400002)(346002)(396003)(451199021)(8676002)(5660300002)(66946007)(66556008)(66476007)(31686004)(44832011)(8936002)(41300700001)(316002)(4744005)(186003)(2906002)(478600001)(6486002)(6666004)(6506007)(26005)(36756003)(6512007)(86362001)(2616005)(31696002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a21LNVBFQlFRelpUcWZsamVaUTNueGFUWVBzMVFOZ2lhZnFOelNEWERaYzJi?=
 =?utf-8?B?RUcrekY1OU0rTHgwKzR3dEdBMTZrNFlvbThibHh4K2lhWkVYSTRhOGdZTTEv?=
 =?utf-8?B?TEJiY0tiZVZzMEdTckI1SGxkc0lSZU9lYS9YaS94aCt2TDFLa093NHkyVCtn?=
 =?utf-8?B?Q3ZUQk5UTVBHZ2tTMkkvVlNOaThiam54ODhCcnpERy9kOTNwRW03ZlpFRFIx?=
 =?utf-8?B?cFhUcHhXeDdoamh4TlI3ay9hbkJQVHN1b0lsRCtqdVRKRGxDL1R3V3ZEUmNm?=
 =?utf-8?B?VGNMN1JpK0t0SjJ2L1FMNnE2VkFrZkUzYlFkczAxYk84WVVnbkpSVHVIY0Vw?=
 =?utf-8?B?ekM4WE53VFZBd0pUNUNVUjlQd05SQ0tCTWV4SjFidloyOFYxbUJhdzhOQm12?=
 =?utf-8?B?QkNWUStXdU9nQ0p4Z3c5amkxRGpHV1NTV0dqbVRvMjQvcU80eGcrR1RGQ2ts?=
 =?utf-8?B?MkplYzU5a1BJTm9WWlVMWU0vZzYrMUJ6MDdzQ2ZqN3VIaFU5L2pPVjF5c2dk?=
 =?utf-8?B?S09IWngvL2pXTG9YK1psOElwUy9ybUxGM2JQaVJMWlpvZTFuVk1SdmhWbHZx?=
 =?utf-8?B?bE54L0FQS1p1Y253dDc2NmpLaEZNK3pRZWtyUUVwc0k5aXdobnlGOTBXcVdh?=
 =?utf-8?B?MDlLV0xKWGJ3S1lzZE1kdGNlTFdNdTNjTW94UUVlMHNaNjJNY2NPOGQ3QTRk?=
 =?utf-8?B?MGVOZ1pyWm8zT1JCdU9XNGV4c1NvTGFQN3VxeFVCWFY4cjgvR0NsWHpUUmt5?=
 =?utf-8?B?NjZQOWlwN2I4UHE5dUxKTWkzNFFYamdvOWw0QWo4eEtXakFTVHBnS1VLYzNz?=
 =?utf-8?B?QUxWalc1UEtLV0pNUzRnSnBsRkpRbkFON2xGa1doTWV4eHJFci9VVWNNL0U3?=
 =?utf-8?B?am94bDUzUWVOKzRsdkNLc0phRGpkK0JZMFlKTW5WazVFMGVESDArWVNnNEdF?=
 =?utf-8?B?SWVNdHAyMnl3Q2ZzTGQ1SDdTRzNMbGtCcjVtZlF3cFJSWStESnJEMVcvSmx4?=
 =?utf-8?B?NE5GdUt1Zm1oTGl6dEd2YzhqQjNzTFkrdnVpUkg1dlY3VCtGK2c5SmIwMlJq?=
 =?utf-8?B?ZE9yd3JYbW9NVkxHMkk1VEJLZlh2endIdHhxQnduanp3QVdDV0w1a2VlVjY2?=
 =?utf-8?B?V014SGh1cjZwdnd4UlI5Y0xMSzVDTWtCOTJMaG4zOE42YzBTMy81Q1F0K2pD?=
 =?utf-8?B?cnBQVUJxRmhnRmdDV1JCWkVMWTgrd1dJRTNmNU51VUZqNHQ1bFhWekpCenpK?=
 =?utf-8?B?aXBNbVQxQWVia2tKUWNkZ1RReXRYTGZjZWNVLzRlbitOY24ybHVMSXZmRmpK?=
 =?utf-8?B?anV0Q3JSenVPd2RaMS9aeXN3UGk3d2YwTXVnZzlQQkdhaSs5N1F3aE92cUdp?=
 =?utf-8?B?cVZuSFJCMVZzMlVrSGFDazM4RmV2cnRxSzdvNC92N2dFdy9rTzZpcmVkc1o2?=
 =?utf-8?B?Tng5UC81TVVURHlMeGRmTm9TdnBacklLVG5JbWptVzFsc1Z1aVRIaGk0WjhO?=
 =?utf-8?B?ZzdSbjIwN2l6bUhjdTVnNUlaaVJqc3RqcWx0enBpQzVodFl1L2hTajBMeHIv?=
 =?utf-8?B?MUdmU3lHc3Q0WTVHTldDc01LWHJ2MzBjTldvNm9RMHgzVHZvLzJFZXkyYWhE?=
 =?utf-8?B?d084NlpzWVpZZURpRGlreE1XTTNzZ0FjejJmWHp2ZEJyNFFTUURBMU5yaDVU?=
 =?utf-8?B?STRMZDhGSml3R2p6VXdDSGM3VEpPdzUwMjRUUnlLWHkxaDNYNXZveHFWR1Uz?=
 =?utf-8?B?TzF0cHg5bWlnd08ybGhVQXRVdXMrQUdldXhFL094eXRqQ2NlQ1Z3NFZ2Qkhq?=
 =?utf-8?B?b1JienQraVc0TFgvTXI2aFJydlZ0T3NsV3BrbGJMODdmZFJIYldOSTBJWkZz?=
 =?utf-8?B?cW5Cdm5RSDBCZ0JMa0hiekIrQmErOVQ3NlNyL1ArTzRjelE0eUtCVGVqWjUw?=
 =?utf-8?B?Q2tQZi9zNFBUQmw0ejVHQjFFcGRNTUNpaHZqSXZtdXVDU0oxR3B6UnFRSGNo?=
 =?utf-8?B?b1YyNmFqaXp5QTVCcVdmZkRwSFVrVHE2eUk2ZG9tdjZjcGFDbHJyS0xnVzAy?=
 =?utf-8?B?L1V0Tk5MdkJRcVJwM09iSVZWdEZSSHpzK3FnWlNnTWJUR1dwR3AwV3JMM2xn?=
 =?utf-8?Q?T90XIw31rnP9k0L3Sd9aiCiIS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HXBRPpL5KXZOd0LH5a3ACfTYfnCBlpLfBdKiNYbcE22UAdh1dd7vPKUkt4ldKtHtn42s+0nntueKAJYoEufPpAEpdQ93MtB8cylRt+OnqvPTTX/gPODNypoakZsPnH9UkVy2e03Lqj8w+bOfMvCSXP7+BKFBgIeG7ZEG84RDwhBbWPm/NPuzCxYsqG6RVffcOcHusBIC6vkNaDkgvG717kENL1SQ1CEF5/9CY9S7zrCYpweiKbqdIp1nNmNvi5hKH/ku304nCV60nd79asjSmhaOt6ntrc7QTTzABBI5uA4B2+oigmpRKn5fav6TmW10wmHi6+d2uh+OQrdZkzGpLmDDopMfLkQGZ4jazz59gW+eP2Zd/u/hxcXULU5bYHy5ZcdGKdpEtTKOUG68dY4vsy9ui6MgN7MSVhUlXuG/fsZY7nLgAmNZakBrYBY41Vx14Rl8SkcAlavi4WJdYezfk7FSsnVJX0hkbGfEn4BvG1KSc+h6HrjOU4RyL+VPBOv91PTd1owEfn9mgUsOznQBTXiZrEjsZ4OXKPgk2whS0okBkst63jtvNnjrqDp/2EREcv1kBa6ooApSV8Kw9fwiSTlSW6q8TYE+jndAm/wWFME5rjoID4v+nVj0KkqYBnV9PgJA/8p2AQ9ucu36U8P85+h0KYRTQCfjCEV3TqUvTnBZQqs/eutkD3cpMFVX5q8TxcqIFGZw809XClo52hToQj5VqueoidOIySw9mc1ddK193nj1wGcGqhLev7RM6/sU6gBer7slfB7yCuYz6sMXEjds8mD1Y6nh46v2M3UNAe8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 750501f1-b1b1-4f30-4d13-08db6a6aa5e3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2023 10:57:28.9244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aa0UMw9Z69cKWDISYYoWf0Q5KVYRrDzMRnqpDxYzBCwl1ewIawmNoKGEmDHL+hrDMV069ulIlhMFMZGS29hCHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6301
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-11_07,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=930 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306110099
X-Proofpoint-GUID: s59JHy09iCAVH4NWrl9h_FqC9c1-xUan
X-Proofpoint-ORIG-GUID: s59JHy09iCAVH4NWrl9h_FqC9c1-xUan
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


>> struct open_ctree_args {
>>          const char *filename;
>>          u64 sb_bytenr;
>>          u64 root_tree_bytenr;
>>          u64 chunk_tree_bytenr;
>>          unsigned flags;
>> };
> 
> OK, then you may want to also rename @ocf to @oca.
> 

Will do.

> And since we're already here, removing @open_ctree_flags also makes
> sense, as we can directly use oca.flags.

Included in the next reroll.

Thanks,

