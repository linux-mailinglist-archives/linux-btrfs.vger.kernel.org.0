Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618BE798962
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 16:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244281AbjIHO6r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 10:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbjIHO6r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 10:58:47 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE4B1BF1
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 07:58:43 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-76dc77fd024so124918185a.3
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Sep 2023 07:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1694185122; x=1694789922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EdNZL89ani32rF+OWwgNqjhoHPD6xBG3D9Foe6SvYMY=;
        b=yr48hHzI8961AyaOlMniBll5O0HPnXBDkoEOWYIejCB3e0ZrWx/184NDzvkeV3pmgC
         cWimFiUbpS6kYY7647SQO0K8GwB8wSHM22r/IdzgdAdMqzxWhp//4i7hVJwNV4KE6LAY
         SdVZog4pJUwS9r7G8Cb8mjp+0Jul69nDESu6exRqUHZMMSNJ252uKoliIJkoNpQWgDs9
         x4bzIFgvwLuwuCd3/TG2oYChQjJPt88Eol9VJXlA8x6rzVQxwbpZ2VJ9rKQb2RPJj+2M
         twPc64L6tC/sTG0d0ZQflsTgyKrhR9uA9W0o7UwnjCkhSNt69uZOxuzhHTm9FjIGzb3N
         xeig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694185122; x=1694789922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdNZL89ani32rF+OWwgNqjhoHPD6xBG3D9Foe6SvYMY=;
        b=HKRINlgLXBchRQMEQajWjcycb7IYAaWgrN+wb2LyszvUhV3XWjF+llWrlMi3PP1AwM
         3sUSO/+Q60eo4ixkRfY+EHxfOcLCWnnwajxViGzlC4LTJ3DME+Q5jna5sfWig9FNiWdR
         +CHHWpQljSLwty6cIgDc+7E4GqpV1IneBcBb/fiMrrvBeP53XGpiPpIJJKIuWzL4KvR/
         FsyZi6LE+9TOrxDxYxKHqePQZCvq6pRUH3YoDi4GcZZKFMRqPVi/eE0rtYOwbRBVKHdC
         1rpt8iQ9zcHfVwNBvUrzXvPksA+lUdHEgecwKQv3tR2rWVJK3vBxZ/0bjRQBq/E6bMZK
         NnkA==
X-Gm-Message-State: AOJu0Ywe7nzMAlQHDSXUfaSD8ojSliJntM7mkigz2Xx05sxKLVP6yRYQ
        ykj40QGOB2R6u8chZSHiV4XohDeEI/E7Ztbw4HhT2Q==
X-Google-Smtp-Source: AGHT+IFlopMJP3RV24poA1tRFSyALcCPPh1qAsFtfszqtilcaHlO/Ga1SlAux2WV2aJh/CoJPtHzqA==
X-Received: by 2002:a05:620a:318c:b0:76f:d8b:d6bf with SMTP id bi12-20020a05620a318c00b0076f0d8bd6bfmr3213246qkb.22.1694185122657;
        Fri, 08 Sep 2023 07:58:42 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id u14-20020a05620a120e00b0076d1e149701sm631831qkj.115.2023.09.08.07.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 07:58:42 -0700 (PDT)
Date:   Fri, 8 Sep 2023 10:58:41 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 03/21] btrfs: pass a space_info argument to
 btrfs_reserve_metadata_bytes()
Message-ID: <20230908145841.GD1977092@perftesting>
References: <cover.1694174371.git.fdmanana@suse.com>
 <ebcb3b7f9426e28325f857a4ace3c29d2331274b.1694174371.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebcb3b7f9426e28325f857a4ace3c29d2331274b.1694174371.git.fdmanana@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 08, 2023 at 01:09:05PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We are passing a block reserve argument to btrfs_reserve_metadata_bytes()
> which is not really used, all we need is to pass the space_info associated
> to the block reserve, we don't change the block reserve at all.
> 
> Not only it's pointless to pass the block reserve, it's also confusing as
> one might think that the reserved bytes will end up being added to the
> passed block reserve, when that's not the case. The pattern for reserving
> space and adding it to a block reserve is to first reserve space with
> btrfs_reserve_metadata_bytes() and if that succeeds, then add the space to
> a block reserve by calling btrfs_block_rsv_add_bytes().
> 
> Also the reverse of btrfs_reserve_metadata_bytes(), which is
> btrfs_space_info_free_bytes_may_use(), takes a space_info argument and
> not a block reserve, so one more reason to pass a space_info and not a
> block reserve to btrfs_reserve_metadata_bytes().
> 
> So change btrfs_reserve_metadata_bytes() and its callers to pass a
> space_info argument instead of a block reserve argument.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
