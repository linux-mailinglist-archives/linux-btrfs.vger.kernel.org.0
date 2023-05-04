Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872866F7853
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 May 2023 23:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjEDVtU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 May 2023 17:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjEDVtR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 May 2023 17:49:17 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2055.outbound.protection.outlook.com [40.107.20.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB28132BE
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 14:49:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HuEEHwt8jjBhFOIH+xuZ95X2RhCVvFlTmEIpw2nuPT9MMAg9O8dguVK7pbXsFgP7fiQaTnuIVmMJP4Hn0THMovlBQi97M1/b+EO11S6imfteoAGYGFAbIVUxgEINKyxN1ldPEdVBZYOb5S1v5+IKxRoahATrbtbXQe98sm9bXPF0K3CXKKTvvNvTix2dMpTDE6Cmu12fZjWWq/UsIcvdrLDLmGqUr/NVSB1ETqmFFQAY73Jftjz76o+blN7thAW1UJeUng/ZsE5KdYegnOD68jfGmx5BnlfAF0f1zpVYIV9BxfQ32lDzAbep4VEs7M791X6FLWBi+cIYYbKLJuKM6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RE64M1LD52SOl/iVKcHHV+ZyCt9i6f/YPMiX6llrl4A=;
 b=ngKAaGQ1YjMgLsPkkhCMI0wK7gsH5y6O8/kpcwAD1l2udpYhd9YMkG4OIaf49SsbjGHMnVAOC4rZhe5zGA+RHZF1sBR/NQjN9y1Xcf8xVnk3LUMXxchv+osjqxNVUt1xpDnQu/gpecLwPnGYwFlrIxtq7NtlX1lR9mcYyqg6Drg15sUKA372zp5O2ci0XzYejL3y6mTCuc6X8ougu2Kz+v1lc6RlciyRac31JHBoxSzt1Q6lw7Ju2pLsgbIU2Lg1Plxlxi0h0M4AqyaDH2+tIbXNm0mbhsPk3so+gyi/XwPYwLZNkTy7CKa45rUdZHiq4wFCpWXzo6O0fUwx32ailw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RE64M1LD52SOl/iVKcHHV+ZyCt9i6f/YPMiX6llrl4A=;
 b=UdcbC08BEYHBGQ6/bfRtNzCo74SNYwfNGMp53+fY2HrJaWWKdYIjPaZ4d1pWZ+AvmcvdUsl0Tu0R5JxAGDXuPo++J/oqBkAsXfH0nPhy5Tlg4yAaWi8axSLEpoWJkVyLAyQyJELWx5/mnx76NY0J4OV/A7WisUVBmQkqVcf8oQ9ey+MnrQOGjUDdAe45CnnheL7nRGu0cNwkfAXGsLo/uCBdpas1Rf3DPPxbnXuLZxthHzPpbx95IF1/TfA/9kIgQpBOWUshEw2VAxJqtF7PbUxVp3hTD60CbwXcqXpih5B44A4v4dSOTYcuL9dTzTN9WMQealPxnTviuStuuHl4aQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AS5PR04MB9855.eurprd04.prod.outlook.com (2603:10a6:20b:652::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.21; Thu, 4 May
 2023 21:49:11 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::79ff:9640:3ffc:75f2]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::79ff:9640:3ffc:75f2%5]) with mapi id 15.20.6363.027; Thu, 4 May 2023
 21:49:10 +0000
Message-ID: <e92837ae-0a14-21ee-1d2e-699165391ff2@suse.com>
Date:   Fri, 5 May 2023 05:49:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 3/9] btrfs: track original extent subvol in a new inline
 ref
