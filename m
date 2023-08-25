Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDB2787D15
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Aug 2023 03:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjHYBYH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Aug 2023 21:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbjHYBXo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Aug 2023 21:23:44 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9E419B4
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Aug 2023 18:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1692926615; x=1693531415; i=quwenruo.btrfs@gmx.com;
 bh=aZmSwr3B59Q2FvdDFn+1cCLMpGZSJKrEzyFuIWrDjHc=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=Dqwpn3hI10PJfSUEtT+amRKjV/hZdAdEyJ/Mq3bQ+g2qLxiavAfBNhWcqIRarltyrYpBwJP
 C5BB3+Lmjbf27Fu6q51gQSSFqE4Wp2RWuqcfJ9xkYS9TJoWOOtKl+71CuF4lcnOUGNS042/Rq
 73kjfrIvawiFDl0M6enS88JFP3h3UD1EuFqSdbusHN9uWI32ywfyixgfLdELWLvNE9DG79qmV
 UVpGS0J3+vJdMhx3H9FHYJO2/g7N/yrz9Grr+rxbl6ZcwBpNpnS4lp5BAZr7LT5shf7aZ+KZQ
 gBhdaqpMjrJPFIdGTRzWkpCNPvPI6+6EHzL0YmGYfKZWTTzFi45g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Ma24y-1qEZZi1IHM-00VuPl; Fri, 25
 Aug 2023 03:23:34 +0200
Message-ID: <c3792425-efcf-40d4-a3fb-e7f8b38dc666@gmx.com>
Date:   Fri, 25 Aug 2023 09:23:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs blocks root from writing even when there is plenty of
 statfs->f_bfree
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <dca245d8861cfa6ba65a4ca4b74ff8adaba9bfc0.camel@kernel.org>
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
In-Reply-To: <dca245d8861cfa6ba65a4ca4b74ff8adaba9bfc0.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UIEDIlUDeXIvvWuEPKziH+F9PJnJqpH8AfusW4NbvmjEuPIZbf1
 1Zi+R0udeRIHi/I6DY2v4eRWiXDlvUVJsuvdj3E9wADI3AzBskq+kzKOYR+3KcxDvm5rSDW
 9e1QZOwzTP3qbVCMbOWNPFBKROb4/rm7y98VaYyPNlO00/AedLd43dPSEP4tZYjzW1H9qLO
 0HYhrJvgHc7OdJUH3mNtg==
UI-OutboundReport: notjunk:1;M01:P0:/9Zl/gLF9wA=;TwkeUOjqugKs1KxnITHinR20Anf
 Tw1qTNtjEfJio1DdD9qgmuSMaUb+3UssX1olADCF9DNDOW6sxRLgJq7DtCXhPE6f2d2b6F/oh
 IhIJVJRJd9RsZbPMtsc42PKgXC0BvILOmPWfhHd9sq/2WUuF6vk65V09isr78wKwAQG404pdO
 +simiDxE5L22ErOjOxs4fmQe0b7jqK1jZ8zIjD1nj0g2r93pgGOcDcEuMuFfghe4TwE+YB8UG
 8KyDAlAx5MAUsqYDILzCgYiUI9QZfuF3WEuKhAzbTRMuBL/pD541fIUtEa14VkM/fPaR5rRNb
 P+fVHoMMXvJh/pvUQO+LSoHmM/zgJxFzFpkAr54EKPcOxAW1x3gkgs61TpQdCftTgh7D0sIut
 PRlsKtuT2W2oWdT7BdaR8q0LhTlo1h/YJzR1RNzSZqpCoW/U3L+PQlt1oiwbNECcm845YOfEz
 KZkW28jjf9A63vrhVVWg0dbJ8BbE1D52X09fHz5ScMBTj1Bj6df+jJfozJIyZcfFUs8/xHkPM
 kS9tthZZWgWgFf6b4bM7J/OQA/MQsax3wjvtDGnf4yoVVYqwk5NNn2/KwgWju9WIgQ43YS+tk
 1GstETWda3zEzwAJOjCHdwLovUdVE1nonGTnDqWPRrlRbMWNDWdu4xmXPTwk624FDF7GN2LWu
 +JhbipBzHB2OYzb9VMhMwxlAcnv0mOFCabCNwTd/EqXbUSAvd3nFMJW+u+pjq0qRLk0mxYHjZ
 XaSHxpCHUbuo+BFEpHQK+SZRAsaF88osTkj5wPVH33bdIDtPvX2IlBIuhjq5J2S3I6XXH3fOx
 eU7EyrVcU3ApL2r6LOZJYJ1zGuhbG6x2Snz5kD9OuutQ3ZZ5pHS+1PdfyxDvqPz97WQE12QpI
 R6YCDQWNvjtfostx96sv48MuhSXPAIgvvFvaiyjDBPO/tgZg5eQuJ5byA/qpcjm1pskl5oEk8
 ktEeJzqQbLqifsDgZsjECr8Seag=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/8/25 04:33, Jeff Layton wrote:
> I've been doing some testing with btrfs exported via nfsd and hit this
> bug. root is unable to write to the filesystem, even though statfs
> reports that there should be 400k+ blocks available.
>
> The reproducer is pretty simple. First I fill up the filesystem as an
> unprivileged user (let this run until I hit ENOSPC):
>
> [vagrant@kdevops-nfs-default btrfs]$ dd if=3D/dev/urandom of=3D/media/bt=
rfs/bigfile bs=3D1M
>
> ...and then try to write to a file on the fs as root:
>
> [root@kdevops-nfs-default btrfs]# strace -f -e statfs df .
> statfs(".", {f_type=3DBTRFS_SUPER_MAGIC, f_bsize=3D4096, f_blocks=3D2621=
4400, f_bfree=3D452204, f_bavail=3D0, f_files=3D0, f_ffree=3D0, f_fsid=3D{=
val=3D[0xa9d43863, 0xb08b34cc]}, f_namelen=3D255, f_frsize=3D4096, f_flags=
=3DST_VALID|ST_RELATIME}) =3D 0

Note that, unlike XFS/EXT4, btrfs goes strict limits between data and
metadata.

Metadata space can only be used to store tree blocks, never data.
And both metadata and data space are allocated dynamically, thus we have
have problems when the workload is unbalanced.
(This is a little like the inodes limits on XFS/EXT4, but more dynamic)

In your particular case, the data space is all used up, but metadata
space still has some free space.

And f_btree returned by btrfs is including the metadata space, as
although that's inaccurate, it's the best what we can do to report.


> Filesystem     1K-blocks      Used Available Use% Mounted on
> /dev/nvme2n1   104857600 103048784         0 100% /media/btrfs
> +++ exited with 0 +++
> [root@kdevops-nfs-default btrfs]# xfs_io -f -c "pwrite -b 4096 4096 4096=
" ./file1
> pwrite: No space left on device
>
> This works on ext4 and xfs. The kernel is Linus' master branch as of a
> couple of days ago:
>
>      6.5.0-rc7-g081b0d4bef5d
>
> Let me know if you need more info.

That's why for btrfs we recommend to go "btrfs fi usage" to get a more
comprehensive understand on the space usage.

In your case, Data usage should be 100%, without any spare ones.

Thanks,
Qu
