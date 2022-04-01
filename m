Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71A74EEF79
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Apr 2022 16:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346863AbiDAO2W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Apr 2022 10:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346972AbiDAO2S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Apr 2022 10:28:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59062282B1E
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 07:26:21 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B1E801FD00;
        Fri,  1 Apr 2022 14:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648823180;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MYijVkg1qqV2xFzVT8etLjLLxnIyhkOydSfh07+zhdQ=;
        b=q3E+oB7QW03i01+T4VF7YvAc9qEk1kAWVOsb+MQOa10HGvpHgq8ptgd7lL2QrXNNqUWwjC
        TRk/LoB2YHfJTRmjl1BXADVnvhhwNQ+XoLSj/qWkJpVrHNGHkIfuBs3sv0IBTxv+2UGxPq
        u5PWgh3mZqIaj/YmaI9feWKy7NVk1KA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648823180;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MYijVkg1qqV2xFzVT8etLjLLxnIyhkOydSfh07+zhdQ=;
        b=yl8BJNeq/yQ+I6jARMpbuvG3Vs6SKBsumtyEfq4bHJWiMsy6iB8XM01cb7I9bySgvw5hmE
        QHvruwN2fPcmRfCg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 77C23A3BA0;
        Fri,  1 Apr 2022 14:26:20 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 72AC8DA7F3; Fri,  1 Apr 2022 16:22:21 +0200 (CEST)
Date:   Fri, 1 Apr 2022 16:22:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, johannes.thumshirn@wdc.com
Subject: Re: [PATCH v2 0/2] btrfs: zoned: activate new BG only from extent
 allocation context
Message-ID: <20220401142221.GK15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, johannes.thumshirn@wdc.com
References: <cover.1647936783.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1647936783.git.naohiro.aota@wdc.com>
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

On Tue, Mar 22, 2022 at 06:11:32PM +0900, Naohiro Aota wrote:
> In btrfs_make_block_group(), we activate the allocated block group,
> expecting that the block group is soon used for the extent allocation.
> 
> With a lot of IOs, btrfs_async_reclaim_data_space() tries to prepare
> for them by pre-allocating data block groups. That preallocation can
> consume all the active zone counting. It is OK if they are soon
> written and filled. However, that's not the case. As a result, an
> allocation of non-data block groups fails due to the lack of an active
> zone resource.
> 
> This series fixes the issue by activating a new block group only when
> it's called from find_free_extent(). This series introduces
> CHUNK_ALLOC_FORCE_FOR_EXTENT in btrfs_chunk_alloc_enum to distinguish
> the context.
> 
> --
> Changes
> - v2
>   - Fix a flipped condition
> 
> Naohiro Aota (2):
>   btrfs: return allocated block group from do_chunk_alloc()
>   btrfs: zoned: activate block group only for extent allocation

Added to misc-next, thanks.
