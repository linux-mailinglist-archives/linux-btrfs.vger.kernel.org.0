Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7310C2DE6F3
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Dec 2020 16:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbgLRPwZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Dec 2020 10:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbgLRPwY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Dec 2020 10:52:24 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A6CC0617A7
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Dec 2020 07:51:44 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id z3so1550462qtw.9
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Dec 2020 07:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=BuPf/VHKVZuuGlqcs6vckZHKIcSAu+YciU113xKPgQw=;
        b=dnF+mmZw/1X1vgaCNeR26jdKojTKwfQfXE+n1VBc1W0q6Rjp1EURiLOMWUXVvrWSxi
         AhOm3gb/D9nCGRjPjf3U0s1cOBbS9Mlh7TwdwdOyiKkf/+ggtAJqhK91nPbSX8qdIxlo
         lNrCsOf1vzh/irAvswSKuuE6tBfcZ297JiVpmOc9T+z92Px21q7E+MGYuw2MLtodydPq
         qsXC95+gBA0zVnJeY7btjgdOGvOOgBKVZNJxz75D2ZB3qF26HlFkOrN0Ln/4qcqoXVYd
         Fq3Xi4O0dMtQar3a8Xh5lHES6Jh2y/64FnMwiHZ60MbrWiqf7ol8K0kup3rkheo9MfiB
         TtEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BuPf/VHKVZuuGlqcs6vckZHKIcSAu+YciU113xKPgQw=;
        b=ICFg8Hon+4ZGCZFEOTeBpHn9txGqBcFkWi/gMBiyhym/zej9lskfOM6GP4skf1TYoA
         1q9gF+zPpPWJMTYvdAbC3fVzrqFkDDh6z2sSmUQ6dpUo8ptca3SQ4wvZjbJtpIKrTY37
         CDG0IMQlNTaNmRk3PdPjCa1FbZ/LNu6voCcza9lu5rjfRm80eBEXX5kBqPjGXEKFh9zo
         ygpRbE4OVYnRX84szsg0OU07woXIK05q3TrZelPOvZ6iTzB6F911kgQUl8+0AybXspG/
         9/oY7LTLuyOOqbM5o6adMJMg3FGFOm3H1pEPrSGvmGZ3kPxaRbBYMaM7ZWQKum4l+g3x
         gLQQ==
X-Gm-Message-State: AOAM532FH+bgkwli+u3Wfv+ujciK83dhgstn1hjRvpED5iqJfD5/kgWS
        +qE17hhWbhfdxkCjNNofd6UDqA==
X-Google-Smtp-Source: ABdhPJzXB7jqgE2/YHZwzGvMA/zrWgMNs2b3Pgqn/oGy1F8jH8J3YwH7aoqajr2I46Z1EtXB77rLsw==
X-Received: by 2002:ac8:70c:: with SMTP id g12mr4560142qth.140.1608306703776;
        Fri, 18 Dec 2020 07:51:43 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x17sm4351648qts.59.2020.12.18.07.51.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Dec 2020 07:51:43 -0800 (PST)
Subject: Re: [PATCH v4 5/6] btrfs: stop running all delayed refs during
 snapshot
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1608215738.git.josef@toxicpanda.com>
 <8f91eea944203695995bd69512d7e0e37a39bd64.1608215738.git.josef@toxicpanda.com>
 <346befc5-e425-846f-27c7-ada577dc5a63@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <b640bcde-0910-3d4d-4b48-e77929a4bd6f@toxicpanda.com>
Date:   Fri, 18 Dec 2020 10:51:42 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <346befc5-e425-846f-27c7-ada577dc5a63@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/18/20 4:26 AM, Nikolay Borisov wrote:
> 
> 
> On 17.12.20 г. 16:36 ч., Josef Bacik wrote:
>> This was added a very long time ago to work around issues with delayed
>> refs and with qgroups.  Both of these issues have since been properly
>> fixed, so all this does is cause a lot of lock contention with anybody
>> else who is running delayed refs.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> Codewise it's ok, however I would have liked a better reference to the 2
> problems being fixed, I'd assume same applies to David. SO it seems the
> first delayed refs run was added due to :
> 
> 361048f586f5 ("Btrfs: fix full backref problem when inserting shared
> block reference") and the 2nd one by d67263354541 ("btrfs: qgroup: Make
> snapshot accounting work with new extent-oriented qgroup.")
> 
> 
> However there is no indication what code superseded the need for those 2
> commits.

For 361048f586f5 it's because we now do #2 as described in that commit, which is 
to make sure we insert the actual extent entry first, and then deal with all 
subsequent extent reference modifications.  The delayed refs code was quite 
fragile before, but we've gotten it into a good spot now so we no longer have 
this class of issues.

And you bring up a good point for the second one, now that I look at the code. 
It appeared to me at first glance that the qgroup stuff had been reworked to no 
longer require the delayed refs flush, but it still does require it, so I'll 
rework this to move it into the appropriate helper and I'll update this commit 
message.  Thanks,

Josef
