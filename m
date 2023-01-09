Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF03E66342B
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jan 2023 23:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbjAIWlA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Jan 2023 17:41:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237984AbjAIWko (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Jan 2023 17:40:44 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAA21CB17
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Jan 2023 14:40:39 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 02CC03EF63;
        Mon,  9 Jan 2023 22:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673304038;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7O0K93Rf9mPB48D0qlFU1qkEmnjvuq6FFTWOdGPnw30=;
        b=kp4DjPjQFbTxqDTFDNiru8EIJcKLqv3Nv5HUxf1VeRlsE45M6gbpomMG68moKKJQjxzSEV
        cbvD9/6Xd4vZ+/yraoVwnlXmifsAPtVXINJYTbJ9dvhpBHZZcOUGdZsz7X+HPEOU4tAqdY
        5fQmKAV5ziSTNQsdFWbtjPVOfCrPpgY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673304038;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7O0K93Rf9mPB48D0qlFU1qkEmnjvuq6FFTWOdGPnw30=;
        b=z5WPZMZMTov03Jd/kweXHKjQjx3LkLJ2O82h42FsF3wxI0wfHzlpNVHKvtt+TT+kPj0UrH
        6LCGQZxbeQ0FnIAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CA5D513583;
        Mon,  9 Jan 2023 22:40:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3SZgMOWXvGM/IAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 09 Jan 2023 22:40:37 +0000
Date:   Mon, 9 Jan 2023 23:35:03 +0100
From:   David Sterba <dsterba@suse.cz>
To:     waxhead <waxhead@dirtcellar.net>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: Btrfs progs release 6.1
Message-ID: <20230109223503.GY11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20221222205716.4916-1-dsterba@suse.com>
 <00ac11fa-b6c9-6234-50db-3af1c2ae826c@dirtcellar.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00ac11fa-b6c9-6234-50db-3af1c2ae826c@dirtcellar.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Dec 24, 2022 at 11:20:20AM +0100, waxhead wrote:
> I have nagged about this before, but here goes again.
> Can we as users get some kind of deduplicaiton support for btrfs-progs?
> 
> As a conservative Debian user I tend to stick with what is in the 
> package repos, and I also believe that most people will feel more 
> comfortable with a "official" implementation rather than some random 
> program for this kind of stuff.
> 
> something as "simple" as "btrfs filesystem deduplicate -R /mnt" would be 
> wonderful.

Yes, this is planned, it would be convenient to quickly deduplicate a
few files or let it work on a directory. This would probably copy what
duperemove does and most likely also steal the implementation as it's in
C.

I'm not sure if btrfs command should provide exactly the same set of
features and options and duplicate the project, I think dupremove is not
currently maintained. I don't want to reimplement everything from
scratch so some level of sharing will make things easier, either direct
copy or as git submodule. It'll start as an experimental command.
