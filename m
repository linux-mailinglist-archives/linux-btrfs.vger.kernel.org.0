Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA65798967
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 17:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244284AbjIHPBh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 11:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244175AbjIHPBg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 11:01:36 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB0813E
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 08:01:33 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-4936b401599so762581e0c.0
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Sep 2023 08:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1694185292; x=1694790092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7P/MY+y50rJ+8M/jcZZpurxrgCHcckwGNmG5e3Xr+vM=;
        b=YckRQQ3HWrWHAMtSOz8lBK9/lCQ309ANIj3h1iOizMW1D27oHp7xhJ0RE8f1GRsoNW
         91aoB1eNGXTrDK3CC1ZxGG2LcwV+2w/HIJ+WjPmQXg4KFOY7MXPsPhMqW1c+kkHUu4v7
         8eHK6VfXkArY1AJZF3s4JfJpeOCPAiLmNE1ODCXHM/uh4KwpWfqgWFFn8D9+BDIXkCy0
         IGJBHBuGkMvs8a5WAn6aAQh2nsr+xZ+68PhQNNtGHofd5NituE4x1w5Jy6KDuQVhACJq
         Cfe0BejBg6ZtrJ7xvxWX44wJCBZlDbfUO3075mFL7yQCUCy4j+vw34qIQKGpPfNG1naq
         Z1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694185292; x=1694790092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7P/MY+y50rJ+8M/jcZZpurxrgCHcckwGNmG5e3Xr+vM=;
        b=vl7y5atCgpmEZI/qu/hiDJTl1y4AzVx0WQw1A47kTlPFCJKcqxCZ/1coy4mVFa9UC5
         ubpNiyR4LdVdGFhmkIJKiTd+fIeOF3Ep+uT58gZ8OJNcFsOj6Spn4IEtQwirbOnpSt6g
         raJlEasB8CX/iVzgbml4N83V4Er6wVs2t+9twP8O4ZKapHpPHkLMt3x6O5+ktVoka+fJ
         QBBHRLEk6UQBmkx9EydC2Yxbjkcq4qspPpkx/TEHYvlKJCxDfZM4ODsi4l3jzCaybenH
         FQ67eUEHoYxOWXi5HIdaxH+2Z6It2u439e+uncGwraWy2jsnEF+dphbbB3L6kuB+pOlL
         4umg==
X-Gm-Message-State: AOJu0YwLdWsXDeutfagKrPFS96B4Fr3Zl0152TOb2CzwyYNkCDjX6P3I
        0GR84z5aFV/Zcu4Nn6J9EyHykw==
X-Google-Smtp-Source: AGHT+IG5uSLnCrF9HzTuGXvKmCOqgz3H0EtthLEAZoW6e/CnuYmO0rZ/Iga2N3mcfbMrsWPuaEWQVg==
X-Received: by 2002:a1f:e743:0:b0:490:1114:f3ee with SMTP id e64-20020a1fe743000000b004901114f3eemr2948872vkh.8.1694185292156;
        Fri, 08 Sep 2023 08:01:32 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id h15-20020ac8568f000000b0040ff0e520besm667733qta.35.2023.09.08.08.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 08:01:31 -0700 (PDT)
Date:   Fri, 8 Sep 2023 11:01:31 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 06/21] btrfs: return -EUCLEAN for delayed tree ref with a
 ref count not equals to 1
Message-ID: <20230908150131.GG1977092@perftesting>
References: <cover.1694174371.git.fdmanana@suse.com>
 <a8109a354d0aa8bbe376f98cce8952e61b342ee8.1694174371.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8109a354d0aa8bbe376f98cce8952e61b342ee8.1694174371.git.fdmanana@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 08, 2023 at 01:09:08PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When running a delayed tree reference, if we find a ref count different
> from 1, we return -EIO. This isn't an IO error, as it indicates either a
> bug in the delayed refs code or a memory corruption, so change the error
> code from -EIO to -EUCLEAN. Also tag the branch as 'unlikely' as this is
> not expected to ever happen, and change the error message to print the
> tree block's bytenr without the parenthesis (and there was a missing space
> between the 'block' word and the opening parenthesis), for consistency as
> that's the style we used everywhere else.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
