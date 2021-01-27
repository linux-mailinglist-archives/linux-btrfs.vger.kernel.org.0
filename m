Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78DAA305FB5
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 16:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235343AbhA0PFW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 10:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235341AbhA0PB2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 10:01:28 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D80C061793
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 06:58:14 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id n15so1922156qkh.8
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 06:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=51D0mFh5cEUFoHBTma2moWOOpyGpgJMYnt01r9UG3AY=;
        b=fDhQVtUcG0J8/5WfYqbmZFYqcf4Pw06oIjfivyJ+a5f5IZ5SbZyPdt7dfBNTRyxKP7
         8DuCzY0zrNkE/vYpXQVyX4uvyPs6aZ1rBs87CtJX8s7TTVISG/5TdNX223pZfXF7iITq
         DiiV3CjzVJ7T80KvED1ENgkEhcdKKwu9Etgc3XOZmUUq1Cz+z3FgfUabV3a9PzbDxi5a
         cXsBXz5o8dXY7psvRkZkzDCZBPt+ONoU4D+v63z9N6bJXkiFE8GNYQm+z8Uf8pHZeQMR
         1igaCmShwoEGvALb1kwenSpV7dIUA1VbtLT43jZja5uu3u83KOkSL1iXih24iDFHA1Fg
         ST2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=51D0mFh5cEUFoHBTma2moWOOpyGpgJMYnt01r9UG3AY=;
        b=qNcgYffpfFYy148bb740pn/YJfFV0x7VutgLrCABwWGL/XpSg+oXKoBjwueVfJzYBV
         7aOphe1Wb37yh3NUSi8L4jMUX9dyRTmqk6URhcYfIdyFpLWyLJIN53pdA8xjmwYVJhDp
         rlk+KBGNzgEzOeWhT9ETTGjmawuALkB+1Aor+XNGU6uKc2CkvyLu6I8uAcIES0yqj+92
         tzOVca//AUgVB+UMOqmEwlO38QTcwS+U1BYCrYz+yOQZAS5QIgn85vN49FwOjAXYvIrk
         hxiL8SFsdgCPdC3jzaY6h1VpA7NzrD6H29XoKduo2QA0ntp4LXnGjeCwH0WaidsodHyp
         Roog==
X-Gm-Message-State: AOAM533WjJ6fx+Zhaaas814HhbQZKrSah8+HeFA6GTrLkb1BNQl/t4iB
        EiYkUPMMnuwNfBagJFMXwy7Sp00dnu1fRKYc
X-Google-Smtp-Source: ABdhPJxnfRNJ3D3nyR/+n6fvzBKmcB/lPFG7KQkLJni/R3vuZQ5wmbeqAHBRAkbPHdaeyCpgf7Pzaw==
X-Received: by 2002:a05:620a:55d:: with SMTP id o29mr10738357qko.454.1611759493270;
        Wed, 27 Jan 2021 06:58:13 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 138sm1346583qkd.80.2021.01.27.06.58.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 06:58:12 -0800 (PST)
Subject: Re: [PATCH] btrfs: Simplify the calculation of variables
To:     Abaci Team <abaci-bugfix@linux.alibaba.com>, clm@fb.com
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1611735097-101599-1-git-send-email-abaci-bugfix@linux.alibaba.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <de8a96f9-e9e1-81ef-9c98-7894ba4dfb9a@toxicpanda.com>
Date:   Wed, 27 Jan 2021 09:58:11 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <1611735097-101599-1-git-send-email-abaci-bugfix@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/27/21 3:11 AM, Abaci Team wrote:
> Fix the following coccicheck warnings:
> 
> ./fs/btrfs/delayed-inode.c:1157:39-41: WARNING !A || A && B is
> equivalent to !A || B.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Suggested-by: Jiapeng Zhong <oswb@linux.alibaba.com>
> Signed-off-by: Abaci Team <abaci-bugfix@linux.alibaba.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
