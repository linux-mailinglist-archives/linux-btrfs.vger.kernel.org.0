Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6713F10C738
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Nov 2019 11:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfK1KwC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Nov 2019 05:52:02 -0500
Received: from mout.gmx.net ([212.227.17.21]:40847 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbfK1KwC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Nov 2019 05:52:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574938249;
        bh=HdYEtFkUnnZEGJo/Yjg2u20Hw8DryoZwZpfqOgvHGcU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ly2ctU0QuaYFZ7pwdd9TMDVGQ0yWk+UqIqvoxmHZsZk4Zdykk3lVN2odcIrgFJs4N
         c/TW4WFyTFEvH+hRjpZntf6yTtRiH9iRX56FnXIq+I/F7JBrO5A2+I/Ev4eRxrgJOQ
         2ohzWCf3BXniz+VRFgM7T5pXNZm3PILQc1LQLiuw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.169] ([34.92.246.95]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mw9UK-1hiJFk2d9A-00s29k; Thu, 28
 Nov 2019 11:50:49 +0100
Subject: Re: [PATCH] btrfs: relocation: Output current relocation stage at
 btrfs_relocate_block_group()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20191128075437.10621-1-wqu@suse.com>
From:   Su Yue <Damenly_Su@gmx.com>
Message-ID: <6dbfa97a-837f-7596-1813-04cbfb84167d@gmx.com>
Date:   Thu, 28 Nov 2019 18:50:44 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:71.0)
 Gecko/20100101 Thunderbird/71.0
MIME-Version: 1.0
In-Reply-To: <20191128075437.10621-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:v7PZQeeTFWd9+lmgbf+pdjcevMFp+mX3D5RawgWKzRsyb+3XMes
 8LFSe7Sca25nmN4m7q+fv1LZGpnxdEvegfqrNOgn7Ke4JoC06aYehtMjYd/SfJg+lkoFVL2
 RdjbdFR40Py8GKXINkbKeXzq2XACiXIrRh+E7S4kPyalBNLeeF1Byn7cjBoPv1YL6RRIOZi
 W45R5OMGC3nXGUuj8M5TQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+JuGjNOjydI=:M5EM01Wdq7RP2sNcfVezgZ
 4haIlMAMs5jjOO6I9quLw2o6pPUWrC+z16T5sRDRMCwECzgrqM1XNwzU3soNaXDySidGunV9l
 iLHD46Y+PumeQH/HQcnFYqkVMnggjSRTLVT9WVb14/eAdWYgOEszmFYjB1/sNuFXaRBTleUce
 dQ9SGG9+EETsC5vLPNNrg0lVCbYPsf9nwnI0PIqGkWdGOo03Mdu36DAhz8YOCJNwSKIcreP31
 2LNQCi4lHsOFn2d67OcVpCi3Xb3HPfvN5yM5e+bRgXxUtiKpXFxWzHGAV6A9tFEnxJf/JovxJ
 la4MFpCgR/kdaGUwVQtLkM8hxPH2AtfxbyV+PKZHrs2tGLux9SSJSOJBd45z0YXko+ev0qmkA
 vgx8dIAQA9uD6mt3yHaZqTi7riE4c+SRliXBR7XBezOInNdpZzjjyI/HrgUJCu/IkNso45mMw
 g1KguMum5VcKQmKN0mBAfy2fADtVXYSCXIx/7avSV3aVL0jNGhjr+emZWgQUT6qaVm7cz5bBT
 LMolGU/Wyfo3nd5DvtqQsI9vwKjAwZea5Ol2Mt9qpmo6I+RZd7js1EHyMLSg0cB1E4iQDjCO0
 bdRFgbxyRRiquy/rGfWcPwFq83nyFhMKhqynRqRyE47qHRmndD+5mZgqPCDntovfDe3o8RdOk
 7Sap9+PXgOq6vS02Qk8kQ+KgVmdIWnMyBQVV2dvcIT28bdyX6SloOPk7CfYc3edBNMunf9TYr
 RyB0XeZsBfwtKYRMLU216FQg8h7OFa8vVPsGH+z5b9MqqHEXtRh2Y6ptHJulhnTS9q6MS0Skj
 KDvfXaNDPx0bUU3aKg22t8Ra2isTYCm59FAlSCWResLsNRhpzWysEbjtxnQ6Vp6aKsD6k73k4
 hTubZZvsYlZ8g8mQjyEKxHHLfJKSLgkCsLjoXi+NPc+JfomGcgkoRAmppw5sKITTERroXWbNP
 7veVGe+qFgHG11wnHUR4VIYDtiKLAIHdgvhmfLz1fu9LLhTmFBLFuzlE0ecUgZrnVavsNU7Vm
 t2cROnngm+ZJ6WDXNprUGh8Pf4yqpK5M3Cddb92KBmYolsp/i5BElx13E024Tn+xF20NLXOb5
 DPw99mp1g21FTul3IMuKidvVl5HBsZtzzsDraQ6h9GrDbjD9CECpv3AhI3ScfSgNNOp6TNAin
 NCVc+Au+6w2E0aloc1I0UxSqLJOfjq1vV6W5vQLDqjijevE3csrYAyC5HpHmbZ7f4MdZJ2Tva
 EZIRqgGoGe05SKOGdn1DFVWjOzhZJN1CaHgi1Z5LVKwfQesnOsJGPIIdo90E=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/11/28 3:54 PM, Qu Wenruo wrote:
