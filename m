Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07B47C8DF5
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Oct 2023 21:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjJMTzO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Oct 2023 15:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjJMTzN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Oct 2023 15:55:13 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F2DAD
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Oct 2023 12:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1697226908; x=1697831708; i=quwenruo.btrfs@gmx.com;
 bh=iZW3jcGoWyqKzx++HEt2EWyYYjZOon1lr2nTd5wEZH4=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=R0lO4Frnz1Q/vFjv6FRMKHS3QRzHVMlLSYaKKdKsQNL8H+FChnmX8jdUFq+6XW03oM2WP2ju3/I
 l/sLek9lxNaDHEBmghn5l1ajCfi22+80qAryuYNGMQQ+MBQSsk7f19j3qEbi3MDqIJEfiieot7TVY
 yMUZSPw24WwD8KhyMMb/s+NWX64mno010u6C6AtUd85HKqF4TnrZ7n8IZwmLGwDySj628NjkoYxS6
 wf4x0HfKt8CB5g/4VvktTnOfYnYTPX4F1ncKQSMY/mFxVtzSqIw/hwEK1+aAmGyT9Wb5iv62KpcmL
 MxYFBTKLB66IwCXWL6sv6lVH0SnUsOWWz4wQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([218.215.59.251]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MPog5-1rDkka1Bbv-00Mv9c; Fri, 13
 Oct 2023 21:55:07 +0200
Message-ID: <9be61664-edfa-4771-b9cc-e3333d0fdbe8@gmx.com>
Date:   Sat, 14 Oct 2023 06:25:03 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] btrfs-progs: mkfs/rootdir: copy missing attributes
 for the rootdir inode
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1697057301.git.wqu@suse.com>
 <d33e5e10e92a0c8c2a82005eba1da47927bf286a.1697057301.git.wqu@suse.com>
 <20231013155553.GQ2211@twin.jikos.cz>
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
In-Reply-To: <20231013155553.GQ2211@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Hel/dGj2fonX0gy0WyBfkbNI8zmWv5hTOvLnbpoSpB0us65naNK
 IGqNzzyTkycjlBvQ+uk5Ipj2glozPcx1kjtfCAElNhOSMoWaUox5/zTV+kpahNtAP2az2G+
 XGw63a5/pPFshW5LJ6gBykAb6EvqqdLfUCgmJ//fg6yZy/T1GJuMGNmPL8gh+Fq1/UBli3u
 pVhTtB17DyR0W7H0RFjoQ==
UI-OutboundReport: notjunk:1;M01:P0:Vf2qyxDMg3Q=;F2Lu3sxB01mK9ZYmWvhzeSs9lw9
 6xmXe37eYcnxPIVJoD+GYXweXuplDtXpe+Xg4aOaGX2qC5OEcL1v/GTInPofe/Ss+3laT43zD
 MpVqT7d1Aa1/V4gl+kPPgkH19X7ZUbr73AawJp+SRjGBerjVvwpLN/WaGZeDV3GwxAXtCS6l2
 CFt4pFBja7Zg+Z4nZs1IjYTdOhE3D0+X71/tvvOpDF7HWnjdzfocG8XqzY1uSRFjREceBDKkw
 NS51l/A+gCyonSlrLWy0nGgWYztsBJ/MLhgMl8fUwe8wgGjEzYkXz20cPdOeElucmcC3qb6tV
 J7m+Ycs4yYG9+ZWS3FuQl3ipiqRcT47iVQaM3xyziqErDRWFzvapFgc8qcWWpFX20emelglLp
 poXCo4N+S19Zdwomf6C1aKDmVdGElg1t2+5cabDxZBb5VDGR9aBGZl2G14fKLvGSuIQ/R+MLX
 69c9dj3rqUmjU8z3YHQM0G4xb1nx5wlpc05OgzZP2eDk7NZgvsEqQQPho2FEMZPW3ekmq1iWE
 u1UFYwHf9Dp8SiXnmzgqZFjJjApT/fP+wDR/fpD+jZWq9jkGKwsM5UwSCno1bHurup+0SwEVM
 UAk8g3gOcqcpuWCaugRNQxNaI8tqcgOpumdK9VrrWzUr+CoRBS+oe6t3f1aUeSrtIOFfqMwhI
 GggdHt4I25MWNsTETgeKHDBgVdaazkA4i4SSZ6VPmvqD0d52cv1toVR82+mLZjA2C+ZL7OdDU
 Nlz1LBEasJ/5I1TJ9fCQKZZEzLKC76jeiwyKTTkw2kvg2jlGG2qQlu4k0BnBEDayGoLWaMnsQ
 cuKOkEpYQp+O14GJ+mBn8vWSSX09v8spShTcoYtFZGws+9GLOkAzqysFIuIK/KLtgqv/CVFoK
 qf3BhTFbzhzSgXWXDM3KbnQdq++iD0ApbKiJfX1LT8g5gNC/9oVCxzeZxBPYvMh+CCskQ3y6m
 U3tIkqb6cV1ruGhtgeE1WfBdUC4=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/10/14 02:25, David Sterba wrote:
