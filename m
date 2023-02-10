Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08AEA691FEB
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Feb 2023 14:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbjBJNjZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Feb 2023 08:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjBJNjY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Feb 2023 08:39:24 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18231555F;
        Fri, 10 Feb 2023 05:39:23 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31AAnaxh009134;
        Fri, 10 Feb 2023 13:39:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=PuA7Jfi3Db8nM1WhYvwml0G0MHCLdz4wVkN72xxriOA=;
 b=qx4UTW0xZYuarHUwrJ8n7qNIomjyhs0KBf75kHl75HwRk79ZHmCICcy4fr5AeF2IJy42
 Bi+t3YUZK4iiPazhh5h8Mo+SeLLV283aQE393LtfpsAC+02ds07C0XGZn2ro71sKmvtQ
 3hWK/m17RUoQAZ5nYr0oeGViIUaQncwYce5PITgyA6V0MCCclYWdwte0aO3bpzNS8iUh
 4m4M2B9cBdUr0r8DbWL5PhCshQQLLh6fWhpPXOvL4y3VQbIf/zhSDVbkN7OvmYCPCv8b
 GdhX/cTlsaTnMLu7d1cRrhNLhRnuvw1VpGDCPpFCYQ50/0oSuPPMGLd7rX5VQ4HNQRJ0 Yg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nheyu5aac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 13:39:20 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31ABWHaW036112;
        Fri, 10 Feb 2023 13:39:19 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdtgkkwd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 13:39:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=en7Aow6bKHvOvIv4NUitmRo/ak1LeY1kml26pn/yKWiQhIC/PxapVC4KVvMzxZm4i0vzQVRG3nGKklXrpozMIFyXqm7PMjKB8ppvV4xb1XbwVD7e3WWa4nv8NrNyNazN0y11VWtEVD+hLjjaC67iW2E+M+erIjRqwJGpBEIsi80gmAUsExwtn5XJlpqqmJm8oLAFhn4S9DlEhbf8XmnV8008f94DgRlRQjNYzcsaV35dY40cLs38NluretB14Z2NgzmnSuC4djYvb7i1r/h/7lKq8KPUVCf+SpSSEndaYuxFm09eETfCiPvyqV13C8bP/DnOLJXShMFN96sG4SrIHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PuA7Jfi3Db8nM1WhYvwml0G0MHCLdz4wVkN72xxriOA=;
 b=KoC8UvKMI6KUG+KOz2bw8mXLAkFJW98y4Hskm3MGgTSHtEMGbGI7zYAmSSXK/miKwVI3nmcj8qMqdamtYoNCBLb13yeORstuK2/FPeP1hT+yHblhLdOgqILa09HJ64XhtSu6jiDpoiYZDEEilHrNRbMfVWI+kjTRL2aT7Vh0JiK6VjMT4WJPtuCJ5EW5Fn6I6p0lTuJXc2qfxqcFrpiGqHdThadEhb105T1y1FdubzSf+leAHSkyEXJO/VubHeHwvzyUbMEPKlbZbwI9NgeLRIIi/Pn4L6afYzL2DmHevag+t3yWTVRWQN4jxeSr3i5gFgpp4Xz3YaadYSO8HzrEDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuA7Jfi3Db8nM1WhYvwml0G0MHCLdz4wVkN72xxriOA=;
 b=X+DxTHyR9ptCJIx2gi/2BzxPrxyKdxmJj1u8seeVfqkEVl72A3LAw28YoJmB7abBV5AQBlEkmW2tfsynsnRJqL7oGAFDjdVI8Kktgb9iiWq23XKak/adBTbaTmR+8wI1AbZlS3ayHpE0Ucbg8XpuAhvxrT3xz3RNP42TQ6lRwus=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM4PR10MB6087.namprd10.prod.outlook.com (2603:10b6:8:bf::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.7; Fri, 10 Feb
 2023 13:39:18 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%9]) with mapi id 15.20.6086.011; Fri, 10 Feb 2023
 13:39:17 +0000
