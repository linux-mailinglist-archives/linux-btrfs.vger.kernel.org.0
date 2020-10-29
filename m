Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE9929F436
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 19:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbgJ2Sl7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 14:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgJ2Sl6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 14:41:58 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81259C0613CF
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Oct 2020 11:41:58 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id x20so4052340ilj.8
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Oct 2020 11:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tJC+jKt/xvuB1zSijd1DnY12ASfncTEWnkrnHaiH8FI=;
        b=pjSibn4ArK2LpvLDtf99XGYB3iZLi3pKKYLtdGM4k7j5HvA9432BP+HpSp+H5yGfxZ
         MIgY3np08g02oLUOzBrHu1Oc74iSl8Y5AYGZqXYpvkzYvljK84cIaCwP0wmY81IhlgQz
         Ud1+8v/im3uPzNQS4hAXSnqrJR2kbn+wgQemaegMvngkw2zjCJ9Zqe26t+ju4bd41k3L
         OORgPkD44JvCF++jwrSpcqd3fFsQNL/H5Y8ryj1glNQxg8U7H3Naua9bApUERcWTuSw4
         Tv3huDJYv1n4odlrBKqLgF+zl7GYU1u2AJ1ZMJcFJn7ghgdmK5fUzjuNS6UuIW2vADdh
         lJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tJC+jKt/xvuB1zSijd1DnY12ASfncTEWnkrnHaiH8FI=;
        b=BiLVQOuXzqYsy+JLoTVBaA64iaAQWjag7QT9fwFnTuv2YD4G1Z71ImtqUke5Ec7ryK
         B2y0tYQ2aKgxOVstrFNXA6UtLbTjRwILkl/1zOGpIzGw5VHaYJ7m0DWi9wFzEDMHlXIp
         fq374ZH48l7k6GQBWDWim+egG3kNhV9sIT5BQWYmZe3bbURMfKXpt82M8+n/rUQjOIrs
         IM1C/c9Yl3VY0vqCNrL0rJBKAPSBYj+iB9na5fV2gaTGW/bKCfCkLhyPxM5BxP2CfRXa
         VsKPOBLYfooMKXGQErv+B/EUXybvoZ3vBxYDmeg7SKSWA4VthAj/hPzEpOyF63xnEWuC
         ZdOw==
X-Gm-Message-State: AOAM531FEi7rpz66xw46eTzPC2kMVUdPJA+6hQLVGwTwnn/CsJ42uhYO
        EhECzMik0fFTWEyb57LViPqtgQ==
X-Google-Smtp-Source: ABdhPJxiFbhE5Y4gInYS/7Yp1Xn9/CNetly+i4ogVq/z9HVHZHOeJu9m3xpRY7i1uu86z4J0Px22pQ==
X-Received: by 2002:a92:c7c7:: with SMTP id g7mr4197762ilk.303.1603996917647;
        Thu, 29 Oct 2020 11:41:57 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11c1::1376? ([2620:10d:c091:480::1:18c8])
        by smtp.gmail.com with ESMTPSA id u18sm2575904iob.53.2020.10.29.11.41.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 11:41:56 -0700 (PDT)
Subject: Re: [PATCH] fstests: add missing remove of the $seqres.full file for
 some tests
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <8bc766361cbe31af4bc1b71f077e9561a1828ba7.1603973261.git.fdmanana@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <3e7f3078-93b7-5885-dacb-023543a17f7c@toxicpanda.com>
Date:   Thu, 29 Oct 2020 14:41:55 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <8bc766361cbe31af4bc1b71f077e9561a1828ba7.1603973261.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/29/20 8:09 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Some test cases are missing the 'rm -f $seqres.full' line but are appending
> to that file, so everytime they run that file gets bigger and bigger (some
> of them are using about a dozen megabytes on one of my test boxes).
> 
> So just add the 'rm -f $seqres.full' line to them, together with the comment
> that the 'new' script generates for new test cases.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
