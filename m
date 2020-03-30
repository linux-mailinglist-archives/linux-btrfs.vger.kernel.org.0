Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95395197639
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Mar 2020 10:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729589AbgC3ILl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Mar 2020 04:11:41 -0400
Received: from 4brad.ctyme.com ([184.105.182.90]:47272 "EHLO 4brad.ctyme.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgC3ILl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Mar 2020 04:11:41 -0400
Received: from [192.168.123.14] (c-76-102-119-11.hsd1.ca.comcast.net [76.102.119.11])
        by 4brad.ctyme.com (Postfix) with ESMTPSA id 7D83A6340A35;
        Mon, 30 Mar 2020 04:11:41 -0400 (EDT)
Subject: Re: btrfs-transacti hangs system for several seconds every few
 minutes
To:     Andrei Borzenkov <arvidjaar@gmail.com>,
        Tomasz Chmielewski <mangoo@wpkg.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <94d08f2b57dd2df746436a0d6bb5f51e@wpkg.org>
 <8703e779-d31b-37c1-672b-dea482e8a491@gmail.com>
From:   Brad Templeton <4brad@templetons.com>
Organization: http://www.templetons.com/brad
Message-ID: <b71b10f8-6410-4d32-f89c-9b3f20d9b2f2@templetons.com>
Date:   Mon, 30 Mar 2020 01:11:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <8703e779-d31b-37c1-672b-dea482e8a491@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Also, isn't it 4 debs -- image, modules, headers and architecture
independent headers?

Still, I am surprised that the ubuntu team, with a data corruption
issue, would not make a priority to install a fixed kernel or at least
backport btrfs modules into the current kernel.

On 3/29/20 10:56 PM, Andrei Borzenkov wrote:
> 30.03.2020 05:29, Tomasz Chmielewski пишет:
>>> I wonder why they put 5.3.0 as the standard advanced Kernel in Ubuntu
>>> LTS if it has a data corruption bug.   I don't know if I've seen any
>>> release of 5.4.14 in a PPA yet -- manual kernel install is such a pain
>>> the few times I have done it.
>>
>> You have all kernels compiled as packages here (for Ubuntu):
>>
>> https://kernel.ubuntu.com/~kernel-ppa/mainline/
>>
>> So just download two deb packages, dpkg -i, and done.
>>
> 
> Beware that it is not exactly the same as distribution kernel (both in
> terms of included patches and enabled configuration options). Also
> matching linux-tools is not provided which means perf, cpupower,
> turbostat and some other tools stop working.
> 
