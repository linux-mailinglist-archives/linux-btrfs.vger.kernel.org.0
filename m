Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE3BE16608D
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2020 16:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgBTPLL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Feb 2020 10:11:11 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:34444 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbgBTPLL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Feb 2020 10:11:11 -0500
Received: by mail-qv1-f67.google.com with SMTP id o18so2034592qvf.1
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2020 07:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=5xo0/VVbnOmNDrzDAqAlXDqiSAiWNSsTExxNPuxk+C4=;
        b=WUynoY28PU23Uc2mWomA8BWC3D4YmxIythkagVtEd5DzrVKK2JWQO2gJlP2gqgPTXk
         Q5MW9GNBaoNlY80+tUHRqYvzRbBhyAWg1xeTlLDICz/4cOpn1g/SnlHM7IGZln6ZCPI5
         xLIIrjtVkVWpqxRN1Y5H+DZCxzwHnNJoyfV910qUvlIBtHkGSMwcRe+/98q34YP4UcN2
         M39t5hVckt9wAYchXBo0xFEUtVXVTyYQwAqXbrlQtKgt9TkC8BT4EEezW540B0t/k2xw
         wkkEh51wYSMHiyaA/fVJh03Q7E/xHR2BT9BtHEQMpi00irE2zPW985uFXuZ8mBkq8//c
         m0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5xo0/VVbnOmNDrzDAqAlXDqiSAiWNSsTExxNPuxk+C4=;
        b=VIl+y1rg34je3vkbE49fZ0tYiM+RRGDG6xX4haB/nV1+T8zEI9Mola/56yVpEyowsn
         /i7EDnHQoO/ptw5ngv55YQi/Ap9c7CX+9SRyrFhZdvmwr1Ix6DPSVjgJTH5NRIoK/vdu
         qneAVxvaFl0KicQlVU+7j+aJPGOWFUDP0ZQ22qIbKGj6MMaMWDdMTXPzh3xVtf5RLY99
         HvZWBmFLGZEAGl3AMqnKrIAcYVcr7lMQYsVFCd+tW/dqOsdRPhijZSc+LLm9VD+xNcdf
         yvOfkYKs70j3eLCe10BozLLdStQaDILmjPZG+D+9sqnVb1YLqt1u/Xx87OxOcwQgJ1hH
         BBwQ==
X-Gm-Message-State: APjAAAUJxThXctWMTJIEV1kQcibyRjrR6UXMWQmIbm5U8NK1XXYQU/3g
        vjIPtI+IIkAxC9Ly0xh9lKiEeE33KA8=
X-Google-Smtp-Source: APXvYqwQesf3kahpZIl3y643XJZfWwIgpJg3ibOWgP+n/4hRkWAt5Ff5MGe0nWcBdR7UOMXERj90jg==
X-Received: by 2002:a0c:ac4e:: with SMTP id m14mr25316105qvb.37.1582211469464;
        Thu, 20 Feb 2020 07:11:09 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id a1sm1699462qkd.126.2020.02.20.07.11.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 07:11:08 -0800 (PST)
Subject: Re: [PATCH 1/4] Btrfs: move all reflink implementation code into its
 own file
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20200219140547.1641512-1-fdmanana@kernel.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <ed4abab6-af99-6227-29c8-f628c41dda66@toxicpanda.com>
Date:   Thu, 20 Feb 2020 10:11:07 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200219140547.1641512-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/19/20 9:05 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The reflink code is quite large and has been living in ioctl.c since ever.
> It has grown over the years after many bug fixes and improvements, and
> since I'm planning on making some further improvements on it, it's time
> to get it better organized by moving into its own file, reflink.c
> (similar to what xfs does for example).
> 
> This change only moves the code out of ioctl.c into the new file, it
> doesn't do any other change.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
