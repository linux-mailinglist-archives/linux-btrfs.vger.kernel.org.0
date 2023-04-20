Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61BAE6E9F33
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Apr 2023 00:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbjDTWm4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Apr 2023 18:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbjDTWmz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Apr 2023 18:42:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30852696
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Apr 2023 15:42:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A07EA21A14;
        Thu, 20 Apr 2023 22:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682030572;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dV6r7jvPj2FL0oCVz+0TnXoLSQ3dxWwYWhgTi7e0ROc=;
        b=mRrYVDUx6sgAe78eeKVdDq7PbdVxR0UmSL3Lt3PUSP6UvCL99dQSkmReJW4GKifLt9QvjY
        W9gwiqhw+0KwD3gYH98tqSO+XU7jbAqQERGmxqAnRuBI/8Yhg8aDLU6Vsu7G70TCtxKfXn
        Tp866DpvG+/u7ncPRAFshFP7LhZHaQY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682030572;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dV6r7jvPj2FL0oCVz+0TnXoLSQ3dxWwYWhgTi7e0ROc=;
        b=Pc5nt8G84ywR2mgH4M8nCV7QEDVbLWIBp+Ud15N55QMfkZxzVF+Z4iTEjTbr0PfOuXyVjQ
        fMxzb2836jWWC6Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 71E0213584;
        Thu, 20 Apr 2023 22:42:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xENlGuy/QWSrIAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 20 Apr 2023 22:42:52 +0000
Date:   Fri, 21 Apr 2023 00:42:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Remi Gauvin <remi@georgianit.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Does btrfs filesystem defragment -r also include the trees?
Message-ID: <20230420224242.GZ19619@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <b7c067eb-e828-35f7-4b26-499173fd07d9@georgianit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7c067eb-e828-35f7-4b26-499173fd07d9@georgianit.com>
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

On Thu, Apr 20, 2023 at 08:37:07AM -0400, Remi Gauvin wrote:
> I have recently experienced that btrfs defragment (by itself, without
> -r) of a subvolume can dramatically improve performance when accessing
> very large directories.  I would go so far as to call it critical
> maintenance when working with gtk3 based file managers.
> 
> What I am not clear on, however, does adding the -r *also* defragment
> the subvolume extent tree, or do the two commands needs to be run
> separately to get the full effect?

No, -r does not defragment the extent tree, so if you really want to
defragment the extent tree, then you need to run it separately and
without -r.

Originally there was only the extent tree defragmentation which was
confusing when defrag got a directory as an argument, then it always
defragmented the extent tree but did not descend recursively. Then the
-r was added and the bare directory path discouraged. It still works
though.

I've checked if this is documented, it seems to (btrfs-filesystem,
section defrag):

"NOTE: Directory  arguments  without -r do not defragment files
recursively but will defragment certain internal trees (extent tree and
the subvolume tree). This has been confusing and could be re- moved in
the future."

but if you think it's not clear enough please suggest in what way it
could be extended or what's missing.
