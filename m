Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A69D21274D
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 17:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729867AbgGBPG2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 11:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729571AbgGBPG2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jul 2020 11:06:28 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11F6C08C5DD
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jul 2020 08:06:27 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id el4so8711622qvb.13
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jul 2020 08:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0/oQeFGb9q7IFEOtuZsdtgXTlAdH2UK8SamdeT5Jr3c=;
        b=Rj1K/FlLFv/aZVTsBFLMCeUGuFFlRbEOoFl1VEcYcEZ5GiHLynUkSO3xMfedzKVwoI
         Eo/VS0x94krv6pQc9letmxEKVnty9BrQhtdlsIGS43SOhVPbHGIK2BxsQD8Dpk9GnHVN
         nUwKfrnFcasI6JHq0qKChTGLxx3xmpUuAuzdXnggG1UIjYFBbeVeZb3N2kZLKuwFQl55
         pe6NaGbp8GEgma/ezCqcXh+DMb88h6+VpRn6g8z25s/e55T1kwa7T6MM174Adz+GTGyJ
         ukrFmjV4GzxUjT/wV4yW3C7b8Cxx3IIx5rpj2BO0VKnQ5A1tOhWydbw2cnlhVwiJpHJP
         FTKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0/oQeFGb9q7IFEOtuZsdtgXTlAdH2UK8SamdeT5Jr3c=;
        b=TmpI14516lstui5CPcJuo9EIcaChJuIrxdOJmCqFgRiwVyIEvk08lNMKW64LXKjPpM
         l1uG+7dirxq9FvJzvgFFMNh99grSQWouBl2r6lSSVRMbnmziCcY0IjsmcDTELvDacH9g
         Ax91wTCMdIuS7CLFrr1KJe5PN7zmUGqH8BihNu/3X+aacvT4ye/iCI5PtLq3aoTqJHHk
         dobzEa7FjZxN2tzHAkqkRzyaL8Gh4mKL//KDjwiQglagaahbGfMtZfagwgi6OifzAEIA
         qlKBlls09O3e2QxV0uAJJIUQrQOg4/2ET7es0kgkmTPmBIObtSQcNcgy76qKNnIykU81
         CU3A==
X-Gm-Message-State: AOAM531SLdCtx54jMtC8ROiAcRdL//UlY/7XZlHHJqVPEpmePDDuX7Xm
        +2HhQcGDTCSaj2LeoCVjpZfiChICQEcUjg==
X-Google-Smtp-Source: ABdhPJwBqtyAjoGSEC0aPY6SuFttxTE0NcLPRU+D7OEZWUEe9M1MV3sK2qHPLRzVY2yGskzWJkq8uQ==
X-Received: by 2002:a05:6214:5a3:: with SMTP id by3mr30462590qvb.201.1593702386588;
        Thu, 02 Jul 2020 08:06:26 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a28sm8006482qko.45.2020.07.02.08.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 08:06:25 -0700 (PDT)
Subject: Re: [PATCH] btrfs: test that corruption counter is incremented
 correctly
To:     Nikolay Borisov <nborisov@suse.com>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <20200702143823.20333-1-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <1f11c9ee-52e4-2f39-677a-6d766371a717@toxicpanda.com>
Date:   Thu, 2 Jul 2020 11:06:24 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200702143823.20333-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/2/20 10:38 AM, Nikolay Borisov wrote:
> This patch ensures device corrupted counter is being modified when we try to
> read broken data.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
