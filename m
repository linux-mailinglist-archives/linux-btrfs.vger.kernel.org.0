Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4F02489F1
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Aug 2020 17:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgHRPeN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Aug 2020 11:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbgHRPeB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Aug 2020 11:34:01 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D573EC061342
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Aug 2020 08:34:00 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id o22so15386978qtt.13
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Aug 2020 08:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UuPmgCC+5t/0Fxo6v6dbuZXnEeuw2yq3XgKedOCqjiU=;
        b=cKeeFeKJ6G1FhWPEs4Eb/48zcRAkynhIaJeTd/qXaqs3rPPXLBCXb/x1Vaqvu0EsvV
         TlnSEGVBz9N3N2JtLjbVxKwR2PDcjoxC8iOansVWhGVDF+rHALmxs+bRKd50AwChCp+a
         SVeIWZkA8d6Cm3kplt+ZrmT5gezacVy++iYTDmQDvR+9txdxhTChdsXy/O3Ov4hYY6F7
         e9bihM0XT53ze1vomw48YpdEgZI8azTP0Ugb7gxHSvRTiYNK+yy/Jgc6mIuB/EJ4IsWE
         Lz/wk0TRI+d9gZhWOt6Yr6BhuiZ6ksLe1sHm3XSQQolHEEud43Gl6j2Q5EYBYaaPuYOB
         CMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UuPmgCC+5t/0Fxo6v6dbuZXnEeuw2yq3XgKedOCqjiU=;
        b=EPNBOEIo3TjlQIozEykTIaX3P9ptHBjhZkCzV3HmBmev2vPC3XADRgWcyt/wmm2Tm5
         VlI5k/bnGuPqX/8mL3EjxIyRUOVLVDHyH9sxiMAo6f1jOa8vzaeybUvArua8zmdKBXPi
         NiCGyEY+vxdhYRzu2GpOfHvgBqp4DTp8Y3GBG+ArpF1PtPZi1RKQxNbYScnd9SgFcIZR
         //hV5qxC6jbzGVFQAkGIc1Pt6FMSAHvYOJdeoufJF7bTEsbBj2SceLYxE5MtgutOED3v
         TyB5O/MmPckSOt+rWrALPRIpLvxFqjRzUyp9JzycOjvL4LNZI3eByRfg8NwQGt6OIHJJ
         rMKQ==
X-Gm-Message-State: AOAM531Em4TKGfs9JjEwiiUP8zR+qaNZo641SHlLjPov8wBL1tEFSmBq
        Np4lQjVY9xGUOW3Z5WnHDIRdatoUC9fB5OHJ
X-Google-Smtp-Source: ABdhPJzjPx+170fTqdIUgTDiFxlcb0//NNeqFQYttrMpjUxupsfhz7fwkvmKVSwWU762d4iqqbzCTw==
X-Received: by 2002:ac8:4511:: with SMTP id q17mr18098083qtn.117.1597764840041;
        Tue, 18 Aug 2020 08:34:00 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d9::1055? ([2620:10d:c091:480::1:66f8])
        by smtp.gmail.com with ESMTPSA id i75sm21726760qke.70.2020.08.18.08.33.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 08:33:59 -0700 (PDT)
Subject: Re: [PATCH] fstests: btrfs/218 check if mount opts are applied
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
References: <20200804205648.11284-1-marcos@mpdesouza.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <da689149-a332-c69e-a9a7-f63074bcb64c@toxicpanda.com>
Date:   Tue, 18 Aug 2020 11:33:58 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200804205648.11284-1-marcos@mpdesouza.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/4/20 4:56 PM, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> This new test will apply different mount points and check if they were applied
> by reading /proc/self/mounts. Almost all available btrfs options are tested
> here, leaving only device=, which is tested in btrfs/125 and space_cache, tested
> in btrfs/131.
> 
> This test does not apply any workload after the fs is mounted, just checks is
> the option was set/unset correctly.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
