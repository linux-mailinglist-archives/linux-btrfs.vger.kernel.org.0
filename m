Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3877773957B
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jun 2023 04:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjFVCUw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jun 2023 22:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjFVCUv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jun 2023 22:20:51 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343161735
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Jun 2023 19:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1687400443; x=1688005243; i=quwenruo.btrfs@gmx.com;
 bh=jPExh//PN+WnGJg6XB8J2YrBLnPGt2qB2OOM4pobtK8=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=W3NH6vBXCKk2Fmi0hsrK0blR3PMGazBl5rkUGA5Cyac06Z0lVqPwwObcIbuTWj01+WRAUFr
 Nkn/o4iqZetSFssgt9zjT8jpalq1w8xajaIBfw0qzvm3vHtZBZ308ISEb7ID2KGnxzCPrLrcT
 SM+9Mmmvi/bdWy9BnwXKlRp2el566ci0Wi5V/Tcy6eyp/Ef3J062FqbHH85ntGhcLbfiIunUn
 nQ6fBYMC0eJvK2qUZjuBa0afZ1eD1GhYtXvwQ1U7CNdIzIQffSranwrdX+kLB9AiVvt9SA7+g
 4wS13J3GcqfNX6M25mlOeMlO6OpPdEN/XkA9kr4k/jkSklMoXjlg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MbRjt-1pejrP27pZ-00bwRt; Thu, 22
 Jun 2023 04:20:43 +0200
Message-ID: <0b53e722-fdd5-e181-e24a-ca2d3c91b8dc@gmx.com>
Date:   Thu, 22 Jun 2023 10:20:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] btrfs-progs: dump-super: fix read beyond device size
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1687361649.git.anand.jain@oracle.com>
 <f7fed92047412c7e8f89e94c10ec80af564fe9cb.1687361649.git.anand.jain@oracle.com>
 <7783c9f4-021b-c323-2992-56e717276e64@suse.com>
 <57c09714-ece4-ea89-0a20-7390c85957b9@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <57c09714-ece4-ea89-0a20-7390c85957b9@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:d2hiT5AopPUKdNylnAHPrm7POTMYq9KV74fXhWM8g00HCA3Vys/
 4XNUQ4+Eyn50V4q5Ij56Kl5v0HlpokYUJU3SeZejYgbwONLt6EArboA77OlqVUy2a599DDR
 zP4mYAEBk2cbIhFfDct1hY65QBnk/g+AgpPH9gehiOeXbDplSf8e+9xDxGl/CBDXJX/mzw2
 0s2io7BlSP21KOyLx6rLg==
UI-OutboundReport: notjunk:1;M01:P0:WqTOn5Tbzs8=;Uhg4ObpiiKtGY0s+xxjSgOOrg9W
 MuoaFcobDmjpqJ6JhMOmY/QY9Ya+ouNchpiqeB1pIDHYWRSG7MtIvPACmQnPrGc5U913kNdgk
 9YNoTesVnzymAbfMxDytax9MkRCBtEomNNTIPbaPlNC6OP0H/Zu+N+rkpF8nk/OdMywCC2UKc
 +yEKXJtDJ3k7cvB66whDD//Az92gaLbewlCXH7UONgWnTnKWy47tEZ7+rUzqbeF2pci3bVc/p
 fIWbN4CFflE/urj4Ka4sFiR4uThgdlDh/WArXG9yYYu+0Aekccdf8Dt4VO/Oxyohus1hQ8v1l
 7FisJrvVWrvKlEbnfby157bQIwfyWE8Ge8NbW64/uGUQpj8mkgdzl5tAEApNlXj3Agv2SDrP5
 SVBm6sWCo4QX3gNGGRm48D1LnRgiMJlJkkSHVMaeuQ45crABAUIZBmexfsFYreviHEF0Hn+DE
 ow+RLbvQ6A0v2W/u8ZreT/bVht9tdnVsJj1hsATseX2t1pzHKrndBYGSC1lQQvcFeBXoJlhJm
 fuRIxn8JKfe1Tj1IQBaj/Fm+BkoZWwPYnTjGUPKI9JtAlcUD8mrEeY49QXU3odsB2m3f7VPM1
 P/9l3jIkJY7iRY+cd/8ujjgQUx4hUqOiQZKHdaJJ7uLrNpq1FToLuJBhgjU+0yaGbW38ikNYy
 f0OsligwGneslV2PoIZSBlJ46uZkf9D/m2cVRmMgSc2fjoDZEF+QlotBpgUXGGnWFJsimNGd9
 M3mCOyoT5/SXp0zbC8ZpRScygnoKBKdut68rPbBvh/o1M9sFsaNoR7V6oX1lJrUA2CQbGh6gO
 SE7egeP8LPiDhixpRey8lauQDGhW1j/jE1yMgTrgEPzf001wAGhVk0s84hthf8Toj4sfvvviJ
 1fo8yAQdPPkgyLz3RsRR7ISaMWsjBp2jHvsKHmiLaGPEzlz9T+Uy/jPGlzrB8o/NS6gieA0Lc
 wDxvfHeMRHfRMkcqh7arb1WMCvM=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/22 09:29, Anand Jain wrote:
>
>
> On 22/06/2023 09:02, Qu Wenruo wrote:
>>
>>
>> On 2023/6/21 23:41, Anand Jain wrote:
>>> On aarch64 systems with glibc 2.28, several btrfs-progs test cases are
>>> failing because the command 'btrfs inspect dump-super -a <dev>' report=
s
>>> an error when it attempts to read beyond the disk/file-image size.
>>>
>>> =C2=A0=C2=A0 $ btrfs inspect dump-super /dev/vdb12
>>> =C2=A0=C2=A0 <snap>
>>> =C2=A0=C2=A0 ERROR: Failed to read the superblock on /dev/vdb12 at 274=
877906944
>>> =C2=A0=C2=A0 ERROR: Error =3D 'No such file or directory', errno =3D 2
>>>
>>> This is because `pread()` behaves differently on aarch64 and sets
>>> `errno =3D 2` instead of the usual `errno =3D 0`.
>>
>> I don't think that's the proper way to handle certain glibc quirks.
>>
>> Instead we should do extra checks before the read, and reject any read
>> beyond the device size.
>
> I implemented that in a local version, following the kernel's approach.
> However, I didn't send it out because the test case misc-tests/015*
> requires dump-super to work on character devices like /dev/urandom,
> which is an interesting approach I didn't want to disrupt by modifying
> the testcase. Another approach is to check only for regular files and
> block devices, but it's not a generic any device solution.

I think it's completely sane to update that misc/015 test case, so that
we put some garbage into the backup super blocks other than relying on
the support to run super-dump on char devices.

Thanks,
Qu
>
> Thanks, Anand
