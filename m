Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14104C93F6
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Mar 2022 20:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiCATKj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Mar 2022 14:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiCATKi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Mar 2022 14:10:38 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345DE63BEC;
        Tue,  1 Mar 2022 11:09:56 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 221GjK96029912;
        Tue, 1 Mar 2022 11:09:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=MpuNx6hAv5CaxVNEpU1Zl6SXeOxUbYVDv+IzqJkijEg=;
 b=jldDJXVtQLf/V6TC3NaPo6Oe7QfpcUdo5mhRg6/CSqPhfzhWv2RLz5Z3OBLy70n6fUca
 0c6SSdn+QexFhTkSu96hVcp5wwC2U6XOSDYu+oVUCRo9mYrXfUl2pD6A+x3JGrfvKFGv
 D6LEG2O8JdodALMyrOD36ShEAuSPHJUptUw= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ehjnvuaad-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 11:09:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4ug9ACqeFOx1TayEQ57B5RBEgu3UNBqKnDmgxa/B7IgovCEG3GGz8S6kv89jGy8OxRMN4tZdLxsOJpMnmvAbW+WkKsrs1fTZzHh3vmEVf5eHvceIbzt1DS+NZ99YFkpFbUoysmQy424NdNpivFGY9X+Y3SKv8AS0BjGYhT9BrKuw6DMJeuQzf9F+VLR+t3vOvJtXRSWdUdgeXIFpld5pXwOcy2h2tw+0qHDQZF7mhAmrINfiBwZ4TU9SzQsJmPNvUDbxT+kOeT+TMs80qKkCAkHb5Fc4vHdW9tFeQIWyTZmomqmW0yaP6lhIWSdDV8p11tBFnKn81I07LgvaxhWjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RrtA7Advj/TnTaBND94G2wL4wgEZ3ANVwb287GKuyTI=;
 b=PTIOlfDfcXzdhm0MRfY3ry54VBEYuj1D3R8uN90ZxfjFwN4FYWd0ucTkMwLEnL/J5wIhKp6HfnhcR2VYrzWu3kgElySnVUl1ou7ZZTkirWCseJL7eNFU9uDUaXAjhcrb6VlcI2zl15zslT/sUkADosn2/bgaCspK4XV8h/sXkg+GQ9FQiUs19RxwTFzY9L4p8DVN6RNk1xD7LT8ZcpzEEWHS0vaVGL1zOhoB/LA6uM0VQkRm9yczbcxHq7AVTL0yKixyD9HqOErMJlnuFhLNR4RIjT/7Yi3apQrzaA3sPzD3qOvhYGSAMEeG2ne43AjPjGIqCjam3BIldmkTAtpRXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by DM5PR15MB1577.namprd15.prod.outlook.com (2603:10b6:3:ca::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Tue, 1 Mar
 2022 19:09:51 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::60e8:d4f3:93b5:aa79]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::60e8:d4f3:93b5:aa79%5]) with mapi id 15.20.5038.014; Tue, 1 Mar 2022
 19:09:51 +0000
From:   Nick Terrell <terrelln@fb.com>
To:     Sedat Dilek <sedat.dilek@gmail.com>
CC:     Nick Terrell <nickrterrell@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        "squashfs-devel@lists.sourceforge.net" 
        <squashfs-devel@lists.sourceforge.net>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Chris Mason <clm@fb.com>,
        Petr Malat <oss@malat.biz>, Yann Collet <cyan@fb.com>,
        Christoph Hellwig <hch@infradead.org>,
        =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>,
        David Sterba <dsterba@suse.cz>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Felix Handte <felixh@fb.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Paul Jones <paul@pauljones.id.au>,
        Tom Seewald <tseewald@gmail.com>,
        Jean-Denis Girard <jd.girard@sysnux.pf>
Subject: Re: [GIT PULL] zstd changes for v5.16
Thread-Topic: [GIT PULL] zstd changes for v5.16
Thread-Index: AQHX1QiBEf9PNrcT30asmDtzjP1LvKyc0zeAgA7CkQA=
Date:   Tue, 1 Mar 2022 19:09:51 +0000
Message-ID: <EBEC67C0-1CB9-4B24-A114-42F52071F04B@fb.com>
References: <20211109013058.22224-1-nickrterrell@gmail.com>
 <CA+icZUX0t1TzLm_XFEG50pZi_u901TcXP4CZspk6VRUw26vYNQ@mail.gmail.com>
