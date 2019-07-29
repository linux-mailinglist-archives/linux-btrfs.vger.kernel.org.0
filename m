Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A411078CFE
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2019 15:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfG2NkA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Jul 2019 09:40:00 -0400
Received: from ns.bouton.name ([109.74.195.142]:56434 "EHLO mail.bouton.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726627AbfG2NkA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Jul 2019 09:40:00 -0400
Received: from [192.168.30.57] (laubervilliers-657-1-19-239.w80-15.abo.wanadoo.fr [80.15.154.239])
        by mail.bouton.name (Postfix) with ESMTP id 0EB92B845;
        Mon, 29 Jul 2019 15:39:59 +0200 (CEST)
From:   Lionel Bouton <lionel-subscription@bouton.name>
Subject: Re: Massive filesystem corruption since kernel 5.2 (ARCH)
To:     =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>,
        linux-btrfs@vger.kernel.org
References: <bcb1a04b-f0b0-7699-92af-501e774de41a@petaramesh.org>
 <f8b08aec-2c43-9545-906e-7e41953d9ed4@bouton.name>
Message-ID: <02f206eb-0c36-6ba7-94ce-f50fa3061271@bouton.name>
Date:   Mon, 29 Jul 2019 15:39:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <f8b08aec-2c43-9545-906e-7e41953d9ed4@bouton.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Le 29/07/2019 à 15:29, Lionel Bouton a écrit :
> Hi,
>
> Le 29/07/2019 à 14:32, Swâmi Petaramesh a écrit :
>> Hi list,
>>
>> I've been using BTRFS for years on a whole lot of machines witch complex
>> configurations (in RAID, over LUKS, with bcache etc) and was happy I
>> never lost ONE byte.
>>
>> Well, since I upgraded my main laptop to Arch Linux kernel 5.2, I
>> IMMEDIATELY got my laptop's SSD BTRFS FS (over LUKS) corrupt, and have
>> to rebuild and restore it.
>
> For another reference point, my personal laptop reports 17 days of
> uptime on 5.2.0-arch2-1-ARCH.
> I use BTRFS both over LUKS over LVM and directly over LVM. The system
> is suspended during the night and running otherwise (probably more
> than 16 hours a day).
>
> I don't have any problem so far. I'll reboot right away and reply to
> this message (if you see it and not a reply shortly after, there might
> be a bug affecting me too).

My laptop rebooted without problems. Note : my system uses a NVMe
device, not a SATA SSD.

Lionel

Edit: resent in pure text (Thunderbird seems to have forgotten that
linux-btrfs refuses HTML).
