Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D4E59F42C
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Aug 2022 09:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234870AbiHXH0H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Aug 2022 03:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbiHXH0B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Aug 2022 03:26:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88D31758A
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Aug 2022 00:25:55 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27O27cwh024807;
        Wed, 24 Aug 2022 07:25:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=oOrKQJAamCIMRXUmbBuTJlA+eFD+v0RIMRn6dXyVJ1I=;
 b=l7hPXNWZ1CbdNZkxFzrvZha3reMkheae1dJWi9H7sZcPahHQcKdcEBs5mi09ngxHegkq
 5h5po8O7jWGFt8mbbBnoRqtOHfncfoNZr1hq6g1XVhg2fZL0wWdY0vnP1Nfq4JSKvSuY
 ta4OHhX57+vnCk3EZktFfC/5hy6AicdGaljRcHvTtQrDz3pDRxBW07y3Rxy8zTvWMzOj
 jToQo72FZpkGEbk2hwIBEsvD+7HdlUF/9AhLbIrwkp/RDoeEWYBOrjymEqeCuLNZOZUD
 lWWhOhsH6yND7Kj0DqO6YqcB9n8Kth+6YB2DGhqK6IfMSl/SfIk+mvAHNzKkGC4zg8eD Lw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j5awvgdm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Aug 2022 07:25:51 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27O5LoB4018272;
        Wed, 24 Aug 2022 07:25:50 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mjfawcm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Aug 2022 07:25:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLx40hqRj4xdSto7YRLb0s5yl6K+zmP8Z2kpRJrUMnuUGL0/rs4b3oHsSS0AKFUszdQK6Pcl/RBGVr9/3BUOHfbr0BOz4xf9qU5AVPpiI+ZTGGLZGzMdNc/CZb4n/Zi/tPAEu5K/Nlm+NDX3S1IintGtu3hLboPjBmaIAeGN/EX2ZKJK6a6PibBdAxF8cgt+q/khTkHXZbxlYLKJt81ehjD1dgaEZS2oBbuRt6nQdhwdOW3npLB2hL/+jR/MQ7mkUTGcsNhPA+hD69BMrYqY0K0izrkczASz8zyI+I7zwTJqsKFM+1NuMmgSz8gqxC0Mpnz26gIa7xAJNT8M0E3koA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oOrKQJAamCIMRXUmbBuTJlA+eFD+v0RIMRn6dXyVJ1I=;
 b=afnfUzfbyUTTfh+2nbl7UQU6U3kSPLLT9Z7LOoCrBzHaCqfpvCyPKSYmfCB57Uk8zL/WH9gmGa5bwdMYW4+AUQBk/vxJH5/2WoDUJUqCtTO8sFsjVaGVxLiMXg2mnQfouTj+BEPmH6HblcV/wOtsu3viT32SAOvuD7kYwC5pkR/rSjF8YdqWXIoHu09ZcEQoYEEBtYOVk2MwP0kqKkC+rjLzZglFd1xiTV7IC5Pytr93ar8ls3Okh6io1TXGIMwJbK3JrpawLxjLsb5/9KsZopC3oj/ZxzwSH8LFfzGIUVyV0Slof/Hptw9whMsJSt6kfMta6f83zu23pfFnXkn7ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOrKQJAamCIMRXUmbBuTJlA+eFD+v0RIMRn6dXyVJ1I=;
 b=CT31QFQ0I1t4SorUfneLeCl/7HRGAcMJy3uVw/rCfTOMebc74KPLYtyJUjf/fspUDpn0XrCyOkVN9pVC07pUNnqDVlBMQbBH+GCFbnPmQQcLXQV9/acPerVf6Albf6PeetQ75vA4hm85nFyTn9W1gHYYWCAyrEYuMLs59AKgkc8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM6PR10MB3049.namprd10.prod.outlook.com (2603:10b6:5:6f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Wed, 24 Aug
 2022 07:25:48 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::f164:f811:6e47:b7cd]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::f164:f811:6e47:b7cd%2]) with mapi id 15.20.5566.014; Wed, 24 Aug 2022
 07:25:48 +0000
