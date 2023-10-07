Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C210C7BC6C9
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Oct 2023 12:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343799AbjJGKb3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 7 Oct 2023 06:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343765AbjJGKb2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 7 Oct 2023 06:31:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18E193
        for <linux-btrfs@vger.kernel.org>; Sat,  7 Oct 2023 03:31:25 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3975FfbQ032178;
        Sat, 7 Oct 2023 10:31:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=wqpE7wIN1+6ZEtZf65xx6xwfGSSkmvobOnqnYej+I+8=;
 b=fkeEG8+y0LR1RJaKdCmriUPAHTkamuh9+9cTnI97TMxcXxZdGevh3MPj2jwVcMzsZv6G
 /doOm4/2imgXxHgbN0UOECIFQGIq8tA0E54CjZsitvsrQ6jpFbxwi5M2nYPzb2KSdd0E
 u77p7Yg2qQylsoxaqwldVeF196mSSFXt6XzfeXxOZe43eTgoRq0U3aATuyBEG6EIMg5H
 NaUUMqJM24SgVeraLtvVhT8rueam384onGEy1mW/qasuJAIQJr77YYoPIW0aO55OOJBJ
 i25VQaHmUmR+VMDzpsi7aOX1pNNLroGv0cFot/WWeAEtPpafEi3byOS7hC9j29gaX7sj Ew== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjwre0f50-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Oct 2023 10:31:12 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 397ALHOS006971;
        Sat, 7 Oct 2023 10:31:12 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tjws2ahhs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Oct 2023 10:31:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RA7WhSkTjiS/WucP6USUegLeVs3C6tj11Tru8c5lK70tbVCU4iQts7vbmRcLNRexu4WYqw2qCBLPLeJ2wUkA04XjCalPlwgK+gkpkPWz6qsEgxlONwg+MbQ3P0OFWkuRpsbxwOqBKx6Yi6k1mTAHq8DOlzBby8Qr2ot/eqNYzv6wsw1Zo7yRssPTXNNWVbkRgv/EDRtys3fwdMjSFeX3CvfOqEd+Vd46WKn8PTpb/0XvMPBt+jnGj+6A81jV8VqGSJ27M0+tdaROw5uK34z9lNAP3KoaOCZTLge1QB+VbNzots9QsFLqQ1DfWEUE9C7qxHTtc++OI0ifHdJDujySFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqpE7wIN1+6ZEtZf65xx6xwfGSSkmvobOnqnYej+I+8=;
 b=SnwL2rNPZqCKcuzm67iXZnaWve69FdA2NhfvmY9+ye2yeJ19y6305VmjyCRXBZ98E+bQpCXRPIm8QWvjtOmyeQUTFbus6FRSC4Phb8qT9mvG4jyCDMIrUVmsfnLPvojdTM1tF+YkUod8N+voi4ZN3aY/cnJay9eq+NDpiQY0IkUeASg2ioQ3LFAIifGvKQs0OhESaBtZJFL5C3rwb7u/k/sV+lKANN/qUCewmT7O5AWcBxofqvL9JFYstM0AfK9aFKccfezRs8LnrInQBWSRvzftqzvDFk4sMy4Q1FrPbji3QCryCqqBjn85Nha29ZAQaPOjqzHCw5aJY2azHD8RfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqpE7wIN1+6ZEtZf65xx6xwfGSSkmvobOnqnYej+I+8=;
 b=eEiIHWFbYYuhOmRDrmDBGGy6/Z7A3X0O58dB/SCSlM3E9grS2g642LgBKOZbw5hba1UcEHmrwLnqQhVjWaavlxLr5DMnl+Ch9UHB++oo18IH9jLdCO7nTsJXOs9UiIPyAL1AF1rKP/ldCR0EHwAs3ezrFHMDhkqMKg1cw1EyA6s=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ2PR10MB7760.namprd10.prod.outlook.com (2603:10b6:a03:574::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Sat, 7 Oct
 2023 10:31:10 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6838.033; Sat, 7 Oct 2023
 10:31:10 +0000
Message-ID: <9cfb8122-4956-4032-b9ab-2eea8bb19415@oracle.com>
Date:   Sat, 7 Oct 2023 16:00:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] btrfs: sysfs and unsupported temp-fsid features for
 clones
