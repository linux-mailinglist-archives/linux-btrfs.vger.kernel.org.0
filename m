Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F86C18BDD2
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Mar 2020 18:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgCSRTj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Mar 2020 13:19:39 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:34257 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbgCSRTj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Mar 2020 13:19:39 -0400
Received: by mail-qv1-f68.google.com with SMTP id o18so1443716qvf.1
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Mar 2020 10:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=jKE/tFJyW5ecNxjXx7zmLeInbveCDR3q3KzjetR7jkM=;
        b=Ze00+1NhK/3a+rVLiPuatn7kSP1wp6CYNRt2TZpKT2CSAkxA7SMBVwFEQuGVeh/mWb
         7snqE6NWVNVbWQ1nHOFC2AWEgEd1fTvjHd0fiP5uo/5GqVbzeSykQ4G5hnmFUTjnEAXQ
         2+H6Q2eQlsT0xbNm9eXS7B/Dmin0hK3xt92ZmazK6kKAKVsg0TfVMiISZgzD/wZwor2E
         Br1ns2tDR2fs9Aw6aVHflfSSqQXTioDAJ6MA93o884OwjsP5ZNxJWkDAxrLwD7h5gXbW
         hF47B/BNWSbBWWeSufPXBfecr7S5XzVGunP1GhfnblvF0EmtdjJ7vrQWNlSHd+fYWkrf
         PhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jKE/tFJyW5ecNxjXx7zmLeInbveCDR3q3KzjetR7jkM=;
        b=nYg8Q6pezMbIDnOE5udY9HNWapI80rU0yc2vvI5OjavoSMg26tXQX+SnOsyPs1r36x
         LbnklEXAWoKf8uI/0CtmLCz5OTNtJQ4sV7aH+BiWiuMn31ExGcJjyZkwIzugp22ph6Ol
         Ew+Jqv/zG//RbfYoMILPFMJv0OCJ8527V+ogmfASt3Qf04s+0AXHKitQrCiUEQzSd0W6
         B+60bHyVqYvgNVoKw34uYZFTIrqtOGMUcIhzXZjJzTPvf31c+9rDkOk67md5F4xzJcDQ
         9mqtoco46LdPo8RQKf5zzIuZCJyDzeRv+tHgw129LkhNVrf5o6qRhZPBPhWtrv5az8C9
         uing==
X-Gm-Message-State: ANhLgQ3Nhx2h3SMZUndaalBrCX8JoHnmI9zJ7Q68RCEq6wvxg5C1+5a5
        aDxyI0kdi/sZ/sZwjLciRReSP+eMlG4=
X-Google-Smtp-Source: ADFU+vvJ554jeacgAF98apiykXav9tNXgTmskUa5dTHxAqQO+lBW+HFsuagWFfG/JpE+q5QzDShFpA==
X-Received: by 2002:a05:6214:12f1:: with SMTP id w17mr3875750qvv.132.1584638377529;
        Thu, 19 Mar 2020 10:19:37 -0700 (PDT)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id e2sm1895118qkg.63.2020.03.19.10.19.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 10:19:36 -0700 (PDT)
Subject: Re: [PATCH RFC 13/39] btrfs: relocation: Refactor the finishing part
 of upper linkage into finish_upper_links()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200317081125.36289-1-wqu@suse.com>
 <20200317081125.36289-14-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <6b0aa6bb-4093-111d-5a1c-c2e6b7117ca0@toxicpanda.com>
Date:   Thu, 19 Mar 2020 13:19:35 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200317081125.36289-14-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/17/20 4:10 AM, Qu Wenruo wrote:
> After handle_one_tree_backref(), all newly added (not cached) edges and
> nodes have the following features:
> 
> - Only backref_edge::list[LOWER] is linked.
>    This means, we can only iterate from botton to top, not the other
>    direction.
> 
> - Newly added nodes are not added to cache rb_tree yet
> 
> So to finish the backref cache, we still need to finish the links and
> add all nodes into backref cache rb_tree.
> 
> This patch will refactor the existing code into finish_upper_links(),
> add more comments of each branch, and why we need to do all these works.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
