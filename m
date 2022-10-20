Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B586064B0
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Oct 2022 17:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiJTPfs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Oct 2022 11:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiJTPfq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Oct 2022 11:35:46 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BAD189801
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Oct 2022 08:35:44 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id s3so13911906qtn.12
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Oct 2022 08:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nr3UIMWfwGhtNeHqIvW7PzVlni4pQoO7uyfyBu0ZD4o=;
        b=fbz8l8RVPmTRquEl9oLiF6Gzdp82p+yLoiLnAeUx7kE7CxQWQA3JLnxJIwPh3Tefmb
         9iy9v0PyJzkA6T/3AlGgV+0mwgcyDAJ+ykyKAiEZLszOgQo7zaZL0psWVXbd4N2tCZDU
         in6O/GOMXBuRlrV+ZvOu0WFaEX1IRBiXtEkjptbMtIC11U88+F6AO6gZQbsbJzZQOrys
         owWuxVJJASCPjlVAJAfwgacu/yHXg8VZ1PkRxCMVI75hhPP0aDQdTZLvF1ORK8nadubG
         L+kHlKHAdQ1sLfRuAxO6+EddvHzxhCnvKiKkJsEvY5RhbspVZbFMD4c99lyioF/D+VQ6
         cIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nr3UIMWfwGhtNeHqIvW7PzVlni4pQoO7uyfyBu0ZD4o=;
        b=UtdECEHNkh1lEaS494lnFJ7mym5yxt322Bnh6Z7eKtBDyd4E1rIx3hnxKujioah0J9
         12bXcdBICLeyLQCOrIO6t+2ne8v4i550gC+yuxyuq5ia9EI2phUFKy8iX3UU1ukk1IJi
         qSFcd6SdsOy7oiZuRL5pR0IeIIynfTeaM3HN9EcFUTjGFf8ukJVDeMdqngcPgKhmaap7
         f0PTZwCxTUdEigMr7WOPNdxlcx9nvcYu/ADi8dPf8HXtjriI4VGKj7qzWnVHXNimck9o
         p3g3dTR0aNjQKkTsfX1stG65JZeQlkR8gaFfzHO23S5Vmn7DRrScAbz0mPOhq2bCBmnv
         hjMQ==
X-Gm-Message-State: ACrzQf3EJM4P4V1PQMyTFerX+j5h3xV5ZztV0NwVjDmoQ2j3glCfZ6KU
        NtZVXmQZajJnPgHriSyU4epSFaurMBL6uw==
X-Google-Smtp-Source: AMsMyM5xal5ONTKssd8W6z5xQZCMPJRh9wUcxs0z3CzJslr5UFm2vgajFA6zFDeoYMHtppKtXnurzA==
X-Received: by 2002:a05:622a:5d4:b0:39c:ba77:d032 with SMTP id d20-20020a05622a05d400b0039cba77d032mr11608182qtb.642.1666280142887;
        Thu, 20 Oct 2022 08:35:42 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id d12-20020a05622a15cc00b003995f6513b9sm6395881qty.95.2022.10.20.08.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 08:35:42 -0700 (PDT)
Date:   Thu, 20 Oct 2022 11:35:41 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [RFC v3 07/11] btrfs: zoned: allow zoned RAID1
Message-ID: <Y1FqzVtX9lUOucgr@localhost.localdomain>
References: <cover.1666007330.git.johannes.thumshirn@wdc.com>
 <ae7eefe6f2862c14b5fbb15a7445d0bf2956acc3.1666007330.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae7eefe6f2862c14b5fbb15a7445d0bf2956acc3.1666007330.git.johannes.thumshirn@wdc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 17, 2022 at 04:55:25AM -0700, Johannes Thumshirn wrote:
> When we have a raid-stripe-tree, we can do RAID1 on zoned devices for data
> block-groups. For meta-data block-groups, we don't actually need
> anything special, as all meta-data I/O is protected by the
> btrfs_zoned_meta_io_lock() already.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
