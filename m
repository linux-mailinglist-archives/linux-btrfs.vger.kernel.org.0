Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE9C6816BF
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jan 2023 17:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236266AbjA3Qo5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Jan 2023 11:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237078AbjA3Qoq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Jan 2023 11:44:46 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE403CE0A
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Jan 2023 08:44:42 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UGeASO001926;
        Mon, 30 Jan 2023 16:44:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=BMrR9i1yBtTR3MYVlh66XyGMZin5BGnPr+rfnCTP7I0=;
 b=bBnAoCzNu0XPULdYBVPB3dQPy94njPMCtQGJd3exCs9eViwUCh/taI7CHLV5xwS+iQkL
 qXWA5Gpv0zxlnupvXnyn5JqVvfKbzIZFWNS7v6pIZkv7cut5sWkr2BdI67vy493CYbU0
 jPy4HJe3FOyr+1nOnP8zzSAGKUUHDGs/ZRDPJslPvW5IjHM7gKpeT9kvjKdmEzPJyCHC
 kl2UHvIH4KjYVUrYnemwDCJOojaz88yqvtggfMg0QdLoGSbq4IGKQDl1yQSmXE0suppy
 yQjih28zDiclMH7p8F7byXa9yh4Cw7jJbB21gqz8vrvmb1AW9tF33VrYhIJeszIARy6p rg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvm13de9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jan 2023 16:44:37 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30UGLHPK018478;
        Mon, 30 Jan 2023 16:44:35 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nct54kfdx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jan 2023 16:44:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oeMQ4dpeaOuGqIizTOx5Yf6RQEK3sV2LxxEsfHMMUY4uZktosMrNJ28wENYCig/B4euGrntzb+IFUk0v/cV0DQ6mrw+vhJb3xEtoXYxmTzihIfHNKOmGdibnOJLDqdkcj4v/5pgO1OuWnNzgk1ZM2bIdRlqsLwmljQxnWHwzJTS3PG/z8EHUh3H13oGeCoTIN4qdObpdd0XueOsgnd9y7K3lPhzh3HMgpw6a4e0FdROwMyPyBkKz/j6eMdJN3Qhel6QkpNZqyeJ+QPAcRIjthQnzYJNMGDAfiukHUnnlLzBV1gtPmptm9A5ZpDaaHbahWKvnevI+zbSy/0mFCL32hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BMrR9i1yBtTR3MYVlh66XyGMZin5BGnPr+rfnCTP7I0=;
 b=eilI9S0rEixxILE0II1qoOyKHIX5bQLpUFqW+9ErXe540cL/0X2fAuHP5ofDg63u7QdmKBV7y3SSvBvbOUBjeyjbw1KihkmDXO74pdp/sg//4m+79nkq0wbeZuw/ePoT+a3OIJXDtK/LP1T20Pt3BDZWKeMiwfvS44f03SZyV5TT3Y2lRZO6Dp07ejhHe6gb2rMFy1cLL8jK0brj0L0bUAXnMN74iNWvBXVGeKW6bJ9b+ku2uxMdIyE5brSTPiaUO5YYe9xxIrYpLylw/F96T+s/ql4QkeNv1gZ5m3adda7g+2xlAdYNOm6N2Ui/FMwmvfRNxsYWxbg+PMdwkElrQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMrR9i1yBtTR3MYVlh66XyGMZin5BGnPr+rfnCTP7I0=;
 b=Lis/JtsEZ0ohXnVa3J+w7qs7BEgGJSn3s6ndhC/w6kNzYBGb/Jv/Z9GRJa8OYY94+3f52zZAgjYEM1OBNiGOEUhx/rp6uCzb7gCUMRZM5bVxdmI0dVLy54oKViHMC4m1HYubfaVacxB8ZKZqE+QzT2EQnxy0c4l28yRNS3m4d3I=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BN0PR10MB4887.namprd10.prod.outlook.com (2603:10b6:408:124::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.21; Mon, 30 Jan
 2023 16:44:32 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%9]) with mapi id 15.20.6064.021; Mon, 30 Jan 2023
 16:44:32 +0000
