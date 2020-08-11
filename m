Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA7D24186F
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Aug 2020 10:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgHKIr0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Aug 2020 04:47:26 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:36769 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728301AbgHKIrZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Aug 2020 04:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1597135641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IRxZr0RlXorCbxkXyGiev6AjmzF4/CVtzpukfMAM61Q=;
        b=YZycDn/rRBrVvFI1PSM6DMYET/LIJWe4e9i1Ls7oJvJslZ4ew9ra24Yuc9PDKOxuRPHqLg
        Mml9kiTmI6wJ4bS70s5vADIU+fTixcAXqIt3uEQC9OLILrRLTYd03ooz3wpW29c87FLwCQ
        ESEJg5GLSsF+6ydxqWE6cr1fJDEsQKE=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2104.outbound.protection.outlook.com [104.47.18.104])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-26-P-8yajQYPEyP-mLaeL83cQ-1; Tue, 11 Aug 2020 10:47:20 +0200
X-MC-Unique: P-8yajQYPEyP-mLaeL83cQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYs0+QeXTBsIavyuaYlQJ4Ivnz63sx0c9mA+mcWSmlBZlGd2qQmJ1eB3uUuKez+9NxFF6mNU7N6rB5KA9hLiGXSrQ3gYfXPyQOqATpymviwOxl0J4Lq85HzrjmK1RIk1VeuZGI0SS3Y2hIviLv003crad899vmlClkpctBTDSaAI7tXfjtWlo16U1jQ/q+TG3012tx3zbumwUwQVla/uTPSDiQP4YA+9Ql1OtxKytSyssRa2tgJ4d+b/V44CFJdukQIxC6Ff2J7zek3FzDkWITXCnZLJLDWKbs3KyIIvdh4pAKRbwFG93qyvEhDSYfzv5wuKFgb+9R2kVdBTb2Gzbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TzviU999Wm4HQ+r6rEpEJpEnsguEElZl2OyJJA062Ic=;
 b=SQaK9i3a46ynEgem/Z+MBfsI/JvEztJqz651TZ2fa//TDyf9PT//1S+x9Fkp/T1+ArUtR+3fjvjEfScB2LO0KeSYWHhqvLJDrolCMjXuP8W90F/uYB+Yo5D2bE1SwAYE5zd0av1x7NF/Z4dLBK2pNAPv6+vQZoNtJ3w3L6k477SiaEscHgn51Bcf7XwzIB4UzDg7g0d0qKR8OBWBltLh8gjWGDzcKtD5r9QgV783OID7nTdF/D5iIX+JgvHJ9Lq6VBYK+qebd86zPQyxVm6jI02e4bdOvr9aMN4kG3f9FmJo9xo8MSp3c/PzMgG+JUrpkiIooES1Ir5//l9NZ1F5rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
 by AM0PR04MB5460.eurprd04.prod.outlook.com (2603:10a6:208:11c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.20; Tue, 11 Aug
 2020 08:47:19 +0000
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e49c:64ce:47e0:16]) by AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e49c:64ce:47e0:16%3]) with mapi id 15.20.3261.024; Tue, 11 Aug 2020
 08:47:19 +0000
Subject: Re: [PATCH v4] btrfs: trim: fix underflow in trim length to prevent
 access beyond device boundary
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
CC:     Filipe Manana <fdmanana@suse.com>
References: <20200731112911.115665-1-wqu@suse.com>
 <5cda2c95-e407-8b11-e206-20c4aac5d48b@suse.com>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <269982fa-0174-5816-3a23-37912737abc9@suse.com>
