Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8938342C1AA
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Oct 2021 15:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234907AbhJMNrW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Oct 2021 09:47:22 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35446 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbhJMNrV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Oct 2021 09:47:21 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B659C223AC;
        Wed, 13 Oct 2021 13:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634132717;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=He7pj3VgFM0KAIsXfN+xqcrQuvm9FXxlqXW9XzCsTCM=;
        b=UWNafR6nTsJs28Y2i9eu4KGSCjqcNMtfxlm2iQXsGMLMyHx4WowGv9isCFwu6kpqJtiA86
        jCN2DV/dd+AlyWFjNV/9Rs2a6liimqLsGYsEPhf+WvdEKZ7jlTHXsqCfT3WkU1c4qIj/KR
        N24GMARdISXO+32OxppGxpVphVAkvBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634132717;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=He7pj3VgFM0KAIsXfN+xqcrQuvm9FXxlqXW9XzCsTCM=;
        b=9QtH70vo0XxhWXdXPVN0RmDLU3kLaHIi9MjBbNfT0HSfQLBLozWuAnNVjLAaDnQSJqXx4A
        K8LorZBuOFfLJPAQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 0FA07A3B83;
        Wed, 13 Oct 2021 13:45:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 82C41DA7A3; Wed, 13 Oct 2021 15:44:53 +0200 (CEST)
Date:   Wed, 13 Oct 2021 15:44:53 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: use bvec_kmap_local in btrfs_csum_one_bio
Message-ID: <20211013134453.GF9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org
References: <20211012063153.380185-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012063153.380185-1-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 12, 2021 at 08:31:53AM +0200, Christoph Hellwig wrote:
> Using local kmaps slightly reduces the chances to stray writes, and
> the bvec interface cleans up the code a little bit.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Added to misc-next, thanks.
