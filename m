Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4222DB58F
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Dec 2020 22:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbgLOVAg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Dec 2020 16:00:36 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:62558 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728601AbgLOVAX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Dec 2020 16:00:23 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BFKo2nL025413;
        Tue, 15 Dec 2020 12:58:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=5tgNtHHd0qkc0IfOna7/r+P6WSB3CguvRPOw8xV+v00=;
 b=lkVmDkv40xiJ4apRwBKpVkQThhze7YZDrIxoNBbZuafp2e6Y67CNuK/BAV6aDtqEglRW
 dH+xAS1nHn2aOtvsz6peT0Eg8LTgsAzooXwAFyLkL3BCT8IFf2B59VIe48Mbq6uFLzaX
 c4miifeyfMXPNlMuehVW1DiJauwUV2DsCNk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 35ewhdjry5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 15 Dec 2020 12:58:58 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 15 Dec 2020 12:58:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=esUvEBFEcNvPsfFLm35r6/vwV40JR9M5ow3JoM5+hr/iHEZBPBHxn7Ys4FmTQ99ihlWHns//ybbdGP4JUtrpUFRs+TW3Hx3Lq/aaNoHatbWV3HHCgpuZzYGA8btyZIII4XEpAGQ4zNNWBsX4orN7tCVeYiYeThQ9pFP9F68ITeyV0O27JXrdHWoBgt7g5VzGaEFpFFGigfArQK1BaD+ngn5z9xESID+j6yQI/Twress0qVEni3ZVtwBADPSdWg8QbN5uhFJNlXP3ULcpknwCkkK2DFDmYrVHrB10ejWtM14glw2QgxcCTlenMMHeTJAF8pO7hXtr4FW/KpK0kdX89w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5wEY/KrZZ7TNly110gUxpYjyuBP/Tj2Mn8xePHwkdtE=;
 b=ZCsUbuwN8VlmLasvVZgV9Rn0KP+j+EPlfYs0IeMHYukeeB4m+CxUvW8YtK+P/u4bFoIxxFXAOS8Y3PAKhX+500/8ke3emlhhzDcfgZzGZHzxImeNmOgk3O8M5CsvZ1DI8rPrMih02sBeTFb1tO3kfPjIcA/FBdo5IyHguqq/S9scD6/ZoSV5iKxm90XS06pD/AHJrJBQmZI1JRyT0y7AAcLvbAaEl/2pBpVIwmRqNujFHdA+K0iOwmGom4cPpmpPZcIeK0hJxNnWpMZfTbQq7bCedIlzA3jCIu3Ei8sKNV29qAsUdhi2BKwhXatFiv2qhsv+hwNc4Wq7ns/3NuAxRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5wEY/KrZZ7TNly110gUxpYjyuBP/Tj2Mn8xePHwkdtE=;
 b=MXuyD5Os0suLBYILogY1SRzvHVojHZb7uQiB6wwemThx2ZRAO8X5JoHE9lexBEmVXGL0lO2T7Q5WJoPMLYMDc/aEwuQUr1xtNU5vGk20npxVk/LFjgwEl+THgM6KKS9bifC1weVNJoEzLp5zSrKW9RcaesRhlA95PThFhgg/f4A=
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by BYAPR15MB2839.namprd15.prod.outlook.com (2603:10b6:a03:fd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18; Tue, 15 Dec
 2020 20:58:52 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::17e:aa61:eb50:290c]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::17e:aa61:eb50:290c%7]) with mapi id 15.20.3654.025; Tue, 15 Dec 2020
 20:58:52 +0000
From:   Nick Terrell <terrelln@fb.com>
To:     Nick Terrell <nickrterrell@gmail.com>
CC:     Herbert Xu <herbert@gondor.apana.org.au>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        "squashfs-devel@lists.sourceforge.net" 
        <squashfs-devel@lists.sourceforge.net>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Chris Mason <clm@fb.com>,
        Petr Malat <oss@malat.biz>, Johannes Weiner <jweiner@fb.com>,
        Niket Agarwal <niketa@fb.com>, Yann Collet <cyan@fb.com>,
        Christoph Hellwig <hch@infradead.org>,
        =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
