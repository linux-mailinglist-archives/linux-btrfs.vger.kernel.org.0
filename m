Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5292C4E489D
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Mar 2022 22:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236455AbiCVVsQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Mar 2022 17:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236457AbiCVVsH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Mar 2022 17:48:07 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8145FF1D
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 14:46:20 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id ke15so5806247qvb.11
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 14:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LKx7aTf4N2Dk8THFGun6pyZ/8KZeTLDyrbOjT1cCE0A=;
        b=7/JM+dWbT6GZmjJQe+eA3KlxWPHcHSHpD2Z2aUO2lHlDpzyWZZBYUlNQ9OdmlHFVN6
         fFYNtlwj1vLbaz20VByQvTueoOusL4FdxapqHRvkZtagUcmVk+3yjlhM6y93RVTYCiIm
         Ao8iHqHcEHG3ekyUI16xODIuur7PYvYmeRM27FbVrx/JJjMzcPgJFD0QmizPNsLrw/Mm
         VdDF52BMRIM4wgGs7vf5oDwGe3aSA6ED+OizovooeMVEJDB6Sw7CTmADp8lM4i/Y8jHr
         CdcoXV5Yuquf1d44lISmhjMpp0X7z9CcWUs7le1TLFqZtqX+5yVYKNWi1V1/fG2qC5/h
         5nGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LKx7aTf4N2Dk8THFGun6pyZ/8KZeTLDyrbOjT1cCE0A=;
        b=YVFnzVoJg+nYAcGOUsPLfYCKc6lRJ1csS0KTiiHdssQ/Iku8vuqxwnROSjo8zulo2h
         vrbKcn8N9uiT5z/E5O6HtWr+x8KhpStSzXIXj+BlcuUkUM4xNoy6bagAezIQwus1vWYR
         Nvgqu98gxQT5ThU6xmryc9owZgyyeE3uOMuJ2VT8YjcaHlrbrNy47DsKChdi/2Ci25eu
         dMfG/As7BRosPthFqBCgrmWXKbeFL+C8fTxxU40Pt3sDyuBmn0Gwa0QyReDQ2Q0um2Jg
         ke3L32obUR3GPIf2Mq5rDFsZuWLMi2c+RQww5A8jT+Jsuy+fLniRD1ClYKXn4AE0EOp6
         Yxyg==
X-Gm-Message-State: AOAM532A8SyqI9dZmHyZFCqWPYJehGJHVa8EehqChnucXRh3WYDWUmtT
        Uhc2YtCMX6Sub5qLalG+pisHKw==
X-Google-Smtp-Source: ABdhPJxe9WbohK8Hjj990+8/qO10c22Z8GEFQGNy/D+9AB0i+sMf671Mb3eU6cm7fCkouZi+81wTaA==
X-Received: by 2002:a05:6214:2266:b0:435:ab16:1eab with SMTP id gs6-20020a056214226600b00435ab161eabmr21212147qvb.17.1647985579492;
        Tue, 22 Mar 2022 14:46:19 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f14-20020ac8068e000000b002dd1bc00eadsm13865968qth.93.2022.03.22.14.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 14:46:19 -0700 (PDT)
Date:   Tue, 22 Mar 2022 17:46:17 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: do not clear read-only when adding sprout device
Message-ID: <YjpDqWNlNqLTV3ZT@localhost.localdomain>
References: <16c05d39566858bb8bc1e03bd19947cf2b601b98.1647906815.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16c05d39566858bb8bc1e03bd19947cf2b601b98.1647906815.git.boris@bur.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 21, 2022 at 04:56:17PM -0700, Boris Burkov wrote:
> If you follow the seed/sprout wiki, it suggests the following workflow:
> 
> btrfstune -S 1 seed_dev
> mount seed_dev mnt
> btrfs device add sprout_dev
> mount -o remount,rw mnt
> 
> The first mount mounts the FS readonly, which results in not setting
> BTRFS_FS_OPEN, and setting the readonly bit on the sb. The device add
> somewhat surprisingly clears the readonly bit on the sb (though the
> mount is still practically readonly, from the users perspective...).
> Finally, the remount checks the readonly bit on the sb against the flag
> and sees no change, so it does not run the code intended to run on
> ro->rw transitions, leaving BTRFS_FS_OPEN unset.
> 
> As a result, when the cleaner_kthread runs, it sees no BTRFS_FS_OPEN and
> does no work. This results in leaking deleted snapshots until we run out
> of space.
> 
> I propose fixing it at the first departure from what feels reasonable:
> when we clear the readonly bit on the sb during device add. I have a
> reproducer of the issue here:
> https://raw.githubusercontent.com/boryas/scripts/main/sh/seed/mkseed.sh
> and confirm that this patch fixes it, and seems to work OK, otherwise. I
> will admit that I couldn't dig up the original rationale for clearing
> the bit here (it dates back to the original seed/sprout commit without
> explicit explanation) so it's hard to imagine all the ramifications of
> the change.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Can we get this turned into a fstest please?

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
