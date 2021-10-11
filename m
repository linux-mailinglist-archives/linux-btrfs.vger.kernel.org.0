Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55BDA428E86
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 15:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234354AbhJKNtH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 09:49:07 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53244 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbhJKNtG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 09:49:06 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 717DE1FEAC;
        Mon, 11 Oct 2021 13:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633960025; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8pKjUHL3mpciGcNQdaeJn8clKZ+d0c55JCELdb/rrNU=;
        b=QiMPvacOdlQkxNVIW9ZtfHX7KpZvptEaeylLSFzitiwdwlaao7yaWXfSJ5ITjid3IqWM/8
        MFSD/i5EYgBOysW42ZhFmMDzCJRR8SBCQQxqlEhMC0T4CkJrYCpSTKoNsGzGoPIx6chLr8
        VvP1UJKwEsV4XMM3GrAC8ugyfrblwo0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 490C913C5E;
        Mon, 11 Oct 2021 13:47:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pdU3D1lAZGHzIAAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 11 Oct 2021 13:47:05 +0000
Subject: Re: No space left even there is a lot of space
To:     Michal Strnad <michal.strnad@ibt.cas.cz>,
        linux-btrfs@vger.kernel.org
References: <8d31b2f5-5474-6e12-fd9b-56aa378069f4@ibt.cas.cz>
 <4b21c3a5-f8f2-fd25-0f9a-b22cfdf27fe6@suse.com>
 <7a7d2b07-b8d7-bd6f-f652-1a0646db478a@ibt.cas.cz>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <baf73902-e13a-bd3b-76be-88a3078bca4f@suse.com>
Date:   Mon, 11 Oct 2021 16:47:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <7a7d2b07-b8d7-bd6f-f652-1a0646db478a@ibt.cas.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11.10.21 г. 16:44, Michal Strnad wrote:
> Hi Nikolay,
> 
> On 10/11/21 2:34 PM, Nikolay Borisov wrote:
>>
>>
>> On 11.10.21 г. 15:30, Michal Strnad wrote:
>>> Hello,
>>>
>>> I have problem on production server with Btrfs. I got call trace in
>>> dmesg with "No space left" message which led to the filesystem being
>>> switched to read-only, but both df (system df and btrfs df) say I've got
>>> lots of space.
>>>
>>
>> <snip>
>>
>>>
>>>
>>> [root@kappa ~]# uname -a
>>> Linux kappa.ibt.biocev.org 3.10.0-1160.42.2.el7.x86_64 #1 SMP Tue Sep 7
>>> 14:49:57 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
>>
>>
>> This is a vendor kernel and it is likely missing multiple fixes to our
>> ENOSPC machinery. Best advice is to update to some upstream kernel.
>>
> 
> Do you recommend a specific kernel version?

Latest stable, if this is considered too bleeding edge, at least latest
LTS - 5.10 based one.

> 
> I will probably have to compile kernel from source on my CentOS 7, or
> can I use ELrepo (that would be an easier method for me)?

I'm not familiar with what elrepo provides so can't say.

> 
> Thank you
> 
> Regards,
> Michal Strnad
> 
