Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37C002CC92E
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 22:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgLBVwd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 16:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgLBVwd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 16:52:33 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A35BC0613D6
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 13:51:53 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id o1so819627qtp.5
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 13:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=rJRhzQRr8nIlVl9KfPvJLeSrENtJSKewGjqPwuzNn+o=;
        b=oY8EH9V5giTPjeC/2L5rStRvD6SlXzLL5WsXpqdC8uNeoZpp6eFYDMtA/qdz3Pm34L
         uoqH8B6QnYS3bmrAKyQ/OZ3fn2rLG8yi6x199+IBVl+EMt6sIuV7GPuBzBruMS7jD9oa
         7zp99injKtTuuprEVG94QvajWoBXSSN6+H1b8xzMl+LP0VRqjBOIB35fkj2Ak+K6/Q8A
         c6a4mDhr/OPWTMB2vL7bqZ/FDUmIuembwjlsg8fJIeB8IqUGKjnFka2ZwZ+nujk5FZNf
         alKH+4lxp2gJf5XGBhGVeWR69DbbVyAkz7mcMsGvTYD0uzbYkyyCnaDoFQWQrLkdSEWj
         PSlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rJRhzQRr8nIlVl9KfPvJLeSrENtJSKewGjqPwuzNn+o=;
        b=BYsGTOrMKb5S3bBqLtrBOqgc8EQZEsTrBobhvPcZtx9FaWq/4QCRlzb3hmcgOdfSW7
         TMXP0yFVpKyRkYk1cFG4J+yzO3MIHgqEByqRLnrh+gRDG02O1v6CboLO0TixOXnd8m+q
         xjHnapOaqzKST4Q4MjLZLrk0hOprb5HZpRZ89219KpuSK/tDEd3Vqsv2vvAozy4RsRrh
         LOzGbrTOi9nWrJ+McgaVIfKuPiogOlaeuPydq+ifNyR2kD0d6WTPj9fqztrVFXfr2eZS
         lvC0mcVqVcFNr2sekPBGD8w3LqUQXocvDhOhKfcui1iZyWz1PsJUh41CQwDOYeJrOhe6
         3Apg==
X-Gm-Message-State: AOAM533SDhQwacor6A+vvu9pxvJw1GC5MYNlZaoIm56ECNTWpCrMsGcK
        aRLyQBa6D8Abcp5HPFzxkq5atNUVEZ5leA==
X-Google-Smtp-Source: ABdhPJy1tu1Fin7Xnj95cb6kolHHT3iknTJAawz2rI9wH/QkuvXA/Gkf+YNAAM45pGNpO7j162ZpLg==
X-Received: by 2002:ac8:444e:: with SMTP id m14mr245308qtn.120.1606945912177;
        Wed, 02 Dec 2020 13:51:52 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s23sm3365263qke.11.2020.12.02.13.51.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 13:51:51 -0800 (PST)
Subject: Re: [PATCH v2 0/3] btrfs async discard fixes & improvements
To:     Pavel Begunkov <asml.silence@gmail.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1606937659.git.asml.silence@gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <38a7483d-af92-4ad4-0371-0d80f741a7c0@toxicpanda.com>
Date:   Wed, 2 Dec 2020 16:51:50 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <cover.1606937659.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/2/20 2:39 PM, Pavel Begunkov wrote:
> v2: fix async discard stalls [1/3]
> 
> Two others are same but rebased on top. [2/3] fixes not important
> stats torn reads, [3/3] saves a bit of locking.
> 
> note: based on for-next
> 
> Pavel Begunkov (3):
>    btrfs: fix async discard stall
>    btrfs: fix racy access to discard_ctl data
>    btrfs: don't overabuse discard lock
> 
>   fs/btrfs/discard.c | 66 +++++++++++++++++++++++-----------------------
>   1 file changed, 33 insertions(+), 33 deletions(-)
> 

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
