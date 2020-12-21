Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC7D2DFF39
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Dec 2020 19:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgLUSFd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 21 Dec 2020 13:05:33 -0500
Received: from mail-am6eur05olkn2014.outbound.protection.outlook.com ([40.92.91.14]:14560
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725783AbgLUSFa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Dec 2020 13:05:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5V8FktDxgH3X3EBVvrMT7FQbLKEENAB356FNVno6ctlDv6DwJJldh5o1ZQbpYd1ezQnRaifWEn8uzTz7dyQi32di4A1RhznQW7pGsvFTJP0sUUC86cbhaE6iIog/2FfajottyjeR8gU8sXGvQTVnHoJwgnB1lC1VDNXPS+jyYjkm80YOfbXQulU9u5oBqi/Gki7eiUsbkOPkIr7+ppi5e5wmueUqYy+oDO4lLozWcSdlIFuGvfhWJQrIUqQ88LCYsQBVPVEOG+InRMjPFD7uoZpSyfVQD3W5X22khg+9Xk1VurwZ2NbVRvwyyOHKgKR2U2TmapoPrl5zzsH2iseBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEQE5lCKSOnF6+jznVKOLznKig4AVDPustleGwRB4Gw=;
 b=g12I2diqgcKB5CTF6xrF5lo4MjfwB0jlMOnhtQskOxsmBXuhW6CwfK65ZsmzNvQlT5F78JG+BC/BqHiWr6C+8rCo7PAnlLhaQLOAbq+RuibJbW/PtKX+74QVzjJmwXQlenmciqRBJBFmk7CRb5g0QWDRK0xm4yjTdYLKAMbTS8tJNPi3OQqKJSTfNDdNJPK9fi/GtKQRlyYCBXrM1nhWMauREzsyQ88mcQmukTeo81RTT07gDTOi3nD8p+Lk578NerUVhUS7Xpnx1RWPGFO6VxAPMl/60ndTrzTcRqBNSyX7LcoP46pUZVtQB6yR1983mZMs5VnpMJlWgYE4ibR4og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from VI1EUR05FT031.eop-eur05.prod.protection.outlook.com
 (2a01:111:e400:fc12::42) by
 VI1EUR05HT209.eop-eur05.prod.protection.outlook.com (2a01:111:e400:fc12::215)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.22; Mon, 21 Dec
 2020 18:04:40 +0000
Received: from AM9P191MB1650.EURP191.PROD.OUTLOOK.COM (2a01:111:e400:fc12::4f)
 by VI1EUR05FT031.mail.protection.outlook.com (2a01:111:e400:fc12::170) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.22 via Frontend
 Transport; Mon, 21 Dec 2020 18:04:40 +0000
Received: from AM9P191MB1650.EURP191.PROD.OUTLOOK.COM
 ([fe80::b49f:86f8:1023:df3d]) by AM9P191MB1650.EURP191.PROD.OUTLOOK.COM
 ([fe80::b49f:86f8:1023:df3d%2]) with mapi id 15.20.3676.030; Mon, 21 Dec 2020
 18:04:40 +0000
From:   Claudius Ellsel <claudius.ellsel@live.de>
To:     Remi Gauvin <remi@georgianit.com>
CC:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: AW: WG: How to properly setup for snapshots
Thread-Topic: WG: How to properly setup for snapshots
Thread-Index: AQHWzwEUMIqawVdWg0mLNgWO6o19JqoBySKLgAAP3ICAAAzDuQ==
Date:   Mon, 21 Dec 2020 18:04:40 +0000
Message-ID: <AM9P191MB1650AE92A25D9618163309E5E2C00@AM9P191MB1650.EURP191.PROD.OUTLOOK.COM>
References: <AM9P191MB165033908B55F8312178D90AE2CB0@AM9P191MB1650.EURP191.PROD.OUTLOOK.COM>
 <AM9P191MB1650A1159D554207CB5D738AE2C00@AM9P191MB1650.EURP191.PROD.OUTLOOK.COM>,<a68cd516-d6a2-b7ee-744b-d1b0ee83c2df@georgianit.com>
In-Reply-To: <a68cd516-d6a2-b7ee-744b-d1b0ee83c2df@georgianit.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:7C022D722A2CCC09502F30BCB8F386B26090F0B3912DBDC22B9CCD16DBC73BEA;UpperCasedChecksum:213AF098A3F97C720E55A30E030ED5501CE59958C8F4EDA83472041751C8FD07;SizeAsReceived:7194;Count:45
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [jiiLZY1IwW4ssUvyGAEQKCekjZe0PzhmXhYXDLIEytz45zPmoPdppqXYmWKy2uip]
x-ms-publictraffictype: Email
x-incomingheadercount: 45
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 33e415d9-0b64-46e9-47f2-08d8a5dae338
x-ms-traffictypediagnostic: VI1EUR05HT209:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HrnnlOcFliCU3Cyq0IR2NxiWZ055IOAQ+HY2VI3QYxnUM1/SNl9Y8g1CqrCkz2mRd0p6gjkym3M3c36BglkbnPJXn4ixAOeIe0cfCY9rJw3KsgOxHLl7GKznvG4U/XpSGv8e7e0Hcwj5YgwOWWKpqdFWdJKB043oJWiGw6pGsSznsxisZSIQoBm8UfvbLqdYtpkNyHQYDtLsv4WB1eD74fcuG2IG0RTxz7Om0CctU0/GZwGI7MswyxmMRl9v9qhB
x-ms-exchange-antispam-messagedata: RiGbJy8V6kn0+vTlCEq6zyk3KOseMqA+OjRMoZgpLGxsDcoSZrleVOErbCPc8qnBUW72alAytwhqhdmQW1OYVTKbMFAVB/BJozmS46ddGGqih/vk10UUmokeBcWollez+LYVtfGNtNMoDfHO7wTQIFGZ+IzGu5D5CWHhha4fnLDqLf0c81J98qwncy708/GFEIZ/ei+ctfVsJT7U+JW0Kg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR05FT031.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e415d9-0b64-46e9-47f2-08d8a5dae338
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2020 18:04:40.5549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1EUR05HT209
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

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



