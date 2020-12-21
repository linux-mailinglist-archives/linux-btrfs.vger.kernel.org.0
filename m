Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5C72E01A2
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Dec 2020 21:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbgLUUqk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 21 Dec 2020 15:46:40 -0500
Received: from mail-am6eur05olkn2038.outbound.protection.outlook.com ([40.92.91.38]:44097
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725899AbgLUUqk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Dec 2020 15:46:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=euk2MUrxuFiqW42v8FivOH4Hktdctu4rktoyknSxjeYkZ4pAWew/vX7+gwTGeDvaGpwWWu2g2W7NEG1GfMju9OxJ9e0XF7XPmoyG++5RuJJRSX6k8L5uMvZPGQ1qa0ZpGQt6Ee0LjtdumA/7GOtCOPcBERg31Sz60JZCn21d99IjLEYHraUa9riZmgY4vc3FH1ubYTM9H5Uujt8JlcnGC5TRVWqT958zBLvW8T1Z4+JWh8s2GvIQxX8tcQyst2pY4hNwIQoftC+VmU5Bu75VaSlEEO8yiCRJjsmLHEKeIIKmZ9wQ6ou4ha+UUdNO8xOeWHaLJvWUDXLaBt04LAjJsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ms5UhKiTfOdCDLhcaoLpRGv/6rQdB21DcC1V3z19EGs=;
 b=C+u9aiEQ5mKM0LHupdR/te9ZwtaU+jFa2xPJ2ol8p5qvpm7eoIOXU1kAguyaKt7kUyq8OCaPV5FrjctssM0xHYuReJ/LvHtzpKGuHaEmcXGHvCsbI7Ps51XuXSTvakIiPpEBar4sOnU6CDfuXE9rzR31VWDbmkMd1XpGte4hJWqMSMkAekBlxPZMg21qGJHqjKrmaoqEDzGT1G6cOZBss6WT3WZ3KZ9Hxo7mICx/XWDgkC+0T+5nESILXHRrQC41mVooWYW1bD1LPUblVUuLs8Q9mqSw9HqgFz7Buev66R0HW/biF3fcAunvKurOQHIIGBnEYz9OdZCZNrJcIXml+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM6EUR05FT047.eop-eur05.prod.protection.outlook.com
 (2a01:111:e400:fc11::53) by
 AM6EUR05HT165.eop-eur05.prod.protection.outlook.com (2a01:111:e400:fc11::257)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.22; Mon, 21 Dec
 2020 20:45:51 +0000
Received: from AM9P191MB1650.EURP191.PROD.OUTLOOK.COM (2a01:111:e400:fc11::4a)
 by AM6EUR05FT047.mail.protection.outlook.com (2a01:111:e400:fc11::423) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.22 via Frontend
 Transport; Mon, 21 Dec 2020 20:45:51 +0000
Received: from AM9P191MB1650.EURP191.PROD.OUTLOOK.COM
 ([fe80::b49f:86f8:1023:df3d]) by AM9P191MB1650.EURP191.PROD.OUTLOOK.COM
 ([fe80::b49f:86f8:1023:df3d%2]) with mapi id 15.20.3676.030; Mon, 21 Dec 2020
 20:45:51 +0000
From:   Claudius Ellsel <claudius.ellsel@live.de>
To:     Remi Gauvin <remi@georgianit.com>
CC:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: AW: WG: How to properly setup for snapshots
Thread-Topic: WG: How to properly setup for snapshots
Thread-Index: AQHWzwEUMIqawVdWg0mLNgWO6o19JqoBySKLgAAP3ICAAAzDuYAALjsd
Date:   Mon, 21 Dec 2020 20:45:51 +0000
Message-ID: <AM9P191MB16502C509C161C5827FC1686E2C00@AM9P191MB1650.EURP191.PROD.OUTLOOK.COM>
References: <AM9P191MB165033908B55F8312178D90AE2CB0@AM9P191MB1650.EURP191.PROD.OUTLOOK.COM>
 <AM9P191MB1650A1159D554207CB5D738AE2C00@AM9P191MB1650.EURP191.PROD.OUTLOOK.COM>,<a68cd516-d6a2-b7ee-744b-d1b0ee83c2df@georgianit.com>,<AM9P191MB1650AE92A25D9618163309E5E2C00@AM9P191MB1650.EURP191.PROD.OUTLOOK.COM>
In-Reply-To: <AM9P191MB1650AE92A25D9618163309E5E2C00@AM9P191MB1650.EURP191.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:A0919DAC53F95644183CE7274F67827C46B70BB6DD786B8FFCCC209C56491182;UpperCasedChecksum:AFC093F42E47BE70E7A11108456B19557C563ABC1E3AA9A5BB516A60E1199A2D;SizeAsReceived:7310;Count:45
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [/+K9f1+x4BOsq7rFaF6uKIxYtfkQaF/jLWAR1o7aYW98unwqTQhkZmx5U50EBYtz]
x-ms-publictraffictype: Email
x-incomingheadercount: 45
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: f9f7ea60-d6a7-4485-3dbc-08d8a5f1678b
x-ms-traffictypediagnostic: AM6EUR05HT165:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HsHTIOl0wVy7Xgk0F6QmEMvf0jYnTulbDjub16UkL51pWy2ilWR0ivcPKCIUBwGEZh4BXV+IfwDJRW/jHLKjzHdtyypLbJCb7puqADzDJAmB4+3Vknw8V7L9IEgbkdhQQW/cIFm78KnNXCiFe1zmm/z6bE2LXTlMXcExw8My/ABQClMDRm0IlCmcO5plii1alfSZyfz7KuMHowpS3qUBiBoozjVfgqMJS2TvUTzFh8G9NHrcLq/KfzdAvofXrTK6
x-ms-exchange-antispam-messagedata: uKFzwjNvJjRQ4OKwJjvxDgx+dyWMprWFbgxpcjI/HLLF/1xfv2P0O/Fhy64acb4GBNjmY3TJcVpozwEjQcLgzHkAZC6LQc97CqUFHOAGaHc1emnisCDbBRw0Bt0RCYryL0WcM9jfq5BE1/rl3YzhLyNRz/RfEcqK8hk29Ii5Zp2NAqyZofRovBJLTJ78nls2BZgz2PJDimeyjMe9MV4glQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: AM6EUR05FT047.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f7ea60-d6a7-4485-3dbc-08d8a5f1678b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2020 20:45:51.4988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6EUR05HT165
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I had a closer look at snapper now and have installed and set it up. This seems to be really the easiest way for me, I guess. My main confusion was probably that I was unsure whether I had to create a subvolume prior to this or not, which got sorted out now. The situation is apparently still not ideal, as to my current understanding it would have been preferable to set up a subvolume first at root level directly after creating the files system. However, as this is only the data drive in the machine (OS runs on an ext4 SSD) it is at least not planned to simply swap the entire volume to a snapshot but rather to restore snapshots at file / folder level, where snapper can also be used for.

One can possibly also safely achieve the same with only using btrfs commandline tools (I made the mistake of not thinking about read only snapshots when I wrote about my fear to delete / modify mounted snapshots). Still I have a better feeling when using snapper, as I hope it is less easy to screw things up with it :)

