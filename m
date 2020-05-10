Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8C0F1CCAA1
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 May 2020 13:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgEJLw2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 10 May 2020 07:52:28 -0400
Received: from zaphod.cobb.me.uk ([213.138.97.131]:36282 "EHLO
        zaphod.cobb.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbgEJLw1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 May 2020 07:52:27 -0400
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 137599C3DC; Sun, 10 May 2020 12:52:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1589111541;
        bh=Z7P+RCQa9JQykNGP/wXeBRE0+DWQh4Bh1d0qrKVLKUg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FCn+xHrL0jOnp9R/lclHRqfCD3ecEtGE4HVaayAUppJ4t8B0kp3FOaOoTmNaQ+K1+
         3pYC2EEm9lWhUjHLAyhCBx6SdxOTGmkuValIaBFIw8BU3faEnzabkmaDrOs1lda4hy
         6pg469v7DO7zqXuVbCgfcnpfZEq4EL79LSUWeSlTVF/O20MtAa/90P9rUJdL/dm2zC
         rqYCaCBQQ+LC80JJy1Yl/5UN/WmaJsCtWxRMRBTnLWf85H3+bI8zzDqGGiWzvsRH2P
         FlmKkuRLGQKkiOA2ESkGh5kSl1AUd8b2G4jjZ07niKH4tB9+tL0GBO7XrpkrtnIjCf
         Iop3nLJHK/86Q==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-0.8 required=12.0 tests=ALL_TRUSTED,DKIM_INVALID,
        DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 085049B9D5;
        Sun, 10 May 2020 12:52:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1589111538;
        bh=Z7P+RCQa9JQykNGP/wXeBRE0+DWQh4Bh1d0qrKVLKUg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WcVCkqnFRYtrY3gKhMf+4SFL+evRBjYIdVkADrcgTWZhzTXhaN5whED8eEqsLCvAK
         ZVdTbieKPDxOh+PvFE/+xLnGxIRLx7QbGJOQJ7mBRL8b/KidYotOHodLtuzcEUU6aQ
         UprNCYGzocw5EHLMQ0mkffyaBbi63db0wx5vRyir+Si+odKbhkNYL8T+QNFVCW9Me0
         T+1IwFKFtC7W6jEQKpY5zdyfG+cLONv4GxayX7J8IURdWm/PkXGuSi+91oRrm/xen7
         Z2vh2XmnZOm+B+pvquGi1g9nJXr90Pat8MJ8G88xfgJrVozxRggVi7qOG8/zHb97v4
         E6OfgcM732QyQ==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id 891381020C5;
        Sun, 10 May 2020 12:52:17 +0100 (BST)
Subject: Re: btrfs-progs reports nonsense scrub status
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Andrew Pam <andrew@sericyb.com.au>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <0d1cceb6-9295-1bdf-c427-60ba9b1ef0b3@sericyb.com.au>
 <709e4c3f-15b3-3c8a-2b25-ea95f4958999@sericyb.com.au>
 <CAJCQCtTGygd22TYvsPS6RPydsAZoqQYDDV=K4w1yFgTn0+ba6A@mail.gmail.com>
 <8ceacc86-96b7-44d2-d48d-234c6c4b45de@sericyb.com.au>
 <CAJCQCtQ4xOdNH79XDQdy=ExkNHbpbYdMMHG1fTeN7SeA+dTo7w@mail.gmail.com>
 <8ab9f20d-eff0-93bf-a4a4-042473b4059e@sericyb.com.au>
 <CAJCQCtQvyncTMqATX2PkVkR1bRPaUvDUqCmj-bRJzfHEU2k4JQ@mail.gmail.com>
 <ff173eb0-b6e8-5365-43a8-8f67d0da6c96@sericyb.com.au>
 <CAJCQCtTdHQAkaagTvCO-0SguakQx9p5iKmNbvmNYyxsBCqQ6Vw@mail.gmail.com>
 <ac6be0fa-96a7-fe0b-20c7-d7082ff66905@sericyb.com.au>
 <c2b89240-38fd-7749-3f1a-8aeaec8470e0@cobb.uk.net>
 <ace72f18-724c-9f2c-082f-cb478b8a63ef@sericyb.com.au>
 <CAJCQCtSq7Ocar4hJM0Z+Y7UeRM6Cfi_uwN=QM77F2Eg+MtnNWw@mail.gmail.com>
 <04f481fd-b8e5-7df6-d547-ece9ab6b8154@sericyb.com.au>
 <CAJCQCtTdSSX15Y7YX7fAg+iKncZf09ZG6KnHmmo4S77OtGWWXw@mail.gmail.com>
 <CAJCQCtTcwGm8WF+AKX4CBBRQ2vYjj-ZPx66So3Qxvp8Y9j5rJg@mail.gmail.com>
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Openpgp: preference=signencrypt
Autocrypt: addr=g.btrfs@cobb.uk.net; prefer-encrypt=mutual; keydata=
 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 myxb
Message-ID: <e2a308d2-690d-e6dd-8166-c56765aef54e@cobb.uk.net>
Date:   Sun, 10 May 2020 12:52:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtTcwGm8WF+AKX4CBBRQ2vYjj-ZPx66So3Qxvp8Y9j5rJg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/05/2020 02:14, Chris Murphy wrote:
> I don't know how the kernel and user space communicate scrub progress.
> I don't see anything in sysfs.

I did some work on btrfs-scrub a while ago to fix a bug in the way
last_physical was being saved between cancel and restore.

If I remember correctly, the way this works is that the scrub process
receives stats about the scrub progress directly from the kernel on a
socket it creates in /var/lib/btrfs, then writes updated stats into a
file in /var/lib/btrfs/scrub.status.<UUID> to share with scrub status
and keep a record. At the end of the scrub, the final stats are provided
by the kernel into a buffer provided in the ioctl which are also then
used to update the scrub.status file.

I don't remember how often the stats are received from the kernel but it
is frequently (not just at the end).

Unless I am confused, if the bytes scrubbed numbers are going up, then
the progress updates are being received from the kernel. The update
includes the last_finished so there should be no way the scrub process
can receive updated bytes scrubbed numbers without updated last_finished
from the kernel.

HOWEVER, I think (I may be wrong) btrfs scrub status normally reads the
stats from the file, not directly from the kernel. So it is actually
reporting the data in the file written by scrub process. That does
processing on the numbers (that was where the bug was which I found). It
is possible there is still a bug in that processing -- if so it is
possible that last_finished in the file could be zero even though it was
received as non-zero from the kernel. So, we can't be sure, without
adding logging to the scrub command, whether the kernel is really
reporting zero.

This is from memory. Sorry, I don't have time, at the moment, to go back
to the scrub usermode code to check.
