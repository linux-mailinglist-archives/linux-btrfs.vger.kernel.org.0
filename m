Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24EE6692F8
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jan 2023 10:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241034AbjAMJaT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Jan 2023 04:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241042AbjAMJ2M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Jan 2023 04:28:12 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E2A626C
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Jan 2023 01:24:56 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30D9Not7001312;
        Fri, 13 Jan 2023 09:24:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=B3PLkYBLav9/be0iRf8JEvO83LIMmmvjH4NPZ3Z6Fbo=;
 b=K9GR1FCax1JPV8v4DrkkznP4FcOaG52D4lBMFbevfsK4YTwOb08Uo0Teb5NZDtANlucU
 n72XFFSIAx7RDyi8Te5m4z3ymsITE9+toskdHoFHneCmgQqqnrYbDSWM0RoCM+HKAPNQ
 4WOXvXV6MuO8Pxc4ZhsDm3ydwUcKIp2sPrGrq7unkZ/JcYkFX8/QxjYr6MCPJQ3PK7Sl
 pHSrF/YazZ9shmzg+QLFEsOVaiL4PxZq3AJWV6/f/bwgso9HHKNUBDwHpv69rHZ6qJxu
 6HT/+PUzdWWHtFRlRNoj2XFy4pghrn3Twyzu7cqmIrISbJvJR3d1zBx8Yqq6QiRaCP/J aQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3my0btv9e4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 09:24:53 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30D8dQCd038461;
        Fri, 13 Jan 2023 09:24:52 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4hmjb2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 09:24:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WHbyvzVQW82n592GG/tlEUnst0cYi/328uCfcS3Bub6AZ9K2Zsoy23jyusk+Mtffbh/ZvALjEG34BDRWHYQ3qpjWN4qBrm4h29gHZ3y5wnuaM+AC1jg/rOg5bxyKggyXoNHHSh/6pEM+unnWLu+yv8l28tsdjXF2lUX8hjeCru0EWTE/M5WSFXNOzlJXdsXk/78BdRnb9s93t0sengGW8Nm70M3q+wGyJknfHT1jTelOQhPWYi4ExiHNlMDk9+zNcA9nCVFHnNWFWGjUIrAnHMhMYD1IRNH6VW6c+7NgurHXdkYKkwf+nNqV45SWWKiPb+wGmNl+3pJsM8nqo4ltEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3PLkYBLav9/be0iRf8JEvO83LIMmmvjH4NPZ3Z6Fbo=;
 b=BS0UpK7z58xo0fqYpnhibcKJ2ZxHsUeWkIAIWvBRqnUdbFozsGc7X00stWWBx4cZUTL7m15XZbUs2VEzhXqVQoWgWDOydHPT5HeHvjSe6yCL1WG4OQH030bw+EebK0qercMxaUg6dHT1MqYR7MLysx6MPsnrT4hpTIGgG4bw1rY3D1eyUl2wLw3SEj3oFwER+vZLBqpHPlytyOLnx9J54ZZVvHdxWc7c9za2Y+QOi/4xSw1V6Aa3+dYsB0yiUW8yQP+KG89SopT9aB90Q4kxjsKQe2r2KO1nYq8gtl2jwGi21h8MdeeYNcQeThsAarhVbU5uVBKS5cKJSB48j/FV1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3PLkYBLav9/be0iRf8JEvO83LIMmmvjH4NPZ3Z6Fbo=;
 b=gikg9Jtq+oBtt9lJ18lpG/+R+Q99Sq+hNqYXDcinPB4FqOR2rmAcuozw+dcZWUFsGiJxyq6YipVGLXabfdkoo1XRruB30oOXcP3tFjAtl9HimrnKw1yqUd5IIIqxJ8vYoUbsBS+qMkclnEt24Rc4J21BWRaJ++XhWvc6qYP/mRA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN0PR10MB5911.namprd10.prod.outlook.com (2603:10b6:208:3cd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.10; Fri, 13 Jan
 2023 09:24:50 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%7]) with mapi id 15.20.6002.009; Fri, 13 Jan 2023
 09:24:50 +0000
