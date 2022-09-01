Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB945AA335
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 00:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbiIAWiW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Sep 2022 18:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbiIAWiU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Sep 2022 18:38:20 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1397F58DCF
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 15:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662071893;
        bh=Gwx+xXurBZGQMHCBkvd8wMIq0v/q7cQ8XPXY8ocltfI=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=i7LqgCivdlKT+3YpetErAP7GauKk0XGFJyPJXG7TCZLiAy831ZKPULpg1Mrpx+lSR
         8JtwiU0cUSqDb43W67HNRdx8HOk9q0RXOtRE8HHql+eCCJVNcdAcO3s6hfGxXgVsKB
         Qi1lS1CHsmBrAkeLDl09XT4vibRw+U3G842Fcaag=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N6KUd-1pRAYH31w1-016jZk; Fri, 02
 Sep 2022 00:38:13 +0200
Message-ID: <edaba4d4-22ca-fad8-67c0-4c9736b0815c@gmx.com>
Date:   Fri, 2 Sep 2022 06:38:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1662022922.git.fdmanana@suse.com>
 <dd926ea5086a8c5d0bd627bb07d8f83eb492a2f6.1662022922.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 05/10] btrfs: properly flush delalloc when entering fiemap
In-Reply-To: <dd926ea5086a8c5d0bd627bb07d8f83eb492a2f6.1662022922.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0IL1ArMIyHiXPrMaZBOvsAuKZyI3LA2u7JFVwtOHIHUYr0NQV43
 3/gw+XhNykeU4LBB8DqpwCJYmVN36w7P7OXA2ol0aa4WpIf7UXhL0JsJLqSlnXJJlaencvW
 BZv4+AmahofKa80winuKH37Xo37TuRBPAy63NMONz95T7UbHuC9fEZZOX874+PHE2weM4ZX
 z6zEo/+KWQdgPYIJyQLBQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lwhrTcyJWPI=:Eu6F1IKEcO7jpcUCvMwRoa
 rMtrhTdOwsyt7eXvgW9lRntJTTGtlRqv0VYuTYMnX/kxMhHx9OoF8rCWxRhYGnBxCjxQGS2hx
 +faZTLJJonhs2E/juUUqOZmxtCNNGUdfN+k4dz7CRJ1eiZ+/8gbfUZPPca1XiJQ7yYr+AlJ4S
 NsBjmSyTEhxj764yYJxI1gfWIja9xvP6b7WhtpVWT/yDEtBbv5S/vP99f5kb0pvn8eBJPlIBO
 +JfZ1dEeO2iisjFNmmFPZZV6MBvHBxbAN2KFlf/oB0ABH2y39nDwtVT3HrH3xrbpB3yUr6Sre
 xVBLO6oTdpofASzQp3B1gjklDHrpYpz4mbCC01JLWva9ZHk+KcRtfnBV8wlXuUhwAumjT6Q/5
 vAjko0ArAMlAg974ZJ1g4tzxuQHTdZc5LCFY7sX4oLtQtQSKKFzHbJzPW2E6VScRN35cmOuU5
 tzqM/PfE4jo2PG5X15zWLLCWLtCIz7xxDbIQI+D9D8Hbdfs1VZXX+3sAcjnJROcpl1GLfdbme
 3DBsZlB9OSrmEA3j7o5YNVoijXOS8eRKsvSGv+gmj0OJWj3ykG4mIvcelgA2ZtBN5fpakt2j2
 qPbFMTdME+uGPQ656rR43EO1aCqXdIYaqBaSxmgo6cJJhMwg7ANNN97v+pm8WjCZzaXgTWv8I
 UzBrKfFljPQWgEW3BZL7HNUAMmTDOwROEGl2WmGvYtXMsRJL6DtG/r1hXnG7c+CWoFyDfcDB6
 12s7MBbslmJKFBb3dGybrIDrltiDUwvoWxMMUqnnzZbjncGvEazStgq6lN8XaAtoOUi8d9t2B
 zi+77j/OSs7Ljkeixjaf3q7rub3mdioPNWsJnpqFJ4tKpoTvLBdWR8LRgPR2+OhwlqrI1f8O7
 EUV6Dmq131oMCsmTp6QwfLGlDU0N+bKcpLS+0RiAv0TWenO9LxGDJDzpdzFzM1Wwfcg9Yd6ak
 jPKiqEu+KISxC4VoTIBODWVmqjfagFAINC/2C+fV/1R1D4Eq2yldpTlq2R+yICy3CuGz3ajfc
 IHsCMCdYPc+er0DX2Ba7sYzM1bdPCSKKwh3Hpki3koUaf78dFsSPnrektZlNBmYagaoUmhNyG
 lDN3IG0p2sZhf29NBe6+xlgdsS+92H2FmHSjmtSwH1xAmCbJTP+Na+nPzEdA6iBc88tXe4Qkk
 udPLjRhXRoOvl0497EZg4vwIxB
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/1 21:18, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> If the flag FIEMAP_FLAG_SYNC is passed to fiemap, it means all delalloc
> should be flushed and writeback complete. We call the generic helper
> fiemap_prep() which does a filemap_write_and_wait() in case that flag is
> given, however that is not enough if we have compression. Because a
> single filemap_fdatawrite_range() only starts compression (in an async
> thread) and therefore returns before the compression is done and writeba=
ck
> is started.
>
> So make btrfs_fiemap(), actually wait for all writeback to start and
> complete if FIEMAP_FLAG_SYNC is set. We start and wait for writeback
> on the whole possible file range, from 0 to LLONG_MAX, because that is
> what the generic code at fiemap_prep() does.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/inode.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 493623c81535..2c7d31990777 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -8258,6 +8258,26 @@ static int btrfs_fiemap(struct inode *inode, stru=
ct fiemap_extent_info *fieinfo,
>   	if (ret)
>   		return ret;
>
> +	/*
> +	 * fiemap_prep() called filemap_write_and_wait() for the whole possibl=
e
> +	 * file range (0 to LLONG_MAX), but that is not enough if we have
> +	 * compression enabled. The first filemap_fdatawrite_range() only kick=
s
> +	 * in the compression of data (in an async thread) and will return
> +	 * before the compression is done and writeback is started. A second
> +	 * filemap_fdatawrite_range() is needed to wait for the compression to
> +	 * complete and writeback to start. Without this, our user is very
> +	 * likely to get stale results, because the extents and extent maps fo=
r
> +	 * delalloc regions are only allocated when writeback starts.
> +	 */
> +	if (fieinfo->fi_flags & FIEMAP_FLAG_SYNC) {
> +		ret =3D btrfs_fdatawrite_range(inode, 0, LLONG_MAX);
> +		if (ret)
> +			return ret;
> +		ret =3D filemap_fdatawait_range(inode->i_mapping, 0, LLONG_MAX);
> +		if (ret)
> +			return ret;
> +	}
> +
>   	return extent_fiemap(BTRFS_I(inode), fieinfo, start, len);
>   }
>
