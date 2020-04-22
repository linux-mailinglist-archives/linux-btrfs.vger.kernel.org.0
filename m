Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4CF1B41C0
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Apr 2020 12:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbgDVKzM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Apr 2020 06:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728507AbgDVKzL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Apr 2020 06:55:11 -0400
Received: from wp558.webpack.hosteurope.de (wp558.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8250::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230ACC03C1A8
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Apr 2020 03:55:11 -0700 (PDT)
Received: from mail1.i-concept.de ([130.180.70.237] helo=[192.168.122.235]); authenticated
        by wp558.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1jRD25-0002jJ-L2; Wed, 22 Apr 2020 12:55:09 +0200
Subject: Re: RAID 1 | Newbie Question
To:     Hugo Mills <hugo@carfax.org.uk>, linux-btrfs@vger.kernel.org
References: <be4ee7ea-f032-ee63-2486-030b2f270baa@peter-speer.de>
 <20200422104403.GE32577@savella.carfax.org.uk>
From:   Stefanie Leisestreichler <stefanie.leisestreichler@peter-speer.de>
Message-ID: <d59a8a2e-2aae-0177-a0a8-6c238776814a@peter-speer.de>
Date:   Wed, 22 Apr 2020 12:55:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200422104403.GE32577@savella.carfax.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;stefanie.leisestreichler@peter-speer.de;1587552911;cffa8089;
X-HE-SMSGID: 1jRD25-0002jJ-L2
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 22.04.20 12:44, Hugo Mills wrote:
>     You can't set up btrfs RAID-1 to use only one device. It's only
> possible to end up like that if you set up a 2-device RAID-1 and then
> unplug a device and mount it in degraded mode.

It was this sentence in the btrfs wiki, what confused me, also comments 
in the net that btrfs is not giving you RAID with redundant data 
(https://btrfs.wiki.kernel.org/index.php/FAQ):

"It is possible with all of the descriptions below, to construct a 
RAID-1 array from two or more devices, and have those devices live on 
the same physical drive. This configuration does not offer any form of 
redundancy for your data."
