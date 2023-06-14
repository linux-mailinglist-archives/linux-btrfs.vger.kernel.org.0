Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E31E72F526
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jun 2023 08:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241045AbjFNGrb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jun 2023 02:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242751AbjFNGr3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jun 2023 02:47:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6668610FE
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 23:47:23 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35E6k8is015557;
        Wed, 14 Jun 2023 06:47:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=zx9/09uxBbTCX6go6UeXdHjxlycz0f4FN6PGw46XXaE=;
 b=kMTfzSVPt8gcW7myzQPE6AzBZuLA2pkUJf/6XfV3uf9a6iSBWk626hNYtipm/+8tZNS3
 3qEk2usskUMGsonE5XPaP5U7XZKwf7JZKeI5gyvzYKryEvawQ6uDfOoeYKknSeAeXIvS
 iUqeq+swqFmG1Z+pNnzqzUr1BX/KjPKE46+uofA3/oKQELWbJPgvdTbUIoPC8kAm9RHb
 kufE7TymvOExi/qMb3bIBkrN/WvGpoE1rDxfY+TnKBZ5gKfhC1jy3/l/UFoVahj7w88J
 AbLA1TOBE6pPznxWx8xmW1H6ineoAd1Cwl3N9s/HCBj4XQVi2GxBlncQWytB7l8j9e5k 3g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4h2apt33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Jun 2023 06:47:20 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35E6QH7O016326;
        Wed, 14 Jun 2023 06:47:19 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm55qwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Jun 2023 06:47:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QXlVm+uUE8iAfrr+xydYGR5/T+hXqH+dnDPtbLB4fi6STCb1zdVO0jCABKRqo2Qj5XIWyj4A4PGOi2b0SxekI+tAfH5rjP5bxaMZn1Ol0UXQD3R5KCEETaGFKXHclNOTTIAyrRLe4i8zqW2HxtCIp4MYDruxaT9wz0JwxfB3Qjv6msClGzoAlVdhWdV5qbmTqh0Vf6bmGBRKsWg04vWLoowYLVdk9CYYFvRZIdn0GAVF6fAlPj5KuTQVRFMIWjF4z3/6ncwPhgxGAG7cRkxUFCw1gxBY6ks4qdaPKDNyiIPUl9ygGpe0eVDRb3k3I+D2oOZRdvsaq6NsBizKrsMuNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zx9/09uxBbTCX6go6UeXdHjxlycz0f4FN6PGw46XXaE=;
 b=Qim1/tDzS2/oY3Cxy4W/n25Z46RXMcbQIL0qXnmw3uO4HGHoMKjvqwd3QEewwLld/wVkpWxLKiwhenwU3CQIlzSbG66GhkrTpnbRRtu2w5j7HkTEBlInR1CX04wjqkeB9B8GD+OFVSIg227CAu453J+dZ1SeNkNkN4UySeFB0g6X0Ud3ka6IyYcBtBGbIhpSJriNxIsTjnROiw7Zs7c0lqOWIU6185bKB3LijnaAjRhj01sjWpSbp4Ux1okbF5Kz4Tc5zyP3+R8u6MgYRK3JOJZecrVY++qBCZUGEUesyFF0SxpMRnO83rGzWKnhuE24t0Ux+B+A6ppBNIWc69NZmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zx9/09uxBbTCX6go6UeXdHjxlycz0f4FN6PGw46XXaE=;
 b=rcq5ybNnOImVv8qCJmHBun/XU+2s8rIZTU+T7dmxq8xB+v2Qs7EYVVJWC+44/WypdILVsWJNb50jpB2DDLZhgDBXDOAPCMwGnmHs+UyR1KV4dtYVG40ksi8ihnd7h4lDZhEtmC1dy/auuxHZGPj892j9dQ3K7OivyofUHpwcDY4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Wed, 14 Jun
 2023 06:47:17 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6477.028; Wed, 14 Jun 2023
 06:47:17 +0000
