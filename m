Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213F045936D
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Nov 2021 17:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240442AbhKVQxi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Nov 2021 11:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238381AbhKVQxi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Nov 2021 11:53:38 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75674C061574
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Nov 2021 08:50:31 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id 8so17160179qtx.5
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Nov 2021 08:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zipCcKFyQkNn6B342wqJn/P6MHmgjYMhxXqponEo6pc=;
        b=U5fd3Ws9u4BQlxQYwXY0LIYvKpPO4+pc64JqxKF6SWlRbf5bB1w46IbuvpnQvcTsfk
         0cJZAxZwsMAy/HKarnTOoloH8kPr6mnifaFJUe8uIWpu53C8Fwve6kq0YHX+RErEYYZO
         Bd0CdDBRb1R1Rd96WU1kR7tdd07TcxoZ8HGm+xEc75Po89q3ho4whaouhp/bJL9kTQW4
         jq2ysRkbwAco5ZUXvhhHhq+8sibYeROXudW8oU6sWSEGaHAOFjAJSIONekmLxa/aaoBa
         dYQc+G9OGApnA7ezzdcOfe/bx6aYIr2kqTQRXmXDokzjmKr14kCXYfrZFLsRA0RpWO2Z
         R6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zipCcKFyQkNn6B342wqJn/P6MHmgjYMhxXqponEo6pc=;
        b=OcCzLMZ1Sqz1C4Jllr8f6rwiJqBYubmxxPnK5Vj45+ttr965nUnw5CCxWbiGHv1YgL
         5epmS5kAW+uvT2BSrTVVEas/JuhwjkHJ+GUDrE73uejB62CPPP6TaMaky5tz/x5HpHt+
         lvcuzVowXt8q68XXqboIMsbkx9zqW2n6CaKyML2+x8Ggp31IMYUsVGeNh8Aq3dl2Fp5K
         DTM9tEuiFDVUgIqHzP06BA+m/S+qGFZeL3IUAu5vROIiNDSs+nx4S7iBLO9dWuPhgGL6
         bPwHv+PoeeTQj+cJqv0Fizib8bg4u91iOGUPFhAw4YU4GqXJ/BWrfopaIGX6XUKiAD/d
         i88g==
X-Gm-Message-State: AOAM531SnqJq1VI9FFTFWhiLZUsf6J3+BvZKfkUV4/b5kTlzaqWxJQmL
        /pCuKaZma/kGFIs0f+ST6w/sXg==
X-Google-Smtp-Source: ABdhPJx5J3yF09JHlIdmMH1o/CtiRQVrLCQtDeFyQ0UOPCNKSnwnpYfupRTLuOj3f24lxQ975CmQdg==
X-Received: by 2002:ac8:588a:: with SMTP id t10mr33478755qta.151.1637599830550;
        Mon, 22 Nov 2021 08:50:30 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l15sm4752380qtx.77.2021.11.22.08.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 08:50:29 -0800 (PST)
Date:   Mon, 22 Nov 2021 11:50:29 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: eliminate if in main loop in tree_search_offset
Message-ID: <YZvKVVVvkfGRD+PI@localhost.localdomain>
References: <20211122151713.14316-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122151713.14316-1-nborisov@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 22, 2021 at 05:17:13PM +0200, Nikolay Borisov wrote:
> Reshuffle the code inside the first loop of tree_search_offset so that
> one if() is eliminated and the becomes more linear.

Need a SOB and you need to set entry = NULL initially if you're going to make
this change.  Thanks,

Josef
