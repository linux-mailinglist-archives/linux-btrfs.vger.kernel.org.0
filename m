Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D0576B67B
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Aug 2023 15:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbjHAN6A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Aug 2023 09:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234265AbjHAN5u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Aug 2023 09:57:50 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DF21BCC
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Aug 2023 06:57:49 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-76af2cb7404so401726085a.0
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Aug 2023 06:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1690898269; x=1691503069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mCHZGDzkrmwQUzNfxZDMdHWShttn4Q70y30+JhEO2z0=;
        b=Qqg13spJoOB8w+wu5zzO+njpL2IwtY112mfgdomV3/uZiQf+tZQ4VVi0O7qY3d37J2
         hjLxFdLYwPQLxoxO6wRocoXmwBtIhbYH8GKw2bHMIBaug5Suoq8xvWJiWA7hA1k9HRR3
         65zM19jmm4bCb4UgOaA0dIVTawM35HH28zQcAeQbl5O2xYXf1D2hERhHYfpBRiYr9lmP
         Nju2R0felmVDy3V3OAYcyfZMI/qqYiXVTrL7Jzn/e55NBMLwAt+ImedInxQifi0UD2jW
         bpavl/5dGmkvks2IuwUG5jCGe18asGxHd4yYr2yZcwyN5j38WJAdkfXTNrqfpzwoC/op
         Qq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690898269; x=1691503069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCHZGDzkrmwQUzNfxZDMdHWShttn4Q70y30+JhEO2z0=;
        b=FmADma8pMjx0d9SkwBfr1uu2x0MbrPyMu5NeXot6g213wMCS3i3KnH/5bccu81XLL+
         Chf01rjraVOV9wOwcyBy5Nl87Oj15mImOy6F3QKbxStS+F3FuioPhpX7npTd6m8rCmXX
         Mywt+6368puRn+Iqhv6ft3lShVKlfPOzZbKrORy7lKqN6mTsFM4U99JVKXgnbGQxY1Ph
         s77+FmjhCuRcdjO3A5Ta1Qu4ejZiJa5t8beIrKzD4SfORCUN37EOCw4Y6hHMvZoEsXcC
         bfA2yUkAZnY158XNC4g1mOdxWKRnnbWoxBWKFP7CdTlcwKycDwt7rQ1vGv0EUebXbVf+
         MICg==
X-Gm-Message-State: ABy/qLY/7UY5p4UFEGfQiQC/EF/+ZuuaKDMYY6VIzehuFKvWxQbLFzPf
        QQmhYenxWXOpYi9j1jubNr4jBg==
X-Google-Smtp-Source: APBJJlFL+vubFr36JTCpInVrbL6owfUFU75Pu+Sgw4SW2fVPiqsSo7tf10bI+zDJ3hzvQQ9TD12jUA==
X-Received: by 2002:a05:620a:4727:b0:75e:bf51:29a6 with SMTP id bs39-20020a05620a472700b0075ebf5129a6mr15046627qkb.65.1690898268872;
        Tue, 01 Aug 2023 06:57:48 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id oq7-20020a05620a610700b00767c961eb47sm4167614qkn.43.2023.08.01.06.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 06:57:48 -0700 (PDT)
Date:   Tue, 1 Aug 2023 09:57:47 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] btrfs/276: allow a slight increase in the number of
 extents
Message-ID: <20230801135747.GA2012161@perftesting>
References: <20230801065529.50122-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801065529.50122-1-wqu@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 01, 2023 at 02:55:29PM +0800, Qu Wenruo wrote:
> [BUG]
> Sometimes test case btrfs/276 would fail with extra number of extents:
> 
>     - output mismatch (see /opt/xfstests/results//btrfs/276.out.bad)
>     --- tests/btrfs/276.out	2023-07-19 07:24:07.000000000 +0000
>     +++ /opt/xfstests/results//btrfs/276.out.bad	2023-07-28 04:15:06.223985372 +0000
>     @@ -1,16 +1,16 @@
>      QA output created by 276
>      wrote 17179869184/17179869184 bytes at offset 0
>      XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>     -Number of non-shared extents in the whole file: 131072
>     +Number of non-shared extents in the whole file: 131082
>      Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>     -Number of shared extents in the whole file: 131072
>     ...
>     (Run 'diff -u /opt/xfstests/tests/btrfs/276.out /opt/xfstests/results//btrfs/276.out.bad'  to see the entire diff)
> 
> [CAUSE]
> The test case uses golden output to record the number of total extents
> of a 16G file.
> 
> This is not reliable as we can have writeback happen halfway, resulting
> smaller extents thus slightly more extents.
> 
> With a VM with 4G memory, I have a chance around 1/10 hitting this
> false alert.
> 
> [FIX]
> Instead of using golden output, we allow a slight (5%) float in the
> number of extents, and move the 131072 (and 131072 - 16) from golden
> output, so even if we have a slightly more extents, we can still pass
> the test.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
