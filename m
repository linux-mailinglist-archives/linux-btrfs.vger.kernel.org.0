Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 299CB2B571D
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Nov 2020 03:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgKQCxd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Nov 2020 21:53:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgKQCxd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Nov 2020 21:53:33 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C453C0613CF;
        Mon, 16 Nov 2020 18:53:33 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id a18so16115139pfl.3;
        Mon, 16 Nov 2020 18:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=e+k0NNbbIJsnWb6/NawsT3reeEAv80LjdOayORgiKkw=;
        b=qN9UIVQUq4Be03GE6EviCnPDGjHnCsMNttJ3B/t4/rxYCSJF8IWjyOdx+h56EF/4eh
         3/oGDvVtHWXSZDu3WrA7K6aEIH3dq1JNJ5XMNZBb86bvlT9o25j9UfAm6vP//9IAyI4N
         CjyvlFt/nIkwXLctXNABaXe/yWXU4WMxuWg5P6/f2BEw2ejuV2zOkdtdFF1u5kOvTbTi
         NChaNVQgVKmVExWzvTHmLq0sNL5HSWo8alzAnKq+OlYJP9M6H+fnQqqgN6hSMg9OJf5a
         BjNwI8q13Y3mhfB4vZ0hKzErbTNmN6Bbut6nwwiWxnBdmRq35s1WnpnkAAOiud9gXxpj
         o1mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e+k0NNbbIJsnWb6/NawsT3reeEAv80LjdOayORgiKkw=;
        b=Jk2tGcx5dIe1sjkl/HmS8i8bMmF7O2dXSTItEmzJky4x+cC2x9kRYsbbcXau5fLuLf
         crhAiNXWGwXqDSeb0AwcFGjPXMEbPw1h6fISSORssYEuJ3/82LebEEbJzZxbVU143WA/
         PF3SG8vnplWJAtlVbWNMOBk9sg3wHGJ9Vg/2fvjGu8uAxW3E4vgxzwI1Q9+f+tT9loSz
         b7C01cOw5udmUpvLYhjOq8gvcrX6A+Ialqvo2dW7JCfIcDo3JacjrxC5doy29F2r1EQr
         SfXRM7nfes25KNEwL8yMq3RQXHKDZGfKe5zIAgXZLDtHS6UXV3YTUdO8REaiEO/QHzGQ
         f0ZA==
X-Gm-Message-State: AOAM533IGDwGn0wFU+6cXu9Yzs+GZ3EiCpQ+fDEN9+g9X4jJTQjdWHMd
        O2xplaETyYKRyb2q2HZqKg==
X-Google-Smtp-Source: ABdhPJxZSKuhMuASGc9aDRyMhsK2eQZxwHJ5qil+KbEa7c2RNPGiAovjVlPHN/G++oi4+JdAaq2jSw==
X-Received: by 2002:a17:90a:fe0a:: with SMTP id ck10mr2148420pjb.233.1605581612707;
        Mon, 16 Nov 2020 18:53:32 -0800 (PST)
Received: from [10.76.131.47] ([103.7.29.6])
        by smtp.gmail.com with ESMTPSA id h9sm863647pjs.26.2020.11.16.18.53.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 18:53:32 -0800 (PST)
Subject: Re: [PATCH] btrfs: remove the useless value assignment in
 btrfs_defrag_file
To:     dsterba@suse.cz, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kaixu Xia <kaixuxia@tencent.com>
References: <1605344781-10362-1-git-send-email-kaixuxia@tencent.com>
 <20201116151338.GI6756@twin.jikos.cz>
From:   kaixuxia <xiakaixu1987@gmail.com>
Message-ID: <9a60330f-ae5e-ba78-ef34-69ab2b7ee0df@gmail.com>
Date:   Tue, 17 Nov 2020 10:53:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201116151338.GI6756@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/11/16 23:13, David Sterba wrote:
> On Sat, Nov 14, 2020 at 05:06:21PM +0800, xiakaixu1987@gmail.com wrote:
>> From: Kaixu Xia <kaixuxia@tencent.com>
>>
>> The variable ret is overwritten by the following variable defrag_count
>> and this assignment is useless, so remove it.
> 
> This could be actually pointing to a bug, please explain why you think
> it's correct to remove it and not to return EAGAIN.

The right fix should be goto out_ra and return EAGAIN. I will do it
in the next version.

Thanks,
Kaixu
> 

-- 
kaixuxia
