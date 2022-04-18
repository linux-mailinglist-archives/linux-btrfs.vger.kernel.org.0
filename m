Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BE0505BEE
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Apr 2022 17:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345950AbiDRPwH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Apr 2022 11:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345903AbiDRPvu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Apr 2022 11:51:50 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC8C12759
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Apr 2022 08:30:59 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id o18so10253548qtk.7
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Apr 2022 08:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hxMpVA+vY3er/hLF7xfbfNHgtcZ8KeWqt4rWVE6pHlU=;
        b=r5Cg80JFVujoiSWJc87j7ZfJ5XvMet94oEVliiapS8rgEMkHoJObwQhuuHGqbCa7O7
         +5K5XOh8KFLDFov1wgkBqeIqlIahu7cq4limW4EpVbmUapbeV20VWFLx6SwVVBnkofEU
         CoTDv5hPtZFX9SWzyn/SqBRvOUFlrdtovbc1Y8Zo02214Mem1wFVrxZL9hR71LQRXNku
         mVz6UZiWTis8bs9d7zFNHGp6BzL5RBYmWA9oe5YLYjtzMGPQLludt+PJuauyP5ahB4oO
         cT7M/jOdUykpjqNySCQM7615S+OpFnw0ytafVf4Q+MuG1p4jnBPfFoGgCbGY9sazOsDn
         A88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hxMpVA+vY3er/hLF7xfbfNHgtcZ8KeWqt4rWVE6pHlU=;
        b=eS7FBOwKdHXxtXgvRtuTS6U7aJE6Gx0eM+gyK5XIuN672GGE+P/8pEs0geldhaUD/L
         JbMHIZRxTy6j66YUqvc5QwJirRtFpONneQeK0dnEdb9WtzgdhT6IaTbSo6SHi2hgyMTF
         Z0KGoR+2rUXQCW+7oPsi9BQgrKiQoy2J/IQefcagefzcXu1+xh+hjMA9MMUczxoNAfdA
         N8x/SSLvWYt1JLDkKyoRbtjyWtneGYSmTatdBqb+Xb4e9+z9644DuZ8uYbujmaEQi3I1
         liQeagEfGbhWPX2cRM+CdqmHSZ428x8302ZcfC7i9wJjE0UqUcGD3oPpx1qWOGnvsJvV
         beUg==
X-Gm-Message-State: AOAM531MyEZJhEcvpW7Vn8fzrJa6zoJpSMLE9+nihIfK507A+gtjggqh
        DUvJ1dQK/g8pKZ9Y7BwdtXVJMU5b5fHMAQ==
X-Google-Smtp-Source: ABdhPJwOCwfap+ZJ1bZkFuB+0A9a/fRkm4kb/FrPK8r7uSRr4T1MUvoSCIfe3RX1pVDnI39E/5siXw==
X-Received: by 2002:ac8:7e8a:0:b0:2f1:ebd6:b28b with SMTP id w10-20020ac87e8a000000b002f1ebd6b28bmr7532218qtj.286.1650295858062;
        Mon, 18 Apr 2022 08:30:58 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n8-20020ac85a08000000b002f1fc230725sm2483362qta.31.2022.04.18.08.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 08:30:57 -0700 (PDT)
Date:   Mon, 18 Apr 2022 11:30:55 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: do not allow setting seed flag on fs with
 dirty log
Message-ID: <Yl2ELwGRRE1OTj3E@localhost.localdomain>
References: <4022d9f87067124c26bb83d4bba1970c954cdf50.1650022504.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4022d9f87067124c26bb83d4bba1970c954cdf50.1650022504.git.wqu@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 15, 2022 at 07:37:43PM +0800, Qu Wenruo wrote:
> [BUG]
> The following sequence operation can lead to a seed fs rejected by
> kernel:
> 
>  # Generate a fs with dirty log
>  mkfs.btrfs -f $file
>  mount $dev $mnt
>  xfs_io -f -c "pwrite 0 16k" -c fsync $mnt/file
>  cp $file $file.backup
>  umount $mnt
>  mv $file.backup $file
> 
>  # now $file has dirty log, set seed flag on it
>  btrfstune -S1 $file
> 
>  # mount will fail
>  mount $file $mnt
> 
> The mount failure with the following dmesg:
> 
> [  980.363667] loop0: detected capacity change from 0 to 262144
> [  980.371177] BTRFS info (device loop0): flagging fs with big metadata feature
> [  980.372229] BTRFS info (device loop0): using free space tree
> [  980.372639] BTRFS info (device loop0): has skinny extents
> [  980.375075] BTRFS info (device loop0): start tree-log replay
> [  980.375513] BTRFS warning (device loop0): log replay required on RO media
> [  980.381652] BTRFS error (device loop0): open_ctree failed
> 
> [CAUSE]
> Although btrfs will replay its dirty log even with RO mount, but kernel
> will treat seed device as RO device, and dirty log can not be replayed
> on RO device.
> 
> This rejection is already the better end, just imagine if we don't treat
> seed device as RO, and replayed the dirty log.
> The filesystem relying on the seed device will be completely screwed up.
> 
> [FIX]
> Just add extra check on log tree in btrfstune to reject setting seed
> flag on filesystems with dirty log.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Can we get a progs test for this as well?

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
