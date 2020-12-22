Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A45D2E0C99
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Dec 2020 16:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbgLVPUf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 22 Dec 2020 10:20:35 -0500
Received: from mail-oln040092066035.outbound.protection.outlook.com ([40.92.66.35]:13313
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727605AbgLVPUe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Dec 2020 10:20:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUZ2mdZVp81sdKXQOVf/p04qRfmqIxo/ZlaUxbjDQ3d5/EbCJJOTEzoWPyuB+Ofr+AzmMddcGVffFqeiwV3QBcN3/YQRmZfQWkGSZlXhRxXbpQTk/VDY6lbB1So28/zlHn0UNVVEUCXmCgyEfUpKROybUkkKIRFi+iu/0fynq5cjIYr6vM4SPDqsqTnYH8K7VUMczX9uah0jUUXXQ3/AKX6OvS4PWvoXXP9nzK7V7t0WKax8ehh3NwFUP2h2uZ5OoAnaajds3WVgTK0gbYg6/PCMvyubZcc43v4+76i8dQYEU+e/4dgCtMHMmQXkS4LdJP8zl7Y3R/v1MJNghFCnfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWf0UIbg1+ZHQxkMWOcmmxupZvnK5un55s9AQFTzxto=;
 b=T5MXTSX0Gu2v5TeW7A99DR7RGCODdi5+LUV+lBXUrEO8rp+2cq3gUY5RLYCqZpt8RsXL9NwnURRACEKltv2HursC7kqhIdo5RlTao9hSKQ7t8Nl3dJa0vsXFcygvEXW/YiehSxt7QK07i34LlR/QMWhYkg6FVEs2Gveq1y4e/ZROP2BF0GYPV4XgrxJjkkcdhUCynvJrnsfw3gPl/qX42dUYClsyNe9jmcEr5BuWNuHvS7F/fTem1pO5YVL/NvBkan+Z+CwBv1jYoyj1q2E2vA1FUO13BSq14hH52J/Ejj7sk3QWoQbXKhQN26JMQLE/ZgX5xHqrVERKYNeP9ia+/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DB5EUR01FT007.eop-EUR01.prod.protection.outlook.com
 (2a01:111:e400:7e1a::4a) by
 DB5EUR01HT102.eop-EUR01.prod.protection.outlook.com (2a01:111:e400:7e1a::187)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.25; Tue, 22 Dec
 2020 15:19:45 +0000
Received: from AM9P191MB1650.EURP191.PROD.OUTLOOK.COM (2a01:111:e400:7e1a::51)
 by DB5EUR01FT007.mail.protection.outlook.com (2a01:111:e400:7e1a::107) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.25 via Frontend
 Transport; Tue, 22 Dec 2020 15:19:45 +0000
Received: from AM9P191MB1650.EURP191.PROD.OUTLOOK.COM
 ([fe80::b49f:86f8:1023:df3d]) by AM9P191MB1650.EURP191.PROD.OUTLOOK.COM
 ([fe80::b49f:86f8:1023:df3d%2]) with mapi id 15.20.3676.030; Tue, 22 Dec 2020
 15:19:44 +0000
From:   Claudius Ellsel <claudius.ellsel@live.de>
To:     Graham Cobb <g.btrfs@cobb.uk.net>,
        Remi Gauvin <remi@georgianit.com>
CC:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: AW: AW: WG: How to properly setup for snapshots
Thread-Topic: AW: WG: How to properly setup for snapshots
Thread-Index: AQHWzwEUMIqawVdWg0mLNgWO6o19JqoBySKLgAAP3ICAAAzDuYAALjsdgAAxV4CAAQShPQ==
Date:   Tue, 22 Dec 2020 15:19:44 +0000
Message-ID: <AM9P191MB165050841D27C7264838E459E2DF0@AM9P191MB1650.EURP191.PROD.OUTLOOK.COM>
References: <AM9P191MB165033908B55F8312178D90AE2CB0@AM9P191MB1650.EURP191.PROD.OUTLOOK.COM>
 <AM9P191MB1650A1159D554207CB5D738AE2C00@AM9P191MB1650.EURP191.PROD.OUTLOOK.COM>
 <a68cd516-d6a2-b7ee-744b-d1b0ee83c2df@georgianit.com>
 <AM9P191MB1650AE92A25D9618163309E5E2C00@AM9P191MB1650.EURP191.PROD.OUTLOOK.COM>
 <AM9P191MB16502C509C161C5827FC1686E2C00@AM9P191MB1650.EURP191.PROD.OUTLOOK.COM>,<28c839e8-4d4f-031c-ee3e-3e676e344db3@cobb.uk.net>
In-Reply-To: <28c839e8-4d4f-031c-ee3e-3e676e344db3@cobb.uk.net>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:73202B531B477F35BFEA8C1527405F586678CE81C0B5953F56376B6FBD095219;UpperCasedChecksum:7638F19A2C262A4E7F5ED4C96AA13638DEBDDE99FCF5B9E9FEDA8B3ECE35B46E;SizeAsReceived:7472;Count:45
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [HBHz+6Hi/vcF5lUfmU/68rGxN1LpIPb5TZvHI7ALWY92XpaPXTfgXMAT2dWQaY23]
x-ms-publictraffictype: Email
x-incomingheadercount: 45
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 7f355fc7-f874-4428-646b-08d8a68d0310
x-ms-traffictypediagnostic: DB5EUR01HT102:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ryLCYaxu/kGPJB3tMkLVK3Wd2C8WDS/s3qIadv1P5Xm6dfcdiQtFs/I77a3F6Fkno6wM4lc0z5kPR5DrWbK2T6aP7d12Tg/E6eh/cPd0WS1MfUrFBv0nXcLMLtK6800CSnU1G3TR/IU0ENKWw0mV7TyXVLMATT1YMJkGCEDhUNWagumd66q2Lcm9LDbZkYcsnYTKfi1gAotYly0QiHZyUAlR0eD0fB8Th/riQAnGpCjeyon+juyCc3XAwe/+0N1N
x-ms-exchange-antispam-messagedata: 0YlbjeAt7GaNUC9WIhdpoiLuGFXSLoznAUeinwP3DcafQZ2KC5Ct8xfCUdmbeZeHQhiR694E6cfRP5kYEwjZS+yQnEF0a1JzhPSg5QNk5wxBSG5y2DOGy7ibdzJwB8mv95fQnOMrEmEvq77UOhzx4nX2Lccnp8a0JIH9qXcdqP2FRCb/hf19uMjzm64nNG5pbIt3NxvKxwi4OXLQrFVcaA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT007.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f355fc7-f874-4428-646b-08d8a68d0310
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2020 15:19:44.4602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5EUR01HT102
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

True, ideally I'd have done proper research first (I usually do that, else I wouldn't be using btrfs probably).

