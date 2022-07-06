Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62095567E3F
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jul 2022 08:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiGFGQg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Jul 2022 02:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiGFGQe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Jul 2022 02:16:34 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70072.outbound.protection.outlook.com [40.107.7.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD079FE8
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 23:16:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VsqiqQRQ3Yq4f2RFlP2kIZQy+gcUNZOwpSH5nqnZfZAFOcsFU259RzXR+ZzcxU/3d1qxV7QLI304duK38CstlrwB0F2r/1+w+khuQ2QWeZLXyW69ubr7U/VUW5dXzldGYmNjUdKO47HLijYqNtJkuEymL0Wmo3uJnOhUg8JVisdMdB+jOlmfIDYEOpqE3BU56Edkc9fd+tGuPALzNpEyHwpvbFaijXoTRMy2LTIHdqNJ30Mn/ZnuiMY4lLPsqNaaf5TLhnQBCbE1RKUY2jbOMafnWd2jkYFBR0agYj2JNvdQFZX7uwLNBYe6F1R3wcalvTP73u4rC/KerCNFwW5C5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ezF+m7ch3NQDKcfeA/j7xLlgdoUgY07WVOAZEdhzStw=;
 b=SDUhaEDS0thfYrPGS0QE7Htpo9EBxyRT2bkaVGRjFDaQKd8ci+NIw6GeQdGe7PHCXjHlyD7T/LHE3SxM396ggtPK5Xl4AoMhcplZYZM8j9Mwm+ILrqD1g/YF9EV7oG3PdAZFgBrEisVglLb/SqyUUOY5wnQpBJL+OJUG8MSHlwdOEB5AmqfK5sUQWhQJX/f96Ah6N0BbI7XxtQ7Eg0XieC+UMnTyzUvEJYXRb2ataHLiN0uVshlUtVXB2XvYdeScGPKOFBZ2raYE8DjHzwEINqmVOQ+7Hp/YLUkV2GWH3fFGQD2NTR2kYn9Nrf4OGi2sVPt6o7ZFb6W5a9zRcjzBDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ezF+m7ch3NQDKcfeA/j7xLlgdoUgY07WVOAZEdhzStw=;
 b=jq9p8klxsFPopiEnbZU/x0iKz3NFuFgVfXRCAx7SPImKE28HVQI+Wv1A24MZo2uovR5jOKB7IIz595BJsSZlOucqtk16759cPgUJg5xCQhSTNJPK0uqFIU2H0wz2jYjd/N4kP+CUkf/fl0UhDE0x3YQHmQNARBKnBURrX6pgEs0ZqG1SYcBZsBySjQcD788D+sOclEu38sXoNmLHqP1Qn95g0ebBzdCllS69f8Uyz/fXx08i4AJASUpYWIhKvggQ0TwYez2sBE4fNydb/BytCwpuIZOOqYjzzmIzNdAdFpbSULTwxAksDgmX4EDVzFgUPtoGn6SFRh8L6xKe3P+usw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AM8PR04MB7937.eurprd04.prod.outlook.com (2603:10a6:20b:248::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Wed, 6 Jul
 2022 06:16:29 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::c48:27de:73e5:ea97]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::c48:27de:73e5:ea97%9]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 06:16:29 +0000
Message-ID: <80911341-8479-5a49-7a96-0f75c12dce74@suse.com>
Date:   Wed, 6 Jul 2022 14:16:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH RFC 06/11] btrfs: write-intent: introduce an internal
 helper to set bits for a range.
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <cover.1657004556.git.wqu@suse.com>
 <ad68fad714efc8ab938ca69af099afd0e1201075.1657004556.git.wqu@suse.com>
In-Reply-To: <ad68fad714efc8ab938ca69af099afd0e1201075.1657004556.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0053.namprd07.prod.outlook.com
 (2603:10b6:a03:60::30) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77e580e3-31ae-4701-38d5-08da5f170fc6
