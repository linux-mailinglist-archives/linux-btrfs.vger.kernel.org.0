Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3951E358C04
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Apr 2021 20:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbhDHSRZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Apr 2021 14:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbhDHSRY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Apr 2021 14:17:24 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7F8C061760
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Apr 2021 11:17:13 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id c6so2175395qtc.1
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Apr 2021 11:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=DQZVdYDgxdQjFL/ptbI2y3k+dho0sNH+IGxMewgrV1c=;
        b=u41aO8QBZzruvniTVW8XNebAKbKkjbsuoI5qy9q1SdthLk6aJsjgDd5EsDoc8UhYGi
         HD5gelBeNkJKnsvYp5QnslJAbmVslGrcB7ENmkFsP3acsg6tgnRB8VYBGIwm6vve3B/m
         HP2IYKRnmrDcqom1Qr+37cxkq+dMY2l8wqvXsNNLi79fIPHyFe3eN+ouR6J81e6Xvas7
         D1AQViqb7d1RxsC9SrNA+b/T+/YOwSb96Qulnyw19hzip09BiFHrRg8Ds15mVs/6v/jz
         p3ShspCYz9W4Jfv+Mw3WMsELQMsPqwoTLD2Sri9CiT2YAqsRAyCFyRaX8wcob5cfUPiC
         Z1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DQZVdYDgxdQjFL/ptbI2y3k+dho0sNH+IGxMewgrV1c=;
        b=rthU9QqHNpBCVj8L4izOKn9LVVWe8uciQV3007siOjLTAPBqjbBePev6PSaCtR1OAy
         uvib1w5RwSFvtcuOP4AkgvWZAXP+GU42b69+7jJmOumRcJSoIV8xa/lbJhDkFqDrOPT7
         eYu5EMab3rq0qhD+cZbqFZuqjhBW2lYhbyNTu+ENvmmK0y4HaEIRlMR4zF7vZ+fluBDA
         vWACPWFQSbUX8UnJVqGJNbtVjSDyztA7WgSZLTMbkdZHTMzs3Su4fUCJYbw7Ss/SeJ/f
         mYzIGYsPqTSmx1YQl9d6oK5bw3hikydyatjVcan179HDaFZUy28vXFdt6D45XNVsfmvs
         Sq2A==
X-Gm-Message-State: AOAM533ABEYbTHLKyTbRPLtGf8sBeqa+FkjcbdDSqau82B5F5Mod6Xsw
        6J1ORuxJoBYiVFDpJNwn0+O7IA==
X-Google-Smtp-Source: ABdhPJwbc9YGsm/6h3Br2hSr7xqpnga0XBeORccYL5TTXzFe+AGmHG1NUsBBFxgo+r3cUJnAyc1Kyw==
X-Received: by 2002:a05:622a:110c:: with SMTP id e12mr8853621qty.350.1617905832332;
        Thu, 08 Apr 2021 11:17:12 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11c1::11cc? ([2620:10d:c091:480::1:a6d7])
        by smtp.gmail.com with ESMTPSA id o26sm48859qko.83.2021.04.08.11.17.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 11:17:11 -0700 (PDT)
Subject: Re: [PATCH] btrfs: return whole extents in fiemap
To:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <274e5bcebdb05a8969fc300b4802f33da2fbf218.1617746680.git.boris@bur.io>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <b5c9c0f8-f072-3bb5-acb8-cd51049c8a11@toxicpanda.com>
Date:   Thu, 8 Apr 2021 14:17:10 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <274e5bcebdb05a8969fc300b4802f33da2fbf218.1617746680.git.boris@bur.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/6/21 6:31 PM, Boris Burkov wrote:
> `xfs_io -c 'fiemap <off> <len>' <file>`
> can give surprising results on btrfs that differ from xfs.
> 
> btrfs spits out extents trimmed to fit the user input. If the user's
> fiemap request has an offset, then rather than returning each whole
> extent which intersects that range, we also trim the start extent to not
> have start < off.
> 
> Documentation in filesystems/fiemap.txt and the xfs_io man page suggests
> that returning the whole extent is expected.
> 
> Some cases which all yield the same fiemap in xfs, but not btrfs:
> dd if=/dev/zero of=$f bs=4k count=1
> sudo xfs_io -c 'fiemap 0 1024' $f
>    0: [0..7]: 26624..26631
> sudo xfs_io -c 'fiemap 2048 1024' $f
>    0: [4..7]: 26628..26631
> sudo xfs_io -c 'fiemap 2048 4096' $f
>    0: [4..7]: 26628..26631
> sudo xfs_io -c 'fiemap 3584 512' $f
>    0: [7..7]: 26631..26631
> sudo xfs_io -c 'fiemap 4091 5' $f
>    0: [7..6]: 26631..26630
> 
> I believe this is a consequence of the logic for merging contiguous
> extents represented by separate extent items. That logic needs to track
> the last offset as it loops through the extent items, which happens to
> pick up the start offset on the first iteration, and trim off the
> beginning of the full extent. To fix it, start `off` at 0 rather than
> `start` so that we keep the iteration/merging intact without cutting off
> the start of the extent.
> 
> after the fix, all the above commands give:
> 0: [0..7]: 26624..26631
> 
> The merging logic is exercised by xfstest generic/483, and I have
> written a new xfstest for checking we don't have backwards or
> zero-length fiemaps for cases like those above.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
