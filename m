Return-Path: <linux-btrfs+bounces-1138-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC64F81E5BB
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Dec 2023 08:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E511282DD7
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Dec 2023 07:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440F64C60B;
	Tue, 26 Dec 2023 07:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="FD0+PNJ/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690164C624;
	Tue, 26 Dec 2023 07:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1703576270; x=1704181070; i=quwenruo.btrfs@gmx.com;
	bh=LzfYCc4og795G66EYmFab42vkfOfyMah6Qmi9bAZQX0=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=FD0+PNJ/5oQZyEw4xtRpaIv82PRxs0Nib/S44sdVK19F86VELt5IvOEob//wXTiW
	 mjvhL1DP4smdU5KKzdYURKGNRasnRpFeb4v+9RUnbIO2zV6kWYsrHURWWtNPR5dxe
	 +wV9SuJAX6wV4/vUYiSGpTOOjK4B+EpdCk7JHxFfS0zzyhfY+phP0bBPagKctsjGj
	 euIvtDrq6f5Y2mpFf1lwrdvVR/RXz4r10pvwmK5H9Xpm1cz8S3jncs3lyM1TyJCO9
	 eWT0YdbyCzBw6RsIHk1F/QDzw5TUsXbXS3j9fI8t80xfu5NmnrmPqSWinainDr51/
	 j1svwTWeJposjfQmmQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([118.211.64.174]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MYNJq-1rmOi72dn8-00VTn0; Tue, 26
 Dec 2023 08:37:50 +0100
Message-ID: <479bcb3b-bf0b-472f-8f3e-11e032587552@gmx.com>
Date: Tue, 26 Dec 2023 18:07:40 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] kstrtox: add unit tests for memparse_safe()
To: kernel test robot <lkp@intel.com>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, christophe.jaillet@wanadoo.fr,
 andriy.shevchenko@linux.intel.com, David.Laight@aculab.com, ddiss@suse.de
Cc: oe-kbuild-all@lists.linux.dev
References: <56ea15d8b430f4fe3f8e55509ad0bc72b1d9356f.1703324146.git.wqu@suse.com>
 <202312261423.zqIlU2hn-lkp@intel.com>
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
In-Reply-To: <202312261423.zqIlU2hn-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:o3gkxVcNg9JixdCfm4SplO3oSgC4L30OLrttyvoHPSsKcGjuvvK
 lRvSLOPhzlgaOIbieXMeaHB7BXx7nXJEF+d0Ahl7225b8y05GlPIjd+WuxhYtRu3Pj/xWpX
 cbhZQ3rSgDl86IsG/GMsQ854SxJRgph+mA2ovZI+2Xh99FXl4lteUX1rXzlLkYAbHtT4vtl
 Zxgvwv6aPBqn7JH0/3X8Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:G5mIQ07WWjk=;+HowpZSXQLfPNCTWFW/pTEbfBBM
 hE4mE1C3yuotedek8TXLw0XhLV3eMa2BUSM/H94Nl0PJohira29/HlhmUmdwn2Nw0vy7K0uEk
 c/FtoBfpeA5+3PCEZHDc4AXN+/gDbrChAJtXVIXcQtr3mYTqaIEdZY/SkbnZmp94y7GC2xyLL
 xIlObiR6alnEf8w2H2d+b5FQYJ2D6Vh2oLbHkFTdDGC1VDl+pZQndk5dJQuYNEfp0OFLt8mwI
 URoFLHuFHpEixv4T0pCC9inBhUlcTZtv3C7jg2/s93FpjQmz6G4rdVytvp+5nc27ZeGTnlGLX
 ule576OrKibhLk7Vwp1DgsKyHPK0HrV4I/DjwNfwoXyya0KlOoR99xfkNCAkXgMU1UmtSuWMH
 VQ3gRaraacTyHD7tOYNsF7kDh8otkau/JXngUee2HTmmd6TZ9aL1OGpqPlwTCmJJKzmqcs49o
 JtoQ3gB/HtVmmhhmogOpOrQ0BuHR2AyUp5hUWJLBQ2xwR1h1SWjfW52EOaePuDppWYevzLSbs
 0qfgHiYw/HQOFhNXI8d6zHrmWuYbH94WVKbBZgzJmy1LUTC1fhCle13nU5aAKa97MDfnRLck6
 dREE6G3epfUm9Of+TCiJP6QpRtLPqotfJG164FuhIBBC4HM0qh0Zl8AqRDvAe7PBB/4SgZXOS
 Ch3sgvYvYe5OMZIVp4zTXLCb8tYD/koAI2x7U9R6Gxqi5gBVBDb466CGrVIBSNGVjrDFalrFr
 gAhxanNKTF4b5yZrsZxpBmNBo8OqKO5s9e/2KXKtIeHzvlVYREDB/+0xajq2j6/jqVsQ+53RC
 XWiI/OrjagQhDT4P/MMAry670bMKAzWx3EvZhp1tvvHWuqDWV6KnvnnLU6gKp7Ge74FpE/KJQ
 pvLnWL25dn3D2Sx1oRTDCTJmJtcHHW+a5Upgz8mLFfbPlGeqNRore+1PIkRAf/Na3YYVt3pFx
 acTDnBSOmSFU0QVs3rIgO/UXRM8=



