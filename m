Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1017349C99C
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jan 2022 13:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241255AbiAZM0W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jan 2022 07:26:22 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:52558 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241237AbiAZM0V (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jan 2022 07:26:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1643199980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=heDBFkta0qJ/NEO1VBTzzjHpMhhheVWGMhABtdcyox0=;
        b=E5DlGzTbIwpC1tdCGQcC72fqlvmbMmpSlyQ53gcRiiL3pN1lUkqacGPZSogYQAzvrt8RUl
        xeYLb8OMYJkboERsbwn2Sp9snheVyBtM38BVm7WGytZ0RQzTlH5zY+CTkxKb/knUAryxYc
        265DA+TnkVX4HoaPwkSZ69+j7IfN2lM=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2054.outbound.protection.outlook.com [104.47.13.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-3-3TaCCnRhPKejHnkf6hxuUw-1; Wed, 26 Jan 2022 13:26:18 +0100
X-MC-Unique: 3TaCCnRhPKejHnkf6hxuUw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jAokIh3OWrUxzy8O1wZccvK/iGTsTSRI7uE+0v45I2XeS7wbcGcvekrxerdcvAK5Z/imf1ApwN2YRv2oqEEI/6ksKR8dGlV8Os0MHGIH/X25ripXaq8A1mF2rgUFH/8z13LQvP9wfvFRxwb5OQbCoxpX54vvwxK6+pypKonF4VfmiphZ1l2cPaujcTSm2pPWWWUR5kyq5gt8r4Uj5dLZIQ/srQ3dMlbWD8A/bvyawXOdwOZO8IBSBa23VxGduBQdTS4nFje6564VA6GKDpB8fL8MkvoE3Tn1Y0jZw0hrc8era4lfEbc0Fnx53cJoeVhbCJJogR7TvdsK0fmlEI0uug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=heDBFkta0qJ/NEO1VBTzzjHpMhhheVWGMhABtdcyox0=;
 b=HVj3S9WvnPQbitT2gB6Mbx5Jpshm1aRuw8cTSmn8yG9R1P9y0357UJVMmhKb7JKnDIlXqBbAvATJOqge7oWBrFFMKvWFELHhwqOhOGS4GSJfBK+7cGar/Rh+OslSzKH9IxYBkO0yHnds62FBku3hySIytkO28Jz4UX40K4xQR9QWKj7zbsSQblXgbWvNobSpeXiY1aLCqnNCZcFpplaDqTMoJ7jUKB0YMcOLbo9SU00+5ryw+iFsEj3tvhH5CdrtuszFgUa43KrcxrVTlr9ifnV9poZjSUK7cBbu2nGv23lBnbFtwVa5qVYDv4yKoU+DMKelWx0wtW+gdyO3n97vRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by AM6PR04MB5638.eurprd04.prod.outlook.com (2603:10a6:20b:a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 26 Jan
 2022 12:26:17 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::18db:1eae:719e:ef4e]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::18db:1eae:719e:ef4e%5]) with mapi id 15.20.4930.015; Wed, 26 Jan 2022
 12:26:16 +0000
Message-ID: <7e0ba10b-04f0-d7d4-1da0-01f455b2d55e@suse.com>
Date:   Wed, 26 Jan 2022 20:26:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org
References: <20220126005850.14729-1-wqu@suse.com>
 <20220126005850.14729-2-wqu@suse.com> <YfEzNCybtrSufSvu@debian9.Home>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH 2/3] btrfs: defrag: use extent_thresh to replace the
 hardcoded size limit