Message-ID: <27b36b04-44a0-6a62-8a8c-109ac7058499@oracle.com>
Date:   Fri, 10 Feb 2023 21:39:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: run more tests in the auto group
To:     Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org
References: <20230209051355.358942-1-hch@lst.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230209051355.358942-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM4PR10MB6087:EE_
X-MS-Office365-Filtering-Correlation-Id: adaa38da-5891-4a0b-9678-08db0b6c34ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8VN3KtkAUAQ0ArfJvQ/TDKmJZlFggZgrDQU414sHxj6hFOmlGR1xpF1iVK/m2tNTKHJAkc9qH85Y5XMZXaU1ABEMjbCXMRbm5nQX/c6337mle/UcePki9vZJVIBWZwPyDKoylPBQC6Mi3Hnq0bwNpDABFIiU7/R2/H6V1LT3VDdzt51GsMQrbtT5gaYKQTTSxXEBl3WtQ3wdaTavxjdYZVl69cyjjr8/oRCoZMXbfxniUCt9KE1lQK7a6ybGQoDEafAAnj+SftlQbd1q33pOJOxLnVryx0HPJuBkfo1Y8NYsG/mW2HO8W01gwW9/gUDVAJ8UejjhD+t7a1Ia0nXmHFlzwgBCoK5BQi2ZWn12+PDQSKn2TSTfWik2XOEnSy1+AGOhvhxkIHmBo8Mn/2ECCnxCrpwFGeNjbiEo8TSNt3idmtr1ViFVLxtKnSZXn8Weat/nL2KIr4qp/SqPz34S20JkFG/mTUIo3QogIU1bEo2p8Fu/i6ushnmGGqXzrzzN1XPuMn6u7rykcOdrq3DlR+rZ30QHN0VSbgYyaBzSTn42CP9hxq+VN21mh4NU9zDy5DjsVQ/SyJKWo9yp7RZJJJkH64KdL2daJjK19zIu8UhLtZi0xwcl97X56rx3EWn7CQ7UUElkV8UcdNP1xG3+XISDYQ5QaEpWPTqWLlSfk9zNSr6R3z5HnYRVo8h7oXHXGOLzLQ0AwSXkrwGCAMaD/JZbNGGkGYFBeYbemy4X8Ag=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(376002)(366004)(39860400002)(136003)(451199018)(31696002)(86362001)(36756003)(38100700002)(4326008)(26005)(186003)(8676002)(66476007)(66556008)(66946007)(6506007)(6512007)(4744005)(8936002)(5660300002)(41300700001)(6666004)(44832011)(478600001)(6486002)(316002)(2906002)(53546011)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cit1RDhMSVk0ajhhNHZSOWliY3laZ0o1TTVUN25KcmNIZC9DeTZMT05Bc1Nk?=
 =?utf-8?B?M0d5RFlrMEZFYWt1U1MvM1F1NlVKbEhZczNSajJxVUZzOGJOT3poeVRvUnFC?=
 =?utf-8?B?Njh6SXhqZWVzVHRIYVlhRnFqNDZtNm1xYXVIblBxemp2MWp2NWRZUVVxM3li?=
 =?utf-8?B?bUlDRXlUVkUwVXk5bGczUnFobzNiSEpHa0IzTjdrWkhudDJWMktJNjdpbFJn?=
 =?utf-8?B?WmV2bkVPZDhWUStqM1F2aFp5djVYZVdka0I4WUphdWdsUlNyZzd5NVJzQ0o0?=
 =?utf-8?B?M2NQb1MvVHRRUkNKbFp6Uk8vTTEyUVptdmgzaDNkOUtDRC82VldPSWN5eGE3?=
 =?utf-8?B?SUxKVk5PaXFMY3V1bnZlbVdWYjJSekZpbG1laGQyZUkrNzdZOHA5RFBFaDdj?=
 =?utf-8?B?U1kxOHc0UGhsa2Vld00rOE5TdCtvVDhuSGNXNVdISjlGL0NGVXk2Wml2KzJQ?=
 =?utf-8?B?MEhtZHkybWZhdmcrTEZsOHlicno5cjg0alFjNWVvUk1xWDFyZElxd3pNSW43?=
 =?utf-8?B?OHNFeG9ucTVHdS9OTjZiNk9KZ1pnK3BuZ1N3clQybTJnZHp1RHVuVXFtYTlx?=
 =?utf-8?B?VmFXYm5nSkpJN2JhaFYxOWNYODZRVmRxYXBSR1Exd1ZoZGVUdGhWM1Z3dmFT?=
 =?utf-8?B?OXI1RzJNdThERG5nZlNHLzlmR3dxS1hWTVh1SDl5K3d5YXhzV1RBTUc0em96?=
 =?utf-8?B?ZllCMGRUTVNsdjVXY0NUK3pzRUZ2UWRnMTI2SlBmZVRQTnlrdWlYMUw5RTZZ?=
 =?utf-8?B?cHdVaUhwNEZUTFQ0TXN1ZEx6eGpITDJVWFE4S3VMRTl1L1Bxc0YrSUxKZVlv?=
 =?utf-8?B?Tkt0T1p5azJyTnJGYWtPcVBGQkRySzF1L3ltZXFYYXE2Nm5qd1Iwd0dCYVpZ?=
 =?utf-8?B?UUhSSFBPZlF6azFsSjZYa2pnc3Nwc1dpQnh6VkVsb3JPa2kydkRobGxjMjEx?=
 =?utf-8?B?eVRRSHZGWkhwRXZ2cVZJY2xLK2JHZkphdkNjNkpCL3BqYVd3cUZXT3VFRmVB?=
 =?utf-8?B?dVR6UHlNSk55VVBjdERyNXFTd0tYWnVnc01xUVNiSGEzdFRHVFZFeDU4azZ4?=
 =?utf-8?B?N1c0TjhNVWZDRVFXVWczYlZDTmxUZmg1bFVHNXgrdU5rcHBkOXQwZldMNkIr?=
 =?utf-8?B?ejJBWngzQzlTaHNmNm9kcmtZUmtPMVV5TzBrZXZ6NTZQWEgxajhXWUdvK3BC?=
 =?utf-8?B?elIwYzlOeFBwR0RXdi82UHduQW9rcXFYcTRSbjg3cEdDMHFnNEVGR0R0RzhK?=
 =?utf-8?B?NWhxWlFaMDJZT3Y4TURlMjZmWEhWSzBHOWVRSnFpRkxxZDFmZzVvSGxOUHND?=
 =?utf-8?B?MEdla25sdzRCaWZJNGdtN0lOU0JxbllHZ3lOdFM2SFBaQ1l4dHF1ZFhuT2oy?=
 =?utf-8?B?M0JtV000bUtOazBRNXp0SElna01QamhNb0VCUDBOamdWZWw2V3VXemh1Z2hs?=
 =?utf-8?B?UDI5ZVZ0aUE1OENxRm1hUzR3K3hVYzhUbGpIc3N3UTZhWHcvbktVSU5zWGRT?=
 =?utf-8?B?UGgwYjJKZkwvRDZPbVI4QjVqb1o1aVF6VTRxQXM1cUdwUHo0SDE2ZVhpOUlI?=
 =?utf-8?B?bzA1RHhMVGs2M3dmNE5EdmNnQkVCaTFKTW5IRjNaanBNNitmS3BWOFQrUklz?=
 =?utf-8?B?RVMwWGxzbXZBcnh2WHFaMjBQYWlTWkcrOCsrUHlSZmdWaEl3S0hGeXArRTJ3?=
 =?utf-8?B?WTBnOXRUbEtKRjkwUWo3clppTnRIRFBVdlZkejNBMHcreDlSNXBYMXAyOGls?=
 =?utf-8?B?WDg5MG05eWp0ekY5VXdQN1QvQWUzUUROek5DdnMrS3JRdUc5UGNaeS9ZRDk5?=
 =?utf-8?B?ZlJicFV4dCt1MGRoOUM4VGdEb01zQmxpMmpUdlhRa2I5bHMreFo4TTZZckM3?=
 =?utf-8?B?UGh6RWJhVVlGbTR0UGs0dkVBUGc2Rzc3SWJZaHRBRm0rWm02TnFXRXJpRUx0?=
 =?utf-8?B?NGU1UnFJR3lCbktBbkNXeS9zYTYwN0hjY09HdmxUUnNYSFNscWMwdmQ2VzlF?=
 =?utf-8?B?NDdXZlNaWml6R1Bab1RVNFBCNENKWmpWNmRNZlVPdFRzb3NsNE1NWFBaUzZj?=
 =?utf-8?B?MnUyMThnN1NldytvWmVFRUliZGFNYkdmd2FXWDdKTmFFUUQzUHpjWUlodVJR?=
 =?utf-8?B?cDBhbmE2ZTU4NTA4YUh6LzR2N1pNRkhKcW5kMXdLS3JnYTdBNWE5VmFXa0hp?=
 =?utf-8?B?bnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SDW0h6BjnIYvjB51/wa7YTHbavS86AUKPqpP33beFMq9ONYpW0uHKFGLoCiiabTGDvFuRpal8vnyQYRmuD5IJqiaymt1HULZdLpWl7MLW6rcjCS/fO9VqmxaLxka4fhTh+unXz9DWJ1m2EQvOUN+vu9nB/xMc5hEk2XT79Tb/1N2mZLwlSXz1qcc/pQ/Ht8bWq9t0ojMornyw/3zM+FN14uPNa19Q31gBXWelKgF4YpTVcrbN7UhEvcVpTjUQEwKV+lrr1P6bhcQkyqiBvbUkLh0duHfjxjgPkwVOPsOMJcElxIOmMGwffY0BjJGi9WNQdCXdzaPvZxiV3sPE1e8AM0XzKx5C5gPzDm5vrmCyEdAWhxnynNeuJ8FAty+rADseXbCla2kzOP1O6QOHl/WUUOvGWVpITTJIqQ0WxO72yh0Ty5qDJzc2BLOheEZqGj4f8KjujAWXnrk33f2p304Py9ukdIrDaNE6ppAwTznkmlF/G9JiZZfAU/BmS4QTKDa/tpndEQNewO03Bqt1fO2179CUpPNzYaXGCG8+kRmF9zGb4+6UqAdCovCTYM7Nrr6d9hGqKw2xNENLADEfZ/BcNd8sDkxbFFn8O3PGdRaGKNz1k9eY4k7mc1QBlqXvvY3nIZoWVyqyU4lwndeA0eBcKb1p1GeYhE199c8mN00T+CPuxdqhgsj5TGNP60sX5eXz/691wKvv9PIWvzXWPVDDPFw2jIRLR5xY4TPFKgQTf7sHz5yEiGQJlnIabQrretF1WebgojSsRI/G4Hmy1TWlQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adaa38da-5891-4a0b-9678-08db0b6c34ab
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 13:39:17.6258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CoR8UTVDpD1iswQsoCUOOYAf0yrA+KIkb1s71tyjX6FQELcy1AelXrPxUMf2Hhl8YUJc8xU4PYRr7oI9lm08BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6087
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_08,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302100112
X-Proofpoint-GUID: b0DL8jxFZPmQwEqxeP8YHnSm5XS366r2
X-Proofpoint-ORIG-GUID: b0DL8jxFZPmQwEqxeP8YHnSm5XS366r2
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 09/02/2023 13:13, Christoph Hellwig wrote:
> Hi all,
> 
> this series adds a more tests to the auto and quick groups so that they
> are run as part of the usual regressions tests.

For patches 1-4

      Reviewed-by: Anand Jain <anand.jain@oracle.com>


They also need the _fixed_by_kernel_commit attribute, which the 
(upcoming) series [1] fixes.

     [1] [PATCH 0/3] fstests: btrfs- add _fixed_by for new tests in the 
auto group

However, for btrfs/125, it is most likely that there isn't a single
patch that made it work.

Thanks, Anand

