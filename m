Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586776299BB
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 14:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiKONLu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 08:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiKONLt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 08:11:49 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D136FFE7;
        Tue, 15 Nov 2022 05:11:48 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 920E51F8C7;
        Tue, 15 Nov 2022 13:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668517907;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mcZK0uCYLnnDgZeVCTmh41Y7RICzghsvCX4u7bWxMPg=;
        b=2M4jynWbfd+pnHEfhJjvpGPceSZBJyRo7n/6IdU+p3uMddpyGShX+KL0LjtjAlgblsMN2m
        qY3XTbFz4GCAa6z6lJYBz/YhHwYdmeFsKvz5SZc/R5qmtlyEuHB39C1Gi9NCwgFhC1jzlB
        ckdwu/Stl5kZg4aJf0FpcmrKg4aT1ag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668517907;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mcZK0uCYLnnDgZeVCTmh41Y7RICzghsvCX4u7bWxMPg=;
        b=r2J9xiw9D5YDjTRNDRzp/4NX1QpLveMXOf2Bpk3NASOOCFu1lADaHRUgtZQHqBPoAIQvMz
        z2JIUWXqHYc9JjAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5D7DF13A91;
        Tue, 15 Nov 2022 13:11:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id J4YoFROQc2OYWwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 15 Nov 2022 13:11:47 +0000
Date:   Tue, 15 Nov 2022 14:11:21 +0100
From:   David Sterba <dsterba@suse.cz>
To:     guo.ziliang@zte.com.cn
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next] btrfs: remove redundant ret variable in
 delete_v1_space_cache
Message-ID: <20221115131121.GF5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <202211150914564821972@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202211150914564821972@zte.com.cn>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 15, 2022 at 09:14:56AM +0800, guo.ziliang@zte.com.cn wrote:
> From: guo ziliang <guo.ziliang@zte.com.cn>
> Return value from delete_block_group_cache() directly instead of taking
> this in another redundant variable.

Have you found this manually or by some tool? I did a quick grep and
found 14 other cases that could be simplified like that. I'm not sure if
we really need it, but if you fix more than one case then lets do it.
