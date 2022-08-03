Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7557588E35
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Aug 2022 16:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238638AbiHCOF6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Aug 2022 10:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236494AbiHCOF5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Aug 2022 10:05:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D4E17580
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Aug 2022 07:05:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 21B4A381A5;
        Wed,  3 Aug 2022 14:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659535552;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b8pG/+FAfxRUaj/tkk7zt5bflrmHwViutTDsufurgUw=;
        b=KAdb7yJhlPN/2mxYz+cO28+EJWWeiEp0MjYvZa8mhNNmyBM/xnoS/JDZrpPpD6mSALg0rH
        +1lpRa5DM9qqWgelRHi5K8GyCgbdYv1/TG7ODsk2FLbRGqY3HQ9y/0wn6xzuDDI+KptILK
        gH632mEuauaL76EDL6nHCzQGoSiCIXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659535552;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b8pG/+FAfxRUaj/tkk7zt5bflrmHwViutTDsufurgUw=;
        b=qULSkuD52kpj2rvthvK9I3QdZXPA5U2uMvb1k4H2WPwOqbpyTyHj8vUOuLppxhg9artBbF
        /lslCltkgdeKK6BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EDCFC13A94;
        Wed,  3 Aug 2022 14:05:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DuKAOL+A6mL6EAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 03 Aug 2022 14:05:51 +0000
Date:   Wed, 3 Aug 2022 16:00:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 3/4] btrfs: add checksum implementation selection
 after mount
Message-ID: <20220803140049.GH13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1659443199.git.dsterba@suse.com>
 <cc590040e5393aad0294e3d7c592de991706cf2e.1659443199.git.dsterba@suse.com>
 <cb79999e-a16c-294e-4dab-74c4be45b85e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb79999e-a16c-294e-4dab-74c4be45b85e@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 03, 2022 at 08:06:46AM +0800, Anand Jain wrote:
> On 02/08/2022 20:28, David Sterba wrote:
> > The sysfs file /sys/fs/btrfs/FSID/checksum shows the filesystem checksum
> > and the crypto module implementing it. In the scenario when there's only
> > the default generic implementation available during mount it's selected,
> > even if there's an unloaded module with accelerated version.
> > 
> > This happens with sha256 that's often built-in so the crypto API may not
> > trigger loading the modules and select the fastest implementation. Such
> > filesystem could be left using in the generic for the whole time.
> > Remount can't fix that and full umount/mount cycle may be impossible eg.
> > for a root filesystem.
> > 
> > Allow writing strings to the sysfs checksum file that will trigger
> > loading the crypto shash again and check if the found module is the
> > desired one.
> > 
> > Possible values:
> > 
> > - default - select whatever is considered default by crypto subsystem,
> >              either generic or accelerated
> > - accel   - try loading an accelerated implementation (must not contain
> >              "generic" in the name)
> > - generic - load and select the generic implementation
> > 
> > A typical scenario, assuming sha256 is built-in:
> > 
> >    $ mkfs.btrfs --csum sha256
> >    $ lsmod | grep sha256
> >    $ mount /dev /mnt
> >    $ cat ...FSID/checksum
> >    sha256 (sha256-generic)
> >    $ modprobe sha256
> >    $ lsmod | grep sha256
> >    sha256_ssse3
> >    $ echo accel > ...FSID/checksum
> >    sha256 (sha256-ni)
> 
> I am not sure if I understand the use of slots 1 and 2 correctly.
> As each checksum type can be either generic or accelerated, slot 0 is
> the default which tells the preferred method. So slot0 is either
> CSUM_GENERIC or CSUM_ACCEL. And by default, we prefer accelerated when
> available or user requests. So I am still not getting the purpose of
> slot1 and 2. Instead, overwriting slot0 will still do the job without
> slot1 and 2.

We need to keep track of all allocated hashes so they don't leak, which
would happen if slot 0 is overwritten after the switch. Also we must not
free the hash from sysfs because it could be in use. That's why there
are slots that keep track of the allocated structures and slot 0 that's
provided to use it for checksumming, merely as an alias.

The pointer switch is atomic (regarding the pointer value, not the
atomic_t semantics) so once some function uses it for shash it'll stay
there even if it won't be the default anymore.

I could add READ_ONCE/WRITE_ONCE for the slots so it's clear the access
is done in some unusal way, as we do with other sysfs variables.

> > The crypto shash for all slots has the same lifetime as the mount, so
> > it's not possible to unload the crypto module.
> 
> How does the update of the accelerated module work if a btrfs is a
> non-root filesystem? Does it need a reboot?

By update you mean rmmod/insmod with eventual update of the .ko file?
That won't work due to reference counts, so reloading the module would
require unmounting the filesystem, or reboot.

Freeing the allocated hash structure could be implemented by usage
counters when there's some checksumming in progress, the sysfs write
would wait until there are no users left and then free it.
