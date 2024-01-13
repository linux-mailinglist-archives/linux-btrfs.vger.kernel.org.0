Return-Path: <linux-btrfs+bounces-1435-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E2882CEC3
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Jan 2024 22:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 240181F2212E
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Jan 2024 21:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E3C16436;
	Sat, 13 Jan 2024 21:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="OIgFMMEw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099FB15AF9
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Jan 2024 21:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1705181037; x=1705785837; i=quwenruo.btrfs@gmx.com;
	bh=5DIYeolcksyk/PrsCbWRJPkdt4U8P7GpEGCtAG4Dnxw=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=OIgFMMEwQKkDv6EUPNfHJpNilWRYUv4HOZf7wdahSRh4gaJZwc7cLpuJadLFZ4Z0
	 7nXtqC82NlhJWCb0l4g9EiWEZl0eSLWHBpbwhRgxofciy6ahMCIXy+9stqxNsleTj
	 ODEMLgDP6F5h0OaMLcVc4FlvUy5wkNChXBT798o/sGej/Q+PH3vvdbYtX6HKmcFMl
	 0mfQF5eS0+H4OHvRVGwFQvsDKTr7EuG8cMFldEMTfGxCzVLaaEP5O/8No3/F5gpzU
	 ZM6caU1i5AvFQd2f/4LRiyx/7+vjLICyw+wmlO8qdtWsB/S+XC69oEGKn1gjYHwVi
	 R4+jFSlG+FkYsMY4mg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([61.245.157.120]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MEUzA-1rLx7m2IjS-00G1OS; Sat, 13
 Jan 2024 22:23:57 +0100
Message-ID: <b28cb9be-b21a-47ab-807e-23a1a8d0f6f6@gmx.com>
Date: Sun, 14 Jan 2024 07:53:53 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: scrub: slab-use-after-free (ae76d8e3e)
Content-Language: en-US
To: Rongrong <i@rong.moe>, linux-btrfs@vger.kernel.org
References: <0a3faca1c52f7fff0ac35566c6453f81f57a3d16.camel@rong.moe>
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
In-Reply-To: <0a3faca1c52f7fff0ac35566c6453f81f57a3d16.camel@rong.moe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mPBPweq7YJpqVqo7+0rGcHmPqKIThZ071/aocWrf67eYwfk0UUt
 6lyo+GBLTAw09oihjfu8KPXl0zLgDEXo4pm8wQ27x1dHkfxJZ4bkSbOpFQm9H3P3hkZfY9K
 +suOUWYhIN9pEKt6jIbWiGiPkVdtN0qjVLWb3u8//kaaGoxp2xQRkewKYRE2rYth9Ku87w0
 BxdykQWMq4kLxEy2u6u5Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:o6O4keepbIU=;QNXwT/n9ztEPKB3rF2IjtzkBCZO
 NJ7eK6OucoskYqU4tVe4rfgLI1TaVPFXEob2N8WAZNSF4ruM3+bzJ0bYS1ZQVVmTUXVErJEVz
 kb/sVPWQAJNippgxYsq8H8naRmvJBAQGVHSdGQSyHuKtv5LfqHRoPxuOHc2lbSjtYKxX1ETpj
 b72ULS4rJ56kQsVo5cemyYdW9XVpx6Jp1tYSl8/BY7mhecndU06SE0IvaAtwJydkaEOwHvNVG
 PKVAjcJ6+WSnDNyPqVhCeLJr39KoQUkTh/H5DXmJZ/OdducnaTYHam9Bqjr70KS70Th3SQKl6
 xdH8k8I1MwuSyhtoNtY70G6Tu+kfdoGU38yGM4jTh+eFpd3VvHwFU7/60KI6KpkX/CMseR8Q6
 CqD+3VodwqPvnwm43UCkM9PpcoS5GHoBvZ4WswJEiDn/VjbEf7dFPR9YWh0DkEItBC9NyLR2D
 FhzjEJ9qOuIkZIOapCKVJzVLWrTm58Mcw3n+v4NvYTr8YjKh3UDZh6oFPC06OzpADolyyL6wi
 vcbfGUk448kmNJFBicdEek0Sw3jjZNRGRN5hVjq6yT5oiO7vzLh5NRrhcCIrIQY4uGu3ZRf4g
 cFfedctYvjeq1A/Qe3S/WaPIKpApzzZNEnwnJzYab727C+MprDjJC0rqX3H6nJ2VmxoM4nnHc
 zM0bz7m/nB6Mvtcyx57dnndz8n5fNhNiK+ZZl/cyNUBMdR0uCkV4GvTyW6rB6UjfdvPcqRp9+
 zqzz4Rab2o0daQc6o+hvoOoFIA7LdpHOhZiuwCtcZKZfjiLe2nm0S/ofwzk8ixPIzPbcFBp8b
 uGmqG2ZHLJs4Do5A5lfpwBPtyhMDH+qJLiJII85x16C0lYFuNdZcIZnskwkujVxzS2bynRjB6
 Z21oP3X8CYWkQB4iyB8P7qsE0RTzlHBkJGGANJr40InxWwuR/u9whCBzgYqswoC911yLYIzFz
 BHub1RWhDaZ22QNjl5No3oxheWg=



On 2024/1/14 04:10, Rongrong wrote:
> Hi all,
>
> I recently scrubbed my fs and surprisingly saw kernel oops. For context
> and more information about the fs, please refer=C2=A0to
> https://lore.kernel.org/linux-btrfs/8bd12a1ee60172f53ee0c27374f41c3ec997=
6be8.camel@rong.moe
>
> Usually the kernel oops when the scrub progress is 1~30%. Then it will
> oops again, making the btrfs process die. After that, any attempt to
> unmount the fs hangs forever, so do reboot and shutdown.
>
> It seems always reproducible if any of the below conditions is met:
> - Intel CPU (i7-7567U/i7-13700H), intel_iommu=3Doff
> - x86_64 KVM (host CPU: Intel/AMD), virtio-blk
> - RK3399
> - Mounted via a loop device
>
> Not reproducible on:
> - Intel CPU (i7-7567U/i7-13700H), intel_iommu=3Don
> - AMD Ryzen CPU (PRO 4750U), amd_iommu=3Don/off
>
> Starting here, all experiments were done in a KVM:
> - Host: Intel i7-7567U
> - Vdisk: raw dump of my fs, virtio-blk (IO scheduler: none)
> - btrfs-progs: 6.6.3
>
> The first reproducible stable kernel is 6.5.4.
>
> Bisection between 6.5.3 and 6.5.4 indicates that the buggy commit is
> ce585c9b1cd700324fecedae130a9c35261fec30, which is a backport of
> ae76d8e3e1351aa1ba09cc68dab6866d356f2e17 (first appeared in v6.6-rc1).
>
> KASAN detected slab-use-after-free in __blk_rq_map_sg while scrubbing
> on v6.7, meanwhile an assertion was failed at block/blk-merge.c:584.
> See also the attached dmesg.
>
> With the below patch applied to v6.7, slab-use-after-free and oops
> disappeared, making scrub able to finish.

Thanks for the report.

Although I believe the root cause is the same for the uncorrectable errors=
.

And IMHO, even with the patch, as long as you enable KASAN, KASAN would
still warn about the use-after-free.

The root cause is that, the new scrub code expects the whole 64K read to
be mapped in one go, thus no bio split from btrfs bio layer.

But for the converted fs, the end of a data chunk is not ensured to end
at the 64K boundary, thus it can lead to unexpected bio split.

With the extra bio split, the scrub_read_endio() can be called twice,
causing the same bio to be freed and all kind of weird use-after-free.

Sorry I didn't notice it early enough, as it needs the full chunk tree
dump to verify.

So all of these would be handled in the original thread.

Thanks,
Qu
>
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index b877203f1dc5..3fecd7eee0bf 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -1698,14 +1698,11 @@ static void submit_initial_group_read(struct scr=
ub_ctx *sctx,
>                                        unsigned int first_slot,
>                                        unsigned int nr_stripes)
>   {
> -       struct blk_plug plug;
> -
>          ASSERT(first_slot < SCRUB_TOTAL_STRIPES);
>          ASSERT(first_slot + nr_stripes <=3D SCRUB_TOTAL_STRIPES);
>
>          scrub_throttle_dev_io(sctx, sctx->stripes[0].dev,
>                                btrfs_stripe_nr_to_offset(nr_stripes));
> -       blk_start_plug(&plug);
>          for (int i =3D 0; i < nr_stripes; i++) {
>                  struct scrub_stripe *stripe =3D &sctx->stripes[first_sl=
ot + i];
>
> @@ -1713,7 +1710,6 @@ static void submit_initial_group_read(struct scrub=
_ctx *sctx,
>                  ASSERT(test_bit(SCRUB_STRIPE_FLAG_INITIALIZED, &stripe-=
>state));
>                  scrub_submit_initial_read(sctx, stripe);
>          }
> -       blk_finish_plug(&plug);
>   }
>
>   static int flush_scrub_stripes(struct scrub_ctx *sctx)
>
> Thanks,
> Rongrong

