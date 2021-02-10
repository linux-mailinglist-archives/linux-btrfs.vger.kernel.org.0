Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8280B316A3B
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Feb 2021 16:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbhBJPbe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Feb 2021 10:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbhBJPbc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Feb 2021 10:31:32 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F458C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Feb 2021 07:30:51 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id q85so1978622qke.8
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Feb 2021 07:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=pDXXtxKBe0PUoiIr7dtfU7Mocygm0Cj76jVIzhJTiOQ=;
        b=lxVy+VBXxAQd0UwhRmvB6oJa4sJLIf8EpBlLrPiHVKWVXkcJYH0DZAtwQfCLd3EdEF
         JXijuKoxHa9YZLHjvz4ZTcbcdUsPLlGCMSTDoTLkx6Dt0q/p0ssJq+f/DFJwIv3EKn7A
         CLs3K0+8oivsR7rONro43a+lZijEOWLK1Kes45VpUgzDHcmbnXDkRz2wAfgDXh0O4IIZ
         npoauibNJJGD4bO8gyFIJJZzXoho7jerZ+xUWKziGIrFBTogOwXCqqSkVRrDVW9criOg
         q7o642qxgv4rgQx3AK33YTxtV1fodUi6PJfcyfyYLIaPSJktQ5AqreSQo04JO4dFfiTk
         /HVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pDXXtxKBe0PUoiIr7dtfU7Mocygm0Cj76jVIzhJTiOQ=;
        b=YbUa8o0tNJZAos7ZTzE3CGdaT2aK5YYAJBwJ7HhS87R5EnEPVtrg+JaL65jkdng+NX
         R5djnMTzyks3oA0WdXf6zHJ8nAvqQB90oLSfO0RlJUiUU9HUKmlAnWryv1QjnJP3DKJI
         YmCUPBQUrb/UfNbgT/H2t1/bt/wdsmqVsMdk9rAq2TmTpYrf2lmFuDbxQ6m1R9bjzSwe
         cYIBuY9yBSZppisMSDzD4pWUV61JBLjy1F3Ua05ab5GwIIxiTut4sbFkL3tMVkYTJ40j
         q+qmoDttVzRSNmh3PCLlsXva1qP1vwD2wA9YrX3lKXULDSDHHjKcX2+JTOE3E3HBxo9H
         yFdQ==
X-Gm-Message-State: AOAM530XxNNLCXRyVFFSDkBFoLx78Up+in/rDqG6ErD7oAm2oYGU2Kzw
        dV69pMUyyDu46TevgBSXLNmInlx5F06FA9y8
X-Google-Smtp-Source: ABdhPJyjl8Fw8bYFN4dfPhmMxO3ZB+rXS5T8bWhGPXdYyQ1qVt4kXKpK6Ro/c3g44c9PdmVPn+Qt1w==
X-Received: by 2002:a05:620a:6c8:: with SMTP id 8mr3887777qky.220.1612971050286;
        Wed, 10 Feb 2021 07:30:50 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c63sm1690262qkf.8.2021.02.10.07.30.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 07:30:49 -0800 (PST)
Subject: Re: [PATCH 0/4] btrfs: fix a couple swapfile support bugs
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1612350698.git.fdmanana@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <d8dd8f74-ca4b-f41b-4e07-72ee406167d7@toxicpanda.com>
Date:   Wed, 10 Feb 2021 10:30:48 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <cover.1612350698.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/3/21 6:17 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The following patchset fixes 2 bugs with the swapfile support, where we can
> end up falling back to COW when writing to an active swapfile. As a bonus,
> it makes the NOCOW write patch, for both buffered and direct IO, more efficient
> by avoiding doing repeated worked when checking if the target block group is
> read-only.
> 

You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

To the series, thanks,

Josef
