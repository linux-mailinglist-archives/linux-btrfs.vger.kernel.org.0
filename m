Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09E76F3ABC
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 May 2023 00:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbjEAW66 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 May 2023 18:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjEAW6q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 1 May 2023 18:58:46 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2056.outbound.protection.outlook.com [40.107.104.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D639D2D63
        for <linux-btrfs@vger.kernel.org>; Mon,  1 May 2023 15:58:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bi/JT7mgZBnBMeItbE06DO/n99djT+eR6qtVTdcjvThBPOsEnJQscWIgq90t2/8IwOXS3rxXerx4oJfLb3+g+tBCuE8mRxl96Oza3mYWjPqKkmH6d9Lt6y2Kxidy2HKPQX04LHGvb4rFU6zBX0ZlaErqtEGz/MZlIdQIXjIDdwFF6PwAHUz22EAbQxxkftpshlUVbOPMiepAlhBoFSoLtq7UEvzhXunu+iNfehjk0lGB4hdZ1Lx3/nvWIOhLo8XQu6KNFhQZoazb7POf3zpVTu379gTjVXpghfmkuhHeTQq7KlL1tTy5/69nN9r95ei4DDfo0/tQIcP98xqUa127rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJx1hLld0U8AyYLPkGxNiQmKWx4et7e3cuNAlfX0gKU=;
 b=foao5g0PMswcDkAq/gUyKZbfmZYuljQHDGmPYaE6ImSdz5k9RLY3G3JcRYJYS4Mf1XAj4nvEAYusjZOV+p3CIXrt/GCvVnQtEPZOs9LOTy7SiBjgi5y3GsagablF5LfjmPsWd06iKKETj826zI7AXkisjf7NDUvB1WrixVM8JwnaKk3j/49WX/zZsb7JYqvNMf/P3GvzAqOAWyqr8RXyxOAVvVaiLgWXfHh5lSJTcrSy12EZOkzrqiUyQhzq0dOX/CXQvNSyO0jUF5mnH7rNPIaQHAdSCBCbab9NT16lIsr8XR+go9ooCC7LfVtqSmyjqccuwUZ2Emh+9ttPSeMjxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJx1hLld0U8AyYLPkGxNiQmKWx4et7e3cuNAlfX0gKU=;
 b=EpOE3nPS6JrcScOmSpmzDxd/ev+Nhu+LU4b0VsBk/1TIJY54mt1t5zgqxPRB/JfAjV0YoG7Sg92llzfvZKVH/nCTnAnZEpXKUr5R0/2x2QCh2SCpoqMEjTBWwq3kP6LQljNHdUgpG6dcRZSRv5mx7SBqNP9/XxcfLLKDby9cwK1zMCfBMTrL5I/88ZnVTCG/K3K+T67RL6+VX2jLT842LiixbNGJGD7rlId/nXujDagMKGhFLyU3FkoIo3zYLkg/RsscXDYgX5VXMrW473BZd05JGUTFdmQkMOe0fokYyfIWfs3IMdIpJsve2TBF4B7UrKTpx7mxQS9qX/xuA5b1iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AS8PR04MB8328.eurprd04.prod.outlook.com (2603:10a6:20b:3fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Mon, 1 May
 2023 22:58:42 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::79ff:9640:3ffc:75f2]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::79ff:9640:3ffc:75f2%5]) with mapi id 15.20.6340.031; Mon, 1 May 2023
 22:58:42 +0000
Message-ID: <d6111cfa-1315-2c45-67b3-3946a7229896@suse.com>
Date:   Tue, 2 May 2023 06:58:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH RFC] btrfs: fix qgroup rsv leak in subvol create
To:     Boris Burkov <boris@bur.io>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <c98e812cb4e190828dd3cdcbd8814c251233e5ca.1682723191.git.boris@bur.io>
 <23f9b436-223c-918c-a3fd-290c3ac3bd7e@gmx.com> <20230501165016.GA3094799@zen>
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <20230501165016.GA3094799@zen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0167.namprd05.prod.outlook.com
 (2603:10b6:a03:339::22) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|AS8PR04MB8328:EE_
