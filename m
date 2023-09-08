Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69FE798998
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 17:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244000AbjIHPII (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 11:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239684AbjIHPIH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 11:08:07 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0283A1BFF
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 08:08:04 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-57358a689d2so1331887eaf.2
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Sep 2023 08:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1694185683; x=1694790483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+kMmOnRhQZNOCXJvJn0T0G+0WHbC6OXEibOuYoAcYZM=;
        b=2+88qp6Q+4pHVSWIqRrvBeVYkJuDTlxagG42qC2Y6BS67N76lykWgLuQptzwUOrfbe
         ScwjF60ce6Ts7bnjeUxiF7545SvIVJACGVJEyfBiXG/HkX4w+Zyqu7VCRl0c2EYpBBFj
         ebqqDoCmqdfNsZpJHFrwU2WsM09nyWXrrpU85yC8cnkKuoR+wVyzFtp8/TtmpVh1oiXg
         sPi2s5FryHcKBwcSRYntfMy6dOS3PGUHfOR9ytH/yiCCuCv33CQK8P/H7UaJZnR0aB3E
         5Xue5qJSbSNDLmQ2G1iOz1kb9k25puBRCEu/WkT+/tM5Bdgg1uhsbCkrj93v9vCuJUld
         r5hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694185683; x=1694790483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+kMmOnRhQZNOCXJvJn0T0G+0WHbC6OXEibOuYoAcYZM=;
        b=Ge7dAf2Ua+xUH9i4pxX8fJnL+Tps6y0IL9ESz00xNnvXVAMoPQs0XUtat4T9L4iOcS
         cPxHQHkFGlIwPlFORnRPZAV9QA7AeLuVi3QEI8LxkhKjlctTiAllUjaVNKGDVrRiGmH6
         vqBrg3eGI9jMy7que50s0kKyLgl7ZzH3CARSyVmZjteI04Aq9A7pcG26w1PonuyEf/wK
         Virph28gselsYMZm4K/SgWReoUh/s5rxLxnkTxXhSUh50IPp79i4MLeQz+R5fMyO4Efp
         D7LQJZKxK7Um9GHRC8OVjKG8IWS7nG+gw9Ek57e28ClFz1D07d5rc+hAO4VroaHpRXCy
         /OWw==
X-Gm-Message-State: AOJu0YxF0cT9LxY9OqmSMVrQVzRoEiGaEOYz4TXgRkZ4TW0CS7v5gizd
        y1ZLVPyH5raTU7NoTscLzMjRi5AgSLbBDyLyfL+THQ==
X-Google-Smtp-Source: AGHT+IH76woyTFnptwKsVcwvx2adjzQ7+s104rWzS7S2QiFHCH2CegcLzIKcXDLrDLlJ/p+XHEJmMw==
X-Received: by 2002:a05:6358:990e:b0:139:b4c0:93c with SMTP id w14-20020a056358990e00b00139b4c0093cmr3508878rwa.5.1694185683263;
        Fri, 08 Sep 2023 08:08:03 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id q13-20020a0cf5cd000000b0064f77d37798sm777094qvm.5.2023.09.08.08.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 08:08:02 -0700 (PDT)
Date:   Fri, 8 Sep 2023 11:08:02 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 12/21] btrfs: log message if extent item not found when
 running delayed extent op
Message-ID: <20230908150802.GM1977092@perftesting>
References: <cover.1694174371.git.fdmanana@suse.com>
 <5c0f10fff0bb9e0bbd0368069d965d8e4ea0cb1e.1694174371.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c0f10fff0bb9e0bbd0368069d965d8e4ea0cb1e.1694174371.git.fdmanana@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 08, 2023 at 01:09:14PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When running a delayed extent operation, if we don't find the extent item
> in the extent tree we just return -EIO without any logged message. This
> indicates some bug or possibly a memory or fs corruption, so the return
> value should not be -EIO but -EUCLEAN instead, and since it's not expected
> to ever happen, print an informative error message so that if it happens
> we have some idea of what went wrong, where to look at.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
