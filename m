Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD6C6A741D
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Mar 2023 20:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjCATPA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Mar 2023 14:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjCATO7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Mar 2023 14:14:59 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD34A34015
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Mar 2023 11:14:48 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 634811FE3B;
        Wed,  1 Mar 2023 19:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677698087;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PUXMsi6kqK4dZ0REwpZq22dZkzE15745w722S8e3Gzk=;
        b=hv++BD7ywzEcogawncoG+8pJM4fYhNmxNfjyFkyc0Q7EwayaFsLswZQTFQ3iMBzXJhS71B
        XkVrIdBo1iUcp0s1xdEDoBH89Xc0gptkArdbtVkbBLL+vLHh52QUyuTzoAHvtMGKAAfwHR
        6OCQVu/b9ghoe/aNYA5rWph2u6QnDB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677698087;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PUXMsi6kqK4dZ0REwpZq22dZkzE15745w722S8e3Gzk=;
        b=GzxyoosQHJj1cZidxUIg2CXvUAtMOwlFPFozO020R/1JqxFXvMXP2aXxktZm7j7CfzTE2T
        P4SK1NbZv1Z07gDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 310F113A63;
        Wed,  1 Mar 2023 19:14:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ijT5Ciek/2MmVQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 01 Mar 2023 19:14:47 +0000
Date:   Wed, 1 Mar 2023 20:08:47 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: do not use replace target device as an extra
 mirror
Message-ID: <20230301190847.GY10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <5032646bf05bad479eb170b1d3e5b1c78dbdfb10.1677052042.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5032646bf05bad479eb170b1d3e5b1c78dbdfb10.1677052042.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 22, 2023 at 03:47:40PM +0800, Qu Wenruo wrote:
> [BUG]
> Currently btrfs can use dev-replace device as an extra mirror for
> read-repair.
> 
> But it can lead to NODATASUM corruption in the following case:
> 
>  There is a RAID1 data chunk, and dev-replace is running from
>  dev2 to dev0.
> 
>  |//| = Replaced data
>           X       X+1MB     X+2MB
>   Dev 2:  |       |         |           <- Source dev
>   Dev 0:  |///////|         |           <- Target dev
> 
> Then a read on dev 2 X+2MB happens.
> And something wrong happened inside devid 2, causing an -EIO.
> 
> In that case, read-repair would try the next mirror, and since we can
> use target device as an extra mirror, we will use that mirror instead.
> 
> But unfortunately since the read is beyond the current replace cursor,
> we should not trust it at all, what we get would be just uninitialized
> garbage.
> 
> But if this read is for NODATASUM range, then we just trust them and
> cause data corruption.
> 
> [CAUSE]
> We used to have some checks to make sure we only return such extra
> mirror when the range is before our left cursor.
> 
> The first commit introducing this behavior is ad6d620e2a57 ("Btrfs:
> allow repair code to include target disk when searching mirrors").
> 
> But later a fix, 22ab04e814f4 ("Btrfs: fix race between device replace
> and chunk allocation") changed the behavior, to always let
> btrfs_map_block() to include the extra mirror to address a race in
> dev-replace which can cause missing writes to target device.
> 
> This means, we lose the tracking of cursor for the extra mirror, thus
> can lead to above corruption.
> 
> [FIX]
> The extra mirror is never a reliable one, at the beginning of
> dev-replace, the reliability is 0, while only at the end of the replace
> it's a fully reliable mirror.
> 
> We either do the complex tracking, or never trust it.
> 
> IMHO it's much easier to maintain if we don't trust it at all, and the
> extra mirror can only benefit for a limited period of time (during
> replace).
> 
> Thus this patch would completely remove the ability to use target device
> as an extra mirror.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.

> ---
> In a thread discussing the situation with Stefan, he mentioned some
> cases where we want to avoid read from an unreliable source device.
> 
> The problem is, using the target device as an extra mirror is not
> affecting replace itself (I recently fixed that by patch "btrfs: make
> dev-replace properly follow its read mode"), and read-repair is already
> avoiding read from source device when mode avoid is specified.
> 
> So the argument to avoid read from the source device should not be a big
> deal already, as long as the user specify "-r" option for "btrfs replace
> start".

This could be better promoted if it's supposed to make some use cases
work, the documentation of replace explains that a bit. I think I've
read complaints about dev replace not able to finish if a device has an
bad sector that always does EIO. Resolving that involved balance filter
tricks but there should be a more friendly way to do it within the dev
replace modes.