In-Reply-To: <CA+icZUX0t1TzLm_XFEG50pZi_u901TcXP4CZspk6VRUw26vYNQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5fa58b1b-f708-427d-4906-08d9fbb70fc3
x-ms-traffictypediagnostic: DM5PR15MB1577:EE_
x-microsoft-antispam-prvs: <DM5PR15MB157773A83F681E4C199A99C7AB029@DM5PR15MB1577.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ETkCA9NrHjoJOjDmnuoEmaD1IaoqRXgIMAbb5G5Q++rOYfwgPO4V23IvwYjVxKFftXqA2bvfstpJzYn0KVtHhTUXDPm1WgGREp80HuIuGl38bTdz6hPnrlIGoX7RpYznvJo9pdRxZU78sdIDRlF0uXoOJjZKt9nHjiBk/5/DzdwnX8+hNVt4LRANATShRXJbxzJGNDlY6NFGV339NQZVNCY0R906mwYOYLwz4MbrwZABWfhCoZgasy/EH6FKa6swGwv/22nCkBPu7Jvs5w4IP5JmUGiVnhY73x5mGURg4hMqF2wyqRJmztUNXPvJPcpuyB5AJMdXE+yfAIk857yMoMqbTBKpE8kUBbrhsTKarSPExp0r62JhZ6AljI01uha7YNqQaSTyeqLbZ4pf5ry0bQYyKN3qqiawEdxnfoK0Pzwv78s/FWR5Ffcqq4bO451q299X9FrNJ0VLpyaZI+CSKo5sGwITRq3NdbKCmYRWLtvt6aPz+0wZ/hdDK7mk/bRkMjXneArQURkgDEFgi7UkcH0QMB94JxMm0UpwhrBG+33FIcovPu/zypCNFBTIJr8ybiCYhHCWidzyQtVrArWJ67pmKEfv/MMYdzFB2rHt60jgvpBj9u6zhkTk0k2KSOW2BA9XVE5zvKI/0OrgV69YlGN8MCrUlupHG7Q9hpigkjiag3A/Jeadkr9J9hjECgN9cPwTaOOjvOj3IBoiUUIc0ihxi1wnjpxxu8XH3kJSWO0FELj1/TWNzHGN7jr4k6PfUKJWl+2u9CwCTscyJXWD1yjYgG4cUg9f+ILtDuFUIMlq8UJ5EjJ7F6onezO0dQ3quBRN43ajfKXl1hD4B6Y7iqh9VSVlGZVarULTygaHB5c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(53546011)(186003)(2616005)(6486002)(966005)(38070700005)(36756003)(6916009)(6506007)(71200400001)(6512007)(33656002)(26005)(83380400001)(2906002)(316002)(86362001)(508600001)(122000001)(64756008)(8936002)(76116006)(66446008)(7416002)(66946007)(38100700002)(66556008)(66476007)(30864003)(5660300002)(54906003)(8676002)(4326008)(45980500001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?96/b3Xt9CHCooqXuujInczrAF3YbaqocHtUN5aRpwuaSiHKfOWAFNq0Vqa?=
 =?iso-8859-2?Q?upMWBxvDmHP4KsjNPd7YUqknFICaAEp/4kg2kVU600zRxC1KSMO1jTKsMd?=
 =?iso-8859-2?Q?ByPQHUPHsk4Jpx2D1KR8MyyNWdp+OOq4V/BhLZEuwhepccFfdLLKJQ6Rzy?=
 =?iso-8859-2?Q?ACr1Cg9aXtvDKAXM8MJFguFJRK5wJ+2DmxLUbfAGK2VuV9tB7kTsY79Svw?=
 =?iso-8859-2?Q?TrwZHDqh15ESkoIHxRYd7DSt+Y36e6fQUErHJ9f1N0Y0zarZiBZiPoHn/d?=
 =?iso-8859-2?Q?eSPKydOIAU6u+tI681c8D5c8ObURipuFL59T3A2/PSSUr+4cBW0UKgJaB1?=
 =?iso-8859-2?Q?e7BnQoS+q3zpVNfwPDB7YUxrRJC8ftAycKH180p7jWEHo/rYJet2MCg4s+?=
 =?iso-8859-2?Q?CkuJ6XpfWVeOluOly++oNqeUhbnLG54ObXBx4IvE7HHWEAMJwg2ljfCM9s?=
 =?iso-8859-2?Q?XfK6AgtQhp/3JWDiME06pZwtgoAm4j471T2VgzXPfGiaeNrWyqKTdwrs0D?=
 =?iso-8859-2?Q?SajBFBGEmGIpaAxu/FAkg+o4le94DYcLL3oS8J0KveVqSenThmoEQsOYeQ?=
 =?iso-8859-2?Q?XcjAq00WitkYW4F+FSH5hbOrudlG9gvKv1oPYVxJPOqNjiFL98s18A1uNp?=
 =?iso-8859-2?Q?gPe6vqpIwOc9AiF0hBD6DoW3KT3YFulvZItzT2uya01pgqKq75AzaVbpOt?=
 =?iso-8859-2?Q?oOaDV+g1vRn54jurFTzzK8adM6AaEA2lJl8I0MJhLdRacnitEwfKJXaEKj?=
 =?iso-8859-2?Q?NcdY1jXhd8j1PkpHC2Bqgv9wF6wYy4u/6CnCyfCJmqqTOujXAh0tVR+qDW?=
 =?iso-8859-2?Q?vTq+zIvUja3yeANKR5zLH7Y1Yv6EpPQnuHt9fLq5CoGAZ9GfwwKEsoiL+L?=
 =?iso-8859-2?Q?GaFPQsXSsDvDUoqfA/hsnDAiG68/POghq90kZD9aseqjGLTjHrb9zH/Yf3?=
 =?iso-8859-2?Q?Ip/PnMeEtGkqqGASm8lhW3gCKnVzCC3scMe7DP1GVnXleOuNfbXkBIky6M?=
 =?iso-8859-2?Q?CaMrn22AWGosg/5dDJRyAqytbJspzWSY5im6urfswV7vN6r0OROkUBwNBy?=
 =?iso-8859-2?Q?A2WDUI6nWeMCKEQ8/2N4m60mORVet2ZAcyeL3e0s8M26YS0ejpj+2MGpkm?=
 =?iso-8859-2?Q?PxRnGgOcxmd/gR0gJLJdl1vDhuVVYk3RGlpgvWPT2sITIClVDRiYNNr0O3?=
 =?iso-8859-2?Q?m9e3aNamVFjjcLhuYKEe9aRzK/2giYGRAUppe6H+xJnKkg0KmpLmHwOzeh?=
 =?iso-8859-2?Q?AJALjGNnJvDK0x1WXch2GF0xWG2+wUuEtH3p3ke9btHvjQ/3+tXdpzyTRm?=
 =?iso-8859-2?Q?7X7TwSh+r9iRapQnRoNdwaCN63IRuXLGrJcTiOhwpw7VcujLSF1lruOhCx?=
 =?iso-8859-2?Q?p1fmYe/TrDDbnLMsYZICntxcIEx532itOyVSygGrHHywVo2gkRHQj1Z+s4?=
 =?iso-8859-2?Q?3cdKpesgMP/whKUAlwuJ6aOdOIJyJ+SHWGH+PecxB0fE1Gt8KogfDZXsl7?=
 =?iso-8859-2?Q?ru4/QP47f59w3xdlqrqUJzhou+6U1NDDDz+ppXpDu7RLsHfphv0535nUQ+?=
 =?iso-8859-2?Q?1IrLtZGxU0Rj+qVVBWBadFOmt6C44V8WWbNdKyEJuSLPYcRNpSjqI9yKr2?=
 =?iso-8859-2?Q?M60oWotuCTi/Y=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <747323ECC582B941910A4DFFB9CFB4FC@namprd15.prod.outlook.com>
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa58b1b-f708-427d-4906-08d9fbb70fc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2022 19:09:51.1210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /DiygcxfeaO2NXTWnjeaYq/0dlyYO5HEHSSLrzgW21JK/2f/2ya1DFhmokxlY3U/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1577
X-Proofpoint-GUID: 6ofLgpmF0eSOxr4jGY9b7nmGPh-REs0L
X-Proofpoint-ORIG-GUID: 6ofLgpmF0eSOxr4jGY9b7nmGPh-REs0L
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 4 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-01_07,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1011
 impostorscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2203010096
X-FB-Internal: deliver
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



> On Feb 20, 2022, at 1:45 AM, Sedat Dilek <sedat.dilek@gmail.com> wrote:
>=20
> On Tue, Nov 9, 2021 at 2:24 AM Nick Terrell <nickrterrell@gmail.com> wrot=
e:
>>=20
>> From: Nick Terrell <terrelln@fb.com>
>>=20
>> Hi Linus,
>>=20
>> I am sending you a pull request to add myself as the maintainer of zstd =
and
>> update the zstd version in the kernel, which is now 4 years out of date,
>> to the latest zstd release. This includes bug fixes, much more extensive=
 fuzzing,
>> and performance improvements. And generates the kernel zstd automatically
>> from upstream zstd, so it is easier to keep the zstd verison up to date,=
 and we
>> don't fall so far out of date again.
>>=20
>> Thanks,
>> Nick Terrell
>>=20
>> The following changes since commit d2f38a3c6507b2520101f9a3807ed98f1bdc5=
45a:
>>=20
>>  Merge tag 'backlight-next-5.16' of git://git.kernel.org/pub/scm/linux/k=
ernel/git/lee/backlight (2021-11-08 12:21:28 -0800)
>>=20
>> are available in the Git repository at:
>>=20
>>  git@github.com:terrelln/linux.git tags/zstd-for-linus-v5.16
>>=20
>> for you to fetch changes up to 0a8ea235837cc39f27c45689930aa97ae91d5953:
>>=20
>>  lib: zstd: Add cast to silence clang's -Wbitwise-instead-of-logical (20=
21-11-08 16:55:38 -0800)
>>=20
>> ----------------------------------------------------------------
>> Update to zstd-1.4.10
>>=20
>=20
> Hi Nick,
>=20
> where is the official ZSTD version 1.4.10 (see below links)?
> Can you clarify on this, please?

