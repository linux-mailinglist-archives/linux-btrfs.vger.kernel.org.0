Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46A0B64C66
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jul 2019 20:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfGJStj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Jul 2019 14:49:39 -0400
Received: from zaphod.cobb.me.uk ([213.138.97.131]:44908 "EHLO
        zaphod.cobb.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727287AbfGJSti (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Jul 2019 14:49:38 -0400
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 6830A142BC2; Wed, 10 Jul 2019 19:49:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1562784575;
        bh=askeCnKptZFte6x3gRutpsC7UE+/qqqgh3C/4/+Y/a4=;
        h=To:From:Subject:Date:From;
        b=CZf/HYMMlEYwfuOkMRhO3dQkglC5Y7BEiC0SKkYZ0LGDkbG+TYf/GLxFvQvOsDtEz
         nV3PFVU/19giHopKP32edSYYTf+Fs7k/0xCgyzLl3XvL+LGMfnOKcB/YlpRqtLLjPr
         R1v86W3HgDn1nnpZmWAdDWHZ++WDVjIM3QKxYl41MlbeaPxoCb3RwQbs+DnvJsni6p
         mEdGp+juzlAQq2Vhf/gFAWxEGR+rEG6XHov/Pg7SCvsynzzhlAoaa2+r6K5PcSk95C
         ZMtzsrgs9nC6C0nz7+HSLdwp0dHvZvj/wCmkFoajO8RXdqnE08uDQs/x92ilXxk/oV
         Wb/3eAvrY0CrA==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-0.8 required=12.0 tests=ALL_TRUSTED,DKIM_INVALID,
        DKIM_SIGNED,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id EBDAC142BC1
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Jul 2019 19:49:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1562784575;
        bh=askeCnKptZFte6x3gRutpsC7UE+/qqqgh3C/4/+Y/a4=;
        h=To:From:Subject:Date:From;
        b=CZf/HYMMlEYwfuOkMRhO3dQkglC5Y7BEiC0SKkYZ0LGDkbG+TYf/GLxFvQvOsDtEz
         nV3PFVU/19giHopKP32edSYYTf+Fs7k/0xCgyzLl3XvL+LGMfnOKcB/YlpRqtLLjPr
         R1v86W3HgDn1nnpZmWAdDWHZ++WDVjIM3QKxYl41MlbeaPxoCb3RwQbs+DnvJsni6p
         mEdGp+juzlAQq2Vhf/gFAWxEGR+rEG6XHov/Pg7SCvsynzzhlAoaa2+r6K5PcSk95C
         ZMtzsrgs9nC6C0nz7+HSLdwp0dHvZvj/wCmkFoajO8RXdqnE08uDQs/x92ilXxk/oV
         Wb/3eAvrY0CrA==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id A5E7316DA2
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Jul 2019 19:49:34 +0100 (BST)
To:     linux-btrfs@vger.kernel.org
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Subject: "btrfs: harden agaist duplicate fsid" spams syslog
Openpgp: preference=signencrypt
Autocrypt: addr=g.btrfs@cobb.uk.net; prefer-encrypt=mutual; keydata=
 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 myxb
Message-ID: <5d8baf80-4fb3-221f-5ab4-e98a838f63e1@cobb.uk.net>
Date:   Wed, 10 Jul 2019 19:49:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Anand's Nov 2018 patch "btrfs: harden agaist duplicate fsid" has
recently percolated through to my Debian buster server system.

And it is spamming my log files.

Each of my btrfs filesystem devices logs 4 messages every 2 minutes.
Here is an example of the 4 messages related to one device:

Jul 10 19:32:27 black kernel: [33017.407252] BTRFS info (device sdc3):
device fsid 4d1ba5af-8b89-4cb5-96c6-55d1f028a202 devid 4 moved
old:/dev/mapper/cryptdata4tb--vg-backup new:/dev/dm-13
Jul 10 19:32:27 black kernel: [33017.522242] BTRFS info (device sdc3):
device fsid 4d1ba5af-8b89-4cb5-96c6-55d1f028a202 devid 4 moved
old:/dev/dm-13 new:/dev/mapper/cryptdata4tb--vg-backup
Jul 10 19:32:29 black kernel: [33018.797161] BTRFS info (device sdc3):
device fsid 4d1ba5af-8b89-4cb5-96c6-55d1f028a202 devid 4 moved
old:/dev/mapper/cryptdata4tb--vg-backup new:/dev/dm-13
Jul 10 19:32:29 black kernel: [33019.061631] BTRFS info (device sdc3):
device fsid 4d1ba5af-8b89-4cb5-96c6-55d1f028a202 devid 4 moved
old:/dev/dm-13 new:/dev/mapper/cryptdata4tb--vg-backup

What is happening here is that each device is actually an LVM logical
volume, and it is known by a /dev/mapper name and a /dev/dm name. And
every 2 minutes something cause btrfs to notice that there are two names
for the same device and it swaps them around. Logging a message to say
it has done so. And doing it 4 times.

I presume that the swapping doesn't cause any problem. I wonder slightly
whether ordering guarantees and barriers all work correctly but I
haven't noticed any problems.

I also assume it has been doing this for a while -- just silently before
this patch came along.

Is btrfs noticing this itself or is something else (udev or systemd, for
example) triggering it?

Should I worry about it?

Is there any way to not have my log files full of this?

Graham

[This started with a Debian testing kernel a couple of months ago.
Current uname -a gives: Linux black 4.19.0-5-amd64 #1 SMP Debian
4.19.37-5 (2019-06-19) x86_64 GNU/Linux]
