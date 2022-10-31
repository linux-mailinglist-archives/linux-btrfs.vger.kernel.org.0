Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9216138E4
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Oct 2022 15:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbiJaOYM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Oct 2022 10:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbiJaOYL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Oct 2022 10:24:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E82EC04;
        Mon, 31 Oct 2022 07:24:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D7C9E22CEC;
        Mon, 31 Oct 2022 14:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667226248;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l6ZBtYwIEqSS/WVwqwtcl27nEMPkHYL68oG1bMw5MCM=;
        b=tYe/sofVRIcZGvG4tCulhIOYw/tWmcgq29wEu9HbCqMAvuQv4P+D7XTFVfNW3XRkjJ0Xp0
        vcLt/7NWjsUZB0yZYzsmJT3KOTOzDCqun2FGqIYpiUAJLY/vaoE11vy7U6u8EuVBgmtEbd
        4YOa5qIfyW9n5j/WDAhFFYZqJ3gWyfI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667226248;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l6ZBtYwIEqSS/WVwqwtcl27nEMPkHYL68oG1bMw5MCM=;
        b=HkQLuSxAuJz+FMxDcjnRQG1Rt6mzcGjclK2BoigEo22GqdtDQGxqPPiibOxJmsxE3Mqimu
        sJq/mAbR6jNyMrCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 87A7E13451;
        Mon, 31 Oct 2022 14:24:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lIcoIIjaX2NZeAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 31 Oct 2022 14:24:08 +0000
Date:   Mon, 31 Oct 2022 15:23:51 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     syzbot <syzbot+8edfa01e46fd9fe3fbfb@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, clm@fb.com, dsterba@suse.com,
        hch@lst.de, josef@toxicpanda.com, linmiaohe@huawei.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org
Subject: Re: [syzbot] WARNING in btrfs_space_info_update_bytes_may_use
Message-ID: <20221031142351.GA5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <0000000000000d9d6f05ec498263@google.com>
 <000000000000fa42c105ec5339ec@google.com>
 <Y1/SqIuP4tbszPAW@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1/SqIuP4tbszPAW@casper.infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 31, 2022 at 01:50:32PM +0000, Matthew Wilcox wrote:
> Dmitry, I don't see a way to tell syzbot that its bisection has gone
> astray.  Can you add one or document it if it already exists?
> 
> On Mon, Oct 31, 2022 at 04:51:22AM -0700, syzbot wrote:
> > syzbot has bisected this issue to:
> > 
> > commit 0c7c575df56b957390206deb018c41acbb412159
> > Author: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Date:   Wed Feb 24 20:01:52 2021 +0000
> > 
> >     mm/filemap: remove dynamically allocated array from filemap_read
> 
> This change affects the read path.  The crash happens in the unmount
> path.  The data structure that's being checked is modified in the write
> path.  I just can't see how this commit is in any way related.

Yeah I agree the bisection hasn't identified the correct commit.

> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=119e21b6880000
> > start commit:   b229b6ca5abb Merge tag 'perf-tools-fixes-for-v6.1-2022-10-..

The starting commit is not related to btrfs but the bisection hit the
warning basically on each run so it's not completely random. There might
be some timing change that triggers the warning, likely it's caused by
some the space accounting bug.
