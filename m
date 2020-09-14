Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E69A82689B3
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Sep 2020 13:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbgINLBp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Sep 2020 07:01:45 -0400
Received: from mout.gmx.net ([212.227.15.19]:45097 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbgINLBR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Sep 2020 07:01:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600081270;
        bh=6G76sIdVfW9c9pYEMN3g9T8YSLHwIkLFFq/zccB0824=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=NWZDy/ddu64vM7l8OXkY7WUiH+XUmLMX0gjCNuNnG9A4VvGAbPGK1zhIQ3nEiZQ9E
         BHYoG/H2Hbk8C+rKGTSDHjovlpGAEu+/vXgH9KqV4Gy6XgH3zJ2fQhePVic94sjbAB
         eu1llk5/Qp/XyBcERTcgOBmHWYc5/Cr9Sxbd0U3I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MXp5a-1k1FP62GgW-00YAQF; Mon, 14
 Sep 2020 13:01:10 +0200
Subject: Re: [PATCH v2 2/9] btrfs: Simplify metadata pages reading
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200914093711.13523-1-nborisov@suse.com>
 <20200914093711.13523-3-nborisov@suse.com>
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
Message-ID: <cffbc9ba-f63c-77ea-1516-da4da7043db3@gmx.com>
Date:   Mon, 14 Sep 2020 19:01:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200914093711.13523-3-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UNKCKv/1sUm6wI4M7iuambwYqZeIv+uLiuuZXTFEGZhTYdb1Ia1
 SaqGT4TYH6XO7A3ZxTAE+X3c+R7iZZDIYEOsHM2Bum6c4lKgOHCxNMHe3lKbTOoxJSldo4+
 XFoY7Vc9MhlE4Xm3+ehpAKcSRGEJOuW3gyqo/YnE9Ax1yL8VlorH31lSkJYYK/+tw5noGMk
 HlDOCTl5SRyMvPu93929Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lpa3Fg7ytDE=:Yx17gBvIv94mfuIQUqitzr
 KODoIlij7sBq8lL4KeYNdi9xfDA1dW7BjEuU5hyr2l2/Xt6VKY0K+8fMr/IxQwpS2/+Mz7hnG
 lBsMBz/uurZwkJD2eig4YZ8l6s6xfgL65tEEaXA0B0oOFKqSEStE6tQBlFY+AKD6FUicO9Py1
 KBsoqKLIpjJLHOfuF9gQFFQ44C/i/DaDwUqMgb16qYQhOTOCFgWcFwVJfoJzO3FQRLUzT/2Hg
 eYcc33Bdaw8lyMeE7ISx0051mq0zpf3NjB9KWc9gAMKWpgsiJyvctTJpgcvN/8gw9CF7/y5oY
 qwpzhUi79HQPn23LuwLqS15jVx5PVYOETqS+yjvsMDleRcTNJ/t1T0xgXcq5HBa0JSBs7+TEj
 LNxoVecaqYAjUNvUNEc9mjo8sVCmAGGsqG7pLzEXWrF9MXMZE++dUm6DUnjESS0RkpPK4nu3R
 WOW82PZq5HNZcEcz9YTMvhAKNgWgJP3rX0NQ6p1l+j5J1vZFylFVWnXoV+BBxi6pz2SJD2/sT
 ctvzCdS8HnrQMugdlHEKPInjehg81QDfICWU56icTip6jZ2smVsub8F2+X59TzwniwAiWZ0JB
 gUkZ0NfABmn0C4PVa5Fkgm4OCvLb66JmU1Klfb9yoneKr53lN0mjcNwPy8drudwQYmZ3ramYB
 +X2eHC1TuJJMnEjzmbnki4a3Cfn9+0kvV3nBouiGkWxPzRyxslYfwjIL9D2VdJTp1svWr3pgd
 PBTc5bJ+V/g9t2cJO90U3QYP+ax3HBnTCPGGudTwUlFXI83EGPNx73QmUu6GifGjS8tKP6mXI
 qnwctoX1FpmwNGPgYTBuSXVAkVz8lT5mwhiF0bUUAC4fz6Gu3ScDlf6L/5Sr7ls99b6vwYgm3
 ucnyp4MLDnhVOEhvbKUcBeqgk0FNml4H0HmMC4vKHCJUREW8OwRu88WkEJRNzQ/WZoA67n7Sl
 DGfaGzOHFVqCB0fuMMOmz2LuLOHyWGq2UvGrEfIaf4paLhFbA/smpDnT059iP7knZC9oOk1Xp
 GiQuKhrdN6V71dIFzVwH1blrJtyxFS7NxE3V32JMMQv3Arn/y1dZg8uL7K4tIjsOksLYeHtel
 075ITJ+pi3gVZqMDMkfXWO7xg5j77axw2dG5yir2zZh7Fm9EGluYi5oARi7hFyEOELzut/7tx
 KUf3IMDlcFdOPZiIZaatoFIyd73aFZO684tTKTjoSQq9r4+QSMyn+aw8fquUfTKeaASdXwP9+
 0fir0rH6hZa9R5GXplin0Q0Rj4Y49SUSChoJebA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/9/14 =E4=B8=8B=E5=8D=885:37, Nikolay Borisov wrote:
> Metadata pages currently use __do_readpage to read metadata pages,
> unfortunately this function is also used to deal with ordinary data
> pages. This makes the metadata pages reading code to go through multiple
> hoops in order to adhere to __do_readpage invariants. Most of these are
> necessary for data pages which could be compressed. For metadata it's
> enough to simply build a bio and submit it.
>
> To this effect simply call submit_extent_page directly from
> read_extent_buffer_pages which is the only callpath used to populate
> extent_buffers with data. This in turn enables further cleanups.
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>  fs/btrfs/extent_io.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index a1e070ec7ad8..0a6cda4c30ed 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -5573,20 +5573,19 @@ int read_extent_buffer_pages(struct extent_buffe=
r *eb, int wait, int mirror_num)
>  			}
>
>  			ClearPageError(page);
> -			err =3D __extent_read_full_page(page,
> -						      btree_get_extent, &bio,
> -						      mirror_num, &bio_flags,
> -						      REQ_META);
> +			err =3D submit_extent_page(REQ_OP_READ | REQ_META, NULL,
> +					 page, page_offset(page), PAGE_SIZE, 0,
> +					 &bio, end_bio_extent_readpage,
> +					 mirror_num, 0, 0, false);
>  			if (err) {
> -				ret =3D err;
>  				/*
> -				 * We use &bio in above __extent_read_full_page,
> -				 * so we ensure that if it returns error, the
> -				 * current page fails to add itself to bio and
> -				 * it's been unlocked.
> -				 *
> -				 * We must dec io_pages by ourselves.
> +				 * We failed to submit the bio so it's the
> +				 * caller's responsibility to perform cleanup
> +				 * i.e unlock page/set error bit.
>  				 */
> +				ret =3D err;
> +				SetPageError(page);
> +				unlock_page(page);
>  				atomic_dec(&eb->io_pages);
>  			}
>  		} else {
>
