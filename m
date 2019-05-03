Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7334B12739
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2019 07:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725777AbfECFmA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 3 May 2019 01:42:00 -0400
Received: from smtprelay08.ispgateway.de ([134.119.228.107]:42231 "EHLO
        smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfECFmA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 May 2019 01:42:00 -0400
Received: from [94.217.144.7] (helo=[192.168.177.20])
        by smtprelay08.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <hendrik@friedels.name>)
        id 1hMQxJ-0001Tx-4e; Fri, 03 May 2019 07:41:57 +0200
From:   "Hendrik Friedel" <hendrik@friedels.name>
To:     "Qu Wenruo" <quwenruo.btrfs@gmx.com>,
        "Chris Murphy" <lists@colorremedies.com>,
        "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Subject: Re[2]: Rough (re)start with btrfs
Date:   Fri, 03 May 2019 05:41:52 +0000
Message-Id: <ema5c33b0a-936b-48f6-99ba-4c5a50e8a88a@ryzen>
In-Reply-To: <e6918268-1e3e-6c2d-853c-aa1eaf8e9693@gmx.com>
References: <em9eba60a7-2c0d-4399-8712-c134f0f50d4d@ryzen>
 <e6918268-1e3e-6c2d-853c-aa1eaf8e9693@gmx.com>
Reply-To: "Hendrik Friedel" <hendrik@friedels.name>
User-Agent: eM_Client/7.2.34062.0
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Df-Sender: aGVuZHJpa0BmcmllZGVscy5uYW1l
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

-by the way: I think my mail did not appear in the list, but only 
reached Chris and Qu directly. I just tried to re-send it. Could this be 
caused by
1) me not a subscriber of the list
2) combined with me sending attachments
I did *not* get any error message by the server.

>>  I was tempted to ask, whether this should be fixed. On the other hand, I
>>  am not even sure anything bad happened (except, well, the system -at
>>  least the copy- seemed to hang).
>
>Definitely needs to be fixed.
>
>With full dmesg, it's now clear that is a real dead lock.
>Something wrong with the free space cache, blocking the whole fs to be
>committed.
>
So, what's the next step? Shall I open a bug report somewhere, or is it 
already on some list?

>If you still want to try btrfs, you could try "nosapce_cache" mount option.
>Free space cache of btrfs is just an optimization, you can completely
>ignore that with minor performance drop.
>
I will try that, yes.
Can you confirm, that it is unlikely, that I lost any data / damaged the 
Filesystem?

Regards,
Hendrik

