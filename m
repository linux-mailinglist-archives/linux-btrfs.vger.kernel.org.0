Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478434238D3
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Oct 2021 09:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237335AbhJFH2z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Oct 2021 03:28:55 -0400
Received: from mail-me3aus01on2078.outbound.protection.outlook.com ([40.107.108.78]:10829
        "EHLO AUS01-ME3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230013AbhJFH2y (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 6 Oct 2021 03:28:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4ohHVO+lRxIYqRABAlL2t5RZxQIvjkn1gIHtAaJdpD3NImnpwBBTQ4DMutY9FDPN0EMTgzLuT/7jtB8TXip9F01Mn4RE2MPljzBsqAPMntfRysf1BYC08qODn0LB7Jxb8SYBDA+edsHVvIyjKSwobiz0nTAoKe6u3zQMtvEDbIN9kWlnYyaw+xlNwluox63BsuoN0txuQy0GY1NopzZgVdCi+D/Eio/wP6bZ1RMLWFq3hwDXMYQq8PibpP0oinj6vfj+5CebMETW2XlHah4DDhrJJKpN+mdPLYj6F4xReNlXtaxf9KRZpCvPciiL8a+TgGtG4mimLfF/LN575AP1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FfJfQVyLQ/gO900+AYuBbrXO9uKCDVrLmlmd3hh+9+o=;
 b=VrRifXBchfMhmLZC4v3oTnw0/oO51VbXdjkAEHAK+1ZNY3mJT4QuzHfY9OfPXK7K4KL52493PMgAnXBIJL5vo2nAyZrvyT2s+A2pFOCKl8a9yp999KP4a2yOB4fSBESTzJWnMRX+KL5ZlmmKJEuJC1OGw6BwjlTV7gOVjd3jG/zq78eOF7gCkW8VFb1fqFhKFqWXHDz0AtJLRkC0cF+bnRGWPPfYPPRBOVO6e/C7166XZmunup7zi9ghnuI+WM5L4BSiTQnTMlUy7Yra2RQEBj52FvrBYYO+N+ikDmGHf4mwSX19GjN4Xp3cE6DlIsTOadWilaH3e7NwTWITH3pf1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pauljones.id.au; dmarc=pass action=none
 header.from=pauljones.id.au; dkim=pass header.d=pauljones.id.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oakvillepondscapes.onmicrosoft.com;
 s=selector2-oakvillepondscapes-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfJfQVyLQ/gO900+AYuBbrXO9uKCDVrLmlmd3hh+9+o=;
 b=sKRKB1JUznzNmDfWYokQh9zNlYxXqjq5qV5s59DxGUcQTMSCuV7fqNL/XD5LFsFlMPhHZry8Kwq2gV606nQGBN7s8ZvX/qJkfUFsYaDvglq2J0xU1sTxI1p40gzmPx11hQROnAkfYUDD/FHoDNosMGjpysipb5bRGAYdcoha9b4=
Received: from SYXPR01MB1918.ausprd01.prod.outlook.com (2603:10c6:0:2b::11) by
 SY3PR01MB0796.ausprd01.prod.outlook.com (2603:10c6:0:2::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.19; Wed, 6 Oct 2021 07:26:57 +0000
Received: from SYXPR01MB1918.ausprd01.prod.outlook.com
 ([fe80::416f:f98f:2ea:ecb3]) by SYXPR01MB1918.ausprd01.prod.outlook.com
 ([fe80::416f:f98f:2ea:ecb3%5]) with mapi id 15.20.4566.022; Wed, 6 Oct 2021
 07:26:57 +0000
From:   Paul Jones <paul@pauljones.id.au>
To:     Nick Terrell <nickrterrell@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
CC:     "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "squashfs-devel@lists.sourceforge.net" 
        <squashfs-devel@lists.sourceforge.net>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Nick Terrell <terrelln@fb.com>, Chris Mason <clm@fb.com>,
        Petr Malat <oss@malat.biz>, Yann Collet <cyan@fb.com>,
        Christoph Hellwig <hch@infradead.org>,
        =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>,
        David Sterba <dsterba@suse.cz>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Felix Handte <felixh@fb.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Tom Seewald <tseewald@gmail.com>
Subject: RE: [GIT PULL][v12] zstd changes for linux-next
Thread-Topic: [GIT PULL][v12] zstd changes for linux-next
Thread-Index: AQHXuYpmfu/kJxtVvkmL5OaOetZ/r6vFk7PA
Date:   Wed, 6 Oct 2021 07:26:56 +0000
Message-ID: <SYXPR01MB19183D4BD6A62319A082E0BF9EB09@SYXPR01MB1918.ausprd01.prod.outlook.com>
References: <20211005014118.3164585-1-nickrterrell@gmail.com>
In-Reply-To: <20211005014118.3164585-1-nickrterrell@gmail.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=pauljones.id.au;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 81abcf04-42ae-427d-a088-08d9889aadbb
x-ms-traffictypediagnostic: SY3PR01MB0796:
x-microsoft-antispam-prvs: <SY3PR01MB0796AD93DF2F3709FDAADC9A9EB09@SY3PR01MB0796.ausprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PynqXQNgrfDZgn9+do3o7XylqFAbDuInFjwNtkXmfJDDlnWBno2dvzLIZTJdrZCjh2PE9w2F/HCIqOBtzzChnfoPZSOEU7ALN21FbcHageeKv61SmJ2xhTjOaT+dN9k2WlBvuRXEAq2ApIFKT7bqszmuczGtrN5cFmf8ZNQVAzUd9ox0j3J2p4c6XMwMVWoYf8gzuLND517IPkScDHc8u9jugVWugzw5uCOsMfQwEv0aftqHtrM5rA9MYpYiGgypu2pwi8RVdLjbFF5C0K2bS+SE4Fg2+yYKo1o1Wcep71kDTUSdJgak2uAGcwHdhJlmePP1Ntw6tcCa4AJcqIy5TTLIsCEh23lACVcIw/n+8hDdNNaHa7G/OujDcWJVA4v/UTnUyLna1kR6wrPPWLiDazROsLMjabJgHJ+r/FTOMw0KSNC9k26M9bfPlqseMIJbmkWWuvQXr6bFaLWDBKc2arwSUZkLUw2fM+Fq1vmYt4+z8E4rSIaF66V/3LUU+aAASxdAwinBTAO4u+ehMxYWfjDmuLp43pcebJJ6Rs2set6DfCCaF0vbHWnBGCz5X23VJFu/aZgx5xH6lZUQcFZs6ERAo0AMc52DZMD/Wxm7dAcYvQoVi+ZLm76Ve6kpbuyyIuCXhQq90lOg11t3jKtjQj4YjgbFb/jO/9ucryExQ4UY+4ipaHZ+aDZJhjmY6J3pHxe7GEvoL7aSSx65XUYtog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SYXPR01MB1918.ausprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(346002)(376002)(366004)(396003)(136003)(122000001)(55016002)(8676002)(76116006)(38070700005)(71200400001)(26005)(66476007)(66446008)(9686003)(66556008)(64756008)(83380400001)(66946007)(508600001)(6506007)(316002)(7696005)(8936002)(2906002)(4326008)(38100700002)(7416002)(54906003)(52536014)(86362001)(5660300002)(110136005)(4744005)(33656002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?JUTuL7pbfqk79u0A/WBjNf4q1b8kLR3xf4vCVwlsP+FCpCR0GpMLs4GDq5?=
 =?iso-8859-2?Q?2kZmqeUtBt9h8xQqxyocCUuKIigM+BBekk1Ch7tfLf5Smi+5p7aq7Qd9zg?=
 =?iso-8859-2?Q?4WwmZcF/PZ8gUGmLtWefWWKv5u1nohLpy+RyGRc9LPnevjJXXG0HIFn+b6?=
 =?iso-8859-2?Q?s+izV3UyPHoCvF8ghaLbP2Wivn/VU+Wrnv08tk+OW4rj6zd/MXtmLpD6h4?=
 =?iso-8859-2?Q?mND6TX09FXSvKZQcQVNuoiGJILhkn5DhrmVBT8RXZMN7Qjsaf7Me0+GeDL?=
 =?iso-8859-2?Q?dfd7pXM2jwE5anm5FYx/4NK3bopJuFiJ/opQovfAk8KNrKHNAFzLGArb8g?=
 =?iso-8859-2?Q?D+VZL6miH+4QfNFcLWqtuqyX32C92axLo4lyaURXkZbgIcBXNp54MLBWcT?=
 =?iso-8859-2?Q?Q5aCm9uD7QpnZCOw19nRogzM0LLfeq0bNxkvDWXs0dKTEeHgij/6gsMU7o?=
 =?iso-8859-2?Q?k7mMbeeM/i7VBhLPlCYE55p39yCUIDH6BW5e2GE+RTGBbvuOPOXzTkEr7J?=
 =?iso-8859-2?Q?Gi18xbmQUNzYC0ORRKFP2slTzXkKN5nmY+pIPLLw2ywrEf3ddVUd8SE8wV?=
 =?iso-8859-2?Q?EZyLHjLrYVmSYa5Y7oyz9zkFJGmVEWCj+xzS6mCQVCtu35kOjEiYNvuYTC?=
 =?iso-8859-2?Q?us9gDbrxfh8USx8W7j2UYbYWPpQEbvJl7ZvbmQDiJlFUvTwJqNw3CM7DRq?=
 =?iso-8859-2?Q?QHoU1mzfX9xNQCiIJ9j+BB4vvuFCbbzrZrgd9A/ld7Dk8cbSby+d1CrAFE?=
 =?iso-8859-2?Q?9YJsC+172NpspcZqwZ8DaJnmBVcyHCEUboib6s9sQGvl48j4zj27isNL9o?=
 =?iso-8859-2?Q?75NxHZCkTbr+hkd9TPMDJU7NqHMkMxtPePYxm6Vziw55cL0n1EBDv0/BQ8?=
 =?iso-8859-2?Q?ivbqD4p2Q0y4Gqiky7DVzpvI1HodmdFhKm0egBpjCImUhPnDeFktJMD1yQ?=
 =?iso-8859-2?Q?XlKqENmmR4N7nhPbFgdnMUHKoUqP3sjpFISTpkjlPJPufsWMwE1bzQhlHx?=
 =?iso-8859-2?Q?FqCBq2/5ip/+DNF0F4eZ0NOc1JyRV/iX4FygtV14tEDFOkG7N1386jtaeI?=
 =?iso-8859-2?Q?iU1iX3m33rWJcvCfh13fOB2UUAKH6E5xjvcuLLXhe/gvQQCaLgqxnAOO6U?=
 =?iso-8859-2?Q?F8mlmmlA/PuIYyeRo0m+Dwbb7VHH6WRSqnuZJwfGjH45/jTTEBgkoSLv66?=
 =?iso-8859-2?Q?k4wVUjqZ9OgQUHpOC/oUZRRVFn1aZzASykmlEwf4emXI4JwQJxmGgW7wJA?=
 =?iso-8859-2?Q?LO7CeKwiQmFVne9fsJyszKdmpNgoQ53Zpt+XlqNAIadiEyeFkLJCn+zffe?=
 =?iso-8859-2?Q?XRgcNvi+dVlV5zsQA4RakGsZp7471dXI3zWPHotlN3/qxhWXQKrX0ffWvO?=
 =?iso-8859-2?Q?+s2i/7COyb?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: pauljones.id.au
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYXPR01MB1918.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81abcf04-42ae-427d-a088-08d9889aadbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2021 07:26:56.9352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8f216723-e13f-4cce-b84c-58d8f16a0082
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DTkf3vKWTITtAecFjSipr+/UbtUMvi55o+jPQ6qlqpSJYrXAHDLKknX3dj7q4b5HD1N7ShcEUhqzz2HJc5ehOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY3PR01MB0796
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> -----Original Message-----
> From: Nick Terrell <nickrterrell@gmail.com>
> Sent: Tuesday, 5 October 2021 12:41 PM
>=20
> From: Nick Terrell <terrelln@fb.com>
>=20
> The following changes since commit
> a25006a77348ba06c7bc96520d331cd9dd370715:
>=20
>   Add linux-next specific files for 20211001 (2021-10-01 17:07:37 +1000)
>=20
> are available in the Git repository at:
>=20
>   git@github.com:terrelln/linux.git tags/v12-zstd-1.4.10
>=20
> for you to fetch changes up to 5210ca33b09bed5e09f72e9b46a3220f64597f8c:
>=20
>   MAINTAINERS: Add maintainer entry for zstd (2021-10-04 18:14:42 -0700)
>=20
> I would like to merge this pull request into linux-next to bake, and then
> submit the PR to Linux in the 5.16 merge window. If you have been a part =
of
> the discussion, are a maintainer of a caller of zstd, tested this code, o=
r
> otherwise been involved, thank you! And could you please respond below
> with an appropiate tag, so I can collect support for the PR

Tested By: Paul Jones <paul@pauljones.id.au>