In-Reply-To: <YfEzNCybtrSufSvu@debian9.Home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::27) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0db3b1e-5ff9-486a-fb4f-08d9e0c70c79
X-MS-TrafficTypeDiagnostic: AM6PR04MB5638:EE_
X-Microsoft-Antispam-PRVS: <AM6PR04MB56389CD95E2904456C42F90CD6209@AM6PR04MB5638.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F1JyYKMcwVcgYsYbZlLNbrTqOqv0zxGL+iM3vdDp4m+4YMAwlinIejRZMFBuTMhOyqF/1EtDBJ2Ynm3Z2OSkbumGDFQ1lV800zy9otsTyKjIXMAbNPAteeuPZeYUMfvCV0F1KAFbUmQRcdQXpne4ls0qWnc596OdzheNAih0C/QliptrJvwLdB879Mfj2QxEEKhJrwny7/h33fZAaIKaXvPMb8ZoQHWjmtBnCbvZNSMQkMHxAeyXiEdWlrhJw/B75Kw2voD9hYZZR3w7HxMtXeYjj4y82OdZwhkk/nNZbx4QZPzMmJrfzM1icMJzl5rN5UpTfQcIT8tfGGfUgzevt2mIj6CMs0jp1SXP/2h6p8E4YJU9WanVnAqT1zS9lM/Gvg/JyVA5lyFVKO+JqxijreZ1YHVQ1LpdFrE80zuoVtiqofAoCjssErPxZmQ629RQON32Tj/uspQBw7FwAdZoFtrYah8/xcscsasZM1FtwTRTS66/mnbzR7/DwUIklY9Nklj0VqQk6RuVVunaKkKWCk1bfLThh+HZ7mgNt+RX7ak9+36g7uXzONMFicry7V0bD82Kc2uAYP3cdCkEKjBo9aPQUkQhVZY0bJC7n488PhxSiZue4yLJC7fosenONrG3MJYBckASVXLCDvdDfSMzRpypElGgO2FtCHTSKs9uhVcmQpWHunM85e8pDwY1Qj72jsYhUIwD9UG5XfeLJsS3NStsOvkMC0LEPp4i+KBYY3Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(6506007)(6666004)(53546011)(5660300002)(86362001)(31696002)(2906002)(38100700002)(4326008)(8676002)(8936002)(6916009)(36756003)(83380400001)(508600001)(2616005)(66946007)(186003)(6486002)(316002)(66556008)(31686004)(66476007)(26005)(43740500002)(45980500001)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUZhWFNOR3lNNkpibkxOSjIyN3NLUHUwRDZteTVOQ3kwOVZ1V1ZnY3JrKzB6?=
 =?utf-8?B?ak5Qbmg3N2VISU5RbDkwVWY2VDdOUFRxNHFEMU5WMjkvTy9xL2Jma0FQeDdl?=
 =?utf-8?B?ZzBtb091Qzd2VFhITSt2eHBqQjVqK2t5Q1paSElKbFVoY2JtMFdibUhYdXor?=
 =?utf-8?B?elphT1g1N2VLZnFnUUpOWVN2NU1HcHExWFFqc1BzdE9wYThsRDM1UFFxY29l?=
 =?utf-8?B?NERiRkxmcDh5MkdIOEthWkd0WEY2b2VMZ3VtajZaZVUwZkR0V21IcU5IZm9L?=
 =?utf-8?B?QzBUdXJoakNkKzZDNmp1OVcya0FQQkRKRGJpNmZtNXBhMzl6MzZZWlZ0dVNF?=
 =?utf-8?B?VFlnK3gvM2xMM2hRTjByWktRQkRuS1NBNGFqVUpMUVZKZVVmZXJuWGVLUTJI?=
 =?utf-8?B?L3doVjFmR3lQbzhTR3hrVFBtSHF0V0sycTc5UVczWG9MZTBMeDBETTk4Vm1p?=
 =?utf-8?B?RVlpNVZjR1V4eEtnWFA2ZTZwcmNhbmIyVFlPM3M0WG9aUWh6UlFOa2szMXdj?=
 =?utf-8?B?dm9rZFhlK3hzYnlXQ0lXNmplKys0M1RJSkMvVlpXRENGTEdLRFpMT1JvVk1W?=
 =?utf-8?B?UlF1dHppRGtYTDU2djZieFRwNzdXVHRuQkx5Z3VsMDV6citFU1d5ZDJiRlgy?=
 =?utf-8?B?ODU1emVTMHBPWTZHZERhVWxZbWg4MEs5aW52QXRaRDIwbXhPUm9oT1BrbmtL?=
 =?utf-8?B?VjJlUHFjV2FGMlZRME45Vno5NHlwY3RsbzhSS0FOMEJYVGpVTnIrMGVNeHBU?=
 =?utf-8?B?NmpHVi9Zc3VCcjl5TmZHMWJLZ244T3RPaUdRTU8rQm5wenBoL1dUVEtRZUZu?=
 =?utf-8?B?c013VkxYYnk2am5OYnljQ2ZjNmZPaFVJVm9WYWR3V2pDbTEyeXZHcVFsYTZt?=
 =?utf-8?B?K21GR3QwU3lxMW11amQrOEV5enpKenlUc2F2Ulc2WWV2UlFqcUd5cnhucGVl?=
 =?utf-8?B?WlZ2dUpUc3o5d0ZPbkozNE9pbTcyK1cxR0xzTXkxNk81RCtRREdjRmsrWWJV?=
 =?utf-8?B?Qld1Q3UvaGpaWmJPV3NkU0xDb1ZTRmdPRW1PQ0tGMUR6YnFBbkpRaTdXMmFs?=
 =?utf-8?B?S1BEUXNHNGlHU2JMMXNiQ0dUY3RNK2UyeU4xbE1GZXRCNzRxS1Q0dzdSQ2Rh?=
 =?utf-8?B?THQ4VjZ3UmhMWEVYbm11cFJKWXpHcUkwWit1eDAyYnBwb0huYW85SktneVkw?=
 =?utf-8?B?RXBRYk42UVQ4NUZNM1ZuZC9nTU85QVhPMVBKQWpOUzJLMHVaaGVqVVUrMktv?=
 =?utf-8?B?b20vK1RwTWFCYkl5YmNDVUY4WUxqMXUxN0xsR2YzTDdRNlEyTjQ2aW1TQXVD?=
 =?utf-8?B?eWxDNUVwM2ROV2lTRjBZcUl2ZkEzY0ZNRTZSWHhHdi9GUU5OL3hTZHJUUG1F?=
 =?utf-8?B?T0JkZFVOK0VodkozdWc3elMwUkI5OWJYL21aQ25FT25TRWVmUG9aTmVRN29r?=
 =?utf-8?B?c1gycmx4KzBOR0l2MndIdjlib004bnc1SldRcnpzalg0ZVhEeEc2QkNZRWRl?=
 =?utf-8?B?bnFNMjJ3cmVKSHc2ckFEWWNiNTBGdkxzUmpKQUt4NjJsOGNqK2JUNzBpMmll?=
 =?utf-8?B?REdHZnpqMk1ZNXk3dVlwS1lOaEJGbUtsakYxZnBtUnVlcjY3amxLUmI2Zjk2?=
 =?utf-8?B?THBPZ1NOekpNazdGcTJ2ODgydmlPNzczemVDcE56N1QyOWl2bkFvYVBEaWtQ?=
 =?utf-8?B?d3BiQTdrbSt4YnBMb0dXcVNpUHlna2JHbjVJcDdhNUo5dXhqRithVzdrWlFq?=
 =?utf-8?B?ak54Nmc0eGNEQzFtTEJzVW5Oc1NJWGsrbnl1TURJVjRHQlpIL2dOQnpvWk1U?=
 =?utf-8?B?SmFGbHJEV3lhaEg4NFpZemNrT3R4VzhyNDhqTEpaV3VMVGhoa0h6cUhudm05?=
 =?utf-8?B?a1lyZ1hSMjFEeTZLNnhHOFVKSlU3LzdMN0prYVNWdEp5VFA1K1dnaXowTnVZ?=
 =?utf-8?B?T05XcjlWZVZ1bUdwSTlDREhZVTJVQlkycEhZc0R6NDRtTXBKY0lQck03RklS?=
 =?utf-8?B?OE9LNm5Dby92dllmbHc0bC8wVFRITlJ1cERsbldkNFlzd3NGTCtXU0VoS2FO?=
 =?utf-8?B?VGhNY2NCZFlpYTh4ZUY5TU0ya0MyK0tydVgvQ3oyZmMrZUtaWHgrMW9Ddldt?=
 =?utf-8?Q?DggM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0db3b1e-5ff9-486a-fb4f-08d9e0c70c79
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 12:26:16.3163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q3dxyqLoEgvksDl7Sk7ZvFC98s7ODJlS7K2TcSnjYVDVPr95o4qlT7l/vYUFfq7q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5638
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/26 19:40, Filipe Manana wrote:
> On Wed, Jan 26, 2022 at 08:58:49AM +0800, Qu Wenruo wrote:
>> In defrag_lookup_extent() we use hardcoded extent size threshold, SZ_128K,
>> other than @extent_thresh in btrfs_defrag_file().
>>
>> This can lead to some inconsistent behavior, especially the default
>> extent size threshold is 256K.
>>
>> Fix this by passing @extent_thresh into defrag_check_next_extent() and
>> use that value.
>>
>> Also, since the extent_thresh check should be applied to all extents,
>> not only physically adjacent extents, move the threshold check into a
>> dedicate if ().
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/ioctl.c | 12 +++++++-----
>>   1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>> index 0d8bfc716e6b..2911df12fc48 100644
>> --- a/fs/btrfs/ioctl.c
>> +++ b/fs/btrfs/ioctl.c
>> @@ -1050,7 +1050,7 @@ static struct extent_map *defrag_lookup_extent(struct inode *inode, u64 start,
>>   }
>>   
>>   static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
>> -				     bool locked)
>> +				     u32 extent_thresh, bool locked)
>>   {
>>   	struct extent_map *next;
>>   	bool ret = false;
>> @@ -1066,9 +1066,11 @@ static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
>>   	/* Preallocated */
>>   	if (test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
>>   		goto out;
>> -	/* Physically adjacent and large enough */
>> -	if ((em->block_start + em->block_len == next->block_start) &&
>> -	    (em->block_len > SZ_128K && next->block_len > SZ_128K))
>> +	/* Extent is already large enough */
>> +	if (next->len >= extent_thresh)
>> +		goto out;
> 
> So this will trigger unnecessary rewrites of compressed extents.
> The SZ_128K is there to deal with compressed extents, it has nothing to
> do with the threshold passed to the ioctl.

Then there is still something wrong.

The original check will only reject it when both conditions are met.

So based on your script, I can still find a way to defrag the extents, 
with or without this modification:

	mkfs.btrfs -f $DEV
	mount -o compress $DEV $MNT
	
	xfs_io -f -c "pwrite -S 0xab 0 128K" $MNT/file1
	sync
	xfs_io -f -c "pwrite -S 0xab 0 128K" $MNT/file2
	sync
	xfs_io -f -c "pwrite -S 0xab 128K 128K" $MNT/file1
	sync

	echo "=== file1 before defrag ==="
	xfs_io -f -c "fiemap -v" $MNT/file1
	echo "=== file1 after defrag ==="
	btrfs fi defrag $MNT/file1
	sync
	xfs_io -f -c "fiemap -v" $MNT/file1

The output looks like this:

=== before ===
/mnt/btrfs/file1:
  EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
    0: [0..255]:        26624..26879       256   0x8
    1: [256..511]:      26640..26895       256   0x9
=== after ===
/mnt/btrfs/file1:
  EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
    0: [0..255]:        26648..26903       256   0x8
    1: [256..511]:      26656..26911       256   0x9

No matter if the patch is applied, the result is the same.

So thank you very much for finding another case we're not handling well...


BTW, if the check is want to reject adjacent non-compressed extent, the 
original one is still incorrect, we can have extents smaller than 128K 
and is still uncompressed.

So what we really want is to reject physically adjacent, non-compressed 
extents?

Thanks,
Qu
> 
> After applying this patchset, if you run a trivial test like this:
> 
>     #!/bin/bash
> 
>     DEV=/dev/sdj
>     MNT=/mnt/sdj
> 
>     mkfs.btrfs -f $DEV
>     mount -o compress $DEV $MNT
> 
>     xfs_io -f -c "pwrite -S 0xab 0 128K" $MNT/foobar
>     sync
>     # Write to some other file so that the next extent for foobar
>     # is not contiguous with the first extent.
>     xfs_io -f -c "pwrite 0 128K" $MNT/baz
>     sync
>     xfs_io -f -c "pwrite -S 0xcd 128K 128K" $MNT/foobar
>     sync
> 
>     echo -e "\n\nTree after creating file:\n\n"
>     btrfs inspect-internal dump-tree -t 5 $DEV
> 
>     btrfs filesystem defragment $MNT/foobar
>     sync
> 
>     echo -e "\n\nTree after defrag:\n\n"
>     btrfs inspect-internal dump-tree -t 5 $DEV
> 
>     umount $MNT
> 
> It will result in rewriting the two 128K compressed extents:
> 
> (...)
> Tree after write and sync:
> 
> btrfs-progs v5.12.1
> fs tree key (FS_TREE ROOT_ITEM 0)
> (...)
> 	item 7 key (257 INODE_REF 256) itemoff 15797 itemsize 16
> 		index 2 namelen 6 name: foobar
> 	item 8 key (257 EXTENT_DATA 0) itemoff 15744 itemsize 53
> 		generation 6 type 1 (regular)
> 		extent data disk byte 13631488 nr 4096
> 		extent data offset 0 nr 131072 ram 131072
> 		extent compression 1 (zlib)
> 	item 9 key (257 EXTENT_DATA 131072) itemoff 15691 itemsize 53
> 		generation 8 type 1 (regular)
> 		extent data disk byte 14163968 nr 4096
> 		extent data offset 0 nr 131072 ram 131072
> 		extent compression 1 (zlib)
> (...)
> 
> Tree after defrag:
> 
> btrfs-progs v5.12.1
> fs tree key (FS_TREE ROOT_ITEM 0)
> (...)
> 	item 7 key (257 INODE_REF 256) itemoff 15797 itemsize 16
> 		index 2 namelen 6 name: foobar
> 	item 8 key (257 EXTENT_DATA 0) itemoff 15744 itemsize 53
> 		generation 9 type 1 (regular)
> 		extent data disk byte 14430208 nr 4096
> 		extent data offset 0 nr 131072 ram 131072
> 		extent compression 1 (zlib)
> 	item 9 key (257 EXTENT_DATA 131072) itemoff 15691 itemsize 53
> 		generation 9 type 1 (regular)
> 		extent data disk byte 13635584 nr 4096
> 		extent data offset 0 nr 131072 ram 131072
> 		extent compression 1 (zlib)
> 
> In other words, a waste of IO and CPU time.
> 
> So it needs to check if we are dealing with compressed extents, and
> if so, skip either of them has a size of SZ_128K (and changelog updated).
> 
> Thanks.
> 
>> +	/* Physically adjacent */
>> +	if ((em->block_start + em->block_len == next->block_start))
>>   		goto out;
>>   	ret = true;
>>   out:
>> @@ -1231,7 +1233,7 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
>>   			goto next;
>>   
>>   		next_mergeable = defrag_check_next_extent(&inode->vfs_inode, em,
>> -							  locked);
>> +							  extent_thresh, locked);
>>   		if (!next_mergeable) {
>>   			struct defrag_target_range *last;
>>   
>> -- 
>> 2.34.1
>>
> 

