Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DED87DFB7C
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Nov 2023 21:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbjKBUZZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Nov 2023 16:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbjKBUZY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Nov 2023 16:25:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD55181
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Nov 2023 13:25:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 76E981FD65;
        Thu,  2 Nov 2023 20:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698956717;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kWEarye3v1SfTnyNMSTuyQ2YSMzLsR2A6FTV4QhpASA=;
        b=2JHZlJWSl+mfFD9nL1Ww1xLEDGnlfKhwKlA9DctaJr5oNn5yvWbU63M95rwqeyvNc3+2q6
        2rGIRo9WtNTbN7uYno5kFbQpiL+1KFK9kkV7h++YMiAhj0+o60iWsv2/5wutu8xqil4YuG
        +b6IKbkOZyvmslnxtpa7kW7ZT070tN8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698956717;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kWEarye3v1SfTnyNMSTuyQ2YSMzLsR2A6FTV4QhpASA=;
        b=qrDfwQGNe48VmVJTR1xMbnR7K3xHllhIt8ZjwgNHxdbyveP92pzSk0FyR9Tcj8QqK5jide
        V3KAbkt+uiRWsVCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 22F3B13584;
        Thu,  2 Nov 2023 20:25:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ku/SB60FRGWnNwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 02 Nov 2023 20:25:17 +0000
Date:   Thu, 2 Nov 2023 21:18:18 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: add dmesg output when mounting and unmounting
Message-ID: <20231102201818.GI11264@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <215e7eea95459d1b0cc4fd9ce522dc7c8f5d4e02.1698873846.git.wqu@suse.com>
 <18fda4f8-8f3c-4dd1-8aca-667726e278df@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18fda4f8-8f3c-4dd1-8aca-667726e278df@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 02, 2023 at 09:16:19AM +0800, Anand Jain wrote:
> On 11/2/23 05:24, Qu Wenruo wrote:
> > There is a feature request to add dmesg output when unmounting a btrfs.
> > 
> > There are several alternative methods to do the same thing, but with
> > their problems:
> > 
> > - Use eBPF to watch btrfs_put_super()/open_ctree()
> >    Not end user friendly, they have to dip their head into the source
> >    code.
> > 
> > - Watch for /sys/fs/<uuid>/
> >    This is way more simpler, but still requires some simple device -> uuid
> >    lookups.
> >    And a script needs to use inotify to watch /sys/fs/.
> > 
> 
> 
> > Compared to all these, directly outputting the information into dmesg
> > would be the most simple one, with both device and UUID included.
> > 
> 
> Well, I submitted a patch for this in 2017, but I'm not sure why it 
> wasn't integrated or commented.
> 
> https://lore.kernel.org/linux-btrfs/3352043d-dbb1-0055-f50a-c91ca43aff1d@oracle.com/

I think you sent it more than once and that I replied, messages about
mounting each subvolume (as in your patch) seem to be duplicating what
eg. audit or some policy layer should do. The same comment is in the
github issue.

The patch here and the request is to track only the first and last mount
of the same filesystem with a bit different use case, eg. properly
waiting until lazy umount finishe, or in container environments to be
sure that the last mount is gone.

The suggested waiting on /sys/fs/btrfs/UUID could eventually wrapped in
a subcommand, for conveniencie.
