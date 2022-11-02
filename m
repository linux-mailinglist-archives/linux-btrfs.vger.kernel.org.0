Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9723F61646C
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Nov 2022 15:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbiKBOGS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Nov 2022 10:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbiKBOGQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Nov 2022 10:06:16 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEE7B1EE
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Nov 2022 07:06:12 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id e15so7430373qts.1
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Nov 2022 07:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qHBf44+0hIHrMo5IKfWPOYuRgZJZUzs8c34hHRujhdY=;
        b=q3x/X3MFiMn1M05etC4hjAimlrSd8cw9esvDDXu5rdtY338dRUj3AnhAMUj6hR1weW
         WB1MF6+l/aoD/TBpdZZWXxS7spr6XrKERjbeg0Gdw3+Sq4gkYcSUTyibaHKq82sjgWOC
         MF0unYpxRRCPwYeCwVqFaA43r+nAavz8BCnd7wdM8Sn3aJNCrmqBJG+v2IhNDeh9pptF
         Pq9zeLhSvP3FnzGOqxZLHYAF+QWQBeOvjjtA1YIpVjiVNBGtQ81YupJoqEowENxToyhZ
         VJ+b6X6LtgNQjlfJuXVUaPnuQyBmB9j6yqYmP40Faaf15PJDkR6rPjHdA8ZNjqbTH6Ps
         hvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHBf44+0hIHrMo5IKfWPOYuRgZJZUzs8c34hHRujhdY=;
        b=kMhonOEZvUz8PemgCbAkojwPF+PvJT7eqMV2pA1BdHN5hsWim8M2nNIeoVmm6D6+Pl
         dvL3KVkg2pB/c8X+Ox7+dWwiQ1UVVwDYqnz54LCN1QrU64Hd24iP0/4S8gNivV+effQi
         9lkDIA9nioSgqkHxbyRShckdDCut4iizC6d97E2NJW9Z98ef1sVDX4oYRcT/AqFYRlH3
         ShHIsXzMPS1tm/AUIsxWwVneNBrgzHV2O/OCUz1Nv5Y0rZidQukdDJ2tCtJ1uAWT+KmQ
         ulWlbBBchF/5PuRCMr5SvG5YF0n+9zhn+wMv+nZqY/OJQpsCBK+55jqNN0aKJO4lKxeo
         y2HA==
X-Gm-Message-State: ACrzQf2Z+2fqz1AS7KDy4510o2oGg+B9znCnc2xGcfhzgIZUf89NqGu7
        XGRoZXQN/5/Git7jk99vl3oP+Q==
X-Google-Smtp-Source: AMsMyM5TDw22DYFHlvFo3+cL35k50Ah2925CRZaqLTD4OsfMBtRf6Y6O2SPdRLSJXF0JyXHyXG4U+Q==
X-Received: by 2002:a05:622a:ca:b0:3a5:24d2:9295 with SMTP id p10-20020a05622a00ca00b003a524d29295mr14147810qtw.300.1667397971315;
        Wed, 02 Nov 2022 07:06:11 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id l2-20020a37f902000000b006cea2984c9bsm8477568qkj.100.2022.11.02.07.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 07:06:10 -0700 (PDT)
Date:   Wed, 2 Nov 2022 10:06:10 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: fixes for nowait buffered writes
Message-ID: <Y2J5UnPxu4BvXJj8@localhost.localdomain>
References: <cover.1667392727.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1667392727.git.fdmanana@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 02, 2022 at 12:46:34PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> A couple fixes for the recently added support for nowait buffered writes.
> Trivial stuff, one of the bugs was reported sometime ago by the lkp test
> robot.
> 
> Filipe Manana (2):
>   btrfs: fix nowait buffered write returning -ENOSPC
>   btrfs: fix inode reserve space leak due to nowait buffered write
> 
>  fs/btrfs/file.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef 
