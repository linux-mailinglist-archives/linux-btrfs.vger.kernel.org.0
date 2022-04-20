Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A72C508380
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Apr 2022 10:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349376AbiDTIhZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Apr 2022 04:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238908AbiDTIhY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Apr 2022 04:37:24 -0400
X-Greylist: delayed 410 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 20 Apr 2022 01:34:37 PDT
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A4CDF5B
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 01:34:37 -0700 (PDT)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id C03199B807; Wed, 20 Apr 2022 09:27:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.me.uk; s=201703;
        t=1650443263; bh=OlksthEKdc07lLzXPyvMiASbZ0osr+psuW0LZQINHNM=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=NiL/mM9L0EaXKmGSchtx8EginU2ONzzW7/WPn24vKrJbuNunz2N7BtUcB0m8RJX4h
         CoeDvn3moHmkyAXAD5FJiP/i19N/76fBJoij7a8r4H796y6XhUJlUWrncv6hJYoGVW
         p/AkP77/S2VIfA79HVWqE57PsdwdWSo81dhsL63BAuHj5R10f/SQz76pVudgeA4Bma
         zscqGDZCtnSW80G5x9JHf0J2kM1VtzFmPKANHcaCWQF2baUHpoWQ3HU/doQ3jsyku5
         Q3xWhX3a4iEBdzY3M4dxSEBiO3TgCIDbuCv9NUw2653mnAc+1gkpWWyoWpXYCUxDj/
         8OYDY0kQfsJJg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id EF11F9B6F3;
        Wed, 20 Apr 2022 09:27:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.me.uk; s=201703;
        t=1650443244; bh=OlksthEKdc07lLzXPyvMiASbZ0osr+psuW0LZQINHNM=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=Xac18JLKwDpoxEUdyDtkN/a03QkT7N4iifXgAb3l2+nf0R+ieyW+JRM2e5kaUiavX
         89CYjlbtjkcng14tTYmzMW1q6kFY3wJIUOnDlvrtZPrckO9esoT/P62nbFxbi8Wovq
         L3mbErWKsjFKm8VMY9o7FiyIZn3zV0AVIMGv+Dv6UfwHAhTZoP+oBWPLEoKbZg8gK3
         +SGBwW64c/adhrRz5TtKGSmcE5TmF2HRYPPEoVdsbYznHm90gVVqHK1kYXaV1bBz8z
         HmKFPKIM4d0pQti0hVBkj2B6bf4j+QRx2y/m8Py4W3Fu4Koq3TwDoQ5qNEvVXTN216
         eq0s514y2oESA==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id C32121580F6;
        Wed, 20 Apr 2022 09:27:23 +0100 (BST)
Message-ID: <cac308f5-5d4a-00e2-94de-40e4f144a144@cobb.uk.net>
Date:   Wed, 20 Apr 2022 09:27:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From:   Graham Cobb <g.btrfs@cobb.me.uk>
Subject: Re: space still allocated post deletion
Content-Language: en-US
To:     Alex Powell <alexj.powellalt@googlemail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CAKGv6Cq+uwBMgo6th6E16=om8321wTO3fZPXF151VLSYiexFUg@mail.gmail.com>
 <6672365e-c3d2-1a4c-7eb6-957f7a692d3a@cobb.uk.net>
 <CAKGv6CovkUjb92MAaM-irNcJvJk2P_2QNpybzCSsSs2RMgfz4A@mail.gmail.com>
In-Reply-To: <CAKGv6CovkUjb92MAaM-irNcJvJk2P_2QNpybzCSsSs2RMgfz4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 20/04/2022 08:17, Alex Powell wrote:
> Thank you,
> The issue was veeam keeping snapshots in .veeam-snapshots above the
> root subvolume. I have no idea why this is the expected behaviour,
> because the backups are set to go to /mnt/data.

I don't use either veeam or Ubuntu but I note that btrbk (which I use)
has a similar concept of storing some snapshots on the disk itself and
only moving a subset of them to the backup disk. I use this to keep
hourly snapshots on the source disk itself and move one of them to the
backup disk per day. The hourly snapshots have proved occasionally
useful when I manage to accidentally delete a chunk of a document I am
working on and then save the file - DOH!

Of course, it isn't so useful if you never knew it existed :-)

