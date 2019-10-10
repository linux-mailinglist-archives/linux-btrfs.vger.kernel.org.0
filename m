Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB7CD2C3D
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2019 16:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfJJOQf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Oct 2019 10:16:35 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33273 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfJJOQe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Oct 2019 10:16:34 -0400
Received: by mail-qt1-f196.google.com with SMTP id r5so8974176qtd.0
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2019 07:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aVCEq4Xt2SMyq02Zk4Rv7Aph4gFtFdHacCn23HLPOa8=;
        b=DqjAMN4xzufZizU07zH/3cpLwGG+Zezan2/oWMENr31Cj9dP5JYAhJh26L70M1prP7
         1YtxZOSe813I2W5lDvHksIVN6HnAiruA/WP1CoXfOB4IJ9tLPc7udEq9agSD56rmWTg1
         MswtkeXaJ36pOcPS3WF1LooKK6JB7YVtYAWgrPVoXLlfQgJ+qkVax5IOe922JcDPP7aj
         10EjybzgTEGD53J6fF2qxluE+YbBbOpbxbOgfKVMNFi+i+Rsb7DTHbEK8f0yU7Fp4V1c
         sFGrKEbefUo45cnzmcxrAtLOYKdqMnsH2zc7qowv4XxGPsr+YgJ4yeEu9SaYa0jOXHg0
         mHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aVCEq4Xt2SMyq02Zk4Rv7Aph4gFtFdHacCn23HLPOa8=;
        b=ZDs8360z8qKPj1qMN0un+m2qf2cDL9O0UkV+UyfBQjSmbd4bRtGAnXqOlZqWv029VG
         OhlmVsNNzFFFCRVeNrO0KinGSlndaia7dPGgjfzr8vY1V1kL8w8q3haKMKvAn70v4wkQ
         Y76GRbzxzI3qbS1xkG0JhLu5X70YdJI/zM8JZbBPqbOw92OHbTob5/T4ojopbBQ55a8U
         tTuTPsdmMKFDLMK0QyyQr3I+3BumXtGujmmSRXSG6quClG6zf43DjPXbRK4G+KGtLQiw
         VjvB5fxLJwk+5O8g9RZclIthzN27DOt9mZ6E1PzDzpBjkKuP2p3QWqYG9yN3/jrvX3o/
         QWzA==
X-Gm-Message-State: APjAAAWZZHI1Ehwa0Miggpgo6ZC9/Nhax0TIk5NA98a4ydHQ3gwrWxSA
        Ia5mPa3KJanA67CCGb+acG9TQQ==
X-Google-Smtp-Source: APXvYqy+Rqqi/Loh5NMOl16asShGO8K15OggVkk8ZXIKCuc9r9iSWqugPbbBvZh6Q4z+Nf3paT75kg==
X-Received: by 2002:ac8:738f:: with SMTP id t15mr10874237qtp.219.1570716992055;
        Thu, 10 Oct 2019 07:16:32 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::18ce])
        by smtp.gmail.com with ESMTPSA id z200sm2834356qkb.5.2019.10.10.07.16.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 07:16:31 -0700 (PDT)
Date:   Thu, 10 Oct 2019 10:16:30 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 04/19] btrfs: keep track of cleanliness of the bitmap
Message-ID: <20191010141629.xzlwkf6tn57dsdnv@macbook-pro-91.dhcp.thefacebook.com>
References: <cover.1570479299.git.dennis@kernel.org>
 <4cdbe31836b701c2c134c8484bb3531f7024031d.1570479299.git.dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cdbe31836b701c2c134c8484bb3531f7024031d.1570479299.git.dennis@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 07, 2019 at 04:17:35PM -0400, Dennis Zhou wrote:
> There is a cap in btrfs in the amount of free extents that a block group
> can have. When it surpasses that threshold, future extents are placed
> into bitmaps. Instead of keeping track of if a certain bit is trimmed or
> not in a second bitmap, keep track of the relative state of the bitmap.
> 
> With async discard, trimming bitmaps becomes a more frequent operation.
> As a trade off with simplicity, we keep track of if discarding a bitmap
> is in progress. If we fully scan a bitmap and trim as necessary, the
> bitmap is marked clean. This has some caveats as the min block size may
> skip over regions deemed too small. But this should be a reasonable
> trade off rather than keeping a second bitmap and making allocation
> paths more complex. The downside is we may overtrim, but ideally the min
> block size should prevent us from doing that too often and getting stuck
> trimming
> pathological cases.
> 
> BTRFS_FSC_TRIMMING_BITMAP is added to indicate a bitmap is in the
> process of being trimmed. If additional free space is added to that
> bitmap, the bit is cleared. A bitmap will be marked BTRFS_FSC_TRIMMED if
> the trimming code was able to reach the end of it and the former is
> still set.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>

I went through and looked at the end result and it appears to me that we never
have TRIMMED and TRIMMING set at the same time.  Since these are the only two
flags, and TRIMMING is only set on bitmaps, it makes more sense for this to be
more like

enum btrfs_trim_state {
	BTRFS_TRIM_STATE_TRIMMED,
	BTRFS_TRIM_STATE_TRIMMING,
	BTRFS_TRIM_STATE_UNTRIMMED,
};

and then just have enum btrfs_trim_state trim_state in the free space entry.
This makes things a bit cleaner since it's really just a state indicator rather
than a actual flags.  Thanks,

Josef
