Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6736B5FEDEE
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Oct 2022 14:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiJNMWo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Oct 2022 08:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiJNMWl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Oct 2022 08:22:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1F31CBAB6
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 05:22:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BF6BA1F383;
        Fri, 14 Oct 2022 12:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665750159;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gRsp5L6XVrMjOFY82+UmAGmSuPyj1As8ri0BV+dofTQ=;
        b=zFhIkHxB8ZXWND1abc5dhqzBW506iUww/u8aURC6Y2b9CI3FtmlV1kvXKMSTNdQOHA5IBm
        aUHqSLC6ylXHtq6wu3XGdZxajydNu9qYJqi7aHD2Awt1zafdgG2VZw2r6W+bYmhV2caUs9
        wRoyYV4rkmjm4FYgg2LIYP/OEo0HIzY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665750159;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gRsp5L6XVrMjOFY82+UmAGmSuPyj1As8ri0BV+dofTQ=;
        b=x5UpyiJFu/OJreGaEvvUg3jiEyEetJzzSv60+jg32ppziPRH7RVouEBtS/jYQrlju7gdoG
        30t3uOyyce6+0ICA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A05BF13A4A;
        Fri, 14 Oct 2022 12:22:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vu5kJo9USWN6BQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 14 Oct 2022 12:22:39 +0000
Date:   Fri, 14 Oct 2022 14:22:32 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.cz>
Cc:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 2/5] btrfs: use ffe_ctl in btrfs allocator tracepoints
Message-ID: <20221014122232.GG13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1664999303.git.boris@bur.io>
 <22c0c12d9fb7750d21fe2e7ad566bcc49856bf5a.1664999303.git.boris@bur.io>
 <20221011130335.GS13389@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011130335.GS13389@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 11, 2022 at 03:03:35PM +0200, David Sterba wrote:
> On Wed, Oct 05, 2022 at 12:49:19PM -0700, Boris Burkov wrote:
> > --- /dev/null
> > +++ b/fs/btrfs/extent-tree.h
> > @@ -0,0 +1,80 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#ifndef BTRFS_EXTENT_TREE_H
> > +#define BTRFS_EXTENT_TREE_H
> > +
> > +#include "ctree.h"
> 
> Pulling ctree.h into this header is going the opposite way, we're trying
> to logically separate the APIs.

Fixing that results in many cascaded changes in other headers that
depend on "ctree.h pulls everything", so this should be fixed
separately, it was not a one-liner as I hoped for.
