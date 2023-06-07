Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0C1725BC0
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 12:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbjFGKnk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 06:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239645AbjFGKn1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 06:43:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E572B124
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 03:43:25 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3576K1LU006056
        for <linux-btrfs@vger.kernel.org>; Wed, 7 Jun 2023 10:43:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Dl4OECrXKyzdfnpTnm794eFQZTF8cHi2Thdjju4r/UI=;
 b=emTzPuZpF+3pA3zAa2tAbyzxSHfhZ+wjea32AdRHsU3qiwhqzWrzF3gvLDhtZSYE2bFY
 ywoqVNSn4a41y8z/Ddo0evfaYSl+Vj44uIZXm82DhOn9BSqSasxok5d+9xInz9PGyc6T
 wuiXRrq8exwLZGSiDmqkUE26Oo8ZtXldU/7ajVXEUX06qlHhKI3NTAAT/lDD7JOEltTX
 9duc8+NltWeGze76l6Lt1GI35+IrpfNB0Xt0tcFBXOZw3amJKx74ofrmVd9Z7YJz/9bs
 Xooi7cxZ7xddFod7XnffM4Bs982Rj2ySQWuTeEnAxwYjIT/BGVM/ipfr4u5px6WbBgT7 4A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6shevh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Jun 2023 10:43:25 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3579jW0v015961
        for <linux-btrfs@vger.kernel.org>; Wed, 7 Jun 2023 10:43:24 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6kjj8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Jun 2023 10:43:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifpqhH4tImbuE47yf6iC/zj7NU+ceWMr2DT1AV0SMslvCY5Coirl2thmB7R879RVHUO8czPcMSb+M119WOrpE8VxY4pKQc8QUaobDJdrhHFQUYPQ6C7tv+29HaxSt+hH589DT+KpdCpdOpLW8O0A7xoNd6+XRMZ3qOtKtDKefmqsG4Pf5xGzrCZZuy8R4QxIuPEznsZKu358XfnUY28cC1uJmrOpq7G5eoIYeIILfiNbAg42DbUpIGKUCEVe6QGVJCsaoj6C7ZbqCPM/c+/iBHUX+pp4LZjBYgHvNEg9SLwOiCpTxevLIFGHMGGOGr1gyALmIWe5TxfWNC/+kMCyow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dl4OECrXKyzdfnpTnm794eFQZTF8cHi2Thdjju4r/UI=;
 b=NwB+mnph3i9TMUGVyfWY8crUXETUETk+/D+TzolYYl6eqJsR5YtVKhi5+wV1lfA0RX+CMDdVQUf/U1e1uPvoang5T5mHXjH92qFHaybgQ0ARujZsP4fMFGNGcxREInsLz+D4IwMHGIN1MQIE0tu8ecHmoMhr2giYquAKu20COGwVcLhwurTC13rbsX2/HUwMYBELiSAeGe03IZJCwWETkZpEJDR7wFM4NL5uri5+sAUxjCwE86FWCGyhb+2DOG3Zfq2YOb2Dl3SHNX4jW7HLEOIM4L5vvs1KqhPEdranb/smNSkQNZ5viqwwMMLb7n3rVZJ1TruKzimxKVKZaN2ewA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dl4OECrXKyzdfnpTnm794eFQZTF8cHi2Thdjju4r/UI=;
 b=aeyJFPewlW791HoaGkIgoqf9EG0jV69MmeEmw0IqLEjRM8GJWYdHlNd6EKR2CvMa454vQT2U3wSZWnHboP/LYlLzOGZdIakD0hhjng+ZKVIQlimc6KXZeHhEFOixmo5h9p7rmrO3gqzuvX3n4qLSIT8WsLKKAdlVTGIRn/dXfHE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4441.namprd10.prod.outlook.com (2603:10b6:806:11d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 10:43:22 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 10:43:22 +0000
Message-ID: <d85b0ba9-968e-2210-4722-0ed28e3a2548@oracle.com>
Date:   Wed, 7 Jun 2023 18:43:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/9] btrfs-progs: btrfstune: accept multiple devices and
 cleanup
To:     linux-btrfs@vger.kernel.org
References: <cover.1686131669.git.anand.jain@oracle.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <cover.1686131669.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0089.apcprd02.prod.outlook.com
 (2603:1096:4:90::29) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA2PR10MB4441:EE_
