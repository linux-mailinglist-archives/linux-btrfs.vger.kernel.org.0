Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF1E629C38
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 15:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiKOOir (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 09:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiKOOiq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 09:38:46 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B4719C13
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 06:38:45 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id cg5so8778229qtb.12
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 06:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R+SinHn4vnB6av3+sr2VUp4hcDCA4rcKGZ4qy5Lxifo=;
        b=qVfWIcQcowSxfI8ngA8CakjlfMeSvmBe5tI6IFtJagf0V+OeUxeBs5Km3AZkk5P5o8
         YD7xLbcVRAnEWvjYnnImlnoS4W4eEJf7I9VELO8E0fsCw5V5q2cKG09RmnLpUttAwO5s
         07fijjbNykZcspUQf2e7T1jqojmBYhTuyO1GML9t9BfI85n3OTqWJeztCfDcYeBJdOdB
         lM7U715BPX0MPmYccoI73TJ4QKbBljLbrd20rgYMgUUuFYI0nR+YY9bT4NzG9E70xOhD
         ZeR+3p07BVmFz9EJfi/6l6XpULVso2gA1VOWc+vQZZR0CeLhzioe1mKG975xuzsTYvU6
         2rDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+SinHn4vnB6av3+sr2VUp4hcDCA4rcKGZ4qy5Lxifo=;
        b=oRmsYZN/j9gGEHBzEA6ARm2B2RJJQ+AtW8+AZo3kB6H+1pBe7xWCk8jyR8waltpqho
         6tku4VP7+g9zpfHNZSuYKHKS2BHri2b8hXnQ3ffcj2OBE+WiF8v8kn1kvoRAFjnHWmJb
         cGkct8wmrOkxD6ssuUlxw3+VFn5VMNyH5U2RmEau9u9u4Hr/+VIItGHKLXzGVgz4Or7c
         nriCwu9V54cxzh0UnGhWvNWkdX/hzR5pRFpLXnMSqBndbxI1gUQP2PfQUxlw40AcBvk3
         /va8yqEx5qBYAVXL02Oin6fNN8OavfBhF1mfyEHCXXmZLlLNkuro5nw54un0FvCQXiK9
         j8xg==
X-Gm-Message-State: ANoB5pmWyP/AokbFlD5WrQ49Ad+Dunt43CCJT7po2TVbHhGRUaKL+kFs
        0E50k/kZ4jH2FGyaq58pHmXhyQ==
X-Google-Smtp-Source: AA0mqf4aEPQp4P82zZUj7vS2YieUHjLSHzgW8J/FeVXlAuadxc5mEpWGAkPdjYkzm2BVit7BJL0R1A==
X-Received: by 2002:ac8:544b:0:b0:3a5:6961:e1b5 with SMTP id d11-20020ac8544b000000b003a56961e1b5mr16892892qtq.598.1668523124048;
        Tue, 15 Nov 2022 06:38:44 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id k21-20020ac84795000000b003a569a0afcasm7146036qtq.66.2022.11.15.06.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 06:38:43 -0800 (PST)
Date:   Tue, 15 Nov 2022 09:38:41 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Qu Wenruo <wqu@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs: move struct btrfs_tree_parent_check out of
 disk-io.h
Message-ID: <Y3OkcUhOMSXjTISF@localhost.localdomain>
References: <20221115094407.1626250-1-hch@lst.de>
 <20221115094407.1626250-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115094407.1626250-2-hch@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 15, 2022 at 10:44:04AM +0100, Christoph Hellwig wrote:
> Move struct btrfs_tree_parent_check out of disk-io.h so that volumes.h
> an various .c files don't have to include disk-io.h just for it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
