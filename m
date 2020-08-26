Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A13F25314E
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Aug 2020 16:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgHZO3R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Aug 2020 10:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgHZO3Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Aug 2020 10:29:16 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90787C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Aug 2020 07:29:16 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id t20so1484783qtr.8
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Aug 2020 07:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=MLk3xp0P15oSmktUt7b7VORZE6gCk8tIxf6AXdwFm/s=;
        b=h/nWhT+Qz8DO4/hsXByBrpOBdpaDATkCOtSQFV2ew4YfhVh9LJj/zBmovOG49Z8GK/
         Jlq1vsX+oOQIhjST3f0+gw784exFyvY+cnQw5lUnQaaMbLOu5LjYNNsZfrnOwuD+TYyX
         sccg632sNOEz7EQaIX7ThcYSa4M1pLYPgHb8Lv9HrQxWZVynq/IqQhN7NfGZZ8JUoxXT
         2DT3SOqEpznvuUeBeBQSwq3uuz2u1aFZ4/R6UNuWiw0P+Yur8Kx5IhMi6AwdjyOHCigx
         ke5avC89l9YvXQM3+mpipDTJgNAUe+5CEwfI8vIg98khONfFR8e9kCzSa5QMTPyCDkvc
         kJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MLk3xp0P15oSmktUt7b7VORZE6gCk8tIxf6AXdwFm/s=;
        b=tSDAkNUb+Qf5AOXyFs5PrrrlR2jekORHhJvWcIAfRwPr6bww6y6KkOUXgBZhJOF2Ud
         yycdOnXZ4fV8jWFeJBY3RpPLK91bo9JJzTIUQMP+H9Ua8UDwNOnhjkrnmmUXFRMF4yRW
         c53Y0djh1/5JkFgoLlABjIcIyVNPdnhKYsoOc8y4R3rSfMpx+lS4jOjz9c7mU8lEGp6r
         4S+kBn0HwvZZ7RF0zRyx7ftklkvbUV48bc0phqa6M662olVK7ETyf+6h3UzTr/w6OLee
         QLbukHHZaJdhlx885xF/dZIQMCoAjunNpQrcDqL9edeWjfyZxeMawJMG8KX3YDN9GqqU
         PdHw==
X-Gm-Message-State: AOAM533wV8v2Z64FKYf8T9qFoZSWAKw4TSK6vMix21JJwx4cDw0HBzxy
        np77XTx4MXsR/dfWDytZOPweQ6GRNDftik8r
X-Google-Smtp-Source: ABdhPJxbIe4dZTi0i1HgA2lwnIGs5EiwGSIPyuv3aB0ZcxHUzgDwakVsVcAz+BIqpvZJS+3ulhikeQ==
X-Received: by 2002:aed:3461:: with SMTP id w88mr14297475qtd.180.1598452155507;
        Wed, 26 Aug 2020 07:29:15 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d9::10f3? ([2620:10d:c091:480::1:efc3])
        by smtp.gmail.com with ESMTPSA id d202sm1803040qkc.2.2020.08.26.07.29.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2020 07:29:14 -0700 (PDT)
Subject: Re: [PATCH 2/2] btrfs-progs: remove the unused variable in
 check_chunks_and_extents_lowmem()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200826004734.89905-1-wqu@suse.com>
 <20200826004734.89905-3-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <5496cb97-774f-c85b-7452-6b98c5c8e684@toxicpanda.com>
Date:   Wed, 26 Aug 2020 10:29:13 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200826004734.89905-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/25/20 8:47 PM, Qu Wenruo wrote:
> The variable @root is only set but not utilized, while we only utilize
> @root1.
> 
> Replace @root1 with @root, then remove the @root1.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
