Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5428478301A
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Aug 2023 20:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237141AbjHUSQx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Aug 2023 14:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237134AbjHUSQx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Aug 2023 14:16:53 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A7E10E
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Aug 2023 11:16:51 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-58fba83feb0so24932807b3.3
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Aug 2023 11:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692641811; x=1693246611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+IB4jcDinY526zvuXcpVwPKo5CYvslkh0FyxlwQy2lM=;
        b=4GACG/mtJotch9DvuVrr0dM3CBYWU7zcdnr6AffJF9i8BOKOj0waZqy4+RjFhMbVO7
         Y0NE8g16RQx2hr2Hn7fz+LzA6oePfOXviKUcLgchEmVdwztfIrLv9Xj9F4tuXJ2p3Pn4
         NE2nP8EJeC3Y21PVXM+OpfcB5poQPLY+ZOL5SMoTkis0vC3L3+Dh8ZNK52w9tBDmeVam
         1YRmoBD+fBEIMJ6kNg6YmwC8WFeZJL+77FUGS9QyKZvqWZ8DVniEW34ogK4F0ETb+YZt
         sXYgWV47tVUFF83yC8BWWCicF6E/xg5Duv56ZGVNIiwdFpW49cMoRu8iDcRY0YwAECti
         wCKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692641811; x=1693246611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+IB4jcDinY526zvuXcpVwPKo5CYvslkh0FyxlwQy2lM=;
        b=QnzFdFMDSM5yCfF9gy0JzywG3VInBOYXfQaUqhE6hsUymnAzCkUlUasCsUcwtl0YGb
         Pe532Ny97fI9tRwJIFmMp0Kv3exZiyMTuDIfQeagGL5WKdL52XXRBdBxDtBt2DuScUOc
         JxQC0osh81LAJhS78C6/7PvC20j3qAAaDykBqagGXLDq7MnnSdsFG4vCR9r7ecatjw8v
         yFK6kitUW+BpejS584YRNi+zXxGUCt4Pb+bTodK25NWBArWG04uk4XaqwUIeRWEvpSaT
         jRtuYNtcI92VJ13JShLIh4R8fYs48o15eqLiwfHPzlTl/lrPaFHVZ58nwoQ5qgBfUWUs
         fdEQ==
X-Gm-Message-State: AOJu0YycLHHnqDEIinx+RReoKvMP6zYDkTBhltyvnNxD4IWy1EUEVyaf
        3atbNuIGqkJ87ObIqS/8S5ArcQ==
X-Google-Smtp-Source: AGHT+IGthlIKNyGt2sNpHuJM+oBMeN1qkPUnhi7ADDtmF5eFu9pJ+iYmNPrwCew58GbcY2JIuFJmug==
X-Received: by 2002:a81:7384:0:b0:577:3fb4:f245 with SMTP id o126-20020a817384000000b005773fb4f245mr6367920ywc.19.1692641810938;
        Mon, 21 Aug 2023 11:16:50 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id i126-20020a0df884000000b0057085b18cddsm2358227ywf.54.2023.08.21.11.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 11:16:50 -0700 (PDT)
Date:   Mon, 21 Aug 2023 14:16:49 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 18/18] btrfs: only set QUOTA_ENABLED when done reading
 qgroups
Message-ID: <20230821181649.GM2990654@perftesting>
References: <cover.1690495785.git.boris@bur.io>
 <e834e5ffa72d6eb19163164b8e822f6879cd7381.1690495785.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e834e5ffa72d6eb19163164b8e822f6879cd7381.1690495785.git.boris@bur.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 27, 2023 at 03:13:05PM -0700, Boris Burkov wrote:
> In open_ctree, we set BTRFS_FS_QUOTA_ENABLED as soon as we see a
> quota_root, as opposed to after we are done setting up the qgroup
> structures. In the quota_enable path, we wait until after the structures
> are set up. Likewise, in disable, we clear the bit before tearing down
> the structures. I feel that this organization is less surprising for the
> open_ctree path.
> 
> I don't believe this fixes any actual bug, but avoids potential
> confusion when using btrfs_qgroup_mode in an intermediate state where we
> are enabled but haven't yet setup the qgroup status flags. It also
> avoids any risk of calling a qgroup function and attempting to use the
> qgroup rbtrees before they exist/are setup.
> 
> This all occurs before we do rw setup, so I believe it should be mostly
> a no-op.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
