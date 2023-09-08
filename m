Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A5B7989A0
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 17:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241969AbjIHPKk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 11:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjIHPKi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 11:10:38 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD841BF9
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 08:10:34 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-4121788397fso15719881cf.0
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Sep 2023 08:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1694185834; x=1694790634; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B70dzY+3oGxpyVsmKEpD2yVDun+nJ/naJtGTEL8W7G0=;
        b=QX+GljsY3UT+R4gtVfXMJIAFRM7Wby6sYa9MOSkp5Nk3OKGIsv3wFI8jG07CLGXhJe
         US/tX5hLlAYyyZVF+kjzoW9hcq8mWtjcegMuoqCu7VXKqdWf6J0igsw+57CLCAcqUsLb
         krMTD51voTWUUQEVdWzIodS77yh1wFdZj4Dk+pc8/UAulVWC+9U0ebn5gNmeiSzwe84W
         DiPodC355n0uK4XRUnAbBP6U6gJzYNTxNNVFjxyLD+eKHbSxgv1E6QALZUfUTyorpxy1
         jW6+5ZLijStt4RZLKD7hk+H0H75WEGFNf0V0A/wRQ0idEstYN9UBoEmtq2HTO3ItdMtR
         Q9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694185834; x=1694790634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B70dzY+3oGxpyVsmKEpD2yVDun+nJ/naJtGTEL8W7G0=;
        b=COJVoGLUCSdxLgbKVpaZ0uMN3k/7yx0GD8Do5d7j+fe2SBcxHJTDdKLOV1pfRSCMI8
         Zqex2mS5nR4fi9bodzW+yv9Eu88cvqj+OOLVk/QoYwLISPLft8KzmaSBdSLVAojeNAB4
         dfltb8ACi3JllIHEHwx5D6KWFUc2WFVM2v7VxfppcmqdNZzyoiBchXOp9NeGmi5O8nkF
         lw1cfvXVKSAPHkRhLSpdG/MoQ4ulBJ8kPmayYzWA05J2vp/KOodIsW8X1ci26d98T7+F
         gJ23WJWnNacz1296nLXg/HlghinfPs0BnAanNvIu5V3X7Xf1MZCUZPcdLJBggtU9vwp9
         XWKw==
X-Gm-Message-State: AOJu0YxhO8dCgzJ60hMX1nl5oo7LjTFSnokyjDe6HDjuRhsEMBFYS65X
        b37sdP8DVPkr5mPrZx2MGH6YwB1apwNx5B54HXAskA==
X-Google-Smtp-Source: AGHT+IHyrZ6qgHblmYPHAGzkQJTvvhxao3VYfwCkTd3qWT6yB3RgQGhCjwtDWlhMGJI3TetWo33sWg==
X-Received: by 2002:ac8:7f51:0:b0:410:20b8:967e with SMTP id g17-20020ac87f51000000b0041020b8967emr3619786qtk.12.1694185833878;
        Fri, 08 Sep 2023 08:10:33 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id r16-20020ac87ef0000000b0040ff387de83sm673777qtc.45.2023.09.08.08.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 08:10:33 -0700 (PDT)
Date:   Fri, 8 Sep 2023 11:10:32 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 15/21] btrfs: return -EUCLEAN if extent item is missing
 when searching inline backref
Message-ID: <20230908151032.GP1977092@perftesting>
References: <cover.1694174371.git.fdmanana@suse.com>
 <b79b564eb5cc9823b42890db4309501bd48d2d39.1694174371.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b79b564eb5cc9823b42890db4309501bd48d2d39.1694174371.git.fdmanana@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 08, 2023 at 01:09:17PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> At lookup_inline_extent_backref() when trying to insert an inline backref,
> if we don't find the extent item we log an error and then return -EIO.
> This error code is confusing because there was actually no IO error, and
> this means we have some corruption, either caused by a bug or something
> like a memory bitflip for example. So change the error code from -EIO to
> -EUCLEAN.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
