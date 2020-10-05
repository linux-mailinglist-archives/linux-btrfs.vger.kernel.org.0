Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C56CC283671
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Oct 2020 15:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgJENXW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Oct 2020 09:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgJENXV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Oct 2020 09:23:21 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFAFC0613CE
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Oct 2020 06:23:21 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id c23so2343006qtp.0
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Oct 2020 06:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=v9RvH7c14zfHueeXQNRBx290zmK9yEAMPK/fBrelE2s=;
        b=W4dajL4wLbGwjY+/Fhb/duUJ5Jo2xMOYUmfMs6lO9LhTjwMYRIyhRqfUxybeh+2Rnp
         i8mYvv+gpQMOc20gnC7g22f9k/YLjW0+I+IOC1HNOf2t+2JX8Hr5H7Of4mme3jGTxvkh
         RoB1vrnPzLXX8WaU6XmdWrjwEKbGOmsCewhjwK4MHE3tTBMT0b8R1chFByyq9w43LZ89
         8QfIGwnh8ZAvvnSLOYWT0h73maMHScvKQg0ULcIhqQYdRQdMBo48ERVx6rtiz4SPJUoF
         SnlwkOizEQKYMO1KX7TMK75NnxZ+byPJSjMtANT4JgqceheXnVjDd8urUt7D+6QPjt2Z
         AY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v9RvH7c14zfHueeXQNRBx290zmK9yEAMPK/fBrelE2s=;
        b=MIbtmZAingmmtbaPYrd+hmoxyuI21KY5LO28VUzewc0+zQrRMZd5JRssa90vStnqLB
         TCJzQvcvEvSelkQb2KV3eBimXXeYn0hiE7kLguyDnGfOfV54eRFtxB5mT/g6So0xJVTJ
         w9D/kDiFoRrCVOW8WFahZJI4vhc+fcSl4S2Lz7lbilJDdqKNkgSf5/aU6jJ1p2IATVl/
         4bxqKuNdLQEes92b+qZHXoR4AMgJthQmJHW2AYyAEa9jUc93X0hnw8gJUIKImwmUm59Y
         DyK3n77SNXMImFogzf1g45vINaimVCyL3Pdr4rWTMQNJPAv6ieCszwtJKWeI2eBPKODm
         OTnQ==
X-Gm-Message-State: AOAM532OJckWqYbVik6C6wug/Fzmv3vuA1HEUKXM3328vbVSWFbCiApD
        GGoQgrHdv0zK07QFeitNW3mGMg==
X-Google-Smtp-Source: ABdhPJyIIohiDMf8P3yC56v4i/SnVrGjvV/b0Ej4TogmdKC0YroTDtdRbaZSGx+dUHcbbLUlTkHNXw==
X-Received: by 2002:ac8:6901:: with SMTP id e1mr5178132qtr.122.1601904200745;
        Mon, 05 Oct 2020 06:23:20 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q3sm7144180qkq.132.2020.10.05.06.23.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2020 06:23:20 -0700 (PDT)
Subject: Re: [PATCH 2/2] btrfs: fix btrfs_find_device unused arg seed
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     nborisov@suse.com, wqu@suse.com, dsterba@suse.com
References: <cover.1600940809.git.anand.jain@oracle.com>
 <b9108a14773af7a899226f59a9dbd0953d20abe5.1600940809.git.anand.jain@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <455f799d-d8fb-41a2-1c96-37d2b7644cea@toxicpanda.com>
Date:   Mon, 5 Oct 2020 09:23:19 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <b9108a14773af7a899226f59a9dbd0953d20abe5.1600940809.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/24/20 6:11 AM, Anand Jain wrote:
> commit 343694eee8d8 (btrfs: switch seed device to list api), missed to
> check if the last arg (seed) is true in the function btrfs_find_device().
> This arg tells whether to traverse through the seed device list or not.
> 
> This means after the above commit the arg is always true, and the parent
> function which set this arg to false aren't effective.
> 
> So we don't worry about the parent functions which set the last arg to
> true, instead there is only one parent with calling btrfs_find_device
> with the last arg false in device_list_add().
> 
> But in fact, even the device_list_add() has no purpose that it has to set
> the last arg to false. Because the fs_devices always points to the
> device's fs_devices. So with the devid+uuid matching, it shall find the
> btrfs_device and returns. So naturally, it won't traverse through the
> seed fs_devices (if) present.
> 
> So this patch makes it official that we don't need the last arg in the
> function btrfs_find_device() and it shall always traverse through the
> seed device list.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
