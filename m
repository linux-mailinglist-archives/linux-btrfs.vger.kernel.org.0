Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C9122543B
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jul 2020 23:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgGSVEB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Jul 2020 17:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgGSVEA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Jul 2020 17:04:00 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83312C0619D2
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Jul 2020 14:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dirtcellar.net; s=ds201912; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Reply-To:
        Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uKskJrK0t49rILF7u7tLZA7wP3nqchrsBeTheQCtb/U=; b=QPRSiTdzZmE9S9/IKmhg5ZkWvh
        rp4wSd+SVtyNQuux1/5/JZnaAO3hRZfYqZmbjYWmWy17AVt2BO89EMEA0y29eWDnXPtUHFLAh5VO+
        Zg5cdMQkDrhsUPaqcCYIhUJXjiDWquw6288gXSu/qYaG9FvhnIwHt9wU+qyJeKJokMj4uGG5Ja8+M
        ggNksrBfjj5Uosvin6CHNkAYI8g7lH8nAc9DbVIJ+a3bvMsxK5E+VcMY1L8JjgLGYOvoc9NwXrqw1
        3NbeXYU+jFZ6QFS/ZzfPBrijNABUKKfoRLKiCtdd9u5NhFwX3wW9qtfiFvUp7fpdPFGqAWtnQ0lGc
        lxWCj1fA==;
Received: from 254.79-160-170.customer.lyse.net ([79.160.170.254]:56848 helo=[10.0.0.10])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <waxhead@dirtcellar.net>)
        id 1jxGTV-0005IE-5Y; Sun, 19 Jul 2020 23:03:57 +0200
Reply-To: waxhead@dirtcellar.net
Subject: Re: Possible bug detected, need help
To:     Falk Bay <falkartis@gmail.com>, linux-btrfs@vger.kernel.org
References: <CANUBKXi6yLPrisTy8ym_Q-6yyubLcTz2LtrSAvGK_SjMJR1sHA@mail.gmail.com>
From:   waxhead <waxhead@dirtcellar.net>
Message-ID: <ef34694a-1055-6838-f8f0-730162c1eae3@dirtcellar.net>
Date:   Sun, 19 Jul 2020 23:03:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 SeaMonkey/2.53.1
MIME-Version: 1.0
In-Reply-To: <CANUBKXi6yLPrisTy8ym_Q-6yyubLcTz2LtrSAvGK_SjMJR1sHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



Falk Bay wrote:
> Hi,
> 
> First of all I want to thank you for this great piece of software,
> I've been using it for a long time and it perfectly suits my needs.
> 
> After a unclean shutdown, with a balancing in progress and very little
> free space in my RAID1 filesystem I ended up with a btrfs filesystem
> that only works in ro mode.
> If I try to mount it as normal, any read or write operation will hang
> forever, not even "umount" will return.
> As a side note, if I mount it as normally I have to force my machine
> to power off since the normal shutdown will wait until any filesystem
> is unmounted.
> 
> Here are my technical details:
> 
> uname -a
> Linux poloni 4.15.0-111-generic #112-Ubuntu SMP Thu Jul 9 20:32:34 UTC
> 2020 x86_64 x86_64 x86_64 GNU/Linux
> 
> btrfs --version
> btrfs-progs v4.15.1
> 

I am just the average user, but I notice that you are running a old 
kernel. 4.15 is from early 2018 or so I think and is not even a LTS 
kernel. Lots of fixes and improvements has happened since that time.

As I am sure the devs on this mailinglist will tell you, try the newest 
LTS kernel you can get your hands on first. If that fails try the latest 
kernel and if that fails as well then come back.

Do not run any filesystem repair unless instructed by the developers.

For what it's worth - I use Debian myself and the 'testing' repo has 
kernel 5.7 and btrfs progs 5.7. That is as new as you can get it so try 
a live cd and see if that can fix your filesystem.
