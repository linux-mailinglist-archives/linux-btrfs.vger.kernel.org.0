Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A13C179860
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2020 19:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbgCDSuB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Mar 2020 13:50:01 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36253 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729600AbgCDSuB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Mar 2020 13:50:01 -0500
Received: by mail-qk1-f196.google.com with SMTP id u25so2718659qkk.3
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Mar 2020 10:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ZZce8Kgf4lzQGQy5RFLZ3RANenqkxgHNP5BlS7lu+1s=;
        b=wsn3bl8op2uGGydcNy1qrrRkEih2h10OJY0xtjKRbWt4YxMYpRKcG+awL9QuExa/jL
         EkyxVdGD6+TuhjLujHYVeifwprVlH31ep508UCjrb13CC8YKNBYxIODVBo88Q56hK2m+
         Xh48/P9QwxYCENf4wZVbvCJhGQBzWEl0sPq2G89DCOUjct0Y8lu9txguqe2FagL3jSSu
         EnahvNMOGxWoir/KP2FArUlU+nSPudd0c8xEfii16wruHh602QxGm8xBhg+W0RbR0O9O
         zwD+HzT7IdC3XGL4BAOEnl131TiQUL3eil7sPr7CIKBKfmJyrlZQbkJjMyPnUwFjzE2M
         Hb3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZZce8Kgf4lzQGQy5RFLZ3RANenqkxgHNP5BlS7lu+1s=;
        b=MsX0YWMjqsl12YJfzvTeIrfMAsAs4L87tJdpkGD9bf5D7NLaqQU9uG0VkFCBlidlLe
         Ius0lz3jR1SAqw6Q23U7fHocBvjwxLbjb3CcOA73uomTb9NrEXuhL0pmcE50odS7NZgP
         Pi4CxP77BG+u+sMeCwn5RJ9cX5DPimbUAEui/eNmbL5wuCtH6YXkGkEnTrIPFITUzEAK
         oRj2RisjRNbKYOgvJlnM51MRXNjKX2CV/LNFBIomEeQWw0vxZVc2TUhyOIO7eUpOetkH
         9tuqgKUMyGJ1oiNVyRldwa09K/y94XlrkhdWb7q4ecuOyN364H0FKP0lgtr559cMil7w
         j1AA==
X-Gm-Message-State: ANhLgQ3/ylsz0RyICP9XVC8zI9Y5hiHu1wgjg3uYx7UJC4pc5tRTzVCK
        ZcfkFnjuHtXO28iMtoC6DpVMo9mtdi4=
X-Google-Smtp-Source: ADFU+vvKwbJmKpTMZTm06sMwd9p36mqaMbe4Hl7qnIOVPjKW5HTOxEj+QSA4/2rtx20+5hgQFmkChA==
X-Received: by 2002:a37:96c6:: with SMTP id y189mr4331813qkd.150.1583347799733;
        Wed, 04 Mar 2020 10:49:59 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id v186sm9491258qkb.8.2020.03.04.10.49.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2020 10:49:58 -0800 (PST)
Subject: Re: [PATCH] btrfs: Open code insert_extent_backref
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200304093353.26248-1-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <3ee8178f-b43a-6267-09f2-5538bb9f7aa6@toxicpanda.com>
Date:   Wed, 4 Mar 2020 13:49:58 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200304093353.26248-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/4/20 4:33 AM, Nikolay Borisov wrote:
> No need to add a level of indirection for hiding a simple 'if'. Open
> code insert_extent_backref in its sole caller. No functional changes.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
