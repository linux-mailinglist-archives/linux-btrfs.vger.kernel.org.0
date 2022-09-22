Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049945E670A
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Sep 2022 17:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbiIVP1Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Sep 2022 11:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbiIVP1W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Sep 2022 11:27:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37739F1D61
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Sep 2022 08:27:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A89291F96B;
        Thu, 22 Sep 2022 15:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663860439;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iKfOlUSTH+VyzKZs+Z6Z3er+nN5c/fRLXz5y1yC35GQ=;
        b=yN36TWARLtY0b2vLbUA8oN7I0598iUmy5be/gr1/ZDgwJzzEJ7zg2JBb/3SWoM81DZDiin
        0zsh6bOaESTm3ASQRPKbmcsfeKA3CgAVnd7TUP29TGIb9wDO59/VhQBxTJzGpFgiCWrXUB
        4nIUqedJUtHG6e7JP1vWEhmElWHqN54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663860439;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iKfOlUSTH+VyzKZs+Z6Z3er+nN5c/fRLXz5y1yC35GQ=;
        b=S4oF8Ucd40ytyWYJr7sFgXv673ee4zgyI6hT78/Rqge+sGBPvLxddJxOvPsDSmLclrsd7L
        J3b8l3D7SR/M3cBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 782821346B;
        Thu, 22 Sep 2022 15:27:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rmXzG9d+LGMwMAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 22 Sep 2022 15:27:19 +0000
Date:   Thu, 22 Sep 2022 17:21:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: drop btrfs_write_inode prototype
Message-ID: <20220922152147.GK32411@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20220922130848.96937-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922130848.96937-1-jlayton@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 22, 2022 at 09:08:48AM -0400, Jeff Layton wrote:
> This function no longer exists.
> 
> Fixes: 3c4276936f6f ("Btrfs: fix btrfs_write_inode vs delayed iput deadlock")

Thanks. The Fixes: is for something that's supposed to go to stable,
otherwise it's enough to mention the commit as part of the changelog,
I'll update it.
