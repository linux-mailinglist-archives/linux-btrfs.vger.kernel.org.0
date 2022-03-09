Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035424D2A2E
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 09:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiCIIAo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 03:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbiCIIAd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 03:00:33 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAED14D702
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Mar 2022 23:58:36 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B3C211F380;
        Wed,  9 Mar 2022 07:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646812708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+qlLIgAFpzIcAYXYcGcrtcFUqtZ65RQAbyyhSeT0Ezw=;
        b=br+sWKjLi1CxqxXfaQqRCo2VhCwnQ31FOSxGl+e5+EM0ALgtG3+CnSGcbjlUMUtjDmiZ70
        nlBi6RgHu91BsO5waPBU6kySbRBfzyrRtkzCMNKObPvgsRDeVfTrCy+3Z76/pA7qAeiq7G
        XZAtP6Wm9ooryUM78cMl2tf5kR6Qk4w=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 869F513D78;
        Wed,  9 Mar 2022 07:58:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NRnpHSReKGK/cQAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 09 Mar 2022 07:58:28 +0000
Message-ID: <722c4bfb-514b-05ad-af50-f94908539a0a@suse.com>
Date:   Wed, 9 Mar 2022 09:58:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Trying to understand duperemove failure to deduplicate
Content-Language: en-US
To:     Andy Smith <andy@strugglers.net>, linux-btrfs@vger.kernel.org
References: <20220309065536.djkig3d43c4uts76@bitfolk.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220309065536.djkig3d43c4uts76@bitfolk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 9.03.22 г. 8:55 ч., Andy Smith wrote:
> Hi,
> 
> I was hoping to use duperemove to dedupe a set of large backups on a
> btrfs fs.
> 
> I did a test run and saw hardly any savings. I expected several
> hundred GB to be found; duperemove actually reported about 98GB but
> "df" only shows around 30GB. So I looked a bit harder.
> 
> FS mount options:
> 
> /dev/mapper/backupenc /data/backup btrfs rw,noatime,compress=zstd:15,space_cache,subvolid=5,subvol=/ 0 0
> 
> Kernel version 5.10.0-11-amd64, Debian 11.
> 
> Take for example these two files:
> 
> $ stat daily.{0,1}/cacti/var/lib/debconf_selections
>    File: daily.0/cacti/var/lib/debconf_selections
>    Size: 94065           Blocks: 184        IO Block: 4096   regular file
> Device: 26h/38d Inode: 136346107   Links: 1
> Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
> Access: 2022-01-26 01:45:24.281602018 +0000
> Modify: 2019-11-12 08:25:03.528065556 +0000
> Change: 2022-03-08 11:28:27.862447446 +0000
>   Birth: 2022-03-08 11:28:27.834447672 +0000
>    File: daily.1/cacti/var/lib/debconf_selections
>    Size: 94065           Blocks: 184        IO Block: 4096   regular file
> Device: 26h/38d Inode: 134478113   Links: 1
> Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
> Access: 2022-01-26 01:45:24.281602018 +0000
> Modify: 2019-11-12 08:25:03.528065556 +0000
> Change: 2022-03-07 20:37:22.993579274 +0000
>   Birth: 2022-03-07 20:37:22.993579274 +0000
> 
> They have identical content:
> 
> $ md5sum daily.{0,1}/cacti/var/lib/debconf_selections
> c5633915f9d847394a6640c77c55f83a  daily.0/cacti/var/lib/debconf_selections
> c5633915f9d847394a6640c77c55f83a  daily.1/cacti/var/lib/debconf_selections
> 
> They don't currently share extents:
> 
> $ filefrag -v daily.[01]/cacti/var/lib/debconf_selections
> Filesystem type is: 9123683e
> File size of daily.0/cacti/var/lib/debconf_selections is 94065 (23 blocks of 4096 bytes)
>   ext:     logical_offset:        physical_offset: length:   expected: flags:
>     0:        0..      22:  374427125.. 374427147:     23:             last,encoded,eof
> daily.0/cacti/var/lib/debconf_selections: 1 extent found
> File size of daily.1/cacti/var/lib/debconf_selections is 94065 (23 blocks of 4096 bytes)
>   ext:     logical_offset:        physical_offset: length:   expected: flags:
>     0:        0..      19:     399511..    399530:     20:             encoded,shared
>     1:       20..      22:     306304..    306306:      3:     399531: last,encoded,shared,eof
> daily.1/cacti/var/lib/debconf_selections: 2 extents found

The problem is in duperemove, not btrfs. Basically in the default mode 
of operation duperemove works based on extents, however those 2 files 
have identical content but its logical structure is different 1 vs 2 
extents. Unfortunately duperemove is not able to cope with this, if you 
want to dedupe those file you should be using the block-based dedupe 
mode. This is explained in duperemove's FAQ in the man page:


.SS I got two identical files, why are they not deduped?

Duperemove by default works on extent granularity. What this means is if 
there
are two files which are logically identical (have the same content) but are
laid out on disk with different extent structure they won't be deduped. For
example if 2 files are 128k each and their content are identical but one of
them consists of a single 128k extent and the other of 2 x 64k extents then
they won't be deduped. This behavior is dependent on the current 
implementation
and is subject to change as duperemove is being improved.

<snip>


> Thanks,
> Andy
> 
