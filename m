Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EABD7611AF4
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Oct 2022 21:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiJ1Thh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Oct 2022 15:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiJ1Thg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Oct 2022 15:37:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAD71DB89F
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Oct 2022 12:37:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BC96C2210D;
        Fri, 28 Oct 2022 19:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666985853;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mDq7UfaeuNWw7IbM7FZ2gFWsmvsezli2GwUR8zE5s8g=;
        b=po9uqmw4gFpCf1hzrqx7ENX4PHGuIZcnVgF35qgUjN4osZzsm1Z4dGVM3Hwy6q3muh10aL
        sOP3i2wupAwgfZ5j0QMiHtheX6GWgJnQPZHO/LMFU+2LwiNJUHQzXyU1zeyQa0YjOK/9Iv
        7wYnFhg78uU+B8qZEbTSOAnZCSHuSjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666985853;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mDq7UfaeuNWw7IbM7FZ2gFWsmvsezli2GwUR8zE5s8g=;
        b=W8RJuIWRHqWFT5Cpbt7P2dM2YMGNjSspc8PhBuCGHUWhop7HQHYuPkwUe+K6736B6OxuH0
        +HVueYN0wLbL8ABA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8DEDD13A6E;
        Fri, 28 Oct 2022 19:37:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1kTdIX0vXGOdOAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 28 Oct 2022 19:37:33 +0000
Date:   Fri, 28 Oct 2022 21:37:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 05/26] btrfs: move the printk and assert helpers to
 messages.c
Message-ID: <20221028193717.GX5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1666811038.git.josef@toxicpanda.com>
 <051b9887171d14d8d5eb30d3274a946427ed3c69.1666811038.git.josef@toxicpanda.com>
 <974d0f7b-1272-1c7f-cf34-88104642e7ca@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <974d0f7b-1272-1c7f-cf34-88104642e7ca@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 28, 2022 at 01:22:54PM +0800, Anand Jain wrote:
> On 27/10/2022 03:08, Josef Bacik wrote:
> > These helpers are core to btrfs, and in order to more easily sync
> > various parts of the btrfs kernel code into btrfs-progs we need to be
> > able to carry these helpers with us.  However we want to have our own
> > implementation for the helpers themselves, currently they're implemented
> > in different files that we want to sync inside of btrfs-progs itself.
> > Move these into their own C file, this will allow us to contain our
> > overrides in btrfs-progs in it's own file without messing with the rest
> > of the codebase.
> > 
> > In copying things over I fixed up a few whitespace errors that already
> > existed.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> LGTM
> Reviewed-by: Anand Jain <anand.jain@oracle.com>
> 
> 
> a nit below:
> 
> > diff --git a/fs/btrfs/messages.c b/fs/btrfs/messages.c
> > new file mode 100644
> > index 000000000000..a94a213da02e
> > --- /dev/null
> > +++ b/fs/btrfs/messages.c
> > @@ -0,0 +1,352 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include "fs.h"
> 
> > +#include "messages.h"
> 
> messages.h is not required to include.

There's btrfs_crit, so it's needed.
