Return-Path: <linux-btrfs+bounces-3831-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42991895EB3
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Apr 2024 23:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E31D1C23D1F
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Apr 2024 21:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CB715E5D4;
	Tue,  2 Apr 2024 21:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="XkmdqecF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682B715AAA7
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Apr 2024 21:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712093421; cv=none; b=gHYeEax5C2NFL5W3KtdqkSI7GvtNmjin8qQcRoanP2lL5Ytunvu1DW2bVWaMPRkYhJ6dTF4taaRUMGSI4iybqafNCRmXmYHRdi/XKBL6vwW5EfzZ7h3phrPKgdWw1r/xSf3MgCbPH96pecyZXMRf+lrmu6No0kxs9cYAV1kSUic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712093421; c=relaxed/simple;
	bh=0+9EunwE8Ys/SbHeRngAExVMMLeeXE/CrTKUuUb2eOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ilFYPLZfMq4pkuuPOSH4KQ1Id0M9mmR3dncRI1pMl9mdTlWbGr9GKljbNvJUKG3dYpttrUJz8hErk2u+1hHHweNhob+ScAzB/wSQ0Y3hAOa9TQnPNX3lv/ChkogAQlTa1KZduiO4sfJt8G75IhwvmfuVoMc6C/zI9PfjBDiB9Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=XkmdqecF; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1712093415; x=1712698215; i=quwenruo.btrfs@gmx.com;
	bh=y9QmRR8uoD+uE/Nj4jmLf0WZnNB2g9WPYCVMLaHoKXg=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=XkmdqecFO8N8nmoIhS6hq9KiCmhOSOS/z7vUl7KTsKdhX0GE5NcqLfCLgGW0U876
	 j/orXvNy3a+DwEknein3han1kKKsbAXgHFFouDygZrlPy2jbk5jCgh7fr8U7Lnw+n
	 olIU91yT7GFcOgoJ7wW76R9lRajcKrgX9WjAOITXYlbW3SC4xEwZFdGGpTADZZVA+
	 uM1NQ6ym9ye5QistAVecR5i565hc/emtFzy/7sNyos44wVUFnN8+/L5nmdXDSrQ1L
	 fNptz7s6io+nhh8ACF00PSTjMvllX1IJVr107oY19yHd5LjfWaMWC7EKIjWtB8ShJ
	 Z1F9Lz9Z6ruJ8lxjnQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MfYLQ-1sTHG23Mkq-00g0hc; Tue, 02
 Apr 2024 23:30:15 +0200
Message-ID: <e184d249-a4e5-4031-a152-95e7718877c7@gmx.com>
Date: Wed, 3 Apr 2024 08:00:11 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] btrfs-progs: remove unused header for tune/main.c
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1711412540.git.wqu@suse.com>
 <a7224b1e785d51d74c6bd369ee0c0f586cbdf616.1711412540.git.wqu@suse.com>
 <20240402184216.GE14596@twin.jikos.cz>
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
In-Reply-To: <20240402184216.GE14596@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1ASYcv0Ci9AUdEx7rI9pYKn5O5eT097OSxFDeI9icnzpqeFQKei
 RPanrKIDKsxSsko0jx9kziZvPjmnOu41tumSTkbn3xQalt8PKqvF8PjJhfG/Jb6IFhFpits
 yUshnHPoNhKToVenYF+CSt8/mkADF57ZxGIHmvaGIFXgFNdOC0YdLv2L7MnPhjmu+qu9hYM
 BmON8KJJEnBANBDOnRGaw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bkzHiCurG1k=;WXYtEJGyCKboq9pKnKqaAJ0JiTS
 JZcWhvmpXPooO59TS73m3XaqSZTHECuwpgur+CH4ag7FcD00rvKL8S0ixSAMWbYpbrKRr79fG
 IFpCygY4TAaM0pYJmtxp2yHaFQa9oqyAFmxBIOeOR+4pMz6b00CWDhtHSAriD9Q8p6QXm+3UP
 1zwPobpq2Y2ja1IErKaOoIudUOj64PxTZOBGwv3T02zA0I/WbF5eSAQmOaIbsuPJIoi7MHgLz
 pcuwuYsHE6jnH5gX1IJ28ceac3eDl9d/qQeVjmlCZUTI9dOVFYeuruOHnA1ZfRdHpxCn///EW
 5eRkAHNvst2maIn6YF1XZ0G6XhzifARlRyDusUQe0/JUNWLPUCWEtP41MJgdI8Y2SwzmD+rwm
 K2D2mkdzzK3eKd9jw44dSDO+eOM+HcFfz9EgjUeGCALNJJaYhnYLTu7W2L1S9FJZvDwDqrQXu
 YFCrQFE/WqyHyoN2xk33WpiR3J+ooHCZ51IdIdMBNbm9ky5wTXpzSZ5v3Qkb2DtJxBPriLpIC
 YBL/0+pG5y3Xx9sbMYhsdKx9j7nTZclAAbn5vdDwU9EY2ecPgzYsS6GAM+DsL9YhgZ+UrYR3K
 SnGoATpuuLlC7SNrys2UBNGXKphb/e+8/acnE6KXxEYVFckNu722+WIUkuMRreXxY+Ox6Z6ga
 I5VuMfmL/CaiX+YvwowjvrSuYuoIpgHVRj+Btyy+DPZGSs9LmjEihJRNb9KHre0XQ5RqemLdn
 q4k17e7x3uwBAtTrjOYwJRpzU4mLl1B4q1EmgWJFybIcDOhv+NFhP018v0AjiLNcMYl7h+pG7
 01OK0o5PKmuGiJv14SnAVGrARFgIktTLhk5x3gIiehWJ8=



=E5=9C=A8 2024/4/3 05:12, David Sterba =E5=86=99=E9=81=93:
> On Tue, Mar 26, 2024 at 10:52:41AM +1030, Qu Wenruo wrote:
>> My clangd LSP server reports warning that "common/parse-utils.h" is not
>> utilized at all.
>
> Please be careful about removing headers, the LSP depends on the
> build flags and reports symbols or headers only for the last configured
> state.
>
> In this case removing parse-utils.h causes compilation error in
> experimental mode because of
>
> 287 #if EXPERIMENTAL
> 288                 case GETOPT_VAL_CSUM:
> 289                         btrfs_warn_experimental(
> 290                                 "Switching checksums is experimental=
, do not use for valuable data!");
> 291                         ctree_flags |=3D OPEN_CTREE_SKIP_CSUM_CHECK;
> 292                         csum_type =3D parse_csum_type(optarg);
>                                          ^^^^^^^^^^^^^^^^^^^^^^^
>
> 293                         btrfstune_cmd_groups[CSUM_CHANGE] =3D true;
> 294                         break;
> 295 #endif
>
> Some build checks or targets could be missing so we'd lack coverage and
> early warnings during development, this needs to be fixed.

Indeed.

Although I don't think early checks in headers would be a problem.

If a header never got included, then the header itself is not really
needed, meanwhile the checks in headers only need to be run once, thus
it's not a big deal when the early checks got executed.

>
> Builds that change LSP state (and combinations):
>
> - make box
> - make static box.static
> - various D=3D values and modes
> - configure --experimental
> - possibly different includes for glibc and musl defining a symbol
>    indirectly

I'll do more checks not only with the different configs, but also more
manual inspection into the dropped headers.

Thanks,
Qu

