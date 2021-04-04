Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0068353847
	for <lists+linux-btrfs@lfdr.de>; Sun,  4 Apr 2021 15:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhDDNpZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 4 Apr 2021 09:45:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:60596 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229665AbhDDNpZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 4 Apr 2021 09:45:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ABEE6ABB1;
        Sun,  4 Apr 2021 13:45:19 +0000 (UTC)
Subject: Re: APFS and BTRFS
To:     Forrest Aldrich <forrie@gmail.com>, linux-btrfs@vger.kernel.org
References: <f2508894-5198-7c33-bec7-b731667f597b@gmail.com>
From:   Michal Rostecki <mrostecki@suse.de>
Message-ID: <110677dd-2969-c913-38d2-c9dd729afe0c@suse.de>
Date:   Sun, 4 Apr 2021 14:45:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <f2508894-5198-7c33-bec7-b731667f597b@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/20/21 4:09 PM, Forrest Aldrich wrote:
> I have a really large (3+ TB) volume I am copying to a BTRFS volume 
> (both over USB) which is painfully slow.  In fact, it will probably take 
> days to complete.   My goal is to use BTRFS on that larger USB volume 
> (it's an 18TB drive)....
> 
> I don't suppose there is a way to convert APFS to BTRFS :)   I know, but 
> I thought I would ask as it seems like others may have a similar query.
> 
> 
> Thx...

Hi Forrest,

No, there is no other option than copying the data. Converting 
partitions automatically with btrfs-convert is supported only for 
ext2/3/4 and reiserfs, though it's still not recommended without backups 
and might fail.

https://btrfs.wiki.kernel.org/index.php/Manpage/btrfs-convert

Cheers,
Michal
