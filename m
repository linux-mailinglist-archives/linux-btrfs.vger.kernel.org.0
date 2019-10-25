Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0500E55A4
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2019 23:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbfJYVK2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Oct 2019 17:10:28 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:33507 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbfJYVK2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Oct 2019 17:10:28 -0400
X-Originating-IP: 37.170.99.6
Received: from [192.168.43.75] (unknown [37.170.99.6])
        (Authenticated sender: swami@petaramesh.org)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id CA5721C0005;
        Fri, 25 Oct 2019 21:10:25 +0000 (UTC)
Subject: Re: Btrfs progs release 5.3.1
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20191025121535.28802-1-dsterba@suse.com>
From:   =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>
Message-ID: <22dd7053-8f00-03c0-a803-4b8f897efcea@petaramesh.org>
Date:   Fri, 25 Oct 2019 23:10:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191025121535.28802-1-dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

Le 25/10/2019 à 14:15, David Sterba a écrit :
> btrfs-progs version 5.3.1 have been released.
> 
> This fixes (only) linking against libbtrfs (reported by snapper users).
> I did houpefully enough testing, the CI is green, builds on various arches, and
> snapper running with the library from 5.3.1 works.

Now it looks unhappy on my #Arch...


root@zafu:/# inxi -S
System:    Host: zafu Kernel: 5.3.7-arch1-1-ARCH x86_64 bits: 64 
Desktop: Cinnamon 4.2.4 Distro: Arch Linux

root@zafu:/# pacman -Qs btrfs-progs
local/btrfs-progs 5.3-1
     Btrfs filesystem utilities

root@zafu:/# pacman -Qs snapper
local/snap-pac 2.3.1-1
     Pacman hooks that use snapper to create pre/post btrfs snapshots 
like openSUSE's YaST

root@zafu:/# snapper list
snapper: symbol lookup error: /usr/lib/libbtrfs.so.0: undefined symbol: 
write_raid56_with_parity



ॐ

-- 
Swâmi Petaramesh <swami@petaramesh.org> PGP 9076E32E
