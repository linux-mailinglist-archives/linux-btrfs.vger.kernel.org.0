Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8D9595BBD
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Aug 2022 14:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbiHPMXj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Aug 2022 08:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbiHPMXg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Aug 2022 08:23:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198CB481EB
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Aug 2022 05:23:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C7FF81FB74;
        Tue, 16 Aug 2022 12:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660652613;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CVmU/4+Hp0Cdt6aWMcemz2tmV2I6XpI1GC8cuDrRoGY=;
        b=QYsW0kSA7iDM1iF+sWrLyAI/gJK104DIL0/3kP5khxjgL3DWlcEUVA5Isyu8y5xZANnCR+
        0bhhBIC3fgYQosJewu2BsL14qW1uZvGEWcWex/7PA0hU9IYc5qkW71C11QnnjhDQpPM/Db
        KqtVnGN1hMOhihIeviXqXjnllVgzZG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660652613;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CVmU/4+Hp0Cdt6aWMcemz2tmV2I6XpI1GC8cuDrRoGY=;
        b=D5F32hb8leCJicvmrQbogjXcNHt56mfAwN7zGt34OEhUGr+HdW1301g5J161UKRm6T3bA3
        gfCYF0+mNwR9KbBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ABD8C1345B;
        Tue, 16 Aug 2022 12:23:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kC0WKUWM+2JVSwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 16 Aug 2022 12:23:33 +0000
Date:   Tue, 16 Aug 2022 14:18:23 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: avoid redefined __bitwise__ warning
Message-ID: <20220816121823.GB13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Wang Yugui <wangyugui@e16-tech.com>,
        linux-btrfs@vger.kernel.org
References: <20220816013703.72722-1-wangyugui@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816013703.72722-1-wangyugui@e16-tech.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 16, 2022 at 09:37:03AM +0800, Wang Yugui wrote:
> compile warning:
>     ./kerncompat.h:142: warning: "__bitwise__" redefined
>     #define __bitwise__
> 
>     In file included from ./kerncompat.h:35,
>                     from check/qgroup-verify.c:24:
>     /usr/include/linux/types.h:25: note: this is the location of the previous definition
>     #define __bitwise__ __bitwise
> 
> Because  __bitwise__ is already defined in newer kernel-headers
> (/usr/include/linux/types.h), so add #ifndef to avoid this warning.
> 
> Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>

Added to devel, thanks.
