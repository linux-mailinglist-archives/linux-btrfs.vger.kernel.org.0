Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB05FFB30C
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2019 16:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbfKMPA3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Nov 2019 10:00:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:37810 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727687AbfKMPA3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Nov 2019 10:00:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 00DADB40E;
        Wed, 13 Nov 2019 15:00:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CD3C9DA7E8; Wed, 13 Nov 2019 16:00:31 +0100 (CET)
Date:   Wed, 13 Nov 2019 16:00:31 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     David Sterba <dsterba@suse.com>, Qu Wenru <wqu@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 4/7] btrfs: handle error return of close_fs_devices()
Message-ID: <20191113150031.GC3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>, Qu Wenru <wqu@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20191113102728.8835-1-jthumshirn@suse.de>
 <20191113102728.8835-5-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113102728.8835-5-jthumshirn@suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 13, 2019 at 11:27:25AM +0100, Johannes Thumshirn wrote:
> close_fs_devices() will be able to return an error instead of crashing
> after the following patch.
> 
> Prepare btrfs_close_devices() for this.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  fs/btrfs/volumes.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index e5864ca3bb3b..be1fd935edf7 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1143,10 +1143,10 @@ static int close_fs_devices(struct btrfs_fs_devices *fs_devices)
>  int btrfs_close_devices(struct btrfs_fs_devices *fs_devices)
>  {
>  	struct btrfs_fs_devices *seed_devices = NULL;
> -	int ret;
> +	int err, err2 = 0;

Please use ret and ret2.

>  	mutex_lock(&uuid_mutex);
> -	ret = close_fs_devices(fs_devices);
> +	err = close_fs_devices(fs_devices);
>  	if (!fs_devices->opened) {
>  		seed_devices = fs_devices->seed;
>  		fs_devices->seed = NULL;
> @@ -1156,10 +1156,13 @@ int btrfs_close_devices(struct btrfs_fs_devices *fs_devices)
>  	while (seed_devices) {
>  		fs_devices = seed_devices;
>  		seed_devices = fs_devices->seed;
> -		close_fs_devices(fs_devices);
> +		err2 = close_fs_devices(fs_devices);

So only the last error value gets propagated to the return statements.
Is that intentional?

>  		free_fs_devices(fs_devices);
>  	}
> -	return ret;
> +
> +	if (err2)
> +		return err2;
> +	return err;
