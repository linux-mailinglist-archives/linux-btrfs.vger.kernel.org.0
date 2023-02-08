Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889A468F6DC
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Feb 2023 19:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbjBHS0k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Feb 2023 13:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBHS0j (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Feb 2023 13:26:39 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C16270F
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Feb 2023 10:26:37 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id cw4so686687qvb.6
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Feb 2023 10:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/B2r76dVxVoMuBLDSYWf+FTha5PdwHyx60SntDv6IhQ=;
        b=xn72+3gdY87iun1iFpc0TmqsR3PfJ1sLowBBOxhDwBx4EG+zyVolFncARZvQruDYHP
         UAiq9cA3QmdQf0pSFUpVJIXLnM8tW0GvqIP9PZK9c/YU85wpmo0HT/o91dX4/D9RKUQv
         a4PT9Nybj5BG9WKh3MMmOXb+Sb/lYxoxknxbqHuy8mwu/sVHT3zeodd89YbtlIq1maLL
         JnFicqnqVQEst/W8FDKNRhnnlENkaMp9biyg09KsXr3AV65ntLuLBoGojuSUpq8P+l5X
         duJASqNch7dXzopkloxZG18VNhvaGSUx3WNND3Q4Yzu/hwTimdkcloivsBuj/znC3FMd
         A6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/B2r76dVxVoMuBLDSYWf+FTha5PdwHyx60SntDv6IhQ=;
        b=rF1fs6XyL1zoQY2opPxH7/5CsI+Nh9kZP+RNu5o1NjSOAn74VqyZ4ioIS90LptVcCL
         zP+uXpgszqZJLIKaNAHg4rdZ67dfllm+9l7sw656dDezmOiPSLDRXymWjHofVBAALQkZ
         nD7GiYr+FEHaO9RNdgZGrQBycaDLoqHoDEuaqChkoaTU2X0XBGVWDCwtJjSgs49ctAiq
         fHMay+tEAjC5w4vy3sqNsHEDzjjaIjNqZxGZpLfrJk2F3H8+l4SYltRb2laE9ZYkisjb
         nTxaJDRmMdxL6+qETqLwHYfnFmjmYhrnUeNlA3PQ2YUfWCCqGKX+PsuiybLt8vISIncr
         Bf2w==
X-Gm-Message-State: AO0yUKUHcBychSa4uRyWrbVbMNRupJNcsDsKTS71CvlYp8C4ZIiqpj5/
        q78eSzSweu7pa4478qRid1c/J/7WOwkd6EMPo8Q=
X-Google-Smtp-Source: AK7set8f5LigK+GKsiwOwPF9zWi0b6ussaV9sAhWKw3dYAsn5vLXRFmvrQz1xYuGzK7/F+P16S6WOQ==
X-Received: by 2002:a05:6214:2b08:b0:56c:1574:6538 with SMTP id jx8-20020a0562142b0800b0056c15746538mr6481945qvb.42.1675880796610;
        Wed, 08 Feb 2023 10:26:36 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id d2-20020a05620a204200b0071f0d0aaef7sm12046900qka.80.2023.02.08.10.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 10:26:35 -0800 (PST)
Date:   Wed, 8 Feb 2023 13:26:34 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: some minor tweaks to the extent buffer binary
 search
Message-ID: <Y+PpWt8qOpS3k+Wf@localhost.localdomain>
References: <cover.1675877903.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1675877903.git.fdmanana@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 08, 2023 at 05:46:47PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Add a couple minor tweaks to the binary search function. These were
> originally part of a larger patchset I'm working on, but since these
> are trivial and independent from the test, I'm sending them out
> separately. More details on the change logs.
> 
> Filipe Manana (2):
>   btrfs: eliminate extra call when doing binary search on extent buffer
>   btrfs: do unsigned integer division in the extent buffer binary search loop
> 
>  fs/btrfs/ctree.c | 31 +++++++++++++------------------
>  fs/btrfs/ctree.h | 15 +++++++++++++++
>  2 files changed, 28 insertions(+), 18 deletions(-)
> 

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
