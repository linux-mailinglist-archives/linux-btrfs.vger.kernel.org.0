Return-Path: <linux-btrfs+bounces-3207-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C228878D5D
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Mar 2024 04:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 569291C21B3A
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Mar 2024 03:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E369463;
	Tue, 12 Mar 2024 03:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="C7xIugB+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A04F79F0;
	Tue, 12 Mar 2024 03:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710212799; cv=none; b=EGSNKxw7dLFCUowK5nZ61N3pDfFMgeMyYGabyldbxG1upbZLSll4II+MyfW9j9eWmxv3XrNr44KfAj/wikm+uCQIDW9yl3uZlDHSEaceHQ7oZeopnJNjPFPndKjkF/jqVfIrN53+UI6fc0yPUWnsjHqs8EBdoyZVxO3J0Ll/nEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710212799; c=relaxed/simple;
	bh=Dsz8rOrKGnoesyhzbMnlt4gtpaDOM6z/iEpucXsac1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tbjAEX+2d30iR+DzKlGaQDR1yIV3QvDN/AjDRsC9K4zVl+UbbzTt9z9NOPlQMtz+HC82UvN9HIOtCmPDT0KA3ca4SL8idLVVDo8rYb57P/Q+WxOidh1/79sfWzATJHVD4G9/ofBaWilPPqcSEf+bLOs7ul7WPjX7zrtvSj1yeHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=C7xIugB+; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1710212791; x=1710817591; i=quwenruo.btrfs@gmx.com;
	bh=Dsz8rOrKGnoesyhzbMnlt4gtpaDOM6z/iEpucXsac1E=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=C7xIugB+iXYHhju91HtNbRvagny7E1K4EERgWHXN9UIwf2K76AxNyYTaRPam0uVj
	 b4EWD0SBk/LRVgWhtjMA0mu08rmyE1ulrORerlrBpLwU8rFhdnguwu7Xpavujqpck
	 GT+Uzj9ne0u3tAdIceVdGnqSgzg2pc4UEA5hf8yicrYuMLg0qRl1PFYBpeOz9mbiH
	 8KZwwXtLMmWHDM4mrXQkN7gh/6Z1gvCxrCIckYF278bnJPCivoD3G5sp8TbdTGi+D
	 oIeysmfzIvr5sTHc1VZNZFgoX2wNJ4XTRK1GtSsKteZOYjstMsM77b7L/+YzAWBGr
	 kXzjapPfhgumVEPnMQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWRRT-1rKqQX1R0N-00Xvng; Tue, 12
 Mar 2024 04:06:30 +0100
Message-ID: <51f4dcf3-d0f2-4a05-af68-7ee124eb8045@gmx.com>
Date: Tue, 12 Mar 2024 13:36:26 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] btrfs: defrag: allow fine-tuning defrag behavior
 based on file extent usage
Content-Language: en-US
To: kernel test robot <lkp@intel.com>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
References: <d87c011eca11395aafa23cf7ea3ac8c0c8812fe6.1710137066.git.wqu@suse.com>
 <202403112159.IQpF7kcT-lkp@intel.com>
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
In-Reply-To: <202403112159.IQpF7kcT-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BMzuF9ftvf2viYlDFvVHz9k9uUp9BG1gh2SsPB2rf3wal+cGLhj
 m74rk2cnbPho1Q6iJFSQItTbAm2HdrTWdmmoQ1R5vrR/3BPCrNsil8MFdi/+ahAfHI45OM0
 BNxGyC9S1Vfwu7zlX5OtHgp6G6vUH7yqEBMnMNesWWaxpX6hF+nIDajHcDT8LDZbMopwMKJ
 XSXY+RJCHr5Y3LuO39PNg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:urgd2w3GMgY=;GI7HN3awwr90741H4SlLErxnH7f
 WIBzaJoBMnCUKeVnc8kutH5Vujdhj5W/Pbr1Pt0IfeIqWM+Mo+lMquisJ7sP6I6zP6fvxH3gC
 Lv7No/pthJ+DjKobLaUIjlmXs7GWCJzeZeFlrq9jHKldu2ONmnkbh0qNii7k8121nc/d/vOZU
 qQBZ1zgd2BJq0A9/vlFffJlp2AX4w6W8BkzRPIepcbI204juipZRd3DIjfotYXBCTee9ja325
 Mp/pgAWIfvyMX3GOgGoI4KIxcWsTBjyE+mV1qktzDG0EZwpaMhmZtjkYBGWGWR2FAbplCNTft
 n0fSPMflN83LvSAsIBw0G2ginAsiW8VE6IM0I99Ejcp2MOp+BS6gke+gw2OyeLJp1BTplgKmp
 B7kIImn7DHpeuY1QeSO+4fgpo2JJ0IY7hjevTNRoGY4WPDdxd3PX1KCHtutwlLL7H42FIJh1H
 5GyiSb47MaSKlOenmxFwcuTN0ToEK2JXU05w85Jjpu/ev9fTcOR5hzzphrCkOYxQhyCtWpLay
 F5EIQjtRBGFlM5zB/n2erqvoXBmXRl72p2HRP7ntkVJE4NVdYNCxdDDty+rxXN02AplJ63NSy
 S7kCChfyNHmoZDZHiPTx5Dc9ik6vCUdU/6JVePUFeBRmQxc3REh4BDyDKftHwvmIvJ1kEKegA
 FYttWMRaeEiEa9nbsBhXV65U3Fmn/EGntL2KUbFPTVsejyNsSkgk1yBN4uUjr+htbycovx9SY
 vupLYltXaH6CHYz8ETdqKB7KFR1LcsJivCI0/R1LxNirSz630TQDmHZxhZlCrwvKho33/7GA6
 NCX9EeFOLi5XaUFpJc+cB2EBKujdbiq9+2gOp13XjaI5w=



=E5=9C=A8 2024/3/12 00:24, kernel test robot =E5=86=99=E9=81=93:
> Hi Qu,
>
> kernel test robot noticed the following build errors:

Thanks as usual, the LKP bots are really helpful to detect such 32 bit
division problems.

>
> [auto build test ERROR on kdave/for-next]
> [also build test ERROR on linus/master v6.8 next-20240308]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Qu-Wenruo/btrfs-d=
efrag-add-under-utilized-extent-to-defrag-target-list/20240311-141116
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git =
for-next
> patch link:    https://lore.kernel.org/r/d87c011eca11395aafa23cf7ea3ac8c=
0c8812fe6.1710137066.git.wqu%40suse.com
> patch subject: [PATCH v2 2/2] btrfs: defrag: allow fine-tuning defrag be=
havior based on file extent usage
> config: m68k-defconfig (https://download.01.org/0day-ci/archive/20240311=
/202403112159.IQpF7kcT-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arch=
ive/20240311/202403112159.IQpF7kcT-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new ver=
sion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202403112159.IQpF7kcT-lk=
p@intel.com/
>
> All errors (new ones prefixed by >>, old ones prefixed by <<):
>>> ERROR: modpost: "__udivdi3" [fs/btrfs/btrfs.ko] undefined!

So it's my new 100 based (aka, percentage) parameter of usage_ratio
triggering the problem:

+       if (em->len < em->orig_block_len * usage_ratio / 100)

Where my previous version goes "/ 65536" and the compiler just change it
to right shift thus no such problem.

Thanks,
Qu

>

