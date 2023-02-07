Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7FD68DD9D
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Feb 2023 17:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjBGQKf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Feb 2023 11:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjBGQKd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Feb 2023 11:10:33 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB526EA8
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Feb 2023 08:10:32 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6FE435F839;
        Tue,  7 Feb 2023 16:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675786231;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mer2dNRvBkvojRNtbPjbaiQkNFXs/2RP2J7ywllRbTQ=;
        b=Ec1Hn/POl0MEDw70GyvgfRp7+HyME9aQpl5aWVPK+cTqj0103iYElOUnkct+VxfRPgZdEn
        mVRbR6k6fGpNFdwf/ilsath0HHrQVH01AdUqwyEFvBQPRo9uhmoJ147OQ8nsjRoOOqaGwY
        1xBV+VziYHhOt8S5cmrGNtcMwSee2Pg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675786231;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mer2dNRvBkvojRNtbPjbaiQkNFXs/2RP2J7ywllRbTQ=;
        b=faBdrAPyfLPXGYezTeDF5FLcl6Nxf9YT2lTzB/tdoxVSRqNAj4S8GUFSlYOVKrBzCP6jrZ
        UxSOw/5zyGPik6AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4BBB0139ED;
        Tue,  7 Feb 2023 16:10:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6vGAEfd34mOkPAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 07 Feb 2023 16:10:31 +0000
Date:   Tue, 7 Feb 2023 17:04:42 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     dsterba@suse.com, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, Daan De Meyer <daandemeyer@fb.com>
Subject: Re: [PATCH] btrfs: free device in btrfs_close_devices for a single
 device filesystem
Message-ID: <20230207160442.GI28288@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <faf1de6f88707dbf0406ab85e094e72107b30637.1674221591.git.anand.jain@oracle.com>
 <Y9gb4eFlYh/b7XRx@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9gb4eFlYh/b7XRx@localhost.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 30, 2023 at 02:34:57PM -0500, Josef Bacik wrote:
> On Fri, Jan 20, 2023 at 09:47:16PM +0800, Anand Jain wrote:
> > We have this check to make sure we don't accidentally add older devices
> > that may have disappeared and re-appeared with an older generation from
> > being added to an fs_devices (such as a replace source device). This
> > makes sense, we don't want stale disks in our file system. However for
> > single disks this doesn't really make sense. I've seen this in testing,
> > but I was provided a reproducer from a project that builds btrfs images
> > on loopback devices. The loopback device gets cached with the new
> > generation, and then if it is re-used to generate a new file system we'll
> > fail to mount it because the new fs is "older" than what we have in cache.
> > 
> > Fix this by freeing the cache when closing the device for a single device
> > filesystem. This will ensure that the mount command passed device path is
> > scanned successfully during the next mount.
> > 
> 
> Dave, I think I like this approach better actually, it may be less error prone
> than my fix, if we just delete single disks from the device cache we can remount
> whatever later.  This may be safer than what I suggested, what do you think?

Agreed, removing the single devices from cache sounds like a safe
option, the cache is there namely for multi-device fs so we don't lose
anything.
