Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F12505BC9
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Apr 2022 17:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345737AbiDRPtn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Apr 2022 11:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345862AbiDRPtg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Apr 2022 11:49:36 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16FB3DA76
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Apr 2022 08:26:49 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id j9so3973787qkg.1
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Apr 2022 08:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ah0fueQ3iLWlIipxrI2Mp7PnF1WOJ+meFzcPfHC/7JM=;
        b=Ec9GdXD1X1rIbBomiEeYu37YrPDeODbln9CqR1d3PZe3ueaOeKGwYWZOnkFKUzuJhc
         I48SZgXKpxeROEhcm/eyv83icvxhG17HS0xd/fJrCwY3LMRsA5i0FN8OEYywYwKpA2o9
         E4bQt7QrpfQoA5aT1YcUDiO3+cTuMS/BzZtjuCZ2zFbLNSsCguuWeksP7DCosEXWi5HT
         8lm+jNKKH3S9ahUjZf5m4SSTKbt0jzbtkR9rv6DvU4jl4nHV+q21o1pUXRpHEcdwXIMB
         RefbRDJBj/LgdEoLoSdxRanw4a6GtBEJPTR7pkh6VQ1jqsbpr/reB6KVHTrHNtyo5uq1
         zBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ah0fueQ3iLWlIipxrI2Mp7PnF1WOJ+meFzcPfHC/7JM=;
        b=ixKQTWnQjS3fHnTHWS7cyk1sSGM02REYwtcjEX74+07mlTPAWfK3Lhq2lUAHl0DeGE
         Gmb3emsX2CJReTmNbghNpxqZwn6icobA1wuPAU5pSq2pq+2t10oEpFHYw7/hLe+AEnfv
         DTzpFp97kbOJrDs9gVXGKe5XmQoaPh+JS60PHI07/ChmERIiqH87e5xAG5fjPi+LBRqm
         wQ6eo1B3K1EbvsfVxJ5A3yMD0iTeNEw9aJ1sGUJUA/0bpZzxfZ1apQllpGMoMy/rxG3H
         bqIDCzk+yAhfH+I7Z1g8zzwKm03rrohryricrZiKCHsGDa2xoRV2qWWKjzMOUbdFldyR
         xnPg==
X-Gm-Message-State: AOAM530tMFSZbMF075DD7UJCajes3QTovxCnsdTR9/qXPrAK2yIxm4Hb
        0S1yMYxSbScKvSJiLI3EaTKSQA==
X-Google-Smtp-Source: ABdhPJwOFwEOy4omdRFEmKvfWG2pAi4WkibjJExVNF3TDoyzJ2V4d36E/XxQDXUhiMZwrqXH1K48+Q==
X-Received: by 2002:a37:9204:0:b0:69b:f7ea:4638 with SMTP id u4-20020a379204000000b0069bf7ea4638mr7100451qkd.77.1650295608747;
        Mon, 18 Apr 2022 08:26:48 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v17-20020ac85791000000b002f1ec31ed68sm6006245qta.91.2022.04.18.08.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 08:26:48 -0700 (PDT)
Date:   Mon, 18 Apr 2022 11:26:47 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs-progs: fix a memory leak when starting a
 transaction on fs with error
Message-ID: <Yl2DN8CyzdpZE3jh@localhost.localdomain>
References: <cover.1650287150.git.wqu@suse.com>
 <0aa27221eba9359cd566fc6448d46b12583211f2.1650287150.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0aa27221eba9359cd566fc6448d46b12583211f2.1650287150.git.wqu@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 18, 2022 at 09:10:07PM +0800, Qu Wenruo wrote:
> Function btrfs_start_transaction() will allocate the memory
> unconditionally, but if the fs has an aborted transaction we don't free
> the allocated memory but return error directly.
> 
> Fix it by only allocate the new memory after the transaction_aborted
> check.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
