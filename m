Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 890E0489775
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jan 2022 12:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244729AbiAJLae (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jan 2022 06:30:34 -0500
Received: from mout.gmx.net ([212.227.17.22]:47499 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244798AbiAJLaS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jan 2022 06:30:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641814215;
        bh=p9OUMfwy9BqWB+PtsDQhazgZ6/KHvPGYlMDo0IJOacA=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=D1/eH7gpnWX3YEAp8skFTVMHf34V0p+gnNo2fou56uqkeKIKaZylZfRlT9L7JhZRu
         PrSqTSj3AvdfBRPyGakzsdW/iMO69VsiagKg66UgtsSGVfcd3bVgcgnrRB4FXfmI/o
         927wrm84faodeFK7vIcMmSuMmz/Orh2nIhlyBdYg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mn2aN-1mgOED0tiZ-00k8Gt; Mon, 10
 Jan 2022 12:30:15 +0100
Message-ID: <c880cf15-45eb-062e-f118-3b8467e4a62a@gmx.com>
Date:   Mon, 10 Jan 2022 19:30:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] btrfs-progs: Don't crash when processing a clone request
 during received
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Chris Muprhy <lists@colorremedies.com>
References: <20220110111201.1824108-1-nborisov@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220110111201.1824108-1-nborisov@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NlXgk7DzMNF4Zy0bT4lhTAlVRhX5O2PkwfMXOBfaN4B9OyTajfy
 fTmma7cASExWG7RrACEh8HGNAM/5gIqsztCkMMgd3lWCtrEQQhaFMLnJuN8rAo5Te686pSk
 zAFpgQTBAx/SL9RUlTsxzTE1o+dLYEldqRhXZgdhc1g+QMkpVRofS+sc+XYUQW86GbSbJzW
 yKJl/qs14z6wdVBoCuqZg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7vj2zYMpBGw=:tHLPWpytNKHRd+4U0XRNsS
 FAfPqiGy8Ey5HiucBFm7nebapP4nsAUzkoErYgh0adTr9biLcGfhZh+gzM7Mf1JCFoyDZTCYG
 0hmkEAeWOfYMvl1w/+U0UEO0B4sziS8gP3nKcIINbNmRS6R+YcfNtZD4IYmxK5Gfl4rGIlwju
 latEzTbT0hqHvvJuvRPxmNFz2VkjeLu06OXMNgMy9SKmDG130epWu0qjR1Kc4yo7bxwo6FBwS
 1HHTUTkVjIjAt9xRfVYpa5RyXV5hSf5v9dehciOGz4/0uTB0jmMs18dNQGF1MrUriXT6FreMK
 +3hGYRjYo1gCE0MTpZ/xuVxWRM/0uaXESomHw3zU4O6YhfsOJfLBSFen6tyV6AVQIeFx7E31a
 bZO0EEpfgpdcZKxJvkQ4Xoz/jB7d5eCxjuXBLpCgeKpUZzsn4I9Ss0dwbx9wW0BA7yqULHsu0
 Yj4R+WV2iwMtKJ8aW+MUTMDlk2LDmWLS+Hcg2W9d8cGRSt/SiOQG0nklLQphGG/cvWV1dCJR/
 RHKGmCu88rIWGFCp052AOS6ihsQzxAmdAcvknl1pSOiCnp5m48H7nGxbzOQb6uVD4bPv88XTr
 QlrFYw0yjG6s7OD93BwVJKhe3SawDLkkwCde0r3uu25f8AoImwDwmEG5fm8VjhAED9K1Qt6DM
 9DHGrOmah+M0yj+vqYb+eOAScinHAyniyzgNHuyHDJtQD4D+GSF9NjlBlfwRsVgVXr6NPcRvV
 SPMAF+crpvfPX9TYsmbPyXtIjjT3tVqJdw6Z+qQmaYtB38kjIxpGyw4lgPXXvPYx7qH+0Ag4z
 IttCeus27EYc6um7fre9SgY9AKXhlKNJTeZvzXPRIQYph/wNaiXC/3HSIx/iLPv2t8o/mDFo4
 iQyQxr8iCA7hu9XcnFu48Bk+xulkfU7c4yzLoa7d7imMT7SLJZvk3XwT6gQPT466OKbDMsHku
 T1PDeYGjV5GXdMNZxKbjuNcQBoYfKV10djG48/rpk2xvMzM0hReR6fM7Y+IEc8NSFjzdQaaLD
 JMfKhO/J7C2xFV4ccL5Xk2vdEgj0ajJT0Ehs5mKGZj+S2+2ujjyzlBvmSb0xSni4wvkXi9dHy
 Tx/AehTQ1w5yog=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/10 19:12, Nikolay Borisov wrote:
> If subvol_uuid_search can't find the clone root then 'si' would either
> be NULL or contain an errno. The behavior of this function was
> changed as a result of commit
> ac5954ee36a5 ("btrfs-progs: merge subvol_uuid_search helpers"). Before
> this commit subvol_uuid_search() was a wrapper around subvol_uuid_search=
2
> and it guaranteed to either return well-fromed 'si' or NULL. This was
> sufficient for the check after the out label in process_clone.
>
> Properly handle this new semantic by changing the simple null check to
> IS_ERR_OR_NULL which covers all possible return value of
> subvol_uuid_search.
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> Reported-by: Chris Muprhy <lists@colorremedies.com>
> Link: https://lore.kernel.org/linux-btrfs/CAJCQCtT-k3WbCSTvrvWLZQ7gLOUtT=
bXfOiKsGZxkPVb1g2srWg@mail.gmail.com/

Reviewed-by: Qu Wenruo <wqu@suse.com>

Just curious that, can we refactor the helper to remove the NULL pointer
return case?

Thanks,
Qu
> ---
>   cmds/receive.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/cmds/receive.c b/cmds/receive.c
> index b4099bc482b2..16b9b4a853be 100644
> --- a/cmds/receive.c
> +++ b/cmds/receive.c
> @@ -794,7 +794,7 @@ static int process_clone(const char *path, u64 offse=
t, u64 len,
>   	}
>
>   out:
> -	if (si) {
> +	if (!IS_ERR_OR_NULL(si)) {
>   		free(si->path);
>   		free(si);
>   	}
> --
> 2.17.1
>
