Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B9D6B9D87
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Mar 2023 18:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjCNRwF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Mar 2023 13:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjCNRwA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Mar 2023 13:52:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD79B3E1B
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Mar 2023 10:51:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 85F7621CA3;
        Tue, 14 Mar 2023 17:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678816290;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lZ40UwuzxkZVUXOtJ646FaAGmbhGfOd0KpUCdqcCCps=;
        b=nddxjKFJR09aVXTpg9jkWS4rFB5AenA0592CNJYu4a+vaJMCPRWQytMwsszKwd/D2KRhaz
        ODnrz4mXdJc9/OlC7iGaBwYQVV+vsGHug+IIVFaoKSPSc7DlWT1n/amoiDgP5NyJlbOQt0
        +hxJ5ijBEUwkAW8qB1JYprhTzsKzue8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678816290;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lZ40UwuzxkZVUXOtJ646FaAGmbhGfOd0KpUCdqcCCps=;
        b=RNOsqhHMlDe5bvv++7LUjgKtiSIXMQIbhV3jUaWLaTl9lFj1d/X3rSPZPaOyPfEwkU4iXT
        NKZdzU78PosLlZBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6949613A1B;
        Tue, 14 Mar 2023 17:51:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qpOEGCK0EGTNEwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 14 Mar 2023 17:51:30 +0000
Date:   Tue, 14 Mar 2023 18:45:24 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: relax bg_reclaim_threshold for debug purpose
Message-ID: <20230314174523.GO10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <d04a158f989de1f564cd007f05fd51b6b154c006.1678693572.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d04a158f989de1f564cd007f05fd51b6b154c006.1678693572.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 13, 2023 at 04:46:54PM +0900, Naohiro Aota wrote:
> Currently, /sys/fs/btrfs/<UUID>/bg_reclaim_threshold is limited to 0
> (disable) or [50 .. 100]%, so we need to fill 50% of a device to start the
> auto reclaim process. It is cumbersome to do so when we want to shake out
> possible race issues of normal write vs reclaim.
> 
> Relax the threshold check under the BTRFS_DEBUG option.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Added to misc-next, thanks.
