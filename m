Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A247BE515
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Oct 2023 17:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376965AbjJIPiD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Oct 2023 11:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377778AbjJIPhu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Oct 2023 11:37:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66BC189
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Oct 2023 08:37:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 822431F749;
        Mon,  9 Oct 2023 15:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696865847;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=208lq0Wn8Pc5PySYpfX1PuL7KFdMB/D+5FYTAs1tZAc=;
        b=romOz+C774106ADuM0Rkw/K8zWY96ex9TiKOhSIFOhYwU13wOjK0IE31V2vv0yhUgxwUrd
        kn9FpTeDOnhEdJ0pyLO4MxdGD5H5Vv7XXNpZjarEnZkL0gC3xB6jGaxLGMPRWBFrjPk2e0
        M7JNxLqi/CGOL1+pJQEk59rvp9fYo/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696865847;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=208lq0Wn8Pc5PySYpfX1PuL7KFdMB/D+5FYTAs1tZAc=;
        b=GDYBqHarIdelDziOmMbbHYftUU1wa/ZIOfApzxqar/k37242GC6sYYlkHrctxCM7kaYdi2
        DCRgtly6nPOceAAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5D64813586;
        Mon,  9 Oct 2023 15:37:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ilcNFjceJGUcNgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 09 Oct 2023 15:37:27 +0000
Date:   Mon, 9 Oct 2023 17:30:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove redundant log root tree index assignment
 during log sync
Message-ID: <20231009153042.GR28758@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <92f3ac5682d6582c04cfa8ecd5a79eafa774c253.1696852669.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92f3ac5682d6582c04cfa8ecd5a79eafa774c253.1696852669.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 09, 2023 at 01:01:43PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> During log syncing, when we start updating the log root tree we compute
> an index value, stored in variable 'index2', once we lock the log root
> tree's mutex. This value depends on the log root's log_transid. And
> shortly after we compute again the same value for 'index2' - the value
> is exactly the same since we haven't released the mutex and therefore
> the log_transid of the log root is the same as before.
> 
> This second 'index2' computation became pointless after commit
> a93e01682e28 ("btrfs: remove no longer needed use of log_writers for the
> log root tree"). So remove it.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
