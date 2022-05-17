Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005C452ABCB
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 21:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352617AbiEQTR6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 15:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243528AbiEQTR5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 15:17:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4979D40E64
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 12:17:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0B01D1F916;
        Tue, 17 May 2022 19:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652815075;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LM0dbbZ9ikIm3Z8XfLN93TcbO+c1ZjxhszUK2jxYqAc=;
        b=sLR104gubP04wOHdFMe8w90S/pfSCKci6gIWB4OW1+7NVEp9yMvwlFpIcCbW9DxYf7USyy
        WLjw0bAQcXJn/hbskeDnNtG3NYoHQ/LDIacJYuX8z4ASHnyqE4Q9R0tp4VJgpP2BY1jLd5
        r0hqyqYRu+hdTn7bFd28pTGbZivZExc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652815075;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LM0dbbZ9ikIm3Z8XfLN93TcbO+c1ZjxhszUK2jxYqAc=;
        b=jhsPyZmPmzRDq+K2WbNvNiZXoUW9PkFiz94cxBqX0av7coHt8VUQX1agFY8gu5giXE2ecq
        vaUUS6hCWcS6pKCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D8F3A13305;
        Tue, 17 May 2022 19:17:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id A+oENOL0g2LfUwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 17 May 2022 19:17:54 +0000
Date:   Tue, 17 May 2022 21:13:36 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: removed unused header check/btrfsck.h
Message-ID: <20220517191336.GH18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <5675e197da96530f011d40102b0e4dc8c88322b7.1652442718.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5675e197da96530f011d40102b0e4dc8c88322b7.1652442718.git.wqu@suse.com>
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

On Fri, May 13, 2022 at 07:52:01PM +0800, Qu Wenruo wrote:
> It should have been deleted, as CHANGES mentioned this in v5.14, but
> obvious it's not.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks.
