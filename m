Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79EA31C0478
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Apr 2020 20:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgD3SNj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Apr 2020 14:13:39 -0400
Received: from ciao.gmane.io ([159.69.161.202]:46906 "EHLO ciao.gmane.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbgD3SNi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Apr 2020 14:13:38 -0400
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <gcfb-btrfs-devel-moved1-3@m.gmane-mx.org>)
        id 1jUDgn-0004mH-C1
        for linux-btrfs@vger.kernel.org; Thu, 30 Apr 2020 20:13:37 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-btrfs@vger.kernel.org
From:   Jean-Denis Girard <jd.girard@sysnux.pf>
Subject: Re: Extremely slow device removals
Date:   Thu, 30 Apr 2020 08:13:31 -1000
Message-ID: <r8f4gb$8qt$1@ciao.gmane.io>
References: <8b647a7f-1223-fa9f-57c0-9a81a9bbeb27@ka9q.net>
 <14a8e382-0541-0f18-b969-ccf4b3254461@ka9q.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <14a8e382-0541-0f18-b969-ccf4b3254461@ka9q.net>
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Le 30/04/2020 à 07:31, Phil Karn a écrit :
> I started the operation 5 days ago, and of right now I still have 2.18
> TB to move off the drive I'm trying to replace. I think it started
> around 3.5 TB.

Hi Phil,

I did something similar one month ago. It took less than 4 hours for
1.71 TiB of data:

[xxx@taina ~]$ sudo btrfs replace status /home/SysNux
Started on 21.Mar 11:13:20, finished on 21.Mar 15:06:33, 0 write errs, 0
uncorr. read errs

[xxxg@taina ~]$ sudo btrfs fi show /home/SysNux/
Label: none  uuid: c5b8386b-b81d-4473-9340-7b8a74fc3a3c
        Total devices 2 FS bytes used 1.70TiB
        devid    1 size 1.82TiB used 1.71TiB path /dev/bcache2
        devid    2 size 1.82TiB used 1.71TiB path /dev/bcache0

These disks are behind bcache, which may have a positive impact. Also my
system is Fedora 31, and it was with 5.5 kernel, much more recent than
yours.

> Should I reboot degraded without this drive and do a "remove missing"
> operation instead? I'm willing to take the risk of losing another drive
> during the operation if it'll speed this up. It wouldn't be so bad if it
> weren't slowing my filesystem to a crawl for normal stuff, like reading
> mail.

No idea, I'm just a (happy) Btrfs user.


Hope this helps,
-- 
Jean-Denis Girard

SysNux                   Systèmes   Linux   en   Polynésie  française
https://www.sysnux.pf/   Tél: +689 40.50.10.40 / GSM: +689 87.797.527




