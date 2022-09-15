Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2405B9425
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 08:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiIOGJt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 02:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIOGJp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 02:09:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA40FD34
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 23:09:43 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28F5oixC021819;
        Thu, 15 Sep 2022 06:09:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=fo3zhe0L9Rlwlzx3mKOCivJ2agZR6RwnKZCfw/MpI0s=;
 b=G+Jy4cdORKQdAa0ZITVaMC4l1C5r9/6QyirsX6u+jbQoQlAYfdaPiLOwz4JaDzILcBEv
 fYS4SQeErRnDCbSn4VeK5DmvwPBdjlUkseOUJQdZLJnQ/LC3ZFAcDiEFDQ8gkwbdZWZz
 v5M1ybBRh5HQ8CiKUpbnKt9RbzqHI+vu1FvJZn6Gwej0CyfXru3WLbaFMZHlVTAdcj1C
 cVJUtBM35V3SEgVy9g0P1dG1iDWOnfLH7CSgxhMYoTwpMEsymBSqXJkpVzkwmqNFcT0J
 82dmqcUjuwQmkd7ill+qsD462o1NuKOeyOk8EmYqhFtgMsjz0WOsY8tsXLzfCLoJAEta Tg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxypc6qw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 06:09:40 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28F5uGZn009576;
        Thu, 15 Sep 2022 06:09:38 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jjyednuu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 06:09:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJ5pOJVbW9T9shaXtl6m9pJrCm9mr6TGPqu0NffhLVKjrX4KN2LrNEma2tO+m69+IdjhhJRmKf5eZDdB4fwNNNLfoEG9iseeAzI2BMj43FnNaxIUkElmJkQMEDoZcUq1eFZhxzUtNSDuEwZkWbql+y8jRif8ZLc5LSlHX8Q3gAAg/Wpd4yJ1/A0fU++rEBa9vgDk+SOBhSkY5kuLgaIGf6uc3yXHmLM6tB5nXTKjtcq5VUYABpiURZTlTfFYD2mqPw+hFn7eVcfdEzaNRMQGsq0SP/vkaABi64YVZ4iXXYjPgzzkR8Qx0ww9+E7AXKJyOxlvtVeJ0gcypxAIf9hBSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fo3zhe0L9Rlwlzx3mKOCivJ2agZR6RwnKZCfw/MpI0s=;
 b=b2FbhF/YCBaUW0aRixs7ffvq9nw3h8TryZ3NI+rPYsQADTc8elTBAtHTphk7SjzLsprKOdqWPz1XVXGasEklrM9dAr4/2g0NnaTkokjLuKjh2zo4y5SfiH5H6+Isc4REw8mZ9/5r0YXgxRjOsaQcy+oGdn6EJF9W+kuIvl2vXBd40m/JfO2T9kU4G0MWembY8ccPxcy24qXuk8mo0mq7ipM3qoUIsk54vqHYdSe3Dmy0/0wygt44q1sKB/i3kY7xIQ3xsSpIMC3DKXZcV+0X6Pf/rnyHnBO7amA1c5u3WFk1uzPTs25gukI66d/UOXMGkm2DYBENbts43SLbqXPMvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fo3zhe0L9Rlwlzx3mKOCivJ2agZR6RwnKZCfw/MpI0s=;
 b=qNe1985/n+HNJMhir/HgKu3HLlUHQsSToS6Lomt8ffVhLDK5XqiZTNyFgpBVeI+b3eppCrFEaZDI8/ONR8M0Q7IOIA9QeS1ZPw/33F4PVi7oRaeI5dPjFyqqiYZ41xUNUtefRJCQBwpBhttAR2J5K1iOBGmrMco3Nqf8do4HrBc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB4720.namprd10.prod.outlook.com (2603:10b6:a03:2d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 06:09:37 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::74b2:acd4:6739:716f]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::74b2:acd4:6739:716f%5]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 06:09:36 +0000
Message-ID: <b8e96769-d553-6095-cfae-d8bcbd199981@oracle.com>
Date:   Thu, 15 Sep 2022 14:09:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 01/15] btrfs: move btrfs_caching_type to block-group.h
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1663196541.git.josef@toxicpanda.com>
 <84da2b1e0670313091a6ff604c105b09f3f18879.1663196541.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <84da2b1e0670313091a6ff604c105b09f3f18879.1663196541.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:194::22) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB4720:EE_
