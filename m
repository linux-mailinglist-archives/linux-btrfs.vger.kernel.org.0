Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB6C29BCA7
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Oct 2020 17:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1810967AbgJ0Qgb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Oct 2020 12:36:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:41088 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1799913AbgJ0Pn0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Oct 2020 11:43:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603813405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6qI8fOrH7+Vi4/ERE20mqksWSQx2CijT5kFRwVaNpJE=;
        b=GMiJcWjutsOhpNpEbk4D/Lwj2EeeYJZkN8MizclaunrYGs1c8maHUh0iI4iA4Zjl6N35ml
        L+pUJJCq2kP4vIIrSuwHsTOSK26SkxAxo720EeQS5vC6bBW1jBPEEnFHbAqIkqItROubIn
        gMJUY2YZWj4HoMN3o541triAgDV5nlo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 793ACACF3;
        Tue, 27 Oct 2020 15:43:25 +0000 (UTC)
Date:   Tue, 27 Oct 2020 10:43:23 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 22/68] btrfs: disk_io: grab fs_info from
 extent_buffer::fs_info directly for btrfs_mark_buffer_dirty()
Message-ID: <20201027154323.zrxh7iz3hu5junsy@fiona>
References: <20201021062554.68132-1-wqu@suse.com>
 <20201021062554.68132-23-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021062554.68132-23-wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 14:25 21/10, Qu Wenruo wrote:
> Since commit f28491e0a6c4 ("Btrfs: move the extent buffer radix tree into
> the fs_info"), fs_info can be grabbed from extent_buffer directly.
> 
> So use that extent_buffer::fs_info directly in btrfs_mark_buffer_dirty()
> to make things a little easier.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

-- 
Goldwyn
