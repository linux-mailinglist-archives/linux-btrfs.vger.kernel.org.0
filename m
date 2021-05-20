Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFFB389AC3
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 May 2021 03:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbhETBJm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 May 2021 21:09:42 -0400
Received: from mout.gmx.net ([212.227.15.15]:44189 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230049AbhETBJk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 May 2021 21:09:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1621472893;
        bh=IK4Lx5sZTtvoKkLvNYMpx7tYlbV6YCE/gMPzPr/qR74=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=kPGundGCHNfBUZnnVDueJxBUol//PQPPwdiWbSIMrVvvE/liQ84tEKyejoBxUfF+g
         QW2sK45eUTt5g8K9fTm3SvHAbfPKZbkre0qXH80QkfishHwLd2vncWJEwyn3SWJ9Wf
         f/4VAa3CqsTJYBsYGX8PaVPW0xrYnsuNk9BS4TbY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MulqD-1lS8mF0SLz-00rmdI; Thu, 20
 May 2021 03:08:12 +0200
Subject: Re: [PATCH] btrfs: abort the transaction if we fail to replay log
 trees
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <9513d31a4d2559253088756f99d162abaf090ebd.1621438132.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <bdf7c194-c14b-1b36-02ad-e67743fbbfef@gmx.com>
Date:   Thu, 20 May 2021 09:08:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <9513d31a4d2559253088756f99d162abaf090ebd.1621438132.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xGL5qo+yC48Br4d1ZxTxZjxVd1K6lJbVZDKOAopyV3368XBplum
 Hg6PrHKBQaEmjQuY+zyH6Sf+bizpTDwf0vNZTeN9tgGZG3lZmMYdnqbNv9qj6P6wDkVljMD
 SpO/VUouWA03zTesrVTzh6XlyY0BSpJa2eiFOF+RKbkXOCqmoghI7NLjo46aeUn5twH9L1I
 CyhV77aZlbZ7zeoCkjrRg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hBdGU/oFHeQ=:0RP4Q5CFj+crRsQzuKY0ZJ
 2MG4PGDfeg72mJYkc1fEQfI/M8v+sxq1KziJ4tj4bJKpebt2eNGt98Q/SOdu4kL3YOYIEAfH6
 ca2RJx/8vGK7xUdZo4NdnJSeye6jzJBKAPdNHEvE6EUflkcNeqkfHcphOyjkK4a7uSX+aO0df
 ZJXvdPoljTtJ7bKYgIjDOB6feTqJhiDErCiaPn7lMFnm6btQHHnbyXSMYRBi+QWQTHJ+Zk/+E
 LiXKUBuvdawI7SI3Sl8v8HV9obYWLAZAPOlE7VJphVZORUULuRm3XPcKRaKOgvIOz0zMs3JqC
 63UorOI2kHe2CxHjza3vowibVo2Yhvj/q4nX+aQ/ybr75/ZT9qAI4dnTkTbThSSDHMXJt9zMZ
 IoAWVmit1oKq4zkmCYLk8/uVdnAgqrivclTpHo7S+/8kO97A8lQRZTWHsdIzvZaVI9e0wrEiN
 c2v7O3azH/HUM/9rgvsjp/1/qXXSLqbWtA4f1bDnIUi0kSoCNGAllMzD/MoBitBZrBGxxGwTd
 dFAQfE23DOq1uDwGexbADZZU52NHus0qOG0iuH/LQTrzGjf2P059CxjVeTaNxCDV5rLz6jsyn
 dDd28oLLvVlNStdi85YjKM4JX8BCqN65i3fApVdRQaM2PaJCZ6rIPUyNJlwVXeJvkq3mF2ylv
 v3ueaUQ4Hyu5yAJ9vxIEj87lVN9/AkqmGJF4MXc4EG5Lve46rKTKrJm9qXdnV42qNHfzI0+n9
 CPpU0XA27CwseVBl0ACPtGTetq5J7kQB59RRMy9p3ZbKSavfi/IKodf/bCVPDkxAs5JPvqy8J
 WI5n9BFp42GFLcXxNDX90tgA6AvFdJnRMZF8xHfrzn4MfDUEU6WzzDOz8ZnDIFvLVOHfswFRr
 wEOS8kxmUHjdyCHVlX7FEqSqgjsAfqD35V5udB+Wu3oYyiz9UdqgH6cE82zVOqiFFXWb+siX8
 2Ozi0V0F9aUzE/Z4d5umwyrL+inwFeeN20zH9xfNaKKPtPq8d42ZnfRcv2woWNWO8D/YKnEMk
 NJiJkrAu4cURqRSIYHqBvfzS9dqwH2hXZiWho3MRYCEtao4SnpXSndlyh8sjxIN44+vg0BwMJ
 r1si53BPQ+4+pyGkTb6w6kyTK2ih4U6uK60rFTQneObnCC+WK5riygD+jImUYC3MwrJsvclc1
 au5CCIXcDf1YVLcht9C3lcOt/AEiE68SlxGSYSmFiQcxgoYM/NK9oUP+sU+EHMqpVRmLlH2J0
 vV2se1CuU84MhtWDl
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/19 =E4=B8=8B=E5=8D=8811:29, Josef Bacik wrote:
> During inspection of the return path for replay I noticed that we don't
> actually abort the transaction if we get a failure during replay.  This
> isn't a problem necessarily, as we properly return the error and will
> fail to mount.  However we still leave this dangling transaction that
> could conceivably be committed without thinking there was an error.
> Handle this by making sure we abort the transaction on error to
> safeguard us from any problems in the future.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/tree-log.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 4dc74949040d..18009095908b 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -6352,8 +6352,10 @@ int btrfs_recover_log_trees(struct btrfs_root *lo=
g_root_tree)
>
>   	return 0;
>   error:
> -	if (wc.trans)
> +	if (wc.trans) {
> +		btrfs_abort_transaction(wc.trans, ret);
>   		btrfs_end_transaction(wc.trans);
> +	}
>   	btrfs_free_path(path);
>   	return ret;
>   }
>
