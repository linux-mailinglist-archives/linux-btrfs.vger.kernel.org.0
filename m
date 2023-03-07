Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FC06AD433
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Mar 2023 02:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjCGBpQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Mar 2023 20:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCGBpO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Mar 2023 20:45:14 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290396923E;
        Mon,  6 Mar 2023 17:44:52 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326Nwrcl024446;
        Tue, 7 Mar 2023 01:44:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=uP4gtgwgItBGunbtu3MW+rVlc7HejPFHSqhSi2Q9iGA=;
 b=mBoMM6LBRyeULgBYEjIkaCDRdHHyduhdNKs2nMfPiSKz7qSZtQebOx0/XeYWzPDMyKaM
 P7JQyP9Rcy/qGRIWps1GEPETUXMJexOc7jtRO1lYYFRd8R36SAfu4ZOoeKs4+7u3zC17
 RsGgMNzkX6rVrZxvfZWSE1SajM6BBbf5ElIcAjRbY+uQb5OEKtdCy2zQIjBbSXe/8aqj
 FYNDaBuXLT3Z+k6S9rjtF+4YawBB/khLpQxytmpv/U/PKf+YzMgRTBJSCFFryBjB7Hph
 Gwi0Wj26QeFjSe/c8Qwvc22Q0lgtiyU67RcBr7O4A7dYl9s/pB3Kaqs0yuPF/5r7+zsp FA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p416wmee9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 01:44:46 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 326NZiA0029277;
        Tue, 7 Mar 2023 01:44:45 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p4u1eb8ky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 01:44:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0HP4mXx8wekR/y8YfNgybtFHSeH/8/U5xrjinWL8mCxCRE2tzthJtJQQ84k8tcVgF7pPE27YBhJDVEYGoUOyAI/sqgTCRBfPxLvO3c2MeRTFuDBKmx2ROIm+NyP1rAoaZHJYkXPZk+GwTFvJNHfVLnu8wBEfbaSWylR0Xd8ycH/ipr58LAXIHfc7XdX5mrKHeFNwkL0uhba+wnOnP/aUaI5BxEtc2/Bn0q2Snx13ylA8p9536mb0SXZQwxfdu+5YFLUjfk8BG04jK/543cZH7uYXoD/nst84K2Bf1TlB3eyamp2Zwfc+xNjRGdex2NPCh+cbo+xKShbGFtU6xhBBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uP4gtgwgItBGunbtu3MW+rVlc7HejPFHSqhSi2Q9iGA=;
 b=PUBP0nQc8UzN1sF2L/FUwbdhQnaWfE+crPe8kKXCGZ5bOP05v9hn1/eXVNbIvCa6ip85cFFLonCzQIGYasaGuk0AuMh8l7DA/ON80MUc8PPZKm1r7lVWGv7X0JAHhvE0ZEzXeufCewMpm45o9uWytdhHoOsKH9AjL2lzkH60eSggyY1EWcFK5ksMtbEzznwy8n2gpVyubdoZjc+DaCQnDY+NUQSCe1rPBbWPc6o/jTuZVliud7R8C9l0G+Tpt8iId/naHp4OCjjxxb7OQTMaa+GJmv2UAQ8h/2TyWSwVdtC0mgasmMo5ucljUjjYVtCZk+B2MWHbX51AEPprKkG94A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uP4gtgwgItBGunbtu3MW+rVlc7HejPFHSqhSi2Q9iGA=;
 b=zxppqlxGjTQ/tTEgMbDqwvmJn1E0ihO4kOWzvYkCPynu5HrlA48tUk3Luuw82LiUhnh0kIJOWZ0qRoyOchZ43neclDZlXFLok3ozQeiLEzVy1649G1rv36JeRZAtg/jldaNTPmhPz3Sc9R/lOilqccDd/Raw3n8cm2MxeoU+m6s=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB5567.namprd10.prod.outlook.com (2603:10b6:a03:3dd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.27; Tue, 7 Mar
 2023 01:44:42 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%4]) with mapi id 15.20.6156.026; Tue, 7 Mar 2023
 01:44:42 +0000
Message-ID: <85aaae82-4a67-f7d8-885b-d2fbeddcc8e7@oracle.com>
Date:   Tue, 7 Mar 2023 09:44:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3] common/rc: don't clear superblock for zoned scratch
 pools
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Zorro Lang <zlang@redhat.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        David Disseldorp <ddiss@suse.de>,
        Naohiro Aota <naohiro.aota@wdc.com>
