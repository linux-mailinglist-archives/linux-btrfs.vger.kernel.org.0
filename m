Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28CC0455F51
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Nov 2021 16:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbhKRPZg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Nov 2021 10:25:36 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:52204 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbhKRPZf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Nov 2021 10:25:35 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C981C1FD29
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Nov 2021 15:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637248954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tys3zM3aG+SIp0oVibby5VpUKZLCaWbhCMN4SUtqEdo=;
        b=eF/ZODIAZ/WtqAEfVJbmYPY4laRVs8cptn5oQqS8F5nEGpcvPh4td8fGP4jvvKdlL0XikX
        LKi+F1OnhiFcCn6mIR7xN6WYj2tCJn25l7p/o6EdxkaQpbLimloAxGcAOtwFEeqyBPjRl8
        3ECKBEPIXVgb6cn255M7/EiG1C7gRzk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A922B13D43
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Nov 2021 15:22:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id D5++JrpvlmFSHQAAMHmgww
        (envelope-from <nborisov@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Nov 2021 15:22:34 +0000
Subject: Re: [PATCH v2 1/2] btrfs-progs: fi show: Print missing device for a
 mounted file system
To:     linux-btrfs@vger.kernel.org
References: <20210910083344.1876661-1-nborisov@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <1a0eb650-e23f-ea3d-07ac-b6109c8103b4@suse.com>
Date:   Thu, 18 Nov 2021 17:22:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210910083344.1876661-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10.09.21 г. 11:33, Nikolay Borisov wrote:
> Currently when a device is missing for a mounted filesystem the output
> that is produced is unhelpful:
> 
> Label: none  uuid: 139ef309-021f-4b98-a3a8-ce230a83b1e2
> 	Total devices 2 FS bytes used 128.00KiB
> 	devid    1 size 5.00GiB used 1.26GiB path /dev/loop0
> 	*** Some devices missing
> 
> While the context which prints this is perfectly capable of showing
> which device exactly is missing, like so:
> 
> Label: none  uuid: 4a85a40b-9b79-4bde-8e52-c65a550a176b
> 	Total devices 2 FS bytes used 128.00KiB
> 	devid    1 size 5.00GiB used 1.26GiB path /dev/loop0
> 	devid    2 size 0 used 0 path /dev/loop1 MISSING
> 
> This is a lot more usable output as it presents the user with the id
> of the missing device and its path.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
> 
> V2:
>  * Removed stars around MISSING


Ping
