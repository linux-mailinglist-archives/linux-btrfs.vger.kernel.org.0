Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484B879899A
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 17:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239684AbjIHPJr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 11:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjIHPJq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 11:09:46 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348041FC1
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 08:09:38 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-410af8f75d9so14057201cf.0
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Sep 2023 08:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1694185777; x=1694790577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WojmZpvgCdIp6uiRTAjCvmj8g7GXzLXsjNvtwkHrUMg=;
        b=0cUTqg4diLzinWInTUjNP0TPZkFbGptHBlzU+58Lgi3OTpGu5304tHaMa1rSj6KB5s
         wfXi8BjxKXF1wWYuVtKtXrYH3Cvlq1ewdSulUtr51MaqQ9TI6oK+4qOYyeGWXEKsdqVT
         U+iDBRam0N1BnVBqpCQ6EzfLy9nKshAPpLW8zlUnsOAJ6T78ldi0aTOcSJc0MQyiUR0u
         0T1jfuNeGdC31z21GtpHMIOr9ZXjp2UTc+Vge66p/EUdBuYlXeIZNRJn9APEVPfRirv1
         0u41O/N+wgGpkjq98zJ5SOJu1dGJa2tpiysa/KvLhx6X4o5a0QiwqDJBmxaNELjVFvP6
         xeUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694185777; x=1694790577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WojmZpvgCdIp6uiRTAjCvmj8g7GXzLXsjNvtwkHrUMg=;
        b=D6xzCl5ydvBG2DFfq14FOLt8Lks5Q7EQJ8dzC4WIf2fYClSedEYlerX7zYJmeW+EW1
         bYZUiCimdFHsdCbgnEhmVUVcwrFRUVApN3Mdi07sVDdEIb2XU4h3BdQRvnDjWrV/i9ck
         i3a6b99MwWyWVXwG24RmbN1NaOy1WM6AYZKdn1CSt4KX8/vGQ0kXmCmR4huf7H9Cf8uk
         pFGG89E/VsK6bdLGkSrUWlQY5FbJD6yJmQ5joQiiVs0XdNd0V9jJGrXi0/CIrmFvtKN7
         gQCQIJ9ebyDETQm3OTQiaaMQ6M0dzCTNgVO+lfWm9mrvjrtoMlM38NrQfiIWVe5wYdQZ
         nM2A==
X-Gm-Message-State: AOJu0YxNv4xNNexjnOin/3h3VJ/S9o8FlpRiHNBGf96RmLZ7IkFNkOxq
        aJ87lQExA0L8k9IpigwW3SgVhzVZ34qPTdTQHrcNBg==
X-Google-Smtp-Source: AGHT+IFwQxbS+IM+gNjjdDFKyHiSFXIS2QWcdF9BDzRrbr96eQ6bcDxzotsV0O9NVIPyOl85bAY6FA==
X-Received: by 2002:a05:622a:1913:b0:40f:ef6d:1a3f with SMTP id w19-20020a05622a191300b0040fef6d1a3fmr3517871qtc.30.1694185777331;
        Fri, 08 Sep 2023 08:09:37 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id hz11-20020a05622a678b00b0041079ba4f6bsm661875qtb.12.2023.09.08.08.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 08:09:36 -0700 (PDT)
Date:   Fri, 8 Sep 2023 11:09:36 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 13/21] btrfs: use a single variable for return value at
 run_delayed_extent_op()
Message-ID: <20230908150936.GN1977092@perftesting>
References: <cover.1694174371.git.fdmanana@suse.com>
 <f1456757efb45a67a9e7fea6e1a6dd8006f21f24.1694174371.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1456757efb45a67a9e7fea6e1a6dd8006f21f24.1694174371.git.fdmanana@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 08, 2023 at 01:09:15PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Instead of using a 'ret' and an 'err' variable at run_delayed_extent_op()
> for tracking the return value, use a single one ('ret'). This simplifies
> the code, makes it comply with most of the existing code and it's less
> prone for logic errors as time has proven over and over in the btrfs code.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
