Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427F66E1276
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Apr 2023 18:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjDMQi2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Apr 2023 12:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjDMQi1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Apr 2023 12:38:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB0D7EEE
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Apr 2023 09:38:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DD6081FD6C;
        Thu, 13 Apr 2023 16:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681403904;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XolZ+3R+QN27eNd51H/UnuZAoCwQjwuJJCq8fUDMpPI=;
        b=eL2qmZaFVRgMwX6hmxdb+Tj5icnQ4KtOn6yGcTToRCKMs7WaT5QPKr/cy4bft8gnnQA7I1
        rSBJHHW+e58BHCVlO0bQLEH8c7BSIQtrIBUrV6IpjUxuMFeQY8YmaYCGr24guRt7QbGKQY
        1KPkbQ5IUkXDVZisQ2mvXjE+hD3E34Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681403904;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XolZ+3R+QN27eNd51H/UnuZAoCwQjwuJJCq8fUDMpPI=;
        b=Db8qGj0AGmOo2pD9WmTozvUF8+7UaSUxTMmMsiiBbmDB3vYqg57lnn9jAYTQLLwVw55g5f
        xOOOOh8qu/HZSIBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B48A413421;
        Thu, 13 Apr 2023 16:38:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JswiKwAwOGSRfQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 13 Apr 2023 16:38:24 +0000
Date:   Thu, 13 Apr 2023 18:38:18 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs-progs: move block-group-tree out of
 experimental features
Message-ID: <20230413163818.GI19619@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1681180159.git.wqu@suse.com>
 <4cc5819796bd2af6de78b7a1919b4f8ed02b985f.1681180159.git.wqu@suse.com>
 <054ae0c1-3a1a-eed5-5ac9-c4d7773c8ab9@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <054ae0c1-3a1a-eed5-5ac9-c4d7773c8ab9@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 13, 2023 at 05:54:01PM +0530, Anand Jain wrote:
> On 4/11/23 08:01, Qu Wenruo wrote:
> > The feedback from the community on block group tree is very positive,
> > the only complain is, end users need to recompile btrfs-progs with
> > experimental features to enjoy the new feature.
> > 
> > So let's move it out of experimental features and let more people enjoy
> > faster mount speed.
> > 
> 
> 
> > Also change the option of btrfstune, from `-b` to
> > `--enable-block-group-tree` to avoid short option.
> 
> What is the tradeoff for the desktop use case (lets say 1TB disksize)
> if the block-group-tree is made the default option? And add btrfstune
> --disable-bg instead.

On a 1TB disk the difference is probably not that big, the long mount
times were reported on larger filesystems and bgt is advertisied as
help on many-terabyte filesystems. It's a vague statement because we
don't know the exact value but from 4T on it would probably make more
sense.

Another thing, block-group-tree is not going to be default yet, it's
being moved from experimental features, i.e. generally available by
default. When we're going to make it default is not known yet.

Conversion from bgt to extent tree is something I asked for but it's not
a priority in case bgt is not default so we don't have --disable-bg.
