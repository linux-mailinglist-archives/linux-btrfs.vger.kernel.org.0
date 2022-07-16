Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4820F577180
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Jul 2022 23:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiGPVJc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 16 Jul 2022 17:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGPVJb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 16 Jul 2022 17:09:31 -0400
Received: from ste-pvt-msa2.bahnhof.se (ste-pvt-msa2.bahnhof.se [213.80.101.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A270A17AA6
        for <linux-btrfs@vger.kernel.org>; Sat, 16 Jul 2022 14:09:29 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 488773F36F;
        Sat, 16 Jul 2022 23:09:27 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -1.91
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cnsqv0dmstEY; Sat, 16 Jul 2022 23:09:22 +0200 (CEST)
Received: by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 8A55E3F351;
        Sat, 16 Jul 2022 23:09:22 +0200 (CEST)
Received: from [192.168.0.119] (port=38256)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1oCp2O-000Mwd-LD; Sat, 16 Jul 2022 23:09:21 +0200
Date:   Sat, 16 Jul 2022 23:09:19 +0200 (GMT+02:00)
From:   Forza <forza@tnonline.net>
To:     "David C. Partridge" <david.partridge@perdrix.co.uk>,
        linux-btrfs@vger.kernel.org
Message-ID: <be35d86.ae31e4f5.18208d825f0@tnonline.net>
In-Reply-To: <004c01d8994d$f5677800$e0366800$@perdrix.co.uk>
References: <004c01d8994d$f5677800$e0366800$@perdrix.co.uk>
Subject: Re: Oh dear - some new problems
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
X-Mailer: R2Mail2
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



---- From: "David C. Partridge" <david.partridge@perdrix.co.uk> -- Sent: 2022-07-16 - 21:55 ----

> I get an error log from a weekly btrfs scrub:
> 
> Scrub started:    Sat Jul 16 07:45:26 2022
> Status:           finished
> Duration:         6:12:24
> Total to scrub:   9.99TiB
> Rate:             455.57MiB/s
> Error summary:    csum=36
>   Corrected:      0
>   Uncorrectable:  36
>   Unverified:     0
> 
> Have now run the scrub again and it's showing errors even though it isn't
> yet complete.
> 
> Please see attached journalctl log file
> 
> The raid array detected an error on one of the drives which I have now
> replaced and the raid is now rebuilding ...

What kind of raid device are you using? 

> 
> What should I do at this juncture.

The errors are uncorrectable because Btrfs doesn't have a good copy to repair from. You have to replace the damaged files. Since they are torrents it should not be too bad since the torrent protocol can repair/re-download individual blocks in files. 


> 
> Thanks, David
> 


