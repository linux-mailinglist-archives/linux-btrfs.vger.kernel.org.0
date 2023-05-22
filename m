Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E78F70BE6E
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 May 2023 14:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbjEVMgj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 May 2023 08:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbjEVMgQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 May 2023 08:36:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EA7F1
        for <linux-btrfs@vger.kernel.org>; Mon, 22 May 2023 05:35:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 630511FEC2;
        Mon, 22 May 2023 12:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684758022;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+HLOpd51YVJtj7NyJTS6XR8JwHtjHn5zir1PMJ1Sq/c=;
        b=F1WUtuMcNhUl7i71dblvyKaZL/uxJk2yHL1nFU0+55YZV+CBN7PLAW7gyudAk2zo/1gOeC
        amSoq9hojUVQ8LqDCCwGqQ0KFxF2Bh2Fo4tEWSKE2xkUFQ3xKNoatTurpQHE6oipZmyQ8z
        xEjfUAgERvf2maHq5HvZK7nkT+j0Yu4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684758022;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+HLOpd51YVJtj7NyJTS6XR8JwHtjHn5zir1PMJ1Sq/c=;
        b=Qad/VBTwilXyLjeoYVJ55mIDdnN7SGjWT9ZQhUD/dAYXCxvK+vxcsxUoxsdt2uv4Ow8aUH
        J82NokYrGIwvfoAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 39A6013776;
        Mon, 22 May 2023 12:20:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cbZSDQZea2S1UwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 22 May 2023 12:20:22 +0000
Date:   Mon, 22 May 2023 14:14:16 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/7] btrfs-progs: csum-change: add the initial support
 for offline csum type change
Message-ID: <20230522121416.GN32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1684375729.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1684375729.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 18, 2023 at 10:10:38AM +0800, Qu Wenruo wrote:
> [CHANGELOG]
> v2:
> - Skip csum item checks if the fs is under csum change
>   Tree-checker can be too sensitive if the csum size doesn not match the
>   old csum size, which can lead to false alerts on overlapping csum
>   items.
> 
>   But we still want the tree checker functionality overall, so just
>   disable csum item related checks for csum change.

I still see some errors with v2, the same test that rotates the checksum
types on an increasingly filled filesystem (the one I sent you before):

ERROR: failed to insert csum change item: File exists
ERROR: failed to generate new data csums: File exists
WARNING: reserved space leaked, flag=0x4 bytes_reserved=16384
extent buffer leak: start 610811904 len 16384
extent buffer leak: start 5242880 len 16384
WARNING: dirty eb leak (aborted trans): start 5242880 len 16384
