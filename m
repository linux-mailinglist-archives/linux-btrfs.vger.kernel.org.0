Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A72E9817A8
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2019 12:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbfHEK4j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Aug 2019 06:56:39 -0400
Received: from mail02.iobjects.de ([188.40.134.68]:43066 "EHLO
        mail02.iobjects.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbfHEK4j (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Aug 2019 06:56:39 -0400
Received: from tux.wizards.de (p5DE2BA44.dip0.t-ipconnect.de [93.226.186.68])
        by mail02.iobjects.de (Postfix) with ESMTPSA id 832E4416C4D0;
        Mon,  5 Aug 2019 12:56:37 +0200 (CEST)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.wizards.de (Postfix) with ESMTP id 35344F015F9;
        Mon,  5 Aug 2019 12:56:37 +0200 (CEST)
Subject: Re: [PATCH] btrfs: add an ioctl to force chunk allocation
To:     Hans van Kranenburg <hans@knorrie.org>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20190802161031.18427-1-josef@toxicpanda.com>
 <a90f8550-c956-310d-c56c-6be8781fb3e9@applied-asynchrony.com>
 <b93a2c4b-79e5-4ee8-cdfb-941f9a2b480e@knorrie.org>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <09ba523a-e14f-eb93-8ae1-800c365b3439@applied-asynchrony.com>
Date:   Mon, 5 Aug 2019 12:56:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b93a2c4b-79e5-4ee8-cdfb-941f9a2b480e@knorrie.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/5/19 12:31 PM, Hans van Kranenburg wrote:
> On 8/5/19 12:20 PM, Holger Hoffstätte wrote:
>> On 8/2/19 6:10 PM, Josef Bacik wrote:
>>> In testing block group removal it's sometimes handy to be able to create
>>> block groups on demand.  Add an ioctl to allow us to force allocation
>>> from userspace.
>>
>> Gave this a try and it works as advertised, though I noticed that the
>> redundancy level is ignored, e.g. adding a single metadata chunk will
>> add a new "single" chunk even when the metadata level is dup.
>> Doing a balance -mconvert dup,soft fixes that right up, but it's IMHO
>> unexpected. Can you put a cherry on top and create the new chunk according
>> to its dup level?
> 
> Looking at the code, you should get -EINVAL when you specify anything
> else than single? (because of the != comparisons).
> 
> If this gets in, and is available without doing some special debug style
> kernel build, then it will (tm) be (ab)used by users in the future for
> things we didn't imagine today. So, in that case, it makes sense to be
> able to specify any valid combination of flags (type+profile), like
> indeed METADATA|DUP or whatever.

..and that's precisely why it (IMHO) should simply do The Right Thing
by default instead of giving people more footguns with unexpected
behaviour. Just observe the existing profile in the kernel ioctl and
act accordingly, no need for more user-supplied flags. Just don't.

Holger
