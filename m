Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3048D730503
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jun 2023 18:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbjFNQfY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jun 2023 12:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235022AbjFNQen (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jun 2023 12:34:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA29213A
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jun 2023 09:34:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EB8E71FDBD;
        Wed, 14 Jun 2023 16:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686760460;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HF4E8J9ndJaNtn5Ip7CfjE21fTRjhNEE9n8kGfsziug=;
        b=01Mjk+cMicRx1tUnihnlebAZtahBGsCWZWHo09JGJRfI4nydFp7Cy/9LxMi1zlApCm5o1r
        QyINzW7/xbg0GRz/+H/Du17dmkRh18LiAd+B5XCgBT6RrhaTn0Ugso3wTd1ZrixzoVi8bK
        p+tx8aJoKItnyh07abDEhEvZ+uG2xvk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686760460;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HF4E8J9ndJaNtn5Ip7CfjE21fTRjhNEE9n8kGfsziug=;
        b=l/0yA5LCH5mO9aCeXFdvaDi7B0bVBkRKv/KOeddViaOCW3roZzdR2h0QpCV0aINu7OvPzP
        z04WkxlhwyiDnRCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BE99C1391E;
        Wed, 14 Jun 2023 16:34:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xg7ILQzsiWSEOgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 14 Jun 2023 16:34:20 +0000
Date:   Wed, 14 Jun 2023 18:28:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: fix accessors for big endian systems
Message-ID: <20230614162801.GL13486@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <55b1841a271b69b8047f1195eeb26fb23f893f71.1686738215.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55b1841a271b69b8047f1195eeb26fb23f893f71.1686738215.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 14, 2023 at 06:23:43PM +0800, Qu Wenruo wrote:
> [BUG]
> There is a bug report from the github issues, that on s390x big endian
> systems, mkfs.btrfs just fails:
> 
>  $ mkfs.btrfs  -f ~/test.img
>  btrfs-progs v6.3.1
>  Invalid mapping for 1081344-1097728, got 17592186044416-17592190238720
>  Couldn't map the block 1081344
>  ERROR: cannot read chunk root
>  ERROR: open ctree failed
> 
> [CAUSE]
> The error is caused by wrong endian conversion.
> 
> The system where Fedora guys reported errors are using big endian:
> 
>  $ lscpu
>  Byte Order:            Big Endian
> 
> While checking the offending @disk_key and @key inside
> btrfs_read_sys_array(), we got:
> 
>  2301		while (cur_offset < array_size) {
>  (gdb)
>  2304			if (cur_offset + len > array_size)
>  (gdb)
>  2307			btrfs_disk_key_to_cpu(&key, disk_key);
>  (gdb)
>  2310			sb_array_offset += len;
>  (gdb) print *disk_key
>  $2 = {objectid = 281474976710656, type = 228 '\344', offset = 17592186044416}
>  (gdb) print key
>  $3 = {objectid = 281474976710656, type = 228 '\344', offset = 17592186044416}
>  (gdb)
> 
> Now we can see, @disk_key is indeed in the little endian, but @key is
> not converted to the CPU native endian.
> 
> Furthermore, if we step into the help btrfs_disk_key_to_cpu(), it shows
> we're using little endian version:
> 
>  (gdb) step
>  btrfs_disk_key_to_cpu (disk_key=0x109fcdb, cpu_key=0x3ffffff847f)
>      at ./kernel-shared/accessors.h:592
>  592		memcpy(cpu_key, disk_key, sizeof(struct btrfs_key));
> 
> [FIX]
> The kernel accessors.h checks if __LITTLE_ENDIAN is defined or not, but
> that only works inside kernel.
> 
> In user space, __LITTLE_ENDIAN and __BIG_ENDIAN are both defined inside
> <bit/endian.h> header.
> 
> Instead we should check __BYTE_ORDER against __LITTLE_ENDIAN to
> determine our endianness.
> 
> With this change, s390x build works as expected now.
> 
> Issue: #639
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks.
