Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3173F3B1A
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Aug 2021 17:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbhHUPCH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 21 Aug 2021 11:02:07 -0400
Received: from eu-shark1.inbox.eu ([195.216.236.81]:35138 "EHLO
        eu-shark1.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbhHUPCG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 21 Aug 2021 11:02:06 -0400
Received: from eu-shark1.inbox.eu (localhost [127.0.0.1])
        by eu-shark1-out.inbox.eu (Postfix) with ESMTP id 45BEF6C007C5;
        Sat, 21 Aug 2021 18:01:26 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1629558086; bh=Fqy8VaU1h8h3R7Cjm7WVRIbTLj78xD7EOp+64BU8lVo=;
        h=References:From:To:Cc:Subject:Date:In-reply-to;
        b=rKvZ9Zqu1HjweENT6JgQ5SOWjIBiJmcwt7llsfVrOZNw99dq/WE05h0s4vhgbO1Tk
         18sHl/w3tEwSq+LBt/mvk+dqWbQ6Nd0pokbEBlCw4DQT3sIg5/yTuMAQn44YmXvsJb
         JqL/ydw4VBG8cyUWBc3nmy8up4lalpfR9M16F+s8=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 341256C007C1;
        Sat, 21 Aug 2021 18:01:26 +0300 (EEST)
Received: from eu-shark1.inbox.eu ([127.0.0.1])
        by localhost (eu-shark1.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id 93hsG86gFv-s; Sat, 21 Aug 2021 18:01:26 +0300 (EEST)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id EEBBE6C007BB;
        Sat, 21 Aug 2021 18:01:25 +0300 (EEST)
Received: from nas (unknown [49.65.73.48])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 830871BE009C;
        Sat, 21 Aug 2021 18:01:24 +0300 (EEST)
References: <cover.1629396187.git.anand.jain@oracle.com>
 <8b8e72c87d0ee97da1b2e243a24b68d84d0ac3b9.1629396187.git.anand.jain@oracle.com>
 <y28weeg4.fsf@damenly.su>
 <4b891418-b8d1-6e3f-ae71-b1dface98ae2@oracle.com>
 <sfz2etf4.fsf@damenly.su>
User-agent: mu4e 1.5.8; emacs 27.2
From:   Su Yue <l@damenly.su>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH RFC 2/3] btrfs: consolidate device_list_mutex in
 prepare_sprout to its parent
Date:   Sat, 21 Aug 2021 23:00:20 +0800
In-reply-to: <sfz2etf4.fsf@damenly.su>
Message-ID: <pmu6eta9.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Virus-Scanned: OK
X-ESPOL: 6N1ml5Y9aTPX9ELDN3bfAwY2rSJKXenj55TE3V0G3GeDUSOAd1YLVQ6wnnJyRWA=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Sat 21 Aug 2021 at 22:57, Su Yue <l@damenly.su> wrote:

> On Fri 20 Aug 2021 at 16:53, Anand Jain <anand.jain@oracle.com>
> wrote:
>
>>>> @@ -2366,6 +2366,8 @@ static int btrfs_prepare_sprout(struct
>>>> btrfs_fs_info *fs_info)
>>>>      u64 super_flags;
>>>>
>>>>      lockdep_assert_held(&uuid_mutex);
>>>> +    lockdep_assert_held(&fs_devices->device_list_mutex);
>>>> +
>>>>
>>> Just a reminder: clone_fs_devices() still takes the mutex in
>>> misc-next.
>>    As I am checking clone_fs_devices() does not take any lock.
>>   Could you pls recheck?
>>
>
> Hmmmm... misc-next:
>
> https://github.com/kdave/btrfs-devel/blob/e05983195f31374ad51a0f3712efec381397f3cb/fs/btrfs/volumes.c#L381

Sorry, it should be

https://github.com/kdave/btrfs-devel/blob/misc-next/fs/btrfs/volumes.c#L995

--
Su