Message-ID: <47c60fdb-8100-3515-a4e6-43f05699e57a@oracle.com>
Date:   Wed, 14 Jun 2023 14:47:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] btrfs: scrub: remove unused btrfs_path in
 scrub_simple_mirror()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <9a09b2850b25de2eb9142d95bcdb1b46ff0207af.1686724789.git.wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <9a09b2850b25de2eb9142d95bcdb1b46ff0207af.1686724789.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0011.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::6) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW6PR10MB7639:EE_
X-MS-Office365-Filtering-Correlation-Id: 638ff685-a81a-4ecd-69a1-08db6ca33143
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b10fHwNjhDVh3zmdNGXop+ul1mmwXWIzFlHPShB0kpLEokhhxhEe5nFqMXCpLVbtzHx4GjqX7jUnxqYn+oAv5enyJzk6NmJDEkLbltAAPKSaK0K5kp5VqUqygntCcTMwxTGGfoJjDOJM5q52rVo4gbyjmDQlSjp0mu8BDzXrKGdjRRO9SeAXwyZe25qAVdgITGdqhQToAmDC58zqw6sDyOmnbCIeFBcdbt3uuDDabCdJP1bQNhbVBHg5LkzS41KMwGXcJxUygEU0Poy21KPQDZbx6OX+AqT4HH0FqrL2zZbaO1itLanvZok+Swj5kmJqpF7NTNNvTxR3isLEtmeU9meP9Ss/7ylZwcAWnwFnATd2Rla0YaLVy7D1uf3blCzHRbcPW7XR5aJWmCrwZxdV+H99IWuDud/eI6C845IGL7lRYDDXAsfyDHAtsOZvnra4nxjP3mtyih6TxrmslXuGlHSf867QTLyftd79hWxa/NwQvjKJc/CQBqJWe4ddHV7FkBIWHvG9wIrk99itkMQLWf8EgKFVUQdp2MM73x+YsNOqBVhh0+IkFICdIz3ltsLSi5Csfd+CJCDNfEOb2GEJ9RRP/YQnpcjT+NNT83pWmh46iVWTunhSWmDUpp2zlCQryWsRECLztU3pDImcq+BNUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(366004)(346002)(396003)(376002)(451199021)(38100700002)(6506007)(186003)(26005)(6512007)(2616005)(36756003)(86362001)(31696002)(558084003)(4270600006)(19618925003)(478600001)(8936002)(8676002)(66476007)(2906002)(66946007)(66556008)(44832011)(5660300002)(41300700001)(316002)(6486002)(6666004)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bm5jTjZycXMvWGNNblRxWFEvaEpPbFIyTnVCeWZWbjZ6VmEvNHROUktwN3Qw?=
 =?utf-8?B?Qks2bUo0Ry84Mk9DdDdpd2E4aDgyQVVMU0k0MHlKRzdTTDU2NHBUaGNWMlhV?=
 =?utf-8?B?UjFKVHdUNXNtSXdJWXQrNEpRS3AzK0RCc0JqTlBsdFdseVBqUFNqcm1zamJu?=
 =?utf-8?B?VHpXeUdLNGlidFhKRHQ4cnJ3MlFaZUQ0ZC9HekNJVWxES0lVQWdtVVY4NFF0?=
 =?utf-8?B?bFIwOHJ0VFk1ZUdsajlVZForTFhhaTZZMUZNZ1d4aDVDQXJ2UFhEdXFyOE5K?=
 =?utf-8?B?VDVkVURDR3lkR0VhQ1pIL2dndTRpWW11VENXRkdpYU13UTlBN0V5WFNTam0y?=
 =?utf-8?B?OENCOVBXMlV0blgxSloxa3pySWwwNm9HcUp0Y0w1cDh1SjB0cEVBTzBrdTJm?=
 =?utf-8?B?U0JyTGdtZEdBZEdFZnZWU1J0SHJVSDVQK3dBanFHL29rR0RVZW5aYklFZTIv?=
 =?utf-8?B?blBYRjNQZ0V5dXZmOTcydUNLWi8wTHdyeEV1WXpsOWhEVTUybnQ3NGVqRVdV?=
 =?utf-8?B?a1cxbnI0Y1prcEJNN1doMzc1UWh5V2I1Y0dQZ2N3eC8zQit0V292ajZMLzg5?=
 =?utf-8?B?eFNSU21LcEs4TTVnMGFuaVBJY2Q2bDNSZ3dyT2xudnFKQVBubWFGM0xpN0NF?=
 =?utf-8?B?cm5CU2ZwN3pBOWdFejdTYkRFQWlLNm9kV0hWLzNQOUVabEU1eUpkTS96V0lI?=
 =?utf-8?B?Y05WMmMvSC9qYjRlcFdtZVQ5aEwrWVJwd0xpY3V0MHJCb2NCbFljTUNNSEJV?=
 =?utf-8?B?aGZLdTFkZldIZnAxZkl5WmVBQ3g2amRHSW1TM2dvOW92VFZVbkpJQ3lqMkVV?=
 =?utf-8?B?TlZPczRMelMwbDR5RVJIMjJoMmR5bkdtcmxKMlg2b2Fza28wemdEWnpocUZO?=
 =?utf-8?B?VW9TZ0p5RENORTNPNSs4THJUQUlldUJ2VHBTSGdta2NaRHhvZnN2Y3dnazNM?=
 =?utf-8?B?MHNITDQ3ZlUxU00yR0wxeklQK0pHbnE4TkVqc1MwV0ppZWtMNlV0eVB2NFln?=
 =?utf-8?B?TzZzOTR1dEY3ckRza0FtS01JM3FKRUdQbFRyZEsram9IajdBeTArZDBVYTBT?=
 =?utf-8?B?UU1nSStDM2RHRHBtd3paTml4eDJjamk2RG1hUXdqckF4ZWRLeEFFWHczdm5o?=
 =?utf-8?B?eHY5WlQyR2JXSllXWXYrU20zSHB0bFMwbmduVWhjbEp2ZHdLNTcxL0NzTERr?=
 =?utf-8?B?c3BDaXEzOFNKbURiTnIzWWkrV1kxQnRiQ25wK2UzK3VoY1VncFliMmtOTTc0?=
 =?utf-8?B?WDdXYU1hdWRvUjRIRU9jTTNpejI5bDlJNHBZalNldGI3K2Z6enpqWFcxSzZC?=
 =?utf-8?B?cFlEdVVhTVVaa3NuN3FnWDR3YW5sUTJYdkZ1QVlxaCtSN2gvQm5GaG12Uytl?=
 =?utf-8?B?Zy92dDQxNjV0c203Z0Qwdk1xZDVDK2FsZldsb0VVWjd6TnRhREt3alZmTjZR?=
 =?utf-8?B?bHU0UzhiUmhUWWFyd2VwOFduam1pWit3SzBkUGFUdzFNakNRSlVNYUViRmJ6?=
 =?utf-8?B?OFpBNTdlM2dGWjlad1JMcHZqNmpxeEg5MUh6ZnpOOGFSUE10cGZ2MTdkb1Ra?=
 =?utf-8?B?TnJIdkd1MERoeWVIZEtJSUpFUmtiV29RaGtLSmQ1NGl2STY4a09maDBEc2lz?=
 =?utf-8?B?NnZvV0FGcGU1TTc1dTlQZTRHcnYxVzhZM1g1aE5mL1hvUndiU3FYZVJManFL?=
 =?utf-8?B?YzJuQk9RMkI2dTNtZ00rY1locXFEellBVXVQZHlBbDMrYTdsb2I1MGMxOUpS?=
 =?utf-8?B?emgyMUp2YTh0dUV6RkxBWjN1RHJrR2xpWTkzVFRCRTNpSGF1enMzZEU0WTha?=
 =?utf-8?B?UlNUaEpIc2RnSmdnOGk2RW02VWRBMGExd3pncHdoVEcrL0VwbmFyZ3dyL0xx?=
 =?utf-8?B?Y2JnWUxDY0JtVXJ6VGZzSExHYTV5Q3dVUGxoUWdwdzBTQUpTZHVkd0N0QnlV?=
 =?utf-8?B?ekFxbXBNaWV4R1Z6OXhTQ01rZVM1dTU3ek1JcjJvbVoyRGJjRXdMbmtwK3pZ?=
 =?utf-8?B?QmxpY2JLVm5Ganpsd1llVGM3OElJcmtYSmFlb2FBS1RMeDlWV2lFaGNiS1FU?=
 =?utf-8?B?cUxHc1lNOVUrZ0ZCcU1Bd0xoMXc5Sm1oUlgyL05TN0FxVElKRGdWWS9oZ1pD?=
 =?utf-8?B?aUo3MldEOTFrWTNONERMazhtOVR2bjVuZGhTMXVNWFlRUnJzdnZzaVFnZlZi?=
 =?utf-8?B?L3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eCRrutBFTLZ5J32Conv6ZYwc2EBifuwivEl+2fymDOjaiK2HUl1tUe66rrv5cpGU/JAerBvjC0k5u5t+v/syEvleIviMTJbVIyhKdXWKLHNKV4t13DT51rEDab2/J1IgUHRh18ueY2BbhyzQJkmTicBOvL38EMQEygQwG1htjuY8n/uV8Is23oliVX3QQ0GUmZFLLOKkbsS0FRHNJ+LRCpAVKwC0RcY+01mESibu2tZBFXy2gFUJwPQhve5WGpN2jOtrL/zcyQfxVvqqMWcHrqZF8KyMALqFQa1Nh83RHuM5vfh8Oc9gvicxlfaGhZD2zQfMXUp/6rB8HI9R9nqBKL+gAwiFQudIxKAZjma2TCzxq0+jR2TxXC0DDFL8MqNyzGjpEVpk5H8nhivm+fwxcb+bazog8C+o/9NvA7i3qFzNKEJpQDsmXnzFdN79qiRZrGkfG7/+DhMhkhTEeFgOo6pRQB+WehH39YRFaaobXjUkG94IwatnW3sT/pCWjcx17/4xpxkrPJ4rTbnB+cjgN5XpwEXbfsDZSqDIpj4uSsjS++Hx7ptvFUwtnTauRLYCBCiOwIj26HybqdhJFDLFCtjt+AoujtVvcipGDylPGiiBiIDsKCIQdcNbQnoazGHvmpW018jba6XCXi2CyQAe5ccEFfSyiPJDGnjb7yd1Izp+NpXSo1U4lNlYRAKyhjiRg843hfc81WIU+FMkWBhTeqAMJy/52AYYFeaPfm75nvG+Sli5IeAY8Ed1LfXlvsCXpxOBjkuWdTSl5e/R6ogjLgZX2E3QrP0JWwVUHrQxhmc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 638ff685-a81a-4ecd-69a1-08db6ca33143
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 06:47:16.9930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: shmFubIYQesDvaFYq7xvA7+20cAUI9isxj1iQuC4Oro4dgEwgoni+vVjKJyKd0u/IwVYlluwwWbyM1RcG0zbHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7639
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_04,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306140058
X-Proofpoint-ORIG-GUID: oGuYk9CSfvk72KHw5FC5I2H97t6kLzTp
X-Proofpoint-GUID: oGuYk9CSfvk72KHw5FC5I2H97t6kLzTp
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Reviewed-by: Anand Jain <anand.jain@oracle.com>
