Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9B6506D02
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Apr 2022 15:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345109AbiDSNEj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Apr 2022 09:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235870AbiDSNEh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Apr 2022 09:04:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F643702A;
        Tue, 19 Apr 2022 06:01:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 405951F38D;
        Tue, 19 Apr 2022 13:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650373314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9vN+XTepgNW/qw3GEIsYzifQhkj8V3BEekB3LB/twmk=;
        b=lXfGpYBn4Af8dwmtLLIazr68958A3oPhENq2DRwF+If9cD35FvULq4UfhyrRibFUEyaoyD
        fbxieYXRs8f4wU6X8Ef4NHAA33wyW0gr+6TZIx2VnY+uxdw//g3XidhaaQDCsrAzTCpNQA
        ZPokBUX2cCWMzNn44X0xQHHU3WtABvo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0FE29139BE;
        Tue, 19 Apr 2022 13:01:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id q4GuOcCyXmJFewAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 19 Apr 2022 13:01:52 +0000
Message-ID: <86175a32-eaff-b48b-9971-4bbd123127fc@suse.com>
Date:   Tue, 19 Apr 2022 16:01:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] fstests: btrfs: test setting compression via xattr on
 nodatacow files
Content-Language: en-US
From:   Nikolay Borisov <nborisov@suse.com>
To:     Chung-Chiang Cheng <cccheng@synology.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org, fdmanana@kernel.org, dsterba@suse.com
Cc:     shepjeng@gmail.com, kernel@cccheng.net
References: <20220418075430.484158-1-cccheng@synology.com>
 <322a24a2-8ab3-63da-a284-e78663ddd0f8@suse.com>
In-Reply-To: <322a24a2-8ab3-63da-a284-e78663ddd0f8@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 19.04.22 г. 15:47 ч., Nikolay Borisov wrote:
> 
> 
> On 18.04.22 г. 10:54 ч., Chung-Chiang Cheng wrote:
>> Compression and nodatacow are mutually exclusive. Besides ioctl, there
>> is another way to setting compression via xattrs, and shouldn't produce
>> invalid combinations.
>>
>> Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>
>> ---
>>   tests/btrfs/264     | 76 +++++++++++++++++++++++++++++++++++++++++++++
>>   tests/btrfs/264.out | 15 +++++++++
>>   2 files changed, 91 insertions(+)
>>   create mode 100755 tests/btrfs/264
>>   create mode 100644 tests/btrfs/264.out
>>
>> diff --git a/tests/btrfs/264 b/tests/btrfs/264
>> new file mode 100755
>> index 000000000000..42bfcd4f93a0
>> --- /dev/null
>> +++ b/tests/btrfs/264
>> @@ -0,0 +1,76 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (C) 2022 Synology Inc. All Rights Reserved.
>> +#
>> +# FS QA Test No. 264
>> +#
>> +# Compression and nodatacow are mutually exclusive. Besides ioctl, there
>> +# is another way to setting compression via xattrs, and shouldn't 
>> produce
>> +# invalid combinations.
>> +#
>> +# To prevent mix any compression-related options with nodatacow, 
>> FS_NOCOMP_FL
>> +# is also rejected by ioctl as well as FS_COMPR_FL on nodatacow 
>> files. To
>> +# align with it, no and none are also unacceptable in this test.
>> +#
>> +# The regression is fixed by a patch with the following subject:
>> +#   btrfs: do not allow compression on nodatacow files
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick compress attr
>> +
>> +# Import common functions.
>> +. ./common/filter
>> +. ./common/attr
>> +
>> +# real QA test starts here
>> +
>> +_supported_fs btrfs
>> +_require_scratch
>> +_require_chattr C
>> +_require_chattr c
>> +
>> +_scratch_mkfs >>$seqres.full 2>&1
>> +_scratch_mount
>> +
>> +#
>> +# DATACOW
>> +#
>> +test_file="$SCRATCH_MNT/foo"
>> +touch "$test_file"
>> +$CHATTR_PROG -C "$test_file"
>> +$LSATTR_PROG -l "$test_file" | _filter_scratch
>> +
>> +$SETFATTR_PROG -n "btrfs.compression" -v zlib "$test_file" |& 
>> _filter_scratch
> 
> In my testing setfattr doesn't produce any output, so why the 
> _filter_scratch ?

nit: Ah right, that applies to those setfattr calls that are expected to 
fail when doing the nodatacow ops. So perhaps you could only do |& on 
the setfattr calls which are expected to fail.

<snip>


SO the main thing which remains to fix is calling the _filter_spaces to 
ensure the test succeeds.
