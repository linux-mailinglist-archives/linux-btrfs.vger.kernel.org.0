Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3FB25C53D
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 17:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbgICPZm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Sep 2020 11:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728623AbgICPZi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Sep 2020 11:25:38 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1062AC061244
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Sep 2020 08:25:38 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id g72so3381137qke.8
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Sep 2020 08:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=R/vwlE9cotrE5bF1HG/3J+pmzzBO2FvouGDghb20Twg=;
        b=C3s14jKIewUb/T2LNA4mIaFff+1F0i51goIY66znsk9DHLF1XD+GDrI8bMnNlq87KA
         0jpExC4qh955TFejIunNn1EtXwRsD7063bJFvFhUkDsppGvoGgnH7WUyHcnf9MJMoUyy
         SGz0DO8LVkUAZvCqa92LCGzQPame2BgzZkuEz7FbKnrNw+CHPV3ULq9zL+7Vpi8F4s0F
         LHGOzCIOecOANc8I3XspoSTYscgSm/IhTMgYpkkAy9sjW7qFDmIGT4xsOzuZXWXKU7+W
         QnZOOh5FJg4jLQYM1d2t1JqiOA3VJzoX7OB5XRSvWLKzPQz1rSbef4uuOa4ZIpW9BgW/
         FI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R/vwlE9cotrE5bF1HG/3J+pmzzBO2FvouGDghb20Twg=;
        b=VTH075ZtN0/koJNyBlXPDClgU+nZf1ONYvh+llCd4nDjr5e2JUzHMG2Atuv4o6HyTu
         i+I0OtvIAhQUFpH6CPpnPbwNwYZFyBkWKwwfUwCznMsKefLZti4s2OzffeKNI91mSK5p
         GAQZ21v3UUTyu7O4MPexIBNFZV+MTNZX4p9q99YSHUjsAQa7IFeHzZ/metBukgsGtjyd
         lwBHUxm2f+mfQQ7yfsyMnB26IUC5xRnaxD0PM5Zo5ZhseRAXLlLtZE6oeZrHVNuX3X0H
         EUl1SWZn46yAn6u4OR/RIwSsL4ZcX13bKNvNWenpsyAp23JH44fqwRybXPMS3GNJ+6gQ
         8rvg==
X-Gm-Message-State: AOAM533RoQOqvIyrDN/sgz7Eh7bo5OVKLAdUHWWo4WvBPXMC79RXYS46
        OT/e7JvYOInGidT3YEFr+KoFGg==
X-Google-Smtp-Source: ABdhPJy/yqeBqsjf92CcgO9/A6oGH/gPfzk2dcKO80W15DN8x1IeCj13jUAI92znENUGX7F99NPFSQ==
X-Received: by 2002:a05:620a:211c:: with SMTP id l28mr3466200qkl.395.1599146737168;
        Thu, 03 Sep 2020 08:25:37 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o6sm2292347qki.16.2020.09.03.08.25.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 08:25:36 -0700 (PDT)
Subject: Re: [PATCH] btrfs/011: skip if on too small devices
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20200903121815.7797-1-johannes.thumshirn@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <a1c29b06-7ae4-717a-9429-bf4c08ea91f4@toxicpanda.com>
Date:   Thu, 3 Sep 2020 11:25:35 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200903121815.7797-1-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/3/20 8:18 AM, Johannes Thumshirn wrote:
> btrfs/011 does require a spare device of at least 10GB, skip if we don't
> have big enough devices, e.g. when testing on ramdisks.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
