Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE8C751A05
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 09:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjGMHiH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 03:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjGMHiG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 03:38:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CF2C1
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 00:38:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 85F281F855;
        Thu, 13 Jul 2023 07:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689233883; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v9AJ5GQc3ArzlaXJhqF0AEhRtoDWCsRztyga+D1Z+LY=;
        b=DdDFhqwmaQLcxCJXUBNjpq9/QOrtdtwyfvpGhKGrKGOc5KdDsPepasWBnrUfnb603obTAl
        j2zRub7EfeEoUGrk2lObv1WjJTBBgn8sOE5S2eUM0Irnh7B7hSn+yhQAD5Nw2d3Q+YzcDi
        1nYSfe/CHa7apw64jVpyyqFYmfENFYs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689233883;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v9AJ5GQc3ArzlaXJhqF0AEhRtoDWCsRztyga+D1Z+LY=;
        b=0rtLq26a/CctG6UHBG+yW8CQTAHXYTlAt/NC8r7rTdchRNF/hUZhaZu9Apm6IhPQDP/HHK
        gzNkjLMcvEZOWzCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 72ED3133D6;
        Thu, 13 Jul 2023 07:38:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QcU+G9upr2Q9EgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 13 Jul 2023 07:38:03 +0000
Message-ID: <a5d30c32-b1ec-a607-b5b9-c8bb22425819@suse.cz>
Date:   Thu, 13 Jul 2023 09:38:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] btrfs: disable slab merging in debug build
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     linux-mm@kvack.org
References: <20230712191712.18860-1-dsterba@suse.com>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230712191712.18860-1-dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/12/23 21:17, David Sterba wrote:
> The slab allocator newly allows to disable merging per-slab (since
> commit d0bf7d5759c1 ("mm/slab: introduce kmem_cache flag
> SLAB_NO_MERGE")). Set this for all caches in debug build so we can
> verify there are no leaks when module gets reloaded.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

