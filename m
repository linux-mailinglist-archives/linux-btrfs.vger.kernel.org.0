Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99AF857A3C6
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jul 2022 17:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239572AbiGSP4I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jul 2022 11:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239646AbiGSP4B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jul 2022 11:56:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895125A8AD
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jul 2022 08:55:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E77C0208DF;
        Tue, 19 Jul 2022 15:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658246154;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GDqP+dKPCMwJdXyK/kNnmWBISc8Gzd4sEk9SZh2HFv8=;
        b=xV2LLPlvgUqvGl9Rn6mxbb0h7obbOzEMBfqXHFDOn8ixOvuK5TOU26Nse4gWU1bSHBkPyQ
        dSYQ4HJf8PnRlEsmt8MWS+Q5kzpba2sQ6Wj/CW0Gs3tR3Ih8RKDpUme23IqyrSz99Zh6/d
        7pK2UcGG1UDL3poQnj0HNdOTb+4Oe0E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658246154;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GDqP+dKPCMwJdXyK/kNnmWBISc8Gzd4sEk9SZh2HFv8=;
        b=d+N61FCIOSeLoXqWEAFsn7oLzbfsLsJ42mP4RNyOp08norY/EpGDuOc5+E6CAu50I8QhvU
        8xIR9jx/rn18daAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C68BE13A72;
        Tue, 19 Jul 2022 15:55:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oRZ9LwrU1mKTHgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 19 Jul 2022 15:55:54 +0000
Date:   Tue, 19 Jul 2022 17:51:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: make btrfs_super_block::log_root_transid
 deprecated
Message-ID: <20220719155101.GP13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <ad5b8dbe66567eddd09025cf46114cc9412d1add.1654603274.git.wqu@suse.com>
 <20220718153410.GF13489@twin.jikos.cz>
 <03436e26-8408-6771-2f13-d4bbdbd99b7a@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03436e26-8408-6771-2f13-d4bbdbd99b7a@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 19, 2022 at 09:31:28AM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/7/18 23:34, David Sterba wrote:
> > On Tue, Jun 07, 2022 at 08:01:17PM +0800, Qu Wenruo wrote:
> >> This is the same on-disk format update synchronized from the kernel
> >> code.
> >>
> >> Unlike kernel, there are two callers reading this member:
> >>
> >> - btrfs inspect dump-super
> >>    It's just outputting the value, since it's always 0 we can skip
> >>    that output.
> >>
> >> - btrfs-find-root
> >>    In that case, since we always got 0, the root search for log root
> >>    should never find a perfect match.
> >>
> >>    Use btrfs_super_geneartion() + 1 to provide a better result.
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> > 
> > Added to devel, thanks.
> > 
> >> --- a/kernel-shared/print-tree.c
> >> +++ b/kernel-shared/print-tree.c
> >> @@ -2014,8 +2014,6 @@ void btrfs_print_superblock(struct btrfs_super_block *sb, int full)
> >>   	       (unsigned long long)btrfs_super_chunk_root_level(sb));
> >>   	printf("log_root\t\t%llu\n",
> >>   	       (unsigned long long)btrfs_super_log_root(sb));
> >> -	printf("log_root_transid\t%llu\n",
> >> -	       (unsigned long long)btrfs_super_log_root_transid(sb));
> > 
> > For dump super I'd like to keep it there, same as we print the value of
> > leafsize even if it's deprecated.
> 
> In that case, we only need add "(deprecated)" to the string and adjust 
> the offset.
> 
> Do I need to update the patch or send a incremental update?

No need to, it was a simple fixup.