Date:   Tue, 11 Aug 2020 16:46:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <5cda2c95-e407-8b11-e206-20c4aac5d48b@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: TY1PR01CA0135.jpnprd01.prod.outlook.com
 (2603:1096:402:1::11) To AM0PR04MB6195.eurprd04.prod.outlook.com
 (2603:10a6:208:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (45.77.180.217) by TY1PR01CA0135.jpnprd01.prod.outlook.com (2603:1096:402:1::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19 via Frontend Transport; Tue, 11 Aug 2020 08:47:09 +0000
X-Originating-IP: [45.77.180.217]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7578cd7d-2604-470c-6741-08d83dd32828
X-MS-TrafficTypeDiagnostic: AM0PR04MB5460:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB54608AC2416159E016A9DD37D6450@AM0PR04MB5460.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BaBhfV97uhE2KytnOeVzXiMBB5ZQzU4IV8hjUR0s9pQAeHUtwhZFVrWx+QvK39CaLs4opge2c5msClLemzkCQx1cSqvvDmGImvBUPbE6mtyJJSW0fKe6XhJzJpJRr0KBkWGEeWzxW6AndWGApdS1ag0MjiwQjwMsjScFTulviR7x+275Yg2a5fAbjZ7Oc4iXlQBLBoP/HcRfCTONa7/M3eJKWqbvqt/Mgcpcu/14lYvP7qcDHzYAKWfz/+q9icGRk6cEncHxJScmbVOm8PhnHjlPY4cqK0oIHxFOS/H+EWtS1I5vz+bD+9Jkw0fCO9bdlEwH10XSJT61vXGsjTZjc+3d4sqS56CNXLwInLopXg+9AsgQ2MuuPstbEsGXp24xkoJXVsAA0zeHUNthd3mf4A04uM7yYkVe2/42XsGyjqgVPzLkc9Iz5fITTkvFfuUrQ4Ww7VEoSaYwyKceFy0bRnFXPmD7t+IVkMFQmm6YMlE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6195.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(39860400002)(376002)(136003)(346002)(366004)(4326008)(31686004)(5660300002)(31696002)(86362001)(316002)(107886003)(2616005)(956004)(52116002)(2906002)(478600001)(55236004)(6666004)(16576012)(36756003)(16526019)(83380400001)(66476007)(6706004)(966005)(8676002)(6486002)(8936002)(66556008)(26005)(186003)(66946007)(78286006)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: QpQxMG7/Mt5lhfHpXSxYyx1pHI0/fcgos0GfIZTBWexac3Sz1oMo3/3cAzBFtuz9exCYrwoq4gEGgJLuBPZqKN4JJ85/yXsHhOD4WlhQrrX91q/eTrAnvVdRGUJTZS3NVkDyvAqFfXbhLIFXklEaTQS0xXmJMEPz7Ad44st1QJRzSUan8AoCfxSIZJKRIw/DTYeuMxpKDdQKlcseSbtDpvTXnXY7hrYnMXumUp3Kadw7FhAg3ztBlXphjcvotoagn32rYdNWglArGTwHzVL45Z+yScfX4aSJ8/PBnkkP5X+5EsYqZNiKqIi3m1UdWxt2qOrlkWNpCVFkBei11ZlS+Cx2rRzcuh60jrGpfj7MWtFHWpQIpeoWn8+Gcq6YvkJ+7DDp1OEuJWi/lYeNuC26LV4hcHhmTr5PE9BVd+ys7y8+K+91HO/JRIiP7p4wLWEwsBoq/Ok1dF+Xt6rJPsmy+jkzozP1Eor/rfixz7Lh981waFCBUaG74e6mV7F70cvzqVSqLP3GKgTYst2PKuNReQBc/GrK+sVdqtuT+fZGFusg/JH3gG6QCTPMsIRC4Gw90kNyhp6MFeBuPdnXTz91d+Zgnhh5TZEnUPSuyEJAXuOR7ned9ByUDqHfCT4PwFWtuD8zhWc91BwNbrU8lbiwUA==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7578cd7d-2604-470c-6741-08d83dd32828
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6195.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 08:47:19.5664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E4S9WGBIQn4vzx7EhAA3Hfvt6BTWsAOGbsodrQdlYbfV9eG4yJebGHWr7bQCne+N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5460
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/8/11 =E4=B8=8B=E5=8D=884:41, Nikolay Borisov wrote:
>=20
>=20
> On 31.07.20 =D0=B3. 14:29 =D1=87., Qu Wenruo wrote:
>> [BUG]
>> The following script can lead to tons of beyond device boundary access:
>>
>>   mkfs.btrfs -f $dev -b 10G
>>   mount $dev $mnt
>>   trimfs $mnt
>>   btrfs filesystem resize 1:-1G $mnt
>>   trimfs $mnt
>>
>> [CAUSE]
>> Since commit 929be17a9b49 ("btrfs: Switch btrfs_trim_free_extents to
>> find_first_clear_extent_bit"), we try to avoid trimming ranges that's
>> already trimmed.
>>
>> So we check device->alloc_state by finding the first range which doesn't
>> have CHUNK_TRIMMED and CHUNK_ALLOCATED not set.
>>
>> But if we shrunk the device, that bits are not cleared, thus we could
>> easily got a range starts beyond the shrunk device size.
>>
>> This results the returned @start and @end are all beyond device size,
>> then we call "end =3D min(end, device->total_bytes -1);" making @end
>> smaller than device size.
>>
>> Then finally we goes "len =3D end - start + 1", totally underflow the
>> result, and lead to the beyond-device-boundary access.
>>
>> [FIX]
>> This patch will fix the problem in two ways:
>> - Clear CHUNK_TRIMMED | CHUNK_ALLOCATED bits when shrinking device
>>   This is the root fix
>>
>> - Add extra safe net when trimming free device extents
>>   We check and warn if the returned range is already beyond current
>>   device.
>>
>> Link: https://github.com/kdave/btrfs-progs/issues/282
>> Fixes: 929be17a9b49 ("btrfs: Switch btrfs_trim_free_extents to find_firs=
t_clear_extent_bit")
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>> ---
>> Changelog:
>> v2:
>> - Add proper fixes tag
>> - Add extra warning for beyond device end case
>> - Add graceful exit for already trimmed case
>> v3:
>> - Don't return EUCLEAN for beyond boundary access
>> - Rephrase the warning message for beyond boundary access
>> v4:
>> - Remove one duplicated check on exiting the trim loop
>> ---
>>  fs/btrfs/extent-tree.c | 14 ++++++++++++++
>>  fs/btrfs/volumes.c     | 12 ++++++++++++
>>  2 files changed, 26 insertions(+)
>>
>> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
>> index fa7d83051587..6b1b5dfba4b3 100644
>> --- a/fs/btrfs/extent-tree.c
>> +++ b/fs/btrfs/extent-tree.c
>> @@ -33,6 +33,7 @@
>>  #include "delalloc-space.h"
>>  #include "block-group.h"
>>  #include "discard.h"
>> +#include "rcu-string.h"
>> =20
>>  #undef SCRAMBLE_DELAYED_REFS
>> =20
>> @@ -5669,6 +5670,19 @@ static int btrfs_trim_free_extents(struct btrfs_d=
evice *device, u64 *trimmed)
>>  					    &start, &end,
>>  					    CHUNK_TRIMMED | CHUNK_ALLOCATED);
>> =20
>> +		/* CHUNK_* bits not cleared properly */
>> +		if (start > device->total_bytes) {
>> +			WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
>> +			btrfs_warn_in_rcu(fs_info,
>> +"ignoring attempt to trim beyond device size: offset %llu length %llu d=
evice %s device size %llu",
>> +					  start, end - start + 1,
>> +					  rcu_str_deref(device->name),
>> +					  device->total_bytes);
>> +			mutex_unlock(&fs_info->chunk_mutex);
>> +			ret =3D 0;
>> +			break;
>> +		}
>=20
> Isn't this a NOOP, because the latter chunk ensures we can never cross
> device->total_bytes. Since this is a purely defensive mechanism and
> following this patch we *should* never have CHUNK_* bits set beyond
> device->total_bytes I'd say make this an ASSERT(). Otherwise you force
> people to pay the cost of the check for every trim ...

I'm fine with the ASSERT() idea.

But on the other hand, we really don't know how things can go wrong, and
such graceful exit makes us way easier to expose and fix bugs when it
happens in a production system.

So currently I'm 50-50 on change it to ASSERT().

Thanks,
Qu

>=20
>=20
>> +
>>  		/* Ensure we skip the reserved area in the first 1M */
>>  		start =3D max_t(u64, start, SZ_1M);
>> =20
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index d7670e2a9f39..4e51ef68ea72 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -4720,6 +4720,18 @@ int btrfs_shrink_device(struct btrfs_device *devi=
ce, u64 new_size)
>>  	}
>> =20
>>  	mutex_lock(&fs_info->chunk_mutex);
>> +	/*
>> +	 * Also clear any CHUNK_TRIMMED and CHUNK_ALLOCATED bits beyond the
>> +	 * current device boundary.
>> +	 * This shouldn't fail, as alloc_state should only utilize those two
>> +	 * bits, thus we shouldn't alloc new memory for clearing the status.
>> +	 *
>> +	 * So here we just do an ASSERT() to catch future behavior change.
>> +	 */
>> +	ret =3D clear_extent_bits(&device->alloc_state, new_size, (u64)-1,
>> +				CHUNK_TRIMMED | CHUNK_ALLOCATED);
>> +	ASSERT(!ret);
>=20
> I agree with this part.
>=20
>> +
>>  	btrfs_device_set_disk_total_bytes(device, new_size);
>>  	if (list_empty(&device->post_commit_list))
>>  		list_add_tail(&device->post_commit_list,
>>
>=20