Subject: Re: [PATCH v7 0/3] Update to zstd-1.4.6
Thread-Topic: [PATCH v7 0/3] Update to zstd-1.4.6
Thread-Index: AQHWybXbXo5DSFQdaEqlAnoQrw8JMqn4tsKA
Date:   Tue, 15 Dec 2020 20:58:52 +0000
Message-ID: <DF6B2E26-2D6E-44FF-89DB-93A37E2EA268@fb.com>
References: <20201203205114.1395668-1-nickrterrell@gmail.com>
In-Reply-To: <20201203205114.1395668-1-nickrterrell@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [98.33.101.203]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3a70fa5-ced2-465e-7525-08d8a13c3a7e
x-ms-traffictypediagnostic: BYAPR15MB2839:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB2839BBA8382C185125CD6435ABC60@BYAPR15MB2839.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kVxYVaAuy+mki69UYQxXNc8ghDXCqFjxGPrw/i/Gr1rnU2QdbYQlQFAoAoaLmwjgY+kc1o3EFqs1iVTEYe/u1hyFBs+yiwa9wJz25vAtBrfEOcEssT5hpnFi2Lec9FmxOjc1D28NoBhJhlchXrJMeQwfm5uBWaDnRvoEaMrCsoEnjAppP5QxgnbI6iNjAdUuFHSmZ7Uy2ojWrj5Cg5sdn818E7T5o2fcCJPr4lcSeyjQ0QVHO+MRfEXFD+4VSooWacvEuN0WIYuMv4sC9ZubRpeL5bsPeWbRL0bwUm1Yin+ei0Oz7N3ldeUCkWJ+aGnCCuTO72tlwEGH5q9v7u+SdNlksuNAoJo8PEtdJlqTbPDxaZH7SveqrhI6iH+GN1swG0+AHX1QYSVCBoZI6cMscpeevVa+1RXuY5SiaGebviyz4J8IsxOEQwqvj3CJNdccvI9XwzM2dqy/xsVra654Qw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(39860400002)(376002)(396003)(366004)(8676002)(7416002)(186003)(36756003)(53546011)(4326008)(6506007)(478600001)(33656002)(30864003)(6512007)(15650500001)(2616005)(71200400001)(66476007)(76116006)(66446008)(64756008)(966005)(2906002)(5660300002)(6486002)(66556008)(8936002)(66946007)(26005)(316002)(86362001)(54906003)(83380400001)(6916009)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-2?Q?3AZOutp2GPMbMgypxyZK2ZokIZf88eAB0yLZHriLDS/GgJ48YhgD+eVog1?=
 =?iso-8859-2?Q?8AofRiLwO8WFZPZbtMLd1U0/elrwGedkOfx84ps1E0dPutOORallGUwnxw?=
 =?iso-8859-2?Q?Go1+Hu88Uf0tOc4CjlalnltfeK+IsBb55hgwBqiQMa1VUd8ft/WodbbFtB?=
 =?iso-8859-2?Q?WUW/9LxnB2V8/5NmeldW6e49VferAtnBqqk4S1GFqtmy0nbnwuQn9xTb5R?=
 =?iso-8859-2?Q?Ec9YdB3eOGwqkgX6GLpjgbcmaoOWpuYm2LA6bi9hXBF1xtZbJlm78XWzhK?=
 =?iso-8859-2?Q?b+oAF6xNefLXwFS9rWFh3Ut4hdCEew3DpTi5Uq4X90bzz/Pq3tXtcHguQM?=
 =?iso-8859-2?Q?Kb03U5GOf4wLuhMuK9vF/wUH7jo03eVNf8Ia8LGkFUT//c3AlB63BfRQBu?=
 =?iso-8859-2?Q?B8yMdS/44u7wX+wEWA7ZSw+RvuHJhsPVmxloJC9EjKqE8OQt9NVcufngn7?=
 =?iso-8859-2?Q?sYH9bFQN3vMJGsCfF/axUDYhsccMJ0rLefJpXB1gyZCA3shPY9kgfzj5EI?=
 =?iso-8859-2?Q?gBqGN+DT7hnAUXRakBl1i8Lgne6KWJ4PDwQwZH5oWtEdxhghkw8ArAXIW6?=
 =?iso-8859-2?Q?lQ2G9pyzk0sZwzuVkwGOfcG/to1y4PIOAizPoXNkAybPl4bpPXaBzhGMqV?=
 =?iso-8859-2?Q?iCJm2DPMqmNgeWH4YxZ9fJAjqBYyOUgnS8FUn09y8NtyqJ/IvshsN0gRvl?=
 =?iso-8859-2?Q?flNXIGmoahXq8aIct9BobU61Uocvg7DqTeHoJ6pFn6r0ndBOEzNI7LTfkN?=
 =?iso-8859-2?Q?4pCFJfTO8PkMjfEZL53vBkL52xnJgGLQ+0NxuNE7c/lFSSKM997iUGU1Iw?=
 =?iso-8859-2?Q?Z0zaAuqzacB8zRy3dKAnqM7p2SDG69/5/9m3lKktalKCWOfy8euG6IZEdq?=
 =?iso-8859-2?Q?78H9tzDF/Y6HgvaYYPiSBBkSyVE7HlHMLzS7b1MMvWab27zQU3x2zKMDps?=
 =?iso-8859-2?Q?Yi8+qI3IEwW8gGrqx8Rf08zQ9b88uYF/8GDGTa8KvS/iTzHfQNoSUyoFZ5?=
 =?iso-8859-2?Q?Pe07SZAH2VOJ9EKbPE7ONCmfrBHzdB/UTLNNx+?=
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <FC065527164D554DB5D995FB0FC52D12@namprd15.prod.outlook.com>
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a70fa5-ced2-465e-7525-08d8a13c3a7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2020 20:58:52.3451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pCmKnJpO8tfKx9jzaiqvMuRX7xP8l4eVAql6uNZkFJcq3Uh0z/WIMh++TZS8FsAT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2839
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-15_12:2020-12-15,2020-12-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 spamscore=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999
 adultscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012150140
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