Message-ID: <29f941cb-207e-8e77-e376-c3481557981a@oracle.com>
Date:   Wed, 24 Aug 2022 15:25:41 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH v2] btrfs: slience the sparse warn of rcu_string
To:     Wang Yugui <wangyugui@e16-tech.com>, linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20220824051208.19924-1-wangyugui@e16-tech.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220824051208.19924-1-wangyugui@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0201.apcprd06.prod.outlook.com (2603:1096:4:1::33)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd445198-1764-46fc-2c11-08da85a1dd64
X-MS-TrafficTypeDiagnostic: DM6PR10MB3049:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bCVb8f1FcdjPozjzjS89xqVqAUgbkUKDqujCLhcY3FUEDLGBQhX7LO6JZ/QCO+nzwSvtxQVZgdA4PLlP/F4/B6w7kGspJwoGLeVpbdAqRJuiUfEXKXoa7dd7qmUE7oXYMNb953GiRAlGjsp6bLdn1MlryhlWdKCWVGj48I9Ely7vpAATfCs05FpF+5NXxlk1LYtkdaMXf/ylcPRMKKVoAFc32ZcGox+TM8vZ/T5cTuv4LphYPpLXh1/1ePlwIctqrTcxNv2YivE12rYnwOUb5Obe/IaLQo8jGszXfO9YfrgqZ9f9jmXmjTjp+Ab2tZEKAY9z3AMA2PqO+4IHKSXHsviLnWcJJ49w+ZOqWC77ZanZgXGyHvHD7foZWqZKtsEQudrp7QRMwGg2dMfnbz3U0HgrteQzkI0gOdm2YQz/Hs7EEC+bFXxJpxJ0Dulh7TJbDw0LRglHizVK+ZyqforxrizIF3vocEgyy2VyOnlEdB476+jymOpnWItsB8xUQPwfKx/OPQGs0uab5nQkxeH1Toqi4E7/3KZoJYEfUNeLgUYz8wnfsDWc8r6e9DbPTXa+kLOH4/GaFMn66mSDHoluGrXNGWzyVDrYShpXEh3kngRL+493tIJXFdvdCVlOs4GLvW5UIFr7QM/5G6I/GREr+CvdtVihYC3u0URl5Uz1uvcXks89PIncyeppHr0sMMCM4IlWMXvvO0d66Ezj2nEEnXP8tjA7jBmR530f5QDbiK/n2wywlGct9lr5fwKJ1XRP4zFu2KprwOTSaZa2YTRYsApDoY5ePJ5mXPG6+dfi7dU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(376002)(39860400002)(396003)(136003)(31696002)(186003)(41300700001)(26005)(36756003)(86362001)(6666004)(53546011)(6512007)(31686004)(83380400001)(6486002)(6506007)(478600001)(2616005)(66476007)(8676002)(66556008)(66946007)(316002)(38100700002)(4326008)(4744005)(2906002)(8936002)(44832011)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzRlUFplU1dSMEFRdjlwaTB5YjNLelQ2YmE0S2pzNklZT0RUNkpqeVNDTnN0?=
 =?utf-8?B?MmZUajlQNGw0cFBsRlVBekpHdnd2K0ZZZnBuQmU1YkUrM0NUeFpBTmFFU2Zh?=
 =?utf-8?B?cXRMWStZbS96elBnVHB3eGhlQzlnZ25yZDcyRkVFMXFNMUlOVUZ3a3FDeFA4?=
 =?utf-8?B?SE92a0NHYUlENHlmL3NCSG1jb2dabHR4NXpxK0lWTjYzU1hFdEsxRkRnWGFi?=
 =?utf-8?B?blZXUmoxbTlrWEc3L0FGTXZPYjJSYnY2bVg4SE9pUlZyby9NOVRHMm41TVhk?=
 =?utf-8?B?cHpDRmFkMmw0N3crdllJNThLckh5R0psaEJ1a29wSllYd29OTyt5eG56LzNK?=
 =?utf-8?B?clBRNDd0NGdxc3VIZkJJa1BHaTZtMGp3MGljRjIxYmUvQU96cXN0ZkQvSWVH?=
 =?utf-8?B?SlJDdFROdzcvVnNCYlhxWm5ZOXN5Zjhmbk1mT3k0eTNrL1AwNmNleTZ2Q3A0?=
 =?utf-8?B?NmlhQjcyL2l5NmZpQXlra0xKVlpsZExrRVVTSVlXTHgzY2Zqb1Q4R1FlK3Zy?=
 =?utf-8?B?K3RwV0QvKzRLTi9CbWpjVHphVlJhanc4UnNRL2x3YmRTTWI0Nm15UDNlWGww?=
 =?utf-8?B?NlNHYzBUOUwzM1pFSnFSYktPUFBoM01tMXJKSC9XYmhXU1VaeEYzWjBlRGkv?=
 =?utf-8?B?MU1BWDE0cUVvdkZucml4amxBRm54UjdJQ213NS81dXdQUUFMcnlLcGpVZTNQ?=
 =?utf-8?B?ZzB2d3pPamNkVG5jbDk0dzRlZnRBQWU1SDRhT2krM3FFdEplSWM3WlROUlpC?=
 =?utf-8?B?Z1dxMlk0bm1KTHl3UkRTYU1xT0c5aUNpekRxM1Y2dFo3VUdYcW85cGFwTncx?=
 =?utf-8?B?dnkzT1VESW5WWXZJRk1JVlJ5dU1aT3N6dWZNU2E0eEV1UGgybTExYjRTZFFx?=
 =?utf-8?B?bTU3bHFwcWJZTy9HY2VOWnJlOXZhN0swajdVdHcxV3FRSWFPSXJqZVd1Yy9F?=
 =?utf-8?B?am52QzBLQ2xVaWNEWjZMZlFRNklwL2tFU0UrQUVMZWJHNEo2ZnZDalVHS2lT?=
 =?utf-8?B?ZnBzV0lzd0RMYTk5aGhZK0JiZm9YSWQ2d0lIYUlpUWhybnMvVTltTVRoeW9w?=
 =?utf-8?B?VUpyVDIzZStJYW1jbnBhWkFWSHBtYlRoS0Uwb21naVMvL3I2Q0pVSUpBOUkz?=
 =?utf-8?B?WUFsTHh0Wi9YUTVnMzdJcmZPbVlMQVJrbEsvYURDUmluaUdZTDlUeU11Tklw?=
 =?utf-8?B?UjYySStxMXBYRzViZDEraVdvdzlBbFZqMjhRMFRtU0MzQ1NGdWx0ZFdSaDVN?=
 =?utf-8?B?Rmdhd1NEUXp4dFBBREVFQnRMSFFSVFJrRGwyT2hTREV4ZHNkZXhJTy9DTERU?=
 =?utf-8?B?TVZ4MjA0RXRhbHNNNFI2S3I1QWl2Ty9KV0NmVEYzUEVISStuN0FPcGpnSnpL?=
 =?utf-8?B?NDdjWklqd1dQVmVFOUtFakEwVndYUVlWRDQ4QzZSVFloUE5mbEk4dHpTQnVJ?=
 =?utf-8?B?bXhXOExKMlNWZDBIUTlVQ0xKZHMwdDBwenVmVDFTS1l5UnVXQld1d3dQUUNP?=
 =?utf-8?B?U2U1Q2JPSG11dTlCemlKZGdXNXZSOWx2a1VMSjcxWjhvcm5KSERQUng2QW9U?=
 =?utf-8?B?Q2x2L2ZDMFQ2eWNyZGNjNGFvK08raGJrcnhVRVh0eHg4MFpPak45TDcxQkVH?=
 =?utf-8?B?Q0pKWnVWSnZqTWRDRXM5c1BWR1V1dENocHJJVXVIUUJpTmRNUmFOeWRBR2Iy?=
 =?utf-8?B?QVNYOURLSUI1eHlEZEtTSmZtY25qaHA1djEyMGJoaXZnWTVXZTFzQVJ6RWY1?=
 =?utf-8?B?U2w0R1FSbEpSeGJTcnVoSDNoVFNUSk1uN3NVTXBieUxPTEtpRlByYU1rUTM4?=
 =?utf-8?B?clVmb0JsQnFnU1JDQmFnWjlSa0hxL2hvOGR6c1RYUVk4MEV4TTJucUdGTGlV?=
 =?utf-8?B?QXZLc25iMHNINGZCYjc2MVhSVXN3aEFMN0hxMUhIMTQwNEhpUkZkYzRwZWw1?=
 =?utf-8?B?RWJldVlKZHFpajg2V2pDdG8wd0xSMTRreCsyZHRVRWZVM2ZWUzVXWCs4ekt5?=
 =?utf-8?B?SGFRcEpnd2J4dTd2Rk5TZ1hJQU92Qnd2RzFrVHkzWnRRYVNtN083dHZJcFNF?=
 =?utf-8?B?Z1RwZC9leXU2dklFTWhxc2RiY0pDMkZmUDRGaUdtVkdidXo1NzloRVBHL25K?=
 =?utf-8?Q?3+QKJdvcxHgCactMdad8E4HTq?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd445198-1764-46fc-2c11-08da85a1dd64
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 07:25:48.1446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nsaNSs79LbhtUDxn9lTFt9KpwDBur3k+9iYKTcTIp2SRelJwhFloSOru4c6RoK9+mi7AXz5DgDoHKYQYJPBlLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3049
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_04,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208240029
X-Proofpoint-ORIG-GUID: 2mq3OlQ02nImMU_wEZkZAuLSqJZDf7WD
X-Proofpoint-GUID: 2mq3OlQ02nImMU_wEZkZAuLSqJZDf7WD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/24/22 13:12, Wang Yugui wrote:
> slience the sparse warn of rcu_string reported by 'make C=1'
> 
> warning example:
> fs/btrfs/volumes.c:2300:41: warning: incorrect type in argument 3 (different address spaces)
> fs/btrfs/volumes.c:2300:41:    expected char const *device_path
> fs/btrfs/volumes.c:2300:41:    got char [noderef] __rcu *
> 
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

