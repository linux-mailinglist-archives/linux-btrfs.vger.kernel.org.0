Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82CD44FFD0
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Nov 2021 09:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236397AbhKOIO1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Nov 2021 03:14:27 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:36744 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235879AbhKOIOZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Nov 2021 03:14:25 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7A9221FD58;
        Mon, 15 Nov 2021 08:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636963887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ROAT3Nt0uLgstUr5q0WBksx4VbQLymO7IrIzSy0hUhU=;
        b=U9/Udg4vjDCnvJCTf1/Zd9BAz7PU4xZPJnnpDCPBfScR325/coGQHx1za7n51yjL9g6NhF
        XKNVLTc1UPJ9KrNPRhBT5mNYS1/dD2FqBir1UiM2q5DQUtGiVYkbj+wwIFcyFhGGgfxFdN
        YZiRfJy2IDRX0MxEQ2VnE90MO2ARRn8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 422A91348A;
        Mon, 15 Nov 2021 08:11:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FMQTDS8WkmG4YwAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 15 Nov 2021 08:11:27 +0000
Subject: Re: [PATCH v3] btrfs: Test proper interaction between skip_balance
 and paused balance
To:     Eryu Guan <guan@eryu.me>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20211108142901.1003352-1-nborisov@suse.com>
 <YZD7yEhwsKRBm0IE@desktop>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <e6ac686a-92c9-9de2-dcca-c865882784c5@suse.com>
Date:   Mon, 15 Nov 2021 10:11:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YZD7yEhwsKRBm0IE@desktop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 14.11.21 г. 14:06, Eryu Guan wrote:
> On Mon, Nov 08, 2021 at 04:29:01PM +0200, Nikolay Borisov wrote:
>> Ensure a device can be added to a filesystem that has a paused balance
>> operation and has been mounted with the 'skip_balance' mount option
>>
>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>> ---
>>
>> V3:
>>  * Added swapon to the list of exclusive ops
>>  * Use _spare_dev_get
>>  * Test balance resume via progs while balance is paused. I hit an assertion failure
>>  outside of xfstest while doing this sequence of steps so let's add it to
>>  ensure that's not regressed.
>>
>>  tests/btrfs/049     | 92 +++++++++++++++++++++++++++++++++++++++++++++
>>  tests/btrfs/049.out |  1 +
>>  2 files changed, 93 insertions(+)
>>  create mode 100755 tests/btrfs/049
>>
>> diff --git a/tests/btrfs/049 b/tests/btrfs/049
>> new file mode 100755
>> index 000000000000..d01ef05e5ead
>> --- /dev/null
>> +++ b/tests/btrfs/049
>> @@ -0,0 +1,92 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2021 SUSE Linux Products GmbH.  All Rights Reserved.
>> +#
>> +# FS QA Test 049
>> +#
>> +# Ensure that it's possible to add a device when we have a paused balance
>> +# and the filesystem is mounted with skip_balance. The issue is fixed by a patch
>> +# titled "btrfs: allow device add if balance is paused"
> 
> After looking at the kernel patch, it looks more like a bug fix not a
> new feature, as adding device to a ENOSPC-but-paused balance seems to be
> the only reasonable way to finish the balance. If that's the case,
> there's no problem add this case that will fail on old kernels.

*nod*

> 
>> +#
>> +. ./common/preamble
>> +_begin_fstest quick balance auto
>> +
>> +# real QA test starts here
>> +
>> +_supported_fs btrfs
>> +_require_scratch_swapfile
>> +_require_scratch_dev_pool 3
>> +
>> +_scratch_dev_pool_get 2
>> +_spare_dev_get
>> +
>> +swapfile="$SCRATCH_MNT/swap"
>> +_scratch_pool_mkfs >/dev/null
>> +_scratch_mount
>> +_format_swapfile "$swapfile" $(($(get_page_size) * 10))
>> +
>> +check_exclusive_ops()
>> +{
>> +	$BTRFS_UTIL_PROG device remove 2 $SCRATCH_MNT &>/dev/null
>> +	[ $? -ne 0 ] || _fail "Successfully removed device"
>> +	$BTRFS_UTIL_PROG filesystem resize -5m $SCRATCH_MNT &> /dev/null
>> +	[ $? -ne 0 ] || _fail "Successfully resized filesystem"
>> +	$BTRFS_UTIL_PROG replace start -B 2 $SPARE_DEV $SCRATCH_MNT &> /dev/null
>> +	[ $? -ne 0 ] || _fail "Successfully replaced device"
>> +	swapon "$swapfile" &> /dev/null
>> +	[ $? -ne 0 ] || _fail "Successfully enabled a swap file"
>> +}
>> +
>> +uuid=$(findmnt -n -o UUID $SCRATCH_MNT)
> 
> $uuid is not used anywhere, can be removed?

