Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E3F7CFB06
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Oct 2023 15:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345767AbjJSNal (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Oct 2023 09:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345754AbjJSNaj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Oct 2023 09:30:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49F811D
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Oct 2023 06:30:37 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39JCZT2v031820;
        Thu, 19 Oct 2023 13:30:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : cc : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=SCCdixEvSWZoQv6sIEGfuTk2XXZEW16s0lJXr/2ZHIs=;
 b=4AsmqSbQNstfbEo3yoRiGybB8/oSV0uDjD8s89T63/oRjDX4OVHdb61aeNtseb/LsAPK
 I2PdzUIxgjxp1KYYjKRnMUy6exrS0dr/fWa0a30fSChjJ4tfT+qOQNy7k1YMHxNg8FyV
 p9BSqYKalXcr5Yy5viqn2wYPQTb5xFVShyYOybrqufumtJu8vjGGMRolOwB5Ef0yS3C3
 U0eu6dxBhS7qtSYbknRBCOc/zj4IMuuXar6Zbw2CO6XWVos+8FOyl8imsZ1lOEKrtdNk
 hJAbPKdFYbE2eRyUkQI/pk7edSOX5XqBAkCOLHkPilnxKJZ4lCcwQ4qE/pBXPZwnDRTh YA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk28ttd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 13:30:33 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39JCMYCg040584;
        Thu, 19 Oct 2023 13:30:32 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3trfyq7g67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 13:30:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCEe2MCc6Tm+ierC2NIhchjuCED6KRZgpRWrP6Lkwc0/T7rvma48iAfpvhi7Yize/HieCzr+o5SCLhwUQrbzyo8cMErRtZHnJaCIHxdKf63PwhzsCk0JlafTlKSvwu1DvIdO6p+2nRTY0H5JGl2OK+Lvh5edQ9xy0tvjjCt+cHjT00fjWYoKyKTpefZ8aWq8Qfipn+UIsgCIXkMZ7hKr60eGPVX4bx+4IqEYvWPFbOZJgsGAQdphHrH2IfETtEOjHx/MO5rtbbEwtEyMlAFh3yC2ZlIIE9p3jUns2405bPlHgrGYzjqWaB5iYkCprYxo3MLQ58Ix/T3sW7pod5htNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SCCdixEvSWZoQv6sIEGfuTk2XXZEW16s0lJXr/2ZHIs=;
 b=Uho2vQVG3CSZ9b+Z0A2YnRqqGmTkcO/O+kj3kyP1KOWFHL/7jl7DO/PPgN5bcEFHzKTLTNTMKn8jjf1C+9tq+rtCHldebLIGkJ9pp/bma1nXJCuraNdaAb2VUwNHRzg8aQwCe0gQgHypHVFWYDfcWjnlexpn+526LDigbB9A2qOHl6/EK28nMEFGqmnjgwUkn3Aa2Im+Ef5W4+78DCoxcTXLdOWYTIciHlE+pY8LKPV7soLltOZn4afp2yk6V/q/GXoRu7+qtRfDqTrHs85TVbvmGJ/C4oXxB3e6apSF3d/3dJe0GSJ60S9aVyZ3nrXzhfLt0Ef9rGBeoVbHdSGsUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCCdixEvSWZoQv6sIEGfuTk2XXZEW16s0lJXr/2ZHIs=;
 b=dDchQR37EX19nrCFnc6+SgioeTCl4CNGvaRKpiLLwMbN+237N6ZZbyjfC7LdIY1gw+0r+xUoxIc2NttOZuaLnQPCrzBRAB6ctZdgYNuFarSfoMIrcqZO+batYjSS2aoddhTckU/SjryHMBOb2AQc3F5am7kCZ1Dhd6U1s8uXrS4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB7693.namprd10.prod.outlook.com (2603:10b6:510:2e5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Thu, 19 Oct
 2023 13:30:30 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6886.034; Thu, 19 Oct 2023
 13:30:30 +0000
Message-ID: <6fc25a08-de54-4f5e-aae0-054afa91b8ca@oracle.com>
Date:   Thu, 19 Oct 2023 19:00:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] btrfs: use bool for return type of
 btrfs_block_can_be_shared()
To:     linux-btrfs@vger.kernel.org
References: <cover.1697716427.git.fdmanana@suse.com>
 <7c7cede90b6aafe10821784396ee1033d0537022.1697716427.git.fdmanana@suse.com>
Content-Language: en-US
Cc:     fdmanana@kernel.org
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <7c7cede90b6aafe10821784396ee1033d0537022.1697716427.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0085.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::6) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB7693:EE_
X-MS-Office365-Filtering-Correlation-Id: f21270fc-b444-4576-d1f8-08dbd0a7906a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ia1YqXINGt6vUYvAhyFWBB07KlGaKUHeS3IFJsu0SRzZk4NMWZEqceb5zESuqM1xBom1nOjjDFI8EvCq9hBNJBn1GgTlcLz7LkyLFKxnOFwDvcnz7TKHt62KOCKGd4m0zvOEkOsgvzjTVHGkR08NJt+MEgxUao8a1L8kmGW99UAxdLsr57B+kbgHnGFjokwYkJOvKTyHjA3AcUmNJqyqNwrGJ1h1/LqEswwGKr9WnovbPVbga/eoz4aC9wHOsgVZhYY9D0XgwgbYdikn02yubYUO1zPVa2n6Yx5o9r7FYpFasjQUTZRto2h36zVFqBN2NtMYzwGS9z/levE5R0vgPdl46dxxkKVqo6OG2dLufL1LsG68dgDHmx7oex8blmT7Q/TViuEOZ196ZLxkwkCSSXiK+faWiWL+Q19u6AXEu3vSAzl2Tjx9KVQ8AvgigI7IbrpvLMuXEP/LG9P33EV8VHfazTfZsdUFJYxq5VHXe+pEMGu/cvU4Kl5DXZbVw5XHokrLqdUgElCbX3/THkXem2GJbW/4Nret6z9WJCMvkvO7zv6UDv3bkIgk+D7fq/wOjve2gQ5wLr2nzYCHoTfExbN4Q/PuBDtbEGj5ymG3IQ5gUeF+sHjtVxcVwndhllHBQU2NWpo3UI46sN75zQIoVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(346002)(39860400002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(8936002)(66946007)(4326008)(2616005)(6512007)(38100700002)(66476007)(36756003)(5660300002)(2906002)(6916009)(316002)(8676002)(41300700001)(558084003)(66556008)(44832011)(6486002)(31696002)(86362001)(6666004)(6506007)(478600001)(19618925003)(31686004)(4270600006)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T05iNjBPa3pqRnoyc0dibWdBUnpaaHd5Y2Q3MlVja0pZbEN0Y09NdWtYb1NX?=
 =?utf-8?B?Z3hiVVFwemxhb3pQOWY1VFYzY2d2b2t3RFFleGwzRTVPK3pEMWVsRUdnQ3Jl?=
 =?utf-8?B?VnRPalB0QUFXL2c1WnE5VkdHYmdVUHkyRWdSb1dQdXFXS3NBV1FTajRhRXZz?=
 =?utf-8?B?NFBIaUdRWW15UjdrZ3AyV0JqRng2TVdDbkpDK0ZzS1FYNVpPTXk5QzNDWFlI?=
 =?utf-8?B?NlU0U0VsUDY0RlVURXNXNU1EbDRzenVrNWJGbGllb2hKaGNlV0dkTDM3QXhW?=
 =?utf-8?B?K2ozNDV3cEpWSk15TmVBT3lyOUlONkpsN1lxMk9TVmxOMzFKZUUrSDhkdjNn?=
 =?utf-8?B?b2plK0VLbGhmRVU3aThRa3IrbUZRNG9ibDYxakcwWXhXaUJPaE5RV2JQNkJC?=
 =?utf-8?B?aFJyekZNaXpNY0R5djBJb2xWcEtSZ2FmWXYxdmI2cldGNEk4emdIT1ZKbjZk?=
 =?utf-8?B?VzNnTDVxeXVkdTZLRnROUGFpc2JKOUNQczZkemlId25xUXhwYXZ1RzY2aUVu?=
 =?utf-8?B?d3hlU1V1aWJ3cDRjSU90NEplV3lFcTdJOGdjZm9oL1FLSnQ2NnNVWnJ3YjIz?=
 =?utf-8?B?UTZnaFVHbWpJVlROYmhab2ZVZXAya3hPYUtQRnNaMkdHc2JQTWcxZmxjOGxj?=
 =?utf-8?B?b0RVVU03ME1JcDN0MEg5MEtsM0x3MVpOdmFHYjNZMzJNNnZEblhOYnZNaVdE?=
 =?utf-8?B?TVFTUTVhME9UMWNMcjVkWk5ZeFROejl2cDZuWGtIZ1BMOEJnbHg0MHRUVXZa?=
 =?utf-8?B?UElWVnY1TmJwRFEyQ3RkZmJmQkxLUVJTNzdrV3pOVzhTTFlSRS8rRnFxOXpF?=
 =?utf-8?B?QlI1V0ZVTXFUT1VVL2V3OXJZUi85RFAyNEVDN1hoR2lNWTcwaE5mUWZPWVY2?=
 =?utf-8?B?SHdFRXZNK2lZOUl5VU9iWWhDRTFYVms4b004V0VGaGpxZThEa0xqY0VVZUFi?=
 =?utf-8?B?RlRNYTlIV1lqMlN1cVl3MUxMNUo1VmtjbjhzbmNZL3JrM3VHZFRWY3dMcHBz?=
 =?utf-8?B?UjYxSzA1VXg1Y3FqSUExL052ZGVIY1pHOVZUcWd1eHd6L3VHNmRvTXFSak9P?=
 =?utf-8?B?azBCblExdW5EeEFmZ0FuVjg1STRtUFRaWjJ3dFlEODB5aEZiV0h5WE10QmVT?=
 =?utf-8?B?bCtoeDZkU3J6V3grRzNPM2JFK1kyOGJTU21ueG82QXJ5L3dQazdGOWVsZ0Y3?=
 =?utf-8?B?UXVJM3hWbWdkc00xQnByQ2QvTVBOMzF4cklReTdWbzE2VGowQk40TDhobXdW?=
 =?utf-8?B?VlZkWGJXalNnK3d5dXVpR09JUXBFMS9IOGZyL0dMb3UxQ3FiSk5aT3NsbE4z?=
 =?utf-8?B?STQ1dS9FOVdYSXpDNU5ncW13amM2djZlUDVNQmN5NWpkclhOcDZDQ2RkdXpj?=
 =?utf-8?B?MG44Y3Zma3o5N2x2cFlzR245ZDNLRTBqd0tPNFV1R2h0by9HWmF5WXRhS1hK?=
 =?utf-8?B?VENOZHdLTWUveXdoY2NKSnZ4MXBnRXRwZ0lqWGYwaWlrT1RucjlyRkxTK0tI?=
 =?utf-8?B?K0xzb083b3ZEdTAwSm9tUVo4Uld1dk1rendTQjR6bjlQaFZxZVlnbTd4czFJ?=
 =?utf-8?B?QTdCdUpjVFVQTHhaeGJhTURMR0FVWkpFenFWbWpiTVY3VW1oR0JjNFpSV2tU?=
 =?utf-8?B?TWoyNDg5N0lURnJaRFlWMHRSalo0Z0g1dXV5WjZ0TTRJTUtEUHkxUjVla0lo?=
 =?utf-8?B?d1plZzdOaTdNZ3lwMXFpNGc5TU9nWmYyeGhzNDUydmt6Snc2aGdrZzJ0Y2dx?=
 =?utf-8?B?NEF3WHdqekUwNUtsSzdMN1VMRE53d3NJYk5mazdxQTRFVE9EYmtJUHhJem1l?=
 =?utf-8?B?ZXo0V1YrSkwrUWdpVGJueTZ6bEVlOHd2ejFFTVBFNm9rQ0NRYVl5OHAwSC9G?=
 =?utf-8?B?NWpHMGtxNmVFeml3SVl5NTFJYUh6NmIxMjByckZqSGhwcEVmSE4raVpTWkNE?=
 =?utf-8?B?NkJhWVFsekhFamkvbGVkMTJNSmRMaXN5Z3Zzcy93RktMRUJGSkhxNUJEUUlM?=
 =?utf-8?B?MEJrMjBRK21pdDNMQ2hIS082QjRVZ0wwZjV3VVA1TmtDeEdteHJUdGQzUWda?=
 =?utf-8?B?OXpEVVV6N2RvQU92dWlLQkJJVWtVUGZ4WkVUK1REK29xdGhwNUw5RTlLYVlJ?=
 =?utf-8?B?LzFoeXNPKzhYSWNhWHkvaTN3Z3RvSVlvTVB1bDU1ckJCOVFpQVQwT2ZNU2tQ?=
 =?utf-8?Q?BIO1jND1WEo+i129iPtpSKoiEPJUDd31OscOmz5oYr4M?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: n1V+pevXBmaP4rPgLwgTj8Nk2bkdDmqirGEvnMeMI359iJuKFZAMVwnW8kkImJ9vgfMKWDHggpj99r/R6HWPTKidAPRO6Nt1F96p5/QfbdQFmOHfvKrKkhFFu0mMnyFWqix0QW+jMYCUsY7+rlugzbajke+Te0XhxyqldjZAWPdLUWQ+PFOgZcJ1u1B8nEzhVvnXKogyINQVNfFwqwgr3+OFGulNVhRrzpmGNsFCWJ6dhyWTbUPmRfrbfQ4ZImUqFfFzMIyDU10T9HHLYTKa71AsVmStTo12q7Tp56PFtat0L6BIHwY+sgCalgzK5Z+TvngEnY+SCvKpg8OO0UW4wGwj0WE4Pu/9E+YAsGfo0p9jbLMcEnv9u6Fh5uB+uc0n3fzyWeb3pZL+C1CyhGKOXMAYXGvr1YTYQfS35jS5IMS9oOKlVR0AtVX8tdNv8N+rj1eBpvjr2DqmxT6RUN396jZOmM++Mwq18rvrof+4B0vKQ2qT+Oef4GhdumwnuP+AslLXlbyzv/lvyXMpOqXIuLm9tNc0DGWwTilbY8HqvT5Jn1g3nIAkI29+j4kWJQGL5L1zjSSqF4MY2ToXZv4kBIoiw8XUJ+4tBh6kNFXkubu0K546wooK6GTm3bk6OAsnjZbaLvaAb0Rv2YkmSo6+yevosXFt4ns8Zudg+OUmH6Q6GptFB/fJpPon1Yj0WRBorOvVbp8XHBwfFbq6O+x7OM02FD04+5ZTyS5UQfL+RETOYASNr18adJeY+srgQR9CQ2CeDllfN+HG/bAyxBnkLguAyF8pTd3zpDGcpHSM4pU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f21270fc-b444-4576-d1f8-08dbd0a7906a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 13:30:30.8691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4gA+uPv22QnNgEk0O6YMhDt1aHVNrK5bsifHJa507iUhM8bSEkCzP1OjhLjcxel8or552A715rJrnwtxYKoZSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7693
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_12,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310190116
X-Proofpoint-ORIG-GUID: EEapKdIOjtCUtHIp9pOvJ83NrmvCvHzO
X-Proofpoint-GUID: EEapKdIOjtCUtHIp9pOvJ83NrmvCvHzO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

LGTM.

Reviewed-by: Anand Jain <anand.jain@oracle.com>


