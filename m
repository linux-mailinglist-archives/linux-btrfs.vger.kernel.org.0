Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5F820676C
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jun 2020 00:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388123AbgFWWoe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Jun 2020 18:44:34 -0400
Received: from mout.gmx.net ([212.227.15.15]:44141 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387815AbgFWWod (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Jun 2020 18:44:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592952271;
        bh=/AvxE6xdV2XfNhueO/ge/R/llsuuHxRxV39s5uTNX8I=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=AvP907VL8BgAukPkCVo9UAwLN4FFr+KCpcz9V/biPv7NJq0kHyOqt+XoeDVxbQzrp
         2S52Nnk0S3umtf9QMaz3woIT/qeq7M0OcVJJcYemgQuwuz6QUsFixAFVqiIuX+8KKR
         /5/QZ/mwciD6ZW3UNrXDd5D9XJ3Jhux0XS8Y+biI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MY68d-1jMlXn0hJt-00YVXg; Wed, 24
 Jun 2020 00:39:18 +0200
Subject: Re: [PATCH v4 3/3] btrfs: refactor btrfs_check_can_nocow() into two
 variants
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20200623052112.198682-1-wqu@suse.com>
 <20200623052112.198682-4-wqu@suse.com>
 <ed6eedb1-26e9-c209-900f-069322a02503@oracle.com>
 <SN4PR0401MB3598CC48A53558D70DCB3DFC9B940@SN4PR0401MB3598.namprd04.prod.outlook.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
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
 ABEBAAGJATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAK
 CRDCPZHzoSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gy
 fmtBnUaifnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsS
 oCEEynby72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAk
 ZkA523JGap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gG
 UO/iD/T5oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <4a37f008-31af-17db-6cee-f5d67820e0c0@gmx.com>
Date:   Wed, 24 Jun 2020 06:39:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <SN4PR0401MB3598CC48A53558D70DCB3DFC9B940@SN4PR0401MB3598.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sOnfHYkiI61Y4SzwICQnAVr8wkdylUFDEJxv7GLkTRZ9j+tWHAZ
 n11IcL0mgVDNPskS0kc6qyR1N8jzom7ZdAvTZGOJ/LKqD+Sloox1pUpH3Z+70N5XJsHv0WO
 4Vh88MLEDUMl+ktFQp0kI745G9CQsNQngIIUlFuPga4zG4JCxxSWp425bdMor9QQrIQ0R5q
 ZWJtpjC+3REzhuy+SPNJA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:HONQAaxh4SA=:zKnglhC67rqN9nchzaVJ76
 GtoM152746mQgVSrVdw7Gno8e8IF6OpGWSa3Zyl2BZDi+jmAj4sq6QIuCTgt0507u/ogjWdEG
 +H/GInrjQkkyAva0vjMph6Xzoygfi3fi28OPOY+rn94oSR8ljsyX2DJ6bV1VaeLUXzclK/+lJ
 cZ7QmZK1J3aFaF9o1QeRb0g3qEOGOdaDdLyBp2mi2v4RP/PdzQM0rYH8kCIJ0vTwqcPwfpPPS
 9N0AC0SDPyXS2OqspSPYrWps2z0QzK2/HmdnikT1CdwlG4yUYGJ3tOSJ3VCJtI8jOippqerEO
 fZTr2jc6on8EAUwfqFQ02+fBB+qBdzsVlXaq7sL44r4cZcZxKxhL0StbNciEbT9dnEH4lksM/
 DshSbguGR9SQFlHQTFMw58T+Fx+ERJwsyQdKPqN2PiAas+Uxd6y9Z7HELVPdgXhjKQdHQ5zGR
 qeURj9d8OlKrNJuYGNYRAQEAKpzP55VwDn+DVmGsgQlwI5EjJVDyMQ5hTRW9jgIAYyN0KCCvs
 UDm9vphX32hknEmRhKWJbwk8sUlPB/Jj6OjhlBNP1rFqDdYGDYSs2VbeTfnyLUM/7ozfxLpVg
 39cDDw0+rZQnuKYnrgl8esm5s25fAaNDHtIrFYsIIsZu2HljmrZ6P+UHqBu3WWjRrFCb4LfN/
 cONm4nq3W0Fp2OrPLH5iDYPhLBnwapnc0XIYqQ/6HgvftmtrdJ8ckISgbQlA+n+rNh+YLIs2F
 KnW4jgSiGtRSVlCMw9880CFF4XcXPLayNODCubcV0sRymXQpqQMAeziHIdc7q0FqBKcXe03UF
 ftGlBd3tMkSLOR7pqoMuvznRAvuXXJcwFyz8b0HHl09Gi+SsPmJYGEGtlRQ0vb80I3KKRxGdO
 hA8Z28BiXno5z3mHsozgnxuXRKTlvDbtRcGbJRLmRZl/LMYjbTnk9QD4lUJmR0m1W9zUPFfHd
 nr1YadkYZg3a13YEmXiEkszRm2puS2KaiTXU4kjluGy+F5381WLwE+Iyyk1Cc0rs1bLWw+cPz
 jQb9QtQHq17AaYny2Aln1qRO7btM5mjCITbnY/qMFgcIOzcMXckw9MW6IaF14x5OXPWOYpw6X
 Bc+IyR+rcN32MEaa6qlEtUmLShH2ZmpnN8L10QxUHSLyZuZHO3NeIYG4MwazdEbw0slAqCher
 HDTn3Z/Sm/TBdG3YNpxE9YLcaxbelV+lM3yRQXkl9q04yPJM+rz7GeuaAHh7IdMTz40yhiTVk
 mfPqZmsfpqJiGW8OW
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/6/23 =E4=B8=8B=E5=8D=8811:03, Johannes Thumshirn wrote:
> On 23/06/2020 16:58, Anand Jain wrote:
>>
>>
>>
>>> +static int check_nocow_nolock(struct btrfs_inode *inode, loff_t pos,
>>> +			      size_t *write_bytes)
>>> +{
>>> +	return check_can_nocow(inode, pos, write_bytes, false);
>>> +}
>>
>>
>>> +int btrfs_check_nocow_lock(struct btrfs_inode *inode, loff_t pos,
>>> +			   size_t *write_bytes)
>>> +{
>>> +	return check_can_nocow(inode, pos, write_bytes, false);
>>> +}
>>
>>
>>   Both functions are same.  Something obviously not ok.
>
> Oh right, how could I have missed that. The _lock will need 'true'
> for the 3rd parameter.
>

Holly sh*t, how could the test passed without extra failures.

Definitely the most embarrassing bug...

Thanks for pointing it out,
Qu
