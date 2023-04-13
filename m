Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8ACE6E107E
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Apr 2023 16:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjDMO6J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Apr 2023 10:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjDMO6I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Apr 2023 10:58:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B85AD15;
        Thu, 13 Apr 2023 07:57:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 922D71FD67;
        Thu, 13 Apr 2023 14:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681397875;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rSBNwC+d8u++QC7Mbtf4PYXIAx/WzXjSXOiex9i0Dac=;
        b=sB0vCCftw4cl4Ats2mQZGf5nBVTppwKw30G0zJnipUc171sKoxr1L5pAtdOGnFO3h9jeCY
        5v/UW2rXLiBh9WzflNbmyXgldffGeFl72pMxwqYxmNXb6h3wU/Wicq5cCTOwzQDmVdtmGI
        8G4SXlh/8wGkIvqZGJTSheiKUKAsAgY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681397875;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rSBNwC+d8u++QC7Mbtf4PYXIAx/WzXjSXOiex9i0Dac=;
        b=wlBpsaltwsBaXEAyWtiJ0Ac8dPuzxHmvtS7diwcDjNcKB9tTcnMyvzY6jYw88KEOL43kfo
        06a0jpJohtmU+4Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3EF811390E;
        Thu, 13 Apr 2023 14:57:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vQ9bDnMYOGTpSgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 13 Apr 2023 14:57:55 +0000
Date:   Thu, 13 Apr 2023 16:57:48 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>, linux-btrfs@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-scsi@vger.kernel.org, linux-hyperv@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 08/11] btrfs: Mark btrfs_assertfail() __noreturn
Message-ID: <20230413145748.GF19619@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1681342859.git.jpoimboe@kernel.org>
 <960bd9c0c9e3cfc409ba9c35a17644b11b832956.1681342859.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <960bd9c0c9e3cfc409ba9c35a17644b11b832956.1681342859.git.jpoimboe@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 12, 2023 at 04:49:38PM -0700, Josh Poimboeuf wrote:
> Fixes a bunch of warnings including:
> 
>   vmlinux.o: warning: objtool: select_reloc_root+0x314: unreachable instruction
>   vmlinux.o: warning: objtool: finish_inode_if_needed+0x15b1: unreachable instruction
>   vmlinux.o: warning: objtool: get_bio_sector_nr+0x259: unreachable instruction
>   vmlinux.o: warning: objtool: raid_wait_read_end_io+0xc26: unreachable instruction
>   vmlinux.o: warning: objtool: raid56_parity_alloc_scrub_rbio+0x37b: unreachable instruction
>   ...
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202302210709.IlXfgMpX-lkp@intel.com/
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

I'll add this one to btrfs queue, thanks.
