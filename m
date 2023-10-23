Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB58A7D3866
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Oct 2023 15:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjJWNtA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Oct 2023 09:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjJWNs6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Oct 2023 09:48:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66ADE4
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Oct 2023 06:48:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 91BB521AD3;
        Mon, 23 Oct 2023 13:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698068935;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TzjixHljhP0z6Va8eRliked44Degft4Y2vEpnjiqiYs=;
        b=0vz4WC5Y2mq9C3IIfUxfG2ebW+04NnHigdkN4q67qgaKwvdPTGaGQpzC59+VNkT4qvpRv4
        YOhhZkb+ysCmZJ4TwOdwsqv35opY1mqpSE9wHkbEszvfiEMOTmK8Y32q/a2xITFwMBh67n
        IIF0dX3R5+VTq7lCKe9oQgP/aeCrXsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698068935;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TzjixHljhP0z6Va8eRliked44Degft4Y2vEpnjiqiYs=;
        b=7N1tQb9wvqv7FRP3aQw58luydkMkcM7Ph4lyWzxDVkjzUBE4b+sB02AxXP8qiY0JRzPWoX
        sDOZ3AZZ2cMr7MDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6855D132FD;
        Mon, 23 Oct 2023 13:48:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mmeXGMd5NmVBWgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 23 Oct 2023 13:48:55 +0000
Date:   Mon, 23 Oct 2023 15:42:02 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs-progs: follow-ups for issue #622
Message-ID: <20231023134202.GH26353@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1697945679.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697945679.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -6.45
X-Spamd-Result: default: False [-6.45 / 50.00];
         ARC_NA(0.00)[];
         HAS_REPLYTO(0.30)[dsterba@suse.cz];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         REPLYTO_ADDR_EQ_FROM(0.00)[];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_TWO(0.00)[2];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-2.65)[98.44%]
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Oct 22, 2023 at 02:10:06PM +1030, Qu Wenruo wrote:
> Issue #622 is a very interesting bug report, that ntfs2btrfs has a fixed
> bug that it can generate out-of-order inline backref items.
> 
> This leads to kernel transaction abort, but btrfs-check failed to detect
> it at all.
> 
> Although the fix for btrfs-progs is already merged in the latest v6.5.3
> release, we still lacks the following thing:
> 
> - Better dump-tree support to show the weird inline backref order
>   This is very weird, as we have the inline type in ascending order,
>   but for the sequence number (hash for EXTENT_DATA_REF, offset for all
>   other types) it is descending inside the same type.
> 
>   That's why the following output of one data extent item looks
>   out-of-order:
> 
> 	item 0 key (13631488 EXTENT_ITEM 4096) itemoff 16143 itemsize 140
> 		refs 4 gen 7 flags DATA
> 		extent data backref root FS_TREE objectid 258 offset 0 count 1
> 		extent data backref root FS_TREE objectid 257 offset 0 count 1
> 		extent data backref root FS_TREE objectid 260 offset 0 count 1
> 		extent data backref root FS_TREE objectid 259 offset 0 count 1
> 
> - Lowmem mode support to detect the error
> 
> - Test case to make sure we can detect the error
> 
> This series would address all the three points above.
> 
> Qu Wenruo (3):
>   btrfs-progs: dump-tree: output the sequence number for inline
>     references
>   btrfs-progs: check/lowmem: verify the sequence of inline backref items
>   btrfs-progs: fsck-tests: add test image of out-of-order inline backref
>     items

Thanks, added to misc-next. We can add ntfs2btrfs conversion tests to
btrfs-progs, either with the external utility or on-demand build from git.
