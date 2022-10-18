Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8624602E57
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Oct 2022 16:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiJROX1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Oct 2022 10:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiJROXZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Oct 2022 10:23:25 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1E42250C
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Oct 2022 07:23:24 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id m6so8699491qkm.4
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Oct 2022 07:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QfJXYu3baHg501W9UORFQ3+1HPvyhnmHtZ0sd9zH7Wo=;
        b=1RMX/1wJ1KEQEImLqTsjsFyuhFiWFyzbCjnHSWW1F6YQPG/PHA40Rej5DlYBMBr50P
         4ipsl+YTr4dZ6nkWVesXqyWtYMCS42cIIBZmBoPivCAoMDKnpUN9pR/8EHzt+3qHpQ3Z
         NQN8pB+qt+fMSFTs9mS5FgfpVRx7n14NLmWAiYfof3spAfwCn82XwCByLAZ2N7CZMvRs
         hotSvOgZ+F7KZX+qV0bk/2KqH9LH3YHt4uRLB+TJhKTNSSoOPAx7t4xksubPElucRUo7
         0ONP5EMgiGZ4dFFPjMCghGB8bC74tDwMqcliJnddZZSdwUaYG/DJh+Zk8HBl0ZUf77DH
         osEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QfJXYu3baHg501W9UORFQ3+1HPvyhnmHtZ0sd9zH7Wo=;
        b=8PGPMV0Q0ycgzZkoZq+SxEmy5tt28s4mA4/zZHzYRHgyEE4lBDDHOMU3idNznbei6P
         t+FpK2tCQijXxle9bKUtLXSgQHulkVE0a/bKLEcKI2ctnwULIabRnV1e27LenuCdiBhF
         ecUHj2TcPx3lKibvBtcmSsXRViykxvbBnvWv+qIGWSMjy5z9Wzc5e6CM8BWkGo/i/ycw
         H2SARM5xt9m61QZLVZ3chf7kvhKQzpxrXx/0AecjbC+BZcBUVuhzzjHp2BMcnv0ucxQI
         5sLdVS6N+njOwl/cbAji64aziA4xHAMrBASbOX7LK6oY20yfg1FEVcBXXf5zHF5Ptho8
         gfIw==
X-Gm-Message-State: ACrzQf1PQ5M2/ambiZsAkyM7PcVQcg2QgyQGHup+FvMI1ECuYShHJtm4
        BycVffnGfPDadtuF+5NnuIBtmQ==
X-Google-Smtp-Source: AMsMyM6sQmfhpV7Vi9JF73n8UrHIGsX7SD2FX8Wz3uv2sz3oGEhYy6Y2PSx3epy+zbBp4phQ9iuhlQ==
X-Received: by 2002:a05:620a:f03:b0:6cf:c0a1:20bc with SMTP id v3-20020a05620a0f0300b006cfc0a120bcmr1986415qkl.663.1666103003708;
        Tue, 18 Oct 2022 07:23:23 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id dm54-20020a05620a1d7600b006eeb185c209sm2405035qkb.50.2022.10.18.07.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 07:23:23 -0700 (PDT)
Date:   Tue, 18 Oct 2022 10:23:22 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix type of parameter generation in
 btrfs_get_dentry
Message-ID: <Y0622mvIwQgdfTPr@localhost.localdomain>
References: <20221018140552.3768-1-dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018140552.3768-1-dsterba@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 18, 2022 at 04:05:52PM +0200, David Sterba wrote:
> The type of parameter generation has been u32 since the beginning,
> however all callers pass a u64 generation, so unify the types to prevent
> potential loss.
> 
> CC: stable@vger.kernel.org # 4.9+
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
