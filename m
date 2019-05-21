Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1969A25896
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2019 22:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfEUUBB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 21 May 2019 16:01:01 -0400
Received: from smtprelay08.ispgateway.de ([134.119.228.98]:43446 "EHLO
        smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbfEUUBB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 May 2019 16:01:01 -0400
Received: from [94.217.151.102] (helo=[192.168.177.20])
        by smtprelay08.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <hendrik@friedels.name>)
        id 1hTAwT-0002wh-FX; Tue, 21 May 2019 22:00:57 +0200
From:   "Hendrik Friedel" <hendrik@friedels.name>
To:     "Rowland penny" <rpenny@samba.org>,
        sambalist <samba@lists.samba.org>,
        "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>,
        "Qu Wenruo" <quwenruo.btrfs@gmx.com>
Subject: Re[2]: [Samba] Fw: Btrfs Samba and Quotas
Date:   Tue, 21 May 2019 20:00:55 +0000
Message-Id: <em093fdc1c-abb5-4cc9-b346-ea270deca7c1@ryzen>
In-Reply-To: <c3c6eb4b-2af1-57d2-44ec-0596a2ac9c78@samba.org>
References: <emee6c041c-adec-4106-b8f6-c4665299ea29@ryzen>
 <em20253d9b-ed68-47a7-946b-55c040417fd6@ryzen>
 <bd91e229-90cc-f30e-1709-d8c55818af1a@samba.org>
 <em24499f72-5f4d-4fc2-8998-b81b877d8d3f@ryzen>
 <5bbcabdc-ac46-7481-64a8-b515745d72b4@samba.org>
 <em1a6d365f-4482-4553-81d9-dfa58a31f5d4@ryzen>
 <8954cf73-77a1-f313-6ea1-d9bdb142dced@samba.org>
 <emea02ad50-7e16-4771-9d78-37f0cde2bb16@ryzen>
 <c3c6eb4b-2af1-57d2-44ec-0596a2ac9c78@samba.org>
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

 >> In my impression: Yes. Also, this problem seems to affect also zfs 
and
 >
 > I'm mostly interested in the claim that ZFS is affected.
 > I haven't followed this thread carefully, but what exactly is the problem we're
 > talking about, and how do we know it impacts ZFS?
 > [Something more than a single one-liner in that bug report?]

Indeed, I only find that one line. I can try to find out.

 > Is the extent of the issue that quotas won't work, while enforced from Samba
 > against a ZFS volume?
 >
 > Can someone perhaps enlighten me? :)

The explaination is:

 > That's because the concept of a btrfs "subvolume" completely
 > breaks the POSIX idioms that smbd depends on.

And wouldn't that also be applicable to zfs?

>  At least I hope you can understand why some bug reports seem to take forever to get fixed, it is all down to priorities, the highest  priority ones get fixed first,

Yes, I understand that.

 > What I was trying to say was (and failing, it would seem), this is a 
two way street
 > and if OMV cannot/will not help you, then it is hard to fix,

What is OMV specific here? Isn't the problem fully included already in linux (=kernel) and samba?

 > especially now that Jeremy has pointed out that it cannot be fixed as is. Now this
 > doesn't mean it can never be fixed, throw enough money and man hours at it
 > and a workaround can probably be found

Here, I could imagine that linking with linux-btrfs would be worthwhile.

 > but this would undoubtedly entail OMV getting involved

Why? OMV merely writes the smb.conf...

Greetings,
Hendrik

