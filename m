Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF0F784983
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Aug 2023 20:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjHVSnw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Aug 2023 14:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjHVSnw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Aug 2023 14:43:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C90CD5;
        Tue, 22 Aug 2023 11:43:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 72EE222C0C;
        Tue, 22 Aug 2023 18:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692729827;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dqfe1xNLanx1P+RTqEk7FWW1QngcON/3PVFKsrMpkq0=;
        b=tWNBJn9rv3zs5t0qGc1hAWU8YWxVHwqn8y1/JIt/D6J/qugMYjaibZAdiwQjmxO5nkueHU
        EsG7GR+N8qRKSWzUTwsgZlbP+5dRPYansRPbHiW6KEZYQO8NB8pcDL7GAgpXjkx+VEOuVI
        SqBgj+7/Zfm2OZAznNXwoAAeM6/Adjg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692729827;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dqfe1xNLanx1P+RTqEk7FWW1QngcON/3PVFKsrMpkq0=;
        b=6sj8kCiH0tvwWEon4s8diLYzW5lsWzWf2hptywUfC1iHz11xAoBhRHBomwLBK1sHR3jOwS
        fHryKAak40vj6uBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4A8F413919;
        Tue, 22 Aug 2023 18:43:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IKiUEeMB5WTYFwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 22 Aug 2023 18:43:47 +0000
Date:   Tue, 22 Aug 2023 20:37:15 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, corbet@lwn.net,
        linux-btrfs@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: kconfig: Doc: MAINTAINERS: Obsolete wiki link
 replace
Message-ID: <20230822183715.GF2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1692420752.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1692420752.git.unixbhaskar@gmail.com>
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

On Sat, Aug 19, 2023 at 10:23:02AM +0530, Bhaskar Chowdhury wrote:
>  Remove and replace old and obsolete wiki link to active maintained link.
> 
> Bhaskar Chowdhury (3):
>   Remove obsolete wiki link
>   Replace obsolete wiki link
>   Remove obsolete wiki link

I'd rather merge all the patches into one, it's not a functional change
nor a potentially conflicting change so I don't see a reason to send
them separately.
