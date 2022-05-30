Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0575C537323
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 May 2022 02:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbiE3Ap4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 May 2022 20:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiE3Apy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 May 2022 20:45:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB721D307;
        Sun, 29 May 2022 17:45:53 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24T8kXLV026549;
        Mon, 30 May 2022 00:45:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=wAXLhe9Nsy9jgN6NMjp78VGkmwxD9N1xlHuC8wUhB3g=;
 b=CvPQ4cSeCzLhdXwbWNczJ7wXPdlUKXbarKnMx72sF3kpmM1ND7XqKqRfLLpXFT/AQuk4
 N4Kaur3tzQ6qPVev/YL3hLpvfmdk3rrbTHlnaNLGqRO6WrW3X0oXBHrQqrWSXcXV4l2a
 C9jOTkRebCd8CZ1pC7W5eCls0hwRQL42KoydnGgbjjo+93SutoEynqyzZe0g1kTGHJbp
 WnjRV963pmRrfkRRvavYfWBAXTpHMzYCp0SbAg1YBOutEeEz5sl188MWTMEyMjcmxk/A
 vC2DqT9eIJczRbk7qjs7Jfd1SIwakgq9+4nhoFHMgylmlVxVGBjo9l8dJq1FkG3xzB/j mg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbgwm1gu6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 May 2022 00:45:47 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24U0G05B022317;
        Mon, 30 May 2022 00:23:26 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gc8htrqdn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 May 2022 00:23:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGFr8v9+ISLK+GQc5DLOA6WlQ5bVBjAajsmSksgG4T0Y89rml0oAX36zRA5zgi2FDyeqOu2nI4jS5VzLJsm1NZFTZ1+vxKUL1JaclJCe4AamoeTnJEtphjGNU04w0kpVJKWY27jNVqr6/eq402MB3DiKReelIT/HWenWrqlBDDVvgHH44olNRzyVkUpzzyieCWInOTxykq6H+FxcE8DepfcreZ2BMiKOl2OOUwnzGgtN9EXkAbzTb3bOnlQN35yACGguIcaoZgUhHbjOqPQK0SzPWWaLIwu07r5c/JmA9P4khgAwD8/gjZb3o39ilCMk45DFhVgEbWye1keuqP9U+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wAXLhe9Nsy9jgN6NMjp78VGkmwxD9N1xlHuC8wUhB3g=;
 b=AX9mRu8ahA04k2LfsZ5iX8cJj5GjsvACSGmNz9OiMrYAzCCtOb08dam/yOp4EkVEa3B0GUswg37TJjYUxfLspmMiIZ4roohxnfv+Y1Td5uALl+Y/oTwKWSN9XDakTIi2admlrfkn+8wKEB4pi5p4oXnh2NjV3Qlh4zvv6HL4HtUX/YbkRruTfIRq+Op0P3V2ZAMTLG2zyjDT46z6hVhm6IOIS+FzWiV7LApK3UbyaQ1ZTw4nQ/H1UNxB+EWr8z0LSa5f7x8H+af3y/pgIPdK671uZgNa6x10HzBl3rQ/0w263XunTfgODmDJM570V0ltzXtlHro+u2K0qLwBcC77ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wAXLhe9Nsy9jgN6NMjp78VGkmwxD9N1xlHuC8wUhB3g=;
 b=wy+NC5uVgRVKYR/MI1mAjS2ClBhRzoQX4Wgs1Ttk+84gp/5q+MdnttFFArbaaE4k2QHDLXpsTY8mc3RwK2b2X1qOQe6Aib8zzbW4/Ne/t/TU/9wIszueqRdhaPzpijTNSiWs1cp2u43Xl7bgNtCVFgPltIQsj0nZUojYcV58S2E=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN2PR10MB3647.namprd10.prod.outlook.com (2603:10b6:208:117::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Mon, 30 May
 2022 00:23:24 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::5cd0:c06e:f0e0:784f]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::5cd0:c06e:f0e0:784f%3]) with mapi id 15.20.5293.018; Mon, 30 May 2022
 00:23:24 +0000
