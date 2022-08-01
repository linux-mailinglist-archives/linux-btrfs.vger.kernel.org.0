Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7C8586292
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Aug 2022 04:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238876AbiHAC23 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 31 Jul 2022 22:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbiHAC21 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 31 Jul 2022 22:28:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73CE24E
        for <linux-btrfs@vger.kernel.org>; Sun, 31 Jul 2022 19:28:26 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26VNJB6q013313;
        Mon, 1 Aug 2022 02:28:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=QrO55UGbEMoLnV6/u5sFsDdFtSqraJNKhRT1cTHWwcI=;
 b=uBfn2Y+rUlFoh3Jagpbge26yj+h/0MRTSvP9ySlAsU9ZN7hqxXKYfauesIy1/8/x0pUt
 JNtRJPrjNNGBqTtZZEzJPd16LqGwH6xCL0yI+6dElTlXesMn3X9Cp8C9gZ5Hu069wRxC
 FUNLH4lEbj2/W6HvYkwc8klMR1APISADhhy1v8ud97cLbS6PItS5F81gxPLNYMq0Fgt8
 udL1a2O4Xj9OiK/xle/907X2N8/xhaBbhGCKnxbXujFf36U5fI3+w+YDLBD/OVLn0Nfj
 YWBA8v/CY/llU7k99k2bQ3vqyayCTAfIZS5qcwjVdVgy15UjiEuYscrVullA2zOafgeG EQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmvh9j4rf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 02:28:23 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2711VrBO007473;
        Mon, 1 Aug 2022 02:28:22 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu30ma2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 02:28:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNDHhGazUyFHcqsF0BEHcni7IjZb4ML9KTfkXNdC7f6LEHCi3jituG0TbJxeKQrw4Yy+36qDZSoKfDc2C+jZyS8unU8fU2sCAat3b5Zt9BAULK96kR2RMqS79f2cxoSBu+HSTDpeT5xGAiLjbxlobU2TECltNsrFRuiK3Eq3PD4MWHjroG5hSWY6tT5MPtjGMXfcc0ovF4qMlg/TGga+2ZXYuXN995aCxp4Ok63rgPlxREbfMn1GIap1K+ynwpnnpGpFAckffDlO4QFFTObbaz6wME9Jd5kx26MShcIFBj5mY8g5ImHhjRuzniBcWRcQLJH2lUKt3iK8/kDdcZ0BCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QrO55UGbEMoLnV6/u5sFsDdFtSqraJNKhRT1cTHWwcI=;
 b=moeYNi8gKbF6q1lTzU01mvZDHZhl8wy46qitOv5eQVrnmxv1DgP6NgT4gCvCXRWTMQktzVX0DszNWfCuN10pOU++7i0dT07Pf3sHJBZU5F5CIiipNrBUNse5fIxYFQxjZoibO8YghTON5G9SeCKQ40nQp+9oMMoPAuVZNHV7g4KD4l/FkMO1QSPXCGLtmWNMQU+2AayJ5ldqNa1Mp72HALjxkbwGosYIVsUTuZvJVwu7+eAiQJTO22whnlbxV7Zr3UxeUuu8Rj7XqySMOBLqAhXTA8FN9PhznfMJ4bfVCSeQ+lzX4iOSysqt7wgRrf3DcgMhkELK4C8ZE4OFxjNhLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrO55UGbEMoLnV6/u5sFsDdFtSqraJNKhRT1cTHWwcI=;
 b=fGIaZWLGo7n3HBygcYzAWwEPHV/Up0Hdt9UsdmPz72BaXAmVzc9eMNmWK5g+Kpy8jzUB9O9RRSPkGNxRSl7ljus49toEYj7Zjs3YiNvMmJ8I0fjh2/gHUut9nC0+D6J+FaGT2MBlUqUh3ukwwUhVoU94n23XGdRiSxrT0ETxeDs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB6178.namprd10.prod.outlook.com (2603:10b6:510:1f2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Mon, 1 Aug
 2022 02:28:19 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078%9]) with mapi id 15.20.5458.025; Mon, 1 Aug 2022
 02:28:19 +0000
