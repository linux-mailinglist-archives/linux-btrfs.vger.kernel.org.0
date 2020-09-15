Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB1626ACBC
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Sep 2020 20:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbgIOS6n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Sep 2020 14:58:43 -0400
Received: from mail.itouring.de ([85.10.202.141]:54836 "EHLO mail.itouring.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727713AbgIOS6U (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Sep 2020 14:58:20 -0400
X-Greylist: delayed 609 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Sep 2020 14:58:20 EDT
Received: from tux.applied-asynchrony.com (p5ddd745f.dip0.t-ipconnect.de [93.221.116.95])
        by mail.itouring.de (Postfix) with ESMTPSA id 7DCFB1250EE;
        Tue, 15 Sep 2020 20:48:07 +0200 (CEST)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id 38FB4F01600;
        Tue, 15 Sep 2020 20:48:07 +0200 (CEST)
Subject: Re: Changes in 5.8.x cause compsize/bees failure
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>, dsterba@suse.cz,
        A L <mail@lechevalier.se>, linux-btrfs@vger.kernel.org
References: <632b888d-a3c3-b085-cdf5-f9bb61017d92@lechevalier.se>
 <20200915081725.GH1791@twin.jikos.cz> <20200915183438.GG5890@hungrycats.org>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <2424bf74-2fae-025d-9e0d-0b1d3b5f6baa@applied-asynchrony.com>
Date:   Tue, 15 Sep 2020 20:48:07 +0200
MIME-Version: 1.0
In-Reply-To: <20200915183438.GG5890@hungrycats.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2020-09-15 20:34, Zygo Blaxell wrote:
> On Tue, Sep 15, 2020 at 10:17:25AM +0200, David Sterba wrote:
>> On Sat, Sep 12, 2020 at 07:13:21PM +0200, A L wrote:
>>> I noticed that in (at least 5.8.6 and 5.8.8) there is some change in
>>> Btrfs kernel code that cause them to fail.
>>>
>>> For example compsize now often/usually fails with: "Regular extent's
>>> header not 53 bytes (0) long?!?"
>>>
>>> Bees is having plenty of errors too, and does not succeed to read any
>>> files (hash db is always empty). Perhaps this is an unrelated problem?
>>
>> The fix is now in stable queue, to be released in 5.8.10. Thanks for the
>> report!
> 
> And hopefully 5.4?  5.4.64 is also affected (and also fixed by Filipe's
> patch).

Yes, it is queued. You can always check what's coming:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-5.4

For other trees just see the parent dir.

-h
