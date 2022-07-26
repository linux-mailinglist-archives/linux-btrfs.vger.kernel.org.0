Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E268581B93
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jul 2022 23:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbiGZVHr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jul 2022 17:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiGZVHr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jul 2022 17:07:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBE5327
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jul 2022 14:07:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 216C734FD9;
        Tue, 26 Jul 2022 21:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658869665;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yMksGq4btginZ99oRqzYU5RIz6mgYjD4NYyjQZxKKMg=;
        b=bg++NWG+Q66ZpSeuLxAoku0/JUfhWpcvCNRnbPc/s1idISRT5Jby/IdasnjKsZKg6O+Iv7
        M/MuiN9JD53QCQWD8LF9cB8zJay7vFO1rJDn2dnfzH0GGgErPKRaC1b63X0EuLoguEB0Oh
        Wey0G0ZkzyGGiGMUY+Rx0HD3jTjkunw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658869665;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yMksGq4btginZ99oRqzYU5RIz6mgYjD4NYyjQZxKKMg=;
        b=XL7GDWfT/jGPzAdlDZKs9zQZuC4jhRMpO6biSQdjW7rO44GsVluGAh1z34YdPo9enHKhfv
        gG7vTwWxWp0cxkAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E6F0413322;
        Tue, 26 Jul 2022 21:07:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kmnhNqBX4GILTwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 26 Jul 2022 21:07:44 +0000
Date:   Tue, 26 Jul 2022 23:02:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Rich Rauenzahn <rrauenza@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Combining two filesystems into single pool
Message-ID: <20220726210247.GN13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Rich Rauenzahn <rrauenza@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAG+QAKUu6TXJqoq=eQczE+CWJCL06bN8oymbSFQVCzXto+fzyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG+QAKUu6TXJqoq=eQczE+CWJCL06bN8oymbSFQVCzXto+fzyQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 26, 2022 at 01:32:22PM -0700, Rich Rauenzahn wrote:
> I've spent a little while trying to google for this and haven't seem
> to hit the right keywords yet or it just isn't possible.
> 
> I have two btrfs filesystems.  These are independent filesystems with
> mutually exclusive sets of disks.  RAID1, if that matters.
> 
> They are mounted on / -- let's say /A and /B.
> 
> I'd like to combine the disks into a single filesystem.  These file
> systems are large, so creating a third filesystem and merging them is
> not practical, nor is copying /B onto /A.
> 
> Could I, say, move /A to a subvolume A in itself and then permanently
> "connect" /B as a subvolume B, putting all the disks into a single
> pool?  And then mount the two subvolumes as /A and /B?
> 
> I'd swear I'd seen instructions on how to combine filesystem pools
> before, but I can't find it again.

I'm curious how it would be possible, using btrfs means and not eg.
overlayfs or other meta filesystem providing single view into more
filesystems.

Each fielsystem is using a different number (subvolume id, inode) space,
there's no way to join two into one directly. Some transofrmation or
translation is needed and there's no such feature provided by btrfs.
Theoretically it would be possible to implement, renumbering subvolumes
so they don't collide, add chunk mappings from one filesystem to
devices of the other and merge the directory structures.

Otherwise I see only the options you don't want, copying or 3rd
filesystem. You could do some tricks with deleting device from A and
adding it to B, move some data and repeat.
