Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 289D0A941F
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2019 22:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbfIDUwn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Sep 2019 16:52:43 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50196 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfIDUwn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Sep 2019 16:52:43 -0400
Received: by mail-wm1-f66.google.com with SMTP id c10so266453wmc.0
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Sep 2019 13:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H0SOeyV3AJJq2z1n9EQHtQQ16MhkwOgzOaDwXhLLkRg=;
        b=P9jFg/JUd7+71ocWWLVgopCWF0rfCB7myfUrZeiCt3cxrgxbnfAk+/KzfpkqIU4yHO
         izgdlv/ZZt5E1AlCJn50MgbCp+ClqmXi/xuKGrKFCeZnA0oOp00Lz/r0hxz8M9a/1gAK
         kTJwkT9Xm7Y7REx2lIXWYft2QfDPQizdJ97fxAH25P6fc3/DeCcN6HdCFJE83Lk5bLZs
         M4w6RYzg0dmdJRzsZ/LUPu9MDBQtMPDi4uKqW6Ym2ZTrVrZB8qXseDSEdtaSCa8IWyvv
         K0Z/dnjyvFMOBokaCq1uJ87v5zlKDNvz8BbdnQZtR8rFUz6uLdLqjau4ybJql2r516M3
         0uJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=H0SOeyV3AJJq2z1n9EQHtQQ16MhkwOgzOaDwXhLLkRg=;
        b=ijWUAD9lokmM9gpzLB8rXsomqzFewt+R2M5lYVI6tXkOne8hzvQ8/rUkkyTcNqRA8Y
         BRMvkFmDksFslmU0Bf1ci0bK2pxUHLJB1vAa9lWvWnPjA0uBSf/0QRITYuD/z6w6O1hI
         tm3NarBOIOFmZ/hpwRUy5XJZGwMRcHYZCTdfC0cvG58mOlwrMdYa1OCT4bT4aCXWRQbE
         8iIHT2jXXX0Y+lktgBq6u32C1yuganLrSA2rBaCeiBtuadXJY5+DnBLNSla9eJ18cz3L
         yFgEamgj7C8Y15xONmevrcQnzGtsKt5P1nwAnYsLGuk8/P5eIKTQusl6jEV17W9F3YiA
         KowA==
X-Gm-Message-State: APjAAAV1iQfu9XMy3kKUc2QUXrDrXqY2Y9sp3jIiV2uBzp6xSghC83sV
        syrYhZ28SrWQiaOOM/piGF4=
X-Google-Smtp-Source: APXvYqxQeo5RK/0LrGcGe3ggLPIxWO1zYWAwA0QJc37LNLjd1iZZHeKI4beFHDto7PmX6yJtephw9Q==
X-Received: by 2002:a1c:1d4:: with SMTP id 203mr163392wmb.104.1567630359912;
        Wed, 04 Sep 2019 13:52:39 -0700 (PDT)
Received: from ?IPv6:2a01:5c0:e097:52b0:fa16:54ff:fe84:9770? ([2a01:5c0:e097:52b0:fa16:54ff:fe84:9770])
        by smtp.googlemail.com with ESMTPSA id y186sm356610wmd.26.2019.09.04.13.52.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2019 13:52:39 -0700 (PDT)
Subject: Re: No files in snapshot
To:     Chris Murphy <lists@colorremedies.com>,
        Remi Gauvin <remi@georgianit.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Thomas Schneider <74cmonty@gmail.com>
References: <b729e524-3c63-cf90-7115-02dcf2fda003@gmail.com>
 <CAJCQCtTs4jBw_mz3PqfMAhuHci+UxjtMNYD7U4LJtCoZxgUdCg@mail.gmail.com>
 <f22229eb-ab68-fecb-f10a-6e40c0b0e1ef@gmail.com>
 <CAJCQCtRPUi3BLeSVqELopjC7ZvihOBi321_nxqcUG1jpgwq9Ag@mail.gmail.com>
 <423454bc-aa78-daba-d217-343e266c15ee@georgianit.com>
 <CAJCQCtSG9W93dWwH7++dBGh94s6UGGbugrW8y17OmycC5wP8kw@mail.gmail.com>
From:   Oliver Freyermuth <o.freyermuth@googlemail.com>
Autocrypt: addr=o.freyermuth@googlemail.com; prefer-encrypt=mutual; keydata=
 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
 KB7t2CoZv5xo0STm
Message-ID: <a6b8e96a-6b66-be0e-e44d-2b65ab7cb2b9@googlemail.com>
Date:   Wed, 4 Sep 2019 22:52:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtSG9W93dWwH7++dBGh94s6UGGbugrW8y17OmycC5wP8kw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am 04.09.19 um 21:07 schrieb Chris Murphy:
> On Wed, Sep 4, 2019 at 12:24 PM Remi Gauvin <remi@georgianit.com> wrote:
>>
>> On 2019-09-04 1:36 p.m., Chris Murphy wrote:
>>
>>>>
>>>
>>> I don't really know how snapper works.
>>>
>>> The way 'btrfs subvolume snapshot' works,  you must point it to a
>>> subvolume. It won't snapshot a regular directory and from what you
>>> posted above, there are no subvolumes in /var or /var/lib which means
>>> trying to snapshot /var/lib/ceph/osd/ceph-....  would fail. So maybe
>>> it's failing but snapper doesn't show the error. I'm not really sure.
>>>
>>
>> In this case, his snapshots are all of the root.
>>
>> I don't know how Ceph works, but since we already confirmed that there
>> are no subvolumes under /var, the only other explanation is that
>> /var/lib/ceph/osd/ceph-<n> is a submount
>>
>> What is the the result of running:
>> mount | grep /var
>>
> 
> Yep.
> 
> 

Looking at Thomas' mail on the Ceph-users list:
http://lists.ceph.com/pipermail/ceph-users-ceph.com/2019-August/036679.html
I deduce he is using Ceph with the Bluestore backend, which indeed means that /var/lib/ceph/osd/ceph.<n>
are tmpfs mounts which are completeley ephemeral and are created from LVM metadata of the actual Ceph OSD disks. 

That would of course also explain why they are not part of any btrfs snapshot of / (and that also means there is no need to backup anything). 