> On Dec 3, 2020, at 12:51 PM, Nick Terrell <nickrterrell@gmail.com> wrote:
>=20
> From: Nick Terrell <terrelln@fb.com>
>=20
> Please pull from
>=20
>  git@github.com:terrelln/linux.git tags/v7-zstd-1.4.6
>=20
> to get these changes. Alternatively the patchset is included.

Is it possible to get this patchset merged in the 5.11 merge window? It app=
lies
cleanly to the latest master. Please let me know if there is anything that =
I can do
to drive this patchset towards merge.

Thanks,
Nick

> This patchset upgrades the zstd library to the latest upstream release. T=
he
> current zstd version in the kernel is a modified version of upstream zstd=
-1.3.1.
> At the time it was integrated, zstd wasn't ready to be used in the kernel=
 as-is.
> But, it is now possible to use upstream zstd directly in the kernel.
>=20
> I have not yet released zstd-1.4.6 upstream. I want the zstd version in t=
he
> kernel to match up with a known upstream release, so we know exactly what=
 code
> is running. Whenever this patchset is ready for merge, I will cut a relea=
se at
> the upstream commit that gets merged. This should not be necessary for fu=
ture
> releases.
>=20
> The kernel zstd library is automatically generated from upstream zstd. A =
script
> makes the necessary changes and imports it into the kernel. The changes a=
re:
>=20
> 1. Replace all libc dependencies with kernel replacements and rewrite inc=
ludes.
> 2. Remove unncessary portability macros like: #if defined(_MSC_VER).
> 3. Use the kernel xxhash instead of bundling it.
>=20
> This automation gets tested every commit by upstream's continuous integra=
tion.
> When we cut a new zstd release, we will submit a patch to the kernel to u=
pdate
> the zstd version in the kernel.
>=20
> I've updated zstd to upstream with one big patch because every commit mus=
t build,
> so that precludes partial updates. Since the commit is 100% generated, I =
hope the
> review burden is lightened. I considered replaying upstream commits, but =
that is
> not possible because there have been ~3500 upstream commits since the las=
t zstd
> import, and the commits don't all build individually. The bulk update pre=
serves
> bisectablity because bugs can be bisected to the zstd version update. At =
that
> point the update can be reverted, and we can work with upstream to find a=
nd fix
> the bug. After this big switch in how the kernel consumes zstd, future pa=
tches
> will be smaller, because they will only have one upstream release worth of
> changes each.
>=20
> This patchset adds a new kernel-style wrapper around zstd. This wrapper A=
PI is
> functionally equivalent to the subset of the current zstd API that is cur=
rently
> used. The wrapper API changes to be kernel style so that the symbols don't
> collide with zstd's symbols. The update to zstd-1.4.6 maintains the same =
API
> and preserves the semantics, so that none of the callers need to be updat=
ed.
>=20
> This patchset comes in 2 parts:
> 1. The first 2 patches prepare for the zstd upgrade. The first patch adds=
 the