X-MS-Office365-Filtering-Correlation-Id: a87f1960-aa4e-43b3-44d9-08db4a979bed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GM5x3QTaNDsms4M5oDGhswjp2HfIN4F6GQGXjvGv2yDOf3T4GaqbsoaL2k/AeD6ktrmwfV3phcJtydBKdWRpU66B5KkKW7oksEaUdWkOF86ZmOgSS4i3BTntrSCB9WI9ZeU1QKC/0IEcsPRxXj8K0Pp+LIMe7Hd9LmB/NckTa5+g3CXWnmptE9H0GW7+O8Mm3WtKgKYXrM96STdVEjMgbGtLQAFLZSZxqhWEBkOO+SP58GTuZr3kKDgqn8qzWn9eX5S5LfVqX6wWyUw9eFQnElvCWbrDdDFxhY8jJdo8q2omZSx9GSd0vBshTwaZmikEMQTkltdOr/Gi2miev2addZ5FAwakRBoxHVrAynoPhyjxqReNjBzkcnCrxG7iVLQ14ZbXIxSiA4tKeWPU6W4XGrDfb1goFZg9kxwucmknBhHjTP00RvsTN2zGj0G7Txpemh13HySoA4Kju1zPyz9KRR1a6nDgNbd6Am6vQerMKk8HCimvp41Ad+YHWecy4RIs3C87bCPBRZZxKFmmsb21dw47DRSvlVGYzet7rKLC+tozsZQmjw3gfrR2lFMowO6qn2+EvbTnTyrOv29Lz0/eMPXWQMwnVfUax7OQIHrcw+1vSHVyeokVb52i+Qxb22NUO1HVlG/zJ9l7K5PBvpUupA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(366004)(346002)(39860400002)(451199021)(53546011)(6512007)(6506007)(2906002)(5660300002)(2616005)(83380400001)(31686004)(186003)(8676002)(36756003)(8936002)(6486002)(6666004)(41300700001)(478600001)(38100700002)(110136005)(316002)(66556008)(66946007)(31696002)(86362001)(4326008)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnMrL3plam1PL1NCQTVUU1k0LzRhQUZ5cmNLSWRZS2RxWDRBbUVLaWF3V1E0?=
 =?utf-8?B?MDJDTzNzdzUxUTN1M0dCQ1kwcGxraXVaOVFTOTRjc3pnS1NtT2czeThrV1dw?=
 =?utf-8?B?S2FyeFhGRXA3VTBxMi9CMHF0dENCUHlnNUVrZlYwQ3cvOG5rQndYZllZRHVB?=
 =?utf-8?B?T0FjVFZXWnArNVBqRldZRUdOWFVobk0rZEpnSFhVTXhacjRJTjZHbllBaWVv?=
 =?utf-8?B?NHZrZFB5L1h1Kys3ZDgzamdEMmliUk4rV0pTQXVMN0o1eW5nUm9LUTFUTWdu?=
 =?utf-8?B?bE9HRktjT2VuNmlYenlLU2RWK2JuUkNOUlpEaVkvazhWQ2tlcUU3WmVKcFg1?=
 =?utf-8?B?eVNzd1BlakVuMjRrb0E1cUErOTRFaHJnOTRDRXl0V1RZdGNoZjNTNVYvVExM?=
 =?utf-8?B?MU41bklNRThaTGlMRGVXbHJ3S1RZdXQ1MTNxT0VzV3JpckxoSXJYQVJBOWJk?=
 =?utf-8?B?ejU1RlMzVXNwYnJuUjFWRW5WdjBnRVg5Q1RiNnMyR2VveDV5Ni9NUTZMUlNR?=
 =?utf-8?B?dE1ZS2daWURRVDJXSHN4ckhVZ2xnQm8wUS9HZ2hlSlViTHU1b2tBQTJhWE9j?=
 =?utf-8?B?UTdtZlF4YWR5ZGhRaUxCd2ZRYnRWUzdvNG8vTEs2L0NCVFVSL3dNM2FYT21P?=
 =?utf-8?B?Y0x1aEE5M2o0MnN0L1BRdFR3eHF0dTZ3ckx0cnkrSkt3SGZ5aHY3SmlINDJX?=
 =?utf-8?B?WktGMmE1RzhmbTM0ZmlvRG5IRkVJVjZ0ZCtBbXZ2RDVySDZkTkVBaGtTS0l1?=
 =?utf-8?B?OWVZejdxNTd5T3dQbEF1RGVJQmt2eHpiUThocGxYVTI0aXFwaUZrR05vR3Vv?=
 =?utf-8?B?RTR0VmgzNzlKZnpMQ1VvWXAyUEoxSmNWSVhIUnlxZlRodnV4blBFWGU3NnZT?=
 =?utf-8?B?Y1FCbFNlSHlya1pmYlNEcUY5RVNucUZxWkpUVjlpaWFURUFFV08yM3B3NktK?=
 =?utf-8?B?YWJOcFAxMUVDbTZBM25lRmhqYlRsVTM4dTFHV2RrYWdYSDZBWE5jL3VwVFFP?=
 =?utf-8?B?Y2d0eDZBc1B3ZjJuTXRpVFZ6bHZpNHdWcHRhck1PVTRTNGZxUCtkMDlHMUtx?=
 =?utf-8?B?d3dCV1hnOGx0cXhwclptQW9oVFNkQ0piS3BuUXNnL2FUcmQzYlErVlA4cFU5?=
 =?utf-8?B?TkRpMVpzT0tnd1RrL1NTYUdRcXMyWTZnRzlsOTg1ODg3ZFF1eGpPSy9pUjN5?=
 =?utf-8?B?S1R3UUFoeU9oV0hVQ05LejJJZUVvV0NpbVFsOTBkYk1EN2FzZWNaYmtaTzdr?=
 =?utf-8?B?eEYrS3FPdzF3dGkvWDlpR3ZCWkVTYjJ3NTc3RG96dEN0dFY2V2NsdUk0Qkxp?=
 =?utf-8?B?WXlEcEVuQWpDYS8rQ1RFYWp4MTlMc0RhTGdkQWcvUUJrMHdiNmx3eDhUVldJ?=
 =?utf-8?B?dkk3ejJLY1ZHUXpwSDFLNUlGUW5VZ2JVbUg5eGJmOS9mTzlOTWgrSzJ6aWhV?=
 =?utf-8?B?L1NBUzhRdWdnWlRpVjE1MWZETXhORVg2TWdEZnNELzYveWNoZkZ4VnEydHhi?=
 =?utf-8?B?R3dmeC9BUUpJRnUxV0d2d1JuMFFEZUs1c1dKRkdkUDRXU0tZaVFMNWUvRVBK?=
 =?utf-8?B?dU1iTlFaNVN6NWhnV1Q1Y1FwN1lDcDM5dUpUb3pvWEp6RnJXMWFac1Qwcm42?=
 =?utf-8?B?ZWxZZ2t0aVNUSDhnSkJUczNUby9lamJURGY4QzlySldaOUp5RjFYM1R1cnVT?=
 =?utf-8?B?bTZpRlZnak9MQS9XbHZucTRaN1NMTS81RFNmbHlLemQ2UVFDQjJBdFNoN1BN?=
 =?utf-8?B?bnVnUzBaYzRkcGdKNXoxU1pwZ2doRGI2OUJSN3pWUXA0UG9zVkNJakJHMnlj?=
 =?utf-8?B?S01GZ043VjlQRlZqc2hscTVhUGtGN1NJZk9oQXNtVDVCd3NVUWNYZTRScmxE?=
 =?utf-8?B?VW9xN2R4d08xUnFSRmxOK2JyNGRiVkp3M1V6cXNEaVpMV210R04wYy9FNkFK?=
 =?utf-8?B?aXZQckwrUTEybW9rTEZnRUdVK2NzMzM1ek50U2VXeGw0d0xIUSsxakpyS3lH?=
 =?utf-8?B?RXE3Tnl0UThubG12YmVFNnllSmZwbVRaTWFWN2xVZzJ6aGpSVFVGVHBIOU1q?=
 =?utf-8?B?dlVueURWSDB2dVRoUW9KOTJCQjlvV0xqbFRMZXVBSTVVKzk5dE5rc2JQYmEz?=
 =?utf-8?B?cVg3SmtzY2hzVUVLSlp6VlByU1Q2MjFSUjRLL1dwV1k3UWd1YzNUeW9BSzZo?=
 =?utf-8?Q?wTK8n+PkzqTZc2tx1y9uGFo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a87f1960-aa4e-43b3-44d9-08db4a979bed
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 22:58:42.3748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vtCuRw/xVHM0uyynOsgMoaFQ9BgKTCmR1J6il7cqkJ+R8fn9DfEyR1Ho2vm3RrZo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8328
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/2 00:50, Boris Burkov wrote:
> On Sat, Apr 29, 2023 at 03:18:26PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2023/4/29 07:08, Boris Burkov wrote:
>>> While working on testing my quota work, I tried running all fstests
>>> while passing mkfs -R quota. That shook out a failure in btrfs/042.
>>>
>>> The failure is a reservation leak detected at umount, and the cause is a
>>> subtle difficulty with the qgroup rsv release accounting for inode
>>> creation.
>>
>> Mind to give an example of the leakage kernel error message?
>> As such message would include the type of the rsv.
>>
>>>
>>> The issue stems from a recent change to subvol creation:
>>> btrfs: don't commit transaction for every subvol create
>>>
>>> Specifically, that test creates 10 subvols, and in the mode where we
>>> commit each time, the logic for dir index item reservation never decides
>>> that it can undo the reservation. However, if we keep joining the
>>> previous transaction, this logic kicks in and calls
>>> btrfs_block_rsv_release without specifying any of the qgroup release
>>> return counter stuff. As a result, adding the new subvol inode blows
>>> away the state needed for the later explicit call to
>>> btrfs_subvolume_release_metadata.
>>
>> Is there any reproducer for it?
> 
> I believe that all you need is to run btrfs/042 with MKFS_OPTIONS set to
> include "-R quota".

