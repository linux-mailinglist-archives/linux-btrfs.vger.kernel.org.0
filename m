Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64213243937
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Aug 2020 13:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgHMLRU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Aug 2020 07:17:20 -0400
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:35809 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726100AbgHMLRQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Aug 2020 07:17:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1597317430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=v4HjdKO4+DmLlcZDSLXO7u9GNcnFRlzqyjqISyuddi4=;
        b=LVpgTT9dx6M89ObZlFqQvnN/gfW8mutK5qzrbEB6SaNCl3YJuJxrageD4ysk/R9w3gFtCs
        1t3vkyzVmyGFDFh+fy99MitCnmW1rTayt0giC9fFBpuvzd0beXUWTCqUm69qdAtZf5RApZ
        D/RRqqg07BpOsCndQqvelTUF488HIrk=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2059.outbound.protection.outlook.com [104.47.5.59]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-17-E-vlLAzCP6KyxwSxZaGcAg-1; Thu, 13 Aug 2020 13:17:08 +0200
X-MC-Unique: E-vlLAzCP6KyxwSxZaGcAg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VDxQKmtg5MoLidTJfL3TvL4wmRgh0HyOwZk0c9q97BZyS60mgW8te5nmJ53Xq0bc2csgtXtQf1I+nBhBEMLj9QhY2neLQNOHyDukqq5yev3JmS2S0+X0pDxuSxwER7YkhU1LVNbEX3N0F3FKErgApjs31pWTzvCMqNzwQs+MU7JYIHkB/LOufj29eM6Yzj/RwuFkCbL4CokSPMkoVH+i9N7w1htq9RWcvC0ZWDkLrgUHRGSlGkngSq13uT01q75f004YkYMIeK+XZXqw28V9pgoSAN+8/CItFQMABkH7jmyVOVm1a9qqCH4eE7hT/z5PqgQdIYZnr2+lqv8irWHKNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4HjdKO4+DmLlcZDSLXO7u9GNcnFRlzqyjqISyuddi4=;
 b=jZ9Id6Kiq2MLfRZlHqiGKCULSfxGjkbV6psunHdD3a/2pNoodfilWOQ1yRnt52csZlRPvgJ5b1vRlwo+lNtLt15R8JlJwcGluuzz21TkcU2WMlLHr3P+p2SwBoM1ew/j7/pwStOeHpSjxr6ID4PAKViXPEEAVNu349cjTK/kmmDX4uOX9hZEPsqAOzvBephVZQQmE21i4qL6A4adC5sxo47T7yBJMRmOEVPfh/GNjB/21atwJJ5KdgLKSZcfeTb8KGIkpUCKnNP0DKLnollMKRHIA/RLlrQp9fneQbzc9ZVjAfMhi/WWEmPFQmgvDdwAwa7CjlxbE5QMuH0ptcv8tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
 by AM0PR04MB4642.eurprd04.prod.outlook.com (2603:10a6:208:74::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Thu, 13 Aug
 2020 11:17:07 +0000
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e49c:64ce:47e0:16]) by AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e49c:64ce:47e0:16%3]) with mapi id 15.20.3261.026; Thu, 13 Aug 2020
 11:17:07 +0000
