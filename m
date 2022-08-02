Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377205881B9
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Aug 2022 20:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbiHBSLa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Aug 2022 14:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237846AbiHBSLJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Aug 2022 14:11:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD0517E1C;
        Tue,  2 Aug 2022 11:11:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A8F3F381C5;
        Tue,  2 Aug 2022 18:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659463864;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pz4nohXMnV6DoQDiLTQldnM+q/whU1JUDeaFPyIhZ1g=;
        b=qbwOAxE67O43QdxlU3BgVNMFcqw+bIAks9zkzBZrdIt+p9QtP3Fv7xMPLaENAdVp7Aedx9
        XzoRSqRbgRcLUXbFDFMud/GksDdqcgMn+9twIIJ4cRQFVh+siuSiTKL0Shqw/NSsGMSWNj
        Sj0WJF2iodrQNqR8K7qbSku3yKszI1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659463864;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pz4nohXMnV6DoQDiLTQldnM+q/whU1JUDeaFPyIhZ1g=;
        b=B3fB4DC8HPOsEVk5KmGSn/lYbNT4tRMJqrUYo2XAEFOxE+jYElYC0WLOUq4qB59SfGVsCj
        5wjm/c5z7w+cjuBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6C8841345B;
        Tue,  2 Aug 2022 18:11:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LWGzGbho6WJzTgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 02 Aug 2022 18:11:04 +0000
Date:   Tue, 2 Aug 2022 20:06:02 +0200
From:   David Sterba <dsterba@suse.cz>
To:     alexlzhu@fb.com
Cc:     kernel-team@fb.com, linux-mm@kvack.org, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: fix alginment of VMA for memory mapped files on
 THP
Message-ID: <20220802180602.GX13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, alexlzhu@fb.com, kernel-team@fb.com,
        linux-mm@kvack.org, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220801184740.2134364-1-alexlzhu@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801184740.2134364-1-alexlzhu@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 01, 2022 at 11:47:40AM -0700, alexlzhu@fb.com wrote:
> From: alexlzhu <alexlzhu@fb.com>
> 
> With CONFIG_READ_ONLY_THP_FOR_FS, the Linux kernel supports using THPs for
> read-only mmapped files, such as shared libraries. However, the
> kernel makes no attempt to actually align those mappings on 2MB boundaries,
> which makes it impossible to use those THPs most of the time. This issue
> applies to general file mapping THP as well as existing setups using
> CONFIG_READ_ONLY_THP_FOR_FS. This is easily fixed by using
> thp_get_unmapped_area for the unmapped_area function in btrfs, which is
> what ext2, ext4, fuse, and xfs all use.

Commit dbe6ec815641 ("ext2/4, xfs: call thp_get_unmapped_area() for pmd
mappings") adds the callback for DAX, that btrfs does not support so it
was left out.

> The problem can be seen in
> /proc/PID/smaps where THPeligible is set to 0 on mappings to eligible
> shared object files as shown below.
> 
> Before this patch:
> 
> 7fc6a7e18000-7fc6a80cc000 r-xp 00000000 00:1e 199856
> /usr/lib64/libcrypto.so.1.1.1k
> Size:               2768 kB
> THPeligible:    0
> VmFlags: rd ex mr mw me
> 
> With this patch the library is mapped at a 2MB aligned address:
> 
> fbdfe200000-7fbdfe4b4000 r-xp 00000000 00:1e 199856
> /usr/lib64/libcrypto.so.1.1.1k
> Size:               2768 kB
> THPeligible:    1
> VmFlags: rd ex mr mw me
> 
> This fixes the alignment of VMAs for any mmap of a file that has the
> rd and ex permissions and size >= 2MB. The VMA alignment and
> THPeligible field for anonymous memory is handled separately and
> is thus not effected by this change.
> 
> Signed-off-by: alexlzhu <alexlzhu@fb.com>

Please use full name for signed-off.

Also the subject should start with "btrfs:", this is not a memory
management patch. Thanks.
