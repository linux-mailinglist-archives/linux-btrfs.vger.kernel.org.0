Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8545C59953B
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Aug 2022 08:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346049AbiHSGU4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Aug 2022 02:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235053AbiHSGUy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Aug 2022 02:20:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC2060686
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Aug 2022 23:20:53 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27J5xVfc008562;
        Fri, 19 Aug 2022 06:20:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Kuobxt7/Md6RK+GjujY50DG4RFHaMaCmen/5tiWfAQ0=;
 b=b9qPVsT0k1362O9e5bgFwBNJLTI/WWnwUkH35Kqk7zdbCZYbJmis4tD03c3Aq4sfq+sG
 WjnTRlX5EsQjUftoImMUdcVgWRgwUw0EKQ6Vw7JQjpITsSht6eVRQosFcqG+qNwXhjgL
 /Yi5ZVKmGqwoqlvr5fLs0letSmhNsPyRuJb6NTgaTc4x+pFvFCqzTKuAGX5AZAkLkbKB
 xD7RHj0hEpBTJiCwmWUzGU71WNAy1jXGcnE2r8P17s1IVF2yaGPBbutTEyZ1Y0mva5jx
 Swnz/rVrrvnUf9QgtJPkOjqb1FtijiKAMBsrB+OZETWwhmmFjPXDUsbqoLYNc99uOFiM 8w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j24uxg133-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Aug 2022 06:20:46 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27J1KM5T020791;
        Fri, 19 Aug 2022 06:20:45 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j0c49gk0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Aug 2022 06:20:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBnH+cr0xlNe90jkRtzK59BHsYQPu5tM4zCXIbZTU8Ex8ElSVbiHo77QrfR0e2xb5J6HxibdpCf2l+shsrw6+w3BCdGp5WfTXt1/oa73MmjlcxBQF0m9kfGIxEFpLIJqvcilSZ4wpJ1Q1ZC79BxuGKpU9bva02iVI4ACtLeOGmSdl05FGvUXv1Y+tyH1LSzO/SFs0Sypm2A09g7E8JosxYARfUur1xECfNd53QWaBy/FiHsddisxhQtMcymxlskg3WYtDKnuwL0xWupR6CqNZUKSg4E5uZyWFVIa1bKhKqWcrfpZyxyTOsC69nLRmvE0IyvBmBSrRNhbm2OJ23eEfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kuobxt7/Md6RK+GjujY50DG4RFHaMaCmen/5tiWfAQ0=;
 b=KB8jVF0oNJA+0bsNT8+fL+BhIY9DKzrTQlPZCvs8qBOBWilcErDgNS8Rf3iPWGxOrMvJ5hZ+sgLO84JnpL3h6tic18Dojai3z/KVJFgsM31sP4GiFiqknyNdu/jEn6EHtIPBa5aa+WzJS6ZukgSAnDXNdbTUMWx9d+7kpGMyxTW0cEz3PDji/6p+rmHoDQRwUgFSglCRfpu21VFz1eAKZIA4pP1R0uZRITQxbnvKd0Jv6ZbTPU4vn6t05gtwl33HD1BhF1EvCsNW8v4FMhPKTtFnOvT2binzL2mcrWsbVo6E0iqHbzRVcy1sEzYLCoEDXFU+6Kez9q7ePToJJsF+2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kuobxt7/Md6RK+GjujY50DG4RFHaMaCmen/5tiWfAQ0=;
 b=qvMju6nw775IsgA5Iv2Wam5a04AcxRjiMNvOHNyVA3HH23E8XKa8ukhltHpeucuAxG5XtAi0FDKPSV7ckrz5cdRAXIMGRPY+vjMnQawmcHWKF/0PUJQx3hwq6Q8yIafI3i55Ja53+CxGpi4wrVKFvk1ZQTOayq+LddjkSmoRL9o=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW5PR10MB5668.namprd10.prod.outlook.com (2603:10b6:303:1a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Fri, 19 Aug
 2022 06:20:43 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078%9]) with mapi id 15.20.5546.016; Fri, 19 Aug 2022
 06:20:43 +0000
Message-ID: <9cb6418b-88a1-3473-2977-62261eeb2d7c@oracle.com>
Date:   Fri, 19 Aug 2022 14:20:36 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 07/11] btrfs: give struct btrfs_bio a real end_io handler
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>,
        Christoph Hellwig <hch@lst.de>
References: <20220806080330.3823644-1-hch@lst.de>
 <20220806080330.3823644-8-hch@lst.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220806080330.3823644-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0004.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::23) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8c719a3-b5d9-433a-eb8b-08da81aaf1f8
