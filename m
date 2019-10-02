Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACCBFC4B38
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2019 12:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbfJBKSP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Oct 2019 06:18:15 -0400
Received: from mail.render-wahnsinn.de ([176.9.37.177]:40260 "EHLO
        mail.render-wahnsinn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbfJBKSP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Oct 2019 06:18:15 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with robert.krig@render-wahnsinn.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=render-wahnsinn.de;
        s=dkim; t=1570011482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JfhWWy02c3jNL8Bxju2e3KyoJiQj3qjnK7KxNFHutGs=;
        b=APrz8KNAsOWrmHKJZIePwVsMEuW2jSfDAd3Y86BdJgaR/K/jYYdg9lToxk/+3nNXBAVVkh
        wF5iYWaB8kmAdIjkuD/habBw8rsXdUETT1m5uDapYydguqfODrQmqn1Xeg90nX8RUp313M
        0/0xwAZFMrhe6sNYdrXIQx94qlqFIFBUitAvOiaExIsPSJiINdS+fAoAJPFF9g8+NphyZS
        T1LDXRwSqoZxIIvzof1Wjt48DQ6fXHiKtmzMl8q5jBzb+LKQzcvIn5cRR3ooiP5qAcv9lD
        Afcwg1+8C2fgTR8ef3E7wcOCfQgQ/pfo9BrOS+Oms2ra6t9KbQRPFxKgoEkXYw==
Message-ID: <273d41c4d05283aaa658d9c374e7c43199b0aac3.camel@render-wahnsinn.de>
Subject: Re: BTRFS Raid5 error during Scrub.
From:   Robert Krig <robert.krig@render-wahnsinn.de>
To:     Linux Btrfs <linux-btrfs@vger.kernel.org>
Date:   Wed, 02 Oct 2019 12:17:56 +0200
In-Reply-To: <CAJCQCtQcKRN09wpbSmguNQ8bSq5VZEk2JNwLOWcsAK7YYJD2YA@mail.gmail.com>
References: <804e7e93a00dfe954222e4f8dc820a075d9ccb79.camel@render-wahnsinn.de>
         <0fdd1282-f370-b55e-0c3f-486ad8673bcd@suse.com>
         <3616237f8d39c87abcc9b118b8441cfecf36eeb6.camel@render-wahnsinn.de>
         <CAJCQCtQcKRN09wpbSmguNQ8bSq5VZEk2JNwLOWcsAK7YYJD2YA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
        d=render-wahnsinn.de; s=dkim; t=1570011485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JfhWWy02c3jNL8Bxju2e3KyoJiQj3qjnK7KxNFHutGs=;
        b=lUJfO/b9U1ySIFMX1tdGOOnHYkkWhJ/kL7MMWo8pZsykefAqV7IivW13rpa6FT/oWZvDYB
        JWrSb6a0gaXuBAfZaIGsRREK8FuCTTyJIbmHxJXVcjeGvrJNjjWkOY78TCDR7YwWnVqtJs
        ptuxui6jFGqi/pI5fYQZPvMeJO3Iq8oEI5LF9I/1aoFsUVNy5qEk+7K0Iz82YmmrrYA6cy
        DqaGS3qpzI8R8W5kjlgdfUf/zLOyV28G1krbp8vn5EBMcKZroq/1Lf8IV+J0dd4ILvBnN7
        +lEcx5p0NDOC2i7rxyv+C99ZXABSLBMSftEbJVffC7iubci+mIEWXrVYCOqYWg==
ARC-Seal: i=1; s=dkim; d=render-wahnsinn.de; t=1570011485; a=rsa-sha256;
        cv=none;
        b=nOZuoA/f7PE7xPBEaKtAcmgMlTt5us0Jy/EXb6Qz0wvNUBsfZLNxg2X0YIAAFl2b21D676
        hzRU7ixDr7gytCkqgpNbHqzrFbc65KcYL1DUgNfN5PgunXdT9lDg6PgyuIVd7nEfQgARoM
        J4Pftj8SsMyaXL4lH/Y9Rf6sBeEgsdZ7rN3GVFffh+zttg0AI/GgJb7W4JLDW9JfNc68ku
        NRZ7kLXJiRarq9k+esiYUIu9YT8uRoXnyqgtIeyVQsnRJw1PFXBcPXZKwY72Ek/yCfLL14
        f9F6DlP5h+u51hQ53MDHVnDT6RbJPwVygATtMC0Imxrydywk6ApRXsael4Sueg==
ARC-Authentication-Results: i=1;
        mail.render-wahnsinn.de;
        auth=pass smtp.mailfrom=robert.krig@render-wahnsinn.de
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Here's the output of btrfs insp dump-t -b 48781340082176 /dev/sda

Since /dev/sda is just one device from my RAID5, I'm guessing the
command doesn't need to be run separately for each device member of my
BTRFS Raid5 setup.

http://paste.debian.net/1103596/


Am Dienstag, den 01.10.2019, 12:10 -0600 schrieb Chris Murphy:
> On Mon, Sep 30, 2019 at 3:37 AM Robert Krig
> <robert.krig@render-wahnsinn.de> wrote:
> > I've upgraded to btrfs-progs v5.2.1
> > Here is the output from btrfs check -p --readonly /dev/sda
> > 
> > 
> > Opening filesystem to check...
> > Checking filesystem on /dev/sda
> > UUID: f7573191-664f-4540-a830-71ad654d9301
> > [1/7] checking root items                      (0:01:17 elapsed,
> > 5138533 items checked)
> > parent transid verify failed on 48781340082176 wanted 109181 found
> > 109008items checked)
> > parent transid verify failed on 48781340082176 wanted 109181 found
> > 109008
> > parent transid verify failed on 48781340082176 wanted 109181 found
> > 109008
> > Ignoring transid failure
> > leaf parent key incorrect 48781340082176
> > bad block 48781340082176
> > [2/7] checking extents                         (0:03:22 elapsed,
> > 1143429 items checked)
> > ERROR: errors found in extent allocation tree or chunk allocation
> > [3/7] checking free space cache                (0:05:10 elapsed,
> > 7236
> > items checked)
> > parent transid verify failed on 48781340082176 wanted 109181 found
> > 109008ems checked)
> > Ignoring transid failure
> > root 15197 inode 81781 errors 1000, some csum missing48 elapsed,
> > 33952
> > items checked)
> > [4/7] checking fs roots                        (0:42:53 elapsed,
> > 34145
> > items checked)
> > ERROR: errors found in fs roots
> > found 22975533985792 bytes used, error(s) found
> > total csum bytes: 16806711120
> > total tree bytes: 18733842432
> > total fs tree bytes: 130121728
> > total extent tree bytes: 466305024
> > btree space waste bytes: 1100711497
> > file data blocks allocated: 3891333279744
> >  referenced 1669470507008
> 
> What do you get for
> # btrfs insp dump-t -b 48781340082176 /dev/
> 
> It's possible there will be filenames, it's OK to sanitize them by
> just deleting the names from the output before posting it.
> 
> 
> 

