Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3DB719202D
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Mar 2020 05:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgCYEaV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Mar 2020 00:30:21 -0400
Received: from mail-eopbgr1370050.outbound.protection.outlook.com ([40.107.137.50]:8224
        "EHLO AUS01-SY3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725781AbgCYEaV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Mar 2020 00:30:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mT4ZaoZDn79W2GQT7parmZiFhCAhIpSAZdJDG7rwGhq7txktOvB3gUTCLGG2FQzk+KH/BZ0uWHF9nNdWiWgMmjw4ZGXfMZ+WqTL/VdtS1eQHWN1gy/kyMwHM+eB6UTX8NoP5nkm+ShFHanAoAnb+BVwBGtko3qG9oX72HTSwVh+26tsFdEbZK0kzY7bkwYkKdjNiiROkB+a9A04bqil4FrZMxtPToJptALkHMorNxfVlBV1gT9msiM+8i7dgAZ0AVyEQ685Jd2dD2MERNz4yYVFraU7DWK1woT7ejfK3CCqG9NiJungE5U06FcbGI+LiFzjg6w6FN+mLInxwCKCZzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ooco78fKYV2xovCcubUfyY7k8E5C3YsCqkTZf3+MtYk=;
 b=E3qZV4YCoQasK6vhm90dE2vhNaoYXXjbWzdVm5DTYFW2RuFH1bZWefWslB6y+SUQWUKvnlgXWsryDe9mMfuXuKt8HIjNydP1Q6Q5FHhjD9p/4H543vAtlQLN4QNaKz6dNGqxG8tvSrwOkiv28Mvi3sr+CTLDJ8tgYBSekjQ/+Y52pRorWKUblFPTTsjcL/tzYNBrTqY+yM1X2BcvD4csRRNQ979hlxrnaGIZhhrCQDxcwUKljlXpuqKQejDFDaCBEyHLDJu58Qh3j12eHYiOJtfJzq+DHaCDcOSc1Gzzsil4sAHWOkcwol0NJWiIUMTH58ig6EKYYpN5fqJbZqJbTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pauljones.id.au; dmarc=pass action=none
 header.from=pauljones.id.au; dkim=pass header.d=pauljones.id.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oakvillepondscapes.onmicrosoft.com;
 s=selector2-oakvillepondscapes-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ooco78fKYV2xovCcubUfyY7k8E5C3YsCqkTZf3+MtYk=;
 b=LUP6j2dRrr5isJoYwB1l68XH4YzpZxRd98wQF4Le8+RErItvyqg2TQbWmMfQOXys/csIGTKCD+dqfna+CeYyPPEaPDVBPMGTJG8zI93u2tbKlwcBjdnO4q41VQ1U5PzIls8O8pYPB4M1qoRqNDKz4htMxgOHlM0wcJO9fojQAcA=
Received: from SYBPR01MB3897.ausprd01.prod.outlook.com (20.177.136.214) by
 SYBPR01MB4764.ausprd01.prod.outlook.com (20.178.191.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.19; Wed, 25 Mar 2020 04:30:17 +0000
Received: from SYBPR01MB3897.ausprd01.prod.outlook.com
 ([fe80::790e:69fb:3a25:5092]) by SYBPR01MB3897.ausprd01.prod.outlook.com
 ([fe80::790e:69fb:3a25:5092%5]) with mapi id 15.20.2835.021; Wed, 25 Mar 2020
 04:30:17 +0000
From:   Paul Jones <paul@pauljones.id.au>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Graham Cobb <g.btrfs@cobb.uk.net>
CC:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: RE: Question: how understand the raid profile of a btrfs filesystem
Thread-Topic: Question: how understand the raid profile of a btrfs filesystem
Thread-Index: AQHWAVSkooa6FDNgjUanL7QrcK3ORKhWx78AgAHsDACAAAIGAA==
Date:   Wed, 25 Mar 2020 04:30:16 +0000
Message-ID: <SYBPR01MB38972C6A31FA985B0D9494109ECE0@SYBPR01MB3897.ausprd01.prod.outlook.com>
References: <517dac49-5f57-2754-2134-92d716e50064@alice.it>
 <20200321032911.GR13306@hungrycats.org>
 <fd306b0b-8987-e1e7-dee5-4502e34902c3@inwind.it>
 <20200321232638.GD2693@hungrycats.org>
 <3fb93a14-3608-0f64-cf5c-ca37869a76ef@inwind.it>
 <d472962c-c669-3004-7ab4-be65a6ed72ba@inwind.it>
 <20200322234934.GE2693@hungrycats.org>
 <a15a47f1-9465-dd5c-4b70-04f1a14e6a96@libero.it>
 <28ddb178-674b-fab7-afa4-18a575299c1d@cobb.uk.net>
 <20200325040950.GV13306@hungrycats.org>
In-Reply-To: <20200325040950.GV13306@hungrycats.org>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=paul@pauljones.id.au; 
x-originating-ip: [60.240.33.147]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b69e66ee-d99e-4781-7ece-08d7d0753859
x-ms-traffictypediagnostic: SYBPR01MB4764:
x-microsoft-antispam-prvs: <SYBPR01MB4764A780454A986CD2C5C7019ECE0@SYBPR01MB4764.ausprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39830400003)(396003)(366004)(136003)(6506007)(4326008)(53546011)(186003)(55016002)(9686003)(71200400001)(26005)(5660300002)(76116006)(110136005)(2906002)(52536014)(86362001)(508600001)(66556008)(7696005)(66476007)(8936002)(316002)(33656002)(64756008)(81156014)(8676002)(66446008)(66946007)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:SYBPR01MB4764;H:SYBPR01MB3897.ausprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: pauljones.id.au does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lnBn9RPrEYf9UCPuwbMRnpWDF+REDACCMtd2uv5Gn7pU2EnfhaDck0GnKUWZVF/vzgAcEhkr2IJUhUUh09OPiho52cLRTVx/OxeFtIEKxFNXM73VubmzndmDj6k0+Wc4kbEWF8KSV06NUA+WiJFztyJAx4L6SY6tsK5IqpQk/R2GA4NYSScRKhtkyYLT3cFGEo6TzSuhAlH7X1VcXZ6t6R1GRACCNJ/JvuH3DmWtGDMprsjIZehd9DVLAtlkkI0GCI3KZZxTpQCg/JlYsYXYqVfgin8t0c/u1xB4oU5e5rAmBkGK4cNYsu1azOrZF15HKCIVGymoPlfi+F+fDX/msPZaDCHBV/yZRvr9b/4htnig8VHuH4lnLwzMXdPCbfNN1+wyGJexNHmw6spgA7z7vmvMXThUYxg5nqIzn1WdB1qaGYak+P7b6LlK5O3nk+OL
x-ms-exchange-antispam-messagedata: YqrkSWkM3CNyXD+X2j7/K+pVMgJB4qsgvPfYKeYO4y16LevMYJaWIalbm7Hj6JEvNjyMl72LyLZiBxJ52lXYysoliGrH6bzhUaOGORrGJ5bAE/kD5T6GDcwGB2qN90HY2mlO7P8d5BmLZ5MVb6BPWg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: pauljones.id.au
X-MS-Exchange-CrossTenant-Network-Message-Id: b69e66ee-d99e-4781-7ece-08d7d0753859
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 04:30:17.0225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8f216723-e13f-4cce-b84c-58d8f16a0082
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RXI9T5rmr9+ysGeM7NAVsJF4mvIy2NlBUBTdB801v/cqllOkurlpUA+xXtwm3n1pWQPh41cxRkD7jmLgnsX1oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBPR01MB4764
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> -----Original Message-----
> From: linux-btrfs-owner@vger.kernel.org <linux-btrfs-
> owner@vger.kernel.org> On Behalf Of Zygo Blaxell
> Sent: Wednesday, 25 March 2020 3:10 PM
> To: Graham Cobb <g.btrfs@cobb.uk.net>
> Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
> Subject: Re: Question: how understand the raid profile of a btrfs filesys=
tem

> Disk removes are where the current system breaks down.  'btrfs device
> remove' is terrible:
>=20
> 	- can't cancel a remove except by rebooting or forcing ENOSPC
>=20
> 	- can't resume automatically after a reboot (probably a good
> 	thing for now, given there's no cancel)
>=20
> 	- can't coexist with a balance, even when paused--device remove
> 	requires the balance to be _cancelled_ first
>=20
> 	- doesn't have any equivalent to the 'convert' filter raid
> 	profile target in balance info
>=20
> so if you need to remove a device while you're changing profiles, you hav=
e to
> abort the profile change and then relocate a whole lot of data without be=
ing
> able to specify the correct target profile.
>=20
> The proper fix would be to reimplement 'btrfs dev remove' using pieces of
> the balance infrastructure (it kind of is now, except where it's not), an=
d so
> 'device remove' can keep the 'convert=3D' target.  Then you don't have to=
 lose
> the target profile while doing removes (and fix the other problems too).

I've often thought it would be handy to be able to forcefully set the disk =
size or free space to zero, like how it is reported by 'btrfs fi sh' during=
 a remove operation. That way a balance operation can be used for various t=
hings like profile changes or multiple disk removals (like replacing 4x1T d=
rives with 1x4T drive) without unintentionally writing a bunch of data to a=
 disk you don't want to write to anymore.
It would also allow for a more gradual removal for disks that need replacin=
g but not as an emergency, as data will gradually migrate itself to other d=
iscs as it is COWed.

Paul.
