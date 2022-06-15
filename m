Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B434154CB0F
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jun 2022 16:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbiFOOTi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jun 2022 10:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236578AbiFOOTe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jun 2022 10:19:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE17B36B4A
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jun 2022 07:19:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AD12121C19;
        Wed, 15 Jun 2022 14:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655302772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tt7gMhMEcMkCS/yDGKL2aUGkJVGZWHF9rWaZJR1wkuI=;
        b=Zw91fAGscNzT/Us/eQsll4f5fbRWT9srN/Qk3mK/rjJBeescMTsPnrp2Oun3ASDNBlgZSj
        3RJiUFIsXWjve8skUlaFi8cUGBpLkjs+JVnVjklYCfnchqgZqI92v/bJD74N3vGrh6pbyB
        JtASuzHMZz/pmUibhDsBeknk0uHJ1IM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 851C0139F3;
        Wed, 15 Jun 2022 14:19:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0/neHXTqqWLLOgAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 15 Jun 2022 14:19:32 +0000
Message-ID: <5dd42610-7f3e-2fe0-ce5d-4a4ee896702c@suse.com>
Date:   Wed, 15 Jun 2022 17:19:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 5/9] btrfs: add fast path for extent_state insertion
Content-Language: en-US
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1654706034.git.dsterba@suse.com>
 <85ad4b193c5c4dcc803449feff008f06bd61808f.1654706034.git.dsterba@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <85ad4b193c5c4dcc803449feff008f06bd61808f.1654706034.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 8.06.22 г. 19:43 ч., David Sterba wrote:
> In two cases the exact location where to insert the extent state is
> known at the call time so we don't need to pass it to insert_state that
> takes the fast path.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>   fs/btrfs/extent_io.c | 24 +++++++++++++++++-------
>   1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 9b1dfe4363c9..00a6a2d0b112 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -569,6 +569,21 @@ static int insert_state(struct extent_io_tree *tree,
>   	return 0;
>   }
>   
> +/*
> + * Insert state to the tree to a location given by @p_

that @p_ seems incomplete?

<snip>
