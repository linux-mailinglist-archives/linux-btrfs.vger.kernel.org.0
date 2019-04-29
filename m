Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC320E795
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2019 18:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbfD2QSo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 29 Apr 2019 12:18:44 -0400
Received: from smtprelay08.ispgateway.de ([134.119.228.109]:10434 "EHLO
        smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728666AbfD2QSn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Apr 2019 12:18:43 -0400
Received: from [94.217.144.7] (helo=[192.168.177.20])
        by smtprelay08.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <hendrik@friedels.name>)
        id 1hL8zI-0004Lv-GK; Mon, 29 Apr 2019 18:18:40 +0200
From:   "Hendrik Friedel" <hendrik@friedels.name>
To:     "Austin S. Hemmelgarn" <ahferroin7@gmail.com>,
        "Andrei Borzenkov" <arvidjaar@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Fw: Re[2]: Migration to BTRFS
Date:   Mon, 29 Apr 2019 16:18:39 +0000
Message-Id: <em8cc4b9a0-902a-4ce3-8fee-a5a3320b6fc4@ryzen>
Reply-To: "Hendrik Friedel" <hendrik@friedels.name>
User-Agent: eM_Client/7.2.34062.0
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Df-Sender: aGVuZHJpa0BmcmllZGVscy5uYW1l
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,
>>With "single" data profile you won't lose filesystem, but you will
>>irretrievably lose any data on the missing drive. Also "single" profile
>>does not support auto-healing (repairing of bad copy from good copy). If
>>this is acceptable to you, then yes, both variants will do what you want.
>Actually, it's a bit worse than this potentially.  You may lose individual files if you lose one disk with the proposed setup, but you may also lose _parts_ of individual files, especially if you have lots of large (>1-5GB in size) files.
You mean if parts of the files are on the failed drive, or what do you 
have in mind?

>   And on top of this, finding what data went missing will essentially require trying to read every byte of every file in the volume.
Why is that and how would it be done (scrub, I suppose?)
I am wondering, why the design of 'single' is that way? It seems to me, 
that this is unneccessarily increasing the failure probability. My 
thinking: If I have two separate file-systems, I have a FP of Z, with Z 
the probability of one drive to fail. If I one btrfs-system in single 
profile, I have a FP of Z^N, wheras it could -with a different design- 
still be Z, no?
>>As of today there is no provision for automatic mounting of incomplete
>>multi-device btrfs in degraded mode. Actually, with systemd it is flat
>>impossible to mount incomplete btrfs because standard framework only
>>proceeds to mount it after all devices have been seen.
Do you talk about the mount during boot or about mounting in general?

 > If I where you, with your use case I would consider using mhddfs
 > https://romanrm.net/mhddfs which is filesystem agnostic layer on top of 2x [-m
 > DUP, -d SINGLE] BTRFS drives. Last time I tested mhddfs (about 5+ years ago) it
 > was dead slow, but that might not be very important to you. For what it does it
 > works great!

In fact, that is what I am using today. But when using snapshots, this 
would become a bit messy (having to do the snapshot on each device 
separately, but identically.

 > remember that backup is not a backup unless it has a extra backup

I do have two backups (one offsite) of all data that is irreplacable and 
one of data that is nice to have (TV-Recordings).


Greetings,
Hendrik

