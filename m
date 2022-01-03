Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACCC48348F
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jan 2022 17:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbiACQHM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jan 2022 11:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbiACQHM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jan 2022 11:07:12 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46092C061761
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jan 2022 08:07:12 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id i130so30701438qke.3
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Jan 2022 08:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sIDmolFItdLY5IwJX9+GuuPYaYwcDz9sqQCAbpGh1wE=;
        b=rMLDMy6yp0B3ftK1UPgmHCnXQUPeqg4P4ecrtlaFhBkJwwadKBtNNw/8yVX6hGIPFv
         vWATzl8VySbx1fcVBy6IGixyDKDERMrqNe9gUfeJCO8ULKriuKlRK7ZcVzhxIQA8nZ3t
         zgKN4KKRfNeBJzNNwKMUMt9Z3HGmWYPUOOQLd+tdFnh7cAZ9wPhBW/x6zqOfwfcauwk9
         Qn5ecP4IiXxR6h9u/pKUpEBTzru42d09Weyr10PdxIy079Y8dNMtgO/rIWv/eyKDA2sn
         VKr829MprFqPn0ODlEpxE5xO3BR7WZ0YHwgQoTaicvFNZKAZu/h0V/bpcEi2a/zYcleD
         7mtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sIDmolFItdLY5IwJX9+GuuPYaYwcDz9sqQCAbpGh1wE=;
        b=w3nXY7iHBH885uJMnTwMZpMDAbaQPEPugCmNp9+wr4ykCywBsmfYNn2YpLQO8NiTtZ
         DmB8a8p67H2iokwjoIhl5YkZBDQVCODo643MozUGPy53SkygfZesj42sZrFmDrrIwchx
         baw+bwkLYO2r5U6RbqDSk6gJcJi/K7qvPSfuHxgT2uy86uiQWJVGK92CrrxMd6OtieK5
         f5Uw+omAQyAleAigdIboM++jchqu9SfVsd11+35Ba3D+UVsOlq0V/dsguJmdtFrvvd/u
         LgyTC656VER98OJ9HC+CQUFcHTzPqiXicWJJPX0l7l5nm/T8Y0YC27KiQ6a7ZB/cw+/W
         s86Q==
X-Gm-Message-State: AOAM53232TCQB8NLl0arDHxVPdCBowgZKGccSFxfr99RjADa3GdcEzPC
        aHRtaGLGS+tkh5CgzofVB4rYNQ==
X-Google-Smtp-Source: ABdhPJwCUlHB6rzu8KP2WEpHUn/8Ivn86bEttT3QovpgOgRw+jNYpkg11Et2kZj2n0Wc+O1Mbu3j5A==
X-Received: by 2002:a37:9bc1:: with SMTP id d184mr31970042qke.679.1641226031261;
        Mon, 03 Jan 2022 08:07:11 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g14sm29375792qko.55.2022.01.03.08.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 08:07:10 -0800 (PST)
Date:   Mon, 3 Jan 2022 11:07:09 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: selftests: dump extent io tree if extent-io-tree
 test failed
Message-ID: <YdMfLeu+y9YfLDYp@localhost.localdomain>
References: <20211230084513.29292-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211230084513.29292-1-wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 30, 2021 at 04:45:13PM +0800, Qu Wenruo wrote:
> When code modifying extent-io-tree get modified and got that selftest
> failed, it can take some time to pin down the cause.
> 
> To make it easier to expose the problem, dump the extent io tree if the
> selftest failed.
> 
> This can save developers debug time, especially since the selftest we
> can not use the trace events, thus have to manually add debug trace
> points.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Love it,

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
