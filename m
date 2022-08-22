Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5948B59BF3B
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Aug 2022 14:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbiHVMGa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Aug 2022 08:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234862AbiHVMG2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Aug 2022 08:06:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD5839BB3;
        Mon, 22 Aug 2022 05:06:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AEB7E34537;
        Mon, 22 Aug 2022 12:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661169986;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kc5mGUgbC9e93/8VtvBmXTPzMo+Wf+Vj9kC1tsuV+5U=;
        b=XQ0ngXOXIn08K6CbVR0BrzxyQduDBpj+CyfEbs3m+0Y8unmyFlodAreccqTmNhd0frQPGE
        fR+2iHeigcnU9GerNJAsqPiB/ydhxgBYmYrzLD3vvG/MLNf6d4RLYMlXsC5XdmWhVPknIa
        5WtkXpqHqjhFfon0+dAxat6VSOy0S/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661169986;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kc5mGUgbC9e93/8VtvBmXTPzMo+Wf+Vj9kC1tsuV+5U=;
        b=Nqfem3JipBVmHs68SZ1NcjQM/iQ7oMz0tKwWT1VnDui74mlU3jXY+2tp7oC+GJV9XOheHn
        vNCoFIA+Cfjc5wCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6D40013523;
        Mon, 22 Aug 2022 12:06:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9DaLGUJxA2MpQAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 22 Aug 2022 12:06:26 +0000
Date:   Mon, 22 Aug 2022 14:01:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     bingjingc <bingjingc@synology.com>
Cc:     fdmanana@kernel.org, josef@toxicpanda.com, dsterba@suse.com,
        clm@fb.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, robbieko@synology.com,
        bxxxjxxg@gmail.com
Subject: Re: [PATCH v3 0/2] btrfs: send: fix failures when processing inodes
 with no links
Message-ID: <20220822120112.GT13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, bingjingc <bingjingc@synology.com>,
        fdmanana@kernel.org, josef@toxicpanda.com, dsterba@suse.com,
        clm@fb.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, robbieko@synology.com,
        bxxxjxxg@gmail.com
References: <20220812144233.132960-1-bingjingc@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812144233.132960-1-bingjingc@synology.com>
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

On Fri, Aug 12, 2022 at 10:42:31PM +0800, bingjingc wrote:
> From: BingJing Chang <bingjingc@synology.com>
> 
> There is a bug causing send failures when processing an orphan directory
> with no links. In commit 46b2f4590aab ("Btrfs: fix send failure when root
> has deleted files still open")', the orphan inode issue was addressed. The
> send operation fails with a ENOENT error because of any attempts to
> generate a path for the inode with a link count of zero. Therefore, in that
> patch, sctx->ignore_cur_inode was introduced to be set if the current inode
> has a link count of zero for bypassing some unnecessary steps. And a helper
> function btrfs_unlink_all_paths() was introduced and called to clean up old
> paths found in the parent snapshot. However, not only regular files but
> also directories can be orphan inodes. So if the send operation meets an
> orphan directory, it will issue a wrong unlink command for that directory
> now. Soon the receive operation fails with a EISDIR error. Besides, the
> send operation also fails with a ENOENT error later when it tries to
> generate a path of it.
> 
> 
> BingJing Chang (2):
>   btrfs: send: refactor get_inode_info()
>   btrfs: send: fix failures when processing inodes with no links

Added to misc-next, thanks.
