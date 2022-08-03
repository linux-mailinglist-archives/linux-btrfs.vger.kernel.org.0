Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18405588D81
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Aug 2022 15:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236139AbiHCNpj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Aug 2022 09:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiHCNpi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Aug 2022 09:45:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E42C5F47;
        Wed,  3 Aug 2022 06:45:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E43F9400BE;
        Wed,  3 Aug 2022 13:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659534335;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=akp1pNQEiXkOGeo4BViAGmqcuddhmRP3JLmV9s8Jl30=;
        b=X2G0jJi1PM5voo71dPWDflfqa+/6EF7wfOcwNxDI+kawn2SHTL39NxngM8de4U6PkAhu/y
        KpbSrgZfB3DLXfNjJlX3sRKlsYB875Jzg71y6CJgp42J6mJh5wCRKEirky86UJVsb5C/3l
        tFQiVsEBfXBuKvknaPtIQVHQoC2kqO0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659534335;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=akp1pNQEiXkOGeo4BViAGmqcuddhmRP3JLmV9s8Jl30=;
        b=/0Ob9r/t/uNjK4UfEGtcaSYFnM351yM09euQxQwh7QlaExjLrFGlFM+suKMA7O2q8T8UQ+
        wihK1T3bcovbV2Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A199E13A94;
        Wed,  3 Aug 2022 13:45:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5ziHJv976mJ1BwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 03 Aug 2022 13:45:35 +0000
Date:   Wed, 3 Aug 2022 15:40:33 +0200
From:   David Sterba <dsterba@suse.cz>
To:     alexlzhu@fb.com
Cc:     kernel-team@fb.com, linux-mm@kvack.org, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] btrfs: fix alginment of VMA for memory mapped files
 on THP
Message-ID: <20220803134033.GG13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, alexlzhu@fb.com, kernel-team@fb.com,
        linux-mm@kvack.org, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220802203246.434560-1-alexlzhu@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802203246.434560-1-alexlzhu@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 02, 2022 at 01:32:46PM -0700, alexlzhu@fb.com wrote:
> From: Alexander Zhu <alexlzhu@fb.com>
> 
> With CONFIG_READ_ONLY_THP_FOR_FS, the Linux kernel supports using THPs for
> read-only mmapped files, such as shared libraries. However, the kernel
> makes no attempt to actually align those mappings on 2MB boundaries,
> which makes it impossible to use those THPs most of the time. This issue
> applies to general file mapping THP as well as existing setups using
> CONFIG_READ_ONLY_THP_FOR_FS. This is easily fixed by using
> thp_get_unmapped_area for the unmapped_area function in btrfs, which
> is what ext2, ext4, fuse, and xfs all use.
> 
> Initially btrfs had been left out in Commit 8c07fc452ac0 ("btrfs: fix
> alginment of VMA for memory mapped files on THP") as btrfs does not support
> DAX. However, Commit 1854bc6e2420 ("mm/readahead: Align file mappings
> for non-DAX") removed the DAX requirement. We should now be able to call
> thp_get_unmapped_area() for btrfs.
> 
> The problem can be seen in /proc/PID/smaps where THPeligible is set to 0
> on mappings to eligible shared object files as shown below.
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
> Signed-off-by: Alexander Zhu <alexlzhu@fb.com>

Added to misc-next, thanks.
