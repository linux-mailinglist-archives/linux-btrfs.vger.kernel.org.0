Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255653FD010
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Sep 2021 01:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238269AbhHaX5W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Aug 2021 19:57:22 -0400
Received: from eu-shark1.inbox.eu ([195.216.236.81]:45120 "EHLO
        eu-shark1.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbhHaX5W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Aug 2021 19:57:22 -0400
Received: from eu-shark1.inbox.eu (localhost [127.0.0.1])
        by eu-shark1-out.inbox.eu (Postfix) with ESMTP id 0E0F96C00827;
        Wed,  1 Sep 2021 02:56:25 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1630454185; bh=19GjFIWWPQXA85J0i1Mhf1gmAjKpXtZgS3wisL3JLlw=;
        h=References:From:To:Cc:Subject:Date:In-reply-to;
        b=GMYrnrWixX+b0CW8Ea/VbJm88a6amWVVohIuFxcGggYDXycBGRkV4cgfaj5HaNE9d
         hysKutKBZreP0uIQV7RQDe3s/qdXfEy7tEbLL2GSEHRIhKju0w5UR2mRZmb/YvEIX7
         Z4G1jPC44R/WdB96kEgdT70y62g2JLk0THTPn/bo=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id F3B156C00821;
        Wed,  1 Sep 2021 02:56:24 +0300 (EEST)
Received: from eu-shark1.inbox.eu ([127.0.0.1])
        by localhost (eu-shark1.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id eNdgy34L1jZI; Wed,  1 Sep 2021 02:56:24 +0300 (EEST)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id B3B876C00820;
        Wed,  1 Sep 2021 02:56:24 +0300 (EEST)
Received: from nas (unknown [49.65.73.48])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id D25C41BE00BA;
        Wed,  1 Sep 2021 02:56:22 +0300 (EEST)
References: <cover.1629780501.git.anand.jain@oracle.com>
 <34118c32-0d7f-426b-7596-4372315599ea@oracle.com>
 <1r69r830.fsf@damenly.su> <20210831154104.GL3379@suse.cz>
User-agent: mu4e 1.7.0; emacs 27.2
From:   Su Yue <l@damenly.su>
To:     dsterba@suse.cz
Cc:     Anand Jain <anand.jain@oracle.com>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH V5 0/4] btrf_show_devname related fixes
Date:   Wed, 01 Sep 2021 07:55:49 +0800
In-reply-to: <20210831154104.GL3379@suse.cz>
Message-ID: <wno1p3rx.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Virus-Scanned: OK
X-ESPOL: 6N1mkJY3ejOgg0CnRmXZBhgzpzY6IuClpKemo25U7wXmU1qJf04NURK/nm1yS2A=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Tue 31 Aug 2021 at 17:41, David Sterba <dsterba@suse.cz> wrote:

> On Tue, Aug 31, 2021 at 10:28:24PM +0800, Su Yue wrote:
>>
>> On Tue 31 Aug 2021 at 06:41, Anand Jain <anand.jain@oracle.com>
>> wrote:
>>
>> > Ping.
>> >
>> In the past week, I spent some time on testing this patchset 
>> and
>> the patch 'btrfs: fix lockdep warning while mounting sprout 
>> fs'.
>>
>> Same as you, I wonder if there is any race condition. Just 
>> wrote
>> some scripts including device removal, replace and sprout while
>> busy looping showing mount info. It runned well and passed
>> xfstests
>> in my two VMs. I'm not a pundit in btrfs device field so I 
>> can't
>> give my
>> RBs even these patches looks almost okay to me.
>
> So this could be a Tested-by if you want.

Sure. Thanks.

--
Su
