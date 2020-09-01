Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA0A259F2C
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Sep 2020 21:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732565AbgIATWo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Sep 2020 15:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731801AbgIATVu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Sep 2020 15:21:50 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7964CC061244
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Sep 2020 12:21:50 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id v69so2081431qkb.7
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Sep 2020 12:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=MntMsVPzmZM0EEenhj/7RUjTr3FTGv5QKUA3oK8MPXc=;
        b=M80TQRYym6Rj30v5dNPyGzIhQ1BXZlIYgRgQhcwdOrPQGWEuf6mlCvS7VTuRsCWJLd
         iqWnrsZZti/KDE0xjrHiu+LfWewEqfJhpvlY7HJIIy3c0qF6FJgKlyNN4+oFB6hyN/KH
         GQDHpJYES5ZDi7V7FLABjIWC77eja9oZTqzWTc7pvpvkIPmQO1w+wRQmL8RdOL2Lsv9f
         K2xeSiq/i21+hkiS0ZTNRErAKtxPgK+S6n6EfU/LwOlBHE19BmmoYoaxp3f7AAkQJI1a
         lKi+0clTkOejTY9UQPwcNl+zdB6YnRPIFBgG8uAohhRJxTBtbLn0YjMAC5loCbsqgCAO
         3G2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MntMsVPzmZM0EEenhj/7RUjTr3FTGv5QKUA3oK8MPXc=;
        b=LGJPRwZH8jfawMU5QjpU7DoPD4QmjPTtc8rfU61Us7Ezkr7eD0knh7azeWOVYpapcn
         CziXzetpqN8oXPocH5YihCpVm5cl0slc6g9svym2AYmp54e108ErEPUhCYd9TJ3HzJ4E
         N7hFEMf46ttnLhtuyKplh+en+zxCLOHegIUOZJFw1nuvpQ7ozL4tC7EEQAcpTDFNCHvP
         CShzx/HhxnEJjYciIrXXq+kqW5LHdvljbNgwmqIi1X+E4SH0ifkySc9DI7RefHCfVvkL
         z47qMRH1U05Hisa0KiFDebU6o/SfodvqqJCkGoLz+1N+1VwQRFKmFtcJxJNfP9ah/nDk
         3OSQ==
X-Gm-Message-State: AOAM530/4E8XGToRQFEVAeeRXVtZ8ot4caSsga537z/klEtY4hL0wuQP
        Ew7cUeUz07ttsYC2HAEQ02w+OFe5305hZ35R
X-Google-Smtp-Source: ABdhPJxkw+8VvLu88JeJJTf4tWswk1bKoAdmOvZVv58zqscnS+FDPr2cqTwwd6GQsTN+c1Qe5dmEAA==
X-Received: by 2002:a37:7f47:: with SMTP id a68mr3349663qkd.163.1598988109341;
        Tue, 01 Sep 2020 12:21:49 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x28sm2416519qki.55.2020.09.01.12.21.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 12:21:48 -0700 (PDT)
Subject: Re: [PATCH 3/5] btrfs: Sink total_data parameter in
 setup_items_for_insert
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200901144001.4265-1-nborisov@suse.com>
 <20200901144001.4265-4-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <3cbc9507-0abf-0702-b349-f5279b5b2f44@toxicpanda.com>
Date:   Tue, 1 Sep 2020 15:21:47 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200901144001.4265-4-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/1/20 10:39 AM, Nikolay Borisov wrote:
> That parameter can easily be derived based on the "data_size" and "nr"
> parameters exploit this fact to simply the function's signature. No
> functional changes.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
