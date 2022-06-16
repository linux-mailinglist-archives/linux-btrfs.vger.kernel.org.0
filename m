Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D0754ED18
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jun 2022 00:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378961AbiFPWFu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jun 2022 18:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379008AbiFPWFj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jun 2022 18:05:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667FD6129B;
        Thu, 16 Jun 2022 15:05:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5C90F1F37E;
        Thu, 16 Jun 2022 22:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655417111;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=60VPT8oMa+JleU+N4k5yeM0YGzH9c1yMuWkZXfIBx2Q=;
        b=ca/Kx249PJn3ys4VBzyp8/pOEdhfXS0ESJyjgZfo2iKJgnaucGHtVdSkSkTpL+Hatc2Hh9
        2TRztA2paZKxpaWGXRHRfayguUH53QpQEQlxBY7ul4RQ7/024zYecknQetmqgUm7Fw335m
        rNMHYIrGj4aGKHsQtv6a0dm7auCkXgY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655417111;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=60VPT8oMa+JleU+N4k5yeM0YGzH9c1yMuWkZXfIBx2Q=;
        b=FLgB+caB+gYGr0bWmD0mtEnjkKf/cqHeHwUYYI2sjy31hWj4InPzEe/GRSEa7I/U0epV5u
        VZWRQL2/8E2wGTAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 277271344E;
        Thu, 16 Jun 2022 22:05:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wcaJCBepq2ICRAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 16 Jun 2022 22:05:11 +0000
Date:   Fri, 17 Jun 2022 00:00:36 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     kernel test robot <oliver.sang@intel.com>,
        David Sterba <dsterba@suse.com>, 0day robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-btrfs@vger.kernel.org,
        lkp@lists.01.org
Subject: Re: [btrfs]  66a7a2412f: xfstests.btrfs.131.fail
Message-ID: <20220616220036.GF20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Matthew Wilcox <willy@infradead.org>,
        kernel test robot <oliver.sang@intel.com>,
        David Sterba <dsterba@suse.com>, 0day robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-btrfs@vger.kernel.org,
        lkp@lists.01.org
References: <20220607154229.9164-1-dsterba@suse.com>
 <20220616143710.GF25633@xsang-OptiPlex-9020>
 <Yqud1/SooVDamiuP@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yqud1/SooVDamiuP@casper.infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 16, 2022 at 10:17:11PM +0100, Matthew Wilcox wrote:
> On Thu, Jun 16, 2022 at 10:37:10PM +0800, kernel test robot wrote:
> > btrfs/131	- output mismatch (see /lkp/benchmarks/xfstests/results//btrfs/131.out.bad)
> >     --- tests/btrfs/131.out	2022-06-13 17:10:24.000000000 +0000
> >     +++ /lkp/benchmarks/xfstests/results//btrfs/131.out.bad	2022-06-15 18:54:06.505508542 +0000
> >     @@ -2,9 +2,9 @@
> >      Using free space cache
> >      free space tree is disabled
> >      Enabling free space tree
> >     -free space tree is enabled
> >     +free space tree is disabled
> 
> I think I know what's going on here:
> 
>         compat_ro="$($BTRFS_UTIL_PROG inspect-internal dump-super "$SCRATCH_DEV"
>  | \
>                      sed -rn 's/^compat_ro_flags\s+(.*)$/\1/p')"
>         if ((compat_ro & 0x1)); then
>                 echo "free space tree is enabled"
>         else
>                 echo "free space tree is disabled"
>         fi
> 
> dump-super is reading the super block out of the page cache, but this
> change makes the page cache incoherent with what's on disc.  We could
> fix that by invalidating the page out of the page cache, but it may be
> easier to just dump this patch and fix how we use the page cache to
> write back the superblocks?

The build bot picks up the branch with some delay, I've removed it from
the pushed branches. It's interesting to see that using the page cache
vs direct write does have effects in tests, so it would need to be
unified in kernel and user space.
