Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF062DFDEB
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Dec 2020 17:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725804AbgLUQMS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 21 Dec 2020 11:12:18 -0500
Received: from mail-oln040092067031.outbound.protection.outlook.com ([40.92.67.31]:24321
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725782AbgLUQMR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Dec 2020 11:12:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFN2NpvwLDbFyRCOQtvx9QmhsfJSjGGPQ6oMk+n93xWWWToBXdlA4Z0XvRYljdn5keiPBCnTsvNvCOiaA7hn34FDTVromQ5AD/tHcdD1BnHGl9IQ2y4JcHyYyeEz7dETA7kgVU8EBTiDy9TyA3ICo/xw8JGI+kE5RS3p6Yun9ETarcDt7HT6/2jEeeNvJ/YsnuQwJFKbjWq/ivW427nZxNAs53tDbZn/almMg6oHUsd/mAGfhqdsN4ECTM2wJ7dDi7pUWp0uk+ADT7M3nd8eOCWz2GBwV0hwUiie5LlKMF3wskVLF+Ege8olRNAZqbbQLT3gEl42KWXTlbO7gpUgCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsbAJFWJewSeS7mvDHg6Ls6dekbGMxCf8GvWGT9nPGM=;
 b=Qk3S7Zbd+1mu9/EkYJEIa2xjFAx2h4sKdDO5fzgECQyWwV2FX8a4L45zxA80wF4w7glPrES6mUBLlwFWRN479V5N7KtmYdF30XFvVzNydYQXzHUoyVxVorbwZB3CUWKd64+Edz4urUSUxQBK+MvH5ytqHQ1uChXXJtojOk3jCmBVagximwC5ZdhniJ+C9eBll9SnGy0X2NnCqCQdRJgQ7o5UC1jqS1xGtIx7nT49SFwTAIvjsRAVRcDkVq95cNpYyjtN40lEytvSpPikdPPpKpVJmVkJ5CkIb7SqrrrLor6G6SETXI23GJ1y8XzF2sb7Z6zo7fkc6I75GxjzFOSkhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from VE1EUR02FT019.eop-EUR02.prod.protection.outlook.com
 (2a01:111:e400:7e1e::43) by
 VE1EUR02HT051.eop-EUR02.prod.protection.outlook.com (2a01:111:e400:7e1e::274)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.22; Mon, 21 Dec
 2020 16:11:25 +0000
Received: from AM9P191MB1650.EURP191.PROD.OUTLOOK.COM (2a01:111:e400:7e1e::4e)
 by VE1EUR02FT019.mail.protection.outlook.com (2a01:111:e400:7e1e::107) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.22 via Frontend
 Transport; Mon, 21 Dec 2020 16:11:25 +0000
Received: from AM9P191MB1650.EURP191.PROD.OUTLOOK.COM
 ([fe80::b49f:86f8:1023:df3d]) by AM9P191MB1650.EURP191.PROD.OUTLOOK.COM
 ([fe80::b49f:86f8:1023:df3d%2]) with mapi id 15.20.3676.030; Mon, 21 Dec 2020
 16:11:25 +0000
From:   Claudius Ellsel <claudius.ellsel@live.de>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: WG: How to properly setup for snapshots
Thread-Topic: How to properly setup for snapshots
Thread-Index: AQHWzwEUMIqawVdWg0mLNgWO6o19JqoBySKL
Date:   Mon, 21 Dec 2020 16:11:25 +0000
Message-ID: <AM9P191MB1650A1159D554207CB5D738AE2C00@AM9P191MB1650.EURP191.PROD.OUTLOOK.COM>
References: <AM9P191MB165033908B55F8312178D90AE2CB0@AM9P191MB1650.EURP191.PROD.OUTLOOK.COM>
In-Reply-To: <AM9P191MB165033908B55F8312178D90AE2CB0@AM9P191MB1650.EURP191.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:C7673F6E7BAC329CDF298AC10A52ABCB63A761C2A9645B11C64B291BC0652D16;UpperCasedChecksum:0B55D1DF51579F11317D82180D1C5BD3ECF16940DE4F774189E6CDD304EC1023;SizeAsReceived:7042;Count:44
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [ldgOuAlI5cusqQkkX3nChZrepg9Np/uVjHqMAG32fk5gfAOSu2E/j93xNDt1mD81]
x-ms-publictraffictype: Email
x-incomingheadercount: 44
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: dda9e2d1-fb4a-43bb-81ee-08d8a5cb112f
x-ms-traffictypediagnostic: VE1EUR02HT051:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kM1edAKi8vCoyltH3dIhZRstaV4eKLn1WdjDs55zijOE468F+sIfMNY2vQg+PVzYt3LJigjNzj9XsK8NxZ83a9O7MtZzVMdSP0MaXXhNd8vVH9v82dQMF5OWQf+/ugB5pcXBLYkjDwN0qbpXy7Mof30asVxUUggU5Zls5gp/78meon1JjXPoymPOytGF83k5EcKK8nyO/sTiEAXVdEeJ5P7KoJfGH3pDtViB07EbFndat5k0qdoK0YJZERsjiDj+
x-ms-exchange-antispam-messagedata: IpRIEPbfqWffOhXEklLXQGhsJGGWtW+FXetlKKsG/4xhqDtywwvmq4zJ3H/0ZNSJPGf491EBaDkgEXF7UcWCsPsZ4C3SKHL2dljwMb0ziqL2/FPqAnPWeLG3ib4vuiNeY83EeWgOJhmEt724NMFw4WBZvUsjexbqOLnN2DPlyHhInvaddY4VlgCXnROCmdLfuuqtUYPB7fnrOisCMloDYQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT019.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: dda9e2d1-fb4a-43bb-81ee-08d8a5cb112f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2020 16:11:25.7239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR02HT051
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Next try (this time text only activated) after my second try was treated as spam (this time I at least got a delivery failed message stating so).

The original message does not seem to have made it through, so here I try again.

Von: Claudius Ellsel <claudius.ellsel@live.de>
Gesendet: Donnerstag, 10. Dezember 2020 15:37
An: linux-btrfs@vger.kernel.org <linux-btrfs@vger.kernel.org>
Betreff: How to properly setup for snapshots 
 
Hello,

I recently started setting up btrfs on Ubuntu 20.04 LTS for usage as an SMB share mainly. Currently I am at the stage that I have two disks set up with RAID1 and automatically mounting them on boot with a fstab entry. Also I have setup samba and have transferred data on it.

Now I wanted to create snapshots, but am not sure how exactly that works. The wiki does not say much and information on the internet is not really reliable.

The problem might be that I currently don't have any subvolumes set up at all. Am I still be able to create snapshots in this stage or do I have to create a subvolume first from which snapshots can be created afterwards?

Also I learned about snapper from SUSE which sounds nice, but I don't want to break things while trying to use it.

Unfortunately I am already at a somewhat production stage where I don't want to lose any data.

Hopefully somebody can shed some light on this, maybe we can also add info to the wiki so there is a somewhat "official" source to rely on.

PS: I am not subscribed to this list, hopefully replies will reach me anyway.

Kind regards
Claudius Ellsel
