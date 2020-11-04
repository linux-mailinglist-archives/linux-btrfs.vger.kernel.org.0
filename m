Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0DE2A6F50
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Nov 2020 22:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731152AbgKDVAd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Nov 2020 16:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730906AbgKDVAd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Nov 2020 16:00:33 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA326C0613D3
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Nov 2020 13:00:32 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id 140so20723667qko.2
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Nov 2020 13:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=05srrPXh0Hbfw7TJHhj/OgO44D0QBeBjRr86jh7U7MM=;
        b=m+Y0chVTRXj/ze4aQ8kABg9Y5e9SQca88gbAVRs+s47TR2qTydlOS06Ue7FL/7RtIQ
         ++g7/nXBEAmxelDDyvpJcGnfR3RaYK8Z3092rMcoxN8IA+5Fk9WRQsG4sCeJLAs/qDfG
         90JG6WREbWoNd4+0eiZZzw8CpZyeHshDOipXsZHXBICwIkq9fkC2v5ClOURBJJKg22QU
         l8cbkxBmTeFUkhDWeUBXMMG1wG/RR269PDBPbbqorXI59HUaT52ZR4l/y/pqOyXVVM0R
         e3+KBojgZYS0unWYnYaA9s7fWrzzq7QBzsjhHuHW1JRMMlaED15tdQH5Nc8Wwi7dgF1f
         S+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=05srrPXh0Hbfw7TJHhj/OgO44D0QBeBjRr86jh7U7MM=;
        b=MMCk3Abq704Gw6y1MUa2Ko2PCMxgNJ17fSrSe1fVBN4vtVd1n0FwDSt+CoojtG0QHC
         8oADVgYOyzNSgU7BYPDmuj86vgPh7/oVVp1qHsBtXg36YEJEYoqYEHSDfo4lGz7hAxuz
         aBM/86GCz5Bm0W7dKfN9AnLaDIfBRnAVKd5LmbYVPIABAb2eEOE5bFEB+hSniBx+27jp
         8nCQzX5jXzJQz9k1rrxS+awKQhvHw95uTUCpqtHLZgfOGQsF8HAzkSBefNnY8dsOzWr8
         eY3AQA4+Fn06v4ss0S82gpUKrHo2D6G1k7rjbsFmO5dgp/Hdui74KSINBQdoAyv8vNN+
         GUFA==
X-Gm-Message-State: AOAM531KFdGjbohjt7GkWpkLkvABfd61M02J/yyXvhAfMpzHk0U0nVc3
        ajubcIIBwgo8cOoGQ9FPVouHl0jU4dvAKQ==
X-Google-Smtp-Source: ABdhPJwrlaZXCNTTe9Ihjshc/+GOFfQa6kBFDG5Db2uEemT62kYy3X5Ixl07yr13yIITcqHhOqExuw==
X-Received: by 2002:a37:7d43:: with SMTP id y64mr29204qkc.225.1604523631701;
        Wed, 04 Nov 2020 13:00:31 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:11c1::1180? ([2620:10d:c091:480::1:8f29])
        by smtp.gmail.com with ESMTPSA id z20sm1128727qtb.31.2020.11.04.13.00.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 13:00:31 -0800 (PST)
Subject: Re: [PATCH 4/4] btrfs: discard: reschedule work after param update
To:     Pavel Begunkov <asml.silence@gmail.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1604444952.git.asml.silence@gmail.com>
 <6114f7d2699147186adf70c4e82a9a22de7a78aa.1604444952.git.asml.silence@gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <2b4b412b-32d5-c373-8392-7d23b5c48f9a@toxicpanda.com>
Date:   Wed, 4 Nov 2020 16:00:29 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <6114f7d2699147186adf70c4e82a9a22de7a78aa.1604444952.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/4/20 4:45 AM, Pavel Begunkov wrote:
> After sysfs updates discard's iops_limit or kbps_limit it also needs to
> adjust current timer through rescheduling, otherwise the discard work
> may wait for a long time for the previous timer to expier or bumped by
> someone else.
> 
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
