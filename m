Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E683944AB82
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Nov 2021 11:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245337AbhKIKdd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Nov 2021 05:33:33 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:47152 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238291AbhKIKdc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Nov 2021 05:33:32 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B50141FDB7;
        Tue,  9 Nov 2021 10:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636453845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yi7KVuFdWNg/IECkk6zByFM5JJvZ0Vac3u8evFl0z9w=;
        b=KI/tNzsZj4vLG5YSSkdybn2HOVBu8+zm3IT0mnSxMn84WUjwpt8bnEHy9mpEEljqB8+BXf
        WTuDlYc60L54YNF04tZMQ99MrQvo7eDoJc5HbenlYCoZMQjCl5EvyhASstxX+aYd6EX7Fg
        ZxzJ57n/OtifmhVzv686LSL2uXSq1P0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8C94213467;
        Tue,  9 Nov 2021 10:30:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uAvCH9VNimFfdQAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 09 Nov 2021 10:30:45 +0000
Subject: Re: Bug#998840: Strange warning when deleting subvolume as non-root
 user
To:     Adam Borowski <kilobyte@angband.pl>, linux-btrfs@vger.kernel.org
References: <YYniaHjEO9ssCiGq@angband.pl>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <000fed14-fc45-db06-cc75-093b40960d99@suse.com>
Date:   Tue, 9 Nov 2021 12:30:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YYniaHjEO9ssCiGq@angband.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 9.11.21 г. 4:52, Adam Borowski wrote:
> ----- Forwarded message from Boris Kolpackov <boris@codesynthesis.com> -----
> Date: Mon, 8 Nov 2021 16:01:53 +0200
> From: Boris Kolpackov <boris@codesynthesis.com>
> Subject: Bug#998840: Strange warning when deleting subvolume as non-root user
> 
> Package: btrfs-progs
> Version: 5.14.1-1
> 
> After upgrading from btrfs-progs 5.7-1 with Linux kernel 5.7.6 to
> btrfs-progs 5.14.1-1 with Linux kernel 5.14.9-2 (from current testing)
> I see the following strange new warning when deleting the subvolume as
> non-root user (the filesystem is mounted with user_subvol_rm_allowed):
> 
> WARNING: cannot read default subvolume id: Operation not permitted
> 
> The subvolume deletion succeeds.
> 
> To reproduce, mount a btrfs filesystem with user_subvol_rm_allowed,
> say, on /mnt and then (assuming non-root user is called nonroot):
> 
> # chown nonroot:nonroot /mnt
> # su - nonroot
> $ cd /mnt
> $ btrfs subvol create test
> Create subvolume './test'
> $ btrfs subvol delete test
> WARNING: cannot read default subvolume id: Operation not permitted
> Delete subvolume (no-commit): '/mnt/test'
> 
> Any idea what's going on here and how to get rid of this warning?
> It adds quite a bit of noise to our logs.


This error is printed because btrfs-progs checks whether the volume
being deleted is the default since this is not allowed. To perform this
check we rely on the TREE_SEARCH ioctl which requires the user having
CAP_SYS_ADMIN capability.


> 
> 
> ----- End forwarded message -----
> 
> 
> Reproduces for me both on 5.14 kernel+progs and 5.15.
> 
> 
> Meow!
> 
