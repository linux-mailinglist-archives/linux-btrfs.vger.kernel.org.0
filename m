Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF9E74DC06
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jul 2023 19:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbjGJRNH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jul 2023 13:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjGJRNG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jul 2023 13:13:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52F910D;
        Mon, 10 Jul 2023 10:13:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8D1B721954;
        Mon, 10 Jul 2023 17:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689009184;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2RuwFg7Qt+lIFK9XLSCxEld3QsD6i2kbNJ5/TBXk/78=;
        b=jcE8bKuUh3ugJsbxHmwWMkGD7as0DV9IqJd2b1NBNnOJrmb9iN5GKBgGGl80UbkjehaSdr
        VyguTnvOlS/BWrnbCcXJH6HcTbeyK/JXooVU+89bm2Behf7vHRB2pXw7at0OIAx6QaILKq
        jvv5kNzTcHflZs5/gFtx3N01dqisBiY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689009184;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2RuwFg7Qt+lIFK9XLSCxEld3QsD6i2kbNJ5/TBXk/78=;
        b=yybNXXD7wO+Dl2AW1oVh+vgzNN6P/pww4EZlVVb1hgO5yr47NEr6vbh9VLw2NJfBiO0euE
        xfcu0b9+ynwjszCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 42DE913A05;
        Mon, 10 Jul 2023 17:13:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TXd3DyA8rGSJEAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 10 Jul 2023 17:13:04 +0000
Date:   Mon, 10 Jul 2023 19:06:29 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Anand Jain <anand.jain@oracle.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Changbin Du <changbin.du@intel.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: fix 64-bit division link failure
Message-ID: <20230710170629.GB30916@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230705140117.795478-1-arnd@kernel.org>
 <20230705140117.795478-2-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705140117.795478-2-arnd@kernel.org>
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

On Wed, Jul 05, 2023 at 04:01:09PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Some of the recent refactoring of the statfs code apparently
> brought back a link failure on older gcc versions that I had
> fixed before:
> 
> arm-linux-gnueabi-ld: fs/btrfs/super.o: in function `btrfs_statfs':
> super.c:(.text+0xec40): undefined reference to `__aeabi_uldivmod'
> 
> I think what happened is that gcc is free to not inline a function
> despite the 'inline' annotation, and when this happens it can end
> up partially inlining the div_u64() helper in a way that breaks the
> __builtin_constant_p() based optimization.
> 
> I only see this behavior for gcc-9, but it's possible that the same
> thing happens in later versions as well when the code changes again.

This is second fix to work around compiler assumptions and dependency
from other code, somehow this feels like the fix is being done in the
wrong place. Filesystem code using a number division helpers that are
supposed to abstract away 64bit division problems are as far as we
should go. Speculating about partial inlining or working/not-working
constant value detection maybe belongs to some highly optimized code but
not to a plain API usage.
