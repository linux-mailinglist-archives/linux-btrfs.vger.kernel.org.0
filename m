Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9564CAC92C
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Sep 2019 22:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405150AbfIGU0D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 7 Sep 2019 16:26:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49032 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727309AbfIGU0D (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 7 Sep 2019 16:26:03 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B2968308FC4E;
        Sat,  7 Sep 2019 20:26:02 +0000 (UTC)
Received: from localhost.localdomain (ovpn-121-49.rdu2.redhat.com [10.10.121.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EAB4B10018FF;
        Sat,  7 Sep 2019 20:26:01 +0000 (UTC)
Subject: Re: LTP fs_fill test results in BTRFS warning (device loop0): could
 not allocate space for a delete; will truncate on mount warnings
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Jan Stancek <jstancek@redhat.com>
References: <4d97a9bb-864a-edd1-1aff-bdc9c8204100@redhat.com>
 <CAJCQCtSm0rv=-zoAReP7+kjdvV1ihgi7tx1sh9YM=on_fZLKNg@mail.gmail.com>
 <CAJCQCtS0=-9RouGbn-hWKJrUT56mJT=3ij5_wC5jujLwrS95=g@mail.gmail.com>
From:   Rachel Sibley <rasibley@redhat.com>
Message-ID: <4adcb8d3-3212-7dd8-75a7-d9f1a17deb0c@redhat.com>
Date:   Sat, 7 Sep 2019 16:26:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtS0=-9RouGbn-hWKJrUT56mJT=3ij5_wC5jujLwrS95=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Sat, 07 Sep 2019 20:26:02 +0000 (UTC)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 9/6/19 5:56 PM, Chris Murphy wrote:
> On Fri, Sep 6, 2019 at 3:35 PM Chris Murphy <lists@colorremedies.com> wrote:
>> On Fri, Sep 6, 2019 at 1:21 PM Rachel Sibley <rasibley@redhat.com> wrote:
>>> Hello,
>>>
>>> While running LTP [1] as part of CKI [2] testing, we noticed the fs_fill
>>> test fails pretty
>>> consistently with BTRFS warnings seen below, this is seen with recent
>>> kernel (5.2.12).
>>> I have included the logs below for reference.
>> I'm only 6 for 6, but  so far can't get it to trigger with 5.3.0-rc7
> Also cannot reproduce, 10 for 10 with 5.2.13-200.fc30.x86_64 which was
> just built in koji, same as 5.2.12 which was quickly replaced with a
> single unrelated revert for touchpads.
>
> But comparing fs_fill logs, yours has a ton more writer threads (~6x)
> and ENOSPC counts. Possibly related?
It could be related to the higher thread/ENOSPC counts, I tried to 
manually reproduce
right now and was unsuccessful, I'll see if I can get a reproducible 
scenario. I'm traveling
the next few weeks but will review results when I get back.

Thanks for looking into it!
Rachel
>

