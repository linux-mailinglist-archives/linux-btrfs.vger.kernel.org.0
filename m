Return-Path: <linux-btrfs+bounces-3310-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D9A87C445
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 21:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4682E1C213CC
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 20:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD89762C1;
	Thu, 14 Mar 2024 20:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="GuccfZr/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877D775804;
	Thu, 14 Mar 2024 20:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710447987; cv=none; b=KbFNrxfSUBlFHZH9G86ctHS/Fqp49DW9/QQI4jnjAWJCAzjn/DRyKj9aGpCipQIJyMwnZ58+k9Uy2yFk20vOYfdq0i6Tz2QmrZu/vR9xDxlGtBjy0ZqDPaGCACUI3iKe+CP8YCuQuAmyvmbwuYlRnx/McURihyS4xR2WDPVkeI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710447987; c=relaxed/simple;
	bh=ZnBeDeSWfjCdJ7GYR4YJ2BGIWkdAPDjPmlCB+KR8pGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jxv1dFZE6ZUTzlJfWXPkY3kw90nHkB5Pz59hmhPRPfNi+jsi4sDHv7VU+Y2jxFZ9UkctXpeA9XxV9wOZ3Haj6ZS0z5O/Mjz6wYetQrvZr3+ABF2X26nlNLoXR2v+eaULo36SF1haKVu/MeZYJoDoFNpHCIrRni9Rdp7wPJzMALI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=GuccfZr/; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1710447977; x=1711052777; i=quwenruo.btrfs@gmx.com;
	bh=ArEIYza25ugOhcZyVqXmWy4/8AuxskIzLfppu6JE7CI=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=GuccfZr/sAHTqm7eEm06/5ZRVydWLt/5eg9njIC9IeOC3va1XKbtN+2Dx+eGK6uh
	 shsKop2jOCbxsbU+tdEYegM67gM8bfXUib6eBmVSTJetMvThRBTVRWzrrnADhIucx
	 vMY8XlI3juWqYScGBRHUU5nNvsVx8mnKmnL0afXpkY3THnei+O7Hq5w5TNWrXrXxX
	 vPlDo+pCqD4cmWp+Vc9lGSq3tPJSvt5xCfluXHbUz6qCg5biUriIpSVv3kzyT+VsH
	 xUqU2YGx3/nvXp9YyLLHHMvWXU0xVtCEvJSg5LKZmnJODAzKaG4fOq5DDztcfZPDY
	 dJpPxuuCKSDnpIg+Cw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MoO6C-1r0oWO3nKq-00om1B; Thu, 14
 Mar 2024 21:26:17 +0100
Message-ID: <0d28c03f-56f1-4c7c-b278-bf5ea6de08e7@gmx.com>
Date: Fri, 15 Mar 2024 06:56:13 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] btrfs: reduce the log level for
 btrfs_dev_stat_inc_and_print()