Indeed, now it fails consistently.

Although you don't need the extra mkfs options, as the test itself is 
utilizing qgroups already.

Thanks,
Qu
> 
>>
>> By the description it should be pretty simple as long as we create multiple
>> subvolumes in one transaction.
>>
>> I'd like to have some qgroup related trace enabled to show the problem more
>> explicitly, as I'm not that familiar with the delayed inode code.
>>
>> Thanks,
>> Qu
>>>
>>> I suspect this fix is incorrect and will break something to do with
>>> normal inode creation, but it's an interesting starting point and I
>>> would appreciate any suggestions or help with how to really fix it,
>>> without reverting the subvol commit patch. Worst case, I suppose we can
>>> commit every time if quotas are enabled.
>>>
>>> The issue should reproduce on misc-next on btrfs/042 with
>>> MKFS_OPTIONS="-K -R quota"
>>> in the config file.
>>>
>>> Signed-off-by: Boris Burkov <boris@bur.io>
>>> ---
>>>    fs/btrfs/delayed-inode.c | 4 +++-
>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
>>> index 6b457b010cbc..82b2e86f9bd9 100644
>>> --- a/fs/btrfs/delayed-inode.c
>>> +++ b/fs/btrfs/delayed-inode.c
>>> @@ -1480,6 +1480,7 @@ int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
>>>    		delayed_node->index_item_leaves++;
>>>    	} else if (!test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags)) {
>>>    		const u64 bytes = btrfs_calc_insert_metadata_size(fs_info, 1);
>>> +		u64 qgroup_to_release;
>>>    		/*
>>>    		 * Adding the new dir index item does not require touching another
>>> @@ -1490,7 +1491,8 @@ int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
>>>    		 */
>>>    		trace_btrfs_space_reservation(fs_info, "transaction",
>>>    					      trans->transid, bytes, 0);
>>> -		btrfs_block_rsv_release(fs_info, trans->block_rsv, bytes, NULL);
>>> +		btrfs_block_rsv_release(fs_info, trans->block_rsv, bytes, &qgroup_to_release);
>>> +		btrfs_qgroup_convert_reserved_meta(delayed_node->root, qgroup_to_release);
>>>    		ASSERT(trans->bytes_reserved >= bytes);
>>>    		trans->bytes_reserved -= bytes;
>>>    	}
