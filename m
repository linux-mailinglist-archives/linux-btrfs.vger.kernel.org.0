Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90686EE456
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Apr 2023 16:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjDYO6g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Apr 2023 10:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbjDYO6a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Apr 2023 10:58:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4406D49C0
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Apr 2023 07:58:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EF5301FD82;
        Tue, 25 Apr 2023 14:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682434699;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ft2BZ56e28Ggl1qA/bTJTuPOrobX4lsMDHGUUFzbzJc=;
        b=oGL1pcw8atTfuOwGccwhhT3dfDLnFrIWWg6LJK/EMStJh6esIM+G7RpZVwZ7EsE0pQy+2j
        cpobqTcrFRvrSeI6kn3whgZ0cvaHKdzztHxBH176+2wAb+GECHgDq/gTaGnVg1wfTzRIst
        3xh34U9WpYdcmj396f01MbDYS6256IQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682434699;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ft2BZ56e28Ggl1qA/bTJTuPOrobX4lsMDHGUUFzbzJc=;
        b=whh65x9YP/4u0FRtdhkm9IAqufz22FH6b+tG0hZnUTaVYvR6zuGGXkKvE69ZDJKz20a4yz
        2gCJE9t8sxCzG4Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D0A9B138E3;
        Tue, 25 Apr 2023 14:58:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pA4YMovqR2TaSwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 25 Apr 2023 14:58:19 +0000
Date:   Tue, 25 Apr 2023 16:58:06 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Disseldorp <ddiss@suse.de>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH btrfs-progs] btrfs-completion: include files in "du"
 completion
Message-ID: <20230425145806.GD19619@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230420092842.786-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420092842.786-1-ddiss@suse.de>
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

On Thu, Apr 20, 2023 at 11:28:42AM +0200, David Disseldorp wrote:
> Currently "btrfs filesystem du" auto-completes for directories only,
> but it can also be used against files to determine shared vs exclusive
> extents.
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>

Added to devel, thanks.
