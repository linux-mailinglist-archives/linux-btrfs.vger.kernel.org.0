Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2ECB420914
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Oct 2021 12:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbhJDKMZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Oct 2021 06:12:25 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39490 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbhJDKMV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Oct 2021 06:12:21 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 55AD6201B4;
        Mon,  4 Oct 2021 10:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633342231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9+4hSyuooPmq2E7X5OqLAzl9QXEsYFY09yPjeVQw61s=;
        b=dtfk/2M5SfsogYEy2fe8840ZZWKFcJ8sAd6g7EyEeywkaZkiSk34z55vKTRgPg0HGIPL5n
        DjK2DRCz4rf0R4BxPY84sGewqrHRzFOkc6iunYJ3Q8rL59u37AZ0gFf5T/RI+6cW1k1ill
        7/rIEjZPlkwqoCPIKlNffaXpfATU7+0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 24F5513A13;
        Mon,  4 Oct 2021 10:10:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qLfZBRfTWmHgVAAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 04 Oct 2021 10:10:31 +0000
Subject: Re: [PATCH 4/5] btrfs-progs: property: ro->rw and received_uuid
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1633101904.git.dsterba@suse.com>
 <4c02eb0d00433fa95b77befecafcdf147c230f21.1633101904.git.dsterba@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <bfb7c505-64c4-5c11-8ab1-1d1377be6d25@suse.com>
Date:   Mon, 4 Oct 2021 13:10:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <4c02eb0d00433fa95b77befecafcdf147c230f21.1633101904.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 1.10.21 г. 18:29, David Sterba wrote:
> Implement safety check when a read-only subvolume is getting switched
> to read-write and there's received_uuid set.
> 
> This prevents accidental breakage of incremental send usecase but allows
> user to do the rw change anyway but resets the received_uuid in that
> case.
> 
> As this is implemented entirely in userspace, it's racy and using the
> raw ioctl won't prevent it nor reset the received_uuid.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>


Thanks for sending this, I'm going to comment inline as well as compare
this to my proposal, hopefully that'll help you understand what I mean
and allow you to make an informed decision of which approach to take in
the end and merge.

> ---
>  cmds/property.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 
> diff --git a/cmds/property.c b/cmds/property.c
> index 647c3f07afb5..230bef04f6ce 100644
> --- a/cmds/property.c
> +++ b/cmds/property.c
> @@ -22,6 +22,7 @@
>  #include <sys/ioctl.h>
>  #include <sys/stat.h>
>  #include <sys/xattr.h>
> +#include <uuid/uuid.h>
>  #include <btrfsutil.h>
>  #include "cmds/commands.h"
>  #include "cmds/props.h"
> @@ -40,6 +41,26 @@
>  #define ENOATTR ENODATA
>  #endif
>  
> +static int subvolume_clear_received_uuid(const char *path)
> +{
> +	struct btrfs_ioctl_received_subvol_args args = {};
> +	int ret;
> +	int fd;
> +
> +	fd = open(path, O_RDONLY | O_NOATIME);
> +	if (fd == -1)
> +		return -errno;
> +
> +	ret = ioctl(fd, BTRFS_IOC_SET_RECEIVED_SUBVOL, &args);
> +	if (ret == -1) {
> +		close(fd);
> +		return -errno;
> +	}
> +	close(fd);
> +
> +	return 0;
> +}
> +
>  static int prop_read_only(enum prop_object_type type,
>  			  const char *object,
>  			  const char *name,
> @@ -50,6 +71,10 @@ static int prop_read_only(enum prop_object_type type,
>  	bool read_only;
>  
>  	if (value) {
> +		struct btrfs_util_subvolume_info info = {};
> +		bool is_ro = false;
> +		bool do_clear_received_uuid = false;
> +
>  		if (!strcmp(value, "true")) {
>  			read_only = true;
>  		} else if (!strcmp(value, "false")) {
> @@ -58,12 +83,44 @@ static int prop_read_only(enum prop_object_type type,
>  			error("invalid value for property: %s", value);
>  			return -EINVAL;
>  		}
> +		err = btrfs_util_get_subvolume_read_only(object, &is_ro);
> +		if (err) {
> +			error_btrfs_util(err);
> +			return -errno;
> +		}
> +		/* No change if already read-only */
> +		if (is_ro && read_only)
> +			return 0;
> +
> +		err = btrfs_util_subvolume_info(object, 0, &info);
> +		if (err)
> +			warning("cannot read subvolume info\n");
> +		if (is_ro && !uuid_is_null(info.received_uuid)) {
> +			printf("ro->rw switch but has set receive_uuid\n");
> +
> +			if (force) {
> +				do_clear_received_uuid = true;

So you'll require the user to explicitly pass -f in order to clear
received uuid when switching ro->rw but otherwise you are not actively
preventing the user to continue relying on invalid behavior.


> +			} else {
> +				printf("cannot flip ro->rw with received_uuid set, use force\n");
> +				return -EPERM;
> +			}
> +		}
> +		if (!is_ro && !uuid_is_null(info.received_uuid))
> +			warning("read-write subvolume with received_uuid, this is bad");

Do you intend to augment this error message or not, I know this is just
a prototype but I wonder what would a useful text here look like. Ok you
are going to warn the user what they are doing is wrong but you won't
stop them from doing it so how is this preventing possible future
streams of people coming to the mailing list and complaining that their
incremental send isn't working or that they are experiencing silent data
corruptions following in incremental send?


In contrast, my approach is to have btrfs progs check scan for such
cases and when it finds them to directly clear the received_uuid as part
of a --repair switch.


>  
>  		err = btrfs_util_set_subvolume_read_only(object, read_only);

So indeed, you are not preventing the users from continuing to exercise
the invalid behavior.

>  		if (err) {
>  			error_btrfs_util(err);
>  			return -errno;
>  		}
> +		if (do_clear_received_uuid) {
> +			int ret;
> +
> +			printf("force used, clearing received_uuid\n");
> +			ret = subvolume_clear_received_uuid(object);

The fact that this can't be made atomic w.r.t setting RO (from user
space) just demonstrates this is somewhat fragile. Even after someone
running btrfs property set -f and a crash occurs it's possible they end
up with a subvol.

My approach on the other hands solves this on the kernel side where we
can make the ro->rw switch + received_uuid clear atomic.

My opinion is that this approach is too fragile.

> +			if (ret < 0)
> +				warning("failed to clear received_uuid: %m");
> +		}
>  	} else {
>  		err = btrfs_util_get_subvolume_read_only(object, &read_only);
>  		if (err) {
> 