Content-Language: en-US
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, stable@vger.kernel.org
References: <cover.1710409033.git.wqu@suse.com>
 <c54030e9a9e202f36e6002fb533810bc5e8a6b9b.1710409033.git.wqu@suse.com>
 <CAL3q7H7hMVH+YcTY1LufgjTHjKKc6AQyOb-RmppHBskf4h0wDQ@mail.gmail.com>
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
In-Reply-To: <CAL3q7H7hMVH+YcTY1LufgjTHjKKc6AQyOb-RmppHBskf4h0wDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iNKl2Nq0qJafbMgKJq/vzSmiGUrpvY7T6aCMBR69xiF1btZbgdM
 FwkEQtK59tordXI1rKB8cS3GoclsqSsyFuKKLn7FAjFTh8n9UTLK7S1R3Oeiuw4OUVi8mDn
 +548wa+PCu9oRhLkHj/AYQeatArYMEThBtSHBsAuufQLdZnmrE1zEp3pf2Czp9557oVOFhI
 9WA3+5ARaU9iFmcwUZaKQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LBt8tWnH1oI=;+CqIdXUX9MdaMDd1etLZ0u5+Rdx
 2YdaJBGE4tVLeGkFNx9ZbqZPhgn/7kIUnG9Z+P12gBep/N7ZgdwvIjNSbhNTIZL/NnYgc11fG
 L0JqvhanMcLZCNrMH9FDRfx5TXGB/tZmm9WMIFKro3lSyhxF4LlHuJJCox7x8mnAKW/l1+Hiz
 nmTvhOSEhCrDQEmflzXbnsrwxFvjdExzY9cRaf+wSQfOwN8nobfEk+jXAWeOgzVzCm+7IQXVY
 y1kz9G7DA8geiVFYNJrdl+CiqkEBscjaiSCCw+Z8tfr3PxYkxposnAtC4au+tVAmxMuL7npsJ
 YthM7T9SoqYd5GoTkpeYwl2uiiGMIgR1yOTKK+Rys20sjCKRghc6+62q/1nBgL6brcKXMm7Vu
 hJKfEjIKFgWtOnYOW0NEo2hUnVkHMzoiA8Rw6Pwf7ho0QyNr4z4vXXrNOtChmQOpLO8IpSGIR
 AaErTq+WxBJqMkIsio+5UtGKRhBZLQpr1SEg3P98PoqUvjJPTi7UjsGmKHbagmmoxWwvrfVWl
 1ZMQm9GiI2F9btJNe/dqWXMjTfhYHePvmI2oNP72zNP9QpYb2IcoOfeMAwmrSH2VZqcMfZAAH
 ZOI8oUl37PmiLCJNMncOjS3/YjRYjF9mRPqf4/Xc9UzBpYZAILojwp4Sk4l78qSybElk5131t
 VBh4GR4Y1LFMcbEhvbvv0e46eC97OPf862jhozViDmNu9uUi22/js03/M8Bktnu06Rpltyax9
 y4IvSBmra8gy8tVQeWqMFx4unvKHgwJhgo0tfgDMgS6hYiHWfQI72vBZIQ0BiK4HYlbCuiUBn
 ixD6rQJVdDxsu/OgxqW80iliUm6mfNVx3BYDAx4NfFddU=



=E5=9C=A8 2024/3/15 03:47, Filipe Manana =E5=86=99=E9=81=93:
> On Thu, Mar 14, 2024 at 9:54=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>>
>> Currently when we increase the device statistics, it would always lead
>> to an error message in the kernel log.
>>
>> I would argue this behavior is not ideal:
>>
>> - It would flood the dmesg and bury real important messages
>>    One common scenario is scrub.
>>    If scrub hit some errors, it would cause both scrub and
>>    btrfs_dev_stat_inc_and_print() to print error messages.
>>
>>    And in that case, btrfs_dev_stat_inc_and_print() is completely
>>    useless.
>>
>> - The results of btrfs_dev_stat_inc_and_print() is mostly for history
>>    monitoring, doesn't has enough details
>>
>>    If we trigger the errors during regular read, such messages from
>>    btrfs_dev_stat_inc_and_print() won't help us to locate the cause
>>    either.
>>
>> The real usage for the btrfs device statistics is for some user space
>> daemon to check if there is any new errors, acting like some checks on
>> SMART, thus we don't really need/want those messages in dmesg.
>>
>> This patch would reduce the log level to debug (disabled by default) fo=
r
>> btrfs_dev_stat_inc_and_print().
>> For users really want to utilize btrfs devices statistics, they should
>> go check "btrfs device stats" periodically, and we should focus the
>> kernel error messages to more important things.
>
> Not sure if this is the right thing to do.
>
> In the scrub context it can be annoying for sure.
> Other cases I'm not so sure about, because having error messages in
> dmesg/syslog may help notice issues more quickly.

For non-scrub cases, I'd argue we already have enough output:

No matter if the error is fixed or not, every time a mirror got csum
mismatch or other errors, we already have error message output:

  Data: btrfs_print_data_csum_error()
  Meta: btrfs_validate_extent_buffer()

For repaired ones, we have extra output from bio layer for both metadata
and data:
  btrfs_repair_io_failure()

So I'd say the dev_stat ones are already duplicated.

Thanks,
Qu
>
>>
>> CC: stable@vger.kernel.org
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/volumes.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index e49935a54da0..126145950ed3 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -7828,7 +7828,7 @@ void btrfs_dev_stat_inc_and_print(struct btrfs_de=
vice *dev, int index)
>>
>>          if (!dev->dev_stats_valid)
>>                  return;
>> -       btrfs_err_rl_in_rcu(dev->fs_info,
>> +       btrfs_debug_rl_in_rcu(dev->fs_info,
>>                  "bdev %s errs: wr %u, rd %u, flush %u, corrupt %u, gen=
 %u",
>>                             btrfs_dev_name(dev),
>>                             btrfs_dev_stat_read(dev, BTRFS_DEV_STAT_WRI=
TE_ERRS),
>> --
>> 2.44.0
>>
>>
>

