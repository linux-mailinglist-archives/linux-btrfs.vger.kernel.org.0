Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3F32A999D
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 17:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgKFQjT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 11:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbgKFQjS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Nov 2020 11:39:18 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FA3C0613CF
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Nov 2020 08:39:17 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id n63so1170686qte.4
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Nov 2020 08:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=OidUDvpyBht9zZdJkVXEfI17w44qoIxASuset4xJH1g=;
        b=puTRlXa9lIjTL4NEyK645vNL3ZGazW6MccOZS4ckIGbnQofjf5WA/ALSOgDA7G+qSt
         bSHocMvLj8w/ph8JqThfwRfMUUghj/8wysaHxKG07Ts2IHeCa9jbnwJMvXMAgL04Yngn
         9yO43I61MqNW3/+B+k92kR813HXeaGJKI+2IjZtRDYSZ3tsGzncagVmMzSmuvoThITIV
         KYfmw6ZF+W9NzcjN2mSX3mS2BnNhhLu1CjaHWaii2i+zO0rAfqt0QvPdWW/YEH1AVk2B
         yXvUmLMtBibvsf2yCAEahFcbK8cVv5xErWHFssGfO6MZbjTwH7eyblE9cPmcMA/IjN4F
         nvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OidUDvpyBht9zZdJkVXEfI17w44qoIxASuset4xJH1g=;
        b=LoqOw+/7MnDCWdEWc2jqpMurtFqJJrWNp3ICx1PurwMP9Gw/skHbMMGbSAhNmBbM5G
         he2WfgPjdZH3ItZY6f6L+4UpEeUjSbPaxwzG6UhXxa4SEek97phOwD/I50iTd1Li4OWL
         LOsURXbDgw380VXfJ0vzFLW67VuQyBiQeg11KFoI+voWcrJYdDOpwidRrSdmICn+W9WE
         qEOSRZfZaiY2Z5UCnrPf+WO178DGqzCjhBCKM2uTj8GnOYR3C4SolLiTjiqJhcbYaPC8
         KUzZjK/lmvjI3aAsf6BgAi97zCuwIgFoj9eZx/ehjSHgzb3kJSTGGhgmstgI81HmwtNu
         TViA==
X-Gm-Message-State: AOAM532yLqvWP7cymc1iwcxbwUbXFc8sPA+s51U2QbcT+5ickr63Lt01
        iSsBqbbuuDAB7UghozLIF74kLGqm6mW1eZJN
X-Google-Smtp-Source: ABdhPJx7cpwLJG9Oa0/cH4tra0fHVj4m7aBi1VhLnWVahD45J0E/WD26/GTIezTRM6vobQeyraquBw==
X-Received: by 2002:aed:2c45:: with SMTP id f63mr2320443qtd.301.1604680756206;
        Fri, 06 Nov 2020 08:39:16 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g13sm834784qth.27.2020.11.06.08.39.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2020 08:39:15 -0800 (PST)
Subject: Re: [PATCH v6 00/10] btrfs: free space tree mounting fixes
To:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1604015464.git.boris@bur.io>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <90d01d49-9d15-705d-3e5e-03d4f30fb387@toxicpanda.com>
Date:   Fri, 6 Nov 2020 11:39:14 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <cover.1604015464.git.boris@bur.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/29/20 7:57 PM, Boris Burkov wrote:
> This patch set cleans up issues surrounding enabling and disabling various
> free space cache features and their reporting in /proc/mounts.  Because the
> improvements became somewhat complex, the series starts by lifting rw mount
> logic into a single place.
> 
> The first patch is a setup patch that unifies very similar logic between a
> normal rw mount and a ro->rw remount. This is a useful setup step for adding
> more functionality to ro->rw remounts.
> 
> The second patch fixes the omission of orphan inode cleanup on a few trees
> during ro->rw remount.
> 
> The third patch adds enabling the free space tree to ro->rw remount.
> 
> The fourth patch adds a method for clearing oneshot mount options after mount.
> 
> The fifth patch adds support for clearing the free space tree on ro->rw remount.
> 
> The sixth patch sets up for more accurate /proc/mounts by ensuring that
> cache_generation > 0 iff space_cache is enabled.
> 
> The seventh patch is the more accurate /proc/mounts logic.
> 
> The eighth patch is a convenience kernel message that complains when we skip
> changing the free space tree on remount.
> 
> The ninth patch removes the space cache v1 free space item and free space
> inodes when space cache v1 is disabled (nospace_cache or space_cache=v2).
> 
> The tenth patch stops re-creating the free space objects when we are not
> using space_cache=v1
> 

Looks good, you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

To the series, thanks,

Josef
