Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7327BE896
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Oct 2023 19:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377041AbjJIRre (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Oct 2023 13:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbjJIRre (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Oct 2023 13:47:34 -0400
X-Greylist: delayed 398 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 09 Oct 2023 10:47:32 PDT
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B50391
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Oct 2023 10:47:32 -0700 (PDT)
Received: (wp-smtpd smtp.tlen.pl 18777 invoked from network); 9 Oct 2023 19:40:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1696873250; bh=QZyP8wKrTcJG2FYOx8Z5U8/f0kTs/1pfVf+UPHcYYRc=;
          h=From:To:Subject;
          b=IoEP4gmHups1PasCdW0eBMnPaIma0jyofMhYxrze9+vcJ7Jr1rzhKTD3JcKMY2L3r
           ivJ1dI4NASJGRxNHfCYMIBVz6NnPQEIoDGi93ciGJA/lwCdaoH1HttC299iyRFCEZZ
           RvphpLH89dMokkI+z7d4yG4DKWXz45dH0V2AKg3s=
Received: from 89-67-68-22.dynamic.chello.pl (HELO [192.168.0.165]) (pe3no@o2.pl@[89.67.68.22])
          (envelope-sender <pe3no@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with ECDHE-RSA-AES256-SHA encrypted SMTP
          for <linux-btrfs@vger.kernel.org>; 9 Oct 2023 19:40:50 +0200
Message-ID: <65243B1F.6040302@o2.pl>
Date:   Mon, 09 Oct 2023 19:40:47 +0200
From:   "pe3no@o2.pl" <pe3no@o2.pl>
User-Agent: Mozilla-Thunderbird 2.0.0.24 (X11/20100329)
MIME-Version: 1.0
To:     linux-btrfs@vger.kernel.org
Subject: BTRFS /dev/md0 recovery - mounted RW, after being hibernated.
References: <937af4c3d97d4c3d93721a08029fa7a4@grupawp.pl>
In-Reply-To: <937af4c3d97d4c3d93721a08029fa7a4@grupawp.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-WP-MailID: 08350ce6ec93b4b810d17a6bc1a21ae8
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000002 [kRHT]                               
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        GB_FREEMAIL_DISPTO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello Dear BTRFS Friends, nice to meet you!

Would it be possible to get BTRFS Developer/s help to recover my 
important data from BTRFS /dev/md0, please?
By mistake, it was mounted RW after being hibernated. I was not able to 
backup the data before, so I strongly need to recover it, with your 
Great Help, please!

I would  also like to ask a new BTRFS Feature which would prevent the 
possibility to mount a BTRFS partition RW, if it was previously hibernated.
I can specify it in more in detail and get involved into testing, if needed.

Thank you in advance for help and kind regards~~Piotrek~~pe3no
