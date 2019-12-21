Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A430012890C
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Dec 2019 13:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfLUMUB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 21 Dec 2019 07:20:01 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:33353 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfLUMUB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 21 Dec 2019 07:20:01 -0500
X-Originating-IP: 88.191.131.7
Received: from [192.168.1.155] (unknown [88.191.131.7])
        (Authenticated sender: swami@petaramesh.org)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 6282DC0005;
        Sat, 21 Dec 2019 12:19:59 +0000 (UTC)
Subject: Re: Kernel 5.4 - BTRFS FS shows full with about 600 GB Free ?
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "'linux-btrfs@vger.kernel.org'" <linux-btrfs@vger.kernel.org>
References: <8bd55f28-2176-89f7-bd53-4992ccd53f42@petaramesh.org>
 <81dec38b-ec8e-382e-7dfe-cb331f418ffa@gmx.com>
From:   =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>
Message-ID: <1ef1129f-e44b-18ca-9237-29bc52760972@petaramesh.org>
Date:   Sat, 21 Dec 2019 13:19:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <81dec38b-ec8e-382e-7dfe-cb331f418ffa@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Le 21/12/2019 à 13:00, Qu Wenruo a écrit :
> Running a fsck is always a good behavior, although in this case, it
> shouldn't cause any corruption.

Actually looks good...

root@moksha:~# btrfs check /dev/mapper/luks-xxxxxxxxxxxxx
Opening filesystem to check...
Checking filesystem on /dev/mapper/luks-xxxxxxxxxxxxxx
UUID: yyyyyyyyyy
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 1306090934272 bytes used, no error found
total csum bytes: 1267957652
total tree bytes: 7383269376
total fs tree bytes: 5703942144
total extent tree bytes: 282771456
btree space waste bytes: 1153433142
file data blocks allocated: 1329687621632
  referenced 1430556405760

Kind regards.


