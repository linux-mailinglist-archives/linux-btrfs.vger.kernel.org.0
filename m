Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0C41E8DED
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 May 2020 07:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbgE3FAR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 30 May 2020 01:00:17 -0400
Received: from mout.gmx.net ([212.227.17.22]:41423 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbgE3FAP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 30 May 2020 01:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590814806;
        bh=Gfm/R9hhYaH3Gf7kmHHQzoVhNm8ZVKnVCxB+hRuXtZ4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=XiBpdT3YpRFZ/vTr/ylFT1j4WPM7pjqFx60muZbcDhfiR/pbFuaZLjxRKsXzOYO6f
         noHv1B/McT1iF97UQz4WRQXRULDSoeGK8gX0LAPpH4ngYgoZ/ZfnoXol5v1IAqr4d+
         V1CP38ErBtGJVBTbxLKZWYuOMlkXKoWSbE2ByPRo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M5fIQ-1jdFyJ2HzW-007Eue; Sat, 30
 May 2020 07:00:06 +0200
Subject: Re: [RFC][PATCH V3] btrfs: ssd_metadata: storing metadata on SSD
To:     Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs@vger.kernel.org
Cc:     Michael <mclaud@roznica.com.ua>, Hugo Mills <hugo@carfax.org.uk>,
        Martin Svec <martin.svec@zoner.cz>,
        Wang Yugui <wangyugui@e16-tech.com>
References: <20200405082636.18016-1-kreijack@libero.it>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <69939407-de18-e455-6c85-cd10683894be@gmx.com>
Date:   Sat, 30 May 2020 12:59:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200405082636.18016-1-kreijack@libero.it>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uHHH3hTRHqjlhfTq1Vnsuqko5+itmM3C9jOAf16QmdJ4TNJc435
 HdLvU6kVC3/5a9jiJWGIc3lfkYBsVpffBuU6BZpdh/D0AmJ/haXDWBNv/8u2OHJHaa/fJFT
 vkynHcGCgKeXJeltsk3i7wzGvUg7QWDKhtDV8ZAA5/8238xxfWpof6wxSMUmobRIN5rFlx7
 EIzJY972MR1F2kfurqBpw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jj4virOfagE=:DsgdtIPQH6xIXKuPmBvfOC
 qUSyVR3pujoqoFhx/W8ZcMp2PizIQBoEi0eUBiou/uZ0+VQIJpGu+BPTdWuaD+ig9uQC0qj8H
 9gCZHpiY6l5lJ7ZVH/W2i7AHFOeupFzGVNwqRwRIee3FCELerqEXQb2aaeIMGlOFsYTDvg9aW
 DCyl2or2BrQmiTttOCuLTB+c5R8jowsgtailZpM4hQpdh68QcrFihHnVV2GYQtzf+W1cfEVKJ
 rV6fcmCr77DsJ2Vzzb58Du/ME9ft/XbNzLW47J7OSVruyuexuvuJoYXyzNe1XOqPucCUfkHlh
 QI6Ke0QL3wvvb8NNLW0MRh9L4HlE/Bn305VoilYC7oCz3X9B1O3SkNdmM0vXgTUomRBIpETb9
 bbTSnYWPhTVP8xCQkiFlmN1MMH7EP94lmh4E1RRAskENmot09XsQ+5rgdSyHUL3eW/txnWOjA
 bo4W7irkNTVQBpFCfRcRb04b8668BvzGfrgt7z1YDhiwd9M2hornIRlCwLIf8Xfde6jlRad+z
 5ysi1f2xklSEWzLYojCqaS99ly1zglrAIeulOvbLqylLtKO3gsG3Fr+aZYsV5TCNeUuKXJrct
 w0y6KIRgTt9rDEIsD0ehRWAorM2cYB8Z0GvJNqJDSLgpb6VMIh37KC9dfGWbXl5frYSM0rX6N
 QHzGYv7+sDwoB1Azx7oe/OSaODztbF9U7s2HM6d2bz6xyUFFPvMHNtyYeM4WNGMI3ygBuhUpK
 Cqw968IDAxY9w8/udgWbG5Kw2ijRGpzWfMU2bMcMvOFzfX+6IDNhTzqd9XpZQ8+VuMeopXh6a
 KYqseCF9jN3USUFwTnj/qPD3krA7MBWvBxwC8uyx1sby3ouh3XpKeARdM2pviF1A0yGCNm5AB
 RjNM0vr4HthYLBHDVvBgne5NdwWO0L3edZsoNSUJEiBQP8IWsMkVBpcsMDRB+jnXx2dHry2qD
 FPpgjWJ5M8FDTdQ+U5S2p8LaebGsLyY5RWQpOhoDiQAOPsBZyGOd8k73VnZ12BRLVWwInr5mh
 0s3NDSrVp2BH8SeH/XO2X+vF+Im8Isw5SOOox0Ae/MFuCNVr/gcFIiAKeGuqmMNR1jb6pXJ42
 0A1hl4mAZcXOIQq5DQSKr0DrxyvY3AgttbEJxiZt0qlki3mTKtoPti+W732zG9GAQBHojjMWk
 6f+MZpUh/2G1NYOUHbd8YY/FVgXXZHy7hs5yxmLkJdCZ/oX9WjgBxEMPjl8mrpzQx4aQ3BOR8
 cTBl98F5oYWnORAA2
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/4/5 =E4=B8=8B=E5=8D=884:26, Goffredo Baroncelli wrote:
>
> Hi all,
>
> This is an RFC; I wrote this patch because I find the idea interesting
> even though it adds more complication to the chunk allocator.
>
> The core idea is to store the metadata on the ssd and to leave the data
> on the rotational disks. BTRFS looks at the rotational flags to
> understand the kind of disks.
>
> This new mode is enabled passing the option ssd_metadata at mount time.
> This policy of allocation is the "preferred" one. If this doesn't permit
> a chunk allocation, the "classic" one is used.

One thing to improve here, in fact we can use existing members to
restore the device related info:
- btrfs_dev_item::seek_speed
- btrfs_dev_item::bandwidth (I tend to rename it to IOPS)

In fact, what you're trying to do is to provide a policy to allocate
chunks based on each device performance characteristics.

I believe it would be super awesome, but to get it upstream, I guess we
would prefer a more flex framework, thus it would be pretty slow to merge.

But still, thanks for your awesome idea.

Thanks,
Qu


>
> Some examples: (/dev/sd[abc] are ssd, and /dev/sd[ef] are rotational)
>
> Non striped profile: metadata->raid1, data->raid1
> The data is stored on /dev/sd[ef], metadata is stored on /dev/sd[abc].
> When /dev/sd[ef] are full, then the data chunk is allocated also on
> /dev/sd[abc].
>
> Striped profile: metadata->raid6, data->raid6
> raid6 requires 3 disks at minimum, so /dev/sd[ef] are not enough for a
> data profile raid6. To allow a data chunk allocation, the data profile r=
aid6
> will be stored on all the disks /dev/sd[abcdef].
> Instead the metadata profile raid6 will be allocated on /dev/sd[abc],
> because these are enough to host this chunk.
>
> Changelog:
> v1: - first issue
> v2: - rebased to v5.6.2
>     - correct the comparison about the rotational disks (>=3D instead of=
 >)
>     - add the flag rotational to the struct btrfs_device_info to
>       simplify the comparison function (btrfs_cmp_device_info*() )
> v3: - correct the collision between BTRFS_MOUNT_DISCARD_ASYNC and
>       BTRFS_MOUNT_SSD_METADATA.
>
> Below I collected some data to highlight the performance increment.
>
> Test setup:
> I performed as test a "dist-upgrade" of a Debian from stretch to buster.
> The test consisted in an image of a Debian stretch[1]  with the packages
> needed under /var/cache/apt/archives/ (so no networking was involved).
> For each test I formatted the filesystem from scratch, un-tar-red the
> image and the ran "apt-get dist-upgrade" [2]. For each disk(s)/filesyste=
m
> combination I measured the time of apt dist-upgrade with and
> without the flag "force-unsafe-io" which reduce the using of sync(2) and
> flush(2). The ssd was 20GB big, the hdd was 230GB big,
>
> I considered the following scenarios:
> - btrfs over ssd
> - btrfs over ssd + hdd with my patch enabled
> - btrfs over bcache over hdd+ssd
> - btrfs over hdd (very, very slow....)
> - ext4 over ssd
> - ext4 over hdd
>
> The test machine was an "AMD A6-6400K" with 4GB of ram, where 3GB was us=
ed
> as cache/buff.
>
> Data analysis:
>
> Of course btrfs is slower than ext4 when a lot of sync/flush are involve=
d. Using
> apt on a rotational was a dramatic experience. And IMHO  this should be =
replaced
> by using the btrfs snapshot capabilities. But this is another (not easy)=
 story.
>
> Unsurprising bcache performs better than my patch. But this is an expect=
ed
> result because it can cache also the data chunk (the read can goes direc=
tly to
> the ssd). bcache perform about +60% slower when there are a lot of sync/=
flush
> and only +20% in the other case.
>
> Regarding the test with force-unsafe-io (fewer sync/flush), my patch red=
uce the
> time from +256% to +113%  than the hdd-only . Which I consider a good
> results considering how small is the patch.
>
>
> Raw data:
> The data below is the "real" time (as return by the time command) consum=
ed by
> apt
>
>
> Test description         real (mmm:ss)	Delta %
> --------------------     -------------  -------
> btrfs hdd w/sync	   142:38	+533%
> btrfs ssd+hdd w/sync        81:04	+260%
> ext4 hdd w/sync	            52:39	+134%
> btrfs bcache w/sync	    35:59	 +60%
> btrfs ssd w/sync	    22:31	reference
> ext4 ssd w/sync	            12:19	 -45%
>
>
>
> Test description         real (mmm:ss)	Delta %
> --------------------     -------------  -------
> btrfs hdd	             56:2	+256%
> ext4 hdd	            51:32	+228%
> btrfs ssd+hdd	            33:30	+113%
> btrfs bcache	            18:57	 +20%
> btrfs ssd	            15:44	reference
> ext4 ssd	            11:49	 -25%
>
>
> [1] I created the image, using "debootrap stretch", then I installed a s=
et
> of packages using the commands:
>
>   # debootstrap stretch test/
>   # chroot test/
>   # mount -t proc proc proc
>   # mount -t sysfs sys sys
>   # apt --option=3DDpkg::Options::=3D--force-confold \
>         --option=3DDpkg::options::=3D--force-unsafe-io \
> 	install mate-desktop-environment* xserver-xorg vim \
>         task-kde-desktop task-gnome-desktop
>
> Then updated the release from stretch to buster changing the file /etc/a=
pt/source.list
> Then I download the packages for the dist upgrade:
>
>   # apt-get update
>   # apt-get --download-only dist-upgrade
>
> Then I create a tar of this image.
> Before the dist upgrading the space used was about 7GB of space with 228=
1
> packages. After the dist-upgrade, the space used was 9GB with 2870 packa=
ges.
> The upgrade installed/updated about 2251 packages.
>
>
> [2] The command was a bit more complex, to avoid an interactive session
>
>   # mkfs.btrfs -m single -d single /dev/sdX
>   # mount /dev/sdX test/
>   # cd test
>   # time tar xzf ../image.tgz
>   # chroot .
>   # mount -t proc proc proc
>   # mount -t sysfs sys sys
>   # export DEBIAN_FRONTEND=3Dnoninteractive
>   # time apt-get -y --option=3DDpkg::Options::=3D--force-confold \
> 	--option=3DDpkg::options::=3D--force-unsafe-io dist-upgrade
>
>
> BR
> G.Baroncelli
>
