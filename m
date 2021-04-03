Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F363534A5
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Apr 2021 18:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236808AbhDCQHO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 3 Apr 2021 12:07:14 -0400
Received: from mail.tuxforce.de ([84.38.66.179]:40226 "EHLO mail.tuxforce.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230266AbhDCQHO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 3 Apr 2021 12:07:14 -0400
X-Greylist: delayed 20582 seconds by postgrey-1.27 at vger.kernel.org; Sat, 03 Apr 2021 12:07:13 EDT
Received: from [IPv6:2001:4dd5:b099:0:19b2:6b8c:f4bb:b22d] (2001-4dd5-b099-0-19b2-6b8c-f4bb-b22d.ipv6dyn.netcologne.de [IPv6:2001:4dd5:b099:0:19b2:6b8c:f4bb:b22d])
        by mail.tuxforce.de (Postfix) with ESMTPSA id 8AA2D520021;
        Sat,  3 Apr 2021 18:07:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.tuxforce.de 8AA2D520021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tuxforce.de;
        s=202009; t=1617466029;
        bh=F9D8Fz6r0vFJ7T8IlWCjkWshdami/ReunTBZlMPl54k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=uLEeQNAa4+DwA5cBI1RGMA9kVr70gDDxlt5WbKwvoaJVcHPrVh156x4AA3N5QEC96
         9UNEAmdd0ijuYTR36Iugy0E9O3lwDmFfoL1Kfgxd6777N/3duFNmk36aWFA9at49Cz
         5iVV7Fx/KBofpOVzfVyg5YLln0zRfr074XTq5U/wsR4DKPyEAs5wU8NyopfT/6i/Fa
         YeYlv5rFySzpPlqACTL0HUW1QC1WBfxXhPLKL8dyazoVpCXWCUA3b1DVmFLSE1tHzf
         UBuJHRWLvzelaiiERtT3NHQujlo3qhPX7JdjKVBwpXa1OtxtiNnIa1GbaRZDbjqK/9
         fvWolb2XckgZg==
Subject: Re: Is request_firmware() really safe to call in resume callback when
 /usr/lib/firmware is on btrfs?
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-btrfs@vger.kernel.org, Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, Lukas Middendorf <kernel@tuxforce.de>
References: <20200813163749.GV4332@42.do-not-panic.com>
 <0b1621bf-fc82-1a56-c11f-c5c46677e59e@tuxforce.de>
 <20200813221348.GB4332@42.do-not-panic.com>
 <fc887e06-874c-79d8-0607-4e27ae788446@tuxforce.de>
 <20200814163723.GC4332@42.do-not-panic.com>
 <a79f1a0c-012d-bebe-c9c7-b505f59079c2@tuxforce.de>
 <20200817152056.GD4332@42.do-not-panic.com>
 <9e5c716e-1736-9890-54be-75739ea5462f@tuxforce.de>
 <20200818143715.GF4332@42.do-not-panic.com>
 <6b61e549-42b8-8e71-ff57-43b7c5b4291f@tuxforce.de>
 <20210402180253.GS4332@42.do-not-panic.com>
 <CAB=NE6WVnR197DnH+EgHDoyy98x15D0fVdoGjZcHW9W5P7Jipg@mail.gmail.com>
 <CAB=NE6X8bXUoTuTxhy-DDqO8ByaFiJqbjzCSmmGwTbbLY95FhA@mail.gmail.com>
 <679f1f74-1304-9e79-1d83-0810361b4503@tuxforce.de>
From:   Lukas Middendorf <kernel@tuxforce.de>
Message-ID: <63de0271-5222-efb0-b7ba-1ccf3d2401fa@tuxforce.de>
Date:   Sat, 3 Apr 2021 18:07:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <679f1f74-1304-9e79-1d83-0810361b4503@tuxforce.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Luis,

I now succeeded in reproducing this in VirtualBox running a F34 minimal 
installation with / on btrfs (with default firmware files).
I can send you the virtual disk file if you want it. With the kernel 
sourcecode and the compiled and installed kernel it currently is 21.8GiB.


On 03/04/2021 12:24, Lukas Middendorf wrote:
> On 03/04/2021 00:58, Luis Chamberlain wrote:
>> Can you provide kernel logs for where you are seeing things get stuck at? 

I have dumped the output of the serial console with all outputs cranked 
to the max.
In [1] is the output with test_firmware loaded and suspend test running. 
This leads to a freeze. However it is not completely dead. While it does 
not visually react, at least from time to time there still are some 
messages from the kernel and the cursor is still blinking.


In [2] is a (successful) suspend and resume cycle with test_firmware not 
loaded.

Lukas

[1] https://gist.github.com/midluk/05716f714f778d26dc02771245df0ac9
[2] https://gist.github.com/midluk/a03eb953b6cf097688b8be2e0cd387fd
