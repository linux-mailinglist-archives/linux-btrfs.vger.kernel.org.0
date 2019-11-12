Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72D49F9B33
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2019 21:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfKLUst (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Nov 2019 15:48:49 -0500
Received: from server.roznica.com.ua ([80.90.224.56]:39308 "EHLO
        server.roznica.com.ua" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfKLUst (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Nov 2019 15:48:49 -0500
Received: from work.roznica.com.ua (h244.onetel95.onetelecom.od.ua [91.196.95.244])
        by server.roznica.com.ua (Postfix) with ESMTP id 852BA7271CC
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2019 22:48:47 +0200 (EET)
Subject: Re: btrfs based backup?
To:     linux-btrfs@vger.kernel.org
References: <20191112183425.GA1257@tik.uni-stuttgart.de>
From:   Michael <mclaud@roznica.com.ua>
Message-ID: <ccd91228-b51f-f0ac-5deb-72c261679dd7@roznica.com.ua>
Date:   Tue, 12 Nov 2019 22:48:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191112183425.GA1257@tik.uni-stuttgart.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

12.11.2019 20:34, Ulli Horlacher пишет:
> I need a new backup system for some servers. Destination is a RAID, not
> tapes.
>
> So far I have used a self written shell script. 25 years old, over 1000
> lines of (HORRIBLE) code, no longer maintenable :-}
>
> All backup software I know is either too primitive (e.g. no versioning) or
> very complex and needs a long time to master it.
>
> My new idea is:
>
> Set up a backup server with btrfs storage (with compress mount option),
> the clients do their backup with rsync over nfs.
>
> For versioning I make btrfs snapshots.
>
>
> To have a secondary backup I will use btrfs send / receive,

Check my message with subject *"**Read-only snapshot send speed very 
slow after modify original data. Need help 
<https://www.spinics.net/lists/linux-btrfs/msg94128.html>*/"./

/Very-very slow send read-only snapshot after modify original rw subvol 
if compress. In some cases ~8-15 hour per snapshot./

/100cpu load and send only 5-100mb diff./
/There is no reaction
/

>
> Any comments on this? Or better suggestions?
>
> The backup software must be open source!
>

-- 
С уважением, Михаил
067-786-11-75
