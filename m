Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC923E29ED
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Aug 2021 13:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245578AbhHFLmy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Aug 2021 07:42:54 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59184 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243393AbhHFLmy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Aug 2021 07:42:54 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9170C22416;
        Fri,  6 Aug 2021 11:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628250157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1SGf8SiMCSpJ3c7WDQPjbO0k72+xkHP8rviVTc5dF0o=;
        b=RDUHvIGEtUkguThVAOGSjs3Egl35TwG/nOrSIiiJb4fSxXz4pjeRyheuYq7ThK4GKROtKz
        6FN6KjJbH+JWUvD/sTPZ9codFnEJvoQnmqKmXzG8+Ei0nspGQXlQXTsyE8jTc6Vdbs9kQd
        9mDP+52VTz6HceTxpfZT+8TSLPUrcNI=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 6014213A79;
        Fri,  6 Aug 2021 11:42:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id A3cvFC0gDWGzZAAAGKfGzw
        (envelope-from <nborisov@suse.com>); Fri, 06 Aug 2021 11:42:37 +0000
Subject: Re: [PATCH v2] fstests: btrfs/244: add test case to verify the
 behavior of deleting non-existing device
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
References: <20210806113333.328261-1-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <5547039c-2989-e9d7-6126-15877758b3f0@suse.com>
Date:   Fri, 6 Aug 2021 14:42:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210806113333.328261-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 6.08.21 г. 14:33, Qu Wenruo wrote:
> There is a kernel regression for btrfs, that when passing non-existing
> devid to "btrfs device remove" command, kernel will crash due to NULL
> pointer dereference.
> 
> The test case is for such regression, it will:
> 
> - Create and mount an empty single-device btrfs
> - Try to remove devid 3, which doesn't exist for above fs
> - Make sure the command exits properly with expected error message
> 
> The kernel fix is titled "btrfs: fix NULL pointer dereference when
> deleting device by invalid id".
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Change the subject to also verify the error behavior
> - Include the error message into golden output
> - Also verify the return value of btrfs command
> ---
>  tests/btrfs/244     | 47 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/244.out |  2 ++
>  2 files changed, 49 insertions(+)
>  create mode 100755 tests/btrfs/244
>  create mode 100644 tests/btrfs/244.out
> 
> diff --git a/tests/btrfs/244 b/tests/btrfs/244
> new file mode 100755
> index 00000000..fbefeedf
> --- /dev/null
> +++ b/tests/btrfs/244
> @@ -0,0 +1,47 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 SUSE Linux Products GmbH.  All Rights Reserved.
> +#
> +# FS QA Test 244
> +#
> +# Make sure "btrfs device remove" won't crash when non-existing devid
> +# is provided
> +#
> +. ./common/preamble
> +_begin_fstest auto quick volume dangerous
> +
> +# Override the default cleanup function.
> +# _cleanup()
> +# {
> +# 	cd /
> +# 	rm -r -f $tmp.*
> +# }
> +
> +# Import common functions.
> +# . ./common/filter
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_require_scratch
> +
> +_scratch_mkfs >> $seqres.full 2>&1
> +_scratch_mount
> +
> +# Above created fs only contains one device with devid 1, device remove 3
> +# should just fail with proper error message showing devid 3 can't be found.
> +# Although on unpatched kernel, this will trigger a NULL pointer dereference.
> +$BTRFS_UTIL_PROG device remove 3 $SCRATCH_MNT
> +ret=$?
> +
> +if [ $ret -ne 1 ]; then
> +	echo "Unexpected return value from btrfs command, has $ret expected 1"
> +fi

<rant>
This just shows how broken progs are w.r.t return values. The generally
accepted return value is 0 on success, yet it returns 1 on success since
the functions implementing this functionality in progs treat the return
value as a boolean.
</rant>



> +
> +# Fstests will automatically check the filesystem to make sure metadata is not
> +# corrupted.
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/244.out b/tests/btrfs/244.out
> new file mode 100644
> index 00000000..629adf2a
> --- /dev/null
> +++ b/tests/btrfs/244.out
> @@ -0,0 +1,2 @@
> +QA output created by 244
> +ERROR: error removing devid 3: No such file or directory
> 
