Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F2D3F0ED5
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 01:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235060AbhHRXwN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Aug 2021 19:52:13 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:33852 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234998AbhHRXwM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Aug 2021 19:52:12 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6634520091;
        Wed, 18 Aug 2021 23:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629330696;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j6FsTlAP2zTj/pKxPLSr2qM/vhbp+kKoEMRX7OhFqQ8=;
        b=KkBDy6NPC+DnNA/uA6OlWgpkCFlrO/Uh0NyCqN21uauhGuK+q4bJvRxnCknyzzKpBTYiwC
        LSfone6wMl+3tB+9jNIGB93DK48vD+GFzDON9uyP2InTIL67cHS3joR4ysLbFZBH0itZej
        4ufdotOgAAFGEkb05fCbEtdzZ2j80JM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629330696;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j6FsTlAP2zTj/pKxPLSr2qM/vhbp+kKoEMRX7OhFqQ8=;
        b=mVDwP7w7yGzdWerGG/M0hlJaNfIJlV9WwBOlKREd/OuoJpzNTRegOhclQCpMjfQxyLwHGn
        MIumwAOfr+7PBDCw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 32131A3B98;
        Wed, 18 Aug 2021 23:51:36 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 42A22DA72C; Thu, 19 Aug 2021 01:48:39 +0200 (CEST)
Date:   Thu, 19 Aug 2021 01:48:38 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        naohiro.aota@wdc.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: sysfs: advertise zoned support among features
Message-ID: <20210818234838.GB5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>, johannes.thumshirn@wdc.com,
        damien.lemoal@wdc.com, naohiro.aota@wdc.com,
        linux-btrfs@vger.kernel.org
References: <20210728165632.11813-1-dsterba@suse.com>
 <5d40cac5-2048-6a9b-292b-52046a1793cd@oracle.com>
 <20210809091916.GJ5047@suse.cz>
 <a246559d-8eed-7885-d20e-df651d73d146@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a246559d-8eed-7885-d20e-df651d73d146@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 10, 2021 at 08:30:51AM +0800, Anand Jain wrote:
>   As in the proposed patch which adds a table to figure out the correct 
> table to add the attribute, adding to the 
> btrfs_supported_static_feature_attrs attribute list will add only to 
> /sys/fs/btrfs/features, however adding the attribute to 
> btrfs_supported_feature_attrs adds to both /sys/fs/btrfs/features and 
> /sys/fs/btrfs/uuid/features.

I can't see it in the code right now, but that would mean that eg. zoned
would show up in static features once such filesystem is mounted. And
that does not happen or I'm missing something.
