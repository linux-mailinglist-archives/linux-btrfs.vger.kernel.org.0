Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4621356FC
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2020 11:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbgAIKe2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jan 2020 05:34:28 -0500
Received: from mail.itouring.de ([188.40.134.68]:44938 "EHLO mail.itouring.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729165AbgAIKe2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 Jan 2020 05:34:28 -0500
Received: from tux.applied-asynchrony.com (p5B07E981.dip0.t-ipconnect.de [91.7.233.129])
        by mail.itouring.de (Postfix) with ESMTPSA id 2B0FE41669C5;
        Thu,  9 Jan 2020 11:34:26 +0100 (CET)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id C755CF015C3;
        Thu,  9 Jan 2020 11:34:25 +0100 (CET)
Subject: Re: btrfs scrub: cancel + resume not resuming?
To:     =?UTF-8?Q?Sebastian_D=c3=b6ring?= <moralapostel@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CADkZQakAhrRHFeHPJfne5oLT81qFGbzNAiUoqb3r0cxVSuHTNg@mail.gmail.com>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <b031f351-2a9c-83b3-7e4b-ac15791d96e6@applied-asynchrony.com>
Date:   Thu, 9 Jan 2020 11:34:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CADkZQakAhrRHFeHPJfne5oLT81qFGbzNAiUoqb3r0cxVSuHTNg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/9/20 11:03 AM, Sebastian Döring wrote:
> Maybe I'm doing it entirely wrong, but I can't seem to get 'btrfs
> scrub resume' to work properly. During a running scrub the resume
> information (like data_bytes_scrubbed:1081454592) gets written to a
> file in /var/lib/btrfs, but as soon as the scrub is cancelled all
> relevant fields are zeroed. 'btrfs scrub resume' then seems to
> re-start from the very beginning.
> 
> This is on linux-5.5-rc5 and btrfs-progs 5.4, but I've been seeing
> this for a while now.
> 
> Is this intended/expected behavior? Am I using the btrfs-progs wrong?
> How can I interrupt and resume a scrub?

Using 5.4.9+ (all of btrfs-5.5) and btrfs-progs 5.4 I just tried and
it still works for me (and always has):

$btrfs scrub start /mnt/backup
scrub started on /mnt/backup, fsid d163af2f-6e03-4972-bfd6-30c68b6ed312 (pid=25633)

$btrfs scrub cancel /mnt/backup
scrub cancelled

$btrfs scrub resume /mnt/backup
scrub resumed on /mnt/backup, fsid d163af2f-6e03-4972-bfd6-30c68b6ed312 (pid=25704)

..and it keeps munching away as expected.

TBH it's a bit odd that there is no "pause" - I'd expect cancel to be final,
but apart from that it seems to work.

-h
