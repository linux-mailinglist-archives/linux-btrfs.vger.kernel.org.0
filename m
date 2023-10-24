Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943827D5C8A
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Oct 2023 22:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343896AbjJXUhG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Oct 2023 16:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234576AbjJXUhF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Oct 2023 16:37:05 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F78EA
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Oct 2023 13:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
        s=s31663417; t=1698179819; x=1698784619; i=quwenruo.btrfs@gmx.com;
        bh=Y0BsvOG5MQu0x3Eee3v75d2G3ghDuNeE67kPJzSVa0c=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=KBNMnMLY15+W4LzH0OkKyBwwXW6B5Ev/x/pHjZnITdpG7VPcsWYWfo402AcOSxza
         pM/Rt32wrrT8dxd56qJk5P3JhgDHA4YiYOjCQt5v+zuGvW6YaEegLFrSm11jKekbv
         ca4VZ0UZppmCFLBm990e8Xl5yhz43E2pOEGPH8GpG8HhanHOaqonDMSpJVoxqmhOz
         A/bQC6tVF6PAYpVXnThsiIBM+9trcTyFPBnG0MVwknCVVh69+Q7Ng1j8yUUIIjwJW
         3oGRlbDXY+F/7329gjpkrly/qv+6f96A5FXR8W0Sqn3yNjDxgaCi65oD/a8JDgAJe
         djQKg/ZdYsKKcmyv5Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.10.18] ([218.215.59.251]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MiJV6-1rRzbw37VG-00fP6I; Tue, 24
 Oct 2023 22:36:59 +0200
Message-ID: <c78a3cb4-5a0c-442e-b712-a2f9294c0cb5@gmx.com>
Date:   Wed, 25 Oct 2023 07:06:53 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: tree-checker: add type and sequence check for
 inline backrefs
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <23fbab97bd9dbce7869e858cb59d96a7238db57e.1698105469.git.wqu@suse.com>
 <20231024134827.GA2811083@perftesting>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
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
In-Reply-To: <20231024134827.GA2811083@perftesting>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:U1hTTM5EhSwOpIcqKTSQbf9rk0iPxUC6jjHaoutHqfGQ7MJJ3sF
 yEmILoyKkLShoeVCeYCxEyFwiNyByC8n0B4NIpnAN8VAMMF8nyOsgtq5rPXaahvxnQmYUXI
 qa52qpFH7+iaoB4Ly4O8z/ImIYj2X8gxSWEoK7xH6Yqs7dvYgz1UJbgpCKH8AWLBG3wz0O7
 KzyPNUJXn/JZyPYsmM7Wg==
UI-OutboundReport: notjunk:1;M01:P0:QWg3Ugl1ttc=;rRscFD0E7QvffMN69A9V4ffqz73
 dW2oyK4QOfyh/DYBzxG2Lv+i3CVOKYn7QKHrQYQvAJ5a/V+VEFs6P3dN34lodX0wIxvdrMw0i
 IJ42XaZnSSPE2vDQ6uz6zMFGW2Fb+qYoIfiqAEXRydjtBRsKjczS8BcomuT9yVrv5Z1YDj2jH
 JdBiDd54/POGAsYDu/rLRvVX65fjvhqU9vIJCTpHK7c9hzrUp4CzGuQSpfcqF2Rr3YEgFY+PI
 kr2AKB5i4Uo9ST+QflnusD+5tVmVsKHZ7L59aiylwBBEiRpHphK01Ct7/gYzGhXCEmgAK37v7
 O+esxBLtq4BioC/aj8F3j66u7zZcUb/c60k/tiin6vC417fQzhkuiP6KFU8EDEdlthwQjNxau
 +6hYG0ciMEJ1Dx3cCx5R/PSB0znexQK/y79M1vMPEYCngoTT2T4GDGzyVXRfqUrbLFnUPwMkj
 /6P4RyxUL/rhpn5RZAV7PTLugbAd0MlfRBX/IFBkh6R2tk6U53GrM6G59lkPch93HmM+pPgjw
 aojlDiVKbPKTlMfhz0HQbwFRrOB0wGQIMNNiBDugtdgoc3+3NfL8y427ZO79M0LCvbqlXIO3D
 iYBh28qOHJVWF0tUwke0R1DsmnExCANdEU3hxXZyWV/VCOLotH8Ma8dcNV7OmCL5KmYH9x3Oc
 TcwwaA/ex7FiKHCCX7O1BTsnnqevj996+KegV6853a0cd9gDSn9FsHDWH7EnKnPm6r1WnudtT
 rK6VAulLYf1357M+4urUjd8C8ADYsEdYmulw1cuKGNHEffx8XpOJ6qGomtl/GJPiOcqOFj+6d
 R7dx34QmiiE77uXzlYTJXBtBAW3aNN4vU86or7JIHZXkUK3rZ5uKPj9CBARKY5qGFZhAnU1L0
 jX0ogNmUGqNGXEl/1g5Z7murDiS4nvMH7zJCfjAD1nsQdtWdkbcGTmof2AqxJxyGPF7RCzCbY
 iDm0EUvcP23Hzgd5TmwMGl8Mpns=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/10/25 00:18, Josef Bacik wrote:
> On Tue, Oct 24, 2023 at 12:41:11PM +1030, Qu Wenruo wrote:
>> [BUG]
>> There is a bug report that ntfs2btrfs had a bug that it can lead to
>> transaction abort and the filesystem flips to read-only.
>>
>> [CAUSE]
>> For inline backref items, kernel has a strict requirement for their
>> ordered, they must follow the following rules:
>>
>> - All btrfs_extent_inline_ref::type should be in an ascending order
>>
>> - Within the same type, the items should follow a descending order by
>>    their sequence number
>>
>>    For EXTENT_DATA_REF type, the sequence number is result from
>>    hash_extent_data_ref().
>>    For other types, their sequence numbers are
>>    btrfs_extent_inline_ref::offset.
>>
>> Thus if there is any code not following above rules, the resulted
>> inline backrefs can prevent the kernel to locate the needed inline
>> backref and lead to transaction abort.
>>
>> [FIX]
>> Ntrfs2btrfs has already fixed the problem, and btrfs-progs has added th=
e
>> ability to detect such problems.
>>
>> For kernel, let's be more noisy and be more specific about the order, s=
o
>> that the next time kernel hits such problem we would reject it in the
>> first place, without leading to transaction abort.
>>
>> Link: https://github.com/kdave/btrfs-progs/pull/622
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
>
> Does fsck catch this?  If not can you update it so it does?  Thanks,

Fsck is already catching that, and a progs selftest image is also added.

Thanks,
Qu

>
> Josef