X-MS-TrafficTypeDiagnostic: MW5PR10MB5668:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xTqNod74BnOA7Uw+3P5ZD1M9VDFzJ10pBtzYB1nI51h1YGnoAtSiCJqh6wwFb1Ru36DQQHWJ6ma+0XI2FNfrTuNQlJIv4VQb7XRGD6HNRasacY7+qa9LBkttYuznSCw2doF6UQtntOV6mBA2HK710Vk64qiyfk2aGyaBJBTefojvFOwn/A+M4GD/yQZZNss5l49WhzxFY8yL3Kj38qWQ2uWg9vZQ2jBMLmH2JtRtE5r3Qi0eAcx6EhSsDdkAcdMBquU8Te0VvVRlwQ0N61YyJiPWEn03w6+xGstyNPrG1iD7rWl9Invd9OgIjBNsmtGPWv9RFIF7QEToBgdp5rZlGhhVZ4+4SbckiQnaojm2WYoCTxcO7cI++fgctfWfxBSXWAWVPZM8GlDtJSb4Vxnci3WuMyHZ8Hx3QLW0ctR7wGM8f4p2HN+knzbkxtSonG3/UiaK7ZwuhvAz4KeSvnK6zWlN09cKaSmahUFYuvueyPL45WmRjczSx8mibEfk+jXbo3hE7NbsKGVNCJ8ugviVn48yZ0oSHl/j/h6iHRN80ZPOhn5vSfR3ge8hqVDQzOYbqgDSFiy7VB1ExpYtYrZXknkzFZpnuZw+TPI8PLb/r93sYQChTsugCgU21Lq8vSQrcRvr7Yo6m6HDjsSPfS9b1By6Tm7Mc/Qi/MyfLysVXyWODF+0Se1tZU08eaf3OmL1FT9MiEVXaNe24S0Nl+JxERFqriAzJ3Knst/ZczbHjRb9B1LGLr8Lrn/rLPwpw24u++b+indCn/opVBoq1+7kd0xBmIkDBcrvizmfSI1eL/k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(376002)(396003)(136003)(346002)(31686004)(38100700002)(316002)(8676002)(4326008)(66556008)(66476007)(66946007)(31696002)(86362001)(36756003)(2616005)(83380400001)(186003)(41300700001)(6512007)(478600001)(53546011)(6506007)(6916009)(6666004)(26005)(6486002)(54906003)(44832011)(8936002)(5660300002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGYwUEd2a25uYmZTdm5XKy83Wk5NbnFqWktxQ2NTb0NieE92MTN4ZHQ3Ti9n?=
 =?utf-8?B?NjdPMDBNMEhPZk1xZkozTGwrc05yZEFodWxQTDIvWUNJbEdZa2ViM0pBMEZn?=
 =?utf-8?B?RFJxT0VqQzZBRHBVQ0Z0OU1PR1NUNTZkSGpzYThUNmpMSFh1MVRiRU9ybE96?=
 =?utf-8?B?NEw1UHgyb3lWMnhzTk5qSDNIRWJxZVk5dEoxNFlTZkRZa2hKTE1UaDJoeXZ2?=
 =?utf-8?B?UVJ5KzRoK2c3WjAvWVZIVFdXZW8vN2wzajFVWXpObmloRThhS1BvbDBvRnlY?=
 =?utf-8?B?ekdORXVrY2l1YStacGVtLzJNUVlONldnRVBoSTN6MndjcFFKRmhtcW5MaFU0?=
 =?utf-8?B?cGJXU2xLd3FFYUxvejg0c0RWL3ExaXJPVkwvTkNQTVI4ZytMQnlKWWU5YmN4?=
 =?utf-8?B?M2pTSUJrTU9TRmdYbUJiZG8rMVdGUUk0dGVZYjZOTE1WWjhUUFFWQzdpYXFp?=
 =?utf-8?B?ZGk1eG52dTZ5SUdWNU91WG5EQkMzYnVIL1JwY0ZuMjZTTjQwcUpmYWlQazdE?=
 =?utf-8?B?cmpLSU5mUG1kMzBrNUZVMlpXVDVWS3hxZm11Q3hobTBHUTRVSmttZzU2Y1Rk?=
 =?utf-8?B?NmR0UWpuSDFBWGdHdjhiRXJ6dW82WDNIK01xd3dZSDd0ZjRPdWZrTWFwdzBR?=
 =?utf-8?B?VCtyb1phMDliWmtORldWdHZwSkt2VlYrUHBUT1lOYjlYNlZYSUJjU05EOVhN?=
 =?utf-8?B?VTJUT2p2aXFnVHdlSUNiZU1hTWhwcDg0R0JFYWZnS2hXZWVMc2tRMDRMVm42?=
 =?utf-8?B?YlZPL2FBdFowWlE0MldwbkFaTU4zYlNZNmQ3UUtjRnpaUTBZcFNHdEtCUUVo?=
 =?utf-8?B?MUZDYUhsKzZSUUlieXdEVDNVMUNoRGVwdGpUWmtFeVo5ZzVibGwyallVU1hS?=
 =?utf-8?B?QmVodlJjWC8yQ3gvYnhqL0FRdjBOdHN0ejE3anJDTm1GeFVodDA0QzVQYnh5?=
 =?utf-8?B?bno3cDNjcVFKcllsc2dZWUpJem1OV3J4eG9ldSt6Q1puTVVRY2FzczhILy9W?=
 =?utf-8?B?MjBqQUcyeG93TlB5WFMvRmVORnNINkx5V2doakdGdWVEa1UxYWJhS0NDU1di?=
 =?utf-8?B?RjdubU5TV3lwZElxN3ExUjJGVkhwVjJCWEhKaitaaER1eEdqUlZQMWl2Vnlx?=
 =?utf-8?B?MHJDZDM1cjJGSU5IaGl4NTVPMFpQdER3Q1JZN1dQcGx6QnFQb1phenh5MFln?=
 =?utf-8?B?Z05pRUYwb0JXWVoya3VqMURrdzNYR2NvZnoreHN2bUl5bEZOUUt4cFRndzJa?=
 =?utf-8?B?ZStQV0dyV2Z0by9tVWthcE4vYWtoUXk3TUNFV2h6bCtkOER6WDQ1Z29oZ0R6?=
 =?utf-8?B?dzNqU2Jkem9pNTd1WldOYmsvV0RoZTI5dWVzemZHYmVpRGJKekFkNm1ycDVV?=
 =?utf-8?B?TVhsdFVvbnByc2I1a1M0Y2xlS0pVWU9xNkxIaHhpbDN2NWxuSVdUUzRkU0Zp?=
 =?utf-8?B?dURnTkx6NzF3amdpWmtESmprYTdsbVQ0MDFzNVBQcGUvd1pPTG15bllRbmI1?=
 =?utf-8?B?UEhVcENWekJQeVk4ZzlCSG5rVWR3elMyb2NTSFNPMlBKd09LZTRJaE5FQWlU?=
 =?utf-8?B?R01QdnBoMXBwdUpqWkIwZGswWWlRTnBURlloSUJ2dWFFTTVBSEM5TGhoRyto?=
 =?utf-8?B?d0NCSDRxaVdaZ0FFTnpOQVNxVTFkS1hqZTFQSzQzNFdPMEhHa3NCU2p0ZU8y?=
 =?utf-8?B?LzhIL2pNdjhsbTk2YTVuUEZEOVl6STgwRCtMMmYvYkN3c0lPSDVTL2I0V2hh?=
 =?utf-8?B?RitvaThOY3JURmVGeWE3dmd1UVlnTjI5azRZdG0rU2JndkM2UGN2NWd1SXJ0?=
 =?utf-8?B?MDVXemxtNTNoMEhDTUVsZTF6OU8wS2hveUJHWWV1d3FDUWYrNG9vWHdTTGVJ?=
 =?utf-8?B?Z0QwNVU2RE9FNjVJNldmTk16Q29DN3ZPN2JOWE9qZ1ByOHhFRmZXOWJwQmhF?=
 =?utf-8?B?TUMzQkYyZjNkUUM3TlNReFdwODE4SmRpdWIyUnR5amZMbkZpazk2RlQxS0xn?=
 =?utf-8?B?S0ZrTi9rWlpBUE1Bc2YzaDkzSHRGQXpzSFpRbzM0WVM3R3Z4Q1pEK1ZTQlR6?=
 =?utf-8?B?S1F6Ni9oMXl5d1hBcXkyS1R4ZFJOL3ljeittQjBwQnFnV3Ntc21FM2xmR1Bv?=
 =?utf-8?Q?SvOm/eLPMN05BAvb6nWgOkdtg?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RGkzcm5ubmUraEVMandiWGErVkJ5dWhreWRnS1pTMFZlbFBsNnFZYUdDbWdM?=
 =?utf-8?B?L2lyZHJRNGF6bWFEeWx6RGJ0WkFnczFsN01mdVRYN2hJa0YyMExydnFOb3Jl?=
 =?utf-8?B?dG54UEladUNLYlJqeDhmUGZSMGhOQUVGZVp3aWVrdHhvOVlpbDYrU084RHZY?=
 =?utf-8?B?MjUvbVhaR0FCbmlEaW5hM0orejhwYjNZMHVTRldTSlgzMkNZNzFhczFQb0Q5?=
 =?utf-8?B?b2ZQenFhS3kxSWl5Y3lqcHlKMmFXRHRqT2VQVTZEd01XZW9TbDdEWHVPKyt2?=
 =?utf-8?B?UHY3M20rcXhoSFIwc3NHVXFMSHZGOEhyU2Mza3pXWDRzWlRSdGYrdXFHYnhq?=
 =?utf-8?B?eEt2Nk9hOFVZWVNjV0hRa3dWS3Q1R1VUaGNCRC9YeGRsVkE4NHNQUVpmRjhu?=
 =?utf-8?B?aGtvRXhxTUZkT3JZZ2FpQmo2L2oxeTU2WHhoZllLSlNsaWdRZFk5WExhclhu?=
 =?utf-8?B?Qk1kNERyeG9CcnRzVDcvWXMvdStGMWlrMThTdiszdUs1N3M3dVd3NHdHMzhY?=
 =?utf-8?B?TWNRZ3NHcWt3bXhKY0t0NFo4ZkZJMUovOThCTlZlbExMMUNlTlZrTkxBbUNn?=
 =?utf-8?B?K3pHeUdiWXVVakREME9zVnZQK0dhSWMyUW5FUDljTUFSRXY0azluWThYM0Rr?=
 =?utf-8?B?bVVSWEJad2w3V3kwd2x0TXN5NFkycDliY1d0Z0k3b29CdTEwbzNyN3ZuZ2Z5?=
 =?utf-8?B?Q0NvMlBMcGY5Rm9wNXpNeGZxbnlnM2dzRkpQQWtRVloyVnROcXJKZTRHM2NY?=
 =?utf-8?B?VnJ1NzE1Mkg2Wmo3dmh2dUluM2d3ZHp0aGg4eU5GLzlFR1czVmd5RmptY1cw?=
 =?utf-8?B?VFV5ZCtYQzNlNy9mVUhYNXpZS1k3bUNReE9tdVFzL1Q3QlVNeEtsM0cxaW1o?=
 =?utf-8?B?ei9LNDVnaDVuTlVib0hHZHRoN0RxTkk4RFN3Mzd3QndVT3hRdlRiZENNL21a?=
 =?utf-8?B?YmFCZHloc25BZFlaOXcwUmVwaEVDaEVzRDlIMmhqS093VmJHWllDZjZsMEpR?=
 =?utf-8?B?OEthUGNGMncvazNRU3JvNEZjaXJ3bm9hdnhjQTFhZkF2K0ZxSVRBTnpiZHhy?=
 =?utf-8?B?NUppUll6MUo5RmdEMTdkVFpYK092cGpnUjVNTXV0SUZhOU5JaktZdXozNmxN?=
 =?utf-8?B?ZzlWczV5c09TeGFuVjBwTmlOcldoZWRpUTRUc2NRLytIb3VKNWxTUUZub1VZ?=
 =?utf-8?B?dE5xMitISkRRLzU4VDdFa1VLZDIzNk9vOUZwM0kvZC8yRm1BNlFCaFJMZEM2?=
 =?utf-8?B?M0k4WGNYZ09GanNoeUNObEN4eTV4M1I4SGxxZVlGZ28zYlB5WFpMeVhDdVNK?=
 =?utf-8?Q?qVH0TMle7nI99dH4ZuGhq17pGnzqq0MpdA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8c719a3-b5d9-433a-eb8b-08da81aaf1f8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 06:20:43.3984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rdqfv7vSySQEcXtc3DTG/Ex5sbsB+Q2hEQO0qxBn04zeko7aAgxqLhQzx8/9xL9GSB11niU4OcFctFaaxXagpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5668
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-19_02,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208190025
X-Proofpoint-GUID: SLipU6rBAtjlXkTxb05ag38tP9ahfFy6
X-Proofpoint-ORIG-GUID: SLipU6rBAtjlXkTxb05ag38tP9ahfFy6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/6/22 16:03, Christoph Hellwig wrote:
> Currently btrfs_bio end I/O handling is a bit of a mess.  The bi_end_io
> handler and bi_private pointer of the embedded struct bio are both used
> to handle the completion of the high-level btrfs_bio and for the I/O
> completion for the low-level device that the embedded bio ends up being
> sent to.  To support this bi_end_io and bi_private are saved into the
> btrfs_io_context structure and then restored after the bio sent to the
> underlying device has completed the actual I/O.
> 
> Untangle this by adding an end I/O handler and private data to struct
> btrfs_bio for the highlevel btrfs_bio based completions, and leave the
> actual bio bi_end_io handler and bi_private pointer entirely to the
> low-level device I/O.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Tested-by: Nikolay Borisov <nborisov@suse.com>
> Tested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>
