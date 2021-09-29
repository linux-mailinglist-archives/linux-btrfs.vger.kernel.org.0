Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482D941C4F3
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Sep 2021 14:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343920AbhI2MxH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Sep 2021 08:53:07 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38922 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343839AbhI2MxH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Sep 2021 08:53:07 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5F99320368;
        Wed, 29 Sep 2021 12:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632919885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=emLYCFuzjNX4odOW4wkkUW8adYX9wAwY4Qq3LqtD9x0=;
        b=b5IqtkkeM/Q5VtEjHUE1CqkOoKFTsU85ZTF+UHvZvfwY2663dyq57ElMpVy8tJuSk4eLdt
        gmFKV/nE0OL+F98XtsJR4qRQTePEg0nrSeDQBhvD2E/U2Wd/lvcfw5ENQPh02/OXlwElk3
        HibsRLEQaKx8/KL8xUVitnzCxDxIprc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2FD3713FE7;
        Wed, 29 Sep 2021 12:51:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tnX8CE1hVGHyPgAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 29 Sep 2021 12:51:25 +0000
Subject: Re: [PATCH 1/2] btrfs-progs: Ignore path device during device scan
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <20210928123730.393551-1-nborisov@suse.com>
 <50f82537-0ccc-701d-215a-f45c20c0827b@oracle.com>
 <9330f390-f561-7358-f932-46fd580f98e5@suse.com>
 <036be5f7-642b-60b4-f862-7541e65c0551@oracle.com>
 <42ce59f6-4458-5cf9-351e-7fa81d62ebf5@suse.com>
 <c2828ccd-80a2-a7c9-0282-bb58046375c3@oracle.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <02fed018-c02b-6c7b-f7c6-63f25d3743d1@suse.com>
Date:   Wed, 29 Sep 2021 15:51:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <c2828ccd-80a2-a7c9-0282-bb58046375c3@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 29.09.21 г. 15:44, Anand Jain wrote:
> 
> 
>>>> flap means going up and down. The gist is that btrfs fi show would show
>>>> the latest device being scanned, which in the case of multipath device
>>>> could be any of the paths.
> 
>   But why the problem is only when a device flaps? Or it doesn't matter?

Because when the device re-appears it will be the last device scanned by
btrfs scanning code. It can be reproduced by following steps:

1) Validate 'btrfs fi show' is showing /dev/mapper/xxxx for all fs's
1) Unplug one of the cables from the FC adapter < this can be simulated
by simply doing 'echo 1 > /sys/block/sdd/device/delete' for the given
path device >
2) Wait for the paths/drives associated with the downed port to disappear
3) Check again that 'btrfs fi show' still lists the /dev/mapper entry
4) Reattach the cable to the hba port <this can be simulated by
rescanning the HBA or w/e bus you have: echo "- - -" >
/sys/class/scsi_host/host1/scan >
5) Check that 'btrfs fi show' is now shows /dev/sdX devices for all mpio
fs's

> 
>>>   Do you mean 'btrfs fi show' shows a device of the multi-path however,
>>>   'btrfs fi show -m' shows the correct multi-path device?
>>
>> Yes, that's a problem purely in btrfs-progs, as the path devices are
>> opened exclusively for the purpose of multiapth.
> 
>  Ok. All parts of the test case is with an unmounted btrfs, I am
> clarified, now.
> 
> 
> 
