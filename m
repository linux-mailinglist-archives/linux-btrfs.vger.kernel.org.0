Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED84A5FEFD8
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Oct 2022 16:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiJNOJO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Oct 2022 10:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiJNOJM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Oct 2022 10:09:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441691D3447
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 07:09:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0478A1F383;
        Fri, 14 Oct 2022 14:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665756550;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=98QH/2inju+VgBTDsnGLY5wPQNAQ4P/nDL871FxvPVo=;
        b=EtC38kSMgtitiaxJssmP0M1SxBwilAACchd03MDocyYak7WKGjS4Wfz2UA75ECQuTS/uM2
        sDXyQL+63RPPuBjh8HZXfvQF6QlvtfHs869iGrBBCLmbjERNxwj1qxj+Evr5El1hJZwt4i
        +GVEd5VH4k4c4sTEROwENSwqVpDRzWo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665756550;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=98QH/2inju+VgBTDsnGLY5wPQNAQ4P/nDL871FxvPVo=;
        b=OtliOifu3tZecV1ptO3swtZ4R0u3Isp6RnPWAizruwU+DtSrMQCgM9Ad31USuebdAVUII6
        A4QkPmItwazQFjBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D6AF213451;
        Fri, 14 Oct 2022 14:09:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NEyMM4VtSWP+QwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 14 Oct 2022 14:09:09 +0000
Date:   Fri, 14 Oct 2022 16:09:02 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        'Filipe Manana ' <fdmanana@kernel.org>
Subject: Re: [PATCH v2 0/2] btrfs: minor reclaim tuning
Message-ID: <20221014140902.GK13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1665701210.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1665701210.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 13, 2022 at 03:52:08PM -0700, Boris Burkov wrote:
> Two minor reclaim fixes that reduce relocations when they aren't quite
> necessary. These are a basic first step in a broader effort to reduce
> the alarmingly high rate of relocation we have observed in production
> at Meta.
> 
> The first patch skips empty relocation.
> 
> The second patch skips relocation that no longer passes the reclaim
> threshold check at reclaim time.
> 
> Changes in v2:
> - added the re-check patch
> - improved commit message and comment in the skip-empty patch.
> 
> Boris Burkov (2):
>   btrfs: skip reclaim if block_group is empty
>   btrfs: re-check reclaim condition in reclaim worker

Added to misc-next, thanks.