> There are several reports of hanging relocation, populating the dmesg
> with things like:
>    BTRFS info (device dm-5): found 1 extents
>
> The investigation is still on going, but will never hurt to output a
> little more info.
>
> This patch will also output the current relocation stage, making that
> output something like:
>
>    BTRFS info (device dm-5): balance: start -d -m -s
>    BTRFS info (device dm-5): relocating block group 30408704 flags metad=
ata|dup
>    BTRFS info (device dm-5): found 2 extents at MOVE_DATA_EXTENT stage
>    BTRFS info (device dm-5): relocating block group 22020096 flags syste=
m|dup
>    BTRFS info (device dm-5): found 1 extents at MOVE_DATA_EXTENT stage
>    BTRFS info (device dm-5): relocating block group 13631488 flags data
>    BTRFS info (device dm-5): found 1 extents at MOVE_DATA_EXTENT stage
>    BTRFS info (device dm-5): found 1 extents at UPDATE_DATA_PTRS stage
>    BTRFS info (device dm-5): balance: ended with status: 0
>
> The string "MOVE_DATA_EXTENT" and "UPDATE_DATA_PTRS" is mostly from the
> macro MOVE_DATA_EXTENTS and UPDATE_DATA_PTRS, but the 'S' from
> MOVE_DATA_EXTENTS is removed in the output string to make the alignment
> better.
>
> This patch will not increase the number of lines, but with extra info
> for us to debug the reported problem.
> (Although it's very likely the bug is sticking at UPDATE_DATA_PTRS
> stage, even without the patch)
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/relocation.c | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index d897a8e5e430..88fd9182852d 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -4291,6 +4291,15 @@ static void describe_relocation(struct btrfs_fs_i=
nfo *fs_info,
>   		   block_group->start, buf);
>   }
>
> +static const char *stage_to_string(int stage)
> +{
> +	if (stage =3D=3D MOVE_DATA_EXTENTS)
> +		return "MOVE_DATA_EXTENT";
> +	if (stage =3D=3D UPDATE_DATA_PTRS)
> +		return "UPDATE_DATA_PTRS";
> +	return "UNKNOWN";
> +}
> +
>   /*
>    * function to relocate all extents in a block group.
>    */
> @@ -4365,12 +4374,15 @@ int btrfs_relocate_block_group(struct btrfs_fs_i=
nfo *fs_info, u64 group_start)
>   				 rc->block_group->length);
>
>   	while (1) {
> +		int finishes_stage;
> +

NIT: the rc::stage is an unsigned integer.


>   		mutex_lock(&fs_info->cleaner_mutex);
>   		ret =3D relocate_block_group(rc);
>   		mutex_unlock(&fs_info->cleaner_mutex);
>   		if (ret < 0)
>   			err =3D ret;
>
> +		finishes_stage =3D rc->stage;
>   		/*
>   		 * We may have gotten ENOSPC after we already dirtied some
>   		 * extents.  If writeout happens while we're relocating a
> @@ -4396,8 +4408,8 @@ int btrfs_relocate_block_group(struct btrfs_fs_inf=
o *fs_info, u64 group_start)
>   		if (rc->extents_found =3D=3D 0)
>   			break;
>
> -		btrfs_info(fs_info, "found %llu extents", rc->extents_found);
> -
> +		btrfs_info(fs_info, "found %llu extents at %s stage",
> +			   rc->extents_found, stage_to_string(finishes_stage));
>   	}
>
>   	WARN_ON(rc->block_group->pinned > 0);
>
