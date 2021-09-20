Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 162ED412A9D
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Sep 2021 03:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbhIUBol (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Sep 2021 21:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbhIUBjQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Sep 2021 21:39:16 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B139C01AE6D
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Sep 2021 12:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dirtcellar.net; s=ds202012; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Reply-To:
        Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LLjpqaKG1MQR1WAc2WRBF2GC/MlR+KsMHS3g+Qb6oAM=; b=QvEvC2gJ3U1BCeczTZoJY718Ii
        zlOPNNGSaBeLocYIPGOLN6NLCEs4INDY9K78uXIpRhmw//hMVwBHyXN12cy4MRRRMpdViT1tkscHv
        93MP8zNdFNrtCuFmABsxeD0GTIQswwogq8Aos1YC9jbU98O0R2bgMWvTwdrZl5PYg3nlVsaiSAhTw
        Fb5mNo5vBVAedw5ZnZkPTaOyGnN9eiNq0Ry1Ybd4xRo0j5fUxToPzN5sTcxhL1wq7/5+zE5ydaKNx
        7rCWSIjr6Em+RkBUYdZfDQMLLApjlYF7IzffjtHgLMp3y9YzIyIrb20NA6FS4ctJ4YDCoWaHZUu1Z
        FwTa3mOA==;
Received: from 254.79-160-170.customer.lyse.net ([79.160.170.254]:61827 helo=[10.0.0.10])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <waxhead@dirtcellar.net>)
        id 1mSPBI-0000Yz-Gq; Mon, 20 Sep 2021 21:42:24 +0200
Reply-To: waxhead@dirtcellar.net
Subject: Re: bug: btrfs device stats not showing raid1 errors
To:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtRbktnZ5NxRTZL9UKvTr1TaFtkCbeCS2pVnf2SPg8O3-w@mail.gmail.com>
From:   waxhead <waxhead@dirtcellar.net>
Message-ID: <14eec475-dae4-b1cf-00d7-bb8546806568@dirtcellar.net>
Date:   Mon, 20 Sep 2021 21:42:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 SeaMonkey/2.53.9
MIME-Version: 1.0
In-Reply-To: <CAJCQCtRbktnZ5NxRTZL9UKvTr1TaFtkCbeCS2pVnf2SPg8O3-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Chris Murphy wrote:
> https://bugzilla.redhat.com/show_bug.cgi?id=2005987
> 
> Various kernel messages like this:
> 
> [2634355.709564] BTRFS info (device sda3): read error corrected: ino
> 27902168 off 8773632 (dev /dev/sda3 sector 52960104)
> [2634355.733898] BTRFS info (device sda3): read error corrected: ino
> 27902168 off 8749056 (dev /dev/sda3 sector 52960056)
> 
> And yet 'btrfs dev stats' does not show an increment in tracked
> statistics, in particular read_io_errs
> 
This is extremely confusing for me as well and I am just a BTRFS user...
I am an BTRFS "enthusiast" if there is such a thing , and if this seems 
wrong (regardless if it is wrong or not) imagine the frustration and 
confusion for those not that into filesystems.

> This does seem like suboptimal behavior.  Discussed a bit on IRC today
> and Zygo found the behavior is introduced with commit 0cc068e6ee59
> btrfs: don't report readahead errors and don't update statistics
> 
> Zygo on IRC writes:
> readahead errors are things like "out of memory" or device-mapper nonsense
> so the best is 'don't correct and don't count'
> since there's probably nothing wrong with the underlying media
> but if there is something wrong with the underlying media, we want a
> proper read, correct, and count to happen
> which means we can safely do nothing during readahead
> so the right answer is don't correct and don't count
> ---
> 
> I'm not sure how noisy it could be to always report such read errors
> discovered during read ahead, but my gut instinct is that anytime
> there's a read error whether physical or virtual, we probably want to
> know about this? If these are bogus errors then that suggests (a) do
> not increment the dev stats counter, and also (b) do not fix up.
> 
...And in case someone clears this up. Please consider a table output 
option like btrfs fi us -T /mnt ... e.g. btrfs de st -T /mnt that output 
something like

Device stat ErrWrite ErrRead ErrFlush ErrCorrupt ErrGen
----------- -------- ------- -------- ---------- ------
/dev/sdb1          0       1        2          0      3
/dev/sdt1          0       2        3          0      4
/dev/sdr1          0       3        4          0      6
/dev/sdf1          0       4        5          0      7
/dev/sds1          0       5        6          0      8

instead or in addition to...

[/dev/sdb1].write_io_errs    0
[/dev/sdb1].read_io_errs     0
[/dev/sdb1].flush_io_errs    0
[/dev/sdb1].corruption_errs  0
[/dev/sdb1].generation_errs  0
[/dev/sdt1].write_io_errs    0
[/dev/sdt1].read_io_errs     0
[/dev/sdt1].flush_io_errs    0
[/dev/sdt1].corruption_errs  0
[/dev/sdt1].generation_errs  0
...etc...

The current list that duplicates stuff takes up an awful lot of space if 
you have plenty of storage devices. I have 18 harddrives in a BTRFS pool 
and the btrfs de st list is annoyingly long...

A table would be nice , or simply SKIP printing the lines where the stat 
counter==0 as this simply is not needed.

