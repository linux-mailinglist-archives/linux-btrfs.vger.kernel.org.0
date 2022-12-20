Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126E3652754
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Dec 2022 20:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiLTTuo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Dec 2022 14:50:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiLTTun (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Dec 2022 14:50:43 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2507B5A
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Dec 2022 11:50:41 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 20FA94D974;
        Tue, 20 Dec 2022 19:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671565840;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BTQkXRyjWFCD4S7FaIGzf17VD7ijBYZJSFQUWzLTuwY=;
        b=kGCfla8ZRTiHCyq98vZg/Pk1L7ZD1n04MAi/t/ljh7i3o/gEucMcJ7RtnsEGGc5T4m5Lbn
        EgoEIuEpBmb6FCfgYJjLt7t7uU8+VzIndpsthG75Iwcse/k762ddhBn8WPeIcTlccewMqq
        zxtLUiGMLh765wSPQOlSOecKntjJQBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671565840;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BTQkXRyjWFCD4S7FaIGzf17VD7ijBYZJSFQUWzLTuwY=;
        b=A+pylsuR+MobYvtD6qvNqzN9YU744y18zFadeSpDkNpbldJQq7/+rtz8MK+l/vpGrNpbXS
        wDt0KirZqucjqOAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E946813254;
        Tue, 20 Dec 2022 19:50:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +JQKOA8SomNeRwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 20 Dec 2022 19:50:39 +0000
Date:   Tue, 20 Dec 2022 20:49:54 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: corrupt-block: fix the mismatch in --root
 and -r options
Message-ID: <20221220194954.GT10499@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <45593abf29f76663fa9b18c5ddc52556df5464f6.1670387695.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45593abf29f76663fa9b18c5ddc52556df5464f6.1670387695.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 07, 2022 at 12:35:01PM +0800, Qu Wenruo wrote:
> [BUG]
> 
> The following command will crash:
> 
>  $ btrfs-corrupt-block --value 4308598784 --root 5 --inode 256 --file-extent 0 \
> 	-f disk_bytenr ~/test.img
> 
> [CAUSE]
> The backtrace is at the following code:
> 
> 			case 'r':
> 				root_objectid = arg_strtou64(optarg);
> 				break;
> 
> And @optarg is NULL.
> 
> The root cause is, for short option "-r" it indeed requires an argument.
> But unfortunately for the longer version, it goes:
> 
> 			{ "root", no_argument, NULL, 'r'},
> 
> Thus it gave @optarg as NULL if we go the longer option and crash.
> 
> [FIX]
> Just fix the argument requirement for "--root" option.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks.
