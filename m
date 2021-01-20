Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7C52FD554
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jan 2021 17:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391356AbhATQSU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jan 2021 11:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390783AbhATQSJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jan 2021 11:18:09 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E5AC0613C1
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jan 2021 08:17:28 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id h22so1206343qkk.4
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jan 2021 08:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4p4wNNqBhppuZiFH/w6WIK5SqV3vEKIxg67twmz4YCc=;
        b=zcknEUCm7hjY/X2B6JrZeSgSpuqvJjvndP+gNXaJHYdDCW8ia2aRA8ZQa0ri1kWaQg
         IgjKpyefozQaRMrkaqQs12OKj5ZFM3nPgJL5PZHUnFPtPAYrHuO7Am5cADK33DUepSWK
         a5VZpeiQWXG+8SyuFUp+pntIv4asQ/arZImW51/+OrDOhqnd90CSwpclbNB7zr37ahJb
         j7l2de91C9gnp6jks3Osf5bn7eHiTApZSGL+Nl6YlP70tiKR0YcYmwQPqW5RIN4Tw4Pz
         SVcKA1SO9qcM3O8L+c4yrzfAuS9X9yjjZ0ZZw5/qDjjdw5WsM76tYnJwjxE8FswgP1Fc
         UAEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4p4wNNqBhppuZiFH/w6WIK5SqV3vEKIxg67twmz4YCc=;
        b=C1BKJiGP6VTPawzxqtLGBckoT+J0fPATOwbnjJJc7Kg8ySG2PMU9jlzHKkv+7mBRv/
         oQpLY6JcBOiKhvHUbk7bux+lhgk1ZWrYT1Z5c6F1fYtf/nU4lRTYYQDXuZJHhCosuujW
         5V722UExf/3BGGSEqPwmbrMPieA5m3TQk0gjV6DHduuLGwE5c7C57K2FY8y3kL/QyH6Y
         6wEkNQn6n1x10vjJtwvXGWvQKQJvVfStXdJ6Uolwz4rn/7qgTCR4n6GYcpJDjlP61k9T
         riJCE/GxnQMOqJDSz8S3zDlK24aXMOBn9YmlPBE//grMb0bM27LYMyZE+DyqH6L06u7z
         4VLA==
X-Gm-Message-State: AOAM530v9WW1PgdksKfhHe4Oj8Gt3i6PLuVfkPHFwthqbj7nBCpFbgXq
        uosvmD+mMe689qdTPl5R+5z7Ag==
X-Google-Smtp-Source: ABdhPJwE4q11wBcm7K412tkhuJGQRo9hB3X4UYyccFGac3teGBWl5ZKegb88hDyueGA97fwf4+JrgQ==
X-Received: by 2002:a37:b204:: with SMTP id b4mr10092152qkf.72.1611159447571;
        Wed, 20 Jan 2021 08:17:27 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n20sm1501973qtc.13.2021.01.20.08.17.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 08:17:26 -0800 (PST)
Subject: Re: [RFC][PATCH V5] btrfs: preferred_metadata: preferred device for
 metadata
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Goffredo Baroncelli <kreijack@libero.it>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <20210117185435.36263-1-kreijack@libero.it>
 <30cd0359-e649-dcc7-e373-4dd778fbf70b@toxicpanda.com>
 <SN4PR0401MB35989479F9B02A1E2795728F9BA20@SN4PR0401MB3598.namprd04.prod.outlook.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <de31f532-e478-8904-c20e-ba24a4ca731c@toxicpanda.com>
Date:   Wed, 20 Jan 2021 11:17:25 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <SN4PR0401MB35989479F9B02A1E2795728F9BA20@SN4PR0401MB3598.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/20/21 11:15 AM, Johannes Thumshirn wrote:
> On 20/01/2021 17:09, Josef Bacik wrote:
>> I'm not against adding new actual keys and items
>> to the tree itself, but is there a way we could use our existing property
>> infrastructure that we use for compression, and simply store the xattrs in the
>> tree root?  It looks like we're just toggling a policy decision, and we don't
>> actually need the other properties in the item you've created, so why not just a
>> btrfs.preferred_metadata property with the value stored in it, dropped into the
>> tree_root so it can be read on mount?
> 
> +1 from my side as well.
> 
> I have the need for this in a planned/future series and I'd be more than happy if
> someone else would've already implemented it so I can jump on the train there.
> 

Same, hoping to encourage a grenade jumper,

Josef
