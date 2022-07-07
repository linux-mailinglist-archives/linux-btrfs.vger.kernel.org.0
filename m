Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6146256AE3B
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Jul 2022 00:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236915AbiGGWR3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Jul 2022 18:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236973AbiGGWRX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Jul 2022 18:17:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748476069A;
        Thu,  7 Jul 2022 15:17:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BEE9D1FE4F;
        Thu,  7 Jul 2022 22:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657232238;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NQHmVjONVW9HBKDyRt/r720zRRw/7ufnQWCuHyx0tgU=;
        b=AMLeYp46gfvG5OYYxmSHWOSsVg611S1x9HIxx7i+TiQtZPqjK2maEGSUNwIj/8obkAs562
        OWF3HprbsH9qOre8WT3mc3sEyZpJnU9XWg00WpuULWoTPQI6yg5Turmn189fxjet5IkYMX
        CrpP8iAff/ueR9FinnanBd2Bd0ZETEQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657232238;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NQHmVjONVW9HBKDyRt/r720zRRw/7ufnQWCuHyx0tgU=;
        b=m4FLEyUovO/d2M2Y+OmpP71OLh3JnFbHASJneI4PmA085VBRoatYjaKxq1b/EMn+MhkxMh
        nQihNDqak0uDA9Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5E63A13461;
        Thu,  7 Jul 2022 22:17:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NUQBFm5bx2ImXwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 07 Jul 2022 22:17:18 +0000
Date:   Fri, 8 Jul 2022 00:12:31 +0200
From:   David Sterba <dsterba@suse.cz>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Nick Terrell <terrelln@fb.com>, linux-btrfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "James E. J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        John David Anglin <dave.anglin@bell.net>,
        linux-parisc@vger.kernel.org
Subject: Re: [PATCH v6 0/2] btrfs: Replace kmap() with kmap_local_page() in
 zstd.c
Message-ID: <20220707221231.GS15169@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, Nick Terrell <terrelln@fb.com>,
        linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "James E. J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        John David Anglin <dave.anglin@bell.net>,
        linux-parisc@vger.kernel.org
References: <20220706111520.12858-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706111520.12858-1-fmdefrancesco@gmail.com>
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

On Wed, Jul 06, 2022 at 01:15:18PM +0200, Fabio M. De Francesco wrote:
> This is a little series which serves the purpose to replace kmap() with
> kmap_local_page() in btrfs/zstd.c. Actually this task is only accomplished
> in patch 2/2.
> 
> Instead patch 1/2 is a pre-requisite for the above-mentioned replacement,
> however, above all else, it has the purpose to conform the prototypes of
> __kunmap_{local,atomic}() to their own correct semantics. Since those
> functions don't make changes to the memory pointed by their arguments,
> change the type of those arguments to become pointers to const void.
> 
> v5 -> v6: Delete an unnecessary assignment in 2/2 (thanks to Ira Weiny).
> 
> v4 -> v5: Use plain page_address() for pages which cannot come from Highmem
> (instead of kmapping them); remove unnecessary initializations to NULL
> in 2/2 (thanks to Ira Weiny).
> 
> v3 -> v4: Resend and add linux-mm to the list of recipients (thanks to
> Andrew Morton).
> 
> Fabio M. De Francesco (2):
>   highmem: Make __kunmap_{local,atomic}() take "const void *"
>   btrfs: Replace kmap() with kmap_local_page() in zstd.c

Added to the kmap patch queue, thanks. With all the other conversion
there are 5 patches

  highmem: Make __kunmap_{local,atomic}() take const void pointer
  btrfs: zstd: replace kmap() with kmap_local_page()
  btrfs: zlib: replace kmap() with kmap_local_page() in zlib_compress_pages()
  btrfs: zlib: replace kmap() with kmap_local_page() in zlib_decompress_bio()
  btrfs: replace kmap_atomic() with kmap_local_page()

and there are no kmap or kmap_atomic left in fs/btrfs, scheduled for 5.20.