Sure, I'm sure I did but I guess fucked up during rebase.

> 
>> +
>> +# Create some files on the so that balance doesn't complete instantly
> 
> You mean "on the device"?

Yep.

> 
>> +args=`_scale_fsstress_args -z \
>> +	-f write=10 -f creat=10 \
>> +	-n 1000 -p 2 -d $SCRATCH_MNT/stress_dir`
>> +echo "Run fsstress $args" >>$seqres.full
>> +$FSSTRESS_PROG $args >/dev/null 2>&1
>> +
>> +# Start and pause balance to ensure it will be restored on remount
>> +echo "Start balance" >>$seqres.full
>> +_run_btrfs_balance_start --bg "$SCRATCH_MNT"
>> +$BTRFS_UTIL_PROG balance pause "$SCRATCH_MNT"
>> +$BTRFS_UTIL_PROG balance status "$SCRATCH_MNT" | grep -q paused
>> +[ $? -eq 0 ] || _fail "Balance not paused"
>> +
>> +# Exclusive ops should be blocked on manual pause of balance
>> +check_exclusive_ops
>> +
>> +# Balance is now placed in paused state during mount
>> +_scratch_cycle_mount "skip_balance"
>> +
>> +# Exclusive ops should be blocked on balance pause due to 'skip_balance'
>> +check_exclusive_ops
>> +
>> +# Device add is the only allowed operation
>> +$BTRFS_UTIL_PROG device add -K -f $SPARE_DEV "$SCRATCH_MNT"
>> +
>> +# Exclusive ops should still be blocked on account that balance is still paused
>> +check_exclusive_ops
>> +
>> +# Should be possible to resume balance after device add
>> +$BTRFS_UTIL_PROG balance resume "$SCRATCH_MNT" &>/dev/null
>> +[ $? -eq 0 ] || _fail "Couldn't resume balance after device add"
>> +
>> +# Add more files so that new balance won't fish immediately
>                                               ^^^^ finish ?

Yes,

>> +$FSSTRESS_PROG $args >/dev/null 2>&1
>> +
>> +# Now pause->resume balance. This ensures balance paused is properly set in
>> +# the kernel and won't trigger an assertion failure.
>> +echo "Start balance" >>$seqres.full
>> +_run_btrfs_balance_start --bg "$SCRATCH_MNT"
>> +$BTRFS_UTIL_PROG balance pause "$SCRATCH_MNT"
>> +$BTRFS_UTIL_PROG balance status "$SCRATCH_MNT" | grep -q paused
>> +[ $? -eq 0 ] || _fail "Balance not paused"
>> +$BTRFS_UTIL_PROG balance resume "$SCRATCH_MNT" &>/dev/null
>> +[ $? -eq 0 ] || _fail "Balance can't be resumed via IOCTL"
>> +
>> +_spare_dev_put
>> +_scratch_dev_pool_put
>> +echo "Silence is golden"
>> +status=0
>> +exit
>> diff --git a/tests/btrfs/049.out b/tests/btrfs/049.out
>> index cb0061b33ff0..c69568ad9323 100644
>> --- a/tests/btrfs/049.out
>> +++ b/tests/btrfs/049.out
>> @@ -1 +1,2 @@
>>  QA output created by 049
>> +Silence is golden
> 
> Ah, 049.out was forgotten to be removed by commit 668c859d37f2
> ("btrfs/049: remove the test"), so it's reused here.
> 
> Thanks,
> Eryu
> 
