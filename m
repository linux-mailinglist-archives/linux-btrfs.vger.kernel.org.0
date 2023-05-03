Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40176F54C8
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 11:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjECJcu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 May 2023 05:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjECJcp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 May 2023 05:32:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E06420B
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 02:32:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E77A6201B1;
        Wed,  3 May 2023 09:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683106354;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vJaRJT1ieemBAFSB9I4nCcsB5loyBvvvgxgULqpQoHo=;
        b=r1wpr1WrlTQYVVxkG7XHfzS9g3Z2QZhAS7kgrMu0gH+Aj+SUS373UqeGjN2zv1+6F9F4mY
        SNn7gzz5QIvcZsGK/gum4yKOT4ptZ6yNCvhGuSkqLGH32oHC36yro78SikatOeM2j3aIbV
        pfDigYEvVYl26DVedNR+8sVswJYigiA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683106354;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vJaRJT1ieemBAFSB9I4nCcsB5loyBvvvgxgULqpQoHo=;
        b=bJhA+DgartBHjSRQIX4BdkOLGk4pFCugQWF9zDE16uu7WkzYOUBll93peii4Ju3Pipm+3Y
        F3MWJ8pJzzgeesCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BAC491331F;
        Wed,  3 May 2023 09:32:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4jTOLDIqUmQpFwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 03 May 2023 09:32:34 +0000
Date:   Wed, 3 May 2023 11:26:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/8] btrfs-progs: sync basic code from the kernel
Message-ID: <20230503092639.GT8111@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1681938911.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1681938911.git.josef@toxicpanda.com>
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

On Wed, Apr 19, 2023 at 05:17:11PM -0400, Josef Bacik wrote:
> Hello,
> 
> This series copies the easier to sync files from the kernel into btrfs-progs and
> updates all the users to include the appropriate headers.  There's an extra
> change in here to deal with va_format, which we'll need for future syncs.  I put
> it in here because it's related to the messages sync, so it seemed appropriate.
> 
> This depends on the series
> 
>  btrfs-progs: prep work for syncing files into kernel-shared
> 
> Thanks,
> 
> Josef
> 
> Josef Bacik (8):
>   btrfs-progs: sync uapi/btrfs.h into btrfs-progs
>   btrfs-progs: sync ondisk definitions from the kernel
>   btrfs-progs: sync messages.* from the kernel
>   btrfs-progs: add struct va_format support to our btrfs_no_printk
>     helper
>   btrfs-progs: sync accessors.[ch] from the kernel
>   btrfs-progs: sync file-item.h into progs
>   btrfs-progs: sync async-thread.[ch] from the kernel
>   btrfs-progs: sync extent-io-tree.[ch] and misc.h from the kernel

Added to devel, thanks. There were random compilation problems due to
the paths or missing forward declarations. I did only minimal changes to
make it build, we'll need to do another pass once all the patches land.
