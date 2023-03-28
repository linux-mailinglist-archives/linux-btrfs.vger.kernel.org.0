Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A386CCA0C
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Mar 2023 20:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjC1SfM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Mar 2023 14:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC1SfL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Mar 2023 14:35:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C108519F
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Mar 2023 11:35:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7C9F11FDDF;
        Tue, 28 Mar 2023 18:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680028509;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wJE5a68mcs9u/eCIVqpld2bXp15LGAK8FmegO16Q9rE=;
        b=ssgp/5oNDU1nJGdBQ30I3euKAEPHGivfG6dc1j/EQ6HZf0UrYN5g9FUBeCCgME1gcQ9p1j
        R6zHlKRrzsxVks1SK8wPtcTfe7GPg4/eiJjyyv90ojOH+TOFu5tMQGQRddqLOQj+Ygyw0o
        o6G7XKkXGImthQHfXpeWn7D3ppAOGdU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680028509;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wJE5a68mcs9u/eCIVqpld2bXp15LGAK8FmegO16Q9rE=;
        b=DPMCge6sqJrB3LU15SLz/T0/lXWd75Jw0aBj+LUwlzJeJhVPxvQ1C6FIbklJoIHfA2PpMT
        ZecBpTpNYujkTuAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6128C1390B;
        Tue, 28 Mar 2023 18:35:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id S+DRFl0zI2S3eAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 28 Mar 2023 18:35:09 +0000
Date:   Tue, 28 Mar 2023 20:28:55 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fixup: Btrfs: change wait_dev_flush() return type to
 bool v2
Message-ID: <20230328182855.GO10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <3e067c8b0956f0134501c8eea2e19c8eb5adcedc.1679910088.git.anand.jain@oracle.com>
 <be5e43a3f8333200a69ba85e9c62eb943871c811.1679980900.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be5e43a3f8333200a69ba85e9c62eb943871c811.1679980900.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 28, 2023 at 01:31:27PM +0800, Anand Jain wrote:
> A fixup for the patch:
>  Btrfs: change wait_dev_flush() return type to bool v2
> 
> In v2:
> Fixes:
>  Update write_dev_flush() to return false upon success and true upon errors.
>  Remove the local variable ret in barrier_all_devices().
>  Correct the bug where errors_wait was incremented upon success.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> Dave,
> 
> I am sending this patch as a fix-up while I am still waiting to hear
> whether patch 4/4 will be dropped. If you would prefer to have this
> series sent as v2 with patch 4/4 removed, I can do that.

Ok let's do test_and_clear(), I'll fold the fixup and add the series to
misc-next. Thanks.
