Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DECA645E91
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jun 2019 15:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbfFNNlZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Jun 2019 09:41:25 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34100 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728334AbfFNNlV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Jun 2019 09:41:21 -0400
Received: by mail-qt1-f194.google.com with SMTP id m29so2496293qtu.1
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jun 2019 06:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZR/EKmu5gWkoNUBhKpXkUDUjfp2N+yxxCefDqkXhc2k=;
        b=gY8OMr7BO35CDdoLUsDArY+W5z7EkRkN8AGq0dhi/gK6t+98bkfUbhJeUYUMBxtq+E
         g/Xqmry39VK37V6HcDuOlZVZdFScnNlI5fO22ZjQAxXKe8UxoQaTYQdYHu9NWssVJh09
         oQKm2CnNGBnYzpdV/hzWHXwBLN0fD60gYqJER5Y1wmA5i+s/1pZ1w5+Vsa+6X/IEpVo4
         4DwFbeGOWDMdnnUzU79UmAhVu8HCPM3pSWNcoxEciJpp2cxbWwhpvdVvy9nHYaBDyDXg
         ApDcHnYRFm/c0Vnxbt/lDNoUai9VByA89l35kZjTMomAM3HeFl5Cckoxu3XJbeh6ZuDO
         dfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZR/EKmu5gWkoNUBhKpXkUDUjfp2N+yxxCefDqkXhc2k=;
        b=iY4YhVxCLs+zPig3hHk8CJyfL0HPnDeao70fQUtv3JUakuqRvBUmOkMIb7lWVGGwIU
         F6ag0h5SfVbb5uZLVKO9vMxkhjMz19IZ2c8TIN+cUEP9z3M/2b8ZzcYW/zbMP/6Qeo+O
         KLA1SGbsBZNPV6TySKTb5ih2cvGJlMqYE11n0i9VVfpBE2JgnlkFAEAqKBZVC7akAODW
         hJvMz6gQP7ONrML2QH7U9DS+6ms8MWcMWm66EwgxlvWvBBcYy4R04siJHEwUC2VWQI6V
         Vj7Zxw27p4WtoSGw+MDfkKYEx0LNNI11WfhoueqFDROQckxuu+n40s7IVMkS8OJNBtWq
         JDcQ==
X-Gm-Message-State: APjAAAXnK/3hf/ZnRP5t+s4LB1cgQwo4kVbEt0J+RlW60nWF4XkXF1Z9
        Y/3OfaFCa2KzNcjoJ0QmphBCxw==
X-Google-Smtp-Source: APXvYqws96+Oa1Yx5sGxA4g4gfNEVNQGDUhXxTBNVV5tp7vpSzt17KeuRr00AjHyuAVlm/HgeGIJRQ==
X-Received: by 2002:ac8:2d19:: with SMTP id n25mr42440329qta.180.1560519680205;
        Fri, 14 Jun 2019 06:41:20 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::a658])
        by smtp.gmail.com with ESMTPSA id p37sm1685047qtc.35.2019.06.14.06.41.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 06:41:19 -0700 (PDT)
Date:   Fri, 14 Jun 2019 09:41:18 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     dsterba@suse.com, clm@fb.com, josef@toxicpanda.com,
        axboe@kernel.dk, jack@suse.cz, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 1/8] blkcg, writeback: Add wbc->no_wbc_acct
Message-ID: <20190614134117.pngediuiim7ktcvi@MacBook-Pro-91.local>
References: <20190614003350.1178444-1-tj@kernel.org>
 <20190614003350.1178444-2-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614003350.1178444-2-tj@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 13, 2019 at 05:33:43PM -0700, Tejun Heo wrote:
> When writeback IOs are bounced through async layers, the IOs should
> only be accounted against the wbc from the original bdi writeback to
> avoid confusing cgroup inode ownership arbitration.  Add
> wbc->no_wbc_acct to allow disabling wbc accounting.  This will be used
> make btfs compression work well with cgroup IO control.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
