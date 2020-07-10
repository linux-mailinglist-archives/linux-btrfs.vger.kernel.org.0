Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA44821BC9A
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jul 2020 19:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgGJRw3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jul 2020 13:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbgGJRw2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jul 2020 13:52:28 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F87C08C5DC
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jul 2020 10:52:28 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id c139so6077572qkg.12
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jul 2020 10:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z/EptbW5l5MlTK8iv4lqndCFmdDwMl00L4o7dddZcU0=;
        b=Ez/bv/5D+7tFESuhn9k7WjcLZnnwQyMLqHBllKwyW1T/oJwT33VKLBet1y6PzkPqTX
         +pvCDOzktxICTq/ajVhFg5U9GAXmyIhwlPN8ypMWqzfwFdxu5J1M4UpA2vMplZbf9aXa
         Nbqv3QsDjr4vvaFR4kSuRr1zH2VDG8+t1BoszfZ/g7TPmAFx4jz25YRzRb3dSPh/O1as
         69zbh0K9XzvSFERi8oCeuriZhTg7kBSQLcJu7fq6nk5ZukHCgm5m4lxiKNBj9BuMrm++
         h3nyPBcChYWVugnARelnAulwgbyKpw4MsLMo5489dkFMpasBpH2OROJU5GCn/FwnsD1v
         8MXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z/EptbW5l5MlTK8iv4lqndCFmdDwMl00L4o7dddZcU0=;
        b=RUb32RXP8Pznrr9N77mYg8Bgl+1qo6vMK6k5Dplv68C2bPE69/ivp5tSAZCv7RzFYq
         dIni11daHqgnJja9fJt+/yDBlDCfbpXKYbLA+/ZyAOlgRIFZxc7pGFhIB4P9kkILym5P
         D3Ld+PfYPg6pW0tw6qYLtX4EQlirrQe+/M89SvRJs2J/9ci49Fk8+kUJgKC1ZD1800HU
         MhPBU7jR1PANg+n1WHL4D0ssDglqfm+jHGCpAjP5xxHcTt5Bkzt8JG8dE0C8eGCgOiYz
         vKW6bJuCNUrciHTLDrZ7rHulBWKFfuQyFM8z4TkUC6iN/Ho9VUd3KoFJ/5wGWcyx4GXx
         nsGQ==
X-Gm-Message-State: AOAM531JTmUtKxNbZTeBSf3JeNPiE+upq/vMZCMMXLrVP/dO3w38gzzg
        osX4uj9aUKM+SWW3/Bjwj7IH2mWSq9GA4Q==
X-Google-Smtp-Source: ABdhPJy+fakZnr5H9Yi75eg6ca9yYWo4GVWxwEGvLucV1Llpwri1a+7ByKvnC6Vfo3UmuYN6zLCusg==
X-Received: by 2002:a05:620a:1235:: with SMTP id v21mr52811688qkj.454.1594403547564;
        Fri, 10 Jul 2020 10:52:27 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o50sm8802506qtc.64.2020.07.10.10.52.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 10:52:26 -0700 (PDT)
Subject: Re: [PATCH v2] generic: add a test for umount racing mount
To:     Boris Burkov <boris@bur.io>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <c8bfc2c7-4c13-72e4-3665-c2e2dec99dd4@toxicpanda.com>
 <20200710171836.127889-1-boris@bur.io>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <641e25ca-17bd-034a-9970-2396fe238c81@toxicpanda.com>
Date:   Fri, 10 Jul 2020 13:52:25 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200710171836.127889-1-boris@bur.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/10/20 1:18 PM, Boris Burkov wrote:
> Test if dirtying many inodes (which can delay umount) then
> unmounting and quickly mounting again causes the mount to fail.
> 
> A race, which breaks the test in btrfs, is fixed by the patch:
> "btrfs: fix mount failure caused by race with umount"
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
