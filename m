Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC336A9385
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Mar 2023 10:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjCCJPe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Mar 2023 04:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjCCJPX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Mar 2023 04:15:23 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428B555050
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Mar 2023 01:15:22 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3233kGPF025184;
        Fri, 3 Mar 2023 09:15:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=W6uN1yDEZ1cW+2WsUqPes43Ebvo08g67VLnC4dRlxIQ=;
 b=W61w76EPTH63+PQEBwGVYHv17PPyNgteou2LCKPypSnhdO89jWkPWMtURZWaSe0zgk2U
 iknZfNMjwxRACCxcMHJ9CR8klLGZzYHVJfAkMzubdauFuIH0ReJpEd7tQWY2s4j/6ZYc
 Kk8s4f/LElOoO8KD9GJKi2DgsuHGIrek3tHOXNieGF1yT82WYVl1Rwx9gcG7pti+G1qC
 wzV8lMMmmbubcqqGpn9/ng6IUGpbShtWl4Pez/37YYouTJWmBffh1TXKkctzysh4m6Y+
 mBuCKkrgNQr9HEAC9q5RaPJq/aMjbI5QLnHPsDW1qdkF6NQE+7Q8uwrQNm1zJpXpXxj8 uQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyba7nsp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Mar 2023 09:15:09 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3237URBD033010;
        Fri, 3 Mar 2023 09:15:09 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8sb7xga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Mar 2023 09:15:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VeruG7gZ5jN2WLiIhlxY6Qi75JpYskURd6CUjDbF7Dl5bYsny/O7vlGRpIw24rHkgbkq9eLb9qAs6Y6a1EK0PaargzqAN0GpTB8MraughCbq13GtH5JBoMjGvwrhjzQ/JOQBAHezmtjgODceo1Lu/6W4Y7X1ew8r4ATtJ2hSzXFqmVOvDU2vobh1T4LhqTkuKXPBSUkdCIIwrVu+2YZd2+Oxlj0IbwBjyEmPIEj38pj9SlRaoQMABiGvsvaufBjHgCmEtIQgFgf75iLz1qCPWVGvBxp6IZCZWinBDTEdYSmW1dsGj0c0Umsyw3m+97NVYaWEHP+EvF3f94m5zENNtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6uN1yDEZ1cW+2WsUqPes43Ebvo08g67VLnC4dRlxIQ=;
 b=Y4mLmkLmNYabVYmEXpFKF3LhollosUphDOZ1S1SlXs79YZEIEpnA0fBE2lufNL7+JFKoHGPNHLKIs5BxpZVhRLmbDR8rXXyjKWVXFYuch8/Q0j64IXlSiyaLzQP+LnvR5ToaUXVGcrFAwk1P1ohpeyh3YSjttKN5VPobGE0oi2cvfR3tLWtoFppvzBkhuRg5QDCQJl9WxDOryEQwtRg8jZxJ+EiNCCnNX/G1HJUCjrvjWNaY/V85ktB1QfOm2zLqxYyBKpyPJ8iZMv7X0beARSXBBFa1bR0vOaPTyRPY/m5ckOH5Zq2X2cZeZ1jqFgUPAG+I4Vf8CPhwyTWRbMVHqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6uN1yDEZ1cW+2WsUqPes43Ebvo08g67VLnC4dRlxIQ=;
 b=kaDjkajzCghuaxPeJoiu5ts4KVmOR+kBlKNzfc6B07TyceDuUTHlZAQ0N9RkpiTr7PCITg8voTW8wehEBrRCxR5zjbIftWFkmJEBWR/3oW+uhWAWXqxFFOAo/e0Da+AQ2Vnf85uOYXrXYl0l1vgvWsBJ4U8Hoo83MfTwYSG3DhY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4524.namprd10.prod.outlook.com (2603:10b6:806:118::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.20; Fri, 3 Mar
 2023 09:15:06 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%5]) with mapi id 15.20.6156.017; Fri, 3 Mar 2023
 09:15:06 +0000
