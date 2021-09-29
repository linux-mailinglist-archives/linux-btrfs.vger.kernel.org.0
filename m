Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC1341C18D
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Sep 2021 11:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245053AbhI2JZV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Sep 2021 05:25:21 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:33917 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230347AbhI2JZU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Sep 2021 05:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1632907418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UvQgU4+rZj4Y/Qli8hmsm3j0/2TOFqa91nWg6Ons8wU=;
        b=CAkmZd9y7hZ2kiVpHVexIuwor4D2oIJ5wSyXznEWo8F0QG+fGnYLAIyTaINATWbhTjNyAW
        ZZTZBcyDqHzxghNgTqPifVV1hRG2SG6+ORIdpAtd7IDUd8yQ5g8957BFg/iELhAHvQhSWw
        WIPDPhUap8N2nvy3UV4rTVkBa8ecPtQ=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2111.outbound.protection.outlook.com [104.47.17.111])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-28-MwjyXO5vO_aBA2ZtE-O3Hw-1; Wed, 29 Sep 2021 11:23:37 +0200
X-MC-Unique: MwjyXO5vO_aBA2ZtE-O3Hw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDQlqDj+FTL87Mg7n24N2ePaQs0Kyi9MZyMJKGsTUbsb0xtNB0Vl+MRrBOS2s2bb7xU97QYJl+USdijpFm/LNR7fcbZkvseKnIQrMNgRF9cOR8yZu0vRszMNCQMPUSi58xHU3ProRzy235J9UClB2to37F71w9qdpn2X+ElbUK4v9slfrA+guuGof92FXM5z1SmyiFv1R7uddTNQrfBgluIaxSVqxEM6G9qXKxjgqB4UTv2jmMr4t+RDWanvh170Qw0POjTsadRet2Nkkj6f+o44KEaheVt7y90qjTJYAfh7XDGkW1DnaQWv/9uMSfzYveRwgryXWXTYwiNG67CKFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=UvQgU4+rZj4Y/Qli8hmsm3j0/2TOFqa91nWg6Ons8wU=;
 b=mITohttSCbFMX7Md4gUEyKDCxPeC6l2dggo8QkBAPqL0xdMdmYyQlHfuP11cc2tfk2FdmamnT1llHaSym4FHPJnLhNmZ/sqUyBWNArbeLwWNXok1227XXxVNQ/feL7/IobnISkIM2LOWdGnH8KSBM6DlPx0l9SmCyBVvhf8D6N7eNE+IkbjIiSXNdsISo6d6tVkXKvzM/YgAX0vKXlEeWX8RjwePzHJB4l3VTu8DIbB4edKyiCakcPFv5M6pFlc38J+5L9SfXCDuiRtOhOiJwpFdPA2QcHK8wf6rAj26NMejShWeA9tRdyTcs9Mp3Z4noKF+ncFl6VYxVgaxhzx3TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR04MB4519.eurprd04.prod.outlook.com (2603:10a6:20b:18::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 29 Sep
 2021 09:23:22 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::78e1:ab2a:f283:d097]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::78e1:ab2a:f283:d097%4]) with mapi id 15.20.4566.015; Wed, 29 Sep 2021
 09:23:22 +0000
Message-ID: <4d305518-a5c9-46c5-08f4-13a0e0f9d662@suse.com>
Date:   Wed, 29 Sep 2021 17:23:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Content-Language: en-US
To:     fdmanana@gmail.com
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20210929004446.12654-1-wqu@suse.com>
 <CAL3q7H7=smEFy8UM9uRK202rCwnX6wUWN=TRAzPjethAKdJOew@mail.gmail.com>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH] fstests: btrfs/248: test if btrfs receive can handle
 clone command on inodes with different NODATASUM flags
In-Reply-To: <CAL3q7H7=smEFy8UM9uRK202rCwnX6wUWN=TRAzPjethAKdJOew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0031.namprd04.prod.outlook.com
 (2603:10b6:a03:40::44) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
