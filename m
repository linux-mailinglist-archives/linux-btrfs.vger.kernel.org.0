Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1E727DDEE
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 03:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbgI3Blh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Sep 2020 21:41:37 -0400
Received: from eu-shark1.inbox.eu ([195.216.236.81]:55938 "EHLO
        eu-shark1.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729776AbgI3BlZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Sep 2020 21:41:25 -0400
X-Greylist: delayed 464 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Sep 2020 21:41:23 EDT
Received: from eu-shark1.inbox.eu (localhost [127.0.0.1])
        by eu-shark1-out.inbox.eu (Postfix) with ESMTP id 5054F6C00776;
        Wed, 30 Sep 2020 04:33:38 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1601429618; bh=jf8uf4SIn92dGdGBlmsIqUR5mX3wDuCODPy1eVzqeRY=;
        h=References:From:To:Cc:Cc:Subject:In-reply-to:Date;
        b=P/nTBU68B99khjQM+zksCHpXCcg6EXbLHkYIj6QqoSn0CYTch488j7yYzGOxCnCjD
         67FpgqqStrMFxuVKYvadTOBcI19wVggGnzTbeD7Uk5Tbb2hO6un5VA9Fn2lMhpFSZZ
         cBqTrTsDpUNNAbfOlRvUzyGCu4Bd37coOZUcZ/20=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 3E4B66C0079B;
        Wed, 30 Sep 2020 04:33:38 +0300 (EEST)
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "Cc"
Received: from eu-shark1.inbox.eu ([127.0.0.1])
        by localhost (eu-shark1.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id XeMBzgFar9Y0; Wed, 30 Sep 2020 04:33:38 +0300 (EEST)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id ED8586C00776;
        Wed, 30 Sep 2020 04:33:37 +0300 (EEST)
Received: from nas (unknown [103.116.47.51])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 9DD441BE00F2;
        Wed, 30 Sep 2020 04:33:36 +0300 (EEST)
References: <20200928150729.2239-1-realwakka@gmail.com>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Su Yue <l@damenly.su>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH] btrfs-progs: subvolume: Add warning on deleting default
 subvolume
In-reply-to: <20200928150729.2239-1-realwakka@gmail.com>
Message-ID: <blhogiac.fsf@damenly.su>
Date:   Wed, 30 Sep 2020 09:33:31 +0800
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Virus-Scanned: OK
X-ESPOL: 885mlYpNBD+ljEClRGXbBBpV3CdKQJ6b9qflkAEq73aHWDLmCkUMVhC2n2R1THi+og==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Mon 28 Sep 2020 at 23:07, Sidong Yang <realwakka@gmail.com> 
wrote:

> This patch add warning messages when user try to delete default
> subvolume. When deleting default subvolume, kernel will not 
> allow and
> make error message on syslog. but there is only message that 
> permission
> denied on userspace. User can be noticed the reason by this 
> warning message.
>
> This patch implements github issue.
> https://github.com/kdave/btrfs-progs/issues/274
>
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> ---
>  cmds/subvolume.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/cmds/subvolume.c b/cmds/subvolume.c
> index 2020e486..0cdf7a68 100644
> --- a/cmds/subvolume.c
> +++ b/cmds/subvolume.c
> @@ -264,6 +264,7 @@ static int cmd_subvol_delete(const struct 
> cmd_struct *cmd,
>  	struct seen_fsid *seen_fsid_hash[SEEN_FSID_HASH_SIZE] = { 
>  NULL, };
>  	enum { COMMIT_AFTER = 1, COMMIT_EACH = 2 };
>  	enum btrfs_util_error err;
> +	uint64_t default_subvol_id = 0, target_subvol_id = 0;
>
>  	optind = 0;
>  	while (1) {
> @@ -360,6 +361,25 @@ again:
>  		goto out;
>  	}
>
> +	err = btrfs_util_get_default_subvolume_fd(fd, 
> &default_subvol_id);
> +	if (fd < 0) {
>
Should it be
"     if (err) { 
|
         error_btrfs_util(err);
         ...
"?

> +		ret = 1;
> +		goto out;
> +	}
> +
> +	if (subvolid > 0)
> +		target_subvol_id = subvolid;
> +	else {
> +		err = btrfs_util_subvolume_id(path, &target_subvol_id);
> +		if (fd < 0) {
>
And here.

> +			ret = 1;
> +			goto out;
> +		}
> +	}
> +
> +	if (target_subvol_id == default_subvol_id)
> +		warning("trying to delete default subvolume.");
> +
>  	pr_verbose(MUST_LOG, "Delete subvolume (%s): ",
>  		commit_mode == COMMIT_EACH ||
>  		(commit_mode == COMMIT_AFTER && cnt + 1 == argc) ?

