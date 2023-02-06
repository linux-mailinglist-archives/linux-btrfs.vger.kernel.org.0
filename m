Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEF068C5F4
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Feb 2023 19:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjBFSjW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Feb 2023 13:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjBFSjT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Feb 2023 13:39:19 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D972CC63;
        Mon,  6 Feb 2023 10:39:17 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3F19460845;
        Mon,  6 Feb 2023 18:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675708756;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dAWkS57jklU6SXWg2r8ZiTAi7stYMaw/Kax88+A3hjI=;
        b=I2ClgK91jcGt6qybmNupF0jPRY52XybxRlSGZGMnlKbV4gvIuChyuC4XoWgjImxp+iGiu1
        HakHOfz4fLIdes2Ak3r4jfP+ltRencrHnjXx+V2hGfYRHtv9qlXgHLZwjw0o5WrtQlXRcY
        nosvMP2fOZ450Dpdnyu+piOIFv5qBek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675708756;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dAWkS57jklU6SXWg2r8ZiTAi7stYMaw/Kax88+A3hjI=;
        b=WQFErx/4ZMcsxdLXcA/SX8KnRTYVYchY+s5zqFxW5ie1s/AyY36DybY86fSyxOYBBJV5/v
        BhDJ1wyMeoAmtSBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0BE1B138E7;
        Mon,  6 Feb 2023 18:39:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id v+D0AVRJ4WPTTAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 06 Feb 2023 18:39:16 +0000
Date:   Mon, 6 Feb 2023 19:33:27 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] btrfs: sysfs: Handle NULL return values
Message-ID: <20230206183327.GC28288@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230204183510.never.909-kees@kernel.org>
 <Y99XGrFvXBL32cOO@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y99XGrFvXBL32cOO@kroah.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Feb 05, 2023 at 08:13:30AM +0100, Greg KH wrote:
> On Sat, Feb 04, 2023 at 10:35:10AM -0800, Kees Cook wrote:
> > Each of to_fs_info(), discard_to_fs_info(), and to_space_info() can
> > return NULL values.
> 
> The code says it could, but I really do not think that is possible at
> all, especially based on the fact that there have never been any crashes
> reported here.
> 
> So the NULL returns should just be removed instead, right?

Yes. The access to any sysfs callback always implies an existing
fs_info, the sysfs files are destroyed before the instance of fs_info.
If the callback is slow or stuck for some reason, the removal will block
due to reference counts.

> Also, to_space_info() is a macro of container_of() which can not return
> NULL.
> 
> And get_btrfs_kobj() is just odd, that probably should be fixed up as
> well, that's an indication that something is wrong with the sysfs code
> if anyone has to attempt to walk the whole kobject parent path :(

The get_btrfs_kobj is relatively new and more generic than the other
helpers that basically hardcoded the kobj path relative to the main
sysfs object.

> So while this patch might fix up the compiler warning, it's logically
> not going to change anything, let's fix this properly.  I can look at it
> next week if someone doesn't beat me to it.

Let me have a look, I was meaning to clean up the code to use only
get_btrfs_kobj. So far there was no pressing reason for that but if gcc
13 is going to warn about the checks it needs to be fixed.
