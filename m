Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 022C0495E8C
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jan 2022 12:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348108AbiAULsN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jan 2022 06:48:13 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:53550 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244240AbiAULsL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jan 2022 06:48:11 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0C3C41F888;
        Fri, 21 Jan 2022 11:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642765690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=liglXMhDezhDiWWzDaxOZQZ28c0/vzwAJcyD6zhEg+E=;
        b=O//AUfpsfJ8gFR7b6hFDLHBgmGk7rncskDwhFdcDnKrXRkjPClgG7FAURZNqLxTF6T39FR
        4d9tYuo3k/hj5EODEV8kiBECf10gq5L63QSkevLSbwk0oAwjS2hl3tc0DadnE0Ae/8Ccd9
        +9H0qZcicFljuQgn/LW8K6wCP0rB+Mk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9388313BC5;
        Fri, 21 Jan 2022 11:48:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cgoBIXmd6mGUGAAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 21 Jan 2022 11:48:09 +0000
Subject: Re: [PATCH v2] btrfs: zoned: Remove redundant initialization of
 to_add
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, clm@fb.com
Cc:     josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20220121114351.93220-1-jiapeng.chong@linux.alibaba.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <2450db09-4029-df92-1c6e-bb5376b74ead@suse.com>
Date:   Fri, 21 Jan 2022 13:48:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220121114351.93220-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 21.01.22 г. 13:43, Jiapeng Chong wrote:
> to_add is being initialized to len but this is never read as
> to_add is overwritten later on. Remove the redundant
> initialization.
> 
> Cleans up the following clang-analyzer warning:
> 
> fs/btrfs/extent-tree.c:2769:8: warning: Value stored to 'to_add' during
> its initialization is never read [clang-analyzer-deadcode.DeadStores].
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
