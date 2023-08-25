Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2A2787D90
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Aug 2023 04:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240851AbjHYCMs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Aug 2023 22:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236796AbjHYCMb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Aug 2023 22:12:31 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5637A1BDB
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Aug 2023 19:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1692929539; x=1693534339; i=quwenruo.btrfs@gmx.com;
 bh=ka1Qo76QzpUy0sv+j/0t7103FK+dvx9cufM1CXQyiOQ=;
 h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
 b=Z8j/i1YMOXSLJ7sXBrDSV/iaF6QCqytyo8/eQ/96hol3RZA1ijo5qIYdKs+MivgFL1/zeVH
 Ys//OFvqP+2i1AbrEXRepVmrN4sa8IkEGQZZuTp05igY53HYdDREqglu+cT+a2OIzjsi9+Nw+
 oemzw9woz8O+eOM740HjUjBkGPSOG3v9gcJsB5+1PcSrPGe4NdJrsUJZz0dHkksEPIlTgt6pY
 aKp+n5tkdJkBq6/FRuwT+0Pk+mMDT+mKDnx1DoWphYdIS1bmulgdAifIr1psHihOkZrz5ql9F
 JVeqqq0c8jyeus2mb0xGTOOuS80p6nJ3Z0YuR1ALgJBbG5CgOtgA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MN5eX-1qJCVD0R3V-00J2IC; Fri, 25
 Aug 2023 04:12:18 +0200
Message-ID: <32999248-c1e9-4601-9a1e-b236a7fa8638@gmx.com>
Date:   Fri, 25 Aug 2023 10:12:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs blocks root from writing even when there is plenty of
 statfs->f_bfree
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Jeff Layton <jlayton@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <dca245d8861cfa6ba65a4ca4b74ff8adaba9bfc0.camel@kernel.org>
 <c3792425-efcf-40d4-a3fb-e7f8b38dc666@gmx.com>
Content-Language: en-US
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
In-Reply-To: <c3792425-efcf-40d4-a3fb-e7f8b38dc666@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AKv2v45cwTToR3D3QxByVCOKQsv1smujTiY+0XcPyrt83gl7rop
 +RvEnms8I6+XfcA7hPeNBbsey4VSAsSo6XaCZI3LsOgPkTvzC0fypZ8IXoqIsYmX7MlG48p
 5o53hU2X6KRw2gZ5RJo7zBzMUplJrKmR9mfQeV/T8YqEub3g+p+cXyRc8+91K1ZFCbDm+Dx
 zl2QEwlXt4XEOToW5fEuw==
UI-OutboundReport: notjunk:1;M01:P0:Va6wfAgXSf0=;pPyK2eNGd/VM38/UIahfqykxeSF
 kaDBCmJh12ia1PCE6+qMpf31jXjGbM6CILlSXUaRYM5K4hcTzTjE9UXBSX5uqLDKVbuNonynb
 6GGX0MGmpTVKJ/Mx7GESu2bxgMysz5VXYGeEJsZZcMy+u1cDUWSbbrBiWYKYZpGO28ENs+JcS
 JIFP4tB6fEndivzDNfflCJcYHQTvWYBcjgH6lvjp9xpdaqdxH3rs8MPEiozxQixGWP115WQ3A
 vnh0FzvjXq0w5yvNtRRm5qPngqMEmoIPlgzVgYMbTIH50I/0lN5spJ97+E7yBJL37jTEXao+L
 LNqwECfBoEhusGhtCofy4trGvKtinoRfnSIDPaWLaFQDByfqUz8NVBfRKHWHGeGxcyKDfXMUv
 bMiVGlQzJfPkclJZUd54izpUaxTwmaXsxwT3p6i7hN9Ys3NoGwLZaaKUhdNEZupDHYCFSnK17
 gmSkw0eQbTnELXQTN7ZRl4y9ViN4oqzOoop/OhR8YkngFt40JAcsmGjwOl6Ru9qlVW8yO4Y63
 4+ZufrOQl9fuxRKty6MvHZSyNIBeH0FWCw4IyifPCsP6xaVx+kyqhKyQ1CcQItoYouSNFiIVv
 Ql5R4N0k7OJB50VfRPrEtfl7dfFhVbm1OCreZyszMrlh3ui1miujTOcSvueBAhYhqE0qAR2/F
 5rQ3l0MZU7UqvGUAdWIkMrkES50p+M64XxuvR6u+4f340P+4bwZyNW6xM5JKOFdS7SUO6D90H
 oTBCoJy7z/cInqCO0o7B4ADnFRnDn1MEdCQLa5WASpEO5uckiLyr0voz4i0eGlxQp0V8cclzX
 l+qSPcgI9uQpUNmryGe/jHhl4+V2nWcQTOnCU0f+U12Bc/wB3INA94LpM4eNMRtqjr9iPL9Hd
 g/TlZb6sbmoi5lAtljLT3paN/p7XNY9TOv/1j7JCmutGGHTw2CnIIYQGOREXy0i366+8BFfbY
 A/h4SjxW3QN60QX5Va/3DuE+Lg8=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/8/25 09:23, Qu Wenruo wrote:
