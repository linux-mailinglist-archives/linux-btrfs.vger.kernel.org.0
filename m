Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0EB79899F
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 17:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243235AbjIHPKU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 11:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjIHPKT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 11:10:19 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B5D1BF9
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 08:10:13 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-76de9c23e5cso123862585a.3
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Sep 2023 08:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1694185813; x=1694790613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DCatO7G++COZ4lAWfIb7k8noZQqa79yoBSHSXGi4UH8=;
        b=qXYCwkyu7hTdMw+sSZzjhVBZcs7FETxnB2uZlwNUnkEAwgrc1N15tUdkslHelT+Cid
         qjRnzQsI3AiBnRm9/g7H3YxV6A3Tblcu6tRcjy8OQmvduAv4RsSzo3GsNAIViCyfe3O3
         KQRN2hMxYgeKOZHNkiZv+WKxL03tQ1ptuGU3EFSCEIVB0+dRzGswGzi9prNerdS3BLrj
         RFxVxvnebAvQtnpad4GZx218dYZfLQ0YvkXFTZKg29UaBinyfpumFH6XSgLY+s5wCS6f
         zW2q9tPa2OUHZ/jVjHaB6onVxsOoMKrN+OpPiSlMpvJHCFb56nrGSp2wE5SidCHWImgb
         C8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694185813; x=1694790613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCatO7G++COZ4lAWfIb7k8noZQqa79yoBSHSXGi4UH8=;
        b=DEf0eFf/lFyfn+FGwz0onrhpdBBu3/ZK2vnNVnMklmgGQDK+EAcFaEMQmoeqJ7FdY8
         nykPtLZerFsdFpZEqOcv2t6w1/DHYiZEBO3QyDOFIlygYcCPo2KmUJF/aBqQp0D3pW5m
         3OyHge0C6PLY2OuFnnTiuQSTDoc6eacQfMFRL2s2V1ByQMDu2G70wilKU7FUXsjHUnWr
         zqH4M0hftb1PTw7KcRkEG39lo4LkspBKWmu1Uiv/lboDkQwAb3z+VS4oZylYdDn1d9wq
         8sEKFaUXmEqm1NNh8fQuWpAC3c+qUC1I8ejgxR71EX7LQw9dzf+taV/8JYar/WzkaRII
         zDgw==
X-Gm-Message-State: AOJu0YxPRY0M25btQBmbC7Qww8PWDFw6MuB2SMxECui8l7sfohOghRUp
        /IwYypzoZqZ/zrW1VgkeD8JLZHm3RDgv2g4ydEnrrQ==
X-Google-Smtp-Source: AGHT+IHjYtlV8h1pm00ukvwKzEnv6iii6J2VNsoA0T6RXcJ04b8MIo8KJqLBgpxCR/P4RMJnIpgMsQ==
X-Received: by 2002:a05:620a:1a01:b0:76e:f2cc:294f with SMTP id bk1-20020a05620a1a0100b0076ef2cc294fmr2950434qkb.63.1694185812681;
        Fri, 08 Sep 2023 08:10:12 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id t26-20020a05620a035a00b0076ef2816ff0sm647835qkm.16.2023.09.08.08.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 08:10:12 -0700 (PDT)
Date:   Fri, 8 Sep 2023 11:10:11 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 14/21] btrfs: use a single variable for return value at
 lookup_inline_extent_backref()
Message-ID: <20230908151011.GO1977092@perftesting>
References: <cover.1694174371.git.fdmanana@suse.com>
 <6a03f43747c9126f6162886e3bb7934fd480ae48.1694174371.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a03f43747c9126f6162886e3bb7934fd480ae48.1694174371.git.fdmanana@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 08, 2023 at 01:09:16PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> At lookup_inline_extent_backref(), instead of using a 'ret' and an 'err'
> variable for tracking the return value, use a single one ('ret'). This
> simplifies the code, makes it comply with most of the existing code and
> it's less prone for logic errors as time has proven over and over in the
> btrfs code.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
