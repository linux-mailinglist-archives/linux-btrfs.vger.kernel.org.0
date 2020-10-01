Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7642802BD
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Oct 2020 17:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732449AbgJAP2Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Oct 2020 11:28:16 -0400
Received: from mailrelay2-3.pub.mailoutpod1-cph3.one.com ([46.30.212.11]:51306
        "EHLO mailrelay2-3.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730534AbgJAP2Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Oct 2020 11:28:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lechevalier.se; s=20191106;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version:date:
         message-id:from:references:cc:to:subject:from;
        bh=t7bkS1VEsBFBc3nVPA04mzGs4JuqBDxfovycieI85PI=;
        b=sBwwq3tdXSSBkL/UnkPkzd7JNkVCRYJyIvpnR1NjN7FLSfEAjytpvhFMVt2ftEVQxxQWlOAqYvh55
         66lI/8RRxGIJh9at/twy7Z3xsYpjYxjh/4FvoGEXvhGSmc+HQsjUzC3h0dzIlcZf+b1xI0NYHy8Lvs
         ZGndsYeSscxhvnIxW3E9JydEIJOFgFt97DjIvSfWoEEtnlRIHK8NNefT82RjtCEodrxUFUFqm34xK5
         VB1DaiSD8mNBE93k1hwjpMF+7s417TFIY3/LpIDHR+qLgwob92M4XlbOC5oKTAaqdhGLXnLjYGlh9v
         AXav+GuDbWZ4jkmKzPt/yloYMnwBeag==
X-HalOne-Cookie: 10f930dd8fc5703e50af513ce900fa26cdbbd471
X-HalOne-ID: b82a712e-03fa-11eb-84a6-d0431ea8a290
Received: from [192.168.0.10] (h-131-138.a357.priv.bahnhof.se [81.170.131.138])
        by mailrelay2.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id b82a712e-03fa-11eb-84a6-d0431ea8a290;
        Thu, 01 Oct 2020 15:28:13 +0000 (UTC)
Subject: Re: how to recover from "enospc errors during balance"
To:     Giovanni Biscuolo <g@xelera.eu>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
References: <87r1qk4q4d.fsf@roquette.i-did-not-set--mail-host-address--so-tickle-me>
 <20200930000417.GH5890@hungrycats.org>
 <878scq1g0g.fsf@roquette.i-did-not-set--mail-host-address--so-tickle-me>
From:   A L <mail@lechevalier.se>
Message-ID: <0afae20d-62d2-00eb-4ac5-fa9b5205a937@lechevalier.se>
Date:   Thu, 1 Oct 2020 17:28:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <878scq1g0g.fsf@roquette.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020-10-01 10:56, Giovanni Biscuolo wrote:
> [...]
>
>>> I tried to add a new device (I have 2 spare disks) but it does not work
>>> with a read-only filesystem.
>>>
>>> Please how can I remount the filesystem read-write and free some space
>>> deleting some files?
>> Add 'skip_balance' to mount options so that the next mount will not
>> attempt to resume balancing metadata.  Keep mounting and umounting
>> (not remounting) until it completes orphan and relocation cleanup (it
>> may take more than one attempt, probably fewer than 20 attempts).
> I try to mount with this command:
>
> --8<---------------cut here---------------start------------->8---
>
> ~$ mount -o skip_balance,relatime,ssd,subvol=/ /dev/sda3 /
> mount: /: wrong fs type, bad option, bad superblock on /dev/sda3, missing codepage or helper program, or other error.
>
> --8<---------------cut here---------------end--------------->8---
>
> dmesg says:
>
> --8<---------------cut here---------------start------------->8---
>
> [7484575.970136] BTRFS info (device sda3): disk space caching is enabled
> [7484576.001375] BTRFS error (device sda3): Remounting read-write after error is not allowed
>
> --8<---------------cut here---------------end--------------->8---
>
> Am I doing something wrong?
>
> It seems that the filesystem is not allowed to be remounted RW after the
> error.
>
> I don't think rebooting is a good option since it will be unbootable
> (and it's a remote machine).
>
> I fear the only option is to reboot from USB and revover :(
>
> Do you have any other option in mind please?
I think you need to mount an unmounted filesystem and not re-mounting it 
(as per dmesg output).

Example: "mount -o skip_balance /media && btrfs balance cancel /media"

However, I think this is your root filesystem, correct? They you must 
boot with a bootable media and do recovery from there

Just remember that deleting data on Btrfs can increase metadata usage, 
especially if you have lots of snapshots and such. In the case your 
filesystem goes back into ro mode when deleting files, you may need to 
add two additional disks (or loop devices, usb sticks etc) to continue.

