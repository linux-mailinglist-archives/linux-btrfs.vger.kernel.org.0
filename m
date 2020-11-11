Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C432AE5DF
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Nov 2020 02:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732293AbgKKBfB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Nov 2020 20:35:01 -0500
Received: from mout.gmx.net ([212.227.17.22]:35469 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731657AbgKKBfB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Nov 2020 20:35:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605058492;
        bh=kuXeiYlgDiVbrDaXNMZ5wBt1tKVywepYJ16kBaXvtxQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=LM0pEBOEniD89LS5t3EoHiZVxxXTmwwjHBkJaL7nk1bhGhMAnAjlvlw65uGrik/SH
         t5qAkGwjpCZIC/XB5fepmKOfcYZkphhdN0nTNgka1ClrKl5haAgg62E+omGpM9yv4i
         D9t1VQffpcDCgmhWTHsp0DMzblRPW8ad32FFuo4M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MUosT-1klDcg1pyL-00QkuX; Wed, 11
 Nov 2020 02:34:52 +0100
Subject: Re: [PATCH 15/32] btrfs: introduce a helper to determine if the
 sectorsize is smaller than PAGE_SIZE
To:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20201103133108.148112-1-wqu@suse.com>
 <20201103133108.148112-16-wqu@suse.com>
 <0eb2c642-f0df-a899-388d-2e1d9db6e5ae@suse.com>
 <5079f2e4-10b5-4024-1dd7-d2a59cc4945f@gmx.com>
 <20201106172816.GQ6756@twin.jikos.cz>
 <8633b9b2-42f3-4916-b252-c9f9a23382a0@gmx.com>
 <20201110145348.GJ6756@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <22f2ce66-e586-f84e-caa2-f5176725b3bc@gmx.com>
Date:   Wed, 11 Nov 2020 09:34:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201110145348.GJ6756@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M8WtWWGkVuHNR1IphM71tbyRWaaOstJWEXUnkw03ZhoR4CLlzPI
 yEVnDWBT97YyBrxguDEsXHd/A8mt9pnJ6vKbmuw3nBqnSq1DpsRXRJT9sDlSPJTSnpSgPAU
 F3/4dkTA9F/0R2+KyZwVqVxtJc1nl13CxkzPIEVd4qf1a4skav2xPJWaxQ56UaboUaa1WgO
 tw9WCc2vlvgcldWM3Qj4Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WzOhzUMBJS0=:nDKT0ZOaz19+KsLn7OJ74z
 eg0SqgvxakXwFkxVuRdw6Zu5Z+PM6gijDG6VCWt0o977VsAzZwe9b0DuteplNyWNC475O8aqL
 fS9iMOqpExTlq+akyN+myXJ9mHqaY2/wK4bu8wQjGRLqdHuByFn++Lw8VFpHasQ9sjIMGT/Uv
 ztZbenIKb+ewNRSmZRqNckHLcNjI8niz3yW+apPi1OJtvz+dCHtH1w/j83q8cGvFPr740BOZG
 eYuRhDMKs3KyUEAqp72I6oEi9fzBgYOCAC2Uo+ckL8xmUvaWKHtdJVC8m+jI5w/qUgSgOtrD5
 P5VhLAjlZeTDEVsqBxKNCDLv2Xrqi7g9SP137AdaTVdF98BHPl1MiLRY8fOoP4IS3DyIFybeg
 QEn4TT269tuNQx2ymgpL4ki1Gys8RnTE9eYsUifcsFrntoxbHcyqbx1TM+nyeXs93WcTVTB/c
 TTM8mLIw7jJX0Xa6LyFjnfqw7FxP9gRJWY+qYReNeQfgX/rRh8grGZ2azTiMs9jQlhM4CzrWD
 i4yjT6iT9Ti7dwawhLXP0/QYdIXFm5hEXQJ12OEdyvk0OzA+3FK3x+zz64Hw36yBhqSBv3Awb
 7npJV6zJh2gzao64sQ5nsoCt7B6+cRNPx35YJ8Wpmt8/ih2lSqazSFp8/vmcEMP29UsOh/puC
 CsUsy6DwrVlQS1y/y+NflFT9BhucLMtfWWq6QfE2Tlu8JRxI91pCmtsiQEb87VnhF0HMzDIUA
 yXctgY2FofBX//afnLgs6+Ca4kxI1MTZerIo1/x5gi9Oe0UGYucqo5RnVk9VheGY/mZzOqbqm
 mH+zgMbNKGyd4cRa/FTFUDe2qOFhLO14of8ttKLSCU482E4C1HmiBbzRBPNMkQSB15RNBkR+z
 HrP3Ij38ig8AcJOPO5gA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/11/10 =E4=B8=8B=E5=8D=8810:53, David Sterba wrote:
> On Sat, Nov 07, 2020 at 08:00:26AM +0800, Qu Wenruo wrote:
>>>>>> +static inline bool btrfs_is_subpage(struct btrfs_fs_info *fs_info)
>>>>>> +{
>>>>>> +	return (fs_info->sectorsize < PAGE_SIZE);
>>>>>> +}
>>>>>
>>>>> This is conceptually wrong. The filesystem shouldn't care whether we=
 are
>>>>> diong subpage blocksize io or not. I.e it should be implemented in s=
uch
>>>>> a way so that everything " just works". All calculation should be
>>>>> performed based on the fs_info::sectorsize and we shouldn't care wha=
t
>>>>> the value of PAGE_SIZE is. The central piece becomes sectorsize.
>>>>
>>>> Nope, as long as we're using things like bio, we can't avoid the
>>>> restrictions from page.
>>>>
>>>> I can't get your point at all, I see nothing wrong here, especially w=
hen
>>>> we still need to handle page lock for a lot of things.
>>>>
>>>> Furthermore, this thing is only used inside btrfs, how could this be
>>>> *conectpionally* wrong?
>>>
>>> As Nik said, it should be built around sectorsize (even if some other
>>> layers work with pages or bios). Conceptually wrong is adding special
>>> cases instead of generalizing or abstracting the code so it also
>>> supports pagesize !=3D sectorsize.
>>>
>> Really? For later patches you will see some unavoidable difference anyw=
ay.
>
> Yeah some of the new sector/page combinations will need some thinking
> how to handle them without sacrificing code quality.
>
>> One example is page->private for metadata.
>> For regular case, page-private is a pointer to eb, which is never
>> feasible for subpage case.
>>
>> It's OK to be ideal, but not OK to be too ideal.
>
> I'm always trying to take the practical approach because with a long
> development period and with many people contributing and with doing too
> many compromises the code becomes way below the ideal. You may have
> heared yourself or others bitching about some old code, but we have
> enough group knowledge and experience not to let bad coding patterns
> continue coming back once painfully cleaned up.
>
Yeah, I totally understand that.

But here we have to do trade-off call for page->private anyway.

Either we:
- Do special handling for btrfs subpage support
  This means, for subpage, page->private will be handled specially,
  while regular page size will stay mostly the same.
  This doesn't touch the existing behavior, except one extra if () check
  on certain low-level functions.

  For subpage, page->private will be used for extra info, like various
  bitmap, and reader/writer counts. Just like iomap_page.
  This would be the "code quality" impact.

- Do no special handling, unifying to subpage behavior
  This means, we will allocate extra memory for each data page no matter
  the page size/sector size combination.
  Obviously, it would cost extra memory usage for each data page.
  And if we had any bug in subpage support, no one can survive.

Thus I take the poison of the first method.
Also to reduce the impact, all btrfs_is_subpage() check is in some lower
level function.
You won't see much btrfs_is_subpage() check in some common functions,
but all hidden in some helpers.

I doubt if this would really impact the code quality.

Thanks,
Qu