To:     Boris Burkov <boris@bur.io>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1683075170.git.boris@bur.io>
 <7a4b78e240d2f26eb3d7be82d4c0b8ddaa409519.1683075170.git.boris@bur.io>
 <c10a17cb-506a-2540-eb19-c79c6c00f788@gmx.com>
 <ZFPaf/la4nhbWK7q@devvm9258.prn0.facebook.com>
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <ZFPaf/la4nhbWK7q@devvm9258.prn0.facebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0038.prod.exchangelabs.com (2603:10b6:a03:94::15)
 To AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|AS5PR04MB9855:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c248034-126f-48f2-6969-08db4ce96497
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ybPilsYwfqcTVcS0T9VCGgQ/jLd5KdgZ1g4HrTsZt72pHvJksgD0p9rQaNZj9qw41UVwKFkqj68LmTLtLXq2fhCxeZ+BZPRxYTDfgjPrdVDrqyYkWmowXV1/1K9ER7sSoFbPfof6Xi4SFROPPVODlF288gZpOiY28+fe+zkuCjGGqhGh1UG87Y/twS9l4leUUT+g32m/MPZaatp09FmlPEhkI6y0cSnuwHsNH/zK8y7c/+k3KvxBoPXQ8Ip+8VtXN3xNfMzzNeEHnmfba6YCGg09bTX/FXlZJ3wCXHg5ZyhBf1UfejdInhr6nyuDBX7Fj5r72JmCrH0wydxCbieKbIgpMtVMiEfUV0HtErvlLqNBnYzjP6bLnYym46t7hd50wnQSP1H89tugG9edP8iBP50RMQpPIooefRcAASwDR2er0wbxqG69edfDbBbP08XnqooCZNAKAmzoMYDbWNbt4E893ncrshYPFiIR06BRvbmyR8FMaMuKfererVLWZpsb3z55bs8ZZvua5MFVvrYJJYA/d5loQugYSwRTwhYyPVfR3AsjpwfXU1vJwLKvHCfPvaKZtGJYu5gIrhRVFmIUMIx2hxS7ocd2C/4tgKUiOEqOiMbbXA1CyN/ZzQla2cnZ6Pj4CDx/+ylHEZVMcYQGXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199021)(478600001)(110136005)(6506007)(186003)(31686004)(2616005)(6512007)(53546011)(6666004)(6486002)(4326008)(66556008)(41300700001)(66946007)(66476007)(316002)(83380400001)(5660300002)(8676002)(8936002)(2906002)(30864003)(38100700002)(31696002)(36756003)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEErZkYvd3gvR2h6VEJMZ0NTODR4SXFaYWx5SFg1cXVqV0k3WGNCd2x6cW1H?=
 =?utf-8?B?MlEwaHhUcDBxZ1h6OWVKUlo0YmNMc3p5SGdvMWg2MEFob2YrUFRtNEVqS1Ju?=
 =?utf-8?B?bldWeW0rbTZDNmxraDAwbzhpVUl1S1NERlR1M0dqUmJ6TUtKbFgvWnkzSVRU?=
 =?utf-8?B?ampVdURydHRkay9LRzlFRTdNdlRaMFFrVDJ4ZWVvQkhGUlBra2ozbTE1Yjlh?=
 =?utf-8?B?TjZRTlpHaDRyNERaUHZRdXoyQmR5L0dNZ0R3KzVKd0ZNQkM0dmZMUDdiclIr?=
 =?utf-8?B?R3dkQVBiRU1OeGY0Z1cvcmo0c1IrS2xjc3E0MTlWSERBbm44aEp3M0FVb0Mv?=
 =?utf-8?B?ZDlOd0tMY1ZTdUtUaEpoYUc3aUlpMXFKWlE0eGFraG9BQ1hjRGMxT3NaK2lx?=
 =?utf-8?B?Vjg2bDFNbWM0N0g4Nkx0RmN3MUUycTBMR2F6YzVxV2IrdkMvcVE2Ni9sK0Vy?=
 =?utf-8?B?dk1IMUtaNmVFR2NpbGN3czJyb3hRbWZ3N0ZnSzdaUWdhaTFrNGtTUVZtR2Fy?=
 =?utf-8?B?OHpPYTU1elhWalQxTzV1UnplK3hPaFJCVjdsNk9UdHA2bHEzUUVxeGRWMWZu?=
 =?utf-8?B?Unc5TTN4RWJrNHkrM09lakZ5bG1ueGROSm5rRlBrWTJtSGI5S2FpU0hYT0Fm?=
 =?utf-8?B?dDhUUGViVmlOU2R3MzFZczVMQVU1aW9GcHNyWS9wanJKWWRPQmZ1LzBHdmZF?=
 =?utf-8?B?elFIOUhJQ2c0SjRZUi9yTmxvQlZHTld6dnJSZG1hZ2U0dGRnZjFMT254T1ZT?=
 =?utf-8?B?WGlGMjJPQ0tRNXhyeGhTVndWOEQvWmhuSTdsenpMM2d3UDFZZVBhL09ua2c0?=
 =?utf-8?B?RXcrVnJ2OVFmaGw0bEt3TFMrZ05zK0tCOFZHVE80ZGsza3YzYitPekdqdnNy?=
 =?utf-8?B?eDM3TzZqWnBiSnhJUXVVaCs1TkpRWVA0R3RSK3N0YzBSNVdCZy85bDFFRUc5?=
 =?utf-8?B?L3lHMHV5YUpTMldyeklwY1JkSGZXcHVqWFZ2STJ3bzFSaWpqS09abXJsUnRZ?=
 =?utf-8?B?STZ1Zm5MUEZCcThnLzFwb24ydTJTeWFaUjA2NFAxUlEra3ZtSzA0OGUzOHBK?=
 =?utf-8?B?RU5VVXgzRTJZOTM0aHBzM2tOUnpZb1F5bEZQSVVDMUZ2b1h1TXgrWmJlTk96?=
 =?utf-8?B?VHpRVHd0MzhoQmNaS05sQ3JuZzN5S2NlQzNKZFA0cm1aRzVFQkQzWFFndGcr?=
 =?utf-8?B?NmV1ZTB5Y1V1OVFtWG16eVRxbzd2M1lnT2xHeGlEQ29UL1ZYVWUxQnAzcHhX?=
 =?utf-8?B?WlNrendxUVNVOFVWZC9JU1dhT0pOSkViSWNna2VDM2NYWWtGeEw5QWpqc2VJ?=
 =?utf-8?B?OE92dlB1Q29FVDE5Si8zOVBQNFhrdUJLbHVJUWpaaXJIR1pMak1yRVI1VEsx?=
 =?utf-8?B?S3R6VGp5ZU4xYTBxbnlQaXpSTWYxN283WUR5NUJheDZnbGxoUk81ZndCRWpF?=
 =?utf-8?B?Y2Y2c2lWdW16bDloNytqSm15bUZaQWMrYUpaOXNmU1liNWdoU3pIcEQ3T2V1?=
 =?utf-8?B?cHZrcjBIbXZuZU9hb3RXVm5JMXlpTWQzcEt2SWpkZzdDL2F4cWFUWTZkcGE1?=
 =?utf-8?B?NzloQlJRRk1sTVlyeGxtc1RIR040bVpGazlDNUV1TmJBSDNzQjVKSDJVZlBF?=
 =?utf-8?B?V2dUc091VWJhQTBnV1R3dXhtalhjS2Z5S0YybkhwUUZiSFlBUjZiSloxYjVR?=
 =?utf-8?B?cTZrcVJ6MmloT1QydzJ4dGR6MlBXQkxIV2hmQ1gzaVE2RUVlcXJiN2tEMEpN?=
 =?utf-8?B?VDdlTG9UcU40L1UxdkxidWRZUnlmamtLNXhNZStFUDVQQkVlUkJBT0tZeWJq?=
 =?utf-8?B?Um1EWVk4N2dhWTcwR1M4NkRBdGRJSm1zNUJTeUxTSmp6S1RnWDd0L3U1L0tt?=
 =?utf-8?B?eUtTdElFWmk4d1ZUdG5kZ2hGakpWdXBaOFU3UmJVVHJUdFJ2ZElrd081VHF3?=
 =?utf-8?B?UEMwVWp1OWFtVkxvaFNqMDhkVDdjL1Rtc1NtMTlaMWRDTUM2S05TM3NOTWtv?=
 =?utf-8?B?OFhYTDlFMnlPQm1QNjhTOGFVTUZ1Z1hRVmFQUktTbnRVbTdCRElzM1FLTzFu?=
 =?utf-8?B?bGFZZmhlSEpXYmcxZldaOXZ1SFNvWGpSV2xKMXpBM0hVcnhlWHN4aDNQT1U1?=
 =?utf-8?B?dU1Fc2ZtWDRHWSt2cWE0OG5rWVFsNTBMMFRXN1FSdXNITGswRmE2S2N3ejAy?=
 =?utf-8?Q?/VLFv6t7ncLj6BruCSXVE1o=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c248034-126f-48f2-6969-08db4ce96497
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 21:49:10.6563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zLWjpP+cBPZB4nNVFPY97ivGuG0ZANMz7i9TMBXSFtNEbCzQpSn67E8jipZilgLg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9855
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/5 00:17, Boris Burkov wrote:
> On Wed, May 03, 2023 at 11:17:12AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2023/5/3 08:59, Boris Burkov wrote:
>>> In order to implement simple quota groups, we need to be able to
>>> associate a data extent with the subvolume that created it. Once you
>>> account for reflink, this information cannot be recovered without
>>> explicitly storing it. Options for storing it are:
>>> - a new key/item
>>> - a new extent inline ref item
>>>
>>> The former is backwards compatible, but wastes space, the latter is
>>> incompat, but is efficient in space and reuses the existing inline ref
>>> machinery, while only abusing it a tiny amount -- specifically, the new
>>> item is not a ref, per-se.
>>
>> Even we introduce new extent tree items, we can still mark the fs compat_ro.
>>
>> As long as we don't do any writes, we can still read the fs without any
>> compatibility problem, and the enable/disable should be addressed by
>> btrfstune/mkfs anyway.
> 
> Unfortunately, I don't believe compat_ro is possible with this design.
> Because of how inline ref items are implemented, there is a lot of code
> that makes assumptions about the extent item size, and the inline ref
> item size based on their type. The best example that definitely breaks
> things rather than maybe just warning is check_extent in tree-checker.c

