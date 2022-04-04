Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76BBB4F1C38
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Apr 2022 23:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379591AbiDDVZ4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Apr 2022 17:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379132AbiDDQhB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Apr 2022 12:37:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4068D192B5
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Apr 2022 09:35:05 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 022F41F390;
        Mon,  4 Apr 2022 16:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649090104;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vQfSG+ldkJIiZy66jwWqPoGQOognbVzMxZG8R3wRpM0=;
        b=hD6wRBqSqeX8JhIdndexzCyM5vhq4XlnYwFl+7Z7e95L5zwuTgExEBSnYtnLOzGvbJcQkH
        MWwkYJ3T60GaZXPluTdcj34a7A7mhTAtrpwQkG4FqcmS6ROgs6/xQ8PmFQCdQGbM/Wzuq+
        LgJ/N8H5KpuIYKeab4PbSsgTJf4h3qU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649090104;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vQfSG+ldkJIiZy66jwWqPoGQOognbVzMxZG8R3wRpM0=;
        b=VI+kzyZX1AHHLS4xuFM400/jBpeawuGKplbjC9qh1ko72trHtn88fO39MJZkqe54zASwDp
        2hdNH7U9EyU/VvBg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id EBF88A3B88;
        Mon,  4 Apr 2022 16:35:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 05295DA80E; Mon,  4 Apr 2022 18:31:02 +0200 (CEST)
Date:   Mon, 4 Apr 2022 18:31:02 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Stefan Roesch <shr@fb.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v1 0/3] btrfs: add sysfs switch to get/set metadata size
Message-ID: <20220404163102.GR15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Stefan Roesch <shr@fb.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20220208193122.492533-1-shr@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208193122.492533-1-shr@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 08, 2022 at 11:31:19AM -0800, Stefan Roesch wrote:
> The btrfs allocator is currently not ideal for all workloads. It tends
> to suffer from overallocating data block groups and underallocating
> metadata block groups. This results in filesystems becoming read-only
> even though there is plenty of "free" space.
> 
> This patch adds the ability to query and set the metadata allocation
> size.
> 
>   Patch 1: btrfs: store chunk size in space-info struct.
>     Store the stripe and chunk size in the btrfs_space_info structure
>     to be able to expose and set the metadata allocation size.
>     
>   Patch 2: btrfs: expose chunk size in sysfs.
>     Add a sysfs entry to read and write the above information.
>     
>   btrfs: add force_chunk_alloc sysfs entry to force allocation
>     For testing purposes and under a debug flag add a sysfs entry to
>     force a space allocation.

Sorry for late response, I'm now reviewing the patches, there are still
some things to fix, commends under the patches.