X-MS-TrafficTypeDiagnostic: AM8PR04MB7937:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SjAR8qdkY94Q963hseMrUOkmJw9Aelt9HP0QU4np1GzUImIXtLk8qlAkxELNUUGugbnc745YptIlvN1MdUNAAnd5ZuKQ2YyLzHFbisOp1h0zWYmASymxzzNx+Q65lQ/0cG5f9GITm3i1DUROZm+775gJjWWo8Zp0p/ugAA+pNtTZ8lxjbI6Sjj6gc01euISVA2Q6Keo42Q/y2445lY7SlpM+RpTAS3LoOAu9aGN09yNAXHvzjv2TIM1tWOs+hxQ8iotjYvhXMtPe55uCLu9H7HY3CFYkTCTmhbDTgWVmjsuaBoCJdaiD+dNqNqC6QY7/BvSI+d0MLSumKGnbQvkN5mf0kBbdieBe6QQMGdLsCwSPHBptSdrxolAyAtdpozenlo6o6QHUmMTed/xKMEYPeYZM9vZz8LsL/J+/6rSjY1DALSg30GasO77KY7NXH/2j0zS/SrI1nuHoUUVLAMV8oSbfdR0G4geo3C7vzfZl+4XPlI+AVksLro63UXjYYhGfDKcGlr13ItWs3mOeSlbpMDPAmHVUAj83zlfoPn9yqsFYKx5/dq/eC4YGkArhylxyMpE1Ywj742PLg4A6r/ZADuESR1IzfAd6Y71kyVAS7ofKgn8m3v+s16GnF4IaO+Vun0kyFJ5JPTMaLx0mtMse37GB9ArdmZYMo2XTsDtGB2YbISuM9AaenCwpBrZZCMPcE4+/JcJpAV16arxgnapgyrMcNNjI8HT5mxpr1Opzs6Wm821DOta6ULgBTQjWqN6I6YsZD+eM8RfcPPKtLuwPIYF/8z9rSqeH40x3Nrwt8KWpAYl3Pwvf6Pfg5Nz6yBsPL5h15K5WMORiIiF62IxP2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(376002)(39860400002)(366004)(136003)(36756003)(6506007)(6486002)(2616005)(6512007)(186003)(83380400001)(478600001)(53546011)(38100700002)(2906002)(31686004)(8676002)(66476007)(66556008)(66946007)(86362001)(41300700001)(8936002)(5660300002)(31696002)(6666004)(6916009)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVZPa1NpTlA1RTB5NE1FUkJ1TUlNMlZ0V1Q2SzZSVFhqVU1uK3BiTGtvd01U?=
 =?utf-8?B?VE0wMEN5dkVnQmdtVk1ONng4ck4vdVBWWDZleDNuSnBjSVJrWUVHY0pyblZp?=
 =?utf-8?B?cDhuVmorbjJwSlZnN0lkZllyR29IQmV2R2kzT2c3TlJFOEZaVldpblEwdmtw?=
 =?utf-8?B?VlJEYWNCSkFWVEw2em5Yb25PQlRTbmdqMUVZOWhtdVduY2g2TGFQMXJBb1dI?=
 =?utf-8?B?eFV4QUQwS0k5TXdjdDJ1NUs5c0V1dHNOOHBpTW9aWmpmTmM5bGJPclFFQzlK?=
 =?utf-8?B?aFRQSjYzRVFwaWxQQWMxUU41NWhrbnFEM3ZYWHR2L2Uwdk9Hc1pqUFVySHUv?=
 =?utf-8?B?bUx0K1k1ZFBVU3VOVEd1RFlCTVhmeWhuQ0hUem5zNEkzM3E2V2RJREs4Q3NH?=
 =?utf-8?B?eEptZFZzckM2dWl6VlRNMnBoOWpiSjEvY2hUcTF3WUM5VkJJMC9reTFIQ3Rj?=
 =?utf-8?B?elVDMmg1M1BTc3Z1RytzVllKOTZJODFnQUxHUXJRb21zaFkrQjY5TTRFTGdj?=
 =?utf-8?B?QjVmK0VYeFZWVXVUM2xPOVA1RFZvVndPRk1QTHY4UGZKVGEwV1JZYXB0akpB?=
 =?utf-8?B?NjZtdFZia0RJVU5PY1lkd3RYOEFJY2NjMDhneEJEK1FhK3lPY0VKcjBJRDFD?=
 =?utf-8?B?NnJHbGZtVHVOZFVNeHdvaytTdG1CMmJwK2pReWcvM21tM2NxZ1V6cERyOTNr?=
 =?utf-8?B?UGIrcFBoRS8yNVhsc1pJczN3L01BSzZBZlBqbGs5VHJ3YkpiL2gwV3N2UDVW?=
 =?utf-8?B?bk9NMCtoa0o2OHV1cE1ocXZYUHVOcy9CMXVidGdjSDBFM0x4MlYrcmhtdml2?=
 =?utf-8?B?NGN4RFkvNmFVUnlyamZ6YnpNRFNvNy9aUWJCTmNSSDFSN3I1RTd6VnVsVHlY?=
 =?utf-8?B?ZXM4d1hBK3RySFJOMTZ6aDFLc3JudnNHbXgvVTZwMmllTHIzMUpCRkVVcUtD?=
 =?utf-8?B?QjBMYjhSdVpJOGN0MHMwdG15U2liVWRQUmFOUVBUYXowQWlKT0oweEc0YkdT?=
 =?utf-8?B?RkFFeFhyWEVQUUpPcU0wQVRheWxyUUhrKzJRWStGVFd0ajE0TzhJQVhRZFV0?=
 =?utf-8?B?MTdvZ0V2LzF4ZG0rb0lsbG5UTXhrdU9LNUFoWGViZDJkTEJ4UXc2a2dKTEpU?=
 =?utf-8?B?LzNFSWQvOTlBRHJUY3NxTDBMYVpDMHpWKzd4dTI3dTZXQmxKSDMvbkJIVUxy?=
 =?utf-8?B?RkxvTklVSmdvUUZiZFcwazllek8yeE9VRHNVOVdwdnl4TTFDblBPSkVaUE41?=
 =?utf-8?B?L1A4YVV0Y0JOTHpCQitxRm82WEt4bWJTNTJRZVNHS2J2a3VjN3VZOXp6bklC?=
 =?utf-8?B?cDlNT3MxWVYvSkM1b1NpNnB4ZUgrcVBYeUUyZkltSUh6eWJpcm42WWRjK3lS?=
 =?utf-8?B?MGp2RjY0LzFrUFdKMmp4VVZYdWRha2ErYUdoK3Rmc0lSbmJBMWtucHcySUlQ?=
 =?utf-8?B?bkZHRkQ3UW9zV256c3NLM25BTDA0LzMwSVlwbGdxOXVvY2N0eEF2aFJpMmdi?=
 =?utf-8?B?cUhhQkoxMWVKLzcrb0tZUVNrWXVMNXg1TnA0SUU4RmpBSGlDTGhrUDZkcThI?=
 =?utf-8?B?S1FrSXMrSE9OdjNOQUw1RzEwUHhrNmRRZ3lSUHk1UnpiRy96c3FjTXFPK0s4?=
 =?utf-8?B?RDlrSmk4aDFHZ2dRdWpEOGVMSnVzb25Nc3NST2g3V3FoREQ5RlFJckR4alIr?=
 =?utf-8?B?WExEY0FpVTBpK2FDZU5TZDNhRG5aODdsTUtuWXhmNVhQLzMvd3VKd3BrLzBF?=
 =?utf-8?B?dnBndWgzZmxMeE9qTHRSUFNWcWtrSUNoZkg5T2IrSnd5WTVqbjFQb0s2S3VM?=
 =?utf-8?B?T3pYTzNaUFh6WFhKb1VxWWcvZm1WZ3NxNUN1R1RyZnAvU3Rua2RqWHJuY2tJ?=
 =?utf-8?B?MGVZZzRIS3AzM3k3L1c1cEcyYmxrZHJ4VHdYTmJQaWYvYm10K1ZOYjQwSVFN?=
 =?utf-8?B?bm5XVThRRDMzZmxjRVBPcHFja1RQVmkrMHhqSkUxaHQ4eS96Zk83TG14VmZP?=
 =?utf-8?B?TnJtbXRKLzZTYmxyUDRvZmRwZWZha3ZuMnV4WG16R1FKMDNQaUxpTDFHMURG?=
 =?utf-8?B?TXUySEhSNjF1eWlWc3RwZkRsS3FuY2hMN2cvM2VkTWt4NXB3cGtWK2lDZGlF?=
 =?utf-8?B?cE1MdEU0VHROZmk0OUFGaVBmY0NVcjlZWTdjaVl5ZkRsOGQwYUVYbHYrRmRQ?=
 =?utf-8?Q?aNNWWMDm5Jqr2BF26TjGJOE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e580e3-31ae-4701-38d5-08da5f170fc6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 06:16:29.6891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q8Kx+D7tL8KCydIrYzshYq9ebamcFjuVNgokZMbAy8vPThtuR32XIl8cE8Ej7LOQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7937
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/5 15:39, Qu Wenruo wrote:
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Unfortunately there seems to be corner case not handled properly.

