Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4151C56BDEE
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Jul 2022 18:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238623AbiGHPZt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Jul 2022 11:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238099AbiGHPZs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Jul 2022 11:25:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FF630F71
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Jul 2022 08:25:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 43256220F5;
        Fri,  8 Jul 2022 15:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657293946;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dHmK+do5APd6NYBUiitHYEf08Zo6cOY3UwB4uXBZMCc=;
        b=uuqDoO6OgOdqTxRCxNY0Pz2aAMXZeqrDOKRon2Pgxu7tmi2ZVVSzN4yk4pto/8LzB5NsE6
        xpvvkFzcye4sS3rQm6oDcVka/zEMm1IjvNJ6BKQsasoyMI4McjkjNQ82xNeU6SwZJQ+LYh
        nG1doSvtkogWycpFGANdXAKtuCIQ/aU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657293946;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dHmK+do5APd6NYBUiitHYEf08Zo6cOY3UwB4uXBZMCc=;
        b=phtmcqu4DhcIniOwCjhPJFWbXwLbSQ1c5rK4NygDYzcN+LtAFjfsTWpRs6+EXbnjjmGwrj
        8hjfwGWdSLqlq7Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 20C0513A80;
        Fri,  8 Jul 2022 15:25:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gXRjBnpMyGLZcQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 08 Jul 2022 15:25:46 +0000
Date:   Fri, 8 Jul 2022 17:20:58 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: a few direct IO fixes/improvements
Message-ID: <20220708152058.GV15169@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <cover.1656934419.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1656934419.git.fdmanana@suse.com>
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

On Mon, Jul 04, 2022 at 12:42:02PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Several fixes and improvements regarding direct IO, with the first one being
> recently reported by Dominique when using qemu with io_uring on images that
> have a mix of compressed and non-compressed extents. That in particular
> exposed a bug in qemu's handling of partial reads, fixed recently by
> Dominique, but despite that we could avoid returning a partial read when
> there's really no need to, not just for efficiency but also because many
> applications don't take into consideration partial reads (MariaDB for
> example didn't use to until recently) or are buggy dealing with them.
> More details in the changelogs.
> 
> Filipe Manana (3):
>   btrfs: return -EAGAIN for NOWAIT dio reads/writes on compressed and
>     inline extents
>   btrfs: don't fallback to buffered IO for NOWAIT direct IO writes
>   btrfs: fault in pages for dio reads/writes in a more controlled way

The first patch was already in misc-next, I've compared the code and
briefly the changelog and it looked exactly the same so I've kept the
patch, 2 and 3 added to misc-next. Thanks.
