Return-Path: <linux-btrfs+bounces-555-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD3E80301A
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 11:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 903D71C209BB
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 10:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D459B2134B;
	Mon,  4 Dec 2023 10:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="MBFL2inu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F671192
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Dec 2023 02:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1701685340; x=1702290140; i=quwenruo.btrfs@gmx.com;
	bh=kCGSofc15lHasWPXbTnq0M5U0sqUhXLbLfPFbEe/9oI=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=MBFL2inuqmkBhstRMZVoBoqkUPLC92apfQCbg3rjMufvFGOlUWglfb51mxlHCKeb
	 /L7eiXuSK70bKrXMOuiNRZ02187VxcSzatjeUB2VySoCpfqBASx3GUQMcPuU51mV6
	 JR17iUmM6IzV92VACf5JZiOE9OdRV74sK+F4jMuvzAzZezlVAXbUXXaiJXWlJ9p1K
	 9w1E7ML7f2oP/uA8qwXcldWMZU4KzEpXid6l2hug4fbMDX+dAvyOfUYeA8xMNjh0p
	 ddTWYHdrAVRqmY40+LYpHqgwv2nnmNM1m0OHB6AWf/V+JmGzJgnb0NKptouZVoGS9
	 Y2Hz2KCYGz5UMthHnw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MeCtj-1riLBE3Fcl-00bNMD; Mon, 04
 Dec 2023 11:22:20 +0100
Message-ID: <e051f2dd-dbd6-4e3f-b828-a66a991ed4c2@gmx.com>
Date: Mon, 4 Dec 2023 20:52:15 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] btrfs-progs: tune: add fsck runs before and after a
 full conversion
To: l@damenly.org, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1701672971.git.wqu@suse.com>
 <f919ead47c266bbb4c24ba873e565e4c36b9377a.1701672971.git.wqu@suse.com>
 <a5qqguz5.fsf@damenly.org> <455ec3c5adf1dbb10f5ee00bf3a6c955@damenly.org>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <455ec3c5adf1dbb10f5ee00bf3a6c955@damenly.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q8ZzyLF0C7EFqrPuATt7aQKKSlTWVY5+z21suPmHtnf1NursfOF
 e3b2xhGlp9qiDz78t7Ef6395ojKoFjPHubnQ1w5dSJc6XmliOmuFP0/lWKM2m7gg91NwWS+
 akKHexSLp9lgODs9CrI50DlLPkyYcicaKowLUOVSK5rPi724wPmw7FPp6mwFQpPFfT4natu
 Jl2ZKY5xZePgiuorsiutA==
UI-OutboundReport: notjunk:1;M01:P0:vI/Vo5GUoQQ=;FCbdRzFTpYcOsj81iysTAy6dBPl
 57Imusvu87luYEelJ9LqeBIaqRalNffAXTsda5SU6SblzIAEms2Yqy7ZI1xq96W6MjvqvppDy
 4gGBbgSGTItA1eq5L3YnUmB3c7cAVtm4GSGXjqpV5kCYlvwa3tOcICxduLh7G6+V6dUbHVMB5
 LHomkqM8tu9y0sAElo04F4iqyogOHfpSaUZMWiOo/T470ptb1F1aA3zY2qX/TK3twtN6p+j+7
 hLUZeW1/05f9PXYcxiT80B8UXZLVzdOHvAqlVplOTvC8ny0iFI4Kq4y2BkkOE0xL6dwThboyc
 9bJYy4SXikPzpwtP2FDACnnl3iR2Tnqoia9FODMcgd3HRbDmYizTOZQcJvw+LuszY+cjQDpQp
 +nRx2plPCqsKZhVL2kqUSuO9LgCQ2VRhcC985fpJBbIplcdzF5xT0pdMGfhw3w8sX5Dog06sP
 RT6kU6TianOipviDFPoCzjHmQnA9YugqtdZJyU1SHTXNIOjgTjAjgQ2zevNMtSxKgmr5wC3vf
 22SQNxXTqZegHjazmUl+P2snxFsA6a7IehnoXekEWY7KbhNgTN5+svpeqaML6eHhzlWuDnfbV
 ZJ87iimpwO5h1wJ4KluXfmtWBUIVDIUmcX1pezadMc0GOUueiKofmHPQJuwEpYjApZDqureAM
 LBrtBCHF7+0mTyJeu+mzH0L4SxbcOzWfKhQ+U/CsmM8kgdjyG5dKP1xCCuuhSWLZqIuF/DqME
 32Y4BhLsbaor7o6W3Kw+fcmtNZ8yXsLBGwcyb3YS4a+IOpZYwfpXRND+ixfdfwlrKx5Zy9HOM
 6L37oIXGGf2xu18AODhHAXOb+P8X2kO8YWiNvi3T8bGkS5PNJ9U8B8q/9cW5Or9jl71vhlrt0
 htmi1bFieDqw55rvXSstuD7qW7jiN3Giq5zNlwCbyILDhIJkeJhJ0hvxb5lNRP+u9L7ENlAhn
 nPItRHCXKzSvHd1pbZ3vrMY/Pr8=



