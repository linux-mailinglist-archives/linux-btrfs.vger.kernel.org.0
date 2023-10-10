Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DDF7BF256
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Oct 2023 07:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377940AbjJJFlz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Oct 2023 01:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377040AbjJJFly (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Oct 2023 01:41:54 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0769A9
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Oct 2023 22:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1696916506; x=1697521306; i=quwenruo.btrfs@gmx.com;
 bh=5VjtS6hdoQwc/mYeKYyxZrm5Dk0D4pl7exH7BkI0UtM=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=MRvfBQ1wo3uOwXQsPxpN5ugbT9TPGgLnZf2QveFu2FeG44/GZYpwT941U6iEK+KJ7qi8Efs5JNk
 PFdol6rwABwAfeM6aO57YMgWb612AqYuBumRK4xOmuGHebIANGADq88T9I7VX5h6l2QlFreelEsh1
 Mf5zR9/XcvZgJ8p6lTlUZE62SDRAngSohTug0qdE3B5bzCxVSlZhyUWFF19TYWQ97qBJBa5PFP7/P
 RGas27WCsM/S5rbUVh1TYiueAemKF1bTE5kTdHYamfV5fBLLCxRm5GhORrEMgqptEyUPyBvgR8B9P
 +PPJVju6v2b0CGi187NqIHinXtgYchjUax2A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([218.215.59.251]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MIwz4-1rANXP1S3e-00KOyU; Tue, 10
 Oct 2023 07:41:45 +0200
Message-ID: <f3ac7b74-c011-4d1f-a510-677679fc9743@gmx.com>
Date:   Tue, 10 Oct 2023 16:11:41 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] btrfs mount failure with SELinux context option on
 kernel v6.6-rc5
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.cz>
Cc:     Qu Wenruo <wqu@suse.com>
References: <yq5o7y5cptazpevhohy5e2ddfjdzsi35pbpijjnzjzejtx233p@phog4jcu4mtr>
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
In-Reply-To: <yq5o7y5cptazpevhohy5e2ddfjdzsi35pbpijjnzjzejtx233p@phog4jcu4mtr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ANzwFjscU1fZt8vV4pt/V18Xfqy9gYIYI4cIUFfHA/yrIhWNfpB
 5/YmuzXGXQWASjwkUiaCMXLMd5UOoFr3M9ORZBDAuKhRKYnIlYBc8J7iYGSE2ntWFmDpGv5
 Wv68dBATlOxmO7ygORy0rNbg1p3uN3hTQPGbpm3PYUvM9a5c071VN8YWet4D5Bt7zqcVWbU
 fNExqNV62oKil/fxKAVlA==
UI-OutboundReport: notjunk:1;M01:P0:1MasyyCEZjc=;b8GGmtFiCEIyLiTXoeHlB8giIqM
 nJcmKJUjlgY6EqmGGZADaHBi4aoGB0SIpaBUAhWbbeHJKl5WM0Fr+j0ZwxHgDRDAGtC/c1jU9
 woKTy/3L+v89mFgdA31kEJB1z57Kj+gVuHtnR5cZHXRdPBDJPntunY6K2B9M58fKQ+11bACyJ
 CJWFoHOIjPrPpjdxccjxFdkEZOyjhXEYQTiSaMvnsIeXuS5Ds25P9EiNQNTZwcoEetPMdjmuS
 oWrYQMQtQsAndM3p5850P8+HsWJ7+bHI4aXCag+t6tj7pTgpqQWUTIOcGXE3WHmoBHU/+PVX7
 UGu+rQd2PSPIKKpEt6yEGL/aYE39WWIQxca7hv0XMkmVn5h4R3VPpFrV/etR1Sszhs3rF2Pdm
 8P1DAnkRev4BkLc5U+wkqWODe3fBvIWGripFosLjajsWtLtWHOXtm2URAyew4HtQdOlVG9bHV
 4YcoDCaAaBTpiUDGWYUTi9vEWavjuagR0p5DNK99NJ9FKQWNva/NOrp/a6FOYDcTKyLOudlpe
 oUPAUrWe0YdXmisr7yM9CKlipiAorJ4fE/6JR0So9aZ+cmYWgq+XtJY6H/e65T2xreFNBA+Fu
 wD4O0NDhb1m6wNme5Mh994vR+wMmfJG9o7P2egyBk7kS75gy21NrKn2dKGLKRxdtxCZ7AnfB3
 D2Ua3a24jPw4Jkx2xa0EsrFLMrFP6/ystYPtbruOgyIFDroyejQeJnmYFA9Acz+jnDIc6cQtk
 qyxjk57MTgLMvZAfRUtrLS8GkeM2g6GHoBR/Hf2iOwl1nbqY/HwKafDTGpwCcWTIznIA8cAr9
 JPWJHA5+UDvhxCPpa1mIO9VHZB163/Axk/LusNHcWvFz/SfovDCEh4TqzeAdROPNbQxc47tg8
 732ip6uYs0CgmnPmFYGDcEPI6zyFC3tEr32rXrO5585YjFcEmODzGRobpLVBCGVNDsIJ8enEs
 WTNb68pcbE3yh37GKFceQxfROgs=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/10/10 15:52, Shinichiro Kawasaki wrote:
> Hi all,
>
> I found fstests runs for btrfs on my test systems fail with the kernel v=
6.6-rc5.
> Mount commands for btrfs fail with this message:
>
>    mount: /mnt: wrong fs type, bad option, bad superblock on /dev/sdc, m=
issing codepage or helper program, or other error.
>         dmesg(1) may have more information after failed mount system cal=
l.
>
> And kernel reported:
>
>    BTRFS error: unrecognized mount option 'context=3D"system_u:object_r:=
root_t:s0"
>
> My test system has Fedora which enables SELinux. Fstests adds SELinux se=
curity
> context of the system to the mount command option list. Mount commands w=
ith the
> added option fail:
>
>    $ sudo mount -o context=3Dsystem_u:object_r:root_t:s0 /dev/sdX /mnt
>
> With the kernel v6.6-rc4, the mount command succeeded. I bisected betwee=
n rc4
> and rc5 then found the trigger commit is 5f521494cc73 ("btrfs: reject un=
known
> mount options early"). When I revert the commit from v6.6-rc5, the mount=
 command
> succeeds.
>
> Since the trigger is in the kernel, I guess a fix is required on the ker=
nel side
> rather than fstests or mount command. Actions for fix will be appreciate=
d.

OK, the problem is, the SELinux options are only handled later, in
btrfs_mount_root(), meanwhile btrfs_mount() is called earlier, thus the
SELinux options are rejected.

Unfortunately my environment doesn't utilize SELinux, thus it doesn't
get caught at all...

David, please revert the offending patch, a proper fix would be more
complex.

Thanks,
Qu
