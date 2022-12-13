Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428F564B996
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 17:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235762AbiLMQZl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 11:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235303AbiLMQZk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 11:25:40 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79680236
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 08:25:39 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id a16so219758qtw.10
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 08:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a1B8OL1enxxLGofROCPRQ5+Qn3rb0S7F7b6MyXCkQ74=;
        b=XmwJSbEIRBZN7XPib3Ip7gmXUN1BkkkmZZx5RwCk/I+AwKq4EU5J/kAPeQdtQcJ8dd
         VJ+QFrAGylBexC5eR80CmtOcYvOx3gmNGLZnoiDeJp2oCXthrY1WBRtbI5Dd+t5u/lUH
         Co5aF17E/y319cMgg7EO0GZFgaFKmS0KuLvVncRShdkp8IuZvwZ3vlqTNKDF0PkcwsIJ
         OOJXbFGuOJ9p7NhOe6yRqL7c7Jg/a3CXsrZouxctRvYxKwN9DF7MGDJGPD33iWTf1Gy9
         A/aIhfaNg6ki1I8lP+mVZ7hIsUq0u8VDD1VqyrMeEMKNFz6xQ9cxCXR7WlodHqtdkoAg
         EGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1B8OL1enxxLGofROCPRQ5+Qn3rb0S7F7b6MyXCkQ74=;
        b=1e7feZZii78/1kwwEnam7MBmb3N2ceVdiEmO2L1ztDiyHH3GBQGFi0GYsL9R/l7Ndx
         +zENXCDOXb81iWcAisSToEJs85wEUFx9wDwzYrTgaKxlRdFry7a0MYzNP80vTcNS0G58
         69Gx4STIKsbDeXhReU/Oq9QpAy/616Z8nWZ8EC3rJFneQRQ47oRrXc346LOGuhIhF2Lm
         IDA69W9+cT8+Iz1vunnUYgIlPLGhFu/E8NLnJxRs5VzcnbsUr4AyvRVp+J54Sys83Jif
         WwKenOYlKffiwUd21mojVHA5KJNSDKnoigknnorEcQeGUCh8pqniy3SsATVOCJrJr3Z+
         vDjg==
X-Gm-Message-State: ANoB5plGp+Pxd1s1q0MkwTP+F5STTuYOX9p/npGHKuVzG1KdOupuihel
        6y3WMxVLBBvoIt4ubY+hMtEcO5+/wXc7jINWuqA=
X-Google-Smtp-Source: AA0mqf4X/AM8bFyIKuuR6vIAW1ioLHaym0EAvbQgvNHYk/mTXVOQ9yjO9a8hee5ebpO+RKCmRheklw==
X-Received: by 2002:ac8:7ca4:0:b0:3a6:9622:ea88 with SMTP id z4-20020ac87ca4000000b003a69622ea88mr4233045qtv.43.1670948738307;
        Tue, 13 Dec 2022 08:25:38 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id ga12-20020a05622a590c00b003431446588fsm147239qtb.5.2022.12.13.08.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 08:25:37 -0800 (PST)
Date:   Tue, 13 Dec 2022 11:25:36 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 01/16] btrfs: check for range correctness while locking
 or setting extent bits
Message-ID: <Y5ingH9oGQLTZono@localhost.localdomain>
References: <cover.1668530684.git.rgoldwyn@suse.com>
 <07534e31d822b5c08609c72e5a2e8054604765d9.1668530684.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07534e31d822b5c08609c72e5a2e8054604765d9.1668530684.git.rgoldwyn@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 15, 2022 at 12:00:19PM -0600, Goldwyn Rodrigues wrote:
> Since we will be working at the mercy of userspace, check if the range
> is valid and proceed to lock or set bits only if start < end.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Echo'ing Johannes' comments as well, I'd rather this be an ASSERT() and we catch
it.  Thanks,

Josef
