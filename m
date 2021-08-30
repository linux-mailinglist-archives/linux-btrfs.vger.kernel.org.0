Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B209B3FB908
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Aug 2021 17:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237416AbhH3PfY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Aug 2021 11:35:24 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57864 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237085AbhH3PfX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Aug 2021 11:35:23 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9749D21F98;
        Mon, 30 Aug 2021 15:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630337668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ys6x1VDgj0YUWKfB0Gh/FOC5kaCI1KFmRRZafKMqr/0=;
        b=LUIaBBnU1ctDToYSmLPztVZN7ZQXH5RAVvJGAA3fElNCpnH7khg0jLzETl4PX8z9V8cMcS
        cZxnyZf+WWZCnYMUA896NoZDeg5vrncJA/1w87Occ3HMPMkXDp+godF50eEgnhdOO/cI+O
        bW/+OIaR+XIfx4WorPkIYmCIHW4ZXk0=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 5E3C5139A5;
        Mon, 30 Aug 2021 15:34:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id j3GXE4T6LGGUFwAAGKfGzw
        (envelope-from <nborisov@suse.com>); Mon, 30 Aug 2021 15:34:28 +0000
Subject: Re: [PATCH V2 2/2] btrfs: Add test for rename/exchange behavior
 between subvolumes
To:     fdmanana@gmail.com
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20210830122306.882081-1-nborisov@suse.com>
 <20210830122306.882081-2-nborisov@suse.com>
 <CAL3q7H5Hv4c9z=W4a+NQXfiPUNU3KsTmuanYQ1G_EJrigbsACQ@mail.gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <d9d2cb52-28bb-a6ff-23da-cc2bcb7b3c3e@suse.com>
Date:   Mon, 30 Aug 2021 18:34:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H5Hv4c9z=W4a+NQXfiPUNU3KsTmuanYQ1G_EJrigbsACQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 30.08.21 г. 18:01, Filipe Manana wrote:
> On Mon, Aug 30, 2021 at 1:23 PM Nikolay Borisov <nborisov@suse.com> wrote:
>>
>> This tests ensures that renames/exchanges across subvolumes work only
>> for other subvolumes and are otherwise forbidden and fail.
>>
>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>> ---
>> Changes in V2:
>>  * Added cross-subvol rename tests
>>  * Added cross-subvol subvolume rename test
>>  * Added ordinary volume rename test
>>  * Removed explicit sync
>>
>>  tests/btrfs/246     | 43 +++++++++++++++++++++++++++++++++++++++++++
>>  tests/btrfs/246.out | 27 +++++++++++++++++++++++++++
>>  2 files changed, 70 insertions(+)
>>  create mode 100755 tests/btrfs/246
>>  create mode 100644 tests/btrfs/246.out
>>
>> diff --git a/tests/btrfs/246 b/tests/btrfs/246
>> new file mode 100755
>> index 000000000000..eeb12bb457a8
>> --- /dev/null
>> +++ b/tests/btrfs/246
>> @@ -0,0 +1,43 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2021 SUSE Linux Products GmbH.  All Rights Reserved.
>> +#
>> +# FS QA Test 246
>> +#
>> +# Tests rename exchange behavior when subvolumes are involved. This is also a
>> +# regression test for 3f79f6f6247c ("btrfs: prevent rename2 from exchanging a
>> +# subvol with a directory from different parents").
> 
> And it's also a regression test for commit 3f79f6f6247c83 ("btrfs:
> prevent rename2 from exchanging a subvol with a directory from
> different parents"),
> which is actually the fix that motivated v1 of this test case.
> 
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick rename subvol
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
>> +
>> +# Ensure cross subvol ops are forbidden
>> +_rename_tests_source_dest $SCRATCH_MNT/subvol1/src $SCRATCH_MNT/subvol2/dst "cross-subvol" "-x"
>> +
>> +# Prepare a subvolume and a directory whose parents are different subvolumes
>> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol1/sub-subvol 1>/dev/null
>> +mkdir $SCRATCH_MNT/subvol2/dir
>> +
>> +# Ensure exchanging a subvol with a dir when both parents are different fails
>> +$here/src/renameat2 -x $SCRATCH_MNT/subvol1/sub-subvol $SCRATCH_MNT/subvol2/dir
> 
> Where is the test for renaming a subvolume and the test(s) for regular renames?
> The v2 changelog mentions those tests were added, but all the tests I
> see here are doing rename exchanges only.
> 
> I must have missed something subtle.

Nope, I missed committing my changes...

> 
> Thanks.
> 
>> +
>> +# success, all done
>> +status=0
>> +exit
>> diff --git a/tests/btrfs/246.out b/tests/btrfs/246.out
>> new file mode 100644
>> index 000000000000..d50dc28b1b40
>> --- /dev/null
>> +++ b/tests/btrfs/246.out
>> @@ -0,0 +1,27 @@
>> +QA output created by 246
>> +cross-subvol none/none -> No such file or directory
>> +cross-subvol none/regu -> No such file or directory
>> +cross-subvol none/symb -> No such file or directory
>> +cross-subvol none/dire -> No such file or directory
>> +cross-subvol none/tree -> No such file or directory
>> +cross-subvol regu/none -> No such file or directory
>> +cross-subvol regu/regu -> Invalid cross-device link
>> +cross-subvol regu/symb -> Invalid cross-device link
>> +cross-subvol regu/dire -> Invalid cross-device link
>> +cross-subvol regu/tree -> Invalid cross-device link
>> +cross-subvol symb/none -> No such file or directory
>> +cross-subvol symb/regu -> Invalid cross-device link
>> +cross-subvol symb/symb -> Invalid cross-device link
>> +cross-subvol symb/dire -> Invalid cross-device link
>> +cross-subvol symb/tree -> Invalid cross-device link
>> +cross-subvol dire/none -> No such file or directory
>> +cross-subvol dire/regu -> Invalid cross-device link
>> +cross-subvol dire/symb -> Invalid cross-device link
>> +cross-subvol dire/dire -> Invalid cross-device link
>> +cross-subvol dire/tree -> Invalid cross-device link
>> +cross-subvol tree/none -> No such file or directory
>> +cross-subvol tree/regu -> Invalid cross-device link
>> +cross-subvol tree/symb -> Invalid cross-device link
>> +cross-subvol tree/dire -> Invalid cross-device link
>> +cross-subvol tree/tree -> Invalid cross-device link
>> +Invalid cross-device link
>> --
>> 2.17.1
>>
> 
> 
