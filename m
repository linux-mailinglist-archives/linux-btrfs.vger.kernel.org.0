Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD8B7D5C0B
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Oct 2023 22:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344332AbjJXUBB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Oct 2023 16:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344333AbjJXUBA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Oct 2023 16:01:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB5710C9
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Oct 2023 13:00:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4BAFA1FEB2;
        Tue, 24 Oct 2023 20:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698177652;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A0F1fsOQzxU1CCaaNkUUHV9l1YpQMT8PgDKafxf+2WQ=;
        b=2mDTxK8CzNHMIHR0lmzLoIOzNibXMJ9uXH3ozxurQsbxhuHnxkq3UI4ev+7dAmfwMNmhVg
        ku966J6NRzuBgoqDfBCKjCjsNtHwhJTpPeeg4Wk+znGPXnO8Y4d3GPQKwqlgN4mGWp73mL
        aVEufjVOFBRp2RSKLtj106veLGsqCSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698177652;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A0F1fsOQzxU1CCaaNkUUHV9l1YpQMT8PgDKafxf+2WQ=;
        b=hhQWbn+n9727x2gZlftxJugZyy+UOgqKgRDLDZQOer6336S9tL7uSNCdRjjY+O6zWMhXob
        idWuoa7rnHtsczDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 232F81391C;
        Tue, 24 Oct 2023 20:00:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZGXPB3QiOGWWUAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 24 Oct 2023 20:00:52 +0000
Date:   Tue, 24 Oct 2023 21:53:57 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: tree-checker: add type and sequence check for
 inline backrefs
Message-ID: <20231024195357.GT26353@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <23fbab97bd9dbce7869e858cb59d96a7238db57e.1698105469.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23fbab97bd9dbce7869e858cb59d96a7238db57e.1698105469.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -8.78
X-Spamd-Result: default: False [-8.78 / 50.00];
         ARC_NA(0.00)[];
         HAS_REPLYTO(0.30)[dsterba@suse.cz];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         REPLYTO_ADDR_EQ_FROM(0.00)[];
         REPLY(-4.00)[];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_TWO(0.00)[2];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.98)[86.96%]
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 24, 2023 at 12:41:11PM +1030, Qu Wenruo wrote:
> [BUG]
> There is a bug report that ntfs2btrfs had a bug that it can lead to
> transaction abort and the filesystem flips to read-only.
> 
> [CAUSE]
> For inline backref items, kernel has a strict requirement for their
> ordered, they must follow the following rules:
> 
> - All btrfs_extent_inline_ref::type should be in an ascending order
> 
> - Within the same type, the items should follow a descending order by
>   their sequence number
> 
>   For EXTENT_DATA_REF type, the sequence number is result from
>   hash_extent_data_ref().
>   For other types, their sequence numbers are
>   btrfs_extent_inline_ref::offset.
> 
> Thus if there is any code not following above rules, the resulted
> inline backrefs can prevent the kernel to locate the needed inline
> backref and lead to transaction abort.
> 
> [FIX]
> Ntrfs2btrfs has already fixed the problem, and btrfs-progs has added the
> ability to detect such problems.
> 
> For kernel, let's be more noisy and be more specific about the order, so
> that the next time kernel hits such problem we would reject it in the
> first place, without leading to transaction abort.
> 
> Link: https://github.com/kdave/btrfs-progs/pull/622
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.