Subject: Re: [PATCH] btrfs: refactor how we prepare pages for
 btrfs_buffered_write()
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <20200807072753.68285-1-wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0GFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPokBTQQTAQgAOAIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJdnDWhAAoJEMI9kfOhJf6oZgoH
 90uqoGyUh5UWtiT9zjUcvlMTCpd/QSgwagDuY+tEdVPaKlcnTNAvZKWSit8VuocjrOFbTLwb
 vZ43n5f/l/1QtwMgQei/RMY2XhW+totimzlHVuxVaIDwkF+zc+pUI6lDPnULZHS3mWhbVr9N
 vZAAYVV7GesyyFpZiNm7GLvLmtEdYbc9OnIAOZb3eKfY3mWEs0eU0MxikcZSOYy3EWY3JES7
 J9pFgBrCn4hF83tPH2sphh1GUFii+AUGBMY/dC6VgMKbCugg+u/dTZEcBXxD17m+UcbucB/k
 F2oxqZBEQrb5SogdIq7Y9dZdlf1m3GRRJTX7eWefZw10HhFhs1mwx7kBDQRZ1YGvAQgAqlPr
 YeBLMv3PAZ75YhQIwH6c4SNcB++hQ9TCT5gIQNw51+SQzkXIGgmzxMIS49cZcE4KXk/kHw5h
 ieQeQZa60BWVRNXwoRI4ib8okgDuMkD5Kz1WEyO149+BZ7HD4/yK0VFJGuvDJR8T7RZwB69u
 VSLjkuNZZmCmDcDzS0c/SJOg5nkxt1iTtgUETb1wNKV6yR9XzRkrEW/qShChyrS9fNN8e9c0
 MQsC4fsyz9Ylx1TOY/IF/c6rqYoEEfwnpdlz0uOM1nA1vK+wdKtXluCa79MdfaeD/dt76Kp/
 o6CAKLLcjU1Iwnkq1HSrYfY3HZWpvV9g84gPwxwxX0uXquHxLwARAQABiQE8BBgBCAAmAhsM
 FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2cNa4FCQlqTn8ACgkQwj2R86El/qhXBAf/eXLP
 HDNTkHRPxoDnwhscIHJDHlsszke25AFltJQ1adoaYCbsQVv4Mn5rQZ1Gon54IMdxBN3r/B08
 rGVPatIfkycMCShr+rFHPKnExhQ7Wr555fq+sQ1GOwOhr1xLEqAhBMp28u9m8hnkqL36v+AF
 hjTwRtS+tRMZfoG6n72xAj984l56G9NPfs/SOKl6HR0mCDXwJGZAOdtyRmqddi53SXi5N4H1
 jWX1xFshp7nIkRm6hEpISEWr/KKLbAiKKbP0ql5tP5PinJeIBlDv4g/0+aGoGg4dELTnfEVk
 jMC8cJ/LiIaR/OEOF9S2nSeTQoBmusTz+aqkbogvvYGam6uDYw==
