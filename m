Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0341C64D309
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Dec 2022 00:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiLNXKx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Dec 2022 18:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLNXKv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Dec 2022 18:10:51 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927AB2611
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Dec 2022 15:10:50 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so855978pjo.3
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Dec 2022 15:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sfUK4j3uPSy8USYGH1WaBKFFv+FcT9DPrt0X+dJMTPs=;
        b=cGHJXZ7+kyvGSVT2OxZJ+Jak0y2wfSb6LWPex+ngGJ8Tu3SIAg7xRRWfX1C2WHhhGL
         7Ry8iM8UO7Clz11UW7kHc5i2VR3RNt/SOyAXzXn9qWcmuRGRz3pSwbDeNUVToTat8oo6
         EJNqgHPLfZcPylGQ8uYwR5SamH1F51HUyj0mOwIWHc8yUc/a/usMejiDPfPBvvpe2gOc
         /B4BTGH6TJhwb+JOs6UXtePadcmVKAocK94oAl9pBXh5bdIAY6VkTorkgeOy4eIudSYp
         o0jMzhNkhgRAjCA+6PjoIIraN4O1TW0oNJ4bqsBzlyaQdWs0nU8lfoL5pasMX84NTPRF
         UWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sfUK4j3uPSy8USYGH1WaBKFFv+FcT9DPrt0X+dJMTPs=;
        b=oQtLh1Kw7D2wrXzx8ERA350pMVyLI74Ui21NQCvh4+qZ8HpH3Dr01jasbsHlEIobzg
         Ul5j6oAi76RA1u9G6/7FnydQe1ZnuO0GhXHmQwGGdq7l/G3KknU/EVsnr051iSeEa747
         cK6Kwgh27SahHV3CgSVMGB2HFdSfBktif0blvqDhvcEZ+2jCO5G/WIWjq8U5/soJZEWN
         P/sDrTVcvEbNmtzEXNaoFzu8wM9zaV3oUz7OVPstq7hSfYSviPqAoiARqNIzNcEcbMSz
         qYc2bp8JQqtckYHQvNWzUhmGdibAqZZAcqeEH4G5IxnmohD63CqjtAeVTjgN8D/Misdg
         x48Q==
X-Gm-Message-State: ANoB5pn6S0LFwspiJHhD2t9wjUiUsqRAesqMX9Qe0Dt/wT7dTIMy+ihV
        /T407L32nFvBIg3eaORc4ciVRw==
X-Google-Smtp-Source: AA0mqf7404FQ+x51OsOEaz7mEzZOPK6J+OFvmRUDGC16ye2topm2HL7s7i7K+EGGKyoECUiGW5VY+Q==
X-Received: by 2002:a05:6a20:3b01:b0:ac:2559:35f6 with SMTP id c1-20020a056a203b0100b000ac255935f6mr30989367pzh.28.1671059450001;
        Wed, 14 Dec 2022 15:10:50 -0800 (PST)
Received: from dread.disaster.area (pa49-181-138-158.pa.nsw.optusnet.com.au. [49.181.138.158])
        by smtp.gmail.com with ESMTPSA id rm10-20020a17090b3eca00b00218fba260e2sm1870310pjb.43.2022.12.14.15.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 15:10:49 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1p5ati-008W7d-Nw; Thu, 15 Dec 2022 10:10:46 +1100
Date:   Thu, 15 Dec 2022 10:10:46 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 0/4] fsverity cleanups
Message-ID: <20221214231046.GB1971568@dread.disaster.area>
References: <20221214224304.145712-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214224304.145712-1-ebiggers@kernel.org>
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,SUSPICIOUS_RECIPS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 14, 2022 at 02:43:00PM -0800, Eric Biggers wrote:
> This series implements a few cleanups that have been suggested 
> in the thread "[RFC PATCH 00/11] fs-verity support for XFS"
> (https://lore.kernel.org/linux-fsdevel/20221213172935.680971-1-aalbersh@redhat.com/T/#u).
> 
> This applies to mainline (commit 93761c93e9da).
> 
> Eric Biggers (4):
>   fsverity: optimize fsverity_file_open() on non-verity files
>   fsverity: optimize fsverity_prepare_setattr() on non-verity files
>   fsverity: optimize fsverity_cleanup_inode() on non-verity files
>   fsverity: pass pos and size to ->write_merkle_tree_block
> 
>  fs/btrfs/verity.c        | 19 ++++-------
>  fs/ext4/verity.c         |  6 ++--
>  fs/f2fs/verity.c         |  6 ++--
>  fs/verity/enable.c       |  4 +--
>  fs/verity/open.c         | 46 ++++---------------------
>  include/linux/fsverity.h | 74 +++++++++++++++++++++++++++++++++-------
>  6 files changed, 84 insertions(+), 71 deletions(-)

The whole series looks fairly sane to me.

Acked-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com
