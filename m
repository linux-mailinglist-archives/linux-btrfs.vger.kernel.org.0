Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3EB259F16
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Sep 2020 21:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731229AbgIATTD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Sep 2020 15:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728406AbgIATTC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Sep 2020 15:19:02 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB3FC061244
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Sep 2020 12:19:02 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id x12so1809079qtp.1
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Sep 2020 12:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=hRIadBzZNV5KzZUsuzBCseeTxnXW7Fiq7f561RH6Bzs=;
        b=LZMAju+wRKoiOwJfl9tmzWsslEiQURia7xYT/FC/WHMA+KlHKwKF9WuOCJawZ7HTUK
         OMKWWTwtWFo6OfWBtBjsJ6U4xl/qiBGzn33tb0P9siuvYTlbF0iFmoPg8YJji+OpjJBm
         WILutaINCafVc8nUaYX6vP1XCk1jY46rted0StM5cu35gK8UbklAzF3FncxQdeCjkDEW
         5YoR51ZQ/u59MHKkeZkX03UsjV8JjA+IvcQ7v3NZYtjgVWnPuSFN1u2B1JUhctr4zXux
         464G5mHNR0x+UXFAhbu024eJz3ks+91rGBb0z+wOvKvKh8CG+13MBSgjSrjwGfXxopwn
         HMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hRIadBzZNV5KzZUsuzBCseeTxnXW7Fiq7f561RH6Bzs=;
        b=H+chmX1Oe8aMnlQU16vFtBHSXyT+95kNDDdOCXBMRu5R19EmqbKK2e5oXwvSVTQlpa
         Ik5Ol7dH5yVV+UxZzambXTJxgmNxzKN+IqTb2qXF6ot4PlYYUoKwzkzZZTov7d/XD/1g
         rqo9RCFWcsOwQ79YfhSyYL/fghScAtzys9F2vG6wDpKELSnG2A9r6yWgVufM3Shzex5M
         Y9l6KLLS5Kjtgk5VOhAbux5TodYXdwee5opn429m4gIVR5FqrqS3kDaiB7XhC8geC99m
         V0S58sK0dRb/VYaVEWjsY/Rnk1SerIsBxY40iCw+v6wlEH+GxpXl68WIJvhYhW9VYnrX
         Zd/A==
X-Gm-Message-State: AOAM530zDBPt7Cd+y7Vb7D8PxAj9shITm1Trd2sc2rAEHMTuVKEyHx5b
        vcL30OszvVXAcBOW+U/UGqdIfEKemHyhG7mv
X-Google-Smtp-Source: ABdhPJxxUGQPckuDisjMNTtk3R8rKh63c7NdKseSUzQXB+tYzXOICP+5AAKUfmcxm0RWq7rQAIHhkA==
X-Received: by 2002:ac8:48ca:: with SMTP id l10mr3030648qtr.385.1598987940945;
        Tue, 01 Sep 2020 12:19:00 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q26sm2826183qtq.91.2020.09.01.12.18.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 12:19:00 -0700 (PDT)
Subject: Re: [PATCH 2/5] btrfs: Eliminate total_size parameter from
 setup_items_for_insert
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200901144001.4265-1-nborisov@suse.com>
 <20200901144001.4265-3-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <f2143afd-c34f-06fa-214c-2f8a010557fe@toxicpanda.com>
Date:   Tue, 1 Sep 2020 15:18:58 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200901144001.4265-3-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/1/20 10:39 AM, Nikolay Borisov wrote:
> The value of this argument can be derived from the total_data as it's
> simply the value of the data size + size of btrfs_items being touched.
> Move the parameter calculation inside the function. This results in a
> simpler interface and also a minor size reduction:
> 
> ./scripts/bloat-o-meter ctree.original fs/btrfs/ctree.o
> add/remove: 0/0 grow/shrink: 0/3 up/down: 0/-34 (-34)
> Function                                     old     new   delta
> btrfs_duplicate_item                         260     259      -1
> setup_items_for_insert                      1200    1190     -10
> btrfs_insert_empty_items                     177     154     -23
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Some of these things, like btrfs_batch_insert_items, we could probably clean up 
and remove total_size later.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
