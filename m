Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABB1168B10
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Feb 2020 01:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgBVAgm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Feb 2020 19:36:42 -0500
Received: from mail-qk1-f178.google.com ([209.85.222.178]:46148 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbgBVAgm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Feb 2020 19:36:42 -0500
Received: by mail-qk1-f178.google.com with SMTP id u124so3569879qkh.13
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Feb 2020 16:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Bgatn5L2KPxJzMHZu4nZbLm1ywToUkwc9sdR/0tyvu0=;
        b=MfiyRL1bHFAwUd6wg6xntaf+8/RfKZBUgQjpot5xOlGw5ozppyiJg/aNUbLknrSK/0
         tM6Cbg2sz01RtvHtuPD3702gQO4Pcjla+sN8I3xaWo7dg1/rGjE/rodL7xnmnS/dCT2G
         N+G/7ryPiKjShzMVUAz2yS+ViHwJs+pmM+bUes27/KAdCg4i8qu2o6dSk9S/vN7AR3FZ
         K1HwQddkSubuq6LxCC/rBAWJHI/pBIV+7XAMgzgEkfM7fmXc5LuGjdSr0ZmwPQuLjVNl
         S/b5/CqmTDwwUGc89sCcHAIGB7rdhzi4mumI58djlCQxWgIL/VY+939Um6+3KrTPgLyZ
         B+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Bgatn5L2KPxJzMHZu4nZbLm1ywToUkwc9sdR/0tyvu0=;
        b=K1CW1Be39rumD545fQUTVHUN8nWrZF9qvXctVNFRLiR5LCaabCvFsNlT5Ge3Wb0w3n
         MNP4RL+42l1hXtfhPGcz0OyL2UIeF4NMKj0iF1I8JwpZ+zXddgnbci7pZEEV6ipe4niV
         2tRMXofqVfYy2GzNDyAX70KcJTWLoTdQ2QijjJ0EpGRv0A/KGXaQgX5p85ZPXQwAKYIL
         twisnFuP3y+50Zf94ws61kYNpLnGt75Ku+tZrWXWdAbZ9piBLjfTw2i1WHF0Gel4BiC/
         am82X4+lZyV+47/dJprL0ba07ATdH3v0oCMYBzp0lBiyn6wDns7kJahxm+H5XT0p6e9K
         zvNw==
X-Gm-Message-State: APjAAAVkbyR/5oIK1Z3FjLnPeJvSEmWbv4TywyPqaZZsrCszzo3m3gLi
        jLFpKijMzr6pj1TE/lNZ5zQ8Iw==
X-Google-Smtp-Source: APXvYqz1apTLMAfcPmo26IcUivgEa+BhB333noeC4DPqCq9lWJe+ehB0fkXIp/AVhclfkgYLWgVjvQ==
X-Received: by 2002:a37:4b8a:: with SMTP id y132mr36502836qka.66.1582331800871;
        Fri, 21 Feb 2020 16:36:40 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::174d])
        by smtp.gmail.com with ESMTPSA id e130sm2323453qkb.72.2020.02.21.16.36.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 16:36:40 -0800 (PST)
Subject: Re: How to roll back btrfs filesystem a few revisions?
To:     Marc MERLIN <marc@merlins.org>
Cc:     Roman Mamedov <rm@romanrm.net>, dsterba@suse.cz,
        Martin Steigerwald <martin@lichtvoll.de>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <2656316.bop9uDDU3N@merkaba> <20200219225051.39ca1082@natsu>
 <20200219153652.GA26873@merlins.org> <20200220214649.GD26873@merlins.org>
 <20200221053804.GA7869@merlins.org> <20200221104545.6335cbd1@natsu>
 <20200221230740.GQ19481@merlins.org> <20200221231738.GD11482@merlins.org>
 <5cb4781d-5580-0a8d-562b-c8bfa3def5b4@toxicpanda.com>
 <20200222000846.GE11482@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <190af35b-c571-8472-b27e-4e4b041b5677@toxicpanda.com>
Date:   Fri, 21 Feb 2020 19:36:38 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200222000846.GE11482@merlins.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/21/20 7:08 PM, Marc MERLIN wrote:
> On Fri, Feb 21, 2020 at 06:47:26PM -0500, Josef Bacik wrote:
>> Yeah you can try the backup roots, btrfs check -b and see if that works out?
> 
> So, I'm not super clear on how to do this.
> the backup roots are not really a way to go back in time, they're just
> the same data that maybe didn't get written, so you can maybe go to the
> last revision if all the roots are not up to date, correct?
> 

No they're the previous transaction id's, so it's like going back in time, just 
in 30 second jumps.

> If so, is it best to get the last root since it's the one most likely to
> be the oldest?
> 

Well it looks to go and find the best one out of the group.

> More generally do I do a check -b to see if that looks clean, and if so,
> what's the command to replicate that root onto all the other roots?
>

If you do -b and check finishes fine, you can do --repair and it'll reset the 
super to point at the backup root, and theoretically you should be good to go? 
Thanks,

Josef
