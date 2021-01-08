Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6922EF3F2
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Jan 2021 15:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbhAHObl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 8 Jan 2021 09:31:41 -0500
Received: from mail-vi1eur06olkn2066.outbound.protection.outlook.com ([40.92.17.66]:37728
        "EHLO EUR06-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725942AbhAHObk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 8 Jan 2021 09:31:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G72+2SddQOSbza4U0QjbFxD+Z17iZK6GVXU23o26/wv9jxos3tQxQly+d8Ny5u+t9ay0v8wx808DydriuWn21+mDTZymUp/H6BJanHImPlRSHgEPbGFfqzHkOPSlayAHjuGIMX9cAVjC4PGlOF7x06WeNHVzGNJTr0DanDfQWBaQUZB7wBBN28y/Wtt7zmvlCNzzS2+HY3hOo0GbJ9yKbM3azFDso6Rlqfun+NyXoPXzL2OMjRKE7kOh3nGLTHQxWdMtmtt7pYTHkw09p9IbnicKckJG/Ds2D0mhYPvWnWtnauEbDS/QXqOEU5Gh8T1ghiBRmWl1guwUa9ZS+Y23kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0PM0Z7azu3I2CcdohaewQA9aJD+c/gtrJyFCR15OS0=;
 b=LzkWmuKNRSs8V8c4a/wDGs8S62vMKgY6oHWKOJaMGCAmxFTcc0JqDOP38HWxcAchllw7/zfLP4xtqci0Dbkd+T2rgQuA00he9F8PQ1N223UVwx80t1w5cXWxQkktwkI7IFQUs3mH3IpZFEx5OySNAnc2whbs/wZlz9W5T5xRVrA9DM40leRiwNZweFoBW9V84VqsbFcy0j3PmFnZldZysC8D8LgJwd/1FcC4v/RbfsAjzdiAfd8BXFsP62fjLnJ0EMv4+FCgsfFrEIxiqMxvR8orUbb+v2ltLXV2QIzWgRJAZoTN0KfsWbmcDXRXwaWGP5gzOzO8wCNTzPkwuCyEmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DB8EUR06FT012.eop-eur06.prod.protection.outlook.com
 (2a01:111:e400:fc35::41) by
 DB8EUR06HT224.eop-eur06.prod.protection.outlook.com (2a01:111:e400:fc35::177)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Fri, 8 Jan
 2021 14:30:53 +0000
Received: from AM0P191MB0561.EURP191.PROD.OUTLOOK.COM (2a01:111:e400:fc35::4d)
 by DB8EUR06FT012.mail.protection.outlook.com (2a01:111:e400:fc35::136) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend
 Transport; Fri, 8 Jan 2021 14:30:53 +0000
Received: from AM0P191MB0561.EURP191.PROD.OUTLOOK.COM
 ([fe80::a998:ec2a:8ae2:80fa]) by AM0P191MB0561.EURP191.PROD.OUTLOOK.COM
 ([fe80::a998:ec2a:8ae2:80fa%7]) with mapi id 15.20.3742.010; Fri, 8 Jan 2021
 14:30:53 +0000
From:   Claudius Ellsel <claudius.ellsel@live.de>
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Improve balance command
Thread-Topic: Improve balance command
Thread-Index: AQHW5chl8sCdYeF1/EyvB/fIO6/bcg==
Date:   Fri, 8 Jan 2021 14:30:52 +0000
Message-ID: <AM0P191MB056105988C894B2A076AA0B3E2AE0@AM0P191MB0561.EURP191.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:F5BA600D36307AB4A171F8A351CFC3D84F8AC7DE8A304602E0C2D6AC3AF66072;UpperCasedChecksum:4381B11E314672414321382D756B29C7B076371EB54A45456A8298EA5B8CDF2E;SizeAsReceived:6793;Count:42
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [NYfFGPNOdUYUgJ70G++pGxL96mxv0XMt3qUgT7zk2s8bQVL+8+pHDIXhipE+JrWk]
x-ms-publictraffictype: Email
x-incomingheadercount: 42
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 0875b541-8aa5-4f50-7724-08d8b3e200cb
x-ms-traffictypediagnostic: DB8EUR06HT224:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UBbNSxdqa7eklibStWnrVzrklnfR7avt/1AnG8vihFulUkdoC+H7qWoxBcT733du3qSd8eR468vDyXl2pqKrP0syplu6vpMMas8J6B8wk8d8idpDUrJ0h28QT6eRfJnzPD5hklTJ3LdLnBt+FV8qdhXCQ6f8CDJ3dFKwge6ZJ10Nmv3LCA+MpCYpGM96TmcQBaWchRU9B/xETI7PHzc+xidYCBzT/l/FFLJ/e0Vu4CkKUo3ZeBoNlfLHVTiz/O1rzalkYSP5mOEi36GnAG6DrHJTwKL2BtVUHvdk2RE+0s0=
x-ms-exchange-antispam-messagedata: gyVrD/nbHqheOB9cJiwWoj6quQw250IpXOtUL2b2e5htMogDLmaqeg15TWh9jB9r2RGsr0a1CohDptRRlst9mNQ4hP3F1Ml/n3ap17EsWtXMHzthGKUpZyWtPofWw26Za33JQ9jrFTAdNAdFmbMkFkRv0gnaYedO8VOkwE8FOnrc62JVi4gkvdT+3ulWfqrVClYiXQdIj41iNgXuIYx4YA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: DB8EUR06FT012.eop-eur06.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 0875b541-8aa5-4f50-7724-08d8b3e200cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2021 14:30:52.9105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8EUR06HT224
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

currently I am slowly adding drives to my filesystem (RAID1). This process is incremental, since I am copying files off them to the btrfs filesystem and then adding the free drive to it afterwards. Since RAID1 needs double the space, I added an empty 12TB drive and also had a head start with an empty 1TB and 4TB drive. With that I can go ahead and copy a 4TB drive, then add it to the filesystem until I have three 4TB and one 12TB drives (the 1TB drive will get replaced in the process).
While I was doing this (still in the process), I have used the `balance` command after adding a drive as described in the Wiki. Unforunately I now learned that this will at least by default rewrite all data and not only the relevant chunks that need to be rewritten to reach a balanced drive. In order that leads to pretty long process times and also I don't really like that the drives are stressed unnecessarily.

So now I have the question whether there are better methods to do rebalancing (like some filters?) or whether it is even needed every time. I also created a bug report to suggest improvement of the rebalancing option if you are interested: https://bugzilla.kernel.org/show_bug.cgi?id=211091.

On a slightly different topic: I was wondering what would happen if I just copied stuff over without adding new drives. The 1TB and 4TB drives would then be full while the 12TB one still had space. I am asking because when running `sudo btrfs filesystem usage /mount/point` I am getting displayed more free space than would be possible with RAID1:

Overall:
    Device size:		  19.10TiB
    Device allocated:		   8.51TiB
    Device unallocated:		  10.59TiB
    Device missing:		     0.00B
    Used:			   8.40TiB
    Free (estimated):		   5.35TiB	(min: 5.35TiB)
    Data ratio:			      2.00
    Metadata ratio:		      2.00
    Global reserve:		 512.00MiB	(used: 0.00B)

Data,RAID1: Size:4.25TiB, Used:4.20TiB (98.74%)
   /dev/sdc	 565.00GiB
   /dev/sdd	   3.28TiB
   /dev/sdb	   4.25TiB
   /dev/sde	 430.00GiB

Metadata,RAID1: Size:5.00GiB, Used:4.78GiB (95.61%)
   /dev/sdc	   1.00GiB
   /dev/sdd	   4.00GiB
   /dev/sdb	   5.00GiB

System,RAID1: Size:32.00MiB, Used:640.00KiB (1.95%)
   /dev/sdd	  32.00MiB
   /dev/sdb	  32.00MiB

Unallocated:
   /dev/sdc	 365.51GiB
   /dev/sdd	 364.99GiB
   /dev/sdb	   6.66TiB
   /dev/sde	   3.22TiB

It looks a bit like the free size was simply calculated by total disk space - used space and then divided by two since it is RAID1. But that would in reality mean that some chunks are just twice on the 12TB drive and not spread. Is this the way it will work in practice or is the estimated value just wrong?

Kind regards
Claudius Ellsel
