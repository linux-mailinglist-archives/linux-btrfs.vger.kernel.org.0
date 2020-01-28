Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47AD614B36F
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jan 2020 12:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbgA1LTm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jan 2020 06:19:42 -0500
Received: from mail.itouring.de ([188.40.134.68]:54746 "EHLO mail.itouring.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbgA1LTm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jan 2020 06:19:42 -0500
Received: from tux.applied-asynchrony.com (p5B07E981.dip0.t-ipconnect.de [91.7.233.129])
        by mail.itouring.de (Postfix) with ESMTPSA id D33DA41696C7;
        Tue, 28 Jan 2020 12:19:40 +0100 (CET)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id 8AFB1F01603;
        Tue, 28 Jan 2020 12:19:40 +0100 (CET)
Subject: Re: Unexpected deletion behaviour between subvolume and normal
 directory
To:     Robbie Smith <zoqaeski@gmail.com>, linux-btrfs@vger.kernel.org
References: <CACurcBt_M-x=5CYhVUCiJq-yiUQF6-2a9PhWtmjfpJUYtAxt0Q@mail.gmail.com>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <9ee0bcd2-2a86-9cfb-f5b3-793e1c035f33@applied-asynchrony.com>
Date:   Tue, 28 Jan 2020 12:19:40 +0100
MIME-Version: 1.0
In-Reply-To: <CACurcBt_M-x=5CYhVUCiJq-yiUQF6-2a9PhWtmjfpJUYtAxt0Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/28/20 11:25 AM, Robbie Smith wrote:
> I wanted to try to convert my music library from a directory into a
> subvolume so I could use btrfs send/receive to transfer (changed)
> files between it and a USB backup. A bit of Googling suggested that
> the approach would be:
> 
>> btrfs subvolume create /library/newmusic
>> cp -ar --reflink=auto /library/music/* /library/newmusic/.
>> rm -r /library/music
> 
> After about 30 seconds I realised that it was deleting files from both
> /library/music and /library/newmusic. It appears I've only lost
> everything starting with A, B or C, so I unmounted the device, and am
> currently trying to use `btrfs restore` to get the files back and it
> doesn't seem to be finding them.
> 
> I'm pretty sure deleting files from directory A isn't supposed to also
> delete them from directory B, but that's what it did. Is this a bug?

Whatever happened - this is not it. I do this all the time without
problems. Also note that you can use mv directly, since it will
use reflink when possible:

$mkdir data
$echo "foo" > data/data
$btrfs subvolume create newdata
Create subvolume './newdata'
$mv data/* newdata
$ll data
total 0
$rm -rf data
$ll newdata
total 4.0K
-rw-r--r-- 1 root root 4 Jan 28 12:16 data
$cat newdata/data
foo

All as expected.

-h