Thanks all for your input and help!

Let me know if somebody want to improve the Wiki together to make entry easier for beginners.

Von: Claudius Ellsel <claudius.ellsel@live.de>
Gesendet: Montag, 21. Dezember 2020 19:04
An: Remi Gauvin <remi@georgianit.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
Betreff: AW: WG: How to properly setup for snapshots 
 
I have backups of the important data, but not for all data on that volume. Thus I wanted to make clear that I don't just want to copy paste stuff I find on the internet and motivate why I am asking here and want to have reliable sources. But thanks for the hint anyway, I also plan to have a better backup strategy once this project is finished. Unfortunately I don't have a better one right now where this is in an intermediate state.

> You have 1 subvolume, which is the root of your filesystem.

I still doubt that a bit, `sudo btrfs subvolume list /media/clel/NAS` (which is where I mount the volume with an fstab entry based on the UUID) does not output anything. Additionally I read (I guess on a reddit post) that in this case one has to create a subvolume first. That might have been problematic information, though.

I don't like experimenting and thus try to get the relevant information first. Also I want to state again that I hope, we can improve the Wiki to contain the information, so there is somewhat "official" documentation for this.

I'll probably read some more about snapper, although what I have read so far did not seem that well documented for first time users (for example I still don't know whether it will "just work" or needs some prerequisites).

Von: Remi Gauvin <remi@georgianit.com>
Gesendet: Montag, 21. Dezember 2020 18:05
An: Claudius Ellsel <claudius.ellsel@live.de>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
Betreff: Re: WG: How to properly setup for snapshots 
 
On 2020-12-21 11:11 a.m., Claudius Ellsel wrote:

> Unfortunately I am already at a somewhat production stage where I
don't want to lose any data.
>

You should first and foremost make sure you have backups of everything.

> 
> The problem might be that I currently don't have any subvolumes set up at all. Am I still be able to create snapshots in this stage or do I have to create a subvolume first from which snapshots can be created afterwards?
> 

You have 1 subvolume, which is the root of your filesystem.  You can
make snapshots of it.. (and each snapshot will be a new subvolume)  To
make your life easier, as you start experimenting, I suggest making a
new Read/Write subvolume to put your snapshots into

btrfs subvolume create .my_snapshots
btrfs subvolume snapshot -r /mnt_point /mnt_point/.my_snapshots/snapshot1

(Note: You will not be able to move or rename the snapshot1
folder, but you *will* be able to move or rename the entire
my_snapshots subvolume



> Also I learned about snapper from SUSE which sounds nice, but I don't want to break things while trying to use it.
> 

Snapper is an amazing tool... You should familiarize yourself and be
comfortable with the btrfs subvolume command first, (things will make
more sense if you know whats going on...), but Snapper makes it a.. snap
to automate the snapshots *and* the clean-up.


