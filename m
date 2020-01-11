Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3C2137BD4
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jan 2020 07:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgAKGPh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 11 Jan 2020 01:15:37 -0500
Received: from mout.gmx.net ([212.227.15.19]:60243 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbgAKGPg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Jan 2020 01:15:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578723327;
        bh=eNF1q9P+Wi4MuWTfyeaewgJTfko2PcPzRR7m64WgdQs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ejZHuxXuL9LUxnBkXRnmfXmNabQjfPNO3TQtd14oWAV5FR0woDD0OolBF9s5oAcvx
         h/C+te1Iek5JNdkJzNUmQAh5BnElc6PrFTN+hsphRcTsZFXKVi2simhp8ymSZSHuoE
         1GHKUpaw6QSQCFsAGtqZt5DFESVkoPTYU9Oo79ow=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MjS9I-1jWcKq34mI-00kxPE; Sat, 11
 Jan 2020 07:15:27 +0100
Subject: Re: [PATCH 4/5] btrfs: fix force usage in inc_block_group_ro
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
References: <20200110161128.21710-1-josef@toxicpanda.com>
 <20200110161128.21710-5-josef@toxicpanda.com>
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
Message-ID: <d171bcd6-fbbd-256c-5544-fe3e873bcf0b@gmx.com>
Date:   Sat, 11 Jan 2020 14:15:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200110161128.21710-5-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nMFDj52SSPcSzCpyjQr5qokV9tMTgIm5F+UHnciXQ3TO1zQv7c3
 z3DuuNwEtvLCP1H3+MXJ8+L+1PEPMX374EFv6/0ByMJQQBOMMb+niSWRl25kaJFX/9eg209
 C8E5wWQuLMSkPGAbOc4u+GhAxGvqCRXUdTrdjNlM812xDWlR+cvYKJePeZACDRtv23ZflqJ
 oRidaTXemmPQ4wqmD/Qtg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RBb4O+UE2A8=:LPu1wU9gSu9cuw2VGA2sQY
 qDAFTVqXP/A8Nivd/Ni0Pjcvfp2NgDfaj3R6XaqyL/SlbStRg6C8p0MjrZnjG8n4tLKhuI+XE
 bHoynzZSahe3Oz4tFjQTIxLRchSoGXgBpS1GMOai7fEtymGUaduGrlryImS07OXG9MSlZaqsK
 kKo2XcU+dhg8lPDqrMe+IgKXlo3kAiFfWixfHsn5G5nrvDa5TLBWiWVOaBuCmrcWj7dGSQdS1
 8DbjiKYE9BVt0jrF2I2QzC+1wI5enh/srQMZTmLG3xHKfLBmMnCesLWrJmSDfrxDa4ybsogEJ
 rMCXXDT9vS12V0xG/o5PXKq3/y+GzWTWAiFpx19dXi9a2+7e8lKOmJNFFs5PxOjbZ6rPApWze
 TRf6ZbbioOppsJhaVJlDindl9xYekcA/pLzUMwStFg5s1BOQc33JIkKnD4ZtFlQZoZ8q8xu4C
 kQp54lXTy2YY7fKYg4n9KJ48VZQ2TR8aCbSUMhWNGlFRzu9xV/H/4+lMRYovwQ2vU3/Uas0NF
 3NJwPdhavSDXqLawtKRy2EgZaEcA5Yz9pB+VRFGPKGx/ZWQxSfzB92JSc9l/Ef7rbeJOm2RIn
 RQGNhWg/sNf6OaFRxiTLkwgNtjVyW14Y5oYLDHaqC4hf9+Wy9SepAZwB+rN44Smt+z6SmzkP0
 de6Rhe3W1aLex+Q3we03dnbQrin6fWlYwXyL+LWseVsYU9yjCEQWue/7UxMBhZJgvjFtZ1PBd
 Bgl60nLqfzdfJVoS9iktBt/CwL3RH/Nn7DdnAPwKTNyreLfaCxeD4tT1KeRrv1chne0Mcak0Z
 gXoKooKcXexEYzTy/tIGo/95st1ktVxsjKjND6eLc5XWhZCKMoIZwgKCIm3FJQbyAlhEk9HXi
 tyzJQBnVU7vXERKQJ3Uw82JEjLvmAdowPsUsGzDi+nAfLATfKZX0jRGIUVlVmbBHEdYGYfc1j
 ULtvJ2jhQitM+3tZezMfHGG1qCsK+JhDMbasVlfzemz9JGv+1iAdkB1Ro66SWMVPD4zMjhoja
 mqo+tZTT1MgfES/qywnS4Y50k5YL6+CVzEyxEwPa/1BlOkW1KQanNLCWMwi5SdP0mq4K+NuJN
 oKfcSDxUBvvglzxlbxBREWgVfqLOz+4vvHYcTGl7SnWpmL/ZMQy7IMiNfOzlvGoq1JFjDUYq4
 6byGc4r4INbha52oiawwbMEwQ+GyW1QG2ho2Kk4vIyyY/lX9H5F9bxoKxcfD+DiP45B4kiEv+
 WoyyL8oJqnwOmsG9tTfWOKAvw7xm4m0SYhk+/h3QB4XejoEiNk064tAmHunE=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/1/11 =E4=B8=8A=E5=8D=8812:11, Josef Bacik wrote:
> For some reason we've translated the do_chunk_alloc that goes into
> btrfs_inc_block_group_ro to force in inc_block_group_ro, but these are
> two different things.
>
> force for inc_block_group_ro is used when we are forcing the block group
> read only no matter what, for example when the underlying chunk is
> marked read only.  We need to not do the space check here as this block
> group needs to be read only.
>
> btrfs_inc_block_group_ro() has a do_chunk_alloc flag that indicates that
> we need to pre-allocate a chunk before marking the block group read
> only.  This has nothing to do with forcing, and in fact we _always_ want
> to do the space check in this case, so unconditionally pass false for
> force in this case.
>
> Then fixup inc_block_group_ro to honor force as it's expected and
> documented to do.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>

It looks like my previous comment was on a development branch which we
skip chunk allocation for scrub.

But since it's not upstreamed yet, no need to bother.

Reviewed-by: Qu wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>  fs/btrfs/block-group.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 6f564e390153..2e94e14e30ee 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1190,8 +1190,15 @@ static int inc_block_group_ro(struct btrfs_block_=
group *cache, int force)
>  	spin_lock(&sinfo->lock);
>  	spin_lock(&cache->lock);
>
> -	if (cache->ro) {
> +	if (cache->ro || force) {
>  		cache->ro++;
> +
> +		/*
> +		 * We should only be empty if we did force here and haven't
> +		 * already marked ourselves read only.
> +		 */
> +		if (force && list_empty(&cache->ro_list))
> +			list_add_tail(&cache->ro_list, &sinfo->ro_bgs);
>  		ret =3D 0;
>  		goto out;
>  	}
>
