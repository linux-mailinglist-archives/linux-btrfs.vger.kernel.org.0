Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67328136405
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2020 00:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbgAIXuy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jan 2020 18:50:54 -0500
Received: from pme1.philip-seeger.de ([194.59.205.51]:52974 "EHLO
        pme1.philip-seeger.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729158AbgAIXux (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Jan 2020 18:50:53 -0500
Received: from [0.0.0.0] (unknown [IPv6:2001:a61:407:2401:42c5:fb35:8935:1e08])
        by pme1.philip-seeger.de (Postfix) with ESMTPSA id E9D571FD2EA
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2020 00:50:51 +0100 (CET)
Subject: Re: Monitoring not working as "dev stats" returns 0 after read error
 occurred
From:   Philip Seeger <philip@philip-seeger.de>
To:     linux-btrfs@vger.kernel.org
References: <3283de40c2750cd62d020ed71430cd35@philip-seeger.de>
 <d89fe4da-c498-bb24-8eb5-a19b01680a23@cobb.uk.net>
 <ac61f79a3c373f319232640db5db9a5e@philip-seeger.de>
 <2a9bf923-e7b9-9d82-5f1d-bbdfc192978e@suse.com>
 <d3a234a07192fd9713b0ac33123c99db@philip-seeger.de>
Message-ID: <68ebf136-6aff-bd98-cf95-0c3c7d5bed89@philip-seeger.de>
Date:   Fri, 10 Jan 2020 00:50:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <d3a234a07192fd9713b0ac33123c99db@philip-seeger.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> On 2020-01-09 13:04, Nikolay Borisov wrote:
>> It seems there are other error codes which are
>> also ignored but can signify errors e.g. STS_NEXUS/STS_TRANSPORT.

Speaking of other errors also being ignored.

I just saw this on a different system:

BTRFS warning (device sdd1): csum failed root 5 ino 263 off 5869793280 
csum 0xeee8ab75 expected csum 0x1fc62249 mirror 1

Is BTRFS trying to tell me that the file with inode number 263 is 
corrupt (checksum mismatch)?
I did indeed read (copy) that file earlier so it sounds like BTRFS 
calculated its checksum to verify it and it didn't match the stored 
checksum.

The error counters returned by "dev stats" all stayed at 0 (even after 
scrubbing). This is (was) a single filesystem, no RAID.

Suppose this was an important file, should I be worried now?

If this was a checksum error, why does the stats command keep saying 
that zero errors have been detected?
