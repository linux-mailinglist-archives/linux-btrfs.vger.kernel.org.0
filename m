Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40F06F7CE8
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 May 2023 08:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjEEG03 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 May 2023 02:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEEG01 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 May 2023 02:26:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DC314E41
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 23:26:24 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344MInVl025933;
        Fri, 5 May 2023 06:26:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=2P1gLnoIA/Mh/ebL6oF3NaeTfS10Nqqt5j3oU+1k9b8=;
 b=iz3AZIoUzkCLfO8ZEg+a/pTD1mqaDjwj830KcaK2p+sovv92ToSiFpfd8Sj6ra7HbHCU
 oH8mI0dxdlGXcH+FG78Co0zYppBLLST5hAg4lC6MvhcVh1cBM6YW94734EtFp7G8lkOs
 tr8KZV4hYdn9isnTbTdp27oKPYts3658hDB2XHda72ngLJIl46QYeseJqXb8Sez/Y7pf
 loxBIE2gbAEymATqlEZgLeBMntvz78wHIr4b1daayfbbLsnPrOWsxFTM2KbRmq5uYLpE
 7ruMtTmEFrMpY5PlboaZZ4hHU2zmd9ItfAiulJwLU4VosnMNC6hcsSJ/3FyRlPtCVin2 wg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8snebx0n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 06:26:20 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3454T8Yw040504;
        Fri, 5 May 2023 06:26:20 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp9hcsg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 06:26:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XBnr1m41QjjBKzlmmW8eOwlkrrpQeWDwuNGOv0f3YbwhtZw5LZFm4oXlSWyE3YSYws1Mn+DJIk0fw/PlWhaWS9qYX5fNfw4alrnfBZfq3ZOnxiFadryvSORTP18+/DuYCJqzsMJWEsnaRyFEfIoGHtblThqyiVj4xbpOEIQC4tccgHR4pBm3MoLLsaw5grVM+vUAbOBxV+olkFy8VQkCVkCfYq1fUL5IF3NHkcqOWeA5BBtvineSnuTfwDiD2DQjxInsOjqnK4YUxr25wfCiv84+hRwC9PQB93Y4hQnwadwbqWZZNny38HAevadgRBTosk18LEGPTXq6oE2zuWdfig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2P1gLnoIA/Mh/ebL6oF3NaeTfS10Nqqt5j3oU+1k9b8=;
 b=S4mx32XcfzXh9jBjEQWjsHzzFuPRcABLEOsN/vCih3h+y1k8v8+glt3x9rlkpioQL2lHHnPN0CsBghNA35ja6R97PYmpUahWOjFG/xsAze8YjX3vHN+pIY1yFgn1IktqFYAQgT//BFpWAFNcn1LaHr52xtts/dNdHX7AxqipRHZgA1c+iBJ03kilj4956GjU5yLpmRoS40jP/TVoOmfwH16fFbxsvvGWYE4l6r9aTJ44P2HqkNa/K/algPdGzPAOo6Ah9L4ZGAuAl0HDZTydf2IizQnEI8gBTw/uGflADIRJ+cqStOruzBEF8dNwm1X3s70lRObW9etD7rqEjPXA4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2P1gLnoIA/Mh/ebL6oF3NaeTfS10Nqqt5j3oU+1k9b8=;
 b=AQEeYaO+z1r+wR4FYubb8nrwwgpLS3NJPuE06Ndzqae2GktOfo1KvMPUFICApFsSDPnKI73tpG4BHbmIKf3D3Aa/MOO+TjWJ7gCnNaxqCLtBXWnTiqnzXe7urYqUDgO/w5kmKTPS1xNI/30RqYT9SLszOohISEjEDl9wz6Y6URQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BLAPR10MB5235.namprd10.prod.outlook.com (2603:10b6:208:325::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 06:26:18 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6363.026; Fri, 5 May 2023
 06:26:17 +0000
Message-ID: <d34274a2-db03-d715-0c42-b79c021e3d2d@oracle.com>
Date:   Fri, 5 May 2023 14:26:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] btrfs: don't BUG_ON on allocation failure in
 btrfs_csum_one_bio
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        syzbot+d8941552e21eac774778@syzkaller.appspotmail.com
References: <20230504115813.15424-1-johannes.thumshirn@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230504115813.15424-1-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::21) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BLAPR10MB5235:EE_
X-MS-Office365-Filtering-Correlation-Id: 8267895d-9dcc-4070-efde-08db4d31a246
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CSmWmzfVbrDEN9eC19bKsJbU/iYGDvzz+fQ5F29TnluSTsVlESoxC2X5ki591i+FaxoM4anh9+ODVdHLDkxKRdo+DLi9L3Xwzb9yB4w7eDGDVhyepnu4HKZuB4KD80GTSeKRtbyEIimgYOo780VnS5GRCJw1ILS4K906OJB1C+cZ26dHEAy0nCNs5Rq6tFrQbVv+q6L4dpbMow+0m/Nk8HEByYsxlcvDvhTCQkqZXG92aqNC8PyerSnMowB2fqRzWL50NhTD7P+E2LGmNLHUimCQ3Bjjgo/qdlIcbUaT4/tfVMsMb+3OaTAbRkEaK/BFFu9h++A2WENOzLeg4DMCG5GxkRW51aufzkg7w+kT25qw5gL7BWhAw1apgYWSaRNdm9Tjm4IzvtKJgYcIRCS9G6a63uzxRq7TovxA1hGR1DJVY/8NOI63jspzYmtxz/jtoyKYVL3a0oWGQF6rIfNsyxfGzsIzgk0DtA8oXm34wiRI4J5+AyMVyIWnjcN1NVeIC08LG2kch7p299rgVvFW2qUoPHks++gn7K/OTOr3BjjrlHoKqoUOVLvCS4ZQG2KyftYuhgXox6C6XLifuYbH6CTA+ZHMvryZDWMw8314Dt9HJDF+U1v+Wyx3w06agaUJmNqbLXYsBBh3l56LcgZpfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(346002)(376002)(136003)(451199021)(2616005)(186003)(2906002)(19618925003)(4270600006)(38100700002)(36756003)(558084003)(86362001)(31696002)(41300700001)(8936002)(8676002)(5660300002)(44832011)(4326008)(66556008)(66476007)(66946007)(6486002)(6666004)(316002)(478600001)(31686004)(6512007)(26005)(6506007)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWgwb05nbk82UkYrQWNhOWcyMFZGZ3hGVy8xWUxIT3VSaVdPd0RoVkZaVWU4?=
 =?utf-8?B?ZDJqVWIzUmFLRDFNOVg3WnZ2UjBaaWRVZ2VmZGYxVTZHVjluMG9vUGIyMUNL?=
 =?utf-8?B?ZzVQaFBJUVlrU25nUGRQZ3Q4dWFadjdkUWhIWGFIYU5KR0hSNGQwZ1dIU25y?=
 =?utf-8?B?eHpBZjk4Mnkwa1gxSHAyZ0l0a0w5RHVTM2RSSk0yVitJNjhMQ294bGJ1dmQ1?=
 =?utf-8?B?c1BqNnU4bzZINmJUVDRIUXM3ZU9DcWhqN2VoWTZXdkIxNExwOERGeFFDMVJS?=
 =?utf-8?B?ZVJXbE9qemFCc1RNU1FpQ2hEWC9sWEI3SmQ1ZktBWVI3YitYQWZMUFpaUjJo?=
 =?utf-8?B?alFnTkJ4Z21VK1BqOWZpUVdFQmsrMTlZUEI3QStvS1JLd2R0a2VQVWpYcEFZ?=
 =?utf-8?B?R2VPMVY2djRUakdKVGI4YVphb0wxcmR3UDZJaWlGKzlIOGIxZjRHZEVhaFdN?=
 =?utf-8?B?SWt6eDNlVERUcUM2aElSM2ZlbWEzZTd5dWltdVorRy9VU3lXMDhFaUdFQ0FF?=
 =?utf-8?B?N1dQeWZxbGtWS3hicXkyUmJCcExNamNra0Y5UmNCanQrdnFvQXpYYkdqb2FQ?=
 =?utf-8?B?OFFTeFAwa2lNWGx4c1B3Ukpqc0YxSEpkcjZtaU9jblBhYkxGalVmQnM3RzNC?=
 =?utf-8?B?S0dkdnVScW9nM0FFeHZjSlBvUmRvODc2T2dBNnExWXpEVEgzOHBwS2hUQXdD?=
 =?utf-8?B?Ums4cVpTeTNYNi9lTGZ3RVRXTWNIbVZRcGRFV2tVaVJmODE3Z3k2a1pFOTFq?=
 =?utf-8?B?OWNTa1oxUXNsMmhZUUZSZUJ1YTVJU0pwbDJjUW1SMkhETlpoejNMMENUQ3NE?=
 =?utf-8?B?NVlRbFJqdDNlcW5KWHdmcDlmNnJXUnhFWEZ6b0VZVWcyUEtCTFNjTmszeFJn?=
 =?utf-8?B?OVVHOTV2UGlIcVBaKytXU1IwSGcvaGY3aG5YZER1TEFONSt6dERzVXVSQVZX?=
 =?utf-8?B?S3dFU0txME1BU294dy9MZm5KbnpkU0MzOHh5eVdITkVjSmxZKy90eGxyMXFh?=
 =?utf-8?B?dUhkdEZNd1pkNDZTaEJ0cnpDa0N0elZwZ0FEUjJIZEorQ0JyNE1kbkNzUnpP?=
 =?utf-8?B?aXBpSWpMY2t2QU9MRHFTREptb2ZPaks1aDkvbGpWQmlHWHNxM2E5Z3YxeVpG?=
 =?utf-8?B?MUZ4WnJrUHAyMWJxc1hNN1JyeGZoa0wyRHRrYkh3U3UzN3VvY0laVlhFWTA2?=
 =?utf-8?B?VS90enlYY0xYdnpza3l6aXA3Z3JYb2pYYlR1T2pZQ3ZGRWNVbkdrZmJEUU5G?=
 =?utf-8?B?Y0FXcDF2VlMwT1JrS1pxWkdMOE1zQjhrRWQ5N1BKMDNLRngrQ05sMGtERmVk?=
 =?utf-8?B?aHFyZzd1a3BrU2JtUUJNTFZyY1BPcGZiNjBqelpvNDJaak90S2Z4cVZwWita?=
 =?utf-8?B?YW1VZ1Z3T3hsZFdpamtURHQrMXIvUU5RMW5WQ0toTHByMFV5NHlWcWlIeTQ5?=
 =?utf-8?B?d3A5YUlXeDcyeHo5RGFOUnQ2QnlCcko1N3FySHRqU08wczZrWFprVHVKQzl2?=
 =?utf-8?B?aHRSV1ZSRW9IWTE5Vmtic0lmOGJXdlAybkxsNjQ2TjZTUmpNeGhmUmpiQUd5?=
 =?utf-8?B?Wk51dnI1TC9zcnN1bUxCTjlmUDA5QWhNczhMSHJzUFQyeGtVVWdWWEh2aGtl?=
 =?utf-8?B?b0pBNm9Mbmh2ZHpJeTNUbWlZNU1pcnk2Y0xKclNTR3B3ZVhWY0FVcEpiSTY2?=
 =?utf-8?B?aDZIOGxObTZFbjY2cVVITG42SnR0QWI4bHhaSFpWZkN2RFByUGZIS1Z1VE1m?=
 =?utf-8?B?d1J2N1Nwa29nWDNtbVI2bFhIRVdCeHBwbDkxelp0NHRYbHdHTysrOUNQcFB5?=
 =?utf-8?B?OG1PSWd2S05UelVHTlF1bEdERXRHRU10SEF1ZnQ3ZG45YU5rVFZtd244YVNC?=
 =?utf-8?B?amJrVDR1c1RKYUxTSERyS0lkWGhwTENScGxuYVN6UTMwODMvcjlTYVpXSzI4?=
 =?utf-8?B?dzU1RlIyMUYrY0RLcUlIL0dnS2hsd3lrR0s5Y041TWhLOVNqa3Y0ZTVYQXdT?=
 =?utf-8?B?b2d3ckhWZ0xOZ2RBOENJYW5RYkNxbHRpa3RJSDhEdnpSNkxlS2NUVlJsR1hI?=
 =?utf-8?B?NGl2TWtwdFZsM243N1VqSXRrK3B1ZVc1MGhtK1FHRnJnODd3OURTdmhvbG1z?=
 =?utf-8?Q?yr6yPOrKHD1an6Gb3m4J/MMbI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QHpmoHe1AS8fg4vNAhOi0V/SL9CxXTj4alvr9APAneXPKUv70jOKRFCzjm1EXTLPB0zwTLsNQpTvLsc1NF3zOZm1l+MG968W8oRTFJmMexogj7a4XL+xJAD3u6qyeWSjr9KeeM8Jzqrub6YqFPA7tjsSrH0VX/JnUI0lcEkNtajvpa1ZLO6upKgotTzAhIQnEkLXNeqmbrkglqAaODbwHhzlhIp3d4yM6ZzGuCMtVmFIVXozTOGTPkSciF3gx8kaLbXzhuoAdt+9t0pLoOFW77V285eJdyatjIKchVnjiBN1iWjEbW5wO50lRqeIt0byiyK6Wx+D/MxKMv7sU7NronMXndzNEsCyA+pDyZtmMK8Yiy3Wk0kIuqIDs46dnXbsaURCPu0iSw+HcgliR9vIMlt21mKifcbW+Vc5tREIf8kfy/+j5rwEBr2CwaIJDoiwHnyHKZGxhpZnutSKs1RHadMrwPEM31CsSKv08UWv9xWcABxju8n85JCZ1NBIxH4HNjI1Wl8/0NGhieyFevURtUZyQRc5m9UUXH2Rpcalrp92VQpufD+cOySClnRgnr+Pu9E0JgydPtxc/fqxh2E8VnWilS0cc8dsrkYnQ3kwvird9syjlaDfRQH2aPVylyGcEsPiX+fdHcKEY3xjv614+zu2ixTcxMm0GgybVIp4zKxpro5PN5dP6XXDnkzQ4SdYG+rW3Hxat6rnKUwtO34xIvibqKYAhb+CS7ro0XLn/57AAnzUTg+L+Irs7E0Q6HtKmxlV7C83RIyntEMlcT7M38yGumLvNjqFco+5UVW1BX6afq4Cp03OWQG1INAztt9Y1FxZHEnYVZuOWHNGehf+4z30rDsMcCo04y3V+0AvX1mwodOZqbipHsPN9pO08WXG
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8267895d-9dcc-4070-efde-08db4d31a246
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 06:26:17.8535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: by/1EpJarNV4dJNHMPXIKWOQllNX4+CfiGt9PR01JfrzLR3xNMUgdlbKAFMo60KeKu5tL0TaoiCfG/fhj9qD4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5235
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_15,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305050054
X-Proofpoint-GUID: 9-Couwh7oQ7avshwcQ9-P1wLOD30CJ_Y
X-Proofpoint-ORIG-GUID: 9-Couwh7oQ7avshwcQ9-P1wLOD30CJ_Y
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

LGTM.
Reviewed-by: Anand Jain <anand.jain@oracle.com>

