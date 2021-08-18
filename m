Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D173EFCA5
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Aug 2021 08:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238543AbhHRG1a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Aug 2021 02:27:30 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55480 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238264AbhHRG13 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Aug 2021 02:27:29 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0BA0520058;
        Wed, 18 Aug 2021 06:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629268015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3AnYFos+Eup8Nj9MfAe2ZdwFprddLJgpcERPxcgNbrs=;
        b=V7+R1cX5kBYDy8VajmHE6sf/TUAZkchT5TYrveQnN/sqBSqoTd9iLyTzDR6XJUtDO3L1vl
        ylGHixsqrhbaTk7v6VrjNwisa6FO8UODGdgMB0l9B24QgSsXID5ikYuRWrqcZbC32NICmJ
        Ac3t7+32dQTuY9jW0JN+B7O+i1UUrX8=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id D3C22134B1;
        Wed, 18 Aug 2021 06:26:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id IP2gMC6oHGG2cQAAGKfGzw
        (envelope-from <nborisov@suse.com>); Wed, 18 Aug 2021 06:26:54 +0000
Subject: Re: [PATCH v2] btrfs: rename btrfs_alloc_chunk to btrfs_create_chunk
To:     linux-btrfs@vger.kernel.org
References: <20210705091643.3404691-1-nborisov@suse.com>
Cc:     David Sterba <dsterba@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <eb7458e5-6c4d-c02a-2b81-d12f476822a9@suse.com>
Date:   Wed, 18 Aug 2021 09:26:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210705091643.3404691-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 5.07.21 г. 12:16, Nikolay Borisov wrote:
> The user facing function used to allocate new chunks is
> btrfs_chunk_alloc, unfortunately there is yet another similar sounding
> function - btrfs_alloc_chunk. This creates confusion, especially since
> the latter function can be considered "private" in the sense that it
> implements the first stage of chunk creation and as such is called by
> btrfs_chunk_alloc.
> 
> To avoid the awkwardness that comes with having similarly named but
> distinctly different in their purpose function rename btrfs_alloc_chunk
> to btrfs_create_chunk, given that the main purpose of this function is
> to orchestrate the whole process of allocating a chunk - reserving space
> into devices, deciding on characteristics of the stripe size and
> creating the in-memory structures.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Ping

