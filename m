Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343A73FB1AA
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Aug 2021 09:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbhH3HLv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Aug 2021 03:11:51 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37040 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbhH3HLs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Aug 2021 03:11:48 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 00D781FDDF;
        Mon, 30 Aug 2021 07:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630307452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z2pKf/WfUGHEThNb4vpByybduSWm9sOmXHngqIDAuRQ=;
        b=B4Kw0WXjlW2xg75hnTqB94kya2aPmOPCS/nlzDb4VRfNswqYUlmpWjyWv4odfFUjGheT56
        kefocaWdkFDbe8atnwG8B/IgTGGafB+/ReQtGlvM0IvXk4Jg9qJPoOzJe4+0wmlJYmQaIl
        j6kT2KSWI/JYMDWCkXUG4rL4KuCk1Fs=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id B8F801365C;
        Mon, 30 Aug 2021 07:10:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 1deZKXuELGENEwAAGKfGzw
        (envelope-from <nborisov@suse.com>); Mon, 30 Aug 2021 07:10:51 +0000
Subject: Re: [PATCH] btrfs: Add test for rename exchange behavior between
 subvolumes
To:     Eryu Guan <guan@eryu.me>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20210819131456.304721-1-nborisov@suse.com>
 <YSuUAT27PfryyyRq@desktop>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <1f480dc9-e3a2-90a8-27c5-b8090a5ff9c6@suse.com>
Date:   Mon, 30 Aug 2021 10:10:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YSuUAT27PfryyyRq@desktop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 29.08.21 г. 17:04, Eryu Guan wrote:
> On Thu, Aug 19, 2021 at 04:14:56PM +0300, Nikolay Borisov wrote:
>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> 
> I noticed that test currently fails with v5.15-rc6 kernel as
> 
>   cross-subvol tree/symb -> Invalid cross-device link
>   cross-subvol tree/dire -> Invalid cross-device link
>   cross-subvol tree/tree -> Invalid cross-device link
>  -Invalid cross-device link---
> 
> So is there any background info about this test? Is it motivated by a
> known bug? If so is there a proposed fix available?
> 
> Some descriptions would be good in commit log.
> 
>>  tests/btrfs/246     | 46 +++++++++++++++++++++++++++++++++++++++++++++
>>  tests/btrfs/246.out | 27 ++++++++++++++++++++++++++
>>  2 files changed, 73 insertions(+)
>>  create mode 100755 tests/btrfs/246
>>  create mode 100644 tests/btrfs/246.out
>>
>> diff --git a/tests/btrfs/246 b/tests/btrfs/246
>> new file mode 100755
>> index 000000000000..0934932d1f22
>> --- /dev/null
>> +++ b/tests/btrfs/246
>> @@ -0,0 +1,46 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2021 SUSE Linux Products GmbH.  All Rights Reserved.
>> +#
>> +# FS QA Test 246
>> +#
>> +# Tests rename exchange behavior across subvolumes 
> 
> Trailing white space in above line
> 
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick rename
> 
> Should be in 'subvol' group as well.
> 
>> +
>> +# Import common functions.
>> + . ./common/renameat2
>> +
>> +# real QA test starts here
>> +
>> +# Modify as appropriate.
>> +_supported_fs btrfs
>> +_require_renameat2 exchange
>> +_require_scratch
>> +
>> +_scratch_mkfs >> $seqres.full 2>&1
>> +_scratch_mount
>> +
>> +# Create 2 subvols to use as parents for the rename ops
>> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol1 1>/dev/null
>> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol2 1>/dev/null
> 
> The "1" in "1>/dev/null" could be dropped.

Nope, that's intentional because I want to disregard the usual output of:
Create subvolume '/media/scratch/subvol1'

Yet in case an error occurs I want it to fail the test.



> 
>> +
>> +# _rename_tests_source_dest internally expects the flags variable to contain
>> +# specific options to rename syscall. Ensure cross subvol ops are forbidden
>> +flags="-x"
>> +_rename_tests_source_dest $SCRATCH_MNT/subvol1/src $SCRATCH_MNT/subvol2/dst "cross-subvol"
> 
> I think _rename_tests_source_dest should be updated to take flags as
> arguments instead of inheriting $flags variable from caller. That could
> be done in a separate patch as preparation.

I agree, will implement this.

<snip>

>> +sync
> 
> A global sync seems a bit heavy, does syncfs on scratch fs work? Or does
> umounting scratch dev work? If so we could depend on the test harness to
> umount scratch dev after each test.

Yeah, the unmount at the end of the test is sufficient to trigger the
failure.

<snip>