Message-ID: <c0f45593-5733-29f1-e86e-cfa18091f470@suse.com>
Date:   Thu, 13 Aug 2020 19:16:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <20200807072753.68285-1-wqu@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vqtO0MtjhZsYCVUBKzBp6Gh2YFpQzjseW"
X-ClientProxiedBy: BYAPR08CA0070.namprd08.prod.outlook.com
 (2603:10b6:a03:117::47) To AM0PR04MB6195.eurprd04.prod.outlook.com
 (2603:10a6:208:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR08CA0070.namprd08.prod.outlook.com (2603:10b6:a03:117::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend Transport; Thu, 13 Aug 2020 11:17:05 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d994068a-5252-4c5a-bd57-08d83f7a6a0d
X-MS-TrafficTypeDiagnostic: AM0PR04MB4642:
X-Microsoft-Antispam-PRVS: <AM0PR04MB464268D77205265677CF869BD6430@AM0PR04MB4642.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:669;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hHWbFU7IGGH3cZtCbziRd9uRqiXFLH5yy8IJrvNr/JQTFTEFLPuLjgKA2TsIq18LGGI7WDVrXt44QlptExcRqEuGutiEAcQuuKEZhvKx12lvON+VBDevQxAKTh8xHxQ47zMGxs1ETosuKbNVgs0Qca4H7a0jtzkUVrs0EG2fj08/lu4aRfcpoeaGwnLxgUfrObHibPBKwD3d6HgZdCHz2ht+TLCrZjQ8y+zu6PoxgDj89WnfPYwSAU5F0QA3tSGHQ+Re+iLcEzQzH+AZ1mKTtQlpgYgp2uvPGO5j/3EmIFnVdHnrrCcPTwIRfvnVPlDkB8RCgjh6qOHmS7w5LMo/hhAMXhvvKtYLFNcYuNCJ2uQ0PGLPePfBjL4DpovM4X1H4es4R24RAAbZLJa4LRomLo6yQRQ1IDL0cIhi/DZ0Jz0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6195.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(346002)(136003)(39860400002)(366004)(396003)(8676002)(2906002)(186003)(31696002)(66946007)(6666004)(66556008)(36756003)(66476007)(26005)(8936002)(16526019)(5660300002)(6916009)(235185007)(6706004)(6486002)(478600001)(86362001)(956004)(83380400001)(2616005)(21480400003)(316002)(33964004)(31686004)(52116002)(16576012)(78286006)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: uNsNi0dik0SAjOgvgiWMt8/wTVcuw934QwUhqMXWol5RRFEq2PriSd1MhkXkbwEeb+RMdQbx+1fFmnjdsUZpmcYCoVyb7F/MMR7Vdw5V/K3i+LH6TMGdtrPWphv8PgTiktZ4doKI53NnHfDTSqiIAiwwX1bcbR2ODLSpSBzqtJEynQVc5K8zIO8Zh7/3Eh48BFZJSS6zNXCr5n14bPeFfdjgi5wtAL7pvzjXX/9RLvaV0ymN1bDvA7qeHqDgoEcrsciaW8avTwWDTi6u56LwtBPOiYF8SQwF8bN2nsTvFQWgHP/y1S9cKHVAvz08/oE/T6IGu1/wRpTB4VcIGw8cWE176dKVP4fEPa8/ul73Cx3bxU2Ioi7I49kF/NYnmfgiq8sGB/yTvpK+NFWTZDTQqfI+FgzEMx0DNK0QJWSLZFpigyqCjPWxoDfbj4xt7xa1VEU+rjl83BrYAjsDNw0beOra4fJWqca8B4HF3YFIEIk4YCCpzjxasvWqTs6M9zVAW80kfnrfS8nawtllEbYVTm+9BNT4ge1Rn4kdb2m4ccht/El4wKHoKdb/sm1GhG7WdyIhbXXZorfLEdYjwgeXMtKPESH/Ax5qkWesaJABXPT/0HI25nB84UslRCyc8h1/pRYoMieCkg3/Qxk7tlfeQQ==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d994068a-5252-4c5a-bd57-08d83f7a6a0d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6195.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 11:17:07.2869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 54mYl2sXpiVycV+cNx0x/93a5yOSmDU/4waC97vn2hSnF/8d1wqelYvDezJZACwK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4642
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--vqtO0MtjhZsYCVUBKzBp6Gh2YFpQzjseW
Content-Type: multipart/mixed; boundary="tswFY128Q8cOSEQp5bS4oWu3UZyGkjkos"

--tswFY128Q8cOSEQp5bS4oWu3UZyGkjkos
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/8/7 =E4=B8=8B=E5=8D=883:27, Qu Wenruo wrote:
> When we prepare pages for buffered write, we need to ensure that if
> we're partially dirting a page, then it must be uptodate to make sure i=
t
> has the old content read from disk.
>=20
> While for pages that is completely inside the write range, we don't nee=
d
> to make it uptodate at all, thus we can skip one page read.
>=20
> The old method uses @force_page_uptodate flag, but in fact it doesn't
> make any sense at all.
> In parepare_uptodate_page() it has the check to ensure we always force
> a paritially written page to be uptodate.
>=20
> So this patch will refactor the mess, to make it more easier to read by=
:
> - Remove the @force_page_uptodate bit
>   It makes no difference at all
>=20
> - Remove the @pos and @force_uptodate for prepare_uptodate_page()
>   Now the caller, parepare_pages() will determine if it's necessary.
>=20
> - Add more comment for parepare_pages()
>   This will explain why we don't need some pages to be uptodate.
>=20
> - Use page_offset() to be more user-friendly
>   After find_or_create_page(), page_offset() will return the offset
>   inside the address space, thus can be used directly to be more
>   reader-friendly.
>=20
> The new code uses the following method to do such check:
>=20
> 	full_dirty_page_start =3D round_up(pos, fs_info->sectorsize);
> 	full_dirty_page_end =3D round_down(pos + write_bytes,
> 					 fs_info->sectorsize) - 1;
> 	for (i =3D 0; i < num_pages; i++) {
> 		...
> 		if (!err && !(page_offset >=3D full_dirty_page_start &&
> 			      page_offset <=3D full_dirty_page_end))
> 			err =3D prepare_uptodate_page(inode, pages[i]);
> 	}
>=20
> Which can handle all the possible cases like:
> - Dirty range in side a page
>   || |///| ||
>   Then @full_dirty_page_start > @full_dirty_page_end, and it result wil=
l
>   always be (!err && !(false))
>=20
> - Dirty range across one page boundary
>   ||   |///||//|     ||
>   Then @full_dirty_page_start =3D=3D @full_dirty_page_end + 1, the same=

>   as above case.
>=20
> - Dirty range covers a full page
>   ||   |///||////////||//|     ||
>   Then only for the 2nd page meet the condition, and skip the
>   prepare_uptodate_page() call.
>=20
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Please discard this patch too.

It turns out that, some forced uptodate operations are needed. Reason
inlined below.

There is still something useful, like the partial written range check,
but it breaks the original behavior with some very rare iov combinations.=


> ---
>  fs/btrfs/file.c | 40 +++++++++++++++++++++++-----------------
>  1 file changed, 23 insertions(+), 17 deletions(-)
>=20
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 841c516079a9..705ebe709e8d 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1378,13 +1378,11 @@ int btrfs_mark_extent_written(struct btrfs_tran=
s_handle *trans,
>   * on success we return a locked page and 0
>   */
>  static int prepare_uptodate_page(struct inode *inode,
> -				 struct page *page, u64 pos,
> -				 bool force_uptodate)
> +				 struct page *page)
>  {
>  	int ret =3D 0;
> =20
> -	if (((pos & (PAGE_SIZE - 1)) || force_uptodate) &&
> -	    !PageUptodate(page)) {
> +	if (!PageUptodate(page)) {
>  		ret =3D btrfs_readpage(NULL, page);
>  		if (ret)
>  			return ret;
> @@ -1406,14 +1404,29 @@ static int prepare_uptodate_page(struct inode *=
inode,
>   */
>  static noinline int prepare_pages(struct inode *inode, struct page **p=
ages,
>  				  size_t num_pages, loff_t pos,
> -				  size_t write_bytes, bool force_uptodate)
> +				  size_t write_bytes)
>  {
> -	int i;
> +	struct btrfs_fs_info *fs_info =3D BTRFS_I(inode)->root->fs_info;
>  	unsigned long index =3D pos >> PAGE_SHIFT;
>  	gfp_t mask =3D btrfs_alloc_write_mask(inode->i_mapping);
> +	u64 full_dirty_page_start;
> +	u64 full_dirty_page_end;
>  	int err =3D 0;
>  	int faili;
> +	int i;
> =20
> +	/*
> +	 * || =3D page boundary
> +	 *
> +	 *     @pos                   @pos + write_bytes
> +	 * ||  |///||//////||/////||//|   ||
> +	 *	    \		  /
> +	 *           In this range, we don't need to the page to
> +	 *           be uptodate at all.
> +	 */
> +	full_dirty_page_start =3D round_up(pos, fs_info->sectorsize);
> +	full_dirty_page_end =3D round_down(pos + write_bytes,
> +					 fs_info->sectorsize) - 1;
>  	for (i =3D 0; i < num_pages; i++) {
>  again:
>  		pages[i] =3D find_or_create_page(inode->i_mapping, index + i,
> @@ -1424,12 +1437,9 @@ static noinline int prepare_pages(struct inode *=
inode, struct page **pages,
>  			goto fail;
>  		}
> =20
> -		if (i =3D=3D 0)
> -			err =3D prepare_uptodate_page(inode, pages[i], pos,
> -						    force_uptodate);
> -		if (!err && i =3D=3D num_pages - 1)
> -			err =3D prepare_uptodate_page(inode, pages[i],
> -						    pos + write_bytes, false);
> +		if (!err && !(page_offset(pages[i]) >=3D full_dirty_page_start &&
> +			      page_offset(pages[i]) <=3D full_dirty_page_end))
> +			err =3D prepare_uptodate_page(inode, pages[i]);
>  		if (err) {
>  			put_page(pages[i]);
>  			if (err =3D=3D -EAGAIN) {
> @@ -1638,7 +1648,6 @@ static noinline ssize_t btrfs_buffered_write(stru=
ct kiocb *iocb,
>  	int nrptrs;
>  	int ret =3D 0;
>  	bool only_release_metadata =3D false;
> -	bool force_page_uptodate =3D false;
> =20
>  	nrptrs =3D min(DIV_ROUND_UP(iov_iter_count(i), PAGE_SIZE),
>  			PAGE_SIZE / (sizeof(struct page *)));
> @@ -1727,8 +1736,7 @@ static noinline ssize_t btrfs_buffered_write(stru=
ct kiocb *iocb,
>  		 * contents of pages from loop to loop
>  		 */
>  		ret =3D prepare_pages(inode, pages, num_pages,
> -				    pos, write_bytes,
> -				    force_page_uptodate);
> +				    pos, write_bytes);
>  		if (ret) {
>  			btrfs_delalloc_release_extents(BTRFS_I(inode),
>  						       reserve_bytes);
> @@ -1763,11 +1771,9 @@ static noinline ssize_t btrfs_buffered_write(str=
uct kiocb *iocb,
>  			nrptrs =3D 1;
> =20
>  		if (copied =3D=3D 0) {
> -			force_page_uptodate =3D true;

This is here to prevent the following problem:

One page is completely covered by write range, but the write range
inside the page is split into two iov.

In that case, if the later part failed to be copied, we will hit a short
write.
Originally we will set force_page_uptodate, then falls back to nrptrs =3D=

1; with force_page_uptodate =3D true;

Then in the next loop, we will force to read that full page to avoid
garbage in the partial written page.

This is indeed super rare, thus all my fstests run haven't triggered it.
But in theory, as long as we have differnt iovs supported, it should
still be possible.

Thanks,
Qu

>  			dirty_sectors =3D 0;
>  			dirty_pages =3D 0;
>  		} else {
> -			force_page_uptodate =3D false;
>  			dirty_pages =3D DIV_ROUND_UP(copied + offset,
>  						   PAGE_SIZE);
>  		}
>=20


--tswFY128Q8cOSEQp5bS4oWu3UZyGkjkos--

--vqtO0MtjhZsYCVUBKzBp6Gh2YFpQzjseW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl81ISAACgkQwj2R86El
/qhEbQf/WStXxMqpCeZ8nUNUm2fHflzgiLGl3i4v+sOp9tCTPRzjBReBY5nfFC6e
Iw6I2IkIvdfvOfObp8a/V6drcHKD3PtRdZ1MPsty+nfw0XhDu7RBYAAp59QLoz6Y
tVKZjNRm+39T9qBamrOY3E0hE5TbJ5bmUEjYEB5/1q2smC11/sZxoMbxdknn7WVm
PJudxgRAq9F+eoMq82nCyen4BeaFxgGI1Ted+3A+UJWcPIw5Cmh2ZQoK8Y1j/w1V
EoMGX8lzCUkstKbUBi6nJLVTqJBGcUlR0jstueFlw1wHgcOFSnjHo2DKd9sp/uup
fRu1lwfQ4MyUwOeXNyZSZsuGbToqrA==
=ga0m
-----END PGP SIGNATURE-----

--vqtO0MtjhZsYCVUBKzBp6Gh2YFpQzjseW--

