Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4579062420B
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Nov 2022 13:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiKJMNQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Nov 2022 07:13:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiKJMNO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Nov 2022 07:13:14 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEBB5598
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 04:13:13 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 622DE1F92B;
        Thu, 10 Nov 2022 12:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668082392;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S9JyX8kgydGbtXw6d76cd//W7e/AXvRHlVNJNCN3OZo=;
        b=ZCbx5Y6mBDovPfD0n1/ZlNt+l3XKa3PSUvl0XLbDr0Eu4eG8C4z9YlbbS9CrLt2xzshDJz
        4Hz2nWgQx790u/o4qQX0wp0j4NBPDiaoc6auZxLyCV5968xcu66IBovjWKaR8G944MmLlL
        SIzG6jqrBdK3ZPwyLgqmxCmiJm9woqg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668082392;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S9JyX8kgydGbtXw6d76cd//W7e/AXvRHlVNJNCN3OZo=;
        b=NtN6FmOXEKwgIZDWN9qCOtmWZU50xdPaDYpnFJhUN9k4eEJipa/6Q/MIuNRJqinAqdPzgO
        cb/sq+EennoRCoBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3B78F1332F;
        Thu, 10 Nov 2022 12:13:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EpKADdjqbGOJTAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 10 Nov 2022 12:13:12 +0000
Date:   Thu, 10 Nov 2022 13:12:49 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Eric Levy <contact@ericlevy.name>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: option to mount read-only subvolume with read-write access
Message-ID: <20221110121249.GE5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <G1N4LR.84UPK81F80SK3@ericlevy.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <G1N4LR.84UPK81F80SK3@ericlevy.name>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 10, 2022 at 05:12:52AM -0500, Eric Levy wrote:
> At times it is helpful to modify a subvolume to which has been assigned 
> a read-only property, without changing the property.

So that would be a silent change in the subvolume and not detectable by
eg. checking the generation. That would break incremental send at least
and goes against the point of read-only subvolume. If you'd want to do a
silent change it would have to be something that does not need to
copy-on-write any block (that requires generation change) so it would
have to be in-place and with recalculated checksum.

> One reason for 
> keeping the property is that the same subvolume may be reachable 
> through another mount point. Another is to ensure that the property 
> persists even if some operation fails to complete.

Yeah but the other mount points would see the old data, depending on the
cached status of the blocks.

> Would you consider adding a mount option to cause the system to ignore 
> a read-only property for the subvolume accessed through the mount 
> point, without affecting access to the same subvolume through other 
> mount points?

I think it does not have a well defined semantics, what you ask seems to
be some kind of multi headed subvolume that could appear different
depending on the way it's accessed from the VFS mount point which is out
of reach in many cases.

I'd probably need to understand what you mean in the first sentence "At
times it is helpful", I don't have an idea where it would be helpful.