>   new kernel style API so zstd can be upgraded without modifying any call=
ers.
>   The second patch adds an indirection for the lib/decompress_unzstd.c
>   including of all decompression source files.
> 2. Import zstd-1.4.6. This patch is completely generated from upstream us=
ing
>   automated tooling.
>=20
> I tested every caller of zstd on x86_64. I tested both after the 1.4.6 up=
grade
> using the compatibility wrapper, and after the final patch in this series=
.=20
>=20
> I tested kernel and initramfs decompression in i386 and arm.
>=20
> I ran benchmarks to compare the current zstd in the kernel with zstd-1.4.=
6.
> I benchmarked on x86_64 using QEMU with KVM enabled on an Intel i9-9900k.
> I found:
> * BtrFS zstd compression at levels 1 and 3 is 5% faster
> * BtrFS zstd decompression+read is 15% faster
> * SquashFS zstd decompression+read is 15% faster
> * F2FS zstd compression+write at level 3 is 8% faster
> * F2FS zstd decompression+read is 20% faster
> * ZRAM decompression+read is 30% faster
> * Kernel zstd decompression is 35% faster
> * Initramfs zstd decompression+build is 5% faster
>=20
> The latest zstd also offers bug fixes and a 1 KB reduction in stack uage =
during
> compression. For example the recent problem with large kernel decompressi=
on has
> been fixed upstream for over 2 years https://lkml.org/lkml/2020/9/29/27.
>=20
> Please let me know if there is anything that I can do to ease the way for=
 these
