Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 117AA4462BE
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 12:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbhKELex (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 07:34:53 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56564 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhKELex (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 07:34:53 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8BD121FD36;
        Fri,  5 Nov 2021 11:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636111932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0WuRokTcCKtc182NyeRD2B9gF+w06In/a1DybstLja4=;
        b=ZdO7OUQ3khD8p/1Xh4WHGICgt5daqwQYaLA7k9v7A51OZkLzspTOLTiIjIfQX/DHU0he6f
        oj+mWAfA3FJbvu70sTA621BMFeh+cowgY0ejvMlL7UrlXKxRnq5/xNNDiMwlfrcyx8Bi1W
        qz9CPhPQF8fFbEs3Rel2g7UTMN2tdmU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 479A313B97;
        Fri,  5 Nov 2021 11:32:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id a1QNDzwWhWGaKQAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 05 Nov 2021 11:32:12 +0000
Subject: Re: [PATCH] common/btrfs: source module file
To:     fdmanana@gmail.com, Luis Chamberlain <mcgrof@kernel.org>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Anand Jain <anand.jain@oracle.com>
References: <20211104203958.2371523-1-mcgrof@kernel.org>
 <CAL3q7H7=eKNTqY70cOfurxBqTetWcjkbTVKieBHQm4+RuJ1-hA@mail.gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <87935890-a607-0d14-0a6f-a16b7fa84988@suse.com>
Date:   Fri, 5 Nov 2021 13:32:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H7=eKNTqY70cOfurxBqTetWcjkbTVKieBHQm4+RuJ1-hA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 5.11.21 г. 13:04, Filipe Manana wrote:
> On Thu, Nov 4, 2021 at 8:40 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>>
>> btrfs/249 fails with:
>>
>> QA output created by 249
>> ./common/btrfs: line 425: _require_loadable_fs_module: command not found
>> ./common/btrfs: line 432: _reload_fs_module: command not found
>> ERROR: not a btrfs filesystem: /media/scratch
>>
>> Fix this by sourcing common/module in the btrfs common file.
> 
> I'm not sure why you get such a failure. Without the relevant
> btrfs-progs and btrfs kernel patches, I don't get that error:

I checked all these tests and btrfs/248 and btrfs/249 do not import
common/module whilst the others do it so this might be one of the reason.

IMO it would be cleaner to source it in common/btrfs to remove the
duplication.


> 
> $ ./check btrfs/249
> FSTYP         -- btrfs
> PLATFORM      -- Linux/x86_64 debian9 5.15.0-rc7-btrfs-next-103 #1 SMP
> PREEMPT Tue Nov 2 12:25:45 WET 2021
> MKFS_OPTIONS  -- /dev/sdb
> MOUNT_OPTIONS -- /dev/sdb /home/fdmanana/btrfs-tests/scratch_1
> 
> btrfs/249 [failed, exit status 1]- output mismatch (see
> /home/fdmanana/git/hub/xfstests/results//btrfs/249.out.bad)
>     --- tests/btrfs/249.out 2021-10-26 11:04:03.879678608 +0100
>     +++ /home/fdmanana/git/hub/xfstests/results//btrfs/249.out.bad
> 2021-11-05 10:51:53.752113924 +0000
>     @@ -1,2 +1,5 @@
>      QA output created by 249
>     -Silence is golden
>     +ERROR: unexpected number of devices: 1 >= 1
>     +ERROR: if seed device is used, try running this command as root
>     +FAILED: btrfs filesystem usage, ret 1. Check btrfs.ko and
> btrfs-progs version.
>     +(see /home/fdmanana/git/hub/xfstests/results//btrfs/249.full for details)
>     ...
>     (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/249.out
> /home/fdmanana/git/hub/xfstests/results//btrfs/249.out.bad'  to see
> the entire diff)
> Ran: btrfs/249
> Failures: btrfs/249
> Failed 1 of 1 tests
> 
> Maybe Anand, who authored the test, may have an idea.
> We do have many other tests that call
> _require_btrfs_forget_or_module_loadable(), btrfs/124, 125, 163, 164,
> etc. Does it happen with those as well?
> 
> Also, in the future please CC linux-btrfs for changes related to btrfs tests.
> 
> Thanks.
> 
>>
>> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
>> ---
>>  common/btrfs | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/common/btrfs b/common/btrfs
>> index 5d938c19..4dc4f75d 100644
>> --- a/common/btrfs
>> +++ b/common/btrfs
>> @@ -2,6 +2,8 @@
>>  # Common btrfs specific functions
>>  #
>>
>> +source common/module
>> +
>>  _btrfs_get_subvolid()
>>  {
>>         mnt=$1
>> --
>> 2.33.0
>>
> 
> 
