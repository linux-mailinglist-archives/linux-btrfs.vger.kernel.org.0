Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789874C7AC4
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 21:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiB1Umk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Feb 2022 15:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiB1Umf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Feb 2022 15:42:35 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64382252A
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Feb 2022 12:41:55 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id ba20so14688416qvb.1
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Feb 2022 12:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZHoT4YkDpxrU7Vyv15+4IoJxGiHGy+fxfQCPVHMyNlA=;
        b=IbMt+hmssmUwWFZCBD4jXXibUd/GYg4PUPVQyPb7shcvyXk4zvqUPCNEs6i52K84Qg
         51DB/ywRU7R5gkGz3pJRDfPBUZqVCWAWGn16ccopuaHNjJ4uYJoHpGNTOTI8fyXT4XLS
         26DGDC5O1hSenVBvuswkw94yp2QdmzEoa9XtFqPoE6owUUUjKC1WYn47SXqB5JHD5ZyX
         vYSFkRxJDCu9Pwc1im4EmuS7rPP39U4ZpOg5HXLN5dB8VbEusUggrB/IZI2uMtLyrNYY
         dxxseV8oklAgTLfjcBlgB2t9om8zJLVqNQm893NPoX8xRdyTYVqKdMtwkGRp6P2StKLW
         4F8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZHoT4YkDpxrU7Vyv15+4IoJxGiHGy+fxfQCPVHMyNlA=;
        b=WhBjFp0oVYqd4H6eks3a/eP1yb2oVKaUlbXb+Sd9LbZyENyNhW5Dg/yT1VDLnqg6Nc
         2jSXAFFPQ93ayyY7tJpKkDxBhgXtxh7NO0DTPt2ksuxJiy5mvLtbwDMpG74unGvVhTXx
         I3Vn4vo62zruAXjf87hTjqva6Yn+wKWZ26Vxxp4gIGtkCmXc3Y02qrR8BtVguyFkaHfJ
         mcn2kO2QYDGDD7A/sAIAK8nutYEk0FFTcp/ZBHRXpwF9CFRvWEAAG+q6v0h2QGm4+M77
         QSH0nWOHTXdzKUuBDGJf/Wk5B+gQP7VRdVxOMktpNCmw8ADxCbIW3qIy+h14/0kAZw30
         Ht2w==
X-Gm-Message-State: AOAM530ULaYPUfY0vDj3CgA3Hs7GCBXlpbGaY91XoziESMEtu9lp60j4
        lO4S4RQjnxBvqXubHwWrbzS/7w==
X-Google-Smtp-Source: ABdhPJyGUcFi1j7CzOPTFj6oe/VL5uI9RSyxXYTWHin3yyyJVJfDrN1/Ko3OcrnKEPGGieHj2kUubg==
X-Received: by 2002:ac8:5e4a:0:b0:2de:3a8b:f775 with SMTP id i10-20020ac85e4a000000b002de3a8bf775mr17903095qtx.40.1646080914723;
        Mon, 28 Feb 2022 12:41:54 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p7-20020a05622a13c700b002de9f3894c2sm7771762qtk.50.2022.02.28.12.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 12:41:54 -0800 (PST)
Date:   Mon, 28 Feb 2022 15:41:52 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Niels Dossche <dossche.niels@gmail.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        clm@fb.com, dsterba@suse.com,
        Niels Dossche <niels.dossche@ugent.be>
Subject: Re: [PATCH] btrfs: extend locking to all space_info members accesses
Message-ID: <Yh0zkPCdTlkFSfsQ@localhost.localdomain>
References: <20220225212028.75021-1-niels.dossche@ugent.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225212028.75021-1-niels.dossche@ugent.be>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 25, 2022 at 10:20:28PM +0100, Niels Dossche wrote:
> bytes_pinned is always accessed under space_info->lock, except in
> btrfs_preempt_reclaim_metadata_space, however the other members are
> accessed under that lock. The reserved member of the rsv's are also
> partially accessed under a lock and partially not. Move all these
> accesses into the same lock to ensure consistency.
> 
> Signed-off-by: Niels Dossche <niels.dossche@ugent.be>
> Signed-off-by: Niels Dossche <dossche.niels@gmail.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
