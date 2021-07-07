Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA6483BE78A
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jul 2021 14:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbhGGMDu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jul 2021 08:03:50 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:49742 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbhGGMDt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jul 2021 08:03:49 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C34542006A;
        Wed,  7 Jul 2021 12:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625659268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tEla79BRPc18RqG3uFtLCOzF35+/BEBCAH/+EHaWceI=;
        b=f6FaaXbjxgTthhKlfKXsWra/+lDg1MOwbUYsky15xfJJIfByOXBAcONDpOBS3avZak7B7V
        FfRkx8aeXKFFZqJb6pAwUcw1nIW9Q8HSKlg2KrgxxDIWRJy9kZbR0mtIX7oaI5sX3U9/pN
        jRyAOT7KYAuvQja6YbBYWsOMxAHkYcE=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 975FF1398A;
        Wed,  7 Jul 2021 12:01:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id YtfzIYSX5WBxcQAAGKfGzw
        (envelope-from <nborisov@suse.com>); Wed, 07 Jul 2021 12:01:08 +0000
Subject: Re: [PATCH] btrfs: zoned: fix wrong mutex unlock on failure to
 allocate log root tree
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <11314a6ca7a70deee42785d3ee79c97813b528ab.1625656963.git.fdmanana@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <0b159f83-be03-f01f-5637-8f228425d862@suse.com>
Date:   Wed, 7 Jul 2021 15:01:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <11314a6ca7a70deee42785d3ee79c97813b528ab.1625656963.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 7.07.21 г. 14:23, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When syncing the log, if we fail to allocate the root node for the log
> root tree:
> 
> 1) We are unlocking fs_info->tree_log_mutex, but at this point we have
>    not yet locked this mutex;
> 
> 2) We have locked fs_info->tree_root->log_mutex, but we end up not
>    unlocking it;
> 
> So fix this by unlocking fs_info->tree_root->log_mutex instead of
> fs_info->tree_log_mutex.
> 
> Fixes: e75f9fd194090e ("btrfs: zoned: move log tree node allocation out of log_root_tree->log_mutex")
> CC: stable@vger.kernel.org # 5.13+
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
