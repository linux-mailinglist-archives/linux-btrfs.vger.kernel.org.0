Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB652272710
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 16:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbgIUObb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 10:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbgIUObb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 10:31:31 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB55C061755
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Sep 2020 07:31:31 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id p65so12437181qtd.2
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Sep 2020 07:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xup/6l0/GUl/Q1GS1OD6QBEEYkQUDiMG4VGCKb3WaZ4=;
        b=FmsFIJViZvZbOhXuN7WcjJZgLOdjjtAt45r1K8gsDunmRnuL7o5IKpmfNY4rY/d1R6
         ywSUAYXfeOuVjF/GiZvaDhV6s8003W3ZCjqozUi2KJ7OQCaBMeNf6nWQ8VL0mm2XeZPA
         HcosbleoTU3fngKiPEoWC2ii/TBePj1+cOF4Tfg8vL2odygAzO0dlX0iD1pJqOWIKJuV
         H+x5Q8P3cwkF8bGFnDZe7KX6zxA/UiK7qfNFtRyiAnbmu45sYOP4nUQsSMjb3eeZytG7
         FZCiDyNxevjGY+QVHVUJ0yjqrsd9UX49ikVoaTdQXd9e4FOSgtalklvOIlColvL7yUpn
         gpzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xup/6l0/GUl/Q1GS1OD6QBEEYkQUDiMG4VGCKb3WaZ4=;
        b=TAKep4vdPboq+6xGFKmJht9BCTHfA+S5C2KqgOJK7ugqDoGR7gpGQy7oaNq8/WjfkW
         LT9BF809iIvy36wR1TOuuxR9OCEhw6cN3cOnCpTs/vB0Rxqs+3PxCNz4PzOWLvlxZvYw
         BBAVZE8rcasyZ/g3ElZTyNRExB1m0JChOPHKREw1dv5uompHIqJCy/SVxagY5C82opev
         JVyEEvx9fSSXSueQPiRCs+4Msg9E+HZfzahR6VF53AAo2dxLggdfce3h4BCq+n7DbJLe
         CYc3a2MMqyMkL+a90PUDs5Bq7rZLC03Yphz9HgDnmKu1abvLBrq4LAqmnwbcMHc2Zp7J
         2sCw==
X-Gm-Message-State: AOAM533qlPLyyq4K+t9a1lCwTMn6S2TBpSC9u7T15qNNb4aJsfi6rNxQ
        VP1pGRcNUpZtkboGfru7HDDf8A==
X-Google-Smtp-Source: ABdhPJwPrbg4Ym2iu6C3wPjA2uv+X0G28SeKTQvf82EsiBtY3Q30LKsaXtcWF9P06HDkn3mCxI0BZQ==
X-Received: by 2002:aed:23fc:: with SMTP id k57mr27040226qtc.216.1600698690610;
        Mon, 21 Sep 2020 07:31:30 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n136sm8847639qkn.14.2020.09.21.07.31.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 07:31:29 -0700 (PDT)
Subject: Re: [PATCH 1/2] btrfs: test incremental send after a succession of
 rename and link operations
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <cover.1600693732.git.fdmanana@suse.com>
 <83001e537cdf42258dd4b4e3212546dfd099a337.1600693732.git.fdmanana@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <f2073f68-2491-54e0-a504-2b18fb00d86d@toxicpanda.com>
Date:   Mon, 21 Sep 2020 10:31:28 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <83001e537cdf42258dd4b4e3212546dfd099a337.1600693732.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/21/20 9:15 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that an incremental send operation emits the correct path for link
> and rename operation after swapping the names and locations of several
> inodes in a way that creates a nasty dependency of rename and link
> operations. Notably one file has its name and location swapped with a
> directory for which it used to have a directory entry in it.
> 
> This test currently fails but a kernel patch for it exists and has the
> following subject:
> 
>    "btrfs: send, orphanize first all conflicting inodes when processing references"
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
