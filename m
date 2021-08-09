Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 700613E4527
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Aug 2021 14:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbhHIMBH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Aug 2021 08:01:07 -0400
Received: from mout.gmx.net ([212.227.15.19]:33871 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231327AbhHIMBG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Aug 2021 08:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628510444;
        bh=tMda2khWaB/glo/kUBGIoMUtYmdysnFLP73SVB/sdZU=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=VcWh4rFjHdTDPpSV3mPwnLqsOVpxwGiEhA7XYjCsI47KDgQGA4E83vcHMIHd8/dUg
         cmtxxmrRzgdiiCY+LvZ7eeY2GCdMgNmdCOyH/URbOi9vMnVKH8dUoyKZPR895fOack
         NB4XFNX337adP6qItS8CW6T6JWpMu/c6E/1oKaow=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MdvmO-1mo3P31Us2-00b2JU; Mon, 09
 Aug 2021 14:00:44 +0200
To:     Serhat Sevki Dincer <jfcgauss@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CAPqC6xQcJa7y2mPWxRM7_kNtdawFgEtFtGLP0K2A_UXU0X6u8g@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: max_inline: alternative values?
Message-ID: <9073e835-41c2-bdab-8e05-dfc759c0e22f@gmx.com>
Date:   Mon, 9 Aug 2021 20:00:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAPqC6xQcJa7y2mPWxRM7_kNtdawFgEtFtGLP0K2A_UXU0X6u8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xsX4rX00xshNEUacDskAVP7N5blCuh+lxT83cWpPMGS4hE6klK2
 omaZluzivtVe7lcvnNYW0iu0nFVimNVfdeZaZltxUbxebSFM3Q/D2+nuUa1sZo6/x0u5xJj
 yixhXOJISKA0Pd8PWFB5HRE1WshawJiLoYvqAsP7Q2RTKx+8cq+jhkYYTUWm/cH0xcchRDH
 0jgriFSpo6AetqZqI0VFg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:S3XPHRKVeeI=:6AsTp/beeEpjzwbD4Ni32r
 09b1Wma3stCmnjjoP04gtWJ7ww01TE5D23Jz6SdurKcq7+4hol5mJxUpw7HXSCX/AoCypO4no
 rLwGJ1lnOYQo2KgAB8zM2CXX10x660pZomZM5Tq+fDsGAMS9ESaemgflqFCuyuw91nbdC8aVP
 +/dOYIEmmg9nAMU/k3hbjuzMVHWq0SMrxXMvD9CrIOJsQpx2Kdnnd8np9q1U8y7GL6F8fvoRE
 plXBPsr7C1xoh5LXvHpjDIR3OWE4Ot6p1PufMA40xLSCcakiGxFFc9Qqv4nJzBqMbEtrDq6+F
 w59ncYPmBqc46Bad7TRsK9kadwRi4rlxJOMUrqQWkVlsTeG5vhJPoZaG2TclBDhFwdecypBUw
 +LFL+648Tfhxp4fPoUIeU40s/bBzp7+3JtPRHGlO51FYm8p2/1Z4TuCpU2REoapeMHsn6XiGw
 4uf/YYp3j5k8mmnwEYd28AbtKYka4j2s96SN3Ia3d9Bwz3V7npmn8aP9IU9oZDMHp79Sny+oS
 wdl00MJ1gEzEmDH1tR36Ut8kkVEbIpZQNH4uGSnH+1teOmLQwdiUqh24d3pZe/tZDO/SzA8Zs
 DV1iL16i8hjl+LQC+Pt8C/ZMp5STTQNoGGlK2OO1QdCeAhbN8Yj1FMESb2KZHlblTpbU2F6sP
 RzfQChW+huIGlIOWRWSI+UmN1i0L9v3YaiBlNvSCpeNpVA/qK+LFPU0q/kTz6Ozg8wldLNRer
 JBudLo/H0zLgtsqq6qk16dlF7QHVN7Pg4GVYXB3EDuEAhsOpKkPV3wmYCW02dWom0K5wCs3iz
 54z/u95G6/MC6kMlmH+ZtiRjm5VHx4z09Xogq9uKzpIxlvNg/8TE91SWf2Be6g7rfITG1CtN2
 ll+PI8iCP6goP/L9Uun8B48xdCt6szCudNssSgkYwrw1opVE6uHvp3oeBbH9TqkE/asoUm+Gf
 2NQfrq7YP51b/8QsMBgJeD8fhaWn6YQ+EwsW35UOrZuxrMvXjg4QaplE3aibNSxaf9KPJG87X
 e55lIpEthUWPfw3aJA3TY9drOTqk1FppWGnmUkdi6kiF66TXMxBV7qpwS7Nk4XHdQH6LaSbFO
 USsFM1WCtGxqcOPpUE5sbYXLLt4HLK7YY3cwlVFholHndGqlXhRtkl95g==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/9 =E4=B8=8B=E5=8D=887:15, Serhat Sevki Dincer wrote:
> Hi,
>
> I was reading btrfs mount options and max_inline=3D2048 (by default)
> caught my attention.
> I could not find any benchmarks on the internet comparing different
> values for this parameter.
> The most detailed info I could find is below from May 2016, when 2048
> was set as default.
>
> So on a new-ish 64-bit system (amd64 or arm64) with "SSD" (memory/file
> blocks are 4K,

For 64-bit arm64, there are 3 different default page size (4K, 16K and 64K=
).
Thus it's a completely different beast, as currently btrfs don't support
sectorsize other than page size.

But we're already working on support 4K sectorsize for 64K page size,
the initial support will arrive at v5.15 upstream.

Anyway, for now we will only discuss 4K sectorsize for supported systems
(amd64 or 4K page sized aarch64), with default 16K nodesize.


> metadata profile "single" by default), how would max_inline=3D2048
> compare to say 3072 ?
> Do you know/have any benchmarks comparing different values on a
> typical linux installation in terms of:
> - performance
> - total disk usage

Personally speaking, I'm also very interested in such benchmark, as the
subpage support is coming soon, except RAID56, only inline extent
creation is disabled for subpage.

Thus knowing the performance impact is really important.

But there are more variables involved in such "benchmark".
Not only the inline file limit, but also things like the average file
size involved in the "typical" setup.

If we can define the "typical" setup, I guess it would much easier to do
benchmark.
Depends on the "typical" average file size and how concurrency the
operations are, the result can change.


 From what I know, inline extent size affects the following things:

- Metadata size
   Obviously, but since you're mentioning SSD default, it's less a
   concern, as metadata is also SINGLE in that case.

   Much larger metadata will make the already slow btrfs metadata
   operations even slower.

   On the other hand it will make such inlined data more compact,
   as we no longer needs to pad the data to sectorsize.

   So I'm not sure about the final result.

- Data writeback
   With inline extent, we don't need to submit data writes, but inline
   them directly into metadata.

   This means we don't need to things like data csum calculation, but
   we also need to do more metadata csum calculation.

   Again, no obvious result again.


> What would be the "optimal" value for SSD on a typical desktop? server?

I bet it's not a big deal, but would be very happy to be proven run.

BTW, I just did a super stupid test:
=2D-----
fill_dir()
{
         local dir=3D$1
         for (( i =3D 0; i < 5120 ; i++)); do
                 xfs_io -f -c "pwrite 0 3K" $dir/file_$i > /dev/null
         done
         sync
}

dev=3D"/dev/test/test"
mnt=3D"/mnt/btrfs"

umount $dev &> /dev/null
umount $mnt &> /dev/null

mkfs.btrfs -f -s 4k -m single $dev
mount $dev $mnt -o ssd,max_inline=3D2048
echo "ssd,max_inline=3D2048"
time fill_dir $mnt
umount $mnt

mkfs.btrfs -f -s 4k -m single $dev
mount $dev $mnt -o ssd,max_inline=3D3072
echo "ssd,max_inline=3D3072"
time fill_dir $mnt
umount $mnt
=2D-----

The results are:

ssd,max_inline=3D2048
real    0m20.403s
user    0m4.076s
sys     0m16.607s

ssd,max_inline=3D3072
real    0m20.096s
user    0m4.195s
sys     0m16.213s


Except the slow nature of btrfs metadata operations, it doesn't show
much difference at least for their writeback performance.

Thanks,
Qu

>
> Thanks a lot..
>
> Note:
> From: David Sterba <dsterba@suse.com>
>
> commit f7e98a7fff8634ae655c666dc2c9fc55a48d0a73 upstream.
>
> The current practical default is ~4k on x86_64 (the logic is more comple=
x,
> simplified for brevity), the inlined files land in the metadata group an=
d
> thus consume space that could be needed for the real metadata.
>
> The inlining brings some usability surprises:
>
> 1) total space consumption measured on various filesystems and btrfs
>     with DUP metadata was quite visible because of the duplicated data
>     within metadata
>
> 2) inlined data may exhaust the metadata, which are more precious in cas=
e
>     the entire device space is allocated to chunks (ie. balance cannot
>     make the space more compact)
>
> 3) performance suffers a bit as the inlined blocks are duplicate and
>     stored far away on the device.
>
> Proposed fix: set the default to 2048
>
> This fixes namely 1), the total filesysystem space consumption will be o=
n
> par with other filesystems.
>
> Partially fixes 2), more data are pushed to the data block groups.
>
> The characteristics of 3) are based on actual small file size
> distribution.
>
> The change is independent of the metadata blockgroup type (though it's
> most visible with DUP) or system page size as these parameters are not
> trival to find out, compared to file size.
>
