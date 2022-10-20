Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18E16064B4
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Oct 2022 17:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJTPgS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Oct 2022 11:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbiJTPgN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Oct 2022 11:36:13 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF621B4C46
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Oct 2022 08:36:11 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id x15so989836qvp.1
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Oct 2022 08:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NklapcuMWVeQL/h4zZnFGFas/pTMip0oEuG61VHhdRM=;
        b=u66tm1MoQwtxolt239vrcSpPyP+a7QyL7EC9JVVUZO5t7VvLoA5jqy1wUW7in1vggT
         CbXvbBtgoiL5lPsCOYFWWcNzrXHetlSpMwhkwo0e0zAIzqK/qoBDeMriUaai1NzN9arg
         uYTBi3LncjKWnw4AWh2Vrki0IQMt341bc1ZxWmt7iil+fk+uuaUKlxzPpwoQxPbaIcpQ
         gLuolMzAlzU9ia8ZPDAslv03crIEgnrfMUghyJFbP8NhnumRsR0TWjJ5ad7oXhhUa2lR
         scYwmU2IOiC9K9okIWamPeNLpsp+J5+fBOxGyrNSALGH1UfutiFelavh1ap9np/E+0vl
         DEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NklapcuMWVeQL/h4zZnFGFas/pTMip0oEuG61VHhdRM=;
        b=5IK1GjwGW1/MqqFJCv5qKSyBi041msNPwctl7/HYLrjUCpxBeR4/PQeIYCAdEJIeL6
         WR617qi17tx9D+tNCBkgzFJRWtWoCuxnrGsseFztGtGYVV7Hl9kRnmrFjlMczRlrb2Lp
         mh0nG508zud+cwtKU/P3QeAtC1CEFgMuLtrVm27lYo07p9LDC8vYk6lnZ/9fsHlqN4H9
         Mcs953bhJlZ2hnvB0cwiB9Q8bIFj68KdPEBu6GcK5b3liAmIUtozQppR4X8Bo9N+6TrD
         OzDVbTbAmZ0s2wg7NrkIlSZpGFbpP/xFMHFC1OaRbgDdEPAgpPdK8azremdzvoYE4iCr
         Tehg==
X-Gm-Message-State: ACrzQf3fBozhXjWKQiMCA+nDejQLxkn+6LjJRItK1ZPOVHkC8XGyJD87
        KmxT3FY2iLDukxqLiBzfzlDsCTr418gXQw==
X-Google-Smtp-Source: AMsMyM41l74tTr9xEGpk6yRtPh+Xplo38/XeNvXEfddUbIm6WdLrHw35aSo9sXmgQbSbS+qqWaO+Vg==
X-Received: by 2002:ad4:5ae5:0:b0:4b7:1bdb:d79e with SMTP id c5-20020ad45ae5000000b004b71bdbd79emr5613262qvh.25.1666280170474;
        Thu, 20 Oct 2022 08:36:10 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id gc12-20020a05622a59cc00b0039a3df76a26sm6240002qtb.18.2022.10.20.08.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 08:36:10 -0700 (PDT)
Date:   Thu, 20 Oct 2022 11:36:09 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [RFC v3 08/11] btrfs: allow zoned RAID0 and 10
Message-ID: <Y1Fq6ckHWjX0KC7n@localhost.localdomain>
References: <cover.1666007330.git.johannes.thumshirn@wdc.com>
 <0c8a339cfd8d364b0d5c817637ba85ee0302503a.1666007330.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c8a339cfd8d364b0d5c817637ba85ee0302503a.1666007330.git.johannes.thumshirn@wdc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 17, 2022 at 04:55:26AM -0700, Johannes Thumshirn wrote:
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/raid-stripe-tree.h | 7 ++++++-
>  fs/btrfs/zoned.c            | 4 ++--
>  2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/raid-stripe-tree.h b/fs/btrfs/raid-stripe-tree.h
> index 083e754f5239..d1885b428cd4 100644
> --- a/fs/btrfs/raid-stripe-tree.h
> +++ b/fs/btrfs/raid-stripe-tree.h
> @@ -41,13 +41,18 @@ static inline bool btrfs_need_stripe_tree_update(struct btrfs_fs_info *fs_info,
>  	if (!fs_info->stripe_root)
>  		return false;
>  
> -	// for now

Lol.
