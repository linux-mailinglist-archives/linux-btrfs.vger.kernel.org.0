Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD0640B298
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Sep 2021 17:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbhINPLV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Sep 2021 11:11:21 -0400
Received: from eu-shark1.inbox.eu ([195.216.236.81]:56004 "EHLO
        eu-shark1.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbhINPLU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Sep 2021 11:11:20 -0400
Received: from eu-shark1.inbox.eu (localhost [127.0.0.1])
        by eu-shark1-out.inbox.eu (Postfix) with ESMTP id 1465E6C0088C;
        Tue, 14 Sep 2021 18:10:02 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1631632202; bh=gxE/c+cAUf2Dwlz900rsXwyeKCiOwmLoVl0RTtZxdmQ=;
        h=References:From:To:Cc:Subject:Date:In-reply-to;
        b=h8OheuUtk0e9K+02xb4EnmZiw4Mxkzs+UMY0MukP+tdeW2vUZJodoU9ocIam2KNoM
         uyfGdiNRAqMrYJvvuhWRY+t41A1v2nsQ8PiIUL8HJ9frf/Q7e8dAiKn5OcytJSwcVe
         bhxSGTNMWi9xnNkMK0gc3YqUcPY64h7/zMe+BtsM=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 062C16C00889;
        Tue, 14 Sep 2021 18:10:02 +0300 (EEST)
Received: from eu-shark1.inbox.eu ([127.0.0.1])
        by localhost (eu-shark1.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id HWMzFBWcxemo; Tue, 14 Sep 2021 18:10:01 +0300 (EEST)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id AE9436C00875;
        Tue, 14 Sep 2021 18:10:01 +0300 (EEST)
Received: from nas (unknown [117.89.173.253])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 3AED21BE00DC;
        Tue, 14 Sep 2021 18:09:59 +0300 (EEST)
References: <20210914105335.28760-1-l@damenly.su>
 <20210914131253.GA9286@twin.jikos.cz> <mtof1bt2.fsf@damenly.su>
 <20210914143600.GB9286@suse.cz>
User-agent: mu4e 1.7.0; emacs 27.2
From:   Su Yue <l@damenly.su>
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: make btrfs_node_key static inline
Date:   Tue, 14 Sep 2021 22:55:03 +0800
In-reply-to: <20210914143600.GB9286@suse.cz>
Message-ID: <35q719do.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Virus-Scanned: OK
X-ESPOL: +dBm1NUOBlzXh1y9OhvTBAcwsSJAQuzi+Pm41R5F/g/3MCiEf0oFUxGzm3AFPnHLwCM=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Tue 14 Sep 2021 at 16:36, David Sterba <dsterba@suse.cz> wrote:

> On Tue, Sep 14, 2021 at 10:08:36PM +0800, Su Yue wrote:
>>
>> On Tue 14 Sep 2021 at 15:12, David Sterba <dsterba@suse.cz> 
>> wrote:
>>
>> > On Tue, Sep 14, 2021 at 06:53:35PM +0800, Su Yue wrote:
>> >> It looks strange that btrfs_node_key is in struct-funcs.c.
>> >> So move it to ctree.h and make it static inline.
>> >
>> > "looks strange" is not a sufficient reason. Inlining a 
>> > function
>> > means
>> > that the body will be expanded at each call site, bloating 
>> > the
>> > binary
>> > code. Have you measured the impact of that?
>> >
>> Fair enough.
>>
>> Before:
>>    text    data     bss     dec     hex filename
>> 1202418  123105   19384 1344907  14858b fs/btrfs/btrfs.ko
>> After:
>>    text    data     bss     dec     hex filename
>> 1202620  123105   19384 1345109  148655 fs/btrfs/btrfs.ko
>>
>> +202
>>
>> > There's some performance cost of an non-inline function due 
>> > to
>> > the call
>> > overhead but it does not make sense to inline a function 
>> > that's
>> > called
>> > rarely and not in a tight loop. If you grep for the function
>> > you'd see
>> > that it's called eg. once per function or in a loop that's 
>> > not
>> > performance critical on first sight (eg. in 
>> > reada_for_search).
>>
>> Right, the patch won't impact performance obviously at the cost 
>> of
>> +202 binary size. So I'd drop the patch.
>
> It does increase the size a bit but from what I've seen in the 
> assembly
> it's not that bad and still probably worth doing the inline. 
> There's one
> more extra call to read_extent_buffer (hidden behind 
> read_eb_member
> macro).
>
Thanks for taking a look. I just noticed the lonely function then 
post
the patch without deeper thinking.

> Cleaning up the node key helpers would be useful too, adding 
> some
> more helpers and not calling read_eb_member in the end. I have a 
> WIP
> patchset for that but had to leave it as there were bugs I did 
> not find.
> I can bounce it to you if you're interested.

Thanks a lot. But I can't take it due to some reasons. Since you 
have
a better WIP patchset, I don't mind forgoing the patch.

--
Su