Message-ID: <8bdaa753-ae46-88ec-09ce-0a5f86ea5b9d@oracle.com>
Date:   Mon, 30 May 2022 05:53:15 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH 01/10] btrfs: add a helpers for read repair testing
To:     Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>
References: <20220527081915.2024853-1-hch@lst.de>
 <20220527081915.2024853-2-hch@lst.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220527081915.2024853-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d46c6d70-dfaa-4b63-a4a2-08da41d29bdd
X-MS-TrafficTypeDiagnostic: MN2PR10MB3647:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB36473B5CFC889C8DC7B85EE8E5DD9@MN2PR10MB3647.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U8Yu/AH+8Ku38op8xHghfbGx++Q72qx06hTN/55ITEpsaT7JUbsofsPzWfw51wdvaZFaoCOFrE/0A0qLrKbT7iboQH8rjbXxgaN1RLH/T51APXPNDEtkpkW5sZ/nKtocywkTbr3P3yHYvS07obUY/DJVS0yFZ6CGObac4AoTWo4zYG01nM4jMl3LTjlCxsGin1CuBCYq6lzgyShGsfrCI6otFn0IC/dvwlvlD2+9L48ByKKRDs4XokkqwT8AOXN9hIOkhHFlljgqr9RNxZYJuyIIvQ8Alic2uAWPTmKa938rW/CSnBZBgsTOMPsY4lai0bePQVIrGfxYduA8KC2kunziVr4uhwCINENhW+HS1TWXls4NW8c4alqrkQWw/MGzNW8BBgM1A/mRrIfSADUjDhAW7txb9AXZJ/ljmom5v/luSvKZBtS2LMrLaD1FzSUkWP+I0sORE3DRsst/qkQW5Nj8/enM9eJJ44e9rCCoNV0oXKqrnIB3UFQZlFzTAsHSVEEqIZ+aQg2BXI7crH/lsLMul+chnGF8F9uvSBVV29fk5m4dep9msNWUD3n+OeS4nmownkjLfr5YB/Z2o+2Ly7Zysb5XmdahomRipyZCZOjSK+qpXJIYNORjJpeZzNq4TdiQ1ImUU6yRsItI+G1i/FBVbQRfuoq2hr3ZvewE4bO63szIoLHFhJnDqJDwFruzCDjahrUfSGRHfoA7nAM1jSSoj8liUih0nFbi15EOuiU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(316002)(86362001)(31696002)(6666004)(2906002)(508600001)(6486002)(6512007)(6506007)(8676002)(5660300002)(83380400001)(44832011)(36756003)(4326008)(31686004)(66946007)(8936002)(2616005)(66556008)(66476007)(38100700002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVUxbEhacUx1aWZNVklYemVrSHBocmFJdHBkK2dydlFtcE9nMnFxM1NxcU9o?=
 =?utf-8?B?UjVmdmhOY2xnU1ZyeDVYQnhIRTVjSm5vMEZlMFd5OUZGMjNUb0pwSktzQUhp?=
 =?utf-8?B?aFdTTkhLOTQwY0hhei9NcmI5N2luNEJmM3dMaTZrUUZBSi9lYjJDcUh5Yy9X?=
 =?utf-8?B?blN0R1ZFcWtMRUtSelpZN1V1SmlBTnN1V2dBb3hVT1BWQkd6QWdhS0NSbzlS?=
 =?utf-8?B?QzdtdERUdytpTlBzVThTN1RxZU9zL1VDZ1RtVldzenZmTEVrR25xa2MzVERi?=
 =?utf-8?B?UWtWWWtZaUx4T3pFNWU1enI2UmF6YmRWZ3ZGK3lKV3B4NzlJZzVjajFDcDE2?=
 =?utf-8?B?ME5GbXRtakxjenhPTlNjd2VKeVZ2ejFCWU5PUDJwbW11dmwzZkJ2VUlXTSsv?=
 =?utf-8?B?cEFLSGRCckNqS2oybmwwelNmNTdmOHdIaUpMMkJSd0t6aGJabzhJR0U4YlVw?=
 =?utf-8?B?eHVtWFhCdjIyck1yK0xTNHFUeUVuVGJBNEdsOGc2L0l0cUh0ZTlFSHZ2NFBN?=
 =?utf-8?B?bEF1Ync3SVpCMGdxWVFYbDlDMURNVllXREZZRWkzK1ZwQ2xQT1luMU5BUHdF?=
 =?utf-8?B?UnEzOWNCTW44RHdFaFpyVENXbXR0V0NIdzhHcFdpWkxsTlJqdTBtSkNBanc5?=
 =?utf-8?B?U2o4Wmd3K0F6UmFTazVmQU41OEVNSXVoNjRMcnl4NDdEdWVWbkk5SXBjc0sr?=
 =?utf-8?B?NEtTYjFWTlFSVUE2WDZ6WStnWVo4Q1BsYVVQRzBtSkg5Vld4d1lsYjZDSU1Z?=
 =?utf-8?B?ZXBuV3FHcWc5eFJxaXh1THF4Nmw1cjZEZElhUFhPMnhyaHJEMENzdVo5S1Yw?=
 =?utf-8?B?RUNJdXFTUmJkaiswMTF1cW9ydThLcjhQWXlTOFptRmVPOGhSc0g5eWx0K3Fm?=
 =?utf-8?B?YSttYzhWUm42YVljbnAvQmJWczBxdm9yUG5XVHBLOGpENjdPcVIxU1loNld0?=
 =?utf-8?B?NGtwWG9LbmNoaGFERitTT09uRzE2S29Ld2lqcHc2VUZoNGpTVE9HbHhJeTBv?=
 =?utf-8?B?b0NydGxGUTgzVUR0dnQ4UDRDcS91dTNjWkMwTHlmNDRDNXNHMmFLT0JnRGRh?=
 =?utf-8?B?R3ZLWXlxbzE4QjNNUVI2bklJREpOL1Q1ci9wYmZwc2FuQkErYXhaM1B3UmUv?=
 =?utf-8?B?dTFINm4ycG5SejJWNEwrUXo2UFlUNmsyelVjUTlLNUN1SlVEenp6NlFZc2Rv?=
 =?utf-8?B?ampPVGY1Z1dIOWxycGZoNFY0Mjd2VjhJZWtCWWdiQzBCTzRiUHBZTDJ5eGZE?=
 =?utf-8?B?VEZ3SGVzOWppMnZvWEpIU3crUExLVVhyemt3c0liV0JVQTIrRVlVZkdyS3Y5?=
 =?utf-8?B?NE5uZ2pzcEo2QTdPcUJSN0JUMkUrNWNtZEUyajF0V3Y4S2pYcDRZTllwdXpS?=
 =?utf-8?B?MW0ySGxMcVJPbUxzN25EMFFYZlI2VU83N0dxdW1iWVVHQkNzNkdKUDZkRzlD?=
 =?utf-8?B?M2g5UTVhZjJTeEpoQTR5WU5nMi9VQ0JDZ0pPWldZakdGYTRlRnFkanp0ZGhN?=
 =?utf-8?B?SDBmdGw4cXE4akYrV0pkR0pTV285YXJYZjFjM1JRSFhRQUZMR09GWHowcGlz?=
 =?utf-8?B?MGZnQWxHeGlMa0RQVEx2aWIrMlZWK2dObmV4bm5kMUFSdERTM2VEa0ZGbDVZ?=
 =?utf-8?B?amU5bkpVZ3FVK2FaY3oxS3orWHArYjVSbUg0dmFIamdwVVVVVXB5d0piSVNn?=
 =?utf-8?B?MHBSZkFLbm5PeUhybkdsY2tmTkdjV2VzdUVTa25TRkQxM1JROWZQVyswdnla?=
 =?utf-8?B?MjJXTFFZeDlubG4vQXZQc1ZobUpOaS8wU1BLTUNiNis1R20wRHNaZGpGaTg0?=
 =?utf-8?B?WWNhbTdCN1ByTk4yUG1QbEtpaE9IVlhUUVdTTnRzYTQ3Qll0TkhVNW5JcHlR?=
 =?utf-8?B?VVhIbmJTTEhUS0JwMjBURUNab0FrVy9pZHZFM2hYcDRtOTh0ZnI3MUdLa2lH?=
 =?utf-8?B?Qk1XcmdpZFJNM2pLeDVuSEZzc2hFbGowZng1bnVDK3QzNmZ3YlA3N1hpSGdw?=
 =?utf-8?B?SXhEU1ZESHkyUVYxcCt3QjdKcWZnMVJGNHM2SWxZR1N5RytIT0hHMGdPZnRm?=
 =?utf-8?B?VnllYi9valA5TjlINUJxcGJsY2tqY1BsRFRwKy9UNnQ5WXFCU3NoaDBBUWpu?=
 =?utf-8?B?NnFWeGk0ZjROWEkrSWtQTWpRbXZHTlpYUmRVWUxJeW9DWEdKSW1jZEZxbEdy?=
 =?utf-8?B?T3h1MW8rMFQ5cjhHVVRaRTY5L3NZYWIvZzJUb0JnUEJoeit1QWNEVmF5VWUx?=
 =?utf-8?B?OXg4K0lKZ3I1VnJwNmdSRDRmTzcwZDBRdHY0SGp0d29MRGFNQi9TTko3d1pR?=
 =?utf-8?B?OUlIS0hnVzdGdG9FYmw5U29GYmM1OUZja0lYbnZmNTNmdjhvVitHT204SnRn?=
 =?utf-8?Q?JJTl4JAhoc/fEgR5uP7dcAXFtLzree991Syj8y4kMENaX?=
X-MS-Exchange-AntiSpam-MessageData-1: IJHew2/NjBRdv+8SlXJpRkFNt6yvkrfw1cs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d46c6d70-dfaa-4b63-a4a2-08da41d29bdd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 00:23:24.3715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mf+YRObomPwWiwKbRJBQOdwDnuOIeSzZ/u8ziLyZvAJ7kgB4Q+jm/aZkafkbK6S0aZSLiCh9LvWE+DvHGg8NGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3647
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-29_07:2022-05-27,2022-05-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205300000
X-Proofpoint-GUID: BMSW_tLH80OHzLB3Yhix6KnaggUM-jJl
X-Proofpoint-ORIG-GUID: BMSW_tLH80OHzLB3Yhix6KnaggUM-jJl
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/27/22 13:49, Christoph Hellwig wrote:
> Add a few helpers to consolidate code for btrfs read repair testing:
> 
>   - _btrfs_get_first_logical() gets the btrfs logical address for the
>     first extent in a file
>   - _btrfs_get_device_path and _btrfs_get_physical use the
>     btrfs-map-logical tool to find the device path and physical address
>     for btrfs logical address for a specific mirror
>   - _btrfs_direct_read_on_mirror and _btrfs_buffered_read_on_mirror
>     read the data from a specific mirror
> 
> These will be used to consolidate the read repair tests and avoid
> duplication for new tests.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> ---
>   common/btrfs  | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   common/config |  1 +
>   2 files changed, 76 insertions(+)
> 
> diff --git a/common/btrfs b/common/btrfs
> index ac597ca4..b69feeee 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -505,3 +505,78 @@ _btrfs_metadump()
>   	$BTRFS_IMAGE_PROG "$device" "$dumpfile"
>   	[ -n "$DUMP_COMPRESSOR" ] && $DUMP_COMPRESSOR -f "$dumpfile" &> /dev/null
>   }
> +
> +# Return the btrfs logical address for the first block in a file
> +_btrfs_get_first_logical()
> +{
> +	local file=$1
> +	_require_command "$FILEFRAG_PROG" filefrag
> +
> +	${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar >> $seqres.full
> +	${FILEFRAG_PROG} -v $file | _filter_filefrag | cut -d '#' -f 1
> +}
> +
> +# Find the device path for a btrfs logical offset
> +_btrfs_get_device_path()
> +{
> +	local logical=$1
> +	local stripe=$2
> +
> +	_require_command "$BTRFS_MAP_LOGICAL_PROG" btrfs-map-logical
> +
> +	$BTRFS_MAP_LOGICAL_PROG -l $logical $SCRATCH_DEV | \
> +		$AWK_PROG "(\$1 ~ /mirror/ && \$2 ~ /$stripe/) { print \$8 }"
> +}
> +
> +
> +# Find the device physical sector for a btrfs logical offset
> +_btrfs_get_physical()
> +{
> +	local logical=$1
> +	local stripe=$2
> +
> +	_require_command "$BTRFS_MAP_LOGICAL_PROG" btrfs-map-logical
> +
> +	$BTRFS_MAP_LOGICAL_PROG -b -l $logical $SCRATCH_DEV >> $seqres.full 2>&1
> +	$BTRFS_MAP_LOGICAL_PROG -l $logical $SCRATCH_DEV | \
> +		$AWK_PROG "(\$1 ~ /mirror/ && \$2 ~ /$stripe/) { print \$6 }"
> +}
> +
> +# Read from a specific stripe to test read recovery that corrupted a specific
> +# stripe.  Btrfs uses the PID to select the mirror, so keep reading until the
> +# xfs_io process that performed the read was executed with a PID that ends up
> +# on the intended mirror.
> +_btrfs_direct_read_on_mirror()
> +{
> +	local mirror=$1
> +	local nr_mirrors=$2
> +	local file=$3
> +	local offset=$4
> +	local size=$5
> +
> +	while [[ -z $( (( BASHPID % nr_mirrors == mirror )) &&
> +		exec $XFS_IO_PROG -d \
> +			-c "pread -b $size $offset $size" $file) ]]; do
> +		:
> +	done
> +}
> +
> +# Read from a specific stripe to test read recovery that corrupted a specific
> +# stripe.  Btrfs uses the PID to select the mirror, so keep reading until the
> +# xfs_io process that performed the read was executed with a PID that ends up
> +# on the intended mirror.
> +_btrfs_buffered_read_on_mirror()
> +{
> +	local mirror=$1
> +	local nr_mirrors=$2
> +	local file=$3
> +	local offset=$4
> +	local size=$5
> +
> +	echo 3 > /proc/sys/vm/drop_caches


> +	while [[ -z $( (( BASHPID % nr_mirrors == mirror )) &&
> +		exec $XFS_IO_PROG \
> +			-c "pread -b $size $offset $size" $file) ]]; do

I am confused if it should be BASHPID or PID?

Next, it is ok if the xfs_io_prog fails and returns != 0.
(Part of the test).
But then we will continue in the while loop. No?

Sorry, I am sceptical about this. Could you please clarify
how this works?


Thanks, Anand



> +		:
> +	done




> +}
> diff --git a/common/config b/common/config
> index c6428f90..df20afc1 100644
> --- a/common/config
> +++ b/common/config
> @@ -228,6 +228,7 @@ export E2IMAGE_PROG="$(type -P e2image)"
>   export BLKZONE_PROG="$(type -P blkzone)"
>   export GZIP_PROG="$(type -P gzip)"
>   export BTRFS_IMAGE_PROG="$(type -P btrfs-image)"
> +export BTRFS_MAP_LOGICAL_PROG=$(type -P btrfs-map-logical)
>   
>   # use 'udevadm settle' or 'udevsettle' to wait for lv to be settled.
>   # newer systems have udevadm command but older systems like RHEL5 don't.

