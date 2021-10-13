Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385D842C897
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Oct 2021 20:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238435AbhJMSZn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Oct 2021 14:25:43 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48840 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbhJMSZm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Oct 2021 14:25:42 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D629F219C9;
        Wed, 13 Oct 2021 18:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634149417;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O/wSdTt69YgbX7/SPPCl9GIxcIguT+/qhdi5nzYNWxg=;
        b=EwsJBAK68T/hmNP8ql96AC7OWTbqZg+ryug2fL2pt2xeUWmd7JbAqmMPkY4SYK84yZDUUJ
        K3/KDPmbOSYrz5BAWijk89MSpCKvtKOplUJaS9ByEqab+2V3XT6oZjjdEoFASdiZpfaYl8
        kFBKycOUJf+zCDczbRkrcWk5Rj/odPk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634149417;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O/wSdTt69YgbX7/SPPCl9GIxcIguT+/qhdi5nzYNWxg=;
        b=ARqj+3F+zBDSNC7T8U76oM1ytSK6AKZG+y0KQUkOPhDoc+C4PzFTdvlLCI3opdLORiRzaf
        h/TeEZMBrBgA+3CQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id CE6B2A3B84;
        Wed, 13 Oct 2021 18:23:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 98AA5DA7A3; Wed, 13 Oct 2021 20:23:13 +0200 (CEST)
Date:   Wed, 13 Oct 2021 20:23:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v4 4/6] btrfs: handle device lookup with
 btrfs_dev_lookup_args
Message-ID: <20211013182313.GJ9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1633464631.git.josef@toxicpanda.com>
 <dfcc04056a9895dedad6786a4d0944fffb3d82be.1633464631.git.josef@toxicpanda.com>
 <cbc1df4a-d7bf-3c34-4c5c-c093512c08bf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbc1df4a-d7bf-3c34-4c5c-c093512c08bf@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 06, 2021 at 10:34:41AM +0300, Nikolay Borisov wrote:
> >  int btrfs_init_dev_replace(struct btrfs_fs_info *fs_info)
> >  {
> > +	BTRFS_DEV_LOOKUP_ARGS(args);
> 
> nit: This line can be:
> 
> struct btrfs_dev_lookup_args args = {.devid = BTRFS_DEV_REPLACE_DEVID};
> 
> as it doesn't go over the 76 char limit, the only reason I'm suggesting

The limit is 80-85.

> it is for consistency sake, since in
> btrfs_scrub_progress/btrfs_scrub_dev the latter style is preferred.

Agreed, after seeing the rest of the patchset, if the members (most
often devid) can be set right away like from the parameters, the
explicit initialization should be used, so I've switched it to what
you've suggested.

> > +static inline bool dev_args_match_fs_devices(struct btrfs_dev_lookup_args *args,

Btw static inline that's not in a header does not make much sense, so
it's plain static. Also for read-only parameters it's a good habit to
declare them const, also changed.

> > +					     struct btrfs_fs_devices *fs_devices)
> > +{
> > +	if (args->fsid == NULL)
> > +		return true;
> > +	if (!memcmp(fs_devices->metadata_uuid, args->fsid, BTRFS_FSID_SIZE))
> > +		return true;
> > +	return false;
> 
> Make last 3 lines into:
> 
> return !memcmp(fs_devices->metadata_uuid, args->fsid, BTRFS_FSID_SIZE)

I really don't like the short form where memcmp (or strcmp for that
matter) is done like !memcmp as it reads "if the don't compare as
equeal" and requires the mental switch to if memcmp() == 0 "they're
equal", so I've been switching that to the == 0 form whenever I see it.

In this function, if ther's a chain of if/if/return, it reads better if
all the branches are either implicit or explicit, so mixing both styles
is slightly less preferred.

> > @@ -517,7 +530,7 @@ int btrfs_num_copies(struct btrfs_fs_info *fs_info, u64 logical, u64 len);
> >  int btrfs_grow_device(struct btrfs_trans_handle *trans,
> >  		      struct btrfs_device *device, u64 new_size);
> >  struct btrfs_device *btrfs_find_device(struct btrfs_fs_devices *fs_devices,
> > -				       u64 devid, u8 *uuid, u8 *fsid);
> > +				       struct btrfs_dev_lookup_args *args);
> 
> Let's annotate this pointer with const to be more explicit about this
> being really an input-only struct.

Agreed, const added.
