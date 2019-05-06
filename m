Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3279F153C9
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2019 20:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfEFSjZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 6 May 2019 14:39:25 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:9082 "EHLO
        smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfEFSjZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 May 2019 14:39:25 -0400
Received: from [94.217.144.7] (helo=[192.168.177.20])
        by smtprelay01.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <hendrik@friedels.name>)
        id 1hNiWI-0005Dr-ON; Mon, 06 May 2019 20:39:22 +0200
From:   "Hendrik Friedel" <hendrik@friedels.name>
To:     "Chris Murphy" <lists@colorremedies.com>
Subject: Re[6]: Rough (re)start with btrfs
Cc:     "Chris Murphy" <lists@colorremedies.com>,
        "Qu Wenruo" <quwenruo.btrfs@gmx.com>,
        "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Date:   Mon, 06 May 2019 18:39:14 +0000
Message-Id: <em9719915a-4d1f-4ab9-b14f-488b3cccd9f2@ryzen>
In-Reply-To: <CAJCQCtSdD32h_xTBVOxEZOp0XijqA0j=HsS5YgdePVhpdgtuRg@mail.gmail.com>
References: <em9eba60a7-2c0d-4399-8712-c134f0f50d4d@ryzen>
 <e6918268-1e3e-6c2d-853c-aa1eaf8e9693@gmx.com>
 <ema5c33b0a-936b-48f6-99ba-4c5a50e8a88a@ryzen>
 <CAJCQCtTHFi8uR1JndoXju0HvfGvBwXK6Pq4oqJiop82FaT_J-A@mail.gmail.com>
 <emebc18462-5243-43f8-be24-79a932d90a57@ryzen>
 <CAJCQCtSdD32h_xTBVOxEZOp0XijqA0j=HsS5YgdePVhpdgtuRg@mail.gmail.com>
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

>v2 is expected to become the default soon
That is good to hear.

>But from the sound of it Qu has enough
>information to maybe track down the v1 problem and fix it, and
>probably should be fixed as v1 is the default and is still supported
>and will be forever.
That's good to hear.

>>
>>  For me, the question now is, whether we should chase this Bug or not. I
>>  encountered it three times while filling a 8TB drive with 7TB. Now, I
>>  have 1TB left and I am not sure I can reproduce, but I can try.
>
>I don't think it's necessary unless Qu specifically asks.
Let me know Qu.

>>you wouldn't want to constantly dump
>that amount of information into kernel message buffer and then burden
>the system logger with quite a lot of extraneous information.
I understand. Still, a a pitty.

>Once you have a reproducer, then you can change the scheduler and see
>if your reproduce steps still reproduce the problem.
I will try and let you know. It's not persistent.

Greetings,
Hendrik


>

