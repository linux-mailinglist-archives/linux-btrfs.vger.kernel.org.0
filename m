Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12554302D1A
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Jan 2021 22:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732250AbhAYU6D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jan 2021 15:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732008AbhAYU57 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jan 2021 15:57:59 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCAEC061574
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jan 2021 12:57:14 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id u20so5324751qku.7
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jan 2021 12:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=niKnqml7zC5pFULMCBl20DPmuabrsvNS8Avv00VlMWE=;
        b=nTwcgXacBOWIyO17J3T7x4kCqlbmnHrOXW8cNj49+Sti0s/kd5lxVHG5FYAW3uiJpi
         BITVuCZSXrV6IF4DeVo9wp0meCHiPwz7ThSz1kzfwWxFdt2QwObyj4EN3eeLr4WGNhGb
         lqKl3P8odkxgN6z8fZG+9l0sU29VH5dnb0zoNd1A7mvV59SYS+S9J+wh2PvbXjQ0jMaU
         TvMLpsfScaxEVmSRfFTnJkvaXGOx2kpdlDT5+NUSCnImbmsMzK3LfPl9Qx8Ljx7mfAvZ
         Jlf2W7tMNMeaW2PQ3pAtE0cNOwSbI73W94MEbOX+dmgfEHdKo8fkbNUQZ/wvi9oRsGjM
         1FyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=niKnqml7zC5pFULMCBl20DPmuabrsvNS8Avv00VlMWE=;
        b=L+ngB8yyJ0jnXLiHUaX37NL80LTe32uhXuHX/W634e3rjR568TW7bFGPSTc69dYZOG
         Rc+/UdpCUzqviKIxmjZl90gezCYHtVyXSCwp3Mb/I6y7hP3VXgULdgPt5HqLm3k5/hC4
         rFcW1LaS5y9D31chzpi9H4rXJVG3ka9EkaDq0uTXP5mo+NIqZPn2GiPeaomRFSdUDrHQ
         cG1Ut+eZITZ/4wcDgkIE5dASRAZYlPyUSULO2JtIItcf9l/F+xlBBN3t/mlccZUGiTKR
         cENOxyImEF3/tr5zjrD9hKwug+G9ShldRLc1OjVbLn53V1IeBh2brlNLLvVyax4siXcA
         893w==
X-Gm-Message-State: AOAM530oVklYHb0e49bzU9lsyjK3J8WPyAH17bSwK+GMaWEbP/ZEdtCy
        Jr63WW81qENzhURNt/7b9sXp6PZK9D3JdfSU
X-Google-Smtp-Source: ABdhPJzPgdW3PPLtjzqPd28b002hA5VqIxXzmwvjqq0kI3Uga2Y7QtGJeuapu9ljTVXbLg6lKogZCQ==
X-Received: by 2002:ae9:e716:: with SMTP id m22mr2753241qka.245.1611608233438;
        Mon, 25 Jan 2021 12:57:13 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:11c1::12e0? ([2620:10d:c091:480::1:8a2c])
        by smtp.gmail.com with ESMTPSA id l22sm3537574qtl.96.2021.01.25.12.57.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 12:57:12 -0800 (PST)
Subject: Re: [PATCH v7 02/10] fs: add O_ALLOW_ENCODED open flag
To:     Omar Sandoval <osandov@osandov.com>, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1611346706.git.osandov@fb.com>
 <09988d880282a6ef0dd04d1fce7db1dbbd2d335c.1611346706.git.osandov@fb.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <53d9bf65-7076-c136-b464-f5c35de37790@toxicpanda.com>
Date:   Mon, 25 Jan 2021 15:57:10 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <09988d880282a6ef0dd04d1fce7db1dbbd2d335c.1611346706.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/22/21 3:46 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> The upcoming RWF_ENCODED operation introduces some security concerns:
> 
> 1. Compressed writes will pass arbitrary data to decompression
>     algorithms in the kernel.
> 2. Compressed reads can leak truncated/hole punched data.
> 
> Therefore, we need to require privilege for RWF_ENCODED. It's not
> possible to do the permissions checks at the time of the read or write
> because, e.g., io_uring submits IO from a worker thread. So, add an open
> flag which requires CAP_SYS_ADMIN. It can also be set and cleared with
> fcntl(). The flag is not cleared in any way on fork or exec.
> 
> Note that the usual issue that unknown open flags are ignored doesn't
> really matter for O_ALLOW_ENCODED; if the kernel doesn't support
> O_ALLOW_ENCODED, then it doesn't support RWF_ENCODED, either.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
