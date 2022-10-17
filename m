Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B04C600FCD
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Oct 2022 15:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiJQNDk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Oct 2022 09:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbiJQNDE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Oct 2022 09:03:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4883025D4
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 06:03:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F40D633B5B;
        Mon, 17 Oct 2022 13:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666011782;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EiuPic3uUx9D6nXRzQ0UuzWs376rbPGNcT5yekO2TR0=;
        b=SnzNit05ERQo7GnMl8HlpGp1bd6rgGZ4NDBnv8DrvxNeUiwxgoZiUxj7p5B/kFusnZwUaW
        oqka5FtS4RGaXf1KZYkHBq1dRk1u673MIUT2lXCRPGXLWzwqveBi/3FWRZ04LYBzNKMtOv
        HmtCLCO4qgktDAwtVYpAb2MW1D9d8iQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666011782;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EiuPic3uUx9D6nXRzQ0UuzWs376rbPGNcT5yekO2TR0=;
        b=0XmgzqVUVurNKO8PiKKuFH1/FgONIW3r5HyoLHes3/r1s4au1cmRd91037Kc3l6kVYq0Ol
        TykMSqXPUh4NhLAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D5D5D13ABE;
        Mon, 17 Oct 2022 13:03:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0zG3MoVSTWMgSAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 17 Oct 2022 13:03:01 +0000
Date:   Mon, 17 Oct 2022 15:02:52 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: question about the performance of 'btrfs send'
Message-ID: <20221017130252.GN13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20221015203501.E1ED.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221015203501.E1ED.409509F4@e16-tech.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Oct 15, 2022 at 08:35:01PM +0800, Wang Yugui wrote:
> Hi,
> 
> a question about the performance of 'btrfs send'.
> 
> The output speed of 'btrfs send' is about 700MiB/s in the 3 cases.
> 1) kernel 5.15.73 + 'btrfs send --proto 1'
> 2) kernel: 6.0.1(with btrfs-devel misc-6.1) +  'btrfs send --proto 1'
> 3) kernel: 6.0.1(with btrfs-devel misc-6.1) +  'btrfs send --proto 2'
> btrfs-progs: 6.0
> 
> the outut of 'perf report':
> Overhead  Command  Shared Object      Symbol
> *1  40.63%  btrfs    [kernel.kallsyms]  [k] __crc32c_le
> *2   9.97%  btrfs    [kernel.kallsyms]  [k] memcpy_erms
> *3   9.25%  btrfs    [kernel.kallsyms]  [k] send_extent_data
> *4   5.40%  btrfs    [kernel.kallsyms]  [k] asm_exc_nmi
> *5   2.73%  btrfs    [kernel.kallsyms]  [k] __alloc_pages
>    1.14%  btrfs    [kernel.kallsyms]  [k] __rmqueue_pcplist
>    0.92%  btrfs    [kernel.kallsyms]  [k] bad_range
>    0.88%  btrfs    [kernel.kallsyms]  [k] get_page_from_freelist
> 
> What I expected:
> the above *1) __crc32c_le take >60%, and the outut speed > 1GiB/s.
> The *1) __crc32c_le is necessary operation, and the speed
> seems OK.  2GB/s * 40% = 800MiB/s, it is close to 700MiB/s.
> 
> Question:
> The above *3) is difficult to understand. Any advice?

The perf report does not include IO, right? It's only CPU time spent.
That it's accounted only for send_extent_data would also mean there's
some function inlining involved so it does not point exactly where the
time is spent. I'd say it's the main loop around send_write that emits
the commands and works with memory data.

What could be suboptimal is the call get_cur_path in send_write that
rebuilds the path each time even though it's for the same file.