X-MS-Office365-Filtering-Correlation-Id: b04be5a8-e716-42e5-92f6-08da96e0ddd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H7p4MyEjcWKM143n0g2dGQFqmVAFmaSOvTiKVwsLNZOOV2ODguAiyEezUcklvRocqd1KH1vSqIOJgFmueY2bIm3iIURTZ0QXcEZL7mDJx27srDqyyVw9axwael9k9l5MljJIo0kq2KLiarXyyNldv43dYl+ZYT44+Cs0WfTlLTZd0ApM37pl48KkcKuXSgsZ4+aHn8O3yEIjBKqqyStApzFKvpzv1RHpH7EuNwTEZyoeV+e39+xPhCffOZonDoSKEVYNsjbzpSsJYMg/y0Tgaa4lg0CE1I9JKvQ+q7TsuABLG21Yk8O/PNXoNQSs2rBotVOcEginrGGEbQAen1NyhPDqV4jo2UigDY9eYeJ5yjlXt18z7Vim3WQxJb+cWMsM8TuFPCptA/QyjJ9rnMXVp+LIKB8urINfOfkjFkGecLWaK1Ppxuoqwkbe7cRMwBl1mMVHdygLG5QVFNj9StpULaTFR9fAiFGiAuOr6lWqtodrssqBbBZdh9ZGAG/ZhzP1CB7HAkqQ4Og3kGismpuIcRPhrMuiPeAQP9p10o7ntPwKYw1e0eaM2Qz59bBArBukD5Bz603XIQaBgzRUpF/8FWnAIndGIcun0Ocb7TzlEITV17zThZhWAnY+P6G6tUiaXLjW4/GoOG2SpZv0eDl1BV+w0YdmB+M4DETeV3kA9yWA6Rehw6rA5XFO1lIXgPwNmo9U2+WRzCW+I34cHvemBdwBKti1hkA0c/FQ+EX6U8ZvFmuzTrIrBpHDuDOtp/aERDr7nNo7lD44ylizRZ0SQsp+PdnZ9rpiLzmpW1hf7fY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199015)(83380400001)(186003)(41300700001)(8936002)(44832011)(2616005)(5660300002)(478600001)(6486002)(316002)(86362001)(31696002)(66556008)(66946007)(6666004)(8676002)(6512007)(66476007)(6506007)(53546011)(31686004)(38100700002)(2906002)(36756003)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2xaSldUNGlWYWIrbmV3cmFXU2JBd2JMR2wxVHR5K0pPK0FXUjRuR3ZVanl0?=
 =?utf-8?B?WUhlQVl0SHA4dzZmTmhuZmVMeGVKbWx4M0U3MDdib3dselJPN1FHTEFPZTVX?=
 =?utf-8?B?VE1ENFJDRFhBTWs1QTBVbVg5NWtCNy9jem1vMVhGYkJDdFhmY0h2dFRpUThW?=
 =?utf-8?B?eUFUU05BTGdmaTd2QzJ5cGQ3TkNvRiszbjk4QlBodmRvSkFpaElHMXdxb3Y0?=
 =?utf-8?B?UllXaWlJZTF1aGN2MWJzWm1RMitGaUxMeEpZbWk1Z243Tyt5bHlwMllqTUJk?=
 =?utf-8?B?MVZ3K2Q3MCt3d3dCRnNLbFBGTHlxbWRJRFVSMjRFNWpWNy9ZTFFmdWJGQXhZ?=
 =?utf-8?B?eDVEeWI0UHkyMTJtOG5qVWJyYUljVDZOSWR1YVo3TWM2VkN4M2lSeU9uRHFI?=
 =?utf-8?B?MHlwenNwRkZNakZKNlcxazJGSVJCVFFPcGpuNkliUVVRKys4NjFxMUYyVS9X?=
 =?utf-8?B?OVFkdG8yOVY2RmhVRlZ5cWx0bXdIRklMSkloVU9sanZzb3pBaDlzTFVBNlZx?=
 =?utf-8?B?VDlJandnbUp4TzJORmxNZlcvNzNPZEE5R3k1Y3pSV3NJVDB4M2RadEdZbUkx?=
 =?utf-8?B?NDlBZllQZzlPeVFRQzhleFVPdXVDYzdzUUp2ZkNSK2t6M0JNUERzYTNmOTBn?=
 =?utf-8?B?QTJpTndOY1lYRG5DcmdyQXVtQ1pzQWxrWmZHZG5HcGNWK3NzRmtGVUg2cGsw?=
 =?utf-8?B?OGp2cENtRWNqWjdwcGUvWnYzR2JUcWhVNHYzMFBScXpYcXFBSG54clZrc01w?=
 =?utf-8?B?QVk3aGdHc25EUWp2cFNQUUEvVWtoY2YrZnJBOSsyeTFWa0lhRmttV0FvNy9O?=
 =?utf-8?B?Zkx3UStsZGM1WEZkemIzYkhxL0lJSGVmb3hsNk1VYWtESDUvaTljaFU5Ymt2?=
 =?utf-8?B?OHJMRnlkWjBXN3hqSzNnRlcwRUlIZ1Y1NVh6cDhQRVBsYTZydk5OeGpmR0VJ?=
 =?utf-8?B?MjA0TWhYdmhvU1VDMjBqOEhEOWxHeHRLRktaVWJpZmVYL2VWTHVFVVdOQklN?=
 =?utf-8?B?d0kzYTBWaWF5NEYxenY2RUNzcjBHMnl2dVFlZUQyS0t1enNoOWY2L0wvbzdR?=
 =?utf-8?B?WjFubUh2YlQyMlhuS21uNWVxSm9XWjlydmZmeUpXNHNpeFc2KzRqNnMvRjBT?=
 =?utf-8?B?NGwwSDVIY2JoZ0JuN3RxV3J2QjV5a0pGSlRWTks4SFFWSWJCMVFrTnZuamxK?=
 =?utf-8?B?bklNcTlOK3hybnRqSmw2V0RxRmpCZ24wcGt3MG9pS1RJM2VUQWZoMFEyVnNH?=
 =?utf-8?B?OTNOMVdFMVRwc0lGdHVlUlV4NEM5YTRJeXJNSHVSZWhHUkk2MEZsc1hmVXRN?=
 =?utf-8?B?TGRxeU10QW9xNTI4WWs3bkNSR25Sd1J0bFg5VEhETDB0WStWbFpJQjlNbFZN?=
 =?utf-8?B?R3QrMWJxRlJESUVRbEZ4MzUzRjVEaUprR3A2OFhId0paMmZkbFdlV29lVGVm?=
 =?utf-8?B?SGZsWlIrZGpKVnZDR1UzUEhYWms2bGFtdVR5UmxXZVZXTmFqYStzTGlMSHc2?=
 =?utf-8?B?STRMZWQ2dnNnMXo5aGZINUlEbWhndFpLL3BGNmtrTXd0cTc0dnBuWHNSd0No?=
 =?utf-8?B?VVdRMVNBMzZDeWxDWVRMb2Q5TG56OUhtVXdKSkJTWWkzL0UrNlRnTzRYSHFI?=
 =?utf-8?B?anA5cS8yTk9scGpzT2ZWNXAvK0hqVDBjaFB0eHBzQ3BwR2JaeGIydklDMG0w?=
 =?utf-8?B?MnkwbmExMEw3U1ZDbEJMTUJ5blY1NzRTSzM0RzV4L0Y3T1NuZjYrbmw5SUQ5?=
 =?utf-8?B?YXVSTlpFK21NSEZXaWRYRzlGbHBJSHhhOU5jUXczdHNPcmJya1lkREVOVkZE?=
 =?utf-8?B?NWwxOS95b1pxUUt4bU54YkIrYXBVanlodE5CQW9LVjFVUjBwOWw1TWZkenAy?=
 =?utf-8?B?bmltbjlJRWdCUDJUTjR6c3JVenJJWmlHbTJOK0xqdnB0dTZnckpuRC8wak5s?=
 =?utf-8?B?RTBtdjc5UTFQYnlsbFp6dXlYVHkzOUVuQUhjbVFiU3MvMEJxd1NkdVl1Y0t5?=
 =?utf-8?B?Wi9vOFNOck45ZW85OHdtQlZmZUJLVE1uNGpLL0lyUjkycTRGWDR4UVo0Unc3?=
 =?utf-8?B?Yjd5azVhTm9GWGJYSTJyRW5mNHJZUWlzaGFUSlJDWTVlb0pVOC9QNkczR3hJ?=
 =?utf-8?Q?vh9TSMjISmQ2dgXgXUoY0b+TF?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b04be5a8-e716-42e5-92f6-08da96e0ddd8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 06:09:36.8583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sMDhs8YF8mdpB0a2yas/tliuhhOwGF4/QqRSFhj8T+nY0I/dA0VwibJIcBwzML7uARhzE0DzlxIEmdp31NdK4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4720
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_02,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2208220000
 definitions=main-2209150032