Message-ID: <60287dfa-10bc-0e29-c152-5facaf548065@oracle.com>
Date:   Fri, 13 Jan 2023 17:24:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v3] btrfs: update fs features sysfs directory
 asynchronously
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <86ceb095fdfec9fe86dfb8efdd354a298fb685ff.1673583926.git.wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <86ceb095fdfec9fe86dfb8efdd354a298fb685ff.1673583926.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0212.apcprd04.prod.outlook.com
 (2603:1096:4:187::8) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MN0PR10MB5911:EE_
X-MS-Office365-Filtering-Correlation-Id: a84018fe-8e5f-4bee-29a5-08daf54804fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PVHO38Z6QcvwgA0QR1/0//MM3H7csUwpnRHNOIzIiKn+rIhjN2LlRQRxgs2wUCoINxcPrGKm4ohWLdi0wBAgOOtbTcZbmMbaZzJxtxh/hsDlk6UDkETUQkqvj+naZfu+tbD3mNzlJvxg3QWTgOP4njiplSuM2BNZqYQD4jaHhwpeZblZRvRKYIuVHEAmYnXXF9atxdKSz4dKg7rJoAz0IidxfMH7OhkE5n74YhicKcbtvow+LvWlJrqNJot0VWBzZ4YuiE9KurOA2eu5HkENkPgmCYjeIi1fgQhsr5Cp9NRZ/TwE+WeJIGN4Fw9G6fYg823MXMyoo3SyxtdZVSq/xOx4n1Ty4AtGrVLtJbDEUj6PS2N7DLEvQUVyPcdZ2Ve55QsxSV1ttEBP2U1ex2CP13GPzM6TKNjvQDC4v3XDB1+ymRQCzbsx3yob3A1384NpbEHklpGKCu5Jw+HiN8OFJrXycy+0n06hn/NqdaxQmBWm5LLZeeJq0xg5KcjqfjYRTQKL2qG1cptIA+mVnaBC3VkJ2BUB/PuJehlZbKazNdxqsBBg9sIAlncMiS2BE+g+5pYiWh28lHJmQYizGQddDwSATirWex/t6T78zVOIyUFkrLq/UG+P0SCgCtAtBgQQnpcVAb3jb+lIsxT7MkM0Dj+es9CpEb4UxVUR/vwAb6q/ZAe5LHWzoKnKuMgCbT/mcFz1z2czwISeESzJjjSLtqalpPFUKPA2lKRtCfgAsMQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(376002)(136003)(346002)(39860400002)(451199015)(2616005)(31696002)(86362001)(316002)(31686004)(8676002)(26005)(66476007)(66556008)(66946007)(478600001)(6512007)(6486002)(186003)(53546011)(6666004)(6506007)(38100700002)(36756003)(83380400001)(8936002)(66899015)(41300700001)(5660300002)(44832011)(15650500001)(2906002)(30864003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TE9DdCt4U3h1dGlteGNiYVN2VnFLSFJjamNvR2NoWmNsa1ZLSG5UZmN0bVRF?=
 =?utf-8?B?VjF6a2NhODVuSkhrZUVCRmxyN1BncUVoUzltNUVhWW0rT2VQeHVqUEFWaUFa?=
 =?utf-8?B?SzFRMmlxODVZcFVFdWtSSkNGNHJCOGhiZzhQSDl6eC9jUTQ5alNramMzYThY?=
 =?utf-8?B?Sks2bEZXcDBJbUNrQ0lFZ3oxdTBvcUljREFjWDEvcWx5VVZ5Sk1mbUJaNnli?=
 =?utf-8?B?RXlPTzJuUnlNQ3FxS1dDYXRNZld6ekJBQnozV1RLWmJsRlM4TkpYV3dldXky?=
 =?utf-8?B?WFVBSHBucWNXaEg5UFFEQUFDdUVqYTVOcFFrRFd5OFd2SXUwQXlaU2JhaGgr?=
 =?utf-8?B?YjlqWkowOS8zKys0S0JSTW10NzFNTlB6OXJ2QU9aZ1IxZVRmbFpsbVA1dXVF?=
 =?utf-8?B?bk9WMy96d01jQ2p4ZWpxTCs4QTdJNFp0UXNKYmtyTllydHB1RFNteHk0cytJ?=
 =?utf-8?B?ZFBpcS9TUHFDMFhMaUgwTld0SFYxS3g0MU5lU2wranBvTUVlbnFjSkxGemd3?=
 =?utf-8?B?L2lzNnZsSHZYOVpaQWRKUWZJc05rcTFzVlErdXNnMzQ3d2Q0NlpPRU9oNzlv?=
 =?utf-8?B?L1RwbG9zbjdvWUM2RGVhRTJlVzdjMXNWNFBIUkVWZ0VwTHdJaFoyZW42Uy93?=
 =?utf-8?B?bWl5L1U0YzltdmlJb0lvWGtFZDkweWVXZUxpRklJOEpzaXZWMWZRZFlyMVoy?=
 =?utf-8?B?dlArcklmVHh4aS9hN0tzRWpUSWFSaTVFL0dDaExTalJRdE9URE41MXo5Wk5Y?=
 =?utf-8?B?UVREWTVvdkprWlFvajFKTUZIaGVHOEpzdHBtVy81NWZ3ZXJHblZnQWRBaDFn?=
 =?utf-8?B?dzZnSDR0ZlZKaFBESDdIQzduRHVqdnppcHY4TzlBY0phNkx4OFN2N3RHOTd6?=
 =?utf-8?B?VUdXVGltS011TEw5NTcwbitadHY1R2lweFJ2dGE4dkZzZ1k5UE5ZSkwxLzdB?=
 =?utf-8?B?Qy9CS3dPdklJSXdSdU9CZk0yVnNZa2NhbjYxa0VVb05sUkRucjB6YzRmQ0hl?=
 =?utf-8?B?aXJlbC9jcWlCWHFobWk0MTlLdUZ0NVNwSFA4VHF1T2NHb00yb1BWOEpsUkkr?=
 =?utf-8?B?ZTJZVTJOOGVFcEdaVWtmd1JvbjJ3NGFMSkV0TFdES1NEYUp5bUNVRjBjU3R0?=
 =?utf-8?B?cTFhbTRybDZNSElkUDk5NnFSVUlqN2tXMmlGbUFldUdEbGhPbmY0L2JBQUxl?=
 =?utf-8?B?UXppcHVFaTNtUEsvUk9wckgyVy82ZUF4MW9PZ085bU9vOURWUjAwRTJUM0lr?=
 =?utf-8?B?VkdJL3l4YVZVMzMxcHNKM1VXTG1KdWNmVXhLTVJ1RldyRlloMGFkYmVjZm5r?=
 =?utf-8?B?cXJvQUlhREowQXBuaUZubFVNYi9LMnlxMC9ZM2JmSFpUU0RnMEQ2dFYzUUNl?=
 =?utf-8?B?TWJCVVZjK1plM255aWJOVGpxVHV3WHcrWkM0ak1SY2Mwb3d3em8zV2dXL2Jk?=
 =?utf-8?B?QXJjRDZkWTdSTTArREFmdGhkSk9ac05vMmU1MVAxeVlPRFZFVC9oQWNDakVM?=
 =?utf-8?B?bjdQNDZ0Z1BDSDlEaHI1KzV6MENCRGVHUGVGRXlnbFNBMC94ZXlyT0Y5QnJE?=
 =?utf-8?B?YXJyc3lYY3hVOVNYRTRpLzZnSE9EbUlEd2Q0ZGtUUmFycGpNMkxZQmdvMGxq?=
 =?utf-8?B?RjhXZnRKZHo3L3V0VzJrQUxPVDBVaXJYOXdQWXBnZ3E5UzY0WFNaRndiOHZT?=
 =?utf-8?B?VnVUcWI4Vm95SC9KY1M3bFpCT0s2SjRMSHdZdW9VUWd4WTdqbFJRNXd1azlJ?=
 =?utf-8?B?aVlybEhKdlU4RW5mWWNtRWhsZitHTE1pM3FEQjd4eW81NFFQMmFFT1BZKzRH?=
 =?utf-8?B?N24xNzFqSzB5Vm5hdnVBc0VyVy9qZVhaczVWQVU3N28rQW9CK2xTREZ1aDVO?=
 =?utf-8?B?ZXRzRllJNlRXdjlSR0gwb2c5OXRaZkw5NjB4ZHlXYjR3dUNkd0RISXlLa3hE?=
 =?utf-8?B?TjZRcjdwRmNFZ3NOMlBsSXRQQ3I3MDVNMlVnSURuT1pWc1BWdCtrcjl0TFRI?=
 =?utf-8?B?OWFKV3JjbEx6b29WandnWURodzhJa2M4R1VuUnRCVXBZQ2JiL2orTFY1a2Fr?=
 =?utf-8?B?eXI2Q0hZcm5DRlhRRVo1RnJZRFRBZmUyMVlPWUlJNFdCbVYvZm1FNS8rMFBk?=
 =?utf-8?B?cnVUdk1GUjA0dnFwWUF0aHhSekRKd3gvazc3aTlZNTZMeE92WUxKUUJzbUpp?=
 =?utf-8?B?Y2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: X/3dBvwvuBOayR6gH+XLxQxDjHcSjnqko1bKcis4+cDPpbCZYM6kmeibbtkJYk/rSdoihYK3YGWoOrE6aGQFojrjuFanWsaHQsct+37h/bg6Q/L1muNP4bGfu18OwSQVvvy00RE6m1+VzipsT4uQc58DQfs9V2j1wU863J247EhtwVGYHDuncUO3yMbETq/FM66UdBtJWDFm7SrQQPgwST57YQHHoprrH1FUgJkSK3kmBKm+nYr3QWnEXz4GSwpkh6OUUSmOxIRrHCM/yB5wT/om0GITs0D/fP9rrA45v/wr/HokwL3vs7Yez9fuP8GXR8U1G3dQbFlt5nhe5AGitkz3ehz4t9bKSKEkqC2so11wZ0mPWDwkU/1RmRNuDzwJj40aDc3GccVljZxSxyOfWipOVCKsDe3god085BDwqEMletFk3SRAb+Y9njlfUW/4IlVORY33CXTsRZSAXwyXrVsDvjT8FMebDVLLiIgQ3bwuNiSXNyrwrkK6U7j+y8dLspvSBFBaU2Gm9Wlkv3tdqxzXGbt+1oIEZFLwp4CagdJEt8eZStLQFGm/3i0Dq0mSML++rpJCd0/MmaNvIJ54jRbaK68OSYb/ao6HxURVH4Nvd/YLWpj1X4p3jSuCiq5IpFpn/k3UZW2xP0uULtV/7thqT9deR8Zu7GdiVwsPaI8hv9EeGLtzHW94yOGvhjWM7ffeIl+iokwYnGFUTPLWLasPDoTFI8KjE9YsWpYF4t4vS4ZsK9qZj7is+cLxywV6h6wAuWPviRtSs0+nsBvxfPoMGBOdPR0EFfJlR6DXOtk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a84018fe-8e5f-4bee-29a5-08daf54804fe
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 09:24:50.2030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BmhHR/yANgaeI8Diiv9IdHrzjx8pR2bmB5dX3HhL7plfDYSSCLfXRXO/+VAPRkZvKh76vNdVqFT8cE+NDU38nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5911
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-13_04,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301130065
X-Proofpoint-GUID: beJinDkcKhcyH7AGmp6OOElp1K_f6gc-
X-Proofpoint-ORIG-GUID: beJinDkcKhcyH7AGmp6OOElp1K_f6gc-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 13/01/2023 12:39, Qu Wenruo wrote:
> [BUG]
>  From the introduction of per-fs feature sysfs interface
> (/sys/fs/btrfs/<UUID>/features/), the content of that directory is never
> updated.
> 
> Thus for the following case, that directory will not show the new
> features like RAID56:
> 
>   # mkfs.btrfs -f $dev1 $dev2 $dev3
>   # mount $dev1 $mnt
>   # btrfs balance start -f -mconvert=raid5 $mnt
>   # ls /sys/fs/btrfs/$uuid/features/
>   extended_iref  free_space_tree  no_holes  skinny_metadata
> 
> While after unmount and mount, we got the correct features:
> 
>   # umount $mnt
>   # mount $dev1 $mnt
>   # ls /sys/fs/btrfs/$uuid/features/
>   extended_iref  free_space_tree  no_holes  raid56 skinny_metadata
> 
> [CAUSE]
> Because we never really try to update the content of per-fs features/
> directory.
> 
> We had an attempt to update the features directory dynamically in commit
> 14e46e04958d ("btrfs: synchronize incompat feature bits with sysfs
> files"), but unfortunately it get reverted in commit e410e34fad91
> ("Revert "btrfs: synchronize incompat feature bits with sysfs files"").
> 
> The exported by never utilized function, btrfs_sysfs_feature_update() is
> the leftover of such attempt.
> 
> The problem in the original patch is, in the context of
> btrfs_create_chunk(), we can not afford to update the sysfs group.
> 
> As even if we go sysfs_update_group(), new files will need extra memory
> allocation, and we have no way to specify the sysfs update to go
> GFP_NOFS.
> 
> [FIX]
> This patch will address the old problem by doing asynchronous sysfs
> update in cleaner thread.
> 
> This involves the following changes:
> 
> - Allow __btrfs_(set|clear)_fs_(incompat|compat_ro) functions to return
>    bool
>    This allows us to know if we changed the feature.
> 
> - Make btrfs_(set|clear)_fs_(incompat|compat_ro) functions to set
>    BTRFS_FS_FEATURE_CHANGING flag when needed

> 
> - Update btrfs_sysfs_feature_update() to use sysfs_update_group()
>    And drop unnecessary arguments.
> 
> - Call btrfs_sysfs_feature_update() in cleaner_kthread
>    If we have the BTRFS_FS_FEATURE_CHANGING flag set.


> 

> - Wake up cleaner_kthread in btrfs_commit_transaction if we have
>    BTRFS_FS_FEATURE_CHANGING flag

needs a
      s/BTRFS_FS_FEATURE_CHANGING/BTRFS_FS_FEATURE_CHANGED/
overall

> 
> By this, all the previously dangerous call sites like
> btrfs_create_chunk() can just call the new
> btrfs_async_update_feature_change() and call it a day.
> 
> The real work happens at cleaner_kthread, thus we pay the cost of
> delaying the update to sysfs directory, but the delayed time should be
> small enough that end user can not distinguish.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Fix an unused variable in btrfs_parse_options()
>    Add the missing btrfs_async_update_feature_change() call.
> 
> v3:
> - Make btrfs_(set|clear)_fs_(incompat|compat_ro) functions to set
>    BTRFS_FS_FEATURE_CHANGING flag
>    So we don't need to check the return value and manually set the flag.
> 
> - Wake up the cleaner in btrfs_commit_transaction(
>    This can make the sysfs update as fast as happening in
>    btrfs_commit_transaction(), but still doesn't slow down
>    btrfs_commit_transaction().
> 
>    This also means we don't need to wake up the cleaner manually.
>    The timing is chosen to just after we switched to UNBLOCKED state,
>    to avoid cleaner kthread to wait for running transaction.


> ---
>   fs/btrfs/disk-io.c     |  3 +++
>   fs/btrfs/fs.c          | 28 +++++++++++++++++++--------
>   fs/btrfs/fs.h          | 44 +++++++++++++++++++++++++++++++++---------
>   fs/btrfs/sysfs.c       | 26 ++++++-------------------
>   fs/btrfs/sysfs.h       |  3 +--
>   fs/btrfs/transaction.c |  5 +++++
>   6 files changed, 70 insertions(+), 39 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 7586a8e9b718..a6f89ac1c086 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1914,6 +1914,9 @@ static int cleaner_kthread(void *arg)
>   			goto sleep;
>   		}
>   
> +		if (test_and_clear_bit(BTRFS_FS_FEATURE_CHANGED, &fs_info->flags))
> +			btrfs_sysfs_feature_update(fs_info);
> +
>   		btrfs_run_delayed_iputs(fs_info);
>   
>   		again = btrfs_clean_one_deleted_snapshot(fs_info);
> diff --git a/fs/btrfs/fs.c b/fs/btrfs/fs.c
> index 5553e1f8afe8..a02e6b6cb97c 100644
> --- a/fs/btrfs/fs.c
> +++ b/fs/btrfs/fs.c
> @@ -5,15 +5,17 @@
>   #include "fs.h"
>   #include "accessors.h"
>   
> -void __btrfs_set_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
> +bool __btrfs_set_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
>   			     const char *name)
>   {
>   	struct btrfs_super_block *disk_super;
> +	bool changed;
>   	u64 features;
>   
>   	disk_super = fs_info->super_copy;
>   	features = btrfs_super_incompat_flags(disk_super);
> -	if (!(features & flag)) {
> +	changed = !(features & flag);
> +	if (changed) {
>   		spin_lock(&fs_info->super_lock);
>   		features = btrfs_super_incompat_flags(disk_super);
>   		if (!(features & flag)) {
> @@ -25,17 +27,20 @@ void __btrfs_set_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
>   		}
>   		spin_unlock(&fs_info->super_lock);
>   	}
> +	return changed;
>   }


  Why not something like below

  if there is something changed
  ::
     set_bit(BTRFS_FS_FEATURE_CHANGED, &fs_info->flags)

  and return void.



>   
> -void __btrfs_clear_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
> +bool __btrfs_clear_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
>   			       const char *name)
>   {
>   	struct btrfs_super_block *disk_super;
> +	bool changed;
>   	u64 features;
>   
>   	disk_super = fs_info->super_copy;
>   	features = btrfs_super_incompat_flags(disk_super);
> -	if (features & flag) {
> +	changed = features & flag;
> +	if (changed) {
>   		spin_lock(&fs_info->super_lock);
>   		features = btrfs_super_incompat_flags(disk_super);
>   		if (features & flag) {
> @@ -47,17 +52,20 @@ void __btrfs_clear_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
>   		}
>   		spin_unlock(&fs_info->super_lock);
>   	}
> +	return changed;
>   }
>   

  Similarly to rest of the other set and clear functions as above.

> -void __btrfs_set_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
> +bool __btrfs_set_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
>   			      const char *name)
>   {
>   	struct btrfs_super_block *disk_super;
> +	bool changed;
>   	u64 features;
>   
>   	disk_super = fs_info->super_copy;
>   	features = btrfs_super_compat_ro_flags(disk_super);
> -	if (!(features & flag)) {
> +	changed = !(features & flag);
> +	if (changed) {
>   		spin_lock(&fs_info->super_lock);
>   		features = btrfs_super_compat_ro_flags(disk_super);
>   		if (!(features & flag)) {
> @@ -69,17 +77,20 @@ void __btrfs_set_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
>   		}
>   		spin_unlock(&fs_info->super_lock);
>   	}
> +	return changed;
>   }
>   
> -void __btrfs_clear_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
> +bool __btrfs_clear_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
>   				const char *name)
>   {
>   	struct btrfs_super_block *disk_super;
> +	bool changed;
>   	u64 features;
>   
>   	disk_super = fs_info->super_copy;
>   	features = btrfs_super_compat_ro_flags(disk_super);
> -	if (features & flag) {
> +	changed = features & flag;
> +	if (changed) {
>   		spin_lock(&fs_info->super_lock);
>   		features = btrfs_super_compat_ro_flags(disk_super);
>   		if (features & flag) {
> @@ -91,4 +102,5 @@ void __btrfs_clear_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
>   		}
>   		spin_unlock(&fs_info->super_lock);
>   	}
> +	return changed;
>   }
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index 37b86acfcbcf..503132d90239 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -130,6 +130,12 @@ enum {
>   	BTRFS_FS_32BIT_ERROR,
>   	BTRFS_FS_32BIT_WARN,
>   #endif
> +
> +	/*
> +	 * Indicate if we have some features changed, this is mostly for
> +	 * cleaner thread to update the sysfs interface.
> +	 */
> +	BTRFS_FS_FEATURE_CHANGED,
>   };
>   
>   /*
> @@ -868,14 +874,18 @@ void btrfs_exclop_finish(struct btrfs_fs_info *fs_info);
>   void btrfs_exclop_balance(struct btrfs_fs_info *fs_info,
>   			  enum btrfs_exclusive_operation op);
>   
> -/* Compatibility and incompatibility defines */
> -void __btrfs_set_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
> +/*
> + * Compatibility and incompatibility defines.
> + *
> + * Return value is whether the operation changed the specified feature.
> + */
> +bool __btrfs_set_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
>   			     const char *name);
> -void __btrfs_clear_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
> +bool __btrfs_clear_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
>   			       const char *name);
> -void __btrfs_set_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
> +bool __btrfs_set_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
>   			      const char *name);
> -void __btrfs_clear_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
> +bool __btrfs_clear_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
>   				const char *name);
>   


