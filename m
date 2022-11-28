Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D665C63AD32
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Nov 2022 17:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbiK1QC4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Nov 2022 11:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbiK1QCx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Nov 2022 11:02:53 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E3AE0F8
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Nov 2022 08:02:52 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id e15so6976114qts.1
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Nov 2022 08:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4TCb2FWrNlQYd+Z4uzmL8P45oPWnl0JeHwwWpJYaobY=;
        b=ABm74U9SsYqTgL5b8PH0IvS/B1JUrpb2DvIF0MmIbZ9gEKqkAxZe4pHmHJeF6Iw9b4
         fMwjm856Xcnuq3WTTELwR3zvo01U3gkXIJm9QOQDKzE+wavofqV76u1uWIihrd1l0g4O
         goQF4bFVYE0NtK+CFXMy/zAyaLtGVJZoy/zLU1xp2T7nJRQ+HBaaDRbbZ2IJHSpQwS1a
         18832XJRA5ji4vCI+DgDcJ2DizyN2CHmSqEkldCrHe2u9f2cgQVDjTbr8g1LqUKx0eB6
         CvTp5Cf1MBpJuSM862Rg8KO+3LF23/YGgT6nrsdD4lKZfB+FeyYaD5oyc/O4dvvdwBeS
         SDzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4TCb2FWrNlQYd+Z4uzmL8P45oPWnl0JeHwwWpJYaobY=;
        b=iOmyVFBch/pZdbtGWFbajHj+WAWWxlLpXLHL+wqdXSDUmbYZbs+tFvxDLsJyaA0mJU
         dIX373D/8UftEaZgPlYPe3jVHRK2rDcOid+PLMUiZR8T0bT8Z4hS7Jv65oTFWOFtknmW
         T3DKlG7FuIQtd81CxSNNEm0Le2gNvul0lD+7Aq/PwEzJGUf5biRnFdepLrD7HhAL3U45
         d8E6TGKtyeTv4faG7WJ+PpDSSY2kf5HOaMlnyy1TL/JS82jfO6DvM5cNH7w2dHAuBvMJ
         WIJ1B7qry0qnvTtHMG32edwqmsCLriauH9CNH+Y0+W+/M2qLFWqvM4owhlXLp4X8jZBS
         IsxA==
X-Gm-Message-State: ANoB5pnrD4cmi2OS6hhu/NCTeOk6NcGRpjCnAk2Fwpf75lSi/KUU9tgg
        ZtKSD/gDx2G8HeM3dslqIcT9Ew==
X-Google-Smtp-Source: AA0mqf6XVOkcIpyKRULeoqoELu3EhmM9cvmxWOARjaQ/5E+PVX4xH3KWCHRxVUDc8/0C4+K6s3lRqQ==
X-Received: by 2002:ac8:72d7:0:b0:3a5:2bb7:55d5 with SMTP id o23-20020ac872d7000000b003a52bb755d5mr48068775qtp.439.1669651371824;
        Mon, 28 Nov 2022 08:02:51 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id w23-20020ae9e517000000b006f9f3c0c63csm8452704qkf.32.2022.11.28.08.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 08:02:51 -0800 (PST)
Date:   Mon, 28 Nov 2022 11:02:50 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Zorro Lang <zlang@redhat.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: skip btrfs/253 for zoned devices
Message-ID: <Y4Tbqo7kALoStLco@localhost.localdomain>
References: <20221128122952.51680-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128122952.51680-1-johannes.thumshirn@wdc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 28, 2022 at 04:29:52AM -0800, Johannes Thumshirn wrote:
> The test-case btrfs/253 tests btrfs' chunk size setting, which is not
> available on zoned btrfs, so the test will always fail.
> 
> Skip the test in case of a zoned device.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
