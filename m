Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4049F29F449
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 19:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbgJ2Svq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 14:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgJ2Svq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 14:51:46 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AB6C0613D3
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Oct 2020 11:51:45 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id s7so4640451iol.12
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Oct 2020 11:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=3w3stXyJYyMxFGKwNysh02VpI/KRnkHbgogblrlcZ8w=;
        b=R4nyTjPoFCi7xRlL6imRpACOsIcwC94ywkmhXblcO2UaLbBM5nquFh+IH7Vaei8qoq
         Hd95S84SE0UGrChSN79ejn8jU/rPFQd2QGvzCIDkhC2/GwVQ9pM8WQ1fooF/vZewBzBD
         AxkXKsc+vFN5AQ/kU8e3bdH2C/GtTGFwjLASRix78ywrgAww0NX8yDPgwRFsZc+h5t5F
         8AqrXYmmljUPVwBf7lNStEK+cRq+4cTbRMPVwUX1SYCj9i5ESoIIvv21ZVWSXcUVkk28
         ic9cYOK/Z578uciLe4kWaSp3z77NbAMM5hTLmWnaoma9+MjKiKDlLo4GPBHzw6z0hD7B
         rOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3w3stXyJYyMxFGKwNysh02VpI/KRnkHbgogblrlcZ8w=;
        b=GScYStw5MAYBYlPb2uNWp0nxjW2o9qvoRds4ifYQv6o4iFdWoPFB4DW3Pd/VKNVVuW
         hofYU884pYq45eIXKuxDkBboxUo60nJ3DNx4I4ugftJQFJgWGipEBI2yX8ZM4JMM9NBJ
         IyICu8sDjQAj5a3mqnsKlWv2ck4zq1ucxQQMlCNXW6JnzfLtwdWIYN1UnvNA+aCIlG7m
         zbOtiR+PnTghTKO4IUHpR/gauyWm1m1YuDKQOrY2lAYuowQmdjLnsP+5BHmYsPbzMPL9
         Vo7y1p5qYC2g1yFUzECFQwuMwBlCG0dfiuM2C7QhuciEEUxIPd1xnzJsBOm/PPHUX8fX
         R2hA==
X-Gm-Message-State: AOAM531YTio5Zm4u42Glwshrzi+QYgfF1W6f1FbX07VWNJWNBP0RTbZa
        wcfsKvpcoK52vTZqrY/7PWb/eP/xv8PHoA==
X-Google-Smtp-Source: ABdhPJykKUwpzZFCW2gEvbMX/REWuQSJLNl5yBrcTVq8s+ekFa/MDajRwd1tFuw4cwgt5evzgU/9iw==
X-Received: by 2002:a5e:9604:: with SMTP id a4mr4665243ioq.61.1603997504891;
        Thu, 29 Oct 2020 11:51:44 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11c1::1376? ([2620:10d:c091:480::1:18c8])
        by smtp.gmail.com with ESMTPSA id f77sm3261779ilf.40.2020.10.29.11.51.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 11:51:44 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] btrfs: file-item: remove the
 btrfs_find_ordered_sum() call in btrfs_lookup_bio_sums()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20201029071218.49860-1-wqu@suse.com>
 <20201029071218.49860-3-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <848d3c6d-9d2b-afd6-7608-2708205076ea@toxicpanda.com>
Date:   Thu, 29 Oct 2020 14:51:42 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201029071218.49860-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/29/20 3:12 AM, Qu Wenruo wrote:
> The function btrfs_lookup_bio_sums() is only called for read bios.
> While btrfs_find_ordered_sum() is to search ordered extent sums, which
> is only for write path.
> 
> This means the call for btrfs_find_ordered_sum() in fact makes no sense.
> 
> So this patch will remove the btrfs_find_ordered_sum() call in
> btrfs_lookup_bio_sums().
> And since btrfs_lookup_bio_sums() is the only caller for
> btrfs_find_ordered_sum(), also remove the implementation.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

This one doesn't apply cleanly to misc-next.  Thanks,

Josef