References: <20230302100321.566715-1-johannes.thumshirn@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230302100321.566715-1-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB5567:EE_
X-MS-Office365-Filtering-Correlation-Id: d2635016-70ea-48fd-9ff9-08db1ead8590
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /EXM0adUWSgh9Dsr8yN1la+CEvIQVe7m9d3NgiQZ3isj58payuIssP1UBxHjeJqc3fu0NMnVRMRIWj7KS+GRpEJn68sD4GI+4Tv9Da5KMyGp4/MIfwlROWHHe/c1hY7mD+MVCwkjn7TmPO6uEt6TfURMxGyRy6kn1Uw82qqlENDjR8/c1Bu1W6LVmwaEDRijrZ6tS8EV7iPD8un6F5Qlu3NyPRWqwidtJpuAuo/yiSAqGSe5rBQ40iw+4hZg97Om8pGVsGPGXgLLWnlG/0vsPLsRBVCtgbLJ1JCz5eIRnvGTYvsWQb7457v8+ivSTzYIL1W+6QuuQzE2Uv8b9nPiA/T3PK0gsYePC5BltVoAwJFZ1qyTt5ojyrl9Ja28fbMdsqkC7yiAPdJUNUgOroQA5nTcV7L/qzilo/sKQZNsnl+QQqc9JQHlGnjN9gxOzPRR/PUNOSHB9zp7fyWaxmwJDCPS+gn1FAO8L4YgZpX0wogZJ25rMFrNg58KqDYm7K5HkoDX6sHnS4SYwRd2yGw5f8ZR0sTnEtf7CNNyRKj5xNUvUWfFG4qqbY145VsSTZimTkK0hXaVrdrLiJ6Gi0OtRhtFXZ79ieH7LHYxy3FD7gYu64e6grnEv6k++gRU3Oir+Yz5NDpGpavhVftbQNikmaiChfAWovKkoOip+FLUYKXJIwItZe7ZRweBu53iu80EaqvXzRn/Ih9NLtaX1L1wqw/V5whgUg3zE6IfTWgRBpc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39860400002)(366004)(396003)(376002)(346002)(451199018)(6512007)(6506007)(6486002)(53546011)(6666004)(36756003)(83380400001)(31696002)(86362001)(186003)(38100700002)(2616005)(26005)(41300700001)(66946007)(66476007)(8676002)(4326008)(2906002)(66556008)(8936002)(31686004)(44832011)(5660300002)(478600001)(316002)(110136005)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVFXL29BR3pEY2cyWk1qeVZOR3FhaFRDOHVnM256RUFFWU96aTkvTlN3SmR4?=
 =?utf-8?B?SmIwa2s5WndqRzFKUkFGNWxtdGdmck4yam9GanRNVTZnQkhwUXU5ZHZicmd6?=
 =?utf-8?B?TTh4ZmFSZS91U1N0cXhOVWYvMG8veFJjLy9XZmh6WGdkVlozb3Z1eW81YkxR?=
 =?utf-8?B?U2ZqcDAyZUp5cmRVWFQ2SkQwRk5pOTBmeC9YazMwUzlDUG4xaGlFdzE1djhq?=
 =?utf-8?B?L0x1UlpKOFZSVUxCS3pINyt3eWg3UDdwK1FlWkxVenMrTFZSK3l6RXg0YUZm?=
 =?utf-8?B?YThIamVuZ1AyaFBBQ2J1akZqV2VpNlI0WXl6NnpPS3dJMzBSeGMzS3hCNFI4?=
 =?utf-8?B?bDlhMzYrU0ZIdzFpQ2s4VDdCQ3BGS1p0Z2hjYWVrVXJzMG9SRFFicklMRC9k?=
 =?utf-8?B?Mi8yb2hQWTZmZXhlRlkwQkdRZm0rWFNEeWtuQ2tOay9sWk9zUy93RzQzeFBv?=
 =?utf-8?B?T2xTTTRnSGdRSVdjMmpXckVwL082ZmlUUXBxdEZyZTd4L1MvZ3VhTHpVZ2Ny?=
 =?utf-8?B?cHh2blc5a3FzV0tjcWFaa0pZTDJvaGlhYi9GelJHUms1RkdBSUt6K2h0by9m?=
 =?utf-8?B?QWJheCtvVzI1Sm5pQnZZakY0UUgrNkdHSlFxa0xKZFRnWTFUQUpzczdGOVdz?=
 =?utf-8?B?WFBaTnZoRjkzcEF0NlJRNVVIMnpoY1lEYTVhMHBjVkJZaVVKZUxFM090UEZU?=
 =?utf-8?B?UXhKNFZlbGJMSyt4QklKSkpvUllsaWJDRXh6OTk2UzBwY05zVGlMR0dZYm9B?=
 =?utf-8?B?Q1Jnblk4ZlAwTTc0RlNaTm1GcGRsOXA5S0ZRbktXa0ZucjNCWUhEMWdhMThN?=
 =?utf-8?B?U3g1dnZVdzA0dmxwcGtNTkxJakpEWW0xVlF4QSttVjY3Mm12aDhLSXhxYkhR?=
 =?utf-8?B?SjhXU09sdkx1WXROZ3lYOWVLWG1HRDg0cDlpZWprZytyN0twUnRnSFJsSFlM?=
 =?utf-8?B?NVZIc2xTaUNSM1ArMGROdlNrMURTNmNFU1RFYm82Y3lhNEgvZUl4c2hNTDha?=
 =?utf-8?B?bHRzMHQxYW0xMzhvQ0ZXNmlWSDIzYlZsOWFxd0x3MERhV2tXbXZtR016cmF2?=
 =?utf-8?B?SXljTE15SWlmYUZ2bVM4SThoZTBVVDJSc3B1cHRDeG1lL0VpYUgxWWpBTnQy?=
 =?utf-8?B?eHFFOGR3UVgvbEM1VzQ0K3hMUEpIeEh0RUZWdUd5NTBraVQ3R0ZudTJiMjNl?=
 =?utf-8?B?TWdQT3Q1N3dRQ1ZtREJGQlZ6Q0MwMHZTZFBkQm1EWlVNUC8vNWhJNjZuMHgv?=
 =?utf-8?B?UHk5djlCRm1VcFF4THBYbTdxdjZBMVZSUjNFSitJT3ZraU9rZmZFN0Zkc0ZF?=
 =?utf-8?B?RWpKUFAzZnlFUEtweno1Q2s5eEFoM0lpL3poaGU0bEI4cmdPNzVJc2J6ZGdM?=
 =?utf-8?B?R0ZuWm1UWkhyOHF6c3lJUEI5cCtyVmxvZ2l2amxjc0hDMm9Idk9ObnU1a2th?=
 =?utf-8?B?QThzUmxCNG9ka3BsSDlWSDdyZDZHQ09mTVhpV0pEdWxCRVNBeXFjNGxtYlpT?=
 =?utf-8?B?ZUJnUkl6S3RIZ2pEbTI2Nnd2SWxXa09oTjV1OTlJamxib3J0WDlRM1JPZmRn?=
 =?utf-8?B?UjMydENXWjNjaDR2Y3hSOFZycnVtMExTYlZBU216NFJ1cXk2OUVLcW1LOFhQ?=
 =?utf-8?B?V09UTjkwQ0NpVXpEN2xXY3ZnamRBNXZXVjFSTFFYZ0ZISFdBdXRHa1dVd2No?=
 =?utf-8?B?WUJUQ2RHZjJqNmlpcWlQV3Vxc2VUbmFhVjdMRjg1Vk5NNGw4RENJZEFDN0tC?=
 =?utf-8?B?eG10ZDdJWTNpYnVodkJxc0owWXloQ2FPQ0VrMXBCQjIrbS85ekdxR21Zb1dD?=
 =?utf-8?B?UnJNR2w4VDUrbHVEaWhBWXQ2bFlPODBxMzhnSVhYMWliL1ROa01vWHAzRW1C?=
 =?utf-8?B?TFVQd3BQcHlrZlJCbS8zYkxwRGh6T2ZETmhONkxNd2VJTUd0aC9jbWJZd3lG?=
 =?utf-8?B?T0NVcDdHUEIxSGpKVVZzNFV4K0Z0dUViS0sweGxQSGFUWFFmZEkrcE5VZE43?=
 =?utf-8?B?L2RMcy9taTlrZzlpVDRZdFc3OFhIMGhLaVBRc2R0L2hFUDJ1UjhKRkdiQVR0?=
 =?utf-8?B?NlR6d1VGTWJLZE15UVVLajNkZmNOWXNaVnk0aytFVTlITW92MjZiU1BjUW92?=
 =?utf-8?Q?verU71B8FWm8q+mRri/ii38TP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Sgj5gd6nSl0nvgtGSjzE0PMhX+TNk1403ukyh8Quy1HRXWiEuKxT0wHxLvnoCwSJG47De7Xlstig29IfV716XDniF6Q++s9XaOX4I8fKIv8O35lNUlcNfOue8+qisxl/GCG3+IZjMPOvYUMJl5aj9moujJZ6k85sBVfMbbhYWdMu5hluJiQYWswRSG6ez2PLjDMo9g19kegk+mMr6wc1t7f2XmmAGcLBdvhKDUv2ru+We20MYbqcbrKeEaCmYATA0WQSDsOmzfMjVHwO4aL4GW2qZ9lljXXM3bMcqNe0JYYQJitLfMd+439lL1KlCmn1WWt+bomhyfOpvquKG5sjae3YTsEmItskBSAQqsOYJ1pqDVGqlehTfa3Jam9a9mSR2qryjOMG5juIm7HkxOLyKUiiOr4G4mLdiZg0y/On/qfq1Tl6IOSbQ3tOjqsRMXJ/P9nboX/lqn3h4KE7HrOAflnxmY+8pmRtaDfjzFg46oDvY7Fp8S/UB9yiPX6FjoKK/9o7kNbpDkyFpgQ/AEmHmEelOxY85Vi4BycsY2HTIXNgli9GEaniEIHN0n5xFI2FWuL//ENbJburKWOIlEvihzGBc8EgcMKRquUEy800TLxaFCsXq6Uede+yPzx9AtgFwuijOsqg+sK+jPZSkNs2+nFNhQ8DkIzmNGK0E1d+85MNsFJZnHQyAyqk0WQvwTUPMnkLqQ+ZSPmKn58JZAi0Phwa9qSDcozQlyoW6tHaWJt++w56JvNb/qOfeqz2D2PLRanKjqwLjv2mBYDiqNMHJSDt1IHqZ4eiYEkSjvNSJABu9Uo/11fcYKFaFr4olf6akoXfF/jZ4Vxz/2GbrbPY3A==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2635016-70ea-48fd-9ff9-08db1ead8590
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 01:44:42.7092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bm5QYWsWaiUIt9zxR3ybiE1cF1XgPSp5wHOjQXWHwwThnSxSmFYCigzOwFILcQJI/kFxO2mZbaxyCbBPxuRn2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5567
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_14,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303070014
X-Proofpoint-GUID: a6LgIaKRv0iaBf-be7go6uLCcrqqEAeb
X-Proofpoint-ORIG-GUID: a6LgIaKRv0iaBf-be7go6uLCcrqqEAeb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 02/03/2023 18:03, Johannes Thumshirn wrote:
> _require_scratch_dev_pool() zeros the first 100 sectors of each device to
> clear eventual remains of older filesystems.
> 
> On zoned devices this won't work as a plain dd will end up creating
> unaligned write errors failing all subsequent actions on the device.
> 
> For zoned devices it is enough to simply reset the first two zones of the
> device to achieve the same result.
> 
> Reviewed-by: David Disseldorp <ddiss@suse.de>
> Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   common/rc | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 654730b21ead..dd0d17959db3 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3459,9 +3459,15 @@ _require_scratch_dev_pool()
>   		            exit 1
>   		        fi
>   		fi
> -		# to help better debug when something fails, we remove
> -		# traces of previous btrfs FS on the dev.
> -		dd if=/dev/zero of=$i bs=4096 count=100 > /dev/null 2>&1
> +		# To help better debug when something fails, we remove
> +		# traces of previous btrfs FS on the dev. For zoned devices we
> +		# can't use dd as it'll lead to unaligned writes so simply
> +		# reset the first two zones.
> +		if [ "`_zone_type "$i"`" = "none" ]; then
> +			dd if=/dev/zero of=$i bs=4096 count=100 > /dev/null 2>&1
> +		else
> +			$BLKZONE_PROG reset -c 2 $i
> +		fi
>   	done
>   }
>   

Reviewed-by: Anand Jain <anand.jain@oracle.com>


