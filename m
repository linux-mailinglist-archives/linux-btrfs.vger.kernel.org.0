Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDCA351D26
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Apr 2021 20:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235352AbhDAS1S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Apr 2021 14:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239439AbhDASUs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Apr 2021 14:20:48 -0400
X-Greylist: delayed 458 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 01 Apr 2021 08:07:27 PDT
Received: from mail.tuxforce.de (mail.tuxforce.de [IPv6:2a00:5080:1:16d::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42B5C00F7D6
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Apr 2021 08:07:27 -0700 (PDT)
Received: from [IPv6:2001:4dd5:b099:0:19b2:6b8c:f4bb:b22d] (2001-4dd5-b099-0-19b2-6b8c-f4bb-b22d.ipv6dyn.netcologne.de [IPv6:2001:4dd5:b099:0:19b2:6b8c:f4bb:b22d])
        by mail.tuxforce.de (Postfix) with ESMTPSA id 0A22152007A;
        Thu,  1 Apr 2021 16:59:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.tuxforce.de 0A22152007A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tuxforce.de;
        s=202009; t=1617289188;
        bh=3a6WlI18tPbA5gRTLysYpeWkw8mZwnceMr/ns0Zzj1w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=EfoCDaI0jR5YqXlG8sUTB9/OXuhCp/xJ3sDumLcZMYQWJ6dtRePXG86osxhpa375u
         jlKUtBmN+xE1pKPDHIoSf/n/7ylPgD/Qd2hd1sCILzCJB1C7OFThwGpNQufTdXaSba
         z9cAosTiPFT0dxbVdsDDFmTW1uOfwj1UnMAGQTRYXhX6TKY/1mXE5cnVJqt5PYpFGs
         Ft1OiKiJRcalYM3pzDY5nRx+pxzTJD3vf7w8GJgRp9kcG9DVYYkvU5Pyc77puFU+rG
         JFKy5ACNyNj6orNBnuDU/LBBoNBNA7mCuk61dc8mEMyNP/qSqjQdu0JOfQsubKUY02
         h5p7uLPSAvtAw==
Subject: Re: Is request_firmware() really safe to call in resume callback when
 /usr/lib/firmware is on btrfs?
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-btrfs@vger.kernel.org, Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, Lukas Middendorf <kernel@tuxforce.de>
References: <c79e24a5-f808-d1f0-1f09-ee6f135d9679@tuxforce.de>
 <20200813163749.GV4332@42.do-not-panic.com>
 <0b1621bf-fc82-1a56-c11f-c5c46677e59e@tuxforce.de>
 <20200813221348.GB4332@42.do-not-panic.com>
 <fc887e06-874c-79d8-0607-4e27ae788446@tuxforce.de>
 <20200814163723.GC4332@42.do-not-panic.com>
 <a79f1a0c-012d-bebe-c9c7-b505f59079c2@tuxforce.de>
 <20200817152056.GD4332@42.do-not-panic.com>
 <9e5c716e-1736-9890-54be-75739ea5462f@tuxforce.de>
 <20200818143715.GF4332@42.do-not-panic.com>
From:   Lukas Middendorf <kernel@tuxforce.de>
Message-ID: <6b61e549-42b8-8e71-ff57-43b7c5b4291f@tuxforce.de>
Date:   Thu, 1 Apr 2021 16:59:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20200818143715.GF4332@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello Luis,


On 18/08/2020 16:37, Luis Chamberlain wrote:
> On Tue, Aug 18, 2020 at 12:04:51AM +0200, Lukas Middendorf wrote:
>> On 17/08/2020 17:20, Luis Chamberlain wrote:
>>> This helps, thanks so much, now we'll have to write a reproducer, thanks
>>> for the report!!
>>
>> Will you do it yourself or do you expect me to do anything for this?
> 
> I meant to imply that we'd do this, now that we understand the problem. Thanks
> for your report!

any news on this issue? Did you succeed with reproducing this at your end?

I retested this with 5.12-rc5 and everything still seems unchanged. I 
still get freezes on resume under the same circumstances described 
previously if /usr/lib/firmware is on btrfs. My patches to si2168.c were 
not merged.
The documentation of request_firmware() seems unchanged and does not 
reflect the fact that prerequisites exist for making it safe to call 
during resume callbacks.

Lukas