Message-ID: <34ead078-6d60-883b-19e4-4b8a7567927e@oracle.com>
Date:   Mon, 1 Aug 2022 10:28:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] btrfs: dump extra info if one free space cache has more
 bitmaps than it should
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <8148a70ba12d1a0da36f0834fc2a92d4742820b7.1659317748.git.wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <8148a70ba12d1a0da36f0834fc2a92d4742820b7.1659317748.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0182.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 900b8dff-b84b-45bb-8521-08da73657f80
X-MS-TrafficTypeDiagnostic: PH7PR10MB6178:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j7U9xjHshFdSkUrp7GXEJqFhswCfk7QnTNfqTzoNv66A55lJddrRPpamQgB6Y6cl6ohm+1i/D+gVsxBzSttF0jtujeYr9O1Uaaf1z/TSQYjJ1XA8+SBRqAmoiDBOwKhhXeoCtYHDjj5pEhDHlPbEt+WNv1EDgS0BspWAZzWWLNi+h5zptWSmQ9sR8C0WH1yrJ0QNw6/B+hHaHE0XABq3VOjhTjLJgB03lHGGl+KUWJFAXS6P9AGD0cFLPwtjG8GGShTfRQP+PxY0z0C/FOkMHzleFd7OnZYB7fz2EMM1cxUMWCk5XYu9dmCh7cRXo5/nrFJOBi/gs5fA4zXfbRv/K1UkyksORuvTMTGM+bSu5+BSlQE02nB6Fkn8c0fzsoBcQ9feUnZBTPUSW2By7R9zcWmrNgJ8gLTeUk21WklHUaQeg+3ZgQCO7evvPIG8DE4mJYBZauSgr2e32I7bOFVQs2E1MYeIx4nhsJv+alNU+Nf/ZILmpS6eRY5IEjeCKcgasWuRAJL7g7SEZXYV+wZLtn2gUVomlrEhAOr/4JZlq2r+22Oym27UCfW+wFMKQyD0841/i1xcHUe5Chk6XqhziTG4MxTCrzLyzw5nu7XiEg5DxOTUXjMvq2Ogevku/ZzfblstWlwZKEf3b5NdCUDxyG1RjK/ShFHMXKPDa9tRNRQZKxMFIeTsXhBN2ezrHz92y7ieUUh/22SoFlVWainpjGQJuSuHBmDSIxbIvYEHCzc+ya7sURBGwDafHog7F08s6uX+XXnYK0g3oLi/rH9UePZOeTjEoPknseLtRV0DWNXU55wGST3qj+3R8XjQotNm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(136003)(366004)(396003)(376002)(53546011)(44832011)(6666004)(8936002)(6506007)(6512007)(26005)(8676002)(31686004)(2616005)(186003)(478600001)(66946007)(41300700001)(83380400001)(36756003)(31696002)(5660300002)(38100700002)(86362001)(66556008)(6486002)(66476007)(316002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlhQVms3QjlITi9vR21vYjVaN25nRHlINnFiUE1QczVMVllubUFWa3IyVHNU?=
 =?utf-8?B?bm5TQTFwRVI0STRmSkVUM1VUYWdFaCs3eEJaTSs3bXNuMW5FYnZjUy9iRUc0?=
 =?utf-8?B?VVZHcmdyNE5XYUd6Y1ROckI3MEtyZkJNUkdlOVFxZ2hUYmZ0aStWWjdkMUNx?=
 =?utf-8?B?OWdaSWw4STdCeUxwVVl5ekJnZG9DMGJ6WGNkZlQ5eUlvbXZqblRzRWUvUWZS?=
 =?utf-8?B?L2IwVS9JZEREZGVBaHArSjB3NGFUQ3VXWE53eE5FRlBTZ1ZJTC9BMHhKVExo?=
 =?utf-8?B?MmpKZXpBUFJqd0hMUy81dlE1eFgxMUVVdzRjQm5KZXJqT0tVNVJDaWZoUVZI?=
 =?utf-8?B?THVjeCtSaWkrQWYyMlIzSlQ2dGFkejQ2Q2ZqVXVZOG8rdVFqRU4vckhiME96?=
 =?utf-8?B?Z0tMcE9jbmNBUlliemRsd0xZTHRwUzBXK3krZTNqWFYxZ3EzalJoQTNoaUZh?=
 =?utf-8?B?aEpXZ3pBVEptSWlnSnNxdkhOU0RvMjZ2Ty9MZTJseE4wV3FwZDZkM2pnR05G?=
 =?utf-8?B?S3FuVkZhVi9hWU1jV0wzUkJjeG1WWm1kSEpkRmdITzdldmYwZEFJblR2bndy?=
 =?utf-8?B?SEFOemdEbWs3dndzeVJqbm5VRHlkM25WMHd5MWo3U08rU3JNdmthUkFpTEVD?=
 =?utf-8?B?ZXJJVi8wd01jSWV5VzA2R2Nuc0UzcDNiUmhEZFZKVVpqOXVXS0JsTHdCS2Fh?=
 =?utf-8?B?am9GdFRUYzFKQXo3SGpLSEVvZW5TZWo0N09TblBwY0s4OW5FQ095OWlLT1pT?=
 =?utf-8?B?SWRZbXhWVExvWWdZenM3UFJRbG9ET2Rnb2ljeUhQSnl5eDF0UzVJNHpCT2dT?=
 =?utf-8?B?U0NNRjc0QndBdVlEeFdwSTVVajd4elE3Y1M5TW1aSTh3QStlWU9aMHJYbHU5?=
 =?utf-8?B?c2ZEQUdiQ2FyL3Erak9Cb2RiSTFxSDBhVHRQWDhWczhCK0lzRDRqZDM0SFkv?=
 =?utf-8?B?Zi9aVzZFbE5yOGtFNW9RU1Z1ZFBYcWV0K1pBczJ5dWhnL1IveXk2eHNmbXdE?=
 =?utf-8?B?eDRsRXVHSFpKU1NodkhXQnUxaUZpSnZYTzNxT1gvTmpJMUVGYTYyWFhnL2tF?=
 =?utf-8?B?SzE0M1NTSXRBYlFsaEhGMWxYQndLV0pENlBMb1FETG02ZFhzMi81U2M0TWo0?=
 =?utf-8?B?S09Qc0xMd044Z0xaOSthS0VwZkllRzBiTmIvS0l3TFNlenBWKzRVQjMvZXkz?=
 =?utf-8?B?R0ljWVd0azdZSUh0bHphMDluYThPZjZkMXZ0dnVGWUlCUmgxWEM1THFMK2pU?=
 =?utf-8?B?bEo2dlFPZGZHSmx1YkxmWFl2VUovMHVHWm9QanpoWGNKR2R4YjE5dHdmTlI1?=
 =?utf-8?B?ZzhubmVML09ydU9EVHU0MUxKbk9mVFFISmxHZ29wQkV6dHVzTnVqZzR6Q0FN?=
 =?utf-8?B?Y09zUmtVbEZOSTZxcEJJK3JRd2hRRXNWRzNGbXBld29JTGVvc0hNRUxXNU4z?=
 =?utf-8?B?MEoyYStQQzhMTTNaMklYTEJHQVJ3bHRaTmw1eThzR3JyaWhGRTZtTnRtZVVE?=
 =?utf-8?B?cVo3ajVGOXQ4Q2JvZjN5MDRsRXJDUXpWM0txK2E2VXpRSHFXenI5K28rdkxk?=
 =?utf-8?B?QS9STEROeUtQQzZIZXJxblZ3NHRwSkRHeHFWMW96cWVXbXFwVTZLQ3lCQzRY?=
 =?utf-8?B?aHZEV0FsS2RJU0FBNGttRk1uMnNmS0YrUEFBaGx2b0VzZVB6TGFZR2QxMGlo?=
 =?utf-8?B?MTQycS9tNWswaWZSNGdjQmJSdFJ6R1RYcHNXSG1wbCt6N3E4VzZXSXBaSHF4?=
 =?utf-8?B?SHhhSUdPeE1VMEpBUnJqVTRIVXJaWi9KRVhOb2krditVMzVoM1l0QUIwQkh1?=
 =?utf-8?B?TEFUU3R4Zm5YVFZCamhoaXhqSzMzSzVJc2ViQ2toV1RSY04vbW5uSEtlVG9M?=
 =?utf-8?B?Y3hiQ1ZqcnJZeUQwZTYyM21HMzY5bDN0L1RtSEVkQmt3WHJqYTFYekFURGlv?=
 =?utf-8?B?dzZTSFlySUk3Z25EMnhyN1dLcEYxMFlJVHdGc0VKWHVmLzZWN0pPVzhsc0dB?=
 =?utf-8?B?UzUxNWdkcUtpRmdNZkozMThRdkZhU0ZtSUdjTG9yc05ETCtMbDlralo3MGhr?=
 =?utf-8?B?YzVQYWxlUWFpR1hQbU5PUHMveXNSL3d6disrV1JlZllYaUZQVGQ0N1J6ZUdF?=
 =?utf-8?Q?ilfn912QchJWY7UcSKfeLRdmq?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 900b8dff-b84b-45bb-8521-08da73657f80
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 02:28:19.7190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RQOG0X4gNzRd1I2ok0pGhBsOzmGBfi11UHRsNeN23ppYRAwYMlqgs8QegGUGRmdDNwNs+rAkvqB/hvZbzc+xqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6178
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-31_20,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208010012
X-Proofpoint-ORIG-GUID: fptjeQVrj6KIt1qYKP5S5JgH4xg5XmqO
X-Proofpoint-GUID: fptjeQVrj6KIt1qYKP5S5JgH4xg5XmqO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 01/08/2022 09:35, Qu Wenruo wrote:
> There is an internal report on hitting the following ASSERT() in
> recalculate_thresholds():
> 
>   	ASSERT(ctl->total_bitmaps <= max_bitmaps);
> 
> Above @max_bitmaps is calculated using the following variables:
> 
> - bytes_per_bg
>    8 * 4096 * 4096 (128M) for x86_64/x86.
> 
> - block_group->length
>    The length of the block group.
> 
> @max_bitmaps is the rounded up value of block_group->length / 128M.
> 
> Normally one free space cache should not have more bitmaps than above
> value, but when it happens the ASSERT() can be triggered if
> CONFIG_BTRFS_ASSERT is also enabled.
> 
> But the ASSERT() itself won't provide enough info to know which is going
> wrong.
> Is the bg too small thus it only allows one bitmap?
> Or is there something else wrong?
> 
> So although I haven't found extra reports or crash dump to do further
> investigation, add the extra info to make it more helpful to debug.
> 
  I guess there is no reproducer. If there is any other related may be 
added such as configs etc.

> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>


> ---
>   fs/btrfs/free-space-cache.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index 996da650ecdc..4ebfd9b7bc53 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -693,6 +693,12 @@ static void recalculate_thresholds(struct btrfs_free_space_ctl *ctl)
>   
>   	max_bitmaps = max_t(u64, max_bitmaps, 1);
>   
> +	if (ctl->total_bitmaps > max_bitmaps)
> +		btrfs_err(block_group->fs_info,
> +	"invalid free space control: bg start=%llu len=%llu total_bitmaps=%u unit=%u max_bitmaps=%llu bytes_per_bg=%llu",
> +			  block_group->start, block_group->length,
> +			  ctl->total_bitmaps, ctl->unit, max_bitmaps,
> +			  bytes_per_bg);
>   	ASSERT(ctl->total_bitmaps <= max_bitmaps);
>   
>   	/*

