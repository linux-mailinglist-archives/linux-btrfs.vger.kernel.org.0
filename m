Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE0C752BA2
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 22:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233960AbjGMU2M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 16:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233916AbjGMU2M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 16:28:12 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C8C2120
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 13:28:11 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5703cb4bcb4so11417897b3.3
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 13:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689280090; x=1691872090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ghe5RuhK4XlHpcWyQ0230IFeOxvRVZMZnlspBWODr4I=;
        b=TA8tVpTggowV7OKstKhLZlcnBVUdQz3O9uzvGJ6IomyZJDwMD3zD8BdkkYvYg1zOma
         M7sKNKUvDpTjAYa0S+2TD8MVIqT8qPuzXWPPdFOYQyRCTnCCdst+81zgr9P3gff0Ul5j
         CiQMrUiG2UAFoAPPxpzOPS8y38eH/xPeQvTK0WJ/PaqA1st2gK2MAik5nqgM4N0aXOKL
         9tU3J1TmfEAVkK3cqOEnF5rXdTpCenZIYfbyu2noCaGH2KK6yLJiN9bWnXrWQd/jN11C
         64jpT4MT5+cI2rc5NJBCNjSXPPjuCEiyFnKXeWhKJtCjM7gJTzy47yrRS5/BAsBmuSXE
         biEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689280090; x=1691872090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghe5RuhK4XlHpcWyQ0230IFeOxvRVZMZnlspBWODr4I=;
        b=FgTy/qNwd3tgWPcdxzdiCiHKc66okOuO2hgQlL8ZO75OOvVmHZldswnJvdBKIUUtxO
         s60X57lUvdhVz1gsfnmzuM/EnQt2NvbcqHdsEvIhXkhacWKHRdNIkiU/Nu8/ZzAJOZYc
         ld3sCS5lolsTQzrRvgs+zFl5sV6/Ro47s53BGChE/B7w/2BCoVbRC7Hscccd3DJJHv35
         s0/VwgGyy8DtT/dwUYgLP5BelJ//JDWanajPWnPMyTScYD435gJwmg8GKYzXGlkwyjP7
         9V8dl3DMgqadAb+WkqRjXyWenJOCe7R9BCBeD8XsmrbfONPcvJT773ZmJZSSicPR9TtU
         JoEw==
X-Gm-Message-State: ABy/qLbSmN4ALD0gwKz6/uPQ2+hDLb/s6JC5Tmiv9b5g0vuDqvy6QlRO
        J5U8qEtblL9Qt5/UxczbEgzJcA==
X-Google-Smtp-Source: APBJJlFQlOu0iexx/Z6UbqlSuk396UktoxoFDiA6/OOIbJPAaIxFIbzZwX8daakOJc8Q4Oo/DB73Mg==
X-Received: by 2002:a0d:e8d0:0:b0:570:7df7:e401 with SMTP id r199-20020a0de8d0000000b005707df7e401mr3222285ywe.29.1689280090428;
        Thu, 13 Jul 2023 13:28:10 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id c23-20020a814e17000000b0057726fce046sm1922625ywb.26.2023.07.13.13.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 13:28:09 -0700 (PDT)
Date:   Thu, 13 Jul 2023 16:28:08 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 8/8] btrfs-progs: tree-checker: handle owner ref items
Message-ID: <20230713202808.GZ207541@perftesting>
References: <cover.1688599734.git.boris@bur.io>
 <45586f6889c79d6e1708b2b78ee9043b15cf6dff.1688599734.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45586f6889c79d6e1708b2b78ee9043b15cf6dff.1688599734.git.boris@bur.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 05, 2023 at 04:36:27PM -0700, Boris Burkov wrote:
> Add the new OWNER_REF inline items to the tree-checker extent item
> checking code. We could somehow validate the root id for being a valid
> fstree id, but just skipping it seems fine as well.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
