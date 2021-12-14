Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B436B473A03
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Dec 2021 02:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240361AbhLNBDk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Dec 2021 20:03:40 -0500
Received: from mail-bn8nam08on2053.outbound.protection.outlook.com ([40.107.100.53]:62305
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232173AbhLNBDk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Dec 2021 20:03:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFVjwrSdgO1P5Cs3k6D4QRnyIei1xIo1A5HK5m/64MLOLlcWmRrUGx8gtumeNtkwcTLH5Qn5t9+ZaHGtQFPGyhIkVDhhXBlyC2PEDX0yThUqslW6MPnpdWNAFu2K8Ah4uGqZd4OOA2qs+CMh5UXxbuzXTRxDyrkyD9GfHEKwhAy4WPsZWW3SH+Y2/CJ2AESZJ2e8pMjHUwqwvmVvwyC6pKjFSjaSsJrO+jUWYin+oYl/Q0mTmQuzO3CmLTzZxg6Z8stCx4Z9t8wLdFvnDeYEcZ2Gb4JGXcDwOuKN4zwCzO0T+h1FnyBgKkMTHc3Yz66kr5j8RfMFD0w7t35c+2LqDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unpt6AXuUn+D0Lf4Jgy0DTE6/lXZcb9zIl8qS81i6UM=;
 b=M+3uva9YzvVXOvxQO9OO5l25BUYp9HsxjElV/oJ1X4Gvi3uKAyr3g7BxxhVb9tSul++AMzPM9QNzteuEZi+b/NAY9Pf5W08jFskZBOIAksHYBg2DoxNt5eo0OcWsN5KC22BXl2JIbMywhXGerL5MIz1iKskVQ9YDTaVccK/hjpxxTz9E9ewSHcWA/TzsxpIpgrpVhHyrON2dAthp1zGfX+pJdQj8KILQcY5ibM8kwa7KCI2jAslmNSWgjOj+taBlPkUIMdDLvGDrNUmVc/75JXq52xX5tiFu2NqLNWa8nsSA0DQJeSu6xIpa3AFO9HS3SKKivisbrYtUt87oDmBrXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=panasas.com; dmarc=pass action=none header.from=panasas.com;
 dkim=pass header.d=panasas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=panasas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unpt6AXuUn+D0Lf4Jgy0DTE6/lXZcb9zIl8qS81i6UM=;
 b=kTuqFjCm5AKvaoMM9hXzkGvnKiOY3EA8mlYHunHUpXYJCDF3L2P1MMZ6Sx6oyE1VJIpCdedPH3xAWzoylJycQD4bUtQITCP1OLwolEHSsXNMCWxPj3Kbt6OIfY0CtMrJNZwxflG2W+XckyvVGOOHxHAuooWvYc/uViVf3OjhlvI=
Received: from SN6PR08MB4400.namprd08.prod.outlook.com (2603:10b6:805:37::31)
 by SN6PR08MB3981.namprd08.prod.outlook.com (2603:10b6:805:20::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13; Tue, 14 Dec
 2021 01:03:37 +0000
Received: from SN6PR08MB4400.namprd08.prod.outlook.com
 ([fe80::748b:5ba5:b71f:2f1a]) by SN6PR08MB4400.namprd08.prod.outlook.com
 ([fe80::748b:5ba5:b71f:2f1a%7]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 01:03:37 +0000
From:   "Sinnamohideen, Shafeeq" <shafeeqs@panasas.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "kreijack@inwind.it" <kreijack@inwind.it>
CC:     David Sterba <dsterba@suse.cz>, Paul Jones <paul@pauljones.id.au>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Dmitriy Gorokh <Dmitriy_Gorokh@epam.com>
Subject: RE: [RFC][V8][PATCH 0/5] btrfs: allocation_hint mode
Thread-Topic: [RFC][V8][PATCH 0/5] btrfs: allocation_hint mode
Thread-Index: AQHXyOwy8f+C7Vo8gUCpyPBtsUp3VKwweL2AgACr3wCAABaVAIAAOUVw
Date:   Tue, 14 Dec 2021 01:03:37 +0000
Message-ID: <SN6PR08MB44004972FE9C2794BA8FE48ED4759@SN6PR08MB4400.namprd08.prod.outlook.com>
References: <cover.1635089352.git.kreijack@inwind.it>
 <SYXPR01MB1918689AF49BE6E6E031C8B69E749@SYXPR01MB1918.ausprd01.prod.outlook.com>
 <1d725df7-b435-4acf-4d17-26c2bd171c1a@libero.it>
 <Ybe34gfrxl8O89PZ@localhost.localdomain>
In-Reply-To: <Ybe34gfrxl8O89PZ@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=panasas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e1723b68-f463-4a38-9efe-08d9be9d8f73
x-ms-traffictypediagnostic: SN6PR08MB3981:EE_
x-microsoft-antispam-prvs: <SN6PR08MB3981A431DAB8BA208DAD0FF2D4759@SN6PR08MB3981.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EkQmYdS/vz1d1LG5gaOs2J0RYf6I2JTIxNK5xAY0QyjsXDsIVcynefP+vQI/gvOw53LqqLVv4vE/KPdwj1evqxQtF6XoY1z51kUTx4JQx/AbnwukbywE4nLJzcVnH3g084Dmhu73dSq3nkOMPhX3J/97vmqq8tFtpaDPhrUMckcha1uEcLN4FQD1/tNlCBKthHYmzrADRT12JAkCJvj2uXbgiwtSRoK2mqjbwGyP6pJxhEdulefG3JHir+K8nSoUHznHyYK6XI0re/tM+KZHfCJMU03TMVAssH0H0MQzuODNoRPaP9sczRIvHRDbH4ypgQZPwSfFu2ZzGR19Jiyl2mblNug2mBfRFzqzQNamwnrWQ3BQJReCL+qqpRjP+y32eET9EAOdUvLM8oSTVcqQr6upirHCD6Lu81G1baZW0uLTO/Vo9A5YgIWBnt9L1DWt7ck9vH6QASUA3QbRgd3VfnmaNSedjHMvQsl8hR3CI4KhMlr2Gp2XvCSIXGpqJ5FHE1my+YGY8NSW5gb6BefRQ/eHujqvliMar/HEgTB+8hbW4/Il/QOfwX26KrQJr38CG5b8npWEN+hhQJNxN8/Kf7gpXAcKNZAN/K9MAL+4IpNUmlGqvoV6OfpQJItJuYrzZe3MJEFXa3ESyXX3qe7v7ladwJWd0fssC6iB2bT9MGkJEaRKtNZtmvSx6D93b9JOEvO9ASuKfoyFBVslg+BTJg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR08MB4400.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(39840400004)(396003)(376002)(366004)(54906003)(9686003)(2906002)(66446008)(64756008)(186003)(66556008)(66476007)(55016003)(26005)(7696005)(6506007)(53546011)(38070700005)(71200400001)(110136005)(52536014)(8936002)(5660300002)(8676002)(33656002)(508600001)(86362001)(4326008)(66946007)(122000001)(316002)(83380400001)(38100700002)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4UdpP+gryuZXApQxJrx5mRWTjBPESl1E0iyIQHciTJBfOcr0qmLmdCxG1SCA?=
 =?us-ascii?Q?3KbohT3Lmw5D2A4Hgzp/vCOYVqlrxpGKtpmiQI+1jiWgGzEUKU6H1gTxIs/8?=
 =?us-ascii?Q?zt9tUG1lML2BjVleFM/zzjwq4QT4aQFGuKyhUNZfZfVnAakQG776S2rdPSrP?=
 =?us-ascii?Q?LKGDNOBKJ1nRO4mB+rb0TciPZqu8KNnz6ItiYY4KzaPDVy5ddazRUXS6puDI?=
 =?us-ascii?Q?MxK3s2fEPsAG+Xcp2RJbW4QNhfoC8aF4xrpoFQfwlo5i0oLFzHAB53gX6n8G?=
 =?us-ascii?Q?oQ9bIECEy2pzGckj4FCe4Lmv1C0S7N3pgkzPfz2pBZdTnXhTGU4ZhtW8XbdT?=
 =?us-ascii?Q?doBwWZi+LTaT1f5r/MZHgOlMJgBh+0k4Gq8dJUg5KtSqrWH7VbKa13Kkw4kO?=
 =?us-ascii?Q?hretHC1NS6qVoDy0cdgT1xSnmPZUbFJtJ4UbP0n1ad1ZiRVpUqMVyZ7X9nRJ?=
 =?us-ascii?Q?cgUH9QIOfRw6VSmAD+5CV/mLXDaqSEUgeW20SpnqudC2KJeAXoFWjH+2X/1R?=
 =?us-ascii?Q?F5wnY9sW9qkfWuUzTD2RliKtKJWUgum8HI/qy8AEOJA+TjaeBDLoGhry7B+Z?=
 =?us-ascii?Q?FS7leuxt8YNNwqO1Ga2wcoz+O3VWjCKEMM/L7LiOeGGtm4Sbs5JKzD6OXM8v?=
 =?us-ascii?Q?ztkT30dNasECRoHGLmq+WeWphbs0dirFPS+SVJ72iuek316z/I4ZMUhDqyu3?=
 =?us-ascii?Q?Bqc/Td2fLu56Ar8WZaGj1Au0ANU4umIu8DKtJapdaKN+1WnzyW+uokvmzI8f?=
 =?us-ascii?Q?tVEG7j29juwwZrhNTLIyUNT0HsjRfBlc2gCXxPIuFc3fZyEL7eaaj+nZRKD9?=
 =?us-ascii?Q?GCduVmtV7Or48EaU5FsETxw92pYO4uaCNHSUK3azGrmsIj8mFAR2wTCtR2oF?=
 =?us-ascii?Q?6RKsDA8ppks1FaCou4O22usqGYwqiqt5f+Lwi/R4WXfOAjBl/phYyfThGEuN?=
 =?us-ascii?Q?boqbTPXPVO2h9OUiGJrlcbOm4Ra/tTV9NmiRqqi//EcrXfvCtSCgYXj1ruai?=
 =?us-ascii?Q?uwtqdRY0FRjlTlSUcnIfYODDfhniBw8eJfYuCc9uzXMZeJ50SftmQw4cHw5C?=
 =?us-ascii?Q?sbaOrL3YIVjcDSq+ZhI0b2fmkyW0QTO6/2FTB7t9retRCws1pkkIOUN7UVHV?=
 =?us-ascii?Q?QnyIDdsmjjuBo1lGBABEq0a1jD52DFNqr4y4QcKy5Ko64sEkt+1jqkh78CJ5?=
 =?us-ascii?Q?T2iILqxRgywA8RVxb57TlYEbXqhf94Mlwx0h1HMeBL4Djs0tJZn0uQ+0exZS?=
 =?us-ascii?Q?rCAubp2Zwo1Y4uj1hmODwdoi9lip1kitD3Tg6K03E5FA1CGGlmQOtBD/19cZ?=
 =?us-ascii?Q?2tCMGTyUBzjwo4KHY07FJwK4Dvazhekr91DzlNBX50vnGHre30uId0X000Xl?=
 =?us-ascii?Q?hMJmSk0bZKDTr2QrQiH3elxONT1BkgL7oO1nn5VheaXoOjoDKf9JNSFc/uA0?=
 =?us-ascii?Q?WGdN3O1mXlkm9i0UNeAACtS/UQ1tGLi/qqcRC8d/ysCm5wygxyVqIhCtzwpa?=
 =?us-ascii?Q?9LyrIDdQjsSdGknBvqHdsrwhAyPQl56oibnXWcYYV46LwB7z/Dwv/Xkw8IAZ?=
 =?us-ascii?Q?UXxh/4PPZoqCiJJj0QqWNSRNq7iVq7wPyBMkBKfKMPAs8aaZ/XDT1gyROkPJ?=
 =?us-ascii?Q?5w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: panasas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR08MB4400.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1723b68-f463-4a38-9efe-08d9be9d8f73
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 01:03:37.3310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: acf01c9d-c699-42af-bdbb-44bf582e60b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rcaIatA2T0/ZqtjH0UV+6OAcFL8+c7/kZ45eoV80jrqy+8pyyCYdYbgp+yUl27llBjxZafL2eFSzEmK0HlY1JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB3981
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Panasas would be very happy with this patch - it solves a problem we have w=
hen delete-only workloads thrash the disks. Because it is equivalent to "rm=
 -rf" of an old directory, caching does't help since the metadata of the fi=
les being deleted will have fallen out of bcache long ago. So giving up a s=
mall amount of SSD space to always hold the metadata yields a big performan=
ce improvement.

We got as far as verifying that it doesn't break existing xfstests, we are =
open to writing the test cases you listed and also to check that the device=
 out-of-space cases behave as expected.

Thanks,
Shafeeq

-----Original Message-----
From: Josef Bacik <josef@toxicpanda.com>=20
Sent: Monday, December 13, 2021 4:15 PM
To: kreijack@inwind.it
Cc: David Sterba <dsterba@suse.cz>; Sinnamohideen, Shafeeq <shafeeqs@panasa=
s.com>; Paul Jones <paul@pauljones.id.au>; linux-btrfs@vger.kernel.org; Zyg=
o Blaxell <ce3g8jdj@umail.furryterror.org>
Subject: Re: [RFC][V8][PATCH 0/5] btrfs: allocation_hint mode

On Mon, Dec 13, 2021 at 08:54:24PM +0100, Goffredo Baroncelli wrote:
> Gentle ping :-)
>=20
> Are there anyone of the mains developer interested in supporting this pat=
ch ?
>=20
> I am open to improve it if required.
>=20

Sorry I missed this go by.  I like the interface, we don't have a use for
device->type yet, so this fits nicely.

I don't see the btrfs-progs patches in my inbox, and these don't apply, so =
you'll definitely need to refresh for a proper review, but looking at these=
 patches they seem sane enough, and I like the interface.  I'd like to hear=
 Zygo's opinion as well.

If we're going to use device->type for this, and since we don't have a user=
 of
device->type, I'd also like you to go ahead and re-name ->type to
->allocation_policy, that way it's clear what we're using it for now.

I'd also like some xfstests to validate the behavior so we're sure we're te=
sting this.  I'd want 1 test to just test the mechanics, like mkfs with dif=
ferent policies and validate they're set right, change policies, add/remove=
 disks with different policies.

Then a second test to do something like fsstress with each set of allocatio=
n policies to validate that we did actually allocate from the correct disks=
.  For this please also test with compression on to make sure the test vali=
dation works for both normal allocation and compression (ie it doesn't assu=
me writing 5gib of data =3D=3D 5 gib of data usage, as compression chould g=
ive you a different value).

With that in place I think this is the correct way to implement this featur=
e.
Thanks,

Josef
