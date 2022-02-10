Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E854B0380
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 03:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbiBJCnL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Feb 2022 21:43:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbiBJCnK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Feb 2022 21:43:10 -0500
X-Greylist: delayed 3604 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 18:43:11 PST
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40912408D
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Feb 2022 18:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1644460989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rDXfTTlh7UGR8nofKT5ama63xduINH2i+Du3YjZMots=;
        b=fjcXac6dcjZQXWvlR07KUAo50gUfCWmb6W3NnSjfjbaZoevH6hd0ml+J14wfOE5qGnwMCA
        A0W5Azn8r2LKJLdXZ469q343SW/Ku58XeIWesBumnlzbJeyMM5oHGObtU5JSoF2EdL1qa9
        pjGHPxE1WHRE1p3fVqfBSQ6YRYbggaI=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2055.outbound.protection.outlook.com [104.47.5.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-36-6pjf9BUlM76pL_5SrhxFRQ-1; Thu, 10 Feb 2022 01:40:32 +0100
X-MC-Unique: 6pjf9BUlM76pL_5SrhxFRQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ko0ooHDVTlePMpPdsY+TEn0fbxFGjWAy6AlupQimsKehB9pusAc6Wlc34dxctu+XRzaVeiuyetvcLj5Zou2Q9j5Ko0k34mbXu2NH3Zb31N4g1QInYk0ST2ZS5JECaoiisii/zZHwmZgF3HG6TRVEzyLrtkAKEN0gsYIiRwg+IHE3F8nkcN5j+Qa/AiTo7nmcmN4O4wTUXRCOPMpMXorj4lENxY2n5RCengQEOOoEiuGeSrfnKuL1Yow0443gPJJPLdtj9c2lo3w4xlEXA2tMJhv1uegp2e9FdadPgfXToR9qJW0x/Cp8cOCSG4ZzJoBdoNiBw8q8vgviYA+1l5JbzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rDXfTTlh7UGR8nofKT5ama63xduINH2i+Du3YjZMots=;
 b=bYV+5DYa61Yg6kh64rxInaNPjKb+kGEhp9JZeAXiRYTf15eLffvcqqF1zlFKucUHbvG+1KcwZYuhR3U70o+imJmrp2tclOrIEclvhl2kV9xdPNIW29LB1S8X2OGnds0FweWZ4z6yVfXbXiIhUmmn0CvDPVqenAtIUpD6oVlbLshsIj8lNn98v47gUM1066OjP6rkem2bDAw83H57Ig8Htumy9vIgK25rCdpTTcql2U1x/P3+JEBlR9gcUS2KkeP7/9JJ9JpF4J47nFJNgMXFfcVt29txSoIwf7rcEj3lv+Q3+Wszqmqpt57MskYAxrI3fn3BBj/QShHp1OAEcZbyhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PAXPR04MB9423.eurprd04.prod.outlook.com (2603:10a6:102:2b3::7)
 by AM6PR04MB4632.eurprd04.prod.outlook.com (2603:10a6:20b:1a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 00:40:31 +0000
Received: from PAXPR04MB9423.eurprd04.prod.outlook.com
 ([fe80::40c0:e02b:d880:bd2b]) by PAXPR04MB9423.eurprd04.prod.outlook.com
 ([fe80::40c0:e02b:d880:bd2b%5]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 00:40:31 +0000
Message-ID: <6b0f23dd-1808-609c-3f97-17f58a4f4688@suse.com>
Date:   Thu, 10 Feb 2022 08:40:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1644301903.git.wqu@suse.com>
 <fe880742bbee1e1c219c7b468300724a3336107d.1644301903.git.wqu@suse.com>
 <YgPhzFA3230j2mlf@debian9.Home>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH v2 2/2] btrfs: defrag: don't use merged extent map for
 their generation check
In-Reply-To: <YgPhzFA3230j2mlf@debian9.Home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0202.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::27) To PAXPR04MB9423.eurprd04.prod.outlook.com
 (2603:10a6:102:2b3::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12298134-680a-4c29-65ca-08d9ec2df0e1
X-MS-TrafficTypeDiagnostic: AM6PR04MB4632:EE_
X-Microsoft-Antispam-PRVS: <AM6PR04MB4632C9739E2762AD0BEB04B4D62F9@AM6PR04MB4632.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qghiSxryyeqqapZDIetMACNtkc+87q15sS3p8kIdwacNtf1lIQpR2W3/Y+VIAGajEMelTDS05huGjBmPW0mupTgBiTjQUuOxcNJTIJJdIKyMuAndICE/bUwH9OPAMuNLF6DTajpmnF7rdXtl7CQIhYa6+Z5I0vEQd4yghlL7NQjs+MNxFNcXOXbIiAxHIqkidBsJ7C1SBmMSdFLAdGI9WnoADXA2I14WdY219GJkGfbCCOa7UVMneyLSQDPV8vFZvkQfKOzLxhTIDvjy59zeTUvR2FRfXqZgv1o5AqPpNN/xYc7K3YCIi+LKkfmgF1CH3qCbXyTHPGEMle8/9dXuzkcEw/+lrJATTqmRFHeh4XuQm7sbUgomFIHc03kLocJWJ2SaLvEYMlPkFLp8LgYUuqOkoPZ7CnzO7sLPQ2it7gozKJudKB0TzufEZ00+BtmTKItxt4LVLSGlq+NwPxIFahUe2OE+2vZVqKaL8dP2q1PDqahQ878s6zA6IoqkTfLsdPwgVOSVLI2RGNylSOHF1e2KnVOZ/WM/VYU8nKHjckR4tRhciw3FSuMDyh2WoCT/XBhuAn1wg5CV3I1dW8xPLMFG/vLYItTHv7pLwxdntG4q2FJy5FXXFsZzfcApGVnoJ7AenIbv1AYxbTuRu4hCTzDaaF0+kpR0/WK07k0NzbhGYwEloFO0wLceA0XRCxXuiLqbAoczrdREcFcckybK0uEwnHBIcsfb8j1+4lT/hBo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9423.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(53546011)(6666004)(316002)(36756003)(8936002)(2616005)(6512007)(6506007)(6486002)(31686004)(6916009)(508600001)(31696002)(8676002)(83380400001)(66946007)(66476007)(4326008)(66556008)(186003)(26005)(86362001)(2906002)(5660300002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QStvRTdiejhZODcrWmRvamd4M1l5S0NlM09qS3Zldm04Wnl4dnhyL2I2YXlB?=
 =?utf-8?B?dncxZkpxeW02ZWsybnhQenRNZU9DQ2VXV2t4dVpUQzNaSUpxSkduN1RUbDNU?=
 =?utf-8?B?N2VMU24zVkhSQTRUclVyR3R1NFlBUGxmTVdISG80dlFaRCtSNUpNWndqaklz?=
 =?utf-8?B?UW1HVFlZSlliVUxMNEJEQXk3cEV5TElrWlU5dVZDM01pc2xsZVJMYThwemdF?=
 =?utf-8?B?OEgyc1l6c1dzMWRjYTNrTTFTQWpjNms2SDFkRDRMLyt6ZHdzQ0ZJeG9ZT2xz?=
 =?utf-8?B?bXY5RWZtazR3dzZ5bFZFRWlYdUtJUktsTzBhN0tndG1Ra2R4RC9Hc3BLbDhu?=
 =?utf-8?B?MUMwK3g4WU9xVzRIS2t4VWR6ZVhubC9sM1gwSDdhZFVoZXlGYzE0RnNuMGVU?=
 =?utf-8?B?Z3pWNHNWMU5NeG9GUzdTK1F3ZDBWV1JQbFhMeGhSOUNoaDVFalpwajYyMVlO?=
 =?utf-8?B?MEFNRlZXRE42WC91aFl2Rk5IenRRUDdZV1JiQjdtbGVWZEdvNzA1K1ByeEJQ?=
 =?utf-8?B?L1NCelpJcFdVVWtSV3JDVDJVa05XM1ZBeFRQdXF0WldhUlIrYjNBQUxuOW15?=
 =?utf-8?B?R3pYMTBTa0JYcG4rZkN3WHgzY2lsVkZQWGg0UllXUjNMOHlKTTQ5Tm1SMXlB?=
 =?utf-8?B?U2ZLcGl4SGpnRkQydTR5dGxiZlJJZ0ZVMHhoakxTYkdHTDRHbkNTQy9EeUp3?=
 =?utf-8?B?WGp1TlRvbjBtK253UjUyQjNSZkhKbU55bU1HR1VXb1lQL1I4NDVhZHpUakFk?=
 =?utf-8?B?UzdEVnZ6dkQvZjdFaERLK2NicnNKbUxxUmNteFZ4TlVsQUFuU3hBeFZmWFhk?=
 =?utf-8?B?b01ic1U5bGx2dkVsVGtaVy95U2RndjNMeXV5NElLRjFIanVhTjNSUno1aXU2?=
 =?utf-8?B?UzhMT1BQRE4rUktrKytKb1l2a1h3dHRMaHFlbW51bm00ejNDd2ZBS1VqL3R6?=
 =?utf-8?B?YW9OV29wRHU1bTJFTUZmV28rKzZpeDdpaCtkL1phY1FPSjh3WVBjZE1XZ3JO?=
 =?utf-8?B?K01mUndEZFdBcEZ0RThCTE8zS2gya28vOUtBTW5ncnFQUFcxck03L3BpUUJn?=
 =?utf-8?B?S1FRenFxbHBrUGhsT09ram5sME5kUndmb3liS3kzRVFxUVRQVS9oNXkwdm5s?=
 =?utf-8?B?M0NNTVh5V2ViemIzbkNPdkVNc0JoODlsbXg0MGd5RDNIZ1Z5cmdvUW5PSU1X?=
 =?utf-8?B?N3RLNkt0N09MTEc5SjlneHlBd0J1VElMM1l0TTZvK0s0RGtsQk1Rc21GYU42?=
 =?utf-8?B?OVFEbFdURU5WN1VTSE0vSGlvZmFWUmQrRjRRdmhHYmhyaFpQTnBGNTMxQnMx?=
 =?utf-8?B?TE9wdnVKcGx0ZTRBS29ialhWK1ZSZWJWQlZieW5yS0dRY2lwQ082ZEZ0NHJ4?=
 =?utf-8?B?MFlhVm1oZFJLdDh6dnZSMksxSC9GcDIxZmNweTZFTlFWRWJkdlFZcEY2MkJr?=
 =?utf-8?B?bU45S3M3aFY1NCtIb0RlUGM3aFJDVVFLNmRCaHBDYS95dGgrdmVKRmJSQytZ?=
 =?utf-8?B?OGpvalZ6R0lUS3FwZStWMUFsVm9IaUZJTk1Ic2ExSlJuVnlpdjlybUlzMlov?=
 =?utf-8?B?SnFEOVIzR0RSVzdkRG5mQVB2WXM0QmpHU05vZURmck9KQ3ltUUltTmdXU25Z?=
 =?utf-8?B?d3RiZmJtdXFrV1ZoSFVqaDFXRzY1T2E3eUNhVWVOQzZCeGZpVjVjYTBNNEdr?=
 =?utf-8?B?ZzVWamRJVlA5Qm5FVG9jSTZYUmR1dVgvWG5UNk9DallhaEtlTjdKNk5TTmJw?=
 =?utf-8?B?UklhTGNHUXU5ZDMwR1JUdHdSajB0VnpBZ0ZQOGJQcmNHK1NtOEtYV3ZndnBj?=
 =?utf-8?B?Q0RibUNYamhGa3hkQ2pUcnRFRE5SMzZTSm9nbDdLZlcyVnY4akNkWEtzNStt?=
 =?utf-8?B?eXlmV21MMzdGRFovU01hTmMwMVcxOHFKUDA0N2wvZHlZQ0dCNE1vWmgyWk92?=
 =?utf-8?B?QTZNdXFpdFZzTDBmZy95VEdGS0UrdWlpaDhTOVh5U1FnUkQ2ZmZ4a2tTV0g3?=
 =?utf-8?B?S3ROZGdtMW4rbE1OTkdzOU8yQkRCS1EwZzB3RFErY0N6K1JMQnRtU2J4VU9w?=
 =?utf-8?B?VkZqbE9xcUhhaWR3TkZVZzBVajRKZnI2YVBHM2YvOW1XZWN5aFFDYWR3Y1Vn?=
 =?utf-8?Q?hjCQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12298134-680a-4c29-65ca-08d9ec2df0e1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9423.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 00:40:30.9872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6IlQAuV0+lW181Vf9tPhHjMt5sC2nzsBfLa77N76gGh8Q7sX93D4qVffVWG6tthF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4632
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/9 23:46, Filipe Manana wrote:
> On Tue, Feb 08, 2022 at 02:36:31PM +0800, Qu Wenruo wrote:
>> For extent maps, if they are not compressed extents and are adjacent by
>> logical addresses and file offsets, they can be merged into one larger
>> extent map.
>>
>> Such merged extent map will have the higher generation of all the
>> original ones.
>>
>> This behavior won't affect fsync code, as only extents read from disks
>> can be merged.
> 
> That is not true. An extent created by a write can be merged after a
> fsync runs and logs the extent. So yes, extent maps created by writes
> can be merged, but only after an fsync.

Or, if there is no fsync(), the em will never be mergeable, unless 
evicted and re-read.

In setup_extent_mapping() if @modified is true, we call 
"list_move(&em->list, &tree->modified_extents)".

So it means such em will not be merged, as try_merge_map() needs the 
em::list to be empty.

Then check when em::list is deleted, there are two paths to remove em::list:

- remove_extent_mapping()

- btrfs_log_inode()/btrfs_log_changed_extents()

This explains why under my test cases which only use sync(), those 
extent maps never get merged, unless removed and read from tree again.

I'm wondering now if this is expected behavior?

Thanks,
Qu

> 
>>
>> But this brings a problem for autodefrag, as it relies on accurate
>> extent_map::generation to determine if one extent should be defragged.
>>
>> For merged extent maps, their higher generation can mark some older
>> extents to be defragged while the original extent map doesn't meet the
>> minimal generation threshold.
>>
>> Thus this will cause extra IO.
>>
>> So solve the problem, here we introduce a new flag, EXTENT_FLAG_MERGED, to
>> indicate if the extent map is merged from one or more ems.
>>
>> And for autodefrag, if we find a merged extent map, and its generation
>> meets the generation requirement, we just don't use this one, and go
>> back to defrag_get_extent() to read em from disk.
> 
> Instead of saying from disk, I would say from the subvolume btree. That
> may or may not require reading a leaf, and any nodes in the path from the
> root to the leaf, from disk.
> 
>>
>> This could cause more read IO, but should result less defrag data write,
>> so in the long run it should be a win for autodefrag.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/extent_map.c |  2 ++
>>   fs/btrfs/extent_map.h |  8 ++++++++
>>   fs/btrfs/ioctl.c      | 14 ++++++++++++++
>>   3 files changed, 24 insertions(+)
>>
>> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
>> index 5a36add21305..c28ceddefae4 100644
>> --- a/fs/btrfs/extent_map.c
>> +++ b/fs/btrfs/extent_map.c
>> @@ -261,6 +261,7 @@ static void try_merge_map(struct extent_map_tree *tree, struct extent_map *em)
>>   			em->mod_len = (em->mod_len + em->mod_start) - merge->mod_start;
>>   			em->mod_start = merge->mod_start;
>>   			em->generation = max(em->generation, merge->generation);
>> +			set_bit(EXTENT_FLAG_MERGED, &em->flags);
>>   
>>   			rb_erase_cached(&merge->rb_node, &tree->map);
>>   			RB_CLEAR_NODE(&merge->rb_node);
>> @@ -278,6 +279,7 @@ static void try_merge_map(struct extent_map_tree *tree, struct extent_map *em)
>>   		RB_CLEAR_NODE(&merge->rb_node);
>>   		em->mod_len = (merge->mod_start + merge->mod_len) - em->mod_start;
>>   		em->generation = max(em->generation, merge->generation);
>> +		set_bit(EXTENT_FLAG_MERGED, &em->flags);
>>   		free_extent_map(merge);
>>   	}
>>   }
>> diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
>> index 8e217337dff9..d2fa32ffe304 100644
>> --- a/fs/btrfs/extent_map.h
>> +++ b/fs/btrfs/extent_map.h
>> @@ -25,6 +25,8 @@ enum {
>>   	EXTENT_FLAG_FILLING,
>>   	/* filesystem extent mapping type */
>>   	EXTENT_FLAG_FS_MAPPING,
>> +	/* This em is merged from two or more physically adjacent ems */
>> +	EXTENT_FLAG_MERGED,
>>   };
>>   
>>   struct extent_map {
>> @@ -40,6 +42,12 @@ struct extent_map {
>>   	u64 ram_bytes;
>>   	u64 block_start;
>>   	u64 block_len;
>> +
>> +	/*
>> +	 * Generation of the extent map, for merged em it's the highest
>> +	 * generation of all merged ems.
>> +	 * For non-merged extents, it's from btrfs_file_extent_item::generation.
> 
> Missing the (u64)-1 special case, a temporary value set when writeback starts
> and changed when the ordered extent completes.
> 
>> +	 */
>>   	u64 generation;
>>   	unsigned long flags;
>>   	/* Used for chunk mappings, flag EXTENT_FLAG_FS_MAPPING must be set */
>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>> index fb4c25e5ff5f..3a5ada561298 100644
>> --- a/fs/btrfs/ioctl.c
>> +++ b/fs/btrfs/ioctl.c
>> @@ -1169,6 +1169,20 @@ static struct extent_map *defrag_lookup_extent(struct inode *inode, u64 start,
>>   	em = lookup_extent_mapping(em_tree, start, sectorsize);
>>   	read_unlock(&em_tree->lock);
>>   
>> +	/*
>> +	 * We can get a merged extent, in that case, we need to re-search
>> +	 * tree to get the original em for defrag.
>> +	 *
>> +	 * If @newer_than is 0 or em::geneartion < newer_than, we can trust
> 
> em::geneartion -> em::generation
> 
>> +	 * this em, as either we don't care about the geneartion, or the
> 
> geneartion, -> generation
> 
> The rest looks fine.
> Thanks.
> 
>> +	 * merged extent map will be rejected anyway.
>> +	 */
>> +	if (em && test_bit(EXTENT_FLAG_MERGED, &em->flags) &&
>> +	    newer_than && em->generation >= newer_than) {
>> +		free_extent_map(em);
>> +		em = NULL;
>> +	}
>> +
>>   	if (!em) {
>>   		struct extent_state *cached = NULL;
>>   		u64 end = start + sectorsize - 1;
>> -- 
>> 2.35.0
>>
> 

