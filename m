Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09294259D3B
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Sep 2020 19:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731599AbgIARbM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Sep 2020 13:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgIARbM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Sep 2020 13:31:12 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA850C061244
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Sep 2020 10:31:11 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id cy2so905136qvb.0
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Sep 2020 10:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Xyg1dw2lPo/HUvaqrhUgsUZBIgpufE69RkAECFvI/So=;
        b=h6WK/EOD3qPk5r7Wn5csInWaPl1gEcClRteOQkTAS0tKzC4wmJ46pZkSCVnX/kyU9y
         EJqlunMBwEGcvQfponAU5WYOpDFVVPQdls20hxFwAoLvQTvdjfnszcHMyvOWTarBH3EJ
         2MgEWNc+em1abegk83vk8EqnQAYKKDhMkegqMWXQED3rw0afmlMUU5yBydZPh72WX6z5
         J3P0PPLO7CHap0ffZZl7CW1k98A1QoXiemSV9KMEX58Tb7/Mc2joQiGFjVgpT/G+PG+I
         K1CACeyyEKP7XFcxMJizUaxmGOUAJt6z3Ij4n7aWDbU01cWgVHyUndfobNymDVTPkpKQ
         +2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xyg1dw2lPo/HUvaqrhUgsUZBIgpufE69RkAECFvI/So=;
        b=sS21eWCAZ14htu9d7Fj//E6lPHLQohfrxic6gjc6K7boyzJ1kxolRrYbzyC2SDMjU4
         QOh86olmiiD3ECVznYCBbl0ZCTYr5OPpNuxgbu55DpzGFkh+R1+vTPjXDHE6BK+TpzZi
         NPocTEfIzsyvNJ+F36Y4ck9bE5VQ4bJn8K9hz07PQ6LRNBOfrLwARxoJiaNPY5udWKDc
         nGhFeGdrVJoJC69nyIYwI9mjShVMPY22erNslDPevubTZvoQjNMaB6JGZrFg4ocqlrc7
         MPFuaCoo6CfDh+NUnDkEa+8wrEFb09QRsr7qJ3C1PrPGoh1XZ7pqtq1oAS6j0oCWZGBC
         hqsw==
X-Gm-Message-State: AOAM533I7DKmJW/o/QN1hR9ynM1Z4fiysO36xdH1T+GObBwa8JMNTtlJ
        N8qPnG5zD7uwcs8Mv51M0A3kaQ==
X-Google-Smtp-Source: ABdhPJxlYdE2YZaAzBCHqo0T3TadMYHoWQKiU6izQB8TS8UFtInNsENgXD5osdsynXgpVjdxrNEpjQ==
X-Received: by 2002:a0c:fa07:: with SMTP id q7mr2480381qvn.41.1598981471083;
        Tue, 01 Sep 2020 10:31:11 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o31sm2132548qte.65.2020.09.01.10.31.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 10:31:10 -0700 (PDT)
Subject: Re: [PATCH 2/2] btrfs: do not create raid sysfs entries under
 chunk_mutex
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1598961912.git.josef@toxicpanda.com>
 <4bf816d4109f4fa812074124a7672db1c5cb851c.1598961912.git.josef@toxicpanda.com>
 <20200901153518.GH28318@twin.jikos.cz>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <83d5a822-de69-7632-a18c-12a6f27990b6@toxicpanda.com>
Date:   Tue, 1 Sep 2020 13:31:09 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200901153518.GH28318@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/1/20 11:35 AM, David Sterba wrote:
> On Tue, Sep 01, 2020 at 08:09:02AM -0400, Josef Bacik wrote:
>> While running xfstests I got the following lockdep splat
> 
> Do you know which test was that? The stacktraces don't match any of the
> currently open issues.
> 

Oops sorry, I hit it with btrfs/177.  Thanks,

Josef
