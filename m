Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E572179ADBF
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 01:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355699AbjIKWBr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Sep 2023 18:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243728AbjIKRfg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Sep 2023 13:35:36 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046DC125
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Sep 2023 10:35:32 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-5717f7b932aso3086283eaf.0
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Sep 2023 10:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1694453731; x=1695058531; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pJztqqjJZ91Rwj8nF59E+xMwCK2VrN5odsIoKXltNF8=;
        b=jCc81UCdhFX6ezLGpjocris64ffjmNa+b4M7VDtgl7BDxeuQ9coCts6R+4CtX+I1py
         8niYkI+jVgS/IbCqMrZ6XAVz7E6fHJL9iTVM/vKHdSxrKZGoC4lG0pM00attV6BevB0K
         LFmy5bfuyNa8vVA8b1kKNBauyJLtIKekGf48xutKGCQIG/850Df2Nj/7FJxO9thUfM5j
         rYOhCUcqGJzr+cp550XwX1QNTTSzAd8hXHSgCP5dpDmO6nrOKPsl7rgFNwhsp0g8O1FK
         vdZ5DscmRcFnj3YSnaJU4Qg8e2/ZQMxMEYGUaANTq267gQ/h259ddFvyw7uOzTsoAqhz
         FVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694453731; x=1695058531;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJztqqjJZ91Rwj8nF59E+xMwCK2VrN5odsIoKXltNF8=;
        b=CzZdP+DaD2YVnEimq7qvEvt4djvS7MRutiKWbyKqMjAzNTjyUSvuokKlDGZY9fzB3/
         t/7oQyTST5dJexCcStsB45+/YiE2StJcqFY/8pQHwWrh4A61jcVLVK393FZnoW3WEsCd
         amdJuH9CjUX1erYO20AT29cRNW2mF+VDCu2yCS5SNfOtQPcQ78Omq55crSEf6csVsXFY
         RDfcmAA6yQeerHJWfRAe2D61JU2asKpgNDAEr/DqzHAjhVmCgLikZnvtnAcLlFzhnQP+
         c7ziEQRwCNbrt41nssgREpUa9YG7vJGTAkrrFFciF/dkLuli/6rs0eNXzIqs1SjDdJY7
         AAPg==
X-Gm-Message-State: AOJu0YxPqBM8pI1xnuKibNCA4lkzFzEhHKrnarvMW343PVJYUj5CXHw+
        oiD45qDiFRCvrE5gzDRWJvGCGJSJnsLORgFJk5yyZQ==
X-Google-Smtp-Source: AGHT+IGpIkUPKNOZp7Ptavm4ZlrP/2TXtpbu9Y3nGePIYbjKnYG0J7HEQBAJdJzPtXu2bFWqCNl3Iw==
X-Received: by 2002:a05:6358:5924:b0:137:8922:7ebf with SMTP id g36-20020a056358592400b0013789227ebfmr13211216rwf.2.1694453731249;
        Mon, 11 Sep 2023 10:35:31 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id s25-20020a0cb319000000b00653559e065asm3095194qve.99.2023.09.11.10.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 10:35:30 -0700 (PDT)
Date:   Mon, 11 Sep 2023 13:35:30 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org, ian@ianjohnson.dev,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 0/2] btrfs: updates for directory reading
Message-ID: <20230911173530.GB2352074@perftesting>
References: <cover.1694260751.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1694260751.git.fdmanana@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Sep 09, 2023 at 01:08:30PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Tweak and fix a bug when reading directory entries after a rewinddir(3)
> call. Reported by Ian Johnson.
> 
> Link: https://lore.kernel.org/linux-btrfs/YR1P0S.NGASEG570GJ8@ianjohnson.dev/T/#u
> 
> Filipe Manana (2):
>   btrfs: set last dir index to the current last index when opening dir
>   btrfs: refresh dir last index during a rewinddir(3) call
> 
>  fs/btrfs/inode.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

I didn't see an fstest for this, is it forthcoming?  Thanks,

Josef
