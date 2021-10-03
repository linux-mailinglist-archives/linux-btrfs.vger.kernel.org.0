Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB3A42014E
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Oct 2021 13:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhJCL2S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 3 Oct 2021 07:28:18 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:26914 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbhJCL2S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 3 Oct 2021 07:28:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id AC5A93F3E5;
        Sun,  3 Oct 2021 13:26:28 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -1.901
X-Spam-Level: 
X-Spam-Status: No, score=-1.901 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, NICE_REPLY_A=-0.001]
        autolearn=ham autolearn_force=no
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iYzO1VkVkhob; Sun,  3 Oct 2021 13:26:27 +0200 (CEST)
Received: by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 71ABC3F3E7;
        Sun,  3 Oct 2021 13:26:27 +0200 (CEST)
Received: from [192.168.0.10] (port=52809)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1mWzdS-000Esv-HT; Sun, 03 Oct 2021 13:26:26 +0200
From:   Forza <forza@tnonline.net>
Subject: Re: btrfs metadata has reserved 1T of extra space and balances don't
 reclaim it
To:     brandonh@wolfram.com
Cc:     linux-btrfs@vger.kernel.org
References: <70668781.1658599.1632882181840.JavaMail.zimbra@wolfram.com>
 <ce9f317.4dc05cb0.17c3070258f@tnonline.net>
 <2117366261.1733598.1632926066120.JavaMail.zimbra@wolfram.com>
Message-ID: <cda76e1b-b98a-4b13-19b1-2cf6ea8b4cf4@tnonline.net>
Date:   Sun, 3 Oct 2021 13:26:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <2117366261.1733598.1632926066120.JavaMail.zimbra@wolfram.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021-09-29 16:34, Brandon Heisner wrote:
> No I do not use that option.  Also, because of btrfs not mounting individual subvolume options, I have the compression and nodatacow set with filesystem attributes on the directories that are btrfs subvolumes.
> 
> UUID=ece150db-5817-4704-9e84-80f7d8a3b1da /opt/zimbra           btrfs   subvol=zimbra,defaults,discard,compress=lzo 0 0
> UUID=ece150db-5817-4704-9e84-80f7d8a3b1da /var/log              btrfs   subvol=root-var-log,defaults,discard,compress=lzo 0 0
> UUID=ece150db-5817-4704-9e84-80f7d8a3b1da /opt/zimbra/db        btrfs   subvol=db,defaults,discard,nodatacow 0 0
> UUID=ece150db-5817-4704-9e84-80f7d8a3b1da /opt/zimbra/index     btrfs   subvol=index,defaults,discard,compress=lzo 0 0
> UUID=ece150db-5817-4704-9e84-80f7d8a3b1da /opt/zimbra/store     btrfs   subvol=store,defaults,discard,compress=lzo 0 0
> UUID=ece150db-5817-4704-9e84-80f7d8a3b1da /opt/zimbra/log       btrfs   subvol=log,defaults,discard,compress=lzo 0 0
> UUID=ece150db-5817-4704-9e84-80f7d8a3b1da /opt/zimbra/snapshots btrfs   subvol=snapshots,defaults,discard,compress=lzo 0 0
> 
> 

It might be worth looking into discard=async (*) or setting up regular 
fstrim instead of doing the discard mount option.

* async discard:
"mount -o discard=async" to enable it freed extents are not discarded 
immediatelly, but grouped together and trimmed later, with IO rate limiting
* https://lore.kernel.org/lkml/cover.1580142284.git.dsterba@suse.com/
