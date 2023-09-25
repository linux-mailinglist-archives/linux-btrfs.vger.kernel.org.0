Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8CE7ADD5A
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Sep 2023 18:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbjIYQob (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Sep 2023 12:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbjIYQo2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Sep 2023 12:44:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E61A9F
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Sep 2023 09:44:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 62C0321853;
        Mon, 25 Sep 2023 16:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695660258;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lAObU49W9lZjkqhFUJqxz3OwaLkvt4SgEGvzs14xXFA=;
        b=SKiLoNDze7TgWrI3sMYz6Up47B7DDsVpncvYpBzZMNRreXlLuY4VsUG7+Adih+U7VEKM/z
        Tr5M69oyXdyfEMCu2b58wr10aWqsURyQeJYQ3S5Pj1Ta0ekpNYfiT17FBVC0/23LxqrSmq
        71qqia0KXIx1R9so7YlLoe9xr7hWalM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695660258;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lAObU49W9lZjkqhFUJqxz3OwaLkvt4SgEGvzs14xXFA=;
        b=cfqkxJGMX8Vx9voxcwgNcr8BJigoyJfyGgpwyEEZhezi7SIA60wunBzv3TKgzj0JOdagN4
        3I1FelSwVzZgVlBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3F6C11358F;
        Mon, 25 Sep 2023 16:44:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9XRPDuK4EWX/fQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 25 Sep 2023 16:44:18 +0000
Date:   Mon, 25 Sep 2023 18:37:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: introduce "abort=" groups for more strict
 error handling
Message-ID: <20230925163740.GQ13697@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1695350405.git.wqu@suse.com>
 <20230922145513.GF13697@twin.jikos.cz>
 <25c4f01f-a355-43b9-ab22-725353dc6380@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25c4f01f-a355-43b9-ab22-725353dc6380@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Sep 23, 2023 at 06:46:26AM +0930, Qu Wenruo wrote:
> On 2023/9/23 00:25, David Sterba wrote:
> > On Fri, Sep 22, 2023 at 12:25:18PM +0930, Qu Wenruo wrote:
> >> On the other hand, I totally understand if just a single sector failed
> >> to be write and we mark the whole fs read-only, it can be super
> >> frustrating for regular end users, thus we can not make it the default
> >> behavior.
> > 
> > I can't imagine a realistic scenario where a user would like this
> > behaviour, one EIO takes down whole filesystem could make sense only for
> > some testing environments.
> 
> I doubt, for some environment with expensive hardware, one may not even 
> expect any -EIO for valid operations.
> If that happens, it may mean bad firmware or bad hardware, neither is a 
> good thing especially if they paid extra money for the fancy hardware or 
> the support fee.

So the semantics we'd need is like "fail on first error of <type>" where
we can define a set of errors, like EIO, superblock write erorr or
something related to devices.

> >> So here we introduce a mount option group "abort=", and make the
> >> following errors more noisy and abort early if specified by the user.
> > 
> > Default andswer for a new mount option is 'no', here we also have one
> > that is probably doing the same, 'fatal_errors', so if you really want
> > to do that by a mount option then please use this one.
> 
> Or I can go sysfs interface and put it under some debug directory.

For a prototype it's much more convenient until we understand what's the
actual usecase.

> > 
> >>    This new "rescue=super" may be more frequently used considering how
> >>    loose our existing tolerance is.
> >>
> >> - Any data writeback failure
> >>    This is only for the data writeback at btrfs bio layer.
> >>    This means, if a data sector is going to be written to a RAID1 chunk,
> >>    and one mirror failed, we still consider the writeback succeeded.
> >>
> >> There would be another one for btrfs bio layer, but I have found
> >> something weird in the code, thus it would only be introduced after I
> >> solved the problem there, meanwhile we can discuss on the usefulness of
> >> this patchset.
> > 
> > We can possibly enhance the error checking with additional knobs and
> > checkpoints that will have to survive or detect specific testing, but as
> > mount options it's not very flexible. We can possibly do it via sysfs or
> > BPF but this may not be the proper interface anyway.
> 
> I think sysfs would be better, but not familiar enough with BPF to 
> determine if it's any better or worse.

BPF is probably a bad idea, I mentioned only as a potential way, it's
another extensible interface.

What you suggest looks like the forced shutdown of filesystem. This can
be done internally or externally (ioctl). I haven't looked at the
interface to what extent it's configurable, but let's say there's a
bitmask set by admin and the filesystem checks that in case a given type
of error happens. Then forced shutown would be like a transaction abort,
followed by read-only. We have decent support for that but with the
shutdown some kind of audit would have to happen anyway, namely for the
EIO type of errors. Specific context like super block write error would
be relatively easy.