X-MS-Office365-Filtering-Correlation-Id: 332d330e-9a92-4f81-a29e-08db674403cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tv9usJjwHItpYEqqIzBthCk6gP6ugfmNgirExl+qtGGW8exGpRznBMJj4RZeGnAGD09nTh4T0pNqMp7MVGal/vO5wXrN2R9HzziCupvBP7WPRvVgI8zt+wesHcyQFNyN0cIarKNP6E1XQVz+oepELO9xN1cs/f4qM4q/V+6QtB/7ghHkiQKxzyXZI2CSsA9ABW/FMCZy526vIcQChrzEJC5Uue8enVdgPe9en/KFK7w+rC3zf3NcqEppsUiyAXSQ4mfQHLliu1SqDkStw6WghL7+s8rdR470nyMkhl9Xmh2sGyOvTa2LXIJXv2Pf07ZMTDIRqnbTMH+WVGLKdVHHafATvComrus/5Gk7KB6a46g5ksJv+skkJngbetMgy+K3HsnfIOVTB+/Zfv62PdOkjiR6woBXtw/d5YurnXrwyNQmGblcXmOudNKZRRsUMPwMOdiRy8nP5T3oeQvAJ1UHWJX534ovmGNq9jETP+Q/d7IZF0eiZYcLSQT1+7fLCuQPpPNMDb1AxfwzyXAx0v+54DYqjsXqN5L+nItXgGJi0BRRJiosLUwD5QpphSGt3ItjpkyjHW/6lJ5wK1+ZY0OajQanmo1CnKD44ZBaQhzI/nfBrHt39ZD/cU0npXuDosypimZJze+1ntX6Q/E1UxeqVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(376002)(136003)(39860400002)(396003)(451199021)(478600001)(316002)(6916009)(8676002)(8936002)(41300700001)(38100700002)(66946007)(66476007)(66556008)(2616005)(186003)(6486002)(6666004)(83380400001)(26005)(6512007)(6506007)(53546011)(31696002)(86362001)(44832011)(5660300002)(2906002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1NBUHMxMkZvQjlOT3FJWWRHSi9VdEFjZi84TDBoeUxBVkdUM1FYRHpqQ1FR?=
 =?utf-8?B?ZExvVnFtN0NzdnNsVTBGTHU5eExwQ0RWellWN2xMcjRxbnpJQmpiK1FGUGhH?=
 =?utf-8?B?aG9iYVA2K000SktJTG93UFdCRjQ4TjNiVzQ5N2R2cStsemJWaW1SZk9EMkNB?=
 =?utf-8?B?S0hMZmJDQWRzcWpIZitkVDM2NU04aUpMT24wZGV0bVNiVXVzcTc2SklHU21F?=
 =?utf-8?B?TTgxcndCa0JCUFBwMlhkT2RSbW81blZmd3VZWWxTUTh1THZ5NGxrSkp5RHhk?=
 =?utf-8?B?WSswTmpqdG9lL2c4dzBxejVHNTJLL3EySnhTbFg3VnhMbjFFWk96TmwvNmtw?=
 =?utf-8?B?Sm4rb0Y4a0hibU5ITWo3ekJJbk5nOXJIQzMybkY1Zi9oVVdhclRxNzVPTVFK?=
 =?utf-8?B?VFlrWC8xSy8zSlAxdjJYdUlPWXMzenVTTURLcUxBUm9makxpL0l0K0x3ZTVm?=
 =?utf-8?B?Tzlad2tSSUFlcUtDa1NKR29XQkJ0bWVvVnF6NUk1b3VZNkEveVpEQ1hBclQ0?=
 =?utf-8?B?NTF0MTFqVXRwU2ljV3V5QVB0N0JwN3ZqanpxbGg4Zlhwdm80R1U4R3RGVE9I?=
 =?utf-8?B?Y29wTTJXM2JYWWhGSHVGcjVoS3JjclBuZEthYWlSNHJuVzFHQ1I3b29LRVNj?=
 =?utf-8?B?TmF0WEFLbnBOQ2tjYmFqaDJZYXRiNzF2Y0s2VGtYb0FobnVlZ0YySUFEaUdV?=
 =?utf-8?B?YkxRM3RnT1lTeWVkZEkyK1dJTER2aDVtaDRJQ1AyTk16Tk5iYjgxM1JUTkQv?=
 =?utf-8?B?U2REck5YZ2FmY1dPUmtsWXVveEtGaFh1a2NvQ3QvYzJrMmkyQURHUXh2NkMy?=
 =?utf-8?B?MjhQMzhKTEl6Z2E5WWNXRFhDZWV6TU1JZ001dnFYRDVwdnJ1MGxBOWVMWVRQ?=
 =?utf-8?B?Ymwzc0lCWG8wb211UDIwTXRUR1VYemVxMmlGb2NKcXowQ2ExaDRlMWorWUhF?=
 =?utf-8?B?SlJOZVU5VjkxZWxLdTRwRXZNWG5qU05MaFo0YmdWZ1NPbE1NU21lSlJsTGpC?=
 =?utf-8?B?VlkvN0R0eFM1MXc3a053VGRLaXF1WnBSWjJ4emxNeWlkTm9Db2ptZjRnZUlO?=
 =?utf-8?B?OVJIbGwwRFluRTExN0Vzb3pQS3ZoVm5lSWdNWTE0dXJ2VkpxVWtTazE5bzhR?=
 =?utf-8?B?czRNRGVnb1BGQjlrVWNxK2hCMGdjMGQvRGlxeFZZekdNcnE5cUFFdExQU0FI?=
 =?utf-8?B?d2x3TE1NY1pzKzBvODhXT25CMW1hMkt6RzFmNXRGWlB3UUZpZ2l1TjFCS0Js?=
 =?utf-8?B?Q0ZqTzZjYTN6UWhDeHhaa0IzQXpPMzYzTXVVQlZJb3l1bm03U2NFOHRoaTJm?=
 =?utf-8?B?OTIrQ1c5QVpXOXlXNElLaExKTElYdzBpeCtNTnIraEpwZldQeGo4YWVuS1hR?=
 =?utf-8?B?b1MwN0IvclgvYStKUlZDRFpjMmNKZ3A0STNOUWtucnAzeTM4OVNicEs4bG4z?=
 =?utf-8?B?Unc4VUg3aHdzS3NDei83cGdYZDRvK3J5QWgrNnlJTlpNQTFGZTRJaEZxV0RE?=
 =?utf-8?B?YTZuRjVTQlpnNy9kTG5rUUJja0NNWDNGUWZSd0RJUHI2MjhrSUZsRUNMM1Vz?=
 =?utf-8?B?dzNyOUVXSDZDUSs5Ym9NS1hjT1h0akYzYlZmVzJ1eFdmQWVpSEdHZWMwVXg4?=
 =?utf-8?B?ZWJoVS8wUGpkN1d2VG5pV20yNCtvM3lhaVFMb3duQUJrWmxDNFJ0bUVsY3lL?=
 =?utf-8?B?aHNBNlEyc1FXUFkzSDB0MEdZa0c0SU1CRU9zUWJvd1hBMm9yc1JUSEJTczhu?=
 =?utf-8?B?bGhwR3R5LzJqd2ExV2ZKeUxrQytFempBK1lHZk9mU2N5UDJQcDlFNVVZUCtZ?=
 =?utf-8?B?R2d2SDRlcld0blFmWWFIN1FEQ0g2eDZHY3FITUQ4OHpHSitQb0xHRDdFL29P?=
 =?utf-8?B?eTFJbzMvYndKTVVXbkl2NXZrRDdsR000Y0l0TGl4anVDNjVFTWszK0hDbnMy?=
 =?utf-8?B?TEwxZlIyWEI5T01VZFNDLzVPclptdHpGWUxoY1RGam41eURHcktQcDRKbDB2?=
 =?utf-8?B?MnZZSUFWNkNvR21iVHFKelRWOGtiK1J6M3orM2djRUhXWTNHaHVjZ0hxaEdq?=
 =?utf-8?B?dCt2Z0RoYWlwZTlXbkxRc1FUNWpZdFZrT2VMbkRad3R3OXZaSktmZXlIaVg0?=
 =?utf-8?B?Q2tHMURubzRhTlZzVDNmV0t5QjBMMEZyVWZnSmNzaU9kcHdVVXFQbjYydU1D?=
 =?utf-8?B?S1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /+K/44gz9Qa5N3XbdmxlRo0rRsXZJ5L1PgnW2lvdT+NzLlHzADLr2hnDDiy9sx5HgXZjskmI5/yLzQsr81qpX/tTa8Cbax4yfvKo59da/Vy5dHb3fEkjgU+fQtGsRVYijcfjiCgkGAlmaU9Xn6AyrMZ+JC+pYQgc1yB2jZTo4Xfex+teARGHaaTuJXbKGrVMF6qaktohbeVH2Gpexmzeq1t7MIbtGxRVpQxAWFLM9TzXrOPZ4IlWVX663x6nKXVhXTmlkrGhcGV2NiF9Z722pepn/d/W+0TtnQ40A0Ful797iC3ZCK5OxUlKuqT8eVYJnG4xCbN2nCrnM6xVm8/H1WsEWmenINkfKHBmisyYeCyIJC251PcEhV+1FO50xQGDX1C/GFwZA0sNu2S3QYot0DJYh2J49BeKmB1RO5M9m4pPEoQEBAC5Yi2z9/UOr5vcO59Kl3Jpjy8nXOiKcPTSYYlXJcSakuizAt9e6Copy1ImHOGKTbOWpUJQIDDsTfBlGxybcbkGVGEQYC+WE5s1KGId68wYPWXcl1l3fExkRE1LtA+qbPH9d5JDzcDmx7XmJI716QW56fydfSiwV6lqTZh+9/+VGRtOhwPr8G8U59Dhs+q9tHU7kIhnMn/x17li1juIkWv243bSq6CqVUd9D/syuvoXssXrguB+FG67w3G+cpCfYK0EpN4+cVW1JWbxR2CoEr/kCQXslS7grePkpVW9a3k6VddL4wfc5XTMyK9m+YAafHtTobc7kVpd/7jS6NMmoH9gPWoK7/Q2Rtffbg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 332d330e-9a92-4f81-a29e-08db674403cd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 10:43:22.5008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dBNZW2oaa+MdvIrCPXiD3qMHeNFtU4jBX+oXSAYTAjDZRpO2sbpJyvh49Ikf0e91gmDOEuGOh6sw24bvuCcYxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4441
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_06,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306070087
X-Proofpoint-GUID: O3uAeKpUzc9XMt1c5kSnRllniAvgGyFB
X-Proofpoint-ORIG-GUID: O3uAeKpUzc9XMt1c5kSnRllniAvgGyFB
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Now I notice that for many patches, the Git changelog is empty,
even though I had it at one time. I am not sure where they went.
I am recreating and resending the whole set again.

Thanks, Anand


On 07/06/2023 17:59, Anand Jain wrote:
> In an attempt to enable btrfstune to accept multiple devices from the
> command line, this patch includes some cleanup around the related code
> and functions.
> 
> Patches 1 to 5 primarily consist of cleanups. Patches 6 and 8 serve as
> preparatory changes. Patch 7 enables btrfstune to accept multiple
> devices. Patch 9 ensures that btrfstune no longer automatically uses the
> system block devices when --noscan option is specified.
> Patches 10 and 11 are help and documentation part.
> 
> Anand Jain (11):
>    btrfs-progs: check_mounted_where declare is_btrfs as bool
>    btrfs-progs: check_mounted_where pack varibles type by size
>    btrfs-progs: rename struct open_ctree_flags to open_ctree_args
>    btrfs-progs: optimize device_list_add
>    btrfs-progs: simplify btrfs_scan_one_device()
>    btrfs-progs: factor out btrfs_scan_stdin_devices
>    btrfs-progs: tune: add stdin device list
>    btrfs-progs: refactor check_where_mounted with noscan option
>    btrfs-progs: tune: add noscan option
>    btrfs-progs: tune: add help for multiple devices and noscan option
>    btrfs-progs: Documentation: update btrfstune --noscan option
> 
>   Documentation/btrfstune.rst |  4 ++++
>   btrfs-find-root.c           |  2 +-
>   check/main.c                |  2 +-
>   cmds/filesystem.c           |  2 +-
>   cmds/inspect-dump-tree.c    | 39 ++++---------------------------------
>   cmds/rescue.c               |  4 ++--
>   cmds/restore.c              |  2 +-
>   common/device-scan.c        | 39 +++++++++++++++++++++++++++++++++++++
>   common/device-scan.h        |  1 +
>   common/open-utils.c         | 21 +++++++++++---------
>   common/open-utils.h         |  3 ++-
>   common/utils.c              |  3 ++-
>   image/main.c                |  4 ++--
>   kernel-shared/disk-io.c     |  8 ++++----
>   kernel-shared/disk-io.h     |  4 ++--
>   kernel-shared/volumes.c     | 14 +++++--------
>   mkfs/main.c                 |  2 +-
>   tune/main.c                 | 25 +++++++++++++++++++-----
>   18 files changed, 104 insertions(+), 75 deletions(-)
> 

