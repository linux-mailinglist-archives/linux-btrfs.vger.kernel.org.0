Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4A83D1868
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jul 2021 22:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbhGUULf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jul 2021 16:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhGUULe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jul 2021 16:11:34 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF9DC0613C1
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Jul 2021 13:52:10 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id s193so3424577qke.4
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Jul 2021 13:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h1JktM+0qQemW/QVrwzQ2IbM7ztSrTgIEbp8sqOhDuo=;
        b=W7svM9KlNEamb7YOyXAwTH7NiGYj5ebgfHIW9RXx4ovi1GlHrI5BTQUmr2sRuE67ic
         R2NGVzlvf9fFhicFWVlH1U/K0nd63EpSsBxgOXbHJCmjC/FMch17bxPNhd63lyoWvUIm
         +4MABSjMLChLKaEEnToxnUTs9WzI7v10x1EeYR32DtsYuuD9m/6mnkJriDp8jsrXsARL
         sTNdVxtuF4B9ONAfPpl5cuUSrWSOj/BiYAZ/C0qTh+eLaStJww9wHCu8oo0RcPLORYlp
         0v+jVgDro5eIfSrIxpfuUhzFhUZHfNgG2E4ztSJ/nkoMZrVwuz5Yq44KJuMrCnQeYjAj
         /P0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h1JktM+0qQemW/QVrwzQ2IbM7ztSrTgIEbp8sqOhDuo=;
        b=dwIImkIluSkBW0V4ouKhbndPsTx2s6Vo004whEhG2nGMNPzkeQm26UpE3FSS6zNqqw
         HPt95stTCGvvGuj2GFtEwbnuAylRZu2YAJYhxxPeSI3jAA8dM3rm0cp2Kv1HbaaxiEGa
         a2LnPZg7iOY2+b1DfKbWQlfzaP+3ysPq6ZbrqVQW2iMMFEL4YDYxBn3X3HuvhVHXVUP/
         9Guzblkasjh+CC9L+lQ4OHKlbaeJegDa/5g0VpoM0UVp7FSpXWlsMmsBCBwrVd4sp6DN
         3lCCAHPcGw/wAwYSAe4nTzOJqDNMpPyjQpyiEkmC6cKA6Qwv8Gx125p6Korptdk4J6p0
         Q7SQ==
X-Gm-Message-State: AOAM532fxGggLVGfNJXhgaAwBbtrLrwJx/GlZAdv5yeJ1XJDaaj5IUQa
        brWXeH6ewlYEu3Jj4bROI2EYVnS5PHbHgvpG
X-Google-Smtp-Source: ABdhPJx+PdR7DGOsrw2e2T6Z86K50XpZpfs2A9SI2kBB6zC+GH7Q+282GznVjIAy03Lq1RzWxTi7zA==
X-Received: by 2002:a37:858:: with SMTP id 85mr36853514qki.70.1626900729345;
        Wed, 21 Jul 2021 13:52:09 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11e8::1223? ([2620:10d:c091:480::1:9441])
        by smtp.gmail.com with ESMTPSA id 143sm8670111qkf.3.2021.07.21.13.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jul 2021 13:52:08 -0700 (PDT)
Subject: Re: fixes and cleanups for block_device refcounting
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <20210721153523.103818-1-hch@lst.de>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <17147cf6-dbb2-39ac-c8ff-e95f87c1173e@toxicpanda.com>
Date:   Wed, 21 Jul 2021 16:52:07 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210721153523.103818-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/21/21 11:35 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series fixes up a possible race with the block_device lookup
> changes, and the finishes off the conversion to stop using the inode
> refcount for block devices.
> 

You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to the series, thanks,

Josef
