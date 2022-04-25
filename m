Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C7350E65F
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Apr 2022 19:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235577AbiDYREE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Apr 2022 13:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237115AbiDYRED (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Apr 2022 13:04:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542451AF17
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Apr 2022 10:00:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0B1871F388;
        Mon, 25 Apr 2022 17:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650906058;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HRAVO2Ts9ln1Cs8CuB8nhxpG5YqQZq8IuOzftBYMH5I=;
        b=FZSiHc4pO98Q+Hahoz3yG9+aBY4TjTxI2d2XFbPNewS9y7gqZjIqnnEVllDZ0FvxuVJLBy
        U24e8NX3m2ORYZCdf7KDzBEDV6Oj0vFSAI9wiJuovqISBHoUQmQbdpLtfHbKXsIx4iMrca
        Mp7Zyir9rCsQXbbQm9In+NwfUz/9qCg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650906058;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HRAVO2Ts9ln1Cs8CuB8nhxpG5YqQZq8IuOzftBYMH5I=;
        b=IkYTHHSQoNp6qHyharHF/CpVoOatD6zPpEVUx5PFk2dF1qAiMJUTpiKkz7mRGFXQVqwuWv
        Z3MaEdz2tIdoWDAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DF4B313AED;
        Mon, 25 Apr 2022 17:00:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Qu/lNMnTZmJeZgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 25 Apr 2022 17:00:57 +0000
Date:   Mon, 25 Apr 2022 18:56:51 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/2] btrfs-progs: bug fixes exposed during delayed
 chunk items insertion
Message-ID: <20220425165651.GQ18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1650366929.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1650366929.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 19, 2022 at 07:17:40PM +0800, Qu Wenruo wrote:
> [CHANGELOG]
> v2:
> - Update the first patch to delaye memory allocation after all other
>   checks
> 
> 
> There are two bugs in the existing code base of btrfs-progs:
> 
> - Memory leak due to wrong error handling in btrfs_start_transaction()
> 
> - Empty rw device list due to missing error handling in create_chunk()
> 
> Just fix them.
> 
> Qu Wenruo (2):
>   btrfs-progs: fix a memory leak when starting a transaction on fs with
>     error
>   btrfs-progs: fix an error path which can lead to empty device list

Added to devel, thanks.
