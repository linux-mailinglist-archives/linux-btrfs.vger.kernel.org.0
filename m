Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054B2777F17
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Aug 2023 19:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbjHJR1C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Aug 2023 13:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjHJR1B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Aug 2023 13:27:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1103211C;
        Thu, 10 Aug 2023 10:26:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8E20E1F45B;
        Thu, 10 Aug 2023 17:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691688418;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sTBWbPbXMOVYOXKs1knmD/Ua0aninMPvw3zHQajoZoM=;
        b=EAJv1GifSX55JIxLJWRtpi1/vGB70r+PtQKBuuHRDZtOVCgY/3Y1TLzbhhvX4yxNfgPOHe
        UyOPa9cyLLiX53uE/o0shQkLnqTGjqg6FdpH6HoS8qGCbQwoTACc4RdswXGbuxgZDbKZsH
        /0aHFWHKji81ooFw28y8MdDqX7l4hoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691688418;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sTBWbPbXMOVYOXKs1knmD/Ua0aninMPvw3zHQajoZoM=;
        b=eyCzHc36a4VL1ccd4dA90gNeJ6TnT/f8zB2OtdrWSK7TMmHi1PBlAF0Bxq8KhSm90XI1GO
        +GoQgZrDHAC1UdBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4824F138E2;
        Thu, 10 Aug 2023 17:26:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QLGOEOId1WSGUQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 10 Aug 2023 17:26:58 +0000
Date:   Thu, 10 Aug 2023 19:20:33 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Anand Jain <anand.jain@oracle.com>,
        Filipe Manana <fdmanana@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Arnd Bergmann <arnd@kernel.org>, linux@leemhuis.info
Subject: Re: [PATCH] btrfs: remove unused pages_processed variable
Message-ID: <20230810172033.GK2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230724121934.1406807-1-arnd@kernel.org>
 <ZMBDWbHiJVOt03u5@google.com>
 <CAKwvOdm9CS0FRrWA9LaWw74enydbTMFUk_WYWXJvNxgLwQBzOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdm9CS0FRrWA9LaWw74enydbTMFUk_WYWXJvNxgLwQBzOQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 03, 2023 at 09:45:27AM -0700, Nick Desaulniers wrote:
> On Tue, Jul 25, 2023 at 2:49 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Mon, Jul 24, 2023 at 02:19:15PM +0200, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > The only user of pages_processed was removed, so it's now a local write-only
> > > variable that can be eliminated as well:
> > >
> > > fs/btrfs/extent_io.c:214:16: error: variable 'pages_processed' set but not used [-Werror,-Wunused-but-set-variable]
> > >
> > > Fixes: 9480af8687200 ("btrfs: split page locking out of __process_pages_contig")
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202307241541.8w52nEnt-lkp@intel.com/
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> > Thanks for the patch!
> > Reported-by: kernelci.org bot <bot@kernelci.org>
> > Link: https://lore.kernel.org/llvm/64c00cd4.630a0220.6ad79.0eac@mx.google.com/
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> 
> Friendly ping the btrfs maintainers to please pick this up.

Fix folded to the original patch, thanks.