The upstream tag v1.4.10 [0] is what is imported into the kernel.

> v1.4.19 seems to be faster than v1.4.18 in some benchmarks.
> The background of question is I wanted to request a new zstd version
> for Debian (currently v1.4.18).

There is no v1.4.18 or v1.4.19, I believe you meant v1.4.8 and v1.4.9.

The latest zstd versions is v1.5.2. We do expect speed improvements
in v1.5.2. However, we don't manage the zstd package in any package
manager, Debian included. So we don't have control over the version
of zstd in Debian.

> My second question:
> As your changes where accepted for upcoming Linux v5.17...
> Do you plan Git branches for...
> Linux v5.16 (is [6] up2date with changes in v5.17?)...
> ...or even Linux v5.15 LTS?

These changes landed in v5.16. I'm not planning on backporting
these changes to any older kernel version myself.

But, I am hoping to update to the latest zstd in either v5.18 or
v5.19. I'm a bit busy currently, but I just got a tentative volunteer
to update the kernel to v1.5.2, and more importantly test the
update.

Best,
Nick Terrell

[0] https://github.com/facebook/zstd/tree/v1.4.10

> Thanks.
>=20
> Regards,
> - Sedat -
>=20
> [1] https://github.com/facebook/zstd/releases
> [2] https://github.com/facebook/zstd/tags
> [3] https://github.com/facebook/zstd/releases/tag/v1.4.9
> [4] https://packages.debian.org/zstd=20
> [5] https://github.com/terrelln/linux/branches
> [6] https://github.com/terrelln/linux/commits/zstd-1.4.10
>=20
>> This PR includes 5 commits that update the zstd library version:
>>=20
>> 1. Adds a new kernel-style wrapper around zstd. This wrapper API
>>   is functionally equivalent to the subset of the current zstd API that =
is
>>   currently used. The wrapper API changes to be kernel style so that the=
 symbols
