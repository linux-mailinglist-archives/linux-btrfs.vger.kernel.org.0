Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0552CB5063
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2019 16:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbfIQOcK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Sep 2019 10:32:10 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:33141 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbfIQOcJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Sep 2019 10:32:09 -0400
Received: from webmail.gandi.net (webmail19.sd4.0x35.net [10.200.201.19])
        (Authenticated sender: pierre-alexis@ciavaldini.fr)
        by relay12.mail.gandi.net (Postfix) with ESMTPA id DD5E4200003
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Sep 2019 14:32:07 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 17 Sep 2019 16:32:07 +0200
From:   pierre-alexis@ciavaldini.fr
To:     linux-btrfs@vger.kernel.org
Subject: btrfs crash in raid1 setup
Message-ID: <0e808a972809f2a193f5a201e46c64f7@ciavaldini.fr>
X-Sender: pierre-alexis@ciavaldini.fr
User-Agent: Roundcube Webmail/1.3.8
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I'm having a massive crash of my BTRFS volume.

The server is a HP ProLiant DL380G6 running CentOS on an xfs volume. It 
is attached to a HP StorageWorks JBOD device which contains 8 drives, 
each formatted as single-volume raid0 devices visible by the OS as 
`/dev/sd{b-i}`. `/dev/sdf` is not formatted for BTRFS, otherwise all 7 
other devices are formatted as full-drive BTRFS (no partitions). The 
BTRFS volume is a raid1 volume, keeping my data and metadata on at least 
2 different drives. At 4:30am on Sep 7, a backup from a remote system 
came in, finished at 04:34:40, and at 04:35:03 the local system crashed 
with the following log. After a lot of operations described below, I can 
mount the filesystem but it does not show any folders anymore except a 
'lost+found' folder of 1GB. The BTRFS fi show still shows the (correct) 
use of 4+ TB.

kernel error log:
https://pastebin.com/7T58UwGn

The local system is used to backup a remote system (~20GB) but also to 
store a lot (4TB) of data (photo and video, projects, ...). This lot of 
data is not backed up anywhere else, it was the plan but the crash 
happened before i could buy the hardware for a second fallback setup. It 
has run nicely for a year, with a few fixing scrubs and a replaced 
hardware faulty drive (`/dev/sdf` -> `/dev/sdi`). I noticed the crash 
yesterday (2019/09/17) and issued the following commands, I truncated 
the output of thousands of similar lines.

actions taken:
https://pastebin.com/u7H5R9fS

Any help how to recover as much data as possible would be welcome.
Thank you.
Pierre-Alexis Ciavaldini
