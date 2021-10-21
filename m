Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F052F436723
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 18:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbhJUQC5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Oct 2021 12:02:57 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38184 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbhJUQC4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Oct 2021 12:02:56 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 79A831FD50;
        Thu, 21 Oct 2021 16:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634832039;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xHbg6Z30Ra3Z8vETufzmFuvJcm8WRO2yyRB9zoS0GYk=;
        b=wWaMquk8faiVCD3WDgqL5Su047Q0cPaMUdiunNrVG6a18TD9pVvMVQayLIT91bUKQ7rIHq
        m2u70OedMj9l/uBJO81ypUYZePL5LIIXDhGjPSX08G0J4FNJv3ESqE7zRMrS9YRgXD9T6Y
        nia22Xx7I9FIgapkhi/8/9tbp86jdLQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634832039;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xHbg6Z30Ra3Z8vETufzmFuvJcm8WRO2yyRB9zoS0GYk=;
        b=t/SC0sjC7/4Uh8qCM4cpNZ5iWRwv20IKssrj+btuljpzT1mGl4Q4q7C5yclE65NLj1PtVd
        O9HSP7EZs9NP+WBA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 71F20A3B92;
        Thu, 21 Oct 2021 16:00:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C47C3DA7A3; Thu, 21 Oct 2021 18:00:09 +0200 (CEST)
Date:   Thu, 21 Oct 2021 18:00:08 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH 1/2] btrfs: sysfs convert scnprintf and snprintf to use
 sysfs_emit
Message-ID: <20211021160008.GC20319@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <cover.1634598572.git.anand.jain@oracle.com>
 <f748bd08259e2b770a5d9f2355c58c33d8566d16.1634598572.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f748bd08259e2b770a5d9f2355c58c33d8566d16.1634598572.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 19, 2021 at 08:22:09AM +0800, Anand Jain wrote:
> @@ -1264,8 +1262,7 @@ char *btrfs_printable_features(enum btrfs_feature_set set, u64 flags)
>  			continue;
>  
>  		name = btrfs_feature_attrs[set][i].kobj_attr.attr.name;
> -		len += scnprintf(str + len, bufsize - len, "%s%s",
> -				len ? "," : "", name);
> +		len += sysfs_emit_at(str, len, "%s%s", len ? "," : "", name);

This is a different pattern the 'bufsize' is 4096 which matches
PAGE_SIZE but it's not the same thing as the show/set callbacks.

>  	}
>  
>  	return str;
> @@ -1304,8 +1301,8 @@ static void init_feature_attrs(void)
>  			if (fa->kobj_attr.attr.name)
>  				continue;
>  
> -			snprintf(name, BTRFS_FEATURE_NAME_MAX, "%s:%u",
> -				 btrfs_feature_set_names[set], i);
> +			sysfs_emit(name, "%s:%u", btrfs_feature_set_names[set],
> +				   i);

And this one too, what's worse is that BTRFS_FEATURE_NAME_MAX is 13 but
sysfs_emit assumes PAGE_SIZE.

The rest is OK, so I'd drop the two changes.
