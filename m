Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 775051754AC
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2020 08:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgCBHjW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Mar 2020 02:39:22 -0500
Received: from mail.virtall.com ([46.4.129.203]:45290 "EHLO mail.virtall.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgCBHjW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Mar 2020 02:39:22 -0500
Received: from mail.virtall.com (localhost [127.0.0.1])
        by mail.virtall.com (Postfix) with ESMTP id 4F3DB3F6FDE0;
        Mon,  2 Mar 2020 07:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wpkg.org; s=default;
        t=1583134761; bh=x9Yj/lrrjJiEQOlx2LI5NEp4dLxxxz8qvMMVNo8Yyr4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=PbVOhFJ1HxBOqY/OnAN2GV18T8De3pA2jtSIkRt+4tPkn+kTRrqvVmKt/M4K3pOvV
         6LMzvRy8gKR9CQXGqz0qd3u0BJdPOQbn7nLppSZyiV2NnR19/QxBCQHqs7VZ7hDikC
         F4dvYq2cAjfjl47jNm7gkDkq77UGo6G5WS/1f7qukfFeXjeyTglHxY9PmADT12VNvG
         O88VaxGpJPVUr62solZZg94J9sABOw8gGKbKNsVjs+kb4b1ray9c/ZQ9aSge0JD5OK
         qUyhhfaEEji+gPgy3PK6NVz68vOEwSTro3RBZW7Fl+A1OoAzh2YJNEPDXMDejvE2Sm
         LtEn5WQ1LHudA==
X-Fuglu-Suspect: 5e09132893cb4360a497d5c68d91309c
X-Fuglu-Spamstatus: NO
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.virtall.com
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: tch@virtall.com)
        by mail.virtall.com (Postfix) with ESMTPSA;
        Mon,  2 Mar 2020 07:39:20 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 02 Mar 2020 16:39:17 +0900
From:   Tomasz Chmielewski <mangoo@wpkg.org>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: balance conversion from RAID-1 to RAID-10 leaves some metadata in
 RAID-1?
In-Reply-To: <CAJCQCtTq_ccnhV9BPU3CA08=m6LDtSxgyve_GUckpPB2HKC1fw@mail.gmail.com>
References: <56ef4bcdd854a9dde3cbe2f5760592ed@wpkg.org>
 <CAJCQCtTq_ccnhV9BPU3CA08=m6LDtSxgyve_GUckpPB2HKC1fw@mail.gmail.com>
Message-ID: <fdcfef7036565db2d2fb26d715dce0c1@wpkg.org>
X-Sender: mangoo@wpkg.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2020-03-02 15:29, Chris Murphy wrote:
> On Sun, Mar 1, 2020 at 3:41 AM Tomasz Chmielewski <mangoo@wpkg.org> 
> wrote:
>> 
>> To my surprise, some metadata is still RAID-1 - is it expected?
> 
> I'd say it's not expected but also balance is pretty complicated. Try
> 
> 'btrfs balance start -dconvert=raid10,soft /mountpoint/'
> 
> What does dmesg report for that command? And are those raid1 bg's
> converted to raid10? I don't think it should matter in this case, but
> what's the btrfs-progs version?

I did one more balance, for metadata only:

btrfs balance start -dconvert=raid10 /mountpoint/

And it fully converted the remaining RAID-1 metadata to RAID-10.

Still, a bit "weird".

btrfs-progs is 5.4.1.


Tomasz Chmielewski
https://lxadm.com
