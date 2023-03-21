Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48256C3463
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 15:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjCUOhR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 10:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjCUOhP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 10:37:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B564DBFC
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 07:37:13 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32LE5CI5012653;
        Tue, 21 Mar 2023 14:37:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=QHGNr14m/8Q09d2PZ7c2/eY3x24/R4EbmJ0dTdFBpsjYDAYFxhZxf1S3ZV5MDH0l6GX2
 NysrfXyNprdVMQVESoBieyO0U4bdAiTsPugCQnlfRF2iI7yeWiOtdXxBr9KZwVBHxOrR
 ShJfpKQfozuHx9sC0BwXmt8WO8ak1T/e/gRBWxYuixeG4cZzNsURyNUz2XGLS16cKNyE
 HzwXWFNLingRoKpOzd5U2MN9/UxurjdMW3fcK3jIZvctESKjZDkeBDEX0IxSkVhxxsGm
 xf6T/0LLYLyke2RILVt9cVlwqrd905EFeo7dWWbmUISf5c7VLHlQ6bOm0qLK68mghR6E +Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd5uueb3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 14:37:11 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32LDX0V6039144;
        Tue, 21 Mar 2023 14:37:09 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pd3rdas6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 14:37:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EjxNITpe7UMsThSfq6pMum0s9Se/TfRVtyYvtxezCbg8NtgFBFSrvUxPl2fDJcgG/Id+Bsp4+qD44AZbDYuer+/tqlgZ/Yi5l/Snq9U8iq/93L3LLvuW3R4FAlv0Lv6qg/w5j+J51YZYPX6kgacEAzUJtmqcNQ72f+BWidkyDuq/EdsEKtlm6A9YvVdmD46E1yLbgKi6gr/XTKfHBD0xSEgPZYuCmmGFYL3uQcJKAoYA4lKrAwSEzVdGhAGP3H0Fe5HV3cEPQqKWXs2HdRZTgt0/RKZWXRHdv9qM/GI3Jz6WGraUcwFGZBecB2rYGQvYuOIMC7Onuldf+LganBWO6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=WuYmb7iOsSkmqq8jbacnONGNrkb2ksBcKjQlnp+bZjk+OQD7ASvQcj0uvi43kYH96IqSdmFZ1DULF3kV5pXgBD5y05F2ZhYeJ5QauVUKvKE3pXJe8KjN1eL/Gixs+kYNg/v0kircH6XFdRR/kDS6UlE8pa2v2/XHES8MFZ7ZPRF89Ao8KkM62a9ht2n7TBAtXGrVI7l57T4dAHChoypO7x/qKLFy9jfPm7Kh73CjLp+2EdvBERYo5u6AQnUEDuUqGm/VSryDJY9fFaqNvMVcDqC5rSnH5ZXLQVdgRjro1S08urB1+jUvhkcDrxN7sEzSzOz7/IZZKXLasDQCDgbY6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=TodaVyRGOZVOX4VDd5MCbRv6lJkPkqcbPAb8WX1Wlztq6vAZjXMHPhmqgsd3ToBfUgmD6II75q+agFmSINvWhxYtX2s0xepSxOX/nIuSEHN5O+vA+maV0voLa6L7IuVaKeh4UDMACCLmv4keKZJ7LSxxp6Hafsy8aNYINew+zhw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB6481.namprd10.prod.outlook.com (2603:10b6:510:1ec::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 14:37:07 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%4]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 14:37:07 +0000
Message-ID: <bd513137-4a62-ae74-99af-449e6fe69843@oracle.com>
Date:   Tue, 21 Mar 2023 22:37:01 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 22/24] btrfs: use a constant for the number of metadata
 units needed for an unlink
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1679326426.git.fdmanana@suse.com>
 <25c3d88a6f706ae21fa100159e0aedacb6c75230.1679326434.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <25c3d88a6f706ae21fa100159e0aedacb6c75230.1679326434.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGBP274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::16)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB6481:EE_
