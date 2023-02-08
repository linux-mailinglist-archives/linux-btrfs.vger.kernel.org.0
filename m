Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39FF068F8B9
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Feb 2023 21:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjBHUSl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Feb 2023 15:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjBHUSk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Feb 2023 15:18:40 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5F77EF3
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Feb 2023 12:18:38 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id k4so213348qvu.7
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Feb 2023 12:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gr137xgKj5SRnQMLzR93HYb3Oc2iJJhNsNQ3Si1K8Sc=;
        b=NYBuRwGsNnVXHRk/82WoLbimbAHc+K6ZOOrkuz95FZRtHFlQYWdcZSYkh9QC9Ezq18
         0I62OHPRcfCbq9+tFtuhaPXU8hQs3kB+BeCQcu9aKB9aby1vAMPm/5ktegtkrvUgHmt3
         yLnpEFtu8dhrlgaHJhSHYFtClkIl+ErqVq8fgIDpNe++BFHmEdo/25s4iosLYaaFrUfN
         sgRqCpH/UYh2hooklELpIdQfsulxTuV6XB2maJEQNUmKqbGU6UNnTYDw5WxItsIm5m+D
         l33MReerQTvfNC6Sb7MbjdlNWtPBUVw0eJM3orYnOTx/8fj/vX32JqKRicsUWU93ctJ/
         b2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gr137xgKj5SRnQMLzR93HYb3Oc2iJJhNsNQ3Si1K8Sc=;
        b=O+3FRplAdP646yLT4WjsjpBf8Irw7iqcG3VN48GbRItJK6c1U7/BFeP9c5zqOqcwys
         IaE0TWjIh44TnFXbyJvILrOEU+f9qmR3cD/nGly240aldMT9hf9COVvU7MWhbqWvkBlD
         WvKubDKinYe/6ooJ4n/dcR0nWUfu/s3qktj3fiT8mVzgYz5bewgi1olV7zj7tDoMyfnM
         8jfCa+tOBVUpcA2xfwA/vSrlIHKjfqH4hhjBWn2WDgutgBagpyTWp75mkCZYXWNk0tJN
         pImE4/auJjuqNeb6BEUCou0ZywjaBTmVqbI903A1priYSSp6uC6FZupB+RKbc03lGXtT
         rQ6w==
X-Gm-Message-State: AO0yUKW6ptD3MgcFvW2xO9PoLptcfYGC3FzFnr/1OSp/6e1hyKwoOYch
        Vduml55L3Zi0H5KTYpBDbf0zBYZU5VpNnjV3UDQ=
X-Google-Smtp-Source: AK7set9Dw+08gL3hTU7CAibgIE4Xz1jkQBgdfVgx3nl+UcoWZZ9stofVNAAV+NW/3K07M6hVGUFf0g==
X-Received: by 2002:a05:6214:1c4c:b0:56b:ef9a:a5bf with SMTP id if12-20020a0562141c4c00b0056bef9aa5bfmr17369983qvb.48.1675887517806;
        Wed, 08 Feb 2023 12:18:37 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id h67-20020a376c46000000b0070495934152sm12402405qkc.48.2023.02.08.12.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 12:18:37 -0800 (PST)
Date:   Wed, 8 Feb 2023 15:18:36 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v5 08/13] btrfs: zoned: allow zoned RAID
Message-ID: <Y+QDnPvlNzZrF0Qf@localhost.localdomain>
References: <cover.1675853489.git.johannes.thumshirn@wdc.com>
 <946bf77cc07eba1b536466c6da1ce8c575865e7e.1675853489.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <946bf77cc07eba1b536466c6da1ce8c575865e7e.1675853489.git.johannes.thumshirn@wdc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 08, 2023 at 02:57:45AM -0800, Johannes Thumshirn wrote:
> When we have a raid-stripe-tree, we can do RAID0/1/10 on zoned devices for
> data block-groups. For meta-data block-groups, we don't actually need
> anything special, as all meta-data I/O is protected by the
> btrfs_zoned_meta_io_lock() already.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
