Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D612864BCF9
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 20:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236790AbiLMTPO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 14:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236791AbiLMTOv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 14:14:51 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1301111164
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 11:14:48 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id fu10so748120qtb.0
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 11:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1/iWzXZTQW7/y032mPfe00QYzD8XqUkvrJVhV2rlje0=;
        b=xjg75ODmxAcEC7VE3UZZRwDA7vzCjXwLaLw+jSgoyOn5koeWcgrv+1gC40HWRMhGdl
         sc5H10TF2dAlvvJmuQrnMXgbHteX/J8qylOHKUyhWXVqEm6MLfNum6xKLbe/dfvaWFVl
         5lhSbLu6n9jipaaTL2OcuXbngtSuZ1o/FSO0G1cDEQyHtLOLQ7Nqlm4oUSizzPRGQNWK
         j8ycHdkQrCKIlTrqMgw7b+r7sz0Xjb95YlbXF7KL3hy5Fq6zTA/1OI46xBXgUn29pDtA
         stgRiW94FuoM7PNNoYQ025zRagkro34Gu4dDz22UD9U/6c3mBvHp037e8wRxbJWK81Lr
         7oBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/iWzXZTQW7/y032mPfe00QYzD8XqUkvrJVhV2rlje0=;
        b=c1uoD71rodIIG61zv8Tm1QFVa0kxnKNFaAnE4IeFXbDELn/O31tk4Xsiqj280QaSlk
         5HZQisvz2xFF2pTGx3vs2+Y1654I26hnpLnRWr2viYqGRljym96XQJlohOfZpu9+TGWq
         ZtR4aH0OY9XhvigNvw11lOo3R+xdn0Ck6cWWRuT9CQkwNY+9H6s1UYeBzhFVVBLBQQLo
         D9/s5cDW8XSfVYYymqFQOwAsO0g6TbtGXe9iXtimniB3BYNGVDWtx1eOWEQa4UqWXPOt
         2vDdn0xegoSDPXoUkO9+AcMd+OMWGKMIgisTaVpv6NuNXBNSRFIViLwpcLbmBPTXHuFE
         in+w==
X-Gm-Message-State: ANoB5pmYR0VlHYVK6EJEOLPMtsCc1JZ0SL0m+SrXLngVHbwMReHCAyTH
        NI3cFPvC6oddGAgTF7FPnrdpxw==
X-Google-Smtp-Source: AA0mqf44RJTP4cDyWezrgGheehbyr0wzyRo2NNFozPlmTs7msiIiE8vyXbxAIRXF6ydOZXc76Dolpg==
X-Received: by 2002:a05:622a:8c:b0:3a6:1d1d:cb4a with SMTP id o12-20020a05622a008c00b003a61d1dcb4amr38397912qtw.55.1670958887007;
        Tue, 13 Dec 2022 11:14:47 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id h22-20020ac87156000000b003a81eef14efsm356034qtp.45.2022.12.13.11.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 11:14:46 -0800 (PST)
Date:   Tue, 13 Dec 2022 14:14:45 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 14/16] btrfs: lock extent before pages for encoded read
 ioctls
Message-ID: <Y5jPJTuIVB3+39G7@localhost.localdomain>
References: <cover.1668530684.git.rgoldwyn@suse.com>
 <7d0e6ad948ebd8ce5b5858b720a9e2403221d677.1668530684.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d0e6ad948ebd8ce5b5858b720a9e2403221d677.1668530684.git.rgoldwyn@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 15, 2022 at 12:00:32PM -0600, Goldwyn Rodrigues wrote:
> Lock extent before pages while performing read ioctls.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