If we have a start=37617664, len=196608, and we have an existing entry 0 
, bitmap=0x0700000000000000.

Then after calling set_bits() with above range, we only got:
entry 0 bitmap=0xc700000000000000.

Note 0xc = 1100 binary, thus we didn't create a new entry for the 
remaining 1 bit, and triggered the later WARN_ON_ONCE() for clear_bits.

I'll fix the bug in the code and add a selftest case for it.

Thanks,
Qu

> ---
>   fs/btrfs/write-intent.c | 251 ++++++++++++++++++++++++++++++++++++++++
>   fs/btrfs/write-intent.h |  16 +++
>   2 files changed, 267 insertions(+)
> 
> diff --git a/fs/btrfs/write-intent.c b/fs/btrfs/write-intent.c
> index a43c6d94f8cd..0650f168db79 100644
> --- a/fs/btrfs/write-intent.c
> +++ b/fs/btrfs/write-intent.c
> @@ -259,6 +259,257 @@ static int write_intent_init(struct btrfs_fs_info *fs_info)
>   	return 0;
>   }
>   
> +static struct write_intent_entry *write_intent_entry_nr(
> +				struct write_intent_ctrl *ctrl, int nr)
> +{
> +
> +	ASSERT(nr < WRITE_INTENT_INTERNAL_BITMAPS_MAX_ENTRIES);
> +	return (page_address(ctrl->page) +
> +		sizeof(struct write_intent_super) +
> +		nr * sizeof(struct write_intent_entry));
> +}
> +
> +/*
> + * Return <0 if the bytenr is before the given entry.
> + * Return 0 if the bytenr is inside the given entry.
> + * Return >0 if the bytenr is after the given entry.
> + */
> +static int compare_bytenr_to_range(u64 bytenr, u64 start, u32 len)
> +{
> +	if (bytenr < start)
> +		return -1;
> +	if (start <= bytenr && bytenr < start + len)
> +		return 0;
> +	return 1;
> +}
> +
> +/*
> + * Move all non-empty entries starting from @nr, to the right, and make room
> + * for @nr_new entries.
> + * Those new entries will be all zero filled.
> + *
> + * Caller should ensure we have enough room for @nr_new new entries.
> + */
> +static void move_entries_right(struct write_intent_ctrl *ctrl, int nr,
> +			       int nr_new)
> +{
> +	struct write_intent_super *wis = page_address(ctrl->page);
> +	int move_size;
> +
> +	ASSERT(nr_new > 0);
> +	ASSERT(wi_super_nr_entries(wis) + nr_new <=
> +	       WRITE_INTENT_INTERNAL_BITMAPS_MAX_ENTRIES);
> +
> +	move_size = (wi_super_nr_entries(wis) - nr) *
> +		     sizeof(struct write_intent_entry);
> +
> +	memmove(write_intent_entry_nr(ctrl, nr + nr_new),
> +		write_intent_entry_nr(ctrl, nr), move_size);
> +	memset(write_intent_entry_nr(ctrl, nr), 0,
> +	       nr_new * sizeof(struct write_intent_entry));
> +	wi_set_super_nr_entries(wis, wi_super_nr_entries(wis) + nr_new);
> +}
> +
> +static void set_bits_in_one_entry(struct write_intent_ctrl *ctrl,
> +				  struct write_intent_entry *entry,
> +				  u64 bytenr, u32 len)
> +{
> +	const u64 entry_start = wi_entry_bytenr(entry);
> +	const u32 entry_len = write_intent_entry_size(ctrl);
> +	unsigned long bitmaps[WRITE_INTENT_BITS_PER_ENTRY / BITS_PER_LONG];
> +
> +	wie_get_bitmap(entry, bitmaps);
> +
> +	ASSERT(entry_start <= bytenr && bytenr + len <= entry_start + entry_len);
> +	bitmap_set(bitmaps, (bytenr - entry_start) / ctrl->blocksize,
> +		   len / ctrl->blocksize);
> +	wie_set_bitmap(entry, bitmaps);
> +}
> +
> +/*
> + * Insert new entries for the range [@bytenr, @bytenr + @len) at slot @nr
> + * and fill the new entries with proper bytenr and bitmaps.
> + */
> +static void insert_new_entries(struct write_intent_ctrl *ctrl, int nr,
> +			       u64 bytenr, u32 len)
> +{
> +	const u32 entry_size = write_intent_entry_size(ctrl);
> +	u64 entry_start;
> +	u64 new_start = round_down(bytenr, entry_size);
> +	u64 new_end;
> +	int nr_new_entries;
> +	u64 cur;
> +
> +	if (nr >= wi_super_nr_entries(page_address(ctrl->page)) ||
> +	    nr >= WRITE_INTENT_INTERNAL_BITMAPS_MAX_ENTRIES)
> +		entry_start = U64_MAX;
> +	else
> +		entry_start = wi_entry_bytenr(write_intent_entry_nr(ctrl, nr));
> +
> +	ASSERT(bytenr < entry_start);
> +
> +	new_end = min(entry_start, round_up(bytenr + len, entry_size));
> +	nr_new_entries = (new_end - new_start) / entry_size;
> +
> +	if (nr_new_entries == 0)
> +		return;
> +
> +	move_entries_right(ctrl, nr, nr_new_entries);
> +
> +	for (cur = new_start; cur < new_end; cur += entry_size, nr++) {
> +		struct write_intent_entry *entry =
> +			write_intent_entry_nr(ctrl, nr);
> +		u64 range_start = max(cur, bytenr);
> +		u64 range_len = min(cur + entry_size, bytenr + len) -
> +				range_start;
> +
> +		/* Fill the bytenr into the new empty entries.*/
> +		wi_set_entry_bytenr(entry, cur);
> +
> +		/* And set the bitmap. */
> +		set_bits_in_one_entry(ctrl, entry, range_start, range_len);
> +	}
> +}
> +
> +/*
> + * This should be only called when we have enough room in the bitmaps, and hold
> + * the wi_ctrl->lock.
> + */
> +static void write_intent_set_bits(struct write_intent_ctrl *ctrl, u64 bytenr,
> +				  u32 len)
> +{
> +	struct write_intent_super *wis = page_address(ctrl->page);
> +	const u32 entry_size = write_intent_entry_size(ctrl);
> +	int i;
> +	u64 nr_entries = wi_super_nr_entries(wis);
> +	u64 cur_bytenr;
> +
> +	/*
> +	 * Currently we only accept full stripe length, which should be
> +	 * aligned to 64KiB.
> +	 */
> +	ASSERT(IS_ALIGNED(len, BTRFS_STRIPE_LEN));
> +
> +	/*
> +	 * We should have room to contain the worst case scenario, in which we
> +	 * need to create one or more new entry.
> +	 */
> +	ASSERT(nr_entries + bytes_to_entries(bytenr, len, BTRFS_STRIPE_LEN) <=
> +	       WRITE_INTENT_INTERNAL_BITMAPS_MAX_ENTRIES);
> +
> +	/* Empty bitmap, just insert new ones. */
> +	if (wi_super_nr_entries(wis) == 0)
> +		return insert_new_entries(ctrl, 0, bytenr, len);
> +
> +	/* Go through entries to find the one covering our range. */
> +	for (i = 0, cur_bytenr = bytenr;
> +	     i < wi_super_nr_entries(wis) && cur_bytenr < bytenr + len; i++) {
> +		struct write_intent_entry *entry = write_intent_entry_nr(ctrl, i);
> +		u64 entry_start = wi_entry_bytenr(entry);
> +		u64 entry_end = entry_start + entry_size;
> +
> +		/*
> +		 *			|<-- entry -->|
> +		 * |<-- bytenr/len -->|
> +		 *
> +		 * Or
> +		 *
> +		 *		|<-- entry -->|
> +		 * |<-- bytenr/len -->|
> +		 *
> +		 * Or
> +		 *
> +		 *	|<-- entry -->|
> +		 * |<-- bytenr/len -->|
> +		 *
> +		 * We need to insert one or more new entries for the range not
> +		 * covered by the existing entry.
> +		 */
> +		if (compare_bytenr_to_range(cur_bytenr, entry_start,
> +					    entry_size) < 0) {
> +			u64 new_range_end;
> +
> +			new_range_end = min(entry_start, bytenr + len);
> +			insert_new_entries(ctrl, i, cur_bytenr,
> +					   new_range_end - cur_bytenr);
> +
> +			cur_bytenr = new_range_end;
> +			continue;
> +		}
> +		/*
> +		 * |<-- entry -->|
> +		 *	|<-- bytenr/len -->|
> +		 *
> +		 * Or
> +		 *
> +		 * |<-------- entry ------->|
> +		 *	|<- bytenr/len ->|
> +		 *
> +		 * In this case, we just set the bitmap in the current entry, and
> +		 * advance @cur_bytenr to the end of the existing entry.
> +		 * By this, we either go check the range against the next entry,
> +		 * or we finish our current range.
> +		 */
> +		if (compare_bytenr_to_range(cur_bytenr, entry_start,
> +					    entry_size) == 0) {
> +			u64 range_end = min(entry_end, bytenr + len);
> +
> +			set_bits_in_one_entry(ctrl, entry, cur_bytenr,
> +					      range_end - cur_bytenr);
> +			cur_bytenr = range_end;
> +			continue;
> +		}
> +
> +		/*
> +		 * (A)
> +		 * |<-- entry -->|			|<--- next -->|
> +		 *		   |<-- bytenr/len -->|
> +		 *
> +		 * OR
> +		 *
> +		 * (B)
> +		 * |<-- entry -->|		|<--- next -->|
> +		 *		   |<-- bytenr/len -->|
> +		 *
> +		 * OR
> +		 *
> +		 * (C)
> +		 * |<-- entry -->|<--- next -->|
> +		 *		   |<-- bytenr/len -->|
> +		 */
> +		if (i < wi_super_nr_entries(wis) - 1) {
> +			struct write_intent_entry *next =
> +				write_intent_entry_nr(ctrl, i + 1);
> +			u64 next_start = wi_entry_bytenr(next);
> +
> +
> +			/* Case (A) and (B), insert the new entries. */
> +			if (cur_bytenr >= entry_end && cur_bytenr < next_start) {
> +				insert_new_entries(ctrl, i + 1, cur_bytenr,
> +						   bytenr + len - cur_bytenr);
> +				cur_bytenr = next_start;
> +				continue;
> +			}
> +
> +			/* Case (C), just skip to next item */
> +			continue;
> +		}
> +
> +		/*
> +		 * The remaining case is, @entry is already the last one.
> +		 *
> +		 * |<-- entry -->|
> +		 *		   |<-- bytenr/len -->|
> +		 *
> +		 * We're beyond the last entry. Need to insert new entries.
> +		 */
> +		insert_new_entries(ctrl, i + 1, cur_bytenr,
> +				   bytenr + len - cur_bytenr);
> +
> +		cur_bytenr = bytenr + len;
> +	}
> +}
> +
>   int btrfs_write_intent_init(struct btrfs_fs_info *fs_info)
>   {
>   	struct btrfs_device *highest_dev = NULL;
> diff --git a/fs/btrfs/write-intent.h b/fs/btrfs/write-intent.h
> index 797e57aef0e1..d8f4d285512c 100644
> --- a/fs/btrfs/write-intent.h
> +++ b/fs/btrfs/write-intent.h
> @@ -106,6 +106,15 @@ struct write_intent_entry {
>   /* The number of bits we can have in one entry. */
>   #define WRITE_INTENT_BITS_PER_ENTRY		(64)
>   
> +static inline u32 bytes_to_entries(u64 start, u32 length, u32 blocksize)
> +{
> +	u32 entry_len = blocksize * WRITE_INTENT_BITS_PER_ENTRY;
> +	u64 entry_start = round_down(start, entry_len);
> +	u64 entry_end = round_up(start + length, entry_len);
> +
> +	return DIV_ROUND_UP((u32)(entry_end - entry_start), entry_len);
> +}
> +
>   /* In-memory write-intent control structure. */
>   struct write_intent_ctrl {
>   	/* For the write_intent super and entries. */
> @@ -189,6 +198,13 @@ WRITE_INTENT_SETGET_FUNCS(super_csum_type, struct write_intent_super,
>   			  csum_type, 16);
>   WRITE_INTENT_SETGET_FUNCS(entry_bytenr, struct write_intent_entry, bytenr, 64);
>   
> +static inline u32 write_intent_entry_size(struct write_intent_ctrl *ctrl)
> +{
> +	struct write_intent_super *wis = page_address(ctrl->page);
> +
> +	return wi_super_blocksize(wis) * WRITE_INTENT_BITS_PER_ENTRY;
> +}
> +
>   static inline void wie_get_bitmap(struct write_intent_entry *entry,
>   				  unsigned long *bitmap)
>   {