Message-ID: <d50e7ed1-4b9c-6c8f-0676-47341a0b9994@oracle.com>
Date:   Fri, 3 Mar 2023 17:14:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 02/10] btrfs: cleanup
 btrfs_encoded_read_regular_fill_pages
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230301134244.1378533-1-hch@lst.de>
 <20230301134244.1378533-3-hch@lst.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230301134244.1378533-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0014.apcprd06.prod.outlook.com
 (2603:1096:4:186::11) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA2PR10MB4524:EE_
X-MS-Office365-Filtering-Correlation-Id: c381779a-ce0c-4e12-7de3-08db1bc7c773
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1l3egvjX2crr6AANRLoEjbqoM0JPPJkfT43/IbWTnf+mnBSvURYgBiV2wRLK6H+v6xKGBF/M3ENz2YHEk2X/jCovdSyVNxuw94LThTwgyDmqvKJA4QgRRCWn/OYrlacserhufpoBp7GxCpfA0yr/+eNgeZaLUFkbXTGzIqt+mqTIPR4Xz9h6fdd1FfZD7lpPqCcWCwfoyzNJlOYnESwYUlmfGrNet3jKCNBku+MD71N5ts15jFtuRRxtZp8z7L6FA4h/I5wOTCI7TkufUy0sv7nx2Q7LsF7WSlVL8GZ5V78uD8zvUmkzhZnOyhBBBVWlGparwGl9yHjcLIuTWe/B+1jFfHRxTHw1M8cESRzVq01nHOrzXteTvN3p8sZsEJCCDdjx5GAzM9DClg3mG5DA5NkmHjUMbcqC8O+oT8uM8XYKz745FjgRc1jKuQvQIi/cU4vn6njfYKp7Q1dRmAdm4/CGHV5v3rpCddsNzmmpc9zH0hhc9U8+LCZJ8bwb0yll5d29g0GuU8w2FHkfg51x2Nl7dBb28H6v354lMBFwtI/yzRGaSRbnFDxVWAg2pA9I8IWtO5MvI33EpNnASlJSxlfyJqI2d8MmLLXDXX3A1mjXvLDNtlBwLJ/Lgywd2AgmU+0mjRIShhamXHeXkqyjUqfheBKhP7FXFRPslPXn8Igti2i0EJ3wc/kcmV11MFaZUSfmL3f5zWOboer41jAzl5mAblQfiIAeUG/FuQFMQMI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199018)(36756003)(6512007)(6666004)(53546011)(26005)(6506007)(6486002)(2616005)(186003)(41300700001)(4326008)(110136005)(316002)(66946007)(44832011)(2906002)(8676002)(478600001)(5660300002)(31696002)(38100700002)(8936002)(86362001)(558084003)(66476007)(66556008)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFM2RjF6Y240NERBMzh3OHNDTkhvZS8rS0U5RytyM2MyUE9sVElacGszZlZP?=
 =?utf-8?B?UlRvcUFEWmpIMENod0g2U0hINHVwZ1habnpQL0tZM3lPa01neXFkWnF4ZWZp?=
 =?utf-8?B?bksyNUNGVlpEMVBKME04Q01PNGMvcnRobm5SU3hGVFZUd0ZyQm5Ma0VvVjky?=
 =?utf-8?B?ZGM3cjNzeTdlSVloZHgxOUh1YlZaemlnYnFnZktzKzY5VC9pSi9TZWlHMmZ3?=
 =?utf-8?B?YzBtR3l0NGRUZ1pxQThZRVAyZGMzN2FGK2RkNFZRbjRBQkdMY0w1WHhWSmw2?=
 =?utf-8?B?ZFpzdW9JSVdyTDhTWkZqVjh2K2x1N21aUS9nNnF1d2Q2d3dnL2hEWVJMdEdD?=
 =?utf-8?B?SjhtVnpRc2tubElSeEMrRjBncTFwUi85SEdCYmRyazFGTjFDMVByc2RocXEv?=
 =?utf-8?B?WlNVQXZXNExxTndsLzJxT2tVNkd0RWFCbVErM1N4cHhOWGVqQVNSMzk3c2ZJ?=
 =?utf-8?B?TjFjQUV4bmhnMHgvSFR6ZjRmWnZ2SnlWMjY0MVY1bXpXMWZ6MlFod2loTitl?=
 =?utf-8?B?YlQvdmlpRWZqUmNjSnJ3cEJOZVNlc09xdGFjUnBqTXd3aUtaaEg4NTVLbE1P?=
 =?utf-8?B?ZW1kSy9iTmZ3bVFYbnl1R1ltM0I4UkxLMGFNSkY4WjN4TWpxTU5jQmJiSWVv?=
 =?utf-8?B?ZEs5WWx0QytRNFJ3bjVtRlJ5bVpLNkE1SGZ3TW5mQmxGZUdhWERscnBLTHdk?=
 =?utf-8?B?UGljNFNCTXpiTUMzVC9FNWcvdGFHcE9nWDJ1ZXR5dzVMVkZFWURCQ3dTdEM3?=
 =?utf-8?B?YjBiVDl6dlpwelRObGhFeE9Td25xa3o0VFVod3ViSFk0cVFaazlMemM0TWtv?=
 =?utf-8?B?R0s4dDNlMWZwMnB3WmlPMUljOGxUaWszaFhDU3loRGV3c2EvbWxVSWZsWEdE?=
 =?utf-8?B?WEVOL1JZc08rUGRoTHdLYjhzT0ZMajFJa05Gdkw1azRkZmQxbGU3V0JLYUZr?=
 =?utf-8?B?ZXRpWi9La1NLNDdCUlVyTnFzUWxIcnRZRXAvdTlqY21zK2xnREdKa2txRDNy?=
 =?utf-8?B?K3pwL3lFemltaGt0aXVYeVdoOGoyS2REN05DTXFQTVRLbWMwQ21OSkxsTUky?=
 =?utf-8?B?VFJrZGt1cEVRRFhLZXZNbGlJOGhsQUR3UTJ0RFdyWHNJOXhiVXZuU0Rqd0pS?=
 =?utf-8?B?aGFBZWtaMXZRR2J0TWg0TGo2ZlEyWTJKVE0wdXFNeW53NldBMk1PK0RsRVRL?=
 =?utf-8?B?eGFFemJtRFljckNzc1VkT05ZTkVHT0RNMXZFS0dTRjB0aDJPYTJYTk1BazF3?=
 =?utf-8?B?K3NQRXNpTzg1Y1RGcnplV2tJMk9vTjFPaTlTVHBNbVMzRmhNRU9xTE9SR0Yx?=
 =?utf-8?B?aTJVNTZqSHFuT0prYlBPejZacEZhUnVBcDhINVFzOHRWWGFVYmg1UHAxTWNz?=
 =?utf-8?B?UnFFeWhrQW1iSGV3Z1pFYUkwSTBGZkk1MmdwSHNYbDViWHdweVphaTZScWdD?=
 =?utf-8?B?RVRrVWJXU0FqSjc3RnRCdGFsQ1JaQ0ZvOTZRa0dmdHVXY3llL1cvM0wyRmtn?=
 =?utf-8?B?ZU04b3d1VDBNZmUvcmVTNWQ2OStPS2ozYjUxVW1ockorUml2Z296bVFHc2VS?=
 =?utf-8?B?b2NBenpMRmVNMFJ0L2dNc29LMUYzeFV3OTdjTDJ1anVnVzBUREhFNG13RjQ3?=
 =?utf-8?B?ei9SdDdPdW54SkpISTZ4YzNIWjUyRm9Nb0tXNVdTSVNPb2Rsa2tmcHpLcnhJ?=
 =?utf-8?B?bzhLbm1wajRocUF6U3hFbklIZWx0R3kxNFJVWkZ6Kzl3b1l1cThWcUI4SDRF?=
 =?utf-8?B?TUlGU2NxWXZXMGNja2Z0QUVTeTg0NzN2MW80aUpBbnk2UkJXb1d5QVZvRXh6?=
 =?utf-8?B?anNzbnNmMS94VWRrUTdWaUNVUU9HcklwemtuK2ZlcE9vd3E0ck9RQmNiMVR6?=
 =?utf-8?B?SVU4ZEZ1bjhIeTNmanhkN2FmLy9qWnExS2dYZndyS09wb0FSOVBTSkc0TjV0?=
 =?utf-8?B?bmtuaTJ6MDI0NlJuYkFncE5BZWhSQ3lHWHF4Nm5NSE9aUTVEU08vQlJzZHlp?=
 =?utf-8?B?RWhxeGw2K3NheDZoQU12QmYwellmQlRLNTNzNmxDNnVTNjBudWhiSko4T2lX?=
 =?utf-8?B?MVk1YnNRMUVRaCtQWE1RZ2lWT1pFbjJ4QTVoSmtLaS8rekk4MTR0ZUsyTE9E?=
 =?utf-8?Q?rpf/6ttz2kOhK/dIGTBlyUbF0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +kORkLi/ouPy4FB8dPgbIVxfy0IyZKxrs8cMx/pSnY5mSThj+N3DJP+5CL2DiINhOBmkrPBsKpRVMqHIa9/7hAowPAS6NOtP7IvJdeyIHHEiIQsvsZAyJ75/9CMi2WZuYrZ7aqS91n+xa8KcFkgxLp4Z0OkoYI9YOEBrfUfKpRF3sqB0eGUBRf/L24Rttp8UnhKW4LbMFTy+eCuXKgFZ1qbuAMaCvybje9mXS3JRiGsVMI02KKsPRdcfDlqTGaUzGDgA5aRz7tCavq7TxK3sI5tsW/w5fojf5ofV3veeuPPCevscrkq9+c3raLHsF/65fpOMQ2F5ysxW64wniRjpytEm4YlFTK70U7xXiPDTvJLpbhPPbE16Fqgc+IoaV23paJEtoAsz++P+lkEHH13HEHCEEo9b1aUVWFT02xVoiPuHHwVLdNYcE5DSa4xukyD6piMbWgW8edwbw7XUuNdjg/pHP+TL+pPHvCJO8CYVV8Sx/saFjIc6kRaZcOqzSBQzlf/Cct3sAn40O3c1Wpm7uXWAq0sTA+Tw2lvkHQkHk2EQDnIbTt533PKtVc5OvdqLYiAGFt9ckekQZaKgUxFmBSswl2qDIhdwKg0aXndwo3dOghyxQbWnHJ00QGKVzjVTLxrHEPMVnFcseydYRcisTeoBLnxotZXPEs2YQZWhN1WqrKV0Tw+rmLLx7Ma+GypaGQtQDn4DZR/rRrRilBqv6vfelZJWLAWubo2sprkKl5+4yw11XXT+vChNq1/yrqw4mZggUifjtIQiE50AqTyfAisoehddpEhKrCyuWcMZTQMbOh9o2xVROYa/D+r7Ao3hGTrJDUQZNfAGGx3kZx/+1WdmC5MB6Bk5K+qqekJQq7Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c381779a-ce0c-4e12-7de3-08db1bc7c773
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 09:15:06.4858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Auix9kVSSYZg4NA/kdPSB0D/6FwXTy05YbH8fzJaYdXOh5dF0lywzuIeoyYZEDUUrn2K8hXcsMeyOEXsX8tug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4524
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_01,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303030082
X-Proofpoint-ORIG-GUID: QKl0TwF_SG9H9-XUqMm19A6LwqKBjryD
X-Proofpoint-GUID: QKl0TwF_SG9H9-XUqMm19A6LwqKBjryD
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 01/03/2023 21:42, Christoph Hellwig wrote:
> btrfs_encoded_read_regular_fill_pages has a pretty odd control flow.
> Unwind it so that there is a single loop over the pages array.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

