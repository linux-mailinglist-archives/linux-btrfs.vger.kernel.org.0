Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032B16A11F9
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Feb 2023 22:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjBWV2G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Feb 2023 16:28:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjBWV14 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Feb 2023 16:27:56 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CCF1FD5
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Feb 2023 13:27:54 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6BFB434F74;
        Thu, 23 Feb 2023 21:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677187673;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DTh1uifuZ2a5gy8ON0NXA4ZZGcJ1Z5PS6rwfWF4GfMY=;
        b=uXTS6kyB8TbBBcbblVE2+eyzw0th1yCjTFBgut2rTgApjBDckrQHSeQyJJKgVT8PV9+iBM
        Y/1rc+QbsjAx+YYk5fDZYa0c8yPIbfQXu6o5CNRDqFVdHnlUiUO46N8gIi52Q60A0fgz0e
        VwGmJhwyt88INfPu/mIbivyqItle84Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677187673;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DTh1uifuZ2a5gy8ON0NXA4ZZGcJ1Z5PS6rwfWF4GfMY=;
        b=67lYJDjWPjr5rO1QcXXF9KFrnaC0Z1s4X1f+61VJ/rKnT71/mFqgUgtFAiooZ6PnW77eeU
        8XyMR+kMnS7aGODA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 36A7813928;
        Thu, 23 Feb 2023 21:27:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IPagC1na92MMdgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 23 Feb 2023 21:27:53 +0000
Date:   Thu, 23 Feb 2023 22:21:56 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v4] btrfs: make dev-replace properly follow its read mode
Message-ID: <20230223212156.GD10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <9abbfc83c08b2cea215f870f26c553b58fbabeab.1677048584.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9abbfc83c08b2cea215f870f26c553b58fbabeab.1677048584.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 22, 2023 at 03:04:37PM +0800, Qu Wenruo wrote:
> [BUG]
> Although dev replace ioctl has a way to specify the mode on whether we
> should read from the source device, it's not properly followed.
> 
>  # mkfs.btrfs -f -d raid1 -m raid1 $dev1 $dev2
>  # mount $dev1 $mnt
>  # xfs_io -f -c "pwrite 0 32M" $mnt/file
>  # sync
>  # btrfs replace start -r -f 1 $dev3 $mnt
> 
> And one extra trace is added to scrub_submit(), showing the detail about
> the bio:
> 
>            btrfs-1115669 [005] .....  5437.027093: scrub_submit.part.0: devid=1 logical=22036480 phy=22036480 len=16384
>            btrfs-1115669 [005] .....  5437.027372: scrub_submit.part.0: devid=1 logical=30457856 phy=30457856 len=32768
>            btrfs-1115669 [005] .....  5437.027440: scrub_submit.part.0: devid=1 logical=30507008 phy=30507008 len=49152
>            btrfs-1115669 [005] .....  5437.027487: scrub_submit.part.0: devid=1 logical=30605312 phy=30605312 len=32768
>            btrfs-1115669 [005] .....  5437.027556: scrub_submit.part.0: devid=1 logical=30703616 phy=30703616 len=65536
>            btrfs-1115669 [005] .....  5437.028186: scrub_submit.part.0: devid=1 logical=298844160 phy=298844160 len=131072
>            ...
>            btrfs-1115669 [005] .....  5437.076243: scrub_submit.part.0: devid=1 logical=322961408 phy=322961408 len=131072
>            btrfs-1115669 [005] .....  5437.076248: scrub_submit.part.0: devid=1 logical=323092480 phy=323092480 len=131072
> 
> One can see that all the read are submitted to devid 1, even we have
> specified "-r" option to avoid read from the source device.
> 
> [CAUSE]
> The dev-replace read mode is only set but not followed by scrub code
> at all.
> 
> In fact, only common read path is properly following the read mode,
> but scrub itself has its own read path, thus not following the mode.
> 
> [FIX]
> Here we enhance scrub_find_good_copy() to also follow the read mode.
> 
> The idea is pretty simple, in the first loop, we avoid the following
> devices:
> 
> - Missing devices
>   This is the existing condition
> 
> - The source device if the replace wants to avoid it.
> 
> And if above loop found no candidate (e.g. replace a single device),
> then we discard the 2nd condition, and try again.
> 
> Since we're here, also enhance the function scrub_find_good_copy() by:
> 
> - Remove the forward declaration
> 
> - Makes it return int
>   To indicates errors, e.g. no good mirror found.
> 
> - Add extra error messages
> 
> Now with the same trace, "btrfs replace start -r" works as expected:
> 
>            btrfs-1121013 [000] .....  5991.905971: scrub_submit.part.0: devid=2 logical=22036480 phy=1064960 len=16384
>            btrfs-1121013 [000] .....  5991.906276: scrub_submit.part.0: devid=2 logical=30457856 phy=9486336 len=32768
>            btrfs-1121013 [000] .....  5991.906365: scrub_submit.part.0: devid=2 logical=30507008 phy=9535488 len=49152
>            btrfs-1121013 [000] .....  5991.906423: scrub_submit.part.0: devid=2 logical=30605312 phy=9633792 len=32768
>            btrfs-1121013 [000] .....  5991.906504: scrub_submit.part.0: devid=2 logical=30703616 phy=9732096 len=65536
>            btrfs-1121013 [000] .....  5991.907314: scrub_submit.part.0: devid=2 logical=298844160 phy=277872640 len=131072
>            btrfs-1121013 [000] .....  5991.907575: scrub_submit.part.0: devid=2 logical=298975232 phy=278003712 len=131072
>            btrfs-1121013 [000] .....  5991.907822: scrub_submit.part.0: devid=2 logical=299106304 phy=278134784 len=131072
>            ...
>            btrfs-1121013 [000] .....  5991.947417: scrub_submit.part.0: devid=2 logical=318504960 phy=297533440 len=131072
>            btrfs-1121013 [000] .....  5991.947664: scrub_submit.part.0: devid=2 logical=318636032 phy=297664512 len=131072
>            btrfs-1121013 [000] .....  5991.947920: scrub_submit.part.0: devid=2 logical=318767104 phy=297795584 len=131072
> 
> Reviewed-by: Anand Jain <anand.jain@oracle.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Rename "replace read policy" to "replace read mode" in comments
>   This is avoid the confusion with the existing read policy.
>   No behavior change.
> 
> v3:
> - Avoid using different mirrors if our profile is RAID56
>   RAID56 doesn't contain extra copies, they rebuilt data from P/Q.
>   Thus for RAID56, we can not directly select another stripe and
>   use it as a read source.
> 
> v4:
> - Fix the failure in btrfs/027
>   The change in v3 is not enough for RAID56, as for missing data stripe
>   dev, we still can not use other mirrors.
>   This fix gives RAID56 higher priority than missing data stripe device.

I didn't do an in-depth review so please send v5 if needed, now added to
misc-next, thanks.