Message-ID: <915539ed-b9be-d1f0-7a01-a6e78e1596d4@oracle.com>
Date:   Tue, 31 Jan 2023 00:44:25 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH v2] btrfs: add size class stats to sysfs
To:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <5c4fcf99c1486e6c2c2c45f11ade73d40f153021.1674856476.git.boris@bur.io>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <5c4fcf99c1486e6c2c2c45f11ade73d40f153021.1674856476.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0066.apcprd02.prod.outlook.com
 (2603:1096:4:54::30) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BN0PR10MB4887:EE_
X-MS-Office365-Filtering-Correlation-Id: 78649e89-16b8-4b55-77e4-08db02e14350
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qFLztaCxCKCGKPngeF901Vmlh8xGwkC7wIW+woPv0Wt3BrwK1XfSz+giWejvIc/Ts1fsO+E7s56dSjryEXODjv9D4iN244ZdypJkx5WFqBm5L3k/XFk5N88IxmDsppZ8QZ6TRzwAoidV1HlwqS8jy8U8OWuT5Tvyx0U0zVXbm8Zbc04iwuyTtzm0hfqyECS505X6dS/NnjCTIfRDxBA8K3SOVru/hd2NOe/1kGFvPAeZBPjfDEBfZEcUXnDtEXzOJX/xSj1y3l48KyG7mECXdEEnNvQAb+6nc0/k0nEGJaDh4u+gzoEBlUjJ5vP2VEKAW7tUVUkgpbIIvuztbTqKcj/TR+su3+4Zigj6gE4iQvrQWohpAjaZ1EdTxrgWlLi7Yo4MRruUC8gHZkI82P83icC2Roou9CF4Apz71HU9A02SAYgk+7a2epkCtMOPcf4unHlemUX6/xfKfJcBNY4rIv+AYyL2t23BjTbglZQO2+Uh8wwLa0GnCmFL4gnLDa/kv2cBze3mmbcdThTQkhAuALL/ru5KeImxWsEDu7o3foJzuKQAulbo/7eDjKnfdwQ6aE+Bzh2W6r1mUEVeKYkZ199Bt4+PfK9yGRDQitYPmt6rbwPjMTizliytlDjyZdm3ccTjtMgNQx5hA7iBS+ai+wk6W7nKWv1KVXk6sI8PB/XX9r+P2Z/lu7I72ygz4vhsAKV39+WMEhblHq+671ws74MxAgROlz3TsrCSCI3Z4cg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199018)(83380400001)(86362001)(36756003)(31696002)(38100700002)(44832011)(2906002)(8936002)(31686004)(5660300002)(316002)(41300700001)(2616005)(8676002)(6666004)(66946007)(66476007)(66556008)(6486002)(53546011)(26005)(478600001)(6512007)(186003)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wms2N0JPclhwUjVJN1c3NkFUMkM3UC9NblY1UFAwQTl0N2VDYVliM0pIZW1K?=
 =?utf-8?B?aDZIU1ZiUG4rcmgvRkwyaGxYZEtXNDVPWXVhaFV4cmtKUG5ESENSbkxZd0dO?=
 =?utf-8?B?S3Y3TmN0OWZrVWR0NGlYYXR2SEZ5NmlQOHdTbE1vNzAxZGVTMWxWTEo5T2JL?=
 =?utf-8?B?WXE3YXJlNW1nQmlwRytqNlhBK2FoeHNJTHVDcldUcENudlp6TVlXN3NEK0h6?=
 =?utf-8?B?U0tVbmF6REQ0cFRuMVFBZURlcmwrWi9sTkNaNC9pdHNKVmF3bDRYVVMrakFP?=
 =?utf-8?B?UUV2dytlQkF2YXprNkRzUFVYMmdJVVRnb1l2UlBQNm1PS1JmdDFFUHF6UUFJ?=
 =?utf-8?B?YlNVdzQvSi9iaWE5d1VFTWFpK1JlSWVza1Vnand3bGovZTY2TTBPQ1lGSXZa?=
 =?utf-8?B?Z3VWcXY5WGJ0SHlLZFBkNmdTTlVCc0thUUVoWWt3MnFVSHNobTVMN3ZRbmVM?=
 =?utf-8?B?R0FYcWpkc2FReXhCZkVPNHNEOFFRYzV2elEyRlBOSUE4OHlaOEtpN1lOTThi?=
 =?utf-8?B?bkw1cUVPL3NWdFdOOFBKZW95c0QxUC9tUHdvdk42d2p3Z3NDbDR4aUNDZ2Fv?=
 =?utf-8?B?Q05GaVQ5WU5tcXBUaVprWkgxMWFXaTBWQlprdW5CTklpYmdoaGlGdENTQURT?=
 =?utf-8?B?MlpEUmx4SURPMXFOY1FQOXlmbTkvVi94OWhuMUFmQlBZanhNajBCWTY1cEVj?=
 =?utf-8?B?aHhxNXJCNzBWb0loSXBPSEVNWlJRb08wRVZha2xSZi9STEFqU2ZJWVlmb0NC?=
 =?utf-8?B?cjhnSGQyQUZDeEdreGRMZUVFOXBHekRGQ01NeE1URWRvZWtuNE9HRCtINEhu?=
 =?utf-8?B?M3pEc254MU42NHhSeU9jL2xCUGd3bG10Q2t4ZlVYWCtWUWc4eDY1MUh6alRK?=
 =?utf-8?B?aG9CdnlKaXgyNFJKVkRSZ2dlaGE0WUNsSTRINER0T011eGcvWXZTYStkNTht?=
 =?utf-8?B?UGFCMS94bnYxS0pqWXBoVzJ3NTByS2sxd3N5RzgwUVRYYWQzK1FCeHhyallZ?=
 =?utf-8?B?UzRnNDZmbXdtS004Vjc3cUN1L0NrY3ovdW94bVgwcUFWLzR5MVVXWWt3U0Vt?=
 =?utf-8?B?ejdNckNOYkxPUHpsQWVlUng5QWlHRHo0b1hUaUNPRERYTkx6V3d2b25FNUdl?=
 =?utf-8?B?dnRDeE52b0ZMamwwM25mdlB6L1RlaFdJbno1Ryt2SE1hWVRQa0pyNWF3SWcz?=
 =?utf-8?B?NkszYjRkYzFiOVF2dVlXdXg3ZXZTZmpWQXJudmZCSVAvaXh2cDlYNU9JTTV0?=
 =?utf-8?B?cEZCNlI2Z05Jeis4ZkRBTEQ2VTJRdGxxUXQ5Qk1KZUM0bDYrU21VaENZcExx?=
 =?utf-8?B?ZGdya09oOFkxY2UxY1FESkp6eVQ0MTVwUW9BTUZ6c0VmSnkwN0JvODN1SDBv?=
 =?utf-8?B?SEE2bUJVN2loUU43ZkVjVncvQ1ZKN0RENk1Eb2c2ZDlqRHNMNUNnZW5KUXBK?=
 =?utf-8?B?SDhVTXVpdHRlQnZGblR6R0JMb3MzVjV0aStSWXNKSFhYTlBYSDUxUk80NzVr?=
 =?utf-8?B?UnFWNDlFREdTWk9ITmZnVm5aZmNPYWRtZzd2YUN4NnkrcjdSVmNBeW1YKy9Z?=
 =?utf-8?B?VXBYRFl5aEhiVllDbkZoY3Bib2ZlOTN3U3RINjVMbHUrTU4vUm52akpBV2FU?=
 =?utf-8?B?R1hKejJ5OW1UbUJuQW92WitDYTFyRDZINk1uRzFndmp4VE56a3E5S1VXZGNo?=
 =?utf-8?B?c1daYzArbU1IY0NvRTdwWGVCK0dUanVKZGZqUTJ5akpJYUxZcURlOHhxcXNv?=
 =?utf-8?B?SnE3UHRnVzRZS0FTREdDSVNsNEp2Tys0VjA3aGJhbEFabEN4VGR0Nk55ZzJ2?=
 =?utf-8?B?c3V6ZUg0T1V4U0tyYS9TSEI0UG15cm5xZUNNUWdSQUNKeTVCVS9oSHNNUkFK?=
 =?utf-8?B?OEZkbmhtUmJqZnVjcWIveTAxRlFEblkzVnJXVEVpWkxjWHAzVlMvK1hPL2NZ?=
 =?utf-8?B?MnVkTUZDeFRLTzYxazhoNFRPdnNxbkJVeTAyQ2pTN1ZSYjB4THFRNFBJL1Q1?=
 =?utf-8?B?eEVuTmFQR2lRclZ3dlIybUZFUzVTVFNlaDk3UElxRVU5TGMrTWFYSTE1WFpw?=
 =?utf-8?B?a2hSUDBMQzFkd2tnTm14bksvQ0w1YmtTaVNFRjFJdCtla2VzeHNEZ0E1bmVz?=
 =?utf-8?B?YVhuL0JGTHFBbTEybisvUVZ2N2s5aU5BREF0S0I2UXZsaHVKWkt2dmNiQkVZ?=
 =?utf-8?B?SkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mycW/tI513S7rPY9kG7/zxdBUNZt0ZJ912B8VxnnGLyd9kbSR1JGKIaBMM6kxt6GgofWv7jTOF1/q0GVctcihqBAcMkBrLufcOyN209wskz16Rohti6dQN3RBqcqpx3Pg+VcD3LRFCMJYDvzN0Sr3jTKUshMHfxmOgrw4LxCASkfHMbHbGKhdQ5bJzzvuJE0qMOELUHhRkS0in/AOpxGA412E7Ta8a+HIN5Rk6MTyY3hvQlAZdEoI+HwU85jTLh4dWU+A56Kyoa2c7jhHLoa65KIzIP7x37l/PIUzoDWPJx8IG7Sv4yhM9UW5mpeD7m77tcaVPRdP54updoWxl5samQdruile3cEWecSehxZ2gcISbFlt7gVfqcNfVj/NET3IjS2mgqslmg2gpgZ0osuQePZgJBBXvkIvCv2mwLvu5AY23aVlI5dQyfa7AKs5SNzJzA/8HD8Ep8dCucY8qa7s1po+Z3Ciy0Q5i8e1K0/tapLz/6e7heHEv0nhPU7PzJ3k0LOTvzBPfKX6DQyeSbVEfYlLalM8ELzG9b8g9mBGn0czAwEEE8TKR7ot905SF7hcHwVcRYC+iGwLePkxg5ZGT03vdZ5TQFV1oJ+ZS/PBE/bqEqVPSWlTK3P6kSGdhJu0+O3Rwifeats8dYrvJJWyWl8xsJ2Nz8vBZnAEAH9AU5NBFsMZYucsonCrmHmE2xNbJ7Wxx02ouoN10OkiQJAtGOWcOjsbeJPMa/mH1ENuIraXiW0YubOG4PrtDymDy7RXjghhijE1EaQ8C2PXVdhjT0oRFfxCRo4N6/uv4rNQJI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78649e89-16b8-4b55-77e4-08db02e14350
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 16:44:32.6894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QAuVz4sHiE/J96US2ByjphZPJh475m+sq3zHzflzEwNqg9uivlQOasfskTIGKOX+b/KZSh+IaNMXDezzHpynrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4887
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_16,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301300162
X-Proofpoint-GUID: lZohJCMS3u10lQwwfvNUZB9WiTQyJRIz
X-Proofpoint-ORIG-GUID: lZohJCMS3u10lQwwfvNUZB9WiTQyJRIz
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/28/23 05:56, Boris Burkov wrote:
> Make it possible to see the distribution of size classes for block
> groups. Helpful for testing and debugging the allocator w.r.t. to size
> classes.

