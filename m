Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3439520861
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2019 15:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfEPNlR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 May 2019 09:41:17 -0400
Received: from mout.gmx.net ([212.227.17.20]:38425 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbfEPNlR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 May 2019 09:41:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1558014071;
        bh=Lrpj1yOYYI/MbtsyFbC6hq65iJHjfF5RyVMkOOMbATw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Dk0svKOWcz0QjQiuv8J0kyGSlq559zyGEZiGAoVU5cLNY3jmpH0J3oLWi9ssSPOi/
         WTv25VSuYYin1brKQkLN6AKmEPWs2RE9pGobzRjsUGEZq/ddfTYPq9p27yQzIdRzCG
         Pe+EDRTLyLSAlSp/e9NcgKs1Sq8Z3bU6+E8rGmtU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([52.197.165.36]) by mail.gmx.com (mrgmx101
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0MHLNn-1hVvaI2NBz-00E5jn; Thu, 16
 May 2019 15:41:11 +0200
Subject: Re: [PATCH 1/2] btrfs-progs: Correctly open filesystem on image file
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20190516131250.26621-1-nborisov@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <e7a99dd5-5107-5da9-df95-6ad43bf8ad7e@gmx.com>
Date:   Thu, 16 May 2019 21:41:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516131250.26621-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E/jggzf0eccx3GlGNwqD0kyYcv8Qx1sM+F8Om0svyrxQHyBRQMb
 VPzXt4n/QyKAEo1VTe45V3qWQt/TBVjZriW9mMYBtZZRY+bXKORgsMm65omNE04h7p7cI69
 u/YxyOY3jlj61QiuvQtzIZzQlysdDRTLX9r6O/o2eJwrxbIChsdjIV/VsFfbwasP62H7vpc
 aQTkbL8WciYs8epkSWP/g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:x8UmPoWc4+w=:j1UeYkXXUz+WNtAtCg9BG8
 4foOW694M3xaXU1AaC3yi6gioe5mdKxfAq8nMGIM/VPjP64czA4tDt+Kv21dZoUiHsQZEVN4v
 6XLzTe3V66SuOpiUG5BDoew3S7v499l9GyzYAFCIC89RcrDvFf14ShzgMHc+PdXiNlL/f9BEC
 qT64FhSDtjmG6Jfu0BNLJ6suu3JBanvesFzGsndoMBV12nIwXY2pn2l+qgGEJH772cYxbBbJe
 zLGOrJJ5KY8sFIkwJh19YsSevuyEsI3/twvEvzk15pm34vq6qT3YAKPtDrEaZlo9QLOT4A04K
 TeQH8pX5v6EcbxBUrAISuydWZtTMUhl7oOFQT28uYgEFhFOceM6Kky3FV3NxGS0q7OoT2CguO
 w8+oINtwGz+WYRqc62vFwLh9N24RKTolU40Shc6PqfgXpsB8dTQIWKOiO+LcVFiE36CgJmZZR
 N+Utx6LAhm5W4tbE28ZfMHwCJTRRQiEPlLNuplUSk1No8maxiiW+fLWbo5VYenFSIN8HnI/T3
 +FvNXkbMdsvTBWbQtEFRSgof1/OPqKiCs0bU1VYTtG6RDEgDCLCwNHYiHsiwadHBnItrNP3wW
 7UUAveVVg0dAvVa/LJ9n9u2+MtifcFk1m7465sRlOOJZYj5bjv5x+C3Td+TsCmAa7Su68S6TP
 Ri5eT+o5u9EAi02vjgJQnQYPWi7U3EEeFn7w/3X57l/R51JzHWGVsfQo3/wAYQfPcC2mIui5x
 N/Hs8pJG1k9BLC9Eb2WemNrD5IYzs8p8429xWSB5KfTL9NJnJUF19pbNOhVC54Sujuotoy7aG
 7//iRLSQhKY3FpdRS+ivRjyk0uQ8usKCksc+jM4sLmXxg7HD2gnfja4uVgxD1L2bfpdz1/Wvx
 jGw2s6osS+NGOD5cnv8a8P1l6lQ68/y0Fdn+ZOvTBIWx2AYeMDxxUaxp/+IzGTA0uWey9ESEQ
 vx9IjohP3QLlGEAumJo/M8fvgTtwFiwE6XF65aUc0AcNgbZ0NcE77
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/5/16 =E4=B8=8B=E5=8D=889:12, Nikolay Borisov wrote:
> When btrfs' 'filesystem' subcommand is passed path to an image file it
> currently fails since the code expects the image file is going to be
> recognised by libblkid (called from btrfs_scan_devices()). This is not
> the case since libblkid only scan well-known locations under /dev.
>
> Fix this by explicitly calling open_ctree which will correctly open
> the image and add it to the correct btrfs_fs_devices struct. This allows
> subsequent cmd_filesystem_show logic to correctly show requested
> information.
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  cmds-filesystem.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/cmds-filesystem.c b/cmds-filesystem.c
> index b8beec13f0e5..f55ce9b4ab85 100644
> --- a/cmds-filesystem.c
> +++ b/cmds-filesystem.c
> @@ -771,7 +771,18 @@ static int cmd_filesystem_show(int argc, char **arg=
v)
>  		goto out;
>
>  devs_only:
> -	ret =3D btrfs_scan_devices();
> +	if (type =3D=3D BTRFS_ARG_REG) {
> +		/*
> +		 * We don't close the fs_info because it will free the device,
> +		 * this is not a long-running process so it's fine
> +		 */

The comment makes sense, but I'm pretty sure we still prefer to clean it u=
p.

Just something like:

	struct btrfs_root *root =3D NULL;

	root =3D open_ctree();
	if (root)
		ret =3D 0;
	else
		ret =3D 1;
	close_ctree(root);

Despite that, I think the patch looks good to me.

Thanks,
Qu

> +		if (open_ctree(search, btrfs_sb_offset(0), 0))
> +			ret =3D 0;
> +		else
> +			ret =3D 1;
> +	} else {
> +		ret =3D btrfs_scan_devices();
> +	}
>
>  	if (ret) {
>  		error("blkid device scan returned %d", ret);
>
