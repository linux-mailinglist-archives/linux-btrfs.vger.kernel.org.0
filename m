Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96F3505BD7
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Apr 2022 17:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345690AbiDRPux (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Apr 2022 11:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345474AbiDRPuE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Apr 2022 11:50:04 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D39F1AD80
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Apr 2022 08:28:21 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id d198so8242460qkc.12
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Apr 2022 08:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7qj+wLzAkHpxSmzaRTcWTs7O2et9GwKcZLdjjXXnL1A=;
        b=DoqHfAuFjGyol/Og/Yb4elYNIy/mLi+gOTL4zgYkeoxb25zP3/T1oPF7Tw371ljfI6
         N2Vuu26MbG7cxTEKgcP8EHC/DA31c98j9zIRSozXnYezYvDxDunxfNCkDtMClXv3V/uI
         DaGWwDKHJJZZ1CcaAxAINTAUq4hNtI9zXs2Ha3m4LJK00iLFMMxEqIzCtoA6o/pfm0Vu
         4VgH8Y9pPTBdC1o7GXs/bsKhaTzKV2CRhBkDYXxRo9M2WwRT7Qn7u/flaw56jfAPdQgL
         xZqm2LT6gUI+z5IuVNoTvFipWi6LI8/NWq5BUAt3tMbBZ/9VSielWaBcx228dnUlaVy1
         xKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7qj+wLzAkHpxSmzaRTcWTs7O2et9GwKcZLdjjXXnL1A=;
        b=RJ5qI+zeTweAp5pZVXLlClcmT8hc9Vt+3gFXPiED6BxuM/zyK+5A32hmGpU079CEqO
         Om0GpXU20LgmywwdduenWDgo9dbG/1snBQLfs4aj2dCwmSDEh+dCinAtCtIy7p40iAgI
         1toHDz9BRWUIcnWyYlQOBe/UOuq2C5mrobTa91FUa+vYF25xUoax5tv4++BqLeDkFNsG
         6BD0V464WPSOw505RQXXL6IXTQMUuJZ10Hu/33ceI8XgiCMvm4Rdm9Vf0Oh+hDvcDScZ
         LAV+VJK8KvlJFmEAX3Q7cebKeokK6bwhy+sF9rqxpQfRluQUGf2ZbWrT3QRXzz06ezPX
         E5nQ==
X-Gm-Message-State: AOAM531uncbVnN7gXiw+Dw6JfS7IFJpyeSz7mIPK7yYe3jgVC3O8ynZx
        Il1NeX92+3UpqHPY6x0j1E/taQ==
X-Google-Smtp-Source: ABdhPJzLT3tZrbj6gSWzmAIm5Rav/G0Ehq28KyMUjYmucPGiWYrgaxv+C45vUQscrBjQsYqpC8H67A==
X-Received: by 2002:a05:620a:4689:b0:69e:a989:5f4b with SMTP id bq9-20020a05620a468900b0069ea9895f4bmr1798796qkb.452.1650295700333;
        Mon, 18 Apr 2022 08:28:20 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h5-20020ac85845000000b002edfd4b0503sm8152505qth.88.2022.04.18.08.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 08:28:19 -0700 (PDT)
Date:   Mon, 18 Apr 2022 11:28:19 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs-progs: fix an error path which can lead to
 empty device list
Message-ID: <Yl2DkxaFud5Gu5YR@localhost.localdomain>
References: <cover.1650287150.git.wqu@suse.com>
 <9f9bba7ebbf66361ac7741a74704228652b3b4b9.1650287150.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f9bba7ebbf66361ac7741a74704228652b3b4b9.1650287150.git.wqu@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 18, 2022 at 09:10:08PM +0800, Qu Wenruo wrote:
> [BUG]
> With the incoming delayed chunk item insertion feature, there is a super
> weird failure at mkfs/022:
> 
>   ====== RUN CHECK ./mkfs.btrfs -f --rootdir tmp.KnKpP5 -d dup -b 350M tests/test.img
>   ...
>   Checksum:           crc32c
>   Number of devices:  0
>   Devices:
>      ID        SIZE  PATH
> 
> Note the "Number of devices: 0" line, this means our
> fs_info->fs_devices->devices list is empty.
> 
> And since our rw device list is empty, we won't finish the mkfs with
> proper superblock magic, and cause later btrfs check to fail.
> 
> [CAUSE]
> Although the failure is only triggered by the incoming delayed chunk
> item insertion feature, the bug itself is here for a while.
> 
> In btrfs_alloc_chunk(), we move rw devices to our @private_devs list
> first, then in create_chunk(), we move it back to our rw devices list.
> 
> This dance is pretty dangerous, epsecially if btrfs_alloc_dev_extent()
> failed inside create_chunk(), and current profile have multiple stripes
> (including DUP), we will exit create_chunk() directly, without moving the
> remaining devices in @private_devs list back to @dev_list.
> 
> Furthermore, btrfs_alloc_chunk() is expected to return -ENOSPC, as we
> call btrfs_alloc_chunk() to pre-allocate chunks, and ignore the -ENOSPC
> error if it's just a pre-allocation failure.
> 
> This existing error path can lead to the empty rw list seen above.
> 
> [FIX]
> After create_chunk(), unconditionally move all devices in @private_devs
> back to rw device list.
> 
> And add extra check to make sure our rw device list is never empty after
> a chunk allocation attempt.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