>>   don't collide with zstd's symbols. The update to zstd-1.4.10 maintains=
 the same
>>   API and preserves the semantics, so that none of the callers need to be
>>   updated. All callers are updated in the commit, because there are zero
>>   functional changes.
>> 2. Adds an indirection for `lib/decompress_unzstd.c` so it
>>   doesn't depend on the layout of `lib/zstd/` to include every source fi=
le.
>>   This allows the next patch to be automatically generated.
>> 3. Imports the zstd-1.4.10 source code. This commit is automatically gen=
erated
>>   from upstream zstd (https://github.com/facebook/zstd).
>> 4. Adds me (terrelln@fb.com) as the maintainer of `lib/zstd`.
>> 5. Fixes a newly added build warning for clang.
>>=20
>> The discussion around this patchset has been pretty long, so I've includ=
ed a
>> FAQ-style summary of the history of the patchset, and why we are taking =
this
>> approach.
>>=20
>> Why do we need to update?
>> -------------------------
>>=20
>> The zstd version in the kernel is based off of zstd-1.3.1, which is was =
released
>> August 20, 2017. Since then zstd has seen many bug fixes and performance
>> improvements. And, importantly, upstream zstd is continuously fuzzed by =
OSS-Fuzz,
>> and bug fixes aren't backported to older versions. So the only way to sa=
nely get
>> these fixes is to keep up to date with upstream zstd. There are no known=
 security
>> issues that affect the kernel, but we need to be able to update in case =
there
>> are. And while there are no known security issues, there are relevant bu=
g fixes.
>> For example the problem with large kernel decompression has been fixed u=
pstream
>> for over 2 years https://lkml.org/lkml/2020/9/29/27.
>>=20
>> Additionally the performance improvements for kernel use cases are signi=
ficant.
>> Measured for x86_64 on my Intel i9-9900k @ 3.6 GHz:
>>=20
>> - BtrFS zstd compression at levels 1 and 3 is 5% faster
>> - BtrFS zstd decompression+read is 15% faster
>> - SquashFS zstd decompression+read is 15% faster
>> - F2FS zstd compression+write at level 3 is 8% faster
>> - F2FS zstd decompression+read is 20% faster
>> - ZRAM decompression+read is 30% faster
>> - Kernel zstd decompression is 35% faster
>> - Initramfs zstd decompression+build is 5% faster
>>=20
>> On top of this, there are significant performance improvements coming do=
wn the
>> line in the next zstd release, and the new automated update patch genera=
tion
>> will allow us to pull them easily.
>>=20
>> How is the update patch generated?
>> ----------------------------------
>>=20
>> The first two patches are preparation for updating the zstd version. The=
n the
>> 3rd patch in the series imports upstream zstd into the kernel. This patc=
h is
>> automatically generated from upstream. A script makes the necessary chan=
ges and
>> imports it into the kernel. The changes are:
>>=20
>> - Replace all libc dependencies with kernel replacements and rewrite inc=
ludes.
>> - Remove unncessary portability macros like: #if defined(_MSC_VER).
>> - Use the kernel xxhash instead of bundling it.
>>=20
>> This automation gets tested every commit by upstream's continuous integr=
ation.
>> When we cut a new zstd release, we will submit a patch to the kernel to =
update
>> the zstd version in the kernel.
>>=20
>> The automated process makes it easy to keep the kernel version of zstd u=
p to
>> date. The current zstd in the kernel shares the guts of the code, but ha=
s a lot
>> of API and minor changes to work in the kernel. This is because at the t=
ime
>> upstream zstd was not ready to be used in the kernel envrionment as-is. =
But,
>> since then upstream zstd has evolved to support being used in the kernel=
 as-is.
>>=20
>> Why are we updating in one big patch?
>> -------------------------------------
>>=20
>> The 3rd patch in the series is very large. This is because it is restruc=
turing
>> the code, so it both deletes the existing zstd, and re-adds the new stru=
cture.
>> Future updates will be directly proportional to the changes in upstream =
zstd
>> since the last import. They will admittidly be large, as zstd is an acti=
vely
>> developed project, and has hundreds of commits between every release. Ho=
wever,
>> there is no other great alternative.
>>=20
>> One option ruled out is to replay every upstream zstd commit. This is no=
t feasible
>> for several reasons:
>> - There are over 3500 upstream commits since the zstd version in the ker=
nel.
>> - The automation to automatically generate the kernel update was only ad=
ded recently,
>>  so older commits cannot easily be imported.
>> - Not every upstream zstd commit builds.
>> - Only zstd releases are "supported", and individual commits may have bu=
gs that were
>>  fixed before a release.
>>=20
>> Another option to reduce the patch size would be to first reorganize to =
the new
>> file structure, and then apply the patch. However, the current kernel zs=
td is formatted
>> with clang-format to be more "kernel-like". But, the new method imports =
zstd as-is,
>> without additional formatting, to allow for closer correlation with upst=
ream, and
>> easier debugging. So the patch wouldn't be any smaller.
>>=20
>> It also doesn't make sense to import upstream zstd commit by commit going
>> forward. Upstream zstd doesn't support production use cases running of t=
he
>> development branch. We have a lot of post-commit fuzzing that catches ma=
ny bugs,
>> so indiviudal commits may be buggy, but fixed before a release. So going=
 forward,
>> I intend to import every (important) zstd release into the Kernel.
>>=20
>> So, while it isn't ideal, updating in one big patch is the only patch I =
see forward.
>>=20
>> Who is responsible for this code?
>> ---------------------------------
>>=20
>> I am. This patchset adds me as the maintainer for zstd. Previously, ther=
e was no tree
>> for zstd patches. Because of that, there were several patches that eithe=
r got ignored,
>> or took a long time to merge, since it wasn't clear which tree should pi=
ck them up.
>> I'm officially stepping up as maintainer, and setting up my tree as the =
path through
>> which zstd patches get merged. I'll make sure that patches to the kernel=
 zstd get
>> ported upstream, so they aren't erased when the next version update happ=
ens.
>>=20
>> How is this code tested?
>> ------------------------
>>=20
>> I tested every caller of zstd on x86_64 (BtrFS, ZRAM, SquashFS, F2FS, Ke=
rnel,
>> InitRAMFS). I also tested Kernel & InitRAMFS on i386 and aarch64. I chec=
ked both
>> performance and correctness.
>>=20
>> Also, thanks to many people in the community who have tested these patch=
es locally.
>> If you have tested the patches, please reply with a Tested-By so I can c=
ollect them
>> for the PR I will send to Linus.
>>=20
>> Lastly, this code will bake in linux-next before being merged into v5.16.
>>=20
>> Why update to zstd-1.4.10 when zstd-1.5.0 has been released?
>> ------------------------------------------------------------
>>=20
>> This patchset has been outstanding since 2020, and zstd-1.4.10 was the l=
atest
>> release when it was created. Since the update patch is automatically gen=
erated
>> from upstream, I could generate it from zstd-1.5.0. However, there were =
some
>> large stack usage regressions in zstd-1.5.0, and are only fixed in the l=
atest
>> development branch. And the latest development branch contains some new =
code that
>> needs to bake in the fuzzer before I would feel comfortable releasing to=
 the
>> kernel.
>>=20
>> Once this patchset has been merged, and we've released zstd-1.5.1, we ca=
n update
>> the kernel to zstd-1.5.1, and exercise the update process.
>>=20
>> You may notice that zstd-1.4.10 doesn't exist upstream. This release is =
an
>> artifical release based off of zstd-1.4.9, with some fixes for the kernel
>> backported from the development branch. I will tag the zstd-1.4.10 relea=
se after
>> this patchset is merged, so the Linux Kernel is running a known version =
of zstd
>> that can be debugged upstream.
>>=20
>> Why was a wrapper API added?
>> ----------------------------
>>=20
>> The first versions of this patchset migrated the kernel to the upstream =
zstd
>> API. It first added a shim API that supported the new upstream API with =
the old
>> code, then updated callers to use the new shim API, then transitioned to=
 the
>> new code and deleted the shim API. However, Cristoph Hellwig suggested t=
hat we
>> transition to a kernel style API, and hide zstd's upstream API behind th=
at.
>> This is because zstd's upstream API is supports many other use cases, an=
d does
>> not follow the kernel style guide, while the kernel API is focused on the
>> kernel's use cases, and follows the kernel style guide.
>>=20
>> Where is the previous discussion?
>> ---------------------------------
>>=20
>> Links for the discussions of the previous versions of the patch set.
>> The largest changes in the design of the patchset are driven by the disc=
ussions
>> in V11, V5, and V1. Sorry for the mix of links, I couldn't find most of =
the the
>> threads on lkml.org.
>>=20
>> V12: https://www.spinics.net/lists/linux-crypto/msg58189.html=20
>> V11: https://lore.kernel.org/linux-btrfs/20210430013157.747152-1-nickrte=
rrell@gmail.com/
>> V10: https://lore.kernel.org/lkml/20210426234621.870684-2-nickrterrell@g=
mail.com/
>> V9: https://lore.kernel.org/linux-btrfs/20210330225112.496213-1-nickrter=
rell@gmail.com/
>> V8: https://lore.kernel.org/linux-f2fs-devel/20210326191859.1542272-1-ni=
ckrterrell@gmail.com/
>> V7: https://lkml.org/lkml/2020/12/3/1195
>> V6: https://lkml.org/lkml/2020/12/2/1245
>> V5: https://lore.kernel.org/linux-btrfs/20200916034307.2092020-1-nickrte=
rrell@gmail.com/
>> V4: https://www.spinics.net/lists/linux-btrfs/msg105783.html=20
>> V3: https://lkml.org/lkml/2020/9/23/1074
>> V2: https://www.spinics.net/lists/linux-btrfs/msg105505.html=20
>> V1: https://lore.kernel.org/linux-btrfs/20200916034307.2092020-1-nickrte=
rrell@gmail.com/
>>=20
>> Signed-off-by: Nick Terrell <terrelln@fb.com>
>> Tested By: Paul Jones <paul@pauljones.id.au>
>> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
>> Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # LLVM/Clang v13.0.0 on x=
86-64
>> Tested-by: Jean-Denis Girard <jd.girard@sysnux.pf>
>>=20
>> ----------------------------------------------------------------
>> Nathan Chancellor (1):
>>      lib: zstd: Add cast to silence clang's -Wbitwise-instead-of-logical
>>=20
>> Nick Terrell (4):
>>      lib: zstd: Add kernel-specific API
>>      lib: zstd: Add decompress_sources.h for decompress_unzstd
>>      lib: zstd: Upgrade to latest upstream zstd version 1.4.10
>>      MAINTAINERS: Add maintainer entry for zstd
>>=20
>> MAINTAINERS                                    |   12 +
>> crypto/zstd.c                                  |   28 +-
>> fs/btrfs/zstd.c                                |   68 +-
>> fs/f2fs/compress.c                             |   56 +-
>> fs/f2fs/super.c                                |    2 +-
>> fs/pstore/platform.c                           |    2 +-
>> fs/squashfs/zstd_wrapper.c                     |   16 +-
>> include/linux/zstd.h                           | 1252 ++----
>> include/linux/zstd_errors.h                    |   77 +
>> include/linux/zstd_lib.h                       | 2432 +++++++++++
>> lib/decompress_unzstd.c                        |   48 +-
>> lib/zstd/Makefile                              |   46 +-
>> lib/zstd/bitstream.h                           |  380 --
>> lib/zstd/common/bitstream.h                    |  437 ++
>> lib/zstd/common/compiler.h                     |  170 +
>> lib/zstd/common/cpu.h                          |  194 +
>> lib/zstd/common/debug.c                        |   24 +
>> lib/zstd/common/debug.h                        |  101 +
>> lib/zstd/common/entropy_common.c               |  357 ++
>> lib/zstd/common/error_private.c                |   56 +
>> lib/zstd/common/error_private.h                |   66 +
>> lib/zstd/common/fse.h                          |  710 ++++
>> lib/zstd/common/fse_decompress.c               |  390 ++
>> lib/zstd/common/huf.h                          |  356 ++
>> lib/zstd/common/mem.h                          |  259 ++
>> lib/zstd/common/zstd_common.c                  |   83 +
>> lib/zstd/common/zstd_deps.h                    |  125 +
>> lib/zstd/common/zstd_internal.h                |  450 +++
>> lib/zstd/compress.c                            | 3485 ----------------
>> lib/zstd/compress/fse_compress.c               |  625 +++
>> lib/zstd/compress/hist.c                       |  165 +
>> lib/zstd/compress/hist.h                       |   75 +
>> lib/zstd/compress/huf_compress.c               |  905 +++++
>> lib/zstd/compress/zstd_compress.c              | 5109 ++++++++++++++++++=
++++++
>> lib/zstd/compress/zstd_compress_internal.h     | 1188 ++++++
>> lib/zstd/compress/zstd_compress_literals.c     |  158 +
>> lib/zstd/compress/zstd_compress_literals.h     |   29 +
>> lib/zstd/compress/zstd_compress_sequences.c    |  439 ++
>> lib/zstd/compress/zstd_compress_sequences.h    |   54 +
>> lib/zstd/compress/zstd_compress_superblock.c   |  850 ++++
>> lib/zstd/compress/zstd_compress_superblock.h   |   32 +
>> lib/zstd/compress/zstd_cwksp.h                 |  482 +++
>> lib/zstd/compress/zstd_double_fast.c           |  519 +++
>> lib/zstd/compress/zstd_double_fast.h           |   32 +
>> lib/zstd/compress/zstd_fast.c                  |  496 +++
>> lib/zstd/compress/zstd_fast.h                  |   31 +
>> lib/zstd/compress/zstd_lazy.c                  | 1414 +++++++
>> lib/zstd/compress/zstd_lazy.h                  |   81 +
>> lib/zstd/compress/zstd_ldm.c                   |  686 ++++
>> lib/zstd/compress/zstd_ldm.h                   |  110 +
>> lib/zstd/compress/zstd_ldm_geartab.h           |  103 +
>> lib/zstd/compress/zstd_opt.c                   | 1346 +++++++
>> lib/zstd/compress/zstd_opt.h                   |   50 +
>> lib/zstd/decompress.c                          | 2531 ------------
>> lib/zstd/decompress/huf_decompress.c           | 1206 ++++++
>> lib/zstd/decompress/zstd_ddict.c               |  241 ++
>> lib/zstd/decompress/zstd_ddict.h               |   44 +
>> lib/zstd/decompress/zstd_decompress.c          | 2085 ++++++++++
>> lib/zstd/decompress/zstd_decompress_block.c    | 1540 +++++++
>> lib/zstd/decompress/zstd_decompress_block.h    |   62 +
>> lib/zstd/decompress/zstd_decompress_internal.h |  202 +
>> lib/zstd/decompress_sources.h                  |   28 +
>> lib/zstd/entropy_common.c                      |  243 --
>> lib/zstd/error_private.h                       |   53 -
>> lib/zstd/fse.h                                 |  575 ---
>> lib/zstd/fse_compress.c                        |  795 ----
>> lib/zstd/fse_decompress.c                      |  325 --
>> lib/zstd/huf.h                                 |  212 -
>> lib/zstd/huf_compress.c                        |  773 ----
>> lib/zstd/huf_decompress.c                      |  960 -----
>> lib/zstd/mem.h                                 |  151 -
>> lib/zstd/zstd_common.c                         |   75 -
>> lib/zstd/zstd_compress_module.c                |  160 +
>> lib/zstd/zstd_decompress_module.c              |  105 +
>> lib/zstd/zstd_internal.h                       |  273 --
>> lib/zstd/zstd_opt.h                            | 1014 -----
>> 76 files changed, 27373 insertions(+), 12941 deletions(-)
>> create mode 100644 include/linux/zstd_errors.h
>> create mode 100644 include/linux/zstd_lib.h
>> delete mode 100644 lib/zstd/bitstream.h
>> create mode 100644 lib/zstd/common/bitstream.h
>> create mode 100644 lib/zstd/common/compiler.h
>> create mode 100644 lib/zstd/common/cpu.h
>> create mode 100644 lib/zstd/common/debug.c
>> create mode 100644 lib/zstd/common/debug.h
>> create mode 100644 lib/zstd/common/entropy_common.c
>> create mode 100644 lib/zstd/common/error_private.c
>> create mode 100644 lib/zstd/common/error_private.h
>> create mode 100644 lib/zstd/common/fse.h
>> create mode 100644 lib/zstd/common/fse_decompress.c
>> create mode 100644 lib/zstd/common/huf.h
>> create mode 100644 lib/zstd/common/mem.h
>> create mode 100644 lib/zstd/common/zstd_common.c
>> create mode 100644 lib/zstd/common/zstd_deps.h
>> create mode 100644 lib/zstd/common/zstd_internal.h
>> delete mode 100644 lib/zstd/compress.c
>> create mode 100644 lib/zstd/compress/fse_compress.c
>> create mode 100644 lib/zstd/compress/hist.c
>> create mode 100644 lib/zstd/compress/hist.h
>> create mode 100644 lib/zstd/compress/huf_compress.c
>> create mode 100644 lib/zstd/compress/zstd_compress.c
>> create mode 100644 lib/zstd/compress/zstd_compress_internal.h
>> create mode 100644 lib/zstd/compress/zstd_compress_literals.c
>> create mode 100644 lib/zstd/compress/zstd_compress_literals.h
>> create mode 100644 lib/zstd/compress/zstd_compress_sequences.c
>> create mode 100644 lib/zstd/compress/zstd_compress_sequences.h
>> create mode 100644 lib/zstd/compress/zstd_compress_superblock.c
>> create mode 100644 lib/zstd/compress/zstd_compress_superblock.h
>> create mode 100644 lib/zstd/compress/zstd_cwksp.h
>> create mode 100644 lib/zstd/compress/zstd_double_fast.c
>> create mode 100644 lib/zstd/compress/zstd_double_fast.h
>> create mode 100644 lib/zstd/compress/zstd_fast.c
>> create mode 100644 lib/zstd/compress/zstd_fast.h
>> create mode 100644 lib/zstd/compress/zstd_lazy.c
>> create mode 100644 lib/zstd/compress/zstd_lazy.h
>> create mode 100644 lib/zstd/compress/zstd_ldm.c
>> create mode 100644 lib/zstd/compress/zstd_ldm.h
>> create mode 100644 lib/zstd/compress/zstd_ldm_geartab.h
>> create mode 100644 lib/zstd/compress/zstd_opt.c
>> create mode 100644 lib/zstd/compress/zstd_opt.h
>> delete mode 100644 lib/zstd/decompress.c
>> create mode 100644 lib/zstd/decompress/huf_decompress.c
>> create mode 100644 lib/zstd/decompress/zstd_ddict.c
>> create mode 100644 lib/zstd/decompress/zstd_ddict.h
>> create mode 100644 lib/zstd/decompress/zstd_decompress.c
>> create mode 100644 lib/zstd/decompress/zstd_decompress_block.c
>> create mode 100644 lib/zstd/decompress/zstd_decompress_block.h
>> create mode 100644 lib/zstd/decompress/zstd_decompress_internal.h
>> create mode 100644 lib/zstd/decompress_sources.h
>> delete mode 100644 lib/zstd/entropy_common.c
>> delete mode 100644 lib/zstd/error_private.h
>> delete mode 100644 lib/zstd/fse.h
>> delete mode 100644 lib/zstd/fse_compress.c
>> delete mode 100644 lib/zstd/fse_decompress.c
>> delete mode 100644 lib/zstd/huf.h
>> delete mode 100644 lib/zstd/huf_compress.c
>> delete mode 100644 lib/zstd/huf_decompress.c
>> delete mode 100644 lib/zstd/mem.h
>> delete mode 100644 lib/zstd/zstd_common.c
>> create mode 100644 lib/zstd/zstd_compress_module.c
>> create mode 100644 lib/zstd/zstd_decompress_module.c
>> delete mode 100644 lib/zstd/zstd_internal.h
>> delete mode 100644 lib/zstd/zstd_opt.h