We could place debug/testing feature in CONFIG_BTRFS_DEBUG. If not, how
would the user be aware of the class size range in non-debugging cases?

Otherwise, the change looks good.

Thanks, Anand

> 
> The new stats can be found at the path:
> /sys/fs/btrfs/<uid>/allocation/<bg-type>/size_class
> but they will only be non-zero for bg-type = data.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
> Changelog:
> v2:
> - add sysfs path to commit message
> - unsigned counter types
> - labeled stat-per-line output format
> 
>   fs/btrfs/sysfs.c | 37 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 108aa3876186..639f3842f99d 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -9,6 +9,7 @@
>   #include <linux/spinlock.h>
>   #include <linux/completion.h>
>   #include <linux/bug.h>
> +#include <linux/list.h>
>   #include <crypto/hash.h>
>   #include "messages.h"
>   #include "ctree.h"
> @@ -778,6 +779,40 @@ static ssize_t btrfs_chunk_size_store(struct kobject *kobj,
>   	return len;
>   }
>   
> +static ssize_t btrfs_size_classes_show(struct kobject *kobj,
> +				       struct kobj_attribute *a, char *buf)
> +{
> +	struct btrfs_space_info *sinfo = to_space_info(kobj);
> +	struct btrfs_block_group *bg;
> +	u32 none = 0;
> +	u32 small = 0;
> +	u32 medium = 0;
> +	u32 large = 0;
> +
> +	for (int i = 0; i < BTRFS_NR_RAID_TYPES; ++i) {
> +		list_for_each_entry(bg, &sinfo->block_groups[i], list) {
> +			if (!btrfs_block_group_should_use_size_class(bg))
> +				continue;
> +			switch (bg->size_class) {
> +			case BTRFS_BG_SZ_NONE:
> +				none++;
> +				break;
> +			case BTRFS_BG_SZ_SMALL:
> +				small++;
> +				break;
> +			case BTRFS_BG_SZ_MEDIUM:
> +				medium++;
> +				break;
> +			case BTRFS_BG_SZ_LARGE:
> +				large++;
> +				break;
> +			}
> +		}
> +	}
> +	return sysfs_emit(buf, "none %u\nsmall %u\nmedium %u\nlarge %u\n",
> +			  none, small, medium, large);
> +}
> +
>   #ifdef CONFIG_BTRFS_DEBUG
>   /*
>    * Request chunk allocation with current chunk size.
> @@ -835,6 +870,7 @@ SPACE_INFO_ATTR(bytes_zone_unusable);
>   SPACE_INFO_ATTR(disk_used);
>   SPACE_INFO_ATTR(disk_total);
>   BTRFS_ATTR_RW(space_info, chunk_size, btrfs_chunk_size_show, btrfs_chunk_size_store);
> +BTRFS_ATTR(space_info, size_classes, btrfs_size_classes_show);
>   
>   static ssize_t btrfs_sinfo_bg_reclaim_threshold_show(struct kobject *kobj,
>   						     struct kobj_attribute *a,
> @@ -887,6 +923,7 @@ static struct attribute *space_info_attrs[] = {
>   	BTRFS_ATTR_PTR(space_info, disk_total),
>   	BTRFS_ATTR_PTR(space_info, bg_reclaim_threshold),
>   	BTRFS_ATTR_PTR(space_info, chunk_size),
> +	BTRFS_ATTR_PTR(space_info, size_classes),
>   #ifdef CONFIG_BTRFS_DEBUG
>   	BTRFS_ATTR_PTR(space_info, force_chunk_alloc),
>   #endif


