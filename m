Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 845F2135798
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2020 12:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730480AbgAILF1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jan 2020 06:05:27 -0500
Received: from mail.itouring.de ([188.40.134.68]:45022 "EHLO mail.itouring.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728635AbgAILF0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 Jan 2020 06:05:26 -0500
Received: from tux.applied-asynchrony.com (p5B07E981.dip0.t-ipconnect.de [91.7.233.129])
        by mail.itouring.de (Postfix) with ESMTPSA id A529A41669C5;
        Thu,  9 Jan 2020 12:05:25 +0100 (CET)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id 5C013F015C3;
        Thu,  9 Jan 2020 12:05:25 +0100 (CET)
Subject: Re: btrfs scrub: cancel + resume not resuming?
To:     Graham Cobb <g.btrfs@cobb.uk.net>,
        =?UTF-8?Q?Sebastian_D=c3=b6ring?= <moralapostel@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CADkZQakAhrRHFeHPJfne5oLT81qFGbzNAiUoqb3r0cxVSuHTNg@mail.gmail.com>
 <b031f351-2a9c-83b3-7e4b-ac15791d96e6@applied-asynchrony.com>
 <71add409-04ad-c6be-4f4f-5eec4ffb167c@cobb.uk.net>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <bafe1610-914b-c9b4-3f04-a0fdcc97d256@applied-asynchrony.com>
Date:   Thu, 9 Jan 2020 12:05:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <71add409-04ad-c6be-4f4f-5eec4ffb167c@cobb.uk.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/9/20 11:52 AM, Graham Cobb wrote:
> On 09/01/2020 10:34, Holger Hoffstätte wrote:
>> On 1/9/20 11:03 AM, Sebastian Döring wrote:
>>> Maybe I'm doing it entirely wrong, but I can't seem to get 'btrfs
>>> scrub resume' to work properly. During a running scrub the resume
>>> information (like data_bytes_scrubbed:1081454592) gets written to a
>>> file in /var/lib/btrfs, but as soon as the scrub is cancelled all
>>> relevant fields are zeroed. 'btrfs scrub resume' then seems to
>>> re-start from the very beginning.
>>>
>>> This is on linux-5.5-rc5 and btrfs-progs 5.4, but I've been seeing
>>> this for a while now.
>>>
>>> Is this intended/expected behavior? Am I using the btrfs-progs wrong?
>>> How can I interrupt and resume a scrub?
>>
>> Using 5.4.9+ (all of btrfs-5.5) and btrfs-progs 5.4 I just tried and
>> it still works for me (and always has):
>>
>> $btrfs scrub start /mnt/backup
>> scrub started on /mnt/backup, fsid d163af2f-6e03-4972-bfd6-30c68b6ed312
>> (pid=25633)
>>
>> $btrfs scrub cancel /mnt/backup
>> scrub cancelled
>>
>> $btrfs scrub resume /mnt/backup
>> scrub resumed on /mnt/backup, fsid d163af2f-6e03-4972-bfd6-30c68b6ed312
>> (pid=25704)
>>
>> ..and it keeps munching away as expected.
> 
> Can you check that the resume has really started from where the scrub
> was cancelled? What I (and, I think, Sebastian) are seeing is that the
> resume "works" but actually restarts from the beginning.
> 
> For example, something like:
> 
> btrfs scrub start /mnt/backup
> sleep 300
> btrfs scrub status -R /mnt/backup
> btrfs scrub cancel /mnt/backup
> btrfs scrub resume /mnt/backup
> sleep 100
> btrfs scrub status -R /mnt/backup
> 
> and check the last_physical in the second status is higher than the one
> in the first status.
> 

Well, yes. Reduced the wait times a bit and:

$cat test-scrub
#!/bin/sh
btrfs scrub start /mnt/backup
sleep 30
btrfs scrub status -R /mnt/backup
btrfs scrub cancel /mnt/backup
btrfs scrub resume /mnt/backup
sleep 10
btrfs scrub status -R /mnt/backup

$./test-scrub
scrub started on /mnt/backup, fsid d163af2f-6e03-4972-bfd6-30c68b6ed312 (pid=26390)
UUID:             d163af2f-6e03-4972-bfd6-30c68b6ed312
Scrub started:    Thu Jan  9 12:02:18 2020
Status:           running
Duration:         0:00:25
	data_extents_scrubbed: 65419
	tree_extents_scrubbed: 28
	data_bytes_scrubbed: 4117274624
	tree_bytes_scrubbed: 458752
	read_errors: 0
	csum_errors: 0
	verify_errors: 0
	no_csum: 0
	csum_discards: 0
	super_errors: 0
	malloc_errors: 0
	uncorrectable_errors: 0
	unverified_errors: 0
	corrected_errors: 0
	last_physical: 3591372800
         ^^^^^^^^^^^^^^^^^^^^^^^^^
scrub cancelled
scrub resumed on /mnt/backup, fsid d163af2f-6e03-4972-bfd6-30c68b6ed312 (pid=26399)
UUID:             d163af2f-6e03-4972-bfd6-30c68b6ed312
Scrub resumed:    Thu Jan  9 12:02:49 2020
Status:           running
Duration:         0:00:36
	data_extents_scrubbed: 12648
	tree_extents_scrubbed: 28
	data_bytes_scrubbed: 823394304
	tree_bytes_scrubbed: 458752
	read_errors: 0
	csum_errors: 0
	verify_errors: 0
	no_csum: 0
	csum_discards: 0
	super_errors: 0
	malloc_errors: 0
	uncorrectable_errors: 0
	unverified_errors: 0
	corrected_errors: 0
	last_physical: 923205632
         ^^^^^^^^^^^^^^^^^^^^^^^^

Not sure what I'm doing wrong ;)

-h
