Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7803452A8
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Mar 2021 23:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhCVW5x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Mar 2021 18:57:53 -0400
Received: from mout.gmx.net ([212.227.17.20]:58753 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230190AbhCVW5X (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Mar 2021 18:57:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616453839;
        bh=S0K00jKu7y2uzoscj68X5OaopkLnGqlchz+DnQB/lD8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=b2+WI7uBo9rhaqmaflLdJlAuDsT9le1repHw67GozyxoezbIyCTQJR477lKBaKsdQ
         8jrlK38UX2YfRMRbPCQkQe6Z89lNJpGQp1D7m08LIlytA5o0EXgmCMFYRbia7F59Ym
         QtmHbesRC4wM/aZOb8bRt1KozH0yh3b5o6QADYjo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M59C8-1lPZwg0joq-001EGB; Mon, 22
 Mar 2021 23:57:19 +0100
Subject: Re: [PATCH] btrfs-progs: qgroup: remove outdated comment
To:     Sidong Yang <realwakka@gmail.com>, linux-btrfs@vger.kernel.org
References: <20210322140316.384012-1-realwakka@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <4736ee1f-2749-87df-e357-ff785b511087@gmx.com>
Date:   Tue, 23 Mar 2021 06:57:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210322140316.384012-1-realwakka@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3EXZ+SuLXx9FSQB+gP230xkdHIR/c1wAMpPviPHtbBesBAqqsqO
 AOKGONYiyfW+DAP9gIjMIbqdP3okqs3nD4uH2I9aqBAkTQHyK0NONq1apRf7xE4h8T5epPl
 K0BPyzJhA4MQWOexXtzRCT+fpGKXWYiREDMcLpCRc8dxOrJwbPYVDZt+vlM2kr4frGvwh78
 bWFfvNQYb+GQUbE0+tyOA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6AcOFkbkxhM=:Kv3gFy603fg6i8c6r+fIYP
 Ej7loBbJg0gLWRDqGXsAJiHu2z469kQZRHvbYyqPMtkYnzDJNFmq0azgms8ZDY7eTQL1SnGq0
 uTX9JplWsV4CgK6giaGKKSoAAD4sh/ek7UM/sTt39U/GGVEWkfCjkJk0EqClkFBnsUGjnHYP4
 oJnvngOW2be7NFtZT8bkH3eyBhWYfydDpOsCXPfItMi5cW3MYU8o+utwZ3B1zc9cTtpFbbn85
 t4kqABhQH/v6dbBLfoMju/vZnvQQ8T7uEvPH6rGpMLItbMVa0L3mYQPjb90RL2j0HgD4vKeIu
 9okszfuy1nweRP+NkGXBdjJ90PJF97kqQsOlrEkww0I8aIKECY6iN2rOrqZboUOhxmnfj0O10
 +8LYw7kqFyv5llR2qiYK9CWLhCOWo6/jVfPNH4EYB/L99w9CRPgG59tHgqrdhINvvhMYujJWj
 w8+lxnJsdDXqRk4QO6MWVk0u1ci5FDAdEE9ZBTDkPQVcx4Qg/jxKxz0XQT5eoS2vxLdQUeKaf
 E5UnBs6rrbtHVgn1ZgdPAoIqqkSfbPlkJ1dIm5OCCcjwNBwu4I55J6CLNVvO8ey/TZLqYfguZ
 xAR+KnYWbfddc5RJ0lNpfo24M35j9ANCidxsjsR5ottPTSdaA4332uKExm69DzrzotS2En8YJ
 Mg0RSlc04NCRSRC3G/gDZsJeDmv58pVUlnIZZIo24i6OMS4uaWXpGsZzYRx4VhJHVdMJfPlIW
 ADLS9wxF+M4pFaqhMqQzn9cY44mVUWZ7BRCd88upd09oREIqGNkSOMDr8gT2eVWJKM8KBHg+V
 ewvTKMQ8lYcTn+TBiMro9CMcRnfrS0QXQcB5HxnpN+5m2inITcHrbSbJlfjhGY01U50n2C6zY
 P3Y1B+8sMAW6i+mDt4bWw7PsgNC6vtdh8Sub2w+jeAKY96iL3C2crDQ+07XfSAetYXamY81Il
 nC93tNvu5hJt0r8SX6du0D+P5GVxAKKvKGrwbIWdulJ6tyYDbaPQRCoxQBUaxjIdc5jElL/ih
 LxzO7K+Gc/OadD2/NsABdTScNbvtjTa9zBF08gylc01LjZv+E4k8J4K3aRP3Kw6p4Q00e2cTG
 9kLUbg4kQOqfnEdqaJZ07WDGZimn0gaLG1RSZpoWoNCCVAJHngLmGRPFySF7mjkwoiPCNLTUg
 NUDg2ZPQgzwFprN9qmgtoCwwuBlwvAE6LUXrtf45vHM6zKxCZTBkA/bQiphQTIVrV42agdnzs
 lw8Kw5mIFH4+ox6dX
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/3/22 =E4=B8=8B=E5=8D=8810:03, Sidong Yang wrote:
> This comment is outdated and this patch remove
> it to avoid confusion.
>
> Signed-off-by: Sidong Yang <realwakka@gmail.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   cmds/qgroup.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/cmds/qgroup.c b/cmds/qgroup.c
> index 2da83ffd..b33f77fa 100644
> --- a/cmds/qgroup.c
> +++ b/cmds/qgroup.c
> @@ -81,9 +81,6 @@ static int _cmd_qgroup_assign(const struct cmd_struct =
*cmd, int assign,
>
>   	path =3D argv[optind + 2];
>
> -	/*
> -	 * FIXME src should accept subvol path
> -	 */
>   	if (btrfs_qgroup_level(args.src) >=3D btrfs_qgroup_level(args.dst)) {
>   		error("bad relation requested: %s", path);
>   		return 1;
>