X-Proofpoint-ORIG-GUID: ChxzWmEwWsT-_nfH2LXfFOibHNRP7GnM
X-Proofpoint-GUID: ChxzWmEwWsT-_nfH2LXfFOibHNRP7GnM
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/09/2022 07:04, Josef Bacik wrote:
> This is a block group related definition, move it into block-group.h.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>


> ---
>   fs/btrfs/block-group.h | 7 +++++++
>   fs/btrfs/ctree.h       | 7 -------
>   2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index e34cb80ffb25..558fa0a21fb4 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -57,6 +57,13 @@ enum btrfs_block_group_flags {
>   	BLOCK_GROUP_FLAG_ZONED_DATA_RELOC,
>   };
>   
> +enum btrfs_caching_type {
> +	BTRFS_CACHE_NO,
> +	BTRFS_CACHE_STARTED,
> +	BTRFS_CACHE_FINISHED,
> +	BTRFS_CACHE_ERROR,
> +};
> +
>   struct btrfs_caching_control {
>   	struct list_head list;
>   	struct mutex mutex;
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 8271b3dccf16..725c187d5c4b 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -180,13 +180,6 @@ struct btrfs_free_cluster {
>   	struct list_head block_group_list;
>   };
>   
> -enum btrfs_caching_type {
> -	BTRFS_CACHE_NO,
> -	BTRFS_CACHE_STARTED,
> -	BTRFS_CACHE_FINISHED,
> -	BTRFS_CACHE_ERROR,
> -};
> -
>   /*
>    * Tree to record all locked full stripes of a RAID5/6 block group
>    */

