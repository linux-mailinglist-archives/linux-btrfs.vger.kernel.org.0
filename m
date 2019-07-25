Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE8B74791
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jul 2019 08:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbfGYG61 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Jul 2019 02:58:27 -0400
Received: from mout.gmx.net ([212.227.15.15]:49149 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbfGYG61 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Jul 2019 02:58:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564037899;
        bh=1v7Weyz/N8FLF5JfFzbuwrWIs+UO2CAxzddcnYKrBmo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=bGfDZO5yLXSohoWAjY8TvJ5hphxQSLHPSml2dgla8B0xzQcx1DTDjHREbo+CVK5bV
         3Cr+7n8b1mqRUDaMK0icKaPGsLpvgRrkHb8d4lKjt5Mwv8bml//2rhomwmvFxXHQHA
         u9bFPsUMvmhiU57S41cueZZKIB8pF+op4wws/eNY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx001
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MarNa-1i6Qgy08D4-00KPry; Thu, 25
 Jul 2019 08:58:18 +0200
Subject: Re: [PATCH v2 1/5] btrfs: extent_io: Do extra check for extent buffer
 read write functions
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190725061222.9581-1-wqu@suse.com>
 <20190725061222.9581-2-wqu@suse.com>
 <8b314cb7-880f-a5fc-0f8f-dd45116351a1@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <403a5d56-6d70-d983-25cc-e8481922f56d@gmx.com>
Date:   Thu, 25 Jul 2019 14:58:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8b314cb7-880f-a5fc-0f8f-dd45116351a1@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RkD4i/yM1EtVJzXF9XzY+hmgdmjjL5n2LWPT5rO6zNc6y+tOahh
 i2MR8MvbbysdOzmCeiz05C7cpESWAq4/BltFmvkGni/e0hSyJP9UMZmnDGOg4Y/YUMG+CzD
 RBlZlOJEubvLOOAEz0aNlY57IXl1tZI0P6QtBT6/Yf9iQvA5o7ws4G46dYKFezxGpTNRZtS
 kQjOGlFGXAhSOvBIJTOkw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kwmLLbl2K50=:ixUIRfxoaDwX5Xg/C6IEGb
 5WNfUNOxnWFZMrQTwsUfH/MWqLnEEeGOb2rol45Ga+Pvy9LMnm3n67XKCviB5K3MG8JmFoD4C
 gYLN9yhMiB1R7kRmICHfcp9bu2siWet/8H2i1qiB/SCF6lkYEFZUdqjni7JLhT8MHiVemkKRM
 Liw8BkmDdgNUyVsvzARjgJjMjwmrijasCmJYxDpVu+0/xbhdD4PpsEAqzB8epOqEXdqOXRr9f
 0Xt/1UpOJU2MspAeJ8weGmAiK+2Jg4YIOom23/F9o95adYbwV7AtDlrLePPa2JjSTEZ94NcYH
 uk55TGa1/p7x6/lxstLD6qfw93vX+3nccI0nwefx1rjreNE5trRoOUFgX7KSkS5ECkNMvpcbs
 o+F+MvwiWcQyrlR8cZyraZPN+VK7ck+MeHBTVMIKGeRsO25iOaoG8FP16A37FxcCQhIMGLkHI
 xbhh+e99MxYIfmSvJ5l0r6e/bCYHV1cM5qFtmQ8jad0VEW27P9xQBdj9DQoizu/EX9Q/HVBvA
 LS2OWJIrFbvntf8KNXhAxUhkQisZzWVTPjtLrdDBoX/mOiFWhIKugXfvQYGO1Qo2BKeQxF5Cz
 i2UIPvlJJD5vcOmHOk78axAcaK5tziyu7hPqCtPaxqxTJ3qqHAwRXx4/M/jrLiylpGN8MJQGk
 dH5HmsraYhsse7GtlRCEwrCZOJbXFVSKGh/ik4TMBpLPCHPmtpq8ABvCWpVEYr4T6iu2jvvIe
 OfrSrxvz8fgJ0CAFzksf7sUiWRNCP9u6fXE4k4Kkfcmplk6tGZerMGIphUoFmMYOwjgDWSzXg
 ySGSin3+QZ9K2TGwGx3u4B/rR2MXFsPOy3X68sr2Y39gZAi0xOv5oDVbcR5nj+2lrvVZtZsMb
 dcPwHOOq8OcnzpPGiVW5mOPOOC73vllyvYY5ehJpkXt8Je+W0vO2zHsGGBnVuRBPF4rCg/A3O
 vGq1F4+mNzEhqflrl3iyRty014RiW7Y/5y+wK7SXvSo2RMH3QsW/LeZhX37nrkcDIb0h1oebP
 9iAKeSlBBW+X62n7nOFWcmKMNalPZqGpEzE3z7KoZYAIBN5EkV7RVraQtPAHTghZ+V2vFEPjk
 V/4K8PF8blHq2C0q27TOto+t8wXP+nMNDeC
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[snip]
>> -	if (dst_offset + len > dst->len) {
>> -		btrfs_err(fs_info,
>> -			"memmove bogus dst_offset %lu move len %lu dst len %lu",
>> -			 dst_offset, len, dst->len);
>> -		BUG();
>> -	}
>> +	if (check_eb_range(dst, dst_offset, len) ||
>> +	    check_eb_range(dst, src_offset, len))
>> +		return;
>
> I'm not sure about this. If the code expects memcpy_extent_buffer to
> never fail then it will make more sense to do the range check outside of
> this function. Otherwise it might silently fail and cause mayhem up the
> call chain. Or just leave the BUG (I'd rather not).

Yes, that's also what I'm concerned.

But at least, for that case we're not making things worse.
Furthermore, btrfs tree checker should have already rejected most
invalid trees already.
So I'm not so concerned.

Thanks,
Qu
