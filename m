Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65E6E305F9F
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 16:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343734AbhA0PaL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 10:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235819AbhA0P2e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 10:28:34 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECC9C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 07:27:54 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id a19so2058840qka.2
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 07:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=0ZpBRCpSuj38MeGzz9LmyKtGDI/+fWwe1ekjmKRbBkE=;
        b=AZXxvihi1yqR3ervVnLNoWzintmp5wmxnNzOy+eCHW/3ZGfxFCnKm7g7bYVTt6M6TF
         +VH8PpsFXywuIskzddpKEyCMh9uXeVxaFgw8CFkFkDVQdDfTx+LqrKuVyEbRjp0X6+XV
         KwKoMtHODltjf1BLSkiSlH2/Mw6Fk9qktDmCHvyLGoIBubPOklr82hy5PUxBxJGC3LvU
         Ycr/IGfBLSeOf/t06XFFBo7vc9EtRAOCignqEFm2EIN2KAiYcOAljS2lXVfe1gYP/Gsn
         vgphMAqKX6PS5IsfIkDVMJdM0Szj3EMG+Bt8ocm5nkH21udXYwjvkxpyTu19bDeo4xto
         jo3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0ZpBRCpSuj38MeGzz9LmyKtGDI/+fWwe1ekjmKRbBkE=;
        b=pCyJH5Ye3jCipa+B1x5NwodUyf2kxHGEVLSPTdJyB0o/KJ/ZY5geoTfQj0krjTki7f
         lLVnj4Os3LpLXDFIBI5bxZiK+Vzfu/i+0bstmYTL+3bQVjAk2nxBVNaFrJy80oi/Bfoi
         qU54i2RnabEBVXKrAXHBAQ4UnzkXSwBZZSMPKQRxC40CSU2tMfQyxnkB3g80515Uces5
         mQs7heyGNqYladKX8ROzFaB+z2q/UaDovYH4RiQorDemXJfpH+zAsgz+7aMrI2M8SG1B
         F/W3O3pQBarKTtfUZAO+5ZmlTihVeG1Jb6tUdxGYGidocJdb1EXNNZSmkqqRoXUraCxo
         RRSg==
X-Gm-Message-State: AOAM530149eHbdBAAE06xtv+KN3/cjGHqmIP54qJ+TTZlr7gT8bSJ40h
        B2yQZEBisjUNGv4H2UpMrDZPmwziJKOXKxPI
X-Google-Smtp-Source: ABdhPJxk99sq8fJK+tsHiLAAIigwNZeL90K1fzgLp/gV3bWMQWhBoy2H9co4myD9lhAD0PsD0HSY+Q==
X-Received: by 2002:a37:9bcb:: with SMTP id d194mr11297171qke.217.1611761273032;
        Wed, 27 Jan 2021 07:27:53 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 5sm1368892qkk.109.2021.01.27.07.27.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 07:27:52 -0800 (PST)
Subject: Re: [PATCH] btrfs: remove wrong comment for can_nocow_extent()
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <9017cffd318c09a5e6248ca904903938c691b450.1611759896.git.fdmanana@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <b9309401-8422-f60c-a591-9fee709b2b60@toxicpanda.com>
Date:   Wed, 27 Jan 2021 10:27:51 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <9017cffd318c09a5e6248ca904903938c691b450.1611759896.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/27/21 10:05 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The comment for can_nocow_extent() says that the function will flush
> ordered extents, however that never happens and was never true before the
> comment was added in commit e4ecaf90bc13 ("btrfs: add comments for
> btrfs_check_can_nocow() and can_nocow_extent()"). This is true only for
> the function btrfs_check_can_nocow(), which after that commit was renamed
> to check_can_nocow(). So just remove that part of the comment.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