Content-Language: en-US
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, gpiccoli@igalia.com
References: <cover.1696431315.git.anand.jain@oracle.com>
 <20231006150755.GH28758@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20231006150755.GH28758@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXP287CA0005.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ2PR10MB7760:EE_
X-MS-Office365-Filtering-Correlation-Id: 3178bfd1-5ad9-43e8-a721-08dbc7208587
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t177yAeFvuDvEVHmWrKgdxBLA7L+48i/+vbMy8tXZqwSeLyoFixZiZN4Eqz7hYAQu1qrhaqC5QwVruKOnJE6uH6YcIlvhAiSzu7iyr9PM9gJzswNR1s23FKbYgwpwk0lIv8Ul8vPekryKLxvpjyCJuHLlATItHUA/Tj6DIyTgqa4O1kLB8S6VuIB9cYCZd5/Xt9Ph4AV8cV0oMHimAskCBOKknJ6wZgc+LjBxgWtzsMrWtCOqrg6796CGRj8jLErNGttq5c8j7VjijfqLZP5pPnxrSpFtN+lcLqeIOMF/k99Q2hDy8UmEdsLQVqncFgp+7XKP3tCDe8SGzUzgkR3QU7osxcZjXEygfqRmeCiCmB00s353VnnnuAo6NF1FC/FPEp+KB9namoGVmXgY3JAJXRnE9Xfg6pZ3OAB3BJGOYu+4KpU5myrDKrGHg6xahRIC/ZOHYeEY/0P4ZfDU5iJnOjYlrR8YfvwyTHWUHBqLn0Gex/w8iqr11p6ZtijPiJ5UcjsaD3VUy1mYcccF0sL7PBcdFD4RVpsHb2wsVamD45LoX4SNKT94AnDxv4cAD5NCaXGgMFaundsinijz2+lipWtkfJTT1sA/jpfNo/Lu6cj1WTYI8wEM6uUdj32ZU3g7TNY0bQjacIgd93wYjpaOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(376002)(366004)(346002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(31686004)(53546011)(6486002)(6512007)(6666004)(478600001)(6506007)(36756003)(86362001)(31696002)(38100700002)(2906002)(6916009)(83380400001)(2616005)(66946007)(8936002)(66476007)(316002)(66556008)(41300700001)(8676002)(44832011)(4326008)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkJmV2lkRXphUUNCSXM4TkJNelNHaCs5RWhsQ1JCemw4c0JoSHhxT0g0ck9K?=
 =?utf-8?B?T0d3ZlFMNnFiYVhOanRpR1luZU1acXpYSVh6S2swZkdSL3VEK0xTT1crbmp5?=
 =?utf-8?B?TUxIMys4Y05nclRJK3ovaWdkcHE5RXFsR2JHM1hoWncvSEgxME9qVGM4NjB2?=
 =?utf-8?B?NjdpbG5neC9BN0k5NmYxMUlkb2lTSVhjeDJzaFpjR2xBelB1RWpLMkVvRmZj?=
 =?utf-8?B?OHE2RlZWMFhkcDJLQkl2UG9kQ1JhSFZoSndkV3hXdUhMTUg0blAyanZGR2hW?=
 =?utf-8?B?KzVTNUdMMitXcm50L2lYSjBkc1NmdXpOVVliMDRrMUFOekI1V1lRalhSWHhh?=
 =?utf-8?B?VkxEVGtHRHNUeTlieUJjSUpjOGJHVy9lSjlUNFdtN1g0UUM5RCtIeCtXVWVP?=
 =?utf-8?B?OFBsVHVkU3piUHJFNmhnVzQ5MW0wUm81VENlZTdjZVljdXZoaFhqTFNlS2N2?=
 =?utf-8?B?VnlIUkh0ak1pdUNRVGlZcmFzYU9sWlJwNXVKSWtZVFprdHo1TzltbEJxdkp0?=
 =?utf-8?B?QUhYdWpSQTR1MWtzT2hIaGc1MVJ2cERkcnljOHZmTnkzbUw1VTZsV0VnMjVx?=
 =?utf-8?B?QW1zclA5b284VkpuNlFreGNJL3Zyc3ptNVBVTXNzdzJkUmxDblBLSGdDWjlt?=
 =?utf-8?B?aDR6VmRrdm4zTWR6WXZJNmxGQTZVMU5KSkJabzFWc3hBazNiMU9KU3M2dE9R?=
 =?utf-8?B?aFR5RFJURk5WeTNINk9qMnFod1pPZFBySnJHTUs5VzVZekJFZEVFQzQ1UUhV?=
 =?utf-8?B?WDY2N05aRkNmUjhtdjAzd0RJeXBEV0tLTVgrODUrR21SdFhnU0hYU2RZYWEr?=
 =?utf-8?B?TUw4aUowOEZ6TmQ0ajlzZ0xrbG9OM3RpRm02d1ZrTXVlNllYaWV3Z0Q5Zmox?=
 =?utf-8?B?UVVPNTFsa0hKZTNid0JMZFlIa3EzS21TZHRWR3FsbUNDcmJJbjhXM2NOdWJB?=
 =?utf-8?B?eHlBZDNNNTBKTGYyTTVIaEd1aXY3YytqOFh3YU91Y3Z0M0htTkpJSThMc0xU?=
 =?utf-8?B?UFJ5TjJGZFlIU1VpdmkzQndEZXdyTUVIV1l1M1Q3YktYUmNHVkw1ZkllQUIx?=
 =?utf-8?B?aW1jeW5keUtTTk1EUC9RQi9oWkJCYkJDUy9QUjBKMG96SVB0bEhNUWh2a3Fm?=
 =?utf-8?B?eTBxTnFTK0Zwd1FHVWNpZ214OUFiTEJKNzEzQ2JkZDY4T0xGWEo1eDRGQ0Q3?=
 =?utf-8?B?cXFrZHNJeEZ3ZlFuY1BWVFY4ZzlDaG81T2RmMExnRjlwVXhpTE95blRpdFRM?=
 =?utf-8?B?Vk1MNmJqMEhOQndySFdpRXpGSWRjanJDOWd2YjhtUk9kMU5MdkphbnNMWjh3?=
 =?utf-8?B?RTQxNzZ0b3haUk9rZEl1Q2lTcHVNQTZVNFR3UGYzTHRBc21kRkdlcnZXRWFk?=
 =?utf-8?B?elBPU0EyMUdYdXFkVEF3ODJoU2FaZVpWTHdUQmh3RVRjVGlLTmMyQ0lHVFFE?=
 =?utf-8?B?cTZKYnJpWUQwV2Y5cmJvK2o2Q2JYcExDV0xaVUJROXZRSzZYQ3RBSEZ6Y3BX?=
 =?utf-8?B?S3RCN0F0RDZCSldpeFV2QmsrMy8zbDNPY0ZFb1RuTFFsSVBwK216ZElPVG5W?=
 =?utf-8?B?bWE5Y3ArTURLQ0JCWlVGTG51Wm8xdFBJRDNldmZLdld0TXBlSWZ5UnRQamdu?=
 =?utf-8?B?bktib0dES2IzR2MzdzZ3Nm9vNlhNWnp4UjltdEFnVzVTRTIzMHNwYkNsdDZD?=
 =?utf-8?B?b0ZNOElzU3U5VVljUkMrdlBaRlRGREJEZzh6UGRyaHYzV3lzWXVuMDVvVU1T?=
 =?utf-8?B?QWttSG5yYnpiQk10VTZ4eU52ZDY2Z3NIWkJkQS9wakFXOVNvanlrZ3pBcTF3?=
 =?utf-8?B?T21hTXE5SDYxZnZkemFMMThQR1l3eXB4d0RpNWtEaDVHbEwrZzE2dzhNNmkr?=
 =?utf-8?B?ZkhxaTlxZUZhTXdqdVFGWU5rdVJRcUVDSkp6ZkFQakdoeGsyWTVoQjVYdVBj?=
 =?utf-8?B?L3UwYjgzYStTb1pkU1ExdzVGUGk1YmhNUFhSOFZVRVNrMWRMTjRVdndLdWli?=
 =?utf-8?B?MTFqTFJMQ1MzUUxCOWR0QzFLc3psZ1RTQUJlTE5LSmtmMXQ2TWRFcXVXMTEw?=
 =?utf-8?B?NnA0ZXZOdzRTUVJnTGJQYTZsTXZCc3hremRQMjk0M2NOOTZVbzJlNXJRNGtS?=
 =?utf-8?B?NzI4NHF5WGNVMmFJM1dxZDhmTllJblYydEZ5dDROU09WbEtUL0dTd3dWRDJa?=
 =?utf-8?Q?MO1jNYkFU0L/WvYBC3WHJQq1ivq59boaFRK0FQXnrUNE?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tLgIFQgP/MXdxGIDfcsq9iwNnBZ3XUTkNdqcmrEe7uw1vV58GzENtLpAjBlebYRFcWAB5uQB0GZ0jXrC1ARaBkxfAYHjvr1KqRyHfDrmLa2brqL5cBZMNZTxKFNi58fnhhxupVRepsZ44JeFmoOWFeWrueDNEll5Yp2SSmJRNHQRTUnF1gF+oZ01gN3XIQ93fzCcKBVjYNopjbNPKk+8ngYCT4ITC+n/UVFd+w0vNHiH8Ec/4Gg5ce6ULN7EXYf+CwFJA/+6f7ma4z1TJfh+GKg9AKVrFAu405gD89r1uZzRXP6+MlNDs21Ud0a9SuC2nfZNMLmv6IBZWVgqSByHG06G7GAbKSLa/emwo4Q1m3ZGzonOAZZLwjVaEBfekzSJ1Bt/A1IGlClYAXCXa1veINpQQkzrj+/U3XyJxahiwqxYJ0pNiMxVCkg/yNFGFptznbZTTSogzI/vZfWTzr1FIs4Vy7dvE4EG6Xms0MIO0plja1f4RMOmsORfzy3naI/l5I9/sUFT3dTBrZzDAauW0VAO+RGhuf/1ltvM25uC7uooIAFewjpyw29v4s/LbKvfGX8KoajvE7lszSJf8LQFUbsFqs7ce9Y4TzYpVFt9b9HFed0NT9IjTnkywuDPuUAMkT+SuEaN9aruqrstHeyUgI2X+9PeTaRdSvgY2So5zj9YK7BnfjMitrcn8HKnw9QzU0D/tPak8D7fBHRlymJkV336L5ENFBdm5GS75gWdX7kV5PVtDpjNdHwQTL7SW+5ffxqB6qgLbbcrzZ/KywDyyUP3MOhhUBYOY9VZ2kK0LcGXj5pewccwXaaPaRao2xXMDAsLD5Y0qylOfcAHcjlZ8A==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3178bfd1-5ad9-43e8-a721-08dbc7208587
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 10:31:10.0017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K4Ov4KrkeKh8EP3Q3TTOcIHiGF6pkMulsxtN3qRUNDQ2Bac8ZJQ+XrYibZhAEU4/PJDOuQYLjIS537jRZ5+joQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7760
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-07_07,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310070093
X-Proofpoint-GUID: pphpYHFsddYcJrmf5jfGuJDyzCJS9rmn
X-Proofpoint-ORIG-GUID: pphpYHFsddYcJrmf5jfGuJDyzCJS9rmn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10/6/23 23:07, David Sterba wrote:
> On Wed, Oct 04, 2023 at 11:00:23PM +0800, Anand Jain wrote:
>> Seed and device-add are the two features that must be unsupported
>> if a cloned device is using temp-fsid to mount, as they conflict
>> with multi-device functionality.
>>
>> Additionally, add sysfs files for the temp-fsid feature.
>>
>> Anand Jain (4):
>>    btrfs: comment for temp-fsid, fsid, and metadata_uuid
>>    btrfs: disable seed feature for temp-fsid
>>    btrfs: disable the device add feature for temp-fsid
>>    btrfs: show temp_fsid feature in sysfs
> 
> Added to misc-next, thanks. The eventual change to the sysfs file can be
> done later.
> 
> How are we going to proceed with the patch from Guilherme?

The last step is to ensure that the temp-fsid feature is restricted
with the temp-fsid superblock flag. Guilherme's patches
(kernel, mkfs, and tune) already handle it but need a rebase.
Can Guilherme send an RFC patch for feedback from others and
copy suggested-by. Because, I haven't found a compelling reason
for the restriction, except to improve the user experience.

His fstests patch will be accepted. And progressively we should
add more coverage when the fstests configuration does not include
the temp-fsid environment.

Lastly, in fact even for this patchset:

   Co-developed-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

Thanks, Anand

