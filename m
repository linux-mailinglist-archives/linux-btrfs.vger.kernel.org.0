Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA85D4292D7
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 17:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbhJKPKl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 11:10:41 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:40734 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbhJKPKk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 11:10:40 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A02C11FED2;
        Mon, 11 Oct 2021 15:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633964919;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J1RlsPUxdbRC9T/b8LM6SQh4KU2EguMm9oESCKe7Aco=;
        b=eBvhwH9ImJKL4KYCTs2ner5GS9g+rUA41nsedshjULtMuETNi5mW/izFvTrlL+dWAPU3fk
        vcP/tJlyQ32DWwkV65eTuKMdh57QqK10//P39rPZL5qK3OZwt1ns4LWSWMaJrRFOyTwYvM
        aVDr2y4D/kJg0aFMqdSG1+Hq+85p6b4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633964919;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J1RlsPUxdbRC9T/b8LM6SQh4KU2EguMm9oESCKe7Aco=;
        b=vWcduUstZnUlpCIJaLidQxRo8OawZ6Jg1nEJRZh3aGlM/8+fbQNzGy/J58UVrEjGZx9yB2
        6/T1bP+t58P/1qBQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 98DD8A3B8A;
        Mon, 11 Oct 2021 15:08:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8E947DA781; Mon, 11 Oct 2021 17:08:16 +0200 (CEST)
Date:   Mon, 11 Oct 2021 17:08:16 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/5] Make real_root used only in ref-verify
Message-ID: <20211011150816.GR9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211011101019.1409855-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211011101019.1409855-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 11, 2021 at 01:10:14PM +0300, Nikolay Borisov wrote:
> Here's a small series that refactors the way btrfs_ref::real_root and
> btrfs_ref::skip_qgroup are used. Currently the former is used in ref-verify but
> also in order to perform the is_fstree() check on it in delayed-ref core. Given
> the complexity and amount of information that the delayed ref machinery hauls
> around it becomes really non-evident that delrefs really don't care about
> real_root itself but rather only if qgroup processing should happen or not.
> 
> Instead of having the check burried in the core this series changes the data
> flow in such a way that real_root will only be used for ref-verify's operation
> and 'skip_qgroup' will contains the final condition of whether qgroup processing
> should take place for a given delref.
> 
> 
> Nikolay Borisov (5):
>   btrfs: Rename root fields in delayed refs structs
>   btrfs: Rely on owning_root field in btrfs_add_delayed_tree_ref to
>     detect CHUNK_ROOT
>   btrfs: Add additional parameters to
>     btrfs_init_tree_ref/btrfs_init_data_ref
>   btrfs: pull up qgroup checks from delayed-ref core to init time
>   btrfs: make real_root optional

I'll add the branch as-is to for-next so we have some testing coverage,
the suggested changes should not change functionality.
