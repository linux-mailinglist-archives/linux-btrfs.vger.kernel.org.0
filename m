Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392AB4399CB
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Oct 2021 17:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbhJYPQA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Oct 2021 11:16:00 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54266 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbhJYPP7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Oct 2021 11:15:59 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4C61521959;
        Mon, 25 Oct 2021 15:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1635174816;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l6h4UO0TJKfFFKl+rRWkYlgZik4NrDjJepUYyR+mnMs=;
        b=rVxdVOIjFXtOT26c8o8Ulf+iwzwXX/dbyO2m78bmR5j5zAEotw2hPLYOO9Ak6GBx7QhFZN
        FSof0kpHnj5gQHWccgPneA+oTFBx2pD0FHJE4bk/fjFLSMS1oikYfAm5l3R86USXdVq2RU
        0/FzlUpEaSzPut/xDKtw/enO+W5YXgE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1635174816;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l6h4UO0TJKfFFKl+rRWkYlgZik4NrDjJepUYyR+mnMs=;
        b=CgHcZoKKUYfwraL4k0waoOEVcJ2Ld9os1ogd7riGx4NXH/Jfj00l3yF6hAM/ghDKn/OEM6
        pzg3KNn8oc0t0qBA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 45F46A3B81;
        Mon, 25 Oct 2021 15:13:36 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5FE47DA7A9; Mon, 25 Oct 2021 17:13:05 +0200 (CEST)
Date:   Mon, 25 Oct 2021 17:13:05 +0200
From:   David Sterba <dsterba@suse.cz>
To:     kreijack@inwind.it
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs-progs: remove path_cat[3]_out() double declaration
Message-ID: <20211025151305.GQ20319@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, kreijack@inwind.it,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <3f86146a-d69c-e8c4-d3b4-d9c91d199d81@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f86146a-d69c-e8c4-d3b4-d9c91d199d81@libero.it>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Oct 23, 2021 at 06:40:49PM +0200, Goffredo Baroncelli wrote:
> Remove the double declaration of path_cat_out()/path_cat3_out()
> 
> The functions
>    - path_cat_out()
>    - path_cat3_out()
> are declared two times in the following header files:
>    - common/path-utils.h
>    - common/send-utils.h
> 
> Remove the double declaration from send-utils.h and add the path-utils.h include file
> where needed.

Thanks, but the prototypes have been removed a few weeks ago, in
"btrfs-progs: remove unused prototypes from send-utils.h". You've
probably developed this on top of master branch.
