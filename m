Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815966D4FEF
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Apr 2023 20:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbjDCSGQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Apr 2023 14:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbjDCSGL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Apr 2023 14:06:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334511717
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Apr 2023 11:06:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BDCC721FDD;
        Mon,  3 Apr 2023 18:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680545162;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FgySYdunC29zg/JLQ8J22uLWMuRQIzARmv695aNKy1Q=;
        b=YAoMqNpZnU6WjyndJUBZreCAo57AMQR6hJsGM6TfZSXgWxbcYFwSN7yzBd8hbol3AUysQn
        y3aDOuzZKV30I9iyT5lLGf41tEdnXQ6OlhQDpST0GuoejgbGNYN1hMnrD6ZE8hvLD7uIRS
        2pz89KmmsHJv8Gv2nTT6yPEMbOHt+Ws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680545162;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FgySYdunC29zg/JLQ8J22uLWMuRQIzARmv695aNKy1Q=;
        b=8IRKm17nIVeFYOQiYR6zPjD2cGe1iWX4TE1PP2Q1vQL4ZEiE4qklPXALUylz+c6v/D5830
        e2Ni4qncqXz7zEDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 96EC213416;
        Mon,  3 Apr 2023 18:06:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cIITJIoVK2SPEgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 03 Apr 2023 18:06:02 +0000
Date:   Mon, 3 Apr 2023 20:06:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: factor out a clean_log_buffer helper
Message-ID: <20230403180600.GB19619@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230403140355.1858319-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403140355.1858319-1-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 03, 2023 at 04:03:55PM +0200, Christoph Hellwig wrote:
> The tree-log code has three almost identical copies for the accounting on
> an extent_buffer that doesn't need to be written any more.  The only
> difference is that walk_down_log_tree passed the bytenr used to find the
> buffer instead of extent_buffer.start and calculates the length using the
> nodesize, while the other two callers look at the extent_buffer.len
> field that must always be equivalent to the nodesize.
> 
> Factor the code into a common helper.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Added to misc-next, thanks.