> patches. I think it is important because it gets large performance improv=
ements,
> contains bug fixes, and is switching to a more maintainable model of cons=
uming
> upstream zstd directly, making it easy to keep up to date.
>=20
> Best,
> Nick Terrell
>=20
> v1 -> v2:
> * Successfully tested F2FS with help from Chao Yu to fix my test.
> * (1/9) Fix ZSTD_initCStream() wrapper to handle pledged_src_size=3D0 mea=
ns unknown.
>  This fixes F2FS with the zstd-1.4.6 compatibility wrapper, exposed by th=
e test.
>=20
> v2 -> v3:
> * (3/9) Silence warnings by Kernel Test Robot:
>  https://github.com/facebook/zstd/pull/2324
>  Stack size warnings remain, but these aren't new, and the functions it w=
arns on
>  are either unused or not in the maximum stack path. This patchset reduce=
s zstd
>  compression stack usage by 1 KB overall. I've gotten the low hanging fru=
it, and
>  more stack reduction would require significant changes that have the pot=
ential
>  to introduce new bugs. However, I do hope to continue to reduce zstd sta=
ck
>  usage in future versions.
>=20
> v3 -> v4:
> * (3/9) Fix errors and warnings reported by Kernel Test Robot:
>  https://github.com/facebook/zstd/pull/2326
>  - Replace mem.h with a custom kernel implementation that matches the cur=
rent
>    lib/zstd/mem.h in the kernel. This avoids calls to __builtin_bswap*() =
which
>    don't work on certain architectures, as exposed by the Kernel Test Rob=
ot.
>  - Remove ASAN/MSAN (un)poisoning code which doesn't work in the kernel, =
as
>    exposed by the Kernel Test Robot.
>  - I've fixed all of the valid cppcheck warnings reported, but there were=
 many
