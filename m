Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1F61315F6
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2020 17:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgAFQWX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jan 2020 11:22:23 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45124 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgAFQWX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jan 2020 11:22:23 -0500
Received: by mail-qk1-f195.google.com with SMTP id x1so39859913qkl.12
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Jan 2020 08:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dvhh6ogEj5AuzRcV1dw4Yh6p7jo5MomIDIIqYgaDkYQ=;
        b=WFOIT7AGa1gnof18zVWSpKGikUrNH9ezMOVEP0fUeJcOFlQwZXTPA2NAP0kXsO0xO2
         ajlyiEx8Muz7r4TrZn7jr0hA9dRXkVbpXRUCCEyfb8O3Rdz1bWC7Rrsj4ixCxbg0rLd/
         /3GCSlwRLiX7aT0lWlDWJsJ3SsH56IDpUMd3xXdn2u+9Nn7fy3OkFvc+WQGyfbgpTBjI
         H9KkbRPVQ7WoX5a/Cc8AfoXUL//wtk5tGIqOjeYPyKhuiMz8AqG30c2+CQl0smL3jafa
         fy9IdWNGJeWbYnc54Ts6iR4Chkjecho71Y8mTlg1EQLfc4xenfvts9y38MQtS/zZf7rM
         My9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dvhh6ogEj5AuzRcV1dw4Yh6p7jo5MomIDIIqYgaDkYQ=;
        b=j14UNUBjVD/aJi4fJYc3mQuQRuPi1ATJUE4EijcvxGqjUtSRtek4Q9+ROdQVJHVjo5
         wS5QZ/hx9MhjFcbB/cxTj2WOs7JRvBbMxlN3EpHXZ1U7+IEQDA8TF5r7LzCy6BFWMpGd
         fmF3/f2lRRHEvhxbP8FN6JEz2MBWBvRrjh4UqnjAB3+UJQRIkdcA2Y+OeIsQXyrMyNRw
         yu3WOpM/aNdd2h7SN539FKPupJ5TEncG1dSySojYAvMwOQXDGJ3BKoCMYRJTUrKm80SH
         F8Yujj+H/CUYV2pC9rDBGRBycvXg1HnE7vRfGSoUzwvVY5GW9YZ5lJ0y7Z0yZT1s1tte
         M4fA==
X-Gm-Message-State: APjAAAUzMkJiHjqeV9hQ5l4vxj0Ml2V5geoWRcAuGGPQnDMQE9BxQ78T
        dvSQwCZ6+O9Fdi7xrBs86IJfUw==
X-Google-Smtp-Source: APXvYqzUNz2kmEEFMZw8SAIfzejI4fJSgmAJS/lTbnjyHy6FZUiaL5u0XN0jKVV4RU+PS2z+Slrafg==
X-Received: by 2002:a37:684b:: with SMTP id d72mr85218255qkc.293.1578327742490;
        Mon, 06 Jan 2020 08:22:22 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::6941])
        by smtp.gmail.com with ESMTPSA id k1sm19855769qtq.86.2020.01.06.08.22.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2020 08:22:21 -0800 (PST)
Subject: Re: [PATCH 1/2] btrfs: add read_policy framework
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     btrfs-list@steev.me.uk
References: <20200105151402.1440-1-anand.jain@oracle.com>
 <20200105151402.1440-2-anand.jain@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <5331bb6f-4c95-9afd-ab98-23d22b71fd3b@toxicpanda.com>
Date:   Mon, 6 Jan 2020 11:22:20 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200105151402.1440-2-anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/5/20 10:14 AM, Anand Jain wrote:
> As of now we use %pid method to read stripped mirrored data, which means
> application's process id determines the stripe id to be read. This type
> of read IO routing typically helps in a system with many small
> independent applications tying to read random data. On the other hand
> the %pid based read IO distribution policy is inefficient because if
> there is a single application trying to read large data the overall disk
> bandwidth remains under-utilized.
> 
> So this patch introduces read policy framework so that we could add more
> read policies, such as IO routing based on device's wait-queue or manual
> when we have a read-preferred device or a policy based on the target
> storage caching.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
