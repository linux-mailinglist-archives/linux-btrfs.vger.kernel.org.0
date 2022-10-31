Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E776141F5
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 00:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiJaXts (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Oct 2022 19:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiJaXtq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Oct 2022 19:49:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C18B5FE3
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Oct 2022 16:49:43 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29VNhuEb019317;
        Mon, 31 Oct 2022 23:49:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=DLmKbvaXULJai6tTh7xN8YWxb+CJfK0mI7RLYfFiAxk=;
 b=G/jTPAnp+MnA66+Y2K/48ZNGdTrBCqE15Jixe2XLEfcSGAvGHe5MfSCTq6ghe7fmGlSh
 GvnTLPrlzZw1Cghtr3SlMp303qdCSxwi6d7224OM85NBqXtEZkdCwaqW2KOOPN13esOp
 tsVMo6Uy9zyToCaIIwK63mtJWDMSdYAyNtLwtZ4he6xBEruYz88rtArvHz74vlPCFT5L
 zL2AvufidWDQjv8Y/tLexiZZjXgErPfkRNx1k80I6w0SUC/YAWSIiOSPCnkdbH6o7Dpu
 iwWefpWKuJ7qemhoZ0FV9NU8tseZG8/ieLHNQmBoDvZJvseYXzLLikXJKMGynKcPDfmO AA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgvqtd7ev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 23:49:40 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29VND8Ct017169;
        Mon, 31 Oct 2022 23:49:39 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm9ub07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 23:49:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9tZeutV/HKpEibe56iJg6QIdg4N+ZuFk1c4KNYvhoe7V9qMJGgjocO18tYhqVW3cTpmCjrKFUjdFuytQdwlGGdunNCwV28+OBryCsrsL3JR1BMFey9X6y3JjyUZML5oAAOESrxiwg8HwNcUDuO1BSMFhHr01JHD1RoHHe6p4I4cczHzVHbOeRdijLf6OUrQAOYbYeYUZpzlag6Prq+dGYz4hlzR6qUynd/O+uayaHC5UkRFLlN4eRj3WEgrVv5RWB6dAdd287EVd96c38SKG/Zgm3GkrV/SG4FUiMeXfdFVjafSzhnd/ho8VjueYi/m8TH0CiObX75t7Di3gm1smA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DLmKbvaXULJai6tTh7xN8YWxb+CJfK0mI7RLYfFiAxk=;
 b=K8uig4CTV09lqBwrlzh/x8r2PzaZ3IR2NCR+W1zdoBlLEWTgmtoMTZeW9nOgvOnOqGUwupCIO6LgX0FSaRj3y8CyUHIP5YDRDgOeWljqr84GknVhWfk+/rsAlFFev14HZmEpAea5tngO2qKkCE6xum/HnfXDJyRlVhEFCtBSdHwXJKpeSSSk7WzWjQx0iD2AiktZSj+QT8ITdzOZdgGKxayCe2rwijyf5vU/ruJonBNqoup9qkL5Rr/KuIS1YBVS2eq6ju5Hdw+/unoyu8fRPafwFhaOJX8v3ztBwiT83PRrELeaBSTQBk6fqp8p934T9n9vI1kjnmRdCzAMN0nEVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLmKbvaXULJai6tTh7xN8YWxb+CJfK0mI7RLYfFiAxk=;
 b=bVNaCjVjDzs9xqT/nKEx7x7iQy1mdEtMaMwo8aNtI8Xkx+zy6AB2If/PUzfoXP18G5wiHEG7Lzys51DMypmDyTQti/JOW/2YGfPY1Mu/Skmr+SeQjJD4c0ud5EBUVTHRHUBVyM8mXxkFVqwz/WK9BfSqS9vug1+iBf3daOHCM9M=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH0PR10MB5210.namprd10.prod.outlook.com (2603:10b6:610:ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Mon, 31 Oct
 2022 23:49:37 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::e2f8:caf3:7f80:8b5b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::e2f8:caf3:7f80:8b5b%4]) with mapi id 15.20.5769.015; Mon, 31 Oct 2022
 23:49:37 +0000
Message-ID: <6cc6cbbb-3da1-416b-ca5d-042965bca1ba@oracle.com>
Date:   Tue, 1 Nov 2022 07:49:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 1/4] btrfs: zlib: use copy_page for full page copy
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1667244567.git.dsterba@suse.com>
 <5f5b4513ded109bd87c5aa5105608fa8363d72d2.1667244568.git.dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <5f5b4513ded109bd87c5aa5105608fa8363d72d2.1667244568.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:3:17::34) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH0PR10MB5210:EE_
