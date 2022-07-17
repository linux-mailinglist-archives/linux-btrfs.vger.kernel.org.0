Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA085577286
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Jul 2022 02:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiGQAEh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 16 Jul 2022 20:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiGQAEg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 16 Jul 2022 20:04:36 -0400
Received: from avasout-ptp-003.plus.net (avasout-ptp-003.plus.net [84.93.230.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485D29583
        for <linux-btrfs@vger.kernel.org>; Sat, 16 Jul 2022 17:04:34 -0700 (PDT)
Received: from APOLLO ([212.159.61.44])
        by smtp with ESMTPA
        id CrlooCuEAGjO8CrlpozAlr; Sun, 17 Jul 2022 01:04:31 +0100
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=HttlpmfS c=1 sm=1 tr=0 ts=62d3520f
 a=AGp1duJPimIJhwGXxSk9fg==:117 a=AGp1duJPimIJhwGXxSk9fg==:17
 a=kj9zAlcOel0A:10 a=O-dTtCbMAAAA:8 a=P1kZ4gAsAAAA:8 a=VwQbUJbxAAAA:8
 a=A4Ad5zX8oVWg5oTyvsEA:9 a=CjuIK1q_8ugA:10 a=p5snsyuY6O_wh2DS_HCF:22
 a=fn9vMg-Z9CMH7MoVPInU:22 a=AjGcO6oz07-iQ99wixmX:22
X-AUTH: perdrix52@:2500
From:   "David C. Partridge" <david.partridge@perdrix.co.uk>
To:     "'Forza'" <forza@tnonline.net>, <linux-btrfs@vger.kernel.org>
References: <004c01d8994d$f5677800$e0366800$@perdrix.co.uk> <be35d86.ae31e4f5.18208d825f0@tnonline.net>
In-Reply-To: <be35d86.ae31e4f5.18208d825f0@tnonline.net>
Subject: RE: Oh dear - some new problems
Date:   Sun, 17 Jul 2022 01:04:24 +0100
Message-ID: <001701d89970$ca0965b0$5e1c3110$@perdrix.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH/1A1EjAIfI5rk0EkkKTArGSpYeAGNjxJRrSbLh7A=
Content-Language: en-gb
X-CMAE-Envelope: MS4xfJxlx5DgA1322u1hYPEQ+HxkPcqr55QYbF8iIT8OdUeOF3+eBZRbhKnBKSUvwS9x5rF670PJnQjpeadj79rZAuA/Rrql574aTOKbGKlP40vb9CoVQTe5
 efdJTdUBRJK8zQImIi0EKMDzJsB8hpO7T/qytwgcQRssJ9TK+osZZiWGGyKVbwyuFBDekvrS3X8MRwjTh5uqolfl668raQU0M/M=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Adaptec ASR-8885 raid card.

Will delete/reDL the suspect files

Thank you
David

-----Original Message-----
From: Forza <forza@tnonline.net> 
Sent: 16 July 2022 22:09
To: David C. Partridge <david.partridge@perdrix.co.uk>;
linux-btrfs@vger.kernel.org
Subject: Re: Oh dear - some new problems



---- From: "David C. Partridge" <david.partridge@perdrix.co.uk> -- Sent:
2022-07-16 - 21:55 ----

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

The errors are uncorrectable because Btrfs doesn't have a good copy to
repair from. You have to replace the damaged files. Since they are torrents
it should not be too bad since the torrent protocol can repair/re-download
individual blocks in files. 


> 
> Thanks, David
> 


