Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616E03222C4
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Feb 2021 00:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbhBVXr5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Feb 2021 18:47:57 -0500
Received: from mout.gmx.net ([212.227.15.15]:37223 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231582AbhBVXr4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Feb 2021 18:47:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614037583;
        bh=dFU/66hMJoFpr7xUQ1WhTUXZb06H+ZTwNes4CBiVRFo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=T6N5BFLOYQNrss2dRbUbZ8GnBCGsYMbBXwLhTnjE2gJr+F3VgiWLOBm9qjvT0oElX
         t2C2JWCm/lINssCnuee9t+E6/LsKflGIIzL7dNsk4LtHPZLfSbVlfOHndjF/vN+hEg
         xtLgK8+7cqhTyNaYxqfc4ns+fLR2jWffTJqvK8pY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MfYLa-1llUvu1O9I-00g2Ix; Tue, 23
 Feb 2021 00:46:22 +0100
Subject: Re: [PATCH 4/6] btrfs: Cleanup try_flush_qgroup
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20210222164047.978768-1-nborisov@suse.com>
 <20210222164047.978768-5-nborisov@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <28c59e21-5de3-9936-6249-10d43f88e55d@gmx.com>
Date:   Tue, 23 Feb 2021 07:46:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210222164047.978768-5-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PDb6ieHbCAFqEymLAWiFzBVBxPgriIswkyQZsGw6Wv2z64YZXe3
 +lsVrxd6IZPTu0eewHMBcl0wuwAaw04IcHkzKKsnEzrsz/eZqPSlH/BZbSUKPhHptfQ6nJJ
 5fMj9upYwjIIG2JcBxLcYeFAj4hIZmREHnGY7E7t1Cy6U2Gdf+pGD7itSqZO/wWirVNGRqr
 mxCg9ElGBhlOeC7gVcWAw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VGEOwCg79FQ=:XAq8fktri8Ou2icoXe/di6
 WTRNagn6N3fiQHOyOTFUkO0Uz7weusRGUQclm/O3t9MCU9YjA6DqDEDcMUngVAk7Gg4MxRvGp
 OaxPquKdZ6m6FsBWNEhOjx7/FtWfsqOG5hgum8iH8IJM2Dge9lbx+zxNZpYZgbK/Ufgunq6zw
 DO/E3LRcEXiJnaJiFRdC66iCZOps+m2CqWFVdWgWFEP51hKL5F4C8+Bt6FFb1wB5f/WFxvlmL
 mFcf8URLPzSSYQzVLN2RnC15RQIgSpJBj3R3Q8wtq+jYXSw2XUipqZjLftXV6b7thApH9HUiv
 C3R6wltgg+cgRMg/+UIdOcNMQSPYMoRULhqwDLBzoOKuqhcWns3yAI+5hOjgxoayNoS1qqAk6
 pvTXTRr+x+ElsRjuldSNN5yz3iRnLGmBQQfbLHMLTvs19IZ8QGuG866DuJgogIV1G2T2ZGgrP
 Tckj+gY2O1ZDKQe+Ej7UO/JEcIUawLqcQXRObtAkLJZBkZEfMioXphn3zNvViDQEFZgNMSuYU
 g2xkA8BChVM4iC44Y6y+CmzuqGPPgJWLDIneSnw0GiMcNmtlsbP2G+ifOXQssRCqy/bwVDO9l
 C+zsJ1e6avtkk3TwWAkIKHzG68Tz5Q4n8N8OS3NeXxEoTNjQ44gq/NXBwZIl7AbDFq0PC88vn
 AC5FDyGnxpB1bcJF+2gNxB8MCjdJiJD5JRcUWKfxYJk+6s+s3KafflZYb4dLOk5pfQM/vxCOs
 nkR04eMGOk3di1ugCXEkJnNM0RrA+q4qhcyJYvD6mn9TWRGvIHw2uYsbHO48sje8o3GGGjbc8
 uAn3D8UKyKCcRuEzWU2sAu3ZCEcOVKNrJvw61wcLyRc8IWQLzh1xPRss1cHO8wvRMcxOFKK4D
 Pk0Qvte7DJaOsRcHZMYg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/2/23 =E4=B8=8A=E5=8D=8812:40, Nikolay Borisov wrote:
> It's no longer expected to call this function with an open transaction
> so all the hacks concerning this can be removed. In fact it'll
> constitute a bug to call this function with a transaction already held
> so WARN in this case.
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/qgroup.c | 35 +++++++----------------------------
>   1 file changed, 7 insertions(+), 28 deletions(-)
>
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index fbef95bc3557..c9e82e0c88e3 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -3535,37 +3535,19 @@ static int try_flush_qgroup(struct btrfs_root *r=
oot)
>   {
>   	struct btrfs_trans_handle *trans;
>   	int ret;
> -	bool can_commit =3D true;
>
> -	/*
> -	 * If current process holds a transaction, we shouldn't flush, as we
> -	 * assume all space reservation happens before a transaction handle is
> -	 * held.
> -	 *
> -	 * But there are cases like btrfs_delayed_item_reserve_metadata() wher=
e
> -	 * we try to reserve space with one transction handle already held.
> -	 * In that case we can't commit transaction, but at least try to end i=
t
> -	 * and hope the started data writes can free some space.
> -	 */
> -	if (current->journal_info &&
> -	    current->journal_info !=3D BTRFS_SEND_TRANS_STUB)
> -		can_commit =3D false;
> +	/* Can't hold an open transaction or we run the risk of deadlocking. *=
/
> +	ASSERT(current->journal_info =3D=3D NULL ||
> +	       current->journal_info =3D=3D BTRFS_SEND_TRANS_STUB);
> +	if (WARN_ON(current->journal_info &&
> +		     current->journal_info !=3D BTRFS_SEND_TRANS_STUB))
> +		return 0;
>
>   	/*
>   	 * We don't want to run flush again and again, so if there is a runni=
ng
>   	 * one, we won't try to start a new flush, but exit directly.
>   	 */
>   	if (test_and_set_bit(BTRFS_ROOT_QGROUP_FLUSHING, &root->state)) {
> -		/*
> -		 * We are already holding a transaction, thus we can block other
> -		 * threads from flushing.  So exit right now. This increases
> -		 * the chance of EDQUOT for heavy load and near limit cases.
> -		 * But we can argue that if we're already near limit, EDQUOT is
> -		 * unavoidable anyway.
> -		 */
> -		if (!can_commit)
> -			return 0;
> -
>   		wait_event(root->qgroup_flush_wait,
>   			!test_bit(BTRFS_ROOT_QGROUP_FLUSHING, &root->state));
>   		return 0;
> @@ -3582,10 +3564,7 @@ static int try_flush_qgroup(struct btrfs_root *ro=
ot)
>   		goto out;
>   	}
>
> -	if (can_commit)
> -		ret =3D btrfs_commit_transaction(trans);
> -	else
> -		ret =3D btrfs_end_transaction(trans);
> +	ret =3D btrfs_commit_transaction(trans);
>   out:
>   	clear_bit(BTRFS_ROOT_QGROUP_FLUSHING, &root->state);
>   	wake_up(&root->qgroup_flush_wait);
>
