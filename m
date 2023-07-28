Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FAB766280
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jul 2023 05:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbjG1Dj1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jul 2023 23:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjG1DjZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jul 2023 23:39:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF7EFE
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 20:39:24 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36S1hs16002146;
        Fri, 28 Jul 2023 03:39:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=zA7ZVulDHN/eC80bN/aXNt1D6VpOzC33ayyPYjjk6fw=;
 b=OJeBEvhC/vCxYZMtNrS6wEJEHPnERH4FI8Hd6SGiIyzvu1m4S2NVgfxqAhITkPqVufSr
 zU/T/mJXunBZ8cfHkSjQH38jD984PILwAx42rYepiVnWLD9jxdIBVR8EVlTZbwdJr0q9
 PbrNLGvWanYMJRGr4q4w9NLg3haCcyp/vWecwuY4ptbFvdoJzfaVMfkzEAnl716N5AN5
 L35WDwM64VkAV/pb9/aR0JbI9TQkGpL79ippFlzjtkf1LOubF0YcNjiS+lNURD2SCFgc
 fY/E0cKYmb9nRWI6Q4NzdMiK5eKKzDD34jagggJ2+ssY57477Y/IcBb4b/tTIGxw2x3T 4w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s061cb4rj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jul 2023 03:39:21 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36S30Sem025389;
        Fri, 28 Jul 2023 03:39:20 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j8xrdt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jul 2023 03:39:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cjsOR32M8yB4Xa/6jb5M6vU8Q7XdpkNAyq5sT7t2D3CQ9wqrfk2H/vcwyDTfWy61n8W2Hj7PSRowgLmOQHtw4ZnDbgW6AEGeV/IoYmDIE9FP82P+6DWigc0zMtZAjpaYUFhc5o7GogdfBs4lsF9rolrfw+7gmSfrbBFsPiuarC1O0bGkXK2/IwPOzzuxXVr9SEA3KLRuy4xZYCe3uOYRMoNFzhppavM8aQ/zEvvnVPEr+AVb395y1F82BYfYO14Ewlb9NFk9t3v5PTPh4kMN908EFINpazkPY0CXrELqE9votqlv65/+3XyNttArCw9zRdX7iRFBVrqC5gzoOAuVtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zA7ZVulDHN/eC80bN/aXNt1D6VpOzC33ayyPYjjk6fw=;
 b=AxwOboDDC2pjpLcHGJ8yoqoa4T9IlWv/J59FUKgS7jsflrPWMx6ZxwIbbecxMsRKSyXtx7oVVfGDdGMBvhWk2vUb+8AThfW7mFEc4bdVGlramLxyA2XZkUv/SW3y7Ym2E9/+7tcBT3q6GyulE3avaCdYqvmKHhb9FP8g0hnRmwVI6NilDtz5p2Y5GBgnzUuh9Y7viM3zmG9YB5n8ft53w20LqvIUwJ5NhpO1Ijbb19XDmyTKD1mbOP1QC+aV7JTyi/qzVTHPKucIPUi74AVXBb7W6lnS+uN/o4RLvr/Mn5cG/HCabWrnEFLOFaB3C/2liFMiSHVqgOQBKH8Sdss60g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zA7ZVulDHN/eC80bN/aXNt1D6VpOzC33ayyPYjjk6fw=;
 b=dXHLeMk8X1/8rPQzqv7xTRqnFBVwHt+DYKK6IbMLM0TW5wdr6tfirudm4pBLdiCLABHL1k2QKbLAUfkmoaOtVe1PYtm5xWYDaA6N5UcmYSnkKUvnfkiZdLiUXS5hnDAHQXvt/AV9Ov/cxV2+ZBqaw5JNbcPSWriPO717KwgXTxg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CYYPR10MB7673.namprd10.prod.outlook.com (2603:10b6:930:cb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 03:39:19 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 03:39:18 +0000
Message-ID: <155356de-ddfc-118c-eaaa-9dca8f2401a1@oracle.com>
Date:   Fri, 28 Jul 2023 11:39:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] btrfs-progs: tests: not_run for global_prereq fail
Content-Language: en-US
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <149265ca8a94688008c1cda96c95cf83ac55950c.1690024017.git.anand.jain@oracle.com>
 <20230727165157.GG17922@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230727165157.GG17922@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CYYPR10MB7673:EE_
