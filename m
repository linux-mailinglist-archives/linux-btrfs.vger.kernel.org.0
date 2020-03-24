Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39A8119060E
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Mar 2020 08:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgCXHHj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Mar 2020 03:07:39 -0400
Received: from mout.gmx.net ([212.227.15.18]:51789 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbgCXHHi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Mar 2020 03:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585033652;
        bh=iO4kmoj0RqdmLWMjfdEYNQ0rPuGStJizcQ2THYeuRrE=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=AzZn5S25RuH3QbpFfD6e/WCZ7R5/PfbOxCJCx60of5Nh2xUOigMC5q8jOUNXnMOa9
         FdG3W5nlVWhfEcEEAzJMxIvNkJESH09CfehdgpStOwKw8l0Khad+/CG8myIKsOjeNw
         60LSGquATNKDnV4lmlvvgig0LvtvaOu4XspoJzDc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M3UZ6-1jHBtB39ve-000asx; Tue, 24
 Mar 2020 08:07:32 +0100
Subject: Re: [PATCH] btrfs-progs: check/lowmem: Fix a false alert caused by
 hole beyond isize check
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200321010303.124708-1-wqu@suse.com>
 <20200323193826.GN12659@twin.jikos.cz>
 <23f1c445-8a0d-b0b4-a557-51e602d58db7@gmx.com>
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
Message-ID: <bc273897-6fa0-a315-0292-bc1de42939a2@gmx.com>
Date:   Tue, 24 Mar 2020 15:07:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <23f1c445-8a0d-b0b4-a557-51e602d58db7@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mZoqq4VKK8zIMzkDh28hfSKLUamnJ9AGL"
X-Provags-ID: V03:K1:MFwAoLON1scpyUsRjrudNKBfNwcLncZgr+il1iZRMY8O6F7AWEb
 4nlYDiTrlH4a2N6JqRLDSY0fvWinlFJBjeo0n4WaPAdNfTf6YRt8dCE5xeqfcwTWL0fVttv
 giixJCFXtWR+9Vv/9qvM4Di39BNMozrNEzuhQjalG0bfxWD4kOZrz7j4wN9/5RteaqcpN42
 hlrNbhrA+74Gx7/2ypAMQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:N2oCZoTkKnY=:cHICVid2An7oBDlZfuWcmY
 ho6sjz+bwKEGWOlsiYr55Q9SOnFxmZZmSk49sUlRjyroRE+tYmwEqyvPoYYKCnbAZRQyxX0nr
 uSKt1k0Lu/roAMrHHtc5E3TSFA01Ul6zbV/o6hanpsynzXvpbpGGyNrQXRmn8uM0KX29TubVg
 cpfOzNnJRCMTYTfyPmVKH6JerQt/tib3RCRJzp6ck6PsYQvcLdGJahMZUJXLw5V7Ypi7rAW/J
 uenlxJJrRtQs98yLFDNpW9Fiv2H/lk9lBAmOzo6UV5qO2dfrQ5d4UBm5pyPWfAqWpYGs3Y9MO
 j6QHNE39NmI1wMdulv+zvYycfFaGRGUgLJzo4Be9TXpyg7rYIr8gc2JsDVCJsbCHpciPDpLqx
 Xu7YgsCVEppH6RtHL0faKUtuGg5jhk346JmEwuYu+wY3EJhfKrUS9FjOKZMIFEuqMpzMmmskr
 LwWl2WVBRILkHFnWxwFCvhOqFcP+Upl9rAuDVoIMP8SubICNtqLGG1yUQNGqw0c/XL3XbfpSm
 /RaGJv7fdRbpdBB5azxBBRMcEl9hOo3AYkINYEXl0fGW0EsLcQkTNeEeg/NobOICo96eVKevo
 egVyieWpf+P/pGvSZJ09ehT3bgM1zLdJwmqWqDGMZe2sGP/zPU+mKSbRCgER2nMxsGfSzPAL5
 R0oqgptvzuzL1kGKxrmNFYMGb/KbUqgumqX0SZW24SUumTPALIBqc4Tk9/C1k1Ihbkwq4OwHL
 U1DLYQunOfVXguTI9yLrlrm4mI1TqMNEugwXehA9vravz6DgaHf05E7zazZF9lJudAqw7eLe1
 KFitpFWIqbOxQV2FrCvlyCk1LEcVHNJ52HviCNkhoiwpPIz+d1gO0sFeBEJLE0h8QVmz3Y/tg
 Cms+BCE+qMll2sXdetTjQ4DXqRO3EvEiytDS9XbK58i9cEkzLFJwyxXKRyXUG6Aa8PditP1hw
 ygLE6GgaZLHFIaRQ8vnAhZOAUg75VRFz6MRqqaQXYi/d+HM4//+Xn2cO+KSJxhdG+bG1t/H/u
 nZimQPsgZh9oxKste1x6MLgpDTn0HXnOUZyrHwXUr84A1mQf0adDv3MomQ99q7n5eJ85sccXv
 sFNd0+HZIGLXf+qlSNGvt0qGcXC9A2Mi8fccBxAtH5MCQEBuU/MnyDym8omH+ccBgtNi387Y5
 Drfzw4vJOtd4+SBIZ0ZTGflHjxXggrdXvhP4d99K531vTPFV297hQGNo8+ea6J213I8qBdB+E
 B1F3DDnFW6+fs+Van
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mZoqq4VKK8zIMzkDh28hfSKLUamnJ9AGL
Content-Type: multipart/mixed; boundary="UODuPuzNMUJK9YubokQNjP2ytd4OK6l8b"

--UODuPuzNMUJK9YubokQNjP2ytd4OK6l8b
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/24 =E4=B8=8A=E5=8D=887:15, Qu Wenruo wrote:
>=20
>=20
> On 2020/3/24 =E4=B8=8A=E5=8D=883:38, David Sterba wrote:
>> On Sat, Mar 21, 2020 at 09:03:03AM +0800, Qu Wenruo wrote:
>>> Commit 91a12c0ddb00 ("btrfs-progs: fix lowmem check's handling of
>>> holes") makes lowmem mode check to skip hole detection after isize.
>>>
>>> However it also skipped the extent end update if the extent ends just=
 at
>>> isize.
>>>
>>> This caused fsck-test/001 to fail with false hole error report.
>>>
>>> Fix it by updating the @end parameter if we have an extent ends at in=
ode
>>> size.
>>>
>>> Fixes: 91a12c0ddb00 ("btrfs-progs: fix lowmem check's handling of hol=
es")
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>> David, please fold the fix into the original patch.
>>
>> Folded, thanks for the fix. The lowmem mode tests still don't pass for=

>> me, have been failing since 5.1. I've now added a make target for it s=
o
>> it's easier to run them without setting up the env variables.
>>
>=20
> Mind to provide the fsck-test-result.txt for me to further investigate
> the problem?

My bad, I didn't catch the problem in the pull request, and my test
environments all failed to catch the problem.

The lack of diversity makes it pretty hard to detect it, as it looks
like all machines tends to zero the unintialized stack structure.

Anyway, the proper fix for that long existing v5.1 bug is here:
https://patchwork.kernel.org/patch/11454395/

And I'll look into the possibility to auto use valgrind in selftests to
avoid similar bug to sneak in.

Thanks,
Qu
>=20
> Thanks,
> Qu
>=20


--UODuPuzNMUJK9YubokQNjP2ytd4OK6l8b--

--mZoqq4VKK8zIMzkDh28hfSKLUamnJ9AGL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl55sbAACgkQwj2R86El
/qh1Igf/Yn2bJjlYTtFjahxR8JAuBBC5VZoJ6J1uz4ytBMUo4Xfa90O5NF7Ae2zy
jtNfFtwtvEuf4b+NzeGV9tY+Hh/9ghtLpSYWqczYvh7wFXiXU2+fNLtMI2c9BVbv
jFYS2LnTl86VHSArjn61fYQLo74T6BjgIrivkX5gRPvFa//Wr9tsLupBeB+ErRBx
sG1gvN1bB9ZaKG8zKxVzTRmqXHXi87kCtOB8//npOYfvl0bA7PE+7hNDiVQE64Y0
0W8HdMcYKTpcouaq5EVTHFBNTe1MMMpCLF8ISWTPFmCWBr07BIIJ0nJg+174CvxL
kTTbSrRHOc5ItdT/bLDtvX2llChWeA==
=KnMi
-----END PGP SIGNATURE-----

--mZoqq4VKK8zIMzkDh28hfSKLUamnJ9AGL--
