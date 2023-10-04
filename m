Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78EC37B76DD
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Oct 2023 05:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjJDD2O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Oct 2023 23:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjJDD2N (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Oct 2023 23:28:13 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC89A7
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Oct 2023 20:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1696390085; x=1696994885; i=quwenruo.btrfs@gmx.com;
 bh=DtT9zyrZUuVMQcen1udGE6zSr84hjIf6NXf2EmeJ8IQ=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=bik0QK1keOghUMm0gIJjJvjX8LIiUsa/f0kEfjP+mM2oQxbGJt/KtHYFY3fps3f9KLlE4J2I33N
 DYMOeTPX8o1M9+n8EKHV2z32FYir+h0f/+C1XxkYpu+aFDjGX456HLidErk8qkXYexgcF3px3drU+
 I9TNxG38gNZHsOqVd0zeNNDW4nmAhNlazW9bwxPc7EBz3tSBgQPCtjOMrVMJ5mIJEd1ybPiK0Jlnp
 aiwYEV1o14V3y5yinoLKxUrkruHHbxgTDQfE7Z9IJwf5vYwloIDsVTRXHZpcRYr9lJxD4IiRDn0Ep
 Dx6IqTetb0WU1ma86c69KjVMJZ8zHpfONmQQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([218.215.59.251]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N1wq3-1rlMs91I2j-012FXq; Wed, 04
 Oct 2023 05:28:04 +0200
Message-ID: <3b73ff33-34f9-4a98-a73b-19d91f845343@gmx.com>
Date:   Wed, 4 Oct 2023 13:57:55 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Filesystem corruption after convert-to-block-group-tree
To:     Alexander Duscheleit <alexander.duscheleit@sweevo.net>,
        linux-btrfs@vger.kernel.org
References: <49144585162c9dc5a403c442154ecf54f5446aca@sweevo.net>
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
In-Reply-To: <49144585162c9dc5a403c442154ecf54f5446aca@sweevo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:H2AZsAydrOa5X4jooj79BwBGhhFZ/ho8vDCyUtSyKaYPbsQ/GT0
 Kj5FsRrVDx6Htnx+eyKa8e4VzVUkSnLbRqOhWEh+M9IquiJtaAfj0Dk6a1rUZh2ZUp9+kYg
 maWgvutSCraNu6L+fIVbBBsCCIITJR7JKE1luCP5/FMxedrZFN/hz1SrZZcXd9Cd3AVW2Ba
 GIm0A6PqLIcKYGEKv3qdQ==
UI-OutboundReport: notjunk:1;M01:P0:2lSWjABLOog=;1ygbOpr3BrFneguVbAoWF99PEhc
 xe/ZgoYg9OZ/tevVGYuwJ+eS2KckmO3YgPbrFb/f599H9GVJg/dRQdwooBBLwjYFyL/97r2H0
 GCGFhvIDN1fo7dz3uMjwBHUC9OO8+8eB21OH9hKmv3AgivNEr9dZq9itNEe++PO5QMq9lzZPR
 IIazwCOkFjLPRwFiH3zqsbuC6JLMcaTFbIM8Jb8PbbI7vl2uQ68lJ96/OUhi/FYgFPImBqeuz
 Hrd9JekfT11Rn4wRPPItTIzn3JKVehGeljtEs+/1FjKd/YaNJVLm2ykwdyCm8ue+xxWceBRpf
 s9+dHBM4u6DJedTo+eFoH1eD76YLp5T/Rd1CxXi1lJKXGjlD8rUzKbDC7RGNuqmO/GYn8blZp
 2aqVZxyytoiUHFtZ04MxYR+pj91e3WojosnFdIe9FiHddcLDjluMd7MjMxKCnlpkJQrV+m4aF
 S5qT5Kty5RTfWrBLm1joYLSIeIzzrBo/95Wcup2wj620riCecXZdPSbLXqNIlRoyuA/bAc+S7
 EuS/r0n4TIJRFtkoPWkkiDAnc4LajHZTqdwyvSc2IYUWQKDr29HNSqCUSAK+5IiQXw6F6a0JE
 PSc73oyunRmIC6hrHKz43nNXRhqqjXivD+C+vlUCI6WSK9Qs917Sg/+3k2w9TcGgF+ivnsHsQ
 UEl7ib/859q+tCsW9osAvdYIHwD3bY3yL2FlTrT4Bm2T0Y5uquYErH54u6J63s/E3ePaHeZbw
 T2pJtw9X5tDKvmEL/wATrjJ7Z0u65uTz7HDGzY3m4dy1By1jO79WcxIOdm3vkv9Ys3Zig30R0
 CBCw1EDEnbVUgqMkf0Y2/bEH2pOletgHX7AdElZfYYwJ9/Te/TNCcFpQRsoD5a00Nz4C7FWRT
 JGnXSeRzfQ/tygi9WjO0EQ8hQhOTiUJFqFyoQRwr/ZFANCbOSeneOmM0k09ckXRUaJnO/fnXL
 W2ByhShmgRxtWe9qWfbyMG3nYpw=
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/10/4 09:47, Alexander Duscheleit wrote:
> Hi all,
> earlier today I tried to convert my BTRFS filesystem to block-group-tree=
 and the operation seemed successful at first glance.
> (I unmounted, converted and mounted the fs without any error.)
> Some time later I tried to access a file and got an I/O error.

The error from the dmesg shows a level mismatch in block group tree.

However the block group tree itself is always fully read at each mount,
thus it means at your first mount, the block group tree is good, or you
can not even mount the fs (unless go with -o rescue=3Dall).

So I'm afraid the corruption is not caused by the conversion, but
something else, after your initial mount.

I'm more interested in what happened between the initial mount and "some
time later".

>
> after some updates, reboots and troubleshooting I ended up in the follow=
ing situation:
>
> The fs cannot be mounted normally, but it mounts (consistently) with
> -o rescue=3Dall,ro (see attached dmesg.log).
>
> No data _appears_ to be missing or corrupt.
>
> btrfs-find-root throws many errors concerning corrupt leaf blocks but do=
es find the curren tree root. (Again, see attached log.)
>
> Is there any way to bring this fs back to a useable state without starti=
ng over from scratch?

It looks like block group tree is corrupted, but without a full "btrfs
check --read-only" it's hard to say.

Extra dump on the bg tree can also help (needs both stderr and stdout):

# btrfs ins dump-tree -t 11 <device>

# btrfs ins dump-tree -b 7868411314176 <device>

BTW, btrfs-find-root is not that useful, thus it should only be adviced
by developers, but at least it does no harm.

Thanks,
Qu
>
>
> System Data:
> # uname -a
> Linux hera 6.5.5-arch1-1 #1 SMP PREEMPT_DYNAMIC Sat, 23 Sep 2023 22:55:1=
3 +0000 x86_64 GNU/Linux
>
> # btrfs --version
> btrfs-progs v6.5.1
>
> (Note: The conversion to block group tree was done with btrfs-progs 6.3.=
3 and Kernel 6.4.12.arch1-1)
>
> # btrfs fi show
> Label: 'hera-storage'  uuid: a71011f9-d79c-40e8-85fb-60b6f2af0637
> 	Total devices 4 FS bytes used 8.36TiB
> 	devid    1 size 4.55TiB used 4.19TiB path /dev/sdb1
> 	devid    2 size 4.55TiB used 4.19TiB path /dev/sdd1
> 	devid    3 size 4.55TiB used 4.19TiB path /dev/sdc1
> 	devid    4 size 4.55TiB used 4.19TiB path /dev/sde1
>
> # btrfs fi df /mnt/btrfs_storage
> Data, RAID10: total=3D8.34TiB, used=3D8.34TiB
> System, RAID1C4: total=3D8.00MiB, used=3D912.00KiB
> Metadata, RAID1C4: total=3D24.00GiB, used=3D23.93GiB
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