X-MS-Office365-Filtering-Correlation-Id: 4935483d-f507-4e94-ab93-08db8f1c3939
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IYaqdN4LYfslvDW75q1m6DQS9HG4n917pN/zj++e+wGxa4d6KA+lagiTH9SeqZGpRslVLyBYM9Ub4WBSl28Rz0AXWifmW+iMjyMoCiV1ccZafg04f5DL00sy0VvmhkcHzuLlq8HvktSpywRnpp3hipm2C13X+BOzm1Ao9+tY/o0oXYJZ0fJvcfJXsHdSKBx9kIBKIkh0ohgSR8BXwPLIhXYSUo3oqRBqkVf/xS4w7vkj8RfA3/0LvyztyKEEjh+vwH6lG2MfERmIMdsbBPj5UWFtB8ghpVmY7mbbUFLFpJvxAEVfI8kUKS6xsMu4tA5krM4V12iFy3Ex84Ljo4Cd55FDX+jgAXT71A9NJ/OugJ5DSu0Ch8yi09/3K/e0OlPAgEZykDQngEKae6f12ElrWGezaZ2hXrgPU9ReB3OJ5OtbH8h66jLoZ+w+8wm5xLxR+v5yr4XLjToQoW0ifBQgH+mMIEB/MvKWb8KGwThhQWLybG7MZ8msi35ftwdtZIJoGQKG8Y+pLIL7jqWu2vN8NyIblxxb68IaLVxW5HdBg0MV0YjRlC3ushE0vl9HzAEWjw8g4lV3MOGJWWTYNCORb3rSaBDv4RMhoIdrZeKCPcj09GekGRARvKrdIkU280SQyPYgIVKHC6mXHLBPLujJ9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199021)(6916009)(66556008)(66946007)(66476007)(26005)(41300700001)(31686004)(4326008)(6666004)(6486002)(8936002)(8676002)(53546011)(6506007)(5660300002)(44832011)(186003)(316002)(6512007)(478600001)(2906002)(2616005)(83380400001)(38100700002)(36756003)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFNKQ3RBYmREbUpOU0toTnJKV01USGxRa3Ixa0NnT3ZaWVhpc01XZnZqU0l6?=
 =?utf-8?B?eVlZenJ4NzVUcFpXWFZkdlI2SlVZMG85VXlrSCt1SWZ4clFXL2phWXBoVWNq?=
 =?utf-8?B?VGtXY25vZDlEY0RiS0ZSQUpoTG9rRzdHbTZnRnJ2ZGRPQ2tsSnNBWFJ3N2Ja?=
 =?utf-8?B?VkFmcnk2OUhQL3M4VXZ2Qk9ZZHpBaUVZNlorQ2VIV0xPUENMZkdlZGptdTU1?=
 =?utf-8?B?TUs0NWV5cXVzOThXZW9kZTFaZHAwbDlCVlFXMi8vYjF5aVZaQzVrRE50TWQr?=
 =?utf-8?B?aVlsd3NYT3orbjBZaElkSjNJelpkcXEvN1A3ZXpwQXlsMUliRjNXYk44UVdj?=
 =?utf-8?B?V01RN1Z4dlRsOFhUUzJCL0pQK1YvUExFQ3Z1d3lhSUwwWmhkeXdZQlFFeU9D?=
 =?utf-8?B?Nm94U0V5SG5XTnpMZjdVeVFNQmlDZlVYY3piTm5kMXdhdDlKaGQxRlpKWjUr?=
 =?utf-8?B?Q1Y5QmZnZ2wxOEViK2RzYThGYVlRVUsrSjRaTk9IYUczSTloWFlpdE1Scmxv?=
 =?utf-8?B?VjRVQVhMWDVlR0Y2c204OGZnTnRKU2xET3pDb1Z1Q2lJNjRNcjlOYmEvM0lV?=
 =?utf-8?B?RnorbU1aa3BFRkFKU2ZRdVQ0TURPa0RiZXhIZFVNWitUQnJCckpTNC9RMk9k?=
 =?utf-8?B?Z0VXbVJlM25Xbkc2NFl1cDJ3NlJUV2VBalgyQU8zelh4MitYd3ozQ0ZVVnM1?=
 =?utf-8?B?Ny95em1aM2w3M2xMZjc5a0VGVEtiQzVxYkUxaFIybDYyMGZnT2xmUW9XYnRz?=
 =?utf-8?B?NzBhY1dNa3lkMjlmZHdKY1VBL0dSaTc4Zmh4VXhmdU1rMkd2ckhCZTJHU0c0?=
 =?utf-8?B?K2thaW1KMnVuUFZuNEpHM3dsaUUwSGpuNnVUYWpRaXVodFI4YVRkSk1yQk1U?=
 =?utf-8?B?SHArVDR5YjRsTmVkWlZraGZWSkFqL1FMSWR5U0dBNFpkWitmWUN0MWhKZnlQ?=
 =?utf-8?B?dy9Bbi9JUjBPN0RHbG9sdVZBSktXN2txdjZVNnByT3pMZjJSNnVtOFhENXND?=
 =?utf-8?B?cCtycHoyUnAyM3pCMmFZZzMxY1J5Zk8rc0dHWlJhMVluaVhrbEhmY3VrcEts?=
 =?utf-8?B?LzRUbFR0eWQ3NlozTVhCMWkwSnMySDdraUtjYUx5eXdjVi9yM0tkakxIQXdv?=
 =?utf-8?B?bmMxeVpyQXk4SUF1VGErRS9BWkp2cDRyTDVCay8yUnN3NitZaC9xU044YTRP?=
 =?utf-8?B?SDJrVGZQRXU4M1JmeXRQc21ITzdmcHB3NVZuRncvRkxrN1Bod3o4c3JmUitG?=
 =?utf-8?B?bjlGV1FSWXhoWWdRVWdCekJCRlkwalRpSE5xWmtTU1VvcEpEK01FSnd5RWF5?=
 =?utf-8?B?TGs5cnFzZnlMbVdyak1SNG5qQ0txeFo0TG1rTjRXYTYvN2lZNkhIMVRTOUFt?=
 =?utf-8?B?SnpLVmFZaVNIc0lhVEpQMENSTVBWVDk0NjBYRkRmc3oxU1Z5YjYzNlNDMi9I?=
 =?utf-8?B?WURHNFNMUGFqYjVtTkxHYUFoZDJMWFVIaEo0NTBBNWZ1UTROdTU0MVBPaTE1?=
 =?utf-8?B?RDNFaGEwMWpkbmcxNEpFaFdid2hjU2FMMnNXcWo5d0pteXBqeUltL0ZCNDIw?=
 =?utf-8?B?ZFBOOHQ0aVA5Tm4rQTVDa1ZENDcwZURrRUpZazBVZm9GVVlvdXhCYlE5ckw4?=
 =?utf-8?B?amxQaDhsOWphK2EvcFJrcWkxNDVUZDNOU3lhSjRIS3U2cnpBSjRQR0N0VHky?=
 =?utf-8?B?LzN2Y1VKU0RIV05YSWlSRkpQcWhpaktQd3QvUkIwQzRUY1JMSW5UTmpjRFRs?=
 =?utf-8?B?QldKbHdxd2tXTHlIVzZjcE9LYWpPSFBGR3pyVWxYcjlXWjE2ZFM5MmxPZy9Y?=
 =?utf-8?B?SnZvZkZwd2FUcTQyT1NFM0ltS2JicUZKaXVHSlJ0S3VDNVpRSkpJWDY0eVVj?=
 =?utf-8?B?UTB1d3NaMVZlQ2VRcGlxbWl2SEkyNFcwOU13VDBIcjQxalpoOFlxdHRuODlT?=
 =?utf-8?B?cUQvNGdkeWNaWVFvWjExelJnV1VQQS9UR3R6NmY1NkNTYWxmZjdxd2hNdklB?=
 =?utf-8?B?WTk5dk9rQVc2ZHNDZWQyZi82T2hKV1BTOGxXV1AyRURuV1oxMGNJcU9vVVZJ?=
 =?utf-8?B?ZlYwV2JQL0lMSlJpa2FTbTU3RXJVNDVkQUl0MC8zdEthTUtUTFdrMHR0ZzR2?=
 =?utf-8?Q?FZ0aujyTrwQtZX9BFyVCpiZBd?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: iEB7YwQzdtCVWYzAeYKqf3/tks3zG8Oz/XtutYiPxB0VD4RfXBrlAJ+gdzkP8rj3MhbkCATxEPKTJ/Elxt75riAWSN62cw1EN3VFDRjoaZxip+e3oc9MY1MkkWd/Vunii+uF0EgnrMY2kMuE13bSDSi8ER+a9a6oscZOttZHQWB8ZtCHJKdrPCOJHlqb75rx20/hg7i66XS2M/K0biOnF9NBP51mdXH35vnqh+2jusrc80Ms/c4VIW0asZOMmINBNdDtQyNOCKRPBfuih4N20SmptScCg2nyQUmubdPtY0t/Go9q+AWoTuRV9YcnZFoMaAhIzm4QrvZmCDgk00GSKw44cxRm8JxPGiohv7H5QvGHgVg8Giunwf/673J3X4pbtDtXrCQIF4RorwLpbOk+Hz0x49yBertas1k7aV4x7b194Fv1c5WIxajdmovZT2Ib0nobvTd35jN35ho2A4lpJ+AXuMIjLf6eUdIvS5YAld9ag42MLI7D+B232z2JVoKb5J1QhJ38g0Lo1XI0uHD1eFLahWUXXu6A+mVrzCJ2AMAsp9FNyVGI4VK3lZ4eU6GW/NUpC62obuWKA97J9zhBkHTvbWdqYQETOQTVDBBGeIKsAm6hEjWUDUqb8vigBn6aQCUhaJ1eJ/4ERqyoEW4sTvrGAKB+3lBd5pdwv6LBUeJCtTj+haEHwOLzxgswCZ2rGo8nZ5Bm9xQ0uceN9rHZ4TFoMScLYkhN4nbNPxBFdO6SidQ8ue0lhK5HJaubdVKFi4d8jP3DBqcAxrQ70PaY7L6briGgujwv3U1fXuHhIdU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4935483d-f507-4e94-ab93-08db8f1c3939
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 03:39:18.8995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zwvWUxVbmZFn3awOTkqD3g7meP/NMO+8Xm/CZIjrrRrfu3ffuPxv0UoAHPDn7a0cBjYrypzLuDvOR8EoKYIpXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7673
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=816
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307280033
X-Proofpoint-ORIG-GUID: z6eXHf_aPPwLx4kPL-nJ_cvfM1ydhALh
X-Proofpoint-GUID: z6eXHf_aPPwLx4kPL-nJ_cvfM1ydhALh
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/07/2023 00:51, David Sterba wrote:
> On Tue, Jul 25, 2023 at 05:43:54PM +0800, Anand Jain wrote:
>> Prerequisite checks using global_prereq() aren't global, so why
>> fail and stop further test cases? Instead, just don't run them.
> 
> I'd rather let the whole testsuite run, a missing global prerequisity
> means the environment is not set up properly, so this fail as intended.
> If you look what kind of utilities are checked in that way it's eg. dd,
> mke2fs, chattr, losetup. All are supposed to be available on a common
> system so it's not expected to fail.
> 
> If there's some less common utility and a test which could be optional
> then this should be a special case, which would require a new helper.

I would prefer using check_global_prereq() to verify all the mandatory
prerequisites at once.

If each test case checks for a different binary using
check_global_prereq() and it fails during that test case, we have to
restart, which becomes messy.

The support for mkreiserfs on OL was removed, causing the test case
to abruptly stop in the middle.
