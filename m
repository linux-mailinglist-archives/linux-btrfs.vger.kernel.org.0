Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA1F6CB306
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Mar 2023 03:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjC1BPR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Mar 2023 21:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjC1BPQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Mar 2023 21:15:16 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB94199E
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 18:15:13 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id a16so9377305pjs.4
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 18:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1679966113; x=1682558113;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zwq4wydL9I093v9hDO3zVwxnC9J0ZcC370MjIqWsDT8=;
        b=4aXydidiJ0gc7rsxJ/Twmo6oHXpvj6XODqgY7UDHkJeLJRsq6y40W37/ZcDksGwZAc
         A7BXYYZww/WmIS5JeLSNicb1HYtNX5E4BjRm8ACtByEhkjCJ9ARbgOcD4/af01hfRL/X
         73P7ZjcuNrHhhdcOJJlOKzxG+9YhoRF2UdL3R+Ol6CJprWIaOhDgSwvj9P9ViC2LIXzB
         vGuC6V//sYYzegzWxHCY0qpLo/W2jl78LaiE3g6VvgIwFElz9WM4eBphtyqshPwZjzT2
         RrI3SIIpLjqG0o0f3Ur2haKngtLQRPgHhAN8u1QzsxyTmcSsuagZ/WXUKES9HL2OZZg9
         YvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679966113; x=1682558113;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zwq4wydL9I093v9hDO3zVwxnC9J0ZcC370MjIqWsDT8=;
        b=OW0LSmUk+TJyWMiwRbAyVW67HEUxMrZlq+jY+3BFZGYQH9tc7EO0U9MbrJ9lt1afso
         aQlPFdA8oMI9zTHyeZRjFLjLFMrlKAGoNDaVBHukKC3zpROTNVwCKmgzp+LB7vX0z2Fw
         y+cnSkGvY3y/Cs/FDyFHd8ZNd/QARzVre6AlnkeYDmh1uZsQKP2mYkBKS+8Yvfa0LaOa
         9cD56Ei5HcAKEuXR8olevTFRegHr3Y1/MG3NSm4dFCmT4jt1o4GzQeOoS1chR0RTmwIK
         Z2+ccWcktKbRybGDZG4xmoiYGViPGfPhwXfj+PIDVCWU0h+vpCW/kSXntNFTvXh9sUVl
         f7Ew==
X-Gm-Message-State: AAQBX9d5uUK8h30JuAT2vi8CoV2efa9nu4NazKF/BQYXntHwKaRqfQsT
        dahx2gpCs/+/vm0PU0Vl/ouHDA==
X-Google-Smtp-Source: AKy350ZYJ4GZvfbOmXmRspn+6HYJw0ztOtB6wwoqRwXMmL0StVUaM++KMQ2fSjcxhpwdlKSJBi5Bqg==
X-Received: by 2002:a17:90a:d58b:b0:23b:4d09:c166 with SMTP id v11-20020a17090ad58b00b0023b4d09c166mr10919116pju.4.1679966112751;
        Mon, 27 Mar 2023 18:15:12 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id l21-20020a656815000000b004eecc3080f8sm18782941pgt.29.2023.03.27.18.15.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 18:15:12 -0700 (PDT)
Message-ID: <f1b3f0c2-f08a-a432-f0c5-6223a59e671a@kernel.dk>
Date:   Mon, 27 Mar 2023 19:15:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 5/7] btrfs, block: move REQ_CGROUP_PUNT to btrfs
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20230327004954.728797-1-hch@lst.de>
 <20230327004954.728797-6-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230327004954.728797-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=3.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/26/23 6:49?PM, Christoph Hellwig wrote:
> REQ_CGROUP_PUNT is a bit annoying as it is hard to follow and adds
> a branch to the bio submission hot path.  To fix this, export
> blkcg_punt_bio_submit and let btrfs call it directly.  Add a new
> REQ_FS_PRIVATE flag for btrfs to indicate to it's own low-level
> bio submission code that a punt to the cgroup submission helper
> is required.

Looks good, and nice to remove more cruft from the generic
submission path:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

