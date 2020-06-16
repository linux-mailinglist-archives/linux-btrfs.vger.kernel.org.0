Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20EC01FBF0F
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jun 2020 21:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730349AbgFPTcL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Jun 2020 15:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729989AbgFPTcL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Jun 2020 15:32:11 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556E7C061573
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Jun 2020 12:32:10 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id dp10so10071396qvb.10
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Jun 2020 12:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=04HR8OX5a52luerMofHovt4vrv/i9p7dWtLoUbbUXDU=;
        b=0qB3hz0ISlUo5JLgsgT8P9RSy81gvagNwr4vRtpWDurl4ingiyzPVQ3t0iaBDxm+QB
         KdVuUqgT29+bhitAF/n0Q/AC9fZBAST1EX8DEGEnr/G/XSgVYa2aWPQHIVXkIDPHo/Dp
         4ECKC45gp/OI61GLJ0fDJWF8tQe7HxyZhyiyq5eoONex537ynqKOUGE50oiktsXS6JpL
         +K4bx7Ukosjjr+zl5DIugR+xay6DnCYZ1MsDjkfszIXZGn+6kh9GVFNv3+GsmhSAUHn7
         YSTDAbil/65+Vnbgn8vnvZzeoi5airsUxeyJGBflqgMbtzNrJBihmozXouYQMVB19c3h
         Tadw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=04HR8OX5a52luerMofHovt4vrv/i9p7dWtLoUbbUXDU=;
        b=ajv6YNGny0cVtiKdbgm5XEhKrkumIxymymcMcYEohoiRCxBX65N6OzUNEKN9l3VjgE
         F1FCAP0OgC27qUL4lQ8ujy6fYFviN+ltMnnb+tsg36UWpdu7acufzojCbMgbRt0/uHpQ
         T8M02ZdB/8q9AUOAf21AHVw1JhULfvRGLj8XJ9fSW7rKT4F0IrY6HHKyEO0A0M0telvy
         xmpVUANGuJRajrd6qe5PVqrSsZg5DGnJ2G9R4V3hASH7PQ12k2GvNK8uy9H1nD1Wc4c0
         9BMR3Cr5kQ39qltFe4A58eWd+9QVsKcY3FspMyjYMCLK+mul1RSlV2/3Bl6CKbsKDmR6
         zN7A==
X-Gm-Message-State: AOAM533du6qFHJApl6f6X1T2imxkEg3chxHcy9YOGNLu+lG/ixzBSb2R
        fGavBJ0OQGsKzRsHuidIhRaoAI7UcJHUaQ==
X-Google-Smtp-Source: ABdhPJwWjSU1nlbQVTJzkJdC3cpcz4TlZXxuQ5/tWJOmeaEeVRdiUyJRorYM4NEwEKgS28z9aw3+Xw==
X-Received: by 2002:a05:6214:a72:: with SMTP id ef18mr4057814qvb.239.1592335929259;
        Tue, 16 Jun 2020 12:32:09 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f43sm17229187qte.58.2020.06.16.12.32.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 12:32:08 -0700 (PDT)
Subject: Re: [PATCH 4/4] Btrfs: fix RWF_NOWAIT writes blocking on extent locks
 and waiting for IO
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20200615174939.15004-1-fdmanana@kernel.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <17c55044-ccba-b031-9589-f996c2a69f4e@toxicpanda.com>
Date:   Tue, 16 Jun 2020 15:32:07 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200615174939.15004-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6/15/20 1:49 PM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> A RWF_NOWAIT write is not supposed to wait on filesystem locks that can be
> held for a long time or for ongoing IO to complete.
> 
> However when calling check_can_nocow(), if the inode has prealloc extents
> or has the NOCOW flag set, we can block on extent (file range) locks
> through the call to btrfs_lock_and_flush_ordered_range(). Such lock can
> take a significant amount of time to be available. For example, a fiemap
> task may be running, and iterating through the entire file range checking
> all extents and doing backref walking to determine if they are shared,
> or a readpage operation may be in progress.
> 
> Also at btrfs_lock_and_flush_ordered_range(), called by check_can_nocow(),
> after locking the file range we wait for any existing ordered extent that
> is in progress to complete. Another operation that can take a significant
> amount of time and defeat the purpose of RWF_NOWAIT.
> 
> So fix this by trying to lock the file range and if it's currently locked
> return -EAGAIN to user space. If we are able to lock the file range without
> waiting and there is an ordered extent in the range, return -EAGAIN as
> well, instead of waiting for it to complete. Finally, don't bother trying
> to lock the snapshot lock of the root when attempting a RWF_NOWAIT write,
> as that is only important for buffered writes.
> 
> Fixes: edf064e7c6fec3 ("btrfs: nowait aio support")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

I'd rather the snapshot lock change be separate, because I had to go look and 
see why that was ok.  But only do it if you have to respin or something,

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
