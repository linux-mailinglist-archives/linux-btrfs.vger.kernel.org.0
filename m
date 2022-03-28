Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7659B4E92A0
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Mar 2022 12:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240309AbiC1Kmb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Mar 2022 06:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234923AbiC1Km3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Mar 2022 06:42:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9479F50E30
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Mar 2022 03:40:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E5AA61015
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Mar 2022 10:40:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3696EC004DD;
        Mon, 28 Mar 2022 10:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648464048;
        bh=CQg04Bqq/4y15ew48bGvG00uvEh2fvccD8QouQBcRkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ek508zebJFhfrhUzzlvz0hzz4VKgL2/lljKchH4Pu9gfZesFYMx1bI/AG7KCC7N4Z
         xdwAkYSVTglOaFizD+sCIZmsQvHpXWXXGP3/6QP/MWX6gPtWVZyusyqVAi6nlR+fe9
         UO6nw+nM6lYqeuEiHXd/zaDLeYICpfmixslJimhv9vQh1TIC4hs22Fly+K7oIYMB40
         G1QRVWurB7+pB0s2TPBkKpCZTZ/bQ6a8SDfdHN34D7l+g337gHjCXqPRXXnkKzyFTI
         xA0OrNQbzY4c/sqZl9b6BcHfIrI4NBRz8jPkyfeObD2VqSrARgO9rFdZJrLNdrQ9f7
         8cYn9+h0Bw27w==
Date:   Mon, 28 Mar 2022 11:40:44 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, johannes.thumshirn@wdc.com,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v3 2/3] fs: add check functions for
 sb_start_{write,pagefault,intwrite}
Message-ID: <YkGQrPMhoe64lD1R@debian9.Home>
References: <cover.1648448228.git.naohiro.aota@wdc.com>
 <5a8a19efe9f19b3e11026f57835614731aeeb62d.1648448228.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a8a19efe9f19b3e11026f57835614731aeeb62d.1648448228.git.naohiro.aota@wdc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 28, 2022 at 03:29:21PM +0900, Naohiro Aota wrote:
> Add a function sb_write_started() to return if sb_start_write() is
> properly called. It is used in the next commit.
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  include/linux/fs.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 27746a3da8fd..57fedc4af4a1 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1732,6 +1732,11 @@ static inline bool __sb_start_write_trylock(struct super_block *sb, int level)
>  #define __sb_writers_release(sb, lev)	\
>  	percpu_rwsem_release(&(sb)->s_writers.rw_sem[(lev)-1], 1, _THIS_IP_)
>  
> +static inline bool sb_write_started(struct super_block *sb)

The argument can be made const.

Also, the subject "fs: add check functions for sb_start_{write,pagefault,intwrite}" is
now oudated, since only sb_write_started() is added.

Thanks.

> +{
> +	return lockdep_is_held_type(sb->s_writers.rw_sem + SB_FREEZE_WRITE - 1, 1);
> +}
> +
>  /**
>   * sb_end_write - drop write access to a superblock
>   * @sb: the super we wrote to
> -- 
> 2.35.1
> 