X-MS-Office365-Filtering-Correlation-Id: 1347b004-469d-45ea-e29e-08db2a19bf2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BM9T9WNhsDJPMNTxcTfnELaG40oN9rdTAkhkjzX2nvEbT4n+9A886Jpjmr5pBn6dySxk6dw3EUeDD6fvy/k8I92nWM75o7FdADlvkOsxXkiEffSa17X9H98sqmI0nbLPhIeXzf70ED2c/ew2DX9PHpKzatLCcYy9Efw3ChoX9FqN4xPoVyVFE3a+io5bkQlvbkQ5HrwdkcppWyiT7V2Pw9m458mqyYDwA8C8BhztnOhNsK5JC7Qo+2JFvPpfLxUztH0tjlRN5DJKMtuvxIKlKy2CUcAGTCrsNxcHTFGTB3Wfq5Sdkraj50MdA+w/0jq9APmC9WPo8vq2S16Q2ukRpUbbv+ah7SSU9sPpIVYIyVGTjrscpTrF1AbBWwCmzui51G/4Wm49mf0W030ZwQer7Ul051g6XJpfCu7d2n92C7sI2b2C7d0rNcnMybt1M04sHtzjYLVDiYu2zpxEbM709q1cDwUFGZZtR8bBj7sgkrk0xcTb567Kq8gBQ1GrIEag+VZVqrkGmAY40pO6lmZ5iDHr/vLCnTfhkIvITEjGGiuhsgovmvnQqjarmUP2Ya5CST9WGiPV7NPdGye8Dh1J1l5DKoqNSNnazbgMpua9CvjYT3yok+xr882p576kI8qj53P5SGaY7qhOuurEysGPizxYWcAzWNk4Ykvh6a6MVJMIOheaVpN1TAB7FdbAUYV2n+egk7wuiFjwBya08EEwGziHCB+3anoY7OSixyIan+s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199018)(44832011)(8936002)(36756003)(4270600006)(5660300002)(19618925003)(2906002)(2616005)(478600001)(316002)(6486002)(558084003)(31686004)(86362001)(31696002)(41300700001)(38100700002)(6512007)(26005)(6506007)(66476007)(8676002)(186003)(66556008)(66946007)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzZ5K0NBK1JDcjhIN2VLNWdzbGdyLy9uc2psOW56QUhENDUvalNIUVljbmZL?=
 =?utf-8?B?UVdpMVdSMVNSbDFmNGNHSU96cDNreHBzNDVSOHNScXlURk5NTkp0Y05BVmQ1?=
 =?utf-8?B?TWs5NXd0YTBmajljSnRrczlLRWNzVHNtYndJOFg4eld6cGhFdVlRclFLbG9O?=
 =?utf-8?B?ZFczMnZac0l3dzdEQmlPUno2VlRERkRyZWVtMVF6eUlNT2orYkVSQjBXbkRx?=
 =?utf-8?B?TFYvaEZNcVloNW9TZEl4Rit6MCt0L21JSkZDVzJQd0EwM1ovcE93b0t1aXJk?=
 =?utf-8?B?ZlIzMS8wdit3T1hjNlVKYTNNRG5aeWFGVjNWbkQ2M29HUkVWWGNob3FSLytp?=
 =?utf-8?B?NytIMGdoQ005dldtczIxRUxYaWUxYWtJczlxVUpyU0pFNExlUFEweVRpdDNK?=
 =?utf-8?B?eGIya0U5VkZpbEdVZGtrSVphdmV0enNacVdZM1QxRGVaUTgzUWxrdHlCTkJW?=
 =?utf-8?B?NUF6ODNKK0ZDWHU1M2ppczA0U0ozd0pLaEF2aVdHamhzUUU4YXlCdHNaelZx?=
 =?utf-8?B?WGpMSXNmWkJIQlJ1a1lONzkwTTJOaHBZOUU1UFhieWs3aFZKVVdSeEs1ZlAr?=
 =?utf-8?B?eWJETllFemMxcWJOdGVYdFc1dzlLTUZBYTNlU0RGN1EzZ0ZFZmVhdEdiamhB?=
 =?utf-8?B?VXpBS1ZpZWY1azZCS0R5YVcwYys1Skgvd29HOENEaDVVbWc3QnFkejI0K2No?=
 =?utf-8?B?dVM4b0VCdlluczJqOG1ETHgrS3VpWHFpT1RmTzgyT0pzMmcrNVc2ZzhoWG9h?=
 =?utf-8?B?dWs1WmJtNDF2bk1TWW8yUU45NzcyOGNieHhhc1ZKVXByaVlibC9DYTBGOUY5?=
 =?utf-8?B?QzlYN0JYM2tZd2hyQ0N2YU55OGhwWVVDNHgyMU9Nd25SUXFtKy9lQW4rMXFl?=
 =?utf-8?B?UDFzNEJZeWVkSXNaV044bWVlNmF4dlBENi9PR3hXUHpmYXV1a0RkWldVL0ZY?=
 =?utf-8?B?SGY3Qlo0S1JoVWdrazFvaFFKZVN6QWYvcmJxc1l2MHJnN3pzM2FyNzBNc1Vk?=
 =?utf-8?B?MHU2SklYZktvdXVEaXVKNWNCZ3BJLyt3WHo1bG9PbjIwczJGYWlBdkFnVmwr?=
 =?utf-8?B?VkhaVGd3aHJZL0NXOXlteGl0TU9XU21OOXVmNEVMUFVBcjN4L3RlRWdoOUQ0?=
 =?utf-8?B?MmpnOXdhcGJMRjN1NE1MTVJ5YXF4VjVuWndxODZQZDJENTZ5U2MyaUliZEsr?=
 =?utf-8?B?Z1BoblcxVURPUjc0VERwNFhSWklMd2JvUDQyZzJHTDBWOXRpdWFOVjUxV0NX?=
 =?utf-8?B?RkRYRWF6cUFJelo0eHNCbmQyZitRZCtCdE42ZTlpbFhSbzlMSVNFaDlUb0Uv?=
 =?utf-8?B?MXFjUXYvR2xBRzlRTmo1ZzIzUXFEeHR0dk40Z1F4MEVtWHVXRGVXMDY2clkw?=
 =?utf-8?B?UlYyWU5JejI5Qy9zT1lrZmJwdzZnenBJdDVteExpUXZoaUhqTjRqZndyYmlG?=
 =?utf-8?B?VkZMTlphaGwrVDhyNHZBeFBEMU5QR3JQUXhZOXo5VTRDQzJUWnh6NEhqOCtZ?=
 =?utf-8?B?bE52R05UcjVqRzkrYURQUXc0QWt2QjZZc0V1K0QwUkRRNjlmR3BlRGE4Mm03?=
 =?utf-8?B?Vk9LTlA2aTlucHVmWmZtM05KL3BEMGlPNTJqeGFYOWVaQU5zSnJFbmhhaHVD?=
 =?utf-8?B?emxOc1IrMS9TN0R2ZTZVY2pUdVl2Z01kVFd3dDlJNTNidTBJcVlxZHc0Z2E4?=
 =?utf-8?B?QmpuU3g5OE5VTEMrcVNScDJnbmxrRUxRb3o1MEwwczJDbXQ2ejI2UWRIZFVs?=
 =?utf-8?B?V2FLMEltb2tjSGpNYitFWWJrSW9NdnVqTDdRUFBueG93TE5OUjJnb0xlZ1By?=
 =?utf-8?B?ZG5VcGNHc04zRUpoZ294Ykc3VDdBTDl5U2czcVdRbFpSckV3USszQmdNZEZx?=
 =?utf-8?B?b3FrdFZ5Tjg0TkFUdlljRU56Zy9hMjRpNlltK1J3UlBZRWlxSmRSRlRybGNl?=
 =?utf-8?B?ckdReU9zNC9NUlJkRGJRdGVIdGwyT0ltOHdSZzdOZkVMbWN4Q0tyTFhzZm5Z?=
 =?utf-8?B?MUY4VkVzU3BXcXR2bmNJeDBxUGh6b2RFY3NmT0JLREQ3d3Vqc011bXRUd29Q?=
 =?utf-8?B?OG8waW02VjZKbUlJdHF3aytUbjJ6VjMzVDJnN3JrTmJESkpsbVo0RHBLOTNy?=
 =?utf-8?B?cEJiWGtkTW1FNEErS1VldHc2UWcxMmF6Qmd2dGttS2hyOGNvdDFVaVlBUlly?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: y9IVQTBpGae6IjqdGoMdDY2OHhHYLKWf2id/zBT6OrB39lGMjsm5qFZSOKhd6BK0GgOGAb5er6LIbr06YoplzF3vpAMprWsJaGl3CEvcxpwvFrzI0zJFnTBSQHWcdTf88xfH284JZLbO2UIt85o1vZcHUJSJZJR4TiJ4Evolsy0QN9T3XeuUDzhYRqLoDbgqNgRoIIW23BZju1DsUS5cBZ1w3TayMbdX+m9XEg16RpvtqjIHKWXLJe9L2KXd5k+T0kjR9jr0LOW4dOsV68NCQdc8uUjv1t7YjXtWidwUs21MJh5ruadYJk7kULr0wF9NKJCps/lYPQ6UOTfSpG0ZmGT8D6hVcuL+yZOcpSoZTD89XzLLvtyOJYrktOBWV9OvuR7VOJsaTlxZTWtqybWsf3R5z0o0ac5TzlF9+gRzXtWEOuUqLs2GJKck4ODu17pdQbr4sJV2XIpAkCQqHWHdKt2PjPWHBxYn2T0V7W7C4RXSw8hw63Q5og7PmZUEpmL2njtI4gC8ahRXCEscpev/UVseyZdktotz2sbctXrC1pHTaqPJgmNJKk4UTb91hx30/uo1X4GibDslHfX6NcidqL41Vkk9dDCcoZduxlt4J/4Zjp4kXrO7TrhGdSi5g/AEki0J/XDRthIGrS7UkECVjYbdiIiutPhCF3BG6+FBQS8DWKUnUuGWn14NjcP9z2njG3vWUqeqb/R4eY0iH7/GeONAzNh8CEuaiXN5LuEWRSPyyN4nd1/Xs2gRWeMwQnCcYFxf45xq0tOReFSOJilrk6HTuk+K0t4egJPTira9HJY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1347b004-469d-45ea-e29e-08db2a19bf2b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 14:37:07.7460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cK3J1/krnxj6RB5G2pHJ9JmK8yeGBLWLYLaEFRD39L9D0KtqvwZDo3o0BjG8L/uLn0KjnlZGL+gBAFTL/tgnsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6481
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_11,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303210114
X-Proofpoint-GUID: yjaiCI54SHicJGKurXNKYQX_RcWm3tt6
X-Proofpoint-ORIG-GUID: yjaiCI54SHicJGKurXNKYQX_RcWm3tt6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

LGTM

Reviewed-by: Anand Jain <anand.jain@oracle.com>
