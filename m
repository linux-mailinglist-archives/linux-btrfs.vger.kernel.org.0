Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6726B6617
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Mar 2023 14:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjCLNGq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 Mar 2023 09:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjCLNGq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 Mar 2023 09:06:46 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E7043445
        for <linux-btrfs@vger.kernel.org>; Sun, 12 Mar 2023 06:06:43 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pbLPM-0001wj-U8; Sun, 12 Mar 2023 14:06:40 +0100
Message-ID: <feb05eef-cc80-2fbe-f28a-b778de73b776@leemhuis.info>
Date:   Sun, 12 Mar 2023 14:06:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH 8/8] btrfs: turn on -Wmaybe-uninitialized
Content-Language: en-US, de-DE
To:     dsterba@suse.cz
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, Guenter Roeck <linux@roeck-us.net>
References: <cover.1671221596.git.josef@toxicpanda.com>
 <1d9deaa274c13665eca60dee0ccbc4b56b506d06.1671221596.git.josef@toxicpanda.com>
 <20230222025918.GA1651385@roeck-us.net>
 <20230222163855.GU10580@twin.jikos.cz>
 <6c308ddc-60f8-1b4d-28da-898286ddb48d@roeck-us.net>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <6c308ddc-60f8-1b4d-28da-898286ddb48d@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1678626403;d01754b6;
X-HE-SMSGID: 1pbLPM-0001wj-U8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 22.02.23 18:18, Guenter Roeck wrote:
> On 2/22/23 08:38, David Sterba wrote:
>> On Tue, Feb 21, 2023 at 06:59:18PM -0800, Guenter Roeck wrote:
>>> On Fri, Dec 16, 2022 at 03:15:58PM -0500, Josef Bacik wrote:
>>>> We had a recent bug that would have been caught by a newer compiler
>>>> with
>>>> -Wmaybe-uninitialized and would have saved us a month of failing tests
>>>> that I didn't have time to investigate.
>>>>
>>>
>>> Thanks to this patch, sparc64:allmodconfig and parisc:allmodconfig now
>>> fail to commpile with the following error when trying to build images
>>> with gcc 11.3.
>>>
>>> Building sparc64:allmodconfig ... failed
>>> --------------
>>> Error log:
>>> <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
>>> fs/btrfs/inode.c: In function 'btrfs_lookup_dentry':
>>> fs/btrfs/inode.c:5730:21: error: 'location.type' may be used
>>> uninitialized [-Werror=maybe-uninitialized]
>>>   5730 |         if (location.type == BTRFS_INODE_ITEM_KEY) {
>>>        |             ~~~~~~~~^~~~~
>>> fs/btrfs/inode.c:5719:26: note: 'location' declared here
>>>   5719 |         struct btrfs_key location;
>>
>> Thanks for the report, Linus warned me that there might be some fallouts
>> and that the warning flag might need reverted. But before I do that I'd
>> like to try to understand why the warnings happen in a code where is no
>> reason for it.
>>
>> I did a quick test on gcc 11.3 (on x86_64, not on sparc64 unlike you
>> report), and there is no warning
>>
>> gcc (SUSE Linux) 11.3.1 20220721 [revision
>> a55184ada8e2887ca94c0ab07027617885beafc9]
>> Copyright (C) 2021 Free Software Foundation, Inc.
>> This is free software; see the source for copying conditions.  There
>> is NO
>> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR
>> PURPOSE.
>>
>>    DESCEND objtool
>>    CALL    scripts/checksyscalls.sh
>>    CC [M]  fs/btrfs/inode.o
>>
>> I.e. it's the same version, different arch and likely not the same
>> config. In the function itself thre's a local variable passed by address
>> to a static function in the same file.
>>
>>     struct btrfs_key location;
>>     ...
>>     ret = btrfs_inode_by_name(BTRFS_I(dir), dentry, &location, &di_type);
>>
>> and there it's
>>
>>     btrfs_dir_item_key_to_cpu(path->nodes[0], di, location);
>>
>> which is a series of helpers to read some data and store that to the
>> strucutre. At some point there's a call to read_extent_buffer() that's
>> in a different file.
>>
>> A local variable passed by address to external function is quite common
>> so I'd expect more warnings and I don't see what's different in this
>> case.
> 
> Me not either. I also don't see the problem with other architectures, only
> with sparc and parisc. It doesn't have to be gcc 11.3, though; it also
> happens
> with gcc 11.1, 11.2, 12.1, and 12.2 (tested on sparc).
> 
> Too bad that gcc doesn't tell why exactly it believes that the object
> may be uninitialized. Anyway, the following change would fix the problem.
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 6c18dc9a1831..4bab8ab39948 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -5421,7 +5421,7 @@ static int btrfs_inode_by_name(struct btrfs_inode
> *dir, struct dentry *dentry,
>                 return -ENOMEM;
> 
>         ret = fscrypt_setup_filename(&dir->vfs_inode, &dentry->d_name,
> 1, &fname);
> -       if (ret)
> +       if (ret < 0)
>                 goto out;
> 
> Presumably gcc assumes that fscrypt_setup_filename() could return
> a positive value.

This discussion seems to have stalled, but from a kernelci report it
looks like above warning still happens:
https://lore.kernel.org/all/640bceb7.a70a0220.af8cd.146b@mx.google.com/

@btrfs developers, do you still have it on your radar?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke
