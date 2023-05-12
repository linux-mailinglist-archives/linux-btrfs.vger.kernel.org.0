Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205E1700300
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 May 2023 10:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239976AbjELIyh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 May 2023 04:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239826AbjELIye (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 May 2023 04:54:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B46E43;
        Fri, 12 May 2023 01:54:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C8A1320447;
        Fri, 12 May 2023 08:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683881671;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7ZadqfqzlE6y/GkIBIfeb/w5RxmHH4WLXaW0JIjrBhg=;
        b=srUxSznMBn3Nf/c4Fq1n+ar6OWZ22QDXL6yZ02vsIoXPNzI6sl3FumZvF1whlniGY6vPfN
        Dlu5/pGOVNfVMKE19eZCNL/vJyYLgYkttZ65T75KqAcPWL2njWtESyRJUEgW9m2YvaTanv
        dDyrUAOgCOIhXmpkRqu4FLOb2KI1eXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683881671;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7ZadqfqzlE6y/GkIBIfeb/w5RxmHH4WLXaW0JIjrBhg=;
        b=I/QwA/3U+1oaNqwMPE8zIULP57B0xgIKnB/9fHkMJbY8Daw6BNaHFmisavmTl3pR/JGBE1
        sWB7l8lPZNfTukBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A274C13499;
        Fri, 12 May 2023 08:54:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sjwFJ8f+XWR9LwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 12 May 2023 08:54:31 +0000
Date:   Fri, 12 May 2023 10:48:31 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] btrfs: scrub: Remove some unused functions
Message-ID: <20230512084831.GE32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230512054457.43501-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512054457.43501-1-jiapeng.chong@linux.alibaba.com>
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

On Fri, May 12, 2023 at 01:44:57PM +0800, Jiapeng Chong wrote:
> These functions are defined in the scrub.c file, but not called
> elsewhere, so delete these unused functions.
> 
> fs/btrfs/scrub.c:553:20: warning: unused function 'scrub_stripe_index_and_offset'.
> fs/btrfs/scrub.c:543:19: warning: unused function 'scrub_nr_raid_mirrors'.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4937
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Added to misc-next, thanks.