> On Thu, Oct 12, 2023 at 07:19:25AM +1030, Qu Wenruo wrote:
>> [BUG]
>> When using "mkfs.btrfs" with "--rootdir" option, the top level inode
>> (rootdir) will not get the same xattr from the source dir:
>>
>>    mkdir -p source_dir/
>>    touch source_dir/file
>>    setfattr -n user.rootdir_xattr source_dir/
>>    setfattr -n user.regular_xattr source_dir/file
>>    mkfs.btrfs -f --rootdir source_dir $dev
>>    mount $dev $mnt
>>    getfattr $mnt
>>    # Nothing <<<
>>    getfattr $mnt/file
>>    # file: $mnt/file
>>    user.regular_xattr <<<
>>
>> [CAUSE]
>> In function traverse_directory(), we only call add_xattr_item() for all
>> the child inodes, not really for the rootdir inode itself, leading to
>> the missing xattr items.
>>
>> Not only xattr, in fact we also miss the uid/gid/timestamps/mode for th=
e
>> rootdir inode.
>>
>> [FIX]
>> Extract a dedicated function, copy_rootdir_inode(), to handle every
>> needed attributes for the rootdir inode, including:
>>
>> - xattr
>> - uid
>> - gid
>> - mode
>> - timestamps
>>
>> Issue: #688
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   mkfs/rootdir.c | 88 ++++++++++++++++++++++++++++++++++++++-----------=
-
>>   1 file changed, 67 insertions(+), 21 deletions(-)
>>
>> diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
>> index a413a31eb2d6..24e26cdf50e0 100644
>> --- a/mkfs/rootdir.c
>> +++ b/mkfs/rootdir.c
>> @@ -429,6 +429,69 @@ end:
>>   	return ret;
>>   }
>>
>> +static int copy_rootdir_inode(struct btrfs_trans_handle *trans,
>> +			      struct btrfs_root *root, const char *dir_name)
>> +{
>> +	u64 root_dir_inode_size;
>> +	struct btrfs_inode_item *inode_item;
>> +	struct btrfs_path path =3D { 0 };
>> +	struct btrfs_key key;
>> +	struct extent_buffer *leaf;
>> +	struct stat st;
>> +	int ret;
>> +
>> +	ret =3D stat(dir_name, &st);
>
> According to the v3 changelog this should be lstat(), right?

It should be stat(), not lstat() of v2.

The reason is, the end user may pass a softlink pointing to a directory.
In that case, lstat() would not follow the softlink.

>
>> +	if (ret < 0) {
>> +		ret =3D -errno;
>> +		error("lstat failed for direcotry %s: $m", dir_name);
>                         ^^^^^
>
> like here.

I'll update it along with other fixes to address the comments.

Thanks,
Qu
>
>> +		return ret;
>> +	}
