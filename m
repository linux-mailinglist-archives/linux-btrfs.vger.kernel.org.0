Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A7F59830B
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Aug 2022 14:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244608AbiHRMUC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Aug 2022 08:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240115AbiHRMUB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Aug 2022 08:20:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54FE785A0
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Aug 2022 05:20:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 739A43EEE7;
        Thu, 18 Aug 2022 12:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660825199;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9FRKwMMeT6gtP7OVV19Q0mAr6C8UD4iS/piKHrvSm54=;
        b=k5K5zdY9TV/wsPBys0EVTPZ+jKvLeQVCpsSI7JzT/dQdLqevWn2t4oi3ifNVsVHg7hiJGW
        kVHwSkU+3EQnk+YHZqXxDPCjnBkWaSi+sbWCce/l65t/fPt9DaNsCtlMNSsWnwUfZH6Lkk
        mWWa3f+I2HNjbXO2Rb7kXBik3YFhgbY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660825199;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9FRKwMMeT6gtP7OVV19Q0mAr6C8UD4iS/piKHrvSm54=;
        b=uVRryr5U8uTPz/xHB5sfrFJbFvvzfyudgB8kGPid8uMPDPV2cgCqsXhY1vltrIHsYhguo/
        UDylz5QMGISqrnDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3D8D2139B7;
        Thu, 18 Aug 2022 12:19:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id St2bDW8u/mKMQQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 18 Aug 2022 12:19:59 +0000
Date:   Thu, 18 Aug 2022 14:14:48 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/2] btrfs: call __btrfs_remove_free_space_cache_locked
 on cache load failure
Message-ID: <20220818121448.GI13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1659989333.git.josef@toxicpanda.com>
 <e1cde76ba6cf7b14d6f38310113588d6486d5a00.1659989333.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1cde76ba6cf7b14d6f38310113588d6486d5a00.1659989333.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 08, 2022 at 04:10:26PM -0400, Josef Bacik wrote:
> +static void __btrfs_remove_free_space_cache_locked(
> +				struct btrfs_free_space_ctl *ctl)
> +{
> +	struct btrfs_free_space *info;
> +	struct rb_node *node;
> +
> +	while ((node = rb_last(&ctl->free_space_offset)) != NULL) {

Please use rbtree_postorder_for_each_entry_safe instead of the
while/rb_next.

> +		info = rb_entry(node, struct btrfs_free_space, offset_index);
> +		if (!info->bitmap) {
> +			unlink_free_space(ctl, info, true);
> +			kmem_cache_free(btrfs_free_space_cachep, info);
> +		} else {
> +			free_bitmap(ctl, info);
> +		}
> +
> +		cond_resched_lock(&ctl->tree_lock);
> +	}
> +}
