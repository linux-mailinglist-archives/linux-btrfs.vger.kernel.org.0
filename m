Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9739C6C3225
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 14:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjCUNAS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 09:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjCUNAQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 09:00:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7371D936
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 06:00:15 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32LBiKZD009110;
        Tue, 21 Mar 2023 13:00:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=W9FWbVEHxfw4pX5PYev8pdRrxGELcXBYdwLGO8Q1wCNk6CfbIw2EE/q96+7q8qmAjje8
 ZolqRYAcBSr/l8xjtloCDlYzgsMiXfhVK3Wh8kvsip9VsqHoW7P50C8OakPNPttbBvXm
 BKhDgS/9Httsp42i9Og9hT9eoITINiA1HrmkDfLM0qUEkDgLqcNwzmFnExsrI5bFJyxT
 0/Fe1r187rlWkXLQ2aoGBSds4HGiuJKPRpTN0SoFte1OaOnTOYfFrgRw2RYdWsllaLdL
 KrR1BS9EwU3B4KuBZ2PWkPTaRJAu/6boSxHbSV5/X76YZr+LiH6BOiXjQW7o0jUw0WCw rg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd47tp6f7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 13:00:12 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32LBalPQ038639;
        Tue, 21 Mar 2023 13:00:11 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pd3rd6269-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 13:00:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dqacw/Q21Dxp7bLlmA2jslGDwkXvEOzHC6U82+Weje5CN6/SvWxB4m2ei3kgVKFyGsqhCkK4cDQpbWN8x5X9EimlrfUN0caqWbffmb8zCCFcPXJMEsebl6hPctpMt8E0jLpCXT/hGQyh1vhZzsc76y4HKlLT8rAlNx6nxC9w9aJk7ozk520jNq/rzqwVU6kDXbaUJVtL85fIJHGkoTWNzd/+xSdx2Xc0L/b9domvssGspFO0yNzN42PkCUjDEo5RS/cVFjHeaPp1KQG/9dlz7Vl4Q0Ghzu0cMdW9KFGfQI/eXuSQOu9cwKauxpqNNT/Jiyb76Bz5//+WfuE2sbmidw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=aCQ+wKeDwx3MxAu/bWWsmU2+tncIayMzJGWMb0ztZCpFVeromMarPvI/cLCwgsPL2tlcD9ddG/u0S9sAJmGMdlR/bf9zrlv6KazEKZe8KLHBhugrL3y614alJ3/mFjR6KYWdeEqH9ZaN/whqNLrz40kJVhPKIdAxt+M8ANa5clVtmafsfuJbe1MqRYLgzo1b6ahhxQtv1sblwRYWnxs0g+xQ2v/avT8qrT0LDDdp8QHBZdtn0syC9SRkEey1KVDLK+35Mg8ix33BXGvny/Jay+IKuVSyUPK007sEW47CKZo5x8V19XKHHsJ4RqeejEXDTVnPPv+j6mp6qQyCSdWoQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=au9or9I0iZeODACnAX9HZYN7bN6ixY9hFEKtQtcYEL95FMdiwK5wTrUJorOcVltwmuo8BvulC8GSBOaBRAkpVDp+atXrAshWVvhDXXaFpHyh1np3he20YWhUKUgeTzu7Sw5hkx9+rsADDhC5gFFQhgf3jhvq5ZXNOYvjLat2W7k=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH2PR10MB4279.namprd10.prod.outlook.com (2603:10b6:610:a8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 13:00:09 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%4]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 13:00:08 +0000
Message-ID: <c566783b-8886-dcf3-27a7-8b527a940045@oracle.com>
Date:   Tue, 21 Mar 2023 21:00:01 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 08/24] btrfs: collapse should_end_transaction() into
 btrfs_should_end_transaction()
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1679326426.git.fdmanana@suse.com>
 <620d28d3978808483b962fc0024dda3600d45cb5.1679326431.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <620d28d3978808483b962fc0024dda3600d45cb5.1679326431.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::32)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH2PR10MB4279:EE_
