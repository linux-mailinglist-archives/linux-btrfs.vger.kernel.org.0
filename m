Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6E26F4851
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 May 2023 18:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbjEBQda (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 May 2023 12:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbjEBQdV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 May 2023 12:33:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4051704;
        Tue,  2 May 2023 09:33:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 38A751FD72;
        Tue,  2 May 2023 16:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683045196;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HeRC7fA+3/8mFjpHJeO1WUYCKgF1yF5CAMdTzrG/j2w=;
        b=dSWBZnCKa4vZUzaWrpjmiSSIgBE4YwQsNvc7/NhwpxCPI7tOcJ1c4XVc9oozntvTnDsuGo
        8DUzxtHUE+7Ch/r75a5aLIJHLIKmjre5Cx0PoASGEGBZrYMdixPduOC70KizqEt8K1Gi2d
        b0EjtdL/DLUoI3MA8w8ZOUteEnMI7Zs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683045196;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HeRC7fA+3/8mFjpHJeO1WUYCKgF1yF5CAMdTzrG/j2w=;
        b=lPMSlWW0Tq86aGrcMM1G9rp5Eh4NtdBs2yCT52DJqnzMyjuxhy9to5epIHXv5Mzx8+GtL5
        BZ8YF9VCqQx6uwBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E0217139C3;
        Tue,  2 May 2023 16:33:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PWDHNUs7UWQjRAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 02 May 2023 16:33:15 +0000
Date:   Tue, 2 May 2023 18:27:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Boris Burkov <boris@bur.io>, oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, ying.huang@intel.com,
        feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linus:master] [btrfs]  52bb7a2166:  filebench.sum_operations/s
 -4.0% regression
Message-ID: <20230502162720.GL8111@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <202304292249.93ef60fb-oliver.sang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202304292249.93ef60fb-oliver.sang@intel.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Apr 29, 2023 at 10:29:00PM +0800, kernel test robot wrote:
> 
> Hello,
> 
> kernel test robot noticed a -4.0% regression of filebench.sum_operations/s on:
> 
> 
> commit: 52bb7a2166af490317ce2cca1865b6630e86aca8 ("btrfs: introduce size class to block group allocator")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

The size classes are a heuristic, it may improve and worsen some
workloads and also depends on actual layout of extents and block groups.
So this is expected, -4% is within acceptable range.