I just had a short look. Currently snapper luckily fulfills my needs.

Currently I have RAID1 set up via btrfs (not a good backup, or depending of the definition of "backup" not a backup at all - I still think one cannot deny that it reduces the risk of data loss). On top of that I have important data on an external drive that I plan to sync to manually regularly (this might be where btrbk might come in useful, as it is probably able to retain all the snapshots (history) on the backup drive instead of just overwriting the data when syncing. Currently I don't have the time to thoroughly look into it, though). Also I plan to use rclone to sync with a cloud service. I also think that depending of the definition of "backup", snapshots can be seen as one. But again of course not a safe one.

It all comes down to lowering the risk of data loss in the end. And finding a solution that is an acceptable balance between cost (or effort) and risk.

Von: Graham Cobb <g.btrfs@cobb.uk.net>
Gesendet: Dienstag, 22. Dezember 2020 00:33
An: Claudius Ellsel <claudius.ellsel@live.de>; Remi Gauvin <remi@georgianit.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
Betreff: Re: AW: WG: How to properly setup for snapshots 
 
On 21/12/2020 20:45, Claudius Ellsel wrote:
> I had a closer look at snapper now and have installed and set it up. This seems to be really the easiest way for me, I guess. My main confusion was probably that I was unsure whether I had to create a subvolume prior to this or not, which got sorted out now. The situation is apparently still not ideal, as to my current understanding it would have been preferable to set up a subvolume first at root level directly after creating the files system. However, as this is only the data drive in the machine (OS runs on an ext4 SSD) it is at least not planned to simply swap the entire volume to a snapshot but rather to restore snapshots at file / folder level, where snapper can also be used for.
> 
> One can possibly also safely achieve the same with only using btrfs commandline tools (I made the mistake of not thinking about read only snapshots when I wrote about my fear to delete / modify mounted snapshots). Still I have a better feeling when using snapper, as I hope it is less easy to screw things up with it :)

I have never used snapper but I know it is a popular tool. But there are
many other tools - with their own advantages, disadvantages and ways of
working. You may want to experiment with several of them. Personally I
use btrbk for automation of snapshots.

Just remember that btrfs snapshots are not a backup tool. At best, they
are a convenience tool, for quickly restoring deleted or modified files
(or full subvolumes) to an earlier (snapshotted) state without having to
access your backups. But they are completely useless if a hardware or
software problem (kernel bug, disk problem, system memory error, faulty
cable, etc) corrupts the filesystem. You don't have a backup solution
unless you are copying the files to another physical disk, preferably on
a different system. btrbk can help with that as well (but it is just
automating btrfs send and btrfs receive underneath).