X-MS-Office365-Filtering-Correlation-Id: 971625b8-2688-4f16-db6b-08db2a0c32c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FnbDuIOFCWb4g4i2BiPffaRw38AI12a74s7+RS08DentG1il9HvoeuUMMVFgO00Ko71qtx01954EkeZrxHXhw3IPzdEtbIU5dNRQa916B034OiOHhA44Jp4w5X3aDAOog0NAm0v2c0h5667zlvWnLsjbGE+5DJXsMNdEZsKzDrsTnV9/W/wKzkYa1VMeoQa+wkRN+aZSmuqCDPCn9HS2F7LCTrUjVAXdg51Rx/MpkYx30jQUctljwKyGk6efJw4X52QtkyfVfzEXgZTGfvWQ3najpk6e9gwSag8MDHYhJ7dmMYeYpUmChHvSGEdE5k9h7RQiaxC6GAo8AuXUYglVFegQ42WPngmFEtq5FZ1Ta0Jsq2xSQM/M9qyfcWcPcjyEC05snor2aq42eXfb4o7QelGoHAIO7lIiqPTEnIKXKTXIrPcPk3/0tTBQ7fxvr7oZOXr1hbXAEq9KnuD5YbbZUGrEb8epfv1GEQwSMizxQTjSFCxvJjdOHkU5uCSLDTa/Gr63YknjXt1L0Dn3uPfDdFtLtddV/79LEbGJ60RuXbK4th1r2lSxsiOEfCDwDUc6UZRSQXq8OXmlvQsMThacpE+kmxTEwWwYYe0N4JlLw10VMSAHTJ+C+ZqDnYK4vDjDeTbfULr/+olQQ7/6KReGCqu1NtJZ2aUsJcMxrIWr9rB2FQkE8zdic/p9z1MxwG8tdFx75pmHRVJ6FLS340WyhHeGsuN76e6qrMho1FKU5VA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(39860400002)(346002)(136003)(366004)(451199018)(38100700002)(19618925003)(31696002)(558084003)(8676002)(316002)(44832011)(66946007)(66476007)(36756003)(66556008)(8936002)(5660300002)(41300700001)(2906002)(478600001)(86362001)(6666004)(4270600006)(2616005)(31686004)(6506007)(26005)(186003)(6512007)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjFxdE0rZ0VpQ0tCMUdUY25QMjBEYlRZcDVXMHM5M01hTEZyYnh0aVBDbDd2?=
 =?utf-8?B?SmY5aGoyZlFnM1UyWGZxRlNDVlRKVjV3c1lDZTZnWDVZSmt0bzlhN0RyR1FH?=
 =?utf-8?B?YWZRUnZlaW8xRkFEeFpOSlJqYmVvRStEV3ppTk85N2pDU3BEamlqcnJEbVpH?=
 =?utf-8?B?NElIYlR6dGVYblVueksxV3kzVFVaOUw3dkVaMmoyWUQzanEzZEE3ZDFqYVBW?=
 =?utf-8?B?enpENHBTTGZySmJsQUVpUUt3ZWVibzhQWXNMYk9ZWk42V1ZzWXhyMjF6Y1Zm?=
 =?utf-8?B?amprVmczN09TVzcvZUVuRG5SYkJnMjBBR1hacUVLS3IzQnhmZlR0MWpPV0lL?=
 =?utf-8?B?TTNXMzdXSVZPSnYyeUZtbjBaejhoRUFSdzc5SU9FSk9yZk1jcTZjZ01TQnpB?=
 =?utf-8?B?NlRLNzVnWXlCdVkyckpYenAzelg3cU84T3Uxb1lWNTZncjc1ZGlGUFQyLzJw?=
 =?utf-8?B?QndQUE40R2hhR0NISVowZEFqRC80UUc3ZUk3a0FpUEYxNzNRdndVQ3grOVV3?=
 =?utf-8?B?OXdka0xtV2hSNzRRQ0JSVWlqTWpkMmJmMy9GWTFjVmlCU2I5OEFCV0JqWmFp?=
 =?utf-8?B?bjZxRWY1QXRtREtzYTV3Wk1XbUw1a3pKVk1jWG9IYSs0S3RkS05PZ010QkJ5?=
 =?utf-8?B?aFo5L2RJWnVuOFVPd3dNbUZpeGtZbDRxTDdGY3hJWEdabWxNc21XTzA1QUtn?=
 =?utf-8?B?K3Brem0waWE2cUZzdEtKRExjMzJmQ0k3R09SQkh3V000Tld4L3NPd1hvRHhr?=
 =?utf-8?B?cjhYdEhadEJFNG90SFdXTEVtSzNiZWo3SW9EWWlvTUNuVUh2UCtYcmRQNFJ0?=
 =?utf-8?B?cUFteklUajlvQzQvVEloSFVEcEtjdCtveXY2THR2OCtpWE1YY3N4WC94OTJ2?=
 =?utf-8?B?V3BQcktqNlA5bkg1NjBnbzFjOWxRclpKTGdCQ3VtcGlqK2haYi9nYXpZcWZn?=
 =?utf-8?B?N3BXeitmTFFFeGRpdkVlMmhVa21VL2FlTjAwMTFTbHBPSDBXTDNBMFpDbTRS?=
 =?utf-8?B?bFMwa1lyVjdFaEdSTUZKYnZPWTlzNUxIK1h4QjRscFVaTVRhUC9LWU1OWTlI?=
 =?utf-8?B?MGdjdVB4WTJNZTkyRGNUeStnbzBmVDd6NGs3R0x0M3NZQWQ2V2ZxZVRUSHpR?=
 =?utf-8?B?U0RRWnlBdGxsZWtkRkVKVHZXcUJyU0c0SEE2N05QeFhDanpheVExaGg1ekpX?=
 =?utf-8?B?bkY5YjF6Mkx2aGJrZVIxT1NWeTBpWTEwQ2Q3QUpoK1p4NmxKZVpwY3QzbmVa?=
 =?utf-8?B?Snp5M0JBcDB0ZEdZZDFCN0JObWthUHdEUTVRTVpyUjV2a1lGeWJsMU1XN2tx?=
 =?utf-8?B?OTFwVmxPU3pzbDA1eEV2YU9RTGJXbHV5K1M3ZXJWUWlDZG50bHcrcGxHVU5q?=
 =?utf-8?B?OWZuR3huNWFWSW94T0RPNkJmV3lxTmpsOHN2Y3pMbEkwRG5MU1JsYVdxTXAr?=
 =?utf-8?B?dlA3bEMvRWJIYkw5TzdXc09DZ2puYllEckY3OHRoeXdJQ2FuQTVPSG5XcUVY?=
 =?utf-8?B?U01kbndiaFRaelBkbXpRSjJkN0VEbTMrc3dEMUpFUkREUS9hdktqV2VxZmxY?=
 =?utf-8?B?ZVVUUzhVSGZ4VkJqYjVZc2JSQmh0SnppTjlRTkYwWWVRYjhPRk54VzRadXZj?=
 =?utf-8?B?U0FjMS96d3F0bnd0Z2dNd2hrS01FU1ZwVTVld0FWano4SG96c2d4a1oraWNZ?=
 =?utf-8?B?SDltMmxRV1B3cVNQMFVza2N1cDd6TFdSdXlwZGQydE5oU1p0V1ZVcTVOcUt2?=
 =?utf-8?B?RFBkMmNIQnk5ZTZVTVpkekh0cEgrSTJnWERyMGMrQkJUeW9Ga1dLbWVHWStW?=
 =?utf-8?B?YStOcTF1NGIzeXJPclcvelVTVmQvaXZDcE9vVW1HcDkzMmx5TExyUDdkT2Yy?=
 =?utf-8?B?ZkVKQmRwZVMyQXh2a2dRa2JDSzZpN0Q3dXA5aXIxbUYyTjNRNGpjNjY5SXEw?=
 =?utf-8?B?eWdnRHZRT0dEZDZtbmdtNm56WWg5VmdGZk5qSzF6Mm9kVlNQS1RBK0x6aHZv?=
 =?utf-8?B?SGlNdHdjOGJXdU9NQWw5Mk5mTU5vL2p4OWlGR21JVUpOaXU3RGxoL0d3MDkz?=
 =?utf-8?B?V2RVSVBYZjFySCtzMmpmQ1lJbm0yajFzRVhlN1VjVHRqSTkrZEFuZ1M0QjBC?=
 =?utf-8?B?R2dHNlRoTTVVRUthTlFTQmdKYXdPcmhlNjNNd1ZKVFFOVDVaNEZvZEE1MHVF?=
 =?utf-8?B?dnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lmhRMG6OSNumDKbetrGKcpQpp4qewkc5DvFdQSdkD5fzFNh296tmhId3c++q9YUz6X86J2IieNrtAZfYYLTJiUQuiwNSJXkI3d8VgkfXmEpuEWgkPq4B7hD2Mk7WPf+pbQF4QqYstD+DeVUoLGlv+zr6AQGvIBiaRDmIg9DCGvrPThIAy21HrBfo7BI/QwYMrE2h2Hd904GLAiN4jSETQJcQgzaiJirm8lCLs47pbK/8CEHlLeJEwKiqv57ftRyznZj9qsnFbrFMY7q7ts4WYRGGmogb4O/WdQJGw4PXAqoXdkOZJJeT32gSvNUDbIh6QQADkvbNHldS1rjw8XEiycUQPK8cJes14qtqp4ws1gjddprZGPuC/BB41faXEXLUZRQ4MkIk6Thp5a+Ijcbypr0O+nmZOWBA3VqD93/M2yl+phwBfGQHwZ0tFtlrF591WE5VhVWrRU6jrRAU4itN1ziSOWePHN9rqra0BcpbzkUgETUMgu8BtjhavE0pWbwTo9+nfi7Gh549NsK9HVU2pydldEI0YTU3PuPi8g9hD5ITOOqDgY+tKdgwKkIFD1fQmQsqmkKfwrWf6/S/LinrJobr/ou41XCV8/gcixHZL7Svv9aczZPNqwXfWS7XDkVhnU5xya+MxWO1SZLxkqVxJFBHXRe21s8rcn9Dtleo+qldAHyEMs6KMvzVsM6V3+fUqfVaMw9y/k/Km9yuvCj9YuTZDWHtZo4VhrZwHR+dKBEhJg2i3Pw3h3S1tMvEFtlKCDDSR/48bRLMeaf5AhI8wszuKHAridnoSArkk9/jFTs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 971625b8-2688-4f16-db6b-08db2a0c32c2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 13:00:08.7348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SACdI0lXWtYwWTbjMp1RbLmiezCIAzYIyEgwkJxW9irrvXLevLZcBdQPF1gs478Dk/fS6lPmauz2vJ+wJlcbnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4279
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_08,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303210102
X-Proofpoint-GUID: O1mrrxiyobmU3yYr2_C5IqyBIY2cDsKU
X-Proofpoint-ORIG-GUID: O1mrrxiyobmU3yYr2_C5IqyBIY2cDsKU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,TVD_SPACE_RATIO autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

LGTM

Reviewed-by: Anand Jain <anand.jain@oracle.com>