>
>
> On 2023/8/25 04:33, Jeff Layton wrote:
>> I've been doing some testing with btrfs exported via nfsd and hit this
>> bug. root is unable to write to the filesystem, even though statfs
>> reports that there should be 400k+ blocks available.
>>
>> The reproducer is pretty simple. First I fill up the filesystem as an
>> unprivileged user (let this run until I hit ENOSPC):
>>
>> [vagrant@kdevops-nfs-default btrfs]$ dd if=3D/dev/urandom
>> of=3D/media/btrfs/bigfile bs=3D1M
>>
>> ...and then try to write to a file on the fs as root:
>>
>> [root@kdevops-nfs-default btrfs]# strace -f -e statfs df .
>> statfs(".", {f_type=3DBTRFS_SUPER_MAGIC, f_bsize=3D4096,
>> f_blocks=3D26214400, f_bfree=3D452204, f_bavail=3D0, f_files=3D0, f_ffr=
ee=3D0,
>> f_fsid=3D{val=3D[0xa9d43863, 0xb08b34cc]}, f_namelen=3D255, f_frsize=3D=
4096,
>> f_flags=3DST_VALID|ST_RELATIME}) =3D 0
>
> Note that, unlike XFS/EXT4, btrfs goes strict limits between data and
> metadata.
>
> Metadata space can only be used to store tree blocks, never data.
> And both metadata and data space are allocated dynamically, thus we have
> have problems when the workload is unbalanced.
> (This is a little like the inodes limits on XFS/EXT4, but more dynamic)
>
> In your particular case, the data space is all used up, but metadata
> space still has some free space.
>
> And f_btree returned by btrfs is including the metadata space, as
> although that's inaccurate, it's the best what we can do to report.
>
>
>> Filesystem=C2=A0=C2=A0=C2=A0=C2=A0 1K-blocks=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 Used Available Use% Mounted on
>> /dev/nvme2n1=C2=A0=C2=A0 104857600 103048784=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 0 100% /media/btrfs
>> +++ exited with 0 +++
>> [root@kdevops-nfs-default btrfs]# xfs_io -f -c "pwrite -b 4096 4096
>> 4096" ./file1
>> pwrite: No space left on device
>>
>> This works on ext4 and xfs. The kernel is Linus' master branch as of a
>> couple of days ago:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 6.5.0-rc7-g081b0d4bef5d
>>
>> Let me know if you need more info.
>
> That's why for btrfs we recommend to go "btrfs fi usage" to get a more
> comprehensive understand on the space usage.
>
> In your case, Data usage should be 100%, without any spare ones.

Another thing is, btrfs doesn't have any extra data space reserved for
root user, instead btrfs has extra space reserved for metadata, as
metadata COW will cost extra space, even doing things like unlinking a fil=
e.

Thus this would be a behavior difference here.

Thanks,
Qu
>
> Thanks,
> Qu
