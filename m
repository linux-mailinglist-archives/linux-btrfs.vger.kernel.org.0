Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31D41F7D23
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jun 2020 20:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbgFLStX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Jun 2020 14:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgFLStX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Jun 2020 14:49:23 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB38CC03E96F
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Jun 2020 11:49:23 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id cv17so4813638qvb.13
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Jun 2020 11:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=qVgO4lJcD3X1uhhAMDxQBptAYPJRL3Gsm09m8T5IPT0=;
        b=mZZEEQqVjI1MXoAQf3MsZqcwhAePECZoRy9bxnpS9Xuu2PRG4RvG7h0gIA2ltFLTm7
         IrOpznIix6PhbnC7qNNTpE/VaoOkIGbmPsDF3WkQXMREjly8SJ9zBAy81wKpU2YexQL/
         9iT+d83HWsOh9N2T6jIhhyrTXW6J8aczzmYFx9Aumj+ZI5ooMVxXY6IB/zsjcx9oUgZ2
         CI0hDbbDicD48mocZqHp5etycWgW+Fvjrxu4CNoAqkw8QKGHJr1QDbL/qyHJgEgGuOTI
         P4aiGpQjUcR94pAA896APk7Vrnm+TzFSHiVeIFmPYyEqhq8LlEClGM28C0/lx7kcTL9t
         qX6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qVgO4lJcD3X1uhhAMDxQBptAYPJRL3Gsm09m8T5IPT0=;
        b=aFCO6hDQZvAjk3sRkRpscDfdEqD1tDJt70IWN1wlXg5AvbGtQvhpW/QOYnU73abPEu
         IyPvpqYYNnAP4WMypcuB8dSSoX+g2Xqj20vnF9mkRx1DuU8NOhhi0wmlGJz/0N2ynFRk
         S3ahWiQzFemZ0SrfAQ4n2uGFHGltkBvLO3GCGv08H7GtcuEBb2ZDqR4TDl6PGRuojDmM
         vbda5qFx3elVMKy/vBnRkJxyeWrzJRhC+xF5D7WeGmR0dRu8OcJHzCX59COWAINzB9T9
         3DzMeuE65/ggYsqpE+bvANI8xPsYVRtxzRTTwkDiBcgyyUWwbgQbskmRHevbeVQh975I
         4WkQ==
X-Gm-Message-State: AOAM53386VqmY/kpDAD8ry7DyfakK5aZi3rm21bZuZoNmtUkg9AZlqZN
        8g6/VKXjb85mR6AaTBtj4YVpdDf5BRKxxQ==
X-Google-Smtp-Source: ABdhPJwLCeZHEGbR3nvewyO8ciT3M7H7Vmjq2GC+2qSWngZzd6YHRixJHHod9q/vtL5ZcAlfazkSeA==
X-Received: by 2002:a05:6214:b33:: with SMTP id w19mr13122433qvj.7.1591987762319;
        Fri, 12 Jun 2020 11:49:22 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11e1::11c4? ([2620:10d:c091:480::1:487c])
        by smtp.gmail.com with ESMTPSA id z19sm5568315qtz.81.2020.06.12.11.49.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2020 11:49:21 -0700 (PDT)
Subject: Re: [PATCH v3 2/5] btrfs: inode: move the qgroup reserved data space
 release into the callers of insert_reserved_file_extent()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200610010444.13583-1-wqu@suse.com>
 <20200610010444.13583-3-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <22373714-6ab1-d812-234f-d37b4bd33ee6@toxicpanda.com>
Date:   Fri, 12 Jun 2020 14:49:20 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200610010444.13583-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6/9/20 9:04 PM, Qu Wenruo wrote:
> This is to prepare for the incoming timing change of qgroup reserved
> data space and ordered extent.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
