Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA364827D5
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Jan 2022 16:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbiAAPdJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 Jan 2022 10:33:09 -0500
Received: from gproxy1-pub.mail.unifiedlayer.com ([69.89.25.95]:56832 "EHLO
        gproxy1-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232444AbiAAPdJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 1 Jan 2022 10:33:09 -0500
X-Greylist: delayed 1321 seconds by postgrey-1.27 at vger.kernel.org; Sat, 01 Jan 2022 10:33:09 EST
Received: from cmgw12.mail.unifiedlayer.com (unknown [10.0.90.127])
        by progateway3.mail.pro1.eigbox.com (Postfix) with ESMTP id F37531004388E
        for <linux-btrfs@vger.kernel.org>; Sat,  1 Jan 2022 15:11:06 +0000 (UTC)
Received: from box2278.bluehost.com ([50.87.176.218])
        by cmsmtp with ESMTP
        id 3g2EnDpE2XOyf3g2En9QSd; Sat, 01 Jan 2022 15:11:06 +0000
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.4 cv=Ot6Kdwzt c=1 sm=1 tr=0 ts=61d06f0a
 a=XwlUGG/Joq/Evm8SRPjtJg==:117 a=XwlUGG/Joq/Evm8SRPjtJg==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10:nop_charset_1
 a=DghFqjY3_ZEA:10:nop_rcvd_month_year
 a=yWZkyvPI6HoA:10:endurance_base64_authed_username_1 a=nL7Da4d70l1PiYVAu5MA:9
 a=QEXdDO2ut3YA:10:nop_charset_2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=casa-di-locascio.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7xId0IJa2ot5OPlwPm3uJzofJdNX7lVK5+wUmiCCzqY=; b=1E1sut6nPXa1whVv2Fth6hv5vA
        J/XNj/z37L0i0jNJVdgbAgj84AWHrS5OknbjiA5IzEgGUFbCdgFNviMroN2QypvjolPl18a3u/Nno
        RXxnWAfyO0sN9+CSs6WYL/Zm+;
Received: from host86-179-160-20.range86-179.btcentralplus.com ([86.179.160.20]:32960 helo=[192.168.1.52])
        by box2278.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <devel@roosoft.ltd.uk>)
        id 1n3g2D-001tuy-SL; Sat, 01 Jan 2022 08:11:06 -0700
Message-ID: <a3b1a882-10a2-e2f4-25c3-bd324d9221d3@casa-di-locascio.net>
Date:   Sat, 1 Jan 2022 15:11:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: parent transid verify failed
Content-Language: en-CA
To:     Chris Murphy <lists@colorremedies.com>,
        Eric Levy <contact@ericlevy.name>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <c0c6ec8de80b8e10185fe1980377dcc7af8d3200.camel@ericlevy.name>
 <CAJCQCtQ1v4_-R=AHXJXUTkCBtYLW+x09_1_bk67fP7Kf=12OYA@mail.gmail.com>
From:   devel@roosoft.ltd.uk
In-Reply-To: <CAJCQCtQ1v4_-R=AHXJXUTkCBtYLW+x09_1_bk67fP7Kf=12OYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box2278.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roosoft.ltd.uk
X-BWhitelist: no
X-Source-IP: 86.179.160.20
X-Source-L: No
X-Exim-ID: 1n3g2D-001tuy-SL
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host86-179-160-20.range86-179.btcentralplus.com ([192.168.1.52]) [86.179.160.20]:32960
X-Source-Auth: fpd_eacct+casa-di-locascio.net
X-Email-Count: 1
X-Source-Cap: Y2FzYWRpbG87Y2FzYWRpbG87Ym94MjI3OC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 30/12/2021 21:47, Chris Murphy wrote:
> On Thu, Dec 30, 2021 at 2:10 PM Eric Levy <contact@ericlevy.name> wrote:
>> Hello.
>>
>> I had a simple Btrfs partition, with only one subvolume, about 250 Gb
>> in size. As it began to fill, I added a second volume, live. By the
>> time the size of the file system reached the limit for the first
>> volume, the file system reverted to read only.
>>
>> From journalctl, the following message has recurred, with the same
>> numeric values:
>>
>> BTRFS error (device sdc1): parent transid verify failed on 867434496
>> wanted 9212 found 8675
>>
>> Presently, the file system mounts only as read only. It will not mount
>> in read-write, even with the usebackuproot option.
>>
>> It seems that balance and scrub are not available, either due to read-
>> only mode, or some other reason. Both abort as soon as they begin to
>> run.
> Complete dmesg, at least since adding the 2nd device and subsequent read only.
> `btrfs fi us $mountpoint` for the ro mounted file system so we can see
> the space available and bg profiles
> `btrfs insp dump-s $anydev` for either of the two devices
> kernel version
> btrfs-progs version
> make/model of the two devices being used
>
>> What is the best next step for recovery?
> For now, take advantage of the fact it mounts read-only, backup
> anything important and prepare to restore from backup. Transid errors
> are unlikely to be repairable. What's weird in this case is there's no
> crash or powerfailure. For transid problems to show up during normal
> operation is unusual, as if one of the drives is dropping writes
> occasionally without even needing a crash or powerfail to become
> confused.
>
>
As well as that I would suggest you run memtesx86+ because those sorts
of bit flips can well be bad memory. I speak from experience.

-- 
==

D Alexander

