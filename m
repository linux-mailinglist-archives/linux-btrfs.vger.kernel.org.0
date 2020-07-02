Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58B27212487
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 15:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbgGBNZe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 09:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728851AbgGBNZd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jul 2020 09:25:33 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66607C08C5C1
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jul 2020 06:25:33 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id j80so25580221qke.0
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jul 2020 06:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=6tgZcolfUTYGRqPRGbfcXLYooEWHL0fbe+5Re6xqiSE=;
        b=GAzhv1jHPoSVkHw5j8/BvTVC5IfLlCi0fxwvgQCg3FF8a3LDEl0wNpwGw327xaGkEy
         K7efVMAJvuolnFd29QneJ/NBT4yTWvqTFlPs1QYG1yi9W76Wpt6B/2zcW/hBasFPbmFy
         4/c4UFlTE0FSsNBnwektd8m3OGk+lM+0/5b/Nt7sm6svIW3v3a9NO7LYR8/rxc37d7PK
         7Wvs9kdqjDQ6+GOKT5zjaCQidiixSiJdLldZ68RljQb9N1Gt2lei3Ho8yVMNAGXLeSta
         XB5MPpA0CJpUBLVucW53AFXKxRbzhjX3UOr7f7z8aoTFiFusGYacyvF3oRfJGp2xEkUD
         6Jog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6tgZcolfUTYGRqPRGbfcXLYooEWHL0fbe+5Re6xqiSE=;
        b=QzRJWoBWgJl3OOI4qXM6d74wARucTPi1VPeqTBXJ+hPQxtNzxhUzRVNHLn/tsIG+Y1
         kzaOhBR3u/GWHuUVeCnTNzoKMYPL2T+o17c1oXCSEdidmrGiR7VU1cFLdKWArQgNO/Xq
         PmpIl1cZ80ipahVxupbUSvuBAnBqSVbsPn0yH9A5JAFKfzjBU7DgUmy1JUAv860DV9XJ
         a4iIfd8SFJNUKmkNGBawKQ1wHKcGFzRvPWKKr12sP4GIBY3S3qkweIyQncTsvtXjaWNU
         kVkpBLHQtxeZ1M+IMPJL8Q5+hjyRFM0dB9mixVkGDe31rpBaZ8X8WdNx7i1Gtd/NUDL5
         ertw==
X-Gm-Message-State: AOAM532lNA39MFJblPxib3Xkyu0Lr9dmwnoP4sqSFuDz+EOs1KuyR3JO
        evyhrFcX/uF/7MNtBFTyADQc9iXTDgDl2w==
X-Google-Smtp-Source: ABdhPJxtgpFUWksg5bk0wNgxOPY8qUYyX50LJPN2MNx4843YkvHLNN4XhaaPXzJf8b0ExTJyK9U2kA==
X-Received: by 2002:a05:620a:2492:: with SMTP id i18mr30159333qkn.414.1593696332242;
        Thu, 02 Jul 2020 06:25:32 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u6sm9227453qtk.9.2020.07.02.06.25.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 06:25:31 -0700 (PDT)
Subject: Re: [PATCH 8/8] btrfs: sysfs: Add bdi link to the fsid dir
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200702122335.9117-1-nborisov@suse.com>
 <20200702122335.9117-9-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <8469fe54-2641-9873-c845-8355932fccef@toxicpanda.com>
Date:   Thu, 2 Jul 2020 09:25:30 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200702122335.9117-9-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/2/20 8:23 AM, Nikolay Borisov wrote:
> Since BTRFS uses a private bdi it makes sense to create a link to this
> bdi under /sys/fs/btrfs/<UUID>/bdi. This allows size of read ahead to
> be controlled. Without this patch it's not possible to uniquely identify
> which bdi pertains to which btrfs filesystem in the fase of multiple
> btrfs filesystem.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Was confused why we needed to make sure the link existed before removing it, 
since other things sysfs is smart enough to figure out.  Apparently it has a 
WARN_ON() if the parent isn't initialized, so the check is necessary, albeit 
annoying.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