On 2023/12/26 17:06, kernel test robot wrote:
> Hi Qu,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on kdave/for-next]
> [also build test WARNING on akpm-mm/mm-everything linus/master v6.7-rc7 =
next-20231222]
> [cannot apply to akpm-mm/mm-nonmm-unstable]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Qu-Wenruo/kstrtox=
-introduce-a-safer-version-of-memparse/20231225-151921
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git =
for-next
> patch link:    https://lore.kernel.org/r/56ea15d8b430f4fe3f8e55509ad0bc7=
2b1d9356f.1703324146.git.wqu%40suse.com
> patch subject: [PATCH 2/3] kstrtox: add unit tests for memparse_safe()
> config: m68k-randconfig-r133-20231226 (https://download.01.org/0day-ci/a=
rchive/20231226/202312261423.zqIlU2hn-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 13.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20231226/20231226142=
3.zqIlU2hn-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new ver=
sion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202312261423.zqIlU2hn-lk=
p@intel.com/
>
> sparse warnings: (new ones prefixed by >>)
>>> lib/test-kstrtox.c:339:40: sparse: sparse: cast truncates bits from co=
nstant value (efefefef7a7a7a7a becomes 7a7a7a7a)
>     lib/test-kstrtox.c:351:39: sparse: sparse: cast truncates bits from =
constant value (efefefef7a7a7a7a becomes 7a7a7a7a)

Any way to suppress the warning? As long as the constant value (u64) is
checked against the same truncated value (u32), the result should be fine.

I really want to make sure the pointer is not incorrectly updated in the
failure case.

Thanks,
Qu
>
> vim +339 lib/test-kstrtox.c
>
>     275
>     276	/* Want to include "E" suffix for full coverage. */
>     277	#define MEMPARSE_TEST_SUFFIX	(MEMPARSE_SUFFIX_K | MEMPARSE_SUFFI=
X_M |\
>     278					 MEMPARSE_SUFFIX_G | MEMPARSE_SUFFIX_T |\
>     279					 MEMPARSE_SUFFIX_P | MEMPARSE_SUFFIX_E)
>     280
>     281	static void __init test_memparse_safe_fail(void)
>     282	{
>     283		struct memparse_test_fail {
>     284			const char *str;
>     285			/* Expected error number, either -EINVAL or -ERANGE. */
>     286			unsigned int expected_ret;
>     287		};
>     288		static const struct memparse_test_fail tests[] __initconst =3D =
{
>     289			/* No valid string can be found at all. */
>     290			{"", -EINVAL},
>     291			{"\n", -EINVAL},
>     292			{"\n0", -EINVAL},
>     293			{"+", -EINVAL},
>     294			{"-", -EINVAL},
>     295
>     296			/*
>     297			 * No support for any leading "+-" chars, even followed by a v=
alid
>     298			 * number.
>     299			 */
>     300			{"-0", -EINVAL},
>     301			{"+0", -EINVAL},
>     302			{"-1", -EINVAL},
>     303			{"+1", -EINVAL},
>     304
>     305			/* Stray suffix would also be rejected. */
>     306			{"K", -EINVAL},
>     307			{"P", -EINVAL},
>     308
>     309			/* Overflow in the string itself*/
>     310			{"18446744073709551616", -ERANGE},
>     311			{"02000000000000000000000", -ERANGE},
>     312			{"0x10000000000000000",	-ERANGE},
>     313
>     314			/*
>     315			 * Good string but would overflow with suffix.
>     316			 *
>     317			 * Note, for "E" suffix, one should not use with hex, or "0x1E=
"
>     318			 * would be treated as 0x1e (30 in decimal), not 0x1 and "E" s=
uffix.
>     319			 * Another reason "E" suffix is cursed.
>     320			 */
>     321			{"16E", -ERANGE},
>     322			{"020E", -ERANGE},
>     323			{"16384P", -ERANGE},
>     324			{"040000P", -ERANGE},
>     325			{"16777216T", -ERANGE},
>     326			{"0100000000T", -ERANGE},
>     327			{"17179869184G", -ERANGE},
>     328			{"0200000000000G", -ERANGE},
>     329			{"17592186044416M", -ERANGE},
>     330			{"0400000000000000M", -ERANGE},
>     331			{"18014398509481984K", -ERANGE},
>     332			{"01000000000000000000K", -ERANGE},
>     333		};
>     334		unsigned int i;
>     335
>     336		for_each_test(i, tests) {
>     337			const struct memparse_test_fail *t =3D &tests[i];
>     338			unsigned long long tmp =3D ULL_PATTERN;
>   > 339			char *retptr =3D (char *)ULL_PATTERN;
>     340			int ret;
>     341
>     342			ret =3D memparse_safe(t->str, MEMPARSE_TEST_SUFFIX, &tmp, &ret=
ptr);
>     343			if (ret !=3D t->expected_ret) {
>     344				WARN(1, "str '%s', expected ret %d got %d\n", t->str,
>     345				     t->expected_ret, ret);
>     346				continue;
>     347			}
>     348			if (tmp !=3D ULL_PATTERN)
>     349				WARN(1, "str '%s' failed as expected, but result got modified=
",
>     350				     t->str);
>     351			if (retptr !=3D (char *)ULL_PATTERN)
>     352				WARN(1, "str '%s' failed as expected, but pointer got modifie=
d",
>     353				     t->str);
>     354		}
>     355	}
>     356
>

