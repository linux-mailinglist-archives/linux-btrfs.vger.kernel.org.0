Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F37472DEC62
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Dec 2020 01:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgLSA1w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Dec 2020 19:27:52 -0500
Received: from mout.gmx.net ([212.227.15.15]:35017 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbgLSA1w (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Dec 2020 19:27:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608337578;
        bh=gI6XXu1PNS5KdYob5o+WFT3meaLH3RDUL+r4Hm/i9TI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=P63TykYhVdsfv4YYJfszGsaPd3/G5aEu66AuPYthXYQBsvTcmga0ORj1qCVJvAgcb
         RRKHN9gFVXLwfHa/0fWcihRYa/Kkc0pJiqr/85cStqTp05LGSmy7z00kEE9w5c/dV3
         KXOV4VaRwd3HA7EJ7LlfRjVBemdU7LEQeQTKaghU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mkpav-1kNAO62Etr-00mHIN; Sat, 19
 Dec 2020 01:26:18 +0100
Subject: Re: [PATCH 0/2] btrfs: btrfs_dec_test_*_ordered_extent() refactor
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201218051701.62262-1-wqu@suse.com>
 <20201218155755.GB6430@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <a612e52b-9c1d-880d-0056-762bbdac60ce@gmx.com>
Date:   Sat, 19 Dec 2020 08:26:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201218155755.GB6430@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+WZ6aLvmKZeGoDkR9ZTY+/RCXFe1m8D+aw5kkq55YOdvpzZCU0V
 u0ZX0g+E+kI9RBQtZL02/lQ3F26mCWsOSA6ZukVPRF00zjrZDItI4i1qmOY7y+ttdUfC8S2
 VYSxt/fwxooYiulrTSjj0JOHMVaWcUMMnTVls09Uy23lpu98bpKJBolj9tc+03fHMB7j2dg
 H19UwGMVSDvWOwKYwkcyg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Tb4rMhBJ8UA=:sCQHdJZcH7HyMNyTJXHi1t
 RE6V/chbkZfPg4M+TQt8gQg+kWXMJQW8I7bP3qKPhVzvO85m6kMLoX6rET0/1qx2YEF029hgn
 5CyUQS3IhxaDbTZk8ff5YdDj+u6Q5X79ki84ydlGFtAfNIepP/EYRLB1XvH+DqDlcJnS+jyNq
 EZJaJWToV2wG/e8sdiWUSlcqoGD4lxk8X5+gHXE5280i739EnwJP51R3s5NslMnhh10Icb1Qh
 Iyugsg1cvSF07Os3ia4UZnn8As83jn0Rhn0t/5N/i4EqQAl+7nw7KixTamN0TjoHaHzLHYkZO
 +L4TxPYE5tU/TCQj0HvXX4s/yW5N6FzQPkhp9zwly6rhyVyn7qDN6L2H/2zN+QL4oqkhbJThg
 Kd6AE1Tp41JWUb3TbiANU01TYuB1u9ivyxy01S2UchBO77M093nygPNjFOlx6gwNwqR/CCAh5
 TRoGhnO+HbfB6/ORqcVkttA+ZpBH+m2FtQafoBLrDbnf/xv3fzwRQAx/koCEKk30ZbjBgRYl5
 OElE01w9ulr7k6YQImCWiudmXWf8jsfBRm9L9QROup1nPT0D13Hg0kcWRgTL6nyIyt8Z2AXIq
 GvQNTjaQNRfHP5S2SCjpvT1qOJfiUrDPc1sCCL0DAzCHkGOohIFYuheEP0DtsbswRfbwIfYKC
 gFqTd6PpoDhejZebVtYipXLt1kn0IYRwKqYh9w8akc2+ggAU1zNXVK38Xd1b/ZfRz7ttWnqf4
 A9vnUtqbHASdH/cnkcYkC3Qf+HWtFVVP/qXPAMU26SxmsZTv48Vzf5bv5b1VVkGnUuZPidITl
 /mXbd+umw7+t3Nio6o2fNuAcwY1oCYF/GxyiDc5n2oE8DqsGBHekiz1qds1h81Jtan/XD7LCm
 PZLYGIS6TXWOh4XxyZxA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/12/18 =E4=B8=8B=E5=8D=8811:57, David Sterba wrote:
> On Fri, Dec 18, 2020 at 01:16:59PM +0800, Qu Wenruo wrote:
>> This small patchset is btrfs_dec_test_*_ordered_extent() refactor durin=
g
>> subpage RW support development.
>>
>> This is mostly to make btrfs_dev_test_* functions more human readable
>> and prepare it for calling btrfs_dec_test_first_ordered_extent() in
>> btrfs_writepage_endio_finish_ordered() where we can have one or more
>> ordered extents for one bvec.
>>
>> Qu Wenruo (2):
>>    btrfs: make btrfs_dio_private::bytes to be u32
>>    btrfs: refactor btrfs_dec_test_* functions for ordered extents
>
> The idea makes sense but the patches are IMO in wrong order and still
> leave some u64/u32, eg. in btrfs_dec_test_first_ordered_pending the
> io_size is still u64 while for btrfs_dec_test_ordered_pending it
> switches type to u32 (as expected).

That u64 is left there and the reason is explained in the 2nd patch.

Mostly due to iomap requirement.

But I totally get your point.

Thanks,
Qu

>
> The type cleanup should be done bottom-up, from the leaf functions
> upwards. After that, the structure type can be safely switched.
>
> I'm not sure what to do with __endio_write_update_ordered, it can take
> u32 for bytes but internally uses u64 for ordered_bytes, that should be
> u32 as well. But
>
>   7711                 if (ordered_offset < offset + bytes) {
>   7712                         ordered_bytes =3D offset + bytes - ordere=
d_offset;
>   7713                         ordered =3D NULL;
>   7714                 }
>
> expression on line 7712 would need a temporary variable for the u64
> calculation and then reassign. Maybe such conversions are inevitable so
> we have clean function API and not pass u64 just because.
>
> I like that the hole btrfs_dio_private gets removed so the cleanups are
> worthwhile, but maybe not trivial.
>