Received: from [0.0.0.0] (149.28.201.231) by BYAPR04CA0031.namprd04.prod.outlook.com (2603:10b6:a03:40::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend Transport; Wed, 29 Sep 2021 09:23:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 450670ea-eceb-485d-5179-08d9832ac843
X-MS-TrafficTypeDiagnostic: AM6PR04MB4519:
X-Microsoft-Antispam-PRVS: <AM6PR04MB45190C190B65B154413D30A1D6A99@AM6PR04MB4519.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xkaRTIMzdGvwozvmMrBhJmKMtJBXDnuXPNE72FpR2FKrg+ksu11HSXs1X8XPZlRRW5YwkNUhR7IAGn3m5ejU/wWkCzwLkND6ibScwjNALlkMjZZG6/1SdhX/qJsx0YDU4KGwT4696+b/muufStt9Tesu+NKod4FpkHdfZBU0qqR7WXYRd34lGUycCEbkzgZpvaU8Ilkt3Ss4qJlXK+GpxOjzTg9uFu/DQz4XHQ8tZvpw3+fLv/1sYVDmQp9EpjQV4t6rpc1+8DE2IE3cyavaNFyXtTxIE9ffLmE6gmx8hiGP29aB12+FgP1zIiOOXrNbU/ndTM5l5rFjSDW0hO1x/pviqcT6BzpmYWQgrwc1sYtqCzf2eS6mqRQzuGD2BH5+bk6oo+07avT/7A4tQCjA5SuMjqRQGfDn8VpOa02FPdSRWEH2hZbHBryMnkU8xr4p0+q5cuHXxCZrhgETDLBC7i3N3FGRGF9f3xeYpOw4K++GApq3YoJtFIBS/hzE0mv+UDpKiycqSpO5/lvM4RxFuNbYdK0fIhM27iJ35V3XS+g6bpBqZAE7/mizZOck9yGNnMDBGUGsIzJmOWwwKeC8s/I+gZzv2HiNfM/LS4NvPfpEnMsKE9CXJuyNMfnWrMncHq8IzoH/l1o7OAN0JNDeyXWyQjLLoKW7HzlfG8l2ZGJrirSgO2fWJN0PKJMDwjsgLfGh+OdO235s1VBy9TbgCKnRZCF4W/havlsctMTva6lO2yHI0J+dUmTx1ul8X1+InaLSKErqlfQ+8VkPWQMaiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(956004)(8676002)(2906002)(53546011)(2616005)(6486002)(66946007)(6666004)(4326008)(66476007)(316002)(66556008)(16576012)(31696002)(38100700002)(5660300002)(86362001)(8936002)(54906003)(6706004)(6916009)(26005)(186003)(83380400001)(31686004)(508600001)(36756003)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dG5tYjkwRVh3Skg1N3Nac01vdXJSU2M3Z05MMW9BbU1uZGs3bExhbG1Rb2s5?=
 =?utf-8?B?UzJBUXFXWm0reThUcFhSaUY0Rm9sa0NzWjRMSjh0QVZJcEx3TVZZYXR2M0hC?=
 =?utf-8?B?ckFwR3dCSk9LT2ZOUFhjYXdQTEpPOVlnMTBtWlU2U2xyeDBjbzZ1Vm5vZVFE?=
 =?utf-8?B?TnBSL3dJZ3FoZDZDby9YNCtGQmNmMWNqdnFFZGF2RTA4QXNqQzRTbktkVm1i?=
 =?utf-8?B?Y21ONGgySzBUcjRpekgwOTRlS2gzOFdEVWJybmhFWFB1UVU5aklubWMxRnA1?=
 =?utf-8?B?Y2V3UllmTTRYcVdmNTgxMWZ1RGZsR0REbm0rWTYzWjNnUVY4Z05KWjZiMUhu?=
 =?utf-8?B?L0prN3dmblZsaUdVSHZTeEN0aWRKM2cydS8rci8ycVRKaUg4R3dYaDFBTWF6?=
 =?utf-8?B?bG5WUkxGUTN0T2k0NjExSEkzUjNKMHFxakxRdzlzSWtiRDZwdWlSZHArTWFW?=
 =?utf-8?B?dG1zU0RVRGJ3SjB0SHkvODljQms2a0VZYnI5Zm9YdXNJUTJqcERQTERyTXJH?=
 =?utf-8?B?SS9heVk5ZUN1VFQvTDY0eTFVTnlsRjVJUmNVMHFybFJUVFdMSkRzUkg0L1BC?=
 =?utf-8?B?MDY2aHM1MkJHMksyeE00Ry9EV3FXV0JzWE51UnpaM0lmWk1iekpucE5hMXlS?=
 =?utf-8?B?d1FjYUxUcS8yc2lZcHpvbkRrL1VWL0owSlNXa2RiYjFjQlc3bVBXVjA4c1Ro?=
 =?utf-8?B?WXlDQ010enBJMXpQMjd4TlNMT043Vk9PRFQzdi9LVDA2cStSbS9XQVpTejN0?=
 =?utf-8?B?aytLT21nKy82Wk13OUQvcE96Vkd4aTdqejFkZmgyMThzUzc5d0RHWTVMd0JW?=
 =?utf-8?B?dnJFT3FPK0FrSENWdXgwY0s0bVVuR3NYK2h3WEdwSjZ5cXA4QzI2OUNGWHZQ?=
 =?utf-8?B?NE44MlBHdEYyd3pWNk8vemZncWh6RVgrRkpyOTQwY3R0MXNaZVQ4bzlRSm9i?=
 =?utf-8?B?RE1lVjdSREg3bHBrNkN2cVpLZ2ZDTDNrM3EyQ0hJM0dWNnhFTmU3Nzg1N3Nj?=
 =?utf-8?B?TXdiVjhUUEdpR1V0OXFlME9TLzlSTVZ2L2d4WlY5NUs2T3JXQ01mYTJ4Rmwx?=
 =?utf-8?B?dklTb3c3aTIvRGpqWnlPNVExTWV1MEVQVTNDWUpON2xaMXJmbDZWMi9aYzVD?=
 =?utf-8?B?N1BkRG1uYmpkTFUrN0EyR3NJUDZYS0x1aTdIMVo4b05tK3kvM2RPa3BVTHVx?=
 =?utf-8?B?S1BmU3RHVFNEaW9wTXJmQ21WaXNOSUwxaGtwL0VVVnJ0WE1ra1pBVDJsTVRR?=
 =?utf-8?B?aFlDS0xuN2lmeXA2b1IyS0poKzJaSFV1bVRacGpNcHpoOGptZGlsM3VYRFZI?=
 =?utf-8?B?VC84dm8xNC9qUHg1b2hHU09uZDFtbmVXY210YXZaRWMvRURKRFBoVWV2Wk1p?=
 =?utf-8?B?SGNvT2Q1WXRMRW1PaUU4R2ZBSlgrenZOUVQwQkNDL2Q2UG1XWCthem5VWW1N?=
 =?utf-8?B?TjRMMmRLSzZnN1A5alJ0RmZDWGxLUkVyT09pd0VzeEFaUG9zR255K3FiMjY1?=
 =?utf-8?B?NzBNNG0yUTIxU1M4dngrcGgrc1Q3WEE0NWc3VW1VbDI0SVIrNmxVNGlUaWg3?=
 =?utf-8?B?NmhtNzdvNGU2eTFwRkw2K3J5RTNSMDl5MzB2SVRsYmJmdkhFTExnN2ZRS1lJ?=
 =?utf-8?B?U3ROb1oxczFBQUxMUDBXVURWdFY5UWdIRzZFSDV4NGJNdS9LU21DOC9acm1u?=
 =?utf-8?B?MFJBUzd2NXRGcUNkVTByRkltR3ZjMVZMejBmQTFFRGt1Ym9EajR6QktMMS9z?=
 =?utf-8?Q?jIdny+TMmMF82FZ8EVXMHPQBpha9oTidR0XTkQl?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 450670ea-eceb-485d-5179-08d9832ac843
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 09:23:22.2928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NTqVrxhUiUplswsYKRGAPEYA2BVy0xnp2aUo7gvXyPXMSXv5kG6H5rBm7IdY1wyw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4519
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/29 17:14, Filipe Manana wrote:
> On Wed, Sep 29, 2021 at 1:45 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> The planned fix is titled "btrfs-progs: receive: fallback to buffered
>> copy if clone failed".
>>
>> The test case itself will create two send streams, and the 2nd stream is
>> an incremental stream with a clone command in it.
>>
>> Using different mount options we are able to create a situation where
>> clone source and destination have different NODATASUM flags, which is
>> prohibited inside btrfs.
>>
>> The planned fix will make btrfs receive to fall back to buffered write
>> to copy the data from the source file.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   tests/btrfs/248     | 74 +++++++++++++++++++++++++++++++++++++++++++++
>>   tests/btrfs/248.out |  2 ++
>>   2 files changed, 76 insertions(+)
>>   create mode 100755 tests/btrfs/248
>>   create mode 100644 tests/btrfs/248.out
>>
>> diff --git a/tests/btrfs/248 b/tests/btrfs/248
>> new file mode 100755
>> index 00000000..964d3e85
>> --- /dev/null
>> +++ b/tests/btrfs/248
>> @@ -0,0 +1,74 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2021 SUSE Linux Products GmbH.  All Rights Reserved.
>> +#
>> +# FS QA Test 248
>> +#
>> +# Make sure btrfs receive can still handle clone stream even if the source
> 
> s/clone stream/clone operations/
> 
>> +# and destination has different NODATASUM flags
> 
> s/has/have/
> 
>> +#
>> +. ./common/preamble
>> +_begin_fstest quick send
>> +
>> +# Override the default cleanup function.
>> +_cleanup()
>> +{
>> +       cd /
>> +       rm -r -f $tmp.*
>> +}
>> +
>> +# Import common functions.
>> +# . ./common/filter
>> +
>> +# real QA test starts here
>> +
>> +# Modify as appropriate.
>> +_supported_fs btrfs
>> +_require_scratch
>> +
>> +_scratch_mkfs >> $seqres.full 2>&1
>> +_scratch_mount -o datasum
>> +
>> +# Create the initial subvolume with a file
>> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/parent >> $seqres.full
>> +$XFS_IO_PROG -f -c "pwrite 0 1m" $SCRATCH_MNT/parent/source \
>> +       > /dev/null
>> +sync
> 
> There's no need to call sync.
> 
>> +$BTRFS_UTIL_PROG prop set $SCRATCH_MNT/parent ro true
>> +$BTRFS_UTIL_PROG send -q $SCRATCH_MNT/parent -f $tmp.parent_stream
>> +_scratch_unmount
>> +_scratch_mkfs >> $seqres.full 2>&1
>> +_scratch_mount -o datasum
>> +
>> +# Then create a new subvolume with cloned file from above send stream
>> +$BTRFS_UTIL_PROG receive -q -f $tmp.parent_stream $SCRATCH_MNT
>> +$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT/parent $SCRATCH_MNT/dest \
>> +       >> $seqres.full
>> +$XFS_IO_PROG -f -c "reflink $SCRATCH_MNT/parent/source 4k 0 128K" \
> 
> This will fail on a 64K sector size, so always use offsets and lengths
> that are multiples of 64K, so that the test can run on all possible
> sector sizes.
> 
>> +       $SCRATCH_MNT/dest/new > /dev/null
>> +$BTRFS_UTIL_PROG prop set $SCRATCH_MNT/dest ro true
>> +$BTRFS_UTIL_PROG send -q $SCRATCH_MNT/dest -p $SCRATCH_MNT/parent \
>> +       -f $tmp.clone_stream
> 
> Man, this is so much more complicated than necessary.
> Switching from RW to RO, having to create and mount another filesystem
> to create the incremental stream, etc.
> 
> Why didn't you follow the simple steps that most of the other tests follow?
> 
> Example:
> 
> 1) mkfs
> 2) mount with -o datacow or -o datasum
> 3) create file $SCRATCH_MNT/foo with some data
> 4) create a RO snapshot of the default subvolume as  $SCRATCH_MNT/snap1
> 5) clone  $SCRATCH_MNT/foo  into  $SCRATCH_MNT/bar for example
> 6) create another RO snapshot of the default subvolume as  $SCRATCH_MNT/snap2
> 7) do a full send of $SCRATCH_MNT/snap1 and save the stream into a file
> 8) do an incremental send of $SCRATCH_MNT/snap2 using
> $SCRATCH_MNT/snap1 as the parent and save the stream into another file

