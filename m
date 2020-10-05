Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9463283DF8
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Oct 2020 20:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgJESGG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Oct 2020 14:06:06 -0400
Received: from smtp-33-i6.italiaonline.it ([213.209.14.33]:48546 "EHLO
        libero.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725960AbgJESGF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 5 Oct 2020 14:06:05 -0400
X-Greylist: delayed 490 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Oct 2020 14:06:04 EDT
Received: from venice.bhome ([78.12.28.19])
        by smtp-33.iol.local with ESMTPA
        id PUkBk7AY8kmT9PUkCk49Pi; Mon, 05 Oct 2020 19:57:52 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1601920673; bh=PiaZ8ueRoxoK7sGJGu+d6TPasSM6x+2dxbCO4WEvCT4=;
        h=From;
        b=WpVOrJiE8FC56vVtZxKnhxjZyyIvVwo6IpFwAuCEXNEr7i/0iOWaP4L96Xxd4xfSL
         xsjeQDwtGPyMhULgSRKUjUeyhCVXQohzojlfzRARZEGnunSsgrbREtj7GQuVA7Xbb6
         V+4pwl4smUIAGCvQUvSPjNeiL5zMwinCqarCDaIglA+PC8fjc/cU7hdkM4QOU6WGWz
         SoRJPPIGhuW6x8w2ypKE6PE1OFZI0/ZQ+v0rna6yIyHbZss3vXObnek/btslTJV8/0
         tPlkSKhyAyUo2q5g30+fZc55lCrRqiXCoDV9z2sGl+GVB1ADhNDIdPRciCvoVZO7K/
         qtUHHFCNg/rew==
X-CNFS-Analysis: v=2.4 cv=ecuDw5IH c=1 sm=1 tr=0 ts=5f7b5ea0 p=kT-NTsFwAAAA:8
 a=+Je5yw9QCSN6miOTP6/PEA==:117 a=+Je5yw9QCSN6miOTP6/PEA==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=maIFttP_AAAA:8 a=vRQcf1xN0crJTZ_7EEMA:9
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=TLwuWKmryFjkTYsgBL5T:22
 a=qR24C9TJY6iBuJVj_x8Y:22
Reply-To: kreijack@inwind.it
Subject: Re: using raid56 on a private machine
To:     cryptearth <cryptearth@cryptearth.de>, linux-btrfs@vger.kernel.org
References: <dbf47c42-932c-9cf0-0e50-75f1d779d024@cryptearth.de>
Cc:     Josef Bacik <jbacik@fb.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <91a18b63-6211-08e1-6cd9-8ef403db1922@libero.it>
Date:   Mon, 5 Oct 2020 19:57:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <dbf47c42-932c-9cf0-0e50-75f1d779d024@cryptearth.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfID9+asp2TNiBZjn5uaBzT26Vv1BWPJGFXsEOMfGftDshAGO5xp9LBJe6VAFux8nFJf5GCs6FgobUI9Ab+U3fra2OClsb0+qy/H3NQ5/VAetNORB56Ny
 zIseQCMQUJTozRe5vJ/l6SxssSq+GQX78XSTgDj0EIN8DzcEVKV346azkImbxdg/aaqy1KqYI/eCgAmgNn7IHqIzmQIEF5nFYqbGNePIH/jC3kbpHnVxSPkt
 zK7amhwqahxLFZfsQ87QxD7zCXp5U3C3o81OZrXvoaTNYfG3VHxvKqdotxqarzke
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/5/20 6:59 PM, cryptearth wrote:
> Hello there,
> 
> as I plan to use a 8 drive RAID6 with BtrFS I'd like to ask about the current status of BtrFS RAID5/6 support or if I should go with a more traditional mdadm array.
> 
> The general status page on the btrfs wiki shows "unstable" for RAID5/6, and it's specific pages mentions some issue marked as "not production ready". It also says to not use it for the metadata but only for the actual data.
> 
> I plan to use it for my own personal system at home - and I do understand that RAID is no replacement for a backup, but I'd rather like to ask upfront if it's ready to use before I encounter issues when I use it.
> I already had the plan about using a more "traditional" mdadm setup and just format the resulting volume with ext4, but as I asked about that many actually suggested to me to rather use modern filesystems like BtrFS or ZFS instead of "old school RAID".
> 
> Do you have any help for me about using BtrFS with RAID6 vs mdadm or ZFS?

Zygo collected some useful information about RAID5/6:

https://lore.kernel.org/linux-btrfs/20200627032414.GX10769@hungrycats.org/

However more recently Josef (one of the main developers), declared that BTRFS with RAID5/6 has  "...some dark and scary corners..."

https://lore.kernel.org/linux-btrfs/bf9594ea55ce40af80548888070427ad97daf78a.1598374255.git.josef@toxicpanda.com/

> 
> I also don't really understand why and what's the difference between metadata, data, and system.
> When I set up a volume only define RAID6 for the data it sets metadata and systemdata default to RAID1, but doesn't this mean that those important metadata are only stored on two drives instead of spread accross all drives like in a regular RAID6? This would somewhat negate the benefit of RAID6 to withstand a double failure like a 2nd drive fail while rebuilding the first failed one.

Correct. In fact Zygo suggested to user RAID6 + RAID1C3.

I have only few suggestions:
1) don't store valuable data on BTRFS with raid5/6 profile. Use it if you want to experiment and want to help the development of BTRFS. But be ready to face the lost of all data. (very unlikely, but more the size of the filesystem is big, more difficult is a restore of the data in case of problem).
2) doesn't fill the filesystem more than 70-80%. If you go further this limit the likelihood to catch the "dark and scary corners" quickly increases.
3) run scrub periodically and after a power failure ; better to use an uninterruptible power supply (this is true for all the RAID, even the MD one).
4) I don't have any data to support this; but as occasional reader of this mailing list I have the feeling that combing BTRFS with LUCKS(or bcache) raises the likelihood of a problem.
5) pay attention that having an 8 disks raid, raises the likelihood of a failure of about an order of magnitude more than a single disk ! RAID6 (or any other RAID) mitigates that, in the sense that it creates a time window where it is possible to make maintenance (e.g. a disk replacement) before the lost of data.
6) leave the room in the disks array for an additional disk (to use when a disk replacement is needed)
7) avoid the USB disks, because these are not reliable


> 
> Any information appreciated.
> 
> 
> Greetings from Germany,
> 
> Matt


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