X-MS-Office365-Filtering-Correlation-Id: cea3ffce-c7f9-43fd-7b6f-08dabb9a91a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TzHuk8aJfxrWK5lEYxTT0BXzt6cuBHO7khxTbDpgsU6SUSthbNgq+F4uXbZoXtI6hpW3xHpa5V8EhLGzhisgzKZ3n9Pd8SPxQm4494MqEtmedVf0o3v/14og2wSnL6JoWYM34ljaLSSqF1V8ibl6BpPykgY+TlYRbhC5jK9uctiugTV8wG0LCOjIbvv9KESdqq+YuMsVmYzwSNTsawU73hiKp1JBTwaEA02bdCwrFJQmeRYkol2wG28/RKOrfoz4RB0xHEPHHyH1xjx3CcpVtgG5EE4eiFzOXutqflEnKARYnd3UcW1IjLIQbbWrBWpsCBd36kUUv9XWYCMiAJwBf+FKBqqgq4GcECzXfKvKpvCTHc6k1oDGpt1gXGI71P9asOq5GOqz9h6H2XwxdA3cZdxd8h5wlO9sgbScvkKoOlEaLgACy1EQKYlX03EO428IjI57t+EBc8jErP5NoVHTlWEj2R7nvyaT+jq1HC9GyuVUM/rwBfq238XKL8NljqaXtXv4qzhb7w3WU+c+8mFl6MZ4WNiwYVqvFbwZOICxBGsAmaV7PNSUfIradNRff82INUga+2y/isswC8QPaE4DPmpcQVvEhMP4J+gHiNjYpujP+dVWbZAUGAZ6Sy9UV3UbhoP9TuTl/7OINJr+uWL53JSKzoXj5A5HLg3ihchmp+1DQmSH+zPJbSj+uayNpdqQ4/WkDW++KskQlwha4xhgTMTYBvP4YYl30WIr3qi1ZvivqRJFLzawEogg3pJsABdnRERoIU1dNvqzoB50VCd0vdb0MBhwsFqIAV3TuKBiSiw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(376002)(346002)(136003)(396003)(451199015)(2616005)(44832011)(6486002)(26005)(2906002)(31686004)(41300700001)(4744005)(186003)(5660300002)(6512007)(86362001)(31696002)(316002)(38100700002)(66556008)(478600001)(6666004)(8676002)(66476007)(66946007)(8936002)(36756003)(6506007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mll0V0lmY0hGeGJWNTJ2ODQ3NGxYbDVWQlFuTXpsRnB5STAvNHRkSmFWNFJo?=
 =?utf-8?B?ektOSzRVME1RSUEvVFJrdmQ2c1NhbkJoUXY1NE1UTm1FU0lKM2FkNXhrbWZD?=
 =?utf-8?B?VmUrUWhFNllWSWNFc2Ywc2h1aTNnYVg1NW14UEcrSUpjTThtTmE2TWVrMENw?=
 =?utf-8?B?ZWx4R0o1OW1QL29OMlhTQ1FINEh3Qmp4NUFTOFdUQUhRUFpKYTczOEoxMERk?=
 =?utf-8?B?RDRSRkYwNkhjbmpqYlBvYXhmZE9BMldDWlRid2x6WjhKVDgrSDRuMzdwRGIr?=
 =?utf-8?B?dGpMZG5CUlBpMEkvdWtNMzk5eEVFMFBFRFZSYlh3YlBLZGFNTWhQcGtVbTZq?=
 =?utf-8?B?WHlPOVcvekVrZVJEeEo2TTJLNG9uMkk0QlNGM1BMUDFVcHVHSWRaallyMkJz?=
 =?utf-8?B?eTczWnZ1ZFlwenBoM0s4Mnh4N21Tdk1BYzlJMDBvYUpkdGRQemF1V0tQKzBQ?=
 =?utf-8?B?NFhwSFBqRUtGZkFoL0c3eC8vNG9waVdxaFFWZ29PdWNIeHVSUnF1MnlnQm5F?=
 =?utf-8?B?UVZDSmVZdm9wcm1YcjdwR3VFK2h6QUIvZTZJN1N1MTZFSFlTSkR0bWdQcUpl?=
 =?utf-8?B?OWtYSG12V2ZiTnNNcUFWNGlnWGhrUEVOdUV0bUNSWWNGZlBWaWt2OWVqSVdH?=
 =?utf-8?B?TFZsL1FibWxkWWYrbVBNbWlndzdqQzBabXdRR1pLTmlUM3dvOXh6ekZSNUhI?=
 =?utf-8?B?WEtEOC8reUwvMXVBMm84Q3F2ckRMWFd5eGZoRzVheVYzc1JBcGtFNkw1bnVT?=
 =?utf-8?B?QW9OTWNHbnRYelhkUkU0Sy9WaWR4WExkVHk2clhQV1pERjByaE1TTnJYckJx?=
 =?utf-8?B?dnoxYlplUWxrVTFrUXQvVWhSVUgyenFXSWV0WFBVMWJwUnY4N21nV0tmRXN2?=
 =?utf-8?B?S0t3VnNTQVBjU2dOVXVSeWJvd3JBSXZrTnIrb05qRWVDd2IweFZ4TktnQzRE?=
 =?utf-8?B?K2wxOERxOTNrNXdGQTNjTW80dUlSdFd1a0x0WUdTYndCaWdtbWJxRXBqTU9T?=
 =?utf-8?B?TXpoVWtRMzY0OEpGSU9JTkZFWDZKQ2tNU2RwaEo2OUVNV1hYd1I3Z1ZiSS9O?=
 =?utf-8?B?UHZxdG1KaGF2REV4eTV6bmpKY0tqM2JtSmpMZnRvazd3QXFWUmNoeEZJa1B2?=
 =?utf-8?B?K2VNRnE1UXkxeWVvY1Q0ZDhwNUpOQ2xZdmZxdHEwc0Y1UUZNVXMyNFB5UTNu?=
 =?utf-8?B?VEs5NjY3SjgvMmM2TCt0N3VzaDlUNGhqQVJ2UURJRmEvWTVsUS9NOTFibGlI?=
 =?utf-8?B?dUUycU5XRG1VNkcxeHhQSTRHVzQzcTRGVUtRSVpjV2ZkOFBFb21EVitDc2NI?=
 =?utf-8?B?c1RpOFZuV3VsajdpdGhHRUExZG0zL1ZFbnljNkVYRm5abGVETjNMSHVEMlYy?=
 =?utf-8?B?RWxOOHpDUDU5M1ZlRFhvVHZWVW9Za1MzakI5NFhEVlZBZGNsckRMTWtrR1JF?=
 =?utf-8?B?SldXYmZrSXBoZVcxYU92RzNtY2ZrNlc2dlRVb1hkV3BqNDEwbmphOWk5L24z?=
 =?utf-8?B?eVYyMGp6b3JmQzQ2U3A5WFhET3Rtc2xLWDQxaExkaEJzcnczYWdwVGdlbGc3?=
 =?utf-8?B?YlE3dWpFOThyNnN5ZjhidElGVE1RellIOVJDTS8wc0UzNnBUbE1IUmNFUTN1?=
 =?utf-8?B?WUM0Z0YyaDdEMHo4THhEczQ3RUYvb0Y5bXcwYlYrbVRpSWI5NjBhQ3NTbmNV?=
 =?utf-8?B?Z1RZNmFpbXlmQzNrdGQwUnA0Nk1YbndVL3FTdUx0ODNpZmE1RHFWQVVHSzQ0?=
 =?utf-8?B?OXA4ZVRPc2Mwb2V5L3RWVXpaaXNGKzVrZVJSRDdyUzd5VEFUTmNRcENjV1ls?=
 =?utf-8?B?eGoyMGMzQWRNSTNtODJHd21ibURkbGJZa0toanhaM1M1WGcvWkVselgvTyt6?=
 =?utf-8?B?TVJBUDB5dmFvM1p4QUcreU5GSHhrcmlTSHd6R05rUW83OElEY3FFaGxqcWR5?=
 =?utf-8?B?ODh1b1hOVENLdFRmeWtxeThFbTlOVnluaHpQQW9MQ1ovU1prcTMxOGIweEsv?=
 =?utf-8?B?WlhVL2xteXE0QzZGbGYwODU1SUJpRFROUm9wcUJLT2hsTUg0Y1ZUVmxCWTVh?=
 =?utf-8?B?N1hBYmdEQjF3a2F5alpuNXdLQzlRajM5aVptT2lrM3NTcU9VbGxjSXQ0anh0?=
 =?utf-8?Q?wv/vkjSZjI9qSdBYIngSKatnG?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cea3ffce-c7f9-43fd-7b6f-08dabb9a91a3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 23:49:37.3332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vzs0JR2gbdqfo2aRMuztkui7TgYMhq7eIhm5tIa9DMWBd0aK48P8ECPItS0gMI+3+N0d0HEnD+ekqZO1xJcFkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5210
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_21,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210310149
X-Proofpoint-GUID: CZ_AAmtTPz-H6i4WQS3yr9St7Z1Lsscp
X-Proofpoint-ORIG-GUID: CZ_AAmtTPz-H6i4WQS3yr9St7Z1Lsscp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 01/11/2022 03:33, David Sterba wrote:
> The copy_page helper may use an optimized version for full page copy
> (eg. on s390 there's a special instruction for that), there's one more
> left to convert.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