On 2023/12/4 20:41, l@damenly.org wrote:
> On 2023-12-04 09:44, Su Yue wrote:
>> On Mon 04 Dec 2023 at 17:26, Qu Wenruo <wqu@suse.com> wrote:
>>
>>> We have two bug reports in the mailing list around block group tree
>>> conversion.
>>>
>>> Although currently there is still no strong evidence showing btrfstune
>>> is the culprit yet, I still want to be extra cautious.
>>>
>>> This patch would add an extra safenet for the end users, that a full
>>> readonly btrfs check would be executed on the filesystem before doing
>>> any full fs conversion (including bg/extent tree and csum conversion).
>>>
>>> This can catch any existing health problem of the filesystem.
>>>
>>> Furthermore, after the conversion is done, there would also be a "btrf=
s
>>> check" run, to make sure the conversion itself is fine, to make sure w=
e
>>> have done everything to make sure the problem is not from our side.
>>>
>>> One thing to note is, the initial check would only happen on a source
>>> filesystem which is not under any existing conversion.
>>> As a fs already under conversion can easily trigger btrfs check false
>>> alerts.
>>>
>> Better to mention above behavior in documentation too? Or some
>> impatient people may give up then complain btrfs is slow ;)

That's a good idea.

>>
> And maybe an option to skip check? People who want to convert to BG tree
> usually have large filesystems, then the original check can be killed
> because of OOM...

I don't want to allow it to be skipped. Maybe I can add some logic to go
lowmem mode depending on the filesystem size.

Just don't want to risk any possible corruption.

Thanks,
Qu
>
> --
> Su
>
>> --
>> Su
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>> =C2=A0Makefile=C2=A0=C2=A0=C2=A0 |=C2=A0 3 ++-
>>> =C2=A0tune/main.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>>> =C2=A02 files changed, 57 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Makefile b/Makefile
>>> index 374f59b99150..47c6421781f3 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -267,7 +267,8 @@ mkfs_objects =3D mkfs/main.o mkfs/common.o
>>> mkfs/rootdir.o
>>> =C2=A0image_objects =3D image/main.o image/sanitize.o=C2=A0 image/imag=
e-create.o
>>> image/common.o \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 image/image-restore.o
>>> =C2=A0tune_objects =3D tune/main.o tune/seeding.o tune/change-uuid.o
>>> tune/change-metadata-uuid.o \
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tune/con=
vert-bgt.o tune/change-csum.o
>>> common/clear-cache.o tune/quota.o
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tune/con=
vert-bgt.o tune/change-csum.o
>>> common/clear-cache.o tune/quota.o \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 check/ma=
in.o check/mode-common.o check/mode-lowmem.o
>>> mkfs/common.o
>>> =C2=A0all_objects =3D $(objects) $(cmds_objects) $(libbtrfs_objects)
>>> $(convert_objects) \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(mkfs_ob=
jects) $(image_objects) $(tune_objects)
>>> $(libbtrfsutil_objects)
>>>
>>> diff --git a/tune/main.c b/tune/main.c
>>> index 9dcb55952b59..f05ab7c3b36e 100644
>>> --- a/tune/main.c
>>> +++ b/tune/main.c
>>> @@ -29,6 +29,7 @@
>>> =C2=A0#include "kernel-shared/transaction.h"
>>> =C2=A0#include "kernel-shared/volumes.h"
>>> =C2=A0#include "kernel-shared/free-space-tree.h"
>>> +#include "kernel-shared/zoned.h"
>>> =C2=A0#include "common/utils.h"
>>> =C2=A0#include "common/open-utils.h"
>>> =C2=A0#include "common/device-scan.h"
>>> @@ -367,6 +368,47 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
>>> =C2=A0=C2=A0=C2=A0=C2=A0 if (change_metadata_uuid || random_fsid || ne=
w_fsid_str)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctree_flags |=3D OPEN=
_CTREE_USE_LATEST_BDEV;
>>>
>>> +=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * For fs rewrites operations, we need to ver=
ify the initial
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * filesystem to make sure they are healthy.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Otherwise the transaction protection is no=
t going to save us.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0 if (to_bg_tree || to_extent_tree || csum_type !=3D=
 -1) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_super_block s=
b =3D { 0 };
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 sb_flags;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Here we just read =
out the superblock without any extra
>>> check,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * as later btrfs_che=
ck() would do more comprehensive check on
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * it.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D sbread(fd, &sb, 0)=
;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 er=
rno =3D -ret;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 er=
ror("failed to read super block from \"%s\"", device);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 go=
to free_out;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sb_flags =3D btrfs_super_f=
lags(&sb);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If we're not resum=
ing the conversion, we should check the fs
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * first.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!(sb_flags & (BTRFS_SU=
PER_FLAG_CHANGING_BG_TREE |
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BTRFS_SUPER_FLAG_CHANGING_DATA_CSUM |
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BTRFS_SUPER_FLAG_CHANGING_META_CSUM))) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bo=
ol check_ret;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st=
ruct btrfs_check_options options =3D
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 btrfs_default_check_options;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ch=
eck_ret =3D btrfs_check(device, &options);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (check_ret) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 error(
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "\"btrfs check\" found som=
e errors, will not touch the
>>> filesystem");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ret =3D -EUCLEAN;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 goto free_out;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0 root =3D open_ctree_fd(fd, device, 0, ctree_f=
lags);
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 if (!root) {
>>> @@ -535,6 +577,19 @@ out:
>>> =C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0 close_ctree(root);
>>> =C2=A0=C2=A0=C2=A0=C2=A0 btrfs_close_all_devices();
>>> +=C2=A0=C2=A0=C2=A0 /* A sucessful run finished, let's verify the fs a=
gain. */
>>> +=C2=A0=C2=A0=C2=A0 if (!ret && (to_bg_tree || to_extent_tree || csum_=
type)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool check_ret;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_check_options=
 options =3D
>>> btrfs_default_check_options;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 check_ret =3D btrfs_check(=
device, &options);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (check_ret) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 er=
ror(
>>> +=C2=A0=C2=A0=C2=A0 "\"btrfs check\" found some errors after the conve=
rsion, please
>>> contact the developers");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
t =3D -EUCLEAN;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 }
>>>
>>> =C2=A0free_out:
>>> =C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>