>    false positives, where cppcheck was incorrectly analyzing the situatio=
n,
>    which I did not fix. I don't believe it is reasonable to expect that u=
pstream
>    zstd silences all the static analyzer false positives. Upstream zstd u=
ses
>    clang scan-build for its static analysis. We find that supporting mult=
iple
>    static analysis tools multiplies the burden of silencing false positiv=
es,
>    without providing enough marginal value over running a single static a=
nalysis
>    tool.
>=20
> v4 -> v5:
> * Rebase onto v5.10-rc2
> * (6/9) Merge with other F2FS changes (no functional change in patch).
>=20
> v5 -> v6:
> * Rebase onto v5.10-rc6.
> * Switch to using a kernel style wrapper API as suggested by Cristoph.
>=20
> v6 -> v7:
> * Expose the upstream library header as `include/linux/zstd_lib.h`.
>  Instead of creating new structs mirroring the upstream zstd structs
>  use upstream's structs directly with a typedef to get a kernel style nam=
e.
>  This removes the memcpy cruft.
> * (1/3) Undo ZSTD_WINDOWLOG_MAX and handle_zstd_error changes.
> * (3/3) Expose zstd_errors.h as `include/linux/zstd_errors.h` because it
>  is needed by the kernel wrapper API.
>=20
>=20
> Nick Terrell (3):
>  lib: zstd: Add kernel-specific API
>  lib: zstd: Add decompress_sources.h for decompress_unzstd
>  lib: zstd: Upgrade to latest upstream zstd version 1.4.6
>=20
> crypto/zstd.c                                 |   28 +-
> fs/btrfs/zstd.c                               |   68 +-
> fs/f2fs/compress.c                            |   56 +-
> fs/pstore/platform.c                          |    2 +-
> fs/squashfs/zstd_wrapper.c                    |   16 +-
> include/linux/zstd.h                          | 1225 +----
> include/linux/zstd_errors.h                   |   76 +
> include/linux/zstd_lib.h                      | 2104 +++++++++
> lib/decompress_unzstd.c                       |   48 +-
> lib/zstd/Makefile                             |   35 +-
> lib/zstd/bitstream.h                          |  379 --
> lib/zstd/common/bitstream.h                   |  437 ++
> lib/zstd/common/compiler.h                    |  150 +
> lib/zstd/common/cpu.h                         |  194 +
> lib/zstd/common/debug.c                       |   24 +
> lib/zstd/common/debug.h                       |  101 +
> lib/zstd/common/entropy_common.c              |  355 ++
> lib/zstd/common/error_private.c               |   55 +
> lib/zstd/common/error_private.h               |   66 +
> lib/zstd/common/fse.h                         |  709 +++
> lib/zstd/common/fse_decompress.c              |  380 ++
> lib/zstd/common/huf.h                         |  352 ++
> lib/zstd/common/mem.h                         |  258 +
> lib/zstd/common/zstd_common.c                 |   83 +
> lib/zstd/common/zstd_deps.h                   |  124 +
> lib/zstd/common/zstd_internal.h               |  438 ++
> lib/zstd/compress.c                           | 3485 --------------
> lib/zstd/compress/fse_compress.c              |  625 +++
> lib/zstd/compress/hist.c                      |  165 +
> lib/zstd/compress/hist.h                      |   75 +
> lib/zstd/compress/huf_compress.c              |  764 +++
> lib/zstd/compress/zstd_compress.c             | 4157 +++++++++++++++++
> lib/zstd/compress/zstd_compress_internal.h    | 1103 +++++
> lib/zstd/compress/zstd_compress_literals.c    |  158 +
> lib/zstd/compress/zstd_compress_literals.h    |   29 +
> lib/zstd/compress/zstd_compress_sequences.c   |  433 ++
> lib/zstd/compress/zstd_compress_sequences.h   |   54 +
> lib/zstd/compress/zstd_compress_superblock.c  |  849 ++++
> lib/zstd/compress/zstd_compress_superblock.h  |   32 +
> lib/zstd/compress/zstd_cwksp.h                |  465 ++
> lib/zstd/compress/zstd_double_fast.c          |  521 +++
> lib/zstd/compress/zstd_double_fast.h          |   32 +
> lib/zstd/compress/zstd_fast.c                 |  496 ++
> lib/zstd/compress/zstd_fast.h                 |   31 +
> lib/zstd/compress/zstd_lazy.c                 | 1138 +++++
> lib/zstd/compress/zstd_lazy.h                 |   61 +
> lib/zstd/compress/zstd_ldm.c                  |  619 +++
> lib/zstd/compress/zstd_ldm.h                  |  104 +
> lib/zstd/compress/zstd_opt.c                  | 1200 +++++
> lib/zstd/compress/zstd_opt.h                  |   50 +
> lib/zstd/decompress.c                         | 2531 ----------
> lib/zstd/decompress/huf_decompress.c          | 1205 +++++
> lib/zstd/decompress/zstd_ddict.c              |  241 +
> lib/zstd/decompress/zstd_ddict.h              |   44 +
> lib/zstd/decompress/zstd_decompress.c         | 1836 ++++++++
> lib/zstd/decompress/zstd_decompress_block.c   | 1540 ++++++
> lib/zstd/decompress/zstd_decompress_block.h   |   62 +
> .../decompress/zstd_decompress_internal.h     |  195 +
> lib/zstd/decompress_sources.h                 |   19 +
> lib/zstd/entropy_common.c                     |  243 -
> lib/zstd/error_private.h                      |   53 -
> lib/zstd/fse.h                                |  575 ---
> lib/zstd/fse_compress.c                       |  795 ----
> lib/zstd/fse_decompress.c                     |  325 --
> lib/zstd/huf.h                                |  212 -
> lib/zstd/huf_compress.c                       |  772 ---
> lib/zstd/huf_decompress.c                     |  960 ----
> lib/zstd/mem.h                                |  151 -
> lib/zstd/zstd_common.c                        |   75 -
> lib/zstd/zstd_compress_module.c               |  103 +
> lib/zstd/zstd_decompress_module.c             |   96 +
> lib/zstd/zstd_internal.h                      |  273 --
> lib/zstd/zstd_opt.h                           | 1014 ----
> 73 files changed, 24800 insertions(+), 12929 deletions(-)
> create mode 100644 include/linux/zstd_errors.h
> create mode 100644 include/linux/zstd_lib.h
> delete mode 100644 lib/zstd/bitstream.h
> create mode 100644 lib/zstd/common/bitstream.h
> create mode 100644 lib/zstd/common/compiler.h
> create mode 100644 lib/zstd/common/cpu.h
> create mode 100644 lib/zstd/common/debug.c
> create mode 100644 lib/zstd/common/debug.h
> create mode 100644 lib/zstd/common/entropy_common.c
> create mode 100644 lib/zstd/common/error_private.c
> create mode 100644 lib/zstd/common/error_private.h
> create mode 100644 lib/zstd/common/fse.h
> create mode 100644 lib/zstd/common/fse_decompress.c
> create mode 100644 lib/zstd/common/huf.h
> create mode 100644 lib/zstd/common/mem.h
> create mode 100644 lib/zstd/common/zstd_common.c
> create mode 100644 lib/zstd/common/zstd_deps.h
> create mode 100644 lib/zstd/common/zstd_internal.h
> delete mode 100644 lib/zstd/compress.c
> create mode 100644 lib/zstd/compress/fse_compress.c
> create mode 100644 lib/zstd/compress/hist.c
> create mode 100644 lib/zstd/compress/hist.h
> create mode 100644 lib/zstd/compress/huf_compress.c
> create mode 100644 lib/zstd/compress/zstd_compress.c
> create mode 100644 lib/zstd/compress/zstd_compress_internal.h
> create mode 100644 lib/zstd/compress/zstd_compress_literals.c
> create mode 100644 lib/zstd/compress/zstd_compress_literals.h
> create mode 100644 lib/zstd/compress/zstd_compress_sequences.c
> create mode 100644 lib/zstd/compress/zstd_compress_sequences.h
> create mode 100644 lib/zstd/compress/zstd_compress_superblock.c
> create mode 100644 lib/zstd/compress/zstd_compress_superblock.h
> create mode 100644 lib/zstd/compress/zstd_cwksp.h
> create mode 100644 lib/zstd/compress/zstd_double_fast.c
> create mode 100644 lib/zstd/compress/zstd_double_fast.h
> create mode 100644 lib/zstd/compress/zstd_fast.c
> create mode 100644 lib/zstd/compress/zstd_fast.h
> create mode 100644 lib/zstd/compress/zstd_lazy.c
> create mode 100644 lib/zstd/compress/zstd_lazy.h
> create mode 100644 lib/zstd/compress/zstd_ldm.c
> create mode 100644 lib/zstd/compress/zstd_ldm.h
> create mode 100644 lib/zstd/compress/zstd_opt.c
> create mode 100644 lib/zstd/compress/zstd_opt.h
> delete mode 100644 lib/zstd/decompress.c
> create mode 100644 lib/zstd/decompress/huf_decompress.c
> create mode 100644 lib/zstd/decompress/zstd_ddict.c
> create mode 100644 lib/zstd/decompress/zstd_ddict.h
> create mode 100644 lib/zstd/decompress/zstd_decompress.c
> create mode 100644 lib/zstd/decompress/zstd_decompress_block.c
> create mode 100644 lib/zstd/decompress/zstd_decompress_block.h
> create mode 100644 lib/zstd/decompress/zstd_decompress_internal.h
> create mode 100644 lib/zstd/decompress_sources.h
> delete mode 100644 lib/zstd/entropy_common.c
> delete mode 100644 lib/zstd/error_private.h
> delete mode 100644 lib/zstd/fse.h
> delete mode 100644 lib/zstd/fse_compress.c
> delete mode 100644 lib/zstd/fse_decompress.c
> delete mode 100644 lib/zstd/huf.h
> delete mode 100644 lib/zstd/huf_compress.c
> delete mode 100644 lib/zstd/huf_decompress.c
> delete mode 100644 lib/zstd/mem.h
> delete mode 100644 lib/zstd/zstd_common.c
> create mode 100644 lib/zstd/zstd_compress_module.c
> create mode 100644 lib/zstd/zstd_decompress_module.c
> delete mode 100644 lib/zstd/zstd_internal.h
> delete mode 100644 lib/zstd/zstd_opt.h
>=20
> --=20
> 2.29.2
>=20

