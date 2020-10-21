Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DE0294EE5
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 16:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443093AbgJUOj4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 10:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442068AbgJUOj4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 10:39:56 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001E2C0613CF
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 07:39:55 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id r7so2704652qkf.3
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 07:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2rWqkhk+c3UyK7GwTf/KmgigGCv4GzRVnWXF7VunzzI=;
        b=htf7OEFTSgZS8qZH4/lqOP7wYbnMeRxW0296NEH2aLgnD6Zdds9m0BoU2dfXOxtpL5
         E97FiR2NL0IyBn+l7044/PgjlFkDK2GWHKRBOcFjRzSZq++Ew/006Jc/Ob+p7Yu1aQSL
         f6hXE+tPYn1DaidTot/eLO+cY+WWmeMOGD0TX508OF4TvK+YAopFtb4DY7JH3DbA9qV9
         r9BLirvmXKkARmJRVtfzu8mGP9T1011NO00ro9qioR/FopFtKynSFErk/p0Y+P14vV/P
         ansH4bCut+RNwL6qFjDfEX21RyYYUyIv+quL5npURohfftzBEur/KSD1RI7AZ2a2AUfq
         vgIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2rWqkhk+c3UyK7GwTf/KmgigGCv4GzRVnWXF7VunzzI=;
        b=ShfdUpTSB868DdADH5aDelxYPfhEv4LaSXAq+Piv+iPRMgy+RG19jdpvPvpo5DGdPd
         ZUi754BtasL3GH08ypFcGedGwdIJaukNzXYJHvAR4bEgJ7F5WeDIYUIC91FlKv00ha4U
         dpHfOW43FOTDaVgzrIs8zL/GqzrbFnPADnKA0ik3+3ejtilERmAe5hvFa+R0COKVhvk1
         271kBFdc8Z76M9ejaSUBuKyJXYnu4V9KPRn0KOrOf3fEOEOraKNvrZDf56a1ycToAbsa
         HBfLeUZzuRJzdVnePoptuBv4/VF+HfcUT9vpUM2wPjgQAS+GG2V+Hci1SGzvH0IFApBc
         dKMg==
X-Gm-Message-State: AOAM532pvfp+LAn5IbkwO/PPnIDxSuXdH2eh2JSt28vJ9FBfn6sJiguJ
        LafGsdiTgzM3fcYXNR4VqxzmoQ==
X-Google-Smtp-Source: ABdhPJwRB94vPJqLu7AubslW9q7QVb1NOL8SsvlO8nhP/9ej3PdP6g7ApupDkYpb7zoaBEZXXwi/Bg==
X-Received: by 2002:a05:620a:130a:: with SMTP id o10mr3354204qkj.63.1603291195189;
        Wed, 21 Oct 2020 07:39:55 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i20sm1308676qkl.65.2020.10.21.07.39.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2020 07:39:54 -0700 (PDT)
Subject: Re: [PATCH] check: fix misspelled variable name for sections
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <9609363e0dfbe7098ded407898b8b78c651dae0f.1603204642.git.fdmanana@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <9976beec-0796-4dd1-4aef-8cba7d9286a5@toxicpanda.com>
Date:   Wed, 21 Oct 2020 10:39:53 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <9609363e0dfbe7098ded407898b8b78c651dae0f.1603204642.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/20/20 10:42 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We have some places that refer to the variable OPTIONS_HAVE_SECTIONS
> has OPTIONS_HAVE_SECIONS, obviously a typo. So fix them.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
