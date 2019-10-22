Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36670E0419
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2019 14:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388050AbfJVMps (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Oct 2019 08:45:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:47025 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387479AbfJVMpr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Oct 2019 08:45:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id n15so7120072wrw.13
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Oct 2019 05:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D1a9DLCsVMs2zT8hE+/E3VTGl136dufrxxgUYKAC5Kw=;
        b=ZKo13Wp5xQoWI3vZ4czQa3FOrYUWng9D8yo8wqRWcRK3A00Ayv19+bWU5vzPYaHCN4
         bR+ZHAIaaSrhH3ETIGCrnYsF7fiZeTgQQD3y4+RGTtnXOBNEgfOuJ7YPacMZLadxlU1/
         Wup02mIGIGfxUYRzzNbeBbj9yTUOsnuf+HfKWdYROg+LVqbAQOcRzzH1FNkQ6a2kp8Y1
         vNYr/giK7V2W3nfKF1yHvzG4PkVmbmHS1zeglX0j5/F8vhrfaBV5mVr6/mKtcL/G3ELX
         H2uNvKnGWqqZ+l7Fv+KY7BNB3buqlFls18xwn3LUCufyw+p/XdN67w3W+Z8nTfpCv2hv
         mH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D1a9DLCsVMs2zT8hE+/E3VTGl136dufrxxgUYKAC5Kw=;
        b=Rk5JH6KRlt2x47RsH4XV+18US9NQy94EU78dAaqvHH3cnA9wsgEGMYJ2Od8Ln6nxKC
         nVib8P7vVG4ImqARnmHEzaU4WA71dkcPvs9X8fdDyT/dAdIs2Kpi/i3I2zako2O9pHFk
         ZHyFJn2232/q3rBQ6IusnpJKl0Ncq6/wO09d+WiDueaWJAZHlK74dPEHQTsMvmcoqPVJ
         qQ2skB+N2h4aCpUsE6IJjzmvkZM0iNr1pml+Y4Aszmv50qiKMJHUMRKWKLba06sv4QGg
         wNcI/dfQMs3JiSFYmABUPMXn+lIgu9nAXberphgLd6DzGZQUc7cAKA3obKMl5rcbcAd7
         pplA==
X-Gm-Message-State: APjAAAWHnJ/Ms34vt7d9CVGEHqwXoI13nL0oDh6ByasHZEcyJdgb4d2O
        ybsBQ8uGWQdhhd/uilEREjQ=
X-Google-Smtp-Source: APXvYqxjhgvb1+ix3Nba0JT5zDMh0nT+elIqxzAqC/cpZIldA9qLdyJbcp+ykF+EmVZMLAzM4kdzlw==
X-Received: by 2002:adf:f004:: with SMTP id j4mr3625953wro.68.1571748345528;
        Tue, 22 Oct 2019 05:45:45 -0700 (PDT)
Received: from [10.20.1.223] (ivokamhome.ddns.nbis.net. [87.120.136.31])
        by smtp.gmail.com with ESMTPSA id u10sm7807541wmj.0.2019.10.22.05.45.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 05:45:44 -0700 (PDT)
Subject: Re: [PATCH 0/2] btrfs-progs: Setting implicit-fallthrough by default
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        dsterba@suse.com, linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
References: <20191022020228.14117-1-marcos.souza.org@gmail.com>
From:   Nikolay Borisov <n.borisov.lkml@gmail.com>
Message-ID: <028a15c3-2395-34c5-f761-5782e851d933@gmail.com>
Date:   Tue, 22 Oct 2019 15:45:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191022020228.14117-1-marcos.souza.org@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 22.10.19 г. 5:02 ч., Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> While compiling btrfs-progs using clang I found an issue using
> __attribute__(fallthrough), which does not seems to work in clang.
> 
> To solve this issue, the code was changed to use /* fallthrough */, which is the
> same notation adopted by linux kernel.
> 
> Once these places were changed, -Wimplicit-fallthrough was set in Makefile, to
> avoid further implicit-fallthrough cases being added in the future.
> 
> Marcos Paulo de Souza (2):
>   btrfs-progs: utils: Replace __attribute__(fallthrough)
>   btrfs-progs: Makefile: Add -Wimplicit-fallthrough
> 
>  Makefile       |  1 +
>  common/utils.c | 12 ++++++------
>  2 files changed, 7 insertions(+), 6 deletions(-)
> 

Overall the patch looks good, it just changes the fallthrough to the
least common denominator which seems to be a simple comment. In clang 10
the currently used attribute method is also going to be supported.

But we'll get most value if we just enable it now, so

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
