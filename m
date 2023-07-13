Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F25C752B89
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 22:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbjGMUUS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 16:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233833AbjGMUUR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 16:20:17 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCBF2121
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 13:20:16 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1b0156a1c49so867991fac.0
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 13:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689279615; x=1691871615;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z4kqiGsGtEVDSRUj+RkrUPrRSOkzEJV9LyZCNd9rCOI=;
        b=On7xGDHhfxT1XfekspZ+Q199mm5gt7mlBTWg7GCM+faLR3bK9eaIUzB367bq2K/F+z
         f5bn9GfBzuW1qOmPrgiCmJQiqvRioHXhZDxRLCNQtTWGOlXteeOI3OcKkJpezWOTkSyN
         DxXSF+FZzljkQZf4oTGQfYNTolgqa1nlRkJ69m60aH9ClCPwtYiugf2qKuv2g1N26aeW
         yXbol1kWfMlo+/RjntY6MGtVU1A3lDCsDSiiWv5TCTEo8w4I9J+6P61SjciFOB6zyDnq
         coNUJ+7DF5ZYPHFWnp7uhNfU2fLfV/SSyU9YU9sT19GJu7euA6Bh+aPLoMTzyCYYGOrI
         2lpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689279615; x=1691871615;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4kqiGsGtEVDSRUj+RkrUPrRSOkzEJV9LyZCNd9rCOI=;
        b=ZLOzhTQuKYrBca8djs3DJ6BVEt8p7GsyEVDnk+CJho1y4D6xWvT5k5uaBvBnX1CzfV
         qZd7z1qtS+cCuO2S/SeMJO0i4B7ByWrAiofirgPhmC0Ek9tp8e8QRuD3qGPX2vRdDfpm
         ijnbIewlSBXZM8rMXBhi2mUEMfVma2smawl0ljHELxUZQdm1f6GQUFy5JuRL6A9Ork+y
         rZh6VJCGj9I6my2HMo73NaQ3GRUD9DeTKH7qiDwEQkK+WTq3HGlu3FuNzIvpbOUYh4ko
         5+aZpQb9baUvfi8/tDNOx7HTGH8lN8yUgoBBqeE3P7xfxw9xCH+DniB0obRylFbOx4Zk
         msSQ==
X-Gm-Message-State: ABy/qLbAhLy+VvyLA3Se+xA71QumDkAHiGLcUPDRzdX6XDRVZvvIicg4
        KZRTmE0Cco6rZV77YgqWrI5ugQ==
X-Google-Smtp-Source: APBJJlHADuqGcNtaFYO+18xuKqmq5BMbw+c4yaLx24pqHLoMzNbUE5CY3WL4cbOQCHneyhCr2lmOiQ==
X-Received: by 2002:a05:6870:c890:b0:1b0:67a9:3089 with SMTP id er16-20020a056870c89000b001b067a93089mr2708018oab.57.1689279614833;
        Thu, 13 Jul 2023 13:20:14 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id l186-20020a0dc9c3000000b0057725aeb4afsm1940058ywd.84.2023.07.13.13.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 13:20:14 -0700 (PDT)
Date:   Thu, 13 Jul 2023 16:20:13 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 3/8] btrfs-progs: simple quotas dump commands
Message-ID: <20230713202013.GU207541@perftesting>
References: <cover.1688599734.git.boris@bur.io>
 <bed9171118addaf2d70eeaa6854264a1f987dc47.1688599734.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bed9171118addaf2d70eeaa6854264a1f987dc47.1688599734.git.boris@bur.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 05, 2023 at 04:36:22PM -0700, Boris Burkov wrote:
> Add support to btrfs inspect-internal dump-super and dump-tree for the
> new structures and feature flags introduced by simple quotas
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
