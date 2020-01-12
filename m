Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58F8A138611
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Jan 2020 12:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732725AbgALLnC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 Jan 2020 06:43:02 -0500
Received: from pme1.philip-seeger.de ([194.59.205.51]:56684 "EHLO
        pme1.philip-seeger.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732723AbgALLnB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 Jan 2020 06:43:01 -0500
Received: from [192.168.10.139] (ppp-93-104-101-141.dynamic.mnet-online.de [93.104.101.141])
        by pme1.philip-seeger.de (Postfix) with ESMTPSA id 9A5C2200245;
        Sun, 12 Jan 2020 12:42:59 +0100 (CET)
Subject: Re: Monitoring not working as "dev stats" returns 0 after read error
 occurred
To:     Andrei Borzenkov <arvidjaar@gmail.com>, linux-btrfs@vger.kernel.org
References: <3283de40c2750cd62d020ed71430cd35@philip-seeger.de>
 <d89fe4da-c498-bb24-8eb5-a19b01680a23@cobb.uk.net>
 <ac61f79a3c373f319232640db5db9a5e@philip-seeger.de>
 <2a9bf923-e7b9-9d82-5f1d-bbdfc192978e@suse.com>
 <d3a234a07192fd9713b0ac33123c99db@philip-seeger.de>
 <68ebf136-6aff-bd98-cf95-0c3c7d5bed89@philip-seeger.de>
 <9b6d7519-cffb-2cfa-5e77-b514817b5f0a@gmail.com>
From:   Philip Seeger <philip@philip-seeger.de>
Message-ID: <2ddeb325-7c53-5423-8b14-8393c6928350@philip-seeger.de>
Date:   Sun, 12 Jan 2020 12:42:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <9b6d7519-cffb-2cfa-5e77-b514817b5f0a@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/11/20 8:42 AM, Andrei Borzenkov wrote:

> On one mirror piece. It likely got correct data from another piece.

This may be a dumb question, but what mirror are we talking about here? 
Note that this "csum failed" message happened on a different system 
(than the "read error corrected" I quoted in the first message of this 
thread). This happened on a simple btrfs partition and by default, 
"data" isn't mirrored (fi df: single).
I wrote it in the same thread, not to cause confusion, but simply 
because I saw the same problem I'm trying to describe in another 
configuration: "dev stats" claims no errors occurred and monitoring 
tools relying on "dev stats" therefore won't be able to notify admins 
about a bad drive before.

I think this is a serious bug. Just think about what that means. A drive 
goes bad, btrfs keeps fixing errors caused by that drive but as "dev 
stats" keeps saying "all good" (which is checked hourly or daily, by a 
monitoring job), no admin will be notified. A few weeks later, a second 
drive fails, causing data loss. The whole raid array might be gone and 
even if the backups are relatively up-to-date, the work from the past 
few hours will be lost and then there's the outage and the downtime 
(everything has to be shut down and restored from the backup, which 
might take a lot of time if the backup system is slow, maybe some parts 
are stored on tapes...).

In other words: What's the point of a RAID system if the admin won't be 
able to know that a drive is bad and has to be replaced?

> This is not device-level error. btrfs got data from block device without
> error. That content of data was wrong does not necessarily mean block
> device problem.

I understand that it's unlikely that it was a block device problem, 
after all it's a new hard drive (and I ran badblocks on it which didn't 
find any errors).
But if the drive is good and the file appears to be correct and one (of 
two?) checksum matched the file's contents, why was the other checksum 
wrong? Or could it be something completely different that triggers the 
same error message?

> You have mirror and btrfs got correct data from another device
> (otherwise you were not able to read file at all). Of course you should
> be worried why one copy of data was not correct.

Which other device?

By one copy of data you mean one of two checksums (which are stored 
twice in case one copy gets corrupted like in this case apparently)?

> Again - there was no error *reading* data from block device. Is
> corruption_errs also zero?

Yes, all the error counts were zero.
