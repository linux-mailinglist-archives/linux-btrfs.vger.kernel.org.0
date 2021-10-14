Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6547F42E002
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Oct 2021 19:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbhJNRZy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Oct 2021 13:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbhJNRZy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Oct 2021 13:25:54 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4ED6C061570
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Oct 2021 10:23:48 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id bj31so3393266qkb.2
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Oct 2021 10:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hoUvxTf6Q59/5k7A41iAepDM4tLMUp6LO3twq3RgZkI=;
        b=O6PMwPISZ6kRGAfcCHRQanpW3ks5JABicUanw5QJC67Z8tB9MaqVoTeF4oTKR9P+hA
         2DfSYh3ySb1PiWQH9rAFfc08DT1XppSUSaIdrSE61++w92x0piTOySRF/7OzIkMY3JFY
         faaairSrMwRt8Lw5H9kXW7if46Z9rJAn79zLQ7ENTFKJUkg42dbT7qpEnNd9OQXjr2Ca
         gghCt6YgzRC1fVhkT8TbJN13vyCvtIW/FDuVqCSiTAKFdkw8N5PE8amvxq2bfePJRs3y
         EAbFgBh7yU4azf850eO94gfM5DoZqi1iuwy0bDj9/MnRkpQCT9nkm5t3E/cNuqI+iaZW
         dZ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hoUvxTf6Q59/5k7A41iAepDM4tLMUp6LO3twq3RgZkI=;
        b=W/II0TDA6XhSFTjqwQZHVhyIBL12e4OdxtXnfoTTTU7+w/LFaKPH6nI8EOg/2gyW38
         Lys5gHIwc/kR+LteF0Js6CGrZET64okuhwSGrDVL7H+18+Rj5Q4zgJvTnETJbiugqGTg
         SfGfBMaQWCLXvmiAQNhLjn1TD3sGwR9FSbmVDHCq0l4RlC8kRezGdrXKmpRUqlxXVBWG
         CF90iFBOOV7jJiH+cPaRd5RZwUhJgSLZnNkJu7e/zWuc64uuaVHz8GaeRbMmkdlVtgfb
         z0XqYfIRW7KfxRBdRrFTOzW025dkDj3ZWgO5rCpO5zlmQpuCl/Q5W9YYXk29ei5s/Wy5
         +HKg==
X-Gm-Message-State: AOAM531DYVfF29aotisbDZtN+VJ3R1g1K6PZNuQEEPumHIQ7sfGtOiLr
        sE1zofPWC9zvEqCi2/yxoVKVoA==
X-Google-Smtp-Source: ABdhPJxijClXePuKm8W7GJpRXVixUoV8n2pdbDmvIrYLMVVzn52792z+Cc9bXyjClykhetjjCg8v2g==
X-Received: by 2002:a37:8044:: with SMTP id b65mr5849697qkd.295.1634232227920;
        Thu, 14 Oct 2021 10:23:47 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j15sm1872671qtx.67.2021.10.14.10.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 10:23:47 -0700 (PDT)
Date:   Thu, 14 Oct 2021 13:23:46 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix lost error handling when replaying directory
 deletes
Message-ID: <YWhnotaGpI9STlEX@localhost.localdomain>
References: <d580b8836d741d5f474536ddcb262dcd26de6262.1634228346.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d580b8836d741d5f474536ddcb262dcd26de6262.1634228346.git.fdmanana@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 14, 2021 at 05:26:04PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> At replay_dir_deletes(), if find_dir_range() returns an error we break out
> of the main while loop and then assign a value of 0 (success) to the 'ret'
> variable, resulting in completely ignoring that an error happened. Fix
> that by jumping to the 'out' label when find_dir_range() returns an error
> (negative value).
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