IIRC if it's compat_ro, older kernel would reject the block group items 
read.

If we expand that behavior to reject the whole extent tree, it can stay 
compat_ro.
Although you may need to do extra backports.

> 
> With a new unparseable ref item inserted in the sequence of refs, that
> code will either overflow or detect padding. The size calculation comes
> up 0, etc. Perhaps there is a clever way to trick it, but I have not
> seen it yet.
> 
> I was able to make it compat_ro by introducing an entirely new item for
> the owner ref, but that comes with a per extent disk usage tradeoff that
> is fairly steep for storing just a single u64.

If it's only to glue the original ref to an extent, I guess a new key 
without an item would be enough.
Although that's still quite expensive.

> 
>>
>> Thanks,
>> Qu
>>>
>>> Signed-off-by: Boris Burkov <boris@bur.io>
>>> ---
>>>    fs/btrfs/accessors.h            |  4 +++
>>>    fs/btrfs/backref.c              |  3 ++
>>>    fs/btrfs/extent-tree.c          | 50 +++++++++++++++++++++++++--------
>>>    fs/btrfs/print-tree.c           | 12 ++++++++
>>>    fs/btrfs/ref-verify.c           |  3 ++
>>>    fs/btrfs/tree-checker.c         |  3 ++
>>>    include/uapi/linux/btrfs_tree.h |  6 ++++
>>>    7 files changed, 70 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
>>> index ceadfc5d6c66..aab61312e4e8 100644
>>> --- a/fs/btrfs/accessors.h
>>> +++ b/fs/btrfs/accessors.h
>>> @@ -350,6 +350,8 @@ BTRFS_SETGET_FUNCS(extent_data_ref_count, struct btrfs_extent_data_ref, count, 3
>>>    BTRFS_SETGET_FUNCS(shared_data_ref_count, struct btrfs_shared_data_ref, count, 32);
>>> +BTRFS_SETGET_FUNCS(extent_owner_ref_root_id, struct btrfs_extent_owner_ref, root_id, 64);
>>> +
>>>    BTRFS_SETGET_FUNCS(extent_inline_ref_type, struct btrfs_extent_inline_ref,
>>>    		   type, 8);
>>>    BTRFS_SETGET_FUNCS(extent_inline_ref_offset, struct btrfs_extent_inline_ref,
>>> @@ -366,6 +368,8 @@ static inline u32 btrfs_extent_inline_ref_size(int type)
>>>    	if (type == BTRFS_EXTENT_DATA_REF_KEY)
>>>    		return sizeof(struct btrfs_extent_data_ref) +
>>>    		       offsetof(struct btrfs_extent_inline_ref, offset);
>>> +	if (type == BTRFS_EXTENT_OWNER_REF_KEY)
>>> +		return sizeof(struct btrfs_extent_inline_ref);
>>>    	return 0;
>>>    }
>>> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
>>> index e54f0884802a..8cd8ed6c572f 100644
>>> --- a/fs/btrfs/backref.c
>>> +++ b/fs/btrfs/backref.c
>>> @@ -1128,6 +1128,9 @@ static int add_inline_refs(struct btrfs_backref_walk_ctx *ctx,
>>>    						       count, sc, GFP_NOFS);
>>>    			break;
>>>    		}
>>> +		case BTRFS_EXTENT_OWNER_REF_KEY:
>>> +			WARN_ON(!btrfs_fs_incompat(ctx->fs_info, SIMPLE_QUOTA));
>>> +			break;
>>>    		default:
>>>    			WARN_ON(1);
>>>    		}
>>> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
>>> index 5cd289de4e92..b9a2f1e355b7 100644
>>> --- a/fs/btrfs/extent-tree.c
>>> +++ b/fs/btrfs/extent-tree.c
>>> @@ -363,9 +363,13 @@ int btrfs_get_extent_inline_ref_type(const struct extent_buffer *eb,
>>>    				     struct btrfs_extent_inline_ref *iref,
>>>    				     enum btrfs_inline_ref_type is_data)
>>>    {
>>> +	struct btrfs_fs_info *fs_info = eb->fs_info;
>>>    	int type = btrfs_extent_inline_ref_type(eb, iref);
>>>    	u64 offset = btrfs_extent_inline_ref_offset(eb, iref);
>>> +	if (type == BTRFS_EXTENT_OWNER_REF_KEY && btrfs_fs_incompat(fs_info, SIMPLE_QUOTA))
>>> +		return type;
>>> +
>>>    	if (type == BTRFS_TREE_BLOCK_REF_KEY ||
>>>    	    type == BTRFS_SHARED_BLOCK_REF_KEY ||
>>>    	    type == BTRFS_SHARED_DATA_REF_KEY ||
>>> @@ -374,26 +378,25 @@ int btrfs_get_extent_inline_ref_type(const struct extent_buffer *eb,
>>>    			if (type == BTRFS_TREE_BLOCK_REF_KEY)
>>>    				return type;
>>>    			if (type == BTRFS_SHARED_BLOCK_REF_KEY) {
>>> -				ASSERT(eb->fs_info);
>>> +				ASSERT(fs_info);
>>>    				/*
>>>    				 * Every shared one has parent tree block,
>>>    				 * which must be aligned to sector size.
>>>    				 */
>>> -				if (offset &&
>>> -				    IS_ALIGNED(offset, eb->fs_info->sectorsize))
>>> +				if (offset && IS_ALIGNED(offset, fs_info->sectorsize))
>>>    					return type;
>>>    			}
>>>    		} else if (is_data == BTRFS_REF_TYPE_DATA) {
>>>    			if (type == BTRFS_EXTENT_DATA_REF_KEY)
>>>    				return type;
>>>    			if (type == BTRFS_SHARED_DATA_REF_KEY) {
>>> -				ASSERT(eb->fs_info);
>>> +				ASSERT(fs_info);
>>>    				/*
>>>    				 * Every shared one has parent tree block,
>>>    				 * which must be aligned to sector size.
>>>    				 */
>>>    				if (offset &&
>>> -				    IS_ALIGNED(offset, eb->fs_info->sectorsize))
>>> +				    IS_ALIGNED(offset, fs_info->sectorsize))
>>>    					return type;
>>>    			}
>>>    		} else {
>>> @@ -403,7 +406,7 @@ int btrfs_get_extent_inline_ref_type(const struct extent_buffer *eb,
>>>    	}
>>>    	btrfs_print_leaf((struct extent_buffer *)eb);
>>> -	btrfs_err(eb->fs_info,
>>> +	btrfs_err(fs_info,
>>>    		  "eb %llu iref 0x%lx invalid extent inline ref type %d",
>>>    		  eb->start, (unsigned long)iref, type);
>>>    	WARN_ON(1);
>>> @@ -912,6 +915,11 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
>>>    		}
>>>    		iref = (struct btrfs_extent_inline_ref *)ptr;
>>>    		type = btrfs_get_extent_inline_ref_type(leaf, iref, needed);
>>> +		if (type == BTRFS_EXTENT_OWNER_REF_KEY) {
>>> +			WARN_ON(!btrfs_fs_incompat(fs_info, SIMPLE_QUOTA));
>>> +			ptr += btrfs_extent_inline_ref_size(type);
>>> +			continue;
>>> +		}
>>>    		if (type == BTRFS_REF_TYPE_INVALID) {
>>>    			err = -EUCLEAN;
>>>    			goto out;
>>> @@ -1708,6 +1716,8 @@ static int run_one_delayed_ref(struct btrfs_trans_handle *trans,
>>>    		 node->type == BTRFS_SHARED_DATA_REF_KEY)
>>>    		ret = run_delayed_data_ref(trans, node, extent_op,
>>>    					   insert_reserved);
>>> +	else if (node->type == BTRFS_EXTENT_OWNER_REF_KEY)
>>> +		ret = 0;
>>>    	else
>>>    		BUG();
>>>    	if (ret && insert_reserved)
>>> @@ -2275,6 +2285,7 @@ static noinline int check_committed_ref(struct btrfs_root *root,
>>>    	struct btrfs_extent_item *ei;
>>>    	struct btrfs_key key;
>>>    	u32 item_size;
>>> +	u32 expected_size;
>>>    	int type;
>>>    	int ret;
>>> @@ -2301,10 +2312,17 @@ static noinline int check_committed_ref(struct btrfs_root *root,
>>>    	ret = 1;
>>>    	item_size = btrfs_item_size(leaf, path->slots[0]);
>>>    	ei = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_extent_item);
>>> +	expected_size = sizeof(*ei) + btrfs_extent_inline_ref_size(BTRFS_EXTENT_DATA_REF_KEY);
>>> +
>>> +	iref = (struct btrfs_extent_inline_ref *)(ei + 1);
>>> +	type = btrfs_get_extent_inline_ref_type(leaf, iref, BTRFS_REF_TYPE_DATA);
>>> +	if (btrfs_fs_incompat(fs_info, SIMPLE_QUOTA) && type == BTRFS_EXTENT_OWNER_REF_KEY) {
>>> +		expected_size += btrfs_extent_inline_ref_size(BTRFS_EXTENT_OWNER_REF_KEY);
>>> +		iref = (struct btrfs_extent_inline_ref *)(iref + 1);
>>> +	}
>>>    	/* If extent item has more than 1 inline ref then it's shared */
>>> -	if (item_size != sizeof(*ei) +
>>> -	    btrfs_extent_inline_ref_size(BTRFS_EXTENT_DATA_REF_KEY))
>>> +	if (item_size != expected_size)
>>>    		goto out;
>>>    	/*
>>> @@ -2316,8 +2334,6 @@ static noinline int check_committed_ref(struct btrfs_root *root,
>>>    	     btrfs_root_last_snapshot(&root->root_item)))
>>>    		goto out;
>>> -	iref = (struct btrfs_extent_inline_ref *)(ei + 1);
>>> -
>>>    	/* If this extent has SHARED_DATA_REF then it's shared */
>>>    	type = btrfs_get_extent_inline_ref_type(leaf, iref, BTRFS_REF_TYPE_DATA);
>>>    	if (type != BTRFS_EXTENT_DATA_REF_KEY)
>>> @@ -4572,6 +4588,7 @@ static int alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
>>>    	struct btrfs_root *extent_root;
>>>    	int ret;
>>>    	struct btrfs_extent_item *extent_item;
>>> +	struct btrfs_extent_owner_ref *oref;
>>>    	struct btrfs_extent_inline_ref *iref;
>>>    	struct btrfs_path *path;
>>>    	struct extent_buffer *leaf;
>>> @@ -4583,7 +4600,10 @@ static int alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
>>>    	else
>>>    		type = BTRFS_EXTENT_DATA_REF_KEY;
>>> -	size = sizeof(*extent_item) + btrfs_extent_inline_ref_size(type);
>>> +	size = sizeof(*extent_item);
>>> +	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE)
>>> +		size += btrfs_extent_inline_ref_size(BTRFS_EXTENT_OWNER_REF_KEY);
>>> +	size += btrfs_extent_inline_ref_size(type);
>>>    	path = btrfs_alloc_path();
>>>    	if (!path)
>>> @@ -4604,8 +4624,16 @@ static int alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
>>>    	btrfs_set_extent_flags(leaf, extent_item,
>>>    			       flags | BTRFS_EXTENT_FLAG_DATA);
>>> +
>>>    	iref = (struct btrfs_extent_inline_ref *)(extent_item + 1);
>>> +	if (btrfs_fs_incompat(fs_info, SIMPLE_QUOTA)) {
>>> +		btrfs_set_extent_inline_ref_type(leaf, iref, BTRFS_EXTENT_OWNER_REF_KEY);
>>> +		oref = (struct btrfs_extent_owner_ref *)(&iref->offset);
>>> +		btrfs_set_extent_owner_ref_root_id(leaf, oref, root_objectid);
>>> +		iref = (struct btrfs_extent_inline_ref *)(oref + 1);
>>> +	}
>>>    	btrfs_set_extent_inline_ref_type(leaf, iref, type);
>>> +
>>>    	if (parent > 0) {
>>>    		struct btrfs_shared_data_ref *ref;
>>>    		ref = (struct btrfs_shared_data_ref *)(iref + 1);
>>> diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
>>> index b93c96213304..1114cd915bd8 100644
>>> --- a/fs/btrfs/print-tree.c
>>> +++ b/fs/btrfs/print-tree.c
>>> @@ -80,12 +80,20 @@ static void print_extent_data_ref(struct extent_buffer *eb,
>>>    	       btrfs_extent_data_ref_count(eb, ref));
>>>    }
>>> +static void print_extent_owner_ref(struct extent_buffer *eb,
>>> +				   struct btrfs_extent_owner_ref *ref)
>>> +{
>>> +	WARN_ON(!btrfs_fs_incompat(eb->fs_info, SIMPLE_QUOTA));
>>> +	pr_cont("extent data owner root %llu\n", btrfs_extent_owner_ref_root_id(eb, ref));
>>> +}
>>> +
>>>    static void print_extent_item(struct extent_buffer *eb, int slot, int type)
>>>    {
>>>    	struct btrfs_extent_item *ei;
>>>    	struct btrfs_extent_inline_ref *iref;
>>>    	struct btrfs_extent_data_ref *dref;
>>>    	struct btrfs_shared_data_ref *sref;
>>> +	struct btrfs_extent_owner_ref *oref;
>>>    	struct btrfs_disk_key key;
>>>    	unsigned long end;
>>>    	unsigned long ptr;
>>> @@ -159,6 +167,10 @@ static void print_extent_item(struct extent_buffer *eb, int slot, int type)
>>>    			"\t\t\t(parent %llu not aligned to sectorsize %u)\n",
>>>    				     offset, eb->fs_info->sectorsize);
>>>    			break;
>>> +		case BTRFS_EXTENT_OWNER_REF_KEY:
>>> +			oref = (struct btrfs_extent_owner_ref *)(&iref->offset);
>>> +			print_extent_owner_ref(eb, oref);
>>> +			break;
>>>    		default:
>>>    			pr_cont("(extent %llu has INVALID ref type %d)\n",
>>>    				  eb->start, type);
>>> diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
>>> index 95d28497de7c..9edc87eaff1f 100644
>>> --- a/fs/btrfs/ref-verify.c
>>> +++ b/fs/btrfs/ref-verify.c
>>> @@ -485,6 +485,9 @@ static int process_extent_item(struct btrfs_fs_info *fs_info,
>>>    			ret = add_shared_data_ref(fs_info, offset, count,
>>>    						  key->objectid, key->offset);
>>>    			break;
>>> +		case BTRFS_EXTENT_OWNER_REF_KEY:
>>> +			WARN_ON(!btrfs_fs_incompat(fs_info, SIMPLE_QUOTA));
>>> +			break;
>>>    		default:
>>>    			btrfs_err(fs_info, "invalid key type in iref");
>>>    			ret = -EINVAL;
>>> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
>>> index e2b54793bf0c..27d4230a38a8 100644
>>> --- a/fs/btrfs/tree-checker.c
>>> +++ b/fs/btrfs/tree-checker.c
>>> @@ -1451,6 +1451,9 @@ static int check_extent_item(struct extent_buffer *leaf,
>>>    			}
>>>    			inline_refs += btrfs_shared_data_ref_count(leaf, sref);
>>>    			break;
>>> +		case BTRFS_EXTENT_OWNER_REF_KEY:
>>> +			WARN_ON(!btrfs_fs_incompat(fs_info, SIMPLE_QUOTA));
>>> +			break;
>>>    		default:
>>>    			extent_err(leaf, slot, "unknown inline ref type: %u",
>>>    				   inline_type);
>>> diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
>>> index ab38d0f411fa..424c7f342712 100644
>>> --- a/include/uapi/linux/btrfs_tree.h
>>> +++ b/include/uapi/linux/btrfs_tree.h
>>> @@ -226,6 +226,8 @@
>>>    #define BTRFS_SHARED_DATA_REF_KEY	184
>>> +#define BTRFS_EXTENT_OWNER_REF_KEY	190
>>> +
>>>    /*
>>>     * block groups give us hints into the extent allocation trees.  Which
>>>     * blocks are free etc etc
>>> @@ -783,6 +785,10 @@ struct btrfs_shared_data_ref {
>>>    	__le32 count;
>>>    } __attribute__ ((__packed__));
>>> +struct btrfs_extent_owner_ref {
>>> +	u64 root_id;
>>> +} __attribute__ ((__packed__));
>>> +
>>>    struct btrfs_extent_inline_ref {
>>>    	__u8 type;
>>>    	__le64 offset;
>>
