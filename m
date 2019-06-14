Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16E9145E95
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jun 2019 15:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbfFNNln (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Jun 2019 09:41:43 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36510 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728354AbfFNNln (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Jun 2019 09:41:43 -0400
Received: by mail-qk1-f194.google.com with SMTP id g18so1677228qkl.3
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jun 2019 06:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yb0/sevEMdafr2vXQ3qC01lm6vSKeakGcpjhBltDdpk=;
        b=jQtFbDrieAPENr34h0NUQDNe209XEw+cgr6byx7mhVe+H/I4OpVT5Rmtkwu7rOTXDf
         UZyyDSms5H7OeZUnR29dpbgr+m10jg7GwyH4EjG9Ift7e1mZBpK4rQRKA5x4zK9cIUam
         PFXJWxFZ6irPMweVHfjT48XHVwUaLlv+WO9I8Y36/SMVyJdGBJdbhncsXKKVQ7hH+pq1
         lqPArqtDo8LoKzaNMBpxhNCABn++pc4m+hJgJEN5Lt2W6uFoh20WmEjYvxnYorDjx7sw
         aS7oYnV14PWuNtxeFf9la+DtngnBiNQEOROSSRJrSkgZJRuTXnUNfuUU02ZE43H3xx1Y
         d5eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yb0/sevEMdafr2vXQ3qC01lm6vSKeakGcpjhBltDdpk=;
        b=JzHt+7YJ9dFrVjuBKgRAvRCkz43sF2tlmBlY9Qh1OOYdXi3BTt6aZODM+mwUS4V7j/
         eamU2C07t4t1dO8ztFz13l6Ck3/oVRA7ol+BDG5wPXj95lxaYLIWmBLgVPx5GqQ7Ry6c
         hxYk/lpA+869Hk72AAZLi8mB/1Re7gjs+CCNHiyHYYL48ySL7I5nqhWLm9YbH1RhYYvP
         /je/0Ct9XR0heNJqT/0Rm0MHewMKVCt8Gc9ss8pL8oFALjR6ykGN2gAZ8r2/6rX2JRoi
         LnVHSoYZ3VDzN07Qa03OTryxKGlAs5DyUejPfv9pWhzy20GlIGQPW0Bsrn5yroPCqjxn
         xbDg==
X-Gm-Message-State: APjAAAV+1dfzJwsEuIYE4vk6qUCGdXiHaTqz+aduiz51fEx1svr9xbtV
        4c1zlIYpscpn67lCiH57GMSNfw==
X-Google-Smtp-Source: APXvYqy95F8IXy3awZMsVz6XFn2JcaEs7ITo2Lhv35mkO5CbPjyv/eOkl5aUm+OphfRVf0h+M09noQ==
X-Received: by 2002:a37:4b56:: with SMTP id y83mr32892834qka.338.1560519702426;
        Fri, 14 Jun 2019 06:41:42 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::a658])
        by smtp.gmail.com with ESMTPSA id l88sm1602172qte.33.2019.06.14.06.41.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 06:41:41 -0700 (PDT)
Date:   Fri, 14 Jun 2019 09:41:40 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     dsterba@suse.com, clm@fb.com, josef@toxicpanda.com,
        axboe@kernel.dk, jack@suse.cz, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 2/8] blkcg, writeback: Implement wbc_blkcg_css()
Message-ID: <20190614134139.miko2ypm5znqho6f@MacBook-Pro-91.local>
References: <20190614003350.1178444-1-tj@kernel.org>
 <20190614003350.1178444-3-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614003350.1178444-3-tj@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 13, 2019 at 05:33:44PM -0700, Tejun Heo wrote:
> Add a helper to determine the target blkcg from wbc.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
