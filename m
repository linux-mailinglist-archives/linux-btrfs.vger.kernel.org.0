Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADDC6FD2A7
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 May 2023 00:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235484AbjEIWXE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 May 2023 18:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjEIWXD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 May 2023 18:23:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1351992
        for <linux-btrfs@vger.kernel.org>; Tue,  9 May 2023 15:23:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 39A6721B3C;
        Tue,  9 May 2023 22:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683670981;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WQysrKe2qo8+HzBYj7yorbMQBmnF1SkOFAmGZLn4FOU=;
        b=id7/sdnhB03Kl00rdeAxWE/xbIMOWEQP84fJmBYI+RrRY6IyP8BclQuelYOdmBNCCDEnjj
        gq5KOELhYO35ZSzg6DB6KXwlTso3q5FRc+8rbfItj6pK0r79RO2dijYcs+CxzkkHnbZKBa
        isLTejJmzv4rD9ijrnC7yMQVbrWjqqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683670981;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WQysrKe2qo8+HzBYj7yorbMQBmnF1SkOFAmGZLn4FOU=;
        b=0/1dpOWglfbBDAx0NKe5VK8+ce9hwXEidwrmqfvfhcazkYxjplLkRsWKal/AkKieZ5iTEv
        7YvQ43W4BdOZKtCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1375313581;
        Tue,  9 May 2023 22:23:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id puTaA8XHWmQqcQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 09 May 2023 22:23:01 +0000
Date:   Wed, 10 May 2023 00:17:02 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <david.sterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: mark btrfs_run_discard_work status
Message-ID: <20230509221701.GH32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <a6acf3890428f9ffc5ca42b4c37faa4292f30c3e.1683652229.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6acf3890428f9ffc5ca42b4c37faa4292f30c3e.1683652229.git.johannes.thumshirn@wdc.com>
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

On Tue, May 09, 2023 at 10:12:01AM -0700, Johannes Thumshirn wrote:
> Mark btrfs_run_discard_work static and move it above its callers.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

With updated subject added to misc-next, thanks.
