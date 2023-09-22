Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2F37AB462
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 17:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbjIVPC2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 11:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbjIVPCN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 11:02:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087BD1706
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 08:01:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 62EC81FF1E;
        Fri, 22 Sep 2023 15:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695394908;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RKVw6Pdc6CYe/kbIRGqPpeGp3m0USrJkzBhfRhXbyOM=;
        b=Ffgnrrdit4+AgAI9kTIgoCY5DY5e/9BabBUvHeNWo8PzvFAjAewYcc5U6L+OvuCpsNKp4E
        KWVZRSPiJdNmjxyqIekiDAfXulGemsOkhtABJI9l7rondjqLP7Wr4kWdl5SFsURCuYVrWA
        t5X4NAb4+cVF7TQ0zavrlOaS8/4yXc0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695394908;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RKVw6Pdc6CYe/kbIRGqPpeGp3m0USrJkzBhfRhXbyOM=;
        b=52aYsAWqrlfJjXbiwElHQjUA/qwZxth7PgVZuqnVeqDlIL9RD+IRYjdoe8G4NAg5Xwiq2l
        7/ugh1lZkSKXYgAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 32DDD13597;
        Fri, 22 Sep 2023 15:01:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HAiNC1ysDWWtEAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 22 Sep 2023 15:01:48 +0000
Date:   Fri, 22 Sep 2023 16:55:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: introduce "abort=" groups for more strict
 error handling
Message-ID: <20230922145513.GF13697@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1695350405.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1695350405.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 22, 2023 at 12:25:18PM +0930, Qu Wenruo wrote:
> During a very interesting (and weird) debugging session, it turns out
> that btrfs will ignore a lot of write errors until we hit some critical
> location, then btrfs started reacting, normally by aborting the
> transaction.
> 
> This can be problematic for two types of people:
> 
> - Developers
>   Sometimes we want to catch the earlies sign, continuing without any
>   obvious errors (other than kernel error messages) can make debugging
>   much harder.
> 
> - Sysadmins who wants to catch problems early
>   Dmesg is not really something users would check frequently, and even
>   they check it, it may already be too late.
>   Meanwhile if the fs flips read-only early it's not only noisy but also
>   saves the context much better (more relevant dmesgs etc).

For sysadmins I think that the preferred way is to get events (like via
the uevents interface) that can be monitored and then reacted to by some
tools.

> On the other hand, I totally understand if just a single sector failed
> to be write and we mark the whole fs read-only, it can be super
> frustrating for regular end users, thus we can not make it the default
> behavior.

I can't imagine a realistic scenario where a user would like this
behaviour, one EIO takes down whole filesystem could make sense only for
some testing environments.

> So here we introduce a mount option group "abort=", and make the
> following errors more noisy and abort early if specified by the user.

Default andswer for a new mount option is 'no', here we also have one
that is probably doing the same, 'fatal_errors', so if you really want
to do that by a mount option then please use this one.

> - Any super block write back failure
>   Currently we're very loose on the super block writeback failure.
>   The failure has to meet both conditions below:
>   * The primary super block writeback failed

Doesn't this fail with flip to read-only?

>   * Total failed devices go beyond tolerance
>     The tolerance is super high, num_devices - 1. To me this is
>     too high, but I don't have a better idea yet.

Does this depend on the profile constraints?

>   This new "rescue=super" may be more frequently used considering how
>   loose our existing tolerance is.
> 
> - Any data writeback failure
>   This is only for the data writeback at btrfs bio layer.
>   This means, if a data sector is going to be written to a RAID1 chunk,
>   and one mirror failed, we still consider the writeback succeeded.
> 
> There would be another one for btrfs bio layer, but I have found
> something weird in the code, thus it would only be introduced after I
> solved the problem there, meanwhile we can discuss on the usefulness of
> this patchset.

We can possibly enhance the error checking with additional knobs and
checkpoints that will have to survive or detect specific testing, but as
mount options it's not very flexible. We can possibly do it via sysfs or
BPF but this may not be the proper interface anyway.
