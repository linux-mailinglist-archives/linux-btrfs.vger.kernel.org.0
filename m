Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD19470CAED
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 May 2023 22:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbjEVUZw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 May 2023 16:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbjEVUZq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 May 2023 16:25:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43150B5
        for <linux-btrfs@vger.kernel.org>; Mon, 22 May 2023 13:25:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5FB8922177;
        Mon, 22 May 2023 20:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684787143;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sod16p03nI18IaS1Fl8zxuhDc4MNPGGgBwUl46cdYPM=;
        b=asNyOu4IKTnWHyvRhhyd7nLZTlSxVMEUfjgXhXwcujXO1rbKGgDTfIdAEsCenfVS97rwu0
        SVEHNCA+V6uSTUaaOp5Y6eCM//8y68ljnG3Klv+41x8ul8y2EUinebxKfjnhoz9qmGJaEv
        C8SjNVPzUVSZQJnLhj5HsFFeb9tmj6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684787143;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sod16p03nI18IaS1Fl8zxuhDc4MNPGGgBwUl46cdYPM=;
        b=DWmIxJvsvT9q9z6qmAl4tzUrssSkwkQCvj11SXvhNOZTUjZMUmdblQb6w68B4F9b/9v+pY
        nGfH5ACl+b2j91Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 42E7313776;
        Mon, 22 May 2023 20:25:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9IIKD8fPa2QRVQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 22 May 2023 20:25:43 +0000
Date:   Mon, 22 May 2023 22:19:36 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/7] btrfs-progs: csum-change: add the initial support
 for offline csum type change
Message-ID: <20230522201936.GQ32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1684375729.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1684375729.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 18, 2023 at 10:10:38AM +0800, Qu Wenruo wrote:
> [TODO]
> - Support for resume
>   Currently we won't resume an interrupted csum conversion.
>   Although the design should be able to handle any interruption at data
>   csum conversion part, and as long as metadata csum writes are atomic,
>   the metadata rewrites should also be fine.
> 
> - Support for revert if errors are found
>   If we hit data csum mismatch and can not repair from any copy, then
>   we should revert back to the old csum.
> 
> - Suppot for precaustious metadata check
>   We'd better read and very metadata before rewriting them.
> 
> - Extra test cases

As the todo list for that feature is still long and it's behind the
experimental build I'll keep the patches in devel, please send
incremental fixes or further updates. Thanks.