Thanks a lot, this is exactly what I want.

> 
> See, no need to mkfs and mount between creating the streams, and
> neither the need to switch subvolumes or snapshots from RW to RO.
Indeed way much better.

> 
> 
>> +
>> +_scratch_unmount
>> +_scratch_mkfs >> $seqres.full 2>&1
>> +_scratch_mount -o datasum
>> +
>> +# Now try to receive both streams
>> +$BTRFS_UTIL_PROG receive -q -f $tmp.parent_stream $SCRATCH_MNT/
>> +
>> +# Remount to NODATASUM, so that the 2nd stream will get all its inodes to have
>> +# NODATASUM flags due to mount option
>> +_scratch_remount nodatasum
>> +
>> +# Patched receive may warn about the clone failure, so here we redirect all
>> +# output
>> +$BTRFS_UTIL_PROG receive -q -f $tmp.clone_stream $SCRATCH_MNT/ \
>> +       >> $seqres.full 2>&1
>> +
>> +# We check the destination file's csum to verify if the clone is done properly
>> +_md5_checksum $SCRATCH_MNT/dest/new
>> +
>> +# success, all done
>> +status=0
>> +exit
>> diff --git a/tests/btrfs/248.out b/tests/btrfs/248.out
>> new file mode 100644
>> index 00000000..b49cfad7
>> --- /dev/null
>> +++ b/tests/btrfs/248.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 248
>> +d48858312a922db7eb86377f638dbc9f
> 
> This is neither very friendly to debug nor easy to validate.
> 
> I suggest either:
> 
> 1) Print the checksum on the original filesystem too, so that we can compare:
> 
> echo "checksum in the source fs: $(_md5_checksum $SCRATCH_MNT/...)"
> (...)
> # Should match the checksum in the source fs.
> echo "checksum in the destination fs: $(_md5_checksum $SCRATCH_MNT/...)"
> 
> 2) Or just dump the file with 'od -A d -t x1' or hexdump.
> 
> As for having the test in fstests or btrfs-progs, I won't mind either option.

For btrfs-progs testing part, the benefit is we don't need to bother 
generating the stream, as btrfs-progs is more tolerant for binary dumps.

And as you have already seen, I really struggle at creating the send stream.

(And no need to wrap every external program makes me feel more at east).

I'm totally fine to have both or either.

Thanks,
Qu

> 
> As Dave Chinner once mentioned in some threads in a distant past,
> fstests is not exclusive for testing kernel only changes - it's a
> testing framework for filesystems, which includes kernel and tools.
> I would prefer if we could have all tests inside the same test suite,
> but we already have things spread between fstests and btrfs-progs, and
> just noticed that btrfs-progs has now at least 1 test case to cover a
> kernel-only fix (misc-tests/041-subvolume-delete-during-send/test.sh).
> 
> Thanks.
> 
>> --
>> 2.33.0
>>
> 
> 

