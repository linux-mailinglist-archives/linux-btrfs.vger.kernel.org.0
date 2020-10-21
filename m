Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8C6294EFA
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 16:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443290AbgJUOqy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 10:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442691AbgJUOqy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 10:46:54 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5057CC0613CE
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 07:46:54 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id t9so2264728qtp.9
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 07:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rKXAuMxhLaNOdNwpm6cTWCNVi9r/VLeCCTM098GVGaQ=;
        b=xPcWI/l7OtBLXB29o1oelKm6f8EAzansaYq/aVD27DhOL5gWQ8NYuE5MrTdyoRr9Ze
         CqUs2AehbMpgnjv5U5AbHCN6XFiG7P/KLSVQIr0nKHjBip/06LG+BPmF/j75KdWN9t/4
         ezouCyVpZzGiEuch8OGc6auCpiYW3GjlGY53MI1SpDb4dcmlf/ZZIJZeYtOd780dM0pK
         maVFrxGED6BrzE5+cNmtwnBOfK67Ea/WqVUET2Zs99DBEgt6PNlwp6dOQuGO2RbwfkpU
         9jYqN1L04yxxZGrEDooJ06QkmBiXJITlqbToJ6z+6mn93wvfFWz+hS10j4U5acnBcpuK
         1wmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rKXAuMxhLaNOdNwpm6cTWCNVi9r/VLeCCTM098GVGaQ=;
        b=FkmTT0fWFHsZvXzil+mv2C7mQxxjT026wyGRagYcTolasYksfSJAFgRzGgS/pDsMFD
         ubQGDezH+Prd4HxKdWCiI505/55hmLRAeFCYmszifpgNmq5X547xDPX1YBKsSro493ko
         ysCnJLWcL/rneP34DUzo6gJCaND/ZxVEp2m2CEnBnp1HXGCbbl9X6xiihcKI0JeVDSRe
         G2PNnb9/23Flf2mCmohdZJGApaC8y4m4Ne9OIpDXpS4H/IyaOjWvh0hX34ZU4ktmTUm+
         8hXuVEzJEgRvVwnVf7yAW6dCA7oS/+wgonxFypzEuclSC2Q2F3RlPxdKYOG4/38TA7Wf
         cTsA==
X-Gm-Message-State: AOAM532+rzsk0Or697CVxbEoAI1evdE1VMHDzS3Wc9ZSZzGWtQy/r705
        sFxUcY7ZSwF9EXmZlco8HZ+Iin1GVB3god7K
X-Google-Smtp-Source: ABdhPJzr2mC8GL9zZajzmNshaP6UR2yT1hSu9iWGxfmDt+DNqePtKp//e4+vYSr4Rov7NEeqb3FqEw==
X-Received: by 2002:ac8:4407:: with SMTP id j7mr3354239qtn.287.1603291613368;
        Wed, 21 Oct 2020 07:46:53 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w11sm1349583qtk.37.2020.10.21.07.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2020 07:46:52 -0700 (PDT)
Subject: Re: [PATCH v8 2/3] btrfs: create read policy framework
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
References: <cover.1602756068.git.anand.jain@oracle.com>
 <faf2c011057fab289535c3a84256272a23687097.1602756068.git.anand.jain@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <abc5a765-4327-c3e8-bc75-1868d8dd5345@toxicpanda.com>
Date:   Wed, 21 Oct 2020 10:46:51 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <faf2c011057fab289535c3a84256272a23687097.1602756068.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/20/20 10:02 AM, Anand Jain wrote:
> As of now, we use the %pid method to read striped mirrored data, which means
> process id determines the stripe id to read. This type of routing
> typically helps in a system with many small independent processes tying
> to read random data. On the other hand, the %pid based read IO policy is
> inefficient because if there is a single process trying to read a large
> file, the overall disk bandwidth remains under-utilized.
> 
> So this patch introduces a read policy framework so that we could add more
> read policies, such as IO routing based on the device's wait-queue or manual
> when we have a read-preferred device or a policy based on the target
> storage caching.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