>   #define __btrfs_fs_incompat(fs_info, flags)				\
> @@ -885,19 +895,35 @@ void __btrfs_clear_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
>   	(!!(btrfs_super_compat_ro_flags((fs_info)->super_copy) & (flags)))
>   
>   #define btrfs_set_fs_incompat(__fs_info, opt)				\
> -	__btrfs_set_fs_incompat((__fs_info), BTRFS_FEATURE_INCOMPAT_##opt, #opt)
> +({									\
> +	if (__btrfs_set_fs_incompat((__fs_info),			\
> +				BTRFS_FEATURE_INCOMPAT_##opt, #opt))	\
> +		set_bit(BTRFS_FS_FEATURE_CHANGED, &(__fs_info)->flags);	\
> +})
>   
>   #define btrfs_clear_fs_incompat(__fs_info, opt)				\
> -	__btrfs_clear_fs_incompat((__fs_info), BTRFS_FEATURE_INCOMPAT_##opt, #opt)
> +({									\
> +	if (__btrfs_clear_fs_incompat((__fs_info),			\
> +				BTRFS_FEATURE_INCOMPAT_##opt, #opt))	\
> +		set_bit(BTRFS_FS_FEATURE_CHANGED, &(__fs_info)->flags);	\
> +})
>   
>   #define btrfs_fs_incompat(fs_info, opt)					\
>   	__btrfs_fs_incompat((fs_info), BTRFS_FEATURE_INCOMPAT_##opt)
>   
>   #define btrfs_set_fs_compat_ro(__fs_info, opt)				\
> -	__btrfs_set_fs_compat_ro((__fs_info), BTRFS_FEATURE_COMPAT_RO_##opt, #opt)
> +({									\
> +	if (__btrfs_set_fs_compat_ro((__fs_info),			\
> +			BTRFS_FEATURE_COMPAT_RO_##opt, #opt))		\
> +		set_bit(BTRFS_FS_FEATURE_CHANGED, &(__fs_info)->flags);	\
> +})
>   
>   #define btrfs_clear_fs_compat_ro(__fs_info, opt)			\
> -	__btrfs_clear_fs_compat_ro((__fs_info), BTRFS_FEATURE_COMPAT_RO_##opt, #opt)
> +({									\
> +	if (__btrfs_clear_fs_compat_ro((__fs_info),			\
> +			BTRFS_FEATURE_COMPAT_RO_##opt, #opt))		\
> +		set_bit(BTRFS_FS_FEATURE_CHANGED, &(__fs_info)->flags);	\
> +})
>   

  we can drop this change.

>   #define btrfs_fs_compat_ro(fs_info, opt)				\
>   	__btrfs_fs_compat_ro((fs_info), BTRFS_FEATURE_COMPAT_RO_##opt)
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 45615ce36498..f86c107ea2e4 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -2272,36 +2272,22 @@ void btrfs_sysfs_del_one_qgroup(struct btrfs_fs_info *fs_info,
>    * Change per-fs features in /sys/fs/btrfs/UUID/features to match current
>    * values in superblock. Call after any changes to incompat/compat_ro flags
>    */
> -void btrfs_sysfs_feature_update(struct btrfs_fs_info *fs_info,
> -		u64 bit, enum btrfs_feature_set set)
> +void btrfs_sysfs_feature_update(struct btrfs_fs_info *fs_info)
>   {
> -	struct btrfs_fs_devices *fs_devs;
>   	struct kobject *fsid_kobj;
> -	u64 __maybe_unused features;
> -	int __maybe_unused ret;
> +	int ret;
>   
>   	if (!fs_info)
>   		return;
>   
> -	/*
> -	 * See 14e46e04958df74 and e410e34fad913dd, feature bit updates are not
> -	 * safe when called from some contexts (eg. balance)
> -	 */
> -	features = get_features(fs_info, set);
> -	ASSERT(bit & supported_feature_masks[set]);
> -
> -	fs_devs = fs_info->fs_devices;
> -	fsid_kobj = &fs_devs->fsid_kobj;
> +	fsid_kobj = &fs_info->fs_devices->fsid_kobj;
>   
>   	if (!fsid_kobj->state_initialized)
>   		return;
>   
> -	/*
> -	 * FIXME: this is too heavy to update just one value, ideally we'd like
> -	 * to use sysfs_update_group but some refactoring is needed first.
> -	 */
> -	sysfs_remove_group(fsid_kobj, &btrfs_feature_attr_group);
> -	ret = sysfs_create_group(fsid_kobj, &btrfs_feature_attr_group);
> +	ret = sysfs_update_group(fsid_kobj, &btrfs_feature_attr_group);
> +	if (ret < 0)
> +		btrfs_err(fs_info, "failed to update features: %d", ret);
>   }

Some thing like
    "failed to update /sys/fs/btrfs/features: %d"
is better IMO.

>   int __init btrfs_init_sysfs(void)
> diff --git a/fs/btrfs/sysfs.h b/fs/btrfs/sysfs.h
> index bacef43f7267..86c7eef12873 100644
> --- a/fs/btrfs/sysfs.h
> +++ b/fs/btrfs/sysfs.h
> @@ -19,8 +19,7 @@ void btrfs_sysfs_remove_device(struct btrfs_device *device);
>   int btrfs_sysfs_add_fsid(struct btrfs_fs_devices *fs_devs);
>   void btrfs_sysfs_remove_fsid(struct btrfs_fs_devices *fs_devs);
>   void btrfs_sysfs_update_sprout_fsid(struct btrfs_fs_devices *fs_devices);
> -void btrfs_sysfs_feature_update(struct btrfs_fs_info *fs_info,
> -		u64 bit, enum btrfs_feature_set set);
> +void btrfs_sysfs_feature_update(struct btrfs_fs_info *fs_info);
>   void btrfs_kobject_uevent(struct block_device *bdev, enum kobject_action action);
>   
>   int __init btrfs_init_sysfs(void);
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 528efe559866..18329ebcb1cb 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -2464,6 +2464,11 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
>   	wake_up(&fs_info->transaction_wait);
>   	btrfs_trans_state_lockdep_release(fs_info, BTRFS_LOCKDEP_TRANS_UNBLOCKED);
>   
> +	/* If we have features changed, wake up the cleaner to update sysfs. */
> +	if (test_bit(BTRFS_FS_FEATURE_CHANGED, &fs_info->flags) &&
> +	    fs_info->cleaner_kthread)
> +		wake_up_process(fs_info->cleaner_kthread);
> +

Why not just wake cleaner_kthred at the end of super writes if 
successful? Would it be too delayed?

And

How does it behave in simultaneous or consecutive feature change 
requests? Would it be consistent?



>   	ret = btrfs_write_and_wait_transaction(trans);
>   	if (ret) {
>   		btrfs_handle_fs_error(fs_info, ret,
> 

-Anand


