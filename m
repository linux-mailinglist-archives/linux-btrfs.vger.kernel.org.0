Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8C0E34D7F3
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Mar 2021 21:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbhC2TO3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Mar 2021 15:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbhC2TOJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Mar 2021 15:14:09 -0400
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CC5C061574
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Mar 2021 12:14:09 -0700 (PDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4F8Mh02JZpz1s15Q;
        Mon, 29 Mar 2021 21:14:08 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4F8Mh01xPbz1r1MR;
        Mon, 29 Mar 2021 21:14:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id MlJhXIUAMTCn; Mon, 29 Mar 2021 21:14:06 +0200 (CEST)
X-Auth-Info: igctTucZFbplj0RaQelaakRDbxByvuV/onfFoE1twPs=
Received: from [10.88.0.186] (dslb-084-056-254-233.084.056.pools.vodafone-ip.de [84.56.254.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 29 Mar 2021 21:14:06 +0200 (CEST)
Subject: Re: btrfs-send format that contains binary diffs
To:     Andrei Borzenkov <arvidjaar@gmail.com>, linux-btrfs@vger.kernel.org
Cc:     Henning Schild <henning.schild@siemens.com>
References: <f3306b7c-a97a-21f2-0f66-dc94dc2c0272@denx.de>
 <db6fae67-6348-1de3-c953-a4c75c459b65@gmail.com>
From:   Claudius Heine <ch@denx.de>
Organization: Denx Software Engineering
Message-ID: <5ba46b04-f3ba-03ef-6ad5-38fd44f8c67e@denx.de>
Date:   Mon, 29 Mar 2021 21:14:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <db6fae67-6348-1de3-c953-a4c75c459b65@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Andrei,

On 2021-03-29 18:30, Andrei Borzenkov wrote:
> On 29.03.2021 16:16, Claudius Heine wrote:
>> Hi,
>>
>> I am currently investigating the possibility to use `btrfs-stream` files
>> (generated by `btrfs send`) for deploying a image based update to
>> systems (probably embedded ones).
>>
>> One of the issues I encountered here is that btrfs-send does not use any
>> diff algorithm on files that have changed from one snapshot to the next.
>>
> 
> btrfs send works on block level. It sends blocks that differ between two
> snapshots.

Are you sure?

I did a test with a 32MiB random file. I created one snapshot, then 
changed (not deleted or added) one byte in that file and then created a 
snapshot again. `btrfs send` created a >32MiB `btrfs-stream` file. If it 
would be only block based, then I would have expected that it would just 
contain the changed block, not the whole file. And if I use a smaller 
file on the same file system, then the `btrfs-stream` is smaller as well.

I looked into those `btrfs-stream` files using [1] and also [2] as well 
as the code. While I haven't understood everything there yet, it 
currently looks to me like it is file based.

> 
>> One way to implement this would be to add some sort of 'patch' command
>> to the `btrfs-stream` format.
>>
> 
> This would require reading complete content of both snapshots instead if
> just computing block diff using metadata. Unless I misunderstand what
> you mean.
I think I should only need access to the old snapshot as well as the 
`btrfs-stream` file. But I currently don't have a complete PoC of this 
ready.

regards,
Claudius

[1] https://github.com/sysnux/btrfs-snapshots-diff
[2] https://btrfs.wiki.kernel.org/index.php/Design_notes_on_Send/Receive
