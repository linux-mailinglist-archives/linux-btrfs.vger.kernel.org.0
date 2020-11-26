Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 474C12C5B4F
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Nov 2020 19:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404582AbgKZSC2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Nov 2020 13:02:28 -0500
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:44694 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391735AbgKZSC2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Nov 2020 13:02:28 -0500
X-Greylist: delayed 385 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Nov 2020 13:02:27 EST
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id EEF873F4C7
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Nov 2020 18:55:53 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -1.901
X-Spam-Level: 
X-Spam-Status: No, score=-1.901 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, NICE_REPLY_A=-0.001]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hmPoZRRrf21U for <linux-btrfs@vger.kernel.org>;
        Thu, 26 Nov 2020 18:55:53 +0100 (CET)
Received: by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 4D7213F47A
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Nov 2020 18:55:52 +0100 (CET)
Received: from [192.168.0.10] (port=55390)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.93.0.4)
        (envelope-from <mail@lechevalier.se>)
        id 1kiLUt-0000Q8-Up
        for linux-btrfs@vger.kernel.org; Thu, 26 Nov 2020 18:55:59 +0100
Subject: Re: State of BTRFS
To:     linux-btrfs Mailinglist <linux-btrfs@vger.kernel.org>
References: <trinity-ca02807b-66c1-46e7-a4ed-efa79636413b-1606411979151@3c-app-gmx-bs37>
From:   A L <mail@lechevalier.se>
Message-ID: <6c2a1f42-962b-0671-2313-25e0b1fb0537@lechevalier.se>
Date:   Thu, 26 Nov 2020 18:55:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <trinity-ca02807b-66c1-46e7-a4ed-efa79636413b-1606411979151@3c-app-gmx-bs37>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020-11-26 18:32, Steve Keller wrote:
> What is the state of btrfs concerning stability and reliability?
I think that the general opinion is that Btrfs profiles 
single,dup,RAID0,RAID1,RAID10,RAID1c34 are safe to use. RAID5/6 has 
issues and is not recommended unless you are experienced with Btrfs.

> Is it safe to my /home file system on btrfs?  I need no RAID,
> currently, as I have mdraid with LVM on top of that already, and I
> have an LVM volume for /home.  But I do like snapshots and would
> probably use them quite a lot.
In this configuration, Btrfs will be able to detect corruptions (bit 
files, faulty data, etc) but be able to repair it. Depending on your 
needs for LVM it may be better to run Btrfs RAID1 so you can utilize the 
full features of Btrfs that protects you from corrupt data.

You should read up on the risks with using volume managers underneath 
Btrfs. For example you can have issues if you use LVM snapshots.

>
> Currently, I have ext4 for /home but I consider switching to btrfs.
> But I want to be really sure not to loose data or otherwise have
> to repair the file system.
>
> Steve
>
Should not be less safe than copying your files over to the new Btrfs 
volume. I would not use btrfs-convert to convert the ext4 to Btrfs. 
Instead set up a new Btrfs volume and copy the files there.


